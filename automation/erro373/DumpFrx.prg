SET SAFETY OFF
SET RESOURCE OFF
LOCAL c
c = ""
USE ("C:\4c\refatoracao\projeto\app\reports\SigReIdc.frx") AGAIN SHARED ALIAS frx
SCAN FOR INLIST(objtype, 8, 18, 9, 17) 
    c = c + TRANSFORM(objtype) + "/" + TRANSFORM(objcode) + " " + ALLTRIM(STRTRAN(expr, CHR(13), " ")) + " | name=" + ALLTRIM(name) + " | tot=" + TRANSFORM(totaltype) + " reset=" + TRANSFORM(resettotal) + " | prt=" + ALLTRIM(STRTRAN(supexpr,CHR(13)," ")) + " | T=" + TRANSFORM(vpos) + CHR(13)+CHR(10)
ENDSCAN
USE IN frx
STRTOFILE(c, "C:\4c\refatoracao\automation\erro373\frx_campos.txt")
QUIT
