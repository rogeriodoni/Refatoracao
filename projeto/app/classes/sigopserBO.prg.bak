*==============================================================================
* sigopserBO.prg - Business Object para Servicos do Item (SIGOPSER)
* Tabela principal: SigMvItn (linhas de servico do item de movimento)
* Tabela relacionada: SigMvItp (TamDe/TamPara - tamanho exigido do servico)
* Dialogo modal aberto pelo form pai (ex.: SigOpPed) para detalhar os
* servicos vinculados a um item de produto (ThisForm.ParentForm.Citem).
*==============================================================================

DEFINE CLASS sigopserBO AS BusinessBase

    *-- Identificacao do movimento/operacao pai (contexto recebido do form
    *-- que abriu o dialogo - TprMvCab/crTpmMvItn do legado) --------------
    this_cEmps            = ""    && char(3)  - Empresa
    this_cDopes           = ""    && char(20) - Operacao do movimento (TprMvCab.Dopes)
    this_nNumes           = 0     && N(6,0)   - Numero sequencial do movimento (TprMvCab.Numes)
    this_nCitemProduto    = 0     && N(10,0)  - Citens do item de produto ao qual os servicos pertencem (ThisForm.Citem)
    this_cCursorAlias     = ""    && Alias do cursor de grade compartilhado com o form pai (crTpmMvItn3 no
                                   && legado), setado pelo Form antes de chamar CarregarDoCursor/Inserir/Atualizar

    *-- Configuracao da operacao (SigCdOpe) - carregada uma vez por sessao
    *-- do dialogo e reutilizada nas validacoes de preco/quantidade -------
    this_nCasas           = 0     && N(1,0)  - Casas decimais do preco unitario (CrSigCdOpe.Casas)
    this_nZerQtds         = 0     && N(1,0)  - Zera a quantidade ao trocar de produto (CrSigCdOpe.ZerQtds)
    this_nPrecoAuts       = 0     && N(1,0)  - Busca preco de lista automaticamente (CrSigCdOpe.PrecoAuts)
    this_nPrecoPs         = 0     && N(2,0)  - Fonte do preco quando nao ha lista vigente (CrSigCdOpe.PrecoPs)
    this_nPrecops         = 0     && N(1,0)  - Define a moeda de faturamento do item (CrSigCdOpe.Precops)
    this_cCMoes           = ""    && char(3) - Moeda padrao da operacao (CrSigCdOpe.CMoes)
    this_nItSituas        = 0     && N(1,0)  - Filtro de situacao do produto/servico (CrSigCdOpe.ItSituas)
    this_nHabServs        = 0     && N(1,0)  - Indica se a operacao habilita servicos (CrSigCdOpe.HabServs)

    *-- Flags de garantia recebidos do form pai no Init do dialogo --------
    this_lGarantia            = .F.   && Indica fluxo de garantia (par_lGarantia)
    this_lValorZeroGarantia   = .F.   && Zera o valor unitario quando em garantia (par_lVlrZeroGarantia)

    *-- Identificacao do PRODUTO dono dos servicos (crTpmMvItn + SigCdPro do
    *-- legado), exibida no cabecalho do dialogo nos campos Get_Produto /
    *-- Get_Descricao / Get_Mercs. Propriedades SEPARADAS das da linha
    *-- (this_cCpros/this_cDpros) de proposito: aquelas descrevem o SERVICO da
    *-- linha corrente da grade e mudam a cada troca de linha, estas descrevem
    *-- o item do documento e valem para o dialogo inteiro - reaproveitar as
    *-- primeiras faria a descricao do produto sobrescrever a do servico.
    this_cCprosItem       = ""    && char(14) - Codigo do produto do item (crTpmMvItn.Cpros)
    this_cDprosItem       = ""    && char(65) - Descricao do produto do item (SigCdPro.dpros)
    this_cMercsItem       = ""    && char(3)  - Mercadoria do produto do item (SigCdPro.mercs)

    *-- Dados do item de servico (linha corrente de SigMvItn + SigMvItp) --
    this_cCidChaves       = ""    && char(20) - Chave unica do item (PK)
    this_nCitens          = 0     && N(10,0)  - Item (mesmo citens do produto pai)
    this_cCpros           = ""    && char(14) - Codigo do servico
    this_cDpros           = ""    && char(65) - Descricao do servico
    this_cCunis           = ""    && char(3)  - Unidade
    this_nQtds            = 0     && N(9,3)   - Quantidade
    this_nUnits           = 0     && N(15,6)  - Valor unitario
    this_nUnivals         = 0     && N(15,6)  - Valor unitario de venda (tabela de preco)
    this_nTotas           = 0     && N(11,2)  - Total do item
    this_cMoedas          = ""    && char(3)  - Moeda do item
    this_cMoefats         = ""    && char(3)  - Moeda de faturamento
    this_cMoevs           = ""    && char(3)  - Moeda de venda
    this_nMoevals         = 0     && N(15,6)  - Valor na moeda de venda
    this_lIconfs          = .F.   && bit      - Exige confirmacao de tamanho
    this_nCodBarras       = 0     && N(14,0)  - Codigo de barras
    this_nUtilizas        = 0     && N(4,0)   - Utilizas
    this_cNotas           = ""    && char(6)  - Notas
    this_cObs             = ""    && memo     - Observacao
    this_cTamDe           = ""    && char(3)  - Tamanho De (SigMvItp)
    this_cTamPara         = ""    && char(3)  - Tamanho Para (SigMvItp)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar sigopserBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do servico a partir do
    * registro corrente do cursor informado (equivalente a leitura de
    * crTpmMvItn3 feita pelos handlers Valid/AfterRowColChange do legado).
    * par_cCursor eh o alias do cursor de grade compartilhado com o form pai.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor) AND USED(par_cCursor)

            SELECT (par_cCursor)

            IF !EOF()
                TRY
                    THIS.this_cCursorAlias = par_cCursor

                    THIS.this_cCidChaves   = TratarNulo(cidchaves, "")
                    THIS.this_cEmps        = TratarNulo(emps, "")
                    THIS.this_cDopes       = TratarNulo(dopes, "")
                    THIS.this_nNumes       = TratarNulo(numes, 0)
                    THIS.this_nCitens      = TratarNulo(citens, 0)
                    THIS.this_cCpros       = TratarNulo(cpros, "")
                    THIS.this_cDpros       = TratarNulo(dpros, "")
                    THIS.this_cCunis       = TratarNulo(cunis, "")
                    THIS.this_nQtds        = TratarNulo(qtds, 0)
                    THIS.this_nUnits       = TratarNulo(units, 0)
                    THIS.this_nUnivals     = TratarNulo(univals, 0)
                    THIS.this_nTotas       = TratarNulo(totas, 0)
                    THIS.this_cMoedas      = TratarNulo(moedas, "")
                    THIS.this_cMoefats     = TratarNulo(moefats, "")
                    THIS.this_cMoevs       = TratarNulo(moevs, "")
                    THIS.this_nMoevals     = TratarNulo(moevals, 0)
                    THIS.this_lIconfs      = ConverterParaLogico(iconfs)
                    THIS.this_nCodBarras   = TratarNulo(codbarras, 0)
                    THIS.this_nUtilizas    = TratarNulo(utilizas, 0)
                    THIS.this_cNotas       = TratarNulo(notas, "")
                    THIS.this_cObs         = TratarNulo(obs, "")
                    THIS.this_cTamDe       = TratarNulo(tamde, "")
                    THIS.this_cTamPara     = TratarNulo(tampara, "")

                    loc_lResultado = .T.

                CATCH TO loc_oErro
                    MsgErro("Erro ao carregar linha de servi" + CHR(231) + "o do cursor: " + loc_oErro.Message, "Erro")
                    loc_lResultado = .F.
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Adiciona uma nova linha de servico ao cursor de grade
    * compartilhado com o formulario pai (equivalente ao mInsereLinha() do
    * legado, que faz "Insert Into crTpmMvItn3(...) Values (...)").
    *
    * Este dialogo NUNCA grava diretamente em SigMvItn/SigMvItp: no legado,
    * o Init monta e o cntOK.btnSair apenas valida/fecha o cursor compartilhado
    * crTpmMvItn3 - a persistencia definitiva (e a auditoria correspondente)
    * acontece quando o formulario pai salva o documento (pedido) por completo.
    * Por isso THIS.RegistrarAuditoria() nao e chamado aqui.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)
            APPEND BLANK

            REPLACE emps      WITH THIS.this_cEmps, ;
                    dopes     WITH THIS.this_cDopes, ;
                    numes     WITH THIS.this_nNumes, ;
                    citens    WITH THIS.this_nCitemProduto, ;
                    cpros     WITH THIS.this_cCpros, ;
                    dpros     WITH THIS.this_cDpros, ;
                    cunis     WITH THIS.this_cCunis, ;
                    qtds      WITH THIS.this_nQtds, ;
                    units     WITH THIS.this_nUnits, ;
                    univals   WITH THIS.this_nUnivals, ;
                    totas     WITH THIS.this_nTotas, ;
                    moedas    WITH THIS.this_cMoedas, ;
                    moefats   WITH THIS.this_cMoefats, ;
                    moevs     WITH THIS.this_cMoevs, ;
                    moevals   WITH THIS.this_nMoevals, ;
                    iconfs    WITH THIS.this_lIconfs, ;
                    codbarras WITH THIS.this_nCodBarras, ;
                    utilizas  WITH THIS.this_nUtilizas, ;
                    notas     WITH THIS.this_cNotas, ;
                    obs       WITH THIS.this_cObs, ;
                    tamde     WITH THIS.this_cTamDe, ;
                    tampara   WITH THIS.this_cTamPara

            THIS.this_nCitens = THIS.this_nCitemProduto
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir linha de servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Grava as alteracoes do servico corrente no registro
    * posicionado do cursor de grade compartilhado (equivalente aos blocos
    * "Replace ... In crTpmMvItn3" dos handlers Valid/LostFocus do legado:
    * PRODUTO.Valid, QTD.Valid, VALOR.Valid, Descricao.Valid, getTamDe/
    * getTamPara.Valid). Mesma observacao da Inserir() quanto a auditoria.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EOF(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Nenhuma linha de servi" + CHR(231) + "o posicionada para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)

            REPLACE cpros     WITH THIS.this_cCpros, ;
                    dpros     WITH THIS.this_cDpros, ;
                    cunis     WITH THIS.this_cCunis, ;
                    qtds      WITH THIS.this_nQtds, ;
                    units     WITH THIS.this_nUnits, ;
                    univals   WITH THIS.this_nUnivals, ;
                    totas     WITH THIS.this_nTotas, ;
                    moedas    WITH THIS.this_cMoedas, ;
                    moefats   WITH THIS.this_cMoefats, ;
                    moevs     WITH THIS.this_cMoevs, ;
                    moevals   WITH THIS.this_nMoevals, ;
                    iconfs    WITH THIS.this_lIconfs, ;
                    codbarras WITH THIS.this_nCodBarras, ;
                    utilizas  WITH THIS.this_nUtilizas, ;
                    notas     WITH THIS.this_cNotas, ;
                    obs       WITH THIS.this_cObs, ;
                    tamde     WITH THIS.this_cTamDe, ;
                    tampara   WITH THIS.this_cTamPara

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar linha de servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarTamanhos - Grava NO registro posicionado do cursor de grade
    * apenas as duas colunas do painel "Tamanho" (SigMvItp.TamDe/TamPara).
    *
    * Equivalente exato do "Replace TamDe With This.Value In crTpmMvItn3" que o
    * legado faz no Valid de cada um dos dois campos. Existe ao lado de
    * Atualizar() - e nao no lugar dela - porque Atualizar() regrava a LINHA
    * INTEIRA: usa-la aqui ampliaria a escrita para 18 colunas que o legado nao
    * toca neste caminho, inclusive iconfs, cujo tipo varia conforme o driver
    * que montou o cursor do chamador.
    *
    * Metodo PUBLIC de proposito: eh chamado pelo Form (regra #51).
    *==========================================================================
    PROCEDURE AtualizarTamanhos()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EOF(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Nenhuma linha de servi" + CHR(231) + "o posicionada para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)

            REPLACE tamde   WITH THIS.this_cTamDe, ;
                    tampara WITH THIS.this_cTamPara

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar o tamanho do servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterMercadoriaProduto - Mercadoria (SigCdPro.mercs) do produto dono dos
    * servicos. Eh o que o legado obtinha junto com a descricao do item:
    *
    *   =ThisForm.Parentform.Podatamgr.Cursorquery('SigCdPro','CrTmpPro', ;
    *                                   'Cpros', crTpmMvItn.Cpros,[dpros, Mercs])
    *
    * Metodo PUBLIC de proposito: eh chamado pelo Form (regra #51). Devolve ""
    * quando nao ha conexao ou o produto nao existe - o chamador decide o
    * default, como o legado faz no Iif de lcMercs.
    *==========================================================================
    PROCEDURE ObterMercadoriaProduto(par_cCpros)
        LOCAL loc_cMercs, loc_cSQL, loc_nResultado, loc_nAreaAnterior, loc_oErro

        loc_cMercs        = ""
        loc_nAreaAnterior = SELECT()

        TRY
            IF VARTYPE(par_cCpros) = "C" AND !EMPTY(ALLTRIM(par_cCpros)) ;
               AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                loc_cSQL = "SELECT dpros, mercs FROM SigCdPro" + ;
                           " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

                IF USED("cursor_4c_ProdutoItem")
                    USE IN cursor_4c_ProdutoItem
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoItem")

                IF loc_nResultado < 0
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler o " + ;
                            "produto do item." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_ProdutoItem")
                        SELECT cursor_4c_ProdutoItem
                        GO TOP

                        IF !EOF()
                            loc_cMercs = ALLTRIM(TratarNulo(mercs, ""))

                            *-- Identificacao do PRODUTO do item, nas
                            *-- propriedades proprias dele: this_cDpros
                            *-- descreve o SERVICO da linha corrente e seria
                            *-- sobrescrita aqui, fazendo a grade exibir a
                            *-- descricao do produto no lugar da do servico.
                            *-- this_cCprosItem eh escrita pelo Form, que eh
                            *-- quem le o codigo no cursor do item
                            THIS.this_cDprosItem = ALLTRIM(TratarNulo(dpros, ""))
                            THIS.this_cMercsItem = loc_cMercs
                        ENDIF

                        USE IN cursor_4c_ProdutoItem
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao ler o produto do item")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_cMercs
    ENDPROC

    *==========================================================================
    * CarregarServicosDisponiveis - monta csSigCdPro, o UNIVERSO dos servicos
    * que o usuario pode escolher nas colunas "Servico" e "Descricao" da grade.
    *
    * Legado (Init de SIGOPSER), transcrito:
    *
    *   If (crSigCdOpe.HabServs = 1)
    *      lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a, SigCdGrp b ]+;
    *                [Where a.Cgrus = b.Cgrus And b.Servicos = 1 ]+;
    *          Iif(crSigCdOpe.ItSituas=1,[ And (Not a.Situas = 2 Or (a.Situas = 2 And
    *                    (Not a.DtSituas Is Null And a.DtSituas < ?pDat)))], ;
    *          Iif(crSigCdOpe.ItSituas=2,[ And a.Situas = 2 ],[]))
    *   Else
    *      lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a Where 0=1 ]
    *   EndIf
    *   ...
    *   Select * From csSigCdPro Where IdeCpros = lcMercs Into Cursor csSigCdPro ReadWrite
    *
    * O "Where 0=1" do ramo Else NAO eh defeito: operacao que nao habilita
    * servicos tem universo VAZIO de proposito, e o legado monta o cursor assim
    * mesmo para que a estrutura exista e os indices possam ser criados.
    *
    * O filtro por mercadoria eh o re-Select que o legado faz logo depois; aqui
    * ele entra no proprio WHERE porque o resultado eh o mesmo e evita uma
    * segunda passagem sobre o cursor inteiro. Quando o chamador nao consegue
    * resolver a mercadoria (par_cMercs vazio), o filtro NAO eh aplicado - o
    * legado nunca chega a esse caso porque sempre cai no default 'JOI'.
    *
    * O cursor sai READWRITE porque o Form cria indices sobre ele (Cpros/DPros)
    * e o cursor de SQLEXEC nasce somente-leitura; por isso o SQLEXEC vai para
    * um alias TEMPORARIO e o resultado eh convertido.
    *
    * pDat do legado eh Datetime() do cliente, nao GETDATE() do servidor:
    * transcrito como GETDATE().
    *==========================================================================
    PROCEDURE CarregarServicosDisponiveis(par_cCursor, par_cMercs)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursor, loc_nResultado
        LOCAL loc_nAreaAnterior, loc_oErro

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()
        loc_cCursor       = IIF(VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor), ;
                                par_cCursor, "csSigCdPro")

        TRY
            IF THIS.this_nHabServs = 1
                loc_cSQL = "SELECT a.Cpros, a.Dpros, a.IdeCPros" + ;
                           " FROM SigCdPro a, SigCdGrp b" + ;
                           " WHERE a.Cgrus = b.Cgrus AND b.Servicos = 1"

                DO CASE
                    CASE THIS.this_nItSituas = 1
                        loc_cSQL = loc_cSQL + ;
                            " AND (NOT a.Situas = 2 OR (a.Situas = 2" + ;
                            " AND (NOT a.DtSituas IS NULL" + ;
                            " AND a.DtSituas < " + GETDATE() + ")))"
                    CASE THIS.this_nItSituas = 2
                        loc_cSQL = loc_cSQL + " AND a.Situas = 2"
                ENDCASE
            ELSE
                loc_cSQL = "SELECT a.Cpros, a.Dpros, a.IdeCPros" + ;
                           " FROM SigCdPro a WHERE 0 = 1"
            ENDIF

            IF VARTYPE(par_cMercs) = "C" AND !EMPTY(ALLTRIM(par_cMercs))
                loc_cSQL = loc_cSQL + ;
                           " AND a.IdeCPros = " + EscaparSQL(ALLTRIM(par_cMercs))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Cpros"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ServicosTmp")
                    USE IN cursor_4c_ServicosTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ServicosTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                            THIS.this_cMensagemErro, ;
                            "Falha na Conex" + CHR(227) + "o (csSigCdPro)")
                ELSE
                    IF USED(loc_cCursor)
                        IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                            TABLEREVERT(.T., loc_cCursor)
                        ENDIF
                        USE IN (loc_cCursor)
                    ENDIF

                    SELECT Cpros, Dpros, IdeCPros ;
                        FROM cursor_4c_ServicosTmp ;
                        INTO CURSOR (loc_cCursor) READWRITE

                    IF USED("cursor_4c_ServicosTmp")
                        USE IN cursor_4c_ServicosTmp
                    ENDIF

                    loc_lSucesso = USED(loc_cCursor)
                ENDIF
            ELSE
                *-- Sem conexao (harness de teste / validacao de UI): o cursor
                *-- existe VAZIO, com a mesma estrutura, para que a grade e os
                *-- lookups encontrem o alias em vez de estourar
                IF USED(loc_cCursor)
                    IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                        TABLEREVERT(.T., loc_cCursor)
                    ENDIF
                    USE IN (loc_cCursor)
                ENDIF

                CREATE CURSOR (loc_cCursor) ( Cpros    C(14), ;
                                              Dpros    C(65), ;
                                              IdeCPros C(3) )

                loc_lSucesso = USED(loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao montar a lista de servi" + CHR(231) + "os")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do item corrente, usada
    * pela RegistrarAuditoria() da BusinessBase
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

ENDDEFINE
