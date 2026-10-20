*-- Compile check: FormSIGPRPRO + SIGPRPROBO (Fase 5 task668)
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL lcForm, lcBO, lcErr, lcSaida

lcForm = "C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.prg"
lcBO   = "C:\4c\projeto\app\classes\SIGPRPROBO.prg"
lcErr  = "C:\4c\automation\compile_check_sigprpro_f5.txt"
lcSaida = ""

*-- Apagar FXP/ERR velhos (FXP antigo faz o teste rodar codigo antigo)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.ERR")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.ERR"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGPRPROBO.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\SIGPRPROBO.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGPRPROBO.ERR")
    DELETE FILE "C:\4c\projeto\app\classes\SIGPRPROBO.ERR"
ENDIF

COMPILE (lcBO)
COMPILE (lcForm)

lcSaida = lcSaida + "=== FormSIGPRPRO ===" + CHR(13) + CHR(10)
lcSaida = lcSaida + "FXP gerado: " + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.FXP"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.ERR")
    lcSaida = lcSaida + "ERROS:" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.ERR") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "ERR: nenhum" + CHR(13) + CHR(10)
ENDIF

lcSaida = lcSaida + "=== SIGPRPROBO ===" + CHR(13) + CHR(10)
lcSaida = lcSaida + "FXP gerado: " + IIF(FILE("C:\4c\projeto\app\classes\SIGPRPROBO.FXP"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\classes\SIGPRPROBO.ERR")
    lcSaida = lcSaida + "ERROS:" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SIGPRPROBO.ERR") + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "ERR: nenhum" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, lcErr)
QUIT
