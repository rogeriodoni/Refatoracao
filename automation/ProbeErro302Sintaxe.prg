*==============================================================================
* ProbeErro302Sintaxe.prg - Isola QUAL pedaco do DDL o servidor recusa.
* Cria em tempdb (descartavel) para nao tocar o DB_MBAHIA enquanto investigo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL302S
gcL302S = "C:\4c\automation\probe_erro302_sintaxe.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL302S)

LOCAL loc_cConn, loc_nH, loc_oE, loc_nR

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=tempdb;" + ;
            "UID=4control;PWD=f2016jstcr%@;"

TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    LogP302S("B: handle = " + TRANSFORM(loc_nH) + "  (conectado em tempdb)")

    IF loc_nH > 0
        LogP302S("C: versao = " + VersaoSrv(loc_nH))

        Tenta(loc_nH, "1 OBJECT_ID 2 args", "SELECT OBJECT_ID('dbo.XYZ', 'U') AS r")
        Tenta(loc_nH, "2 CREATE simples", ;
              "CREATE TABLE #t1 ([a] [char](10) NOT NULL)")
        Tenta(loc_nH, "3 CREATE + DEFAULT compacto", ;
              "CREATE TABLE #t2 ([a] [char](10) NOT NULL DEFAULT ('   '))")
        Tenta(loc_nH, "4 CREATE + DEFAULT com espacos", ;
              "CREATE TABLE #t3 ([a] [char](10) NOT NULL DEFAULT ( '   ' ) )")
        Tenta(loc_nH, "5 CREATE + numeric DEFAULT ((0))", ;
              "CREATE TABLE #t4 ([a] [numeric](1, 0) NOT NULL DEFAULT ((0)))")
        Tenta(loc_nH, "6 CREATE + numeric DEFAULT ( ( 0 ) )", ;
              "CREATE TABLE #t5 ([a] [numeric](1, 0) NOT NULL DEFAULT ( ( 0 ) ) )")
        Tenta(loc_nH, "7 CREATE + PK inline", ;
              "CREATE TABLE #t6 ([a] [char](20) NOT NULL," + ;
              " CONSTRAINT [pk_t6] PRIMARY KEY CLUSTERED ([a] ASC))")
        Tenta(loc_nH, "8 CREATE + virgula antes da CONSTRAINT", ;
              "CREATE TABLE #t7 ([a] [char](20) NOT NULL DEFAULT ( '   ' ) ," + ;
              " CONSTRAINT [pk_t7] PRIMARY KEY CLUSTERED ([a] ASC))")
        Tenta(loc_nH, "9 IF + BEGIN/END + CREATE", ;
              "IF OBJECT_ID('tempdb..#t8', 'U') IS NULL" + CHR(13) + CHR(10) + ;
              "BEGIN" + CHR(13) + CHR(10) + ;
              "    CREATE TABLE #t8 ([a] [char](10) NOT NULL);" + CHR(13) + CHR(10) + ;
              "END")
        Tenta(loc_nH, "10 IF/BEGIN/END + PRINT + ELSE PRINT", ;
              "IF OBJECT_ID('tempdb..#t9', 'U') IS NULL" + CHR(13) + CHR(10) + ;
              "BEGIN" + CHR(13) + CHR(10) + ;
              "    CREATE TABLE #t9 ([a] [char](10) NOT NULL);" + CHR(13) + CHR(10) + ;
              "    PRINT 'criada';" + CHR(13) + CHR(10) + ;
              "END" + CHR(13) + CHR(10) + ;
              "ELSE PRINT 'ja existia';")
        Tenta(loc_nH, "11 o bloco REAL do SigCdOcs", ;
              "IF OBJECT_ID('tempdb..#oc', 'U') IS NULL" + CHR(13) + CHR(10) + ;
              "BEGIN" + CHR(13) + CHR(10) + ;
              "    CREATE TABLE #oc (" + CHR(13) + CHR(10) + ;
              "        [cods] [char](10) NOT NULL DEFAULT ( '   ' ) ," + CHR(13) + CHR(10) + ;
              "        [cidchaves] [char](20) NOT NULL DEFAULT ( '   ' ) ," + CHR(13) + CHR(10) + ;
              "        [descs] [char](40) NOT NULL DEFAULT ( '   ' ) ," + CHR(13) + CHR(10) + ;
              "        CONSTRAINT [pk_oc] PRIMARY KEY CLUSTERED ([cidchaves] ASC)" + CHR(13) + CHR(10) + ;
              "    );" + CHR(13) + CHR(10) + ;
              "    PRINT 'criada';" + CHR(13) + CHR(10) + ;
              "END" + CHR(13) + CHR(10) + ;
              "ELSE PRINT 'ja existia';")
        Tenta(loc_nH, "12 CREATE puro sem IF/PRINT", ;
              "CREATE TABLE #oc2 (" + CHR(13) + CHR(10) + ;
              "    [cods] [char](10) NOT NULL DEFAULT ( '   ' )," + CHR(13) + CHR(10) + ;
              "    [cidchaves] [char](20) NOT NULL DEFAULT ( '   ' )," + CHR(13) + CHR(10) + ;
              "    [descs] [char](40) NOT NULL DEFAULT ( '   ' )," + CHR(13) + CHR(10) + ;
              "    CONSTRAINT [pk_oc2] PRIMARY KEY CLUSTERED ([cidchaves] ASC)" + CHR(13) + CHR(10) + ;
              ")")

        =SQLDISCONNECT(loc_nH)
        LogP302S("D: desconectado")
    ENDIF

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), gcL302S, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL302S, 1)
QUIT

PROCEDURE LogP302S(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL302S, 1)
ENDPROC

PROCEDURE Tenta(par_nH, par_cNome, par_cSql)
    LOCAL lnR
    lnR = SQLEXEC(par_nH, par_cSql)
    LogP302S("   " + PADR(par_cNome, 34) + IIF(lnR < 0, "ERRO: " + ErroS(), "OK (" + TRANSFORM(lnR) + ")"))
ENDPROC

FUNCTION ErroS()
    LOCAL ARRAY laE[1]
    LOCAL lcR
    lcR = ""
    IF AERROR(laE) > 0
        lcR = ALLTRIM(TRANSFORM(laE[2]))
    ENDIF
    RETURN lcR
ENDFUNC

FUNCTION VersaoSrv(par_nH)
    LOCAL lcV
    lcV = "?"
    IF SQLEXEC(par_nH, "SELECT LEFT(@@VERSION, 60) AS v", "cur_v") > 0 AND USED("cur_v")
        lcV = ALLTRIM(cur_v.v)
        USE IN cur_v
    ENDIF
    RETURN lcV
ENDFUNC
