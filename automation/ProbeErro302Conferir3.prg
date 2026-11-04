SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL3
gcL3 = "C:\4c\automation\probe_erro302_conferir3.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL3)
LOCAL loc_cConn, loc_nH, loc_oE
=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;"
TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    L3("B: handle = " + TRANSFORM(loc_nH))
    IF loc_nH > 0
        T3(loc_nH, "a) IN com 5 literais", ;
           "SELECT COUNT(*) AS n FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME IN " + ;
           "('SigCdOcs','SigCdCcp','SigCdCmp','SigCdCrf','SigCdCri')")
        T3(loc_nH, "b) colunas sem alias", ;
           "SELECT TABLE_NAME, ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, IS_NULLABLE" + ;
           " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SigCdOcs'")
        T3(loc_nH, "c) com ISNULL e alias", ;
           "SELECT COLUMN_NAME, ISNULL(CHARACTER_MAXIMUM_LENGTH,-1) AS tam" + ;
           " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SigCdOcs'")
        T3(loc_nH, "d) qualificado com banco", ;
           "SELECT COLUMN_NAME FROM [DB_MBAHIA].INFORMATION_SCHEMA.COLUMNS" + ;
           " WHERE TABLE_NAME = 'SigCdOcs'")
        T3(loc_nH, "e) o SELECT inteiro", ;
           "SELECT TABLE_NAME, ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE," + ;
           " ISNULL(CHARACTER_MAXIMUM_LENGTH,-1) AS tam," + ;
           " ISNULL(NUMERIC_PRECISION,-1) AS prec, ISNULL(NUMERIC_SCALE,-1) AS esc," + ;
           " IS_NULLABLE" + ;
           " FROM [DB_MBAHIA].INFORMATION_SCHEMA.COLUMNS" + ;
           " WHERE TABLE_NAME IN ('SigCdOcs','SigCdCcp','SigCdCmp','SigCdCrf','SigCdCri')" + ;
           " ORDER BY TABLE_NAME, ORDINAL_POSITION")
        =SQLDISCONNECT(loc_nH)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), gcL3, 1)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL3, 1)
QUIT

PROCEDURE L3(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL3, 1)
ENDPROC

PROCEDURE T3(par_nH, par_cNome, par_cSql)
    LOCAL lnR, lcM
    lnR = SQLEXEC(par_nH, par_cSql, "cur_t3")
    lcM = ""
    IF lnR < 0
        LOCAL ARRAY laE[1]
        IF AERROR(laE) > 0
            lcM = "  -> " + ALLTRIM(TRANSFORM(laE[2]))
        ENDIF
    ELSE
        lcM = "  linhas=" + TRANSFORM(IIF(USED("cur_t3"), RECCOUNT("cur_t3"), -1))
    ENDIF
    L3("   " + PADR(par_cNome, 26) + "SQLEXEC=" + PADL(TRANSFORM(lnR), 3) + lcM)
    IF USED("cur_t3")
        USE IN cur_t3
    ENDIF
ENDPROC
