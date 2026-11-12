SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcF
lcF = "C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg"
IF FILE(FORCEEXT(lcF,"err"))
    DELETE FILE (FORCEEXT(lcF,"err"))
ENDIF
COMPILE (lcF)
STRTOFILE("fxp=" + TRANSFORM(FILE(FORCEEXT(lcF,"fxp"))) + "  " + ;
    IIF(FILE(FORCEEXT(lcF,"err")), "ERROS:" + CHR(13)+CHR(10) + FILETOSTR(FORCEEXT(lcF,"err")), "sem .err"), ;
    "C:\4c\origem\correcoes\erro346_tmp\compilar.txt")
QUIT
