SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE
lcOut = "C:\4c\refatoracao\origem\correcoes\erro325_tmp\dumpfrx.txt"
STRTOFILE("", lcOut)
TRY
    USE "C:\4c\refatoracao\projeto\app\reports\SigReCpr.frx" AGAIN SHARED ALIAS frx325
    SCAN FOR INLIST(objtype, 5, 8, 9, 18) AND !EMPTY(expr + supexpr)
        STRTOFILE(TRANSFORM(RECNO()) + " t=" + TRANSFORM(objtype) + " c=" + TRANSFORM(objcode) + ;
            " expr=[" + ALLTRIM(STRTRAN(expr, CHR(13), " ")) + "] supexpr=[" + ALLTRIM(supexpr) + "]" + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    USE IN frx325
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message, lcOut, .T.)
ENDTRY
QUIT
