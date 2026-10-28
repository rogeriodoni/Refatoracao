*==============================================================================
* SIGOPCGVBO.PRG
* Business Object para Pesquisa Global de Vendas (SIGOPCGV)
*
* Entidade central da consulta : SigCdCli (conta pesquisada)
* Chave Primaria da entidade   : iclis char(10)
*
* Nota: Form OPERACIONAL de CONSULTA (nao CRUD) - agrega dados de saldo,
*       cheques, vendas, estoque, pendencias, conserto, cartao, producao e
*       credito de uma conta/cliente, lidos de varias tabelas (SigCdCli,
*       SigCdCrd, SigMvEst, SigMvCab, SigCdOpe, SigCdCeb, SigCdmp, SigSyImp,
*       SigCdAcG, entre outras). O comportamento padrao de Inserir/
*       Atualizar/ExecutarExclusao herdado de BusinessBase ja eh o correto.
*==============================================================================

DEFINE CLASS sigopcgvBO AS BusinessBase

    *-- Criterios de pesquisa (pagina Consulta / Origem)
    this_cConta             = ""    && iclis digitado p/ pesquisa (Get_Conta)
    this_cDescConta         = ""    && nome do cliente (Get_DConta / rclis)
    this_cCpf               = ""    && cpf ou cgc digitado (Get_Cpf)
    this_cConjuge           = ""    && nome do conjuge (GetConj)
    this_cTelefone          = ""    && telefone digitado (getTelefone)
    this_nOpcaoFiltro       = 0     && optFiltro.Value - tipo de filtro de pesquisa
    this_lSomenteCPF        = .F.   && ThisForm.plCPF - restringe pesquisa a CPF

    *-- Criterios de pesquisa (Envelope/O.P. - paginas Vendas e Producao)
    this_cEnvelope          = ""    && numero do envelope/O.P. (Get_Envelope -> Nenvs)
    this_cOperacao          = ""    && numero da operacao (Get_Op -> Nops)

    *-- Periodo de consulta (paginas Saldo/Cheque/hcheques)
    this_dDataInicial       = {}    && get_dt_inicial
    this_dDataFinal         = {}    && get_dt_final

    *-- Vendedor / usuario corrente
    this_cVendedor          = ""    && ThisForm.UsuVendedor

    *-- Flags de controle de fluxo da consulta (equivalentes as PUBLIC vars do form legado)
    this_cEscolha           = ""    && ThisForm.pcEscolha ("CONSULTAR"/"ALTERAR")
    this_lConsultaExecutada = .F.   && ThisForm.ConsultaExecutada
    this_lAutomatico        = .F.   && ThisForm.Automatico
    this_lOkProduto         = .F.   && ThisForm.OkProduto
    this_lOkEstoque         = .F.   && ThisForm.OkEstoque
    this_lOkCartao          = .F.   && ThisForm.OkCartao
    this_nGradeSel          = 0     && ThisForm.GradeSel (1=grid Produto, 2=grid Operacoes)
    this_cUltimoProduto     = ""    && ThisForm.UltProduto

    *-- Flags de criterio dos totais (regra #21 - condicoes ao redor do SCAN/SUM)
    this_lSubTotalSubn      = .F.   && ChkSubn
    this_lSubTotalPagos     = .F.   && ChkPagos
    this_lSubTotalBxParcs   = .F.   && ChkBxParcs

    *-- Grupo padrao do cliente (crSigCdPam.grpadclis)
    this_cGrupoPadrao       = ""

    *-- Dados do cliente localizado pela pesquisa (SigCdCli)
    this_cGrupoCliente      = ""    && grupos     char(10) - grupo do cliente
    this_nClienteInativo    = 0     && Inativas   numeric(1,0) - cliente inativo

    *-- Parametros do sistema (SigCdPam) lidos em CarregarParametros - o legado
    *-- os le dos cursores globais crSigCdPam/crSigCdGcr, que o sistema novo nao
    *-- pre-carrega no startup (ver nota em CarregarParametros).
    this_cMoedaPadrao       = ""    && SigCdPam.moedaps  - moeda do limite de credito
    this_cMoedaLimEstoque   = ""    && SigCdPam.moelimes - moeda do limite de estoque
    this_nTipoPreco         = 0     && SigCdPam.tpprecos - 1 = preco de venda, 2 = custo
    this_lChqLimitaCredito  = .F.   && SigCdPam.chqlcreds - cheque consome o limite
    this_nGrupoLimCredito   = 0     && SigCdGcr.limcres   - grupo controla limite de credito
    this_nGrupoLimEstoque   = 0     && SigCdGcr.limestoqs - grupo controla limite de estoque

    *-- Totais da aba Cheques (os 9 campos somente-leitura que o Processa()
    *-- legado atribui no fim: Get_LCred, Get_ChqAv, Get_ChqVc, Get_ChqDv,
    *-- Get_SaldoCc, Get_ChqNeg, Get_Dispon, Get_VlEstoque e Fwget3)
    this_nLimiteCredito     = 0     && _Limite  - limite de credito do cliente
    this_nChequesAVencer    = 0     && _ChqAv   - cheques com vencimento >= hoje
    this_nChequesVencidos   = 0     && _ChqVc   - cheques com vencimento < hoje
    this_nChequesDevolvidos = 0     && _ChqDv   - cheques marcados como devolvidos
    this_nSaldoContaCorrente = 0    && _Saldo   - saldo consolidado de SigMvSlc
    this_nChequesNegociados = 0     && _ChqNeg  - saldo dos titulos (cheques negociados)
    this_nLimiteDisponivel  = 0     && _Disp    - limite - saldo - negociados - estoque
    this_nValorEstoque      = 0     && _VlEstq  - valor do estoque em poder do cliente
    this_nTotalChequeAberto = 0     && lnVal    - soma de dbAberto.valors
    this_nTotalDevolvido    = 0     && _TotDev  - soma de dbDevolvido.valors

    *-- Aba H.Cheques (mativahcheque legado)
    this_cFollowUpCheque    = ""    && Cnt_Followup.UltFollowup - ultimo historico (SigCheh.Hists)

    *-- Aba Credito (mativacredito legado)
    this_cLabelSituacaoCredito = "" && Label2.Caption - descricao da situacao (SigCdCst.Descrs)
    this_lSituacaoVermelha     = .F. && Label2.ForeColor - .T. quando SigCdCli.Situas = "*"

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCli"
            THIS.this_cCampoChave = "iclis"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopcgvBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - BusinessBase deixa este metodo para a subclasse ("Subclasses
    * devem limpar suas propriedades especificas"): aqui ele zera os CRITERIOS
    * de pesquisa e o resultado derivado deles, que eh o que o cmd_voltar.Click
    * legado faz ao devolver a tela para a pagina Consulta (Space(10) em
    * Get_conta, Space(50) em Get_dconta, Space(20) em Get_cpf, Space(40) em
    * GetConj e Space(15) em getTelefone) somado aos flags de controle do
    * Processa()/PCartao()/PEstoque() (ConsultaExecutada / OkProduto /
    * OkEstoque / OkCartao), que o legado reposiciona a cada nova consulta.
    *
    * NAO zera o que veio de PARAMETRO/sessao e vale para a tela inteira:
    * this_lSomenteCPF (plCPF), this_lAutomatico (Automatico) e this_cVendedor
    * (UsuVendedor, resolvido uma vez pelo ChecaSenha) - limpa-los faria a
    * proxima pesquisa perder a restricao recebida na abertura.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        *-- Criterios de pesquisa (container Origem do legado)
        THIS.this_cConta       = ""
        THIS.this_cDescConta   = ""
        THIS.this_cCpf         = ""
        THIS.this_cConjuge     = ""
        THIS.this_cTelefone    = ""
        THIS.this_nOpcaoFiltro = 1

        *-- Criterios do bloco Producao (Envelope / O.P.)
        THIS.this_cEnvelope  = ""
        THIS.this_cOperacao  = ""

        *-- Dados do cliente localizado
        THIS.this_cGrupoCliente   = ""
        THIS.this_nClienteInativo = 0

        *-- Flags de controle da consulta
        THIS.this_cEscolha           = ""
        THIS.this_lConsultaExecutada = .F.
        THIS.this_lOkProduto         = .F.
        THIS.this_lOkEstoque         = .F.
        THIS.this_lOkCartao          = .F.
        THIS.this_nGradeSel          = 0
        THIS.this_cUltimoProduto     = ""

        *-- Totais derivados (pe da aba Cheques) - sem isso a tela mostraria
        *-- os numeros da conta ANTERIOR enquanto a nova consulta nao roda
        THIS.this_nLimiteCredito      = 0
        THIS.this_nChequesAVencer     = 0
        THIS.this_nChequesVencidos    = 0
        THIS.this_nChequesDevolvidos  = 0
        THIS.this_nSaldoContaCorrente = 0
        THIS.this_nChequesNegociados  = 0
        THIS.this_nLimiteDisponivel   = 0
        THIS.this_nValorEstoque       = 0
        THIS.this_nTotalChequeAberto  = 0
        THIS.this_nTotalDevolvido     = 0

        *-- Textos derivados do cliente localizado
        THIS.this_cFollowUpCheque       = ""
        THIS.this_cLabelSituacaoCredito = ""
        THIS.this_lSituacaoVermelha     = .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (iclis) do cliente
    * localizado pela pesquisa, para uso em RegistrarAuditoria.
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cConta)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do cliente localizado a
    * partir de um cursor de pesquisa (SigCdCli). As diversas pesquisas do
    * legado (por conta, nome, cpf/cgc, conjuge, telefone) devolvem subconjuntos
    * diferentes de colunas - cada coluna opcional eh conferida com TYPE()
    * antes de ser lida, para nao estourar "Variable X is not found" quando a
    * query de origem nao a selecionou.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Sempre presentes (toda pesquisa devolve a identificacao da conta)
                THIS.this_cConta       = TratarNulo(iclis, "C")
                THIS.this_cDescConta   = TratarNulo(rclis, "C")
                THIS.this_cCpf         = TratarNulo(cpfs, "C")

                *-- Opcionais - dependem de qual Valid/pesquisa gerou o cursor
                IF TYPE(par_cAliasCursor + ".conjuges") != "U"
                    THIS.this_cConjuge = TratarNulo(conjuges, "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".tel1s") != "U"
                    THIS.this_cTelefone = TratarNulo(tel1s, "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".grupos") != "U"
                    THIS.this_cGrupoCliente = TratarNulo(grupos, "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".inativas") != "U"
                    THIS.this_nClienteInativo = TratarNulo(inativas, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigopcgvBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarPorConta - Localiza o cliente pelo codigo exato da conta (iclis).
    * Equivalente ao Get_conta.Valid do legado (sem o auto-load de fAcessoContas
    * - a busca eh por codigo EXATO; o picker de nao-encontrado eh resolvido
    * no Form, via FormBuscaAuxiliar/BuscarPorNome).
    *==========================================================================
    FUNCTION BuscarPorConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cConta) != "C" OR EMPTY(ALLTRIM(par_cConta))
            THIS.this_cMensagemErro = "Informe a conta para pesquisa."
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = "SELECT Iclis, Rclis, Cpfs, Conjuges, Tel1s, Grupos, Inativas" + ;
                    " FROM SigCdCli WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta))

                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_BuscaConta") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_BuscaConta")
                    ELSE
                        THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
                    ENDIF

                    IF USED("cursor_4c_BuscaConta")
                        USE IN cursor_4c_BuscaConta
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar a conta:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar a conta: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPorNome - Localiza clientes cujo nome/razao social CONTENHA o
    * texto digitado (Get_dconta.Valid do legado: Rclis Like '%texto%').
    * Popula par_cCursorDestino com a lista de candidatos (1 ou mais linhas) -
    * a escolha de qual conta usar eh feita pelo Form (picker), que em seguida
    * chama BuscarPorConta()/CarregarDoCursor() com a linha escolhida.
    *==========================================================================
    FUNCTION BuscarPorNome(par_cNome, par_cCursorDestino, par_cModoFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
            THIS.this_cMensagemErro = "Informe o nome para pesquisa."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cModoFiltro) != "C"
            par_cModoFiltro = "QUALQUER"
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                *-- optFiltro = Iniciais (prefixo "valor%") ou Qualquer Parte (contem "%valor%")
                IF UPPER(par_cModoFiltro) = "INICIAIS"
                    loc_cFiltro = ALLTRIM(par_cNome) + "%"
                ELSE
                    loc_cFiltro = "%" + ALLTRIM(par_cNome) + "%"
                ENDIF

                loc_cSQL = "SELECT Rclis, Iclis, Cpfs, Conjuges, Inativas" + ;
                    " FROM SigCdCli WHERE Rclis LIKE " + EscaparSQL(loc_cFiltro) + ;
                    " ORDER BY Rclis"

                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

                IF loc_nResultado >= 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Nenhum cliente encontrado com esse nome."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar por nome:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar por nome: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPorCpf - Localiza o cliente pelo CPF/CGC digitado (Get_cpf.Valid
    * do legado). Valida o formato (CPF=11 digitos, CNPJ=14) com ValidarCPF/
    * ValidarCNPJ de validators.prg antes de pesquisar, e compara contra a
    * coluna Cpfs MASCARADA (igual ao TransForm do legado), pois eh assim que
    * o valor fica gravado em SigCdCli.Cpfs.
    *==========================================================================
    FUNCTION BuscarPorCpf(par_cCpf, par_cCursorDestino)
        LOCAL loc_cNumeros, loc_cMascarado, loc_lValido, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCpf) != "C" OR EMPTY(ALLTRIM(par_cCpf))
            THIS.this_cMensagemErro = "Informe o CPF ou CGC para pesquisa."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            RETURN .F.
        ENDIF

        loc_cNumeros = SomenteNumeros(par_cCpf)
        loc_lValido  = .F.

        DO CASE
            CASE LEN(loc_cNumeros) = 11
                loc_lValido    = ValidarCPF(loc_cNumeros)
                loc_cMascarado = FormatarCPF(loc_cNumeros)
            CASE LEN(loc_cNumeros) = 14
                loc_lValido    = ValidarCNPJ(loc_cNumeros)
                loc_cMascarado = FormatarCNPJ(loc_cNumeros)
            OTHERWISE
                loc_lValido    = .F.
        ENDCASE

        IF !loc_lValido
            THIS.this_cMensagemErro = "CPF / CGC Incorreto."
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = "SELECT Iclis, Rclis, Cpfs, Conjuges, Tel1s, Grupos, Inativas" + ;
                    " FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cMascarado)

                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

                IF loc_nResultado >= 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "CPF / CGC n" + CHR(227) + "o encontrado."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar por CPF/CGC:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar por CPF/CGC: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPorConjuge - Localiza clientes pelo nome do conjuge, contendo o
    * texto digitado (GetConj.Valid do legado: Conjuges Like '%texto%').
    *==========================================================================
    FUNCTION BuscarPorConjuge(par_cConjuge, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cConjuge) != "C" OR EMPTY(ALLTRIM(par_cConjuge))
            THIS.this_cMensagemErro = "Informe o nome do c" + CHR(244) + "njuge para pesquisa."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cFiltro = "%" + ALLTRIM(par_cConjuge) + "%"

                loc_cSQL = "SELECT Conjuges, Tel1s, Grupos, Iclis, Rclis, Cpfs" + ;
                    " FROM SigCdCli WHERE Conjuges LIKE " + EscaparSQL(loc_cFiltro) + ;
                    " ORDER BY Conjuges"

                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

                IF loc_nResultado >= 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Nenhum cliente encontrado com esse c" + CHR(244) + "njuge."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar por c" + CHR(244) + "njuge:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar por c" + CHR(244) + "njuge: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPorTelefone - Localiza clientes pelo telefone, contendo o texto
    * digitado (getTelefone.Valid do legado: Tel1s Like '%texto%').
    *==========================================================================
    FUNCTION BuscarPorTelefone(par_cTelefone, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cTelefone) != "C" OR EMPTY(ALLTRIM(par_cTelefone))
            THIS.this_cMensagemErro = "Informe o telefone para pesquisa."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cFiltro = "%" + ALLTRIM(par_cTelefone) + "%"

                loc_cSQL = "SELECT Tel1s, Conjuges, Grupos, Iclis, Rclis, Cpfs" + ;
                    " FROM SigCdCli WHERE Tel1s LIKE " + EscaparSQL(loc_cFiltro) + ;
                    " ORDER BY Tel1s"

                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

                IF loc_nResultado >= 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Nenhum cliente encontrado com esse telefone."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar por telefone:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar por telefone: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CriarCursoresLocais - Recria os cursores locais usados pela aba Saldo
    * (dbSaldo/dbHistorico do Init legado - "executa os parametros set
    * iniciais" / "Cursor de saldos da conta" / "Cursor de historico de conta
    * corrente"). Sao cursores de TRABALHO (nao SQL pass-through), por isso
    * precisam ser RECRIADOS (nao so ZAP) a cada pesquisa de conta - o legado
    * tambem os recria no Init, nunca reaproveita o cursor da conta anterior.
    *
    * Cursores criados aqui, e quem os popula:
    *   dbSaldo / dbHistorico             -> CarregarHistoricoSaldo
    *   TmpPar / crTmpTipos               -> CarregarPendencias
    *   dbAberto / dbDevolvido / DbFollow / DbTitulo -> CarregarCheques
    *   TmpCart                           -> CarregarCartoes
    *   dbEstoque                         -> CarregarEstoque
    *
    * Os cursores das abas Vendas / Operacoes em Aberto / Producao / Historico
    * de Cheques / Credito (dbProduto, dbProdTodos, dbOperac, dbConserto,
    * dbOpera, dbProduc, dbItens, dbEstIte, dbTotVendas) entram junto com o
    * conteudo dessas abas, na fase seguinte.
    *==========================================================================
    FUNCTION CriarCursoresLocais()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("dbSaldo")
                USE IN dbSaldo
            ENDIF
            CREATE CURSOR dbSaldo (grupos C(10), moedas C(3), saldos N(12,3), SaldoConta N(12,3))
            SELECT dbSaldo
            INDEX ON grupos + moedas TAG GruMoe
            APPEND BLANK

            IF USED("dbHistorico")
                USE IN dbHistorico
            ENDIF
            CREATE CURSOR dbHistorico (emps C(3), grupos C(10), datas D, valors N(12,2), ;
                opers C(1), saldos N(16,3), hists C(40), hist2s C(40), moedas C(3), ;
                dopes C(20), numes N(6))
            SELECT dbHistorico
            INDEX ON grupos + moedas TAG GruMoe

            *-- Cursor dos valores a receber (aba Pendencias)
            IF USED("TmpPar")
                USE IN TmpPar
            ENDIF
            CREATE CURSOR TmpPar (grupos C(10), vencs D NULL, emps C(3), fpags C(15), ;
                valos N(12,2), moefpgs C(3), hists C(50), dopes C(20), numes N(6), opers C(1))
            SELECT TmpPar
            INDEX ON grupos + opers + DTOS(vencs) TAG GruVencs
            *-- Tag de UMA coluna para o SET KEY do filtro de grupo: chave
            *-- parcial sobre indice composto nao casa com SET EXACT ON (ver
            *-- a regra de INDEX composto + chave parcial no CLAUDE.md)
            INDEX ON grupos TAG Grupos
            SET ORDER TO GruVencs
            APPEND BLANK

            *-- Formas de pagamento marcaveis da aba Pendencias (grdTipos)
            IF USED("crTmpTipos")
                USE IN crTmpTipos
            ENDIF
            CREATE CURSOR crTmpTipos (Listas N(1), fPags C(12))
            SELECT crTmpTipos
            INDEX ON fPags TAG fPags

            *-- Cheques em aberto (aba Cheques)
            IF USED("dbAberto")
                USE IN dbAberto
            ENDIF
            CREATE CURSOR dbAberto (grupos C(10), vencs D, bancos C(3), agencias C(4), ;
                ncheques C(6), valors N(12,2), ncontas C(10), Flags L, Nums C(8), Devolvidos C(1))
            SELECT dbAberto
            INDEX ON grupos + DTOS(vencs) TAG Vencimento
            INDEX ON grupos + DTOS(vencs) DESC TAG VencVal
            INDEX ON grupos TAG Grupos
            SET ORDER TO VencVal
            APPEND BLANK

            *-- Cheques devolvidos (aba Cheques)
            IF USED("dbDevolvido")
                USE IN dbDevolvido
            ENDIF
            CREATE CURSOR dbDevolvido (grupos C(10), vencs D, bancos C(3), agencias C(4), ;
                ncheques C(6), valors N(12,2), ncontas C(10), numincdevs N(2))
            SELECT dbDevolvido
            INDEX ON grupos + DTOS(vencs) DESC TAG VencVal
            INDEX ON bancos + agencias + ncontas + ncheques TAG Cheque
            INDEX ON grupos TAG Grupos
            SET ORDER TO VencVal
            APPEND BLANK

            *-- Follow-up do cheque selecionado (aba Cheques)
            IF USED("DbFollow")
                USE IN DbFollow
            ENDIF
            CREATE CURSOR DbFollow (Nums C(8), Datas D, Hists C(76) NULL)
            SELECT DbFollow
            INDEX ON Nums + DTOS(Datas) TAG NumData
            INDEX ON Nums TAG Nums
            SET ORDER TO NumData

            *-- Titulos / cheques negociados (aba Cheques)
            IF USED("DbTitulo")
                USE IN DbTitulo
            ENDIF
            CREATE CURSOR DbTitulo (Grupos C(10), Titulos C(10), Vencs D, Valors N(12,2), ;
                ValPags N(12,2), Saldos N(12,2), Hists C(26), Moedas C(3))
            SELECT DbTitulo
            INDEX ON Titulos TAG Titulos

            *-- Cartoes de credito em aberto (aba Cartao)
            IF USED("TmpCart")
                USE IN TmpCart
            ENDIF
            CREATE CURSOR TmpCart (grupos C(10), cartaos C(20), datas D, fpags C(12), ;
                valos N(12,2), nocreditos C(10), vencs D)
            SELECT TmpCart
            APPEND BLANK

            *-- Produtos em poder do cliente (aba Estoque)
            IF USED("dbEstoque")
                USE IN dbEstoque
            ENDIF
            CREATE CURSOR dbEstoque (grupos C(10), cpros C(14), sqtds N(10,3))
            SELECT dbEstoque
            INDEX ON grupos TAG Grupos
            APPEND BLANK

            *-- Historico de cheques da conta (aba H.Cheques - GradeCheque)
            IF USED("dbCheqHist")
                USE IN dbCheqHist
            ENDIF
            CREATE CURSOR dbCheqHist (Emps C(3), Vencs D NULL, Bancos C(3), Agencias C(4), ;
                NContas C(10), NCheques C(6), Valors N(11,2), GruCarts C(10), ConCarts C(10), ;
                Numeros C(6), DiasP N(6), Tipo C(8), Nums C(8))
            SELECT dbCheqHist
            INDEX ON Vencs TAG Venc

            *-- Movimentacao do cheque selecionado em dbCheqHist (GradeMovimenta)
            IF USED("dbCheqMovim")
                USE IN dbCheqMovim
            ENDIF
            CREATE CURSOR dbCheqMovim (Codigos C(15), Nalineas N(3), Dtents D NULL, ;
                Gruorigs C(10), Conorigs C(10), Grupos C(10), Contas C(10), Numlotes N(8), ;
                Protocolos C(8))
            SELECT dbCheqMovim

            *-- Prorrogacoes do cheque selecionado (GradeProrrog)
            IF USED("dbCheqProrrog")
                USE IN dbCheqProrrog
            ENDIF
            CREATE CURSOR dbCheqProrrog (Vencs D NULL, PJuros N(5,2), VJuros N(8,2), ;
                Usuars C(30), Motivo C(30))
            SELECT dbCheqProrrog

            *-- Lancamentos de credito/cobranca da conta, por CPF (aba Credito)
            IF USED("dbCredito")
                USE IN dbCredito
            ENDIF
            CREATE CURSOR dbCredito (Tipos C(1), Usuars C(10), Emps C(3), Datas D NULL, ;
                Dopes C(20), Numes N(6), Ccpfs C(20), Nvalors N(15,2), Dvencs D NULL, ;
                Cbancos C(3), Cagencias C(4), Ccontas C(15), Ccheinis C(6), Cdiginis C(1), ;
                Cchefins C(6), Cdigfins C(1), Cseries C(6), Cdaberts C(7), NChkDocs N(1), ;
                TdDocs D NULL)
            SELECT dbCredito

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao criar cursores locais: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarHistoricoSaldo - Popula os cursores locais da aba Saldo com os
    * dados da conta localizada, reproduzindo o trecho de "Verificando
    * Historicos" / "Verificando Saldo" do Processa() legado:
    *
    *   dbHistorico <- Select * From SigMvCcr Where contas = <conta>
    *                  [And Datas between <ini> and <fim>]  (periodo opcional)
    *
    *   dbSaldo     <- com o periodo EM BRANCO: saldo consolidado de SigMvSlc
    *                  com descricao do grupo (SigCdGcr), nome do cliente
    *                  (SigCdCli) e limite de credito (SigClLcr), de onde sai
    *                  o SaldoConta = (LimCres - saldos) quando ha limite;
    *                  com o periodo PREENCHIDO: soma por grupo/moeda do
    *                  proprio dbHistorico (Valors com sinal por opers),
    *                  exatamente como o legado - nesse ramo o legado NAO
    *                  calcula SaldoConta, que portanto fica zerado.
    *
    * Os dois cursores sao ZAPeados e repopulados (nunca fechados/recriados),
    * para preservar RecordSource/ControlSource/Header/Width dos grids ligados
    * a eles. Quem exibe eh o Form (AtualizarGradesSaldo - GO TOP + Refresh).
    *==========================================================================
    FUNCTION CarregarHistoricoSaldo()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta, loc_lTemPeriodo
        LOCAL loc_dIni, loc_dFim, loc_nLinhas
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("dbHistorico") OR !USED("dbSaldo")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_dIni = ConverterParaData(THIS.this_dDataInicial)
                loc_dFim = ConverterParaData(THIS.this_dDataFinal)
                loc_lTemPeriodo = (!EMPTY(loc_dIni) AND !EMPTY(loc_dFim))

                *-- 1) Historico de conta corrente (SigMvCcr)
                SELECT dbHistorico
                ZAP

                loc_cSQL = "SELECT Emps, Grupos, Datas, Valors, Opers, Saldos," + ;
                    " Hists, Hist2s, Moedas, Dopes, Numes" + ;
                    " FROM SigMvCcr" + ;
                    " WHERE Contas = " + EscaparSQL(loc_cConta)

                IF loc_lTemPeriodo
                    loc_cSQL = loc_cSQL + ;
                        " AND Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                        " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY Datas, Emps"

                IF USED("cursor_4c_MvCcr")
                    IF CURSORGETPROP("Buffering", "cursor_4c_MvCcr") > 1
                        TABLEREVERT(.T., "cursor_4c_MvCcr")
                    ENDIF
                    USE IN cursor_4c_MvCcr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcr")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + ;
                        "rico de conta corrente:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_MvCcr
                    SCAN
                        INSERT INTO dbHistorico ;
                            (emps, grupos, datas, valors, opers, saldos, hists, ;
                             hist2s, moedas, dopes, numes) ;
                            VALUES ;
                            (TratarNulo(cursor_4c_MvCcr.Emps, ""), ;
                             TratarNulo(cursor_4c_MvCcr.Grupos, ""), ;
                             ConverterParaData(cursor_4c_MvCcr.Datas), ;
                             TratarNulo(cursor_4c_MvCcr.Valors, 0), ;
                             TratarNulo(cursor_4c_MvCcr.Opers, ""), ;
                             TratarNulo(cursor_4c_MvCcr.Saldos, 0), ;
                             LEFT(TratarNulo(cursor_4c_MvCcr.Hists, ""), 40), ;
                             LEFT(TratarNulo(cursor_4c_MvCcr.Hist2s, ""), 40), ;
                             TratarNulo(cursor_4c_MvCcr.Moedas, ""), ;
                             TratarNulo(cursor_4c_MvCcr.Dopes, ""), ;
                             TratarNulo(cursor_4c_MvCcr.Numes, 0))
                    ENDSCAN

                    IF USED("cursor_4c_MvCcr")
                        USE IN cursor_4c_MvCcr
                    ENDIF

                    *-- 2) Saldo por grupo/moeda
                    SELECT dbSaldo
                    ZAP
                    loc_nLinhas = 0

                    IF loc_lTemPeriodo
                        *-- Periodo informado: soma do proprio historico carregado
                        IF USED("cursor_4c_SaldoTmp")
                            USE IN cursor_4c_SaldoTmp
                        ENDIF
                        SELECT grupos, moedas, ;
                               SUM(valors * IIF(opers = "D", 1, -1)) AS saldos ;
                            FROM dbHistorico ;
                            GROUP BY grupos, moedas ;
                            INTO CURSOR cursor_4c_SaldoTmp READWRITE

                        SELECT cursor_4c_SaldoTmp
                        SCAN
                            INSERT INTO dbSaldo (grupos, moedas, saldos) ;
                                VALUES (cursor_4c_SaldoTmp.grupos, ;
                                        cursor_4c_SaldoTmp.moedas, ;
                                        cursor_4c_SaldoTmp.saldos)
                            loc_nLinhas = loc_nLinhas + 1
                        ENDSCAN

                        IF USED("cursor_4c_SaldoTmp")
                            USE IN cursor_4c_SaldoTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Sem periodo: saldo consolidado de SigMvSlc + limite de credito
                        loc_cSQL = "SELECT a.Grupos, c.Descrs, a.Contas, b.Rclis," + ;
                            " a.Moedas, a.Saldos, ISNULL(d.LimCres, 0) AS LimCres," + ;
                            " CASE WHEN ISNULL(d.LimCres, 0) > 0" + ;
                            " THEN (ISNULL(d.LimCres, 0) - a.Saldos)" + ;
                            " ELSE a.Saldos END AS SaldoConta" + ;
                            " FROM SigMvSlc a" + ;
                            " JOIN SigCdCli b ON a.Contas = b.Iclis" + ;
                            " JOIN SigCdGcr c ON a.Grupos = c.Codigos" + ;
                            " LEFT JOIN SigClLcr d ON a.Contas = d.Contas" + ;
                            " WHERE a.Contas = " + EscaparSQL(loc_cConta) + ;
                            " ORDER BY a.Grupos, a.Contas"

                        IF USED("cursor_4c_SaldoTmp")
                            IF CURSORGETPROP("Buffering", "cursor_4c_SaldoTmp") > 1
                                TABLEREVERT(.T., "cursor_4c_SaldoTmp")
                            ENDIF
                            USE IN cursor_4c_SaldoTmp
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldoTmp")

                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao carregar o saldo da conta:" + ;
                                CHR(13) + CapturarErroSQL()
                        ELSE
                            SELECT cursor_4c_SaldoTmp
                            SCAN
                                INSERT INTO dbSaldo (grupos, moedas, saldos, SaldoConta) ;
                                    VALUES (TratarNulo(cursor_4c_SaldoTmp.Grupos, ""), ;
                                            TratarNulo(cursor_4c_SaldoTmp.Moedas, ""), ;
                                            TratarNulo(cursor_4c_SaldoTmp.Saldos, 0), ;
                                            TratarNulo(cursor_4c_SaldoTmp.SaldoConta, 0))
                                loc_nLinhas = loc_nLinhas + 1
                            ENDSCAN

                            IF USED("cursor_4c_SaldoTmp")
                                USE IN cursor_4c_SaldoTmp
                            ENDIF
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF

                    *-- O legado zera dbSaldo quando nenhum grupo entrou na lista
                    *-- (Cmb_Grupo.ListCount = 0): sem grupo nao ha saldo a exibir.
                    IF loc_lSucesso AND loc_nLinhas = 0
                        SELECT dbSaldo
                        ZAP
                    ENDIF

                    THIS.this_lConsultaExecutada = loc_lSucesso
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar hist" + CHR(243) + "rico/saldo: " + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametros - Le os parametros do sistema que as abas Pendencias /
    * Cheques / Estoque usam para decidir o que calcular.
    *
    * O legado le esses valores de CURSORES GLOBAIS (crSigCdPam / crSigCdGcr)
    * que o startup Fortyus pre-carregava no login. O sistema novo nao faz esse
    * pre-load, entao cada BO que depende deles le a tabela direto (mesmo
    * tratamento dado a crSigCdPam em outros forms migrados):
    *
    *   SigCdPam.grpadclis -> grupo padrao de clientes (this_cGrupoPadrao)
    *   SigCdPam.moedaps   -> moeda do limite de credito (converte os saldos)
    *   SigCdPam.moelimes  -> moeda do limite de estoque
    *   SigCdPam.tpprecos  -> 1 = avalia estoque a preco de venda, 2 = a custo
    *   SigCdPam.chqlcreds -> cheque em carteira consome o limite disponivel
    *   SigCdGcr.limcres   -> o grupo controla limite de credito
    *   SigCdGcr.limestoqs -> o grupo controla limite de estoque
    *
    * SigCdPam eh tabela de parametro de UMA linha - nao leva WHERE.
    *==========================================================================
    FUNCTION CarregarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF

                loc_cSQL = "SELECT grpadclis, moedaps, moelimes, tpprecos, chqlcreds" + ;
                    " FROM SigCdPam"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + ;
                        "o de Par" + CHR(226) + "metros do Sistema n" + CHR(227) + ;
                        "o Encontrada:" + CHR(13) + CapturarErroSQL()
                ELSE
                    IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                        SELECT cursor_4c_Pam
                        GO TOP
                        THIS.this_cGrupoPadrao      = ALLTRIM(TratarNulo(cursor_4c_Pam.grpadclis, ""))
                        THIS.this_cMoedaPadrao      = ALLTRIM(TratarNulo(cursor_4c_Pam.moedaps, ""))
                        THIS.this_cMoedaLimEstoque  = ALLTRIM(TratarNulo(cursor_4c_Pam.moelimes, ""))
                        THIS.this_nTipoPreco        = TratarNulo(cursor_4c_Pam.tpprecos, 0)
                        THIS.this_lChqLimitaCredito = ConverterParaLogico(cursor_4c_Pam.chqlcreds)
                    ENDIF

                    IF USED("cursor_4c_Pam")
                        USE IN cursor_4c_Pam
                    ENDIF

                    *-- Flags do GRUPO padrao (SigCdGcr): eh ele que decide se
                    *-- existe controle de limite de credito e de estoque
                    THIS.this_nGrupoLimCredito = 0
                    THIS.this_nGrupoLimEstoque = 0

                    IF !EMPTY(THIS.this_cGrupoPadrao)
                        IF USED("cursor_4c_Gcr")
                            USE IN cursor_4c_Gcr
                        ENDIF

                        loc_cSQL = "SELECT limcres, limestoqs FROM SigCdGcr" + ;
                            " WHERE codigos = " + EscaparSQL(THIS.this_cGrupoPadrao)

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_Gcr")
                            IF RECCOUNT("cursor_4c_Gcr") > 0
                                SELECT cursor_4c_Gcr
                                GO TOP
                                THIS.this_nGrupoLimCredito = TratarNulo(cursor_4c_Gcr.limcres, 0)
                                THIS.this_nGrupoLimEstoque = TratarNulo(cursor_4c_Gcr.limestoqs, 0)
                            ENDIF
                            USE IN cursor_4c_Gcr
                        ENDIF
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar os par" + CHR(226) + "metros:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterCotacao - Cotacao da moeda na data informada (SigCdCot), usada para
    * converter saldo / cheque / estoque para a moeda do limite de credito.
    *
    * Substitui fBuscarCotacao()/CarregarCambio() do Framework legado, que nao
    * foram portados. Sem cotacao cadastrada devolve 1 (nao converte), que eh
    * exatamente o que o legado faz quando o Seek em crSigCdCot falha.
    *==========================================================================
    FUNCTION ObterCotacao(par_cMoeda, par_dData)
        LOCAL loc_cSQL, loc_nResultado, loc_nCotacao, loc_dData, loc_cMoeda
        loc_nCotacao = 1

        loc_cMoeda = ALLTRIM(IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, ""))
        loc_dData  = ConverterParaData(par_dData)
        IF EMPTY(loc_dData)
            loc_dData = DATE()
        ENDIF

        IF EMPTY(loc_cMoeda) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_nCotacao
        ENDIF

        TRY
            IF USED("cursor_4c_Cot")
                USE IN cursor_4c_Cot
            ENDIF

            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot" + ;
                " WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
                " AND datas <= " + FormatarDataSQL(DTOT(loc_dData) + 86399) + ;
                " ORDER BY datas DESC, horas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cot")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Cot")
                IF RECCOUNT("cursor_4c_Cot") > 0
                    SELECT cursor_4c_Cot
                    GO TOP
                    IF TratarNulo(cursor_4c_Cot.valos, 0) <> 0
                        loc_nCotacao = TratarNulo(cursor_4c_Cot.valos, 0)
                    ENDIF
                ENDIF
                USE IN cursor_4c_Cot
            ENDIF
        CATCH TO loException
            *-- Cotacao ausente nao interrompe a consulta: segue sem converter
            loc_nCotacao = 1
        ENDTRY

        RETURN loc_nCotacao
    ENDFUNC

    *==========================================================================
    * CarregarGruposCursor - Lista os grupos presentes num cursor de resultado,
    * com a descricao de SigCdGcr, para popular o ComboBox "Grupo :" da aba.
    *
    * Equivale ao Carrega_Combo() do legado, que a cada registro inserido no
    * cursor acrescentava "<grupo> - <descrs>" ao combo da aba e PULAVA o grupo
    * com SigCdGcr.blqcongvs = 1 (grupo bloqueado para a consulta global de
    * vendas). A descricao vem de SigCdGcr pelo mesmo caminho que os outros BOs
    * migrados usam no lugar de fAcessoContab(Usuar, "C", <grupo>).
    *
    * Par: par_cCursorOrigem  - cursor de resultado que tem a coluna "grupos"
    *      par_cCursorDestino - cursor de saida (Codigos, Descrs)
    * Ret: numero de grupos devolvidos
    *==========================================================================
    FUNCTION CarregarGruposCursor(par_cCursorOrigem, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_nGrupos, loc_cLista
        LOCAL loc_cOrigem, loc_cDestino
        loc_nGrupos = 0

        loc_cOrigem  = IIF(VARTYPE(par_cCursorOrigem) = "C", ALLTRIM(par_cCursorOrigem), "")
        loc_cDestino = IIF(VARTYPE(par_cCursorDestino) = "C", ALLTRIM(par_cCursorDestino), "")

        IF EMPTY(loc_cOrigem) OR EMPTY(loc_cDestino) OR !USED(loc_cOrigem)
            RETURN 0
        ENDIF

        TRY
            *-- Grupos distintos do cursor, em lista para o IN do SQL Server
            IF USED("cursor_4c_GrpTmp")
                USE IN cursor_4c_GrpTmp
            ENDIF
            SELECT DISTINCT grupos ;
                FROM (loc_cOrigem) ;
                WHERE !EMPTY(grupos) ;
                INTO CURSOR cursor_4c_GrpTmp READWRITE

            loc_cLista = ""
            SELECT cursor_4c_GrpTmp
            SCAN
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ", ") + ;
                    EscaparSQL(ALLTRIM(cursor_4c_GrpTmp.grupos))
            ENDSCAN

            IF USED("cursor_4c_GrpTmp")
                USE IN cursor_4c_GrpTmp
            ENDIF

            IF USED(loc_cDestino)
                USE IN (loc_cDestino)
            ENDIF

            IF EMPTY(loc_cLista) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                CREATE CURSOR (loc_cDestino) (Codigos C(10), Descrs C(40))
            ELSE
                loc_cSQL = "SELECT codigos AS Codigos, descrs AS Descrs" + ;
                    " FROM SigCdGcr" + ;
                    " WHERE codigos IN (" + loc_cLista + ")" + ;
                    " AND ISNULL(blqcongvs, 0) <> 1" + ;
                    " ORDER BY codigos"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cDestino)

                IF loc_nResultado < 0
                    CREATE CURSOR (loc_cDestino) (Codigos C(10), Descrs C(40))
                ENDIF
            ENDIF

            IF USED(loc_cDestino)
                loc_nGrupos = RECCOUNT(loc_cDestino)
                SELECT (loc_cDestino)
                GO TOP
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar os grupos:" + CHR(13) + ;
                loException.Message
            loc_nGrupos = 0
        ENDTRY

        RETURN loc_nGrupos
    ENDFUNC

    *==========================================================================
    * CarregarPendencias - Popula TmpPar (grade da aba Pendencias) e crTmpTipos
    * (grade de formas de pagamento marcaveis), reproduzindo os dois trechos do
    * Processa() legado que alimentam essa aba:
    *
    *   (1) "Verificando Historicos" - pendencias de CONTA CORRENTE:
    *       varre SigMvCcr da conta e, para cada lancamento que passa o guard do
    *       legado (Nopers <> 0, Tipos em {" ","X"} e - quando tem Dopes+Numes -
    *       Tipos = "X"), insere o saldo em aberto (Valors - Valpags > 0) com a
    *       forma de pagamento fixa "C/Corrente".
    *
    *   (2) "Verificando Historicos (Origem/Destino)" - parcelas de movimento:
    *       SigMvCab + SigMvPar das operacoes da conta (como origem OU destino),
    *       restritas as operacoes que controlam valor em aberto e parcelas
    *       (SigCdOpe.ValPends = 1 e Parcs = 1) e as formas de pagamento que
    *       controlam valor em aberto e nao estao fora da consulta global
    *       (SigOpFp.ValPends = 1 e LisConGv <> 2). O legado monta esse recorte
    *       com um SELECT local sobre tres cursores; aqui o mesmo recorte vai
    *       para o SQL Server, onde as tres tabelas vivem.
    *
    *       O ramo "forma de pagamento do tipo cheque" (SigOpFp.Infos = "C") do
    *       legado so aceita a parcela quando o cheque correspondente esta numa
    *       operacao de DEBITO (SigCdOpt.Tipos = "DB") - transcrito aqui como o
    *       EXISTS sobre SigChe + SigCdOpt.
    *
    *       O grupo da pendencia depende do sentido da operacao: SigCdOpe.COpers
    *       = 1 significa que a conta eh o DESTINO (grupo = Grupods, Opers "D");
    *       caso contrario a conta eh a ORIGEM (grupo = Grupoos, Opers "C").
    *
    *   (3) "Monta grade dos tipos para escolher filtro": as formas de pagamento
    *       distintas que sobraram em TmpPar entram em crTmpTipos JA MARCADAS
    *       (Listas = 1), como no legado.
    *
    * Os cursores sao ZAPeados e repopulados (nunca fechados/recriados), para
    * preservar RecordSource/ControlSource/Header/Width das grades ligadas a
    * eles. Quem exibe eh o Form (AtualizarGradePendencias).
    *==========================================================================
    FUNCTION CarregarPendencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta, loc_lTemPeriodo
        LOCAL loc_dIni, loc_dFim, loc_nValos, loc_cGrupo, loc_cOpers, loc_cHists
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("TmpPar") OR !USED("crTmpTipos")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_dIni = ConverterParaData(THIS.this_dDataInicial)
                loc_dFim = ConverterParaData(THIS.this_dDataFinal)
                loc_lTemPeriodo = (!EMPTY(loc_dIni) AND !EMPTY(loc_dFim))

                SELECT TmpPar
                ZAP
                SELECT crTmpTipos
                ZAP

                *-- (1) Pendencias de conta corrente (SigMvCcr)
                loc_cSQL = "SELECT Emps, Grupos, Vencs, Valors, Valpags, Moedas," + ;
                    " Hists, Opers, Nopers, Tipos, Dopes, Numes" + ;
                    " FROM SigMvCcr" + ;
                    " WHERE Contas = " + EscaparSQL(loc_cConta)

                IF loc_lTemPeriodo
                    loc_cSQL = loc_cSQL + ;
                        " AND Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                        " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                ENDIF

                IF USED("cursor_4c_PendCcr")
                    IF CURSORGETPROP("Buffering", "cursor_4c_PendCcr") > 1
                        TABLEREVERT(.T., "cursor_4c_PendCcr")
                    ENDIF
                    USE IN cursor_4c_PendCcr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendCcr")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar as pend" + CHR(234) + ;
                        "ncias de conta corrente:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_PendCcr
                    SCAN
                        *-- Guard do legado: lancamento sem operacao, de tipo
                        *-- diferente de " "/"X", ou com documento e tipo <> "X"
                        *-- nao gera pendencia
                        IF TratarNulo(cursor_4c_PendCcr.Nopers, 0) = 0 OR ;
                           !INLIST(TratarNulo(cursor_4c_PendCcr.Tipos, " "), " ", "X") OR ;
                           (!EMPTY(TratarNulo(cursor_4c_PendCcr.Dopes, "")) AND ;
                            TratarNulo(cursor_4c_PendCcr.Numes, 0) <> 0 AND ;
                            TratarNulo(cursor_4c_PendCcr.Tipos, " ") <> "X")
                            LOOP
                        ENDIF

                        loc_nValos = TratarNulo(cursor_4c_PendCcr.Valors, 0) - ;
                                     TratarNulo(cursor_4c_PendCcr.Valpags, 0)

                        IF loc_nValos > 0
                            INSERT INTO TmpPar ;
                                (emps, grupos, vencs, fpags, valos, moefpgs, hists, opers) ;
                                VALUES ;
                                (TratarNulo(cursor_4c_PendCcr.Emps, ""), ;
                                 TratarNulo(cursor_4c_PendCcr.Grupos, ""), ;
                                 ConverterParaData(cursor_4c_PendCcr.Vencs), ;
                                 "C/Corrente", ;
                                 loc_nValos, ;
                                 TratarNulo(cursor_4c_PendCcr.Moedas, ""), ;
                                 LEFT(TratarNulo(cursor_4c_PendCcr.Hists, ""), 50), ;
                                 TratarNulo(cursor_4c_PendCcr.Opers, ""))
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_PendCcr")
                        USE IN cursor_4c_PendCcr
                    ENDIF

                    *-- (2) Parcelas de movimento (origem/destino)
                    loc_cSQL = "SELECT a.Grupods, a.Contads, a.Grupoos, a.Contaos," + ;
                        " c.Emps, c.Dopes, c.Numes, c.Vencs, c.Fpags, c.Moefpgs," + ;
                        " c.Valos, c.Vpags, b.COpers" + ;
                        " FROM SigMvCab a" + ;
                        " JOIN SigMvPar c ON a.EmpDopNums = c.EmpDopNums" + ;
                        " JOIN SigCdOpe b ON c.Dopes = b.Dopes" + ;
                        " JOIN SigOpFp d ON c.Fpags = d.Fpags" + ;
                        " WHERE c.Pagos = '1'" + ;
                        " AND b.ValPends = 1 AND b.Parcs = 1" + ;
                        " AND d.ValPends = 1 AND ISNULL(d.LisConGv, 0) <> 2" + ;
                        " AND (a.Contads = " + EscaparSQL(loc_cConta) + ;
                        " OR a.Contaos = " + EscaparSQL(loc_cConta) + ")" + ;
                        " AND (ISNULL(d.Infos, '') <> 'C'" + ;
                        " OR EXISTS (SELECT 1 FROM SigChe e" + ;
                        " JOIN SigCdOpt f ON e.Umovs = f.Operacaos" + ;
                        " WHERE e.Bancos = c.Bancos AND e.Agencias = c.Agencias" + ;
                        " AND e.NContas = c.Contas AND e.NCheques = c.Numeros" + ;
                        " AND f.Tipos = 'DB'))"

                    IF loc_lTemPeriodo
                        loc_cSQL = loc_cSQL + ;
                            " AND a.Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                            " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                    ENDIF

                    IF USED("cursor_4c_PendPar")
                        IF CURSORGETPROP("Buffering", "cursor_4c_PendPar") > 1
                            TABLEREVERT(.T., "cursor_4c_PendPar")
                        ENDIF
                        USE IN cursor_4c_PendPar
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendPar")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao carregar as pend" + CHR(234) + ;
                            "ncias de movimento:" + CHR(13) + CapturarErroSQL()
                    ELSE
                        SELECT cursor_4c_PendPar
                        SCAN
                            *-- Sentido da operacao: COpers = 1 -> a conta eh o
                            *-- DESTINO; caso contrario eh a ORIGEM. O legado
                            *-- descarta a linha quando o lado correspondente
                            *-- nao eh a conta pesquisada.
                            IF TratarNulo(cursor_4c_PendPar.COpers, 0) = 1
                                loc_cGrupo = TratarNulo(cursor_4c_PendPar.Grupods, "")
                                loc_cOpers = "D"
                                IF ALLTRIM(TratarNulo(cursor_4c_PendPar.Contads, "")) != loc_cConta
                                    LOOP
                                ENDIF
                            ELSE
                                loc_cGrupo = TratarNulo(cursor_4c_PendPar.Grupoos, "")
                                loc_cOpers = "C"
                                IF ALLTRIM(TratarNulo(cursor_4c_PendPar.Contaos, "")) != loc_cConta
                                    LOOP
                                ENDIF
                            ENDIF

                            loc_nValos = TratarNulo(cursor_4c_PendPar.Valos, 0) - ;
                                         TratarNulo(cursor_4c_PendPar.Vpags, 0)

                            IF loc_nValos > 0
                                loc_cHists = TratarNulo(cursor_4c_PendPar.Emps, "") + ;
                                    ALLTRIM(TratarNulo(cursor_4c_PendPar.Dopes, "")) + " - " + ;
                                    ALLTRIM(fGerMascara(TratarNulo(cursor_4c_PendPar.Numes, 0)))

                                INSERT INTO TmpPar ;
                                    (emps, grupos, vencs, fpags, valos, moefpgs, ;
                                     hists, opers, dopes, numes) ;
                                    VALUES ;
                                    (TratarNulo(cursor_4c_PendPar.Emps, ""), ;
                                     loc_cGrupo, ;
                                     ConverterParaData(cursor_4c_PendPar.Vencs), ;
                                     LEFT(TratarNulo(cursor_4c_PendPar.Fpags, ""), 15), ;
                                     loc_nValos, ;
                                     TratarNulo(cursor_4c_PendPar.Moefpgs, ""), ;
                                     LEFT(loc_cHists, 50), ;
                                     loc_cOpers, ;
                                     TratarNulo(cursor_4c_PendPar.Dopes, ""), ;
                                     TratarNulo(cursor_4c_PendPar.Numes, 0))
                            ENDIF
                        ENDSCAN

                        IF USED("cursor_4c_PendPar")
                            USE IN cursor_4c_PendPar
                        ENDIF

                        *-- (3) Formas de pagamento presentes, JA marcadas
                        IF USED("cursor_4c_TiposTmp")
                            USE IN cursor_4c_TiposTmp
                        ENDIF
                        SELECT DISTINCT fpags ;
                            FROM TmpPar ;
                            WHERE !EMPTY(fpags) ;
                            INTO CURSOR cursor_4c_TiposTmp READWRITE

                        SELECT cursor_4c_TiposTmp
                        SCAN
                            INSERT INTO crTmpTipos (Listas, fPags) ;
                                VALUES (1, LEFT(cursor_4c_TiposTmp.fpags, 12))
                        ENDSCAN

                        IF USED("cursor_4c_TiposTmp")
                            USE IN cursor_4c_TiposTmp
                        ENDIF

                        SELECT TmpPar
                        GO TOP
                        SELECT crTmpTipos
                        GO TOP

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar as pend" + CHR(234) + "ncias:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * TotalPendencias - Soma de TmpPar.valos respeitando o filtro corrente da
    * grade (getTotPends do legado, alimentado no Cmb_Grupo.InteractiveChange e
    * no FiltraTipos()). Percorre o cursor JA filtrado, por isso soma o que esta
    * visivel na grade - que eh o comportamento do legado.
    *==========================================================================
    FUNCTION TotalPendencias()
        LOCAL loc_nSoma, loc_nRegistro
        loc_nSoma = 0

        IF !USED("TmpPar")
            RETURN 0
        ENDIF

        TRY
            SELECT TmpPar
            loc_nRegistro = IIF(RECCOUNT("TmpPar") > 0, RECNO("TmpPar"), 0)
            SCAN
                loc_nSoma = loc_nSoma + TratarNulo(TmpPar.valos, 0)
            ENDSCAN
            *-- SCAN deixa o ponteiro em EOF: repor para a grade nao perder a
            *-- linha corrente
            IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT("TmpPar")
                GO (loc_nRegistro) IN TmpPar
            ELSE
                GO TOP IN TmpPar
            ENDIF
        CATCH TO loException
            loc_nSoma = 0
        ENDTRY

        RETURN loc_nSoma
    ENDFUNC

    *==========================================================================
    * CarregarCheques - Popula as quatro grades da aba Cheques e os nove
    * totais somente-leitura do pe da pagina, reproduzindo o trecho de cheques
    * do Processa() legado:
    *
    *   dbAberto    <- SigChe + SigCqChm + SigCdOpt, cheques do cliente em
    *                  operacao de DEBITO que nao esta fora da consulta global
    *                  (SigCdOpt.Tipos = "DB" e Congvs <> "N")
    *   DbFollow    <- SigCheh dos cheques carregados (historico/follow-up); o
    *                  cheque que tem follow-up fica com dbAberto.Flags = .T.,
    *                  como no legado
    *   dbDevolvido <- SigChe + SigCqChm + SigCdOpt com Devolvidos = "S",
    *                  agrupando reincidencia do MESMO cheque em numincdevs
    *   DbTitulo    <- SigMvCcr + SigOpOpe (titulos de cheque negociado)
    *
    * Totais (so calculados quando o grupo controla limite de credito -
    * SigCdGcr.limcres = 1, exatamente como o legado):
    *   this_nLimiteCredito      SigClLcr.limcres convertido para a moeda padrao
    *   this_nSaldoContaCorrente soma de SigMvSlc convertida
    *   this_nChequesNegociados  soma de DbTitulo.Saldos convertida
    *   this_nChequesAVencer     cheques com vencimento >= hoje
    *   this_nChequesVencidos    cheques com vencimento < hoje
    *   this_nChequesDevolvidos  cheques marcados como devolvidos
    *   this_nValorEstoque       valor do estoque em poder do cliente (quando o
    *                            grupo controla limite de estoque)
    *   this_nLimiteDisponivel   limite - saldo - negociados - estoque (e menos
    *                            os cheques em carteira quando chqlcreds esta
    *                            ligado)
    *   this_nTotalChequeAberto  soma de dbAberto.valors (Fwget3 do legado)
    *==========================================================================
    FUNCTION CarregarCheques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta, loc_lTemPeriodo
        LOCAL loc_dIni, loc_dFim, loc_cGrupo, loc_cListaNums, loc_cChave
        LOCAL loc_cMoeLim, loc_nCotLim, loc_nCotSal, loc_nLimite, loc_nSaldo
        LOCAL loc_nChqNeg, loc_nDisp, loc_nChequeC, loc_nChequeP
        LOCAL loc_nChqAv, loc_nChqVc, loc_nChqDv, loc_nVlEstq, loc_nValorItem
        LOCAL loc_cMoeItem, loc_nTotAberto, loc_nTotDevolv
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("dbAberto") OR !USED("dbDevolvido") OR !USED("DbFollow") OR !USED("DbTitulo")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF EMPTY(THIS.this_cGrupoPadrao)
                    THIS.CarregarParametros()
                ENDIF
                loc_cGrupo = ALLTRIM(THIS.this_cGrupoPadrao)

                loc_dIni = ConverterParaData(THIS.this_dDataInicial)
                loc_dFim = ConverterParaData(THIS.this_dDataFinal)
                loc_lTemPeriodo = (!EMPTY(loc_dIni) AND !EMPTY(loc_dFim))

                SELECT dbAberto
                ZAP
                SELECT dbDevolvido
                ZAP
                SELECT DbFollow
                ZAP
                SELECT DbTitulo
                ZAP

                STORE 0 TO THIS.this_nLimiteCredito, THIS.this_nChequesAVencer, ;
                    THIS.this_nChequesVencidos, THIS.this_nChequesDevolvidos, ;
                    THIS.this_nSaldoContaCorrente, THIS.this_nChequesNegociados, ;
                    THIS.this_nLimiteDisponivel, THIS.this_nValorEstoque, ;
                    THIS.this_nTotalChequeAberto, THIS.this_nTotalDevolvido

                *-- (1) Cheques em aberto
                loc_cSQL = "SELECT a.Vencs, a.Bancos, a.Agencias, a.NContas," + ;
                    " a.NCheques, a.Valors, a.Nums, b.Devolvidos" + ;
                    " FROM SigChe a" + ;
                    " JOIN SigCdOpt b ON a.Umovs = b.Operacaos" + ;
                    " JOIN SigCqChm c ON a.Nums = c.Nums" + ;
                    " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
                    " AND b.Tipos = 'DB' AND ISNULL(b.Congvs, '') <> 'N'"

                IF loc_lTemPeriodo
                    loc_cSQL = loc_cSQL + ;
                        " AND a.Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                        " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                ENDIF

                IF USED("cursor_4c_CheAbe")
                    IF CURSORGETPROP("Buffering", "cursor_4c_CheAbe") > 1
                        TABLEREVERT(.T., "cursor_4c_CheAbe")
                    ENDIF
                    USE IN cursor_4c_CheAbe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheAbe")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar os cheques em aberto:" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    loc_cListaNums = ""

                    SELECT cursor_4c_CheAbe
                    SCAN
                        INSERT INTO dbAberto ;
                            (grupos, vencs, bancos, agencias, ncontas, ncheques, ;
                             valors, Nums, Devolvidos) ;
                            VALUES ;
                            (loc_cGrupo, ;
                             ConverterParaData(cursor_4c_CheAbe.Vencs), ;
                             TratarNulo(cursor_4c_CheAbe.Bancos, ""), ;
                             TratarNulo(cursor_4c_CheAbe.Agencias, ""), ;
                             TratarNulo(cursor_4c_CheAbe.NContas, ""), ;
                             TratarNulo(cursor_4c_CheAbe.NCheques, ""), ;
                             TratarNulo(cursor_4c_CheAbe.Valors, 0), ;
                             TratarNulo(cursor_4c_CheAbe.Nums, ""), ;
                             TratarNulo(cursor_4c_CheAbe.Devolvidos, ""))

                        IF !EMPTY(TratarNulo(cursor_4c_CheAbe.Nums, ""))
                            loc_cListaNums = loc_cListaNums + ;
                                IIF(EMPTY(loc_cListaNums), "", ", ") + ;
                                EscaparSQL(ALLTRIM(cursor_4c_CheAbe.Nums))
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_CheAbe")
                        USE IN cursor_4c_CheAbe
                    ENDIF

                    *-- (2) Follow-up dos cheques carregados (SigCheh). O legado
                    *-- consulta cheque a cheque; aqui a lista de numeros vai em
                    *-- UMA consulta, com o mesmo efeito (inclusive a marca
                    *-- dbAberto.Flags no cheque que tem historico).
                    IF !EMPTY(loc_cListaNums)
                        IF USED("cursor_4c_CheHis")
                            IF CURSORGETPROP("Buffering", "cursor_4c_CheHis") > 1
                                TABLEREVERT(.T., "cursor_4c_CheHis")
                            ENDIF
                            USE IN cursor_4c_CheHis
                        ENDIF

                        loc_cSQL = "SELECT Nums, Datas, Hists FROM SigCheh" + ;
                            " WHERE Nums IN (" + loc_cListaNums + ")" + ;
                            " ORDER BY Nums, Datas"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheHis")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_CheHis")
                            SELECT cursor_4c_CheHis
                            SCAN
                                INSERT INTO DbFollow (Nums, Datas, Hists) ;
                                    VALUES ;
                                    (TratarNulo(cursor_4c_CheHis.Nums, ""), ;
                                     ConverterParaData(cursor_4c_CheHis.Datas), ;
                                     LEFT(TratarNulo(cursor_4c_CheHis.Hists, ""), 76))

                                SELECT dbAberto
                                LOCATE FOR ALLTRIM(dbAberto.Nums) == ;
                                    ALLTRIM(TratarNulo(cursor_4c_CheHis.Nums, ""))
                                IF FOUND("dbAberto")
                                    REPLACE dbAberto.Flags WITH .T. IN dbAberto
                                ENDIF
                                SELECT cursor_4c_CheHis
                            ENDSCAN

                            USE IN cursor_4c_CheHis
                        ENDIF
                    ENDIF

                    *-- (3) Cheques devolvidos
                    loc_cSQL = "SELECT a.Vencs, a.Bancos, a.Agencias, a.NContas," + ;
                        " a.NCheques, a.Valors, a.Nums, a.Grclis" + ;
                        " FROM SigChe a" + ;
                        " JOIN SigCqChm b ON a.Nums = b.Nums" + ;
                        " JOIN SigCdOpt c ON b.Codigos = c.Operacaos" + ;
                        " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
                        " AND c.Devolvidos = 'S'"

                    IF loc_lTemPeriodo
                        loc_cSQL = loc_cSQL + ;
                            " AND a.Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                            " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                    ENDIF

                    IF USED("cursor_4c_CheDev")
                        IF CURSORGETPROP("Buffering", "cursor_4c_CheDev") > 1
                            TABLEREVERT(.T., "cursor_4c_CheDev")
                        ENDIF
                        USE IN cursor_4c_CheDev
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheDev")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_CheDev")
                        SELECT cursor_4c_CheDev
                        SCAN
                            *-- Chave POSICIONAL do indice Cheque (regra #42): as
                            *-- quatro partes vao PADR na largura da coluna do
                            *-- cursor - 3 + 4 + 10 + 6
                            loc_cChave = ;
                                PADR(TratarNulo(cursor_4c_CheDev.Bancos, ""), 3) + ;
                                PADR(TratarNulo(cursor_4c_CheDev.Agencias, ""), 4) + ;
                                PADR(TratarNulo(cursor_4c_CheDev.NContas, ""), 10) + ;
                                PADR(TratarNulo(cursor_4c_CheDev.NCheques, ""), 6)

                            IF SEEK(loc_cChave, "dbDevolvido", "Cheque")
                                REPLACE dbDevolvido.numincdevs ;
                                    WITH dbDevolvido.numincdevs + 1 IN dbDevolvido
                            ELSE
                                INSERT INTO dbDevolvido ;
                                    (grupos, vencs, bancos, agencias, ncontas, ;
                                     ncheques, valors, numincdevs) ;
                                    VALUES ;
                                    (TratarNulo(cursor_4c_CheDev.Grclis, ""), ;
                                     ConverterParaData(cursor_4c_CheDev.Vencs), ;
                                     TratarNulo(cursor_4c_CheDev.Bancos, ""), ;
                                     TratarNulo(cursor_4c_CheDev.Agencias, ""), ;
                                     TratarNulo(cursor_4c_CheDev.NContas, ""), ;
                                     TratarNulo(cursor_4c_CheDev.NCheques, ""), ;
                                     TratarNulo(cursor_4c_CheDev.Valors, 0), ;
                                     1)
                            ENDIF
                            SELECT cursor_4c_CheDev
                        ENDSCAN

                        USE IN cursor_4c_CheDev
                    ENDIF

                    *-- (4) Titulos (cheques negociados)
                    loc_cSQL = "SELECT a.Grupos, a.Titulos, a.Vencs, a.Valors," + ;
                        " a.Valpags, a.Moedas, a.Hist2s AS Hists," + ;
                        " (a.Valors - a.ValPags) AS Saldos" + ;
                        " FROM SigMvCcr a" + ;
                        " JOIN SigOpOpe b ON a.Dopcs = b.Dopes" + ;
                        " WHERE b.Congvs = 1" + ;
                        " AND a.Contems = " + EscaparSQL(loc_cConta) + ;
                        " AND a.Opers = LEFT(b.Opers, 1)" + ;
                        " AND a.Pagos = '1' AND a.Tipos = ' '"

                    IF USED("cursor_4c_Titulos")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Titulos") > 1
                            TABLEREVERT(.T., "cursor_4c_Titulos")
                        ENDIF
                        USE IN cursor_4c_Titulos
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Titulos")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_Titulos")
                        SELECT cursor_4c_Titulos
                        SCAN
                            INSERT INTO DbTitulo ;
                                (Grupos, Titulos, Vencs, Valors, ValPags, Saldos, ;
                                 Hists, Moedas) ;
                                VALUES ;
                                (TratarNulo(cursor_4c_Titulos.Grupos, ""), ;
                                 TratarNulo(cursor_4c_Titulos.Titulos, ""), ;
                                 ConverterParaData(cursor_4c_Titulos.Vencs), ;
                                 TratarNulo(cursor_4c_Titulos.Valors, 0), ;
                                 TratarNulo(cursor_4c_Titulos.Valpags, 0), ;
                                 TratarNulo(cursor_4c_Titulos.Saldos, 0), ;
                                 LEFT(TratarNulo(cursor_4c_Titulos.Hists, ""), 26), ;
                                 TratarNulo(cursor_4c_Titulos.Moedas, ""))
                        ENDSCAN

                        USE IN cursor_4c_Titulos
                    ENDIF

                    *-- (5) Totais - so quando o grupo controla limite de credito
                    loc_cMoeLim = ALLTRIM(THIS.this_cMoedaPadrao)
                    loc_nCotLim = THIS.ObterCotacao(loc_cMoeLim, DATE())
                    IF loc_nCotLim = 0
                        loc_nCotLim = 1
                    ENDIF

                    STORE 0 TO loc_nLimite, loc_nSaldo, loc_nChqNeg, loc_nDisp, ;
                        loc_nChequeC, loc_nChequeP, loc_nChqAv, loc_nChqVc, ;
                        loc_nChqDv, loc_nVlEstq

                    IF THIS.this_nGrupoLimCredito = 1
                        *-- Limite de credito do cliente (SigClLcr)
                        IF USED("cursor_4c_Lcr")
                            USE IN cursor_4c_Lcr
                        ENDIF
                        loc_cSQL = "SELECT limcres, moedas FROM SigClLcr" + ;
                            " WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ;
                            " AND Contas = " + EscaparSQL(loc_cConta)
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lcr")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_Lcr")
                            IF RECCOUNT("cursor_4c_Lcr") > 0
                                SELECT cursor_4c_Lcr
                                GO TOP
                                IF ALLTRIM(TratarNulo(cursor_4c_Lcr.moedas, "")) != loc_cMoeLim
                                    loc_nCotSal = THIS.ObterCotacao( ;
                                        TratarNulo(cursor_4c_Lcr.moedas, ""), DATE())
                                    loc_nLimite = ROUND(TratarNulo(cursor_4c_Lcr.limcres, 0) * ;
                                        loc_nCotSal / loc_nCotLim, 2)
                                ELSE
                                    loc_nLimite = TratarNulo(cursor_4c_Lcr.limcres, 0)
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_Lcr
                        ENDIF

                        *-- Saldo consolidado da conta (SigMvSlc), convertido
                        IF USED("cursor_4c_Slc")
                            USE IN cursor_4c_Slc
                        ENDIF
                        loc_cSQL = "SELECT grupos, moedas, saldos FROM SigMvSlc" + ;
                            " WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ;
                            " AND Contas = " + EscaparSQL(loc_cConta)
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Slc")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_Slc")
                            SELECT cursor_4c_Slc
                            SCAN
                                IF ALLTRIM(TratarNulo(cursor_4c_Slc.moedas, "")) != loc_cMoeLim
                                    loc_nCotSal = THIS.ObterCotacao( ;
                                        TratarNulo(cursor_4c_Slc.moedas, ""), DATE())
                                    loc_nSaldo = loc_nSaldo + ;
                                        ROUND(TratarNulo(cursor_4c_Slc.saldos, 0) * ;
                                        loc_nCotSal / loc_nCotLim, 2)
                                ELSE
                                    loc_nSaldo = loc_nSaldo + TratarNulo(cursor_4c_Slc.saldos, 0)
                                ENDIF
                            ENDSCAN
                            USE IN cursor_4c_Slc
                        ENDIF

                        loc_nDisp = loc_nLimite - loc_nSaldo

                        *-- Cheques negociados (saldo dos titulos), convertido
                        SELECT DbTitulo
                        SCAN
                            IF ALLTRIM(TratarNulo(DbTitulo.Moedas, "")) != loc_cMoeLim
                                loc_nCotSal = THIS.ObterCotacao(DbTitulo.Moedas, DATE())
                                loc_nChqNeg = loc_nChqNeg + ;
                                    ROUND(TratarNulo(DbTitulo.Saldos, 0) * ;
                                    loc_nCotSal / loc_nCotLim, 2)
                            ELSE
                                loc_nChqNeg = loc_nChqNeg + TratarNulo(DbTitulo.Saldos, 0)
                            ENDIF
                        ENDSCAN
                        GO TOP IN DbTitulo

                        loc_nDisp = loc_nDisp - loc_nChqNeg

                        *-- Cheques do cliente por situacao (a vencer / vencido /
                        *-- devolvido) e em carteira (SigOpFp.valpends <> 1)
                        IF USED("cursor_4c_CheSit")
                            USE IN cursor_4c_CheSit
                        ENDIF
                        loc_cSQL = "SELECT a.Valors, a.Fpags, a.Vencs," + ;
                            " b.Devolvidos, ISNULL(d.ValPends, 0) AS ValPends" + ;
                            " FROM SigChe a" + ;
                            " JOIN SigCdOpt b ON a.Umovs = b.Operacaos" + ;
                            " LEFT JOIN SigOpFp d ON a.Fpags = d.Fpags" + ;
                            " WHERE a.Grclis = " + EscaparSQL(loc_cGrupo) + ;
                            " AND a.Iclis = " + EscaparSQL(loc_cConta) + ;
                            " AND b.Tipos = 'DB'"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheSit")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_CheSit")
                            SELECT cursor_4c_CheSit
                            SCAN
                                IF EMPTY(TratarNulo(cursor_4c_CheSit.Fpags, ""))
                                    loc_nChequeP = loc_nChequeP + ;
                                        TratarNulo(cursor_4c_CheSit.Valors, 0)
                                ELSE
                                    IF TratarNulo(cursor_4c_CheSit.ValPends, 0) <> 1
                                        loc_nChequeC = loc_nChequeC + ;
                                            TratarNulo(cursor_4c_CheSit.Valors, 0)
                                    ELSE
                                        loc_nChequeP = loc_nChequeP + ;
                                            TratarNulo(cursor_4c_CheSit.Valors, 0)
                                    ENDIF
                                ENDIF

                                IF ConverterParaData(cursor_4c_CheSit.Vencs) >= DATE()
                                    loc_nChqAv = loc_nChqAv + ;
                                        TratarNulo(cursor_4c_CheSit.Valors, 0)
                                ELSE
                                    loc_nChqVc = loc_nChqVc + ;
                                        TratarNulo(cursor_4c_CheSit.Valors, 0)
                                ENDIF

                                IF ALLTRIM(TratarNulo(cursor_4c_CheSit.Devolvidos, "")) == "S"
                                    loc_nChqDv = loc_nChqDv + ;
                                        TratarNulo(cursor_4c_CheSit.Valors, 0)
                                ENDIF
                            ENDSCAN
                            USE IN cursor_4c_CheSit
                        ENDIF

                        loc_nChequeC = ROUND(loc_nChequeC / loc_nCotLim, 2)
                        loc_nChequeP = ROUND(loc_nChequeP / loc_nCotLim, 2)
                        loc_nChqAv   = ROUND(loc_nChqAv   / loc_nCotLim, 2)
                        loc_nChqVc   = ROUND(loc_nChqVc   / loc_nCotLim, 2)
                        loc_nChqDv   = ROUND(loc_nChqDv   / loc_nCotLim, 2)

                        IF THIS.this_lChqLimitaCredito
                            loc_nDisp = loc_nDisp - loc_nChequeC
                        ENDIF
                    ENDIF

                    *-- (6) Valor do estoque em poder do cliente
                    IF THIS.this_nGrupoLimEstoque = 1 AND !EMPTY(THIS.this_cMoedaLimEstoque)
                        IF USED("cursor_4c_EstVal")
                            USE IN cursor_4c_EstVal
                        ENDIF

                        loc_cSQL = "SELECT a.Cpros, SUM(a.Sqtds) AS Qtds," + ;
                            " p.Moevs, p.Pvens, p.Fvendas, p.Moepvs, p.Pesoms," + ;
                            " p.Custofs, p.Moecusfs, l.TpVendas, l.TpCustos" + ;
                            " FROM SigMvEst a" + ;
                            " JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                            " LEFT JOIN SigCdPro p ON a.Cpros = p.Cpros" + ;
                            " LEFT JOIN SigCdLin l ON p.Linhas = l.Linhas" + ;
                            " WHERE a.Estos = " + EscaparSQL(loc_cConta) + ;
                            " AND ISNULL(b.ChkLimEsts, 0) <> 2" + ;
                            " GROUP BY a.Cpros, p.Moevs, p.Pvens, p.Fvendas," + ;
                            " p.Moepvs, p.Pesoms, p.Custofs, p.Moecusfs," + ;
                            " l.TpVendas, l.TpCustos"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_EstVal")
                            SELECT cursor_4c_EstVal
                            SCAN
                                IF THIS.this_nTipoPreco = 1
                                    *-- Avalia a preco de VENDA
                                    loc_cMoeItem = TratarNulo(cursor_4c_EstVal.Moevs, "")
                                    loc_nValorItem = ROUND(TratarNulo(cursor_4c_EstVal.Pvens, 0) * ;
                                        IIF(TratarNulo(cursor_4c_EstVal.Fvendas, 0) <> 0 AND ;
                                            !EMPTY(TratarNulo(cursor_4c_EstVal.Moepvs, "")), ;
                                            TratarNulo(cursor_4c_EstVal.Fvendas, 0), 1), 2)
                                    IF ALLTRIM(TratarNulo(cursor_4c_EstVal.TpVendas, "")) == "2"
                                        loc_nValorItem = TratarNulo(cursor_4c_EstVal.Pesoms, 0) * ;
                                            loc_nValorItem
                                    ENDIF
                                ELSE
                                    *-- Avalia a CUSTO
                                    loc_cMoeItem = TratarNulo(cursor_4c_EstVal.Moecusfs, "")
                                    loc_nValorItem = TratarNulo(cursor_4c_EstVal.Custofs, 0)
                                    IF ALLTRIM(TratarNulo(cursor_4c_EstVal.TpCustos, "")) == "2"
                                        loc_nValorItem = TratarNulo(cursor_4c_EstVal.Pesoms, 0) * ;
                                            loc_nValorItem
                                    ENDIF
                                ENDIF

                                loc_nValorItem = loc_nValorItem * ;
                                    TratarNulo(cursor_4c_EstVal.Qtds, 0)

                                IF loc_cMoeLim != ALLTRIM(loc_cMoeItem)
                                    loc_nVlEstq = loc_nVlEstq + ;
                                        (loc_nValorItem * ;
                                         THIS.ObterCotacao(loc_cMoeItem, DATE()) / loc_nCotLim)
                                ELSE
                                    loc_nVlEstq = loc_nVlEstq + loc_nValorItem
                                ENDIF
                            ENDSCAN
                            USE IN cursor_4c_EstVal
                        ENDIF

                        loc_nDisp = loc_nDisp - loc_nVlEstq
                    ENDIF

                    *-- (7) Totais das grades (Fwget3 / Get_TotDevolvido)
                    *-- SUM ... TO exige MEMVAR (nao aceita property)
                    loc_nTotAberto = 0
                    loc_nTotDevolv = 0

                    SELECT dbAberto
                    SUM dbAberto.valors TO loc_nTotAberto
                    GO TOP IN dbAberto

                    SELECT dbDevolvido
                    SUM dbDevolvido.valors TO loc_nTotDevolv
                    GO TOP IN dbDevolvido

                    THIS.this_nTotalChequeAberto = loc_nTotAberto
                    THIS.this_nTotalDevolvido    = loc_nTotDevolv

                    THIS.this_nLimiteCredito       = loc_nLimite
                    THIS.this_nSaldoContaCorrente  = loc_nSaldo
                    THIS.this_nChequesNegociados   = loc_nChqNeg
                    THIS.this_nChequesAVencer      = loc_nChqAv
                    THIS.this_nChequesVencidos     = loc_nChqVc
                    THIS.this_nChequesDevolvidos   = loc_nChqDv
                    THIS.this_nValorEstoque        = loc_nVlEstq
                    THIS.this_nLimiteDisponivel    = loc_nDisp

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar os cheques:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarCartoes - Popula TmpCart (grade da aba Cartao), reproduzindo o
    * PCartao() legado: le os cartoes do cliente em SigCdCrd e mantem apenas os
    * que ainda tem saldo a receber (TotRes - TotPar <> 0).
    *==========================================================================
    FUNCTION CarregarCartoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("TmpCart")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                SELECT TmpCart
                ZAP

                loc_cSQL = "SELECT Cartaos, Datas, Fpags, Valos, Nocreditos," + ;
                    " Vencs, Totres, Totpar" + ;
                    " FROM SigCdCrd" + ;
                    " WHERE Iclis = " + EscaparSQL(loc_cConta)

                IF USED("cursor_4c_Card")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Card") > 1
                        TABLEREVERT(.T., "cursor_4c_Card")
                    ENDIF
                    USE IN cursor_4c_Card
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Card")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar os cart" + CHR(245) + ;
                        "es:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_Card
                    SCAN
                        *-- Guard do legado: so cartao com saldo em aberto
                        IF (TratarNulo(cursor_4c_Card.Totres, 0) - ;
                            TratarNulo(cursor_4c_Card.Totpar, 0)) <> 0
                            INSERT INTO TmpCart ;
                                (grupos, cartaos, datas, fpags, valos, nocreditos, vencs) ;
                                VALUES ;
                                (ALLTRIM(THIS.this_cGrupoPadrao), ;
                                 TratarNulo(cursor_4c_Card.Cartaos, ""), ;
                                 ConverterParaData(cursor_4c_Card.Datas), ;
                                 LEFT(TratarNulo(cursor_4c_Card.Fpags, ""), 12), ;
                                 TratarNulo(cursor_4c_Card.Valos, 0), ;
                                 TratarNulo(cursor_4c_Card.Nocreditos, ""), ;
                                 ConverterParaData(cursor_4c_Card.Vencs))
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_Card")
                        USE IN cursor_4c_Card
                    ENDIF

                    SELECT TmpCart
                    GO TOP

                    THIS.this_lOkCartao = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar os cart" + CHR(245) + "es:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarEstoque - Popula dbEstoque (grade da aba Estoque), reproduzindo o
    * PEstoque() legado: soma por grupo/produto o que esta no estoque da conta
    * (SigMvEst.Estos), considerando SOMENTE as empresas ATIVAS (SigCdEmp.Ativas
    * = 1 - a coluna de empresa de SigCdEmp eh Cemps, nao Cemps, regra #48) e
    * descartando os produtos com saldo zero.
    *==========================================================================
    FUNCTION CarregarEstoque()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("dbEstoque")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                SELECT dbEstoque
                ZAP

                loc_cSQL = "SELECT a.Grupos, a.Cpros, SUM(a.Sqtds) AS Sqtds" + ;
                    " FROM SigMvEst a" + ;
                    " JOIN SigCdEmp b ON a.Emps = b.Cemps" + ;
                    " WHERE a.Estos = " + EscaparSQL(loc_cConta) + ;
                    " AND b.Ativas = 1" + ;
                    " GROUP BY a.Grupos, a.Cpros"

                IF USED("cursor_4c_Est")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Est") > 1
                        TABLEREVERT(.T., "cursor_4c_Est")
                    ENDIF
                    USE IN cursor_4c_Est
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Est")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar o estoque:" + CHR(13) + ;
                        CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_Est
                    SCAN
                        *-- Guard do legado: produto com saldo zero nao entra
                        IF TratarNulo(cursor_4c_Est.Sqtds, 0) <> 0
                            INSERT INTO dbEstoque (grupos, cpros, sqtds) ;
                                VALUES ;
                                (TratarNulo(cursor_4c_Est.Grupos, ""), ;
                                 TratarNulo(cursor_4c_Est.Cpros, ""), ;
                                 TratarNulo(cursor_4c_Est.Sqtds, 0))
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_Est")
                        USE IN cursor_4c_Est
                    ENDIF

                    SELECT dbEstoque
                    GO TOP

                    THIS.this_lOkEstoque = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar o estoque:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarHCheques - Popula dbCheqHist (grade GradeCheque da aba H.Cheques),
    * reproduzindo o trecho inicial do mativahcheque() legado: todo cheque da
    * conta pesquisada, com o Vencs EXIBIDO sobrescrito pelo CASE da ultima
    * movimentacao (CR usa a data dessa movimentacao, DB usa a data de hoje -
    * o legado faz essa troca via coluna duplicada no SELECT, regra #42-like),
    * o Tipo vindo do LEFT JOIN com SigCheh (cheque com historico fica azul) e
    * o DiasP calculado em cima do Vencs exibido (nunca negativo).
    *
    * O periodo (Cnt_periodo) existe no SCX mas o legado o mantem desligado do
    * filtro (os dois ramos que o usariam ficam comentados no Processa() -
    * "*If...*Else...*EndIf"): por fidelidade, o container fica no form (oculto,
    * como no dump) e NAO entra no WHERE aqui.
    *
    * Ao final, posiciona no cheque de vencimento mais distante (GO BOTTOM na
    * ordem Venc, igual ao legado) e chama CarregarMovimentoCheque para esse
    * registro, que eh o estado inicial que o AfterRowColChange reproduziria.
    *==========================================================================
    FUNCTION CarregarHCheques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta, loc_dDiferenca
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("dbCheqHist")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                SELECT dbCheqHist
                ZAP

                loc_cSQL = "SELECT a.Emps, a.Bancos, a.Agencias, a.NContas, a.NCheques," + ;
                    " a.Valors, a.GruCarts, a.ConCarts, a.Numeros, a.Nums," + ;
                    " b.DTEnts AS DtEntsMov," + ;
                    " CASE WHEN c.Tipos = 'CR' THEN c.DTEnts" + ;
                    " WHEN c.Tipos = 'DB' THEN GETDATE() END AS VencsExib," + ;
                    " d.Nums AS TipoHist" + ;
                    " FROM SigChe a" + ;
                    " JOIN (SELECT MAX(DTEnts) AS DTEnts, Nums FROM SigCqChm GROUP BY Nums) b" + ;
                    " ON a.Nums = b.Nums" + ;
                    " JOIN SigCqChm c ON b.Nums = c.Nums AND b.DTEnts = c.DTEnts" + ;
                    " LEFT JOIN SigCheh d ON a.Nums = d.Nums" + ;
                    " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
                    " ORDER BY a.Vencs"

                IF USED("cursor_4c_HistChe")
                    IF CURSORGETPROP("Buffering", "cursor_4c_HistChe") > 1
                        TABLEREVERT(.T., "cursor_4c_HistChe")
                    ENDIF
                    USE IN cursor_4c_HistChe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistChe")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + ;
                        "rico de cheques:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_HistChe
                    SCAN
                        loc_dDiferenca = ConverterParaData(cursor_4c_HistChe.DtEntsMov) - ;
                            ConverterParaData(cursor_4c_HistChe.VencsExib)
                        IF loc_dDiferenca < 0
                            loc_dDiferenca = 0
                        ENDIF

                        INSERT INTO dbCheqHist ;
                            (Emps, Vencs, Bancos, Agencias, NContas, NCheques, Valors, ;
                             GruCarts, ConCarts, Numeros, DiasP, Tipo, Nums) ;
                            VALUES ;
                            (TratarNulo(cursor_4c_HistChe.Emps, ""), ;
                             ConverterParaData(cursor_4c_HistChe.VencsExib), ;
                             TratarNulo(cursor_4c_HistChe.Bancos, ""), ;
                             TratarNulo(cursor_4c_HistChe.Agencias, ""), ;
                             TratarNulo(cursor_4c_HistChe.NContas, ""), ;
                             TratarNulo(cursor_4c_HistChe.NCheques, ""), ;
                             TratarNulo(cursor_4c_HistChe.Valors, 0), ;
                             TratarNulo(cursor_4c_HistChe.GruCarts, ""), ;
                             TratarNulo(cursor_4c_HistChe.ConCarts, ""), ;
                             TratarNulo(cursor_4c_HistChe.Numeros, ""), ;
                             loc_dDiferenca, ;
                             TratarNulo(cursor_4c_HistChe.TipoHist, ""), ;
                             TratarNulo(cursor_4c_HistChe.Nums, ""))
                    ENDSCAN

                    IF USED("cursor_4c_HistChe")
                        USE IN cursor_4c_HistChe
                    ENDIF

                    SELECT dbCheqHist
                    SET ORDER TO TAG Venc
                    GO BOTTOM

                    IF RECCOUNT("dbCheqHist") > 0
                        THIS.CarregarMovimentoCheque(ALLTRIM(dbCheqHist.Nums))
                    ELSE
                        THIS.this_cFollowUpCheque = ""
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + "rico de cheques:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarMovimentoCheque - Popula dbCheqMovim (GradeMovimenta) e
    * dbCheqProrrog (GradeProrrog) com a movimentacao/prorrogacoes do cheque
    * par_cNums, e this_cFollowUpCheque com o historico mais recente
    * (SigCheh.Hists) - transcricao do AfterRowColChange da GradeCheque do
    * legado. Chamado tanto pela carga inicial (CarregarHCheques) quanto pelo
    * Form a cada troca de linha da grade (regra #46 - cursor != grade pintada).
    *==========================================================================
    FUNCTION CarregarMovimentoCheque(par_cNums)
        LOCAL loc_cNums, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        loc_cNums = ALLTRIM(IIF(VARTYPE(par_cNums) = "C", par_cNums, ""))

        IF EMPTY(loc_cNums)
            RETURN .F.
        ENDIF

        IF !USED("dbCheqMovim") OR !USED("dbCheqProrrog")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- Movimentacao (SigCqChm), mais recente primeiro
                SELECT dbCheqMovim
                ZAP

                loc_cSQL = "SELECT Codigos, Nalineas, Dtents, Gruorigs, Conorigs," + ;
                    " Grupos, Contas, Numlotes, Protocolos" + ;
                    " FROM SigCqChm WHERE Nums = " + EscaparSQL(loc_cNums) + ;
                    " ORDER BY Nums, Dtsis DESC"

                IF USED("cursor_4c_CheMov")
                    USE IN cursor_4c_CheMov
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheMov")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar a movimenta" + CHR(231) + CHR(227) + ;
                        "o do cheque:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_CheMov
                    SCAN
                        INSERT INTO dbCheqMovim ;
                            (Codigos, Nalineas, Dtents, Gruorigs, Conorigs, Grupos, Contas, ;
                             Numlotes, Protocolos) ;
                            VALUES ;
                            (TratarNulo(cursor_4c_CheMov.Codigos, ""), ;
                             TratarNulo(cursor_4c_CheMov.Nalineas, 0), ;
                             ConverterParaData(cursor_4c_CheMov.Dtents), ;
                             TratarNulo(cursor_4c_CheMov.Gruorigs, ""), ;
                             TratarNulo(cursor_4c_CheMov.Conorigs, ""), ;
                             TratarNulo(cursor_4c_CheMov.Grupos, ""), ;
                             TratarNulo(cursor_4c_CheMov.Contas, ""), ;
                             TratarNulo(cursor_4c_CheMov.Numlotes, 0), ;
                             TratarNulo(cursor_4c_CheMov.Protocolos, ""))
                    ENDSCAN

                    IF USED("cursor_4c_CheMov")
                        USE IN cursor_4c_CheMov
                    ENDIF

                    SELECT dbCheqMovim
                    GO TOP

                    *-- Prorrogacoes (SigChea)
                    SELECT dbCheqProrrog
                    ZAP

                    loc_cSQL = "SELECT Vencs, PJuros, VJuros, Usuars, Motivo" + ;
                        " FROM SigChea WHERE Nums = " + EscaparSQL(loc_cNums)

                    IF USED("cursor_4c_CheProrrog")
                        USE IN cursor_4c_CheProrrog
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheProrrog")

                    IF loc_nResultado >= 0
                        SELECT cursor_4c_CheProrrog
                        SCAN
                            INSERT INTO dbCheqProrrog (Vencs, PJuros, VJuros, Usuars, Motivo) ;
                                VALUES ;
                                (ConverterParaData(cursor_4c_CheProrrog.Vencs), ;
                                 TratarNulo(cursor_4c_CheProrrog.PJuros, 0), ;
                                 TratarNulo(cursor_4c_CheProrrog.VJuros, 0), ;
                                 TratarNulo(cursor_4c_CheProrrog.Usuars, ""), ;
                                 TratarNulo(cursor_4c_CheProrrog.Motivo, ""))
                        ENDSCAN

                        IF USED("cursor_4c_CheProrrog")
                            USE IN cursor_4c_CheProrrog
                        ENDIF
                    ENDIF

                    SELECT dbCheqProrrog
                    GO TOP

                    *-- Follow-up mais recente (SigCheh.Hists)
                    THIS.this_cFollowUpCheque = ""

                    loc_cSQL = "SELECT Hists FROM SigCheh WHERE Nums = " + ;
                        EscaparSQL(loc_cNums) + " ORDER BY Datas DESC"

                    IF USED("cursor_4c_CheFollow")
                        USE IN cursor_4c_CheFollow
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheFollow")

                    IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_CheFollow") > 0
                        THIS.this_cFollowUpCheque = TratarNulo(cursor_4c_CheFollow.Hists, "")
                    ENDIF

                    IF USED("cursor_4c_CheFollow")
                        USE IN cursor_4c_CheFollow
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar a movimenta" + CHR(231) + CHR(227) + ;
                "o do cheque:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarCredito - Popula dbCredito (grade Grade da aba Credito) com os
    * lancamentos de SigFiCp (compra/cobranca por cheque pre-datado/carteira)
    * do CPF pesquisado, transcricao do mativacredito() legado: normaliza o
    * CPF/CGC digitado para o formato mascarado (11 digitos -> CPF, 14 ->
    * CNPJ, senao mantem como veio) e usa essa mascara como chave de busca em
    * SigFiCp.Ccpfs (char(20), a mesma coluna onde o legado grava a mascara).
    *
    * Tambem resolve a situacao do cliente (SigCdCli.Situas) e a descricao
    * correspondente em SigCdCst para o rotulo colorido (Label2) - vermelho
    * quando Situas = "*", azul nos demais casos, igual ao legado.
    *==========================================================================
    FUNCTION CarregarCredito()
        LOCAL loc_cCpfBruto, loc_cCpfMask, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro      = ""
        THIS.this_cLabelSituacaoCredito = ""
        THIS.this_lSituacaoVermelha     = .F.

        IF !USED("dbCredito")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        loc_cCpfBruto = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(THIS.this_cCpf), ".", ""), "-", ""), "/", "")

        DO CASE
            CASE LEN(loc_cCpfBruto) = 11
                loc_cCpfMask = TRANSFORM(loc_cCpfBruto, "@R 999.999.999-99")
            CASE LEN(loc_cCpfBruto) = 14
                loc_cCpfMask = TRANSFORM(loc_cCpfBruto, "@R 99.999.999/9999-99")
            OTHERWISE
                loc_cCpfMask = loc_cCpfBruto
        ENDCASE

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                SELECT dbCredito
                ZAP

                loc_cSQL = "SELECT Tipos, Usuars, Emps, Datas, Dopes, Numes, Ccpfs," + ;
                    " Nvalors, Dvencs, Cbancos, Cagencias, Ccontas, Ccheinis, Cdiginis," + ;
                    " Cchefins, Cdigfins, Cseries, Cdaberts, NChkDocs, TdDocs" + ;
                    " FROM SigFiCp" + ;
                    " WHERE Ccpfs = " + EscaparSQL(loc_cCpfMask) + ;
                    " ORDER BY Idchep"

                IF USED("cursor_4c_FiCp")
                    USE IN cursor_4c_FiCp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FiCp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar o cr" + CHR(233) + "dito:" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_FiCp
                    SCAN
                        INSERT INTO dbCredito ;
                            (Tipos, Usuars, Emps, Datas, Dopes, Numes, Ccpfs, Nvalors, Dvencs, ;
                             Cbancos, Cagencias, Ccontas, Ccheinis, Cdiginis, Cchefins, ;
                             Cdigfins, Cseries, Cdaberts, NChkDocs, TdDocs) ;
                            VALUES ;
                            (TratarNulo(cursor_4c_FiCp.Tipos, ""), ;
                             TratarNulo(cursor_4c_FiCp.Usuars, ""), ;
                             TratarNulo(cursor_4c_FiCp.Emps, ""), ;
                             ConverterParaData(cursor_4c_FiCp.Datas), ;
                             TratarNulo(cursor_4c_FiCp.Dopes, ""), ;
                             TratarNulo(cursor_4c_FiCp.Numes, 0), ;
                             TratarNulo(cursor_4c_FiCp.Ccpfs, ""), ;
                             TratarNulo(cursor_4c_FiCp.Nvalors, 0), ;
                             ConverterParaData(cursor_4c_FiCp.Dvencs), ;
                             TratarNulo(cursor_4c_FiCp.Cbancos, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cagencias, ""), ;
                             TratarNulo(cursor_4c_FiCp.Ccontas, ""), ;
                             TratarNulo(cursor_4c_FiCp.Ccheinis, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cdiginis, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cchefins, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cdigfins, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cseries, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cdaberts, ""), ;
                             TratarNulo(cursor_4c_FiCp.NChkDocs, 0), ;
                             ConverterParaData(cursor_4c_FiCp.TdDocs))
                    ENDSCAN

                    IF USED("cursor_4c_FiCp")
                        USE IN cursor_4c_FiCp
                    ENDIF

                    SELECT dbCredito
                    GO TOP

                    *-- Situacao do cliente (pelo mesmo CPF) + descricao em SigCdCst
                    IF !EMPTY(loc_cCpfMask)
                        loc_cSQL = "SELECT Situas FROM SigCdCli WHERE Cpfs = " + ;
                            EscaparSQL(loc_cCpfMask)

                        IF USED("cursor_4c_CliSitua")
                            USE IN cursor_4c_CliSitua
                        ENDIF

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliSitua") > 0 ;
                                AND RECCOUNT("cursor_4c_CliSitua") > 0

                            THIS.this_lSituacaoVermelha = (ALLTRIM(TratarNulo(cursor_4c_CliSitua.Situas, "")) == "*")

                            loc_cSQL = "SELECT Descrs FROM SigCdCst WHERE Codigos = " + ;
                                EscaparSQL(PADR(TratarNulo(cursor_4c_CliSitua.Situas, ""), 3))

                            IF USED("cursor_4c_CstDesc")
                                USE IN cursor_4c_CstDesc
                            ENDIF

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CstDesc") > 0 ;
                                    AND RECCOUNT("cursor_4c_CstDesc") > 0
                                THIS.this_cLabelSituacaoCredito = ALLTRIM(TratarNulo(cursor_4c_CstDesc.Descrs, ""))
                            ENDIF

                            IF USED("cursor_4c_CstDesc")
                                USE IN cursor_4c_CstDesc
                            ENDIF
                        ENDIF

                        IF USED("cursor_4c_CliSitua")
                            USE IN cursor_4c_CliSitua
                        ENDIF
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar o cr" + CHR(233) + "dito:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao - NAO sobrescritos de proposito.
    *
    * SIGOPCGV eh um form OPERACIONAL de CONSULTA: a entidade SigCdCli eh
    * somente PESQUISADA aqui (por conta, nome, cpf/cgc, conjuge ou telefone)
    * para alimentar as abas de saldo, cheques, vendas, estoque, pendencias,
    * conserto, cartao, producao e credito. A unica gravacao de cliente do
    * form legado passa pelo wrapper clsconta (cnt_4c_Conta na Page de
    * alteracao), que tem seu proprio mGravaDados/mValidaObj - nao pela
    * ThisForm.poDataMgr deste BO. Por isso o comportamento padrao herdado
    * de BusinessBase ja eh o correto para Inserir/Atualizar/ExecutarExclusao.
    *==========================================================================

ENDDEFINE
