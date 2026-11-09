SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE
lcOut = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\dumpfrx.txt"
STRTOFILE("", lcOut)
TRY
    USE "C:\4c\refatoracao\projeto\app\reports\SigReCtc.frx" AGAIN SHARED ALIAS frx328
    SCAN FOR INLIST(objtype, 5, 8, 9, 18, 25, 26) AND !EMPTY(expr + supexpr + tag)
        STRTOFILE(TRANSFORM(RECNO()) + " t=" + TRANSFORM(objtype) + " c=" + TRANSFORM(objcode) + ;
            " expr=[" + ALLTRIM(STRTRAN(expr, CHR(13), " ")) + "] supexpr=[" + ALLTRIM(supexpr) + "] tag=[" + LEFT(ALLTRIM(STRTRAN(tag,CHR(13)," ")),300) + "]" + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    USE IN frx328
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message, lcOut, .T.)
ENDTRY
QUIT
