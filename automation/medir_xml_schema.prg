SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_cXmlSem, loc_cXmlCom, loc_nR
loc_cOut = ""

CREATE CURSOR cOrig (cidchaves C(20), Cods C(2), Descs C(20), Marcas N(1), Codigo C(4))
INSERT INTO cOrig VALUES ("CH1", "01", "NIVEL UM", 1, "0001")
INSERT INTO cOrig VALUES ("CH2", "02", "NIVEL DOIS", 0, "0002")

*-- SEM schema (como no teste anterior)
= CURSORTOXML("cOrig", "loc_cXmlSem", 1, 0, 0, "")

*-- COM schema embutido: cSchemaName preenchido
= CURSORTOXML("cOrig", "loc_cXmlCom", 1, 0, 0, "VFPSchema")

loc_cOut = loc_cOut + "len sem schema=" + TRANSFORM(LEN(loc_cXmlSem)) + ;
    "   len com schema=" + TRANSFORM(LEN(loc_cXmlCom)) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "XML com schema contem 'xsd:'? " + ;
    TRANSFORM("xsd:" $ loc_cXmlCom) + CHR(13) + CHR(10) + CHR(13) + CHR(10)

*-- Carregar o XML COM schema
IF USED("cComSch")
    USE IN cComSch
ENDIF
loc_nR = XMLTOCURSOR(loc_cXmlCom, "cComSch", 0)
loc_cOut = loc_cOut + "COM schema -> ret=" + TRANSFORM(loc_nR) + ;
    " regs=" + TRANSFORM(RECCOUNT("cComSch")) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "   TYPE(Marcas)=" + TYPE("cComSch.Marcas") + ;
    " TYPE(Cods)=" + TYPE("cComSch.Cods") + ;
    " TYPE(Codigo)=" + TYPE("cComSch.Codigo") + CHR(13) + CHR(10)
SELECT cComSch
GO TOP
loc_cOut = loc_cOut + "   1a linha Cods=[" + TRANSFORM(cComSch.Cods) + ;
    "] Codigo=[" + TRANSFORM(cComSch.Codigo) + ;
    "] Marcas=[" + TRANSFORM(cComSch.Marcas) + "]" + CHR(13) + CHR(10)
TRY
    SELECT cComSch
    COUNT FOR cComSch.Marcas <> 0 TO loc_nQ
    loc_cOut = loc_cOut + "   Marcas <> 0 -> OK, " + TRANSFORM(loc_nQ) + " linha(s)" + CHR(13) + CHR(10)
CATCH TO loE
    loc_cOut = loc_cOut + "   Marcas <> 0 -> ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY

*-- Carregar o XML SEM schema, para contraste
IF USED("cSemSch")
    USE IN cSemSch
ENDIF
loc_nR = XMLTOCURSOR(loc_cXmlSem, "cSemSch", 0)
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "SEM schema -> ret=" + TRANSFORM(loc_nR) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "   TYPE(Marcas)=" + TYPE("cSemSch.Marcas") + ;
    " TYPE(Cods)=" + TYPE("cSemSch.Cods") + ;
    " TYPE(Codigo)=" + TYPE("cSemSch.Codigo") + CHR(13) + CHR(10)
SELECT cSemSch
GO TOP
loc_cOut = loc_cOut + "   1a linha Cods=[" + TRANSFORM(cSemSch.Cods) + ;
    "] Codigo=[" + TRANSFORM(cSemSch.Codigo) + "]  <<< zeros a esquerda perdidos" + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\medir_xml_schema.txt")
QUIT
