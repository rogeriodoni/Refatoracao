SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcForm, lcErr, lcSaida

lcForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPPGC.prg"
lcErr  = "C:\4c\tasks\task786\logs\fase5_compile.err"
lcSaida= "C:\4c\tasks\task786\logs\fase5_compile.txt"

IF FILE(STRTRAN(lcForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(lcForm, ".prg", ".fxp"))
ENDIF
IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF

COMPILE (lcForm)

IF FILE(lcErr)
    STRTOFILE("ERROS:" + CHR(13) + CHR(10) + FILETOSTR(lcErr), lcSaida)
ELSE
    STRTOFILE("OK - sem .ERR. FXP=" + IIF(FILE(STRTRAN(lcForm, ".prg", ".fxp")), "gerado", "AUSENTE"), lcSaida)
ENDIF

QUIT
