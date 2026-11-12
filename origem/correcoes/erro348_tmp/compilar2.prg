SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcF
lcF = "C:\4c\projeto\app\classes\SigReEtlBO.prg"
IF FILE(FORCEEXT(lcF,"err"))
    DELETE FILE (FORCEEXT(lcF,"err"))
ENDIF
COMPILE (lcF)
STRTOFILE("fxp=" + TRANSFORM(FILE(FORCEEXT(lcF,"fxp"))) + "  " + ;
    IIF(FILE(FORCEEXT(lcF,"err")), "ERROS: " + FILETOSTR(FORCEEXT(lcF,"err")), "sem .err"), ;
    "C:\4c\origem\correcoes\erro348_tmp\compilar2.txt")
QUIT
