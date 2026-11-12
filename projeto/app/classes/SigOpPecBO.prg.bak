*==============================================================================
* SIGOPPECBO.PRG
* Business Object para Selecao de Pecas / Imagens de Produtos (SigOpPec)
* Herda de BusinessBase
*
* Legado: SIGOPPEC.SCX - tela que percorre os produtos filtrados pelo form
* pai (cursor CrProdutos, 15 por pagina) e permite ao usuario marcar quais
* produtos entram na selecao de imagens (cursor local CrImagens), para depois
* exportar os JPGs para disco (Exportar Imagens), gerar arquivo (SigOpGar) ou
* imprimir a relacao de pecas (SigRePca). Nao ha INSERT/UPDATE/DELETE em
* tabela do SQL Server nestas acoes - a unica tabela referenciada no Init
* legado via AddCursor eh SigOpGcp/cidchaves.
*==============================================================================

DEFINE CLASS SigOpPecBO AS BusinessBase

    *-- Propriedades espelhando o cursor local CrImagens (Load() do legado) -
    *-- cada produto marcado para selecao de imagem grava um registro com
    *-- este layout (usado depois por Exportar/Imprimir/Gerar Arquivo)
    this_cCpros       = ""
    this_cDpros       = ""
    this_cLinhas      = ""
    this_cColecoes    = ""
    this_nPvens       = 0
    this_cMoevs       = ""
    this_nPesoms      = 0
    this_cMoepvs      = ""
    this_nFvendas     = 0
    this_nPcuss       = 0
    this_cMoecs       = ""
    this_cReffs       = ""
    this_cIfors       = ""
    this_dDatas       = {}
    this_cCgrus       = ""
    this_cCunis       = ""
    this_cFigjpgs     = ""
    this_nFlag        = 0
    this_nTconvs      = 0
    this_cMconvs      = ""
    this_nImppreco    = 0
    this_nCustofs     = 0
    this_cMoecusfs    = ""
    this_nImpcusto    = 0
    this_nImpcompo    = 0
    this_nImpreffor   = 0
    this_nTpconvs     = 0
    this_cMpconvs     = ""
    this_nImpfor      = 0
    this_cDfors       = ""
    this_cCbars       = ""

    *-- Propriedades de controle/paginacao (equivalentes as properties do
    *-- form legado: TotPro, TotPag, TotReg, NumPag, Primeira, Ordena, Pag1,
    *-- Pag2, TelaInic, PlAuto) - a paginacao em si fica no Form (estado de
    *-- UI), mas o BO precisa delas para montar a consulta de cada pagina
    this_nTotalProdutos      = 0
    this_nRegistrosPorPagina = 15
    this_nTotalPaginas       = 0
    this_nPaginaAtual        = 1
    this_nOrdena             = 1
    this_lModoAutomatico     = .F.

    *-- Filtro de promocao (lcPromo/llPromo do legado - Get_Promo do form pai)
    this_cPromocao           = ""
    this_lFiltroPromocao     = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Selecao de Pecas
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpGcp"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_nTotalProdutos      = 0
            THIS.this_nRegistrosPorPagina = 15
            THIS.this_nTotalPaginas       = 0
            THIS.this_nPaginaAtual        = 1
            THIS.this_nOrdena             = 1
            THIS.this_lModoAutomatico     = .F.
            THIS.this_cPromocao           = ""
            THIS.this_lFiltroPromocao     = .F.

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpPecBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros)
    ENDPROC

    *--------------------------------------------------------------------------
    * Persistencia desta tela: conforme o cabecalho do arquivo, NAO ha
    * INSERT/UPDATE/DELETE em tabela do SQL Server nas acoes do usuario (a
    * unica tabela citada no Init legado, SigOpGcp/cidchaves, eh so um
    * AddCursor nunca usado no restante do form). Por isso este BO NAO
    * sobrescreve Inserir()/Atualizar()/ExecutarExclusao() - o comportamento
    * padrao herdado de BusinessBase (recusar a operacao com mensagem) ja eh
    * o correto aqui, e RegistrarAuditoria() nao se aplica sem gravacao real.
    * A "gravacao" do usuario eh local: marcar/desmarcar produtos no cursor
    * de selecao (CrImagens no legado) - metodos abaixo espelham isso.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia o registro CORRENTE do cursor informado
    * (layout de CrImagens/Tmp_Imagens - 31 colunas, ver Load() do legado)
    * para as propriedades this_* do BO. PUBLIC (nao PROTECTED como nos BOs
    * CRUD comuns) porque esta tela nao tem CarregarPorCodigo por chave: o
    * Form varre Tmp_Imagens linha a linha (ChkImp/Command1-4) e precisa
    * carregar cada linha direto antes de decidir Adicionar/Remover.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros      = TratarNulo(cpros, "")
            THIS.this_cDpros      = TratarNulo(dpros, "")
            THIS.this_cLinhas     = TratarNulo(linhas, "")
            THIS.this_cColecoes   = TratarNulo(colecoes, "")
            THIS.this_nPvens      = TratarNulo(pvens, 0)
            THIS.this_cMoevs      = TratarNulo(moevs, "")
            THIS.this_nPesoms     = TratarNulo(pesoms, 0)
            THIS.this_cMoepvs     = TratarNulo(moepvs, "")
            THIS.this_nFvendas    = TratarNulo(fvendas, 0)
            THIS.this_nPcuss      = TratarNulo(pcuss, 0)
            THIS.this_cMoecs      = TratarNulo(moecs, "")
            THIS.this_cReffs      = TratarNulo(reffs, "")
            THIS.this_cIfors      = TratarNulo(ifors, "")
            THIS.this_dDatas      = TratarNulo(datas, {})
            THIS.this_cCgrus      = TratarNulo(cgrus, "")
            THIS.this_cCunis      = TratarNulo(cunis, "")
            THIS.this_cFigjpgs    = TratarNulo(figjpgs, "")
            THIS.this_nFlag       = TratarNulo(flag, 0)
            THIS.this_nTconvs     = TratarNulo(tconvs, 0)
            THIS.this_cMconvs     = TratarNulo(mconvs, "")
            THIS.this_nImppreco   = TratarNulo(imppreco, 0)
            THIS.this_nCustofs    = TratarNulo(custofs, 0)
            THIS.this_cMoecusfs   = TratarNulo(moecusfs, "")
            THIS.this_nImpcusto   = TratarNulo(impcusto, 0)
            THIS.this_nImpcompo   = TratarNulo(impcompo, 0)
            THIS.this_nImpreffor  = TratarNulo(impreffor, 0)
            THIS.this_nTpconvs    = TratarNulo(tpconvs, 0)
            THIS.this_cMpconvs    = TratarNulo(mpconvs, "")
            THIS.this_nImpfor     = TratarNulo(ImpFor, 0)
            THIS.this_cDfors      = TratarNulo(dFors, "")
            THIS.this_cCbars      = TratarNulo(cBars, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteNoCursorSelecao - Equivalente a "Locate for cpros = X / Found()"
    * usado em ChkImp e Command1.Click do legado antes de inserir/remover.
    *--------------------------------------------------------------------------
    PROCEDURE ExisteNoCursorSelecao(par_cAliasDestino, par_cCpros)
        LOCAL loc_lExiste, loc_cAliasAtual
        loc_lExiste = .F.

        IF USED(par_cAliasDestino)
            loc_cAliasAtual = ALIAS()
            SELECT (par_cAliasDestino)
            GO TOP
            LOCATE FOR ALLTRIM(cpros) == ALLTRIM(par_cCpros)
            loc_lExiste = FOUND()
            IF !EMPTY(loc_cAliasAtual) AND USED(loc_cAliasAtual)
                SELECT (loc_cAliasAtual)
            ENDIF
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoFornecedor - Select Rclis From SigCdCli Where Iclis = X
    * (mesma consulta do Command1.Click legado, usada para preencher dFors
    * quando o produto marcado ainda nao estava no cursor de selecao)
    *--------------------------------------------------------------------------
    PROCEDURE ObterDescricaoFornecedor(par_cIfors)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF !EMPTY(par_cIfors)
            TRY
                IF USED("cursor_4c_Fornecedor")
                    USE IN cursor_4c_Fornecedor
                ENDIF

                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE RTRIM(Iclis) = " + ;
                           EscaparSQL(ALLTRIM(par_cIfors))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fornecedor")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Fornecedor") > 0
                    loc_cDescricao = TratarNulo(cursor_4c_Fornecedor.Rclis, "")
                ENDIF

                IF USED("cursor_4c_Fornecedor")
                    USE IN cursor_4c_Fornecedor
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar fornecedor:" + CHR(13) + loc_oErro.Message, "Erro")
                IF USED("cursor_4c_Fornecedor")
                    USE IN cursor_4c_Fornecedor
                ENDIF
            ENDTRY
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarAoCursorSelecao - Insert Into <destino>(...) Values (...) com
    * o layout de CrImagens, usando as propriedades this_* ja carregadas via
    * CarregarDoCursor(). Espelha ChkImp (par_lBuscarFornecedor = .F., sem
    * consultar SigCdCli) e Command1/Command4.Click (par_lBuscarFornecedor
    * = .T., preenche dFors com o Razas do fornecedor). impcusto/impcompo/
    * impreffor/ImpFor SEMPRE gravam 0 no INSERT - no legado esses sinalizam
    * opcoes de impressao marcadas DEPOIS pelo usuario, nunca no momento da
    * selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarAoCursorSelecao(par_cAliasDestino, par_lBuscarFornecedor)
        LOCAL loc_lSucesso, loc_cBarra, loc_cDescFornecedor

        loc_lSucesso = .F.
        loc_cDescFornecedor = ""

        IF USED(par_cAliasDestino)
            TRY
                loc_cBarra = fAltBar2de5(TRANSFORM(THIS.this_cCbars, "@L 99999999"))

                IF par_lBuscarFornecedor
                    loc_cDescFornecedor = THIS.ObterDescricaoFornecedor(THIS.this_cIfors)
                ENDIF

                INSERT INTO (par_cAliasDestino) ;
                    (cpros, dpros, linhas, colecoes, pvens, moevs, pesoms, moepvs, ;
                     fvendas, pcuss, moecs, reffs, ifors, datas, cgrus, cunis, ;
                     figjpgs, flag, tconvs, mconvs, imppreco, custofs, moecusfs, ;
                     impcusto, impcompo, impreffor, tpconvs, mpconvs, ImpFor, dFors, cBars) ;
                VALUES ;
                    (THIS.this_cCpros, THIS.this_cDpros, THIS.this_cLinhas, THIS.this_cColecoes, ;
                     THIS.this_nPvens, THIS.this_cMoevs, THIS.this_nPesoms, THIS.this_cMoepvs, ;
                     THIS.this_nFvendas, THIS.this_nPcuss, THIS.this_cMoecs, THIS.this_cReffs, ;
                     THIS.this_cIfors, THIS.this_dDatas, THIS.this_cCgrus, THIS.this_cCunis, ;
                     THIS.this_cFigjpgs, THIS.this_nFlag, THIS.this_nTconvs, THIS.this_cMconvs, ;
                     THIS.this_nImppreco, THIS.this_nCustofs, THIS.this_cMoecusfs, ;
                     0, 0, 0, THIS.this_nTpconvs, THIS.this_cMpconvs, 0, loc_cDescFornecedor, loc_cBarra)

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgErro("Erro ao adicionar produto a selecao de imagens:" + CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RemoverDoCursorSelecao - Locate for cpros = X / Delete (ChkImp quando
    * o usuario desmarca, e Command2/Command3.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE RemoverDoCursorSelecao(par_cAliasDestino, par_cCpros)
        LOCAL loc_lSucesso, loc_cAliasAtual
        loc_lSucesso = .F.

        IF USED(par_cAliasDestino)
            loc_cAliasAtual = ALIAS()
            SELECT (par_cAliasDestino)
            GO TOP
            LOCATE FOR ALLTRIM(cpros) == ALLTRIM(par_cCpros)
            IF FOUND()
                DELETE
                loc_lSucesso = .T.
            ENDIF
            IF !EMPTY(loc_cAliasAtual) AND USED(loc_cAliasAtual)
                SELECT (loc_cAliasAtual)
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
