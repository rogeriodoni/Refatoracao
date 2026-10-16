SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lc
lc = "C:\4c\automation\frxtmp\dump3.txt"
STRTOFILE("passo1" + CHR(13) + CHR(10), lc)
USE C:\4c\automation\frxtmp\cmv.dbf IN 0 ALIAS f SHARED
STRTOFILE("passo2 used=" + TRANSFORM(USED("f")) + CHR(13) + CHR(10), lc, 1)
SELECT f
STRTOFILE("passo3 FCOUNT=" + TRANSFORM(FCOUNT()) + " RECCOUNT=" + TRANSFORM(RECCOUNT()) + CHR(13) + CHR(10), lc, 1)
QUIT
