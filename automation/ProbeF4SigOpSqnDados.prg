* ProbeF4SigOpSqnDados.prg
* Fase 4 / task806 - mede o UNIVERSO de dados de SigMvCxs e roda a MESMA
* consulta de SigOpSqnBO.ListarSequencias, para distinguir "a consulta nao
* traz linha" de "a tabela esta vazia neste banco".
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cRel, loc_cConn, loc_nH, loc_cOpe, loc_nRes

loc_cOut = "C:\4c\automation\_f4sqn_dados.txt"
loc_cRel = ""

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@"
=SQLSETPROP(0, "ConnectTimeOut", 30)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
loc_nH = SQLSTRINGCONNECT(loc_cConn)

loc_cRel = loc_cRel + "handle = " + TRANSFORM(loc_nH) + CHR(13) + CHR(10)

IF loc_nH > 0
    loc_nRes = SQLEXEC(loc_nH, "SELECT COUNT(*) AS qtd FROM SigMvCxs", "cur_tot")
    loc_cRel = loc_cRel + "SELECT COUNT(*) FROM SigMvCxs -> res=" + TRANSFORM(loc_nRes) + ;
        "  qtd=" + IIF(loc_nRes > 0 AND USED("cur_tot"), TRANSFORM(cur_tot.qtd), "?") + ;
        CHR(13) + CHR(10)

    loc_cOpe = ""
    loc_nRes = SQLEXEC(loc_nH, "SELECT TOP 5 cdopes, COUNT(*) AS qtd FROM SigMvCxs " + ;
        "GROUP BY cdopes ORDER BY COUNT(*) DESC", "cur_ope")
    loc_cRel = loc_cRel + "GROUP BY cdopes -> res=" + TRANSFORM(loc_nRes) + ;
        "  reccount=" + IIF(USED("cur_ope"), TRANSFORM(RECCOUNT("cur_ope")), "?") + CHR(13) + CHR(10)

    IF USED("cur_ope")
        SELECT cur_ope
        SCAN
            loc_cRel = loc_cRel + "   cdopes=[" + ALLTRIM(cur_ope.cdopes) + "] qtd=" + ;
                TRANSFORM(cur_ope.qtd) + CHR(13) + CHR(10)
            IF EMPTY(loc_cOpe)
                loc_cOpe = ALLTRIM(cur_ope.cdopes)
            ENDIF
        ENDSCAN
    ENDIF

    *-- A MESMA consulta de SigOpSqnBO.ListarSequencias
    IF !EMPTY(loc_cOpe)
        loc_nRes = SQLEXEC(loc_nH, ;
            "SELECT a.cdopes, a.cidchaves, a.cnivels, a.seqs" + ;
            " FROM SigMvCxs a" + ;
            " INNER JOIN SigCdOpe b ON a.cdopes = b.dopes" + ;
            " WHERE a.cdopes = '" + loc_cOpe + "'" + ;
            " ORDER BY a.cdopes, a.cnivels", "cur_seq")
        loc_cRel = loc_cRel + "CONSULTA DO BO para [" + loc_cOpe + "] -> res=" + ;
            TRANSFORM(loc_nRes) + "  reccount=" + ;
            IIF(USED("cur_seq"), TRANSFORM(RECCOUNT("cur_seq")), "?") + CHR(13) + CHR(10)
        IF USED("cur_seq") AND RECCOUNT("cur_seq") > 0
            SELECT cur_seq
            GO TOP
            loc_cRel = loc_cRel + "   1a linha: cnivels=[" + ALLTRIM(cur_seq.cnivels) + ;
                "] seqs=" + TRANSFORM(cur_seq.seqs) + CHR(13) + CHR(10)
        ENDIF

        *-- Controle: a MESMA consulta SEM o INNER JOIN, para separar
        *-- "nao ha linha" de "o JOIN descarta a linha"
        loc_nRes = SQLEXEC(loc_nH, ;
            "SELECT cdopes, cidchaves, cnivels, seqs FROM SigMvCxs" + ;
            " WHERE cdopes = '" + loc_cOpe + "'", "cur_sem")
        loc_cRel = loc_cRel + "CONTROLE sem JOIN -> res=" + TRANSFORM(loc_nRes) + ;
            "  reccount=" + IIF(USED("cur_sem"), TRANSFORM(RECCOUNT("cur_sem")), "?") + ;
            CHR(13) + CHR(10)
    ENDIF

    =SQLDISCONNECT(loc_nH)
ENDIF

STRTOFILE(loc_cRel, loc_cOut)
QUIT
