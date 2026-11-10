SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcRes, lcForm, lcBO, lcMenu
lcForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.prg"
lcBO   = "C:\4c\projeto\app\classes\SIGOPNOPBO.prg"
lcMenu = "C:\4c\projeto\app\menu\menu.prg"

COMPILE (lcForm)
COMPILE (lcBO)
COMPILE (lcMenu)

lcRes = "=== FORM ===" + CHR(13) + CHR(10)
lcRes = lcRes + "FXP=" + IIF(FILE(STRTRAN(lcForm,".prg",".fxp")), "SIM", "NAO") + CHR(13)+CHR(10)
lcRes = lcRes + "ERR=" + IIF(FILE(STRTRAN(lcForm,".prg",".err")), "SIM", "NAO") + CHR(13)+CHR(10)
IF FILE(STRTRAN(lcForm,".prg",".err"))
   lcRes = lcRes + FILETOSTR(STRTRAN(lcForm,".prg",".err")) + CHR(13)+CHR(10)
ENDIF
lcRes = lcRes + "=== BO ===" + CHR(13)+CHR(10)
lcRes = lcRes + "FXP=" + IIF(FILE(STRTRAN(lcBO,".prg",".fxp")), "SIM", "NAO") + CHR(13)+CHR(10)
lcRes = lcRes + "ERR=" + IIF(FILE(STRTRAN(lcBO,".prg",".err")), "SIM", "NAO") + CHR(13)+CHR(10)
IF FILE(STRTRAN(lcBO,".prg",".err"))
   lcRes = lcRes + FILETOSTR(STRTRAN(lcBO,".prg",".err")) + CHR(13)+CHR(10)
ENDIF
lcRes = lcRes + "=== MENU ===" + CHR(13)+CHR(10)
lcRes = lcRes + "FXP=" + IIF(FILE(STRTRAN(lcMenu,".prg",".fxp")), "SIM", "NAO") + CHR(13)+CHR(10)
lcRes = lcRes + "ERR=" + IIF(FILE(STRTRAN(lcMenu,".prg",".err")), "SIM", "NAO") + CHR(13)+CHR(10)
IF FILE(STRTRAN(lcMenu,".prg",".err"))
   lcRes = lcRes + FILETOSTR(STRTRAN(lcMenu,".prg",".err")) + CHR(13)+CHR(10)
ENDIF
STRTOFILE(lcRes, "C:\4c\tasks\task772\compilar_retry8_resultado.txt")
QUIT
