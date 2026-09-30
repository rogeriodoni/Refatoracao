*============================================================================
* SigPrAprBO.prg - Business Object para Reajuste de Precificacao
*
* Form OPERACIONAL (SIGPRAPR / FormSigPrApr): processo em lote que recalcula
* o preco de venda de um conjunto de produtos (filtrados por Grupo/Colecao/
* Fornecedor) usando um de tres criterios (Opt_Tipo): Variacao percentual,
* MarkUp sobre custo em moeda, ou Cambio (reprecificacao por cotacao). Os
* produtos calculados ficam numa grade de conferencia (CrProdutos no legado,
* this_cCursorItens aqui) e so sao gravados em definitivo ao clicar Atualizar,
* quando o BO grava historico em SigCdPrc/SigPrCp2 e promocao em SigPrPmi.
*
* Tabelas principais tocadas pelo processo:
*   - SigCdPro  (PK: CPros char(14))    -> produto: preco atual e moedas de custo
*   - SigCdPrc  (PK: cIdChaves char(20)) -> historico de alteracao de preco
*   - SigPrCp2  (PK: cIdChaves char(20)) -> historico de composicao/custo
*   - SigPrPmi  (PK: cidchaves char(20)) -> vinculo produto-promocao
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrAprBO AS BusinessBase

    *==========================================================================
    * Propriedades de filtro - selecao dos produtos a reajustar (Processa.Click)
    *==========================================================================
    this_cCdGrupo   = SPACE(3)    && char(3)  - SigCdGrp.CGrus (Grupo de Produto - "de")        [Get_Cd_Grupo]
    this_cAteGrupo  = SPACE(3)    && char(3)  - SigCdGrp.CGrus (Grupo de Produto - "ate")        [Get_ate_Grupo]
    this_cColecao   = SPACE(10)   && char(10) - SigCdCol.Colecoes (Grupo de Venda/Colecao)       [Get_Col]
    this_cConta     = SPACE(10)   && char(10) - Fornecedor, codigo (SigCdCli.IClis)              [Get_Conta]
    this_cDConta    = SPACE(50)   && char(50) - Fornecedor, descricao (SigCdCli.RClis)           [Get_DConta]

    *==========================================================================
    * Tipo de reajuste (Opt_Tipo: 1=Variacao, 2=MarkUp, 3=Cambio) e parametros
    *==========================================================================
    this_nTipo      = 1           && numeric      - Opt_Tipo.Value (1/2/3)
    this_nVariacao  = 0           && numeric(9,2) - percentual de reajuste (Tipo=1)              [Get_Variacao]
    this_cMoeda     = SPACE(3)    && char(3)      - moeda base do MarkUp (Tipo=2)                [Get_Moeda]
    this_nMarkUp1   = 0           && numeric(6,2) - MarkUp minimo / faixa "de"                   [Get_MarkUp1]
    this_nMarkUp2   = 0           && numeric(6,2) - MarkUp maximo, usado no calculo (Tipo=2)     [Get_MarkUp2]

    *==========================================================================
    * Fator de custo - usado em CalcPreco/CalcMargem quando informado
    *==========================================================================
    this_nFator     = 0           && numeric(8,3) - Fator de custo                               [GET_FATOR]
    this_cMoeCusto  = SPACE(3)    && char(3)      - moeda referente ao Fator de custo             [get_moeCusto]

    *==========================================================================
    * Moedas/feitio de gravacao - sobrescrevem SigCdPro quando informados
    * em Atualiza.Click (campos vazios preservam o valor atual do produto)
    *==========================================================================
    this_cMoeCs     = SPACE(3)    && char(3) - Moeda Custo Compo.  (SigCdPro.MoeCs)     [Get_Moecs]
    this_cMoeCusFs  = SPACE(3)    && char(3) - Moeda Custo Total   (SigCdPro.MoeCusFs)  [Get_MoeCusFs]
    this_cMoedas    = SPACE(3)    && char(3) - Moeda Preco Ideal   (SigCdPro.Moedas)    [Get_Moedas]
    this_cCFtios    = SPACE(3)    && char(3) - Feitio              (SigCdPro.CFtios)    [Get_CFtios]
    this_cMoeVs     = SPACE(3)    && char(3) - Moeda Preco Atual   (SigCdPro.MoeVs)     [Get_MoeVs]

    *==========================================================================
    * Promocao a vincular aos produtos atualizados (grava em SigPrPmi)
    *==========================================================================
    this_cPromo         = SPACE(25)   && char(25) - SigPrPmc.Promos                     [Get_Promo]
    this_lLimparPromos  = .F.         && logical  - Limpar promocoes anteriores         [chkLimpar]

    *==========================================================================
    * Flags de opcoes do processamento
    *==========================================================================
    this_lAuditado  = .F.   && logical - modo "Produtos": inclusao manual de itens na grade  [chkAuditado]
    this_lIncCusts  = .F.   && logical - Incluir Custos no reajuste por variacao (Tipo=1)     [chkIncCusts]
    this_lIgnorar   = .F.   && logical - Ignorar Componentes (nao filtra produto-componente)  [chkIgnorar]

    *==========================================================================
    * Estado - permissao de edicao manual do Valor Atual na grade de conferencia
    *==========================================================================
    this_lLibValAtu = .F.   && logical - fChecaAcesso('SIGPRAPR', 'VMANUAL')

    *==========================================================================
    * Parametros do sistema (SigCdPam/SigCdPac), carregados uma unica vez no
    * Init - equivalente aos SqlExecute('...SigCdPam...')/('...SigCdPac...')
    * do Init() legado
    *==========================================================================
    this_nMarkUpCVs  = 0          && numeric(9,6) - SigCdPam.MarkUpCVs
    this_cGrPadFors  = SPACE(10)  && char(10)     - SigCdPam.GrPadFors (grupo padrao p/ acesso a Contas)
    this_nCalcCusts  = 0          && numeric(1,0) - SigCdPac.CalcCusts (2 = nao usar peso no calculo de custo)
    this_nChkSubGrs  = 0          && numeric(1,0) - SigCdPac.nChkSubGrs (recalcula subgrupo por faixa de preco)

    *==========================================================================
    * Cursor de trabalho - grade de produtos selecionados/reajustados
    * (equivalente ao CrProdutos do legado). Estrutura: lMarca N(1), CPros
    * C(14), DPros C(40), ValAnt N(14,2), ValAtu N(14,2), fCustos N(8,3),
    * MoePcs C(3), CustoFs N(12,3), Manual N(1) - criado/populado pelo
    * metodo de processamento (equivalente ao Processa.Click), a ser
    * completado em fase posterior. Atualizar() abaixo consome este cursor
    * ja preenchido; se ainda nao existir, devolve mensagem de erro.
    *==========================================================================
    this_cCursorItens = "cursor_4c_Produtos"

    *==========================================================================
    * Propriedades de registro - SigPrPmi (vinculo produto-promocao), usadas
    * por CarregarDoCursor()/Inserir()/ObterChavePrimaria(). this_cCpros e
    * this_cPromo (acima) sao compartilhados com o vinculo gravado aqui -
    * this_cPromo ja representa SigPrPmi.Promos (mesmo campo do filtro).
    *==========================================================================
    this_cIdChaves   = SPACE(20)  && char(20) - SigPrPmi.cidchaves (PK)
    this_cPecas      = SPACE(10)  && char(10) - SigPrPmi.pecas
    this_nCBars      = 0          && numeric(14,0) - SigPrPmi.cbars
    this_dDatas      = {}         && datetime      - SigPrPmi.datas
    this_cPromoPro   = SPACE(35)  && char(35) - SigPrPmi.promopro (promo+cpros, truncado)
    this_dDtAlts     = {}         && datetime      - SigPrPmi.dtalts
    this_nVendavels  = 0          && numeric(1,0)  - SigPrPmi.vendavels (NOT NULL, sem uso no legado)

    *==========================================================================
    * Propriedade de item em processamento - produto CORRENTE dentro do laco
    * de Atualizar()/Inserir() (SigCdPro.cpros / SigPrPmi.cpros)
    *==========================================================================
    this_cCpros = SPACE(14)

    *==========================================================================
    * Resposta do MsgConfirma "Confirma a Impressao das Etiquetas?" (legado),
    * definida pelo Form ANTES de EditarRegistro()+Salvar() - BusinessBase.
    * Salvar() chama Atualizar() sem parametros, entao o valor tem de vir
    * por property.
    *==========================================================================
    this_lImprimirEtiquetas = .F.

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela/chave primaria
    * de referencia (SigPrPmi/cidchaves - vinculo produto-promocao gravado ao
    * Atualizar) e carrega os parametros do sistema usados no calculo
    * (SigCdPam.MarkUpCVs/GrPadFors, SigCdPac.CalcCusts/nChkSubGrs)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrPmi"
            THIS.this_cCampoChave = "cidchaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT MarkUpCVs, GrPadFors FROM SigCdPam", "cursor_4c_SigCdPam")
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_nMarkUpCVs = TratarNulo(cursor_4c_SigCdPam.MarkUpCVs, 0)
                    THIS.this_cGrPadFors = PADR(TratarNulo(cursor_4c_SigCdPam.GrPadFors, ""), 10)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                IF USED("cursor_4c_SigCdPac")
                    USE IN cursor_4c_SigCdPac
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT CalcCusts, nChkSubGrs FROM SigCdPac", "cursor_4c_SigCdPac")
                IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                    THIS.this_nCalcCusts = TratarNulo(cursor_4c_SigCdPac.CalcCusts, 0)
                    THIS.this_nChkSubGrs = TratarNulo(cursor_4c_SigCdPac.nChkSubGrs, 0)
                ENDIF
                IF USED("cursor_4c_SigCdPac")
                    USE IN cursor_4c_SigCdPac
                ENDIF

            ENDIF

            *-- Cria o cursor de trabalho vazio ja no Init, para que o Grid
            *-- do form possa ligar Column.ControlSource/RecordSource nele
            *-- durante InicializarForm (o cursor so recebe linhas de verdade
            *-- quando o usuario clicar Processar - BuscarProdutos())
            THIS.CriarCursorItens()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarCursorItens - Cria (ou ESVAZIA) o cursor de trabalho da grade de
    * conferencia. Estrutura TRANSCRITA do legado (Create Cursor CrProdutos,
    * PROCEDURE Init do SIGPRAPR): mesma ordem/tipos/tamanhos em TODOS os
    * lugares onde o cursor eh usado (unico ponto de criacao).
    *
    * Cursor JA existente eh esvaziado com ZAP, NUNCA fechado e recriado - o
    * legado tambem faz "Zap In CrProdutos" no inicio do Processa.Click, pelo
    * mesmo motivo: fechar o alias derruba o binding de quem aponta para ele
    * (grd_4c_Produtos.RecordSource + as 5 Column.ControlSource, ligados uma
    * unica vez em ConfigurarGrid). Recriando, o Processar preencheria o
    * cursor e a grade continuaria vazia - sem erro e sem log.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorItens()
        LOCAL loc_cSafety

        IF USED("cursor_4c_Produtos")
            *-- DataSession=2 reseta SET SAFETY para ON (mesmo mecanismo que
            *-- reseta SET DATE/CENTURY) - sem o guard, o ZAP abre o dialogo
            *-- modal "Are you sure?" e congela a tela.
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT cursor_4c_Produtos
            ZAP IN cursor_4c_Produtos
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos (lMarca N(1), CPros C(14), DPros C(40), ;
                ValAnt N(14,2), ValAtu N(14,2), fCustos N(8,3), MoePcs C(3), CustoFs N(12,3), Manual N(1))
            SET NULL OFF
            *-- Legado: Index On CPros Tag CPros - usado pelo modo "Produtos"
            *-- (chkAuditado) para alternar entre ordem natural (linhas
            *-- digitadas manualmente aparecem no fim) e ordem por codigo
            *-- (exibicao normal, "Set Order To CPros")
            INDEX ON CPros TAG CPros
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarProdutos - Transcreve o PROCEDURE Processa.Click do legado: monta
    * a selecao de produtos a partir dos filtros (this_cCdGrupo/this_cAteGrupo/
    * this_cColecao/this_cConta/this_nTipo/this_nVariacao/this_cMoeda/
    * this_nMarkUp1/this_nMarkUp2/this_lIgnorar - propriedades da Fase 1,
    * preenchidas pelo Form a partir dos campos de filtro), calcula o novo
    * preco (ValAtu) conforme o tipo de reajuste e popula cursor_4c_Produtos
    * para conferencia/edicao manual na grade antes de Atualizar().
    *
    * Retorno .T. com this_cMensagemErro preenchido = falha de VALIDACAO (o
    * legado mostra o MessageBox e devolve o foco ao campo - condicao de
    * negocio, nao erro tecnico; mesmo padrao de SigPrAopBO.BuscarItensPorOP).
    * Retorno .F. = falha TECNICA (SQL/conexao) - so nesse caso o Form deve
    * usar MsgErro no lugar de MsgAviso.
    *==========================================================================
    PROCEDURE BuscarProdutos()
        LOCAL loc_lSucesso, loc_cWhere, loc_cSQL, loc_nResultado, loc_oErro, loc_lProsseguir
        LOCAL loc_nCotId, loc_nCotVd, loc_nPven, loc_nValAtu, loc_cMoePcs, loc_nFCustos, loc_nCustoFs

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        THIS.CriarCursorItens()

        *-- Legado: Do Case / Consiste Selecao
        DO CASE
        CASE THIS.this_nTipo = 1 AND THIS.this_nVariacao = 0
            THIS.this_cMensagemErro = "Varia" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida" + CHR(33) + CHR(33) + CHR(33)
            RETURN .T.
        CASE THIS.this_nTipo = 2 AND EMPTY(ALLTRIM(THIS.this_cMoeda))
            THIS.this_cMensagemErro = "Moeda Inv" + CHR(225) + "lida" + CHR(33) + CHR(33) + CHR(33)
            RETURN .T.
        CASE THIS.this_nTipo = 2 AND THIS.this_nMarkUp2 = 0
            THIS.this_cMensagemErro = "MarkUp Inv" + CHR(225) + "lido" + CHR(33) + CHR(33) + CHR(33)
            RETURN .T.
        ENDCASE

        TRY
            *-- Legado: lcWhere (Cgrus faixa/exato, Colecoes, IFors, e
            *-- MoeVs+Margems quando Tipo=2)
            loc_cWhere = "0 = 0 "
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrupo)) OR !EMPTY(ALLTRIM(THIS.this_cAteGrupo))
                IF !EMPTY(ALLTRIM(THIS.this_cAteGrupo))
                    loc_cWhere = loc_cWhere + "AND Cgrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo)) + ;
                        " AND " + EscaparSQL(ALLTRIM(THIS.this_cAteGrupo)) + " "
                ELSE
                    loc_cWhere = loc_cWhere + "AND CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo)) + " "
                ENDIF
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cColecao))
                loc_cWhere = loc_cWhere + "AND Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecao)) + " "
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cWhere = loc_cWhere + "AND IFors = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + " "
            ENDIF
            IF THIS.this_nTipo = 2
                loc_cWhere = loc_cWhere + "AND MoeVs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + ;
                    " AND Margems = " + FormatarNumeroSQL(THIS.this_nMarkUp1, 2) + " "
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdPro WHERE " + loc_cWhere
            IF !THIS.this_lIgnorar
                loc_cSQL = loc_cSQL + "AND Cpros NOT IN (SELECT DISTINCT cpros FROM SigPrCpo) "
            ENDIF
            loc_cSQL = loc_cSQL + "ORDER BY CPros"

            IF USED("cursor_4c_ProdutosOrigem")
                USE IN cursor_4c_ProdutosOrigem
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosOrigem")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha na consulta de produtos:" + CHR(13) + CapturarErroSQL()
                loc_lProsseguir = .F.
            ELSE
                loc_lProsseguir = .T.
            ENDIF

            *-- Legado: Scan / Do Case (calculo do novo preco por tipo de
            *-- reajuste) / Insert Into CrProdutos
            IF loc_lProsseguir AND USED("cursor_4c_ProdutosOrigem")
                SELECT cursor_4c_ProdutosOrigem
                SCAN
                    loc_cMoePcs  = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ALLTRIM(TratarNulo(cursor_4c_ProdutosOrigem.Moepcs, "")), ALLTRIM(THIS.this_cMoeCusto))
                    loc_nFCustos = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoePcs), THIS.this_nFator, TratarNulo(cursor_4c_ProdutosOrigem.fCustos, 0))
                    *-- Legado: m.CustoFs = Iif(Fator>0 AND !Empty(Moepcs), TmpPro.CustoFs, m.CustoF)
                    *-- onde m.CustoF ja veio de TmpPro.CustoFs - as DUAS ramas do IIF
                    *-- avaliam para o MESMO valor (vestigio do legado, igual ao
                    *-- "Replace CustoFs With m.CustoF" ja documentado em CalcPreco)
                    loc_nCustoFs = TratarNulo(cursor_4c_ProdutosOrigem.CustoFs, 0)

                    DO CASE
                    CASE THIS.this_nTipo = 1
                        loc_nValAtu = cursor_4c_ProdutosOrigem.PVens + ((cursor_4c_ProdutosOrigem.PVens * THIS.this_nVariacao) / 100)
                    CASE THIS.this_nTipo = 2
                        loc_nValAtu = THIS.CalcPreco(THIS.this_nMarkUp2, "cursor_4c_ProdutosOrigem")
                    CASE THIS.this_nTipo = 3
                        loc_nCotId  = THIS.ObterCotacaoResolvida(cursor_4c_ProdutosOrigem.Moedas)
                        loc_nCotVd  = THIS.ObterCotacaoResolvida(cursor_4c_ProdutosOrigem.Moevs)
                        loc_nPven   = cursor_4c_ProdutosOrigem.PVideals * loc_nCotId / loc_nCotVd
                        loc_nValAtu = loc_nPven / IIF(cursor_4c_ProdutosOrigem.Encargos <> 0, cursor_4c_ProdutosOrigem.Encargos, 1)
                    ENDCASE

                    INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAnt, ValAtu, fCustos, MoePcs, CustoFs, Manual) ;
                        VALUES (1, cursor_4c_ProdutosOrigem.CPros, cursor_4c_ProdutosOrigem.DPros, cursor_4c_ProdutosOrigem.PVens, ;
                            loc_nValAtu, loc_nFCustos, loc_cMoePcs, loc_nCustoFs, 0)

                    SELECT cursor_4c_ProdutosOrigem
                ENDSCAN
                USE IN cursor_4c_ProdutosOrigem
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Produtos
                GO TOP
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de uma linha de SigPrPmi
    * (identificada por cidchaves) para as propriedades this_ do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cIdChaves   = TratarNulo(cidchaves, "")
        THIS.this_cCpros      = TratarNulo(cpros, "")
        THIS.this_cPecas      = TratarNulo(pecas, "")
        THIS.this_cPromo      = TratarNulo(promos, "")
        THIS.this_nCBars      = TratarNulo(cbars, 0)
        THIS.this_dDatas      = TratarNulo(datas, {})
        THIS.this_cPromoPro   = TratarNulo(promopro, "")
        THIS.this_dDtAlts     = TratarNulo(dtalts, {})
        THIS.this_nVendavels  = TratarNulo(vendavels, 0)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro "corrente" para auditoria. Ao
    * longo de Atualizar(), this_cTabela/this_cIdChaves sao reposicionados a
    * cada gravacao bem sucedida (SigCdPro por cpros, SigPrPmi por cidchaves),
    * de forma que RegistrarAuditoria() sempre registre a linha certa.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Inserir - Vincula um produto a uma promocao em SigPrPmi (bloco final do
    * Atualiza.Click legado: "If !Empty(lcPromo) / Select TmpPromI / If Eof() /
    * Insert Into CrSigPrPmi ..."). Chamado internamente por Atualizar() para
    * cada produto processado, quando ainda nao existe vinculo com a promocao
    * informada. this_cCpros/this_cPromo DEVEM estar preenchidos antes da
    * chamada; this_cIdChaves, se vazio, e gerado aqui.
    *
    * cbars/pecas/vendavels nao tem equivalente no formulario legado (o
    * Insert do legado tambem nao os cita) - gravados com os defaults do
    * cursor buffer original (0/"").
    *
    * promopro (char 35) e o proprio legado monta com lcPromo (25) + CPros
    * (14) = ate 39 chars, mais largo que a coluna - LEFT() para nao estourar
    * "String or binary data would be truncated" (regra #19).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCpros)) OR EMPTY(ALLTRIM(THIS.this_cPromo))
            THIS.this_cMensagemErro = "Produto ou Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informados."
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cIdChaves = fUniqueIds()
        ENDIF
        THIS.this_cPromoPro = LEFT(ALLTRIM(THIS.this_cPromo) + ALLTRIM(THIS.this_cCpros), 35)

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrPmi (cpros, pecas, promos, cbars, datas, cidchaves, dtalts, promopro, vendavels)
                VALUES (
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL("")>>,
                    <<EscaparSQL(THIS.this_cPromo)>>,
                    <<FormatarNumeroSQL(0, 0)>>,
                    GETDATE(),
                    <<EscaparSQL(THIS.this_cIdChaves)>>,
                    GETDATE(),
                    <<EscaparSQL(THIS.this_cPromoPro)>>,
                    <<FormatarNumeroSQL(0, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao vincular produto " + ALLTRIM(THIS.this_cCpros) + ;
                    " " + CHR(224) + " promo" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCambio - Cotacao (Valos) mais recente da moeda na data informada
    * (SigCdCot, filtrando por Cmoes + Datas <= data, a mais recente primeiro).
    * fBuscarCotacao NAO foi portada (regra CLAUDE.md) - substituicao local.
    * Sem cotacao encontrada, devolve 1 (mesmo fallback do legado: nunca
    * zera o preco por falta de cambio).
    *==========================================================================
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_cMoeda, loc_dData, loc_nCotacao, loc_cSQL

        loc_cMoeda   = ALLTRIM(TratarNulo(par_cMoeda, ""))
        loc_dData    = IIF(EMPTY(par_dData), DATE(), ConverterParaData(par_dData))
        loc_nCotacao = 0

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        IF USED("cursor_4c_Cotacao")
            USE IN cursor_4c_Cotacao
        ENDIF
        loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
            " AND datas <= " + FormatarDataSQL(loc_dData) + " ORDER BY datas DESC"
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cotacao")

        IF USED("cursor_4c_Cotacao") AND !EOF("cursor_4c_Cotacao")
            loc_nCotacao = TratarNulo(cursor_4c_Cotacao.valos, 0)
        ENDIF
        IF USED("cursor_4c_Cotacao")
            USE IN cursor_4c_Cotacao
        ENDIF

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *==========================================================================
    * ObterCotacaoResolvida - Transcreve o padrao repetido em calcpreco/
    * calcmargem/calcmarkpa/calcideal do legado:
    *   CursorQuery('SigCdMoe', ..., par_cMoeda) / Go Top
    *   Se MoeQs preenchido, cotacao = CarregarCambio(MoeQs) * QtdeQs (ou 1)
    *   Senao, cotacao = CarregarCambio(par_cMoeda) * 1
    *==========================================================================
    PROTECTED FUNCTION ObterCotacaoResolvida(par_cMoeda)
        LOCAL loc_cMoeda, loc_cMoeQs, loc_nQtdeQs, loc_nCotacao

        loc_cMoeda = ALLTRIM(TratarNulo(par_cMoeda, ""))
        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        IF USED("cursor_4c_MoedaCot")
            USE IN cursor_4c_MoedaCot
        ENDIF
        SQLEXEC(gnConnHandle, "SELECT MoeQs, QtdeQs FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoeda), "cursor_4c_MoedaCot")

        loc_cMoeQs  = loc_cMoeda
        loc_nQtdeQs = 1
        IF USED("cursor_4c_MoedaCot") AND !EOF("cursor_4c_MoedaCot")
            IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_MoedaCot.MoeQs, "")))
                loc_cMoeQs  = ALLTRIM(cursor_4c_MoedaCot.MoeQs)
                loc_nQtdeQs = IIF(TratarNulo(cursor_4c_MoedaCot.QtdeQs, 0) = 0, 1, cursor_4c_MoedaCot.QtdeQs)
            ENDIF
        ENDIF
        IF USED("cursor_4c_MoedaCot")
            USE IN cursor_4c_MoedaCot
        ENDIF

        loc_nCotacao = THIS.CarregarCambio(loc_cMoeQs, DATE()) * loc_nQtdeQs

        RETURN loc_nCotacao
    ENDFUNC

    *==========================================================================
    * CalcPreco - Transcreve o PROCEDURE calcpreco do legado: preco IDEAL para
    * a margem informada, a partir dos dados do produto CORRENTE do cursor
    * par_cAliasProduto (colunas obrigatorias: PCuss, PesoMs, PFtios, MoeCs,
    * MoePCs, MoeVs, MoeCusFs, MFtios, fCustos, Moedas - mesmo subconjunto
    * usado pelo legado via TmpPro).
    *
    * MoeCusto/FatCusto/MoeIdeal seguem o mesmo IIF do legado (campo do form
    * quando preenchido, senao o dado do produto): aqui os campos do form sao
    * this_cMoeCusto/this_nFator/this_cMoedas (propriedades da Fase 1).
    *
    * O legado tambem faz "Replace CustoFs With lnCustof in TmpPro" ao final -
    * OMITIDO aqui de proposito: em Atualiza.Click esse CustoFs recem-calculado
    * e sempre sobrescrito logo em seguida por CsProdutos.CustoFs (valor da
    * grade), tornando o Replace vestigial nesse fluxo (unico ponto do legado
    * que chama CalcPreco fora do preview).
    *==========================================================================
    PROTECTED FUNCTION CalcPreco(par_nMargem, par_cAliasProduto)
        LOCAL loc_cMoeCusto, loc_nFatCusto, loc_cMoeIdeal, loc_nCusto, loc_nFPeso, loc_nFeitio
        LOCAL loc_nMoeC, loc_nMoeP, loc_nMoeV, loc_nMoeCF, loc_nMoedas, loc_nMoeFT
        LOCAL loc_nCustoF, loc_nIdeal

        SELECT (par_cAliasProduto)

        loc_cMoeCusto = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ALLTRIM(TratarNulo(MoePCs, "")), ALLTRIM(THIS.this_cMoeCusto))
        loc_nFatCusto = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoeCusto), THIS.this_nFator, TratarNulo(fCustos, 0))
        loc_cMoeIdeal = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ALLTRIM(TratarNulo(Moedas, "")), ALLTRIM(THIS.this_cMoedas))

        loc_nCusto  = TratarNulo(PCuss, 0)
        loc_nFPeso  = TratarNulo(PesoMs, 0) * loc_nFatCusto
        loc_nFeitio = TratarNulo(PFtios, 0)

        loc_nMoeC   = THIS.ObterCotacaoResolvida(MoeCs)
        loc_nMoeP   = THIS.ObterCotacaoResolvida(loc_cMoeCusto)
        loc_nMoeV   = THIS.ObterCotacaoResolvida(MoeVs)
        loc_nMoeCF  = THIS.ObterCotacaoResolvida(MoeCusFs)
        loc_nMoedas = THIS.ObterCotacaoResolvida(loc_cMoeIdeal)
        loc_nMoeFT  = THIS.ObterCotacaoResolvida(MFtios)

        IF ALLTRIM(TratarNulo(MFtios, "")) != ALLTRIM(TratarNulo(MoeCusFs, ""))
            loc_nFeitio = (loc_nFeitio * loc_nMoeFT) / loc_nMoeCF
        ENDIF

        IF ALLTRIM(TratarNulo(MoeCs, "")) != ALLTRIM(TratarNulo(MoeCusFs, ""))
            loc_nCustoF = (loc_nCusto * loc_nMoeC) / loc_nMoeCF
        ELSE
            loc_nCustoF = loc_nCusto
        ENDIF

        IF THIS.this_nCalcCusts = 2
            IF loc_cMoeCusto != ALLTRIM(TratarNulo(MoeCusFs, ""))
                loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, loc_nFatCusto * loc_nMoeP / loc_nMoeCF)
            ELSE
                loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, loc_nFatCusto)
            ENDIF
        ELSE
            IF loc_cMoeCusto != ALLTRIM(TratarNulo(MoeCusFs, ""))
                loc_nCustoF = loc_nCustoF + (loc_nFPeso * loc_nMoeP / loc_nMoeCF)
            ELSE
                loc_nCustoF = loc_nCustoF + loc_nFPeso
            ENDIF
        ENDIF

        IF ALLTRIM(TratarNulo(MoeCusFs, "")) != loc_cMoeIdeal
            loc_nIdeal = (loc_nCustoF + loc_nFeitio) * loc_nMoeCF / loc_nMoedas * par_nMargem
        ELSE
            loc_nIdeal = (loc_nCustoF + loc_nFeitio) * par_nMargem
        ENDIF

        RETURN loc_nIdeal
    ENDFUNC

    *==========================================================================
    * ProcessarProdutoManual - Transcreve o trecho do LostFocus do
    * Column2.Text1 legado (modo "Produtos"/chkAuditado): dado o codigo de um
    * produto digitado manualmente na grade, calcula o novo preco pelo MESMO
    * criterio de BuscarProdutos (this_nTipo/this_nVariacao/this_nMarkUp2 - o
    * Form chama SincronizarFiltros() antes desta chamada) e grava a linha em
    * cursor_4c_Produtos. PUBLIC porque o Form aciona isto direto do evento
    * de grade (CalcPreco/ObterCotacaoResolvida sao PROTECTED e nao podem ser
    * chamados de fora do BO). Retorno .F. = produto nao encontrado
    * (this_cMensagemErro preenchido).
    *==========================================================================
    PROCEDURE ProcessarProdutoManual(par_cCodigo)
        LOCAL loc_lSucesso, loc_nValAtu, loc_nCotId, loc_nCotVd, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED("cursor_4c_ProdutoManual")
                USE IN cursor_4c_ProdutoManual
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT CPros, DPros, PVens, PVideals, Encargos, Moedas, MoeVs, " + ;
                "PCuss, PesoMs, PFtios, MoeCs, MoePCs, MoeCusFs, MFtios, fCustos, CFtios " + ;
                "FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCodigo), "cursor_4c_ProdutoManual")

            IF USED("cursor_4c_ProdutoManual") AND !EOF("cursor_4c_ProdutoManual")
                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nValAtu = cursor_4c_ProdutoManual.PVens + ((cursor_4c_ProdutoManual.PVens * THIS.this_nVariacao) / 100)
                CASE THIS.this_nTipo = 2
                    loc_nValAtu = THIS.CalcPreco(THIS.this_nMarkUp2, "cursor_4c_ProdutoManual")
                CASE THIS.this_nTipo = 3
                    loc_nCotId  = THIS.ObterCotacaoResolvida(cursor_4c_ProdutoManual.Moedas)
                    loc_nCotVd  = THIS.ObterCotacaoResolvida(cursor_4c_ProdutoManual.MoeVs)
                    loc_nValAtu = (cursor_4c_ProdutoManual.PVideals * loc_nCotId / loc_nCotVd) / ;
                        IIF(cursor_4c_ProdutoManual.Encargos <> 0, cursor_4c_ProdutoManual.Encargos, 1)
                ENDCASE

                IF USED(THIS.this_cCursorItens)
                    SELECT (THIS.this_cCursorItens)
                    REPLACE lMarca WITH 1, ;
                            CPros  WITH cursor_4c_ProdutoManual.CPros, ;
                            DPros  WITH cursor_4c_ProdutoManual.DPros, ;
                            ValAnt WITH cursor_4c_ProdutoManual.PVens, ;
                            ValAtu WITH loc_nValAtu IN (THIS.this_cCursorItens)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado" + CHR(33) + CHR(33) + CHR(33)
            ENDIF

            IF USED("cursor_4c_ProdutoManual")
                USE IN cursor_4c_ProdutoManual
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarHistoricoComposicao - Copia, para SigPrCp2 (historico), TODAS as
    * linhas de composicao vigentes do produto em SigPrCpo (equivalente a
    * "SqlExecute(Select * From SigPrCpo Where CPros=...) / Scan / Scatter /
    * Insert Into CrSigPrCp2 From MemVar" do legado). cidchaves E GERADO DE
    * NOVO para cada linha - reaproveitar o cidchaves de origem colidiria com
    * a PK de SigPrCp2 caso o mesmo produto seja reajustado mais de uma vez
    * (SigPrCpo.cidchaves nao muda entre reajustes).
    *==========================================================================
    PROTECTED FUNCTION GravarHistoricoComposicao(par_cCpros)
        LOCAL loc_lOk, loc_cSQL, loc_cIdOrigem, loc_cIdNovo, loc_cHora
        loc_lOk = .T.

        IF USED("cursor_4c_ComposicaoAtual")
            USE IN cursor_4c_ComposicaoAtual
        ENDIF
        SQLEXEC(gnConnHandle, "SELECT cidchaves FROM SigPrCpo WHERE cpros = " + EscaparSQL(par_cCpros), "cursor_4c_ComposicaoAtual")

        IF USED("cursor_4c_ComposicaoAtual")
            loc_cHora = SUBSTR(TTOC(DATETIME()), 10, 8)
            SELECT cursor_4c_ComposicaoAtual
            SCAN
                loc_cIdOrigem = cursor_4c_ComposicaoAtual.cidchaves
                loc_cIdNovo   = fUniqueIds()

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigPrCp2 (
                        cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds,
                        obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs,
                        dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz,
                        obsofs,
                        cidchaves, dataalts, horaalts, usuaalts
                    )
                    SELECT
                        cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds,
                        obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs,
                        dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz,
                        obsofs,
                        <<EscaparSQL(loc_cIdNovo)>>, GETDATE(), <<EscaparSQL(loc_cHora)>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>
                    FROM SigPrCpo WHERE cidchaves = <<EscaparSQL(loc_cIdOrigem)>>
                ENDTEXT

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + "rico de composi" + CHR(231) + CHR(227) + ;
                        "o (SigPrCp2):" + CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                    EXIT
                ENDIF

                SELECT cursor_4c_ComposicaoAtual
            ENDSCAN
            USE IN cursor_4c_ComposicaoAtual
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * Atualizar - Confirma a atualizacao de precos (Atualiza.Click do legado).
    * Para cada produto marcado (lMarca=1) em cursor_4c_Produtos:
    *   1) Le a linha CORRENTE de SigCdPro (equivalente ao Seek+Scatter TmpPro)
    *   2) Grava snapshot em SigCdPrc (historico) com os valores ANTIGOS
    *   3) Recalcula PVens/PCuss/CustoFs/Margems/PVIdeals/fCustos/Moepcs
    *      conforme this_nTipo (1=Variacao, 2=MarkUp/CalcPreco, 3=Cambio),
    *      respeitando o override manual da grade (Manual=1 -> usa ValAtu)
    *   4) Recalcula MarkupA (Calcmarkpa) com os valores NOVOS
    *   5) UPDATE SigCdPro com os campos alterados + overrides de moeda/feitio
    *   6) Copia a composicao vigente (SigPrCpo) para o historico (SigPrCp2)
    *   7) Remove vinculo de portal/etiqueta anterior (SigPrPrt)
    *   8) Se this_lLimparPromos, remove promocoes anteriores (SigPrPmi)
    *   9) Vincula a nova promocao (this_cPromo), se informada e ainda nao
    *      vinculada a este produto (via Inserir())
    * Tudo dentro de uma unica transacao manual (SQLCOMMIT/SQLROLLBACK) -
    * qualquer falha em qualquer produto desfaz TODO o lote, igual ao legado
    * (ThisForm.poDataMgr.Commit()/RollBack() unico para o lote inteiro).
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lOk, loc_cSQL, loc_oErro, loc_nQtdeProcessados
        LOCAL loc_cCproAtual, loc_cIdChavesHistorico, loc_cHoraAtual, loc_cOrigem
        LOCAL loc_nPVensNovo, loc_nPCussNovo, loc_nCustoFsNovo, loc_nMargemNovo, loc_nPVIdealsNovo
        LOCAL loc_nFCustosNovo, loc_cMoePcsNovo, loc_nCotIdeal, loc_nCotVenda, loc_nPVenCambio
        LOCAL loc_cMoeCsNovo, loc_cMoeCusFsNovo, loc_cMoedasNovo, loc_cCFtiosNovo, loc_cMoeVsNovo
        LOCAL loc_nMarkupA

        loc_lSucesso = .F.
        loc_lOk      = .T.
        loc_nQtdeProcessados = 0
        THIS.this_cMensagemErro = ""

        IF !USED(THIS.this_cCursorItens) OR RECCOUNT(THIS.this_cCursorItens) = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " produtos processados."
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        LOCATE FOR lMarca = 1
        IF !FOUND()
            THIS.this_cMensagemErro = "Nenhum Produto Selecionado" + CHR(33) + CHR(33) + CHR(33)
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Produtos
            SCAN FOR lMarca = 1

                loc_cCproAtual = ALLTRIM(cursor_4c_Produtos.CPros)

                *-- 1) Carrega a linha ATUAL de SigCdPro (equivalente ao Seek+Scatter TmpPro)
                IF USED("cursor_4c_ProdutoAtual")
                    USE IN cursor_4c_ProdutoAtual
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cpros, pcuss, pesoms, pftios, moecs, moepcs, moevs, moecusfs, mftios, " + ;
                    "fcustos, moedas, cftios, pvens, pvideals, encargos, margems " + ;
                    "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCproAtual), "cursor_4c_ProdutoAtual")

                IF !USED("cursor_4c_ProdutoAtual") OR EOF("cursor_4c_ProdutoAtual")
                    THIS.this_cMensagemErro = "Produto " + loc_cCproAtual + " n" + CHR(227) + "o encontrado."
                    loc_lOk = .F.
                    EXIT
                ENDIF

                *-- 2) Snapshot de historico (SigCdPrc) com os valores ANTIGOS, ANTES do recalculo
                loc_cIdChavesHistorico = fUniqueIds()
                loc_cHoraAtual = SUBSTR(TTOC(DATETIME()), 10, 8)
                loc_cOrigem    = LEFT(TTOC(DATETIME()) + " SIGALTPC", 30)

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdPrc (
                        matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs,
                        cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas,
                        icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs,
                        moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins,
                        reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus,
                        metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs,
                        digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs,
                        tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs,
                        obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts,
                        cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents,
                        codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos,
                        idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, contaccus, gruccus, dtsituas,
                        conjunts,
                        cidchaves, dataalts, horaalts, usuaalts, origem,
                        codcpds, cbms, caracts, cunifors, custocvs, ltmins, markcvs, pesomts, pidealcvs, qtdias,
                        retiras, codccnjs, montagens, tmontas, codconc
                    )
                    SELECT
                        matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs,
                        cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas,
                        icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs,
                        moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins,
                        reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus,
                        metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs,
                        digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs,
                        tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs,
                        obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts,
                        cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents,
                        codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos,
                        idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, contaccus, gruccus, dtsituas,
                        conjunts,
                        <<EscaparSQL(loc_cIdChavesHistorico)>>, GETDATE(), <<EscaparSQL(loc_cHoraAtual)>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>, <<EscaparSQL(loc_cOrigem)>>,
                        <<EscaparSQL("")>>, <<FormatarNumeroSQL(0, 6)>>, <<EscaparSQL("")>>, <<EscaparSQL("")>>, <<FormatarNumeroSQL(0, 3)>>, <<FormatarNumeroSQL(0, 3)>>, <<FormatarNumeroSQL(0, 6)>>, <<FormatarNumeroSQL(0, 3)>>, <<FormatarNumeroSQL(0, 2)>>, <<FormatarNumeroSQL(0, 0)>>,
                        <<FormatarNumeroSQL(0, 0)>>, <<EscaparSQL("")>>, <<FormatarNumeroSQL(0, 0)>>, <<EscaparSQL("")>>, <<EscaparSQL("")>>
                    FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCproAtual)>>
                ENDTEXT

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + "rico de pre" + CHR(231) + "o (SigCdPrc):" + ;
                        CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                    EXIT
                ENDIF

                *-- 3) Recalcula o novo preco conforme o tipo de reajuste - cada variavel
                *--    parte do valor ATUAL (sem alteracao) e so o Do Case sobrescreve
                loc_nPVensNovo    = cursor_4c_ProdutoAtual.pvens
                loc_nPCussNovo    = cursor_4c_ProdutoAtual.pcuss
                loc_nCustoFsNovo  = cursor_4c_ProdutoAtual.custofs
                loc_nMargemNovo   = cursor_4c_ProdutoAtual.margems
                loc_nPVIdealsNovo = cursor_4c_ProdutoAtual.pvideals
                loc_nFCustosNovo  = cursor_4c_ProdutoAtual.fcustos
                loc_cMoePcsNovo   = ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moepcs, ""))

                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nPVensNovo = cursor_4c_ProdutoAtual.pvens + ((cursor_4c_ProdutoAtual.pvens * THIS.this_nVariacao) / 100)
                    IF THIS.this_lIncCusts
                        loc_nPCussNovo   = cursor_4c_ProdutoAtual.pcuss + ((cursor_4c_ProdutoAtual.pcuss * THIS.this_nVariacao) / 100)
                        loc_nCustoFsNovo = cursor_4c_ProdutoAtual.custofs + ((cursor_4c_ProdutoAtual.custofs * THIS.this_nVariacao) / 100)
                    ENDIF
                CASE THIS.this_nTipo = 2
                    loc_nMargemNovo   = THIS.this_nMarkUp2
                    loc_nPVIdealsNovo = THIS.CalcPreco(loc_nMargemNovo, "cursor_4c_ProdutoAtual")
                    loc_nPVensNovo    = loc_nPVIdealsNovo
                    loc_nFCustosNovo  = TratarNulo(cursor_4c_Produtos.fCustos, 0)
                    loc_cMoePcsNovo   = ALLTRIM(TratarNulo(cursor_4c_Produtos.MoePcs, ""))
                    loc_nCustoFsNovo  = TratarNulo(cursor_4c_Produtos.CustoFs, 0)
                CASE THIS.this_nTipo = 3
                    loc_nCotIdeal   = THIS.ObterCotacaoResolvida(cursor_4c_ProdutoAtual.moedas)
                    loc_nCotVenda   = THIS.ObterCotacaoResolvida(cursor_4c_ProdutoAtual.moevs)
                    loc_nPVenCambio = cursor_4c_ProdutoAtual.pvideals * loc_nCotIdeal / loc_nCotVenda
                    loc_nPVensNovo  = loc_nPVenCambio / IIF(cursor_4c_ProdutoAtual.encargos <> 0, cursor_4c_ProdutoAtual.encargos, 1)
                ENDCASE

                *-- Valor Atual informado manualmente na grade prevalece sobre o calculo
                IF TratarNulo(cursor_4c_Produtos.Manual, 0) = 1
                    loc_nPVensNovo = cursor_4c_Produtos.ValAtu
                ENDIF

                *-- Overrides de moeda/feitio de gravacao (campos vazios preservam o atual)
                loc_cMoeCsNovo    = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCs)),    ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moecs, "")),    ALLTRIM(THIS.this_cMoeCs))
                loc_cMoeCusFsNovo = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusFs)), ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moecusfs, "")), ALLTRIM(THIS.this_cMoeCusFs))
                loc_cMoedasNovo   = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)),   ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moedas, "")),   ALLTRIM(THIS.this_cMoedas))
                loc_cCFtiosNovo   = IIF(EMPTY(ALLTRIM(THIS.this_cCFtios)),   ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.cftios, "")),   ALLTRIM(THIS.this_cCFtios))
                loc_cMoeVsNovo    = IIF(EMPTY(ALLTRIM(THIS.this_cMoeVs)),    ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moevs, "")),    ALLTRIM(THIS.this_cMoeVs))

                *-- 4) Recalcula o MarkUp Aplicado (Calcmarkpa) com os valores NOVOS
                loc_nCotIdeal = THIS.ObterCotacaoResolvida(loc_cMoeVsNovo)
                loc_nCotVenda = THIS.ObterCotacaoResolvida(loc_cMoeCusFsNovo)
                loc_nMarkupA  = IIF(loc_nCustoFsNovo = 0, 0, ROUND((loc_nPVensNovo * loc_nCotIdeal) / (loc_nCustoFsNovo * loc_nCotVenda), 3))

                *-- 5) Grava o novo preco em SigCdPro
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    UPDATE SigCdPro SET
                        pvens    = <<FormatarNumeroSQL(loc_nPVensNovo, 5)>>,
                        pcuss    = <<FormatarNumeroSQL(loc_nPCussNovo, 5)>>,
                        custofs  = <<FormatarNumeroSQL(loc_nCustoFsNovo, 3)>>,
                        margems  = <<FormatarNumeroSQL(loc_nMargemNovo, 6)>>,
                        pvideals = <<FormatarNumeroSQL(loc_nPVIdealsNovo, 5)>>,
                        fcustos  = <<FormatarNumeroSQL(loc_nFCustosNovo, 5)>>,
                        moepcs   = <<EscaparSQL(loc_cMoePcsNovo)>>,
                        impetiqs = <<FormatarNumeroSQL(IIF(THIS.this_lImprimirEtiquetas, 1, 0), 0)>>,
                        moecs    = <<EscaparSQL(loc_cMoeCsNovo)>>,
                        moecusfs = <<EscaparSQL(loc_cMoeCusFsNovo)>>,
                        moedas   = <<EscaparSQL(loc_cMoedasNovo)>>,
                        cftios   = <<EscaparSQL(loc_cCFtiosNovo)>>,
                        moevs    = <<EscaparSQL(loc_cMoeVsNovo)>>,
                        markupa  = <<FormatarNumeroSQL(loc_nMarkupA, 3)>>
                    WHERE cpros = <<EscaparSQL(loc_cCproAtual)>>
                ENDTEXT

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar pre" + CHR(231) + "o do produto " + loc_cCproAtual + ;
                        ":" + CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                    EXIT
                ENDIF

                THIS.this_cTabela   = "SigCdPro"
                THIS.this_cIdChaves = loc_cCproAtual
                THIS.RegistrarAuditoria("ATUALIZAR")
                THIS.this_cTabela   = "SigPrPmi"

                *-- 6) Historico de composicao (SigPrCp2), copiado de SigPrCpo
                IF !THIS.GravarHistoricoComposicao(loc_cCproAtual)
                    loc_lOk = .F.
                    EXIT
                ENDIF

                *-- 7) Remove vinculo de portal/etiqueta anterior (SigPrPrt)
                IF SQLEXEC(gnConnHandle, "DELETE FROM SigPrPrt WHERE cpros = " + EscaparSQL(loc_cCproAtual)) < 0
                    THIS.this_cMensagemErro = "Falha ao limpar SigPrPrt do produto " + loc_cCproAtual + ":" + ;
                        CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                    EXIT
                ENDIF

                *-- 8) Limpa promocoes anteriores, se solicitado
                IF THIS.this_lLimparPromos
                    IF SQLEXEC(gnConnHandle, "DELETE FROM SigPrPmi WHERE cpros = " + EscaparSQL(loc_cCproAtual)) < 0
                        THIS.this_cMensagemErro = "Falha ao limpar promo" + CHR(231) + CHR(245) + "es do produto " + ;
                            loc_cCproAtual + ":" + CHR(13) + CapturarErroSQL()
                        loc_lOk = .F.
                        EXIT
                    ENDIF
                ENDIF

                *-- 9) Vincula a nova promocao, se informada e ainda nao vinculada a este produto
                IF !EMPTY(ALLTRIM(THIS.this_cPromo))
                    IF USED("cursor_4c_PmiExiste")
                        USE IN cursor_4c_PmiExiste
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT cidchaves FROM SigPrPmi WHERE cpros = " + EscaparSQL(loc_cCproAtual) + ;
                        " AND promos = " + EscaparSQL(THIS.this_cPromo), "cursor_4c_PmiExiste")

                    IF USED("cursor_4c_PmiExiste") AND EOF("cursor_4c_PmiExiste")
                        THIS.this_cCpros    = loc_cCproAtual
                        THIS.this_cIdChaves = ""
                        IF !THIS.Inserir()
                            loc_lOk = .F.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_PmiExiste")
                        USE IN cursor_4c_PmiExiste
                    ENDIF
                    IF !loc_lOk
                        EXIT
                    ENDIF
                ENDIF

                loc_nQtdeProcessados = loc_nQtdeProcessados + 1
                SELECT cursor_4c_Produtos
            ENDSCAN

            IF USED("cursor_4c_ProdutoAtual")
                USE IN cursor_4c_ProdutoAtual
            ENDIF

            IF loc_lOk AND loc_nQtdeProcessados > 0
                SQLCOMMIT(gnConnHandle)
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Nenhum produto foi atualizado."
                ENDIF
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF
        IF USED("cursor_4c_SigCdPac")
            USE IN cursor_4c_SigCdPac
        ENDIF
        IF USED("cursor_4c_Cotacao")
            USE IN cursor_4c_Cotacao
        ENDIF
        IF USED("cursor_4c_MoedaCot")
            USE IN cursor_4c_MoedaCot
        ENDIF
        IF USED("cursor_4c_ProdutoAtual")
            USE IN cursor_4c_ProdutoAtual
        ENDIF
        IF USED("cursor_4c_ProdutoManual")
            USE IN cursor_4c_ProdutoManual
        ENDIF
        IF USED("cursor_4c_ComposicaoAtual")
            USE IN cursor_4c_ComposicaoAtual
        ENDIF
        IF USED("cursor_4c_PmiExiste")
            USE IN cursor_4c_PmiExiste
        ENDIF
        IF USED("cursor_4c_ProdutosOrigem")
            USE IN cursor_4c_ProdutosOrigem
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
