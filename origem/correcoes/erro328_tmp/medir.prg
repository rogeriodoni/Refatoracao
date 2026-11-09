SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, lcM, lnN, lnB
lcOut = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\medir.txt"
STRTOFILE("", lcOut)
DIMENSION laM[2]
laM[1] = "999,999,999.99"
laM[2] = "4,298.50"
FOR EACH lcM IN laM
    lnN = TXTWIDTH(lcM, "Verdana", 8, "N") * FONTMETRIC(6, "Verdana", 8, "N")
    lnB = TXTWIDTH(lcM, "Verdana", 8, "B") * FONTMETRIC(6, "Verdana", 8, "B")
    STRTOFILE(PADR("[" + lcM + "]", 18) + " normal=" + TRANSFORM(lnN) + "px (" + TRANSFORM(ROUND(lnN / 96 * 10000, 0)) + ")  negrito=" + TRANSFORM(lnB) + "px (" + TRANSFORM(ROUND(lnB / 96 * 10000, 0)) + ")" + CHR(13) + CHR(10), lcOut, .T.)
ENDFOR
STRTOFILE("largura do campo: 10208 = " + TRANSFORM(ROUND(10208 / 10000 * 96, 1)) + "px" + CHR(13) + CHR(10), lcOut, .T.)
SELECT 0
USE "C:\4c\refatoracao\projeto\app\reports\SigReCtc.frx" AGAIN SHARED ALIAS frxm
SCAN FOR INLIST(RECNO(), 25, 26, 27, 28, 29, 30, 40, 41, 42) OR (objtype = 8 AND vpos >= 0 AND INLIST(UPPER(LEFT(ALLTRIM(expr), 6)), "'SUB-T", "'TOTAL"))
    STRTOFILE("rec=" + PADL(RECNO(), 3) + " t=" + TRANSFORM(objtype) + " vpos=" + TRANSFORM(INT(vpos)) + " hpos=" + TRANSFORM(INT(hpos)) + " fim=" + TRANSFORM(INT(hpos + width)) + " style=" + TRANSFORM(fontstyle) + " [" + LEFT(ALLTRIM(expr), 40) + "]" + CHR(13) + CHR(10), lcOut, .T.)
ENDSCAN
USE IN frxm
QUIT
