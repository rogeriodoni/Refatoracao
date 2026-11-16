SET SAFETY OFF
SET RESOURCE OFF
LOCAL c
USE "C:\4c\refatoracao\projeto\app\reports\SigReHev.frx" AGAIN SHARED ALIAS frx
c = ""
SCAN FOR INLIST(objtype, 8, 18) AND !EMPTY(expr)
    c = c + TRANSFORM(objtype) + " " + ALLTRIM(STRTRAN(expr, CHR(13), " ")) + " | pic=" + ALLTRIM(picture) + " | when=" + ALLTRIM(supexpr) + CHR(13)+CHR(10)
ENDSCAN
STRTOFILE(c, "C:\4c\refatoracao\automation\erro367\frx_campos.txt")
QUIT
