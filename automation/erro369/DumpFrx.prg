SET SAFETY OFF
SET RESOURCE OFF
LOCAL c, i, f
LOCAL ARRAY aF[2]
aF[1] = "SigRehp1"
aF[2] = "SigRehp2"
c = ""
FOR i = 1 TO 2
    USE ("C:\4c\refatoracao\projeto\app\reports\" + aF[i] + ".frx") AGAIN SHARED ALIAS frx
    c = c + "==== " + aF[i] + CHR(13)+CHR(10)
    SCAN FOR INLIST(objtype, 8, 18) AND !EMPTY(expr)
        c = c + TRANSFORM(objtype) + " " + ALLTRIM(STRTRAN(expr, CHR(13), " ")) + " | pic=" + ALLTRIM(picture) + " | prt=" + ALLTRIM(STRTRAN(supexpr,CHR(13)," ")) + CHR(13)+CHR(10)
    ENDSCAN
    USE IN frx
ENDFOR
STRTOFILE(c, "C:\4c\refatoracao\automation\erro369\frx_campos.txt")
QUIT
