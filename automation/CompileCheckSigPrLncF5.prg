SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cMsg
loc_cMsg = "OK"
TRY
    COMPILE "C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.prg"
CATCH TO loc_oErro
    loc_cMsg = "FAIL: " + loc_oErro.Message + " Linha:" + TRANSFORM(loc_oErro.LineNo)
ENDTRY
IF FILE("C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.err")
    loc_cMsg = loc_cMsg + CHR(13) + "ERRFILE:" + CHR(13) + FILETOSTR("C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.err")
ENDIF
loc_cMsg = loc_cMsg + CHR(13) + "FXP:" + IIF(FILE("C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.fxp"), "GERADO", "AUSENTE")
STRTOFILE(loc_cMsg, "C:\4c\automation\compile_sigprlnc_f5.txt")
QUIT
