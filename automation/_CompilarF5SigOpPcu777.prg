* _CompilarF5SigOpPcu777.prg - compila Form e BO da task777 (Fase 5)
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cSaida, loc_i, loc_cArq, loc_cFxp, loc_cErr
LOCAL ARRAY loc_aArq[2]
loc_aArq[1] = "C:\4c\projeto\app\forms\operacionais\FormSigOpPcu.prg"
loc_aArq[2] = "C:\4c\projeto\app\classes\SigOpPcuBO.prg"

loc_cSaida = ""
FOR loc_i = 1 TO 2
    loc_cArq = loc_aArq[loc_i]
    loc_cFxp = STRTRAN(loc_cArq, ".prg", ".fxp")
    loc_cErr = STRTRAN(loc_cArq, ".prg", ".err")
    IF FILE(loc_cFxp)
        DELETE FILE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        DELETE FILE (loc_cErr)
    ENDIF
    COMPILE (loc_cArq)
    loc_cSaida = loc_cSaida + JUSTFNAME(loc_cArq) + ;
        " FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + ;
        " ERR=" + IIF(FILE(loc_cErr), "SIM", "NAO") + CHR(13) + CHR(10)
    IF FILE(loc_cErr)
        loc_cSaida = loc_cSaida + FILETOSTR(loc_cErr) + CHR(13) + CHR(10)
    ENDIF
NEXT

STRTOFILE(loc_cSaida, "C:\4c\automation\_CompilarF5SigOpPcu777.txt")
QUIT
