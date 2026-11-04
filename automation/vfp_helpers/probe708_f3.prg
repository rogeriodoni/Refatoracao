*-- Probe da Fase 3 do task708 (FormSigOpCot) - compilacao + instanciacao
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcRes, lcOut
lcOut = "C:\4c\automation\vfp_helpers\probe708_f3_resultado.txt"
lcRes = ""

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe708_f3_dialogs.txt"

PUBLIC gnConnHandle
gnConnHandle = 0

*-- config.prg define SO as globais gc_4c_Caminho* e retorna.
*-- ConfigurarAmbiente() NAO eh chamado: ele pendura nesta maquina.
CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE

lcRes = lcRes + "=== COMPILACAO ===" + CHR(13) + CHR(10)

LOCAL lcBO, lcForm
lcBO   = gc_4c_CaminhoClasses + "SigOpCotBO.prg"
lcForm = gc_4c_CaminhoForms + "operacionais\FormSigOpCot.prg"

ERASE (STRTRAN(UPPER(lcBO),   ".PRG", ".FXP"))
ERASE (STRTRAN(UPPER(lcBO),   ".PRG", ".ERR"))
ERASE (STRTRAN(UPPER(lcForm), ".PRG", ".FXP"))
ERASE (STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))

COMPILE (lcBO)
COMPILE (lcForm)

lcRes = lcRes + "BO.FXP   = " + TRANSFORM(FILE(STRTRAN(UPPER(lcBO),   ".PRG", ".FXP"))) + CHR(13) + CHR(10)
lcRes = lcRes + "BO.ERR   = " + TRANSFORM(FILE(STRTRAN(UPPER(lcBO),   ".PRG", ".ERR"))) + CHR(13) + CHR(10)
lcRes = lcRes + "FORM.FXP = " + TRANSFORM(FILE(STRTRAN(UPPER(lcForm), ".PRG", ".FXP"))) + CHR(13) + CHR(10)
lcRes = lcRes + "FORM.ERR = " + TRANSFORM(FILE(STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))) + CHR(13) + CHR(10)

IF FILE(STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))
    lcRes = lcRes + "--- conteudo do FORM.ERR ---" + CHR(13) + CHR(10)
    lcRes = lcRes + FILETOSTR(STRTRAN(UPPER(lcForm), ".PRG", ".ERR")) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcRes, lcOut)

*-- Carrega as classes recem-compiladas
SET PROCEDURE TO (lcBO)   ADDITIVE
SET PROCEDURE TO (lcForm) ADDITIVE

lcRes = lcRes + CHR(13) + CHR(10) + "=== INSTANCIACAO ===" + CHR(13) + CHR(10)
STRTOFILE(lcRes, lcOut)

*-- Form PAI falso: expoe pcEscolha e os dois alias de cursor, como o
*-- ResolverContextoPai espera encontrar num pai real
LOCAL loPai
loPai = CREATEOBJECT("Custom")
loPai.AddProperty("pcEscolha", "ALTERAR")
loPai.AddProperty("this_cCursorCotacao", "TmpCotProbe")
loPai.AddProperty("this_cCursorCabecalho", "TprMvCabProbe")

LOCAL loForm, loErr
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigOpCot", loPai, DATE())
CATCH TO loErr
    lcRes = lcRes + "EXCECAO: " + loErr.Message + " | LN=" + TRANSFORM(loErr.LineNo) + ;
            " | PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

lcRes = lcRes + "VARTYPE(loForm) = [" + VARTYPE(loForm) + "]  (esperado O)" + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcRes = lcRes + CHR(13) + CHR(10) + "--- propriedades do FORM ---" + CHR(13) + CHR(10)
    lcRes = lcRes + "BaseClass    = [" + loForm.BaseClass + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "Caption      = [" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "Width/Height = " + TRANSFORM(loForm.Width) + "/" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    lcRes = lcRes + "WindowType   = " + TRANSFORM(loForm.WindowType) + CHR(13) + CHR(10)
    lcRes = lcRes + "DataSession  = " + TRANSFORM(loForm.DataSession) + CHR(13) + CHR(10)
    lcRes = lcRes + "TitleBar     = " + TRANSFORM(loForm.TitleBar) + CHR(13) + CHR(10)
    lcRes = lcRes + "ControlBox   = " + TRANSFORM(loForm.ControlBox) + CHR(13) + CHR(10)
    lcRes = lcRes + "Closable     = " + TRANSFORM(loForm.Closable) + CHR(13) + CHR(10)
    lcRes = lcRes + "Themes       = " + TRANSFORM(loForm.Themes) + CHR(13) + CHR(10)
    lcRes = lcRes + "ControlCount = " + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10)

    lcRes = lcRes + CHR(13) + CHR(10) + "--- estado recebido do PAI ---" + CHR(13) + CHR(10)
    lcRes = lcRes + "this_cEscolhaPai      = [" + loForm.this_cEscolhaPai + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "this_cCursorCotacao   = [" + loForm.this_cCursorCotacao + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "this_cCursorCabecalho = [" + loForm.this_cCursorCabecalho + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "this_dDatas           = [" + DTOC(loForm.this_dDatas) + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "this_lConfirmado      = " + TRANSFORM(loForm.this_lConfirmado) + CHR(13) + CHR(10)
    lcRes = lcRes + "BO VARTYPE            = [" + VARTYPE(loForm.this_oBusinessObject) + "]" + CHR(13) + CHR(10)

    IF VARTYPE(loForm.this_oBusinessObject) = "O"
        lcRes = lcRes + "BO.this_cEscolhaPai      = [" + loForm.this_oBusinessObject.this_cEscolhaPai + "]" + CHR(13) + CHR(10)
        lcRes = lcRes + "BO.this_cCursorCotacao   = [" + loForm.this_oBusinessObject.this_cCursorCotacao + "]" + CHR(13) + CHR(10)
        lcRes = lcRes + "BO.this_cCursorCabecalho = [" + loForm.this_oBusinessObject.this_cCursorCabecalho + "]" + CHR(13) + CHR(10)
    ENDIF

    lcRes = lcRes + CHR(13) + CHR(10) + "--- cabecalho (cnt_4c_Sombra) ---" + CHR(13) + CHR(10)
    IF PEMSTATUS(loForm, "cnt_4c_Sombra", 5)
        WITH loForm.cnt_4c_Sombra
            lcRes = lcRes + "cnt Top/Left/W/H  = " + TRANSFORM(.Top) + "/" + TRANSFORM(.Left) + ;
                    "/" + TRANSFORM(.Width) + "/" + TRANSFORM(.Height) + CHR(13) + CHR(10)
            lcRes = lcRes + "cnt BackColor     = " + TRANSFORM(.BackColor) + ;
                    "  (RGB(100,100,100)=" + TRANSFORM(RGB(100,100,100)) + ")" + CHR(13) + CHR(10)
            lcRes = lcRes + "cnt BackStyle     = " + TRANSFORM(.BackStyle) + CHR(13) + CHR(10)
            lcRes = lcRes + "cnt Visible       = " + TRANSFORM(.Visible) + CHR(13) + CHR(10)
            lcRes = lcRes + "cnt ControlCount  = " + TRANSFORM(.ControlCount) + CHR(13) + CHR(10)
        ENDWITH

        WITH loForm.cnt_4c_Sombra.lbl_4c_LblSombra
            lcRes = lcRes + "lblSombra Cap/T/L/W/H/Fore/Vis = [" + .Caption + "] " + ;
                    TRANSFORM(.Top) + "/" + TRANSFORM(.Left) + "/" + TRANSFORM(.Width) + ;
                    "/" + TRANSFORM(.Height) + "/" + TRANSFORM(.ForeColor) + "/" + ;
                    TRANSFORM(.Visible) + CHR(13) + CHR(10)
            lcRes = lcRes + "lblSombra AutoSize/WordWrap    = " + TRANSFORM(.AutoSize) + ;
                    "/" + TRANSFORM(.WordWrap) + CHR(13) + CHR(10)
        ENDWITH

        WITH loForm.cnt_4c_Sombra.lbl_4c_LblTitulo
            lcRes = lcRes + "lblTitulo Cap/T/L/W/H/Fore/Vis = [" + .Caption + "] " + ;
                    TRANSFORM(.Top) + "/" + TRANSFORM(.Left) + "/" + TRANSFORM(.Width) + ;
                    "/" + TRANSFORM(.Height) + "/" + TRANSFORM(.ForeColor) + "/" + ;
                    TRANSFORM(.Visible) + CHR(13) + CHR(10)
            lcRes = lcRes + "lblTitulo AutoSize/WordWrap    = " + TRANSFORM(.AutoSize) + ;
                    "/" + TRANSFORM(.WordWrap) + CHR(13) + CHR(10)
        ENDWITH
    ELSE
        lcRes = lcRes + "*** cnt_4c_Sombra AUSENTE ***" + CHR(13) + CHR(10)
    ENDIF

    *-- Regra #51/#3: metodos que o harness chama de fora tem de ser PUBLIC.
    *-- PEMSTATUS(...,2) devolve .T. quando o metodo eh PROTECTED
    lcRes = lcRes + CHR(13) + CHR(10) + "--- visibilidade (PEMSTATUS attr 2 = PROTECTED) ---" + CHR(13) + CHR(10)
    lcRes = lcRes + "ValidarParametros       PROTECTED = " + ;
            TRANSFORM(PEMSTATUS(loForm, "ValidarParametros", 2)) + "  (esperado .F.)" + CHR(13) + CHR(10)
    lcRes = lcRes + "ResolverContextoPai     PROTECTED = " + ;
            TRANSFORM(PEMSTATUS(loForm, "ResolverContextoPai", 2)) + "  (esperado .F.)" + CHR(13) + CHR(10)
    lcRes = lcRes + "TornarControlesVisiveis PROTECTED = " + ;
            TRANSFORM(PEMSTATUS(loForm, "TornarControlesVisiveis", 2)) + "  (esperado .F.)" + CHR(13) + CHR(10)

    *-- Chamadas externas reais dos metodos PUBLIC (o que o harness faz)
    lcRes = lcRes + CHR(13) + CHR(10) + "--- chamada externa dos metodos PUBLIC ---" + CHR(13) + CHR(10)
    LOCAL llVP, llRC, llTV
    llVP = loForm.ValidarParametros()
    llRC = loForm.ResolverContextoPai()
    llTV = loForm.TornarControlesVisiveis()
    lcRes = lcRes + "ValidarParametros()       = " + TRANSFORM(llVP) + CHR(13) + CHR(10)
    lcRes = lcRes + "ResolverContextoPai()     = " + TRANSFORM(llRC) + CHR(13) + CHR(10)
    lcRes = lcRes + "TornarControlesVisiveis() = " + TRANSFORM(llTV) + CHR(13) + CHR(10)

    *-- Regra #11: o cabecalho tem de ser o PRIMEIRO controle do form
    lcRes = lcRes + CHR(13) + CHR(10) + "--- ordem de criacao (regra #11) ---" + CHR(13) + CHR(10)
    lcRes = lcRes + "Controls(1).Name = [" + loForm.Controls(1).Name + "]" + CHR(13) + CHR(10)

    loForm.Release()
    loForm = .NULL.
    lcRes = lcRes + CHR(13) + CHR(10) + "Release OK" + CHR(13) + CHR(10)
ENDIF

lcRes = lcRes + CHR(13) + CHR(10) + "FIM" + CHR(13) + CHR(10)
STRTOFILE(lcRes, lcOut)

QUIT
