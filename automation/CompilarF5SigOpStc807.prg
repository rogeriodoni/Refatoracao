*-- Compilacao da Fase 5 do FormSIGOPSTC (task807)
*-- SET SAFETY/RESOURCE OFF: execucao unattended (regra #6 do CLAUDE.md)
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcForm, lcFxp, lcErr, lcSaida

lcForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPSTC.prg"
lcFxp  = "C:\4c\projeto\app\forms\operacionais\FormSIGOPSTC.fxp"
lcErr  = "C:\4c\projeto\app\forms\operacionais\FormSIGOPSTC.err"

COMPILE (lcForm)

lcSaida = "FORM FXP=" + IIF(FILE(lcFxp), "SIM", "NAO") + ;
          " ERR=" + IIF(FILE(lcErr), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(lcErr)
    lcSaida = lcSaida + FILETOSTR(lcErr) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, "C:\4c\automation\_f5stc_compile.txt")

QUIT
