SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_cXML, loc_nR
loc_cOut = ""

CREATE CURSOR cOrig (cidchaves C(20), Cods C(2), Descs C(20), Marcas N(1), Codigo C(4))
INSERT INTO cOrig VALUES ("CH1", "01", "NIVEL UM", 1, "0001")
INSERT INTO cOrig VALUES ("CH2", "02", "NIVEL DOIS", 0, "0002")

loc_cXML = CURSORTOXML("cOrig", "loc_cXMLStr", 1, 0, 0, "")
loc_cXML = loc_cXMLStr

*-- flags = 0 sobre cursor JA declarado
CREATE CURSOR cD0 (cidchaves C(20), Cods C(2), Descs C(20), Marcas N(1), Codigo C(4))
SELECT cD0
ZAP
loc_nR = XMLTOCURSOR(loc_cXML, "cD0", 0)
loc_cOut = loc_cOut + "flags=0 ret=" + TRANSFORM(loc_nR) + ;
    " regs=" + TRANSFORM(RECCOUNT("cD0")) + ;
    " TYPE(Marcas)=" + TYPE("cD0.Marcas") + ;
    " TYPE(Cods)=" + TYPE("cD0.Cods") + ;
    " TYPE(Codigo)=" + TYPE("cD0.Codigo") + CHR(13) + CHR(10)
TRY
    SELECT cD0
    COUNT FOR cD0.Marcas <> 0 TO loc_nQ0
    loc_cOut = loc_cOut + "   SCAN FOR Marcas <> 0 -> OK, " + TRANSFORM(loc_nQ0) + " linha(s)" + CHR(13) + CHR(10)
CATCH TO loE
    loc_cOut = loc_cOut + "   Marcas <> 0 -> ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY

*-- flags = 2 (anexar) sobre cursor JA declarado
CREATE CURSOR cD2 (cidchaves C(20), Cods C(2), Descs C(20), Marcas N(1), Codigo C(4))
SELECT cD2
ZAP
loc_nR = XMLTOCURSOR(loc_cXML, "cD2", 2)
loc_cOut = loc_cOut + "flags=2 ret=" + TRANSFORM(loc_nR) + ;
    " regs=" + TRANSFORM(RECCOUNT("cD2")) + ;
    " TYPE(Marcas)=" + TYPE("cD2.Marcas") + ;
    " TYPE(Cods)=" + TYPE("cD2.Cods") + ;
    " TYPE(Codigo)=" + TYPE("cD2.Codigo") + CHR(13) + CHR(10)
TRY
    SELECT cD2
    COUNT FOR cD2.Marcas <> 0 TO loc_nQ2
    loc_cOut = loc_cOut + "   SCAN FOR Marcas <> 0 -> OK, " + TRANSFORM(loc_nQ2) + " linha(s)" + CHR(13) + CHR(10)
CATCH TO loE
    loc_cOut = loc_cOut + "   Marcas <> 0 -> ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY

*-- amostra do XML para ver como o Marcas foi serializado
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- XML (300 primeiros chars) ---" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + LEFT(loc_cXML, 300) + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\medir_xmltocursor_tipos.txt")
QUIT
