SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut
lcOut = ""
USE "C:\4c\projeto\app\reports\SigReEq1.frx" IN 0 ALIAS frx SHARED
SELECT frx
SCAN FOR frx.OBJTYPE > 0 AND frx.VPOS > 0
    lcOut = lcOut + "rec=" + PADL(RECNO(),3) + ;
        " tipo=" + PADL(TRANSFORM(frx.OBJTYPE),2) + ;
        " vpos=" + PADL(INT(frx.VPOS),6) + ;
        " hpos=" + PADL(INT(frx.HPOS),6) + ;
        " w=" + PADL(INT(frx.WIDTH),6) + ;
        " fim=" + PADL(INT(frx.HPOS + frx.WIDTH),6) + ;
        " [" + LEFT(ALLTRIM(frx.EXPR), 30) + "]" + ;
        " P[" + ALLTRIM(frx.PICTURE) + "]" + CHR(13)+CHR(10)
ENDSCAN
USE IN frx
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro345_dump1.txt")
QUIT
