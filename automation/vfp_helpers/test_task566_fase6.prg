SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_cResultado, loc_oForm, loc_oErro, loc_cDiag
loc_cResultado = ""

CD C:\4c\projeto\app\start
DO config.prg
loc_cDiag = "gcCaminhoForms=" + gcCaminhoForms + CHR(13) + ;
    "FILE(form)=" + TRANSFORM(FILE(gcCaminhoForms + "operacionais\FormSIGMVCTH.prg")) + CHR(13)
ConfigurarAmbiente()
loc_cDiag = loc_cDiag + "Apos ConfigurarAmbiente" + CHR(13)

STRTOFILE(loc_cDiag, "C:\4c\automation\vfp_helpers\test_task566_fase6_diag.txt")

TRY
    loc_oForm = CREATEOBJECT("FormSIGMVCTH", "PROP0001      ", 999)

    IF VARTYPE(loc_oForm) = "O"
        loc_cResultado = loc_cResultado + "OK - form instanciado" + CHR(13)

        IF PEMSTATUS(loc_oForm, "txt_4c_Comprador", 5)
            loc_cResultado = loc_cResultado + "OK - txt_4c_Comprador existe, Enabled=" + TRANSFORM(loc_oForm.txt_4c_Comprador.Enabled) + CHR(13)
        ELSE
            loc_cResultado = loc_cResultado + "FALHA - txt_4c_Comprador NAO existe" + CHR(13)
        ENDIF

        IF PEMSTATUS(loc_oForm, "txt_4c_Aprovador", 5)
            loc_cResultado = loc_cResultado + "OK - txt_4c_Aprovador existe" + CHR(13)
        ELSE
            loc_cResultado = loc_cResultado + "FALHA - txt_4c_Aprovador NAO existe" + CHR(13)
        ENDIF

        IF PEMSTATUS(loc_oForm, "txt_4c_DtAprovs", 5)
            loc_cResultado = loc_cResultado + "OK - txt_4c_DtAprovs existe" + CHR(13)
        ELSE
            loc_cResultado = loc_cResultado + "FALHA - txt_4c_DtAprovs NAO existe" + CHR(13)
        ENDIF

        IF PEMSTATUS(loc_oForm, "obj_4c_GetObsAprovs", 5)
            loc_cResultado = loc_cResultado + "OK - obj_4c_GetObsAprovs existe, Enabled=" + TRANSFORM(loc_oForm.obj_4c_GetObsAprovs.Enabled) + CHR(13)
        ELSE
            loc_cResultado = loc_cResultado + "FALHA - obj_4c_GetObsAprovs NAO existe" + CHR(13)
        ENDIF

        loc_oForm.Release()
    ELSE
        loc_cResultado = loc_cResultado + "FALHA - VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)
    ENDIF
CATCH TO loc_oErro
    loc_cResultado = loc_cResultado + "EXCEPTION: " + loc_oErro.Message + " Linha=" + TRANSFORM(loc_oErro.LineNo) + " Proc=" + loc_oErro.Procedure + CHR(13)
ENDTRY

STRTOFILE(loc_cResultado, "C:\4c\automation\vfp_helpers\test_task566_fase6_result.txt")
QUIT
