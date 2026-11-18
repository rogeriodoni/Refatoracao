* MedirSelectNomeExpr.prg - mede se VFP9 aceita NAME EXPRESSION em
* "FROM (var)" e "INTO CURSOR (var)" de SELECT local, e se ALIAS() volta
* corretamente. Grava o resultado em arquivo (STRTOFILE fecha na hora).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cRel, loc_cOrig, loc_cDest, loc_nTt

loc_cRel  = ""
loc_cOrig = "cur_origem"
loc_cDest = "cur_dest"

CREATE CURSOR cur_origem (status C(1))
INSERT INTO cur_origem (status) VALUES ("A")
INSERT INTO cur_origem (status) VALUES ("A")
INSERT INTO cur_origem (status) VALUES ("B")

*-- 1) FROM (var) + INTO CURSOR (var)
TRY
    SELECT status, SUM(1) AS tt ;
        FROM (loc_cOrig) ;
        GROUP BY 1 ;
        INTO CURSOR (loc_cDest) READWRITE
    loc_cRel = loc_cRel + "FROM(var)+INTO CURSOR(var) = OK, _TALLY=" + ;
        TRANSFORM(_TALLY) + ", USED(cur_dest)=" + ;
        IIF(USED("cur_dest"), "SIM", "NAO") + CHR(13) + CHR(10)
CATCH TO loErr
    loc_cRel = loc_cRel + "FROM(var)+INTO CURSOR(var) = ERRO " + ;
        TRANSFORM(loErr.ErrorNo) + " " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- 2) le o resultado com alias em variavel
TRY
    SELECT (loc_cDest)
    loc_nTt = 0
    SCAN
        IF tt > 1
            loc_nTt = tt
            EXIT
        ENDIF
    ENDSCAN
    loc_cRel = loc_cRel + "SCAN no destino = OK, 1o tt>1 = " + ;
        TRANSFORM(loc_nTt) + CHR(13) + CHR(10)
CATCH TO loErr
    loc_cRel = loc_cRel + "SCAN no destino = ERRO " + ;
        TRANSFORM(loErr.ErrorNo) + " " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- 3) SELECT (var) no SCAN do cursor de origem e GO BOTTOM/TOP em cursor VAZIO
TRY
    CREATE CURSOR cur_vazio (status C(1))
    SELECT cur_vazio
    GO BOTTOM
    GO TOP
    loc_cRel = loc_cRel + "GO BOTTOM/TOP em cursor VAZIO = OK" + CHR(13) + CHR(10)
CATCH TO loErr
    loc_cRel = loc_cRel + "GO BOTTOM/TOP em cursor VAZIO = ERRO " + ;
        TRANSFORM(loErr.ErrorNo) + " " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- 4) INSERT INTO cursor com property de objeto no VALUES
TRY
    LOCAL loObj
    loObj = CREATEOBJECT("Empty")
    ADDPROPERTY(loObj, "this_cOp", "MALOTE")
    CREATE CURSOR cur_ins (dopes C(20), cidchaves C(20), status C(1))
    INSERT INTO cur_ins (dopes, cidchaves) VALUES (loObj.this_cOp, "X1")
    loc_cRel = loc_cRel + "INSERT com property no VALUES = OK, dopes=[" + ;
        ALLTRIM(cur_ins.dopes) + "] status vazio=" + ;
        IIF(EMPTY(cur_ins.status), "SIM", "NAO") + CHR(13) + CHR(10)
CATCH TO loErr
    loc_cRel = loc_cRel + "INSERT com property no VALUES = ERRO " + ;
        TRANSFORM(loErr.ErrorNo) + " " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cRel, "C:\4c\automation\_medir_nomeexpr.txt")
QUIT
