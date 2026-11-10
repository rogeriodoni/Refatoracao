* ProbeF3SigOpLoc763.prg
* Instancia FormSigOpLoc (Fase 3) em modo de teste e grava o resultado.
* STRTOFILE grava e fecha na hora - sobrevive a morte do processo.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cSaida, loc_oForm, loc_oErro
loc_cSaida = "C:\4c\automation\probe_f3_sigoploc763.txt"
STRTOFILE("INICIO" + CHR(13) + CHR(10), loc_cSaida)

PUBLIC gnConnHandle, gb_4c_ValidandoUI, gb_4c_ModoTeste
PUBLIC gc_4c_CaminhoBase, gc_4c_CaminhoClasses, gc_4c_CaminhoUtils
PUBLIC gc_4c_CaminhoForms, gc_4c_CaminhoIcones, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado

gnConnHandle          = -1
gb_4c_ValidandoUI     = .T.
gb_4c_ModoTeste       = .T.
gc_4c_CaminhoBase     = "C:\4c\projeto\app\start"
gc_4c_CaminhoClasses  = "C:\4c\projeto\app\classes\"
gc_4c_CaminhoUtils    = "C:\4c\projeto\app\utils\"
gc_4c_CaminhoForms    = "C:\4c\projeto\app\forms\"
gc_4c_CaminhoIcones   = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado   = "TESTE"

SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes,C:\4c\projeto\app\forms\operacionais")

TRY
    SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\dataaccess.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\SigOpLocBO.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\forms\operacionais\FormSigOpLoc.prg") ADDITIVE
    STRTOFILE("SET PROCEDURE OK" + CHR(13) + CHR(10), loc_cSaida, 1)
CATCH TO loc_oErro
    STRTOFILE("FALHA SET PROCEDURE: " + loc_oErro.Message + CHR(13) + CHR(10), loc_cSaida, 1)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("FormSigOpLoc")
    STRTOFILE("CREATEOBJECT VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cSaida, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("BaseClass   =[" + loc_oForm.BaseClass + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("Caption     =[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("Width       =[" + TRANSFORM(loc_oForm.Width) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("Height      =[" + TRANSFORM(loc_oForm.Height) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("DataSession =[" + TRANSFORM(loc_oForm.DataSessionId) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("TitleBar    =[" + TRANSFORM(loc_oForm.TitleBar) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("WindowType  =[" + TRANSFORM(loc_oForm.WindowType) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("Picture     =[" + loc_oForm.Picture + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("PictureFILE =[" + TRANSFORM(FILE(loc_oForm.Picture)) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("BO VARTYPE  =[" + VARTYPE(loc_oForm.this_oBusinessObject) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("MsgErro     =[" + loc_oForm.this_cMensagemErro + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        STRTOFILE("ControlCount=[" + TRANSFORM(loc_oForm.ControlCount) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)

        IF PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)
            STRTOFILE("CNT BackColor=[" + TRANSFORM(loc_oForm.cnt_4c_Sombra.BackColor) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
            STRTOFILE("CNT W/H      =[" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Width) + "x" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Height) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
            STRTOFILE("CNT Visible  =[" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Visible) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
            STRTOFILE("LblSombraCap =[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
            STRTOFILE("LblSombraW/H =[" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Width) + "x" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Height) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
            STRTOFILE("LblTituloCap =[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
            STRTOFILE("LblTituloW/H =[" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Width) + "x" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Height) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
            STRTOFILE("LblTituloVis =[" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Visible) + "]" + CHR(13) + CHR(10), loc_cSaida, 1)
        ELSE
            STRTOFILE("ERRO: cnt_4c_Sombra AUSENTE" + CHR(13) + CHR(10), loc_cSaida, 1)
        ENDIF

        loc_oForm.Release()
        loc_oForm = .NULL.
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("FALHA CREATEOBJECT: " + loc_oErro.Message + ;
              " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
              " | Proc: " + loc_oErro.Procedure + CHR(13) + CHR(10), loc_cSaida, 1)
ENDTRY

STRTOFILE("FIM" + CHR(13) + CHR(10), loc_cSaida, 1)
QUIT
