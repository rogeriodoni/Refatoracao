SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_nI, loc_cPrg, loc_cFxp, loc_cErr
LOCAL ARRAY loc_aArq[2]
loc_aArq[1] = "C:\4c\projeto\app\classes\SigOpRefBO.prg"
loc_aArq[2] = "C:\4c\projeto\app\forms\operacionais\FormSigOpRef.prg"

loc_cOut = "COMPILE REPORT task794 Fase8" + CHR(13) + CHR(10)

FOR loc_nI = 1 TO 2
    loc_cPrg = loc_aArq[loc_nI]
    loc_cFxp = STRTRAN(loc_cPrg, ".prg", ".fxp")
    loc_cErr = STRTRAN(loc_cPrg, ".prg", ".err")

    COMPILE (loc_cPrg)

    loc_cOut = loc_cOut + "---- " + loc_cPrg + CHR(13) + CHR(10) + ;
               "  FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + ;
               "  ERR=" + IIF(FILE(loc_cErr), "SIM", "NAO") + CHR(13) + CHR(10)

    IF FILE(loc_cErr)
        loc_cOut = loc_cOut + FILETOSTR(loc_cErr) + CHR(13) + CHR(10)
    ENDIF
ENDFOR

=STRTOFILE(loc_cOut, "C:\4c\automation\_compila794f8.txt")
QUIT
