*==============================================================================
* ProbeErro297Font.prg - Mede se mexer na FONTE do Grid reseta Column.Width
* (regra #35c diz que sim; o Formmtz setava FontName DEPOIS das larguras).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_oFrm, loc_oG, loc_nI, loc_cW
loc_cOut = "=== PROBE Erro297 - fonte do Grid x Column.Width ===" + CHR(13) + CHR(10)

CREATE CURSOR cur_t (a C(10), b N(12,2), c N(12,2))
INSERT INTO cur_t VALUES ("x", 1, 2)

loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.AddObject("g", "Grid")
loc_oG = loc_oFrm.g
loc_oG.ColumnCount  = 3
loc_oG.RecordSource = "cur_t"
loc_oG.Column1.ControlSource = "cur_t.a"
loc_oG.Column2.ControlSource = "cur_t.b"
loc_oG.Column3.ControlSource = "cur_t.c"

loc_oG.Column1.Width = 90
loc_oG.Column2.Width = 85
loc_oG.Column3.Width = 0
loc_cOut = loc_cOut + "depois das larguras : " + ;
    TRANSFORM(loc_oG.Column1.Width) + " / " + TRANSFORM(loc_oG.Column2.Width) + ;
    " / " + TRANSFORM(loc_oG.Column3.Width) + CHR(13) + CHR(10)

loc_oG.FontName = "Tahoma"
loc_cOut = loc_cOut + "apos Grid.FontName  : " + ;
    TRANSFORM(loc_oG.Column1.Width) + " / " + TRANSFORM(loc_oG.Column2.Width) + ;
    " / " + TRANSFORM(loc_oG.Column3.Width) + CHR(13) + CHR(10)

loc_oG.FontSize = 8
loc_cOut = loc_cOut + "apos Grid.FontSize  : " + ;
    TRANSFORM(loc_oG.Column1.Width) + " / " + TRANSFORM(loc_oG.Column2.Width) + ;
    " / " + TRANSFORM(loc_oG.Column3.Width) + CHR(13) + CHR(10)

*-- e a ORDEM INVERSA (fonte antes das larguras), que eh o conserto proposto
loc_oG.Column1.Width = 90
loc_oG.Column2.Width = 85
loc_oG.Column3.Width = 0
loc_cOut = loc_cOut + "fonte ANTES, larguras depois: " + ;
    TRANSFORM(loc_oG.Column1.Width) + " / " + TRANSFORM(loc_oG.Column2.Width) + ;
    " / " + TRANSFORM(loc_oG.Column3.Width) + CHR(13) + CHR(10)

*-- PADL com '2000', como o legado faz no getAno.Valid
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "=== PADL(x,4,'2000') ===" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  ''   -> [" + PADL("", 4, "2000") + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  '2'  -> [" + PADL("2", 4, "2000") + "] Val=" + TRANSFORM(VAL(PADL("2",4,"2000"))) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  '26' -> [" + PADL("26", 4, "2000") + "] Val=" + TRANSFORM(VAL(PADL("26",4,"2000"))) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  '026'-> [" + PADL("026", 4, "2000") + "] Val=" + TRANSFORM(VAL(PADL("026",4,"2000"))) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  '2026'->[" + PADL("2026", 4, "2000") + "] Val=" + TRANSFORM(VAL(PADL("2026",4,"2000"))) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  '1999'->[" + PADL("1999", 4, "2000") + "] Val=" + TRANSFORM(VAL(PADL("1999",4,"2000"))) + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\probe_erro297_font.txt")
QUIT
