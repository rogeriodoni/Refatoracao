*==============================================================================
* ProbeErro302Conferir2.prg - Conferencia SEM falso OK: dumpa a definicao das
* 5 tabelas nos DOIS bancos para CSV e loga o retorno de CADA SQLEXEC.
* NOTA: NUMERIC_SCALE/NUMERIC_PRECISION/CHARACTER_MAXIMUM_LENGTH sao tinyint/
* smallint; ISNULL(col, -1) ESTOURA ("Erro de estouro de capacidade aritmetica
* para o tipo de dados tinyint"). Precisa de CAST AS int ANTES do ISNULL.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL302C2
gcL302C2 = "C:\4c\automation\probe_erro302_conferir2.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL302C2)

LOCAL loc_cConn, loc_nH, loc_oE, loc_nR, loc_cCols

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@;"

loc_cCols = "SELECT TABLE_NAME, ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE," + ;
            " ISNULL(CAST(CHARACTER_MAXIMUM_LENGTH AS int),-1) AS tam," + ;
            " ISNULL(CAST(NUMERIC_PRECISION AS int),-1) AS prec," + ;
            " ISNULL(CAST(NUMERIC_SCALE AS int),-1) AS esc," + ;
            " IS_NULLABLE" + ;
            " FROM [@BD@].INFORMATION_SCHEMA.COLUMNS" + ;
            " WHERE TABLE_NAME IN ('SigCdOcs','SigCdCcp','SigCdCmp','SigCdCrf','SigCdCri')" + ;
            " ORDER BY TABLE_NAME, ORDINAL_POSITION"

TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    LogP302C2("B: handle = " + TRANSFORM(loc_nH))

    IF loc_nH > 0
        loc_nR = SQLEXEC(loc_nH, STRTRAN(loc_cCols, "@BD@", "DB_MBAHIA"), "cur_a")
        LogP302C2("C: DB_MBAHIA -> SQLEXEC=" + TRANSFORM(loc_nR) + ;
                  "  linhas=" + TRANSFORM(IIF(USED("cur_a"), RECCOUNT("cur_a"), -1)))
        IF loc_nR > 0 AND USED("cur_a")
            SELECT cur_a
            COPY TO ("C:\4c\automation\_erro302_def_mbahia.csv") TYPE CSV
        ELSE
            LogP302C2("   *** FALHOU - conferencia INVALIDA")
        ENDIF

        loc_nR = SQLEXEC(loc_nH, STRTRAN(loc_cCols, "@BD@", "CORLUIZ"), "cur_b")
        LogP302C2("D: CORLUIZ   -> SQLEXEC=" + TRANSFORM(loc_nR) + ;
                  "  linhas=" + TRANSFORM(IIF(USED("cur_b"), RECCOUNT("cur_b"), -1)))
        IF loc_nR > 0 AND USED("cur_b")
            SELECT cur_b
            COPY TO ("C:\4c\automation\_erro302_def_corluiz.csv") TYPE CSV
        ELSE
            LogP302C2("   *** FALHOU - conferencia INVALIDA")
        ENDIF

        =SQLDISCONNECT(loc_nH)
    ENDIF

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), gcL302C2, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL302C2, 1)
QUIT

PROCEDURE LogP302C2(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL302C2, 1)
ENDPROC
