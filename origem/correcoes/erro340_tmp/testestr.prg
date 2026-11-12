SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, loE
lcOut = ""
CREATE CURSOR tst (CBars C(14), DPros C(40))
INDEX ON CBars TAG CBars
PRIVATE m
m = 10137122      && como viria do cursor SQL: numeric(14,0)
*-- A: sem STR (como estava o migrado)
TRY
    INSERT INTO tst (CBars, DPros) VALUES (m, "x")
    lcOut = lcOut + "A) INSERT numerico em C(14): OK (gravou [" + tst.CBars + "])" + CHR(13)+CHR(10)
CATCH TO loE
    lcOut = lcOut + "A) INSERT numerico em C(14): ERRO " + TRANSFORM(loE.ErrorNo) + " - " + loE.Message + CHR(13)+CHR(10)
ENDTRY
TRY
    lcOut = lcOut + "B) SEEK numerico na tag char: " + TRANSFORM(SEEK(m, "tst", "CBars")) + CHR(13)+CHR(10)
CATCH TO loE
    lcOut = lcOut + "B) SEEK numerico na tag char: ERRO " + TRANSFORM(loE.ErrorNo) + " - " + loE.Message + CHR(13)+CHR(10)
ENDTRY
*-- C: com STR (como ficou)
TRY
    INSERT INTO tst (CBars, DPros) VALUES (STR(m, 14), "y")
    lcOut = lcOut + "C) INSERT STR(m,14):         OK (gravou [" + tst.CBars + "])" + CHR(13)+CHR(10)
CATCH TO loE
    lcOut = lcOut + "C) INSERT STR(m,14):         ERRO " + TRANSFORM(loE.ErrorNo) + " - " + loE.Message + CHR(13)+CHR(10)
ENDTRY
lcOut = lcOut + "D) SEEK STR(m,14):           " + TRANSFORM(SEEK(STR(m,14), "tst", "CBars")) + CHR(13)+CHR(10)
STRTOFILE(lcOut, "C:\4c\origem\correcoes\erro340_tmp\testestr.txt")
QUIT
