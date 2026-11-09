SET SAFETY OFF
SET RESOURCE OFF
SYS(2335, 0)
LOCAL lcOut
lcOut = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\caixa.txt"
STRTOFILE("", lcOut)
SELECT 0
USE "C:\4c\refatoracao\projeto\app\reports\SigReCtc.frx" AGAIN SHARED ALIAS frxk
SCAN FOR objtype = 7
    STRTOFILE("shape rec=" + PADL(RECNO(), 3) + " vpos=" + TRANSFORM(INT(vpos)) + ".." + TRANSFORM(INT(vpos + height)) + " hpos=" + TRANSFORM(INT(hpos)) + ".." + TRANSFORM(INT(hpos + width)) + CHR(13) + CHR(10), lcOut, .T.)
ENDSCAN
USE IN frxk
QUIT
