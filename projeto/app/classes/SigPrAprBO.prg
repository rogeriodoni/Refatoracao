*==============================================================================
* SIGPRAPRBO.PRG
* Business Object para Reajuste de Precificacao (SIGPRAPR)
* Entidade: SigPrApr
* Tabela principal: SigCdPro
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigPrAprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * FILTROS DE SELECAO DE PRODUTOS
    *--------------------------------------------------------------------------

    *-- Grupo de produto (de) - SigCdGrp.CGrus (C 3)
    this_cCdGrupo    = ""

    *-- Grupo de produto (ate) - SigCdGrp.CGrus (C 3)
    this_cAteGrupo   = ""

    *-- Colecao - SigCdCol.Colecoes (C 10)
    this_cCol        = ""

    *-- Fornecedor (codigo) - SigCdPro.IFors (C 10)
    this_cConta      = ""

    *-- Fornecedor (descricao) - C 50
    this_cDConta     = ""

    *-- Promocao - SigPrPmc.Promos (C 25)
    this_cPromo      = ""

    *--------------------------------------------------------------------------
    * TIPO DE REAJUSTE
    * 1 = Variacao de Preco (%)
    * 2 = MarkUp
    * 3 = Cambio (Preco Ideal)
    *--------------------------------------------------------------------------
    this_nTipo       = 1

    *--------------------------------------------------------------------------
    * CAMPOS PARA TIPO 1: VARIACAO DE PRECO
    *--------------------------------------------------------------------------

    *-- Percentual de variacao (N 9,2)
    this_nVariacao   = 0

    *-- Incluir custos no reajuste (1=Sim, 0=Nao)
    this_nIncCusts   = 0

    *--------------------------------------------------------------------------
    * CAMPOS PARA TIPO 2: MARKUP
    *--------------------------------------------------------------------------

    *-- Moeda de venda - SigCdMoe.CMoes (C 3)
    this_cMoeda      = ""

    *-- MarkUp de (N 6,2)
    this_nMarkUp1    = 0

    *-- MarkUp para (N 6,2)
    this_nMarkUp2    = 0

    *-- Fator de custo (N 8,3)
    this_nFator      = 0

    *-- Moeda do custo - SigCdMoe.CMoes (C 3)
    this_cMoeCusto   = ""

    *-- Moeda custo componente - SigCdMoe.CMoes (C 3)
    this_cMoecs      = ""

    *-- Moeda custo total - SigCdMoe.CMoes (C 3)
    this_cMoeCusFs   = ""

    *-- Feitio - SigPrFti.Cods (C 3)
    this_cCFtios     = ""

    *-- Moeda preco ideal - SigCdMoe.CMoes (C 3)
    this_cMoedas     = ""

    *-- Moeda preco atual - SigCdMoe.CMoes (C 3)
    this_cMoeVs      = ""

    *--------------------------------------------------------------------------
    * OPCOES DE PROCESSAMENTO
    *--------------------------------------------------------------------------

    *-- Modo entrada manual de produtos (CheckBox "Produtos") (1=Sim, 0=Nao)
    this_nAuditado   = 0

    *-- Limpar promocoes anteriores antes de aplicar (1=Sim, 0=Nao)
    this_nLimpar     = 0

    *-- Ignorar componentes na filtragem de produtos (1=Sim, 0=Nao)
    this_nIgnorar    = 0

    *--------------------------------------------------------------------------
    * ESTADO DO PROCESSAMENTO
    *--------------------------------------------------------------------------

    *-- Permissao para edicao manual de ValAtu (acesso SIGPRAPR/VMANUAL)
    this_lLibValAtu  = .F.

    *-- MarkUpCVs de SigCdPam (parametro de calculo)
    this_nMarkUpCV   = 0

    *-- GrPadFors de SigCdPam (grupo padrao fornecedor, usado em fAcessoContas)
    this_cGrPadFors  = ""

    *--------------------------------------------------------------------------
    * PARAMETROS DO SISTEMA (carregados por CarregarParametros)
    *--------------------------------------------------------------------------

    *-- SigCdPac.CalcCusts (1=usar peso no calculo, 2=nao usar peso)
    this_nCalcCusts  = 1

    *-- SigCdPac.nChkSubGrs (1=atualizar sub-grupos por faixa de preco)
    this_nChkSubGrs  = 0

    *--------------------------------------------------------------------------
    * REGISTRO CORRENTE (usado por CarregarDoCursor, Inserir, Atualizar)
    * Reflete a linha de SigPrPmi/SigCdPro atualmente sob manipulacao unitaria
    *--------------------------------------------------------------------------

    *-- Codigo do produto - SigCdPro.CPros / SigPrPmi.CPros (C 14)
    this_cCPros       = ""

    *-- Descricao do produto - SigCdPro.DPros (C 40)
    this_cDPros       = ""

    *-- Preco de venda anterior (snapshot antes do reajuste) N(14,2)
    this_nValAnt      = 0

    *-- Preco de venda atual (apos reajuste) N(14,2)
    this_nValAtu      = 0

    *-- Custo total do produto N(12,3)
    this_nCustoFs     = 0

    *-- Codigo de barras da promocao - SigPrPmi.CBars (C 20)
    this_cCBars       = ""

    *-- Pecas da promocao - SigPrPmi.Pecas (C 20)
    this_cPecas       = ""

    *-- Data da promocao - SigPrPmi.Datas (D)
    this_dDatas       = {}

    *-- Chave unica da promocao - SigPrPmi.CIdChaves (C 20)
    this_cCIdChaves   = ""

    *-- Chave secundaria PromoPro - SigPrPmi.PromoPro (C 40)
    this_cPromoPro    = ""

    *-- Data de alteracao - SigPrPmi.DtAlts (D)
    this_dDtAlts      = {}

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrPmi"
        THIS.this_cCampoChave = "CIdChaves"
        RETURN DODEFAULT("SigPrPmi")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave unica da promocao corrente
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados de SigPrPmi (ou SigCdPro) do cursor
    * para as propriedades do BO. Reconhece automaticamente as colunas
    * presentes no cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias   = ALLTRIM(NVL(par_cAliasCursor, ""))

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o est" + CHR(225) + ;
                                     " dispon" + CHR(237) + "vel: " + loc_cAlias
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            IF TYPE(loc_cAlias + ".CPros") != "U"
                THIS.this_cCPros    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CPros"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".DPros") != "U"
                THIS.this_cDPros    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".DPros"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".PVens") != "U"
                THIS.this_nValAnt   = NVL(EVALUATE(loc_cAlias + ".PVens"), 0)
                THIS.this_nValAtu   = NVL(EVALUATE(loc_cAlias + ".PVens"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".ValAnt") != "U"
                THIS.this_nValAnt   = NVL(EVALUATE(loc_cAlias + ".ValAnt"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".ValAtu") != "U"
                THIS.this_nValAtu   = NVL(EVALUATE(loc_cAlias + ".ValAtu"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".CustoFs") != "U"
                THIS.this_nCustoFs  = NVL(EVALUATE(loc_cAlias + ".CustoFs"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".fCustos") != "U"
                THIS.this_nFator    = NVL(EVALUATE(loc_cAlias + ".fCustos"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".MoePcs") != "U"
                THIS.this_cMoeCusto = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".MoePcs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".MoeCs") != "U"
                THIS.this_cMoecs    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".MoeCs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".MoeCusFs") != "U"
                THIS.this_cMoeCusFs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".MoeCusFs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Moedas") != "U"
                THIS.this_cMoedas   = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Moedas"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".MoeVs") != "U"
                THIS.this_cMoeVs    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".MoeVs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".CFtios") != "U"
                THIS.this_cCFtios   = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CFtios"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Promos") != "U"
                THIS.this_cPromo    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Promos"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".CBars") != "U"
                THIS.this_cCBars    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CBars"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Pecas") != "U"
                THIS.this_cPecas    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Pecas"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Datas") != "U"
                THIS.this_dDatas    = NVL(EVALUATE(loc_cAlias + ".Datas"), {})
            ENDIF
            IF TYPE(loc_cAlias + ".CIdChaves") != "U"
                THIS.this_cCIdChaves = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CIdChaves"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".PromoPro") != "U"
                THIS.this_cPromoPro = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".PromoPro"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".DtAlts") != "U"
                THIS.this_dDtAlts   = NVL(EVALUATE(loc_cAlias + ".DtAlts"), {})
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em CarregarDoCursor: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto " + ;
                                     CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cPromo))
            THIS.this_cMensagemErro = "Promo" + CHR(231) + CHR(227) + "o " + ;
                                     CHR(233) + " obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro de promocao em SigPrPmi
    * Chave unica em CIdChaves (gerada por fUniqueIds se vazia).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_dAgora

        loc_lSucesso = .F.

        TRY
            *-- Gera chave se ainda nao definida
            IF EMPTY(ALLTRIM(THIS.this_cCIdChaves))
                THIS.this_cCIdChaves = fUniqueIds()
            ENDIF

            *-- Data corrente para Datas/DtAlts se vazias
            loc_dAgora = DATE()
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas  = loc_dAgora
            ENDIF
            IF EMPTY(THIS.this_dDtAlts)
                THIS.this_dDtAlts = loc_dAgora
            ENDIF

            *-- PromoPro (chave secundaria = Promo + CPros) se vazia
            IF EMPTY(ALLTRIM(THIS.this_cPromoPro))
                THIS.this_cPromoPro = ALLTRIM(THIS.this_cPromo) + ;
                                     ALLTRIM(THIS.this_cCPros)
            ENDIF

            loc_cSQL = "INSERT INTO SigPrPmi " + ;
                       "(CPros, Pecas, Promos, CBars, Datas, " + ;
                       " CIdChaves, PromoPro, DtAlts) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCPros))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPecas))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPromo))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCBars))     + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)          + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCIdChaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPromoPro))  + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)         + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao inserir promo" + CHR(231) + ;
                                         CHR(227) + "o em SigPrPmi"
                loc_lSucesso = .F.
            ENDIF

            *-- Registra auditoria
            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Inserir: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza SigPrPmi (Pecas, CBars, Datas) e opcionalmente
    * o preco do produto em SigCdPro (PVens = this_nValAtu, CustoFs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            THIS.this_cMensagemErro = "Produto n" + CHR(227) + ;
                                     "o informado para atualiza" + CHR(231) + ;
                                     CHR(227) + "o"
            RETURN .F.
        ENDIF

        TRY
            *-- Data de alteracao
            THIS.this_dDtAlts = DATE()

            *-- UPDATE SigPrPmi (promocao)
            loc_cSQL = "UPDATE SigPrPmi SET " + ;
                       "Pecas    = " + EscaparSQL(ALLTRIM(THIS.this_cPecas))  + ", " + ;
                       "CBars    = " + EscaparSQL(ALLTRIM(THIS.this_cCBars))  + ", " + ;
                       "Datas    = " + FormatarDataSQL(THIS.this_dDatas)       + ", " + ;
                       "PromoPro = " + EscaparSQL(ALLTRIM(THIS.this_cPromoPro)) + ", " + ;
                       "DtAlts   = " + FormatarDataSQL(THIS.this_dDtAlts)      + " " + ;
                       "WHERE CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros)) + ;
                       " AND Promos = " + EscaparSQL(ALLTRIM(THIS.this_cPromo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao atualizar SigPrPmi"
                loc_lSucesso = .F.
            ENDIF

            *-- UPDATE SigCdPro (preco de venda), se produto informado
            IF !EMPTY(ALLTRIM(THIS.this_cCPros)) AND THIS.this_nValAtu > 0
                loc_cSQL = "UPDATE SigCdPro SET " + ;
                           "PVens   = " + FormatarNumeroSQL(THIS.this_nValAtu)  + ", " + ;
                           "CustoFs = " + FormatarNumeroSQL(THIS.this_nCustoFs) + " " + ;
                           "WHERE CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar SigCdPro"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Registra auditoria
            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Atualizar: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove uma promocao de SigPrPmi por CPros + Promos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            THIS.this_cMensagemErro = "Produto n" + CHR(227) + ;
                                     "o informado para exclus" + CHR(227) + "o"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigPrPmi WHERE CPros = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCPros)) + ;
                       " AND Promos = " + EscaparSQL(ALLTRIM(THIS.this_cPromo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao excluir SigPrPmi"
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("DELETE")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em ExecutarExclusao: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros
    * Carrega SigCdPam (MarkUpCVs, GrPadFors) e SigCdPac (CalcCusts, nChkSubGrs)
    * e SigCdGrp (arredondamentos). Chama UMA vez no Init do Form.
    * Retorna .T. em sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult

        loc_lSucesso = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        TRY
            *-- SigCdPam
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT MarkUpCVs, GrPadFors FROM SigCdPam", ;
                "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdPam)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            GO TOP
            IF !EOF("cursor_4c_Pam")
                THIS.this_nMarkUpCV  = NVL(cursor_4c_Pam.MarkUpCVs, 0)
                THIS.this_cGrPadFors = ALLTRIM(NVL(cursor_4c_Pam.GrPadFors, ""))
            ENDIF

            *-- SigCdPac
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CalcCusts, nChkSubGrs FROM SigCdPac", ;
                "cursor_4c_Pac")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdPac)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pac
            GO TOP
            IF !EOF("cursor_4c_Pac")
                THIS.this_nCalcCusts = NVL(cursor_4c_Pac.CalcCusts,  1)
                THIS.this_nChkSubGrs = NVL(cursor_4c_Pac.nChkSubGrs, 0)
            ENDIF

            *-- SigCdGrp (grupos com arredondamentos, indexado por CGrus)
            IF USED("cursor_4c_Grp")
                USE IN cursor_4c_Grp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CGrus, Arreds FROM SigCdGrp ORDER BY CGrus", ;
                "cursor_4c_Grp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdGrp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Grp
            INDEX ON CGrus TAG CGrus
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarParametros: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarAcessoEdicaoManual
    * Retorna .T. se usuario tem permissao VMANUAL em SIGPRAPR
    *--------------------------------------------------------------------------
    PROCEDURE VerificarAcessoEdicaoManual()
        RETURN fChecaAcesso("SIGPRAPR", "VMANUAL")
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFatorMoeda
    * Retorna taxa de cambio de par_cMoeda, considerando a cadeia MoeQs/QtdeQs
    * de SigCdMoe (moeda quotada em outra moeda * fator de quantidade).
    * par_cMoeda: codigo da moeda (ex: "USD")
    * Retorna 1.0 se vazia ou "R$".
    *--------------------------------------------------------------------------
    PROCEDURE BuscarFatorMoeda(par_cMoeda)
        LOCAL loc_cMoeda, loc_cMoeRef, loc_nQtde, loc_nResult, loc_nTaxa

        loc_cMoeda = ALLTRIM(NVL(par_cMoeda, ""))
        loc_nTaxa  = 1.0

        IF EMPTY(loc_cMoeda)
            RETURN loc_nTaxa
        ENDIF

        TRY
            *-- Verifica se moeda tem alias (MoeQs) e fator (QtdeQs) em SigCdMoe
            IF USED("cursor_4c_MoeRef")
                USE IN cursor_4c_MoeRef
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 MoeQs, QtdeQs FROM SigCdMoe WHERE CMoes = " + ;
                EscaparSQL(loc_cMoeda), ;
                "cursor_4c_MoeRef")

            IF loc_nResult > 0 AND !EOF("cursor_4c_MoeRef")
                SELECT cursor_4c_MoeRef
                IF !EMPTY(ALLTRIM(NVL(cursor_4c_MoeRef.MoeQs, "")))
                    loc_cMoeRef = ALLTRIM(cursor_4c_MoeRef.MoeQs)
                    loc_nQtde   = IIF(NVL(cursor_4c_MoeRef.QtdeQs, 0) = 0, 1, ;
                                      cursor_4c_MoeRef.QtdeQs)
                ELSE
                    loc_cMoeRef = loc_cMoeda
                    loc_nQtde   = 1
                ENDIF
            ELSE
                loc_cMoeRef = loc_cMoeda
                loc_nQtde   = 1
            ENDIF

            IF USED("cursor_4c_MoeRef")
                USE IN cursor_4c_MoeRef
            ENDIF

            loc_nTaxa = fBuscarCotacao(loc_cMoeRef, DATE(), gnConnHandle) * loc_nQtde

        CATCH TO loc_oErro
            MsgErro("Erro em BuscarFatorMoeda: " + loc_oErro.Message, "Erro")
            loc_nTaxa = 1.0
        ENDTRY

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcPreco
    * Calcula preco ideal por markup para o registro CORRENTE de cursor_4c_TmpPro.
    * par_nMargem: markup desejado (ex: 3.5 = 3.5x custo)
    * Usa this_cMoeCusto, this_nFator, this_cMoedas do BO (valores dos campos do form).
    * Escreve em cursor_4c_TmpPro.CustoFs o custo calculado.
    * Retorna preco ideal calculado.
    *--------------------------------------------------------------------------
    PROCEDURE CalcPreco(par_nMargem)
        LOCAL loc_nCusto, loc_nVenda, loc_nMoeC, loc_nMoeV, loc_nMoeCF, loc_nMoeFT
        LOCAL loc_nMoedas, loc_nFator, loc_nFPeso, loc_nIdeal, loc_nCustoF, loc_nMoeP
        LOCAL loc_cMoeCusto, loc_nFatCusto, loc_cMoeIdeal, loc_nFeitio, loc_nPreco

        IF !USED("cursor_4c_TmpPro")
            RETURN 0
        ENDIF
        SELECT cursor_4c_TmpPro

        *-- Resolve parametros: form override ou valor do produto
        loc_cMoeCusto = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ;
                            ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, "")), ;
                            ALLTRIM(THIS.this_cMoeCusto))
        loc_nFatCusto = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoeCusto), ;
                            THIS.this_nFator, ;
                            NVL(cursor_4c_TmpPro.fCustos, 0))
        loc_cMoeIdeal = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ;
                            ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), ;
                            ALLTRIM(THIS.this_cMoedas))

        loc_nCusto  = NVL(cursor_4c_TmpPro.PCuss,  0)
        loc_nFPeso  = NVL(cursor_4c_TmpPro.PesoMs, 0) * loc_nFatCusto
        loc_nFator  = par_nMargem
        loc_nFeitio = NVL(cursor_4c_TmpPro.PFtios, 0)

        *-- Taxas de cambio
        loc_nMoeC  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeCs, "")))
        loc_nMoeP  = THIS.BuscarFatorMoeda(loc_cMoeCusto)
        loc_nMoeV  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeVs, "")))
        loc_nMoeCF = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, "")))
        loc_nMoedas = THIS.BuscarFatorMoeda(loc_cMoeIdeal)
        loc_nMoeFT  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MFtios, "")))

        *-- Converte feitio para moeda de custo total se moedas diferentes
        IF ALLTRIM(NVL(cursor_4c_TmpPro.MFtios, "")) <> ;
           ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
            IF loc_nMoeCF <> 0
                loc_nFeitio = (loc_nFeitio * loc_nMoeFT) / loc_nMoeCF
            ENDIF
        ENDIF

        *-- Custo convertido para moeda de custo total
        IF ALLTRIM(NVL(cursor_4c_TmpPro.MoeCs, "")) <> ;
           ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
            IF loc_nMoeCF <> 0
                loc_nCustoF = (loc_nCusto * loc_nMoeC) / loc_nMoeCF
            ELSE
                loc_nCustoF = loc_nCusto
            ENDIF
        ELSE
            loc_nCustoF = loc_nCusto
        ENDIF

        *-- Aplica fator de peso (CalcCusts: 1=soma peso, 2=multiplica fator)
        IF THIS.this_nCalcCusts = 2
            IF loc_cMoeCusto <> ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
                IF loc_nMoeCF <> 0
                    loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, ;
                                  loc_nFatCusto * loc_nMoeP / loc_nMoeCF)
                ENDIF
            ELSE
                loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, loc_nFatCusto)
            ENDIF
        ELSE
            IF loc_cMoeCusto <> ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
                IF loc_nMoeCF <> 0
                    loc_nCustoF = loc_nCustoF + (loc_nFPeso * loc_nMoeP / loc_nMoeCF)
                ENDIF
            ELSE
                loc_nCustoF = loc_nCustoF + loc_nFPeso
            ENDIF
        ENDIF

        *-- Grava custo calculado no cursor temporario
        IF !EOF("cursor_4c_TmpPro")
            REPLACE CustoFs WITH loc_nCustoF IN cursor_4c_TmpPro
        ENDIF

        *-- Calcula preco ideal
        IF ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, "")) <> loc_cMoeIdeal
            IF loc_nMoedas <> 0
                loc_nIdeal = (loc_nCustoF + loc_nFeitio) * loc_nMoeCF / loc_nMoedas * loc_nFator
            ELSE
                loc_nIdeal = 0
            ENDIF
        ELSE
            loc_nIdeal = (loc_nCustoF + loc_nFeitio) * loc_nFator
        ENDIF

        RETURN loc_nIdeal
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcMargem
    * Calcula margem para um dado preco no registro CORRENTE de cursor_4c_TmpPro.
    * par_nPreco: preco de venda a avaliar
    * Retorna margem calculada.
    *--------------------------------------------------------------------------
    PROCEDURE CalcMargem(par_nPreco)
        LOCAL loc_nCusto, loc_nMoeC, loc_nMoeCF, loc_nMoeFT, loc_nMoedas
        LOCAL loc_nFatCusto, loc_cMoeIdeal, loc_nFeitio, loc_nCustoF, loc_nMargem
        LOCAL loc_nMoeP

        IF !USED("cursor_4c_TmpPro")
            RETURN 0
        ENDIF
        SELECT cursor_4c_TmpPro

        loc_cMoeIdeal = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ;
                            ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), ;
                            ALLTRIM(THIS.this_cMoedas))
        loc_nFatCusto = NVL(cursor_4c_TmpPro.fCustos, 0)

        loc_nCusto  = NVL(cursor_4c_TmpPro.PCuss,  0)
        loc_nFeitio = NVL(cursor_4c_TmpPro.PFtios, 0)
        loc_nFPeso  = NVL(cursor_4c_TmpPro.PesoMs, 0) * loc_nFatCusto

        loc_nMoeC  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeCs, "")))
        loc_nMoeP  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoePCs, "")))
        loc_nMoeV  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeVs, "")))
        loc_nMoeCF = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, "")))
        loc_nMoedas = THIS.BuscarFatorMoeda(loc_cMoeIdeal)
        loc_nMoeFT  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_TmpPro.MFtios, "")))

        IF ALLTRIM(NVL(cursor_4c_TmpPro.MFtios, "")) <> ;
           ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
            IF loc_nMoeCF <> 0
                loc_nFeitio = (loc_nFeitio * loc_nMoeFT) / loc_nMoeCF
            ENDIF
        ENDIF

        IF ALLTRIM(NVL(cursor_4c_TmpPro.MoeCs, "")) <> ;
           ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
            IF loc_nMoeCF <> 0
                loc_nCustoF = (loc_nCusto * loc_nMoeC) / loc_nMoeCF
            ELSE
                loc_nCustoF = loc_nCusto
            ENDIF
        ELSE
            loc_nCustoF = loc_nCusto
        ENDIF

        IF THIS.this_nCalcCusts = 2
            IF ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, "")) <> ;
               ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
                IF loc_nMoeCF <> 0
                    loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, ;
                                  loc_nFatCusto * loc_nMoeP / loc_nMoeCF)
                ENDIF
            ELSE
                loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, loc_nFatCusto)
            ENDIF
        ELSE
            IF ALLTRIM(NVL(cursor_4c_TmpPro.MoePCs, "")) <> ;
               ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, ""))
                IF loc_nMoeCF <> 0
                    loc_nCustoF = loc_nCustoF + (loc_nFPeso * loc_nMoeP / loc_nMoeCF)
                ENDIF
            ELSE
                loc_nCustoF = loc_nCustoF + loc_nFPeso
            ENDIF
        ENDIF

        IF (loc_nCustoF + loc_nFeitio) = 0
            loc_nMargem = 0
        ELSE
            IF ALLTRIM(NVL(cursor_4c_TmpPro.MoeCusFs, "")) <> loc_cMoeIdeal
                IF loc_nMoedas <> 0
                    loc_nMargem = par_nPreco / ((loc_nCustoF + loc_nFeitio) * ;
                                  loc_nMoeCF / loc_nMoedas)
                ELSE
                    loc_nMargem = 0
                ENDIF
            ELSE
                loc_nMargem = par_nPreco / (loc_nCustoF + loc_nFeitio)
            ENDIF
        ENDIF

        RETURN loc_nMargem
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcMarkpa
    * Recalcula MarkupA para o registro CORRENTE de cursor_4c_Pro (SigCdPro buffer).
    * Grava resultado em cursor_4c_Pro.MarkupA via REPLACE.
    *--------------------------------------------------------------------------
    PROCEDURE CalcMarkpa()
        LOCAL loc_nMoeCF, loc_nMoeV, loc_nMarkpA

        IF !USED("cursor_4c_Pro")
            RETURN
        ENDIF
        SELECT cursor_4c_Pro

        loc_nMoeCF = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_Pro.MoeCusFs, "")))
        loc_nMoeV  = THIS.BuscarFatorMoeda(ALLTRIM(NVL(cursor_4c_Pro.MoeVs,   "")))

        IF NVL(cursor_4c_Pro.CustoFs, 0) = 0 OR loc_nMoeCF = 0
            loc_nMarkpA = 0
        ELSE
            loc_nMarkpA = ROUND((NVL(cursor_4c_Pro.PVens, 0) * loc_nMoeV) / ;
                                (NVL(cursor_4c_Pro.CustoFs, 0) * loc_nMoeCF), 3)
        ENDIF

        REPLACE MarkupA WITH loc_nMarkpA IN cursor_4c_Pro
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarReajuste
    * Equivale ao botao Processar (sair.Processa.Click) do legado.
    * Usa this_cCdGrupo, this_cAteGrupo, this_cCol, this_cConta, this_nTipo,
    * this_nVariacao, this_cMoeda, this_nMarkUp1, this_nMarkUp2, this_nIgnorar.
    * Cria cursor_4c_Produtos com os produtos recalculados.
    * Retorna .T. em sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarReajuste()
        LOCAL loc_lSucesso, loc_cWhere, loc_cSQL, loc_nResult
        LOCAL loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen
        LOCAL loc_nValAtu, loc_cMoePcs, loc_nFCustos, loc_nCustoF

        loc_lSucesso = .F.

        TRY
            *-- Valida campos obrigatorios por tipo
            DO CASE
            CASE THIS.this_nTipo = 1
                IF THIS.this_nVariacao = 0
                    MsgAviso("Varia" + CHR(231) + CHR(227) + "o Inv" + ;
                             CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
            CASE THIS.this_nTipo = 2
                IF EMPTY(ALLTRIM(THIS.this_cMoeda))
                    MsgAviso("Moeda Inv" + CHR(225) + "lida !!!", ;
                             "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
                IF THIS.this_nMarkUp2 = 0
                    MsgAviso("MarkUp Inv" + CHR(225) + "lido !!!", ;
                             "Campo Obrigat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
            ENDCASE

            *-- Monta clausula WHERE
            loc_cWhere = "0 = 0 "
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrupo)) OR !EMPTY(ALLTRIM(THIS.this_cAteGrupo))
                IF !EMPTY(ALLTRIM(THIS.this_cAteGrupo))
                    loc_cWhere = loc_cWhere + ;
                        "AND CGrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo)) + ;
                        " AND " + EscaparSQL(ALLTRIM(THIS.this_cAteGrupo)) + " "
                ELSE
                    loc_cWhere = loc_cWhere + ;
                        "AND CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo)) + " "
                ENDIF
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCol))
                loc_cWhere = loc_cWhere + ;
                    "AND Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cCol)) + " "
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cWhere = loc_cWhere + ;
                    "AND IFors = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + " "
            ENDIF
            IF THIS.this_nTipo = 2
                loc_cWhere = loc_cWhere + ;
                    "AND MoeVs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + ;
                    " AND Margems = " + FormatarNumeroSQL(THIS.this_nMarkUp1) + " "
            ENDIF

            *-- Filtra componentes (exceto se chkIgnorar)
            IF THIS.this_nIgnorar <> 1
                loc_cWhere = loc_cWhere + ;
                    "AND CPros NOT IN (SELECT DISTINCT cpros FROM SigPrCpo) "
            ENDIF

            *-- Query principal -> cursor_4c_TmpPro
            IF USED("cursor_4c_TmpPro")
                TABLEREVERT(.T., "cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdPro " + ;
                       "WHERE " + loc_cWhere + ;
                       "ORDER BY CPros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de produtos (SigCdPro)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TmpPro
            INDEX ON CPros TAG CPros
            GO TOP

            *-- (Re)cria cursor de produtos para o Grid
            IF USED("cursor_4c_Produtos")
                USE IN cursor_4c_Produtos
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos ( ;
                lMarca  N(1)    NULL, ;
                CPros   C(14)   NULL, ;
                DPros   C(40)   NULL, ;
                ValAnt  N(14,2) NULL, ;
                ValAtu  N(14,2) NULL, ;
                fCustos N(8,3)  NULL, ;
                MoePcs  C(3)    NULL, ;
                CustoFs N(12,3) NULL, ;
                Manual  N(1)    NULL  ;
            )
            SET NULL OFF
            INDEX ON CPros TAG CPros
            SELECT cursor_4c_Produtos
            SET ORDER TO
            GO TOP

            *-- Percorre produtos e calcula novos precos
            SELECT cursor_4c_TmpPro
            GO TOP
            SCAN
                loc_nCustoF  = NVL(cursor_4c_TmpPro.CustoFs, 0)

                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0) + ;
                                  (NVL(cursor_4c_TmpPro.PVens, 0) * THIS.this_nVariacao / 100)
                CASE THIS.this_nTipo = 2
                    loc_nValAtu = THIS.CalcPreco(THIS.this_nMarkUp2)
                CASE THIS.this_nTipo = 3
                    loc_nCotId = fBuscarCotacao( ;
                        ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), DATE(), gnConnHandle)
                    loc_nCotVd = fBuscarCotacao( ;
                        ALLTRIM(NVL(cursor_4c_TmpPro.MoeVs, "")), DATE(), gnConnHandle)
                    loc_nPVen  = NVL(cursor_4c_TmpPro.PVIdeals, 0) * ;
                                 IIF(loc_nCotVd <> 0, loc_nCotId / loc_nCotVd, 0)
                    IF NVL(cursor_4c_TmpPro.Encargos, 0) <> 0
                        loc_nVlVen = loc_nPVen / cursor_4c_TmpPro.Encargos
                    ELSE
                        loc_nVlVen = loc_nPVen
                    ENDIF
                    loc_nValAtu = loc_nVlVen
                OTHERWISE
                    loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0)
                ENDCASE

                loc_cMoePcs  = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ;
                                   ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, "")), ;
                                   ALLTRIM(THIS.this_cMoeCusto))
                IF THIS.this_nFator > 0 AND !EMPTY(loc_cMoePcs)
                    loc_nFCustos = THIS.this_nFator
                    loc_nCustoF  = NVL(cursor_4c_TmpPro.CustoFs, 0)
                ELSE
                    loc_nFCustos = NVL(cursor_4c_TmpPro.fCustos, 0)
                    loc_nCustoF  = NVL(cursor_4c_TmpPro.CustoFs, 0)
                ENDIF

                SELECT cursor_4c_Produtos
                APPEND BLANK
                REPLACE lMarca  WITH 1
                REPLACE CPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.CPros,  ""))
                REPLACE DPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.DPros,  ""))
                REPLACE ValAnt  WITH NVL(cursor_4c_TmpPro.PVens,  0)
                REPLACE ValAtu  WITH loc_nValAtu
                REPLACE fCustos WITH loc_nFCustos
                REPLACE MoePcs  WITH loc_cMoePcs
                REPLACE CustoFs WITH loc_nCustoF
                REPLACE Manual  WITH 0

                SELECT cursor_4c_TmpPro

            ENDSCAN

            SELECT cursor_4c_Produtos
            SET ORDER TO CPros
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro em ProcessarReajuste: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPrecos
    * Equivale ao botao Atualizar (sair.Atualiza.Click) do legado.
    * Processa registros marcados (lMarca=1) em cursor_4c_Produtos.
    * Salva historico em SigCdPrc, atualiza SigCdPro, SigPrCp2, SigPrPmi.
    * Retorna .T. em sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPrecos()
        LOCAL loc_lSucesso, loc_lImpEtiq, loc_nResult, loc_cSQL
        LOCAL loc_cCPros, loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen
        LOCAL loc_nPVens, loc_nPCuss, loc_nCustoFs, loc_cIdChave, loc_cOrigem
        LOCAL loc_dAgora, loc_cHora, loc_nCt, loc_llOk, loc_nArq

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Produtos")
                MsgAviso("Nenhum produto para atualizar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Verifica se ha marcados
            IF USED("cursor_4c_ProSel")
                USE IN cursor_4c_ProSel
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT 1 WHERE 0=1", "cursor_4c_ProSel")
            SELECT * FROM cursor_4c_Produtos WHERE lMarca = 1 ;
                ORDER BY CPros INTO CURSOR cursor_4c_ProSel READWRITE
            SELECT cursor_4c_ProSel
            GO TOP
            IF EOF("cursor_4c_ProSel")
                MsgAviso("Nenhum Produto Selecionado !!!", ;
                         "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                USE IN cursor_4c_ProSel
                loc_lSucesso = .F.
            ENDIF

            *-- Confirmacao de impressao de etiquetas
            loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?", ;
                                       "Etiquetas")

            *-- Processa cada produto marcado
            SELECT cursor_4c_ProSel
            GO TOP
            loc_llOk = .T.
            SCAN WHILE loc_llOk
                loc_cCPros  = ALLTRIM(cursor_4c_ProSel.CPros)
                loc_dAgora  = DATETIME()
                loc_cHora   = SUBSTR(TTOC(loc_dAgora), 12, 8)
                loc_cIdChave = fUniqueIds()
                loc_cOrigem  = DTOC(DATE()) + " SIGALTPC"

                *-- Obtem dados atuais do produto em SigCdPro
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros), ;
                    "cursor_4c_Pro")
                IF loc_nResult < 1 OR EOF("cursor_4c_Pro")
                    loc_llOk = .F.
                    EXIT
                ENDIF
                SELECT cursor_4c_Pro
                GO TOP

                *-- INSERT historico em SigCdPrc (snapshot antes do reajuste)
                loc_cSQL = "INSERT INTO SigCdPrc " + ;
                           "(cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
                           " margems, moevs, moecs, moepcs, moecusfs, moedas, " + ;
                           " DataAlts, HoraAlts, UsuaAlts, cIdChaves, Origem) " + ;
                           "SELECT cpros, dpros, pvens, pvideals, pcuss, custofs, fcustos, " + ;
                           " margems, moevs, moecs, moepcs, moecusfs, moedas, " + ;
                           FormatarDataSQL(loc_dAgora) + ", " + ;
                           EscaparSQL(loc_cHora) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(loc_cIdChave) + ", " + ;
                           EscaparSQL(loc_cOrigem) + " " + ;
                           "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCPros)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nResult < 1
                    loc_llOk = .F.
                    THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
                                             "rico de pre" + CHR(231) + "os (SigCdPrc)"
                    EXIT
                ENDIF

                *-- Calcula novos valores
                SELECT cursor_4c_Pro
                loc_nPVens   = NVL(cursor_4c_Pro.PVens,   0)
                loc_nPCuss   = NVL(cursor_4c_Pro.PCuss,   0)
                loc_nCustoFs = NVL(cursor_4c_Pro.CustoFs, 0)

                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nPVens = loc_nPVens + (loc_nPVens * THIS.this_nVariacao / 100)
                    IF THIS.this_nIncCusts = 1
                        loc_nPCuss   = loc_nPCuss   + (loc_nPCuss   * THIS.this_nVariacao / 100)
                        loc_nCustoFs = loc_nCustoFs + (loc_nCustoFs * THIS.this_nVariacao / 100)
                    ENDIF
                CASE THIS.this_nTipo = 2
                    loc_nMargem  = THIS.this_nMarkUp2
                    IF USED("cursor_4c_TmpPro") AND SEEK(loc_cCPros, "cursor_4c_TmpPro", "CPros")
                        loc_nPVens   = THIS.CalcPreco(loc_nMargem)
                        loc_nCustoFs = cursor_4c_ProSel.CustoFs
                    ENDIF
                CASE THIS.this_nTipo = 3
                    loc_nCotId = fBuscarCotacao( ;
                        ALLTRIM(NVL(cursor_4c_Pro.Moedas, "")), DATE(), gnConnHandle)
                    loc_nCotVd = fBuscarCotacao( ;
                        ALLTRIM(NVL(cursor_4c_Pro.MoeVs, "")),  DATE(), gnConnHandle)
                    IF loc_nCotVd <> 0
                        loc_nPVen = NVL(cursor_4c_Pro.PVIdeals, 0) * loc_nCotId / loc_nCotVd
                    ELSE
                        loc_nPVen = 0
                    ENDIF
                    IF NVL(cursor_4c_Pro.Encargos, 0) <> 0
                        loc_nVlVen = loc_nPVen / cursor_4c_Pro.Encargos
                    ELSE
                        loc_nVlVen = loc_nPVen
                    ENDIF
                    loc_nPVens = loc_nVlVen
                ENDCASE

                *-- Se Manual=1, usa o valor digitado manualmente pelo usuario
                IF cursor_4c_ProSel.Manual = 1
                    loc_nPVens = cursor_4c_ProSel.ValAtu
                ENDIF

                *-- UPDATE SigCdPro com novos precos
                loc_cSQL = "UPDATE SigCdPro SET " + ;
                           "PVens  = " + FormatarNumeroSQL(loc_nPVens)   + ", " + ;
                           "PCuss  = " + FormatarNumeroSQL(loc_nPCuss)   + ", " + ;
                           "CustoFs = " + FormatarNumeroSQL(loc_nCustoFs) + ", " + ;
                           "ImpEtiqs = " + IIF(loc_lImpEtiq, "1", "0")
                IF THIS.this_nTipo = 2
                    loc_cSQL = loc_cSQL + ", " + ;
                               "Margems  = " + FormatarNumeroSQL(THIS.this_nMarkUp2) + ", " + ;
                               "PVIdeals = " + FormatarNumeroSQL(loc_nPVens) + ", " + ;
                               "fCustos  = " + FormatarNumeroSQL(cursor_4c_ProSel.fCustos) + ", " + ;
                               "MoePcs   = " + EscaparSQL(ALLTRIM(cursor_4c_ProSel.MoePcs))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cMoecs))
                    loc_cSQL = loc_cSQL + ", MoeCs   = " + EscaparSQL(ALLTRIM(THIS.this_cMoecs))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cMoeCusFs))
                    loc_cSQL = loc_cSQL + ", MoeCusFs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeCusFs))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cMoedas))
                    loc_cSQL = loc_cSQL + ", Moedas  = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cCFtios))
                    loc_cSQL = loc_cSQL + ", CFtios  = " + EscaparSQL(ALLTRIM(THIS.this_cCFtios))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cMoeVs))
                    loc_cSQL = loc_cSQL + ", MoeVs   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeVs))
                ENDIF
                loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCPros)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nResult < 1
                    loc_llOk = .F.
                    THIS.this_cMensagemErro = "Falha ao atualizar SigCdPro"
                    EXIT
                ENDIF

                *-- Recalcula MarkupA (CalcMarkpa) apos update
                *-- Recarrega cursor_4c_Pro com dados atualizados
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT PVens, CustoFs, MoeCusFs, MoeVs, MarkupA FROM SigCdPro " + ;
                    "WHERE CPros = " + EscaparSQL(loc_cCPros), ;
                    "cursor_4c_Pro")
                IF USED("cursor_4c_Pro") AND !EOF("cursor_4c_Pro")
                    SELECT cursor_4c_Pro
                    GO TOP
                    THIS.CalcMarkpa()
                    *-- Salva MarkupA calculado
                    SQLEXEC(gnConnHandle, ;
                        "UPDATE SigCdPro SET MarkupA = " + ;
                        FormatarNumeroSQL(NVL(cursor_4c_Pro.MarkupA, 0)) + ;
                        " WHERE cpros = " + EscaparSQL(loc_cCPros), "")
                ENDIF

                *-- Backup composicao -> SigPrCp2
                IF USED("cursor_4c_Compo")
                    USE IN cursor_4c_Compo
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigPrCpo WHERE CPros = " + EscaparSQL(loc_cCPros), ;
                    "cursor_4c_Compo")
                IF loc_nResult > 0 AND !EOF("cursor_4c_Compo")
                    SELECT cursor_4c_Compo
                    GO TOP
                    SCAN
                        loc_cSQL = "INSERT INTO SigPrCp2 " + ;
                                   "(cpros, DataAlts, HoraAlts, UsuaAlts) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(NVL(cursor_4c_Compo.cpros, ""))) + ", " + ;
                                   FormatarDataSQL(loc_dAgora) + ", " + ;
                                   EscaparSQL(loc_cHora) + ", " + ;
                                   EscaparSQL(gc_4c_UsuarioLogado) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL, "")
                        SELECT cursor_4c_Compo
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_Compo")
                    USE IN cursor_4c_Compo
                ENDIF

                *-- Delete de SigPrPrt para o produto
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cCPros), "")

                *-- Limpar promocoes anteriores (se solicitado)
                IF THIS.this_nLimpar = 1
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigPrPmi WHERE CPros = " + EscaparSQL(loc_cCPros), "")
                    IF loc_nResult < 1
                        loc_llOk = .F.
                        THIS.this_cMensagemErro = "Falha ao limpar promo" + CHR(231) + ;
                                                 CHR(245) + "es (SigPrPmi)"
                        EXIT
                    ENDIF
                ENDIF

                *-- Inserir nova promocao (se informada)
                IF !EMPTY(ALLTRIM(THIS.this_cPromo))
                    IF USED("cursor_4c_PromoI")
                        USE IN cursor_4c_PromoI
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 1 FROM SigPrPmi " + ;
                        "WHERE CPros = " + EscaparSQL(loc_cCPros) + ;
                        " AND Promos = " + EscaparSQL(ALLTRIM(THIS.this_cPromo)), ;
                        "cursor_4c_PromoI")
                    IF loc_nResult > 0 AND EOF("cursor_4c_PromoI")
                        loc_cSQL = "INSERT INTO SigPrPmi " + ;
                                   "(CPros, Pecas, Promos, CBars, Datas, CIdChaves, PromoPro, DtAlts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCPros) + ", '', " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cPromo)) + ", 0, " + ;
                                   FormatarDataSQL(loc_dAgora) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cPromo) + loc_cCPros) + ", " + ;
                                   FormatarDataSQL(loc_dAgora) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
                        IF loc_nResult < 1
                            loc_llOk = .F.
                            THIS.this_cMensagemErro = "Falha ao inserir promo" + CHR(231) + CHR(227) + "o"
                            EXIT
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_PromoI")
                        USE IN cursor_4c_PromoI
                    ENDIF
                ENDIF

                *-- Sub-grupos por faixa de preco (SigCdPac.nChkSubGrs = 1)
                IF THIS.this_nChkSubGrs = 1 AND USED("cursor_4c_Pro")
                    SELECT cursor_4c_Pro
                    GO TOP
                    IF !EOF("cursor_4c_Pro")
                        IF USED("cursor_4c_SubGrp")
                            USE IN cursor_4c_SubGrp
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Codigos, nFaixaFins FROM SigCdPsg " + ;
                            "WHERE CGrus = " + ;
                            EscaparSQL(ALLTRIM(NVL(cursor_4c_Pro.CGrus, ""))) + ;
                            " ORDER BY nFaixaFins", ;
                            "cursor_4c_SubGrp")
                        IF loc_nResult > 0 AND !EOF("cursor_4c_SubGrp")
                            LOCAL loc_nPVFinal, loc_cCodigos
                            loc_nPVFinal = IIF(NVL(cursor_4c_Pro.PVens, 0) = 0, ;
                                               NVL(cursor_4c_Pro.PVIdeals, 0), ;
                                               NVL(cursor_4c_Pro.PVens, 0))
                            SELECT cursor_4c_SubGrp
                            LOCATE FOR NVL(cursor_4c_SubGrp.nFaixaFins, 0) >= loc_nPVFinal
                            IF !EOF("cursor_4c_SubGrp")
                                loc_cCodigos = ALLTRIM(NVL(cursor_4c_SubGrp.Codigos, ""))
                                SQLEXEC(gnConnHandle, ;
                                    "UPDATE SigCdPro SET sGrus = " + EscaparSQL(loc_cCodigos) + ;
                                    " WHERE cpros = " + EscaparSQL(loc_cCPros), "")
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_SubGrp")
                            USE IN cursor_4c_SubGrp
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF

                SELECT cursor_4c_ProSel
            ENDSCAN

            IF loc_llOk
                loc_nResult = SQLCOMMIT(gnConnHandle)
                IF loc_nResult < 0
                    SQLROLLBACK(gnConnHandle)
                    THIS.this_cMensagemErro = "Falha ao confirmar transa" + CHR(231) + CHR(227) + "o"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    MsgInfo("Processamento Finalizado com Sucesso !!!", "")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                SQLROLLBACK(gnConnHandle)
                MsgErro(THIS.this_cMensagemErro, ;
                        "Falha na Atualiza" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_ProSel")
                USE IN cursor_4c_ProSel
            ENDIF

        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            MsgErro("Erro em AtualizarPrecos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
