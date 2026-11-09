SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE, lcF
lcOut = "C:\4c\refatoracao\origem\correcoes\erro326_tmp\dump2.txt"
STRTOFILE("", lcOut)
LOCAL laN[2], lnI
laN[1] = "SigReDc2"
laN[2] = "SigReIag"
FOR lnI = 1 TO 2
    TRY
        USE ("C:\4c\refatoracao\projeto\app\reports\" + laN[lnI] + ".frx") AGAIN SHARED ALIAS frxd
        STRTOFILE("== " + laN[lnI] + CHR(13) + CHR(10), lcOut, .T.)
        SCAN FOR ATC("thisform", expr + supexpr) > 0 OR (objtype = 9)
            STRTOFILE(TRANSFORM(RECNO()) + " t=" + TRANSFORM(objtype) + " expr=[" + ALLTRIM(STRTRAN(expr, CHR(13), " ")) + "] supexpr=[" + ALLTRIM(supexpr) + "]" + CHR(13) + CHR(10), lcOut, .T.)
        ENDSCAN
        USE IN frxd
    CATCH TO loE
        STRTOFILE("ERRO " + loE.Message + CHR(13) + CHR(10), lcOut, .T.)
    ENDTRY
ENDFOR
QUIT
