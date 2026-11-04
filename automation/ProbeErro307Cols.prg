*==============================================================================
* ProbeErro307Cols.prg - Quais colunas de SigCdOpe sao REALMENTE obrigatorias
* num INSERT: NOT NULL **e sem DEFAULT**. O docs/schema.sql nao registra os
* DEFAULT (licao do Erro302), e coluna NOT NULL COM default nao precisa estar
* no INSERT - por isso a auditoria estatica acusa centenas e a tela grava.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL307
gcL307 = "C:\4c\automation\probe_erro307_cols.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL307)
LOCAL loc_cConn, loc_nH, loc_oE
=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;"
TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    L307("B: handle = " + TRANSFORM(loc_nH))
    IF loc_nH > 0
        *-- panorama
        IF SQLEXEC(loc_nH, ;
            "SELECT COUNT(*) AS total," + ;
            " SUM(CASE WHEN IS_NULLABLE='NO' THEN 1 ELSE 0 END) AS notnull_," + ;
            " SUM(CASE WHEN IS_NULLABLE='NO' AND COLUMN_DEFAULT IS NULL THEN 1 ELSE 0 END) AS obrig" + ;
            " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SigCdOpe'", "cur_p") > 0
            SELECT cur_p
            L307("C: SigCdOpe -> total=" + TRANSFORM(cur_p.total) + ;
                 "  NOT NULL=" + TRANSFORM(cur_p.notnull_) + ;
                 "  NOT NULL SEM default=" + TRANSFORM(cur_p.obrig))
            USE IN cur_p
        ENDIF

        *-- as realmente obrigatorias
        IF SQLEXEC(loc_nH, ;
            "SELECT COLUMN_NAME, DATA_TYPE," + ;
            " ISNULL(CAST(CHARACTER_MAXIMUM_LENGTH AS int),-1) AS tam," + ;
            " ISNULL(CAST(NUMERIC_PRECISION AS int),-1) AS prec," + ;
            " ISNULL(CAST(NUMERIC_SCALE AS int),-1) AS esc" + ;
            " FROM INFORMATION_SCHEMA.COLUMNS" + ;
            " WHERE TABLE_NAME = 'SigCdOpe' AND IS_NULLABLE = 'NO'" + ;
            "   AND COLUMN_DEFAULT IS NULL" + ;
            " ORDER BY ORDINAL_POSITION", "cur_o") > 0
            L307("D: colunas OBRIGATORIAS no INSERT (" + TRANSFORM(RECCOUNT("cur_o")) + "):")
            SELECT cur_o
            SCAN
                L307("   " + PADR(ALLTRIM(cur_o.COLUMN_NAME), 18) + ;
                     PADR(ALLTRIM(cur_o.DATA_TYPE), 10) + ;
                     " tam=" + PADL(TRANSFORM(cur_o.tam), 4) + ;
                     " prec=" + PADL(TRANSFORM(cur_o.prec), 3) + ;
                     " esc=" + PADL(TRANSFORM(cur_o.esc), 2))
            ENDSCAN
            COPY TO ("C:\4c\automation\_erro307_obrigatorias.csv") TYPE CSV
            USE IN cur_o
        ENDIF
        =SQLDISCONNECT(loc_nH)
    ENDIF
CATCH TO loc_oE
    L307("EXCEPTION: " + loc_oE.Message)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL307, 1)
QUIT

PROCEDURE L307(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL307, 1)
ENDPROC
