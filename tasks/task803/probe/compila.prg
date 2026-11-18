SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lcF, lcB
lcF = "C:\4c\projeto\app\forms\operacionais\FormSigOpSlc"
lcB = "C:\4c\projeto\app\classes\SigOpSlcBO"
COMPILE (lcF + ".prg")
COMPILE (lcB + ".prg")
lcOut = "FORM_FXP=" + IIF(FILE(lcF + ".fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "FORM_ERR=" + IIF(FILE(lcF + ".err"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(lcF + ".err")
    lcOut = lcOut + "--- FORM ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcF + ".err") + CHR(13) + CHR(10)
ENDIF
lcOut = lcOut + "BO_FXP=" + IIF(FILE(lcB + ".fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
lcOut = lcOut + "BO_ERR=" + IIF(FILE(lcB + ".err"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE(lcB + ".err")
    lcOut = lcOut + "--- BO ERR ---" + CHR(13) + CHR(10) + FILETOSTR(lcB + ".err") + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcOut, "C:\4c\tasks\task803\probe\compila_out.txt")
QUIT
