SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut
lcOut = ""
USE "C:\4c\projeto\app\reports\SigReEq2.frx" IN 0 ALIAS frx SHARED
SELECT frx
SCAN FOR INLIST(frx.OBJTYPE, 5, 8)
    lcOut = lcOut + "rec=" + PADL(RECNO(),3) + " tipo=" + TRANSFORM(frx.OBJTYPE) + ;
        " hpos=" + PADL(INT(frx.HPOS),6) + " w=" + PADL(INT(frx.WIDTH),6) + ;
        " font=[" + ALLTRIM(frx.FONTFACE) + " " + TRANSFORM(frx.FONTSIZE) + ;
        " st" + TRANSFORM(frx.FONTSTYLE) + "]" + ;
        " EXPR=[" + ALLTRIM(frx.EXPR) + "]" + ;
        " PICT=[" + ALLTRIM(frx.PICTURE) + "]" + CHR(13)+CHR(10)
ENDSCAN
USE IN frx
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro345_dump.txt")
QUIT
