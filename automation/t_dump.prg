SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lc, lcF
lc = "C:\4c\automation\frxtmp\dump_cmv.txt"
STRTOFILE("", lc)
USE C:\4c\projeto\app\reports\SigReCmv.frx IN 0 ALIAS f SHARED
SELECT f
STRTOFILE("RECCOUNT=" + TRANSFORM(RECCOUNT()) + CHR(13) + CHR(10), lc, 1)
SCAN
    STRTOFILE(PADL(TRANSFORM(RECNO()),3) + " t=" + PADL(TRANSFORM(f.objtype),2) + ;
        " c=" + PADL(TRANSFORM(f.objcode),2) + ;
        " vp=" + PADL(TRANSFORM(INT(f.vpos)),7) + " hp=" + PADL(TRANSFORM(INT(f.hpos)),7) + ;
        " h=" + PADL(TRANSFORM(INT(f.height)),6) + " w=" + PADL(TRANSFORM(INT(f.width)),7) + ;
        " ff=" + PADR(ALLTRIM(f.fontface),12) + " fs=" + TRANSFORM(f.fontsize) + ;
        " | " + STRTRAN(STRTRAN(LEFT(f.expr,70), CHR(13), "~"), CHR(10), "") + CHR(13) + CHR(10), lc, 1)
ENDSCAN
USE
QUIT
