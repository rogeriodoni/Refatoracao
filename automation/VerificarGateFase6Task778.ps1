# =============================================================================
# VerificarGateFase6Task778.ps1
#
# Reexecuta, FORA do orquestrador, as duas verificacoes que a Fase 6 da
# task778 (SIGOPPEC -> FormSigOpPec) precisa passar:
#
#   1. Test-CompletudeCodigo   - nenhum TODO/stub/procedure vazia no Form e no BO
#   2. Gate da Fase 6          - qual ramo valida este form (esperado: CAPTURA)
#
# As funcoes auxiliares vem de LibGateFase6Task738.ps1, que eh uma EXTRACAO
# literal de OrquestradorMigracao.ps1 - dot-source do orquestrador inteiro
# DISPARA uma migracao, por isso nao se usa aqui.
#
# Uso:  powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase6Task778.ps1
# Exit: 0 = as duas verificacoes passaram / 1 = alguma falhou
# =============================================================================

$ErrorActionPreference = "Stop"
$raiz = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $raiz "LibGateFase6Task738.ps1")

$TaskPath  = Join-Path (Split-Path -Parent $raiz) "tasks\task778"
$BaseName  = "SigOpPec"
$FormType  = "OPERACIONAL"
$formClass = "FormSigOpPec"
$boClass   = "SigOpPecBO"
$formFile  = Join-Path (Split-Path -Parent $raiz) "projeto\app\forms\operacionais\FormSigOpPec.prg"
$boFile    = Join-Path (Split-Path -Parent $raiz) "projeto\app\classes\SigOpPecBO.prg"

$falhou = $false

Write-Host "===== 1) COMPLETUDE (sem TODO / stub / procedure vazia) =====" -ForegroundColor Cyan
if (-not (Test-CompletudeCodigo -FilePath $formFile -Descricao "Form FormSigOpPec")) { $falhou = $true }
if (-not (Test-CompletudeCodigo -FilePath $boFile   -Descricao "BO SigOpPecBO"))     { $falhou = $true }

Write-Host ""
Write-Host "===== 2) GATE DA FASE 6 =====" -ForegroundColor Cyan

$conteudo   = Get-Content $formFile -Raw
$dumpLegado = Join-Path $TaskPath "$($BaseName)_form_codigo_fonte.txt"
$txtLegado  = Get-Content $dumpLegado -Raw

# --- lado MIGRADO -----------------------------------------------------------
$temPaginaDados   = ($conteudo -match "ConfigurarPaginaDados" -and $conteudo -match "BINDEVENT")
$semPageFrame     = ($conteudo -notmatch 'AddObject\(\s*"pgf_4c_')
$temBindEvent     = ($conteudo -match "BINDEVENT")
$temMetodoLookup  = ($conteudo -match "PROCEDURE\s+(AbrirLookup|AbrirBusca)\w*")
$nCamposMigrado   = ([regex]::Matches($conteudo, 'AddObject\(\s*"[^"]+"\s*,\s*"TextBox\w*"')).Count

# --- lado LEGADO: ausencia de lookup (os 6 padroes do gate) -----------------
$padroesLookup = @(
    'fwbusca',
    'mAddColuna',
    'sigacess\s*\(',
    'Acesso(Campos|Contab|Contas|Empresa|Grupos|MovInd|MovMto|Produto|Titulo)\s*\(',
    'FormBuscaAuxiliar'
)
$lookupAchados = @($padroesLookup | Where-Object { $txtLegado -match $_ })
$legadoSemLookup = ($lookupAchados.Count -eq 0)

Write-Host "  dump legado: $(Split-Path -Leaf $dumpLegado) ($((Get-Content $dumpLegado).Count) linhas)"
foreach ($p in $padroesLookup) {
    $n = ([regex]::Matches($txtLegado, $p, 'IgnoreCase')).Count
    Write-Host ("    {0,-62} {1}" -f $p, $n)
}
Write-Host "  => legadoSemLookup = $legadoSemLookup" -ForegroundColor $(if ($legadoSemLookup) { "Green" } else { "Yellow" })

# --- lado LEGADO: ramo CAPTURA ---------------------------------------------
$temListaEstrita = ($txtLegado -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                   (Test-LegadoListBoxLigaLista      -TextoDump $txtLegado) -or
                   (Test-LegadoTokenGradeProprioForm -TextoDump $txtLegado) -or
                   (Test-LegadoAddCursorLigaGrade    -TextoDump $txtLegado) -or
                   (Test-LegadoControlSourceLigaLista -TextoDump $txtLegado)
$temCampoCaptura  = $txtLegado -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|checkbox|optiongroup|optionbutton|spinner)\s*$'
$temApiNosCaptura = $txtLegado -match '(?i)(AddPictureNode|ClearNodes|NodeCargo|NodeExpanded|NodeLevel|NodeHeader|\.Nodes\.Add)'
$ehExibicao       = Test-LegadoDialogoExibicao -TextoDump $txtLegado
$nCamposTbLegado  = ([regex]::Matches($txtLegado, '(?im)^\s*BaseClass:\s*textbox\s*$')).Count

$legadoCaptura = (-not $temListaEstrita) -and (-not $temApiNosCaptura) -and $temCampoCaptura -and (-not $ehExibicao)
$pisoCampos    = [math]::Ceiling($nCamposTbLegado / 2)

$temSuperficieCaptura = $false
if ($nCamposTbLegado -ge 1) {
    $temSuperficieCaptura = ($nCamposMigrado -ge $pisoCampos)
} else {
    $temSuperficieCaptura = ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(TextBox\w*|EditBox\w*|ComboBox\w*|CheckBox\w*|OptionGroup\w*|Spinner\w*)"')
}
$temSuperficieCaptura = $temSuperficieCaptura -and
                        ($conteudo -match "InicializarForm") -and
                        ($conteudo -match "PROCEDURE\s+Validar\w+")

$temLayoutCaptura = ($FormType -eq "OPERACIONAL" -and $semPageFrame -and $temBindEvent -and
                     $legadoCaptura -and $legadoSemLookup -and $temSuperficieCaptura)

Write-Host ""
Write-Host "  --- lado migrado ---"
Write-Host "    semPageFrame .................. $semPageFrame"
Write-Host "    temBindEvent ................... $temBindEvent"
Write-Host "    temMetodoLookup (AbrirLookup*) . $temMetodoLookup   (esperado False - legado sem lookup)"
Write-Host "    TextBox criados ................ $nCamposMigrado  (piso $pisoCampos = metade dos $nCamposTbLegado do legado)"
Write-Host "    PROCEDURE Validar* ............. $($conteudo -match 'PROCEDURE\s+Validar\w+')"
Write-Host "  --- lado legado (ramo CAPTURA) ---"
Write-Host "    temListaEstrita ................ $temListaEstrita   (esperado False)"
Write-Host "    temCampoCaptura ................ $temCampoCaptura"
Write-Host "    temApiNosCaptura ............... $temApiNosCaptura  (esperado False)"
Write-Host "    ehDialogoExibicao .............. $ehExibicao        (esperado False - ha campo digitavel)"
Write-Host "    => legadoCaptura ............... $legadoCaptura"
Write-Host ""
Write-Host "  RAMO CAPTURA VALIDA? $temLayoutCaptura" -ForegroundColor $(if ($temLayoutCaptura) { "Green" } else { "Red" })

if (-not $temLayoutCaptura) { $falhou = $true }

Write-Host ""
if ($falhou) {
    Write-Host "RESULTADO: FALHOU" -ForegroundColor Red
    exit 1
}
Write-Host "RESULTADO: OK - completude limpa e Fase 6 validada pelo ramo CAPTURA" -ForegroundColor Green
exit 0
