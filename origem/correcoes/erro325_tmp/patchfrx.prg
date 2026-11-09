SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE, lnN
lcOut = "C:\4c\refatoracao\origem\correcoes\erro325_tmp\patchfrx.txt"
STRTOFILE("", lcOut)
lnN = 0
TRY
    USE "C:\4c\refatoracao\projeto\app\reports\SigReCpr.frx" EXCLUSIVE ALIAS frx325
    SCAN FOR ATC("thisform.", expr + supexpr) > 0
        REPLACE expr    WITH STRTRAN(expr,    "ThisForm.Titulo", "CsCabecalho.Titulo", -1, -1, 1), ;
                supexpr WITH STRTRAN(supexpr, "ThisForm.Titulo", "CsCabecalho.Titulo", -1, -1, 1)
        lnN = lnN + 1
        STRTOFILE(TRANSFORM(RECNO()) + " expr=[" + ALLTRIM(expr) + "] supexpr=[" + ALLTRIM(supexpr) + "]" + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    USE IN frx325
    STRTOFILE("alterados=" + TRANSFORM(lnN) + CHR(13) + CHR(10), lcOut, .T.)
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message, lcOut, .T.)
ENDTRY
QUIT
