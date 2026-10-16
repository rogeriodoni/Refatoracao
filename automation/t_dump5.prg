SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lc
lc = "C:\4c\automation\frxtmp\dump_cmv.txt"
STRTOFILE("", lc)
USE C:\4c\projeto\app\reports\SigReCmv.frx IN 0 ALIAS frxref SHARED
SELECT frxref
STRTOFILE("RECCOUNT=" + TRANSFORM(RECCOUNT()) + CHR(13) + CHR(10), lc, 1)
SCAN
    STRTOFILE(PADL(TRANSFORM(RECNO()),3) + " t=" + PADL(TRANSFORM(frxref.objtype),2) + ;
        " c=" + PADL(TRANSFORM(frxref.objcode),2) + ;
        " vp=" + PADL(TRANSFORM(INT(frxref.vpos)),6) + " hp=" + PADL(TRANSFORM(INT(frxref.hpos)),6) + ;
        " h=" + PADL(TRANSFORM(INT(frxref.height)),5) + " w=" + PADL(TRANSFORM(INT(frxref.width)),6) + ;
        " " + PADR(ALLTRIM(frxref.fontface),10) + TRANSFORM(frxref.fontsize) + ;
        " |" + STRTRAN(STRTRAN(LEFT(frxref.expr,60), CHR(13), "~"), CHR(10), "") + CHR(13) + CHR(10), lc, 1)
ENDSCAN
USE
QUIT
