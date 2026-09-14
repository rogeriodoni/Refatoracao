#==============================================================================
# TestarTodosFormularios.ps1
#
# PROPOSITO: Testa a instanciação de TODOS os formulários do sistema
#            para verificar se abrem sem erros.
#
# USO:
#   .\TestarTodosFormularios.ps1
#
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-02-05
#==============================================================================

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  TESTAR TODOS OS FORMULARIOS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Limpa FXP primeiro
Write-Host "Limpando arquivos .FXP..." -ForegroundColor Yellow
Get-ChildItem -Path "C:\4c\projeto\app" -Recurse -Filter "*.fxp" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -Path "C:\4c\projeto\app" -Recurse -Filter "*.FXP" -ErrorAction SilentlyContinue | Remove-Item -Force
Write-Host "FXP limpos!" -ForegroundColor Green
Write-Host ""

# Cria script VFP temporário para testar forms
$vfpScript = @'
*-- TestarForms.prg
*-- Testa instanciacao de todos os formularios

SET SAFETY OFF
SET TALK OFF
SET EXCLUSIVE OFF

LOCAL loc_aForms, loc_nI, loc_cForm, loc_oForm, loc_cErro
LOCAL loc_nSucesso, loc_nFalha, loc_aErros
DIMENSION loc_aErros[1]
loc_nSucesso = 0
loc_nFalha = 0

*-- Flag para evitar dialogs de conexao
PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.

*-- Carrega configuracoes
CD C:\4c\projeto\app\start
DO config.prg

*-- Lista de forms para testar
DIMENSION loc_aForms[12]
loc_aForms[1] = "FormCor"
loc_aForms[2] = "FormCargo"
loc_aForms[3] = "FormDepartamento"
loc_aForms[4] = "FormProduto"
loc_aForms[5] = "FormTam"
loc_aForms[6] = "Formacg"
loc_aForms[7] = "Formpgr"
loc_aForms[8] = "FormSrv"
loc_aForms[9] = "Formsigregli"
loc_aForms[10] = "FormBloqueioContas"
loc_aForms[11] = "FormSIGBLCTA"
loc_aForms[12] = "FormProcessamentoBloqueioContas"

*-- Arquivo de resultado
loc_cResultado = "C:\4c\automation\teste_forms_resultado.txt"
SET TEXTMERGE ON
SET TEXTMERGE TO (loc_cResultado) NOSHOW

\=== TESTE DE FORMULARIOS ===
\Data: <<DTOC(DATE())>> <<TIME()>>
\

FOR loc_nI = 1 TO ALEN(loc_aForms)
    loc_cForm = loc_aForms[loc_nI]
    \Testando: <<loc_cForm>>...

    TRY
        loc_oForm = CREATEOBJECT(loc_cForm)

        IF VARTYPE(loc_oForm) = "O" AND !ISNULL(loc_oForm)
            \  -> OK (instanciado com sucesso)
            loc_nSucesso = loc_nSucesso + 1
            loc_oForm.Release()
        ELSE
            \  -> FALHA (objeto nulo)
            loc_nFalha = loc_nFalha + 1
        ENDIF

    CATCH TO loException
        \  -> ERRO: <<loException.Message>>
        \     Linha: <<TRANSFORM(loException.LineNo)>>
        \     Procedure: <<loException.Procedure>>
        loc_nFalha = loc_nFalha + 1

        IF loc_nFalha = 1
            loc_aErros[1] = loc_cForm + ": " + loException.Message
        ELSE
            DIMENSION loc_aErros[loc_nFalha]
            loc_aErros[loc_nFalha] = loc_cForm + ": " + loException.Message
        ENDIF
    ENDTRY
ENDFOR

\
\=== RESUMO ===
\Sucesso: <<TRANSFORM(loc_nSucesso)>>
\Falhas:  <<TRANSFORM(loc_nFalha)>>
\Total:   <<TRANSFORM(ALEN(loc_aForms))>>
\

IF loc_nFalha > 0
    \=== ERROS ENCONTRADOS ===
    FOR loc_nI = 1 TO ALEN(loc_aErros)
        \<<loc_aErros[loc_nI]>>
    ENDFOR
ENDIF

SET TEXTMERGE OFF
SET TEXTMERGE TO

*-- Mostra resultado
? "=== TESTE CONCLUIDO ==="
? "Sucesso: " + TRANSFORM(loc_nSucesso)
? "Falhas:  " + TRANSFORM(loc_nFalha)
? ""
? "Resultado salvo em: " + loc_cResultado

IF loc_nFalha > 0
    ? ""
    ? "=== ERROS ==="
    FOR loc_nI = 1 TO ALEN(loc_aErros)
        ? loc_aErros[loc_nI]
    ENDFOR
ENDIF

RELEASE gb_4c_ValidandoUI
QUIT
'@

$scriptPath = "C:\4c\automation\TestarForms.prg"
$vfpScript | Out-File -FilePath $scriptPath -Encoding ASCII

Write-Host "Executando teste de formularios..." -ForegroundColor Cyan
Write-Host "(Isso pode demorar alguns segundos)" -ForegroundColor Gray
Write-Host ""

# Executa VFP
$vfpExe = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe"
if (Test-Path $vfpExe) {
    $process = Start-Process -FilePath $vfpExe -ArgumentList "-c", "`"$scriptPath`"" -Wait -PassThru -NoNewWindow

    Start-Sleep -Seconds 2

    # Mostra resultado
    $resultFile = "C:\4c\automation\teste_forms_resultado.txt"
    if (Test-Path $resultFile) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "  RESULTADO DO TESTE" -ForegroundColor Cyan
        Write-Host "========================================" -ForegroundColor Cyan
        Get-Content $resultFile | ForEach-Object {
            if ($_ -match "ERRO|FALHA") {
                Write-Host $_ -ForegroundColor Red
            } elseif ($_ -match "OK|Sucesso") {
                Write-Host $_ -ForegroundColor Green
            } else {
                Write-Host $_ -ForegroundColor White
            }
        }
    }
} else {
    Write-Host "ERRO: VFP9.exe nao encontrado em: $vfpExe" -ForegroundColor Red
}

Write-Host ""
Write-Host "Concluido!" -ForegroundColor Green
