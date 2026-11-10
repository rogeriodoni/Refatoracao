SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcRes, i
LOCAL ARRAY laArq[2]
laArq[1] = "C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.prg"
laArq[2] = "C:\4c\projeto\app\menu\menu.prg"
lcRes = ""
FOR i = 1 TO 2
    IF FILE(STRTRAN(laArq[i], ".prg", ".fxp"))
        ERASE (STRTRAN(laArq[i], ".prg", ".fxp"))
    ENDIF
    IF FILE(STRTRAN(laArq[i], ".prg", ".err"))
        ERASE (STRTRAN(laArq[i], ".prg", ".err"))
    ENDIF
    COMPILE (laArq[i])
    lcRes = lcRes + laArq[i] + CHR(13) + CHR(10)
    lcRes = lcRes + "   FXP=" + IIF(FILE(STRTRAN(laArq[i], ".prg", ".fxp")), "SIM", "NAO")
    IF FILE(STRTRAN(laArq[i], ".prg", ".err"))
        lcRes = lcRes + "  ERR:" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(laArq[i], ".prg", ".err"))
    ELSE
        lcRes = lcRes + "  ERR=ausente (limpa)" + CHR(13) + CHR(10)
    ENDIF
ENDFOR
STRTOFILE(lcRes, "C:\4c\tasks\task772\compilar_fase8_final_resultado.txt")
QUIT
