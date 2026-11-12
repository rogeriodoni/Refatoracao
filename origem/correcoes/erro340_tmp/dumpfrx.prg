SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, lnI
lcOut = ""
USE "C:\4c\projeto\app\reports\SigReEqe.frx" IN 0 ALIAS frx SHARED
SELECT frx
SCAN
    IF INLIST(frx.OBJTYPE, 5, 8)   && 5=field, 8=label
        lcOut = lcOut + "rec=" + PADL(RECNO(), 3) + ;
            " tipo=" + TRANSFORM(frx.OBJTYPE) + "/" + TRANSFORM(frx.OBJCODE) + ;
            " vpos=" + PADL(frx.VPOS, 6) + " hpos=" + PADL(frx.HPOS, 6) + ;
            " w=" + PADL(frx.WIDTH, 6) + ;
            " EXPR=[" + ALLTRIM(frx.EXPR) + "]" + ;
            " SUPEXPR=[" + ALLTRIM(frx.SUPEXPR) + "]" + ;
            " PICT=[" + ALLTRIM(frx.PICTURE) + "]" + CHR(13) + CHR(10)
    ENDIF
ENDSCAN
USE IN frx
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro340_tmp\dumpfrx.txt")
QUIT
