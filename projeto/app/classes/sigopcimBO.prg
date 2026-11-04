*==============================================================================
* sigopcimBO.prg - Business Object para Consulta/Exclusao de Imagem (Leitura de Barras)
* Tabela principal: Historico (cursor local de leitura de codigos de barras)
* Cursor de grade: CrInvH (Barras/Local/Ocorrencia/Observacao/Peso Real)
* Form original: SIGOPCIM.scx (Consulta Imagem / Exclusao de Barras)
*==============================================================================

DEFINE CLASS sigopcimBO AS BusinessBase

    *-- Codigo de barras lido/digitado (Get_Barra). NUMERICO: medido no
    *-- docs/schema.sql, SigOpEtq.cbars e SigIvTrh.cbars sao numeric(14,0), e o
    *-- proprio SCX declara "Get_Barra / Value = 0 / InputMask =
    *-- 99999999999999" - ou seja a tela tambem digita numero. Guardar como
    *-- char obrigaria a converter nos dois sentidos (STR na ida, VAL na volta)
    *-- numa chave de 14 digitos, e qualquer SEEK no indice "cbars" (que e
    *-- numerico) com chave caractere estoura "Operator/operand type
    *-- mismatch" - a MESMA armadilha que a Fase 7 corrigiu no TextBox.
    this_nBarra      = 0     && numeric(14,0)  SigOpEtq.cbars / SigIvTrh.cbars

    *-- Produto associado a barra (Get_Produto) - FK SigCdPro.CPros
    this_cProduto    = ""    && char(20)  Codigo do Produto (FK SigCdPro.CPros)

    *-- Descricao do produto (Get_Descricao) - somente exibicao, vem do lookup
    this_cDescricao  = ""    && char(60)  Descricao do Produto (FK SigCdPro.DPros)

    *-- Peso medio/real associado a barra (Get_Peso)
    this_nPeso       = 0     && numeric(10,3)  Peso do item

    *-- Linha de producao associada a barra (Get_Linha)
    this_cLinha      = ""    && char(40)  Linha / observacao associada ao item

    *-- Colunas do registro de Historico/CrInvH (cursor_4c_Dados da grade)
    this_cLocal        = ""    && char(10)  Historico.Localis - local da leitura
    this_cOcorrencia   = ""    && char(10)  Historico.Ocors   - ocorrencia do item
    this_mObs          = ""    && memo      Historico.Obs     - observacao do item
    this_nPesoReal     = 0     && numeric(8,2) Historico.PesReals - peso real lido

    *-- Foto do produto (SigCdPro.FigJpgs), usada so para gerar o arquivo .jpg
    *-- temporario exibido em ImgJpg - nunca persistida pelo BO.
    this_mFigJpgs      = ""

    *-- Flags de resultado das consultas (Valid de Get_Barra/Get_Produto)
    this_lBarraLocalizada    = .F.   && .T. quando SigOpEtq achou o CBars
    this_lProdutoLocalizado  = .F.   && .T. quando SigCdPro achou o CPros

    *-- .T. quando o SQLEXEC da consulta falhou (equivalente ao
    *-- "If ...SqlExecute(lStrQuery,'TmpBar') < 1" do legado, que exibe
    *-- "Favor reinicializar o processo !!!" e ABORTA o Valid com Return(.F.)).
    *-- Nao da para sinalizar isso pelo retorno da funcao: ela ja devolve .T.
    *-- tambem quando a consulta roda e nao acha nada, que NAO e erro (regra
    *-- CLAUDE.md #50 - universo vazio nao e erro). Zero linha e falha de
    *-- conexao sao resultados DIFERENTES e o legado os trata diferente.
    this_lFalhaConexao       = .F.   && .T. quando SQLEXEC devolveu < 1

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "Historico"
        THIS.this_cCampoChave = "CBars"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - CBars (Historico/CrInvH.CBars) e a chave logica do
    * item de leitura; na ausencia de barra (modo so-por-produto), a chave
    * passa a ser o codigo do produto (CPros), igual ao Case do Excluiitem.Click
    * legado (Empty(Get_Barra.Value) And !Empty(Get_Produto.Value)).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        *-- A chave da auditoria e CARACTERE (RegistrarAuditoria a concatena na
        *-- string do INSERT), por isso o STR aqui - a property segue numerica.
        IF THIS.this_nBarra != 0
            RETURN ALLTRIM(STR(THIS.this_nBarra, 14))
        ENDIF
        RETURN ALLTRIM(THIS.this_cProduto)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia uma linha de Historico/CrInvH (par_cAliasCursor)
    * para as properties do BO. E o shape da grade (Barras/Local/Ocorrencia/
    * Observacao/Peso Real), nao o shape dos lookups de Barra/Produto - esses
    * tem metodo proprio (ConsultarBarra/ConsultarProduto) porque vem de
    * tabelas diferentes (SigOpEtq/SigCdPro) com colunas diferentes.
    *
    * Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
    * CBars e numeric(14,0) no schema e a property e numerica (ver
    * this_nBarra) - nada de converter para char no caminho.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nBarra      = TratarNulo(cbars, 0)
                THIS.this_cProduto    = TratarNulo(cpros, "")
                THIS.this_cLocal      = TratarNulo(localis, "")
                THIS.this_cOcorrencia = TratarNulo(ocors, "")
                THIS.this_mObs        = TratarNulo(obs, "")
                THIS.this_nPesoReal   = TratarNulo(pesreals, 0)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarBarra - replica o 1o SQLEXEC do Valid de Get_Barra: busca a
    * etiqueta em SigOpEtq pelo codigo de barras. Achando, preenche o Produto
    * e o Peso que a tela espelha; sem achar, so desliga o flag de localizacao
    * (o legado, nesse caso, simplesmente nao atualiza os campos - regra
    * CLAUDE.md #50, universo vazio nao e erro).
    *==========================================================================
    FUNCTION ConsultarBarra(par_nCbars)
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_lBarraLocalizada = .F.
        THIS.this_lFalhaConexao    = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CimEtq")
                    USE IN cursor_4c_CimEtq
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT CBars, CPros, Pesos FROM SigOpEtq WHERE CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    "cursor_4c_CimEtq")

                *-- mesmo criterio do legado ("SqlExecute(...) < 1"). A
                *-- atribuicao fica DENTRO da guarda de conexao: sem handle o
                *-- loc_nResultado nunca e atribuido (nasce .F. logico) e
                *-- compara-lo com 1 estouraria "Operator/operand type
                *-- mismatch" justamente em modo teste/validacao de UI.
                THIS.this_lFalhaConexao = (loc_nResultado < 1)

                IF loc_nResultado >= 0 AND USED("cursor_4c_CimEtq") AND RECCOUNT("cursor_4c_CimEtq") > 0
                    SELECT cursor_4c_CimEtq
                    GO TOP

                    THIS.this_lBarraLocalizada = .T.
                    THIS.this_nBarra   = TratarNulo(CBars, 0)
                    THIS.this_cProduto = TratarNulo(CPros, "")
                    THIS.this_nPeso    = TratarNulo(Pesos, 0)
                ENDIF

                IF USED("cursor_4c_CimEtq")
                    USE IN cursor_4c_CimEtq
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarProduto - replica o SQLEXEC do Valid de Get_Produto: busca o
    * produto em SigCdPro, com a descricao da linha via Left Join SigCdLin
    * (mesma consulta do legado: a.CPros,a.Linhas,a.FigJpgs,b.Descs). Achando,
    * preenche Linha (Descs) e a foto (FigJpgs, para DecodificarEGravarFoto);
    * Peso fica zerado, igual ao legado (ThisForm.Get_Peso.Value = 0).
    *
    * this_cDescricao (a.DPros) tambem e preenchido aqui - e o mesmo SigCdPro
    * que o fluxo de Get_Barra.Valid consulta (lcConsulta = CursorQuery(
    * 'SigCdPro','TmpPro','CPros',...,'CPros,DPros,Linhas,FigJpgs')), so que
    * o legado faz isso em DUAS CursorQuery separadas (SigCdPro + SigCdLin);
    * aqui as duas foram unificadas num LEFT JOIN so. O Form (fluxo de
    * Get_Produto) e quem decide SE usa this_cDescricao - o legado nunca
    * atualiza Get_Descricao.Value no Valid de Get_Produto, so no de
    * Get_Barra.
    *==========================================================================
    FUNCTION ConsultarProduto(par_cCodProduto)
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_lProdutoLocalizado = .F.
        THIS.this_lFalhaConexao      = .F.

        *-- Limpa o que esta consulta PRODUZ, antes de consultar. Nao e zelo:
        *-- no fluxo da BARRA o legado le TmpPro/TmpLinha SEM guarda de EOF
        *-- ("Get_Produto.Value = TmpPro.CPros / Get_Descricao.Value =
        *-- TmpPro.DPros / ..."), ou seja com o produto AUSENTE ele atribui o
        *-- valor vazio do cursor e a tela LIMPA. Sem este reset as properties
        *-- guardariam o resultado da leitura ANTERIOR, e o usuario veria a
        *-- descricao e a FOTO do produto antigo associadas a barra nova -
        *-- divergencia silenciosa, sem erro nenhum.
        THIS.this_cProduto   = ""
        THIS.this_cDescricao = ""
        THIS.this_nPeso      = 0
        THIS.this_cLinha     = ""
        THIS.this_mFigJpgs   = ""

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CimPro")
                    USE IN cursor_4c_CimPro
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT a.CPros, a.DPros, a.Linhas, a.FigJpgs, b.Descs " + ;
                    "FROM SigCdPro a LEFT JOIN SigCdLin b ON b.Linhas = a.Linhas " + ;
                    "WHERE a.CPros = " + EscaparSQL(ALLTRIM(par_cCodProduto)), ;
                    "cursor_4c_CimPro")

                *-- mesmo criterio do legado ("SqlExecute(...,'TmpPro') < 1");
                *-- DENTRO da guarda de conexao pelo mesmo motivo de
                *-- ConsultarBarra.
                THIS.this_lFalhaConexao = (loc_nResultado < 1)

                IF loc_nResultado >= 0 AND USED("cursor_4c_CimPro") AND RECCOUNT("cursor_4c_CimPro") > 0
                    SELECT cursor_4c_CimPro
                    GO TOP

                    THIS.this_lProdutoLocalizado = .T.
                    THIS.this_cProduto   = TratarNulo(CPros, "")
                    THIS.this_cDescricao = TratarNulo(DPros, "")
                    THIS.this_nPeso      = 0
                    THIS.this_cLinha     = TratarNulo(Descs, "")
                    THIS.this_mFigJpgs   = TratarNulo(FigJpgs, "")
                ENDIF

                IF USED("cursor_4c_CimPro")
                    USE IN cursor_4c_CimPro
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarInventarioPorBarra - replica o fallback de SigIvTrH do Valid de
    * Get_Barra, usado quando o item nao esta em CrInvH nem em Historico:
    * Select * From SigIvTrH Where Emps = <emp> And Codigos = <balanco> And
    * CBars = <barra>. par_cCursorDestino recebe o resultado (0 ou 1 linha);
    * quem monta Emps/Codigos e o Form, a partir do cursor global do balanco
    * ativo (CrSigCdBal no legado) - este BO nao conhece esse cursor.
    *==========================================================================
    FUNCTION ConsultarInventarioPorBarra(par_cEmpresa, par_nCodigoBalanco, par_nCbars, par_cCursorDestino)
        LOCAL loc_nResultado

        loc_nResultado = -1

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigIvTrH WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                    " AND Codigos = " + FormatarNumeroSQL(par_nCodigoBalanco, 0) + ;
                    " AND CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    par_cCursorDestino)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * ConsultarInventarioPorProduto - mesmo fallback do ConsultarInventarioPor
    * Barra, mas pelo CPros (Valid de Get_Produto quando !Seek(This.Value,
    * 'CrInvH','CPros')).
    *==========================================================================
    FUNCTION ConsultarInventarioPorProduto(par_cEmpresa, par_nCodigoBalanco, par_cCodProduto, par_cCursorDestino)
        LOCAL loc_nResultado

        loc_nResultado = -1

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigIvTrH WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                    " AND Codigos = " + FormatarNumeroSQL(par_nCodigoBalanco, 0) + ;
                    " AND CPros = " + EscaparSQL(ALLTRIM(par_cCodProduto)), ;
                    par_cCursorDestino)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * DecodificarEGravarFoto - replica a decodificacao da foto do produto (bloco
    * dentro do With ThisForm do Valid de Get_Barra/Get_Produto): remove os tres
    * prefixos "data:image/..." e decodifica o Base64 restante UMA UNICA VEZ
    * (Strconv(...,14) - decodificar duas vezes corrompe o JPEG, o binario
    * resultante nao e base64). Grava o JPEG binario direto em par_cCaminho
    * Destino; quem exibe (Image.Picture) e apaga o arquivo depois e o Form.
    *==========================================================================
    FUNCTION DecodificarEGravarFoto(par_mFigJpgs, par_cCaminhoDestino)
        LOCAL loc_cFoto, loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_mFigJpgs) AND !ISNULL(par_mFigJpgs)
            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(par_mFigJpgs, ;
                "data:image/png;base64,", ""), ;
                "data:image/jpeg;base64,", ""), ;
                "data:image/jpg;base64,", ""), 14)

            IF STRTOFILE(loc_cFoto, par_cCaminhoDestino) > 0
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao - NAO sobrescritos de proposito. O
    * SIGOPCIM legado nunca grava em tabela SQL Server nenhuma: as unicas
    * escritas do form (Excluiitem.Click) sao Insert/Delete em cursores VFP
    * locais (Historico/CrInvH), que o Form ja recebe abertos do ParentForm -
    * nao ha chave SQL para gravar nem auditoria de banco para registrar.
    * O comportamento padrao herdado de BusinessBase (recusar a operacao com
    * mensagem) ja e o correto para esta entidade.
    *==========================================================================

ENDDEFINE
