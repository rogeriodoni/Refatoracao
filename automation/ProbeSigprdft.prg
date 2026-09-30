SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprdft.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigprdftBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprdft.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("Formsigprdft")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK" + ;
            " W=" + TRANSFORM(loc_oForm.Width) + ;
            " H=" + TRANSFORM(loc_oForm.Height) + ;
            " Caption=[" + loc_oForm.Caption + "]" + ;
            " BOtype=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
            " CabExiste=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5)) + ;
            " CabVisible=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Visible) + ;
            " TituloCaption=[" + loc_oForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]" + ;
            " TituloVisible=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible)
        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_sigprdft.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_sigprdft.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\probe_sigprdft_result.txt")
QUIT
