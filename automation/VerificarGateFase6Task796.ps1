# =============================================================================
# VerificarGateFase6Task796.ps1
#
# Reexecuta, FORA do orquestrador, o que a Fase 6 da task796
# (SIGOPROB -> FormSigOpRob) precisa passar:
#
#   1. Test-CompletudeCodigo  - nenhum TODO/stub/procedure vazia no Form e no BO
#   2. Gate da Fase 6         - qual ramo valida este form (esperado: EXIBICAO)
#
# As funcoes auxiliares vem de LibGateFase6Task738.ps1, que eh uma EXTRACAO
# literal de OrquestradorMigracao.ps1 - dot-source do orquestrador inteiro
# DISPARA uma migracao, por isso nao se usa aqui.
#
# Uso:  powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase6Task796.ps1
# Exit: 0 = as duas verificacoes passaram / 1 = alguma falhou
# =============================================================================

$ErrorActionPreference = "Stop"
$raiz = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $raiz "LibGateFase6Task738.ps1")

$TaskPath  = Join-Path (Split-Path -Parent $raiz) "tasks\task796"
$BaseName  = "SigOpRob"
$FormType  = "OPERACIONAL"
$formClass = "FormSigOpRob"
$boClass   = "SigOpRobBO"
$formFile  = Join-Path (Split-Path -Parent $raiz) "projeto\app\forms\operacionais\FormSigOpRob.prg"
$boFile    = Join-Path (Split-Path -Parent $raiz) "projeto\app\classes\SigOpRobBO.prg"

$falhou = $false

# -------------------------------------------------------------------------
# 1. Completude (TODO / stub / procedure vazia)
# -------------------------------------------------------------------------
Write-Host "[1] Test-CompletudeCodigo" -ForegroundColor Cyan
foreach ($arq in @($formFile, $boFile)) {
    if (-not (Test-Path $arq)) {
        Write-Host "    FALHA - arquivo ausente: $arq" -ForegroundColor Red
        $falhou = $true
        continue
    }
    if (Test-CompletudeCodigo -FilePath $arq -Descricao (Split-Path -Leaf $arq)) {
        Write-Host "    OK   - $(Split-Path -Leaf $arq)" -ForegroundColor Green
    } else {
        Write-Host "    FALHA- $(Split-Path -Leaf $arq)" -ForegroundColor Red
        $falhou = $true
    }
}

# -------------------------------------------------------------------------
# 2. Gate da Fase 6 - replica das expressoes do switch 6 do orquestrador
# -------------------------------------------------------------------------
Write-Host "[2] Gate da Fase 6" -ForegroundColor Cyan
$conteudo   = Get-Content $formFile -Raw
$dumpLegado = Join-Path $TaskPath "$($BaseName)_form_codigo_fonte.txt"
$txtLegado  = Get-Content $dumpLegado -Raw

$padroesLookup = @(
    'fwbusca',
    'mAddColuna',
    'sigacess\s*\(',
    'Acesso(Campos|Contab|Contas|Empresa|Grupos|MovInd|MovMto|Produto|Titulo)\s*\(',
    'FormBuscaAuxiliar'
)
$legadoSemLookup = -not ($padroesLookup | Where-Object { $txtLegado -match $_ })

$temPaginaDados = ($conteudo -match "ConfigurarPaginaDados" -and $conteudo -match "BINDEVENT")
$semPageFrame   = ($conteudo -notmatch 'AddObject\(\s*"pgf_4c_')
$temBindEvent   = ($conteudo -match "BINDEVENT")
$temMetodoLookup = ($conteudo -match "PROCEDURE\s+(AbrirLookup|AbrirBusca)\w*")
$temCamposFlat  = ($conteudo -match "\.ControlSource\s*=") -and ($conteudo -match "PROCEDURE\s+Validar\w+")
$temLayoutFlat  = ($FormType -eq "OPERACIONAL" -and $semPageFrame -and $temBindEvent -and
                   ($temMetodoLookup -or ($legadoSemLookup -and $temCamposFlat)))

$temListaLegadoF6 = ($txtLegado -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                    ($txtLegado -match '(?i)(pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)') -or
                    (Test-LegadoAddCursorLigaGrade -TextoDump $txtLegado)
$temCamposLegadoF6 = ($txtLegado -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
$legadoSemListaNemCamposF6 = (-not $temListaLegadoF6) -and (-not $temCamposLegadoF6)
$legadoSoExibicaoF6 = (-not $temListaLegadoF6) -and (Test-LegadoDialogoExibicao -TextoDump $txtLegado)
$nBotoesLegadoF6 = Get-ContagemBotoesLegado -TextoDump $txtLegado

$rxDefineClasseF6Desp = '(?im)^\s*DEFINE\s+CLASS\s+' + [regex]::Escape($formClass) + '\s+AS\s+FormBase\b'
$rxInstanciaBOF6Desp  = 'CREATEOBJECT\(\s*"' + [regex]::Escape($boClass) + '"'
$temEstruturaSemPageFrameF6 = ($conteudo -notmatch 'AddObject\(\s*"pgf_4c_') -and
                              ($conteudo -match $rxDefineClasseF6Desp) -and
                              ($conteudo -match $rxInstanciaBOF6Desp)

if ($nBotoesLegadoF6 -ge 1) {
    $temSuperficieDespachanteF6 = ($conteudo -match 'AddObject\(\s*"(cmg_4c_|cmd_4c_)') -and
                                  ($conteudo -match 'PROCEDURE\s+(Cmd|Btn)\w*Click')
} else {
    $temSuperficieDespachanteF6 = ($conteudo -match "InicializarForm") -and
                                  (($conteudo -match "ConfigurarPageFrame") -or $temEstruturaSemPageFrameF6)
}

$temSuperficieExibicaoF6 = $temSuperficieDespachanteF6 -and
                           ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(EditBox\w*|TextBox\w*)"')
$temLayoutExibicaoF6 = ($FormType -eq "OPERACIONAL" -and
                        $legadoSoExibicaoF6 -and $legadoSemLookup -and $temSuperficieExibicaoF6)

Write-Host ("    legadoSemLookup ............. {0}" -f $legadoSemLookup)
Write-Host ("    temListaLegadoF6 ............ {0}" -f $temListaLegadoF6)
Write-Host ("    legadoSoExibicaoF6 .......... {0}" -f $legadoSoExibicaoF6)
Write-Host ("    nBotoesLegadoF6 ............. {0}" -f $nBotoesLegadoF6)
Write-Host ("    temSuperficieExibicaoF6 ..... {0}" -f $temSuperficieExibicaoF6)
Write-Host ("    temLayoutExibicaoF6 ......... {0}" -f $temLayoutExibicaoF6)
Write-Host ("    (ramos errados) temPaginaDados={0} temLayoutFlat={1} despachante={2}" -f `
            $temPaginaDados, $temLayoutFlat, $legadoSemListaNemCamposF6)

if ($temLayoutExibicaoF6) {
    Write-Host "    OK   - aprovado pelo ramo EXIBICAO" -ForegroundColor Green
} else {
    Write-Host "    FALHA- nenhum ramo aprova o form" -ForegroundColor Red
    $falhou = $true
}
if ($temPaginaDados -or $temLayoutFlat) {
    Write-Host "    AVISO- ramo PAGINADO/FLAT tambem casou (nao deveria neste form)" -ForegroundColor Yellow
}

if ($falhou) { exit 1 } else { Write-Host "TUDO OK" -ForegroundColor Green; exit 0 }
