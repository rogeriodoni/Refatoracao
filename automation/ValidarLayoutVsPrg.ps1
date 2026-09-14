#==============================================================================
# ValidarLayoutVsPrg.ps1
# Compara layout.json (original) com .prg (migrado) para detectar divergencias
# de layout: objetos ausentes, posicoes diferentes, propriedades estruturais.
#
# Uso standalone:
#   .\ValidarLayoutVsPrg.ps1 -LayoutJsonFile "task170\layout.json" `
#       -FormPrgFile "Formsigopind.prg" -ThresholdPx 5
#
# Integrado no pipeline: chamado por Invoke-Etapa06c_ValidarLayoutVsPrg
#==============================================================================

param(
    [Parameter(Mandatory)]
    [string]$LayoutJsonFile,

    [Parameter(Mandatory)]
    [string]$FormPrgFile,

    [string]$MapeamentoFile = "",

    [string]$ReportFile = "",

    [int]$ThresholdPx = 5
)

#------------------------------------------------------------------------------
# Parse-LayoutJson: extrai objetos do layout.json com propriedades
#------------------------------------------------------------------------------
function Parse-LayoutJson {
    param([string]$FilePath)

    $json = Get-Content -Path $FilePath -Raw | ConvertFrom-Json
    $objects = @()

    # Detectar compensacao do PageFrame
    $pageFrameTop = 0
    foreach ($obj in $json.objects) {
        if ($obj.baseClass -eq "pageframe") {
            $pageFrameTop = [int]$obj.top
            break
        }
    }
    $compensacao = [Math]::Abs($pageFrameTop)

    foreach ($obj in $json.objects) {
        # Pular objetos vazios/sentinela
        if ([string]::IsNullOrEmpty($obj.name) -or [string]::IsNullOrEmpty($obj.baseClass)) { continue }
        # Pular o form root
        if ([string]::IsNullOrEmpty($obj.parent)) { continue }
        # Pular grid internals (Header1, Text1, Ingrid1 dentro de Columns)
        if ($obj.parent -match "\.Column\d+" -or $obj.parent -match "\.Col_\w+") { continue }
        # Pular dataenvironment
        if ($obj.baseClass -eq "dataenvironment" -or $obj.baseClass -eq "cursor") { continue }
        # Pular o pageframe em si (nao eh um controle visual posicionavel)
        if ($obj.baseClass -eq "pageframe") { continue }

        # Determinar pagina e se eh filho direto da page
        $page = ""
        $isDirectPageChild = $false
        $containerPath = ""
        $fullPath = if ([string]::IsNullOrEmpty($obj.parent)) { $obj.name } else { "$($obj.parent).$($obj.name)" }

        if ($obj.parent -match "\.Page\.(\w+)$") {
            $page = $Matches[1]
            $isDirectPageChild = $true
        }
        elseif ($obj.parent -match "\.Page\.(\w+)\.") {
            $page = $Matches[1]
            # Extrair container path dentro da page
            $containerPath = ($obj.parent -replace "^.*\.Page\.\w+\.", "")
        }

        # Aplicar compensacao Top para filhos diretos da page
        $topOriginal = if ($null -ne $obj.top) { [int]$obj.top } else { $null }
        $topCompensado = $topOriginal
        if ($isDirectPageChild -and $null -ne $topOriginal -and $compensacao -gt 0) {
            $topCompensado = $topOriginal + $compensacao
        }

        $objects += [PSCustomObject]@{
            Name             = $obj.name
            FullPath         = $fullPath
            Parent           = $obj.parent
            BaseClass        = $obj.baseClass
            Page             = $page
            IsDirectPageChild = $isDirectPageChild
            ContainerPath    = $containerPath
            TopOriginal      = $topOriginal
            TopCompensado    = $topCompensado
            Left             = if ($null -ne $obj.left) { [int]$obj.left } else { $null }
            Width            = if ($null -ne $obj.width) { [int]$obj.width } else { $null }
            Height           = if ($null -ne $obj.height) { [int]$obj.height } else { $null }
            ButtonCount      = if ($null -ne $obj.buttonCount) { [int]$obj.buttonCount } else { $null }
            ColumnCount      = if ($null -ne $obj.columnCount) { [int]$obj.columnCount } else { $null }
            Caption          = if ($null -ne $obj.caption) { $obj.caption -replace '^"|"$', '' -replace '\\<', '' } else { $null }
            Visible          = $obj.visible
            Matched          = $false
        }
    }

    return @{
        Objects      = $objects
        Compensacao  = $compensacao
        FormName     = $json.form.name
        FormWidth    = $json.form.width
        FormHeight   = $json.form.height
        TotalObjects = $json.totalObjects
    }
}

#------------------------------------------------------------------------------
# Parse-PrgFile: extrai objetos e propriedades do .prg via regex
#------------------------------------------------------------------------------
function Parse-PrgFile {
    param([string]$FilePath)

    $linhas = Get-Content -Path $FilePath -Encoding UTF8
    $objects = @()

    # Fase 1: Resolver alias de variaveis
    # Inclui: loc_oPagina = THIS.pgf_4c_Paginas.Page1
    # E tambem: chamadas de metodo com parametro (THIS.ConfigurarXxx(loc_oPagina))
    $aliases = @{}

    # Pass 1: Construir aliases PER-PROCEDURE (loc_oPagina pode ser Page1 em um metodo e Page2 em outro)
    $procAliases = @{}  # chave = nome do PROCEDURE, valor = hashtable de aliases
    $currentProc = "_global_"
    $procAliases[$currentProc] = @{}

    # Pass 1a: varrer todas as linhas, agrupando aliases por procedure
    for ($idx = 0; $idx -lt $linhas.Count; $idx++) {
        $l = $linhas[$idx]
        if ($l -match '^\s*(?:PROTECTED\s+)?PROCEDURE\s+(\w+)') {
            $currentProc = $Matches[1]
            if (-not $procAliases.ContainsKey($currentProc)) {
                $procAliases[$currentProc] = @{}
            }
        }
        # loc_oPagina = THIS.pgf_4c_Paginas.Page1
        if ($l -match '^\s*(loc_\w+)\s*=\s*(THIS\.[^\s]+)\s*$') {
            $procAliases[$currentProc][$Matches[1]] = $Matches[2]
        }
    }

    # Pass 1b: rastrear chamadas de metodo com parametro
    # THIS.ConfigurarBotoesSaldo(loc_oPagina) dentro de ConfigurarPaginaLista
    # → par_oPagina em ConfigurarBotoesSaldo = aliases de ConfigurarPaginaLista[loc_oPagina]
    $currentProc = "_global_"
    for ($idx = 0; $idx -lt $linhas.Count; $idx++) {
        $l = $linhas[$idx]
        if ($l -match '^\s*(?:PROTECTED\s+)?PROCEDURE\s+(\w+)') {
            $currentProc = $Matches[1]
        }
        # THIS.MetodoHelper(loc_var)
        if ($l -match '^\s*THIS\.(\w+)\s*\(\s*(loc_\w+|par_\w+)') {
            $calledMethod = $Matches[1]
            $argVar = $Matches[2]
            # Resolver argVar no contexto do metodo caller
            $resolvedArg = $null
            if ($procAliases.ContainsKey($currentProc) -and $procAliases[$currentProc].ContainsKey($argVar)) {
                $resolvedArg = $procAliases[$currentProc][$argVar]
            }
            if ($null -ne $resolvedArg) {
                # Encontrar o PROCEDURE chamado e mapear seu par_
                for ($s = 0; $s -lt $linhas.Count; $s++) {
                    if ($linhas[$s] -match "^\s*(?:PROTECTED\s+)?PROCEDURE\s+$([regex]::Escape($calledMethod))\s*\(\s*(par_\w+)") {
                        $paramName = $Matches[1]
                        if (-not $procAliases.ContainsKey($calledMethod)) {
                            $procAliases[$calledMethod] = @{}
                        }
                        $procAliases[$calledMethod][$paramName] = $resolvedArg
                        break
                    }
                }
            }
        }
    }

    # Pass 1c: resolver aliases derivados (loc_oCnt = par_oPagina.cnt_4c_Saldo)
    foreach ($proc in $procAliases.Keys) {
        $pa = $procAliases[$proc]
        $changed = $true
        $maxIter = 5
        while ($changed -and $maxIter -gt 0) {
            $changed = $false
            $maxIter--
            # Re-varrer as linhas do procedure
            $inProc = $false
            for ($idx = 0; $idx -lt $linhas.Count; $idx++) {
                if ($linhas[$idx] -match "^\s*(?:PROTECTED\s+)?PROCEDURE\s+$([regex]::Escape($proc))\b") { $inProc = $true; continue }
                if ($inProc -and $linhas[$idx] -match '^\s*(?:PROTECTED\s+)?PROCEDURE\s+') { break }
                if (-not $inProc) { continue }

                if ($linhas[$idx] -match '^\s*(loc_\w+)\s*=\s*(par_\w+|loc_\w+)\.(\w+)\s*$') {
                    $lhs = $Matches[1]
                    $baseVar = $Matches[2]
                    $member = $Matches[3]
                    if ($pa.ContainsKey($baseVar) -and -not $pa.ContainsKey($lhs)) {
                        $pa[$lhs] = "$($pa[$baseVar]).$member"
                        $changed = $true
                    }
                }
            }
        }
    }

    # Funcao helper para resolver alias em contexto de uma linha
    function Resolve-Alias {
        param([string]$VarRef, [string]$ProcName)
        $pa = if ($procAliases.ContainsKey($ProcName)) { $procAliases[$ProcName] } else { @{} }
        $result = $VarRef
        foreach ($alias in $pa.Keys) {
            if ($VarRef -eq $alias -or $VarRef.StartsWith("$alias.")) {
                $result = $VarRef -replace "^$([regex]::Escape($alias))", $pa[$alias]
                break
            }
        }
        return $result
    }

    # Fase 2: Determinar em qual PROCEDURE cada linha esta
    $lineProc = @{}
    $currentProc = ""
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i] -match '^\s*(?:PROTECTED\s+)?PROCEDURE\s+(\w+)') {
            $currentProc = $Matches[1]
        }
        $lineProc[$i] = $currentProc
    }

    # Mapear nome de metodo para page (heuristica baseada no nome)
    # Metodos com "Saldo", "Lista" na Page1/SALDO; "Hist", "Dados" na Page2/HIST
    function Get-PageFromProc {
        param([string]$ProcName)
        if ($ProcName -match '(?i)Saldo|Lista|Filtros') { return "SALDO" }
        if ($ProcName -match '(?i)Hist|Dados|Quitas') { return "HIST" }
        if ($ProcName -match '(?i)PageFrame') { return "" }
        return ""
    }

    # Fase 3: Encontrar AddObject e extrair propriedades do WITH subsequente
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $linha = $linhas[$i]

        # Detectar AddObject("nome", "Classe")
        if ($linha -match '(?:^|\s)([\w.]+)\.AddObject\s*\(\s*"(\w+)"\s*,\s*"(\w+)"\s*\)') {
            $parentRef = $Matches[1]
            $objName   = $Matches[2]
            $objClass  = $Matches[3]

            # Resolver alias do parent usando contexto do PROCEDURE atual
            $currentProcName = $lineProc[$i]
            $resolvedParent = Resolve-Alias -VarRef $parentRef -ProcName $currentProcName
            # Normalizar THIS. no inicio
            if (-not $resolvedParent.StartsWith("THIS.")) {
                $resolvedParent = "THIS.$resolvedParent"
            }

            $fullPath = "$resolvedParent.$objName"

            # Determinar pagina: primeiro pelo path resolvido, depois pelo nome do metodo
            $page = ""
            $isDirectPageChild = $false
            $containerInPage = ""
            if ($fullPath -match "\.Page(\d+)\.") {
                $pageNum = $Matches[1]
                $page = if ($pageNum -eq "1") { "SALDO" } elseif ($pageNum -eq "2") { "HIST" } else { "Page$pageNum" }

                if ($resolvedParent -match "\.Page\d+$") {
                    $isDirectPageChild = $true
                }
                else {
                    $containerInPage = ($resolvedParent -replace "^.*\.Page\d+\.", "")
                }
            }

            # Fallback: determinar page pelo nome do PROCEDURE
            if ([string]::IsNullOrEmpty($page)) {
                $procName = $lineProc[$i]
                $page = Get-PageFromProc -ProcName $procName

                # Se tem page, deduzir se eh direto ou container
                if (-not [string]::IsNullOrEmpty($page)) {
                    # Se o parentRef eh uma variavel simples (loc_oPagina, par_oPagina), eh direto na page
                    if ($parentRef -match '^(loc_|par_)\w+$') {
                        $isDirectPageChild = $true
                    }
                    # Se o parentRef tem "." (ex: loc_oCnt.xxx), eh dentro de container
                    elseif ($parentRef -match '\.') {
                        $containerInPage = $parentRef
                    }
                }
            }

            # Extrair propriedades do WITH block subsequente (proximas 30 linhas)
            $props = @{ Top = $null; Left = $null; Width = $null; Height = $null; ButtonCount = $null; ColumnCount = $null; Caption = $null; Visible = $null }

            # Procurar WITH block que referencia este objeto
            for ($j = $i + 1; $j -lt [Math]::Min($i + 50, $linhas.Count); $j++) {
                $wl = $linhas[$j]

                # WITH direto apos AddObject (pode ser WITH parent.objName ou WITH .objName)
                if ($wl -match "^\s*WITH\s+" -and ($wl -match "$([regex]::Escape($objName))\s*$")) {
                    # Ler propriedades dentro do WITH
                    for ($k = $j + 1; $k -lt [Math]::Min($j + 80, $linhas.Count); $k++) {
                        $pl = $linhas[$k]
                        if ($pl -match '^\s*ENDWITH\b') { break }

                        # Skip sub-WITH blocks (ex: .Buttons(N))
                        if ($pl -match '^\s*WITH\s+') {
                            $nestLevel = 1
                            for ($m = $k + 1; $m -lt $linhas.Count; $m++) {
                                if ($linhas[$m] -match '^\s*WITH\s+') { $nestLevel++ }
                                if ($linhas[$m] -match '^\s*ENDWITH\b') { $nestLevel--; if ($nestLevel -le 0) { $k = $m; break } }
                            }
                            continue
                        }

                        if ($pl -match '^\s*\.Top\s*=\s*(-?\d+)') { $props.Top = [int]$Matches[1] }
                        if ($pl -match '^\s*\.Left\s*=\s*(-?\d+)') { $props.Left = [int]$Matches[1] }
                        if ($pl -match '^\s*\.Width\s*=\s*(-?\d+)') { $props.Width = [int]$Matches[1] }
                        if ($pl -match '^\s*\.Height\s*=\s*(-?\d+)') { $props.Height = [int]$Matches[1] }
                        if ($pl -match '^\s*\.ButtonCount\s*=\s*(\d+)') { $props.ButtonCount = [int]$Matches[1] }
                        if ($pl -match '^\s*\.ColumnCount\s*=\s*(\d+)') { $props.ColumnCount = [int]$Matches[1] }
                        if ($pl -match '^\s*\.Visible\s*=\s*(\.T\.|\.F\.)') { $props.Visible = ($Matches[1] -eq ".T.") }
                    }
                    break
                }

                # Propriedades inline (sem WITH block): parent.objName.Top = X
                if ($wl -match "$([regex]::Escape($objName))\.Top\s*=\s*(-?\d+)") { $props.Top = [int]$Matches[1] }
                if ($wl -match "$([regex]::Escape($objName))\.Left\s*=\s*(-?\d+)") { $props.Left = [int]$Matches[1] }
                if ($wl -match "$([regex]::Escape($objName))\.Width\s*=\s*(-?\d+)") { $props.Width = [int]$Matches[1] }
                if ($wl -match "$([regex]::Escape($objName))\.Height\s*=\s*(-?\d+)") { $props.Height = [int]$Matches[1] }
                if ($wl -match "$([regex]::Escape($objName))\.ButtonCount\s*=\s*(\d+)") { $props.ButtonCount = [int]$Matches[1] }
                if ($wl -match "$([regex]::Escape($objName))\.ColumnCount\s*=\s*(\d+)") { $props.ColumnCount = [int]$Matches[1] }

                # Parar se encontrou outro AddObject ou PROCEDURE
                if ($wl -match '\.AddObject\s*\(' -and $j -gt $i) { break }
                if ($wl -match '^\s*(PROTECTED\s+)?PROCEDURE\s+') { break }
            }

            # Tambem verificar propriedade definida ANTES do WITH (ex: grid.ColumnCount = 7)
            # Buscar nas 5 linhas apos o AddObject
            for ($j = $i + 1; $j -lt [Math]::Min($i + 5, $linhas.Count); $j++) {
                $wl = $linhas[$j]
                if ($wl -match "$([regex]::Escape($objName))\.ColumnCount\s*=\s*(\d+)" -and $null -eq $props.ColumnCount) {
                    $props.ColumnCount = [int]$Matches[1]
                }
            }

            $objects += [PSCustomObject]@{
                Name             = $objName
                Class            = $objClass
                FullPath         = $fullPath
                ParentRef        = $resolvedParent
                Page             = $page
                IsDirectPageChild = $isDirectPageChild
                ContainerInPage  = $containerInPage
                Top              = $props.Top
                Left             = $props.Left
                Width            = $props.Width
                Height           = $props.Height
                ButtonCount      = $props.ButtonCount
                ColumnCount      = $props.ColumnCount
                Caption          = $props.Caption
                Visible          = $props.Visible
                LineNumber       = ($i + 1)
                Matched          = $false
            }
        }
    }

    return @{ Objects = $objects }
}

#------------------------------------------------------------------------------
# Compare-Layout: compara layout original vs .prg migrado
#------------------------------------------------------------------------------
function Compare-Layout {
    param(
        [hashtable]$Layout,
        [hashtable]$Prg,
        [int]$ThresholdPx,
        [hashtable]$Mapping = @{}
    )

    $issues = @()

    # Mapear baseClass do layout para Class do VFP9 (normalizacao)
    $classMap = @{
        "container"    = "Container"
        "label"        = "Label"
        "textbox"      = "TextBox"
        "commandbutton" = "CommandButton"
        "commandgroup" = "CommandGroup"
        "optiongroup"  = "OptionGroup"
        "grid"         = "Grid"
        "checkbox"     = "CheckBox"
        "combobox"     = "ComboBox"
        "pageframe"    = "PageFrame"
        "shape"        = "Shape"
        "image"        = "Image"
        "timer"        = "Timer"
        "spinner"      = "Spinner"
    }

    # Agrupar objetos do layout por page + baseClass para facilitar matching
    $layoutByPage = @{}
    foreach ($lo in $Layout.Objects) {
        $key = "$($lo.Page)|$($lo.BaseClass)|$($lo.ContainerPath)"
        if (-not $layoutByPage.ContainsKey($key)) { $layoutByPage[$key] = @() }
        $layoutByPage[$key] += $lo
    }

    # Para cada objeto do layout, tentar encontrar correspondente no .prg
    foreach ($lo in $Layout.Objects) {
        # Normalizar classe
        $expectedClass = if ($classMap.ContainsKey($lo.BaseClass)) { $classMap[$lo.BaseClass] } else { $lo.BaseClass }

        $bestMatch = $null
        $bestDist = [int]::MaxValue

        # =====================================================================
        # ESTRATEGIA 1: Matching por mapeamento (determinístico, via nome)
        # =====================================================================
        if ($null -ne $Mapping -and $Mapping.Count -gt 0) {
            # Tentar match direto pelo FullPath ou Name do layout
            $mappedName = $null
            if ($Mapping.ContainsKey($lo.FullPath)) {
                $mappedName = $Mapping[$lo.FullPath]
            }
            elseif ($Mapping.ContainsKey($lo.Name)) {
                $mappedName = $Mapping[$lo.Name]
            }
            # Tentar com path parcial (SIGCDPRO.Pagina.Dados.getCpro -> getCpro)
            if (-not $mappedName) {
                foreach ($mKey in $Mapping.Keys) {
                    if ($mKey -like "*.$($lo.Name)") {
                        $mappedName = $Mapping[$mKey]
                        break
                    }
                }
            }
            if ($mappedName) {
                # Buscar objeto no .prg pelo nome mapeado (case-insensitive)
                $mappedNameLower = $mappedName.ToLower()
                $bestMatch = $Prg.Objects | Where-Object {
                    $_.Name.ToLower() -eq $mappedNameLower -and -not $_.Matched
                } | Select-Object -First 1
            }
        }

        # =====================================================================
        # ESTRATEGIA 2: Matching por sufixo do nome (heurístico)
        # Ex: getCpro -> txt_4c_Cpro, Say47 -> lbl_4c_Say47FP
        # =====================================================================
        if ($null -eq $bestMatch) {
            $loNameLower = $lo.Name.ToLower()
            # Remover prefixos comuns do legado
            $loNameClean = $loNameLower -replace '^(get|say|lbl|cmd|chk|opt|cmb|cnt|opc_|bot_)', ''
            if ($loNameClean.Length -ge 2) {
                $nameMatch = $Prg.Objects | Where-Object {
                    -not $_.Matched -and
                    $_.Class -ieq $expectedClass -and
                    ($_.Name.ToLower() -match "4c_.*$([regex]::Escape($loNameClean))")
                } | Select-Object -First 1
                if ($nameMatch) {
                    $bestMatch = $nameMatch
                }
            }
        }

        # =====================================================================
        # ESTRATEGIA 3: Matching por posicao (fallback original)
        # =====================================================================
        if ($null -eq $bestMatch) {
            $candidates = $Prg.Objects | Where-Object {
                $_.Page -eq $lo.Page -and
                $_.Class -ieq $expectedClass -and
                -not $_.Matched
            }

            # Filtrar por container (se o layout object esta dentro de um container)
            if (-not [string]::IsNullOrEmpty($lo.ContainerPath)) {
                $candidates = $candidates | Where-Object { -not [string]::IsNullOrEmpty($_.ContainerInPage) }
            }
            else {
                if ($lo.IsDirectPageChild) {
                    $candidates = $candidates | Where-Object { $_.IsDirectPageChild }
                }
            }

            foreach ($c in $candidates) {
                $dx = 0; $dy = 0
                if ($null -ne $lo.TopCompensado -and $null -ne $c.Top) {
                    $dy = [Math]::Abs($lo.TopCompensado - $c.Top)
                }
                if ($null -ne $lo.Left -and $null -ne $c.Left) {
                    $dx = [Math]::Abs($lo.Left - $c.Left)
                }
                $dist = $dx + $dy

                if ($dist -lt $bestDist) {
                    $bestDist = $dist
                    $bestMatch = $c
                }
            }
        }

        if ($null -eq $bestMatch) {
            # Objeto nao encontrado no .prg
            $issues += [PSCustomObject]@{
                Severity = "ERROR"
                Object   = $lo.Name
                Path     = $lo.FullPath
                Page     = $lo.Page
                Class    = $lo.BaseClass
                Property = $null
                Expected = $null
                Actual   = $null
                Delta    = $null
                Message  = "Objeto do layout.json NAO encontrado no .prg (sem AddObject correspondente)"
                Line     = $null
            }
            continue
        }

        # Marcar como matched
        $bestMatch.Matched = $true
        $lo.Matched = $true

        # Comparar propriedades posicionais
        $propsToCompare = @(
            @{ Name = "Top";    LayoutVal = $lo.TopCompensado; PrgVal = $bestMatch.Top },
            @{ Name = "Left";   LayoutVal = $lo.Left;          PrgVal = $bestMatch.Left },
            @{ Name = "Width";  LayoutVal = $lo.Width;         PrgVal = $bestMatch.Width },
            @{ Name = "Height"; LayoutVal = $lo.Height;        PrgVal = $bestMatch.Height }
        )

        foreach ($prop in $propsToCompare) {
            if ($null -ne $prop.LayoutVal -and $null -ne $prop.PrgVal) {
                $delta = [Math]::Abs($prop.LayoutVal - $prop.PrgVal)
                if ($delta -gt $ThresholdPx) {
                    $issues += [PSCustomObject]@{
                        Severity = "WARNING"
                        Object   = "$($lo.Name) -> $($bestMatch.Name)"
                        Path     = $lo.FullPath
                        Page     = $lo.Page
                        Class    = $lo.BaseClass
                        Property = $prop.Name
                        Expected = $prop.LayoutVal
                        Actual   = $prop.PrgVal
                        Delta    = $delta
                        Message  = "Posicao divergente: $($prop.Name) esperado=$($prop.LayoutVal) atual=$($prop.PrgVal) delta=$delta"
                        Line     = $bestMatch.LineNumber
                    }
                }
            }
        }

        # Comparar propriedades estruturais (devem ser exatas)
        if ($null -ne $lo.ButtonCount -and $null -ne $bestMatch.ButtonCount) {
            if ($lo.ButtonCount -ne $bestMatch.ButtonCount) {
                $issues += [PSCustomObject]@{
                    Severity = "ERROR"
                    Object   = "$($lo.Name) -> $($bestMatch.Name)"
                    Path     = $lo.FullPath
                    Page     = $lo.Page
                    Class    = $lo.BaseClass
                    Property = "ButtonCount"
                    Expected = $lo.ButtonCount
                    Actual   = $bestMatch.ButtonCount
                    Delta    = $null
                    Message  = "ButtonCount divergente: esperado=$($lo.ButtonCount) atual=$($bestMatch.ButtonCount)"
                    Line     = $bestMatch.LineNumber
                }
            }
        }

        if ($null -ne $lo.ColumnCount -and $null -ne $bestMatch.ColumnCount) {
            if ($lo.ColumnCount -ne $bestMatch.ColumnCount) {
                $issues += [PSCustomObject]@{
                    Severity = "ERROR"
                    Object   = "$($lo.Name) -> $($bestMatch.Name)"
                    Path     = $lo.FullPath
                    Page     = $lo.Page
                    Class    = $lo.BaseClass
                    Property = "ColumnCount"
                    Expected = $lo.ColumnCount
                    Actual   = $bestMatch.ColumnCount
                    Delta    = $null
                    Message  = "ColumnCount divergente: esperado=$($lo.ColumnCount) atual=$($bestMatch.ColumnCount)"
                    Line     = $bestMatch.LineNumber
                }
            }
        }
    }

    # Objetos no .prg que nao foram matched (extras)
    $unmatched = $Prg.Objects | Where-Object { -not $_.Matched }
    foreach ($uo in $unmatched) {
        $issues += [PSCustomObject]@{
            Severity = "INFO"
            Object   = $uo.Name
            Path     = $uo.FullPath
            Page     = $uo.Page
            Class    = $uo.Class
            Property = $null
            Expected = $null
            Actual   = $null
            Delta    = $null
            Message  = "Objeto no .prg sem correspondente no layout.json (pode ser auxiliar: labels, containers de layout)"
            Line     = $uo.LineNumber
        }
    }

    return $issues
}

#------------------------------------------------------------------------------
# Generate-Report: gera relatorio JSON e console
#------------------------------------------------------------------------------
function Generate-Report {
    param(
        [array]$Issues,
        [hashtable]$Layout,
        [hashtable]$Prg,
        [string]$LayoutFile,
        [string]$PrgFile,
        [int]$ThresholdPx,
        [string]$ReportFile
    )

    $errors   = @($Issues | Where-Object { $_.Severity -eq "ERROR" })
    $warnings = @($Issues | Where-Object { $_.Severity -eq "WARNING" })
    $infos    = @($Issues | Where-Object { $_.Severity -eq "INFO" })

    $matchedLayout = @($Layout.Objects | Where-Object { $_.Matched })
    $unmatchedLayout = @($Layout.Objects | Where-Object { -not $_.Matched })

    # Console output
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  VALIDAR LAYOUT vs PRG" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Layout: $(Split-Path -Leaf $LayoutFile)" -ForegroundColor Gray
    Write-Host "  PRG:    $(Split-Path -Leaf $PrgFile)" -ForegroundColor Gray
    Write-Host "  Threshold: ${ThresholdPx}px" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  Objetos no layout.json: $($Layout.Objects.Count)" -ForegroundColor White
    Write-Host "  Objetos no .prg:        $($Prg.Objects.Count)" -ForegroundColor White
    Write-Host "  Matched:                $($matchedLayout.Count)" -ForegroundColor Green
    Write-Host "  Sem correspondente:     $($unmatchedLayout.Count)" -ForegroundColor $(if ($unmatchedLayout.Count -gt 0) { "Red" } else { "Green" })
    Write-Host ""
    Write-Host "  ERRORS:   $($errors.Count)" -ForegroundColor $(if ($errors.Count -gt 0) { "Red" } else { "Green" })
    Write-Host "  WARNINGS: $($warnings.Count)" -ForegroundColor $(if ($warnings.Count -gt 0) { "Yellow" } else { "Green" })
    Write-Host "  INFOS:    $($infos.Count)" -ForegroundColor Gray
    Write-Host ""

    # Detalhe dos erros
    if ($errors.Count -gt 0) {
        Write-Host "--- ERRORS ---" -ForegroundColor Red
        foreach ($e in $errors) {
            Write-Host "  [$($e.Page)] $($e.Path) ($($e.Class))" -ForegroundColor Red
            Write-Host "    $($e.Message)" -ForegroundColor Red
            if ($null -ne $e.Line) { Write-Host "    Linha .prg: $($e.Line)" -ForegroundColor Gray }
        }
        Write-Host ""
    }

    # Detalhe dos warnings (top 20)
    if ($warnings.Count -gt 0) {
        Write-Host "--- WARNINGS (posicao divergente) ---" -ForegroundColor Yellow
        $shown = 0
        foreach ($w in ($warnings | Sort-Object -Property Delta -Descending)) {
            Write-Host "  [$($w.Page)] $($w.Object) ($($w.Class)): $($w.Property) esperado=$($w.Expected) atual=$($w.Actual) delta=$($w.Delta)px" -ForegroundColor Yellow
            $shown++
            if ($shown -ge 20) { Write-Host "  ... e mais $($warnings.Count - 20) warnings" -ForegroundColor Gray; break }
        }
        Write-Host ""
    }

    # Salvar JSON
    if (-not [string]::IsNullOrEmpty($ReportFile)) {
        $report = @{
            timestamp       = (Get-Date -Format "yyyy-MM-ddTHH:mm:ss")
            layoutFile      = $LayoutFile
            prgFile         = $PrgFile
            thresholdPx     = $ThresholdPx
            formOriginal    = $Layout.FormName
            summary         = @{
                layoutObjects   = $Layout.Objects.Count
                prgObjects      = $Prg.Objects.Count
                matched         = $matchedLayout.Count
                unmatched       = $unmatchedLayout.Count
                errors          = $errors.Count
                warnings        = $warnings.Count
                infos           = $infos.Count
            }
            issues = @($Issues | ForEach-Object {
                @{
                    severity = $_.Severity
                    object   = $_.Object
                    path     = $_.Path
                    page     = $_.Page
                    class    = $_.Class
                    property = $_.Property
                    expected = $_.Expected
                    actual   = $_.Actual
                    delta    = $_.Delta
                    message  = $_.Message
                    line     = $_.Line
                }
            })
        }
        $report | ConvertTo-Json -Depth 5 | Set-Content -Path $ReportFile -Encoding UTF8
        Write-Host "  Relatorio salvo: $ReportFile" -ForegroundColor Gray
    }

    return @{
        Errors   = $errors.Count
        Warnings = $warnings.Count
        Infos    = $infos.Count
        Matched  = $matchedLayout.Count
        Unmatched = $unmatchedLayout.Count
    }
}

#==============================================================================
# MAIN
#==============================================================================

if (-not (Test-Path $LayoutJsonFile)) {
    Write-Host "ERRO: layout.json nao encontrado: $LayoutJsonFile" -ForegroundColor Red
    exit 1
}
if (-not (Test-Path $FormPrgFile)) {
    Write-Host "ERRO: .prg nao encontrado: $FormPrgFile" -ForegroundColor Red
    exit 1
}

# Auto-gerar nome do report se nao informado
if ([string]::IsNullOrEmpty($ReportFile)) {
    $taskDir = Split-Path -Parent $LayoutJsonFile
    $ReportFile = Join-Path $taskDir "layout_vs_prg_report.json"
}

Write-Host ""

# Carregar mapeamento se disponivel
$mapping = @{}
if (-not [string]::IsNullOrEmpty($MapeamentoFile) -and (Test-Path $MapeamentoFile)) {
    Write-Host "Carregando mapeamento: $MapeamentoFile" -ForegroundColor Cyan
    try {
        $mapJson = Get-Content $MapeamentoFile -Raw | ConvertFrom-Json
        # Construir hashtable legado->migrado a partir do mapeamento
        # Formato: { "mapeamento": { "SIGCDPRO.Pagina.Lista.getCpro": "txt_4c_Cpro", ... } }
        if ($mapJson.PSObject.Properties['mapeamento']) {
            $mapObj = $mapJson.mapeamento
            foreach ($prop in $mapObj.PSObject.Properties) {
                $legacyPath = $prop.Name
                $migratedName = $prop.Value
                if ($legacyPath -and $migratedName) {
                    $mapping[$legacyPath] = $migratedName
                    # Tambem mapear pelo nome curto (ultima parte do path)
                    $shortName = ($legacyPath -split '\.')[-1]
                    if (-not $mapping.ContainsKey($shortName)) {
                        $mapping[$shortName] = $migratedName
                    }
                }
            }
        }
        Write-Host "  Entradas no mapeamento: $($mapping.Count)" -ForegroundColor Gray
    }
    catch {
        Write-Host "  AVISO: Falha ao carregar mapeamento: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}
else {
    # Auto-detectar mapeamento no mesmo diretorio do layout
    $autoMapFile = Join-Path (Split-Path $LayoutJsonFile -Parent) "mapeamento.json"
    if (Test-Path $autoMapFile) {
        Write-Host "Mapeamento auto-detectado: $autoMapFile" -ForegroundColor Cyan
        try {
            $mapJson = Get-Content $autoMapFile -Raw | ConvertFrom-Json
            if ($mapJson.PSObject.Properties['mapeamento']) {
                $mapObj = $mapJson.mapeamento
                foreach ($prop in $mapObj.PSObject.Properties) {
                    $legacyPath = $prop.Name
                    $migratedName = $prop.Value
                    if ($legacyPath -and $migratedName) {
                        $mapping[$legacyPath] = $migratedName
                        $shortName = ($legacyPath -split '\.')[-1]
                        if (-not $mapping.ContainsKey($shortName)) {
                            $mapping[$shortName] = $migratedName
                        }
                    }
                }
            }
            Write-Host "  Entradas no mapeamento: $($mapping.Count)" -ForegroundColor Gray
        }
        catch {
            Write-Host "  AVISO: Falha ao carregar mapeamento: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }
}

Write-Host "Parseando layout.json..." -ForegroundColor Cyan
$layout = Parse-LayoutJson -FilePath $LayoutJsonFile

Write-Host "Parseando .prg..." -ForegroundColor Cyan
$prg = Parse-PrgFile -FilePath $FormPrgFile

Write-Host "Comparando..." -ForegroundColor Cyan
$issues = Compare-Layout -Layout $layout -Prg $prg -ThresholdPx $ThresholdPx -Mapping $mapping

$result = Generate-Report -Issues $issues -Layout $layout -Prg $prg `
    -LayoutFile $LayoutJsonFile -PrgFile $FormPrgFile `
    -ThresholdPx $ThresholdPx -ReportFile $ReportFile

# Exit code: 0 = OK, 1 = has errors
if ($result.Errors -gt 0) {
    exit 1
}
exit 0
