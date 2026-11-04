*==============================================================================
* ProbeErro302Faltantes.prg - Levanta TODAS as tabelas do banco DB_MBAHIA e
* procura SigCdOcs nos demais databases do servidor. So leitura.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL302F
gcL302F = "C:\4c\automation\probe_erro302_faltantes.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL302F)

LOCAL loc_cConn, loc_nH, loc_nR, loc_oE

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@;"

TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    LogP302F("B: handle = " + TRANSFORM(loc_nH))

    IF loc_nH > 0
        *-- todas as tabelas base do banco, para o DBF ser lido pelo PowerShell
        loc_nR = SQLEXEC(loc_nH, ;
            "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES" + ;
            " WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_NAME", "cur_all")
        LogP302F("C: tabelas BASE TABLE no DB_MBAHIA = " + ;
                 TRANSFORM(IIF(USED("cur_all"), RECCOUNT("cur_all"), -1)))
        IF USED("cur_all")
            COPY TO ("C:\4c\automation\_erro302_tabelas_banco.csv") TYPE CSV
            LogP302F("   gravado em _erro302_tabelas_banco.csv")
        ENDIF

        *-- SigCdOcs existe em algum OUTRO database do servidor?
        loc_nR = SQLEXEC(loc_nH, "SELECT name FROM sys.databases ORDER BY name", "cur_db")
        LogP302F("D: sys.databases -> resultado=" + TRANSFORM(loc_nR) + " linhas=" + ;
                 TRANSFORM(IIF(USED("cur_db"), RECCOUNT("cur_db"), -1)))
        IF USED("cur_db") AND RECCOUNT("cur_db") > 0
            SELECT cur_db
            SCAN
                LogP302F("   db: " + ALLTRIM(cur_db.name))
            ENDSCAN
        ENDIF

        *-- varredura server-wide por SigCdOcs
        loc_nR = SQLEXEC(loc_nH, ;
            "EXEC sp_MSforeachdb 'SELECT ''?'' AS bd, TABLE_NAME FROM [?].INFORMATION_SCHEMA.TABLES" + ;
            " WHERE TABLE_NAME = ''SigCdOcs''' ", "cur_fd")
        LogP302F("E: sp_MSforeachdb -> resultado=" + TRANSFORM(loc_nR) + " linhas=" + ;
                 TRANSFORM(IIF(USED("cur_fd"), RECCOUNT("cur_fd"), -1)))
        IF USED("cur_fd") AND RECCOUNT("cur_fd") > 0
            SELECT cur_fd
            SCAN
                LogP302F("   ACHOU em: " + ALLTRIM(TRANSFORM(cur_fd.bd)))
            ENDSCAN
        ENDIF

        =SQLDISCONNECT(loc_nH)
        LogP302F("F: desconectado")
    ENDIF

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              CHR(13) + CHR(10), gcL302F, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL302F, 1)
QUIT

PROCEDURE LogP302F(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL302F, 1)
ENDPROC
