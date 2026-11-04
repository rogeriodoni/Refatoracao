*==============================================================================
* ProbeErro302Ddl.prg - As 5 tabelas ausentes do DB_MBAHIA existem nos outros
* bancos? E qual o DDL REAL (estado vivo), nao o do docs/schema.sql?
* So leitura.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL302D
gcL302D = "C:\4c\automation\probe_erro302_ddl.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL302D)

LOCAL loc_cConn, loc_nH, loc_oE, loc_nI, loc_cTab, loc_nQtd, loc_cDb

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
    LogP302D("B: handle = " + TRANSFORM(loc_nH))

    IF loc_nH > 0
        =SQLEXEC(loc_nH, "SELECT name FROM sys.databases WHERE state_desc = 'ONLINE'" + ;
                 " AND HAS_DBACCESS(name) = 1 ORDER BY name", "cur_db")

        FOR loc_nI = 1 TO 5
            loc_cTab = laTab[loc_nI]
            loc_nQtd = 0
            loc_cDb  = ""
            SELECT cur_db
            GO TOP
            SCAN
                IF SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM [" + ALLTRIM(cur_db.name) + ;
                           "].INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '" + loc_cTab + "'", ;
                           "cur_x") > 0
                    IF USED("cur_x") AND RECCOUNT("cur_x") > 0 AND cur_x.n > 0
                        loc_nQtd = loc_nQtd + 1
                        IF EMPTY(loc_cDb)
                            loc_cDb = ALLTRIM(cur_db.name)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cur_x")
                    USE IN cur_x
                ENDIF
            ENDSCAN
            LogP302D("C: " + PADR(loc_cTab, 10) + " existe em " + PADL(TRANSFORM(loc_nQtd), 3) + ;
                     " banco(s)" + IIF(EMPTY(loc_cDb), "", "  (ex.: " + loc_cDb + ")"))

            *-- DDL real do primeiro banco que tem
            IF !EMPTY(loc_cDb)
                IF SQLEXEC(loc_nH, ;
                    "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS tam," + ;
                    " NUMERIC_PRECISION AS prec, NUMERIC_SCALE AS esc, IS_NULLABLE AS nulo," + ;
                    " COLUMN_DEFAULT AS padrao" + ;
                    " FROM [" + loc_cDb + "].INFORMATION_SCHEMA.COLUMNS" + ;
                    " WHERE TABLE_NAME = '" + loc_cTab + "' ORDER BY ORDINAL_POSITION", ;
                    "cur_col") > 0
                    SELECT cur_col
                    SCAN
                        LogP302D("     " + PADR(ALLTRIM(cur_col.COLUMN_NAME), 16) + ;
                                 PADR(ALLTRIM(cur_col.DATA_TYPE), 10) + ;
                                 " tam=" + PADL(TRANSFORM(NVL(cur_col.tam, 0)), 4) + ;
                                 " prec=" + PADL(TRANSFORM(NVL(cur_col.prec, 0)), 3) + ;
                                 " esc=" + PADL(TRANSFORM(NVL(cur_col.esc, 0)), 2) + ;
                                 " nulo=" + ALLTRIM(NVL(cur_col.nulo, "?")) + ;
                                 "  default=[" + ALLTRIM(NVL(TRANSFORM(cur_col.padrao), "")) + "]")
                    ENDSCAN
                    USE IN cur_col
                ENDIF
                *-- indices/PK
                IF SQLEXEC(loc_nH, ;
                    "SELECT tc.CONSTRAINT_TYPE, kcu.COLUMN_NAME, kcu.ORDINAL_POSITION" + ;
                    " FROM [" + loc_cDb + "].INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc" + ;
                    " JOIN [" + loc_cDb + "].INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu" + ;
                    "   ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME" + ;
                    " WHERE tc.TABLE_NAME = '" + loc_cTab + "'" + ;
                    " ORDER BY tc.CONSTRAINT_TYPE, kcu.ORDINAL_POSITION", "cur_pk") > 0
                    SELECT cur_pk
                    SCAN
                        LogP302D("     CONSTRAINT " + ALLTRIM(cur_pk.CONSTRAINT_TYPE) + ;
                                 " -> " + ALLTRIM(cur_pk.COLUMN_NAME))
                    ENDSCAN
                    USE IN cur_pk
                ENDIF
                *-- quantas linhas tem la (a tabela eh usada de verdade?)
                IF SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM [" + loc_cDb + "].dbo.[" + ;
                           loc_cTab + "]", "cur_n") > 0
                    SELECT cur_n
                    LogP302D("     linhas em " + loc_cDb + " = " + TRANSFORM(cur_n.n))
                    USE IN cur_n
                ENDIF
            ENDIF
        ENDFOR

        =SQLDISCONNECT(loc_nH)
        LogP302D("D: desconectado")
    ENDIF

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              CHR(13) + CHR(10), gcL302D, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL302D, 1)
QUIT

PROCEDURE LogP302D(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL302D, 1)
ENDPROC
