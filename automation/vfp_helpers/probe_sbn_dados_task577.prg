*-- Conexao DIRETA (sem config.prg, que leva ~146s) so para inspecionar os
*-- dados de SigMvPec/SigOpDev e achar uma semente valida de subnivel.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_nH, loc_cCx, loc_oErro
loc_cOut = ""
loc_cCx = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
          "UID=4control;PWD=f2016jstcr%@;Trusted_Connection=No;Login Timeout=30;"

SQLSETPROP(0, "DispLogin", 3)
SQLSETPROP(0, "DispWarnings", .F.)

TRY
    loc_nH = SQLSTRINGCONNECT(loc_cCx)
    IF loc_nH < 0
        loc_cOut = "FALHA conexao"
    ELSE
        SQLSETPROP(loc_nH, "QueryTimeOut", 120)

        SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigMvPec", "c1")
        loc_cOut = loc_cOut + "SigMvPec linhas : " + TRANSFORM(c1.n) + CHR(13) + CHR(10)

        SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigOpDev", "c2")
        loc_cOut = loc_cOut + "SigOpDev linhas : " + TRANSFORM(c2.n) + CHR(13) + CHR(10)

        *-- amostra de SigMvPec
        IF SQLEXEC(loc_nH, "SELECT TOP 3 EmpSubns, Codigos, EmpDopNums FROM SigMvPec ORDER BY Codigos DESC", "c3") > 0
            SELECT c3
            SCAN
                loc_cOut = loc_cOut + "  SigMvPec: EmpSubns=[" + ALLTRIM(NVL(c3.EmpSubns,"")) + ;
                    "] Codigos=" + TRANSFORM(NVL(c3.Codigos,0)) + ;
                    " EmpDopNums=[" + ALLTRIM(NVL(c3.EmpDopNums,"")) + "]" + CHR(13) + CHR(10)
            ENDSCAN
        ENDIF

        *-- amostra de SigOpDev
        IF SQLEXEC(loc_nH, "SELECT TOP 3 Codigos, EmpDopNums FROM SigOpDev ORDER BY Codigos DESC", "c4") > 0
            SELECT c4
            SCAN
                loc_cOut = loc_cOut + "  SigOpDev: Codigos=" + TRANSFORM(NVL(c4.Codigos,0)) + ;
                    " EmpDopNums=[" + ALLTRIM(NVL(c4.EmpDopNums,"")) + "]" + CHR(13) + CHR(10)
            ENDSCAN
        ENDIF

        *-- a divisao inteira usada na semente anterior funciona?
        IF SQLEXEC(loc_nH, "SELECT TOP 3 a.Codigos, a.Codigos/1000000 AS divi FROM SigMvPec a ORDER BY a.Codigos DESC", "c5") > 0
            SELECT c5
            SCAN
                loc_cOut = loc_cOut + "  divisao: Codigos=" + TRANSFORM(NVL(c5.Codigos,0)) + ;
                    " /1000000 = " + TRANSFORM(NVL(c5.divi,0)) + CHR(13) + CHR(10)
            ENDSCAN
        ENDIF

        SQLDISCONNECT(loc_nH)
    ENDIF
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "EXCECAO: " + loc_oErro.Message + " linha " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\tasks\task577\probe_sbn_dados.txt")
QUIT
