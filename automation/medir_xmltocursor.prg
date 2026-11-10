SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_cXML, loc_nR
loc_cOut = ""

*-- Cursor de origem com a MESMA estrutura que o legado declara em CrAux
CREATE CURSOR cOrig (cidchaves C(20), Cods C(2), Descs C(20), Marcas N(1), Codigo C(4))
INSERT INTO cOrig VALUES ("CH1", "01", "NIVEL UM", 1, "0001")
INSERT INTO cOrig VALUES ("CH2", "02", "NIVEL DOIS", 0, "0002")

loc_cXML = CURSORTOXML("cOrig", "loc_cXMLStr", 1, 0, 0, "")
loc_cXML = loc_cXMLStr
loc_cOut = loc_cOut + "XML len=" + TRANSFORM(LEN(loc_cXML)) + CHR(13) + CHR(10)

*-- CASO A: cursor destino JA EXISTE com estrutura, flags = 0
CREATE CURSOR cDest0 (cidchaves C(20), Cods C(2), Descs C(20), Marcas N(1), Codigo C(4))
SELECT cDest0
ZAP
TRY
    loc_nR = XMLTOCURSOR(loc_cXML, "cDest0", 0)
    loc_cOut = loc_cOut + "flags=0  ret=" + TRANSFORM(loc_nR) + ;
        " reccount=" + TRANSFORM(RECCOUNT("cDest0")) + ;
        " fcount=" + TRANSFORM(FCOUNT("cDest0")) + ;
        " temMarcas=" + TRANSFORM(TYPE("cDest0.Marcas") != "U") + ;
        " temCodigo=" + TRANSFORM(TYPE("cDest0.Codigo") != "U") + CHR(13) + CHR(10)
CATCH TO loE
    loc_cOut = loc_cOut + "flags=0  ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY

*-- CASO B: cursor destino JA EXISTE com estrutura, flags = 2 (append)
CREATE CURSOR cDest2 (cidchaves C(20), Cods C(2), Descs C(20), Marcas N(1), Codigo C(4))
SELECT cDest2
ZAP
TRY
    loc_nR = XMLTOCURSOR(loc_cXML, "cDest2", 2)
    loc_cOut = loc_cOut + "flags=2  ret=" + TRANSFORM(loc_nR) + ;
        " reccount=" + TRANSFORM(RECCOUNT("cDest2")) + ;
        " fcount=" + TRANSFORM(FCOUNT("cDest2")) + ;
        " temMarcas=" + TRANSFORM(TYPE("cDest2.Marcas") != "U") + ;
        " temCodigo=" + TRANSFORM(TYPE("cDest2.Codigo") != "U") + CHR(13) + CHR(10)
CATCH TO loE
    loc_cOut = loc_cOut + "flags=2  ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY

*-- CASO C: cursor destino NAO existe, flags = 0
IF USED("cDestNovo")
    USE IN cDestNovo
ENDIF
TRY
    loc_nR = XMLTOCURSOR(loc_cXML, "cDestNovo", 0)
    loc_cOut = loc_cOut + "novo/flags=0 ret=" + TRANSFORM(loc_nR) + ;
        " reccount=" + TRANSFORM(RECCOUNT("cDestNovo")) + ;
        " fcount=" + TRANSFORM(FCOUNT("cDestNovo")) + ;
        " temMarcas=" + TRANSFORM(TYPE("cDestNovo.Marcas") != "U") + CHR(13) + CHR(10)
CATCH TO loE
    loc_cOut = loc_cOut + "novo/flags=0 ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\medir_xmltocursor.txt")
QUIT
