SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lcP, lnI
lcOut = ""
DIMENSION laF[2]
laF[1] = "C:/Users/roger/AppData/Local/Temp/claude/C--4c/5c3d6e1b-73f7-4c38-8cb7-934e8d60a318/scratchpad/chk307\OpsBO.prg"
laF[2] = "C:/Users/roger/AppData/Local/Temp/claude/C--4c/5c3d6e1b-73f7-4c38-8cb7-934e8d60a318/scratchpad/chk307\FormOps.prg"
FOR lnI = 1 TO 2
    lcP = laF[lnI]
    IF FILE(STRTRAN(LOWER(lcP), ".prg", ".fxp"))
        DELETE FILE (STRTRAN(LOWER(lcP), ".prg", ".fxp"))
    ENDIF
    IF FILE(STRTRAN(LOWER(lcP), ".prg", ".err"))
        DELETE FILE (STRTRAN(LOWER(lcP), ".prg", ".err"))
    ENDIF
    COMPILE (lcP)
    lcOut = lcOut + JUSTFNAME(lcP) + " -> fxp=" + ;
        TRANSFORM(FILE(STRTRAN(LOWER(lcP), ".prg", ".fxp")))
    IF FILE(STRTRAN(LOWER(lcP), ".prg", ".err"))
        lcOut = lcOut + "  ERROS:" + CHR(13) + CHR(10) + ;
            FILETOSTR(STRTRAN(LOWER(lcP), ".prg", ".err"))
    ELSE
        lcOut = lcOut + "  (sem .err)"
    ENDIF
    lcOut = lcOut + CHR(13) + CHR(10)
ENDFOR
STRTOFILE(lcOut, "C:\4c\automation\compchk307.txt")
QUIT
