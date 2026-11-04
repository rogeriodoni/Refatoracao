*==============================================================================
* ProbeErro302GerarDdl.prg - Gera o DDL das 5 tabelas ausentes do DB_MBAHIA a
* partir do BANCO VIVO (CORLUIZ), que tem os DEFAULT que o docs/schema.sql
* nao traz. So LEITURA do servidor; a saida eh um .sql em disco, NAO executado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcSql302
gcSql302 = ""

LOCAL loc_cConn, loc_nH, loc_oE, loc_nI, loc_cTab, loc_cTipo, loc_cDef, loc_cOrigem

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

loc_cOrigem = "CORLUIZ"
loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@;"

DIMENSION laTab[5]
laTab[1] = "SigCdOcs"
laTab[2] = "SigCdCcp"
laTab[3] = "SigCdCmp"
laTab[4] = "SigCdCrf"
laTab[5] = "SigCdCri"

gcSql302 = "/* ===========================================================" + CHR(13) + CHR(10) + ;
    "   Erro302 - tabelas do produto AUSENTES do DB_MBAHIA" + CHR(13) + CHR(10) + ;
    "   DDL extraido do banco VIVO [" + loc_cOrigem + "], que as tem (16 dos 122" + CHR(13) + CHR(10) + ;
    "   bancos do servidor tem as 5). Inclui os DEFAULT, que o docs/schema.sql" + CHR(13) + CHR(10) + ;
    "   NAO traz - com eles, INSERT parcial nao viola o NOT NULL (regra #22)." + CHR(13) + CHR(10) + ;
    "   Gerado em " + TRANSFORM(DATETIME()) + " por automation\ProbeErro302GerarDdl.prg" + CHR(13) + CHR(10) + ;
    "   NAO foi executado. Revisar antes de aplicar no DB_MBAHIA." + CHR(13) + CHR(10) + ;
    "   =========================================================== */" + CHR(13) + CHR(10) + CHR(13) + CHR(10) + ;
    "USE [DB_MBAHIA];" + CHR(13) + CHR(10) + "GO" + CHR(13) + CHR(10) + CHR(13) + CHR(10)

TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    IF loc_nH > 0
        FOR loc_nI = 1 TO 5
            loc_cTab = laTab[loc_nI]

            gcSql302 = gcSql302 + "IF OBJECT_ID('dbo." + loc_cTab + "', 'U') IS NULL" + ;
                CHR(13) + CHR(10) + "BEGIN" + CHR(13) + CHR(10) + ;
                "    CREATE TABLE [dbo].[" + loc_cTab + "] (" + CHR(13) + CHR(10)

            =SQLEXEC(loc_nH, ;
                "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS tam," + ;
                " NUMERIC_PRECISION AS prec, NUMERIC_SCALE AS esc, IS_NULLABLE AS nulo," + ;
                " COLUMN_DEFAULT AS padrao" + ;
                " FROM [" + loc_cOrigem + "].INFORMATION_SCHEMA.COLUMNS" + ;
                " WHERE TABLE_NAME = '" + loc_cTab + "' ORDER BY ORDINAL_POSITION", "cur_col")

            SELECT cur_col
            SCAN
                loc_cTipo = ALLTRIM(cur_col.DATA_TYPE)
                DO CASE
                CASE loc_cTipo == "char" OR loc_cTipo == "varchar"
                    loc_cTipo = "[" + loc_cTipo + "](" + TRANSFORM(NVL(cur_col.tam, 1)) + ")"
                CASE loc_cTipo == "numeric" OR loc_cTipo == "decimal"
                    loc_cTipo = "[" + loc_cTipo + "](" + TRANSFORM(NVL(cur_col.prec, 18)) + ", " + ;
                                TRANSFORM(NVL(cur_col.esc, 0)) + ")"
                OTHERWISE
                    loc_cTipo = "[" + loc_cTipo + "]"
                ENDCASE

                *-- COLUMN_DEFAULT eh nvarchar: chega ao VFP em UTF-16, com um
                *-- byte NUL depois de CADA caractere. Sem tirar os NUL o
                *-- literal vai corrompido e o SQL Server recusa o CREATE com
                *-- "Sintaxe incorreta proxima a '('" (Erro302).
                *-- SO tirar os NUL e aparar as BORDAS. Nao mexer no miolo do
                *-- literal: comer os espacos de dentro de ('   ') muda o DDL em
                *-- relacao ao banco de referencia sem necessidade.
                loc_cDef = NVL(TRANSFORM(cur_col.padrao), "")
                loc_cDef = CHRTRAN(loc_cDef, CHR(0), "")
                loc_cDef = ALLTRIM(STRTRAN(loc_cDef, ".NULL.", ""))
                loc_cDef = IIF(EMPTY(loc_cDef), "", " DEFAULT " + loc_cDef)

                gcSql302 = gcSql302 + "        [" + ALLTRIM(cur_col.COLUMN_NAME) + "] " + ;
                    loc_cTipo + " " + ;
                    IIF(ALLTRIM(NVL(cur_col.nulo, "NO")) == "NO", "NOT NULL", "NULL") + ;
                    loc_cDef + "," + CHR(13) + CHR(10)
            ENDSCAN
            USE IN cur_col

            gcSql302 = gcSql302 + "        CONSTRAINT [" + LOWER(loc_cTab) + ;
                "_cidchaves] PRIMARY KEY CLUSTERED ([cidchaves] ASC)" + CHR(13) + CHR(10) + ;
                "    );" + CHR(13) + CHR(10) + ;
                "    PRINT 'criada: dbo." + loc_cTab + "';" + CHR(13) + CHR(10) + ;
                "END" + CHR(13) + CHR(10) + ;
                "ELSE PRINT 'ja existia: dbo." + loc_cTab + "';" + CHR(13) + CHR(10) + ;
                "GO" + CHR(13) + CHR(10) + CHR(13) + CHR(10)
        ENDFOR

        =SQLDISCONNECT(loc_nH)
    ELSE
        gcSql302 = gcSql302 + "/* SEM CONEXAO - nada gerado */"
    ENDIF

CATCH TO loc_oE
    gcSql302 = gcSql302 + "/* EXCEPTION: " + loc_oE.Message + " */"
ENDTRY

STRTOFILE(gcSql302, "C:\4c\automation\erro302_tabelas_ausentes.sql")
QUIT
