SET SAFETY OFF
SET RESOURCE OFF
USE "C:\4c\refatoracao\projeto\app\reports\sigrefun.frx" AGAIN SHARED ALIAS frx
LOCAL c
c = ""
SCAN FOR objtype = 8
    c = c + ALLTRIM(expr) + " | pic=" + ALLTRIM(picture) + " | w=" + TRANSFORM(width) + CHR(13)+CHR(10)
ENDSCAN
STRTOFILE(c, "C:\4c\refatoracao\automation\erro360\frx_campos.txt")
QUIT
