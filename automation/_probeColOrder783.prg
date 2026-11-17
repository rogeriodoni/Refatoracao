SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oGrd, loc_nI, loc_nCol, loc_oForm
LOCAL ARRAY laAlvo[16]
loc_cOut = ""

*-- laAlvo[pos] = numero da Column que deve ficar nessa posicao
laAlvo[1]  = 1
laAlvo[2]  = 3
laAlvo[3]  = 4
laAlvo[4]  = 6
laAlvo[5]  = 15
laAlvo[6]  = 7
laAlvo[7]  = 8
laAlvo[8]  = 9
laAlvo[9]  = 2
laAlvo[10] = 13
laAlvo[11] = 5
laAlvo[12] = 16
laAlvo[13] = 10
laAlvo[14] = 11
laAlvo[15] = 12
laAlvo[16] = 14

TRY
    CREATE CURSOR cur_probe (c1 C(3))
    INSERT INTO cur_probe VALUES ("x")

    loc_oForm = CREATEOBJECT("Form")
    loc_oForm.AddObject("grd1", "Grid")
    loc_oGrd = loc_oForm.grd1
    loc_oGrd.ColumnCount = 16
    FOR loc_nI = 1 TO 16
        STORE "cur_probe.c1" TO ("loc_oGrd.Column" + ALLTRIM(STR(loc_nI)) + ".ControlSource")
        STORE "C" + ALLTRIM(STR(loc_nI)) TO ("loc_oGrd.Column" + ALLTRIM(STR(loc_nI)) + ".Header1.Caption")
    ENDFOR

    FOR loc_nI = 1 TO 16
        loc_nCol = laAlvo[loc_nI]
        STORE loc_nI TO ("loc_oGrd.Column" + ALLTRIM(STR(loc_nCol)) + ".ColumnOrder")
    ENDFOR

    loc_cOut = loc_cOut + "ORDEM FINAL (ColumnN -> ColumnOrder):" + CHR(13) + CHR(10)
    FOR loc_nI = 1 TO 16
        loc_cOut = loc_cOut + "Column" + ALLTRIM(STR(loc_nI)) + " = " + ;
            TRANSFORM(EVALUATE("loc_oGrd.Column" + ALLTRIM(STR(loc_nI)) + ".ColumnOrder")) + CHR(13) + CHR(10)
    ENDFOR
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "ERRO=" + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\_probeColOrder783.txt")
QUIT
