*==============================================================================
* lchBO.prg - Business Object para Lote de Cheques
* Herda de BusinessBase
* Tabela Principal : SigChLcq
* Chave Primaria   : NumLotes (numeric)
* Cursor de Dados  : cursor_4c_Dados
* Form relacionado : Formlch.prg
*==============================================================================

DEFINE CLASS lchBO AS BusinessBase

    *==========================================================================
    * PROPRIEDADES - TABELA SigChLcq (campos diretos)
    *==========================================================================

    *-- Identificacao do Lote
    this_nNumLotes    = 0      && PK - Numero do Lote
    this_nNumLoteFPs  = 0      && Numero do Lote de Parcelas vinculado

    *-- Operacao e configuracao
    this_cCodigos     = ""     && Codigo da Operacao (SigCdOpt.Operacao)
    this_cEmps        = ""     && Empresa C(3)
    this_cUsuar       = ""     && Usuario que criou/alterou

    *-- Moeda e valores financeiros
    this_cMoeds       = ""     && Codigo da Moeda
    this_nCotas       = 0      && Cotacao da Moeda
    this_cCotUsus     = ""     && Cotacao definida pelo Usuario (char(10) em SigChLcq)
    this_nValTots     = 0      && Valor Total em Moeda Original
    this_nValConvs    = 0      && Valor Total Convertido (ValTots / Cotas)

    *-- Datas
    this_dDtEnts      = {}     && Data de Entrada do Lote
    this_dDataTrans   = {}     && Data de Transporte (nullable em SigChLcq)

    *-- Grupo e Conta Destino (campos da tabela SigChLcq)
    this_cGrupos      = ""     && Grupo de Destino
    this_cContas      = ""     && Conta de Destino

    *-- Cliente Emissor (vinculo com SigCdCli)
    this_cIclis       = ""     && Codigo do Cliente Emissor
    this_cGrclis      = ""     && Grupo do Cliente Emissor

    *-- Quantidade e identificadores auxiliares
    this_nQtdeCheqs   = 0      && Quantidade de Cheques no Lote
    this_nOrdens      = 0      && Tipo de Ordens (de SigCdOpt.Ordens)

    *-- Observacoes e follow up
    this_cObss        = ""     && Observacoes gerais do Lote
    this_cFollowUp    = ""     && Texto do Follow Up
    this_lFollowUp    = .F.    && Flag Repetir Follow Up

    *==========================================================================
    * PROPRIEDADES - DESTINO (com descricoes para a UI)
    * Campos do container CntDestino (Page2)
    *==========================================================================

    this_cGruDest     = ""     && Grupo Destino (Get_Grupo em CntDestino)
    this_cConDest     = ""     && Conta Destino (Get_Conta em CntDestino)
    this_cDGruDest    = ""     && Descricao do Grupo Destino
    this_cDConDest    = ""     && Descricao da Conta Destino
    this_cCpfDest     = ""     && CPF quando destino e pessoa fisica

    *==========================================================================
    * PROPRIEDADES - ORIGEM
    * Campos do container CntOrigem (Page2)
    *==========================================================================

    this_cGruOrig     = ""     && Grupo de Origem (Get_GruOrig)
    this_cConOrig     = ""     && Conta de Origem (Get_ConOrig)
    this_cDGruOrig    = ""     && Descricao do Grupo de Origem
    this_cDConOrig    = ""     && Descricao da Conta de Origem
    this_cCpfOrig     = ""     && CPF da Origem

    *==========================================================================
    * PROPRIEDADES - CARTEIRA
    * Campos do container CntCarteira (Page2)
    *==========================================================================

    this_cGruCart     = ""     && Grupo de Carteira (Get_GruCart)
    this_cConCart     = ""     && Conta de Carteira (Get_ConCart)
    this_cDGruCart    = ""     && Descricao do Grupo de Carteira
    this_cDConCart    = ""     && Descricao da Conta de Carteira

    *==========================================================================
    * PROPRIEDADES - EMISSOR
    * Campos do container CntEmissor (Page2)
    *==========================================================================

    this_cGruEmiss    = ""     && Grupo do Emissor (Get_GruEmiss)
    this_cConEmiss    = ""     && Conta do Emissor (Get_ConEmiss)
    this_cDGruEmiss   = ""     && Descricao do Grupo do Emissor
    this_cDConEmiss   = ""     && Descricao da Conta do Emissor
    this_cCpfEmiss    = ""     && CPF do Emissor (Get_Cpf em CntEmissor)
    this_cNomeEmiss   = ""     && Nome do Emissor (Rclis de SigCdCli)

    *==========================================================================
    * PROPRIEDADES - DESPESA
    * Campos do container cntDespesa (Page2)
    *==========================================================================

    this_cGruEmts     = ""     && Grupo de Despesa (Get_GruEmts)
    this_cConEmts     = ""     && Conta de Despesa (Get_ConEmts)
    this_cDGruEmts    = ""     && Descricao do Grupo de Despesa
    this_cDConEmts    = ""     && Descricao da Conta de Despesa
    this_cCpfEmts     = ""     && CPF da Despesa

    *==========================================================================
    * PROPRIEDADES - CENTRO DE CUSTO
    * Campos do container CntCCusto (Page2)
    *==========================================================================

    this_cGruCCs      = ""     && Grupo de Centro de Custo (Get_GrupoCcs)
    this_cConCCs      = ""     && Conta de Centro de Custo (Get_ContaCcs)
    this_cDGruCCs     = ""     && Descricao do Grupo CC
    this_cDConCCs     = ""     && Descricao da Conta CC
    this_cCpfCCs      = ""     && CPF do Centro de Custo

    *==========================================================================
    * PROPRIEDADES - RESPONSAVEL
    * Campos do container CntResponsavel (Page2)
    *==========================================================================

    this_cGruRes      = ""     && Grupo do Responsavel (Get_GruRes)
    this_cConRes      = ""     && Conta do Responsavel (Get_ConRes)
    this_cDConRes     = ""     && Descricao da Conta do Responsavel

    *==========================================================================
    * PROPRIEDADES - EMPRESA (descricao para exibicao)
    *==========================================================================

    this_cDEmps       = ""     && Razao Social / Descricao da Empresa

    *==========================================================================
    * PROPRIEDADES - CONTA DO CLIENTE/EMISSOR (CntConta)
    * Container na parte inferior da Page2 para identificacao do emissor
    *==========================================================================

    this_cContaIclis  = ""     && Conta/Iclis do Emissor (Get_Conta em CntConta)
    this_cCpfIclis    = ""     && CPF do Emissor (Get_CPF em CntConta)
    this_cNomeIclis   = ""     && Nome do Emissor (Get_Nome em CntConta)

    *==========================================================================
    * PROPRIEDADES - PROCESSAMENTO EM LOTE
    * Campos do container CntProcessa (Page2) - processamento automatico
    *==========================================================================

    this_dDtIniProc   = {}     && Data Inicial do Processamento
    this_dDtFimProc   = {}     && Data Final do Processamento
    this_nLoteProc    = 0      && Numero do Lote para Processamento
    this_cEmpProc     = ""     && Empresa para Processamento em Lote
    this_cPlanilha    = ""     && Caminho completo da Planilha Excel (.XLS)

    *==========================================================================
    * PROPRIEDADES - FILTROS DE LISTAGEM (Page1)
    * Campos do cntFiltros na Page1 (lista de lotes)
    *==========================================================================

    this_dDataFiltroI = {}     && Data Inicial do Filtro (Dt_inicial)
    this_dDataFiltroF = {}     && Data Final do Filtro (Dt_final)
    this_nFiltroConc  = 0      && Filtro Conciliacao: 0=Todos, 1=Conciliados, 2=Pendentes, 3=Ambos
    this_cFiltClasemp = ""     && Filtro por Classe Empresarial (Get_Clasemp)

    *==========================================================================
    * PROPRIEDADES - CURSOR DE DADOS
    *==========================================================================

    this_cCursorDados = "cursor_4c_Dados"   && Cursor principal para listagem de lotes

    *==========================================================================
    * INIT - Configuracao da tabela principal
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChLcq"
            THIS.this_cCampoChave = "NumLotes"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar lchBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(STR(THIS.this_nNumLotes, 10))
    ENDFUNC

    *==========================================================================
    * Buscar - Lista lotes de cheques com filtros opcionais
    * par_cFiltro: condicoes WHERE adicionais (ex: "AND a.dtents >= '2024-01-01'")
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.codigos, a.emps, a.dtents, a.datas," + ;
                " a.datatrans, a.moeds, a.cotas, a.valtots, a.valconvs," + ;
                " a.grupos, a.contas, a.gruorigs, a.conorigs," + ;
                " a.grucarts, a.concarts, a.iclis, a.grclis, a.usuarios," + ;
                " a.concs, a.numloteFps, a.cotusus," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.obs" + ;
                " FROM SigChLcq a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.dtents DESC, a.numlotes DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega lote pelo numlotes (PK)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.numloteFps, a.codigos, a.emps, a.usuarios," + ;
                " a.moeds, a.cotas, a.cotusus, a.valtots, a.valconvs," + ;
                " a.dtents, a.datatrans, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.iclis, a.grclis, a.concs, a.obs," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.tipos, a.nums," + ;
                " a.numdopes, a.dopes, a.empdopnums, a.cnotas, a.locals, a.ntrans" + ;
                " FROM SigChLcq a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLotes)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLotes    = TratarNulo(numlotes,   "N")
            THIS.this_nNumLoteFPs  = TratarNulo(numloteFps, "N")
            THIS.this_cCodigos     = TratarNulo(codigos,    "C")
            THIS.this_cEmps        = TratarNulo(emps,       "C")
            THIS.this_cUsuar       = TratarNulo(usuarios,   "C")
            THIS.this_cMoeds       = TratarNulo(moeds,      "C")
            THIS.this_nCotas       = TratarNulo(cotas,      "N")
            THIS.this_cCotUsus     = TratarNulo(cotusus,    "C")
            THIS.this_nValTots     = TratarNulo(valtots,    "N")
            THIS.this_nValConvs    = TratarNulo(valconvs,   "N")
            THIS.this_dDtEnts      = TratarNulo(dtents,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,  "D")
            THIS.this_cGrupos      = TratarNulo(grupos,     "C")
            THIS.this_cContas      = TratarNulo(contas,     "C")
            THIS.this_cIclis       = TratarNulo(iclis,      "C")
            THIS.this_cGrclis      = TratarNulo(grclis,     "C")
            THIS.this_cObss        = TratarNulo(obs,        "C")
            THIS.this_cGruCart     = TratarNulo(grucarts,   "C")
            THIS.this_cConCart     = TratarNulo(concarts,   "C")
            THIS.this_cGruOrig     = TratarNulo(gruorigs,   "C")
            THIS.this_cConOrig     = TratarNulo(conorigs,   "C")
            THIS.this_cGruCCs      = TratarNulo(grupoccs,   "C")
            THIS.this_cConCCs      = TratarNulo(contaccs,   "C")
            THIS.this_cGruEmts     = TratarNulo(grupems,    "C")
            THIS.this_cConEmts     = TratarNulo(contems,    "C")
            THIS.this_cGruRes      = TratarNulo(gratends,   "C")
            THIS.this_cConRes      = TratarNulo(atends,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarCheques - Carrega cheques do lote em cursor_4c_Cheques (grid Page2)
    *==========================================================================
    FUNCTION BuscarCheques(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.nums, a.bancos, a.agencias, a.ncontas, a.ncheques," + ;
                " a.valors, a.valpags, a.vencs, a.datas, a.dtemis, a.nalineas," + ;
                " a.emps, a.iclis, a.grclis, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.grures, a.conres, a.protocolos, a.leituras, a.numeros" + ;
                " FROM SIGCHE a" + ;
                " WHERE a.numos = " + FormatarNumeroSQL(par_nNumLotes) + ;
                " ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

            IF USED("cursor_4c_Cheques")
                USE IN cursor_4c_Cheques
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cheques")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar cheques do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.this_nQtdeCheqs = RECCOUNT("cursor_4c_Cheques")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.BuscarCheques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterProximoLote - Retorna proximo numlotes disponivel para a empresa
    *==========================================================================
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigChLcq" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo
        loc_lSucesso = .F.

        TRY
            loc_nProximo = THIS.ObterProximoLote()
            THIS.this_nNumLotes = loc_nProximo

            loc_cSQL = "INSERT INTO SigChLcq (" + ;
                " numlotes, numloteFps, codigos, emps, usuarios, moeds, cotas, cotusus," + ;
                " valtots, valconvs, dtents, datatrans, grupos, contas," + ;
                " iclis, grclis, obs, concs, grucarts, concarts," + ;
                " gruorigs, conorigs, grupoccs, contaccs, grupems, contems," + ;
                " gratends, atends, autos, tipos, nums, numdopes, dopes," + ;
                " empdopnums, cnotas, locals, ntrans, dtsis)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLotes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumLoteFPs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                "0," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConRes)) + "," + ;
                "0,'','',0,'','',0,0,GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigChLcq SET" + ;
                " codigos = "   + EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                " emps = "      + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                " cotusus = "   + EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                " dtents = "    + FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                " datatrans = " + IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                " grupos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                " contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                " iclis = "     + EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                " grclis = "    + EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                " obs = "       + EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                " grucarts = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                " concarts = "  + EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                " gruorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                " conorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                " grupoccs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                " contaccs = "  + EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                " grupems = "   + EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                " contems = "   + EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                " gratends = "  + EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                " atends = "    + EscaparSQL(ALLTRIM(THIS.this_cConRes)) + ;
                " WHERE numlotes = " + FormatarNumeroSQL(THIS.this_nNumLotes)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de cheques (SIGCHE) e do lote (SigChLcq)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigChLcq WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
