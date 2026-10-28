# MedirDeltaGrupoOpSemVerboCrud.ps1
#
# Mede o ALCANCE da DECIMA-PRIMEIRA excecao (Test-GrupoOpSemVerboCrud) em
# TODOS os dumps de tasks\, antes de deixar o ramo no lugar.
#
# Reproduz a cadeia ESTRUTURAL das Fases 7/8 nas duas versoes:
#   PRE  = frmcadastro OR (Grupo_Op e nao Test-BarraCrudEhDoFormPai)
#   POS  = idem, mais a dispensa de Test-GrupoOpSemVerboCrud
# e lista os dumps em que o veredito ESTRUTURAL muda (sempre no sentido da
# dispensa - relaxar gate nunca REPROVA um form).
#
# Para cada dump alcancado diz tambem se o .prg migrado JA tem os 4 nomes
# BtnXxxClick: se tem, a dispensa eh NO-OP para ele.
#
# Uso:  & C:\4c\automation\MedirDeltaGrupoOpSemVerboCrud.ps1
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$RaizTasks    = 'C:\4c\tasks',
    [string]$RaizForms    = 'C:\4c\projeto\app\forms'
)

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}
if (-not (Get-Command Test-GrupoOpSemVerboCrud -ErrorAction SilentlyContinue)) {
    "ERRO: Test-GrupoOpSemVerboCrud nao existe em $Orquestrador"; exit 2
}

$dumps = Get-ChildItem -Path $RaizTasks -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
"Dumps analisados: $($dumps.Count)"

$prgs = @{}
foreach ($p in (Get-ChildItem -Path $RaizForms -Recurse -Filter '*.prg' -ErrorAction SilentlyContinue)) {
    $prgs[$p.BaseName.ToLower()] = $p.FullName
}

$mudou = New-Object System.Collections.ArrayList
foreach ($d in $dumps) {
    $txt = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $txt) { continue }

    $temFrm   = [bool]($txt -match 'frmcadastro')
    $temGrupo = [bool]($txt -match 'Grupo_Op')
    if (-not $temGrupo) { continue }          # sem Grupo_Op nada muda

    $doPai = (-not $temFrm) -and (Test-BarraCrudEhDoFormPai -TextoDump $txt)
    $semVb = (-not $temFrm) -and (Test-GrupoOpSemVerboCrud  -TextoDump $txt)

    $estruturalPre = $temFrm -or ($temGrupo -and -not $doPai)
    $estruturalPos = $temFrm -or ($temGrupo -and -not ($doPai -or $semVb))

    if ($estruturalPre -ne $estruturalPos) {
        $base = ($d.BaseName -replace '_form_codigo_fonte$','')
        [void]$mudou.Add([pscustomobject]@{
            Dump  = $d.FullName.Replace('C:\4c\','')
            Base  = $base
            Pre   = $estruturalPre
            Pos   = $estruturalPos
        })
    }
}

"Dumps em que o veredito ESTRUTURAL muda: $($mudou.Count)"
$distintos = @($mudou | Select-Object -ExpandProperty Base -Unique | Sort-Object)
"Legados DISTINTOS alcancados: $($distintos.Count)  ->  $($distintos -join ', ')"
""
foreach ($m in $mudou) { "  {0,-5} -> {1,-5}  {2}" -f $m.Pre, $m.Pos, $m.Dump }

""
"--- os 4 nomes BtnXxxClick JA estao no .prg migrado? (SIM = dispensa eh NO-OP) ---"
$quatro = @('BtnIncluirClick','BtnAlterarClick','BtnVisualizarClick','BtnExcluirClick')
foreach ($b in $distintos) {
    $cands = @($prgs.Keys | Where-Object { $_ -eq "form$($b.ToLower())" -or $_ -eq $b.ToLower() -or $_ -like "form$($b.ToLower())" })
    if ($cands.Count -eq 0) { "  {0,-14}  .prg AUSENTE (legado ainda nao migrado)" -f $b; continue }
    foreach ($c in $cands) {
        $t = Get-Content $prgs[$c] -Raw
        $falta = @($quatro | Where-Object { $t -notmatch $_ })
        $nH = ([regex]::Matches($t, 'PROCEDURE\s+(Cmd|Btn)\w*Click')).Count
        if ($falta.Count -eq 0) { "  {0,-14}  {1,-28} TEM os 4 -> NO-OP" -f $b, (Split-Path $prgs[$c] -Leaf) }
        else { "  {0,-14}  {1,-28} faltam {2} / handlers Cmd|Btn*Click = {3}" -f $b, (Split-Path $prgs[$c] -Leaf), $falta.Count, $nH }
    }
}
