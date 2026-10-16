*==============================================================================
* probe_fase6_sigprimp.prg - Fase 6 de FormSIGPRIMP (task629)
* 1) Recompila Form + BO com o .FXP/.ERR apagados antes (senao o harness roda
*    codigo velho) e grava o conteudo do .ERR se houver.
* 2) Instancia o form em MODO TESTE e exercita a regra de campo que a Fase 6
*    entrega: ValidarArquivoImportacao() (When do btnMovEst) e o efeito dela
*    em cmd_4c_BtnMovEst.Enabled via AtualizarEstadoBotoes().
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_cOut, loc_cForm, loc_cBO, loc_cFxpF, loc_cFxpB, loc_cErrF, loc_cErrB
LOCAL loc_oForm, loc_oErro, loc_cLog, loc_lOk

loc_cOut  = "C:\4c\automation\probe_fase6_sigprimp_result.txt"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGPRIMPBO.prg"
loc_cFxpF = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.fxp"
loc_cFxpB = "C:\4c\projeto\app\classes\SIGPRIMPBO.fxp"
loc_cErrF = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.err"
loc_cErrB = "C:\4c\projeto\app\classes\SIGPRIMPBO.err"
loc_cLog  = "=== PROBE FASE 6 - FormSIGPRIMP ===" + CHR(13) + CHR(10)

IF FILE(loc_cFxpF)
    DELETE FILE (loc_cFxpF)
ENDIF
IF FILE(loc_cFxpB)
    DELETE FILE (loc_cFxpB)
ENDIF
IF FILE(loc_cErrF)
    DELETE FILE (loc_cErrF)
ENDIF
IF FILE(loc_cErrB)
    DELETE FILE (loc_cErrB)
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cLog = loc_cLog + "FXP BO   : " + IIF(FILE(loc_cFxpB), "OK", "AUSENTE") + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "FXP Form : " + IIF(FILE(loc_cFxpF), "OK", "AUSENTE") + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "ERR BO   : " + IIF(FILE(loc_cErrB), FILETOSTR(loc_cErrB), "nenhum") + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "ERR Form : " + IIF(FILE(loc_cErrF), FILETOSTR(loc_cErrF), "nenhum") + CHR(13) + CHR(10)

*-- Ambiente minimo (NAO chamar ConfigurarAmbiente - bloqueia o probe)
PUBLIC gnConnHandle, gc_4c_UsuarioLogado, gc_4c_CaminhoIcones, gc_4c_CaminhoReports
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, go_4c_Sistema
gnConnHandle          = -1
gc_4c_UsuarioLogado   = "TESTE"
gc_4c_CaminhoIcones   = "C:\4c\vbmp\"
gc_4c_CaminhoReports  = "C:\4c\projeto\app\reports\"
gb_4c_ModoTeste       = .T.
gb_4c_ValidandoUI     = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_fase6_sigprimp_dialogs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes,C:\4c\projeto\app\forms\operacionais")
SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\validators.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\gridbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cBO) ADDITIVE
SET PROCEDURE TO (loc_cForm) ADDITIVE

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGPRIMP")
CATCH TO loc_oErro
    loc_cLog = loc_cLog + "EXCECAO  : " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cLog = loc_cLog + "VARTYPE  : " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cLog = loc_cLog + "--- metodos PUBLIC (PEMSTATUS attr 2 = PROTECTED) ---" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "ValidarArquivoImportacao existe=" + ;
        TRANSFORM(PEMSTATUS(loc_oForm, "ValidarArquivoImportacao", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarArquivoImportacao", 2)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "AtualizarEstadoBotoes    existe=" + ;
        TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarEstadoBotoes", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarEstadoBotoes", 2)) + CHR(13) + CHR(10)

    loc_cLog = loc_cLog + "--- campo somente-leitura (When -> .f. do legado) ---" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "txt ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_Arquivo.ReadOnly) + ;
        " TabStop=" + TRANSFORM(loc_oForm.txt_4c_Arquivo.TabStop) + ;
        " Value=[" + TRANSFORM(loc_oForm.txt_4c_Arquivo.Value) + "]" + CHR(13) + CHR(10)

    loc_cLog = loc_cLog + "--- regra do When do btnMovEst ---" + CHR(13) + CHR(10)
    *-- Cenario 1: campo VAZIO (modo teste nao carrega SigCdPam) -> botao OFF
    loc_oForm.AtualizarEstadoBotoes()
    loc_cLog = loc_cLog + "vazio   : Validar=" + TRANSFORM(loc_oForm.ValidarArquivoImportacao()) + ;
        " Enabled=" + TRANSFORM(loc_oForm.cmd_4c_BtnMovEst.Enabled) + CHR(13) + CHR(10)

    *-- Cenario 2: campo PREENCHIDO -> botao ON
    loc_oForm.txt_4c_Arquivo.Value = "C:\4c\tasks\task629\"
    loc_oForm.AtualizarEstadoBotoes()
    loc_cLog = loc_cLog + "cheio   : Validar=" + TRANSFORM(loc_oForm.ValidarArquivoImportacao()) + ;
        " Enabled=" + TRANSFORM(loc_oForm.cmd_4c_BtnMovEst.Enabled) + CHR(13) + CHR(10)

    *-- Cenario 3: so espacos -> EMPTY() -> botao OFF (igual ao Empty() do legado)
    loc_oForm.txt_4c_Arquivo.Value = SPACE(10)
    loc_oForm.AtualizarEstadoBotoes()
    loc_cLog = loc_cLog + "espacos : Validar=" + TRANSFORM(loc_oForm.ValidarArquivoImportacao()) + ;
        " Enabled=" + TRANSFORM(loc_oForm.cmd_4c_BtnMovEst.Enabled) + CHR(13) + CHR(10)

    *-- Cenario 4: Click com campo vazio tem de sair sem processar nada
    loc_oForm.txt_4c_Arquivo.Value = ""
    loc_oForm.AtualizarEstadoBotoes()
    loc_oForm.BtnMovEstClick()
    loc_cLog = loc_cLog + "click vazio: saiu sem erro; Enabled=" + ;
        TRANSFORM(loc_oForm.cmd_4c_BtnMovEst.Enabled) + CHR(13) + CHR(10)

    loc_cLog = loc_cLog + "--- botoes ocultos do legado (Visible .F.) ---" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "Visualizar.Visible=" + TRANSFORM(loc_oForm.cmd_4c_Visualizar.Visible) + ;
        " Imprimir.Visible=" + TRANSFORM(loc_oForm.cmd_4c_Imprimir.Visible) + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cLog = loc_cLog + "--- dialogs suprimidos ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cLog = loc_cLog + "--- dialogs suprimidos: nenhum ---" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cLog, loc_cOut)
QUIT
