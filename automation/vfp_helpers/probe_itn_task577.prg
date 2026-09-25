SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cOut, loc_nH, loc_cCx, loc_oErro, loc_cChave
loc_cOut = ""
loc_cCx = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
          "UID=4control;PWD=f2016jstcr%@;Trusted_Connection=No;Login Timeout=30;"
SQLSETPROP(0, "DispLogin", 3)
SQLSETPROP(0, "DispWarnings", .F.)
TRY
    loc_nH = SQLSTRINGCONNECT(loc_cCx)
    SQLSETPROP(loc_nH, "QueryTimeOut", 120)

    SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigMvItn", "t1")
    loc_cOut = loc_cOut + "SigMvItn total de linhas : " + TRANSFORM(t1.n) + CHR(13) + CHR(10)

    *-- a chave exata que o BO agora monta
    loc_cChave = "001MALOTE                   3"
    SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigMvItn WHERE EmpDopNums = '" + loc_cChave + "'", "t2")
    loc_cOut = loc_cOut + "match da chave do BO     : " + TRANSFORM(t2.n) + CHR(13) + CHR(10)

    *-- a chave ENCURTADA (como estava antes do conserto)
    SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigMvItn WHERE EmpDopNums = '001MALOTE     3'", "t3")
    loc_cOut = loc_cOut + "match da chave ANTIGA    : " + TRANSFORM(t3.n) + CHR(13) + CHR(10)

    *-- existe ALGUMA linha de SigMvItn para o movimento MALOTE?
    IF SQLEXEC(loc_nH, "SELECT TOP 5 EmpDopNums, Emps, Dopes, Numes FROM SigMvItn ORDER BY EmpDopNums", "t4") > 0
        SELECT t4
        SCAN
            loc_cOut = loc_cOut + "  SigMvItn: [" + NVL(t4.EmpDopNums,"") + "] len=" + ;
                TRANSFORM(LEN(NVL(t4.EmpDopNums,""))) + CHR(13) + CHR(10)
        ENDSCAN
    ENDIF

    *-- e para os subniveis que EXISTEM (SigMvPec)?
    IF SQLEXEC(loc_nH, "SELECT a.EmpDopNums AS PaiKey, b.Emps, b.Dopes, b.Numes " + ;
            "FROM SigMvPec a JOIN SigMvCab b ON a.EmpDopnums = b.EmpDopNums", "t5") > 0
        SELECT t5
        SCAN
            loc_cOut = loc_cOut + "  subnivel-pai: [" + NVL(t5.PaiKey,"") + "] -> filho Emps=[" + ;
                NVL(t5.Emps,"") + "] Dopes=[" + ALLTRIM(NVL(t5.Dopes,"")) + "] Numes=" + ;
                TRANSFORM(NVL(t5.Numes,0)) + CHR(13) + CHR(10)
        ENDSCAN
    ENDIF

    SQLDISCONNECT(loc_nH)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "EXCECAO: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\tasks\task577\probe_itn.txt")
QUIT
