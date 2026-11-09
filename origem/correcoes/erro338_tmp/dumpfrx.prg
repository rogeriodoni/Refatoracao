SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE, lcF, i
lcOut = "C:\4c\refatoracao\origem\correcoes\erro338_tmp\dumpfrx.txt"
STRTOFILE("", lcOut)
FOR i = 1 TO 4
  lcF = "C:\4c\refatoracao\projeto\app\reports\SigReDt" + TRANSFORM(i) + ".frx"
  STRTOFILE("===== " + lcF + CHR(13)+CHR(10), lcOut, .T.)
  TRY
    USE (lcF) AGAIN SHARED ALIAS frx338
    SCAN FOR INLIST(objtype, 1, 5, 8, 9, 18, 25, 26) AND !EMPTY(expr + supexpr + tag)
        STRTOFILE(TRANSFORM(RECNO()) + " t=" + TRANSFORM(objtype) + " c=" + TRANSFORM(objcode) + ;
            " expr=[" + ALLTRIM(STRTRAN(expr, CHR(13), " ")) + "] supexpr=[" + ALLTRIM(supexpr) + "] tag=[" + LEFT(ALLTRIM(STRTRAN(tag,CHR(13)," ")),200) + "]" + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    USE IN frx338
  CATCH TO loE
    STRTOFILE("ERRO " + loE.Message + CHR(13)+CHR(10), lcOut, .T.)
  ENDTRY
ENDFOR
QUIT
