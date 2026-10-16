SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lc, i, lcLin
lc = "C:\4c\automation\frxtmp\recipe.txt"
STRTOFILE("", lc)
USE C:\4c\automation\frxtmp\t_qr.frx IN 0 ALIAS qr SHARED
SELECT qr
STRTOFILE("campos: ", lc, 1)
FOR i = 1 TO FCOUNT()
    STRTOFILE(FIELD(i) + ",", lc, 1)
ENDFOR
STRTOFILE(CHR(13) + CHR(10), lc, 1)
SCAN
    lcLin = "REC " + TRANSFORM(RECNO()) + CHR(13) + CHR(10)
    FOR i = 1 TO FCOUNT()
        LOCAL lcV
        lcV = TRANSFORM(EVALUATE("qr." + FIELD(i)))
        IF !EMPTY(lcV)
            lcLin = lcLin + "   " + PADR(FIELD(i), 12) + "= " + ;
                STRTRAN(STRTRAN(lcV, CHR(13), "~"), CHR(10), "") + CHR(13) + CHR(10)
        ENDIF
    ENDFOR
    STRTOFILE(lcLin, lc, 1)
ENDSCAN
USE
QUIT
