*==============================================================================
* ProbeErro302Varredura.prg - Fecha as lacunas da 1a medicao do Erro302:
*   1) sp_MSforeachdb falha em SILENCIO em banco offline/sem permissao. Aqui a
*      varredura eh explicita, banco a banco, contabilizando sucesso e falha.
*   2) procura tabela EQUIVALENTE no DB_MBAHIA pelas COLUNAS (cods + descs),
*      nao so por nome parecido.
* So leitura. PROCEDURE no FIM; a rotina de log nao se chama Log (nativa).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL302V
gcL302V = "C:\4c\automation\probe_erro302_varredura.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL302V)

LOCAL loc_cConn, loc_nH, loc_nR, loc_oE, loc_nOk, loc_nFalha, loc_nAchou, loc_cDb

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@;"

TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    LogP302V("B: handle = " + TRANSFORM(loc_nH))

    IF loc_nH > 0
        *-- (1) varredura EXPLICITA, banco a banco, com contabilidade
        loc_nR = SQLEXEC(loc_nH, ;
            "SELECT name, state_desc, HAS_DBACCESS(name) AS acesso FROM sys.databases" + ;
            " ORDER BY name", "cur_db")
        LogP302V("C: sys.databases = " + TRANSFORM(IIF(USED("cur_db"), RECCOUNT("cur_db"), -1)))

        loc_nOk    = 0
        loc_nFalha = 0
        loc_nAchou = 0
        IF USED("cur_db")
            SELECT cur_db
            SCAN
                loc_cDb = ALLTRIM(cur_db.name)
                IF NVL(cur_db.acesso, 0) # 1 OR ALLTRIM(NVL(cur_db.state_desc, "")) # "ONLINE"
                    loc_nFalha = loc_nFalha + 1
                    LogP302V("   SEM INSPECAO: " + PADR(loc_cDb, 24) + ;
                             " state=" + ALLTRIM(NVL(cur_db.state_desc, "?")) + ;
                             " acesso=" + TRANSFORM(NVL(cur_db.acesso, -1)))
                    LOOP
                ENDIF
                IF SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM [" + loc_cDb + ;
                           "].INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SigCdOcs'", ;
                           "cur_x") > 0
                    loc_nOk = loc_nOk + 1
                    IF USED("cur_x") AND RECCOUNT("cur_x") > 0 AND cur_x.n > 0
                        loc_nAchou = loc_nAchou + 1
                        LogP302V("   *** ACHOU SigCdOcs em: " + loc_cDb)
                    ENDIF
                ELSE
                    loc_nFalha = loc_nFalha + 1
                    LogP302V("   FALHOU a consulta em: " + loc_cDb)
                ENDIF
                IF USED("cur_x")
                    USE IN cur_x
                ENDIF
            ENDSCAN
        ENDIF
        LogP302V("D: bancos inspecionados=" + TRANSFORM(loc_nOk) + ;
                 "  nao inspecionados=" + TRANSFORM(loc_nFalha) + ;
                 "  com SigCdOcs=" + TRANSFORM(loc_nAchou))

        *-- (2) tabela EQUIVALENTE no DB_MBAHIA: tem cods E descs?
        loc_nR = SQLEXEC(loc_nH, ;
            "SELECT c1.TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS c1" + ;
            " JOIN INFORMATION_SCHEMA.COLUMNS c2" + ;
            "   ON c1.TABLE_NAME = c2.TABLE_NAME" + ;
            " WHERE c1.COLUMN_NAME = 'cods' AND c2.COLUMN_NAME = 'descs'" + ;
            " GROUP BY c1.TABLE_NAME ORDER BY c1.TABLE_NAME", "cur_eq")
        LogP302V("E: tabelas do DB_MBAHIA com cods E descs = " + ;
                 TRANSFORM(IIF(USED("cur_eq"), RECCOUNT("cur_eq"), -1)))
        IF USED("cur_eq")
            SELECT cur_eq
            SCAN
                LogP302V("   " + ALLTRIM(cur_eq.TABLE_NAME))
            ENDSCAN
        ENDIF

        *-- (3) a tabela existe como VIEW ou SYNONYM?
        loc_nR = SQLEXEC(loc_nH, ;
            "SELECT name, type_desc FROM sys.objects WHERE name = 'SigCdOcs'", "cur_ob")
        LogP302V("F: sys.objects name='SigCdOcs' -> " + ;
                 TRANSFORM(IIF(USED("cur_ob"), RECCOUNT("cur_ob"), -1)) + " linhas")
        IF USED("cur_ob") AND RECCOUNT("cur_ob") > 0
            SELECT cur_ob
            SCAN
                LogP302V("   " + ALLTRIM(cur_ob.name) + " [" + ALLTRIM(cur_ob.type_desc) + "]")
            ENDSCAN
        ENDIF

        *-- (4) o usuario pode CRIAR tabela neste banco?
        loc_nR = SQLEXEC(loc_nH, ;
            "SELECT IS_MEMBER('db_owner') AS owner, IS_MEMBER('db_ddladmin') AS ddl," + ;
            " HAS_PERMS_BY_NAME(DB_NAME(), 'DATABASE', 'CREATE TABLE') AS podecriar", "cur_pm")
        IF USED("cur_pm") AND RECCOUNT("cur_pm") > 0
            SELECT cur_pm
            LogP302V("G: permissao -> db_owner=" + TRANSFORM(NVL(cur_pm.owner, -1)) + ;
                     " db_ddladmin=" + TRANSFORM(NVL(cur_pm.ddl, -1)) + ;
                     " CREATE TABLE=" + TRANSFORM(NVL(cur_pm.podecriar, -1)))
        ENDIF

        =SQLDISCONNECT(loc_nH)
        LogP302V("H: desconectado")
    ENDIF

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              CHR(13) + CHR(10), gcL302V, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL302V, 1)
QUIT

PROCEDURE LogP302V(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL302V, 1)
ENDPROC
