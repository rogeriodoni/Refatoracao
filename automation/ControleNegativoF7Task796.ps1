# ControleNegativoF7Task796.ps1
#
# Controle NEGATIVO do conserto da Fase 7 de FormSigOpRob (task796).
#
# O conserto da Fase 7 foi acrescentar `PROCEDURE QueryUnload()` -> funil +
# NODEFAULT, para que o caminho Alt+F4 nao DESTRUA o dialogo e nao quebre o
# contrato do chamador ("loc_oDlg.Show()" seguido de "loc_oDlg.Release()").
#
# Este script prova que o defeito era REAL na classe de producao, e nao so numa
# maquete: ele gera em tmp uma copia da classe REAL com o QueryUnload REMOVIDO
# (renomeada para FormSigOpRobSemQu, para nao colidir), fecha a tela por
# WM_CLOSE - o mesmo caminho que o Alt+F4 percorre, porque o VFP levanta o
# QueryUnload - e mede o que sobra na variavel do CHAMADOR.
#
# Esperado (defeito reproduzido):
#     DEPOIS ... dlg VARTYPE=X ISNULL=.T.
#     Release() do chamador: ESTOUROU -> LOC_ODLG is not an object.
#
# O par POSITIVO - a mesma medicao na classe de producao, nos TRES caminhos de
# saida (Encerrar, ESC e Alt+F4), todos devolvendo VARTYPE=O e Release OK - esta
# em automation\ProbeF7Task796.prg.
#
# Uso: powershell -ExecutionPolicy Bypass -File automation\ControleNegativoF7Task796.ps1
param(
    [string]$Form   = 'C:\4c\projeto\app\forms\operacionais\FormSigOpRob.prg',
    [string]$TmpDir = 'C:\4c\automation\tmp796\neg',
    [int]   $TimeoutMs = 120000
)

$ErrorActionPreference = 'Stop'
if (-not (Test-Path $TmpDir)) { New-Item -ItemType Directory -Path $TmpDir -Force | Out-Null }

$copia = Join-Path $TmpDir 'FormSigOpRobSemQu.prg'
$texto = Get-Content $Form -Raw

# (1) renomeia a classe e (2) ARRANCA o QueryUnload
$texto = $texto -replace 'DEFINE CLASS FormSigOpRob AS FormBase', 'DEFINE CLASS FormSigOpRobSemQu AS FormBase'
$texto = [regex]::Replace($texto, '\r?\n    PROCEDURE QueryUnload\(\).*?\r?\n    ENDPROC\r?\n', '', 'Singleline')
[IO.File]::WriteAllText($copia, $texto, (New-Object Text.UTF8Encoding $false))   # SEM BOM: BOM no inicio do .prg pendura o vfp9

$sobrou = ([regex]::Matches($texto, 'PROCEDURE\s+QueryUnload')).Count
"QueryUnload na copia = $sobrou (tem de ser 0)"
if ($sobrou -ne 0) { "PREPARO=FALHA (o QueryUnload nao foi removido)"; exit 2 }

$saida = Join-Path $TmpDir 'probe_neg_f7.txt'
$probe = Join-Path $TmpDir 'ProbeNegF7.prg'
@"
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gc_4c_Out
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "$TmpDir\vfp_error_neg.txt"
gc_4c_Out              = "$saida"
LOCAL loc_oErro, loc_oPai, loc_oDlg
STRTOFILE("INICIO (controle NEGATIVO - classe REAL sem QueryUnload)" + CHR(13) + CHR(10), gc_4c_Out)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpRobBO.prg")   ADDITIVE
    SET PROCEDURE TO ("$copia") ADDITIVE

    loc_oPai = CREATEOBJECT("FrmPaiNeg")
    loc_oPai.Enabled = .F.
    DO LogN WITH "ANTES  pai.Enabled=" + TRANSFORM(loc_oPai.Enabled)

    loc_oDlg = CREATEOBJECT("FormSigOpRobSemQu", "Historico", "texto", loc_oPai)
    DO LogN WITH "dlg criado VARTYPE=" + VARTYPE(loc_oDlg)
    IF VARTYPE(loc_oDlg) = "O"
        loc_oDlg.AddObject("tmr_probe", "TmrNeg")
        loc_oDlg.tmr_probe.Enabled = .T.
        loc_oDlg.Show()
        DO LogN WITH "Show() devolveu"
        DO LogN WITH "DEPOIS pai.Enabled=" + TRANSFORM(loc_oPai.Enabled) + ;
            " dlg VARTYPE=" + VARTYPE(loc_oDlg) + " ISNULL=" + TRANSFORM(ISNULL(loc_oDlg))
        TRY
            loc_oDlg.Release()
            DO LogN WITH "Release() do chamador: OK"
        CATCH TO loc_oErro
            DO LogN WITH "Release() do chamador: ESTOUROU -> " + loc_oErro.Message
        ENDTRY
    ENDIF
    DO LogN WITH "FIM"
CATCH TO loc_oErro
    DO LogN WITH "ERRO NAO TRATADO: " + loc_oErro.Message + ;
        " / linha " + TRANSFORM(loc_oErro.LineNo) + " / proc " + loc_oErro.Procedure
ENDTRY
QUIT

PROCEDURE LogN
    LPARAMETERS par_cTexto
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_Out, 1)
ENDPROC

DEFINE CLASS FrmPaiNeg AS Form
    Width = 200
    Height = 100
    WindowType = 0
    Name = "frmpaineg"
ENDDEFINE

DEFINE CLASS TmrNeg AS Timer
    Interval = 1200
    Enabled  = .F.
    PROCEDURE Timer
        THIS.Enabled = .F.
        DECLARE INTEGER SendMessage IN user32 ;
            INTEGER hWnd, INTEGER Msg, INTEGER wParam, INTEGER lParam
        SendMessage(THISFORM.HWnd, 0x0010, 0, 0)
    ENDPROC
ENDDEFINE
"@ | ForEach-Object { [IO.File]::WriteAllText($probe, $_, (New-Object Text.UTF8Encoding $false)) }   # SEM BOM

# .FXP velho roda p-code antigo - apagar as duas grafias e exigir a saida nova
Get-ChildItem $TmpDir -Filter '*.fxp' -Force -ErrorAction SilentlyContinue | Remove-Item -Force
Remove-Item $saida -Force -ErrorAction SilentlyContinue

$vfp = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual FoxPro 9\vfp9.exe'
$p = Start-Process -FilePath $vfp -ArgumentList '-T',$probe -PassThru
$null = $p.WaitForExit($TimeoutMs)
if (-not $p.HasExited) { $p.Kill(); "TIMEOUT" }

if (-not (Test-Path $saida)) { "SAIDA AUSENTE - o probe NAO executou, nada foi provado"; exit 2 }
$log = Get-Content $saida
$log

if (($log -join "`n") -match 'Release\(\) do chamador: ESTOUROU') {
    "VEREDITO=DEFEITO REPRODUZIDO (o QueryUnload da Fase 7 era necessario)"
    exit 0
}
"VEREDITO=NAO REPRODUZIU - rever a premissa do conserto da Fase 7"
exit 1
