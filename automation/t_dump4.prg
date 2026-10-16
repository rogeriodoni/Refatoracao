SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcErr
gcErr = ""
ON ERROR gcErr = gcErr + "[" + MESSAGE() + " @linha " + TRANSFORM(LINENO()) + "] "
LOCAL lc
lc = "C:\4c\automation\frxtmp\dump4.txt"
STRTOFILE("FILE(dbf)=" + TRANSFORM(FILE("C:\4c\automation\frxtmp\cmv.dbf")) + ;
    " FILE(fpt)=" + TRANSFORM(FILE("C:\4c\automation\frxtmp\cmv.fpt")) + CHR(13) + CHR(10), lc)
USE C:\4c\automation\frxtmp\cmv.dbf IN 0 ALIAS f SHARED
STRTOFILE("apos USE dbf: used=" + TRANSFORM(USED("f")) + " err=" + gcErr + CHR(13) + CHR(10), lc, 1)
gcErr = ""
USE C:\4c\projeto\app\reports\SigReCmv.frx IN 0 ALIAS g SHARED
STRTOFILE("apos USE frx: used=" + TRANSFORM(USED("g")) + " err=" + gcErr + CHR(13) + CHR(10), lc, 1)
IF USED("g")
    SELECT g
    STRTOFILE("  RECCOUNT=" + TRANSFORM(RECCOUNT()) + " FCOUNT=" + TRANSFORM(FCOUNT()) + CHR(13) + CHR(10), lc, 1)
ENDIF
ON ERROR
QUIT
