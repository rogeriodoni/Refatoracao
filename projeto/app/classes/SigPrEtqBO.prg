*==============================================================================
* SigPrEtqBO.prg - Business Object para Impressao de Etiquetas Selecionadas
* Herda de: BusinessBase
* Origem legado: SIGPRETQ.SCX (form OPERACIONAL, sem CRUD proprio)
* Tabela de referencia: SigCdPro (produtos que recebem etiqueta)
*==============================================================================
DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Identificacao da movimentacao (getEmps / getDopes / getNumes)
    this_cEmps            = ""   && Empresa (SigCdEmp.Cemps, char(3))
    this_cDopes           = ""   && Operacao de movimento (SigCdOpe.Dopes)
    this_cNumes           = ""   && Numero da movimentacao

    *-- Listas de preco (getLPreco / getLPreco2 - lookup SigCdLpc.LPrecos)
    this_cLPreco          = ""   && Lista de preco principal
    this_cLPreco2         = ""   && Lista de preco secundaria

    *-- Flags de carga de itens (chkLista / chkOperacoes)
    this_lCarregaItensLista     = .T.   && Carrega itens da Lista de Precos
    this_lCarregaItensOperacao  = .T.   && Carrega itens da Movimentacao

    *-- Opcoes de impressao de etiqueta (OptionGroups - valor = indice do botao)
    this_nTipoEtiqueta    = 1    && Opt_Tipo (tipo de etiqueta)
    this_nTipoImpressora  = 1    && Opt_Impressora (impressora especial)
    this_nOpcaoImp        = 1    && Cnt_Impressora.Opcao_imp
    this_nSeparador       = 1    && opt_separador
    this_nOrdem           = 1    && OptOrdem
    this_nPeso            = 1    && opt_peso
    this_nComposicao      = 1    && optCompos
    this_nPreco           = 1    && opt_Preco

    *-- Ajustes finos de impressao (Cnt_Impressora.Spn_*)
    this_nAjVerts         = 0    && Ajuste vertical
    this_nAjHorzs         = 0    && Ajuste horizontal
    this_nAjDenss         = 0    && Ajuste de densidade
    this_nAjVelos         = 0    && Ajuste de velocidade

    *-- Impressora do sistema Windows (Get_Printer - combobox)
    this_cImpressora      = ""

    *-- Controle interno / grade de etiquetas (dbImpressao no legado)
    this_cCursorDados     = "cursor_4c_Dados"
    this_lResultadoOk     = .F.
    this_cMensagemErro    = ""

    *-- Espelho da linha corrente do cursor de grade (dbImpressao no legado)
    *-- Preenchido por CarregarDoCursor() - mesma ordem/nomes do CREATE CURSOR
    *-- dbImpressao declarado no Load() do form legado.
    this_cCpros           = ""   && Codigo do produto (SigCdPro.CPros, char(14))
    this_cDPros           = ""   && Descricao do produto
    this_cReffs           = ""   && Referencia do fornecedor
    this_nQtds            = 0    && Quantidade apurada
    this_nQtdeEtiq        = 0    && Quantidade de etiquetas a imprimir
    this_cPedido          = ""   && Pedido/origem do item (Obs de lista de preco)
    this_cObs             = ""   && Observacao (lista de preco aplicada)
    this_nPVens           = 0    && Preco de venda
    this_nPrecoDe         = 0    && Preco "De" (preco cheio antes do desconto)
    this_nParcelas        = 0    && Numero de parcelas
    this_cCpros2          = ""   && Produto complementar 2 (combo/kit)
    this_cCpros3          = ""   && Produto complementar 3
    this_cCpros4          = ""   && Produto complementar 4
    this_cEmpos           = ""   && Empresa de origem do item
    this_cEmpDopNums      = ""   && Chave posicional Emps+Dopes+Numes (char(29))
    this_nCitens          = 0    && Numero do item na movimentacao (SigMvItn.Citens)
    this_nPesos           = 0    && Peso do produto (SigCdPro.PesoMs)
    this_cCodTams         = ""   && Codigo do tamanho (SigCdPro.CodTams)
    this_cDPro2s          = ""   && Descritivo do produto (SigCdPro.Dpro2s)

    *============================================================================
    PROCEDURE Init()
    *============================================================================
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *============================================================================
    * CarregarDoCursor - Mapeia uma linha do cursor de grade de etiquetas
    * (equivalente ao dbImpressao do legado) para as properties this_*.
    * par_cAliasCursor: alias do cursor posicionado na linha a carregar.
    *============================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCpros          = TratarNulo(Cpros, "")
        THIS.this_cDPros          = TratarNulo(DPros, "")
        THIS.this_cReffs          = TratarNulo(Reffs, "")
        THIS.this_nQtds           = TratarNulo(Qtds, 0)
        THIS.this_nQtdeEtiq       = TratarNulo(QtdeEtiq, 0)
        THIS.this_cPedido         = TratarNulo(Pedido, "")
        THIS.this_cObs            = TratarNulo(Obs, "")
        THIS.this_nPVens          = TratarNulo(PVens, 0)
        THIS.this_nPrecoDe        = TratarNulo(PrecoDe, 0)
        THIS.this_nParcelas       = TratarNulo(Parcelas, 0)
        THIS.this_cCpros2         = TratarNulo(Cpros2, "")
        THIS.this_cCpros3         = TratarNulo(Cpros3, "")
        THIS.this_cCpros4         = TratarNulo(Cpros4, "")
        THIS.this_cEmpos          = TratarNulo(empos, "")
        THIS.this_cEmpDopNums     = TratarNulo(empdopnums, "")
        THIS.this_nCitens         = TratarNulo(citens, 0)
        THIS.this_nPesos          = TratarNulo(Pesos, 0)
        THIS.this_cCodTams        = TratarNulo(CodTams, "")
        THIS.this_cDPro2s         = TratarNulo(DPro2s, "")

        RETURN .T.
    ENDFUNC

    *============================================================================
    * ObterChavePrimaria - Chave da linha corrente da grade (produto)
    *============================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *============================================================================
    * Este BO NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao().
    *
    * O legado nao grava a selecao de etiquetas via INSERT/UPDATE/DELETE de
    * registro: dbImpressao eh um cursor 100% em memoria, populado a partir de
    * SigMvItn/SigCdLpi (metodos BuscarItensMovimento/BuscarItensListaPreco
    * abaixo) e a "gravacao" da tela eh a rotina de impressao de etiqueta
    * (SigOpEtq no legado) seguida de Commit() da conexao - nao um Salvar()
    * de registro no padrao FormBase/BusinessBase. Como este BO nunca chama
    * THIS.Salvar()/THIS.Excluir(), o comportamento padrao herdado de
    * BusinessBase ja eh o correto.
    *============================================================================

    *============================================================================
    * CarregarParametrosEtiqueta - Carrega SigCdPam (parametros gerais de
    * etiqueta) no cursor de destino. Equivale ao 1o CursorQuery do Init legado.
    *============================================================================
    FUNCTION CarregarParametrosEtiqueta(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Pam")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, TpInstalas, " + ;
                   "AjVerts, AjHorzs, TpCBars, GrPadClis, GrPadVens FROM SigCdPam"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * CarregarParametrosImpressao - Carrega SigCdPac (ajuste de impressao/
    * separador de etiqueta) no cursor de destino.
    *============================================================================
    FUNCTION CarregarParametrosImpressao(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Pac")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarTiposEtiquetaAtivos - Tipos de etiqueta ativos (SigCdTpe), na
    * mesma ordem usada pelo legado para montar o Opt_Tipo (cOrdems+cEtiquetas).
    *============================================================================
    FUNCTION BuscarTiposEtiquetaAtivos(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_TiposEtiqueta")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT nTipos, cEtiquetas, cOrdems FROM SigCdTpe " + ;
                   "WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarImpressorasAutorizadas - Impressoras de etiqueta (nTpImpres = 2)
    * liberadas para o usuario, por acesso direto (SigSyImp) ou por grupo
    * (SigCdAcG). Transcricao literal do UNION ALL do Init legado.
    *============================================================================
    FUNCTION BuscarImpressorasAutorizadas(par_cUsuario, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_cUsuario

        IF VARTYPE(par_cUsuario) != "C" OR EMPTY(par_cUsuario)
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ImpressorasAutorizadas")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cUsuario = EscaparSQL(ALLTRIM(par_cUsuario))

        loc_cSQL = "SELECT b.Impres FROM SigSyImp a, SigCdmp b " + ;
                   "WHERE a.UsuAcess = " + loc_cUsuario + " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
                   "UNION ALL " + ;
                   "SELECT c.Impres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                   "WHERE a.Usuarios = " + loc_cUsuario + " AND a.Grupos = b.GrAcess " + ;
                   "AND b.CImps = c.Impres AND c.nTpImpres = 2"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarImpressorasEtiqueta - Todas as impressoras de etiqueta cadastradas
    * (SigCdmp.nTpImpres = 2), sem filtro de usuario. Transcricao do FALLBACK
    * do Init legado: quando o UNION ALL de BuscarImpressorasAutorizadas nao
    * devolve nenhuma linha, o legado repete a consulta sem restricao de
    * acesso ("Select Distinct Impres From SigCdmp Where nTpImpres = 2
    * Order By Impres") em vez de deixar a lista vazia.
    *============================================================================
    FUNCTION BuscarImpressorasEtiqueta(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ImpressorasEtiqueta")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
                   "WHERE nTpImpres = 2 ORDER BY Impres"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorEan13 - Localiza produto pelo codigo de barras EAN13.
    *============================================================================
    FUNCTION BuscarProdutoPorEan13(par_nEan, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_nEan) != "N" OR par_nEan <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE Ean13 = " + FormatarNumeroSQL(par_nEan, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorCodigoBarras - Localiza produto pelo codigo de barras
    * interno (CBars), usado quando o valor digitado nao eh um EAN13 valido.
    *============================================================================
    FUNCTION BuscarProdutoPorCodigoBarras(par_nCodigo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_nCodigo) != "N" OR par_nCodigo <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE CBars = " + FormatarNumeroSQL(par_nCodigo, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorCodigo - Localiza produto pelo codigo (CPros).
    *============================================================================
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorDescricao - Localiza produto pela descricao (DPros).
    *============================================================================
    FUNCTION BuscarProdutoPorDescricao(par_cDescricao, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cDescricao) != "C" OR EMPTY(par_cDescricao)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE DPros = " + EscaparSQL(ALLTRIM(par_cDescricao))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorDescritivo - Localiza produto pelo descritivo (Dpro2s,
    * usado como "Referencia Fornecedor"/descritivo no grid de etiquetas).
    *============================================================================
    FUNCTION BuscarProdutoPorDescritivo(par_cDescritivo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cDescritivo) != "C" OR EMPTY(par_cDescritivo)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE Dpro2s = " + EscaparSQL(ALLTRIM(par_cDescritivo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * VerificarUnidadeEtiquetaIndividual - .T. quando a unidade do produto
    * usa etiqueta individual e NAO permite duplicidade (Etiqs = 'S' e
    * EtiqDups <> 1) - nesse caso o legado bloqueia a impressao em lote.
    *============================================================================
    FUNCTION VerificarUnidadeEtiquetaIndividual(par_cCodUnidade)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lBloqueia

        loc_lBloqueia = .F.

        IF VARTYPE(par_cCodUnidade) != "C" OR EMPTY(par_cCodUnidade)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_UnidadeEtiqueta"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Etiqs, EtiqDups FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCodUnidade))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0
            SELECT (loc_cAlias)
            loc_lBloqueia = (ALLTRIM(UPPER(TratarNulo(Etiqs, ""))) == "S") AND (TratarNulo(EtiqDups, 0) <> 1)
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lBloqueia
    ENDFUNC

    *============================================================================
    * BuscarItensMovimento - Itens da movimentacao (SigMvItn) para a chave
    * posicional EmpDopNums (Emps char(3) + Dopes char(20) + Numes STR(,6)),
    * usada pelo botao "Carregar" quando chkOperacoes esta marcado.
    *============================================================================
    FUNCTION BuscarItensMovimento(par_cEmpDopNums, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cEmpDopNums) != "C" OR EMPTY(par_cEmpDopNums)
            THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ItensMovimento")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        *-- Chave POSICIONAL (Emps+Dopes+Numes) - NAO fazer ALLTRIM nas partes
        *-- que compoem par_cEmpDopNums; o padding faz parte da chave.
        loc_cSQL = "SELECT CPros, DPros, Units, Qtds, Citens FROM SigMvItn " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarItensListaPreco - Itens de uma lista de precos (SigCdLpi), usada
    * pelo botao "Carregar"/Valid de Get_lpreco quando chkLista esta marcado.
    *============================================================================
    FUNCTION BuscarItensListaPreco(par_cListaPreco, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco)
            THIS.this_cMensagemErro = "Lista de pre" + CHR(231) + "os n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ItensListaPreco")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs FROM SigCdLpi " + ;
                   "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarPrecoItemListaPreco - Preco de um produto especifico dentro de
    * uma lista de precos (usado nos Valid dos campos da grade).
    *============================================================================
    FUNCTION BuscarPrecoItemListaPreco(par_cListaPreco, par_cCodProduto, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco) ;
           OR VARTYPE(par_cCodProduto) != "C" OR EMPTY(par_cCodProduto)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_PrecoItemLista")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs FROM SigCdLpi " + ;
                   "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30)) + ;
                   " AND CPros = " + EscaparSQL(PADR(ALLTRIM(par_cCodProduto), 14))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * ValidarListaPreco - Confere se a lista de precos existe (SigCdLpc),
    * usado no Valid de Get_lpreco/getLPreco2 antes de abrir o picker.
    *============================================================================
    FUNCTION ValidarListaPreco(par_cListaPreco)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaListaPreco"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos FROM SigCdLpc WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * BuscarOperacaoNumero - Le o NDopes (numero curto da operacao) de
    * SigCdOpe, usado para montar o "lcBop" (chave de impressao) antes de
    * chamar a rotina de impressao de etiqueta.
    *============================================================================
    FUNCTION BuscarOperacaoNumero(par_cCodOperacao, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cCodOperacao) != "C" OR EMPTY(par_cCodOperacao)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_OperacaoNumero")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodOperacao))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * ValidarOperacao - Confere se o codigo de operacao existe em SigCdOpe.
    * Substitui a chamada legado a fAcessoMovmto() (funcao global nao portada).
    *============================================================================
    FUNCTION ValidarOperacao(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaOperacao"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * ValidarEmpresa - Confere se o codigo de empresa existe em SigCdEmp.
    * Substitui a chamada legado a fAcessoEmpresa() (funcao global nao
    * portada - ver licao aprendida sobre fAcessoEmpresa).
    *============================================================================
    FUNCTION ValidarEmpresa(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaEmpresa"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * ImprimirEtiquetas - Envia para impressao as etiquetas selecionadas na
    * grade (cursor_4c_Dados). O motor de impressao do legado (SigOpEtq, em
    * SIGFUNCS.PRG) gera comandos proprietarios ZPL/EPL/Allegro para
    * impressoras termicas especificas e NAO esta no acervo migrado (mesma
    * familia da licao "funcao global do legado nao portada" - regra
    * CLAUDE.md #27). Como o retorno de SigOpEtq eh descartado pelo legado
    * (=SigOpEtq(...)) e o fluxo segue para "Impressao Concluida!!!"
    * seja qual for o resultado interno dela, este metodo substitui por uma
    * impressao de texto generica e FUNCIONAL (via SET DEVICE TO PRINTER),
    * respeitando quantidade por item (QtdeEtiq), impressora selecionada,
    * exibicao de preco e peso, e separador entre etiquetas - sem reproduzir
    * o layout proprietario exato (codigo de barras/posicionamento termico)
    * que so existe no motor original.
    *============================================================================
    FUNCTION ImprimirEtiquetas(par_nImpPreco, par_lImpSepar, par_nTpEti, par_nTpImp, ;
            par_nAjVerts, par_nAjHorzs, par_nAjDenss, par_nAjVelos, par_cNomeImpressora, ;
            par_lImpPeso, par_cBop, par_cLp1, par_cLp2, par_lCompo)

        LOCAL loc_cCursor, loc_nCopia, loc_nQtdImpressa, loc_lSucesso, loc_oErro

        loc_lSucesso    = .F.
        loc_nQtdImpressa = 0
        loc_cCursor     = THIS.this_cCursorDados

        IF !USED(loc_cCursor)
            THIS.this_cMensagemErro = "Nenhuma etiqueta selecionada para impress" + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            IF !EMPTY(par_cNomeImpressora)
                SET PRINTER TO NAME (par_cNomeImpressora)
            ENDIF

            SET DEVICE TO PRINTER
            SET PRINT ON

            SELECT (loc_cCursor)
            SCAN FOR !EMPTY(Cpros) AND QtdeEtiq > 0
                FOR loc_nCopia = 1 TO QtdeEtiq
                    @ PROW() + 1, 0 SAY PADR(ALLTRIM(Cpros), 14) + "  " + ALLTRIM(TratarNulo(DPros, ""))

                    IF INLIST(par_nImpPreco, 1, 3, 4)
                        @ PROW() + 1, 4 SAY "R$ " + TRANSFORM(PVens, "999,999.99")
                    ENDIF

                    IF par_lImpPeso AND TratarNulo(Pesos, 0) > 0
                        @ PROW() + 1, 4 SAY "Peso: " + TRANSFORM(Pesos, "999,999.999") + " Kg"
                    ENDIF

                    IF par_lCompo AND !EMPTY(TratarNulo(DPro2s, ""))
                        @ PROW() + 1, 4 SAY ALLTRIM(DPro2s)
                    ENDIF

                    IF !EMPTY(par_cBop)
                        @ PROW() + 1, 4 SAY "Ref: " + par_cBop
                    ENDIF

                    IF par_lImpSepar
                        @ PROW() + 1, 0 SAY REPLICATE("-", 40)
                    ENDIF

                    loc_nQtdImpressa = loc_nQtdImpressa + 1
                ENDFOR
                SELECT (loc_cCursor)
            ENDSCAN

            SET PRINT OFF
            SET DEVICE TO SCREEN

            IF loc_nQtdImpressa = 0
                THIS.this_cMensagemErro = "Nenhuma etiqueta com quantidade apurada para imprimir."
            ELSE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            SET PRINT OFF
            SET DEVICE TO SCREEN
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
