SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, lnI, laF[3]
lcOut = "C:\4c\refatoracao\origem\correcoes\erro330_tmp\env.txt"
STRTOFILE("", lcOut)
laF[1] = "C:\4c\refatoracao\projeto\app\reports\SigReCtc.frx"
laF[2] = "C:\4c\refatoracao\origem\correcoes\erro330_tmp\calib2.frx"
laF[3] = "C:\4c\refatoracao\projeto\app\reports\SigReCrP.frx"
FOR lnI = 1 TO 3
    SELECT 0
    USE (laF[lnI]) AGAIN SHARED ALIAS fe
    GO TOP
    STRTOFILE("== " + JUSTFNAME(laF[lnI]) + " objtype=" + TRANSFORM(objtype) + " len(tag)=" + TRANSFORM(LEN(tag)) + " len(tag2)=" + TRANSFORM(LEN(tag2)) + CHR(13) + CHR(10) + ;
        "expr=[" + STRTRAN(ALLTRIM(expr), CHR(13), " | ") + "]" + CHR(13) + CHR(10) + ;
        "tag(ini)=[" + CHRTRAN(LEFT(tag, 60), CHR(0), ".") + "]" + CHR(13) + CHR(10), lcOut, .T.)
    USE IN fe
ENDFOR
STRTOFILE("impressora padrao: " + SET("PRINTER", 2) + CHR(13) + CHR(10), lcOut, .T.)
QUIT
