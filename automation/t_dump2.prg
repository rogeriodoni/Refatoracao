SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED OFF
LOCAL lc
lc = "C:\4c\automation\frxtmp\dump2.txt"
STRTOFILE("", lc)
TRY
    USE C:\4c\projeto\app\reports\SigReCmv.frx IN 0 ALIAS f SHARED
    STRTOFILE("alias usado=" + TRANSFORM(USED("f")) + CHR(13) + CHR(10), lc, 1)
    SELECT f
    STRTOFILE("ALIAS()=" + ALIAS() + " FCOUNT=" + TRANSFORM(FCOUNT()) + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT()) + " RECSIZE=" + TRANSFORM(RECSIZE()) + CHR(13) + CHR(10), lc, 1)
    LOCAL i
    FOR i = 1 TO FCOUNT()
        STRTOFILE("  campo " + TRANSFORM(i) + "=" + FIELD(i) + CHR(13) + CHR(10), lc, 1)
    ENDFOR
CATCH TO e
    STRTOFILE("ERRO: " + e.Message + CHR(13) + CHR(10), lc, 1)
ENDTRY
QUIT
