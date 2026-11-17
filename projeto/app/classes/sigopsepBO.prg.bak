*==============================================================================
* SIGOPSEPBO.PRG
* Business Object - Selecao de Produtos para Lista de Preco
* Origem: SIGOPSEP.SCX (form filho, chamado por ThisForm.ParentForm)
*==============================================================================

DEFINE CLASS sigopsepBO AS BusinessBase

    *-- Filtro: Grupo de Venda (colecoes - SigCdCol)
    this_cGrupoVenda = ""
    this_cDescGrupoVenda = ""

    *-- Filtro: Grupo de Produto (cgrus - SigCdGrp)
    this_cGrupoProduto = ""
    this_cDescGrupoProduto = ""

    *-- Filtro: Moeda de Venda (cmoes - SigCdMoe)
    this_cMoedaVenda = ""
    this_cDescMoedaVenda = ""

    *-- Filtro: Acrescimo/Desconto percentual
    this_nAcrescimoDesconto = 0

    *-- Filtro: Arredondamento
    this_nArredondamento = 0

    *-- Filtro: Situacao (1=Ativos, 2=Inativos, 3=Todos)
    this_nSituacao = 1

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdPro")

        THIS.this_cCampoChave = "cpros"

        THIS.this_cGrupoVenda = ""
        THIS.this_cDescGrupoVenda = ""
        THIS.this_cGrupoProduto = ""
        THIS.this_cDescGrupoProduto = ""
        THIS.this_cMoedaVenda = ""
        THIS.this_cDescMoedaVenda = ""
        THIS.this_nAcrescimoDesconto = 0
        THIS.this_nArredondamento = 0
        THIS.this_nSituacao = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Carrega cursor_4c_Linhas (SigCdLin) para a grade de
    * marcacao de linhas do filtro (SIGOPSEP.Init: CsSigCdLin).
    * SQLEXEC() devolve cursor SOMENTE-LEITURA; como a grade marca/desmarca
    * via REPLACE, convertemos para READWRITE antes de expor o cursor.
    *
    * O bypass de teste vem no TOPO porque o TesteAutomatico.prg e o
    * ValidarUIFidelity.prg NAO conectam ao SQL Server (definem gnConnHandle
    * como SENTINELA). Sem ele a falha de conexao devolveria .F., o
    * InicializarForm do Form devolveria .F., CREATEOBJECT devolveria o
    * LOGICO .F. e a tela simplesmente nao abriria no harness - com uma
    * mensagem de conexao que nao corresponde a falha de rede nenhuma. O
    * cursor VAZIO e criado com a MESMA estrutura e ordem de campos do SELECT
    * abaixo (lMarcas, linhas C(10), descs C(40) - larguras de SigCdLin no
    * schema), para a grade ter o que ligar em ControlSource.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Linhas (lMarcas N(1), linhas C(10), descs C(40))
            SET NULL OFF
            SELECT cursor_4c_Linhas
            GO TOP
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_LinhasTmp")
                USE IN cursor_4c_LinhasTmp
            ENDIF
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, linhas, descs FROM SigCdLin"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasTmp")

            IF loc_nResultado >= 0
                SET NULL ON
                SELECT * FROM cursor_4c_LinhasTmp INTO CURSOR cursor_4c_Linhas READWRITE
                SET NULL OFF

                IF USED("cursor_4c_LinhasTmp")
                    USE IN cursor_4c_LinhasTmp
                ENDIF

                SELECT cursor_4c_Linhas
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLinhas - Replica Marcar.Click/Desmarcar.Click (Replace All
    * lMarcas With <valor> In CsSigCdLin).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLinhas(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                REPLACE ALL lMarcas WITH par_nValor
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorProdutos - Estrutura identica ao "Create Cursor CsSigCdPro"
    * do SIGOPSEP.Init. Cursor local (nao vem de SQLEXEC), por isso ja nasce
    * READWRITE - suporta o CheckBox da coluna flagctabs (Column1) e os
    * REPLACE de MarcarTodosProdutos/ObterProdutosParaCopia.
    *
    * PUBLIC de proposito: o Form chama este metodo para criar o cursor VAZIO
    * antes de ligar a grade de produtos (o SIGOPSEP.Init legado faz o
    * "Create Cursor" inline, antes do RecordSource/ControlSource). Deixar a
    * estrutura do cursor SO aqui evita duas versoes do mesmo CREATE CURSOR -
    * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
    * ControlSource da grade. Metodo que o Form chama de fora NAO pode ser
    * PROTECTED em nenhum nivel da heranca (regra #51): a chamada compila
    * limpo e estoura em runtime com "Property ... is not found".
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorProdutos()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos (flagctabs N(1), cpros C(14), dpros C(40), pvens N(12,2), ;
            pliqs N(12,2), moevs C(3), situas N(1), cgrus C(3), colecoes C(10), linhas C(10), lMarcas N(1))
        SET NULL OFF

        INDEX ON cpros + cgrus TAG CProGrus
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Replica SIGOPSEP.Processar.Click: monta o WHERE a
    * partir dos filtros (this_cGrupoProduto/this_cGrupoVenda/
    * this_cMoedaVenda) e das linhas marcadas em cursor_4c_Linhas, consulta
    * SigCdPro e recria cursor_4c_Produtos com pliqs calculado
    * (this_nAcrescimoDesconto/this_nArredondamento).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (equivalente a
    * CrSigCdLpi) - usado so para marcar flagctabs/lMarcas = 1 quando o
    * produto ja esta na lista de precos (Seek por CPros, igual ao legado).
    * Passar "" quando o form pai ainda nao disponibilizar esse cursor.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_cWhere, loc_cLinhas, loc_cSQL, loc_nResultado, ;
            loc_nVariacao, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cWhere = "0 = 0 "

            IF !EMPTY(THIS.this_cGrupoProduto)
                loc_cWhere = loc_cWhere + "AND cgrus = " + EscaparSQL(THIS.this_cGrupoProduto) + " "
            ENDIF
            IF !EMPTY(THIS.this_cGrupoVenda)
                loc_cWhere = loc_cWhere + "AND colecoes = " + EscaparSQL(THIS.this_cGrupoVenda) + " "
            ENDIF
            IF !EMPTY(THIS.this_cMoedaVenda)
                loc_cWhere = loc_cWhere + "AND moevs = " + EscaparSQL(THIS.this_cMoedaVenda) + " "
            ENDIF

            loc_cLinhas = ""
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                GO TOP
                SCAN
                    IF cursor_4c_Linhas.lMarcas = 1
                        loc_cLinhas = loc_cLinhas + "linhas = " + EscaparSQL(cursor_4c_Linhas.linhas) + " OR "
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cLinhas)
                loc_cWhere = loc_cWhere + "AND (" + LEFT(loc_cLinhas, LEN(loc_cLinhas) - 3) + ") "
            ENDIF

            loc_cSQL = "SELECT flagctabs, cpros, dpros, pvens, moevs, situas, cgrus, colecoes, linhas " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cWhere + ;
                       "ORDER BY cpros, cgrus, flagctabs, dpros, pvens, moevs, situas, colecoes, linhas"

            IF USED("cursor_4c_ProdutosTmp")
                USE IN cursor_4c_ProdutosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTmp")

            IF loc_nResultado >= 0
                THIS.CriarCursorProdutos()

                loc_nVariacao = 1 + (THIS.this_nAcrescimoDesconto / 100)

                SELECT cursor_4c_ProdutosTmp
                GO TOP
                SCAN
                    SCATTER MEMVAR

                    IF !EMPTY(par_cCursorListaPrecos) AND USED(par_cCursorListaPrecos) ;
                            AND SEEK(cursor_4c_ProdutosTmp.cpros, par_cCursorListaPrecos, "CPros")
                        m.flagctabs = 1
                    ELSE
                        m.flagctabs = 0
                    ENDIF
                    m.lMarcas = m.flagctabs

                    m.pliqs = ROUND(cursor_4c_ProdutosTmp.pvens * loc_nVariacao, 2)
                    IF THIS.this_nArredondamento <> 0
                        m.pliqs = ROUND(m.pliqs / THIS.this_nArredondamento, 0) * THIS.this_nArredondamento
                    ENDIF

                    INSERT INTO cursor_4c_Produtos FROM MEMVAR

                    SELECT cursor_4c_ProdutosTmp
                ENDSCAN

                IF USED("cursor_4c_ProdutosTmp")
                    USE IN cursor_4c_ProdutosTmp
                ENDIF

                SELECT cursor_4c_Produtos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosProdutos - Replica cmdMarcaProd.Click/cmdDesmarcaProd.Click
    * (Replace All flagctabs With <valor> For lMarcas = 0).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosProdutos(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                REPLACE ALL flagctabs WITH par_nValor FOR lMarcas = 0
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutosParaCopia - Replica o SCAN de SIGOPSEP.CopiaLista.Click:
    * seleciona os produtos marcados pelo usuario (flagctabs=1) que ainda
    * nao estavam na lista (lMarcas=0), respeitando o filtro de situacao
    * (this_nSituacao: 3=Todos), e reconfere que nao foram copiados nesse
    * meio-tempo (Seek por CPros no cursor do form pai).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (CrSigCdLpi).
    *
    * A INSERCAO final nesse cursor (cidchaves=fUniqueIds(), lprecos do
    * cabecalho CrSigCdLpc, vencis/vencfs={}, flagutabs=.T., pvens=pliqs)
    * fica por conta do Form: a estrutura de CrSigCdLpi/CrSigCdLpc pertence
    * ao form pai (fora do escopo deste BO, que so enxerga SigCdPro/
    * SigCdLin). fArredondamento(pvens, poDataMgr) do legado NAO foi
    * portada (funcao global Fortyus ausente do acervo, SIGFUNCS.PRG) -
    * fica de fora de proposito; o Form aplica essa funcao, quando portada,
    * somente quando o form pai indicar CompVenda <> "C" (mesmo guard do
    * legado). NUNCA substituir por ROUND/INT/CEILING.
    *
    * Popula cursor_4c_ProdutosCopia com cpros/dpros/pvens/pliqs/moevs.
    *--------------------------------------------------------------------------
    PROCEDURE ObterProdutosParaCopia(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF !USED("cursor_4c_Produtos")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                IF USED("cursor_4c_ProdutosCopia")
                    USE IN cursor_4c_ProdutosCopia
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_ProdutosCopia (cpros C(14), dpros C(40), pvens N(12,2), ;
                    pliqs N(12,2), moevs C(3))
                SET NULL OFF

                SELECT cursor_4c_Produtos
                GO TOP
                SCAN FOR cursor_4c_Produtos.flagctabs = 1 AND cursor_4c_Produtos.lMarcas = 0
                    IF THIS.this_nSituacao = 3 OR THIS.this_nSituacao = cursor_4c_Produtos.situas
                        IF EMPTY(par_cCursorListaPrecos) OR !USED(par_cCursorListaPrecos) ;
                                OR !SEEK(cursor_4c_Produtos.cpros, par_cCursorListaPrecos, "CPros")
                            INSERT INTO cursor_4c_ProdutosCopia (cpros, dpros, pvens, pliqs, moevs) VALUES ;
                                (cursor_4c_Produtos.cpros, cursor_4c_Produtos.dpros, cursor_4c_Produtos.pvens, ;
                                 cursor_4c_Produtos.pliqs, cursor_4c_Produtos.moevs)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Produtos
                ENDSCAN

                SELECT cursor_4c_ProdutosCopia
                GO TOP

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores locais abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("cursor_4c_Linhas")
            USE IN cursor_4c_Linhas
        ENDIF
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_ProdutosCopia")
            USE IN cursor_4c_ProdutosCopia
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais ao destruir o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Este BO NAO persiste nenhuma tabela propria: o SIGOPSEP legado apenas
    * CONSULTA SigCdPro/SigCdLin (filtros + grade de selecao) e copia os
    * produtos marcados para o cursor de ITENS do form pai (CrSigCdLpi,
    * fora do escopo deste BO) - nunca grava em SigCdPro. Por isso
    * Inserir()/Atualizar()/ExecutarExclusao()/RegistrarAuditoria()/
    * CarregarDoCursor()/ObterChavePrimaria() NAO sao sobrescritos aqui - o
    * comportamento padrao herdado de BusinessBase ja eh o correto para
    * este caso (mesmo padrao de SigOpCtsBO.prg/SigOpAutBO.prg, outras
    * telas operacionais sem tabela mestre propria).
    *==========================================================================

ENDDEFINE
