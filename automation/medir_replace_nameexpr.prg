SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_cCampo
loc_cOut = ""

CREATE CURSOR cur_teste (ContaAnt C(10), ContaNov C(10))
APPEND BLANK

loc_cCampo = "ContaAnt"

*-- Teste 1: REPLACE (nameExpr) WITH
TRY
    REPLACE (loc_cCampo) WITH "AAA"
    loc_cOut = loc_cOut + "T1 REPLACE (expr): OK valor=[" + cur_teste.ContaAnt + "]" + CHR(13) + CHR(10)
CATCH TO loc_oE
    loc_cOut = loc_cOut + "T1 REPLACE (expr): ERRO " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- Teste 2: REPLACE &macro WITH
TRY
    REPLACE &loc_cCampo WITH "BBB"
    loc_cOut = loc_cOut + "T2 REPLACE &macro: OK valor=[" + cur_teste.ContaAnt + "]" + CHR(13) + CHR(10)
CATCH TO loc_oE
    loc_cOut = loc_cOut + "T2 REPLACE &macro: ERRO " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- Teste 3: STORE TO (alias.campo)
TRY
    STORE "CCC" TO ("cur_teste." + loc_cCampo)
    loc_cOut = loc_cOut + "T3 STORE TO (): OK valor=[" + cur_teste.ContaAnt + "]" + CHR(13) + CHR(10)
CATCH TO loc_oE
    loc_cOut = loc_cOut + "T3 STORE TO (): ERRO " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- Teste 4: Column.SetFocus existe?
loc_cOut = loc_cOut + "T4 Grid Column SetFocus: "
LOCAL loc_oF
loc_oF = CREATEOBJECT("Form")
loc_oF.AddObject("g", "Grid")
loc_oF.g.ColumnCount = 2
loc_cOut = loc_cOut + "PEMSTATUS Column1.SetFocus=" + ;
    TRANSFORM(PEMSTATUS(loc_oF.g.Column1, "SetFocus", 5)) + ;
    " Text1=" + TRANSFORM(PEMSTATUS(loc_oF.g.Column1, "Text1", 5)) + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\medir_replace_nameexpr.txt")
QUIT
