SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_cResultado
loc_cResultado = ""

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.fxp")
    DELETE FILE ("C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.fxp")
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrGl2BO.fxp")
    DELETE FILE ("C:\4c\projeto\app\classes\SigPrGl2BO.fxp")
ENDIF

TRY
    COMPILE "C:\4c\projeto\app\classes\SigPrGl2BO.prg"
    IF FILE("C:\4c\projeto\app\classes\SigPrGl2BO.fxp")
        loc_cResultado = loc_cResultado + "BO_OK" + CHR(13)
    ELSE
        loc_cResultado = loc_cResultado + "BO_FALHOU" + CHR(13)
    ENDIF
CATCH TO loc_oErro
    loc_cResultado = loc_cResultado + "BO_ERRO: " + loc_oErro.Message + CHR(13)
ENDTRY

TRY
    COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg"
    IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.fxp")
        loc_cResultado = loc_cResultado + "FORM_OK" + CHR(13)
    ELSE
        loc_cResultado = loc_cResultado + "FORM_FALHOU" + CHR(13)
    ENDIF
CATCH TO loc_oErro2
    loc_cResultado = loc_cResultado + "FORM_ERRO: " + loc_oErro2.Message + CHR(13)
ENDTRY

STRTOFILE(loc_cResultado, "C:\4c\automation\compilecheck_sigprgl2_result.txt")
QUIT
