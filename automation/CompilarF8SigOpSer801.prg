SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcForm, lcBO

lcLog  = "C:\4c\automation\compila_f8_sigopser801.log"
lcForm = "C:\4c\projeto\app\forms\operacionais\Formsigopser.prg"
lcBO   = "C:\4c\projeto\app\classes\sigopserBO.prg"

IF FILE(STRTRAN(lcForm, ".prg", ".fxp"))
    ERASE (STRTRAN(lcForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(lcBO, ".prg", ".fxp"))
    ERASE (STRTRAN(lcBO, ".prg", ".fxp"))
ENDIF

STRTOFILE("INICIO " + TTOC(DATETIME()) + CHR(13) + CHR(10), lcLog)

COMPILE (lcBO)
STRTOFILE("BO    fxp=" + IIF(FILE(STRTRAN(lcBO, ".prg", ".fxp")), "SIM", "NAO") + ;
          " erros=" + TRANSFORM(_TALLY) + CHR(13) + CHR(10), lcLog, 1)

COMPILE (lcForm)
STRTOFILE("FORM  fxp=" + IIF(FILE(STRTRAN(lcForm, ".prg", ".fxp")), "SIM", "NAO") + CHR(13) + CHR(10), lcLog, 1)

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopser.err")
    STRTOFILE("ERR FORM:" + CHR(13) + CHR(10) + ;
              FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopser.err"), lcLog, 1)
ELSE
    STRTOFILE("ERR FORM: nenhum" + CHR(13) + CHR(10), lcLog, 1)
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigopserBO.err")
    STRTOFILE("ERR BO:" + CHR(13) + CHR(10) + ;
              FILETOSTR("C:\4c\projeto\app\classes\sigopserBO.err"), lcLog, 1)
ELSE
    STRTOFILE("ERR BO: nenhum" + CHR(13) + CHR(10), lcLog, 1)
ENDIF

STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
QUIT
