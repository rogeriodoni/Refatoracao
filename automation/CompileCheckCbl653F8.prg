SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL lcSaida, lcF, lcX, lcE, i
LOCAL ARRAY laArq[3]
laArq[1] = "C:\4c\projeto\app\forms\operacionais\FormSigOpCbl"
laArq[2] = "C:\4c\projeto\app\classes\SigOpCblBO"
laArq[3] = "C:\4c\projeto\app\utils\functions"
lcSaida = ""
FOR i = 1 TO 3
    lcF = laArq[i] + ".prg"
    lcX = laArq[i] + ".FXP"
    lcE = laArq[i] + ".err"
    IF FILE(lcX)
        DELETE FILE (lcX)
    ENDIF
    IF FILE(lcE)
        DELETE FILE (lcE)
    ENDIF
    COMPILE (lcF)
    lcSaida = lcSaida + JUSTFNAME(lcF) + " -> FXP: " + IIF(FILE(lcX), "OK", "AUSENTE") + ;
        " | ERR: " + IIF(FILE(lcE), CHR(13)+CHR(10)+FILETOSTR(lcE), "nenhum") + CHR(13) + CHR(10)
ENDFOR
STRTOFILE(lcSaida, "C:\4c\automation\compile_cbl653f8.txt")
QUIT
