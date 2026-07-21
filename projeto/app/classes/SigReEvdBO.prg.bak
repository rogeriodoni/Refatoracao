*==============================================================================
* SIGREEVDBO.PRG
* Business Object - Demonstrativo de Envelopes Duplicados
*
* Herda de: RelatorioBase
* Formulario: FormSigReEvd.prg
* Relatorio:  SigReEvd.frx
* Tabelas:    SigCdNec, SigCdNei, SigCdOpd, SigCdCli, SigCdGcr, SigCdEmp
*==============================================================================

DEFINE CLASS SigReEvdBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cGrupo       = ""
    this_cConta       = ""
    this_cDConta      = ""
    this_dDatai       = {}
    this_dDataf       = {}

    *-- Cursor de dados resultado (nome DEVE bater com FRX legado: CsSelecao)
    this_cCursorDados = "CsSelecao"

    *-- Propriedades espelhando colunas de cursor_4c_Dados (registro corrente)
    *-- Carregadas por CarregarDoCursor() para inspecao/drill-down do relatorio
    this_nNenvs    = 0
    this_cGrupoOs  = ""
    this_cContaOs  = ""
    this_cRCliOs   = ""
    this_dDatas    = {}
    this_cGrupoDs  = ""
    this_cContaDs  = ""
    this_cRCliDs   = ""
    this_cEmpDnPs  = ""
    this_lRetrabs  = .F.

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de lookup para grupos e clientes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Carregar grupos (SigCdGcr) para lookup de Get_Grupo
            loc_cSQL = "SELECT Codigos, Descrs " + ;
                       "FROM SigCdGcr " + ;
                       "WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
            IF loc_nResult >= 1
                *-- Carregar clientes (SigCdCli) para lookup de Get_Conta / Get_DConta
                loc_cSQL = "SELECT IClis, RClis, Inativas " + ;
                           "FROM SigCdCli " + ;
                           "WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Clientes")
                IF loc_nResult >= 1
                    loc_lSucesso = DODEFAULT()
                ELSE
                    MsgErro("Falha ao carregar clientes (SigCdCli)", "SigReEvdBO.Init")
                ENDIF
            ELSE
                MsgErro("Falha ao carregar grupos (SigCdGcr)", "SigReEvdBO.Init")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReEvdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * PrepararDados - Processa envelopes duplicados conforme os filtros.
    * Equivalente ao metodo 'processamento' do form legado SIGREEVD.
    * Popula cursor_4c_Dados (registros a imprimir) e cursor_4c_Cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_lcGrupo, loc_lcConta, loc_ldDatai, loc_ldDataf, loc_cDtFSQL
        LOCAL loc_lcCliOs, loc_lcCliDs, loc_lcEmp, loc_lcCab, loc_lcSub
        LOCAL loc_nNenvs, loc_cGrupoOs, loc_cContaOs, loc_dDatas
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_cEmpDnPs, loc_lRetrabs
        loc_lSucesso = .F.
        TRY
            loc_lcGrupo = ALLTRIM(THIS.this_cGrupo)
            loc_lcConta = ALLTRIM(THIS.this_cConta)
            loc_ldDatai = THIS.this_dDatai
            loc_ldDataf = THIS.this_dDataf

            *-- Data final com 23:59:59 para cobrir dia inteiro (Datas eh DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_ldDataf),  4, "0") + "-" + ;
                PADL(MONTH(loc_ldDataf), 2, "0") + "-" + ;
                PADL(DAY(loc_ldDataf),   2, "0") + " 23:59:59'"

            *-- Criar cursores de trabalho locais (nomes DEVEM bater com legado)
            IF USED("Envelope")
                USE IN Envelope
            ENDIF
            SET NULL ON
            CREATE CURSOR Envelope (Nenvs N(10), GrupoDs C(10), Qt N(5))
            SET NULL OFF
            INDEX ON STR(Nenvs, 10) + GrupoDs TAG Nenvs

            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            SET NULL ON
            CREATE CURSOR TmpRelat ( ;
                Nenvs   N(10), GrupoOs C(10), ContaOs C(10), RCliOs C(50), ;
                Datas   D,     GrupoDs C(10), ContaDs C(10), RCliDs C(50), ;
                EmpDnPs C(33), Retrabs L)
            SET NULL OFF

            *-- Clausula WHERE com filtros opcionais de grupo e conta
            loc_cWhere = "a.Datas BETWEEN " + FormatarDataSQL(loc_ldDatai) + ;
                         " AND " + loc_cDtFSQL
            IF !EMPTY(loc_lcGrupo)
                loc_cWhere = loc_cWhere + " AND a.GrupoDs = " + EscaparSQL(loc_lcGrupo)
            ENDIF

            *-- Buscar envelopes distintos no periodo/filtros
            loc_cSQL = "SELECT DISTINCT b.Nenvs " + ;
                       "FROM SigCdNec a, SigCdNei b " + ;
                       "WHERE " + loc_cWhere + " AND a.EmpDNps = b.EmpDNps " + ;
                       "ORDER BY b.Nenvs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecBase")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar envelopes (SigCdNec/SigCdNei)"
                MsgErro("Falha ao buscar envelopes (SigCdNec/SigCdNei)", "PrepararDados")
                loc_lSucesso = .F.
            ENDIF

            *-- Processar cada numero de envelope encontrado
            SELECT cursor_4c_NecBase
            SCAN
                IF cursor_4c_NecBase.Nenvs = 0
                    LOOP
                ENDIF

                *-- Buscar itens do envelope em SigCdNei
                loc_cSQL = "SELECT DISTINCT Nenvs, EmpDnPs, Dopps FROM SigCdNei " + ;
                           "WHERE Nenvs = " + TRANSFORM(cursor_4c_NecBase.Nenvs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensiLoc")
                IF loc_nResult < 1
                    IF USED("cursor_4c_NensiLoc")
                        USE IN cursor_4c_NensiLoc
                    ENDIF
                    SELECT cursor_4c_NecBase
                    LOOP
                ENDIF

                SELECT cursor_4c_NensiLoc
                SCAN
                    *-- Verificar tipo de operacao em SigCdOpd
                    loc_cSQL = "SELECT Dopps, Subns, GrComps, SepPedras FROM SigCdOpd " + ;
                               "WHERE Dopps = " + EscaparSQL(ALLTRIM(cursor_4c_NensiLoc.Dopps))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpp")
                    IF loc_nResult < 1
                        IF USED("cursor_4c_TmpOpp")
                            USE IN cursor_4c_TmpOpp
                        ENDIF
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Pular se operacao nao se qualifica (SepPedras 1/3, Subns!=1, GrComps!=1)
                    SELECT cursor_4c_TmpOpp
                    IF INLIST(cursor_4c_TmpOpp.SepPedras, 1, 3) OR ;
                       cursor_4c_TmpOpp.Subns <> 1 OR ;
                       cursor_4c_TmpOpp.GrComps <> 1
                        USE IN cursor_4c_TmpOpp
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF
                    USE IN cursor_4c_TmpOpp

                    *-- Buscar dados do envelope origem em SigCdNec pelo EmpDnPs
                    loc_cSQL = "SELECT GrupoOs, ContaOs, Datas, GrupoDs, ContaDs, " + ;
                               "EmpDnPs, Retrabs FROM SigCdNec " + ;
                               "WHERE EmpDnPs = " + EscaparSQL(ALLTRIM(cursor_4c_NensiLoc.EmpDnPs))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensLoc")
                    IF loc_nResult < 1
                        IF USED("cursor_4c_NensLoc")
                            USE IN cursor_4c_NensLoc
                        ENDIF
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Pular se sem registro ou grupo reservado de estoque
                    SELECT cursor_4c_NensLoc
                    IF RECCOUNT() = 0 OR ALLTRIM(cursor_4c_NensLoc.GrupoDs) = "TRMOVESTQ"
                        USE IN cursor_4c_NensLoc
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Buscar nome do cliente origem (ContaOs)
                    loc_lcCliOs = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_NensLoc.ContaOs))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCliOs") > 0
                        SELECT cursor_4c_TmpCliOs
                        IF !EOF()
                            loc_lcCliOs = ALLTRIM(cursor_4c_TmpCliOs.RClis)
                        ENDIF
                        USE IN cursor_4c_TmpCliOs
                    ENDIF

                    *-- Buscar nome do cliente destino (ContaDs)
                    loc_lcCliDs = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_NensLoc.ContaDs))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCliDs") > 0
                        SELECT cursor_4c_TmpCliDs
                        IF !EOF()
                            loc_lcCliDs = ALLTRIM(cursor_4c_TmpCliDs.RClis)
                        ENDIF
                        USE IN cursor_4c_TmpCliDs
                    ENDIF

                    *-- Guardar valores antes de mudar work area
                    loc_nNenvs   = cursor_4c_NensiLoc.Nenvs
                    loc_cGrupoOs = ALLTRIM(cursor_4c_NensLoc.GrupoOs)
                    loc_cContaOs = ALLTRIM(cursor_4c_NensLoc.ContaOs)
                    loc_dDatas   = cursor_4c_NensLoc.Datas
                    loc_cGrupoDs = ALLTRIM(cursor_4c_NensLoc.GrupoDs)
                    loc_cContaDs = ALLTRIM(cursor_4c_NensLoc.ContaDs)
                    loc_cEmpDnPs = ALLTRIM(cursor_4c_NensLoc.EmpDnPs)
                    loc_lRetrabs = cursor_4c_NensLoc.Retrabs
                    USE IN cursor_4c_NensLoc

                    *-- Acumular no TmpRelat
                    SELECT TmpRelat
                    APPEND BLANK
                    REPLACE Nenvs   WITH loc_nNenvs,   ;
                            GrupoOs WITH loc_cGrupoOs, ;
                            ContaOs WITH loc_cContaOs, ;
                            RCliOs  WITH loc_lcCliOs,  ;
                            Datas   WITH loc_dDatas,   ;
                            GrupoDs WITH loc_cGrupoDs, ;
                            ContaDs WITH loc_cContaDs, ;
                            RCliDs  WITH loc_lcCliDs,  ;
                            EmpDnPs WITH loc_cEmpDnPs, ;
                            Retrabs WITH loc_lRetrabs

                    *-- Atualizar contador de duplicados no cursor Envelope
                    SELECT Envelope
                    SET ORDER TO TAG Nenvs
                    IF !SEEK(STR(loc_nNenvs, 10) + loc_cGrupoDs)
                        APPEND BLANK
                        REPLACE Nenvs   WITH loc_nNenvs, ;
                                GrupoDs WITH loc_cGrupoDs
                    ENDIF
                    REPLACE Qt WITH Qt + 1

                    SELECT cursor_4c_NensiLoc
                ENDSCAN

                IF USED("cursor_4c_NensiLoc")
                    USE IN cursor_4c_NensiLoc
                ENDIF
                SELECT cursor_4c_NecBase
            ENDSCAN

            IF USED("cursor_4c_NecBase")
                USE IN cursor_4c_NecBase
            ENDIF

            *-- Montar cabecalho do relatorio
            loc_lcCab = "Auditoria de Envelopes"
            loc_lcSub = "Per" + CHR(237) + "odo : " + ;
                        ALLTRIM(DTOC(loc_ldDatai)) + " at" + CHR(233) + " " + ;
                        ALLTRIM(DTOC(loc_ldDataf))

            loc_lcEmp = go_4c_Sistema.cCodEmpresa

            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            SET NULL ON
            CREATE CURSOR dbCabecalho (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            SET NULL OFF
            INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_lcCab, loc_lcSub, loc_lcEmp)

            *-- Cursor final: apenas envelopes realmente duplicados (Qt > 1)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SELECT A.* FROM TmpRelat A, Envelope B ;
                WHERE A.Nenvs = B.Nenvs AND A.GrupoDs = B.GrupoDs AND B.Qt > 1 ;
                INTO CURSOR CsSelecao READWRITE ;
                ORDER BY A.Nenvs, A.Datas

            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            IF USED("Envelope")
                USE IN Envelope
            ENDIF

            SELECT CsSelecao
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReEvdBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o registro corrente do cursor de dados do
    * relatorio para as propriedades this_*. Util para drill-down, exportacao
    * registro a registro ou inspecao em testes. Aceita qualquer alias com a
    * mesma estrutura de cursor_4c_Dados (cursor_4c_TmpRelat).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), THIS.this_cCursorDados, par_cAliasCursor)
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o aberto: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor sem registro corrente: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            *-- Mapeamento das colunas do cursor para propriedades do BO.
            *-- Usar TYPE() para tolerar cursores com subset de colunas.
            IF TYPE(loc_cAlias + ".Nenvs") = "N"
                THIS.this_nNenvs = NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".GrupoOs") = "C"
                THIS.this_cGrupoOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaOs") = "C"
                THIS.this_cContaOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".RCliOs") = "C"
                THIS.this_cRCliOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".RCliOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Datas") = "D" OR TYPE(loc_cAlias + ".Datas") = "T"
                THIS.this_dDatas = NVL(EVALUATE(loc_cAlias + ".Datas"), {})
            ENDIF
            IF TYPE(loc_cAlias + ".GrupoDs") = "C"
                THIS.this_cGrupoDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaDs") = "C"
                THIS.this_cContaDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".RCliDs") = "C"
                THIS.this_cRCliDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".RCliDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".EmpDnPs") = "C"
                THIS.this_cEmpDnPs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".EmpDnPs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Retrabs") = "L"
                THIS.this_lRetrabs = NVL(EVALUATE(loc_cAlias + ".Retrabs"), .F.)
            ELSE
                IF TYPE(loc_cAlias + ".Retrabs") = "N"
                    THIS.this_lRetrabs = (NVL(EVALUATE(loc_cAlias + ".Retrabs"), 0) = 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReEvdBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o gravam registros. " + ;
            "Use PrepararDados() para gerar os dados."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o alteram registros. " + ;
            "Use PrepararDados() para gerar os dados."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para o registro corrente, devolve "Nenvs|GrupoDs"
    * (chave composta que identifica o envelope duplicado no resultado).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cAlias
        loc_cChave = ""
        loc_cAlias = THIS.this_cCursorDados
        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            IF !EOF() AND !BOF()
                loc_cChave = ALLTRIM(STR(NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0))) + ;
                             "|" + ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoDs"), ""))
            ENDIF
        ENDIF
        IF EMPTY(loc_cChave) AND THIS.this_nNenvs > 0
            loc_cChave = ALLTRIM(STR(THIS.this_nNenvs)) + "|" + ALLTRIM(THIS.this_cGrupoDs)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao em LogAuditoria. Para relatorios
    * registra apenas a operacao "IMPRESSAO" com os filtros aplicados.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_cFiltros, loc_cOper
        loc_lSucesso = .F.
        TRY
            loc_cOper = IIF(EMPTY(par_cOperacao), "IMPRESSAO", ALLTRIM(par_cOperacao))
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "")

            loc_cFiltros = "Grupo=" + ALLTRIM(THIS.this_cGrupo) + ;
                           "; Conta=" + ALLTRIM(THIS.this_cConta) + ;
                           "; DConta=" + ALLTRIM(THIS.this_cDConta) + ;
                           "; Datai=" + DTOC(THIS.this_dDatai) + ;
                           "; Dataf=" + DTOC(THIS.this_dDataf)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, ChaveRegistro, Operacao, Usuario, DataHora, DadosNovos) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigReEvd") + ", " + ;
                       EscaparSQL("RELATORIO") + ", " + ;
                       EscaparSQL(loc_cOper) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cFiltros, 500)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper o relatorio
            THIS.this_cMensagemErro = "Falha auditoria: " + loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_Clientes")
            USE IN cursor_4c_Clientes
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("Envelope")
            USE IN Envelope
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
