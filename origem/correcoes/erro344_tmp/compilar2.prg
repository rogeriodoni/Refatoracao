SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lcF, lnI, laF[4]
laF[1] = "C:\4c\projeto\app\forms\relatorios\FormSIGREEQR.prg"
laF[2] = "C:\4c\projeto\app\forms\relatorios\FormSigReEqT.prg"
laF[3] = "C:\4c\projeto\app\classes\SIGREEQRBO.prg"
laF[4] = "C:\4c\projeto\app\classes\SigReEqTBO.prg"
lcOut = ""
FOR lnI = 1 TO 4
    lcF = laF[lnI]
    IF FILE(FORCEEXT(lcF,"err"))
        DELETE FILE (FORCEEXT(lcF,"err"))
    ENDIF
    COMPILE (lcF)
    lcOut = lcOut + PADR(JUSTFNAME(lcF),26) + " fxp=" + TRANSFORM(FILE(FORCEEXT(lcF,"fxp"))) + ;
        "  " + IIF(FILE(FORCEEXT(lcF,"err")), "ERROS: " + FILETOSTR(FORCEEXT(lcF,"err")), "sem .err") + CHR(13)+CHR(10)
ENDFOR
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro344_tmp\compilar2.txt")
QUIT
