SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loE, lnN
lcOut = "C:\4c\refatoracao\origem\correcoes\erro326_tmp\patch2.txt"
STRTOFILE("", lcOut)
TRY
    SELECT 0
    USE "C:\4c\refatoracao\projeto\app\reports\SigReDc2.frx" EXCLUSIVE ALIAS frxa
    lnN = 0
    SCAN FOR ATC("thisform.", expr + supexpr) > 0
        REPLACE expr    WITH STRTRAN(expr,    "ThisForm.ImpTodaspaginas", "pn_4c_ImpTodasPaginas", -1, -1, 1), ;
                supexpr WITH STRTRAN(supexpr, "ThisForm.ImpTodaspaginas", "pn_4c_ImpTodasPaginas", -1, -1, 1)
        lnN = lnN + 1
    ENDSCAN
    COUNT FOR ATC("thisform", expr + supexpr) > 0 TO lnSobra
    STRTOFILE("SigReDc2 alterados=" + TRANSFORM(lnN) + " restantes=" + TRANSFORM(lnSobra) + CHR(13) + CHR(10), lcOut, .T.)
    USE IN frxa

    SELECT 0
    USE "C:\4c\refatoracao\projeto\app\reports\SigReIag.frx" EXCLUSIVE ALIAS frxb
    lnN = 0
    SCAN FOR ATC("thisform.", expr + supexpr) > 0
        REPLACE expr    WITH STRTRAN(expr,    "ThisForm.ContaTran", "pc_4c_ContaTran", -1, -1, 1), ;
                supexpr WITH STRTRAN(supexpr, "ThisForm.ContaTran", "pc_4c_ContaTran", -1, -1, 1)
        lnN = lnN + 1
        STRTOFILE("  " + TRANSFORM(RECNO()) + " supexpr=[" + ALLTRIM(supexpr) + "]" + CHR(13) + CHR(10), lcOut, .T.)
    ENDSCAN
    COUNT FOR ATC("thisform", expr + supexpr) > 0 TO lnSobra
    STRTOFILE("SigReIag alterados=" + TRANSFORM(lnN) + " restantes=" + TRANSFORM(lnSobra) + CHR(13) + CHR(10), lcOut, .T.)
    USE IN frxb
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message, lcOut, .T.)
ENDTRY
QUIT
