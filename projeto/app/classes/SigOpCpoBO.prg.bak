*==============================================================================
* SigOpCpoBO.prg - Business Object para Composicao de Produtos (SIGOPCPO)
*
* Form OPERACIONAL de SELECAO: eh um dialogo modal (WindowType = 1,
* TitleBar = 0, ControlBox = .F., Movable = .F.) aberto por um form PAI
* (o Init legado recebe LParameters pFrm, pKey e faz .ParentForm = pFrm /
* .ParentForm.Enabled = .f.). Ele lista a composicao (componentes) do produto
* informado em pKey, deixa o usuario MARCAR quais componentes deseja e, no
* botao OK, mantem na grade apenas as linhas marcadas; no Cancelar, descarta
* todas. Quem persiste eh o form PAI - esta tela NAO grava em tabela alguma.
*
* Tabela principal: SigPrCpo (chave primaria: cidchaves char(20) -
* constraint sigprcpo_cidchaves, ver docs/schema.sql)
* Tabelas auxiliares: SigCdPro (descricao / preco / moeda / referencia /
* imagem do componente e do produto-pai) e SigCdTpc (tipos de composicao com
* Custos = 2, que alimentam o cmbTipos).
*
* Legado (SigOpCpo.SCX):
*   Load           -> fConfigGeral() + Create Cursor crRodape
*                     (Descrs c(100), Usuars c(10), Totas n(12,2))
*   Init           -> guarda pFrm/pKey, lpKey = Padr(pKey, 14),
*                     CursorQuery([SigCdPro],[LocalPro],[Cpros],lpKey,[DPros])
*                     para validar o produto e montar o Caption
*                     (Caption + " - " + lpKey + " - " + LocalPro.DPros),
*                     depois MontaGrades + SelecionaDados
*   SelecionaDados -> Zap crGrade/crRodape; SELECT da composicao (SigPrCpo a
*                     + SigCdPro b) para LocalCompo; Insert Into crGrade;
*                     SELECT Tipos From SigCdTpc Where Custos = 2 para
*                     popular o cmbTipos; Set Filter To Tipos = cmbTipos.Value
*   AtuaTotas      -> Select Sum(Qtds), Sum(Totas) From crGrade Where Marcas
*                     -> grdRodape.Column3 + habilita/desabilita o btnConfirmar
*
* Mapeamento SELECT legado -> coluna real -> propriedade (tipos conferidos
* em docs/schema.sql, lido com Get-Content -Raw por ser UTF-16 - regra #14):
*   a.CPros              -> SigPrCpo.cpros     char(14)      -> this_cCpros
*   a.Mats               -> SigPrCpo.mats      char(14)      -> this_cMats
*   b.DPros              -> SigCdPro.dpros     char(65)      -> this_cDpros
*   a.Qtds               -> SigPrCpo.qtds      numeric(8,3)  -> this_nQtds
*   a.UniCompos          -> SigPrCpo.unicompos char(3)       -> this_cUnicompos
*   b.PVens as PCompos   -> SigCdPro.pvens     numeric(11,5) -> this_nPcompos
*   b.Moevs as Moeds     -> SigCdPro.moevs     char(3)       -> this_cMoeds
*   (a.Qtds * b.PVens)   -> calculado          numeric(11,3) -> this_nTotas
*   a.Etiqs              -> SigPrCpo.etiqs     char(1)       -> this_cEtiqs
*   b.Reffs              -> SigCdPro.reffs     char(40)      -> this_cReffs
*   b.FigJpgs            -> SigCdPro.figjpgs   text NULL     -> this_cFigjpgs
*   a.Tipos              -> SigPrCpo.tipos     char(20)      -> this_cTipos
*   (sem controle)       -> SigPrCpo.cidchaves char(20) PK   -> this_cCidchaves
*
* ATENCAO - as duas colunas "gemeas" que a tela NAO le:
* SigPrCpo tem pcompos numeric(11,3) e moeds char(3) PROPRIAS, mas o SELECT
* legado NAO as usa: ele toma b.PVens as PCompos e b.Moevs as Moeds, isto eh,
* o preco de venda e a moeda de venda do COMPONENTE em SigCdPro. Trocar a
* origem mudaria o valor exibido e o total - por isso as propriedades
* this_nPcompos / this_cMoeds documentam de onde vem (regra #17: a formula e
* a origem do legado se transcrevem, nao se reescrevem).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCpoBO AS BusinessBase

    *==========================================================================
    * Chave do dialogo - produto cuja composicao esta sendo exibida
    *==========================================================================
    *-- Cpros: char(14) - codigo do produto-PAI. Equivale ao .lpKey do legado
    *-- (.lpKey = Padr(Iif(Type([pKey])=[C], pKey, []), 14)) e eh o filtro da
    *-- consulta da composicao (Where a.CPros = '<lpKey>'). O PADR ate 14 eh
    *-- obrigatorio: a coluna eh char(14) e a comparacao com o valor gravado
    *-- depende do padding (regra #42).
    this_cCpros        = ""   && char(14) NOT NULL - produto-pai (lpKey)

    *-- Descricao do produto-pai, lida de SigCdPro.dpros pelo CursorQuery
    *-- ([SigCdPro],[LocalPro],[Cpros],lpKey,[DPros]) do Init legado. Entra no
    *-- Caption do form e nos dois labels da faixa do cabecalho
    *-- (lblSombra/lblTitulo recebem ThisForm.Caption).
    this_cDprosProduto = ""   && char(65) NOT NULL - descricao do produto-pai

    *-- Cidchaves: char(20) - PRIMARY KEY de SigPrCpo (constraint
    *-- sigprcpo_cidchaves). A tela nao grava, mas a chave eh declarada para o
    *-- ObterChavePrimaria() da auditoria e para que a leitura de uma linha
    *-- possa identificar o registro de origem sem ambiguidade.
    this_cCidchaves    = ""   && char(20) NOT NULL - chave primaria SigPrCpo

    *==========================================================================
    * Linha corrente da composicao (colunas da grade grdItens)
    *==========================================================================
    *-- Marcas: coluna LOGICA que existe SO no cursor da grade (nao ha coluna
    *-- equivalente em SigPrCpo). O legado a inicializa com
    *-- (LocalCompo.Etiqs = [S]), isto eh, o componente nasce marcado quando
    *-- Etiqs = "S", e a alterna com Replace Marcas With Not Marcas nos
    *-- handlers do CheckBox da Column1. Propriedade LOGICA porque a origem eh
    *-- uma comparacao, nao uma coluna numeric(1,0) nem bit.
    this_lMarcas       = .F.  && logico (so cursor) - componente selecionado

    *-- Mats: char(14) - codigo do componente (coluna "Item" da grade). No
    *-- SELECT ele tambem eh o lado do join com SigCdPro (a.Mats = b.CPros).
    this_cMats         = ""   && char(14) NOT NULL - codigo do componente

    *-- Dpros: char(65) - descricao do componente, vinda de SigCdPro.dpros
    *-- (coluna "Descricao", a mais larga da grade - Column3.Width = 394).
    this_cDpros        = ""   && char(65) NOT NULL - descricao do componente

    *-- Qtds: numeric(8,3) - quantidade do componente na composicao. Exibida
    *-- com InputMask [99999.999] na Column4 e somada no total de quantidade
    *-- que habilita o botao OK.
    this_nQtds         = 0    && numeric(8,3) NOT NULL - quantidade

    *-- UniCompos: char(3) - unidade da composicao (coluna "Uni",
    *-- Column5.Width = 31).
    this_cUnicompos    = ""   && char(3) NOT NULL - unidade do componente

    *-- Pcompos: o SELECT legado toma b.PVens as PCompos, ou seja o PRECO DE
    *-- VENDA do componente em SigCdPro - numeric(11,5) -, e NAO a coluna
    *-- SigPrCpo.pcompos (numeric(11,3)), que existe mas nao eh lida. Exibido
    *-- com InputMask [99999999.999] na Column6 ("Valor Unitario").
    this_nPcompos      = 0    && numeric(11,5) NOT NULL - b.PVens as PCompos

    *-- Moeds: o SELECT legado toma b.Moevs as Moeds, isto eh a MOEDA DE
    *-- VENDA do componente em SigCdPro - char(3) -, e NAO a coluna
    *-- SigPrCpo.moeds, que existe mas nao eh lida. Coluna "Moe" da grade
    *-- (Column7.Width = 31).
    this_cMoeds        = ""   && char(3) NOT NULL - b.Moevs as Moeds

    *-- Totas: valor total da linha. Formula do legado, transcrita sem
    *-- reescrita (regra #17): (a.Qtds * b.PVens) - quantidade da composicao
    *-- multiplicada pelo preco de venda do componente. SigPrCpo tem uma
    *-- coluna totas numeric(11,3), mas o SELECT NAO a le: o valor eh sempre
    *-- recalculado. Exibido com InputMask [99999999.99] na Column8, que eh a
    *-- unica coluna em negrito e com BackColor 245,251,136.
    this_nTotas        = 0    && calculado numeric(11,3) - Qtds * PVens

    *-- Etiqs: char(1) - flag de etiqueta do componente. O unico uso na tela
    *-- eh definir o estado inicial de Marcas (Marcas = (Etiqs = "S")); nao
    *-- tem coluna na grade.
    this_cEtiqs        = ""   && char(1) NOT NULL - "S" marca o componente

    *-- Reffs: char(40) - referencia do fornecedor do componente. Nao tem
    *-- coluna na grade: eh usada no titulo da tela de zoom da imagem
    *-- (Do Form SigOpZom With ... , [Ref. Fornecedor : ] + crGrade.Reffs).
    this_cReffs        = ""   && char(40) NOT NULL - ref. do fornecedor

    *-- Figjpgs: coluna text NULL de SigCdPro com a imagem do componente em
    *-- base64. O legado remove os prefixos data:image/...;base64, e decodifica
    *-- com Strconv(..., 14) UMA unica vez, gravando o resultado em arquivo
    *-- temporario antes de atribuir ao .Picture do Image. Propriedade de
    *-- CARACTERE porque guarda o base64 cru; por ser NULL no banco, toda
    *-- leitura passa por Nvl(..., []) como no Insert Into legado.
    this_cFigjpgs      = ""   && text NULL - imagem do componente em base64

    *-- Tipos: char(20) - tipo de composicao da linha. Eh a coluna pela qual o
    *-- cmbTipos FILTRA a grade (Set Filter To Tipos = cmbTipos.Value In
    *-- crGrade), executado tanto no fim do SelecionaDados quanto no Valid do
    *-- combo.
    this_cTipos        = ""   && char(20) NOT NULL - tipo de composicao

    *==========================================================================
    * Linha do rodape (grade grdRodape) - cursor criado no Load legado com
    * Create Cursor crRodape (Descrs c(100), Usuars c(10), Totas n(12,2)).
    * O legado insere UMA linha (Insert Into crRodape (Totas) Values (0)) e so
    * atualiza Totas; Descrs e Usuars ficam em branco, mas existem porque as
    * tres colunas estao ligadas as tres Columns do grdRodape
    * (Column1 -> Descrs, Column2 -> Usuars, Column3 -> Totas).
    *==========================================================================
    this_cDescrsRodape = ""   && c(100) cursor local - Column1 do grdRodape
    this_cUsuarsRodape = ""   && c(10)  cursor local - Column2 do grdRodape
    this_nTotasRodape  = 0    && n(12,2) cursor local - Column3 (total geral)

    *==========================================================================
    * Totais do AtuaTotas
    *
    * O legado agrupa SO as linhas marcadas:
    *   Select [ ] as Agrupar, Sum(Qtds) as Qtds, Sum(Totas) as Totas
    *     From crGrade Where Marcas Group By 1 Into Cursor LocalTot
    * O "Where Marcas" eh criterio de negocio (regra #17): linha DESMARCADA
    * nao entra no total, e nao se troca por soma de tudo.
    * O botao OK fica habilitado apenas quando LocalTot.Qtds > 0.
    *==========================================================================
    this_nTotalQtds    = 0    && soma de Qtds das linhas com Marcas = .T.
    this_nTotalTotas   = 0    && soma de Totas das linhas com Marcas = .T.

    *-- Espelha o Enabled do btnConfirmar: (LocalTot.Qtds > 0) no legado.
    *-- Fonte UNICA do estado do botao - o form apenas reflete esta
    *-- propriedade, para nao existirem dois criterios divergentes.
    this_lPermiteConfirmar = .F.

    *==========================================================================
    * Filtro de tipo (cmbTipos) - ComboBox Style = 2 (dropdown list),
    * FontName "Courier New", SEM ControlSource: ele apenas filtra a grade.
    *==========================================================================
    *-- Valor corrente do combo, usado no Set Filter To Tipos = <valor>.
    this_cTipoSelecionado = ""

    *-- Equivale ao llBrc do SelecionaDados legado: fica .T. quando ALGUMA
    *-- linha da composicao tem Tipos vazio (If Not llBrc And
    *-- Empty(LocalCompo.Tipos)). Nesse caso o legado acrescenta um item
    *-- Space(20) no TOPO do combo e o seleciona por padrao; sem nenhuma linha
    *-- sem tipo, o default passa a ser o PRIMEIRO tipo retornado por SigCdTpc
    *-- (ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos)).
    this_lTemTipoEmBranco = .F.

    *-- Item em branco do combo: Space(20), do tamanho exato de
    *-- SigPrCpo.tipos char(20), para o Set Filter To comparar certo.
    this_cTipoEmBranco    = ""

    *-- Filtro fixo da consulta de tipos: Where Custos = 2 em SigCdTpc
    *-- (coluna numeric(1,0)). Valor TRANSCRITO do legado - mudar aqui muda
    *-- quais tipos o usuario pode escolher.
    this_nCustosFiltro    = 2

    *-- Quantidade de tipos carregados de SigCdTpc (sem contar o item em
    *-- branco), para o form saber se o combo tem conteudo.
    this_nQtdeTipos       = 0

    *==========================================================================
    * Tabelas envolvidas (nomes EXATOS do banco - PILAR 2)
    *==========================================================================
    this_cTabelaComposicao = "SigPrCpo"   && composicao do produto (principal)
    this_cTabelaProduto    = "SigCdPro"   && produto: descricao/preco/imagem
    this_cTabelaTipoComp   = "SigCdTpc"   && tipos de composicao do cmbTipos

    *==========================================================================
    * Aliases dos cursores (PILAR 3 - nomes novos, prefixo cursor_4c_)
    *
    * Correspondencia com o legado:
    *   crGrade    -> this_cCursorGrade     (grade grdItens; no legado o cursor
    *                                        pertence ao form PAI e aqui eh
    *                                        apenas Zap'ado - na arquitetura
    *                                        nova ele eh criado e populado por
    *                                        este BO, e o form pai o le depois
    *                                        que o dialogo fecha)
    *   crRodape   -> this_cCursorRodape    (grade grdRodape, 1 linha)
    *   LocalCompo -> this_cCursorTempComp  (cursor TEMPORARIO do SQLEXEC da
    *                                        composicao; o SQLEXEC nunca vai
    *                                        para o alias ligado ao Grid, que
    *                                        perderia o ColumnCount)
    *   LocalTpCom -> this_cCursorTipos     (tipos de SigCdTpc)
    *   LocalPro   -> this_cCursorProduto   (cabecalho: descricao do produto)
    *   LocalTot   -> this_cCursorTotais    (totais do AtuaTotas)
    *==========================================================================
    this_cCursorGrade     = "cursor_4c_Grade"
    this_cCursorRodape    = "cursor_4c_Rodape"
    this_cCursorTempComp  = "cursor_4c_TempComp"
    this_cCursorTipos     = "cursor_4c_Tipos"
    this_cCursorTempTipos = "cursor_4c_TempTipos"
    this_cCursorProduto   = "cursor_4c_Produto"
    this_cCursorTotais    = "cursor_4c_Totais"

    *==========================================================================
    * Decodificacao da imagem (SigCdPro.figjpgs)
    *
    * O legado retira TRES prefixos data-URI antes do Strconv(..., 14):
    *   Strtran(Strtran(Strtran(FigJpgs,[data:image/png;base64,],[]),
    *                                  [data:image/jpeg;base64,],[]),
    *                                  [data:image/jpg;base64,],[])
    * Os prefixos ficam em propriedades para que exista UM unico lugar com a
    * lista, e o Strconv seja aplicado UMA SO VEZ sobre o resultado - decodar
    * duas vezes devolve lixo e a imagem nao abre.
    *==========================================================================
    this_cPrefixoPng  = "data:image/png;base64,"
    this_cPrefixoJpeg = "data:image/jpeg;base64,"
    this_cPrefixoJpg  = "data:image/jpg;base64,"

    *-- Caminho do arquivo .jpg temporario gerado por StrToFile para alimentar
    *-- o .Picture do Image (no legado: Sys(2023) + "\" + Sys(2015) + ".jpg").
    this_cArquivoImagem = ""

    *==========================================================================
    * Estado do dialogo
    *==========================================================================
    *-- .T. quando o usuario fechou pelo OK (btnConfirmar) e portanto as linhas
    *-- MARCADAS devem ser devolvidas ao form pai; .F. no Cancelar (btnSair),
    *-- que descarta todas as linhas.
    this_lConfirmado      = .F.

    *-- Quantidade de componentes carregados na grade (Reccount do cursor da
    *-- grade), usada pelo legado em If (Reccount([crGrade]) > 0) antes de
    *-- calcular os totais iniciais.
    this_nQtdeComponentes = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Define a tabela principal (SigPrCpo) e a chave primaria REAL (cidchaves
    * - constraint sigprcpo_cidchaves, docs/schema.sql), fixa os valores
    * constantes transcritos do legado e zera o estado de edicao herdado de
    * BusinessBase.
    *
    * NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): esta tela eh
    * um dialogo de SELECAO e todo Insert Into / Replace / Delete do legado
    * tem por destino CURSOR LOCAL (crGrade e crRodape) - o acesso remoto eh
    * 100% Select. O comportamento padrao herdado de BusinessBase (recusar a
    * gravacao e reportar pelo ExibirFalha do Salvar) ja eh o correto, e
    * inventar um INSERT aqui violaria a regra #22 (a lista de colunas vem do
    * schema, nunca de adivinhacao).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigPrCpo")

            THIS.this_cTabela     = "SigPrCpo"
            THIS.this_cCampoChave = "cidchaves"

            *-- Nomes das tabelas auxiliares (PILAR 2 - nomes exatos).
            THIS.this_cTabelaComposicao = "SigPrCpo"
            THIS.this_cTabelaProduto    = "SigCdPro"
            THIS.this_cTabelaTipoComp   = "SigCdTpc"

            *-- Item em branco do cmbTipos: Space(20) = largura de
            *-- SigPrCpo.tipos char(20), igual ao AddItem(Space(20)) legado.
            THIS.this_cTipoEmBranco = SPACE(20)

            *-- Filtro fixo da consulta de tipos (SigCdTpc.custos = 2).
            THIS.this_nCustosFiltro = 2

            *-- Prefixos data-URI removidos antes do Strconv(..., 14).
            THIS.this_cPrefixoPng  = "data:image/png;base64,"
            THIS.this_cPrefixoJpeg = "data:image/jpeg;base64,"
            THIS.this_cPrefixoJpg  = "data:image/jpg;base64,"

            *-- Estado inicial do dialogo: nada carregado, nada marcado, OK
            *-- desabilitado (btnConfirmar.Enabled = .f. no SelecionaDados).
            THIS.this_cCpros            = ""
            THIS.this_cDprosProduto     = ""
            THIS.this_cCidchaves        = ""
            THIS.this_lMarcas           = .F.
            THIS.this_cMats             = ""
            THIS.this_cDpros            = ""
            THIS.this_nQtds             = 0
            THIS.this_cUnicompos        = ""
            THIS.this_nPcompos          = 0
            THIS.this_cMoeds            = ""
            THIS.this_nTotas            = 0
            THIS.this_cEtiqs            = ""
            THIS.this_cReffs            = ""
            THIS.this_cFigjpgs          = ""
            THIS.this_cTipos            = ""
            THIS.this_cDescrsRodape     = ""
            THIS.this_cUsuarsRodape     = ""
            THIS.this_nTotasRodape      = 0
            THIS.this_nTotalQtds        = 0
            THIS.this_nTotalTotas       = 0
            THIS.this_lPermiteConfirmar = .F.
            THIS.this_cTipoSelecionado  = ""
            THIS.this_lTemTipoEmBranco  = .F.
            THIS.this_nQtdeTipos        = 0
            THIS.this_cArquivoImagem    = ""
            THIS.this_lConfirmado       = .F.
            THIS.this_nQtdeComponentes  = 0

            *-- Estado de edicao herdado de BusinessBase: dialogo de selecao
            *-- nunca entra em edicao de registro.
            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
            THIS.this_cMensagemErro   = ""
            THIS.this_lErroExibido    = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SigOpCpoBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Devolve a chave primaria da linha corrente
    * (SigPrCpo.cidchaves char(20)), usada pela auditoria de BusinessBase.
    *
    * PADR ate 20 porque a coluna eh char(20) e o valor guardado na property
    * pode vir com ALLTRIM na leitura do cursor (regra #42).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN PADR(ALLTRIM(THIS.this_cCidchaves), 20)
    ENDFUNC

    *==========================================================================
    * Fase 2 - Metodos de carga (equivalentes ao CRUD desta tela)
    *
    * Este dialogo eh SOMENTE-LEITURA no banco: o Init legado (Load +
    * SelecionaDados) faz so Select; o que o usuario marca so eh persistido
    * quando o form PAI grava a composicao, fora deste BO. Por isso Inserir(),
    * Atualizar() e ExecutarExclusao() NAO sao sobrescritos aqui - o
    * comportamento herdado de BusinessBase (recusar a operacao) ja eh o
    * adequado para este dialogo, e RegistrarAuditoria() so eh chamado por
    * esses dois metodos (regra: Audit System). Os metodos abaixo substituem,
    * um a um, a logica do Load/Init/SelecionaDados/AtuaTotas do legado:
    *
    *   Load + Create Cursor crRodape   -> THIS.Init() (Fase 1)
    *   CursorQuery(SigCdPro,...)       -> THIS.CarregarProduto()
    *   SelecionaDados (Insert crGrade) -> THIS.CarregarComposicao()
    *   SelecionaDados (combo Tipos)    -> THIS.CarregarTipos() (PROTECTED,
    *                                      chamado por CarregarComposicao)
    *   Set Filter To Tipos = ...       -> THIS.AplicarFiltroTipo()
    *   AtuaTotas                       -> THIS.AtualizarTotais()
    *   btnConfirmar.Click              -> THIS.ConfirmarSelecao()
    *   btnSair.Click                   -> THIS.CancelarSelecao()
    *   ImgFigJpg.Click (Strconv+jpg)   -> THIS.DecodificarImagem()
    *   leitura da linha da grade       -> THIS.CarregarDoCursor()
    *==========================================================================

    *==========================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de cursor_4c_Grade (ou outro
    * alias informado) para as properties this_* da linha. Usado pelo form
    * sempre que a linha corrente da grade mudar (AfterRowColChange) ou antes
    * de abrir o zoom da imagem (ImgFigJpgClick).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_lMarcas    = TratarNulo(Marcas, .F.)
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
            THIS.this_cMats      = TratarNulo(Mats, "")
            THIS.this_cDpros     = TratarNulo(Dpros, "")
            THIS.this_nQtds      = TratarNulo(Qtds, 0)
            THIS.this_cUnicompos = TratarNulo(UniCompos, "")
            THIS.this_nPcompos   = TratarNulo(PCompos, 0)
            THIS.this_cMoeds     = TratarNulo(Moeds, "")
            THIS.this_nTotas     = TratarNulo(Totas, 0)
            THIS.this_cEtiqs     = TratarNulo(Etiqs, "")
            THIS.this_cReffs     = TratarNulo(Reffs, "")
            THIS.this_cFigjpgs   = TratarNulo(FigJpgs, "")
            THIS.this_cTipos     = TratarNulo(Tipos, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarProduto - Valida o produto-pai (par_cCpros, equivalente ao
    * .lpKey legado) e le a descricao em SigCdPro.dpros para compor o Caption
    * do form ("... - <Cpros> - <Dpros>"), igual ao CursorQuery([SigCdPro],
    * [LocalPro],[Cpros],lpKey,[DPros]) do Init legado.
    *
    * Retorna .F. quando o produto nao existe (equivalente ao
    * "MessageBox('O Produto Informado Nao Existe!!!',...) / .Release" do
    * legado) - o form eh quem decide fechar, exibindo this_cMensagemErro.
    *==========================================================================
    FUNCTION CarregarProduto(par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            THIS.this_cCpros = PADR(ALLTRIM(TratarNulo(par_cCpros, "")), 14)

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            loc_cSQL = "SELECT dpros FROM SigCdPro " + ;
                       "WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorProduto) ;
                    AND RECCOUNT(THIS.this_cCursorProduto) > 0

                SELECT (THIS.this_cCursorProduto)
                GO TOP
                THIS.this_cDprosProduto = TratarNulo(Dpros, "")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "O Produto Informado N" + CHR(227) + ;
                    "o Existe!!!"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Validar Produto")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarComposicao - Recria cursor_4c_Grade (equivalente a crGrade) com
    * a composicao do produto em THIS.this_cCpros, no mesmo SELECT do legado
    * (SigPrCpo a INNER JOIN SigCdPro b, Order By a.Mats), e so depois monta o
    * filtro de tipos (THIS.CarregarTipos + THIS.AplicarFiltroTipo), igual ao
    * SelecionaDados legado (Zap crGrade/crRodape -> Select -> Insert Into
    * crGrade -> Select Tipos -> Set Filter To).
    *
    * O SQLEXEC NUNCA vai direto para cursor_4c_Grade (regra do SQLEXEC zerar
    * ColumnCount do Grid): a consulta roda em cursor_4c_TempComp e cada linha
    * eh copiada por APPEND BLANK + REPLACE para o cursor local que o Grid usa.
    *==========================================================================
    FUNCTION CarregarComposicao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro, ;
              loc_lTemBranco, loc_cCidchaves, loc_cMats, loc_cDpros, ;
              loc_nQtds, loc_cUnicompos, loc_nPcompos, loc_cMoeds, ;
              loc_nTotas, loc_cEtiqs, loc_cReffs, loc_cFigjpgs, loc_cTipos

        loc_lResultado = .F.
        loc_lTemBranco = .F.

        TRY
            IF USED(THIS.this_cCursorTempComp)
                USE IN (THIS.this_cCursorTempComp)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.mats, b.dpros, a.qtds, " + ;
                       "a.unicompos, b.pvens AS pcompos, b.moevs AS moeds, " + ;
                       "(a.qtds * b.pvens) AS totas, a.etiqs, b.reffs, " + ;
                       "b.figjpgs, a.tipos " + ;
                       "FROM SigPrCpo a INNER JOIN SigCdPro b " + ;
                       "ON a.mats = b.cpros " + ;
                       "WHERE a.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ;
                       " ORDER BY a.mats"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTempComp))

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha ao consultar a composi" + ;
                    CHR(231) + CHR(227) + "o do produto." + CHR(13) + ;
                    CapturarErroSQL()
            ELSE
                IF USED(THIS.this_cCursorGrade)
                    USE IN (THIS.this_cCursorGrade)
                ENDIF

                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorGrade) ;
                    (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
                     Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
                     Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
                     FigJpgs M, Tipos C(20))
                SET NULL OFF

                IF USED(THIS.this_cCursorTempComp)
                    SELECT (THIS.this_cCursorTempComp)
                    SCAN
                        loc_cCidchaves = TratarNulo(cidchaves, "")
                        loc_cMats      = TratarNulo(mats, "")
                        loc_cDpros     = TratarNulo(dpros, "")
                        loc_nQtds      = TratarNulo(qtds, 0)
                        loc_cUnicompos = TratarNulo(unicompos, "")
                        loc_nPcompos   = TratarNulo(pcompos, 0)
                        loc_cMoeds     = TratarNulo(moeds, "")
                        loc_nTotas     = TratarNulo(totas, 0)
                        loc_cEtiqs     = TratarNulo(etiqs, "")
                        loc_cReffs     = TratarNulo(reffs, "")
                        loc_cFigjpgs   = TratarNulo(figjpgs, "")
                        loc_cTipos     = TratarNulo(tipos, "")

                        IF EMPTY(loc_cTipos)
                            loc_lTemBranco = .T.
                        ENDIF

                        SELECT (THIS.this_cCursorGrade)
                        APPEND BLANK
                        REPLACE Marcas    WITH (loc_cEtiqs == "S"), ;
                                Cidchaves WITH loc_cCidchaves, ;
                                Mats      WITH loc_cMats, ;
                                Dpros     WITH loc_cDpros, ;
                                Qtds      WITH loc_nQtds, ;
                                UniCompos WITH loc_cUnicompos, ;
                                PCompos   WITH loc_nPcompos, ;
                                Moeds     WITH loc_cMoeds, ;
                                Totas     WITH loc_nTotas, ;
                                Etiqs     WITH loc_cEtiqs, ;
                                Reffs     WITH loc_cReffs, ;
                                FigJpgs   WITH loc_cFigjpgs, ;
                                Tipos     WITH loc_cTipos

                        SELECT (THIS.this_cCursorTempComp)
                    ENDSCAN

                    USE IN (THIS.this_cCursorTempComp)
                ENDIF

                THIS.this_lTemTipoEmBranco = loc_lTemBranco
                THIS.this_nQtdeComponentes = RECCOUNT(THIS.this_cCursorGrade)

                SELECT (THIS.this_cCursorGrade)
                GO TOP

                THIS.CarregarTipos()
                THIS.AplicarFiltroTipo(THIS.this_cTipoSelecionado)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Composi" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarTipos (PROTECTED) - Monta cursor_4c_Tipos a partir de SigCdTpc
    * Where Custos = 2 (this_nCustosFiltro), igual ao "Select Tipos From
    * SigCdTpc Where Custos = 2" do SelecionaDados legado. Quando
    * this_lTemTipoEmBranco (setado por CarregarComposicao) acrescenta o item
    * em branco Space(20) no TOPO, igual ao AddItem(Space(20)) legado, e
    * define this_cTipoSelecionado com o default (o item em branco, se
    * existir; senao o primeiro tipo retornado).
    *
    * PROTECTED porque so faz sentido chamado por CarregarComposicao - o form
    * nunca precisa chama-lo isoladamente, so ler cursor_4c_Tipos.
    *==========================================================================
    PROTECTED PROCEDURE CarregarTipos()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro, loc_cTipo
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorTempTipos)
                USE IN (THIS.this_cCursorTempTipos)
            ENDIF

            loc_cSQL = "SELECT tipos FROM SigCdTpc " + ;
                       "WHERE custos = " + ;
                       FormatarNumeroSQL(THIS.this_nCustosFiltro, 0) + ;
                       " ORDER BY tipos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTempTipos))

            IF USED(THIS.this_cCursorTipos)
                USE IN (THIS.this_cCursorTipos)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorTipos) (Tipos C(20))

            IF THIS.this_lTemTipoEmBranco
                APPEND BLANK
                REPLACE Tipos WITH THIS.this_cTipoEmBranco
            ENDIF

            IF loc_nResultado >= 0 AND USED(THIS.this_cCursorTempTipos)
                SELECT (THIS.this_cCursorTempTipos)
                SCAN
                    loc_cTipo = TratarNulo(tipos, "")
                    SELECT (THIS.this_cCursorTipos)
                    APPEND BLANK
                    REPLACE Tipos WITH loc_cTipo
                    SELECT (THIS.this_cCursorTempTipos)
                ENDSCAN

                USE IN (THIS.this_cCursorTempTipos)
            ENDIF

            THIS.this_nQtdeTipos = RECCOUNT(THIS.this_cCursorTipos)

            SELECT (THIS.this_cCursorTipos)
            GO TOP

            THIS.this_cTipoSelecionado = IIF(RECCOUNT(THIS.this_cCursorTipos) > 0, ;
                TratarNulo(Tipos, THIS.this_cTipoEmBranco), ;
                THIS.this_cTipoEmBranco)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Tipos de Composi" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AplicarFiltroTipo - Filtra cursor_4c_Grade pelo tipo escolhido no
    * cmbTipos, igual ao "Select crGrade / Set Filter To Tipos =
    * ThisForm.cmbTipos.Value In crGrade / Go Top In crGrade" do Valid legado.
    * Comparacao com == (SET EXACT ON global) contra o valor JA padronizado
    * para 20 posicoes (this_cTipoSelecionado nunca leva ALLTRIM - regra da
    * comparacao com buffer padded).
    *
    * O VALOR ENTRA NA EXPRESSAO COMO LITERAL - NUNCA como THIS.<property>.
    * SET FILTER guarda a expressao como TEXTO e a REAVALIA a cada acesso a
    * registro, resolvendo o THIS contra o objeto que estiver ativo NAQUELE
    * momento - e nao contra este BO. Medido no VFP9 (automation\
    * MedirSetFilterThis.prg, 2026-10-30) com "SET FILTER TO Tipos ==
    * THIS.this_cTipoSelecionado", que o VFP armazena como
    * [TIPOS==This.THIS_CTIPOSELECIONADO]:
    *
    *   GO TOP de DENTRO deste BO        -> OK (3 linhas visiveis)
    *   GO TOP de dentro de OUTRO objeto -> ERRO "Property
    *                                       THIS_CTIPOSELECIONADO is not found"
    *   GO TOP fora de objeto algum      -> o VFP DESCARTA O FILTRO em
    *                                       silencio: FILTER() volta VAZIO
    *   valor como LITERAL               -> OK nos TRES contextos
    *
    * A ultima linha do meio eh a perigosa: o Grid repinta FORA de qualquer
    * metodo, entao a grade passaria a exibir TODOS os tipos sem erro na
    * tela - divergencia muda do legado (PILAR 1), que filtra de verdade.
    * O delimitador do literal eh escolhido entre ", ' e [] para o valor
    * nunca quebrar a expressao.
    *==========================================================================
    FUNCTION AplicarFiltroTipo(par_cTipo)
        LOCAL loc_lResultado, loc_cValor, loc_cExpr
        loc_lResultado = .F.

        THIS.this_cTipoSelecionado = TratarNulo(par_cTipo, THIS.this_cTipoEmBranco)

        IF USED(THIS.this_cCursorGrade)
            loc_cValor = THIS.this_cTipoSelecionado

            DO CASE
            CASE !(CHR(34) $ loc_cValor)
                loc_cExpr = "Tipos == " + CHR(34) + loc_cValor + CHR(34)
            CASE !("'" $ loc_cValor)
                loc_cExpr = "Tipos == '" + loc_cValor + "'"
            OTHERWISE
                loc_cExpr = "Tipos == [" + STRTRAN(loc_cValor, "]", " ") + "]"
            ENDCASE

            SELECT (THIS.this_cCursorGrade)
            SET FILTER TO &loc_cExpr
            GO TOP
            loc_lResultado = .T.
        ENDIF

        THIS.AtualizarTotais()

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AtualizarTotais - Soma Qtds/Totas das linhas MARCADAS de cursor_4c_Grade
    * e habilita/desabilita a confirmacao, igual ao AtuaTotas legado:
    *   Select Sum(Qtds) as Qtds, Sum(Totas) as Totas From crGrade
    *     Where Marcas Group By 1 Into Cursor LocalTot
    *   btnConfirmar.Enabled = (LocalTot.Qtds > 0)
    * "Where Marcas" eh criterio de negocio (regra #17): linha DESMARCADA
    * nao entra no total - nao se troca por soma de tudo.
    *
    * O TOTAL EH DA COMPOSICAO INTEIRA, NAO DO TIPO FILTRADO - e isso eh
    * FIEL ao legado, nao um descuido. Medido no VFP9 (automation\
    * MedirSelectComSetFilter.prg, 2026-10-30) com SET FILTER ativo em um
    * tipo que cobre 90 de 100: o acesso NAVEGACIONAL (COUNT, SCAN) respeita
    * o filtro e da 90, mas o SELECT SQL local o IGNORA e da 100 - inclusive
    * na forma exata do AtuaTotas legado (Select .. Where Marcas Group By 1).
    * Como o legado usa esse mesmo SELECT, ele tambem totaliza a composicao
    * inteira. NUNCA trocar este SELECT por SCAN/COUNT "para respeitar o
    * filtro": isso mudaria o numero que o usuario ve, em silencio.
    *==========================================================================
    FUNCTION AtualizarTotais()
        LOCAL loc_lResultado, loc_nSomaQtds, loc_nSomaTotas, loc_oErro
        loc_lResultado = .F.
        loc_nSomaQtds  = 0
        loc_nSomaTotas = 0

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT SUM(Qtds) AS SomaQtds, SUM(Totas) AS SomaTotas ;
                    FROM (THIS.this_cCursorGrade) WHERE Marcas = .T. ;
                    INTO CURSOR cursor_4c_SomaMarcadas

                IF USED("cursor_4c_SomaMarcadas")
                    loc_nSomaQtds  = TratarNulo(cursor_4c_SomaMarcadas.SomaQtds, 0)
                    loc_nSomaTotas = TratarNulo(cursor_4c_SomaMarcadas.SomaTotas, 0)
                    USE IN cursor_4c_SomaMarcadas
                ENDIF
            ENDIF

            THIS.this_nTotalQtds        = loc_nSomaQtds
            THIS.this_nTotalTotas       = loc_nSomaTotas
            THIS.this_lPermiteConfirmar = (loc_nSomaQtds > 0)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Atualizar Totais")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ConfirmarSelecao - Equivalente ao btnConfirmar.Click legado: descarta as
    * linhas NAO marcadas de cursor_4c_Grade (Select crGrade / Set Filter To /
    * Scan / If Not Marcas / Delete / EndScan) e marca o dialogo como
    * confirmado, para o form PAI ler apenas os componentes escolhidos.
    *==========================================================================
    FUNCTION ConfirmarSelecao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                SET FILTER TO
                SCAN
                    IF !Marcas
                        DELETE
                    ENDIF
                ENDSCAN
                GO TOP
            ENDIF

            THIS.this_lConfirmado = .T.
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CancelarSelecao - Equivalente ao btnSair.Click legado: descarta TODAS as
    * linhas de cursor_4c_Grade (Select crGrade / Set Filter To / Scan /
    * Delete / EndScan), incondicional - nao so as desmarcadas - e marca o
    * dialogo como NAO confirmado.
    *==========================================================================
    FUNCTION CancelarSelecao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                SET FILTER TO
                ZAP
            ENDIF

            THIS.this_lConfirmado = .F.
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Cancelar Sele" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * DecodificarImagem - Remove os tres prefixos data-URI e decodifica o
    * base64 de SigCdPro.figjpgs, gravando o resultado num .jpg temporario,
    * igual ao ImgFigJpg.Click legado:
    *   lcArq = Sys(2023) + [\] + Sys(2015) + [.jpg]
    *   Strconv(Strtran(Strtran(Strtran(FigJpgs,png,[]),jpeg,[]),jpg,[]), 14)
    *   StrToFile(lcFoto, lcArq)
    * O Strconv roda UMA SO VEZ sobre o resultado dos tres Strtran - decodar
    * duas vezes devolve lixo. this_cArquivoImagem fica "" quando nao ha
    * imagem, igual ao Image.Visible = .F. do legado quando Empty(FigJpgs).
    *==========================================================================
    FUNCTION DecodificarImagem(par_cFigjpgsBase64)
        LOCAL loc_lResultado, loc_cBase64, loc_cBinario, loc_cArquivo, loc_oErro
        loc_lResultado = .F.
        THIS.this_cArquivoImagem = ""

        TRY
            loc_cBase64 = TratarNulo(par_cFigjpgsBase64, "")

            IF !EMPTY(loc_cBase64)
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoPng,  "")
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoJpeg, "")
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoJpg,  "")

                loc_cBinario = STRCONV(loc_cBase64, 14)
                loc_cArquivo = ADDBS(SYS(2023)) + SYS(2015) + ".jpg"

                IF STRTOFILE(loc_cBinario, loc_cArquivo) > 0
                    THIS.this_cArquivoImagem = loc_cArquivo
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Decodificar Imagem")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
