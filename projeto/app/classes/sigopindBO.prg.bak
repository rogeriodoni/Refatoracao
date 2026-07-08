*==============================================================================
* sigopindBO.prg - Business Object para Contas Correntes Individuais (SIGOPIND)
* Herda de: BusinessBase
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigopindBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da tabela principal
    *--------------------------------------------------------------------------
    this_cTabela     = "SigMvSlc"
    this_cCampoChave = "Contas"

    *--------------------------------------------------------------------------
    * Propriedades de contexto operacional do formulario
    *--------------------------------------------------------------------------
    this_cGrupoOper    = ""    && Grupo de conta corrente selecionado
    this_cCliente      = ""    && Codigo do cliente/conta selecionada
    this_dDataConcilia = {}    && Data de conciliacao em andamento
    this_lMatrizes     = .F.   && Flag: eh matriz (go_4c_Sistema.Matrizes)
    this_cOperacao     = ""    && Operacao corrente (CONSULTA, ALTERAR, etc.)
    this_cUsuario      = ""    && Usuario logado corrente

    *--------------------------------------------------------------------------
    * Propriedades de SigMvSlc (saldos por conta/moeda)
    *--------------------------------------------------------------------------
    this_cEmps       = ""      && Empresa
    this_cGrupos     = ""      && Grupo de conta corrente
    this_cContas     = ""      && Codigo da conta (cliente)
    this_cMoedas     = ""      && Codigo da moeda
    this_nSaldos     = 0       && Saldo atual
    this_cRClis      = ""      && Razao social do cliente
    this_cSituas     = ""      && Situacao do cliente
    this_cCpfs       = ""      && CPF/CNPJ do cliente
    this_cContaMats  = ""      && Conta matriz

    *--------------------------------------------------------------------------
    * Propriedades de SigCdCli (dados do cliente)
    *--------------------------------------------------------------------------
    this_cIClis          = ""   && Codigo interno do cliente
    this_nConcilias      = 0    && Flag: aceita conciliacao
    this_nCanAudits      = 0    && Flag: pode auditar

    *--------------------------------------------------------------------------
    * Propriedades de SigMvCcr (lancamentos/historico)
    *--------------------------------------------------------------------------
    this_cLancEmps      = ""    && Empresa do lancamento
    this_cDopes         = ""    && Documento/operacao
    this_nNumes         = 0     && Numero do lancamento
    this_nNopers        = 0     && Numero da operacao
    this_cVOpers        = ""    && Valor/numero operacao complementar
    this_cOpers         = ""    && Identificador de operacao
    this_cDopcs         = ""    && Documento contra-partida
    this_nNumcs         = 0     && Numero da contra-partida
    this_dDatas         = {}    && Data do lancamento
    this_nSaldosCcr     = 0     && Saldo do lancamento
    this_cHists         = ""    && Historico do lancamento
    this_lConcs         = .F.   && Conciliado?
    this_cUsuConcs      = ""    && Usuario que conciliou
    this_cAuditors      = ""    && Auditor
    this_dDtAudits      = {}    && Data de auditoria
    this_cTipo          = ""    && Tipo do lancamento (P=provisorio, etc.)
    this_cSGrupos       = ""    && Sub-grupo do lancamento

    *--------------------------------------------------------------------------
    * Propriedades de filtro do painel Saldo (cntSaldo / ProcessaSaldo)
    *--------------------------------------------------------------------------
    this_cMoedaCodFiltro   = ""  && Codigo da moeda para filtro saldo
    this_cMoedaDescFiltro  = ""  && Descricao da moeda para filtro saldo
    this_dDataLimiteFiltro = {}  && Data limite para filtro saldo
    this_nOrdemFiltro      = 1   && Ordem: 1=Nome 2=Codigo 3=Saldo
    this_lAscendente       = .F. && Ordenacao ascendente?
    this_cSituacaoFiltro   = ""  && Codigo da situacao para filtro
    this_lImprimeSaldoZero = .F. && Imprimir contas com saldo zero?
    this_nOptFiltro        = 1   && Opcao do optFiltro (1=Todos 2=Devedor 3=Credor)

    *--------------------------------------------------------------------------
    * Propriedades de filtro do historico (cntImprime / ProcessaHist)
    *--------------------------------------------------------------------------
    this_dDtInicial       = {}   && Data inicial do historico
    this_dDtFinal         = {}   && Data final do historico
    this_cMoedaHistCod    = ""   && Codigo da moeda para historico
    this_cMoedaHistDesc   = ""   && Descricao da moeda para historico
    this_cEmpsCod         = ""   && Codigo da empresa para historico
    this_cEmpsDesc        = ""   && Descricao da empresa para historico
    this_cGetOper         = ""   && D/C (debito/credito) para filtro
    this_nCmbConcilia     = 0    && Opcao do combobox de conciliacao
    this_lChkGrupo        = .F.  && Todas as contas do grupo?
    this_lCheckSalto      = .F.  && Quebra pagina por conta?
    this_lCheckSAnt       = .F.  && Sem saldo anterior?
    this_lCheckRazaoCP    = .F.  && Relacao com contrapartida?
    this_lCheckRazaoDoc   = .F.  && Relacao com documento?
    this_lCheckComissao   = .F.  && Incluir comissao?
    this_lCheckSaldoa     = .F.  && Sem saldo?
    this_lChkTaxas        = .F.  && Incluir taxas?
    this_lChkRelDets      = .F.  && Relacao detalhada?
    this_nOptSNA          = 1    && Opcao S/N/A (1=S, 2=N, 3=A)
    this_lChkOcultaCta    = .F.  && Ocultar descricao da conta?

    *--------------------------------------------------------------------------
    * Propriedades de periodos padroes da grade Saldo
    *--------------------------------------------------------------------------
    this_dDataInicialSaldo = {}   && Data inicial do filtro de periodo saldo
    this_dDataFinalSaldo   = {}   && Data final do filtro de periodo saldo

    *--------------------------------------------------------------------------
    * Propriedades para busca de conta (cntConsulta)
    *--------------------------------------------------------------------------
    this_cCdContaBusca  = ""    && Codigo da conta digitado para busca
    this_cDsContaBusca  = ""    && Descricao da conta digitado para busca

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvSlc"
            THIS.this_cCampoChave = "Contas"

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
    *-- Retorna a chave primaria do registro corrente
        RETURN THIS.this_cContas
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Carrega propriedades do BO a partir do cursor combinado (SigMvSlc + SigCdCli)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps      = TratarNulo(Emps, "C")
                THIS.this_cGrupos    = TratarNulo(Grupos, "C")
                THIS.this_cContas    = TratarNulo(Contas, "C")
                THIS.this_cMoedas    = TratarNulo(Moedas, "C")
                THIS.this_nSaldos    = TratarNulo(Saldos, "N")
                THIS.this_cRClis     = TratarNulo(RClis, "C")
                THIS.this_cSituas    = TratarNulo(Situas, "C")
                THIS.this_cCpfs      = TratarNulo(Cpfs, "C")
                THIS.this_cContaMats = TratarNulo(ContaMats, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Inserir()
    *==========================================================================
    *-- Form OPERACIONAL: insercoes sao feitas via lancamentos contabeis externos
        RETURN .F.
    ENDPROC

    *==========================================================================
    PROCEDURE Atualizar()
    *==========================================================================
    *-- Atualiza conciliacao/auditoria do lancamento corrente em SigMvCcr
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Concs = " + IIF(THIS.this_lConcs, "1", "0") + ", " + ;
                       "Usuconcs = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                       "Dataconcs = " + FormatarDataSQL(THIS.this_dDataConcilia) + ", " + ;
                       "Auditors = " + EscaparSQL(ALLTRIM(THIS.this_cAuditors)) + ", " + ;
                       "DtAudits = " + FormatarDataSQL(THIS.this_dDtAudits) + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cLancEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar registro.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
    *-- Exclui todos os lancamentos da operacao (corrente + contra-partida) em SigMvCcr
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "DELETE FROM SigMvCcr " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cLancEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("E")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Excluir()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lan" + ;
                           CHR(231) + "amento?", "Confirma" + CHR(231) + CHR(227) + "o")
                loc_lResultado = THIS.ExecutarExclusao()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE MontaGrade(par_cGrupo, par_nOptFiltro)
    *==========================================================================
    *-- Carrega cursor_4c_Saldos com dados de SigMvSlc + SigCdCli por grupo
    *-- par_cGrupo    : codigo do grupo de conta corrente
    *-- par_nOptFiltro: 1=Todos  2=Devedores(Saldo>0)  3=Credores(Saldo<0)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cFiltroSaldo
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            IF EMPTY(ALLTRIM(par_cGrupo))
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Filtro de saldo conforme opcao selecionada
            DO CASE
                CASE par_nOptFiltro = 2
                    loc_cFiltroSaldo = " AND a.Saldos > 0"
                CASE par_nOptFiltro = 3
                    loc_cFiltroSaldo = " AND a.Saldos < 0"
                OTHERWISE
                    loc_cFiltroSaldo = ""
            ENDCASE

            *-- Consulta principal: saldos por conta/moeda do grupo
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                       "b.RClis, b.Situas, b.Cpfs, b.ContaMats, " + ;
                       "CAST(' ' AS CHAR(1)) AS Matriz " + ;
                       "FROM SigMvSlc a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                       loc_cFiltroSaldo + ;
                       " ORDER BY a.Contas, a.Moedas"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldosTemp")
            IF loc_nRet < 1
                MsgErro("Erro ao carregar saldos do grupo.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Transferir para cursor permanente do grid (protege colunas)
            SELECT cursor_4c_Saldos
            ZAP
            IF RECCOUNT("cursor_4c_SaldosTemp") > 0
                APPEND FROM DBF("cursor_4c_SaldosTemp")
            ENDIF
            IF USED("cursor_4c_SaldosTemp")
                USE IN cursor_4c_SaldosTemp
            ENDIF

            GO TOP IN cursor_4c_Saldos
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_SaldosTemp")
                USE IN cursor_4c_SaldosTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BuscarHistorico(par_cGrupo, par_cConta, par_cMoeda, ;
                                     par_dDataI, par_dDataF, ;
                                     par_cEmp, par_nCmbConcilia)
    *==========================================================================
    *-- Carrega CrSigMvCcr com lancamentos de SigMvCcr
    *-- par_cGrupo      : grupo conta corrente
    *-- par_cConta      : conta (codigo do cliente)
    *-- par_cMoeda      : moeda
    *-- par_dDataI/F    : intervalo de datas
    *-- par_cEmp        : empresa (vazio = todas as empresas)
    *-- par_nCmbConcilia: 0=Todos  1=N" + CHR(227) + "o conciliados  2=Conciliados
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cGruConMoe, loc_cFiltroEmp
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Chave composta gruconmoes: grupo(10) + conta(10) + moeda(3) = 23
            loc_cGruConMoe = PADR(ALLTRIM(par_cGrupo), 10) + ;
                             PADR(ALLTRIM(par_cConta), 10) + ;
                             PADR(ALLTRIM(par_cMoeda), 3)

            *-- Filtro de empresa
            loc_cFiltroEmp = ""
            IF !EMPTY(ALLTRIM(par_cEmp))
                loc_cFiltroEmp = " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmp))
            ENDIF

            *-- Consulta de lancamentos da conta no periodo (todos os registros)
            *-- Filtro de conciliacao aplicado localmente apos carga (como no original)
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                       "a.Datas, a.Dataconcs, a.Hists, a.Hist2s, a.Valors, a.Saldos, " + ;
                       "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                       "a.Concs, a.Usuconcs, a.Usualts, a.Auditors, a.DtAudits, " + ;
                       "a.Tipos, a.Vopers, a.Titulos, a.Nfs, a.Docus, " + ;
                       "a.Empos, a.SGrupos, a.Nlancs, a.GruConMoes, " + ;
                       "a.CidChaves, a.EmpCCs, a.Pagos, a.TitCancs, " + ;
                       "a.Jobs, a.Saldocs, " + ;
                       "b.RClis, b.Situas, b.Concilias " + ;
                       "FROM SigMvCcr a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.GruConMoes = " + EscaparSQL(loc_cGruConMoe) + ;
                       " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                       " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                       loc_cFiltroEmp + ;
                       " ORDER BY a.Datas, a.Nopers"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvCcrTemp")
            IF loc_nRet < 1
                MsgErro("Erro ao carregar hist" + CHR(243) + "rico.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Transferir para cursor permanente do grid (protege colunas)
            SELECT CrSigMvCcr
            ZAP
            IF RECCOUNT("CrSigMvCcrTemp") > 0
                APPEND FROM DBF("CrSigMvCcrTemp")
            ENDIF
            IF USED("CrSigMvCcrTemp")
                USE IN CrSigMvCcrTemp
            ENDIF

            *-- Aplicar filtro de conciliacao localmente (como no original: Delete Where Concs)
            SELECT CrSigMvCcr
            DO CASE
                CASE par_nCmbConcilia = 1
                    SET FILTER TO !Concs
                CASE par_nCmbConcilia = 2
                    SET FILTER TO Concs
                OTHERWISE
                    SET FILTER TO
            ENDCASE

            GO TOP IN CrSigMvCcr
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("CrSigMvCcrTemp")
                USE IN CrSigMvCcrTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarConciliacao(par_lConciliar, par_nNopers, ;
                                          par_cEmps, par_dDataConc)
    *==========================================================================
    *-- Concilia ou desconcilia todos os lancamentos de uma operacao
    *-- par_lConciliar: .T. = conciliar  .F. = desconciliar
    *-- par_nNopers   : numero da operacao (identifica todos os lancamentos)
    *-- par_cEmps     : empresa
    *-- par_dDataConc : data de conciliacao (usada ao conciliar)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cConcs, loc_cUsConcs, loc_cDataConcs
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            IF par_lConciliar
                loc_cConcs     = "1"
                loc_cUsConcs   = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))
                loc_cDataConcs = FormatarDataSQL(par_dDataConc)
            ELSE
                loc_cConcs     = "0"
                loc_cUsConcs   = EscaparSQL("")
                loc_cDataConcs = "NULL"
            ENDIF

            *-- Atualiza todos os lancamentos da operacao (corrente + contra-partida)
            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Concs = " + loc_cConcs + ", " + ;
                       "Usuconcs = " + loc_cUsConcs + ", " + ;
                       "Dataconcs = " + loc_cDataConcs + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(par_cEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar concilia" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                THIS.this_nNopers    = par_nNopers
                THIS.this_cLancEmps  = par_cEmps
                THIS.this_lConcs     = par_lConciliar
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarAuditoria(par_lAuditar, par_nNopers, par_cEmps)
    *==========================================================================
    *-- Audita ou desaudita todos os lancamentos de uma operacao
    *-- par_lAuditar: .T. = auditar  .F. = desauditar
    *-- par_nNopers : numero da operacao
    *-- par_cEmps   : empresa
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cAuditors, loc_cDtAudits
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            IF par_lAuditar
                loc_cAuditors = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))
                loc_cDtAudits = FormatarDataSQL(DATE())
            ELSE
                loc_cAuditors = EscaparSQL("")
                loc_cDtAudits = "NULL"
            ENDIF

            loc_cSQL = "UPDATE SigMvCcr SET " + ;
                       "Auditors = " + loc_cAuditors + ", " + ;
                       "DtAudits = " + loc_cDtAudits + " " + ;
                       "WHERE Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(par_cEmps))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Erro ao atualizar auditoria.", "Erro")
            ELSE
                THIS.this_nNopers   = par_nNopers
                THIS.this_cLancEmps = par_cEmps
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDadosCliente(par_cICli)
    *==========================================================================
    *-- Carrega dados de SigCdCli para propriedades do BO
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            IF EMPTY(ALLTRIM(par_cICli))
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "SELECT IClis, RClis, Concilias " + ;
                       "FROM SigCdCli " + ;
                       "WHERE IClis = " + EscaparSQL(ALLTRIM(par_cICli))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliTemp")
            IF loc_nRet >= 1
                SELECT cursor_4c_CliTemp
                IF !EOF()
                    THIS.this_cIClis     = TratarNulo(IClis, "C")
                    THIS.this_cRClis     = TratarNulo(RClis, "C")
                    THIS.this_nConcilias = TratarNulo(Concilias, "N")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLancamento(par_cEmps, par_nNopers)
    *==========================================================================
    *-- Carrega dados de SigMvCcr para propriedades do BO pelo numero da operacao
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = loc_lResultado
            ENDIF

            loc_cSQL = "SELECT Emps, Grupos, Contas, Moedas, Datas, Dataconcs, " + ;
                       "Hists, Valors, Saldos, Opers, Nopers, Numes, Dopes, " + ;
                       "Dopcs, Numcs, Concs, Usuconcs, Auditors, DtAudits, " + ;
                       "Tipos, Vopers, Empos, SGrupos " + ;
                       "FROM SigMvCcr " + ;
                       "WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
                       " AND Nopers = " + FormatarNumeroSQL(par_nNopers) + ;
                       " ORDER BY Nopers"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LancTemp")
            IF loc_nRet >= 1
                SELECT cursor_4c_LancTemp
                IF !EOF()
                    THIS.this_cLancEmps  = TratarNulo(Emps, "C")
                    THIS.this_cGrupos    = TratarNulo(Grupos, "C")
                    THIS.this_cContas    = TratarNulo(Contas, "C")
                    THIS.this_cMoedas    = TratarNulo(Moedas, "C")
                    THIS.this_dDatas     = TratarNulo(Datas, "D")
                    THIS.this_cHists     = TratarNulo(Hists, "C")
                    THIS.this_nSaldosCcr = TratarNulo(Saldos, "N")
                    THIS.this_cOpers     = TratarNulo(Opers, "C")
                    THIS.this_nNopers    = TratarNulo(Nopers, "N")
                    THIS.this_nNumes     = TratarNulo(Numes, "N")
                    THIS.this_cDopes     = TratarNulo(Dopes, "C")
                    THIS.this_cDopcs     = TratarNulo(Dopcs, "C")
                    THIS.this_nNumcs     = TratarNulo(Numcs, "N")
                    THIS.this_lConcs     = (TratarNulo(Concs, "N") = 1)
                    THIS.this_cUsuConcs  = TratarNulo(Usuconcs, "C")
                    THIS.this_cAuditors  = TratarNulo(Auditors, "C")
                    THIS.this_dDtAudits  = TratarNulo(DtAudits, "D")
                    THIS.this_cTipo      = TratarNulo(Tipos, "C")
                    THIS.this_cVOpers    = TratarNulo(Vopers, "C")
                    THIS.this_cSGrupos   = TratarNulo(SGrupos, "C")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_LancTemp")
                USE IN cursor_4c_LancTemp
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_LancTemp")
                USE IN cursor_4c_LancTemp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE ProcessaSaldo(par_cTipo, par_cGrupo, par_cMoeda, ;
                                   par_nOrdem, par_lAscendente, par_cSitua, ;
                                   par_nOptFiltro, par_lImprimeSaldoZero)
    *==========================================================================
    *-- Gera relatorio de Saldos de Conta Corrente
    *-- par_cTipo          : 'I'=Impressora  'V'=Video/Preview  'E'=Excel
    *-- par_cGrupo         : codigo do grupo
    *-- par_cMoeda         : codigo da moeda (vazio = todas)
    *-- par_nOrdem         : 1=Nome  2=Codigo  3=Saldo
    *-- par_lAscendente    : .T. = ascendente
    *-- par_cSitua         : codigo da situacao (vazio = todas)
    *-- par_nOptFiltro     : 1=Todos  2=Devedores  3=Credores
    *-- par_lImprimeSaldoZero: .T. = inclui contas com saldo zero
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cFiltroMoeda, loc_cFiltroSitua, loc_cFiltroSaldo
        LOCAL loc_cOrdem, loc_cDirecao, loc_cArqRel, loc_cSaida
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Filtros opcionais
            loc_cFiltroMoeda = ""
            IF !EMPTY(ALLTRIM(par_cMoeda))
                loc_cFiltroMoeda = " AND a.Moedas = " + EscaparSQL(ALLTRIM(par_cMoeda))
            ENDIF

            loc_cFiltroSitua = ""
            IF !EMPTY(ALLTRIM(par_cSitua))
                loc_cFiltroSitua = " AND b.Situas = " + EscaparSQL(ALLTRIM(par_cSitua))
            ENDIF

            DO CASE
                CASE par_nOptFiltro = 2
                    loc_cFiltroSaldo = " AND a.Saldos > 0"
                CASE par_nOptFiltro = 3
                    loc_cFiltroSaldo = " AND a.Saldos < 0"
                OTHERWISE
                    loc_cFiltroSaldo = IIF(!par_lImprimeSaldoZero, " AND a.Saldos <> 0", "")
            ENDCASE

            *-- Criterio de ordenacao
            DO CASE
                CASE par_nOrdem = 2
                    loc_cOrdem = "a.Contas"
                CASE par_nOrdem = 3
                    loc_cOrdem = "a.Saldos"
                OTHERWISE
                    loc_cOrdem = "b.RClis"
            ENDCASE
            loc_cDirecao = IIF(par_lAscendente, " ASC", " DESC")

            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                       "b.RClis, b.Situas, b.Cpfs, b.ContaMats " + ;
                       "FROM SigMvSlc a " + ;
                       "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                       "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                       loc_cFiltroMoeda + loc_cFiltroSitua + loc_cFiltroSaldo + ;
                       " ORDER BY " + loc_cOrdem + loc_cDirecao

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelSaldo")
            IF loc_nRet < 1
                MsgErro("Erro ao gerar dados do relat" + CHR(243) + "rio.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Definir tipo de saida e arquivo
            loc_cArqRel = gc_4c_CaminhoReports + "RelSigOpIndSaldo.frx"
            DO CASE
                CASE par_cTipo = "I"
                    loc_cSaida = "TO PRINT PROMPT NOCONSOLE"
                CASE par_cTipo = "E"
                    loc_cSaida = "TO FILE " + gc_4c_CaminhoBase + "RelSaldo.xls TYPE XL5 PROMPT NOCONSOLE"
                OTHERWISE
                    loc_cSaida = "PREVIEW NOCONSOLE"
            ENDCASE

            REPORT FORM (loc_cArqRel) &loc_cSaida

            IF USED("cursor_4c_RelSaldo")
                USE IN cursor_4c_RelSaldo
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_RelSaldo")
                USE IN cursor_4c_RelSaldo
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE ProcessaHist(par_cTipo, par_cGrupo, par_cConta, ;
                                  par_cMoeda, par_dDataI, par_dDataF, ;
                                  par_cEmp, par_cGetOper, par_nCmbConcilia, ;
                                  par_lChkGrupo, par_lCheckSalto, ;
                                  par_lCheckSAnt, par_lCheckRazaoCP, ;
                                  par_lCheckRazaoDoc, par_lCheckComissao, ;
                                  par_lCheckSaldoa, par_lChkTaxas, ;
                                  par_lChkRelDets, par_nOptSNA, ;
                                  par_lChkOcultaCta)
    *==========================================================================
    *-- Gera relatorio de Historico de Conta Corrente
    *-- par_cTipo    : 'I'=Impressora  'V'=Video/Preview  'E'=Excel
    *-- par_lChkGrupo: .T. = todas as contas do grupo / .F. = conta individual
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cGruConMoe, loc_cFiltroEmp, loc_cFiltroOper
        LOCAL loc_cEscopo, loc_cArqRel, loc_cSaida
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Validacoes obrigatorias
            IF EMPTY(ALLTRIM(par_cMoeda))
                MsgAviso("A Moeda N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF EMPTY(par_dDataI)
                MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF EMPTY(par_dDataF)
                MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF
            IF par_dDataF < par_dDataI
                MsgAviso("Data Final menor que Data Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Chave composta gruconmoes: grupo(10) + conta(10) + moeda(3)
            loc_cGruConMoe = PADR(ALLTRIM(par_cGrupo), 10) + ;
                             PADR(ALLTRIM(par_cConta), 10) + ;
                             PADR(ALLTRIM(par_cMoeda), 3)

            *-- Filtros opcionais
            loc_cFiltroEmp = ""
            IF !EMPTY(ALLTRIM(par_cEmp))
                loc_cFiltroEmp = " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmp))
            ENDIF

            loc_cFiltroOper = ""
            IF !EMPTY(ALLTRIM(par_cGetOper)) AND !ALLTRIM(par_cGetOper) = " "
                loc_cFiltroOper = " AND a.Opers = " + EscaparSQL(UPPER(ALLTRIM(par_cGetOper)))
            ENDIF

            *-- Escopo: conta individual ou todas do grupo
            IF par_lChkGrupo
                loc_cEscopo = "a.Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                              " AND a.Moedas = " + EscaparSQL(ALLTRIM(par_cMoeda))
            ELSE
                loc_cEscopo = "a.GruConMoes = " + EscaparSQL(loc_cGruConMoe)
            ENDIF

            *-- Ordenacao: por conta (grupo) ou por data (individual)
            *-- Filtro de conciliacao aplicado localmente apos carga (como no original)
            IF par_lChkGrupo
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                           "a.Datas, a.Dataconcs, a.Hists, a.Valors, a.Saldos, " + ;
                           "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                           "a.Concs, a.Usuconcs, a.Auditors, a.DtAudits, a.Tipos, " + ;
                           "a.Vopers, a.Titulos, a.Nfs, a.Empos, b.RClis " + ;
                           "FROM SigMvCcr a " + ;
                           "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                           "WHERE " + loc_cEscopo + ;
                           " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                           " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                           loc_cFiltroEmp + loc_cFiltroOper + ;
                           " ORDER BY a.Contas, a.Datas, a.Nopers"
            ELSE
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                           "a.Datas, a.Dataconcs, a.Hists, a.Valors, a.Saldos, " + ;
                           "a.Opers, a.Nopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs, " + ;
                           "a.Concs, a.Usuconcs, a.Auditors, a.DtAudits, a.Tipos, " + ;
                           "a.Vopers, a.Titulos, a.Nfs, a.Empos, b.RClis " + ;
                           "FROM SigMvCcr a " + ;
                           "INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                           "WHERE " + loc_cEscopo + ;
                           " AND a.Datas >= " + FormatarDataSQL(par_dDataI) + ;
                           " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(par_dDataF) + ")" + ;
                           loc_cFiltroEmp + loc_cFiltroOper + ;
                           " ORDER BY a.Datas, a.Nopers"
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelHistorico")
            IF loc_nRet < 1
                MsgErro("Erro ao gerar dados do relat" + CHR(243) + "rio.", "Erro")
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Aplicar filtro de conciliacao localmente (como no original: Delete Where Concs)
            SELECT cursor_4c_RelHistorico
            DO CASE
                CASE par_nCmbConcilia = 1
                    SET FILTER TO !Concs
                CASE par_nCmbConcilia = 2
                    SET FILTER TO Concs
                OTHERWISE
                    SET FILTER TO
            ENDCASE
            GO TOP

            *-- Arquivo de relatorio e tipo de saida
            loc_cArqRel = gc_4c_CaminhoReports + "RelSigOpIndHist.frx"
            DO CASE
                CASE par_cTipo = "I"
                    loc_cSaida = "TO PRINT PROMPT NOCONSOLE"
                CASE par_cTipo = "E"
                    loc_cSaida = "TO FILE " + gc_4c_CaminhoBase + "RelHistorico.xls TYPE XL5 PROMPT NOCONSOLE"
                OTHERWISE
                    loc_cSaida = "PREVIEW NOCONSOLE"
            ENDCASE

            REPORT FORM (loc_cArqRel) &loc_cSaida

            IF USED("cursor_4c_RelHistorico")
                USE IN cursor_4c_RelHistorico
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_RelHistorico")
                USE IN cursor_4c_RelHistorico
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
