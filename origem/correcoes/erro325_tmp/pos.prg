SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut
lcOut = "C:\4c\refatoracao\origem\correcoes\erro325_tmp\pos.txt"
STRTOFILE("", lcOut)
USE "C:\4c\refatoracao\projeto\app\reports\SigReCpr.frx" AGAIN SHARED ALIAS frxpos
SCAN FOR INLIST(RECNO(), 21, 22, 23, 24, 25, 27, 28, 29, 31, 32)
    STRTOFILE(TRANSFORM(RECNO()) + " hpos=" + TRANSFORM(INT(hpos)) + " vpos=" + TRANSFORM(INT(vpos)) + " w=" + TRANSFORM(INT(width)) + " [" + ALLTRIM(expr) + "]" + CHR(13) + CHR(10), lcOut, .T.)
ENDSCAN
USE IN frxpos
QUIT
