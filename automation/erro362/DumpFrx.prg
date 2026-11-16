SET SAFETY OFF
SET RESOURCE OFF
USE "C:\4c\refatoracao\projeto\app\reports\SigReFxv.frx" AGAIN SHARED ALIAS frx
LOCAL c
c = ""
SCAN FOR INLIST(objtype, 8, 18) AND !EMPTY(expr)
    c = c + TRANSFORM(objtype) + " " + ALLTRIM(STRTRAN(expr, CHR(13), " ")) + " | " + ALLTRIM(picture) + CHR(13)+CHR(10)
ENDSCAN
STRTOFILE(c, "C:\4c\refatoracao\automation\erro362\frx_campos.txt")
QUIT
