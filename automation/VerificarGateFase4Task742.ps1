# VerificarGateFase4Task742.ps1
#
# Reproduz o bloco `case 4` REAL do OrquestradorMigracao.ps1 (recortado por
# texto do proprio arquivo, nao por copia manual) sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real.
#
# Alvo: SIGOPFIS -> Formsigopfis (task742), "Dados Fiscais": dialogo MODAL
# filho de um form de movimentacao, com PageFrame de paginas de DOMINIO
# ("Impostos"/"Servicos"), 78 TextBox + 3 ComboBox + 1 OptionGroup,
# 9 CommandButton e ZERO Grid/ListBox.
#
# O ramo PAGINADO-NAO-CRUD que as Fases 5 e 6 ja tem
# (Test-LegadoPaginadoSemPaginaDados) nunca recebeu call site na Fase 4.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase4Task742.ps1
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task742',
    [string]$BaseNameArg  = 'sigopfis',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\Formsigopfis.prg',
    [string]$FormClassArg = 'Formsigopfis',
    [string]$BoClassArg   = 'sigopfisBO'
)

$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    exit 2
}
"SINTAXE=OK  ({0})" -f $Orquestrador

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$linhas = Get-Content $Orquestrador
$ini = -1; $fim = -1
for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($ini -lt 0 -and $linhas[$i] -match '^\s{8}4\s\{\s*$') { $ini = $i; continue }
    if ($ini -ge 0 -and $linhas[$i] -match '^\s{8}\}\s*$')    { $fim = $i; break }
}
if ($ini -lt 0 -or $fim -lt 0) { "RECORTE=FALHA (case 4 nao localizado)"; exit 2 }
"RECORTE=OK  (linhas {0}..{1})" -f ($ini + 1), ($fim + 1)

$corpo = ($linhas[$ini..$fim] -join "`r`n")

$formFile  = $FormFileArg
$TaskPath  = $TaskPathArg
$BaseName  = $BaseNameArg
$FormType  = 'OPERACIONAL'
$formClass = $FormClassArg
$boClass   = $BoClassArg
$validado  = $false

# Diagnostico independente do bloco
$dump = Get-Content (Join-Path $TaskPathArg "$($BaseNameArg)_form_codigo_fonte.txt") -Raw
"BaseClass grid|pageframe   = {0}" -f ($dump -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$')
"BaseClass grid             = {0}" -f ($dump -match '(?im)^\s*BaseClass:\s*grid\s*$')
"ListBoxLigaLista           = {0}" -f (Test-LegadoListBoxLigaLista      -TextoDump $dump)
"TokenGradeProprioForm      = {0}" -f (Test-LegadoTokenGradeProprioForm -TextoDump $dump)
"AddCursorLigaGrade         = {0}" -f (Test-LegadoAddCursorLigaGrade    -TextoDump $dump)
"ControlSourceLigaLista     = {0}" -f (Test-LegadoControlSourceLigaLista -TextoDump $dump)
"DialogoExibicao            = {0}" -f (Test-LegadoDialogoExibicao       -TextoDump $dump)
"PaginadoSemPaginaDados     = {0}" -f (Test-LegadoPaginadoSemPaginaDados -TextoDump $dump)
"nBotoesLegado              = {0}" -f (Get-ContagemBotoesLegado         -TextoDump $dump)
$prg = Get-Content $FormFileArg -Raw
"migrado: pgf_4c_           = {0}" -f ($prg -match 'AddObject\(\s*"pgf_4c_')
"migrado: grd_4c_           = {0}" -f ($prg -match 'AddObject\(\s*"grd_4c_')
"migrado: cmd/cmg_4c_       = {0}" -f ($prg -match 'AddObject\(\s*"(cmg_4c_|cmd_4c_)')
"migrado: InicializarForm   = {0}" -f ($prg -match 'InicializarForm')
"migrado: ConfigurarPaginaLista = {0}" -f ($prg -match 'ConfigurarPaginaLista')
"migrado: AlternarPagina        = {0}" -f ($prg -match 'AlternarPagina')

Invoke-Expression "switch (4) {`r`n$corpo`r`n}"

if ($validado) { "VEREDITO=PASSA"; exit 0 }
"VEREDITO=REPROVA"
exit 1
