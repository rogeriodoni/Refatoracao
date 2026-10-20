# Mede o delta de Test-AcaoDoLegadoTemHandler com as DUAS correcoes:
#  (A) colher o verbo tambem dos MEMBROS INTERNOS do CommandGroup/CommandButton
#  (B) aceitar o handler com prefixo Btn OU Cmd (familia, nao especime)
# AST-only: dot-source do orquestrador DISPARA migracao real.
$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

function Test-AcaoNovo {
    param([string]$TextoDump, [string]$ConteudoForm, [switch]$SemInterno, [switch]$SemCmd)
    if ([string]::IsNullOrWhiteSpace($TextoDump))    { return $false }
    if ([string]::IsNullOrWhiteSpace($ConteudoForm)) { return $false }
    $verbosDeSaida = @('sair','saida','sa' + [char]0x00ED + 'da','saidas',
                       'encerrar','encerra','fechar','fecha',
                       'cancelar','cancela','retornar','retorna',
                       'voltar','volta','abandonar','ok','x','esc','exit','close')
    $candidatos = New-Object System.Collections.Generic.List[string]
    $botoesPorBaseClass = New-Object System.Collections.Generic.HashSet[string] ([StringComparer]::OrdinalIgnoreCase)
    foreach ($o in [regex]::Matches($TextoDump,
        '(?im)^\s*Objeto:\s*(?<nome>[^\r\n]+?)\s*\r?\n(?:[^\r\n]*\r?\n){0,3}?\s*BaseClass:\s*(?:commandbutton|commandgroup)\s*$')) {
        [void]$botoesPorBaseClass.Add($o.Groups['nome'].Value.Trim())
    }
    $blocos = [regex]::Matches($TextoDump,
        '(?is)\*\s*PROPRIEDADES\s+DE:\s*(?<caminho>[^\r\n]+)\r?\n[-\s]*\r?\n(?<corpo>.*?)(?=\*\s*PROPRIEDADES\s+DE:|\z)')
    foreach ($b in $blocos) {
        $corpo = $b.Groups['corpo'].Value
        $nome = [regex]::Match($corpo, '(?im)^\s*Name\s*=\s*"([^"]+)"').Groups[1].Value
        if ([string]::IsNullOrWhiteSpace($nome)) { continue }
        if (($nome -notmatch '(?i)^(cmd|btn|command|Grupo)') -and
            (-not $botoesPorBaseClass.Contains($nome))) { continue }
        $caption = [regex]::Match($corpo, '(?im)^\s*Caption\s*=\s*"([^"]*)"').Groups[1].Value
        $brutos = [System.Collections.Generic.List[string]]::new()
        [void]$brutos.Add($caption); [void]$brutos.Add($nome)
        if (-not $SemInterno) {
            foreach ($mi in [regex]::Matches($corpo, '(?im)^\s*\w+\.(?:Name|Caption)\s*=\s*"([^"]*)"')) {
                [void]$brutos.Add($mi.Groups[1].Value)
            }
        }
        foreach ($bruto in $brutos) {
            if ([string]::IsNullOrWhiteSpace($bruto)) { continue }
            $limpo = $bruto -replace '\<', '' -replace '&', ''
            $limpo = $limpo -replace '(?i)^(cmd|btn|command)', ''
            $rxNaoLetra = '[^A-Za-z' + [char]0x00C0 + '-' + [char]0x00FF + ']+'; $limpo = $limpo -replace $rxNaoLetra, ' '
            foreach ($palavra in ($limpo -split '\s+')) {
                if ($palavra.Length -lt 4) { continue }
                if ($verbosDeSaida -contains $palavra.ToLower()) { continue }
                [void]$candidatos.Add($palavra)
            }
        }
    }
    $pfx = if ($SemCmd) { 'Btn' } else { '(?:Btn|Cmd)' }
    foreach ($verbo in ($candidatos | Select-Object -Unique)) {
        $raiz = $verbo
        if ($raiz.Length -gt 5) { $raiz = $raiz.Substring(0, $raiz.Length - 1) }
        $raizEscapada = [regex]::Escape($raiz)
        if ($ConteudoForm -match "(?im)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+$pfx\w*$raizEscapada\w*Click\b") {
            return $true
        }
    }
    return $false
}

# Pareia cada dump de tasks\ com o .prg migrado correspondente
$formDirs = @('C:\4c\projeto\app\forms\operacionais','C:\4c\projeto\app\forms\cadastros','C:\4c\projeto\app\forms\relatorios','C:\4c\projeto\app\forms')
$res = @()
foreach ($dump in Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue) {
    $base = $dump.Name -replace '_form_codigo_fonte\.txt$',''
    $prg = $null
    foreach ($d in $formDirs) {
        $cand = Get-ChildItem $d -Filter "Form$base.prg" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($cand) { $prg = $cand.FullName; break }
    }
    if (-not $prg) { continue }
    $txt = Get-Content $dump.FullName -Raw -ErrorAction SilentlyContinue
    $cnt = Get-Content $prg -Raw -ErrorAction SilentlyContinue
    if (-not $txt -or -not $cnt) { continue }
    $res += [pscustomobject]@{
        Task     = $dump.Directory.Name
        Base     = $base
        Prg      = $prg
        Velho    = (Test-AcaoDoLegadoTemHandler -TextoDump $txt -ConteudoForm $cnt)
        SoA      = (Test-AcaoNovo -TextoDump $txt -ConteudoForm $cnt -SemCmd)
        SoB      = (Test-AcaoNovo -TextoDump $txt -ConteudoForm $cnt -SemInterno)
        Novo     = (Test-AcaoNovo -TextoDump $txt -ConteudoForm $cnt)
        Conteudo = $cnt
        Dump     = $txt
    }
}
"dumps pareados com form migrado = {0}" -f $res.Count
"helper VELHO .T.                = {0}" -f @($res | Where-Object Velho).Count
"helper (A) interno              = {0}" -f @($res | Where-Object SoA).Count
"helper (B) prefixo Cmd          = {0}" -f @($res | Where-Object SoB).Count
"helper NOVO (A+B)               = {0}" -f @($res | Where-Object Novo).Count
"REGRESSAO (.T. -> .F.)          = {0}" -f @($res | Where-Object { $_.Velho -and -not $_.Novo }).Count
$flip = @($res | Where-Object { -not $_.Velho -and $_.Novo })
"FLIP (.F. -> .T.)               = {0}" -f $flip.Count
$res | Export-Clixml 'C:\4c\automation\_medir_f8_acao.xml'
""
"--- FLIPS: quais mudam o veredito FINAL (ja passavam pelos 4 nomes)? ---"
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$mudamFinal = 0
foreach ($r in $flip) {
    $falt = @($metodosFinals | Where-Object { $r.Conteudo -notmatch $_ })
    $jaCasaCanonico = ($r.Conteudo -match $padraoAcaoGravar)
    if ($falt.Count -eq 0 -and -not $jaCasaCanonico) {
        $mudamFinal++
        "  {0,-10} {1,-22} (A={2} B={3})" -f $r.Task, $r.Base, $r.SoA, $r.SoB
    }
}
"total que mudam veredito FINAL (limite inferior) = {0}" -f $mudamFinal
