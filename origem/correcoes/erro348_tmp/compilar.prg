SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lcF, lnI
LOCAL ARRAY laF[2]
laF[1] = "C:\4c\projeto\app\classes\SigReEtlBO.prg"
laF[2] = "C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg"
lcOut = ""
FOR lnI = 1 TO 2
    lcF = laF[lnI]
    IF FILE(FORCEEXT(lcF,"err"))
        DELETE FILE (FORCEEXT(lcF,"err"))
    ENDIF
    COMPILE (lcF)
    lcOut = lcOut + PADR(JUSTFNAME(lcF), 24) + " fxp=" + TRANSFORM(FILE(FORCEEXT(lcF,"fxp"))) + ;
        "  " + IIF(FILE(FORCEEXT(lcF,"err")), "ERROS: " + FILETOSTR(FORCEEXT(lcF,"err")), "sem .err") + CHR(13)+CHR(10)
ENDFOR
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro348_tmp\compilar.txt")
QUIT
