SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_nI, loc_cPrg, loc_cFxp, loc_cErr
LOCAL ARRAY loc_aArq[4]
loc_aArq[1] = "C:\4c\projeto\app\classes\SigOpPdtBO.prg"
loc_aArq[2] = "C:\4c\projeto\app\forms\operacionais\FormSigOpPdt.prg"
loc_aArq[3] = "C:\4c\projeto\app\classes\dmoBO.prg"
loc_aArq[4] = "C:\4c\projeto\app\forms\operacionais\Formdmo.prg"

loc_cOut = "COMPILE REPORT" + CHR(13) + CHR(10)

FOR loc_nI = 1 TO 4
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

=STRTOFILE(loc_cOut, "C:\4c\automation\_compila784f8_final.txt")
QUIT
