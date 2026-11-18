SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cOut, loc_nI, loc_cArq
loc_cOut = ""
DIMENSION loc_aArq[3]
loc_aArq[1] = "C:\4c\projeto\app\classes\SigOpSqnBO.prg"
loc_aArq[2] = "C:\4c\projeto\app\classes\textboxgridlookup.PRG"
loc_aArq[3] = "C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.prg"

FOR loc_nI = 1 TO ALEN(loc_aArq)
    loc_cArq = loc_aArq[loc_nI]
    COMPILE (loc_cArq)
    loc_cOut = loc_cOut + "COMPILE " + JUSTFNAME(loc_cArq) + " -> erros=" + ;
        TRANSFORM(_TALLY) + CHR(13) + CHR(10)
ENDFOR

*-- arquivo de erros que o VFP gera ao lado do .prg
FOR loc_nI = 1 TO ALEN(loc_aArq)
    loc_cArq = FORCEEXT(loc_aArq[loc_nI], "ERR")
    IF FILE(loc_cArq)
        loc_cOut = loc_cOut + "--- " + JUSTFNAME(loc_cArq) + CHR(13) + CHR(10) + ;
            FILETOSTR(loc_cArq) + CHR(13) + CHR(10)
    ELSE
        loc_cOut = loc_cOut + "--- " + JUSTFNAME(loc_cArq) + ": SEM .ERR" + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(loc_cOut, "C:\4c\automation\_compile_sqn_f8.txt")
QUIT
