SET SAFETY OFF
SET RESOURCE OFF

#DEFINE OUTFILE "C:\4c\_tmp_probe_out.txt"

STRTOFILE("[1] inicio" + CHR(13) + CHR(10), OUTFILE)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\_tmp_probe_err.txt"

DO (ADDBS("C:\4c\projeto\app\start") + "config.prg")
STRTOFILE("[2] config.prg ok" + CHR(13) + CHR(10), OUTFILE, 1)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigoppeiBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigoppei.prg") ADDITIVE
STRTOFILE("[3] SET PROCEDURE ok" + CHR(13) + CHR(10), OUTFILE, 1)

LOCAL loc_oForm, loc_oErro, loc_cMsg
loc_cMsg = ""

TRY
    loc_oForm = CREATEOBJECT("Formsigoppei")
    STRTOFILE("[4] CREATEOBJECT retornou VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUTFILE, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_cMsg = loc_cMsg + "INSTANCIOU = SIM" + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "Caption    = [" + loc_oForm.Caption + "]" + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "Width      = " + TRANSFORM(loc_oForm.Width) + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "Height     = " + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "WindowType = " + TRANSFORM(loc_oForm.WindowType) + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "TitleBar   = " + TRANSFORM(loc_oForm.TitleBar) + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "BO VARTYPE = " + VARTYPE(loc_oForm.this_oBusinessObject) + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "ControlCount = " + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10)

        *-- cabecalho
        IF PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)
            loc_cMsg = loc_cMsg + "cnt_4c_Sombra: Top=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Top) + ;
                " Left=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Left) + ;
                " W=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Width) + ;
                " H=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Height) + ;
                " BackStyle=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.BackStyle) + ;
                " Visible=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Visible) + CHR(13) + CHR(10)
            loc_cMsg = loc_cMsg + "  lbl_4c_LblSombra: Top=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Top) + ;
                " W=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Width) + ;
                " H=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Height) + ;
                " Vis=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Visible) + ;
                " Cap=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "]" + CHR(13) + CHR(10)
            loc_cMsg = loc_cMsg + "  lbl_4c_LblTitulo: Top=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Top) + ;
                " W=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Width) + ;
                " H=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Height) + ;
                " Vis=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Visible) + ;
                " Cap=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cMsg = loc_cMsg + "cnt_4c_Sombra AUSENTE" + CHR(13) + CHR(10)
        ENDIF

        loc_oForm.Release()
        loc_cMsg = loc_cMsg + "RELEASE = OK" + CHR(13) + CHR(10)
    ELSE
        loc_cMsg = loc_cMsg + "INSTANCIOU = NAO (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cMsg = loc_cMsg + "EXCECAO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cMsg = loc_cMsg + "--- arquivo de erro do FormBase ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cMsg = loc_cMsg + "arquivo de erro do FormBase: AUSENTE (bom sinal)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cMsg, OUTFILE, 1)
STRTOFILE("[5] fim" + CHR(13) + CHR(10), OUTFILE, 1)
QUIT
