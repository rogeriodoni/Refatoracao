*====================================================================
* SigOpPckBO.prg
*
* Business Object do form OPERACIONAL "SigOpPck" (Atendimento Picking).
* Tela de CONSULTA/PROCESSAMENTO: o usuario escolhe um periodo (Data
* Inicial/Final), uma Empresa e um criterio de Tipo de Operacao
* (grade de Tipos de Operacao OU campo de Movimentacao avulso,
* dependendo do acesso do usuario - ver this_lAcessoPorTipo), alem de
* filtrar por Grande Grupo/Grupo de Produto. O botao Consultar
* processa os movimentos encontrados e monta a grade de resultado
* (legado: crPgRes01), que alimenta visualizacao em tela, impressao
* (REPORT FORM SigOpPck) e exportacao para Excel.
*
* Nao ha uma unica tabela/entidade CRUD por tras deste form - por isso
* this_cTabela/this_cCampoChave ficam vazios (mesmo padrao adotado em
* sigoppedBO.prg, outro dialogo OPERACIONAL sem tabela propria). A
* grade de resultado e cursor puro (cursor_4c_Dados), montada por
* processamento proprio (SQL + regras de negocio) em fase posterior -
* nao existe mapeamento 1-para-1 de coluna para property de BO.
*
* Referencias legado -> BO (filtros da pagina Pagina.pgFiltros):
*   getDcI.Value / getDcF.Value         -> this_dDataIni / this_dDataFim
*   getEmpOs.Value (SigCdEmp.Cemps)     -> this_cEmpresa
*   getDEmpOs.Value (SigCdEmp.Razas)    -> this_cDescEmpresa
*   getOperacao.Value (SigCdOpe.Dopes)  -> this_cOperacao
*   fChecaAcesso('SIGOPPCK','CONPORTIPO') -> this_lAcessoPorTipo
*   getCfgGrade.Value (layout salvo da grade, so visivel p/ 4CONTROL)
*                                        -> this_cCfgGrade
*   Thisform.Caption                    -> this_cCaption
*   crTpOpe (grade de Tipos de Operacao, SigCdTom)    -> this_cCursorTipos
*   crGrdGpr (grade de Grande Grupo, SigCdGpr)        -> this_cCursorGrdGpr
*   crGrdGru (grade de Grupo de Produto, SigCdGrp)    -> this_cCursorGrdGru
*   crSigCdGre (grupos de acesso do usuario via SigCdEmp/SigCdGre)
*                                                      -> this_cCursorGre
*   crPgRes01 (grade de resultado - Detalhamento dos Produtos)
*                                                      -> this_cCursorDados
*
* Fase 1/8 - propriedades e Init() basico (data atual como default do
* periodo, tabela/campo chave vazios). As leituras de SigCdEmp (Valid
* de getEmpOs/getDEmpOs), fChecaAcesso('SIGOPPCK','CONPORTIPO') e o
* preenchimento das grades de Tipos de Operacao/Grande Grupo/Grupo
* ficam para fase posterior - os valores abaixo permanecem no default
* ate la.
*
* Fase 7 - CarregarFiltros() (SigCdEmp/SigCdTom/SigCdGpr/
* SigCdGrp/SigCdGre, equivalentes aos AddCursor/fExecCmds do Init
* legado) e Processar() (monta cursor_4c_Dados a partir dos movimentos
* do periodo/empresa/operacao filtrados, replicando crCursor1 ->
* crPgRes01 do legado, incluindo cotacao de moeda e totalizadores).
*
* Fase 8 - persistencia do layout da grade de resultado por usuario
* (CarregarCfgGrade/GravarCfgGrade em SigSyPar, substituindo o objeto
* poSigSyPar/fGravaUserXML do Framework legado, que NAO foi portado) e
* a barra de progresso do processamento (fwProgressBar, legado oProg1
* com os 3 passos ATIVOS de 6 - os outros 3 estao comentados no
* legado).
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpPckBO AS BusinessBase

    *-- Filtro de periodo (Pagina.pgFiltros.getDcI/getDcF) - legado
    *-- inicializa os dois com Date() no Init do form
    this_dDataIni = {}          && Data Inicial do filtro de movimentacao
    this_dDataFim = {}          && Data Final do filtro de movimentacao

    *-- Filtro de empresa (Pagina.pgFiltros.getEmpOs/getDEmpOs), resolvido
    *-- via fAcessoEmpresa/SigCdEmp - populado em fase posterior; default
    *-- abaixo (preenchido pelo Form a partir de go_4c_Sistema.cCodEmpresa)
    this_cEmpresa = ""           && SigCdEmp.Cemps - codigo da empresa do filtro
    this_cDescEmpresa = ""       && SigCdEmp.Razas - razao social da empresa do filtro

    *-- Filtro de operacao/movimentacao (Pagina.pgFiltros.getOperacao) -
    *-- digitado direto quando o usuario NAO tem acesso a "CONPORTIPO"
    *-- (a grade de Tipos de Operacao fica oculta e este campo aparece no
    *-- lugar dela - ver this_lAcessoPorTipo)
    this_cOperacao = ""          && SigCdOpe.Dopes digitado direto (getOperacao.Value)

    *-- Controla qual UI de filtro de Tipo de Operacao e exibida (legado:
    *-- fChecaAcesso('SIGOPPCK','CONPORTIPO') And Usuar <> '4CONTROL').
    *-- .T. = grade de Tipos de Operacao (grdTipo) + botoes Marcar/
    *-- Desmarcar Tudo visiveis, campo de Movimentacao oculto;
    *-- .F. = campo de Movimentacao avulso visivel, grade/botoes ocultos.
    *-- Calculado em fase posterior via ChecaAcesso (sigacess.PRG);
    *-- default .F. (modo restrito, so com o campo avulso) ate la.
    this_lAcessoPorTipo = .F.

    *-- Layout salvo da grade de resultado (Pagina.pgFiltros.getCfgGrade),
    *-- so visivel para o usuario 4CONTROL (legado: poSigSyPar.mLerCfg()/
    *-- MontaGrade - persistencia de largura/visibilidade de coluna por
    *-- usuario). Populado/gravado em fase posterior; default vazio.
    this_cCfgGrade = ""

    *-- Nomes dos cursores que este BO popula/consome (constantes, para o
    *-- Form referenciar sem repetir literais - equivalentes aos aliases
    *-- globais do legado crPgRes01/crTpOpe/crGrdGpr/crGrdGru/crSigCdGre)
    this_cCursorDados = "cursor_4c_Dados"        && crPgRes01 - grade de resultado (Detalhamento dos Produtos)
    this_cCursorTipos = "cursor_4c_Tipos"        && crTpOpe - grade de Tipos de Operacao (SigCdTom)
    this_cCursorGrdGpr = "cursor_4c_GrdGpr"      && crGrdGpr - grade de Grande Grupo (SigCdGpr)
    this_cCursorGrdGru = "cursor_4c_GrdGru"      && crGrdGru - grade de Grupo de Produto (SigCdGrp)
    this_cCursorGre = "cursor_4c_Gre"            && crSigCdGre - grupos de acesso do usuario (SigCdEmp/SigCdGre)

    *-- Titulo montado para a tela (legado: Thisform.Caption, usado na
    *-- faixa do cabecalho - lblSombra/lblTitulo)
    this_cCaption = "Atendimento Picking"

    *--------------------------------------------------------------------------
    * Propriedades da LINHA CORRENTE da grade de resultado (this_cCursorDados,
    * equivalente a crPgRes01 do legado - "Detalhamento dos Produtos"). Uma
    * propriedade para CADA coluna do CREATE CURSOR legado (SigOpPck_form_
    * codigo_fonte.txt:2761-2770), na mesma ordem, com prefixo "this_cRes"/
    * "this_nRes"/"this_dRes" para nao colidir com as propriedades de FILTRO
    * acima (this_cEmpresa/this_cOperacao sao o filtro escolhido pelo usuario;
    * this_cResEmpresa/this_cResOperacao sao os valores da LINHA exibida).
    *--------------------------------------------------------------------------
    this_cResOrdem           = ""   && Ordem c(1) - A/B/C, define o indice/ordenacao da grade
    this_nResFiltro          = 0    && Filtro n(1) - 1=Vendido no periodo, 2=Diferenca, 3=outros
    this_cResEmpresa         = ""   && Empresa c(3)
    this_cResMovimentacao    = ""   && Movimentacao c(20) - SigCdOpe.Dopes do movimento
    this_nResNumero          = 0    && Numero n(6) - numero do movimento
    this_dResDataVenda       = {}   && Data_Venda d(8)
    this_cResCodVendedora    = ""   && Codigo_Vendedora c(10)
    this_nResItem            = 0    && Item n(10) - numero do item dentro do movimento
    this_cResCodigoItem      = ""   && Codigo_Item c(14) - codigo de barras/produto
    this_cResDescItem        = ""   && Desc_Item c(40)
    this_cResObsItem         = ""   && Obs_Item m(4) - memo
    this_nResQuantidade      = 0    && Quantidade n(16,2)
    this_nResValUnitario     = 0    && Val_Unitario n(16,2)
    this_nResTotal           = 0    && Total n(16,2)
    this_nResTotalGeral      = 0    && Total_Geral n(16,2)
    this_cResMoeda           = ""   && Moeda c(3)
    this_cResOperacao        = ""   && Operacao c(1)
    this_nResBarras          = 0    && Barras n(14)
    this_cResGdeGrupo        = ""   && Gde_Grupo c(3) - SigCdGpr.codigos
    this_cResGrupo           = ""   && Grupo c(3) - SigCdGrp.cgrus
    this_cResSubGrupo        = ""   && SubGrupo c(60)
    this_nResCustoCadastro   = 0    && Custo_Cadastro n(16,2)
    this_cResMoeCusCadastro  = ""   && Moe_Cus_Cadastro c(3)
    this_nResMarkup          = 0    && Markup n(16,2)
    this_nResVendaCadastro   = 0    && Venda_Cadastro n(16,2)
    this_cResMoeVdaCadastro  = ""   && Moe_Vda_Cadastro c(3)
    this_cResImagem          = ""   && Imagem m(4) - memo (base64 da foto do produto)
    this_cResTamanho         = ""   && Tamanho c(4)
    this_cResCor             = ""   && Cor c(4)
    this_cResCodCliente      = ""   && Cod_Cliente c(10)
    this_cResNomeCliente     = ""   && Nome_Cliente c(50)
    this_cResCodFornecedor   = ""   && Cod_Fornecedor c(10)
    this_cResNomeFornecedor  = ""   && Nome_Fornecedor c(50)
    this_nResTktMedio        = 0    && Tkt_Medio n(16,2)
    this_cResRefFornecedor   = ""   && Ref_Fornecedor c(20)
    this_nResValorDiferenca  = 0    && Valor_Diferenca n(16,2)
    this_nResPercDiferenca   = 0    && Perc_Diferenca n(16,2)
    this_cResPctDifChr       = ""   && Pct_Dif_Chr c(20) - percentual formatado para exibicao
    this_nResParcelas        = 0    && Parcelas n(3)
    this_cResCondPagto       = ""   && Cond_Pagto c(100)
    this_nResVendaCadastroR  = 0    && Venda_CadastroR n(16,2)
    this_nResDescAcres       = 0    && Desc_Acres n(16,2)
    this_cResCpfCli          = ""   && CpfCli c(20)
    this_cResPedidoWeb       = ""   && Pedidoweb c(20)
    this_cResPStatus         = ""   && pStatus c(1)
    this_nResDias            = 0    && Dias n(5,0)
    this_cResDescritivo      = ""   && Descritivo c(45)
    this_cResLocal           = ""   && Local c(10)
    this_nResQtde            = 0    && Qtde n(12,0)
    this_cResColecao         = ""   && Colecao c(60)
    this_cResDestino         = ""   && Destino c(3)
    this_cResContaOrigem     = ""   && ContaOrigem c(10)

    *====================================================================
    * Init - Configura tabela/campo chave (form sem entidade propria) e
    * os defaults do filtro de periodo (legado: getDcI.Value = Date() /
    * getDcF.Value = Date(), no Init do form).
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                *-- Form de consulta/processamento - nao edita um unico
                *-- registro de tabela (ver cabecalho do arquivo)
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = ""

                THIS.this_dDataIni = DATE()
                THIS.this_dDataFim = DATE()

                *-- Zera as propriedades da linha corrente (ver CarregarDoCursor)
                *-- para que reusar a mesma instancia numa segunda abertura do
                *-- form nunca exiba os dados da linha vista anteriormente.
                THIS.LimparPropriedadesResultado()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Copia os campos da linha CORRENTE de this_cCursorDados
    * (cursor_4c_Dados, equivalente a crPgRes01 - "Detalhamento dos Produtos")
    * para as propriedades this_Res* desta classe. No legado, os controles da
    * aba de detalhe (getObsItn/getBusca/ImgFigJpg) tinham ControlSource direto
    * em crPgRes01 e se atualizavam sozinhos ao mudar de linha na grade; o
    * migrado nao liga controle a cursor, entao o Form chama este metodo
    * (tipicamente no AfterRowColChange do grid) para espelhar a linha
    * corrente.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorDados)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            THIS.LimparPropriedadesResultado()
            RETURN .F.
        ENDIF

        THIS.this_cResOrdem          = TratarNulo(EVALUATE(loc_cAlias + ".Ordem"), "")
        THIS.this_nResFiltro         = TratarNulo(EVALUATE(loc_cAlias + ".Filtro"), 0)
        THIS.this_cResEmpresa        = TratarNulo(EVALUATE(loc_cAlias + ".Empresa"), "")
        THIS.this_cResMovimentacao   = TratarNulo(EVALUATE(loc_cAlias + ".Movimentacao"), "")
        THIS.this_nResNumero         = TratarNulo(EVALUATE(loc_cAlias + ".Numero"), 0)
        THIS.this_dResDataVenda      = ConverterParaData(EVALUATE(loc_cAlias + ".Data_Venda"))
        THIS.this_cResCodVendedora   = TratarNulo(EVALUATE(loc_cAlias + ".Codigo_Vendedora"), "")
        THIS.this_nResItem           = TratarNulo(EVALUATE(loc_cAlias + ".Item"), 0)
        THIS.this_cResCodigoItem     = TratarNulo(EVALUATE(loc_cAlias + ".Codigo_Item"), "")
        THIS.this_cResDescItem       = TratarNulo(EVALUATE(loc_cAlias + ".Desc_Item"), "")
        THIS.this_cResObsItem        = TratarNulo(EVALUATE(loc_cAlias + ".Obs_Item"), "")
        THIS.this_nResQuantidade     = TratarNulo(EVALUATE(loc_cAlias + ".Quantidade"), 0)
        THIS.this_nResValUnitario    = TratarNulo(EVALUATE(loc_cAlias + ".Val_Unitario"), 0)
        THIS.this_nResTotal          = TratarNulo(EVALUATE(loc_cAlias + ".Total"), 0)
        THIS.this_nResTotalGeral     = TratarNulo(EVALUATE(loc_cAlias + ".Total_Geral"), 0)
        THIS.this_cResMoeda          = TratarNulo(EVALUATE(loc_cAlias + ".Moeda"), "")
        THIS.this_cResOperacao       = TratarNulo(EVALUATE(loc_cAlias + ".Operacao"), "")
        THIS.this_nResBarras         = TratarNulo(EVALUATE(loc_cAlias + ".Barras"), 0)
        THIS.this_cResGdeGrupo       = TratarNulo(EVALUATE(loc_cAlias + ".Gde_Grupo"), "")
        THIS.this_cResGrupo          = TratarNulo(EVALUATE(loc_cAlias + ".Grupo"), "")
        THIS.this_cResSubGrupo       = TratarNulo(EVALUATE(loc_cAlias + ".SubGrupo"), "")
        THIS.this_nResCustoCadastro  = TratarNulo(EVALUATE(loc_cAlias + ".Custo_Cadastro"), 0)
        THIS.this_cResMoeCusCadastro = TratarNulo(EVALUATE(loc_cAlias + ".Moe_Cus_Cadastro"), "")
        THIS.this_nResMarkup         = TratarNulo(EVALUATE(loc_cAlias + ".Markup"), 0)
        THIS.this_nResVendaCadastro  = TratarNulo(EVALUATE(loc_cAlias + ".Venda_Cadastro"), 0)
        THIS.this_cResMoeVdaCadastro = TratarNulo(EVALUATE(loc_cAlias + ".Moe_Vda_Cadastro"), "")
        THIS.this_cResImagem         = TratarNulo(EVALUATE(loc_cAlias + ".Imagem"), "")
        THIS.this_cResTamanho        = TratarNulo(EVALUATE(loc_cAlias + ".Tamanho"), "")
        THIS.this_cResCor            = TratarNulo(EVALUATE(loc_cAlias + ".Cor"), "")
        THIS.this_cResCodCliente     = TratarNulo(EVALUATE(loc_cAlias + ".Cod_Cliente"), "")
        THIS.this_cResNomeCliente    = TratarNulo(EVALUATE(loc_cAlias + ".Nome_Cliente"), "")
        THIS.this_cResCodFornecedor  = TratarNulo(EVALUATE(loc_cAlias + ".Cod_Fornecedor"), "")
        THIS.this_cResNomeFornecedor = TratarNulo(EVALUATE(loc_cAlias + ".Nome_Fornecedor"), "")
        THIS.this_nResTktMedio       = TratarNulo(EVALUATE(loc_cAlias + ".Tkt_Medio"), 0)
        THIS.this_cResRefFornecedor  = TratarNulo(EVALUATE(loc_cAlias + ".Ref_Fornecedor"), "")
        THIS.this_nResValorDiferenca = TratarNulo(EVALUATE(loc_cAlias + ".Valor_Diferenca"), 0)
        THIS.this_nResPercDiferenca  = TratarNulo(EVALUATE(loc_cAlias + ".Perc_Diferenca"), 0)
        THIS.this_cResPctDifChr      = TratarNulo(EVALUATE(loc_cAlias + ".Pct_Dif_Chr"), "")
        THIS.this_nResParcelas       = TratarNulo(EVALUATE(loc_cAlias + ".Parcelas"), 0)
        THIS.this_cResCondPagto      = TratarNulo(EVALUATE(loc_cAlias + ".Cond_Pagto"), "")
        THIS.this_nResVendaCadastroR = TratarNulo(EVALUATE(loc_cAlias + ".Venda_CadastroR"), 0)
        THIS.this_nResDescAcres      = TratarNulo(EVALUATE(loc_cAlias + ".Desc_Acres"), 0)
        THIS.this_cResCpfCli         = TratarNulo(EVALUATE(loc_cAlias + ".CpfCli"), "")
        THIS.this_cResPedidoWeb      = TratarNulo(EVALUATE(loc_cAlias + ".Pedidoweb"), "")
        THIS.this_cResPStatus        = TratarNulo(EVALUATE(loc_cAlias + ".pStatus"), "")
        THIS.this_nResDias           = TratarNulo(EVALUATE(loc_cAlias + ".Dias"), 0)
        THIS.this_cResDescritivo     = TratarNulo(EVALUATE(loc_cAlias + ".Descritivo"), "")
        THIS.this_cResLocal          = TratarNulo(EVALUATE(loc_cAlias + ".Local"), "")
        THIS.this_nResQtde           = TratarNulo(EVALUATE(loc_cAlias + ".Qtde"), 0)
        THIS.this_cResColecao        = TratarNulo(EVALUATE(loc_cAlias + ".Colecao"), "")
        THIS.this_cResDestino        = TratarNulo(EVALUATE(loc_cAlias + ".Destino"), "")
        THIS.this_cResContaOrigem    = TratarNulo(EVALUATE(loc_cAlias + ".ContaOrigem"), "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparPropriedadesResultado - Zera as propriedades this_Res* (linha
    * corrente da grade de resultado). Chamado pelo Init (estado inicial da
    * instancia) e pelo CarregarDoCursor quando o cursor nao existe/esta no
    * EOF - mesmo padrao do sigoppeiBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparPropriedadesResultado()
        THIS.this_cResOrdem          = ""
        THIS.this_nResFiltro         = 0
        THIS.this_cResEmpresa        = ""
        THIS.this_cResMovimentacao   = ""
        THIS.this_nResNumero         = 0
        THIS.this_dResDataVenda      = {}
        THIS.this_cResCodVendedora   = ""
        THIS.this_nResItem           = 0
        THIS.this_cResCodigoItem     = ""
        THIS.this_cResDescItem       = ""
        THIS.this_cResObsItem        = ""
        THIS.this_nResQuantidade     = 0
        THIS.this_nResValUnitario    = 0
        THIS.this_nResTotal          = 0
        THIS.this_nResTotalGeral     = 0
        THIS.this_cResMoeda          = ""
        THIS.this_cResOperacao       = ""
        THIS.this_nResBarras         = 0
        THIS.this_cResGdeGrupo       = ""
        THIS.this_cResGrupo          = ""
        THIS.this_cResSubGrupo       = ""
        THIS.this_nResCustoCadastro  = 0
        THIS.this_cResMoeCusCadastro = ""
        THIS.this_nResMarkup         = 0
        THIS.this_nResVendaCadastro  = 0
        THIS.this_cResMoeVdaCadastro = ""
        THIS.this_cResImagem         = ""
        THIS.this_cResTamanho        = ""
        THIS.this_cResCor            = ""
        THIS.this_cResCodCliente     = ""
        THIS.this_cResNomeCliente    = ""
        THIS.this_cResCodFornecedor  = ""
        THIS.this_cResNomeFornecedor = ""
        THIS.this_nResTktMedio       = 0
        THIS.this_cResRefFornecedor  = ""
        THIS.this_nResValorDiferenca = 0
        THIS.this_nResPercDiferenca  = 0
        THIS.this_cResPctDifChr      = ""
        THIS.this_nResParcelas       = 0
        THIS.this_cResCondPagto      = ""
        THIS.this_nResVendaCadastroR = 0
        THIS.this_nResDescAcres      = 0
        THIS.this_cResCpfCli         = ""
        THIS.this_cResPedidoWeb      = ""
        THIS.this_cResPStatus        = ""
        THIS.this_nResDias           = 0
        THIS.this_cResDescritivo     = ""
        THIS.this_cResLocal          = ""
        THIS.this_nResQtde           = 0
        THIS.this_cResColecao        = ""
        THIS.this_cResDestino        = ""
        THIS.this_cResContaOrigem    = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave da linha corrente da grade de resultado:
    * Empresa + Movimentacao + Numero + Item identificam de forma unica um
    * item de movimento (mesmo criterio usado pelo legado para montar lcEdn =
    * m.Empresa + m.Movimentacao + Str(m.Numero, 6), aqui estendido com o
    * Item porque a grade exibe uma linha por ITEM do movimento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cResEmpresa + THIS.this_cResMovimentacao + ;
            STR(THIS.this_nResNumero, 6) + STR(THIS.this_nResItem, 10)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir()/Atualizar()/ExecutarExclusao() - PROPOSITALMENTE nao
    * sobrescritos. Este form eh de CONSULTA/PROCESSAMENTO (ver cabecalho do
    * arquivo): o legado nao executa Insert/Update/Delete em tabela alguma a
    * partir desta tela - Consultar monta a grade de resultado (SELECT),
    * Visualizar/Imprimir/Exportar apenas LEEM o cursor ja montado, e os
    * botoes de filtro (Marcar/Desmarcar Tudo, Grupo_op) so alteram cursores
    * LOCAIS de filtro (crTpOpe/crGrdGpr/crGrdGru), nunca tabela do SQL
    * Server. O comportamento herdado de BusinessBase ja eh o correto, e
    * nunca chega a ser acionado porque nada no Form chama Salvar()/Excluir().
    *--------------------------------------------------------------------------

    *====================================================================
    * CarregarFiltros - Popula os filtros da pagina de Filtros a partir
    * do banco (legado: bloco do Init do SCX - linhas 2794-2896 do dump).
    * Resolve this_lAcessoPorTipo (fChecaAcesso('SIGOPPCK','CONPORTIPO'),
    * igual Usuar <> '4CONTROL' no legado - aqui gc_4c_UsuarioLogado), o
    * default de Empresa (legado: _Empr -> go_4c_Sistema.cCodEmpresa,
    * regra "_EMPR LEGACY - NUNCA usar") e as 3 grades de filtro (Tipos de
    * Operacao/SigCdTom, Grande Grupo/SigCdGpr, Grupo de Produto/SigCdGrp).
    * Chamado pelo Form em InicializarForm, apos os cursores placeholder
    * (criados em CriarCursoresFiltroPlaceholder) ja existirem - populacao
    * via ZAP + APPEND FROM DBF (nunca SQLEXEC direto no alias ja ligado
    * ao Grid, regra do CLAUDE.md sobre SQLEXEC zerar o ColumnCount).
    *
    * crSigCdPac/crSigCdGre do Init legado NAO sao portados: alimentam
    * apenas as funcoes globais fAcessoEmpresa/fAcessoMovmto, que este
    * form ja substitui por lookup proprio via FormBuscaAuxiliar (ver
    * ValidarEmpOsLostFocus/ValidarOperacaoLostFocus) - popular esses
    * cursores aqui seria SQL morto, sem consumidor.
    *====================================================================
    PROCEDURE CarregarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_lAcessoPorTipo = fChecaAcesso("SIGOPPCK", "CONPORTIPO") ;
                OR UPPER(ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))) == "4CONTROL"

            THIS.this_cEmpresa = go_4c_Sistema.cCodEmpresa

            IF USED("cursor_4c_BuscaEmpIni")
                USE IN cursor_4c_BuscaEmpIni
            ENDIF

            loc_cSQL       = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmpresa)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpIni")

            IF loc_nResultado > 0 AND USED("cursor_4c_BuscaEmpIni") AND RECCOUNT("cursor_4c_BuscaEmpIni") > 0
                THIS.this_cDescEmpresa = ALLTRIM(cursor_4c_BuscaEmpIni.Razas)
            ENDIF

            IF USED("cursor_4c_BuscaEmpIni")
                USE IN cursor_4c_BuscaEmpIni
            ENDIF

            loc_lSucesso = THIS.CarregarGradeTipos() AND THIS.CarregarGradeGrdGpr() AND THIS.CarregarGradeGrdGru()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Carregar Filtros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeTipos - Grade de Tipos de Operacao (legado: crTpOpe <-
    * SigCdTom). nMarcas = IIF(GerGdmis=1,1,0), CCodigos = STR(Codigos,2)
    * (2 chars, igual ao legado), CDescricaos = "<cod>-<descr>" com PADR a
    * 50 - transcricao literal de SigOpPck_form_codigo_fonte.txt:2845-2857.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGradeTipos()
        LOCAL loc_cCursor, loc_cTemp, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorTipos
        loc_cTemp    = "cursor_4c_TiposTmp"

        IF USED("cursor_4c_TiposOrig")
            USE IN cursor_4c_TiposOrig
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT Codigos, Descrs, GerGdmis FROM SigCdTom", "cursor_4c_TiposOrig")

        IF loc_nResultado >= 0 AND USED("cursor_4c_TiposOrig")
            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF

            SELECT IIF(GerGdmis = 1, 1, 0) AS nMarcas, ;
                   STR(Codigos, 2) AS CCodigos, ;
                   PADR(STR(Codigos, 2) + "-" + Descrs, 50) AS CDescricaos ;
                FROM cursor_4c_TiposOrig ;
                ORDER BY 2 ;
                INTO CURSOR (loc_cTemp)

            USE IN cursor_4c_TiposOrig

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                ZAP
                APPEND FROM DBF(loc_cTemp)
            ENDIF

            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeGrdGpr - Grade de Grande Grupo (legado: crGrdGpr <-
    * SigCdGpr). Todos os grupos nascem MARCADOS (nMarcas=1 fixo, igual ao
    * legado - usuario desmarca manualmente via btnDesGde/clique na linha).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGradeGrdGpr()
        LOCAL loc_cCursor, loc_cTemp, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorGrdGpr
        loc_cTemp    = "cursor_4c_GrdGprTmp"

        IF USED("cursor_4c_GrdGprOrig")
            USE IN cursor_4c_GrdGprOrig
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT Codigos, Descs FROM SigCdGpr", "cursor_4c_GrdGprOrig")

        IF loc_nResultado >= 0 AND USED("cursor_4c_GrdGprOrig")
            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF

            SELECT 1 AS nMarcas, Codigos, (Codigos + "-" + Descs) AS CDescricaos ;
                FROM cursor_4c_GrdGprOrig ;
                ORDER BY 2 ;
                INTO CURSOR (loc_cTemp)

            USE IN cursor_4c_GrdGprOrig

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                ZAP
                APPEND FROM DBF(loc_cTemp)
            ENDIF

            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeGrdGru - Grade de Grupo de Produto (legado: crGrdGru <-
    * SigCdGrp). Todos os grupos nascem MARCADOS (nMarcas=1 fixo, igual ao
    * legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGradeGrdGru()
        LOCAL loc_cCursor, loc_cTemp, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorGrdGru
        loc_cTemp    = "cursor_4c_GrdGruTmp"

        IF USED("cursor_4c_GrdGruOrig")
            USE IN cursor_4c_GrdGruOrig
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT Mercs, CGrus AS Codigos, DGrus AS Descs FROM SigCdGrp", "cursor_4c_GrdGruOrig")

        IF loc_nResultado >= 0 AND USED("cursor_4c_GrdGruOrig")
            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF

            SELECT 1 AS nMarcas, Mercs, Codigos, (Codigos + "-" + Descs) AS CDescricaos ;
                FROM cursor_4c_GrdGruOrig ;
                ORDER BY 2 ;
                INTO CURSOR (loc_cTemp)

            USE IN cursor_4c_GrdGruOrig

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                ZAP
                APPEND FROM DBF(loc_cTemp)
            ENDIF

            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Processar - Monta a grade de resultado (this_cCursorDados, legado:
    * crPgRes01) a partir dos movimentos do periodo/empresa/operacao
    * filtrados (legado: PROCEDURE processamento, codigo_fonte.txt:2608-
    * 2736). So reproduz os passos ATIVOS do legado - FilGdeGrupo(),
    * BuscaAntigos() e LimpaEmps() estao COMENTADOS (*!*) no metodo
    * original e nunca executam em producao; manter comentados aqui
    * tambem (regra #17 - transcrever o que o legado FAZ, nao o que esta
    * morto no fonte). A barra de progresso (fwProgressBar) reproduz os
    * passos ATIVOS do legado: 01/06 Selecao de Dados, 04/06 Filtrando
    * Grupo e 06/06 Montando Detalhamento dos Produtos.
    *====================================================================
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_dDataIni, loc_dDataFim, loc_cEmpresa, ;
            loc_cOperacao, loc_cTpO, loc_cSQL, loc_nResultado, loc_oErro, ;
            loc_oProgresso

        loc_lSucesso = .F.
        loc_oProgresso = .NULL.
        THIS.this_cMensagemErro = ""

        TRY
            loc_dDataIni  = ConverterParaData(THIS.this_dDataIni)
            loc_dDataFim  = ConverterParaData(THIS.this_dDataFim)
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cOperacao = ALLTRIM(THIS.this_cOperacao)

            IF EMPTY(loc_dDataIni) OR EMPTY(loc_dDataFim) OR EMPTY(loc_cEmpresa)
                THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo e a empresa antes de consultar."
            ELSE
                loc_cTpO = THIS.MontarFiltroTipoOperacao(loc_cOperacao)

                IF EMPTY(loc_cTpO)
                    THIS.this_cMensagemErro = "Selecione ao menos um Tipo de Opera" + CHR(231) + CHR(227) + "o " + ;
                        "ou informe a Movimenta" + CHR(231) + CHR(227) + "o."
                ELSE
                    *-- DataSession = 2 (privada) nao herda o SET DELETED ON do
                    *-- config.prg (regra do CLAUDE.md sobre DataSession/SET
                    *-- escopado) - FiltrarPorGrupo depende de DELETE visivel.
                    SET DELETED ON

                    loc_oProgresso = THIS.CriarBarraProgresso()
                    THIS.AtualizarBarraProgresso(loc_oProgresso, ;
                        "01/06: Sele" + CHR(231) + CHR(227) + "o de Dados")

                    IF USED("cursor_4c_Cursor1")
                        USE IN cursor_4c_Cursor1
                    ENDIF

                    loc_cSQL       = THIS.MontarSQLMovimentos(loc_cEmpresa, loc_dDataIni, loc_dDataFim, loc_cTpO)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cursor1")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao consultar os movimentos:" + CHR(13) + CapturarErroSQL()
                    ELSE
                        THIS.AtualizarBarraProgresso(loc_oProgresso, "04/06: Filtrando Grupo")
                        THIS.FiltrarPorGrupo()

                        THIS.AtualizarBarraProgresso(loc_oProgresso, ;
                            "06/06: Montando Detalhamento dos Produtos")
                        THIS.MontarCursorDados()

                        IF USED("cursor_4c_Cursor1")
                            USE IN cursor_4c_Cursor1
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        *-- FORA do TRY/CATCH de proposito: a barra tem de ser fechada tanto
        *-- no caminho de sucesso quanto no de excecao (legado: oProg1.Complete
        *-- em cada saida do metodo).
        IF VARTYPE(loc_oProgresso) = "O"
            loc_oProgresso.Complete(.T.)
            loc_oProgresso.Release()
            loc_oProgresso = .NULL.
        ENDIF

        IF !loc_lSucesso AND !EMPTY(THIS.this_cMensagemErro)
            MsgErro(THIS.this_cMensagemErro, "Erro ao Processar")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarBarraProgresso - Instancia a barra de progresso do processamento
    * (legado: oProg1 = Createobject([fwProgressBar], [Filtrando os Dados
    * Selecionados...], 6) + Top deslocado + Titulo.FontBold + Rodape).
    * Devolve .NULL. quando a classe nao esta disponivel ou quando o
    * ambiente eh de teste/validacao headless (onde nenhuma janela deve
    * ser aberta) - os chamadores toleram .NULL. via AtualizarBarraProgresso.
    *====================================================================
    PROTECTED PROCEDURE CriarBarraProgresso()
        LOCAL loc_oBarra

        loc_oBarra = .NULL.

        *-- Nenhuma janela em ambiente headless de teste/validacao de UI.
        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            RETURN loc_oBarra
        ENDIF

        *-- Sem TRY/CATCH, igual aos outros BOs que usam a barra
        *-- (SIGOPCFEBO/CVIBO): a guarda eh o VARTYPE do retorno. A classe
        *-- eh carregada no startup por config.prg/ConfigurarAmbiente().
        loc_oBarra = CREATEOBJECT("fwprogressbar", ;
            "Filtrando os Dados Selecionados...", 6)

        IF VARTYPE(loc_oBarra) = "O"
            loc_oBarra.Top             = loc_oBarra.Top - INT(loc_oBarra.Height / 2)
            loc_oBarra.Titulo.FontBold = .T.
            loc_oBarra.Rodape.Caption  = "Aguarde os Processamentos..."
            loc_oBarra.Show()
        ELSE
            loc_oBarra = .NULL.
        ENDIF

        RETURN loc_oBarra
    ENDPROC

    *====================================================================
    * AtualizarBarraProgresso - Avanca um passo da barra exibindo o texto
    * do passo (legado: oProg1.SubTitulo.Caption = [NN/06: ...] +
    * oProg1.Update(.T.)). Tolera barra ausente (.NULL.).
    *====================================================================
    PROTECTED PROCEDURE AtualizarBarraProgresso(par_oBarra, par_cTexto)
        IF VARTYPE(par_oBarra) = "O"
            par_oBarra.SubTitulo.Caption = par_cTexto
            par_oBarra.Update(.T.)
        ENDIF
    ENDPROC

    *====================================================================
    * ObterChaveCfgGrade - Chave do layout da grade em SigSyPar
    * (cidparams char(64)): nome do form + marcador do parametro +
    * usuario, porque o layout do legado eh POR USUARIO (fGravaUserXML
    * recebia pGrvXMLUsu = Usuar). Mesmo padrao de chave composta por
    * PADR usado em FormSIGOPCGF (filtros nomeados).
    *====================================================================
    PROTECTED FUNCTION ObterChaveCfgGrade()
        RETURN PADR("SIGOPPCK", 8) + PADR("CFGGRADE", 10) + ;
            PADR(UPPER(ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))), 20)
    ENDFUNC

    *====================================================================
    * CarregarCfgGrade - Le o layout salvo da grade de resultado para
    * this_cCfgGrade (legado: ThisForm.poSigSyPar.mLerCfg(), do objeto
    * fGravaUserXML do Framework, que NAO foi portado - substituido por
    * leitura direta de SigSyPar).
    *
    * NUNCA aplicar ALLTRIM ao valor lido: a string eh POSICIONAL (blocos
    * de 5 posicoes por coluna, a 5a eh um BRANCO) e cortar o branco final
    * desalinha a leitura do ultimo bloco.
    *====================================================================
    PROCEDURE CarregarCfgGrade()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(gnConnHandle) = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CfgGrade")
                    USE IN cursor_4c_CfgGrade
                ENDIF

                loc_cSQL = "SELECT mxmls FROM SigSyPar WHERE cidparams = " + ;
                    EscaparSQL(THIS.ObterChaveCfgGrade())
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgGrade")

                IF loc_nResultado > 0 AND USED("cursor_4c_CfgGrade") ;
                        AND RECCOUNT("cursor_4c_CfgGrade") > 0
                    THIS.this_cCfgGrade = TratarNulo(cursor_4c_CfgGrade.mxmls, "")
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_CfgGrade")
                    USE IN cursor_4c_CfgGrade
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Ler o Layout da Grade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GravarCfgGrade - Persiste this_cCfgGrade em SigSyPar (legado:
    * ThisForm.poSigSyPar.fGravaUserCfg(), chamado no Release do form).
    * UPSERT pela chave de ObterChaveCfgGrade; ctpparams = "G" (grade),
    * descrs limitado aos 40 caracteres da coluna.
    *====================================================================
    PROCEDURE GravarCfgGrade()
        LOCAL loc_lSucesso, loc_cChave, loc_cSQL, loc_nExiste, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(gnConnHandle) = "N" AND gnConnHandle > 0
                loc_cChave  = THIS.ObterChaveCfgGrade()
                loc_nExiste = 0

                IF USED("cursor_4c_CfgGradeEx")
                    USE IN cursor_4c_CfgGradeEx
                ENDIF

                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigSyPar WHERE cidparams = " + ;
                    EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgGradeEx") > 0
                    loc_nExiste = NVL(cursor_4c_CfgGradeEx.nExiste, 0)
                ENDIF

                IF USED("cursor_4c_CfgGradeEx")
                    USE IN cursor_4c_CfgGradeEx
                ENDIF

                IF loc_nExiste > 0
                    loc_cSQL = "UPDATE SigSyPar SET mxmls = " + ;
                        EscaparSQL(THIS.this_cCfgGrade) + ;
                        " WHERE cidparams = " + EscaparSQL(loc_cChave)
                ELSE
                    loc_cSQL = "INSERT INTO SigSyPar (cidparams, ctpparams, descrs, mxmls) VALUES (" + ;
                        EscaparSQL(loc_cChave) + ", " + EscaparSQL("G") + ", " + ;
                        EscaparSQL(LEFT("Layout da Grade - SIGOPPCK", 40)) + ", " + ;
                        EscaparSQL(THIS.this_cCfgGrade) + ")"
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o layout " + ;
                        "da grade." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Gravar o Layout da Grade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarFiltroTipoOperacao - Monta o fragmento WHERE do criterio de
    * Tipo de Operacao (legado: codigo_fonte.txt:2623-2650). Se o usuario
    * tem acesso restrito (campo avulso de Movimentacao preenchido), filtra
    * por c.Dopes direto; senao, pelos codigos marcados na grade de Tipos
    * (o.TipoOps = <cod> ou IN (<lista>)). Retorna "" se nao ha nenhum
    * criterio aplicavel (nenhum tipo marcado e campo avulso vazio).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarFiltroTipoOperacao(par_cOperacaoDigitada)
        LOCAL loc_cCursorTipos, loc_cFiltro, loc_cLista, loc_cVirgula, loc_nQtde

        loc_cFiltro = ""

        IF !EMPTY(par_cOperacaoDigitada)
            loc_cFiltro = " c.Dopes = " + EscaparSQL(par_cOperacaoDigitada) + " "
        ELSE
            loc_cCursorTipos = THIS.this_cCursorTipos

            IF USED(loc_cCursorTipos)
                loc_cLista   = ""
                loc_cVirgula = ""
                loc_nQtde    = 0

                SELECT (loc_cCursorTipos)
                SCAN FOR nMarcas = 1
                    loc_cLista   = loc_cLista + loc_cVirgula + ALLTRIM(CCodigos)
                    loc_cVirgula = ", "
                    loc_nQtde    = loc_nQtde + 1
                ENDSCAN

                DO CASE
                    CASE loc_nQtde = 0
                        loc_cFiltro = ""
                    CASE loc_nQtde = 1
                        loc_cFiltro = " o.TipoOps = " + loc_cLista + " "
                    OTHERWISE
                        loc_cFiltro = " o.TipoOps IN (" + loc_cLista + ") "
                ENDCASE
            ENDIF
        ENDIF

        RETURN loc_cFiltro
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQLMovimentos - Transcricao literal do SELECT de
    * PROCEDURE processamento (codigo_fonte.txt:2662-2692): movimentos de
    * SigMvCab/SigMvItn/SigMvIts no periodo/empresa/criterio informados,
    * com os dados de produto/cliente/estoque/etiqueta usados na grade de
    * resultado. Nomes de tabela/coluna conferidos contra docs/schema.sql
    * (regra #14/#48 do CLAUDE.md - SigMvCab.emps SEM "c", SigCdEmp.cemps
    * COM "c" - aqui so SigMvCab.emps eh usado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQLMovimentos(par_cEmpresa, par_dDataIni, par_dDataFim, par_cFiltroTipo)
        LOCAL loc_cSQL, loc_dDataFimSeguinte

        *-- intervalo [00:00 do dia inicial, 00:00 do dia seguinte ao final)
        *-- equivalente ao "Between pDtI And pDtF 23:59:59" do legado, sem
        *-- precisar formatar hora literal (FormatarDataSQL so aceita D/T).
        loc_dDataFimSeguinte = par_dDataFim + 1

        loc_cSQL = ;
            "SELECT c.empds AS Destino, c.emps AS Empresa, c.Dopes AS Movimentacao, " + ;
            "c.Numes AS Numero, c.Datas AS Data_Venda, i.CPros AS Codigo_Item, " + ;
            "ISNULL(p.cbars,0) AS Barra_Geral, " + ;
            "CASE WHEN ISNULL(i.codbarras,0) = 0 THEN ISNULL(s.CodBarras,0) ELSE ISNULL(i.codbarras,0) END AS Barra_Individual, " + ;
            "RTRIM(ISNULL(p.SGrus,'')) + '-' + RTRIM(ISNULL(sg.Descricaos,'')) AS SubGrupo, " + ;
            "p.Reffs AS Ref_Fornecedor, ISNULL(s.CodTams,'') AS Tamanho, " + ;
            "ISNULL(s.CodCors, ISNULL(p.codcors,'')) AS Cor, " + ;
            "ISNULL(x.iclis,'') AS Cod_Cliente, ISNULL(x.RClis,'') AS Nome_Cliente, " + ;
            "ISNULL(i.Pedidoweb,'') AS PedidoWeb, ISNULL(e.local,'') AS Local, " + ;
            "ISNULL(p.dpro2s,'') AS Descritivo, i.DPros AS Desc_Item, " + ;
            "i.Qtds AS Quantidade, ISNULL(e.qtde,0) AS Qtde, " + ;
            "RTRIM(ISNULL(p.colecoes,'')) + '-' + ISNULL(co.descs,'') AS Colecoes, " + ;
            "p.figjpgs AS Imagem, c.ContaOs AS ContaOrigem " + ;
            "FROM SigMvCab c " + ;
            "LEFT JOIN SigCdOpe o ON c.Dopes = o.Dopes " + ;
            "LEFT JOIN SigWbPed w ON c.PedidoWeb = w.Pedido " + ;
            "LEFT JOIN SigCdCli x ON w.cpfcli = REPLACE(REPLACE(REPLACE(x.cpfs,'-',''),'.',''),'/','') " + ;
            "LEFT JOIN (SELECT MAX(datapgt) AS DtPagto, Pedido FROM sigwbpar GROUP BY pedido) n ON c.pedidoweb = n.pedido " + ;
            "LEFT JOIN SigMvItn i ON c.EmpDopNums = i.EmpDopNums " + ;
            "LEFT JOIN SigMvIts s ON i.EmpDopNums = s.EmpDopNums AND i.CItens = s.CItens AND i.cpros = s.cpros " + ;
            "LEFT JOIN SigPrTam t ON s.CPros = t.CPros AND s.CodTams = t.CodTams " + ;
            "LEFT JOIN SigCdPro p ON i.CPros = p.CPros " + ;
            "LEFT JOIN SigCdCli c1 ON c1.ICLis = c.ContaDs " + ;
            "LEFT JOIN SigCdCli c2 ON c2.ICLis = p.IFors " + ;
            "LEFT JOIN SigCdPsg sg ON sg.CGruCods = p.CGrus + p.SGrus " + ;
            "LEFT JOIN SigCdCol co ON p.colecoes = co.colecoes " + ;
            "LEFT JOIN ( " + ;
            "    SELECT a.cpros, a.codtams, a.codcors, a.empos AS emps, a.localizas AS local, SUM(qtde) AS qtde " + ;
            "    FROM ( " + ;
            "        SELECT a.cpros, a.codtams, a.codcors, a.empos, localizas, COUNT(1) AS qtde FROM SigOpEtq a " + ;
            "        LEFT JOIN (SELECT Cpros, Cgrus, Mercs, Colecoes, SGrus FROM SigCdPro) b ON b.cpros = a.cpros " + ;
            "        WHERE a.empos = " + EscaparSQL(par_cEmpresa) + " AND a.grupos <> SPACE(10) AND a.contas <> SPACE(10) " + ;
            "        GROUP BY a.cpros, a.codtams, a.codcors, a.empos, localizas HAVING COUNT(1) > 0 " + ;
            "        UNION ALL " + ;
            "        SELECT a.cpros, '' AS codtams, '' AS codcors, a.emps, a.locals, SUM(sqtds) AS qtde FROM SigMvesl a, SigCdpro b, SigCdUni c " + ;
            "        WHERE a.CPros = b.Cpros AND b.Cunis = c.Cunis AND c.Etiqs <> 'S' AND a.emps = " + EscaparSQL(par_cEmpresa) + " " + ;
            "        GROUP BY a.cpros, a.locals, a.grupos, a.estos, a.emps HAVING SUM(sqtds) > 0 " + ;
            "    ) a " + ;
            "    GROUP BY a.cpros, a.codtams, a.codcors, a.empos, a.localizas " + ;
            ") e ON i.cpros = e.cpros AND ISNULL(s.CodTams,'') = e.codtams " + ;
            "WHERE " + par_cFiltroTipo + " AND c.Emps = " + EscaparSQL(par_cEmpresa) + " " + ;
            "AND c.Datas >= " + FormatarDataSQL(par_dDataIni) + " AND c.Datas < " + FormatarDataSQL(loc_dDataFimSeguinte) + " " + ;
            "AND c.pStatus IN ('','N')"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorGrupo - Remove de cursor_4c_Cursor1 os movimentos cujo
    * Grupo de Produto NAO esta marcado na grade (legado: PROCEDURE
    * filgrupo, codigo_fonte.txt:2238-2256).
    *
    * ACHADO: o SELECT de MontarSQLMovimentos (igual ao legado) NAO traz
    * uma coluna "Grupo" - filgrupo() do legado referencia uma coluna que
    * crCursor1 nunca teve. Como crGrdGru nasce com nMarcas=1 em TODOS os
    * grupos (ninguem desmarca por default), "Locate For nMarcas = 0" so
    * encontra alguma linha se o usuario desmarcar manualmente um grupo -
    * e so NESSE caso o legado estouraria "Variable GRUPO is not found".
    * Isto eh defeito LATENTE do original (nunca exercitado em uso normal,
    * nao regra de negocio - regra #17 nao se aplica a bug de runtime), e
    * aqui eh neutralizado com uma guarda de existencia da coluna, para o
    * form nao quebrar quando o usuario de fato desmarcar um grupo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarPorGrupo()
        LOCAL loc_cCursorGrdGru

        loc_cCursorGrdGru = THIS.this_cCursorGrdGru

        IF !USED(loc_cCursorGrdGru) OR !USED("cursor_4c_Cursor1")
            RETURN
        ENDIF

        IF TYPE("cursor_4c_Cursor1.Grupo") = "U"
            RETURN
        ENDIF

        SELECT (loc_cCursorGrdGru)
        LOCATE FOR nMarcas = 0

        IF EOF(loc_cCursorGrdGru)
            RETURN
        ENDIF

        IF USED("cursor_4c_NaoMarcados")
            USE IN cursor_4c_NaoMarcados
        ENDIF

        SELECT Codigos FROM (loc_cCursorGrdGru) WHERE nMarcas = 0 INTO CURSOR cursor_4c_NaoMarcados

        SELECT cursor_4c_NaoMarcados
        SCAN
            DELETE FROM cursor_4c_Cursor1 WHERE Grupo = cursor_4c_NaoMarcados.Codigos
        ENDSCAN

        USE IN cursor_4c_NaoMarcados
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorDados - Reconstroi this_cCursorDados (cursor_4c_Dados,
    * legado: crPgRes01) a partir de cursor_4c_Cursor1 (legado: PROCEDURE
    * montapgres01, codigo_fonte.txt:2538-2605). As chamadas a
    * fBuscarCotacao(lcMdC,...) e a sub-consulta LocalParcs (SigMvPar/
    * SigOpFp) do legado NAO sao reproduzidas aqui: nenhuma delas tem o
    * resultado usado em lugar algum do metodo original (lnCtC e
    * LocalParcs sao descartados sem Replace nenhum) - transcrever o
    * EFEITO do legado (regra #17), e o efeito dessas duas consultas eh
    * nenhum.
    *
    * ACHADO: a coluna da consulta principal se chama "Colecoes" (com s),
    * mas o campo do cursor de resultado eh "Colecao" (sem s) - no legado
    * o "Insert Into ... From Memvar" casa por NOME e nunca encontra esse
    * par, entao a coluna "Categoria" da grade de resultado fica sempre
    * vazia em producao. Mantido assim de proposito (bug do legado, nao
    * desta migracao - regra #17); NAO mapear Colecoes para Colecao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCursorDados()
        LOCAL loc_cCursorDados, loc_cCursorOrigem, loc_nBarraIndividual, loc_nBarraGeral, loc_nBarras

        loc_cCursorDados  = THIS.this_cCursorDados
        loc_cCursorOrigem = "cursor_4c_Cursor1"

        IF USED(loc_cCursorDados)
            SELECT (loc_cCursorDados)
            ZAP
        ENDIF

        IF !USED(loc_cCursorOrigem)
            RETURN
        ENDIF

        SELECT (loc_cCursorOrigem)
        SCAN
            loc_nBarraIndividual = NVL(Barra_Individual, 0)
            loc_nBarraGeral      = NVL(Barra_Geral, 0)
            loc_nBarras          = IIF(EMPTY(loc_nBarraIndividual), loc_nBarraGeral, loc_nBarraIndividual)

            INSERT INTO (loc_cCursorDados) ( ;
                Ordem, Filtro, Empresa, Movimentacao, Numero, Data_Venda, Codigo_Item, ;
                Desc_Item, Quantidade, Moeda, Barras, SubGrupo, Ref_Fornecedor, Tamanho, ;
                Cor, Cod_Cliente, Nome_Cliente, Pedidoweb, Local, Descritivo, Qtde, ;
                Imagem, Destino, ContaOrigem) ;
            VALUES ( ;
                "A", 0, Empresa, Movimentacao, Numero, Data_Venda, ;
                TratarNulo(Codigo_Item, ""), TratarNulo(Desc_Item, ""), TratarNulo(Quantidade, 0), "", ;
                loc_nBarras, SubGrupo, TratarNulo(Ref_Fornecedor, ""), Tamanho, ;
                Cor, Cod_Cliente, Nome_Cliente, Pedidoweb, Local, Descritivo, Qtde, ;
                TratarNulo(Imagem, ""), Destino, ContaOrigem)
        ENDSCAN

        SELECT (loc_cCursorDados)
        SET ORDER TO TAG Ordem3
        GO TOP
    ENDPROC

ENDDEFINE
