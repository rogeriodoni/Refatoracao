*==============================================================================
* ProbeErro302Conferir.prg - Confere, coluna a coluna, se as 5 tabelas criadas
* no DB_MBAHIA ficaram IDENTICAS as do banco de referencia (CORLUIZ).
* So leitura.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL302C
gcL302C = "C:\4c\automation\probe_erro302_conferir.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL302C)

LOCAL loc_cConn, loc_nH, loc_oE, loc_nI, loc_cTab, loc_nDif, loc_nTot

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@;"

DIMENSION laTab[5]
laTab[1] = "SigCdOcs"
laTab[2] = "SigCdCcp"
laTab[3] = "SigCdCmp"
laTab[4] = "SigCdCrf"
laTab[5] = "SigCdCri"

TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    LogP302C("B: handle = " + TRANSFORM(loc_nH))

    IF loc_nH > 0
        loc_nTot = 0
        FOR loc_nI = 1 TO 5
            loc_cTab = laTab[loc_nI]
            *-- FULL OUTER entre as duas definicoes: qualquer divergencia aparece
            IF SQLEXEC(loc_nH, ;
                "SELECT COALESCE(a.COLUMN_NAME, b.COLUMN_NAME) AS col," + ;
                " a.DATA_TYPE AS tipo_a, b.DATA_TYPE AS tipo_b," + ;
                " a.CHARACTER_MAXIMUM_LENGTH AS tam_a, b.CHARACTER_MAXIMUM_LENGTH AS tam_b," + ;
                " a.NUMERIC_PRECISION AS pr_a, b.NUMERIC_PRECISION AS pr_b," + ;
                " a.NUMERIC_SCALE AS es_a, b.NUMERIC_SCALE AS es_b," + ;
                " a.IS_NULLABLE AS nu_a, b.IS_NULLABLE AS nu_b," + ;
                " a.ORDINAL_POSITION AS op_a, b.ORDINAL_POSITION AS op_b" + ;
                " FROM [DB_MBAHIA].INFORMATION_SCHEMA.COLUMNS a" + ;
                " FULL OUTER JOIN [CORLUIZ].INFORMATION_SCHEMA.COLUMNS b" + ;
                "   ON a.COLUMN_NAME = b.COLUMN_NAME AND b.TABLE_NAME = '" + loc_cTab + "'" + ;
                " WHERE (a.TABLE_NAME = '" + loc_cTab + "' OR a.TABLE_NAME IS NULL)" + ;
                "   AND (b.TABLE_NAME = '" + loc_cTab + "' OR b.TABLE_NAME IS NULL)" + ;
                "   AND (a.COLUMN_NAME IS NULL OR b.COLUMN_NAME IS NULL" + ;
                "        OR a.DATA_TYPE <> b.DATA_TYPE" + ;
                "        OR ISNULL(a.CHARACTER_MAXIMUM_LENGTH,-1) <> ISNULL(b.CHARACTER_MAXIMUM_LENGTH,-1)" + ;
                "        OR ISNULL(a.NUMERIC_PRECISION,-1) <> ISNULL(b.NUMERIC_PRECISION,-1)" + ;
                "        OR ISNULL(a.NUMERIC_SCALE,-1) <> ISNULL(b.NUMERIC_SCALE,-1)" + ;
                "        OR a.IS_NULLABLE <> b.IS_NULLABLE" + ;
                "        OR a.ORDINAL_POSITION <> b.ORDINAL_POSITION)", "cur_dif") > 0
                loc_nDif = IIF(USED("cur_dif"), RECCOUNT("cur_dif"), -1)
                loc_nTot = loc_nTot + MAX(loc_nDif, 0)
                LogP302C("C: " + PADR(loc_cTab, 10) + " divergencias = " + TRANSFORM(loc_nDif))
                IF loc_nDif > 0
                    SELECT cur_dif
                    SCAN
                        LogP302C("     " + ALLTRIM(NVL(cur_dif.col, "?")) + ;
                                 "  MBAHIA[" + ALLTRIM(NVL(cur_dif.tipo_a, "AUSENTE")) + ;
                                 " tam=" + TRANSFORM(NVL(cur_dif.tam_a, -1)) + ;
                                 " nulo=" + ALLTRIM(NVL(cur_dif.nu_a, "?")) + ;
                                 " pos=" + TRANSFORM(NVL(cur_dif.op_a, -1)) + "]" + ;
                                 "  CORLUIZ[" + ALLTRIM(NVL(cur_dif.tipo_b, "AUSENTE")) + ;
                                 " tam=" + TRANSFORM(NVL(cur_dif.tam_b, -1)) + ;
                                 " nulo=" + ALLTRIM(NVL(cur_dif.nu_b, "?")) + ;
                                 " pos=" + TRANSFORM(NVL(cur_dif.op_b, -1)) + "]")
                    ENDSCAN
                ENDIF
                USE IN cur_dif
            ENDIF
        ENDFOR
        LogP302C("D: TOTAL de divergencias nas 5 tabelas = " + TRANSFORM(loc_nTot))

        *-- a PK ficou nas 5?
        IF SQLEXEC(loc_nH, ;
            "SELECT TABLE_NAME, CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS" + ;
            " WHERE TABLE_NAME IN ('SigCdOcs','SigCdCcp','SigCdCmp','SigCdCrf','SigCdCri')" + ;
            " ORDER BY TABLE_NAME", "cur_pk") > 0
            LogP302C("E: constraints criadas = " + TRANSFORM(RECCOUNT("cur_pk")))
            SELECT cur_pk
            SCAN
                LogP302C("   " + PADR(ALLTRIM(cur_pk.TABLE_NAME), 10) + ALLTRIM(cur_pk.CONSTRAINT_TYPE))
            ENDSCAN
            USE IN cur_pk
        ENDIF

        *-- total de tabelas do banco agora
        IF SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM INFORMATION_SCHEMA.TABLES" + ;
                   " WHERE TABLE_TYPE = 'BASE TABLE'", "cur_n") > 0
            LogP302C("F: total de tabelas no DB_MBAHIA agora = " + TRANSFORM(cur_n.n))
            USE IN cur_n
        ENDIF

        =SQLDISCONNECT(loc_nH)
    ENDIF

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              CHR(13) + CHR(10), gcL302C, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL302C, 1)
QUIT

PROCEDURE LogP302C(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL302C, 1)
ENDPROC
