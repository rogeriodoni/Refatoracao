SET SAFETY OFF
SET RESOURCE OFF
LOCAL c
c = ""
SET POINT TO ","
SET SEPARATOR TO "."
c = c + "POINT , : [" + TRANSFORM(152.40, "@Z 99,999.999") + "] [" + TRANSFORM(301.15, "@Z 99,999.999") + "]" + CHR(13)+CHR(10)
SET POINT TO "."
SET SEPARATOR TO ","
c = c + "POINT . : [" + TRANSFORM(152.40, "@Z 99,999.999") + "] [" + TRANSFORM(301.15, "@Z 99,999.999") + "]" + CHR(13)+CHR(10)
COMPILE "C:\4c\refatoracao\projeto\app\classes\SIGREFUNBO.prg"
c = c + "compile ok=" + TRANSFORM(FILE("C:\4c\refatoracao\projeto\app\classes\SIGREFUNBO.err")) + CHR(13)+CHR(10)
STRTOFILE(c, "C:\4c\refatoracao\automation\erro360\locale_out.txt")
QUIT
