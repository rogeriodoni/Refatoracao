*============================================================================
* SigOpChiBO.prg - Business Object para Historico de Cheques
*
* Tabela principal : SigChe    (PK: Nums char(8) - numero sequencial do cheque)
* Tabela detalhe    : SigCqChm (FK: Nums - movimentos/followup do cheque)
* Lookup conta      : SigCdCli (PK: Iclis, desc: Rclis, doc: Cpfs)
*
* Form OPERACIONAL (consulta/historico) - sem Inserir/Atualizar/Excluir.
* Filtra cheques por conta (Origem) ou por conta do Emitente, dentro de um
* periodo de vencimento, e exibe tres grades: Cheque, Movimentacao e
* Prorrogacoes, alem do ultimo Followup registrado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpChiBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigChe (todas as colunas - cheque selecionado
    * na GradeCheque da pagina Historico). Nums eh char(8) NO BANCO - NUNCA
    * numerico (conferido em docs/schema.sql: CONSTRAINT sigche_nums PK em
    * [nums] char(8)).
    *==========================================================================
    this_cNums      = ""    && char(8)  - PK do cheque selecionado na grade
    this_cEmps      = ""    && char(3)  - Empresa do cheque selecionado
    this_cBancos    = ""    && char(3)
    this_cAgencias  = ""    && char(4)
    this_lAutos     = .F.   && bit
    this_cConCarts  = ""    && char(10) - Conta Carteira
    this_cConOrigs  = ""    && char(10) - Conta Origem
    this_cConRes    = ""    && char(10)
    this_cContas    = ""    && char(10)
    this_cCopchs    = ""    && char(15)
    this_dDatas     = {}    && datetime
    this_dDataTrans = {}    && datetime
    this_cFpags     = ""    && char(12)
    this_cGrClis    = ""    && char(10) - Grupo do cliente
    this_cGruCarts  = ""    && char(10) - Grupo Carteira
    this_cGruOrigs  = ""    && char(10) - Grupo Origem
    this_cGrupos    = ""    && char(10)
    this_cGrures    = ""    && char(10)
    this_cGrvends   = ""    && char(10)
    this_cIClis     = ""    && char(10) - Codigo do cliente/conta
    this_cLeituras  = ""    && char(34)
    this_cLocals    = ""    && char(10)
    this_nNalineas  = 0     && numeric(3,0)
    this_cNCheques  = ""    && char(6)
    this_cNContas   = ""    && char(10)
    this_cNotas     = ""    && char(6)
    this_nNtrans    = 0     && numeric(6,0)
    this_cNumeros   = ""    && char(6)
    this_cNumolds   = ""    && char(8)
    this_nNumos     = 0     && numeric(8,0)
    this_cProtocolos = ""   && char(8)
    this_cUMovs     = ""    && char(15) - Ultimo Movimento
    this_nValors    = 0     && numeric(11,2)
    this_nValpags   = 0     && numeric(11,2)
    this_dVencs     = {}    && datetime
    this_cVends     = ""    && char(10)
    this_dDtEmis    = {}    && datetime
    this_dDtAlts    = {}    && datetime
    this_cContat    = ""    && char(10)
    this_cGrupot    = ""    && char(10)
    this_nCotas     = 0     && numeric(11,4)
    this_cMoeds     = ""    && char(3)
    this_nTipoBlq   = 0     && numeric(1,0)
    this_cCustodia  = ""    && char(4)

    *==========================================================================
    * Filtro por Conta de Origem (Pagina.Filtro.Origem)
    *==========================================================================
    this_cContaOrigem     = ""    && Iclis digitado/selecionado
    this_cDContaOrigem    = ""    && Rclis (descricao/nome da conta)
    this_cCpfOrigem       = ""    && Cpfs (CPF/CNPJ da conta)
    this_nTipoFiltroOrigem = 1    && optFiltro.Value: 1=Conta exata, 2=Com Filtro (LIKE)

    *==========================================================================
    * Filtro por Conta do Emitente (Pagina.Historico.Emitente)
    *==========================================================================
    this_cContaEmitente   = ""    && Iclis do emitente
    this_cDContaEmitente  = ""    && Rclis do emitente
    this_cCpfEmitente     = ""    && Cpfs do emitente

    *==========================================================================
    * Filtro por Periodo de Vencimento (Cnt_periodo)
    *==========================================================================
    this_dDataInicial = {}    && Dt_inicial.Value
    this_dDataFinal   = {}    && Dt_final.Value

    *==========================================================================
    * Estado de acesso e navegacao
    *==========================================================================
    this_cAcesso      = "TOTAL"    && Parametro pcAcesso recebido na abertura
    this_lAcesso      = .T.        && INLIST(this_cAcesso,'TOTAL','CARTEIRA')
    this_lFiltrado    = .F.        && .T. quando a Lista foi filtrada por uma conta
    this_cCaptionAtual = ""        && Caption dinamico ("Historico de Cheques de: ...")
    this_cUltimoFollowup = ""      && Texto do ultimo followup do cheque selecionado

    *==========================================================================
    * Alias dos cursores usados pelas grades e pelos lookups
    *==========================================================================
    this_cCursorCheque      = "cursor_4c_Cheque"       && GradeCheque      (SigChe)
    this_cCursorMovimento   = "cursor_4c_Movimento"    && GradeMovimenta   (SigCqChm)
    this_cCursorProrrog     = "cursor_4c_Prorrog"      && GradeProrrog     (prorrogacoes)
    this_cCursorChequeMov   = "cursor_4c_ChequeMov"    && Detalhe do cheque selecionado
    this_cCursorCliente     = "cursor_4c_Cliente"      && Lookup SigCdCli (conta/emitente)
    this_cCursorProtocolo   = "cursor_4c_Protocolo"    && TempChq (impressao de protocolo)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "Nums"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do cheque selecionado
    * na GradeCheque, usada por RegistrarAuditoria (via BusinessBase) caso
    * algum passo futuro do historico precise identificar o registro.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigChe para as
    * propriedades do BO. Alimentado pelo cursor que fica posicionado no
    * cheque corrente da GradeCheque (Pagina.Historico) apos o usuario
    * selecionar uma linha - equivalente ao acesso direto a crSigChe.<col>
    * que o legado faz em Grupo_op.Click (Relatorio/Documento/Prorroga/
    * FollowUp/Protocolo/Carteira) e em GradeCheque.AfterRowColChange.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cNums       = TratarNulo(Nums, "C")
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_cBancos     = TratarNulo(Bancos, "C")
            THIS.this_cAgencias   = TratarNulo(Agencias, "C")
            THIS.this_lAutos      = ConverterParaLogico(Autos)
            THIS.this_cConCarts   = TratarNulo(ConCarts, "C")
            THIS.this_cConOrigs   = TratarNulo(ConOrigs, "C")
            THIS.this_cConRes     = TratarNulo(ConRes, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cCopchs     = TratarNulo(Copchs, "C")
            THIS.this_dDatas      = ConverterParaData(Datas)
            THIS.this_dDataTrans  = ConverterParaData(DataTrans)
            THIS.this_cFpags      = TratarNulo(Fpags, "C")
            THIS.this_cGrClis     = TratarNulo(GrClis, "C")
            THIS.this_cGruCarts   = TratarNulo(GruCarts, "C")
            THIS.this_cGruOrigs   = TratarNulo(GruOrigs, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cGrures     = TratarNulo(Grures, "C")
            THIS.this_cGrvends    = TratarNulo(Grvends, "C")
            THIS.this_cIClis      = TratarNulo(Iclis, "C")
            THIS.this_cLeituras   = TratarNulo(Leituras, "C")
            THIS.this_cLocals     = TratarNulo(Locals, "C")
            THIS.this_nNalineas   = NVL(Nalineas, 0)
            THIS.this_cNCheques   = TratarNulo(NCheques, "C")
            THIS.this_cNContas    = TratarNulo(NContas, "C")
            THIS.this_cNotas      = TratarNulo(Notas, "C")
            THIS.this_nNtrans     = NVL(Ntrans, 0)
            THIS.this_cNumeros    = TratarNulo(Numeros, "C")
            THIS.this_cNumolds    = TratarNulo(Numolds, "C")
            THIS.this_nNumos      = NVL(Numos, 0)
            THIS.this_cProtocolos = TratarNulo(Protocolos, "C")
            THIS.this_cUMovs      = TratarNulo(UMovs, "C")
            THIS.this_nValors     = NVL(Valors, 0)
            THIS.this_nValpags    = NVL(Valpags, 0)
            THIS.this_dVencs      = ConverterParaData(Vencs)
            THIS.this_cVends      = TratarNulo(Vends, "C")
            THIS.this_dDtEmis     = ConverterParaData(DtEmis)
            THIS.this_dDtAlts     = ConverterParaData(DtAlts)
            THIS.this_cContat     = TratarNulo(Contat, "C")
            THIS.this_cGrupot     = TratarNulo(Grupot, "C")
            THIS.this_nCotas      = NVL(Cotas, 0)
            THIS.this_cMoeds      = TratarNulo(Moeds, "C")
            THIS.this_nTipoBlq    = NVL(TipoBlq, 0)
            THIS.this_cCustodia   = TratarNulo(Custodia, "C")

            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *==========================================================================
    * SigOpChi (Historico de Cheques) eh um form de CONSULTA: o legado
    * (SIGOPCHI) nao faz Insert/Update/Delete em SigChe por esta tela - o
    * usuario apenas filtra por conta/periodo e navega para os formularios
    * de detalhe (SigOpChr, SigOpChb, SigOpChp, SigOpFlp, SigOpChc), que sao
    * os responsaveis por qualquer gravacao. Por isso o comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao)
    * ja eh o correto para este BO.
    *==========================================================================

ENDDEFINE
