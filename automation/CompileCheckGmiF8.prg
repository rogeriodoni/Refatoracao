SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL lcForm, lcFxp, lcErrF, lcBO, lcBOFxp, lcBOErr, lcSaida
lcForm   = "C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.prg"
lcFxp    = "C:\4c\projeto\app\forms\operacionais\formsigprgmi.FXP"
lcErrF   = "C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.err"
lcBO     = "C:\4c\projeto\app\classes\SigPrGmiBO.prg"
lcBOFxp  = "C:\4c\projeto\app\classes\sigprgmibo.FXP"
lcBOErr  = "C:\4c\projeto\app\classes\SigPrGmiBO.err"
IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF
IF FILE(lcErrF)
    DELETE FILE (lcErrF)
ENDIF
IF FILE(lcBOFxp)
    DELETE FILE (lcBOFxp)
ENDIF
IF FILE(lcBOErr)
    DELETE FILE (lcBOErr)
ENDIF
COMPILE (lcForm)
COMPILE (lcBO)
lcSaida = "FORM FXP: " + IIF(FILE(lcFxp), "OK", "AUSENTE") + CHR(13) + CHR(10) + ;
          "FORM ERR: " + IIF(FILE(lcErrF), FILETOSTR(lcErrF), "nenhum") + CHR(13) + CHR(10) + ;
          "BO   FXP: " + IIF(FILE(lcBOFxp), "OK", "AUSENTE") + CHR(13) + CHR(10) + ;
          "BO   ERR: " + IIF(FILE(lcBOErr), FILETOSTR(lcBOErr), "nenhum") + CHR(13) + CHR(10)
STRTOFILE(lcSaida, "C:\4c\automation\compile_gmif8_result.txt")
QUIT
