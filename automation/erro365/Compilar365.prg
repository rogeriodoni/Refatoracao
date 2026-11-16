SET SAFETY OFF
SET RESOURCE OFF
LOCAL c, i, n
LOCAL ARRAY la[1]
c = ""
FOR EACH f IN ALINES(la, "sigprnfs,sigprnfx,fvalorextenso,fendentrega,fimpresso", ",")
ENDFOR
DIMENSION aF[5]
aF[1]="sigprnfs" 
aF[2]="sigprnfx"
aF[3]="fvalorextenso"
aF[4]="fendentrega"
aF[5]="fimpresso"
FOR i = 1 TO 5
    ERASE ("C:\4c\refatoracao\projeto\app\utils\" + aF[i] + ".err")
    COMPILE ("C:\4c\refatoracao\projeto\app\utils\" + aF[i] + ".prg")
    IF FILE("C:\4c\refatoracao\projeto\app\utils\" + aF[i] + ".err")
        c = c + aF[i] + ": ERRO -> " + FILETOSTR("C:\4c\refatoracao\projeto\app\utils\" + aF[i] + ".err") + CHR(13)+CHR(10)
    ELSE
        c = c + aF[i] + ": ok" + CHR(13)+CHR(10)
    ENDIF
ENDFOR
LOCAL ARRAY laP[1]
n = APRINTERS(laP)
c = c + "impressoras=" + TRANSFORM(n) + CHR(13)+CHR(10)
FOR i = 1 TO n
    c = c + "  [" + laP[i,1] + "]" + CHR(13)+CHR(10)
ENDFOR
STRTOFILE(c, "C:\4c\refatoracao\automation\erro365\compile_out.txt")
QUIT
