SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_i, loc_cArq, loc_cFxp, loc_cErr
LOCAL ARRAY loc_aArq[6]
loc_aArq[1] = "C:\4c\projeto\app\classes\sigopvciBO.prg"
loc_aArq[2] = "C:\4c\projeto\app\forms\operacionais\Formsigopvci.prg"
loc_aArq[3] = "C:\4c\projeto\app\utils\lemfd.prg"
loc_aArq[4] = "C:\4c\projeto\app\utils\verifporta.prg"
loc_aArq[5] = "C:\4c\projeto\app\utils\rotstatus.prg"
loc_aArq[6] = "C:\4c\projeto\app\utils\fecharporta.prg"

loc_cOut = ""
FOR loc_i = 1 TO 6
    loc_cArq = loc_aArq[loc_i]
    loc_cFxp = STRTRAN(UPPER(loc_cArq), ".PRG", ".FXP")
    loc_cErr = STRTRAN(UPPER(loc_cArq), ".PRG", ".ERR")
    COMPILE (loc_cArq)
    loc_cOut = loc_cOut + JUSTFNAME(loc_cArq) + " FXP=" + TRANSFORM(FILE(loc_cFxp)) + ;
        " ERR=" + TRANSFORM(FILE(loc_cErr)) + CHR(13) + CHR(10)
    IF FILE(loc_cErr)
        loc_cOut = loc_cOut + "---- " + FILETOSTR(loc_cErr) + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(loc_cOut, "C:\4c\automation\_cmp816.txt")
QUIT
