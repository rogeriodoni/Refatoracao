SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcF
lcF = "C:\4c\projeto\app\forms\relatorios\FormSigReEqT.prg"
IF FILE(FORCEEXT(lcF,"err"))
    DELETE FILE (FORCEEXT(lcF,"err"))
ENDIF
COMPILE (lcF)
STRTOFILE("fxp=" + TRANSFORM(FILE(FORCEEXT(lcF,"fxp"))) + " err=" + ;
    IIF(FILE(FORCEEXT(lcF,"err")), FILETOSTR(FORCEEXT(lcF,"err")), "nenhum"), ;
    "C:\4c\origem\correcoes\erro344_tmp\compilar.txt")
QUIT
