SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cFile, loc_cFxp, loc_cResult
loc_cResult = "C:\4c\automation\compile_check_result_sigprgf1_f7.txt"

loc_cFile = "C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.prg"
loc_cFxp  = "C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.fxp"

IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF

TRY
    COMPILE (loc_cFile)
    IF FILE(loc_cFxp)
        STRTOFILE("OK - compilado com sucesso" + CHR(13) + CHR(10), loc_cResult)
    ELSE
        STRTOFILE("FALHA - FXP nao gerado" + CHR(13) + CHR(10), loc_cResult)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("ERRO: " + loc_oErro.Message + " Linha: " + TRANSFORM(loc_oErro.LineNo), loc_cResult)
ENDTRY

QUIT
