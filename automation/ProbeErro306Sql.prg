SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL306S
gcL306S = "C:\4c\automation\probe_erro306_sql.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL306S)
LOCAL loc_cConn, loc_nH, loc_oE
=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;"
TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    L306S("B: handle = " + TRANSFORM(loc_nH))
    IF loc_nH > 0
        T306(loc_nH, "ALLTRIM existe?", "SELECT ALLTRIM('  x  ') AS r")
        T306(loc_nH, "dbo.ALLTRIM existe?", "SELECT dbo.ALLTRIM('  x  ') AS r")
        T306(loc_nH, "NVL existe?", "SELECT NVL(NULL, 0) AS r")
        T306(loc_nH, "ISNULL (equivalente)", "SELECT ISNULL(NULL, 0) AS r")
        T306(loc_nH, "LTRIM(RTRIM()) ok?", "SELECT LTRIM(RTRIM('  x  ')) AS r")
        *-- ha alguma UDF escalar com nome de funcao VFP?
        IF SQLEXEC(loc_nH, "SELECT name, type_desc FROM sys.objects" + ;
            " WHERE type IN ('FN','IF','TF') AND name IN" + ;
            " ('ALLTRIM','NVL','PADR','PADL','EMPTY','TRANSFORM','SUBSTR','OCCURS')" + ;
            " ORDER BY name", "cur_udf") > 0
            L306S("C: UDFs com nome de funcao VFP = " + TRANSFORM(RECCOUNT("cur_udf")))
            IF RECCOUNT("cur_udf") > 0
                SELECT cur_udf
                SCAN
                    L306S("   " + ALLTRIM(cur_udf.name) + " [" + ALLTRIM(cur_udf.type_desc) + "]")
                ENDSCAN
            ENDIF
        ENDIF
        =SQLDISCONNECT(loc_nH)
    ENDIF
CATCH TO loc_oE
    L306S("EXCEPTION: " + loc_oE.Message)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL306S, 1)
QUIT

PROCEDURE L306S(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL306S, 1)
ENDPROC

PROCEDURE T306(par_nH, par_cNome, par_cSql)
    LOCAL lnR, lcM
    lnR = SQLEXEC(par_nH, par_cSql, "cur_x")
    lcM = ""
    IF lnR < 0
        LOCAL ARRAY laE[1]
        IF AERROR(laE) > 0
            lcM = "ERRO: " + ALLTRIM(TRANSFORM(laE[2]))
        ENDIF
    ELSE
        lcM = "OK"
    ENDIF
    L306S("   " + PADR(par_cNome, 24) + lcM)
    IF USED("cur_x")
        USE IN cur_x
    ENDIF
ENDPROC
