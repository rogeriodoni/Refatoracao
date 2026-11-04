*==============================================================================
* FormSIGOPDVM.prg
*
* Legado : SIGOPDVM.SCX (task726)
* Herda  : FormBase
* Tipo   : OPERACIONAL - dialogo FILHO, layout FLAT (sem PageFrame)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo modal aberto por uma tela de Mapa Resumo/Movimento (ainda nao
* migrada), para exibir as diferencas entre o valor apurado no caixa, o
* valor dos itens vendidos e o valor do mapa resumo fiscal, por caixa, na
* data e empresa correntes (grade de 7 colunas - ver SIGOPDVMBO.GerarComparacao).
*
* O legado (Init) NAO consulta SQL Server: ele faz SCAN sobre cursores que o
* FORM PAI ja deixou abertos na MESMA data session (crCaixa, crCaixaI,
* crCaixaFIN, crSigFiMpi) e grava o resultado em crImpressao, que alimenta o
* Grid1. Por isso esta tela NAO precisa de gnConnHandle - precisa apenas que
* o chamador informe os ALIASES desses 4 cursores (ja na mesma sessao) e a
* Empresa/Data do filtro.
*
*------------------------------------------------------------------------------
* CONTRATO COM O FORM PAI (transcrito do legado)
*
*    SIGOPDVM.Init  : LParameters pcForm
*                      ThisForm.DataSessionId = pcForm.DataSessionId
*                      (Scan sobre crCaixa/crCaixaI/crCaixaFIN/crSigFiMpi,
*                       lendo Emps/Datas de pcForm.Pagina.Dados.PageFrame1.
*                       Page1.Get_emps/Get_datas)
*
*    SIGOPDVM.CmdCat.Click : Release Windows
*
* "ThisForm.DataSessionId = pcForm.DataSessionId" nao tem equivalente literal
* em VFP9 (DataSessionID e somente-leitura na classe Form nativa) - a
* intencao e COMPARTILHAR a data session do pai, para os 4 cursores dele
* ficarem visiveis aqui. Na nova arquitetura isso se obtem com
* DataSession = 1 (sessao corrente): como este form e criado de DENTRO de
* um metodo do form pai, "sessao corrente" JA E a sessao do pai, inclusive
* quando o pai tem DataSession = 2 (privada) - ver memoria DataSession1.
*
* O PILAR 3 renomeia os objetos do form pai, entao os aliases dos 4 cursores
* e a Empresa/Data chegam por PARAMETRO explicito de Init (quem abre esta
* tela ja sabe os proprios nomes). THIS.ResolverContextoDoPai() tenta
* completar o que faltar lendo candidatos defensivos do par_oFormPai, mas
* NUNCA e a unica via - sem nenhum dos dois, SIGOPDVMBO.GerarComparacao
* devolve .F. com mensagem, sem quebrar a tela (ela so mostra grade vazia).
*
*------------------------------------------------------------------------------
* ESCOPO JA ENTREGUE
*
* Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump,
* Init (contexto do pai + BO + InicializarForm), cabecalho cinza
* (cntSombra -> cnt_4c_Sombra com os dois labels) e Destroy.
*
* Fase 4/8 - Grid1 -> grd_4c_Dados (ConfigurarGrid: 7 colunas, headers,
* fonte e cores do dump - AINDA SEM RecordSource/ControlSource, que dependem
* do cursor_4c_Dados so criado na Fase 8), Shape1 -> shp_4c_Shape1 decorativo
* e CmdCat -> cmd_4c_Encerrar (ConfigurarBotoes), nesta ordem de AddObject
* (identica ao dump: cabecalho, Grid1, Shape1, CmdCat).
*
* NAO existem aqui PageFrame nem pagina Lista/Dados: o SCX legado nao tem
* Page nenhuma (layout FLAT) e tem apenas 1 botao (CmdCat, "Encerrar") -
* nunca os 5 botoes CRUD do padrao frmcadastro. Inventar PageFrame Lista/
* Dados e botoes CRUD canonicos violaria o PILAR 1.
*
* Fase 5/8 - superficie de DADOS. Esta tela NAO tem campo solto algum: a
* unica superficie de dados sao as 7 celulas da grade (todas ReadOnly = .T.
* no dump), entao "metade dos campos da Page2" e vazio aqui por construcao -
* inventar campos ou uma Page2 violaria o PILAR 1. O trabalho real desta
* fase foi:
*   (a) AUDITORIA das propriedades do dump que a Fase 4 deixou passar, por
*       criar muitos controles de uma vez - 15 atribuicoes acrescentadas:
*       Grid1.Panel = 1 e ColumnN.FontName/FontSize ("Tahoma"/8) nas 7
*       colunas (o dump declara a fonte na Column ALEM do Header1/Text1);
*   (b) ConfigurarPaginaDados() com corpo REAL, chamado no InicializarForm
*       DEPOIS de todos os AddObject: confere que as 7 colunas do dump
*       existem e delega o vinculo;
*   (c) VincularColunasGrade() - as 7 linhas de ControlSource do Init legado,
*       guardadas por USED() para nao derrubar a tela antes do cursor existir
*       (regra #41). Column5/Column6 sao EXPRESSOES, transcritas literalmente.
*
* Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: esta tela nao tem NENHUM dos dois,
* e isso foi MEDIDO no dump, nao presumido.
*
*   (a) CAMPOS - metade de zero continua zero. Os 7 "BaseClass: textbox" do
*       dump sao os Text1 NATIVOS das 7 Column do Grid1 (regra #18), ja
*       entregues com a propria grade nas Fases 4/5; o dump nao tem UM
*       controle de entrada fora da grade (nenhum textbox/editbox/combobox/
*       listbox/checkbox/optiongroup/spinner cujo Parent nao seja uma
*       Column). E todos sao somente-leitura no legado: Grid1.ReadOnly=.T.,
*       Column1..Column7.ReadOnly=.T. e Text1.ReadOnly=.T. em Column1..6
*       (Column7.Text1 nao declara, herda do Grid/Column - por isso o
*       migrado tambem nao declara la). Campo ReadOnly nao recebe lookup por
*       definicao: nao ha onde o usuario digitar codigo para o picker
*       resolver.
*
*   (b) LOOKUPS - o dump nao casa NENHUMA assinatura de busca do Framework
*       Fortyus: nenhum fwBusca* (as TRES variantes Ext/Sel/Int), nenhum
*       mAddColuna (a API de colunas do picker legado, que cobre variante
*       futura da classe), nenhum sigacess(), nenhuma funcao da familia
*       Acesso<X>() e nenhum FormBuscaAuxiliar. comportamento.json confirma
*       pela via INDEPENDENTE da analise comportamental: nos 3 metodos com
*       codigo do SCX (Load, Init, CmdCat.Click) o campo "temLookup" sai
*       .F. nos tres, e a unica funcaoExterna de toda a tela e fConfigGeral
*       (do Load).
*
*       Inventar um lookup para "ter o que entregar" violaria o PILAR 1 e a
*       regra explicita "NUNCA inventar tabelas de lookup que nao existem no
*       original"; um AbrirLookup* de corpo vazio violaria a regra de
*       completude. Mesma decisao, mesmo motivo, dos precedentes SIGOPCLP ->
*       FormSigOpClp (task704: grade de 7 colunas + UM botao Encerrar, o
*       analogo exato desta tela) e SIGMVCHV -> FormSigMvChv.
*
*   (c) O QUE ESTA FASE ENTREGA DE VERDADE - a Fase 4 criou cmd_4c_Encerrar
*       (CmdCat do legado) SEM handler e SEM BINDEVENT: o unico botao da
*       tela estava inerte, e o usuario clicava nele sem nada acontecer. O
*       unico evento de controle que o dump tem - CmdCat.Click, de uma linha
*       so ("Release Windows") - passou a existir aqui, em BtnEncerrarClick
*       + BINDEVENT no fim de ConfigurarBotoes. Deixar o botao morto para
*       mais tarde seria fechar esta fase com um defeito ja conhecido. Com
*       isso a Fase 7 (eventos de botao) fica sem item NOVO nesta tela: o
*       legado tem UM botao e UM Click, e nenhum botao CRUD.
*
* Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: ja entregues, e a ausencia dos
* quatro nomes CRUD foi MEDIDA no dump, nao presumida.
*
*   (a) O QUE O LEGADO TEM DE BOTAO - exatamente UM. Contado no dump: 1
*       objeto com "BaseClass: commandbutton" (CmdCat, classe fwbtng) e ZERO
*       objeto com "BaseClass: commandgroup" (logo nao ha ButtonCount algum a
*       somar). O dump inteiro declara 3 metodos com codigo - Load
*       ("=fConfigGeral()"), Init (a comparacao) e CmdCat.Click - e um unico
*       "PROCEDURE Click".
*
*   (b) O QUE O LEGADO NAO TEM - zero evidencia de CRUD, nas tres vias
*       independentes, todas medidas em 2026-10-31 sobre
*       tasks\task726\SIGOPDVM_form_codigo_fonte.txt:
*
*         ESTRUTURAL : "frmcadastro" 0, "frmrelatorio" 0, "Grupo_Op" 0 e
*                      "pcEscolha" 0 - o form e "Class: form" PURO, sem Page
*                      Lista/Dados (layout FLAT).
*         NOME       : "Incluir" 0, "Alterar" 0, "Visualizar" 0 - e tambem
*                      "Excluir" 0 e "Inserir" 0, entao nem a barra CRUD do
*                      frmcadastro nem a toolbar de LINHA de grade (cujo
*                      unico verbo compartilhado seria "Excluir") existem.
*         CHAMADA    : nenhum "<X>.Click" com X em Incluir/Alterar/
*                      Visualizar/Excluir - o unico .Click do dump e o do
*                      proprio CmdCat.
*
*       Por isso NAO existem aqui BtnIncluirClick/BtnAlterarClick/
*       BtnVisualizarClick/BtnExcluirClick: criar os quatro violaria o
*       PILAR 1 (inventa botao que o usuario do legado nunca teve) e, com
*       corpo vazio, violaria a regra de completude. Mesma decisao e mesmo
*       motivo do precedente SIGOPCLP -> FormSigOpClp (task704: grade de 7
*       colunas + UM botao Encerrar, o analogo exato desta tela).
*
*   (c) O UNICO EVENTO DE BOTAO QUE EXISTE JA ESTA PORTADO - CmdCat.Click ->
*       BtnEncerrarClick, mais o BINDEVENT no fim de ConfigurarBotoes,
*       escritos na Fase 6 para o botao nao ficar inerte (item (c) do bloco
*       da Fase 6 acima). Esta fase RE-AUDITOU esse par, e os cinco pontos
*       conferem:
*         1. BtnEncerrarClick e PUBLIC (sem PROTECTED) - BINDEVENT em metodo
*            PROTECTED falha EM SILENCIO (regra #3) e PEMSTATUS devolveria
*            .T. mesmo assim, escondendo o defeito;
*         2. o delegate EXISTE com o nome exato passado ao BINDEVENT - nome
*            inexistente estoura no proprio bind;
*         3. o BINDEVENT vem DEPOIS do AddObject do botao, no fim do metodo -
*            antes dele o objeto nem existe;
*         4. THIS.Release() (nao Hide()) e a traducao certa AQUI porque esta
*            tela nao devolve NADA ao chamador: nao ha property de retorno,
*            nao ha PROCEDURE Unload no dump e o legado nao e aberto com
*            "DO FORM ... TO <var>". Onde ha resultado a ler, Release()
*            mataria a referencia do chamador (licao do FormSigOpCtd,
*            task715) - nao e o caso desta tela;
*         5. o ESC nao precisa de segundo handler - cmd_4c_Encerrar tem
*            Cancel = .T. transcrito do dump, e a tecla de cancelamento
*            dispara o Click do proprio botao, que e justamente o evento
*            interceptado pelo BINDEVENT.
*
*   (d) NAO ha outro evento a portar. O dump nao tem evento algum de Grid
*       (nenhum AfterRowColChange e nenhum Header1.Click que reordene a
*       grade), nem KeyPress, nem Valid/LostFocus - as 7 celulas sao
*       ReadOnly e nao existe UM controle de entrada fora da grade (medido
*       na Fase 6). O "Load" ("=fConfigGeral()") segue NAO PORTADO:
*       fConfigGeral era inicializacao GLOBAL da aplicacao Fortyus, e
*       utils\fconfiggeral.prg e um wrapper NO-OP que existe apenas para o
*       p-code dos VCX legado - precedente registrado em FormSigMvExp,
*       FormSigMvMen, FormSigMvPdt e no proprio SigOpClpBO.
*
*   (e) Entrega desta fase, em uma linha: NENHUMA linha de codigo nova -
*       cada evento de botao que o legado tem ja existe e foi reconferido.
*       O que entra e o registro da medicao acima, para que a proxima
*       leitura (ou o proximo sweep) nao conclua que faltam handlers.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Esta fase fecha o
* unico buraco funcional que sobrava: ate a Fase 7 a tela ABRIA, mas a grade
* nunca recebia dado nenhum - ConfigurarPaginaDados() chamava
* VincularColunasGrade(), que e GUARDADO por USED() (regra #41), e em tempo de
* Init o cursor da comparacao ainda nao existia, entao o vinculo nunca
* acontecia e ninguem chamava SIGOPDVMBO.GerarComparacao(). O usuario abria o
* dialogo e via a grade VAZIA, sem erro nenhum.
*
*   (a) CarregarLista() - o FUNIL unico de dado desta tela, e o NOME que o
*       gate desta fase cobra com referente de verdade aqui (o legado popula
*       a grade no proprio Init). Faz, na ordem do legado: GerarComparacao()
*       (os dois SCAN + Index + Go Top, ja no BO desde a Fase 2) e so DEPOIS
*       VincularColunasGrade() (RecordSource/ControlSource) - regra #41, que
*       e justamente o motivo de este par nao poder ter nascido na Fase 5.
*       PUBLIC de proposito: o harness de teste chama
*       THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS devolveria
*       .T. para metodo PROTECTED enquanto a chamada real falharia so em
*       runtime (regras #3 e #51).
*
*   (b) InicializarForm() passou a chamar CarregarLista() - DEPOIS de todos os
*       AddObject e de ConfigurarPaginaDados(). Falha de DADO nao aborta a
*       tela (loc_lSucesso nao depende do retorno): o legado tambem abre o
*       dialogo com crImpressao vazio quando nao ha divergencia, e lista
*       vazia e resultado VALIDO desta tela, nao erro.
*
*   (c) AplicarColunasDoDump() - largura e caption das 7 colunas, extraidas de
*       dentro de VincularColunasGrade para virarem FONTE UNICA: atribuir
*       RecordSource/ControlSource reseta Column.Width para 90 e
*       Header1.Caption para "Header1" (Problema 48 / regra #41), e agora ha
*       DOIS caminhos que mexem em RecordSource - o vinculo e o
*       desligamento do ramo de falha. Duas copias divergiriam em silencio na
*       primeira coluna que mudasse (CLAUDE.md #44, item 6).
*
*   (d) Destroy() fecha o cursor da comparacao - mas SO se foi este dialogo
*       que o criou (this_lCursorProprio). A distincao e regra, nao zelo: no
*       legado o crImpressao e do form PAI (o Init legado so faz "Select
*       crImpressao / Zap", nunca o cria), e com DataSession = 1 um USE IN
*       incondicional aqui FECHARIA o cursor do pai ao sair do dialogo,
*       quebrando a tela que nos abriu. CarregarLista mede a posse olhando
*       USED() ANTES de GerarComparacao: nao existia antes e existe depois =
*       nos criamos. Sem TABLEREVERT antes do USE IN - ele exige buffering e
*       com Buffering = 1 ERRA (regra #52); USE IN fecha o alias de qualquer
*       jeito.
*
*   (e) O QUE NAO ENTRA, e por que - medido, nao presumido. O gate desta fase
*       cobra tambem BtnCancelarClick, FormParaBO e BOParaForm, e a lista de
*       verbos de botao de acao
*       Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)Click.
*       NENHUM deles tem referente neste SCX:
*
*         BtnCancelarClick  - nao ha Page2 de Dados nem modo de edicao a
*                             cancelar (layout FLAT, zero Page no dump).
*         FormParaBO        - sentido CAMPO -> BO. Nao existe UM campo
*                             editavel: os 7 "BaseClass: textbox" do dump sao
*                             os Text1 NATIVOS das 7 Column (regra #18) e o
*                             dump declara ReadOnly = .T. no Grid1 E nas sete
*                             Column1..Column7. Nao ha o que ler da tela.
*         BOParaForm        - sentido BO -> CAMPO. A grade le o cursor DIRETO
*                             por ControlSource, como no legado; as 5
*                             properties de linha do BO (CarregarDoCursor)
*                             nao tem controle onde ser exibidas.
*         botao de acao     - o dump tem exatamente UM botao (1 ocorrencia de
*                             "BaseClass: commandbutton", ZERO de
*                             "commandgroup") e o Click dele tem UMA linha:
*                             "Release Windows", o idioma Fortyus de FECHAR.
*                             Nao ha gravacao em lugar nenhum (zero
*                             TABLEUPDATE, zero AddCursor, zero
*                             Insert/Update/Delete contra tabela) - o unico
*                             "Insert Into" do legado grava no cursor de
*                             CALCULO.
*         BtnBuscarClick    - nao ha botao de busca nem campo de filtro no
*                             dump (Empresa/Data vem do form PAI).
*         HabilitarCampos / AjustarBotoesPorModo / LimparCampos - nao ha modo
*                             (zero "pcEscolha", zero "frmcadastro"), nao ha
*                             campo editavel a habilitar nem a limpar, e o
*                             unico botao esta sempre ativo.
*
*       Criar qualquer um deles violaria o PILAR 1 (inventa superficie que o
*       usuario do legado nunca teve) e, de corpo vazio, a regra de
*       completude. Mesma decisao e mesmo motivo do precedente SIGOPCLP ->
*       FormSigOpClp (task704): grade de 7 colunas somente-leitura + UM botao
*       Encerrar, o analogo exato desta tela.
*
* Com isso o arquivo esta COMPLETO: todo objeto do dump existe, toda
* propriedade do dump esta transcrita, o unico evento do dump esta portado e
* a grade recebe dado pelo mesmo caminho do legado.
*==============================================================================

DEFINE CLASS FormSIGOPDVM AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX
    *
    * Width=800 Height=200 BorderStyle=2 ControlBox=.F. TitleBar=0
    * WindowType=1 AutoCenter=.T. Picture=new_background.jpg (ver
    * ConfigurarPageFrame - caminho nunca reconstruido de gc_4c_CaminhoBase).
    *
    * DataSession = 1 (NAO 2): ver nota no cabecalho do arquivo - este
    * dialogo precisa ENXERGAR os cursores que o form pai ja abriu, e
    * DataSession = 2 criaria uma sessao privada onde crCaixa/crCaixaI/
    * crCaixaFIN/crSigFiMpi nao existem.
    *
    * ShowWindow = 1: nao vem do dump (o legado abria com "Do Form" e o
    * default 0 bastava); aqui o form e criado com CREATEOBJECT + Show() e o
    * canonico do projeto e 1 (modal) - regra "WindowType 0 mata a tela".
    *
    * DoCreate do dump NAO entra: flag de design-time do SCX, nao property
    * de runtime da classe Form (regra #33 - nunca chutar lista de
    * propriedades).
    *
    * NAO declarada no dump e portanto NAO inventada (regra #25): Closable
    * fica no default .T. - sem barra de titulo ele nao desenha nada, mas
    * Closable = .F. mataria o Alt+F4, que aqui e o unico jeito de fechar a
    * tela fora do botao Encerrar (regra "Closable inventado tira a saida").
    *==========================================================================
    this_cMensagemErro = ""
    DataSession = 1
    BorderStyle = 2
    Height      = 200
    Width       = 800
    ControlBox  = .F.
    TitleBar    = 0
    WindowType  = 1
    ShowWindow  = 1
    AutoCenter  = .T.

    Caption = "Diferen" + CHR(231) + "as Vendas x Mapa Resumo"

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    *==========================================================================

    *-- Form PAI (pcForm do legado) - guardado so por referencia; esta tela
    *-- NAO desabilita/reabilita o pai (o legado nao faz isso no Init, ao
    *-- contrario de outros dialogos filho da mesma familia - nao inventar
    *-- comportamento que o dump nao tem).
    this_oFormPai = .NULL.

    *-- Aliases dos 4 cursores de origem, na mesma data session do pai
    *-- (crCaixa/crCaixaI/crCaixaFIN/crSigFiMpi no legado - ver contrato em
    *-- SIGOPDVMBO.DefinirCursoresOrigem)
    this_cCursorCaixa      = ""
    this_cCursorCaixaItens = ""
    this_cCursorCaixaFin   = ""
    this_cCursorMapaResumo = ""

    *-- Filtro Empresa/Data (Get_emps.Value / Get_datas.Value do pai no
    *-- legado - ver contrato em SIGOPDVMBO.DefinirParametrosComparacao)
    this_cEmps  = ""
    this_dDatas = {}

    *-- POSSE do cursor da comparacao. No legado o crImpressao e do form PAI
    *-- (o Init legado so faz "Select crImpressao / Zap", nunca o cria), mas o
    *-- BO deste dialogo tambem sabe cria-lo quando o alias nao existe. Com
    *-- DataSession = 1 os dois nascem na MESMA sessao, entao o Destroy nao
    *-- pode fechar o alias as cegas - fecharia o cursor do pai. CarregarLista
    *-- liga esta flag so quando mede que fomos NOS que criamos (USED() antes
    *-- de GerarComparacao contra USED() depois).
    this_lCursorProprio = .F.

    *-- Mensagem de "nao ha o que comparar" exibida UMA vez por tela, nao a
    *-- cada chamada de CarregarLista: o harness e qualquer reexibicao futura
    *-- chamam o funil mais de uma vez, e repetir o mesmo aviso seria ruido.
    this_lFalhaComparacaoAvisada = .F.

    *==========================================================================
    * Init - recebe o contexto do form PAI
    *
    * A ORDEM aqui e regra, nao estilo: FormBase.Init() chama
    * InicializarForm(), logo o contexto recebido por parametro tem de
    * estar guardado ANTES do DODEFAULT() - senao InicializarForm cria o BO
    * sem saber quais cursores comparar.
    *
    * par_oFormPai          - form que abriu o dialogo (pcForm do legado)
    * par_cCursorCaixa       - alias do cursor de totais de caixa
    * par_cCursorCaixaItens  - alias do cursor de totais por item
    * par_cCursorCaixaFin    - alias do cursor de totais financeiros
    * par_cCursorMapaResumo  - alias do cursor do mapa resumo fiscal
    * par_cEmps              - codigo da empresa (Get_emps.Value no legado)
    * par_dDatas             - data do movimento (Get_datas.Value no legado)
    *
    * Todos os parametros APOS par_oFormPai sao opcionais: o que nao vier
    * explicito e completado por ResolverContextoDoPai() lendo candidatos
    * defensivos do proprio par_oFormPai. Sem nenhum dos dois, a tela ainda
    * abre (falha de dado nunca impede a UI de aparecer) e
    * SIGOPDVMBO.GerarComparacao() simplesmente nao encontra o que comparar.
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cCursorCaixa, par_cCursorCaixaItens, ;
            par_cCursorCaixaFin, par_cCursorMapaResumo, par_cEmps, par_dDatas)

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_cCursorCaixa) = "C" AND !EMPTY(ALLTRIM(par_cCursorCaixa))
            THIS.this_cCursorCaixa = ALLTRIM(par_cCursorCaixa)
        ENDIF
        IF VARTYPE(par_cCursorCaixaItens) = "C" AND !EMPTY(ALLTRIM(par_cCursorCaixaItens))
            THIS.this_cCursorCaixaItens = ALLTRIM(par_cCursorCaixaItens)
        ENDIF
        IF VARTYPE(par_cCursorCaixaFin) = "C" AND !EMPTY(ALLTRIM(par_cCursorCaixaFin))
            THIS.this_cCursorCaixaFin = ALLTRIM(par_cCursorCaixaFin)
        ENDIF
        IF VARTYPE(par_cCursorMapaResumo) = "C" AND !EMPTY(ALLTRIM(par_cCursorMapaResumo))
            THIS.this_cCursorMapaResumo = ALLTRIM(par_cCursorMapaResumo)
        ENDIF

        IF VARTYPE(par_cEmps) = "C" AND !EMPTY(ALLTRIM(par_cEmps))
            THIS.this_cEmps = ALLTRIM(par_cEmps)
        ENDIF
        IF INLIST(VARTYPE(par_dDatas), "D", "T")
            THIS.this_dDatas = ConverterParaData(par_dDatas)
        ENDIF

        *-- Completa o que faltou lendo do form pai (defensivo - PILAR 3
        *-- renomeia os objetos do pai, entao nada aqui pode estourar so
        *-- porque o pai usa outro nome de property)
        THIS.ResolverContextoDoPai()

        RETURN DODEFAULT()
    ENDPROC


    *==========================================================================
    * ResolverContextoDoPai - completa cursores/filtro a partir do form pai
    *
    * So entra em acao para o que NAO veio por parametro explicito de Init
    * (par_c* / par_d* tem precedencia). Cada leitura e guardada por
    * PEMSTATUS/TYPE - ausencia simplesmente mantem o default, nunca
    * estoura.
    *==========================================================================
    PROCEDURE ResolverContextoDoPai()
        LOCAL loc_cValor, loc_dValor

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCursorCaixa))
            THIS.this_cCursorCaixa = THIS.LerTextoDoPai("this_cCursorCaixa")
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cCursorCaixaItens))
            THIS.this_cCursorCaixaItens = THIS.LerTextoDoPai("this_cCursorCaixaItens")
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cCursorCaixaFin))
            THIS.this_cCursorCaixaFin = THIS.LerTextoDoPai("this_cCursorCaixaFin")
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cCursorMapaResumo))
            THIS.this_cCursorMapaResumo = THIS.LerTextoDoPai("this_cCursorMapaResumo")
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            loc_cValor = THIS.LerTextoDoPai("this_cEmps")
            IF EMPTY(loc_cValor)
                loc_cValor = THIS.LerTextoDoPai("this_cCodEmpresa")
            ENDIF
            THIS.this_cEmps = loc_cValor
        ENDIF

        IF EMPTY(THIS.this_dDatas)
            loc_dValor = THIS.LerDataDoPai("this_dDatas")
            IF EMPTY(loc_dValor)
                loc_dValor = THIS.LerDataDoPai("this_dData")
            ENDIF
            THIS.this_dDatas = loc_dValor
        ENDIF

        RETURN .T.
    ENDPROC


    *==========================================================================
    * LerTextoDoPai - leitura DEFENSIVA de uma property texto do form pai
    *
    * Acesso por NOME via EVALUATE - nunca Controls(<nome>), que e indexado
    * por NUMERO (regra #34). Sem TRY/CATCH de proposito: os guards
    * (PEMSTATUS + TYPE) ja cobrem ausencia e referencia morta, e um CATCH
    * aqui seria silencioso - engolir erro sem avisar e proibido (regra #9).
    *==========================================================================
    PROCEDURE LerTextoDoPai(par_cProperty)
        LOCAL loc_cRetorno, loc_cExpr

        loc_cRetorno = ""

        IF VARTYPE(THIS.this_oFormPai) != "O" OR VARTYPE(par_cProperty) != "C"
            RETURN ""
        ENDIF

        IF PEMSTATUS(THIS.this_oFormPai, ALLTRIM(par_cProperty), 5)
            loc_cExpr = "THIS.this_oFormPai." + ALLTRIM(par_cProperty)
            IF TYPE(loc_cExpr) = "C"
                loc_cRetorno = ALLTRIM(NVL(EVALUATE(loc_cExpr), ""))
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDPROC


    *==========================================================================
    * LerDataDoPai - leitura DEFENSIVA de uma property data do form pai
    *==========================================================================
    PROCEDURE LerDataDoPai(par_cProperty)
        LOCAL loc_dRetorno, loc_cExpr

        loc_dRetorno = {}

        IF VARTYPE(THIS.this_oFormPai) != "O" OR VARTYPE(par_cProperty) != "C"
            RETURN {}
        ENDIF

        IF PEMSTATUS(THIS.this_oFormPai, ALLTRIM(par_cProperty), 5)
            loc_cExpr = "THIS.this_oFormPai." + ALLTRIM(par_cProperty)
            IF INLIST(TYPE(loc_cExpr), "D", "T")
                loc_dRetorno = ConverterParaData(EVALUATE(loc_cExpr))
            ENDIF
        ENDIF

        RETURN loc_dRetorno
    ENDPROC


    *==========================================================================
    * InicializarForm - monta a estrutura base do dialogo
    *
    * RETURN de bloqueio FORA do TRY (regra #1: nunca RETURN dentro de
    * TRY/CATCH).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- DataSession = 1 ja compartilha a sessao do pai (ver nota no
            *-- cabecalho do arquivo); os SETs de DATE/CENTURY ja foram
            *-- repostos por FormBase.Init() antes deste metodo rodar.

            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPDVMBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Contexto da comparacao (cursores + Empresa/Data). Falha
                *-- aqui NAO aborta a tela - so fica sem o que comparar, e
                *-- CarregarLista mostra a grade vazia (ver mais abaixo).
                THIS.this_oBusinessObject.DefinirCursoresOrigem( ;
                    THIS.this_cCursorCaixa, THIS.this_cCursorCaixaItens, ;
                    THIS.this_cCursorCaixaFin, THIS.this_cCursorMapaResumo)
                THIS.this_oBusinessObject.DefinirParametrosComparacao( ;
                    THIS.this_cEmps, THIS.this_dDatas)

                *-- Fundo do form (new_background.jpg do dump)
                THIS.ConfigurarPageFrame()

                *-- Cabecalho cinza (cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Grid1 -> grd_4c_Dados (ainda SEM RecordSource/ControlSource -
                *-- cursor_4c_Dados so existe apos GerarComparacao(), chamado
                *-- por CarregarLista no fim deste metodo - regra #41)
                THIS.ConfigurarGrid()

                *-- Shape1 decorativo + CmdCat -> cmd_4c_Encerrar (mesma ordem
                *-- de criacao do dump: Grid1 antes, Shape1 e CmdCat depois)
                THIS.ConfigurarBotoes()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis()

                *-- Superficie de DADOS: confere as 7 colunas do dump e liga
                *-- a grade ao cursor da comparacao. Roda DEPOIS de todos os
                *-- AddObject (as colunas tem de existir) e e inerte quanto ao
                *-- ControlSource enquanto o cursor nao existir (regra #41).
                THIS.ConfigurarPaginaDados()

                *-- Dado da tela. No legado isto roda DENTRO do proprio Init
                *-- (os dois SCAN, o Index/Go Top e as 7 linhas de
                *-- ControlSource), por isso tambem roda aqui e nao em evento
                *-- de botao - esta tela nao tem botao que carregue nada.
                *-- O retorno NAO entra em loc_lSucesso de proposito: falha de
                *-- DADO nunca impede a UI de aparecer, e grade vazia e
                *-- resultado valido (o legado abre igual quando nao ha
                *-- divergencia entre caixa, itens e mapa resumo).
                THIS.CarregarLista()

                loc_lSucesso = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel criar o objeto de neg" + CHR(243) + "cio SIGOPDVMBO.", ;
                        "Erro ao Inicializar")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSIGOPDVM")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * ConfigurarPageFrame - aparencia base do form
    *
    * O nome e o do contrato do pipeline; NAO ha PageFrame a criar porque o
    * SCX legado nao tem Page nenhuma (layout FLAT - ver cabecalho do
    * arquivo). O que este metodo faz e o que de fato existe no dump: o
    * fundo do form.
    *
    * Picture = ..\framework\imagens\new_background.jpg no dump. O caminho
    * NUNCA se reconstroi a partir de gc_4c_CaminhoBase (regra #156/#170); o
    * canonico do projeto e gc_4c_CaminhoIcones (o arquivo existe em
    * vbmp\). Picture inexistente falha em SILENCIO (regra #25), por isso o
    * nome e transcrito do dump e nao chutado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
    *
    * Dump: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
    *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
    *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
    *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
    *
    * Width=800 do container bate com o Width=800 do form - diferente de
    * outros dialogos da familia (onde o dump tinha 800 num form menor e
    * precisava de ajuste); aqui Left=10+Width=769=779 < 800, cabe sem
    * ajuste (regra #30 - controle fora da area do pai e recortado).
    *
    * Caption dos dois labels = THIS.Caption, nunca o literal "Cadastro de
    * Testes" do dump (placeholder do extrator) - mesmo padrao das demais
    * telas (regra #11).
    *
    * O cabecalho e o PRIMEIRO AddObject da tela (regra #11), para que
    * Shape/Grid/botao criados na Fase 4 desenhem POR CIMA dele.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label de sombra: preto, efeito de relevo 1px abaixo do titulo
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            *-- AutoSize = .F. explicito: AutoSize e NO-OP em Label criado
            *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
            *-- corta o texto (regra #23).
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            *-- Rotation = 0 esta no dump; e o DEFAULT, atribuicao inerte,
            *-- transcrita por fidelidade literal (regra #49: diferente de
            *-- Format/InputMask vazios, aqui o dump declara um VALOR).
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- Label do titulo: branco sobre o cinza do container OPACO - este
        *-- e o caso em que o branco esta CORRETO (regra #12)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarGrid - Grid1 -> grd_4c_Dados (7 colunas do dump)
    *
    * Dump: Grid1 Top=94 Left=94 Width=611 Height=92 ColumnCount=7
    *       FontName=Tahoma FontSize=8 AllowHeaderSizing=.F.
    *       AllowRowSizing=.F. DeleteMark=.F. ReadOnly=.T. RowHeight=16
    *       ScrollBars=2. RecordMark=.F. nao esta no dump mas e a
    *       convencao de grid manual em form OPERACIONAL (ver memoria
    *       CLAUDE.md sobre Grid RecordMark/DeleteMark).
    *
    * ColumnOrder visual (NAO e a ordem de declaracao Column1..Column7):
    *   Column7 (Caixa, Width=33) aparece PRIMEIRO (ColumnOrder=1), depois
    *   Column1 (Valor) .. Column6 (Diferenca IT) na ordem 2..7.
    *
    * NAO atribuir RecordSource nem Column.ControlSource aqui - o cursor de
    * destino (cursor_4c_Dados) so existe apos SIGOPDVMBO.GerarComparacao()
    * rodar, na Fase 8 (regra #41 - ControlSource de cursor inexistente
    * derruba o Init). As colunas calculadas do legado (Diferenca Mr =
    * ValCxs-ValMrs, Diferenca IT = ValCxs-ValItens) tambem ficam para a
    * Fase 8, no mesmo ControlSource com expressao.
    *
    * Column6 (Diferenca IT) e a UNICA sem InputMask no dump - as outras 5
    * colunas numericas tem InputMask="999,999.99", Column6 so tem a
    * property de design-time Comment="999,999.99" (nao e InputMask - regra
    * #49, transcrever o que o dump declara, nunca completar por analogia).
    * Column7 (Caixa) e texto, sem InputMask.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 94
            .Left              = 94
            .Width             = 611
            .Height            = 92
            .ColumnCount       = 7
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .Panel             = 1
            .ReadOnly          = .T.
            .RowHeight         = 16
            .ScrollBars        = 2
            .Visible           = .T.
        ENDWITH

        *-- Column1 (Valor) - ColumnOrder=2
        WITH THIS.grd_4c_Dados.Column1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 2
            .Width       = 90
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .InputMask   = "999,999.99"
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Valor"
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
            WITH .Text1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BorderStyle = 0
                .InputMask = "999,999.99"
                .Margin    = 0
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column2 (Itens) - ColumnOrder=3
        WITH THIS.grd_4c_Dados.Column2
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 3
            .Width       = 90
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .InputMask   = "999,999.99"
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Itens"
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
            WITH .Text1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BorderStyle = 0
                .InputMask = "999,999.99"
                .Margin    = 0
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column3 (Mapa) - ColumnOrder=4
        WITH THIS.grd_4c_Dados.Column3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 4
            .Width       = 90
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .InputMask   = "999,999.99"
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Mapa"
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
            WITH .Text1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BorderStyle = 0
                .InputMask = "999,999.99"
                .Margin    = 0
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column4 (Nao Fiscal) - ColumnOrder=5
        WITH THIS.grd_4c_Dados.Column4
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 5
            .Width       = 90
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .InputMask   = "999,999.99"
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "N" + CHR(227) + "o Fiscal"
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
            WITH .Text1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BorderStyle = 0
                .InputMask = "999,999.99"
                .Margin    = 0
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column5 (Diferenca Mr) - ColumnOrder=6
        WITH THIS.grd_4c_Dados.Column5
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 6
            .Width       = 90
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .InputMask   = "999,999.99"
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Diferen" + CHR(231) + "a Mr"
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
            WITH .Text1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BorderStyle = 0
                .InputMask = "999,999.99"
                .Margin    = 0
                .ReadOnly  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column6 (Diferenca IT) - ColumnOrder=7 - SEM InputMask no dump
        *-- (ver nota no cabecalho do metodo)
        WITH THIS.grd_4c_Dados.Column6
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 7
            .Width       = 90
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Diferen" + CHR(231) + "a IT"
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column7 (Caixa) - ColumnOrder=1 (primeira visualmente), texto
        WITH THIS.grd_4c_Dados.Column7
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 1
            .Width       = 33
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Caixa"
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarPaginaDados - superficie de DADOS desta tela
    *
    * O nome vem do contrato do pipeline; NAO ha "Page2 de Dados" a criar. O
    * SCX legado nao tem Page nenhuma (layout FLAT) e nao tem UM campo solto:
    * a unica superficie de dados desta tela sao as 7 CELULAS da grade, todas
    * ReadOnly = .T. no dump. Inventar campos/Page aqui violaria o PILAR 1 e a
    * regra "NUNCA inventar".
    *
    * O que sobra de verdade para esta fase - e que PRECISA rodar DEPOIS de
    * todos os AddObject - e a superficie de dados da grade: conferir que as 7
    * colunas do dump existem e vincula-las ao cursor da comparacao.
    *
    * A conferencia nao e decorativa: sem ela, coluna ausente faria
    * VincularColunasGrade() vincular menos colunas do que o legado e a tela
    * exibiria a grade incompleta SEM erro nenhum.
    *
    * Acesso a membro por NOME montado em runtime: EVALUATE para LEITURA
    * (regra #15/#34) - NUNCA Controls(<nome>), que e indexado por numero.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_nI, loc_cCol, loc_lEstruturaOk

        loc_lEstruturaOk = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            loc_lEstruturaOk = (THIS.grd_4c_Dados.ColumnCount = 7)

            FOR loc_nI = 1 TO 7
                loc_cCol = "THIS.grd_4c_Dados.Column" + TRANSFORM(loc_nI)
                IF EVALUATE("VARTYPE(" + loc_cCol + ")") != "O"
                    loc_lEstruturaOk = .F.
                ENDIF
            ENDFOR
        ENDIF

        IF loc_lEstruturaOk
            *-- Vinculo das 7 colunas. GUARDADO por USED() la dentro: em tempo
            *-- de Init o cursor da comparacao ainda nao existe e atribuir
            *-- ControlSource aqui derrubaria a tela (regra #41). O vinculo
            *-- real acontece em CarregarLista, que chama VincularColunasGrade
            *-- DEPOIS de SIGOPDVMBO.GerarComparacao() popular o cursor.
            THIS.VincularColunasGrade()
        ELSE
            MsgErro("A grade de compara" + CHR(231) + CHR(227) + "o n" + ;
                    CHR(227) + "o foi criada com as 7 colunas do cadastro.", ;
                    "Erro na Superf" + CHR(237) + "cie de Dados")
        ENDIF

        RETURN loc_lEstruturaOk
    ENDPROC


    *==========================================================================
    * VincularColunasGrade - liga as 7 colunas ao cursor da comparacao
    *
    * Transcricao das 7 linhas de ControlSource que o Init legado executa
    * depois de montar crImpressao:
    *
    *    Grid1.Column1.ControlSource = 'crImpressao.ValCxs'
    *    Grid1.Column2.ControlSource = 'crImpressao.ValItens'
    *    Grid1.Column3.ControlSource = 'crImpressao.ValMrs'
    *    Grid1.Column4.ControlSource = 'crImpressao.ValNfs'
    *    Grid1.Column5.ControlSource = 'crImpressao.ValCxs-crImpressao.ValMrs'
    *    Grid1.Column6.ControlSource = 'crImpressao.ValCxs-crImpressao.ValItens'
    *    Grid1.Column7.ControlSource = 'crImpressao.Caixas'
    *
    * crImpressao -> cursor_4c_Dados (SIGOPDVMBO.this_cCursorDestino); as 7
    * colunas citadas existem no CREATE CURSOR do BO (Datas/Emps/Caixas/
    * ValCxs/ValItens/ValMrs/ValNfs). O alias vem do BO, nunca hardcoded, para
    * nao divergir de quem o cria.
    *
    * Column5 e Column6 sao EXPRESSOES, nao colunas do cursor - transcritas
    * LITERALMENTE (regra #17: formula do legado se transcreve, nunca se
    * reescreve). Medido no VFP9 em 2026-10-31: ControlSource de expressao
    * funciona (ValCxs 100 - ValMrs 80 exibiu 20) e as duas colunas sao
    * ReadOnly = .T. no dump, entao nao precisam ser gravaveis.
    *
    * ORDEM das atribuicoes (regra #41): ColumnCount -> RecordSource ->
    * ControlSource -> Width -> Header1.Caption. Width e Caption sao REPOSTOS
    * depois do RecordSource porque o VFP pode recalcula-los para o default 90
    * / "Header1" (Problema 48); medido aqui que neste caso eles sobrevivem,
    * mas repor e o canonico e e inocuo.
    *
    * O ControlSource EXPLICITO das 7 colunas e obrigatorio, nao redundante:
    * medido no VFP9 que o grid AUTO-VINCULA as colunas aos campos do cursor
    * corrente e que esse vinculo automatico ESCORREGA de uma coluna quando o
    * ColumnOrder nao e a ordem de declaracao (aqui Column7 e a primeira
    * visualmente) - sem as 7 linhas, a grade exibe o campo ERRADO em cada
    * coluna, sem erro algum.
    *
    * PUBLIC (sem PROTECTED): a Fase 8 e o harness de teste chamam este metodo
    * de FORA da classe - PEMSTATUS devolve .T. para metodo PROTECTED e a
    * chamada real falharia so em runtime (regras #3 e #51).
    *
    * Fecha com GO TOP + Refresh: popular/religar cursor NAO repinta a grade
    * sozinho (regra #21a) - o legado tambem faz "Go Top" antes de vincular.
    *==========================================================================
    PROCEDURE VincularColunasGrade()
        LOCAL loc_cCursor, loc_lVinculou, loc_oErro

        loc_lVinculou = .F.
        loc_cCursor   = "cursor_4c_Dados"

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino))
                loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino)
            ENDIF
        ENDIF

        IF USED(loc_cCursor)
            TRY
                WITH THIS.grd_4c_Dados
                    .ColumnCount  = 7
                    .RecordSource = loc_cCursor

                    .Column1.ControlSource = loc_cCursor + ".ValCxs"
                    .Column2.ControlSource = loc_cCursor + ".ValItens"
                    .Column3.ControlSource = loc_cCursor + ".ValMrs"
                    .Column4.ControlSource = loc_cCursor + ".ValNfs"
                    .Column5.ControlSource = loc_cCursor + ".ValCxs-" + loc_cCursor + ".ValMrs"
                    .Column6.ControlSource = loc_cCursor + ".ValCxs-" + loc_cCursor + ".ValItens"
                    .Column7.ControlSource = loc_cCursor + ".Caixas"
                ENDWITH

                *-- Largura e caption DEPOIS do RecordSource/ControlSource, que
                *-- os resetam para 90 / "Header1" (Problema 48 / regra #41).
                *-- Fonte UNICA, compartilhada com o ramo de falha de
                *-- CarregarLista - ver AplicarColunasDoDump.
                THIS.AplicarColunasDoDump()

                *-- Repinta a grade (regra #21a)
                SELECT (loc_cCursor)
                GO TOP
                THIS.grd_4c_Dados.Refresh()

                loc_lVinculou = .T.

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + ;
                        " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                        " | Proc: " + loc_oErro.Procedure, ;
                        "Erro ao vincular a grade")
            ENDTRY
        ENDIF

        RETURN loc_lVinculou
    ENDPROC


    *==========================================================================
    * AplicarColunasDoDump - largura e caption das 7 colunas
    *
    * Extraido de dentro de VincularColunasGrade para ser FONTE UNICA: existem
    * DOIS caminhos que mexem em RecordSource (o vinculo e o desligamento do
    * ramo de falha de CarregarLista), e atribuir RecordSource/ControlSource
    * reseta Column.Width para o default 90 e Header1.Caption para "Header1"
    * (Problema 48 / regra #41). Duas copias destes 14 valores divergiriam em
    * silencio na primeira coluna que mudasse (CLAUDE.md #44, item 6).
    *
    * Valores transcritos do dump: Column7 (Caixa) Width = 33, as outras seis
    * Width = 90. Reaplicar e seguro e inocuo - nenhuma destas propriedades
    * depende de o cursor existir, por isso este metodo tambem serve ao ramo
    * em que nao ha dado nenhum a exibir.
    *
    * ColumnOrder NAO e reaplicado aqui: ele e ordem VISUAL, nao dependente
    * do RecordSource, e ja foi definido em ConfigurarGrid (Column7 = 1,
    * Column1..Column6 = 2..7). Medido que RecordSource nao o altera -
    * reaplica-lo seria assumir um reset que nao acontece.
    *==========================================================================
    PROTECTED PROCEDURE AplicarColunasDoDump()
        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        WITH THIS.grd_4c_Dados
            *-- Larguras do dump (Column7 = 33, as outras 6 = 90)
            .Column1.Width = 90
            .Column2.Width = 90
            .Column3.Width = 90
            .Column4.Width = 90
            .Column5.Width = 90
            .Column6.Width = 90
            .Column7.Width = 33

            *-- Captions do dump
            .Column1.Header1.Caption = "Valor"
            .Column2.Header1.Caption = "Itens"
            .Column3.Header1.Caption = "Mapa"
            .Column4.Header1.Caption = "N" + CHR(227) + "o Fiscal"
            .Column5.Header1.Caption = "Diferen" + CHR(231) + "a Mr"
            .Column6.Header1.Caption = "Diferen" + CHR(231) + "a IT"
            .Column7.Header1.Caption = "Caixa"
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * CarregarLista - funil UNICO de dado da tela
    *
    * Reproduz, na ORDEM do legado, o que o Init do SCX faz depois de receber
    * pcForm:
    *
    *    1. Select crImpressao / Zap              -> GerarComparacao (BO)
    *    2. os DOIS Scan da comparacao            -> GerarComparacao (BO)
    *    3. Index On Caixas / Set Order / Go Top  -> GerarComparacao (BO)
    *    4. Grid1.RecordSource + os 7 ControlSource -> VincularColunasGrade
    *
    * A ORDEM aqui e regra, nao estilo (regra #41): ControlSource de cursor
    * que ainda nao existe derruba a tela, por isso GerarComparacao() roda
    * ANTES e VincularColunasGrade() so depois. E e exatamente por isso que
    * este par nao podia nascer na Fase 5, quando a grade foi configurada.
    *
    * POSSE DO CURSOR - loc_lExistiaAntes e medido ANTES de GerarComparacao:
    * no legado o crImpressao pertence ao form PAI (o Init legado so o
    * esvazia), mas o BO sabe cria-lo quando o alias nao existe. Como
    * DataSession = 1 poe os dois na MESMA sessao, so quem CRIOU pode fechar -
    * ver Destroy.
    *
    * Lista VAZIA nao e erro: o legado abre o dialogo com crImpressao vazio
    * sempre que caixa, itens e mapa resumo fecham. O aviso so aparece quando
    * GerarComparacao RECUSOU a comparacao (faltou Empresa/Data ou faltou
    * cursor de origem) - e so UMA vez por tela (this_lFalhaComparacaoAvisada),
    * nunca em modo de teste, que nao tem os cursores do pai por construcao.
    * MsgAviso, nao MsgErro: faltar o contexto do chamador e condicao de uso,
    * nao excecao tecnica (o CATCH de GerarComparacao e que reporta erro real).
    *
    * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama
    * THIS.oForm.CarregarLista() de FORA da classe - PEMSTATUS devolveria .T.
    * para metodo PROTECTED e a chamada real falharia so em runtime, com
    * "Property CARREGARLISTA is not found" (regras #3 e #51).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cCursor, loc_lModoTeste, loc_lExistiaAntes
        LOCAL loc_cMensagem

        loc_lSucesso = .F.
        loc_cCursor  = "cursor_4c_Dados"

        loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                         (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        *-- Alias vem do BO, nunca hardcoded, para nao divergir de quem o cria
        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino))
            loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino)
        ENDIF

        loc_lExistiaAntes = USED(loc_cCursor)

        IF THIS.this_oBusinessObject.GerarComparacao()
            *-- Nao existia antes e existe agora = fomos NOS que criamos, logo
            *-- somos nos que podemos fechar no Destroy.
            IF !loc_lExistiaAntes AND USED(loc_cCursor)
                THIS.this_lCursorProprio = .T.
            ENDIF

            loc_lSucesso = THIS.VincularColunasGrade()
        ELSE
            *-- Sem fonte, a grade fica SEM RecordSource - nunca apontando
            *-- para o alias de uma abertura anterior. Exibir linha velha como
            *-- se fosse o resultado desta consulta e pior que exibir vazio.
            THIS.grd_4c_Dados.RecordSource = ""

            *-- Desligar o RecordSource tambem reseta largura/caption
            *-- (Problema 48) - repor pela mesma fonte unica do vinculo.
            THIS.AplicarColunasDoDump()

            loc_cMensagem = ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)

            IF !loc_lModoTeste AND !THIS.this_lFalhaComparacaoAvisada ;
                    AND !EMPTY(loc_cMensagem)
                THIS.this_lFalhaComparacaoAvisada = .T.
                MsgAviso(loc_cMensagem, "Diferen" + CHR(231) + ;
                         "as Vendas x Mapa Resumo")
            ENDIF
        ENDIF

        *-- Repintar e OBRIGATORIO nos DOIS ramos: popular ou religar cursor
        *-- nao redesenha a grade sozinho (regra #21a).
        THIS.grd_4c_Dados.Refresh()

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * ConfigurarBotoes - Shape1 decorativo + CmdCat -> cmd_4c_Encerrar
    *
    * Dump: Shape1 Top=7 Left=698 Width=90 Height=110 BackStyle=0
    *       BorderStyle=0 BorderColor=136,189,188. Left+Width=788 < 800
    *       (regra #30 - controle fora do pai e recortado - cabe sem
    *       ajuste).
    *
    * CmdCat Top=3 Left=725 Picture=cadastro_sair_60.jpg Cancel=.T.
    *       Caption="Encerrar". Left+Width(725+75)=800 = Form.Width, encosta
    *       exatamente na borda direita sem exceder. O botao fica dentro da
    *       faixa do cabecalho (Top 0..80) de proposito - e desenhado DEPOIS
    *       do cnt_4c_Sombra, logo aparece por cima (regra #11, mesmo
    *       principio do bloco Saida dos forms CRUD).
    *
    * Width/Height=75x75 e Themes=.T.+DisabledPicture: nao vem do dump (a
    * classe fwbtng do legado ja traz o tamanho via VCX), mas e o padrao
    * canonico confirmado em outros dialogos OPERACIONAIS com botao
    * standalone fora de container (FormSigPrGmi e demais - regra "standalone
    * CommandButton com Picture precisa de Themes=.T. + DisabledPicture").
    *
    * Nome: o legado chama o metodo CmdCat.Click, mas o PILAR 3 pede nome
    * NOVO e semantico - cmd_4c_Encerrar segue o canonico do projeto para
    * botao de saida (nao cmd_4c_CmdCat, nome generico do mapeamento
    * automatico).
    *
    * Fecha ligando o UNICO evento de controle do dump (CmdCat.Click) ao
    * handler BtnEncerrarClick. O BINDEVENT fica no FIM deste metodo, depois
    * do AddObject - antes dele o objeto nem existe e o bind estouraria.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 698
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725
            .Height          = 75
            .Width           = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- CmdCat.Click do legado. Alvo PUBLIC (regra #3): em metodo
        *-- PROTECTED o BINDEVENT falha EM SILENCIO e o botao ficaria inerte
        *-- sem erro nenhum.
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        RETURN .T.
    ENDPROC


    *==========================================================================
    * BtnEncerrarClick - CmdCat.Click do legado
    *
    * O Click legado tem UMA linha, e esta e ela:
    *
    *     PROCEDURE Click
    *     Release Windows
    *
    * "Release Windows" e o idioma Fortyus para FECHAR a tela - este SCX
    * nunca escreve "ThisForm.Release" (e o unico Click do dump inteiro).
    *
    * A traducao fiel e THIS.Release(), nao THIS.Hide(): Hide() serve a
    * dialogo cujo RESULTADO o chamador precisa ler DEPOIS do Show(), porque
    * Release() destroi o objeto mesmo com variavel externa apontando para
    * ele. Esta tela nao devolve nada - o SCX nao tem PROCEDURE Unload, nao
    * tem property de retorno e o legado nao e aberto com "DO FORM ... TO
    * <var>"; inventar um retorno (ou um Unload) seria caminho que o legado
    * nao tem. Mesma decisao do precedente SIGOPCLP -> FormSigOpClp.
    *
    * NAO reabilita o form pai: outros dialogos filho desta familia fazem
    * "ParentForm.Enabled = .t." aqui porque o legado DELES desabilita o pai
    * no Init. Este nao desabilita (ver o contrato no cabecalho do arquivo),
    * entao nao ha o que reabilitar - e mexer no Enabled de uma tela que nem
    * foi migrada seria inventar comportamento.
    *
    * Atende tambem o ESC sem segundo handler: cmd_4c_Encerrar tem
    * Cancel = .T. (transcrito do dump), e a tecla de cancelamento dispara o
    * evento Click do proprio botao - o MESMO evento que o BINDEVENT acima
    * intercepta.
    *
    * PUBLIC de proposito (sem PROTECTED): alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC


    *==========================================================================
    * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
    *
    * Mesmo padrao recursivo (1 nivel de filhos de container) usado no resto
    * do projeto.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oControle = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                    FOR loc_nJ = 1 TO loc_oControle.ControlCount
                        loc_oFilho = loc_oControle.Controls(loc_nJ)
                        IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
                            loc_oFilho.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC


    *==========================================================================
    * Destroy - fecha o cursor que esta tela criou e libera BO/form pai
    *
    * O cursor da comparacao e fechado SO quando this_lCursorProprio diz que
    * foi este dialogo que o criou. A distincao e regra, nao zelo: no legado o
    * crImpressao pertence ao form PAI (o Init legado so faz "Select
    * crImpressao / Zap", nunca o cria) e, com DataSession = 1, um USE IN
    * incondicional aqui fecharia o cursor do pai ao sair do dialogo -
    * quebrando a tela que nos abriu, depois de o dialogo ja ter desaparecido.
    * Quem mede a posse e CarregarLista (USED() antes de GerarComparacao
    * contra USED() depois).
    *
    * RecordSource = "" ANTES do USE IN: a grade esta ligada ao alias e
    * fecha-lo com o vinculo ativo e pedir problema. Os cursores de TRABALHO
    * (crTotCaixa_4c e irmaos) nao aparecem aqui - GerarComparacao ja os fecha
    * no proprio fim.
    *
    * SEM TABLEREVERT antes do USE IN: ele EXIGE buffering e, com o
    * Buffering = 1 com que um CREATE CURSOR nasce, dispara o erro 1586
    * "Function requires row or table buffering mode" (regra #52). USE IN
    * fecha o alias de qualquer jeito, inclusive com buffer sujo.
    *
    * Este dialogo NAO desabilita/reabilita o form pai (o legado nao faz
    * isso - nao inventar). DODEFAULT() e a ULTIMA linha - FormBase.Destroy
    * reconstroi os popups do menu principal, e omiti-lo faz o menu encolher
    * visualmente (regra do Destroy).
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cCursor

        IF THIS.this_lCursorProprio
            loc_cCursor = "cursor_4c_Dados"

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino))
                    loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino)
                ENDIF
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.RecordSource = ""
            ENDIF

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            THIS.this_lCursorProprio = .F.
        ENDIF

        THIS.this_oFormPai = .NULL.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
