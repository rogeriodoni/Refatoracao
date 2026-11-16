SET SAFETY OFF
SET RESOURCE OFF
LOCAL c, i
DIMENSION aR[3]
aR[1]="sigrehc1"
aR[2]="SigRehc2"
aR[3]="SigRehc3"
c = ""
FOR i = 1 TO 3
    USE ("C:\4c\refatoracao\projeto\app\reports\" + aR[i] + ".frx") AGAIN SHARED ALIAS frx
    c = c + "===== " + aR[i] + CHR(13)+CHR(10)
    SCAN FOR INLIST(objtype, 8, 18) AND !EMPTY(expr)
        c = c + TRANSFORM(objtype) + " " + ALLTRIM(STRTRAN(STRTRAN(expr, CHR(13), " "), CHR(10), " ")) + " | " + ALLTRIM(picture) + CHR(13)+CHR(10)
    ENDSCAN
    USE IN frx
ENDFOR
STRTOFILE(c, "C:\4c\refatoracao\automation\erro366\frx_campos.txt")
QUIT
