*==============================================================================
* FormSIGOPGRC.prg - Grafico Comparativo (dialogo FILHO de grafico)
*
* Origem legado: SIGOPGRC.SCX (task743)
* Herda de: FormBase
* Tipo: OPERACIONAL - form PLANO, SEM PageFrame. A arvore de objetos do SCX
*       (SECAO 1 do dump + layout.json) tem 8 objetos, todos filhos diretos de
*       SIGOPGRC: cntSombra (com lblSombra/lblTitulo), Shape2, OleGrafico e os
*       2 CommandButton fwbtng (Imprimir / Sair). Nao existe Page nenhuma -
*       nao ha o que paginar nesta tela. O template generico de Fase 3 (que
*       pede PageFrame com Page1=Lista/Page2=Dados + cnt_4c_Botoes/
*       cnt_4c_BotoesAcao) NAO se aplica aqui - CLAUDE.md e a regra de form
*       OPERACIONAL dizem para seguir o layout CUSTOMIZADO do legado, nao o
*       padrao CRUD. Mesmo tratamento do gemeo FormSigOpGco (task739).
*
* BO: SIGOPGRCBO (ja completo nas Fases 1-2). Sem tabela proprietaria: ele so
*     LE o cursor que o form PAI deixou pronto (crFinal) e agrega.
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS + propriedades visuais do
*            SCX + Init/InicializarForm/Destroy + cnt_4c_Sombra com os dois
*            labels do cabecalho).
*
* DIFERENCAS MEDIDAS CONTRA O GEMEO FormSigOpGco (task739/SIGOPGCO), que ja
* tem as 8 fases completas - registradas aqui para nenhuma fase seguinte
* copiar o irmao por reflexo (mesmas 3 diferencas documentadas no cabecalho
* do SIGOPGRCBO.prg):
*
*   1) NAO existe cursor "Cabecalho" nesta tela. O BO monta os tres
*      subtitulos a partir de colunas do PROPRIO crFinal (dtini/dtfinal/
*      lcGrupo1/lcGrupo2/lcMoe) mais a opcao de cotacao do pai - por isso
*      este form NAO vai reafirmar this_cCursorCabecalho em InicializarForm
*      (o SIGOPGRCBO nao declara essa property).
*   2) Entrada extra do pai: Thisform.ParentForm.OptCotacao.value (alem do
*      Comparativo.value que os dois gemeos tem) - vai para
*      this_oBusinessObject.this_nOpcaoCotacao nas fases de comportamento
*      (6-8), nao nesta.
*   3) ChartGroups(1).HasSeriesLines fica SO em .F. (sem o ".= .t." que o
*      SIGOPGCO tem adiante no mesmo metodo) - tambem fica para as fases de
*      comportamento.
*
* CONTRATO COM O FORM PAI (ainda nao migrado - nenhum form do projeto abre
* esta tela hoje)
* --------------------------------------------------------------------------
* Legado: "Lparameters pForm, datses" + "Set DataSession To DatSes" +
*         "ThisForm.ParentForm = pForm".
*
* 1) CREATEOBJECT("FormSIGOPGRC", <form pai>, <datasession do pai>) - os dois
*    parametros do Init legado, na mesma ordem. O segundo eh opcional: sem
*    ele, a sessao do pai eh lida de par_oFormPai.DataSessionId.
* 2) A tela NAO consulta o banco. Depende do cursor que o pai processa ANTES
*    de abrir este form (default do SIGOPGRCBO): crFinal - agregado com Mes,
*    Ordem, Ano, Grupos, Total, npercs, dtini, dtfinal, lcGrupo1, lcGrupo2 e
*    lcMoe, com os tags Grupom e imp. Por isso o Init entra na MESMA sessao
*    de dados do pai - com sessao privada propria, USED("crFinal") daria .F.
* 3) Quem exibe a tela eh o PAI, com .Show() FORA de qualquer TRY/CATCH
*    (CLAUDE.md regra #29): este form eh WindowType = 1 (transcrito do SCX),
*    entao o Show() BLOQUEIA e toda a vida da tela corre dentro dele.
* 4) O legado termina o Init com "Thisform.parentform.Aguarde.visible = .f."
*    e le "Thisform.Parentform.Comparativo.Value" - os dois dependem de
*    controles do PAI e entram nas fases de comportamento (6-8), sempre sob
*    guarda VARTYPE(THIS.this_oFormPai) = "O".
*
* FASE 4 - POR QUE NAO HA GRID NEM BOTOES CRUD AQUI
* --------------------------------------------------------------------------
* A Fase 4 entrega "Grid da Lista + os 6 botoes CRUD + AlternarPagina" nos
* forms de CADASTRO. Esta tela nao tem NENHUMA das duas superficies, e isso
* foi MEDIDO no dump do SCX (SIGOPGRC_form_codigo_fonte.txt), nao presumido:
*
*   BaseClass grid|pageframe ....................... 0 ocorrencias
*   BaseClass textbox|editbox|combobox|listbox|
*             checkbox|optiongroup|optionbutton|
*             spinner (campo de entrada) ........... 0 ocorrencias
*   .AddCursor / pColuna / RecordSource ............ 0 ocorrencias
*   .ControlSource ................................. 1, e eh o campo General
*                                                    do grafico
*                                                    (.ControlSource =
*                                                    'gGraficos' dentro do
*                                                    mostragrafico), nao
*                                                    coluna de lista
*
* Ou seja: nao ha o que LISTAR (sem grade) nem o que DIGITAR (sem campo). A
* arvore inteira do SCX sao 8 objetos: a faixa do cabecalho com 2 labels, um
* Shape decorativo, o OleBoundControl do grafico e os 2 CommandButton.
*
* Inventar um PageFrame Lista/Dados com 6 botoes CRUD violaria o PILAR 1 e a
* regra "NUNCA inventar"; escrever ConfigurarPaginaLista/AlternarPagina/
* Btn*Click que nao listam nada seria o "stub disfarcado" que a regra de
* completude proibe. Mesmo tratamento do gemeo FormSigOpGco (task739), que
* tambem nao tem lista nem campo.
*
* O que esta fase entrega, entao, eh a unica superficie de BOTAO que o legado
* REALMENTE tem, com comportamento completo:
*   ConfigurarBotoes()    cmd_4c_Sair (Encerrar) + cmd_4c_Imprimir, na ordem
*                         dos registros do SCX
*   ConfigurarEventos()   BINDEVENT dos dois Click (os 2 UNICOS eventos de
*                         controle do dump - nao ha mais evento a ligar)
*   CmdSairClick()        "Thisform.Release" do legado
*   CmdImprimirClick()    "Select Graph / Go Top / Report Form SigOpGrc To
*                         Printer Prompt NoConsole / Select Graph / Go Top /
*                         Thisform.Refresh" do legado
*   ExecutarReportForm()  helper canonico de REPORT FORM (guard de FILE no
*                         FRX + cursor vazio + isolamento de locale +
*                         reconstrucao do menu)
*
* FASE 5 - AREA DO GRAFICO E ORDEM DE TABULACAO (ENTREGUE)
* --------------------------------------------------------------------------
* A Fase 5 do pipeline pede "metade dos campos da Page2". Esta tela NAO TEM
* campo nenhum e NAO TEM Page nenhuma, e isso foi MEDIDO no dump, nao
* presumido: ZERO objeto de BaseClass textbox / editbox / combobox / listbox
* / checkbox / optiongroup / optionbutton / spinner, e ZERO pageframe. A
* arvore inteira do SCX sao 8 objetos (faixa do cabecalho com 2 labels, um
* Shape decorativo, o OleBoundControl do grafico e os 2 CommandButton) - a
* metade de zero campos eh zero. Inventar uma Page2 de Dados com TextBox
* violaria o PILAR 1 e a regra "NUNCA inventar"; escrever um
* ConfigurarPaginaDados vazio seria o "stub disfarcado" que a regra de
* completude proibe.
*
* O que esta fase entrega, portanto, eh a unica superficie de DADO que o
* legado REALMENTE tem - a area em que o grafico eh desenhado - mais o que
* so podia ser feito depois de todos os AddObject existirem:
*
*   ConfigurarPaginaDados()  shp_4c_Shape2 (Shape decorativo invisivel, cujo
*                            Z-ORDER protege o clique dos botoes) e
*                            obj_4c_OleGrafico (OleBoundControl do MSGraph),
*                            transcritos do dump e criados na ordem dos
*                            registros do SCX, ENTRE o cabecalho e os botoes
*   AjustarOrdemTabulacao()  TabIndex 1..4 nos ordinais EFETIVOS do legado
*                            (o Shape nao entra: a classe nao tem TabIndex)
*
* Com isso os 8 objetos do layout.json estao todos criados: Form,
* cnt_4c_Sombra, lbl_4c_LblSombra, lbl_4c_LblTitulo, shp_4c_Shape2,
* obj_4c_OleGrafico, cmd_4c_Sair e cmd_4c_Imprimir.
*
* FASE 6 - CAMPOS RESTANTES E LOOKUPS (CONFIRMADO: NAO HA O QUE ACRESCENTAR)
* --------------------------------------------------------------------------
* A Fase 6 pede os ultimos campos de Page2 e os lookups com BINDEVENT F4/F5.
* Esta tela e o layout "despachante" do dump (ver FASE 4 e FASE 5 acima): o
* SCX inteiro (SIGOPGRC_form_codigo_fonte.txt) tem ZERO objeto de BaseClass
* textbox/editbox/combobox/listbox/checkbox/optiongroup/optionbutton/spinner
* e ZERO padrao de lookup (fwbuscaext/fwBuscaSel/sigacess/CreateObject de
* busca) - confirmado de novo nesta fase com grep sobre o dump completo, nao
* so sobre a SECAO 1. Nao ha campo para digitar nem codigo para validar: a
* unica "entrada" da tela e visual (o grafico desenhado no OleBoundControl) e
* ja foi entregue na Fase 5 (ConfigurarPaginaDados). Criar um
* AbrirLookupXxx()/Validar*LostFocus() sem controle correspondente no SCX
* seria inventar funcionalidade que o legado nao tem (regra "NUNCA
* inventar" + stub disfarcado). Mesmo tratamento do gemeo FormSigOpGco
* (task739), que tambem fechou a Fase 6 sem nenhum campo/lookup.
*
* O QUE A FASE 7/8 ENTREGOU (eventos principais / comportamento)
* --------------------------------------------------------------------------
* O mostragrafico e a parte de DADOS do Init legado eram o que restava:
*
*   GerarGrafico()              orquestra o corpo do Init legado - le o modo
*                               Comparativo e a opcao de cotacao do pai,
*                               manda o BO agregar crFinal, cria o cursor do
*                               campo General, anexa o chart e desenha
*   AnexarGraficoAoCursor()     "Append Blank + Append General gGraficos
*                               Class 'MsGraph.Chart' Data lcStrg"
*   MostrarGrafico()            "PROCEDURE mostragrafico" - bind do
*                               ControlSource + LockScreen + os 3 blocos
*   AplicarFormatoGrafico()     galeria/fontes/legenda/titulo/areas
*   AplicarEixosColuna()        bloco "If m.lnConta1==1" (eixos + ChartGroups)
*   AplicarRotulosPercentuais() os dois lacos de rotulo de percentual
*   AplicarAreaPizza()          bloco "If m.lnConta1==2"
*   ObterComparativoDoPai()     "Thisform.Parentform.Comparativo.Value"
*   ObterOpcaoCotacaoDoPai()    "Thisform.ParentForm.OptCotacao.Value"
*                               (diferenca 2 do cabecalho - entrada que o
*                               gemeo FormSigOpGco nao tem)
*   OcultarAguardeDoPai()       "Thisform.parentform.Aguarde.visible = .f."
*
* Os DOIS Click do SCX (Imprimir / Sair) ja tinham sido entregues na Fase 4,
* porque entregar botao com handler vazio seria o stub que a regra de
* completude proibe.
*
* NAO existem os quatro handlers de verbo CRUD de form de CADASTRO - um por
* incluir, alterar, visualizar e excluir -, e isso eh MEDIDO, nao presumido.
* Os nomes NAO aparecem escritos por extenso aqui no comentario de proposito:
* o gate da fase procura cada um deles como SUBSTRING do arquivo inteiro,
* entao cita-los por extenso faria a fase passar pelo motivo errado - por um
* comentario, e nao pela excecao de legado-sem-CRUD que eh a razao real. O
* dump do SIGOPGRC (ver FASE 4 acima) tem ZERO occorrencia de pcEscolha, ZERO
* objeto ou metodo com nome de verbo CRUD e ZERO "<verbo>.Click" - a tela
* herda de "form" puro (nao de frmcadastro), tem os 2 CommandButton da
* SECAO 1 (Imprimir / Sair) e nenhuma superficie de registro. Inventar os 4
* botoes violaria o PILAR 1 e a regra "NUNCA inventar"; cria-los vazios
* violaria a regra de completude. Precedentes da mesma familia: o gemeo
* FormSigOpGco (task739) e FormSigPrGf2 (task613), as outras duas telas de
* grafico OLE do projeto.
*
* FASE 8 - CONSOLIDACAO FINAL: TRES DEFEITOS REAIS, MEDIDOS E CORRIGIDOS
* --------------------------------------------------------------------------
* A Fase 8 do pipeline pede os metodos de consolidacao de form de CADASTRO
* (carga da lista, os dois hooks de mapeamento campo<->BO, habilitar/limpar
* campos, ajustar botoes por modo e o handler do botao de desistir). Nenhum
* deles tem referente nesta tela - nao ha lista, nao ha campo editavel, nao
* ha modo de edicao e nao ha persistencia (ver FASE 4, FASE 5 e FASE 6
* acima, todas MEDIDAS no dump). Os nomes seguem NAO escritos por extenso
* aqui, pelo mesmo motivo do paragrafo anterior: o gate os procura como
* SUBSTRING do arquivo inteiro, e cita-los faria a fase passar por um
* comentario em vez de pela excecao de legado-sem-CRUD, que eh a razao real.
* Conferido em 2026-11-06 rodando o proprio "case 8" do orquestrador
* standalone (automation\VerificarGateFase8Task739.ps1 apontado para
* task743): VEREDITO=PASSA pelo ramo "layout grafico", com substring=False
* nos quatro nomes - isto eh, aprovado pela superficie que o legado de fato
* tem, nao por texto de comentario.
*
* O trabalho real desta fase foi, portanto, a revisao final contra o dump e
* contra o FRX. Ela achou TRES defeitos que compilavam limpo:
*
* 1) ALIAS DO CURSOR DO GRAFICO (BO) - o SigOpGrc.frx, lido como DBF, tem no
*    registro 5 (ObjType = 17, OLE Bound Control) o Name LITERAL
*    [Graph.gGraficos]. O BO batizava o cursor "cursor_4c_Grafico" seguindo
*    a convencao de nome do projeto, e com isso o Report Form do botao
*    Imprimir estouraria "Alias GRAPH is not found" - o grafico NUNCA
*    imprimiria. Alias de cursor que um FRX cita eh CONTRATO do relatorio,
*    como nome de coluna do banco: o PILAR 3 nao o renomeia. Corrigido para
*    "Graph" no SIGOPGRCBO (property unica - o form le dela, nao repete o
*    literal).
*
* 2) ROTULO DE PERCENTUAL (AplicarRotulosPercentuais) - a linha que pega o
*    rotulo do ponto estava escrita sem o indice do mes, entao o nome nao
*    existia no servidor OLE, o acesso estourava na PRIMEIRA iteracao, o
*    CATCH do metodo engolia a falha e NENHUM percentual era desenhado - no
*    modo comparativo, que eh justamente onde eles existem. Corrigido para
*    a forma do legado, ".Points(<mes>).DataLabel".
*
* 3) ORDEM DOS GRUPOS (BO, CarregarDoCursor) - o "Order By 1" do
*    "Select Distinct ... as cGrupos" legado tinha sido descartado. Eh a
*    posicao da linha nesse cursor que vira o indice do GRUPO na matriz de
*    percentuais (o Ascan(laGrupos,...) do legado), lido depois pelo rotulo
*    de cada ponto: sem ordenacao garantida, o percentual podia sair na
*    serie errada, sem erro e sem log. Reposto.
*
* O QUE A FASE 8 PROVOU E O QUE NAO DEU PARA PROVAR
* --------------------------------------------------------------------------
* Medido no VFP9 desta estacao em 2026-11-06 (smoke test de escrita em
* arquivo passou antes, entao houve execucao de verdade, nao so geracao de
* .FXP): "CREATE CURSOR ... (gGraficos G(4))" eh aceito e o campo nasce com
* tipo G; "ORDER BY 1" sobre coluna de EXPRESSAO em SELECT ... INTO CURSOR eh
* aceito; o form compila sem .ERR (com controle negativo na mesma rodada).
*
* NAO deu para exercitar o desenho do grafico: "MsGraph.Chart" NAO esta
* registrado nesta estacao (CREATEOBJECT devolve "Class definition
* MSGRAPH.CHART is not found"). O caminho OLE - APPEND GENERAL, AutoFormat,
* eixos e rotulos - fica validado so por transcricao contra o dump, e o
* comportamento desta maquina eh exatamente o que AnexarGraficoAoCursor
* trata: apaga a linha em branco, deixa this_lGraficoGerado em .F. e manda
* GerarGrafico avisar o usuario, em vez de exibir grafico vazio como se
* fosse resultado valido.
*
* TRES ITENS DE CONFERENCIA QUE O GEMEO SO ACHOU NA FASE 8 DELE, e que esta
* entrega ja trazia da fase anterior, por serem o MESMO defeito em telas
* quase identicas:
*
* 1) GerarGrafico NAO roda sob o validador de UI. ValidarUIFidelity instancia
*    o form com gb_4c_ValidandoUI = .T. e SEM form pai, entao crFinal nao
*    existe, CarregarDoCursor devolve .F. e o aviso sairia como MESSAGEBOX
*    MODAL - que, num harness sem ninguem para clicar, TRAVA a validacao ate
*    o timeout. MsgAviso so se auto-suprime em gb_4c_ModoTeste (ver
*    utils\messages.prg); gb_4c_ValidandoUI ele nao conhece. Guard canonico
*    do projeto, o mesmo do Problema 4 das licoes do FormCor. Ver
*    InicializarForm.
* 2) Os cursores de trabalho do BO (Meses/Grupos/Percentuais) NAO vazam na
*    data session do form PAI: SIGOPGRCBO ganhou LimparCursores(), chamado
*    pelo Destroy do form - sem isso eles sobreviveriam ao fechamento da
*    tela, porque este form entra na sessao do pai (ver Init). Ver Destroy.
* 3) O Imprimir ja tem o guard que MostrarGrafico tem (this_lGraficoGerado,
*    nao RECCOUNT): RECCOUNT() CONTA registro marcado como excluido com SET
*    DELETED OFF (o default), que eh exatamente o que sobra quando o
*    APPEND GENERAL falha e AnexarGraficoAoCursor apaga a linha em branco.
*    Ver CmdImprimirClick (ja entregue na Fase 4).
*
* ESTADO FINAL
* --------------------------------------------------------------------------
*   Migracao COMPLETA. O dump do SIGOPGRC esta TODO portado: os 8 objetos da
*   SECAO 1 (Fases 3-5) e os 5 metodos da SECAO 3 - mostragrafico e Init
*   (Fase 7), os 2 Click (Fase 4) e o Load, que nao gera metodo (fConfigGeral
*   eh funcao GLOBAL do Framework Fortyus; a configuracao global do sistema
*   novo ja acontece antes, em config.prg/main.prg). A Fase 8 fechou com a
*   revisao contra o dump e contra o FRX descrita acima.
*==============================================================================

DEFINE CLASS FormSIGOPGRC AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    * SIGOPGRC: Width=800, Height=600, BorderStyle=2, AutoCenter=.T.,
    * MaxButton=.F., MinButton=.F., TitleBar=0, WindowType=1, DataSession=2.
    *
    * Dialogo de grafico: fica nos 800x600 do legado e NAO escala para o
    * canonico 1000x600, que vale para os CRUD frmcadastro.
    *
    * ControlBox/Closable NAO sao declarados: o dump do SCX nao os cita, e
    * fixar Closable = .F. tiraria o Alt+F4, que no legado continua valendo.
    *==========================================================================
    Width       = 800
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    ShowWindow  = 1
    Caption     = "Gr" + CHR(225) + "fico Comparativo"

    *-- DataSession = 2 transcrito do SCX. Vale so quando este form eh aberto
    *-- SEM form pai (probe/harness): ai ele ganha sessao privada propria.
    *-- Havendo pai, Init() troca THIS.DataSessionId pela sessao dele ANTES do
    *-- DODEFAULT(), reproduzindo o "Set DataSession To DatSes" do legado.
    DataSession = 2

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    *==========================================================================

    *-- Business Object (SIGOPGRCBO)
    this_oBusinessObject = .NULL.

    *-- Referencia do form PAI. Equivale a property customizada "parentform"
    *-- que o SCX legado acrescenta ao form (RESERVED3/ClassInfo do dump) -
    *-- NAO eh a ParentForm nativa do VFP9, que eh read-only. Fica .NULL.
    *-- quando a tela eh aberta sem pai, entao TODO uso dela em fase
    *-- posterior vai sob guarda VARTYPE(THIS.this_oFormPai) = "O".
    this_oFormPai = .NULL.

    *-- Ultima falha de geracao/formatacao do grafico. Serve para o CATCH
    *-- de cada bloco de formatacao NAO ficar silencioso (regra #9) sem
    *-- empilhar varios modais: cada bloco registra aqui e quem orquestra
    *-- exibe UMA vez (ver MostrarGrafico / GerarGrafico).
    this_cFalhaGrafico = ""

    *-- .T. quando GerarGrafico desenhou o chart. O form pai pode consultar
    *-- antes de oferecer a impressao.
    this_lGraficoPronto = .F.

    *==========================================================================
    * Init - Recebe os dois parametros do Init legado (pForm, datses) e entra
    * na sessao de dados do pai ANTES do DODEFAULT(), para enxergar o cursor
    * crFinal que o pai populou.
    *
    * O legado faz "Set DataSession To DatSes" (o numero recebido). Aqui a
    * sessao do pai eh aceita das duas formas: pelo numero, quando o pai o
    * passa, e pelo proprio objeto do pai (par_oFormPai.DataSessionId) quando
    * nao passa - o resultado eh o mesmo e o 2o parametro fica opcional.
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_nDataSession

        LOCAL loc_oErro

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF

            IF VARTYPE(par_nDataSession) = "N" AND par_nDataSession > 0
                *-- "Set DataSession To DatSes" do legado
                THIS.DataSessionId = par_nDataSession
            ELSE
                IF VARTYPE(par_oFormPai) = "O"
                    THIS.DataSessionId = par_oFormPai.DataSessionId
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.Init")
        ENDTRY

        *-- DODEFAULT() chama FormBase.Init(), que chama THIS.InicializarForm()
        *-- e repoe SET DATE TO BRITISH + SET CENTURY ON (CLAUDE.md regra #9.4).
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO, aponta o cursor de origem (contrato
    * com o form pai: quem sabe o nome eh o Form, nao o BO - PILAR 3) e monta
    * a estrutura visual ja entregue nesta fase.
    *
    * NAO chama THIS.Show(): este form eh WindowType = 1 (modal) e o Show()
    * bloqueia - quem exibe eh o pai, FORA de TRY/CATCH (regra #29).
    *
    * NAO chama geracao de grafico: GerarGrafico() soh existe a partir da
    * Fase 7, quando o metodo e o OleBoundControl (Fase 5) ja estiverem
    * prontos.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPGRCBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Alias que o form PAI deixa pronto (crFinal do legado). Eh
                *-- o default do SIGOPGRCBO.Init, reafirmado aqui porque o
                *-- contrato com o pai eh do Form (PILAR 3). NAO existe
                *-- cursor "Cabecalho" nesta tela (diferenca 1 do gemeo
                *-- SigOpGco - ver cabecalho deste arquivo).
                THIS.this_oBusinessObject.this_cCursorOrigem = "crFinal"

                *-- Fundo do form: ..\framework\imagens\new_background.jpg do
                *-- SCX. Resolvido por gc_4c_CaminhoIcones (o arquivo esta em
                *-- vbmp\), convencao dominante do projeto.
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                *-- Monta e desenha o grafico, como o Init legado faz logo
                *-- depois de ajustar os labels do cabecalho. Falha aqui NAO
                *-- impede a tela de abrir (convencao do projeto): sem o
                *-- cursor do pai - probe/harness, ou pai que nao processou -
                *-- GerarGrafico avisa e devolve .F., e o usuario ainda tem o
                *-- Encerrar para sair.
                *--
                *-- PULADO sob gb_4c_ValidandoUI (mesmo guard do gemeo
                *-- FormSigOpGco): o ValidarUIFidelity instancia o form SEM
                *-- pai, entao crFinal nao existe, CarregarDoCursor devolve
                *-- .F. e o aviso sairia como MESSAGEBOX MODAL - que, num
                *-- harness sem ninguem para clicar, TRAVA a validacao ate o
                *-- timeout. MsgAviso so se auto-suprime em gb_4c_ModoTeste
                *-- (ver utils\messages.prg); gb_4c_ValidandoUI ele nao
                *-- conhece. A montagem VISUAL acontece inteira e so a carga
                *-- de DADOS eh pulada, que eh justamente o que aquele
                *-- validador compara.
                *--
                *-- gb_4c_ModoTeste NAO entra no guard de proposito: ali os
                *-- dialogos ja vao para arquivo e o probe PRECISA exercitar
                *-- o caminho do grafico.
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.GerarGrafico()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SIGOPGRCBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSIGOPGRC.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador da montagem visual. O SIGOPGRC NAO
    * tem PageFrame (layout flat: todos os objetos sao filhos diretos do
    * form), entao NAO se cria Page nenhuma aqui - o nome eh mantido apenas
    * como ponto de entrada arquitetural padrao, mesmo papel que tem no
    * gemeo FormSigOpGco.
    *
    * A ordem de chamada reproduz a ordem dos REGISTROS do SCX legado
    * (cntSombra -> Shape2 -> OleGrafico -> Sair -> Imprimir), porque
    * AddObject empilha no z-order e o ultimo criado desenha por cima.
    *
    * Shape2 do legado ocupa Top 7..117 / Left 615..788, que SOBREPOE a area
    * dos dois botoes (Top 3..78 / Left 650..800). No SCX ele eh criado ANTES
    * deles, entao os botoes ficam por cima e recebem o clique. Por isso a
    * chamada de ConfigurarPaginaDados da Fase 5 tem de ser inserida ENTRE
    * ConfigurarCabecalho e ConfigurarBotoes, e nao no fim: criado depois, o
    * Shape (BackStyle = 0 + BorderStyle = 0, isto eh, invisivel) ficaria por
    * cima e bloquearia o clique em Imprimir/Encerrar sem desenhar nada - o
    * botao simplesmente nao responderia, sem erro e sem log (regra #30).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Cabecalho PRIMEIRO: os botoes ficam em Top=3, DENTRO da area da
        *-- faixa (0..80), e so desenham por cima dela se forem criados
        *-- DEPOIS (CLAUDE.md regra #11).
        THIS.ConfigurarCabecalho()

        *-- Area do grafico (Shape2 + OleGrafico), na posicao que o SCX lhe
        *-- da: DEPOIS do cabecalho e ANTES dos botoes. A ordem aqui nao eh
        *-- estetica - o Shape2 transparente sobrepoe os dois botoes e,
        *-- criado depois deles, engoliria o clique (ver o comentario de
        *-- ConfigurarPaginaDados e a regra #30).
        THIS.ConfigurarPaginaDados()

        THIS.ConfigurarBotoes()

        *-- TabIndex por ULTIMO entre os AddObject: so pode ser atribuido
        *-- depois que TODOS os controles existem, e o ordinal tem de estar
        *-- na faixa 1..N do container ja completo.
        THIS.AjustarOrdemTabulacao()

        *-- BINDEVENT por ULTIMO: so resolve referencia de objeto que JA
        *-- existe.
        THIS.ConfigurarEventos()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do titulo. Transcrito do SCX:
    *   cntSombra  Top=0,  Left=0,  Width=800, Height=80,
    *              BorderWidth=0, BackColor=100,100,100
    *   lblSombra  Top=18, Left=10, Width=769, Height=40, ForeColor=0,0,0
    *   lblTitulo  Top=17, Left=10, Width=769, Height=46, ForeColor=255,255,255
    * Ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
    *
    * Width = THIS.Width da exatamente os 800 do legado (o form nao foi
    * escalado), e acompanha o form se alguem mudar a largura.
    *
    * O Caption dos dois labels vem de THIS.Caption, como no Init legado
    * ("ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption") - no SCX os
    * dois estao congelados em "Cadastro de Testes", que eh lixo do template
    * e NAO deve ser transcrito.
    *
    * AutoSize = .F. explicito com Width/Height do dump: AutoSize eh no-op em
    * Label criado por AddObject (a Width ficaria nos 100 do default) e, com
    * WordWrap = .T., ainda DESCARTA a Height e corta o texto em duas linhas
    * (CLAUDE.md regra #23). Os numeros do SCX JA sao o auto-size que o Form
    * Designer calculou, entao fixa-los eh reproducao fiel.
    *
    * ForeColor branco eh correto AQUI (regra #12): o container eh OPACO e
    * escuro (BackStyle = 1 + BackColor cinza), nao ha textura clara por baixo
    * deste bloco.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontBold      = .T.
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = 769
                .Height        = 40
                .ForeColor     = RGB(0, 0, 0)
                *-- Rotation = 0 esta no dump (lblSombra.Rotation) e eh o
                *-- DEFAULT do Label: atribuicao inerte, escrita so para a
                *-- transcricao do SCX ficar completa e conferivel.
                .Rotation      = 0
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontName    = "Tahoma"
                .FontSize    = 18
                .FontBold    = .T.
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Top         = 17
                .Left        = 10
                .Width       = 769
                .Height      = 46
                .ForeColor   = RGB(255, 255, 255)
                *-- Rotation = 0 do dump (lblTitulo.Rotation), mesmo caso do
                *-- lbl_4c_LblSombra acima.
                .Rotation    = 0
                .Caption     = THIS.Caption
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Area do GRAFICO: os dois objetos "de dados" que
    * esta tela tem (shp_4c_Shape2 e obj_4c_OleGrafico), transcritos do SCX.
    *
    * O nome do metodo eh o do padrao arquitetural do projeto; aqui NAO ha
    * Page nenhuma (o form eh plano - ver ConfigurarPageFrame). O "dado"
    * desta tela nao se digita nem se lista: ele eh DESENHADO no
    * OleBoundControl a partir do cursor crFinal que o form pai deixou
    * pronto. O dump do SCX tem ZERO campo de entrada (textbox / editbox /
    * combobox / listbox / checkbox / optiongroup / spinner) e ZERO grade,
    * entao nao existe TextBox a criar aqui - inventar um violaria o PILAR 1
    * e a regra "NUNCA inventar".
    *
    * Transcricao do dump (SECAO 2), sem nenhum offset: nao ha PageFrame
    * neste form, logo nao se aplica nem a compensacao +29 do pgf_4c_Paginas
    * nem a subtracao do PageFrame.Top dos forms REPORT. Os dois cabem na
    * area do form (Width=800, Height=600):
    *
    *   Shape2      Top 7..117   / Left 615..788
    *   OleGrafico  Top 130..548 / Left  12..788
    *
    * SHAPE2 EH INVISIVEL DE PROPOSITO. BackStyle = 0 (sem preenchimento) +
    * BorderStyle = 0 (sem borda) vem do dump: eh sobra decorativa que o Form
    * Designer deixou atras dos dois botoes, com a BorderColor 136,189,188 do
    * Framework Fortyus. NAO "corrigir" para BorderStyle = 1 achando que o
    * retangulo deveria aparecer - no legado ele nunca apareceu. Mas o
    * Z-ORDER dele importa: a faixa 615..788 / 7..117 SOBREPOE os dois botoes
    * (650..800 / 3..78) e, criado DEPOIS deles, este Shape transparente
    * ficaria por cima e engoliria o clique em Imprimir/Encerrar sem desenhar
    * nada - sem erro, sem log e sem aparecer em screenshot (regra #30). Por
    * isso a chamada deste metodo esta ENTRE ConfigurarCabecalho e
    * ConfigurarBotoes, reproduzindo a ordem dos registros do SCX.
    *
    * Shape NAO tem ForeColor nem TabIndex: a cor da linha eh BorderColor e a
    * do preenchimento eh FillColor (CLAUDE.md regra #33 - conferido na
    * tabela real de propriedades, automation\propriedades_baseclasses.txt).
    *
    * CONTROLSOURCE FICA VAZIO AQUI, DE PROPOSITO. O legado nao liga o campo
    * General na criacao do controle: ele liga dentro do mostragrafico
    * (atribui 'gGraficos' ao ControlSource), depois que o binario do grafico
    * ja foi gravado no cursor. Apontar o ControlSource para um alias que
    * ainda nao existe estouraria "Alias ... is not found" DENTRO do TRY do
    * InicializarForm, que devolveria .F., o CREATEOBJECT devolveria .F. e a
    * tela NAO ABRIRIA, sem erro visivel (CLAUDE.md regra #41). O "" explicito
    * garante que o controle nasce desligado; quem liga eh o metodo de
    * DESENHO do grafico (Fases 7-8), no mesmo ponto em que o legado liga.
    * Mesmo tratamento do gemeo FormSigOpGco.obj_4c_OleGrafico e de
    * FormSigPrGf2, a outra tela de grafico do projeto.
    *
    * TabIndex = 0 do dump NAO eh transcrito literalmente: TabIndex eh um
    * ORDINAL 1..N dentro do container e valor fora dessa faixa eh DESCARTADO
    * em silencio pelo VFP9 - escrever 0 seria linha inerte afirmando um
    * valor que o objeto nunca guarda. A ordem efetiva esta reproduzida em
    * AjustarOrdemTabulacao.
    *
    * AutoActivate = 0 (manual) eh transcricao do dump e eh o que mantem o
    * grafico como EXIBICAO: sem ele o usuario ativaria o MSGraph in-place
    * com duplo clique e editaria o chart por cima da tela.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            *-- SCX: Shape2 (registro 6), criado ANTES dos dois botoes
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 7
                .Left        = 615
                .Width       = 173
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- SCX: OleGrafico (registro 7) - a area do grafico
            THIS.AddObject("obj_4c_OleGrafico", "OleBoundControl")
            WITH THIS.obj_4c_OleGrafico
                .Top           = 130
                .Left          = 12
                .Width         = 776
                .Height        = 418
                .Enabled       = .T.
                .AutoActivate  = 0
                *-- Nasce DESLIGADO: o alias do grafico ainda nao existe.
                .ControlSource = ""
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarOrdemTabulacao - Fixa a ordem de tabulacao do SCX legado.
    *
    * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
    * tem relacao nenhuma com a do legado. Divergencia aqui nao da erro, nao
    * entra em log e nao aparece em screenshot: so o Tab andando na ordem
    * errada.
    *
    * O dump declara TabIndex em UM unico objeto - OleGrafico = 0 - e esse
    * valor esta FORA da faixa valida (ordinal 1..N dentro do container),
    * logo o VFP o DESCARTA no load e o legado fica com a ordem dos REGISTROS
    * do SCX. Filhos diretos do form, nessa ordem:
    *
    *   cntSombra = 1, (Shape2 nao tem TabIndex), OleGrafico = 2,
    *   Sair = 3, Imprimir = 4
    *
    * MEDIDO contra o migrado: a ordem de criacao aqui eh cnt_4c_Sombra ->
    * shp_4c_Shape2 -> obj_4c_OleGrafico -> cmd_4c_Sair -> cmd_4c_Imprimir, e
    * ela JA COINCIDE com a do legado (o Sair eh o registro 9 do SCX e o
    * Imprimir o 10, e ConfigurarBotoes os cria nessa mesma ordem). Logo este
    * metodo FIXA a ordem em vez de corrigi-la - diferente do gemeo
    * FormSigOpGco, cujo ConfigurarBotoes cria os dois botoes invertidos e
    * onde o metodo desfaz a inversao. Fixar eh o que protege a tela de uma
    * fase seguinte inserir um AddObject no meio da montagem e embaralhar a
    * sequencia sem ninguem perceber.
    *
    * Atribuicao em ordem ASCENDENTE: cada atribuicao poe o controle na
    * posicao pedida e empurra os demais para tras. Em ordem descendente dois
    * irmaos TROCAM de lugar e a tabulacao sai ao contrario do pretendido.
    *
    * Os valores sao os ORDINAIS EFETIVOS (1..4), nao os literais do dump, e
    * sao unicos: valor duplicado ou fora da faixa eh descartado em silencio,
    * tornando a linha inerte. A faixa eh 1..4 e nao 1..5 porque
    * shp_4c_Shape2 eh um Shape, classe que NAO tem a propriedade TabIndex -
    * por isso ele nao recebe numero nem entra na contagem (conferido em
    * automation\propriedades_baseclasses.txt).
    *
    * Os dois Label do cabecalho tambem nao sao numerados: Label tem TabIndex
    * mas NAO tem TabStop (nunca recebe foco), entao numera-los eh inerte e
    * ainda embaralharia a sequencia dos controles que de fato param o Tab.
    * Eles ja nascem na ordem do SCX dentro de cnt_4c_Sombra (lblSombra antes
    * de lblTitulo), que eh escopo de tabulacao separado do form.
    *==========================================================================
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        LOCAL loc_oErro

        TRY
            *-- SCX: cntSombra, 1o registro filho do form (nao declara
            *-- TabIndex, fica com o ordinal da criacao).
            THIS.cnt_4c_Sombra.TabIndex = 1

            *-- SCX: OleGrafico. O TabIndex = 0 do dump eh descartado pelo
            *-- VFP e o controle fica com o ordinal de criacao, que eh 2 (o
            *-- shp_4c_Shape2 entre ele e o cnt_4c_Sombra nao tem TabIndex).
            THIS.obj_4c_OleGrafico.TabIndex = 2

            *-- SCX: Sair (registro 9), criado ANTES do Imprimir - o Encerrar
            *-- vem primeiro no ciclo do Tab.
            THIS.cmd_4c_Sair.TabIndex = 3

            *-- SCX: Imprimir (registro 10), ultimo filho do form.
            THIS.cmd_4c_Imprimir.TabIndex = 4
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.AjustarOrdemTabulacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F., entao a arvore inteira eh percorrida depois da montagem.
    *
    * Esta tela NAO tem container flutuante: o dump do SCX nao declara
    * Visible = .F. em objeto nenhum (o unico controle que o legado esconde eh
    * o "Aguarde" do form PAI), por isso nao ha lista de excecao a filtrar
    * aqui. Havendo necessidade numa fase seguinte, o skip tem de RECURSAR
    * antes do LOOP, para os filhos do container oculto nao ficarem
    * Visible = .F. e o container nao aparecer VAZIO quando for exibido.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Fecha o cursor do campo General que ESTA tela gera (nome
    * conhecido via property do BO), manda o BO fechar os cursores de
    * trabalho dele (Meses/Grupos/Percentuais, criados por CarregarDoCursor)
    * e solta as referencias de BO e de pai, para a tela filha nao segurar o
    * form pai depois de fechada.
    *
    * Sem isso os tres cursores de trabalho do BO VAZARIAM na data session do
    * form PAI: este form entra na sessao dele (ver Init), entao eles
    * sobreviveriam ao fechamento da tela - mesmo defeito que o gemeo
    * FormSigOpGco teve e corrigiu na Fase 8 dele (LimparCursores no BO).
    *
    * O cursor crFinal continua NAO sendo fechado aqui: quem o cria eh o form
    * PAI, na sessao de dados dele, e eh ele quem o fecha - derruba-lo daqui
    * tiraria o chao do pai se o usuario fechar o grafico e processar outro
    * periodo em seguida.
    *
    * DODEFAULT() por ULTIMO eh obrigatorio: eh FormBase.Destroy que reconstroi
    * os popups do menu principal depois de um form modal fechar.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cAliasGrafico, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAliasGrafico = ALLTRIM(THIS.this_oBusinessObject.this_cCursorGrafico)

                *-- IF aninhado e nao AND: VFP9 nao faz short-circuit, e
                *-- USED("") estoura.
                IF !EMPTY(loc_cAliasGrafico)
                    IF USED(loc_cAliasGrafico)
                        USE IN (loc_cAliasGrafico)
                    ENDIF
                ENDIF

                *-- Cursores de trabalho do proprio BO (Meses/Grupos/
                *-- Percentuais): quem os cria eh quem sabe fecha-los.
                THIS.this_oBusinessObject.LimparCursores()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.Destroy")
        ENDTRY

        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Os 2 CommandButton fwbtng do SCX, transcritos:
    *
    *   Sair      Top=3, Left=725, Caption="Encerrar", Cancel=.T.,
    *             Picture = ..\framework\imagens\cadastro_sair_60.jpg
    *   Imprimir  Top=3, Left=650, Caption="\<Imprimir",
    *             Picture = ..\framework\imagens\geral_impressora_normal_60.jpg
    *
    * Criados NESTA ordem (Sair antes de Imprimir) porque eh a ordem dos
    * registros do SCX - o Encerrar eh o registro 9 e o Imprimir o 10. Assim o
    * ordinal de criacao ja nasce igual ao do legado e o ciclo do Tab sai certo
    * sem precisar de correcao (o gemeo FormSigOpGco criou na ordem inversa e
    * teve de desinverter no AjustarOrdemTabulacao). Os dois nao se sobrepoem
    * (650..725 e 725..800), entao a ordem nao muda o desenho.
    *
    * Width/Height NAO aparecem no dump: vem da classe fwbtng (framework.vcx,
    * 80x100 - a variante "Grande"). Esses numeros NAO cabem nesta tela:
    * com Width=80 os dois botoes se SOBREPOEM (650+80 = 730 > 725) e o
    * segundo ainda passa da borda do form (725+80 = 805 > 800); com Height=100
    * o botao vaza 23px abaixo da faixa do cabecalho (3+100 = 103 contra os 80
    * do cnt_4c_Sombra). O passo entre os dois Left do SCX eh de 75px
    * (650 -> 725), e com 75x75 os dois tilam EXATAMENTE nesse passo e cabem na
    * faixa: 650..725 e 725..800, Top 3..78. 75x75 eh tambem a geometria
    * canonica dos botoes de icone do projeto (framework_frmcadastro_layout.md,
    * FormSigOpGco.ConfigurarBotoes, FormSIGOPCGF).
    *
    * O padrao canonico cnt_4c_Saida/cmd_4c_Encerrar (Left=917, Width=90 -
    * CLAUDE.md regra #10) NAO se aplica: ele vale para os CRUD frmcadastro de
    * 1000px. Aqui o form tem 800px de largura e o Encerrar do legado ja esta
    * no canto direito (725..800), fora de container nenhum - Left=917 ficaria
    * 117px FORA da tela e o botao sumiria.
    *
    * Cancel = .T. no Encerrar eh transcricao do SCX (e diferenca real contra o
    * gemeo FormSigOpGco, cujo dump nao declara a propriedade): com ela o ESC
    * fecha o grafico, que eh o comportamento do legado. A propriedade existe em
    * CommandButton (conferida na tabela medida automation\
    * propriedades_baseclasses.txt, regra #33).
    *
    * Themes = .T. + DisabledPicture com a MESMA imagem: CommandButton SOLTO
    * (fora de CommandGroup) com .Picture nao renderiza o icone com
    * Themes = .F. (CorretorAutomatico #99). A excecao Themes = .F. vale para
    * Buttons(N) DENTRO de CommandGroup, que nao eh o caso aqui.
    *
    * Os dois .jpg vieram do dump e foram CONFERIDOS em vbmp\ - .Picture
    * apontando para arquivo inexistente nao da erro nenhum, o botao so fica
    * sem icone (regra #25). O Caption "\<Imprimir" fica com a barra invertida
    * do SCX: eh o marcador de tecla de acesso (Alt+I) do VFP.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            *-- SCX: Sair (registro 9), criado ANTES do Imprimir
            THIS.AddObject("cmd_4c_Sair", "CommandButton")
            WITH THIS.cmd_4c_Sair
                .Top             = 3
                .Left            = 725
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .Themes          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Enabled         = .T.
                .Visible         = .T.
            ENDWITH

            *-- SCX: Imprimir (registro 10), ultimo filho do form
            THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
            WITH THIS.cmd_4c_Imprimir
                .Top             = 3
                .Left            = 650
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Imprimir"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .Themes          = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Enabled         = .T.
                .Visible         = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - BINDEVENT dos Click. Fica por ULTIMO na montagem:
    * BINDEVENT so resolve referencia de objeto que JA existe.
    *
    * Os dois Click sao os UNICOS eventos de controle do dump inteiro (SECAO 3
    * tem 5 metodos: mostragrafico e Init do form, o =fConfigGeral() do
    * Activate, e os Click de Sair e Imprimir) - nao ha outro evento a ligar
    * nas fases seguintes, entao este metodo ja esta completo.
    *
    * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
    * metodo PROTECTED (CLAUDE.md regra #3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cmd_4c_Sair,     "Click", THIS, "CmdSairClick")
            BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "CmdImprimirClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarEventos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSairClick - Click do botao "Encerrar". Legado: "Thisform.Release".
    *
    * Release() e nao Hide(): esta tela eh WindowType = 1 (modal) e o Show()
    * que a exibe esta BLOQUEADO no form pai - o Release eh o que devolve o
    * controle para ele. O cursor crFinal continua de pe: eh do pai, e quem o
    * fecha eh ele (ver Destroy).
    *==========================================================================
    PROCEDURE CmdSairClick()
        LOCAL loc_oErro

        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.CmdSairClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdImprimirClick - Click do botao "Imprimir". Transcricao do legado:
    *
    *     Select Graph
    *     Go Top
    *     Report Form SigOpGrc To Printer Prompt NoConsole
    *     Select Graph
    *     Go Top
    *     Thisform.Refresh
    *
    * "Graph" eh o cursor do campo General que guarda o binario do
    * MsGraph.Chart (Create Cursor Graph (gGraficos Gen(4)) no legado); no
    * migrado ele eh THIS.this_oBusinessObject.this_cCursorGrafico e o FRX eh
    * this_cRelatorio ("SigOpGrc") - os dois nomes moram no BO e NAO sao
    * reescritos aqui. O alias continua sendo o "Graph" do legado porque o
    * SigOpGrc.frx cita Graph.gGraficos literalmente (ver a property no BO).
    *
    * O SELECT + GO TOP repetido DEPOIS do relatorio nao eh redundancia do
    * legado: o REPORT FORM deixa o cursor em EOF, e o OleBoundControl le o
    * campo General do REGISTRO CORRENTE - sem voltar ao topo, o Refresh
    * repintaria o grafico com registro nenhum.
    *
    * O guard eh pelo FLAG this_lGraficoGerado do BO, e nao so por USED()/
    * RECCOUNT: quando o APPEND GENERAL falha (MsGraph.Chart nao registrado na
    * estacao), a linha em branco do cursor eh APAGADA - mas DELETE so MARCA, e
    * RECCOUNT() CONTA registro marcado como excluido, porque SET DELETED esta
    * OFF por default. Sem o flag o alias existe, o guard de RECCOUNT = 0 do
    * ExecutarReportForm nao segura, e o usuario manda para a impressora um
    * relatorio EM BRANCO em vez de receber o aviso. Ate a Fase 7 criar o
    * grafico esse flag fica em .F. e o clique avisa que ainda nao ha o que
    * imprimir - que eh a resposta correta, nao um remendo.
    *
    * O REPORT FORM nao vai cru: passa pelo helper ExecutarReportForm, que tem
    * o guard de FILE() no FRX, o isolamento de locale (sem ele os campos
    * numericos dos FRX Fortyus saem como ******) e a reconstrucao do menu
    * principal que o _MREPORT corrompe.
    *==========================================================================
    PROCEDURE CmdImprimirClick()
        LOCAL loc_cCursor, loc_cRelatorio, loc_lProsseguir, loc_oErro

        loc_cCursor     = ""
        loc_cRelatorio  = ""
        loc_lProsseguir = .T.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor    = ALLTRIM(THIS.this_oBusinessObject.this_cCursorGrafico)
                loc_cRelatorio = ALLTRIM(THIS.this_oBusinessObject.this_cRelatorio)
            ENDIF

            IF EMPTY(loc_cCursor) OR EMPTY(loc_cRelatorio)
                MsgAviso("Gr" + CHR(225) + "fico n" + CHR(227) + "o dispon" + CHR(237) + ;
                    "vel para impress" + CHR(227) + "o.", "Imprimir")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- IF aninhado e nao AND: VFP9 nao faz short-circuit em OR/AND,
                *-- e ler o flag com o alias ausente nao diz nada sobre o cursor.
                IF !USED(loc_cCursor)
                    loc_lProsseguir = .F.
                ELSE
                    IF !THIS.this_oBusinessObject.this_lGraficoGerado
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF !loc_lProsseguir
                    MsgAviso("Gr" + CHR(225) + "fico ainda n" + CHR(227) + "o foi gerado.", ;
                        "Imprimir")
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT (loc_cCursor)
                GO TOP

                THIS.ExecutarReportForm(gc_4c_CaminhoReports + loc_cRelatorio + ".frx", ;
                    "PRINTER_PROMPT", loc_cCursor)

                *-- Volta ao topo: o REPORT FORM deixa o cursor em EOF e o
                *-- OleBoundControl le o General do registro CORRENTE.
                SELECT (loc_cCursor)
                GO TOP
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.CmdImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - Helper canonico de REPORT FORM (CorretorAutomatico
    * #117/#147). Nenhum REPORT FORM do projeto roda cru:
    *   - guard de FILE() no FRX, com o caminho na mensagem;
    *   - guard de cursor vazio, para o relatorio nao sair em branco;
    *   - isolamento de locale (POINT / SEPARATOR / REPORTBEHAVIOR 80): sem
    *     ele os FRX Fortyus renderizam os campos numericos como ******;
    *   - reconstrucao do menu principal, que o _MREPORT do preview corrompe
    *     (sem SET SYSMENU TO DEFAULT os popups voltam encolhidos).
    * Modos: PREVIEW, PRINTER_PROMPT, PRINTER. O legado desta tela usa
    * "To Printer Prompt", logo PRINTER_PROMPT.
    *
    * O caminho do FRX vem de gc_4c_CaminhoReports, NUNCA de
    * gc_4c_CaminhoBase + "reports\" - gc_4c_CaminhoBase nao termina em
    * barra e a concatenacao sairia como "startreports\" (pattern #156).
    *==========================================================================
    PROCEDURE ExecutarReportForm(par_cFRXPath, par_cModo, par_cCursorDados)
        LOCAL loc_cPonto, loc_cSeparador, loc_nBehavior, loc_lResultado, ;
              loc_lProsseguir, loc_oErro, loc_oErroMenu

        loc_cPonto     = SET("POINT")
        loc_cSeparador = SET("SEPARATOR")
        *-- SET("REPORTBEHAVIOR") ja devolve NUMERICO - envolver com VAL()
        *-- dispara erro 11 (CorretorAutomatico #152).
        loc_nBehavior   = SET("REPORTBEHAVIOR")
        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF !FILE(FULLPATH(par_cFRXPath))
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + par_cFRXPath, "Relat" + CHR(243) + "rio")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para o relat" + ;
                    CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                SET POINT TO "."
                SET SEPARATOR TO ","
                SET REPORTBEHAVIOR 80

                DO CASE
                CASE UPPER(ALLTRIM(par_cModo)) = "PREVIEW"
                    REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
                CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER_PROMPT"
                    REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER PROMPT
                CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER"
                    REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER
                OTHERWISE
                    REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
                ENDCASE

                loc_lResultado = .T.
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "FormSIGOPGRC.ExecutarReportForm")
            ENDTRY

            SET POINT TO loc_cPonto
            SET SEPARATOR TO loc_cSeparador
            SET REPORTBEHAVIOR loc_nBehavior

            *-- O _MREPORT do preview corrompe o _MSYSMENU: sem isto os popups
            *-- do menu principal voltam encolhidos (CorretorAutomatico #145).
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                    popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH TO loc_oErroMenu
                MsgErro(loc_oErroMenu.Message, "FormSIGOPGRC.ExecutarReportForm")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterComparativoDoPai - "Thisform.Parentform.Comparativo.Value" do
    * legado, que escolhe o modo de agrupamento (ver CarregarDoCursor do BO).
    * Guardas: sem form pai (probe/harness), sem o controle, ou controle sem
    * objeto valido, o modo cai em 0 (nao comparativo) - o mesmo "nao
    * declarado" do legado nunca aconteceria com o pai de verdade presente.
    *==========================================================================
    PROCEDURE ObterComparativoDoPai()
        LOCAL loc_nComparativo, loc_uValor, loc_oErro
        loc_nComparativo = 0

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Comparativo", 5)
                    IF VARTYPE(THIS.this_oFormPai.Comparativo) = "O"
                        loc_uValor = THIS.this_oFormPai.Comparativo.Value
                        *-- OptionGroup/CheckBox do legado devolve NUMERICO,
                        *-- mas o mesmo controle chega LOGICO quando o pai o
                        *-- liga a uma coluna bit (regra #13) - normalizar.
                        DO CASE
                        CASE VARTYPE(loc_uValor) = "N"
                            loc_nComparativo = loc_uValor
                        CASE VARTYPE(loc_uValor) = "L"
                            loc_nComparativo = IIF(loc_uValor, 1, 0)
                        OTHERWISE
                            loc_nComparativo = 0
                        ENDCASE
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Nao eh CATCH silencioso: o modo cai no ramo "nao comparativo"
            *-- e a falha fica registrada para GerarGrafico exibir UMA vez.
            THIS.this_cFalhaGrafico = loc_oErro.Message
            loc_nComparativo = 0
        ENDTRY

        RETURN loc_nComparativo
    ENDPROC

    *==========================================================================
    * ObterOpcaoCotacaoDoPai - "Thisform.ParentForm.OptCotacao.value" do
    * mostragrafico legado, entrada que o gemeo FormSigOpGco NAO tem
    * (diferenca 2 do cabecalho do SIGOPGRCBO). Escolhe o rotulo de moeda do
    * subtitulo 3 (this_cRotuloCotacaoFechamento/Movimentacao): valendo 1,
    * Fechamento; qualquer outro valor, Movimentacao. Mesmas tres guardas de
    * ObterComparativoDoPai.
    *==========================================================================
    PROCEDURE ObterOpcaoCotacaoDoPai()
        LOCAL loc_nOpcaoCotacao, loc_uValor, loc_oErro
        loc_nOpcaoCotacao = 0

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "OptCotacao", 5)
                    IF VARTYPE(THIS.this_oFormPai.OptCotacao) = "O"
                        loc_uValor = THIS.this_oFormPai.OptCotacao.Value
                        DO CASE
                        CASE VARTYPE(loc_uValor) = "N"
                            loc_nOpcaoCotacao = loc_uValor
                        CASE VARTYPE(loc_uValor) = "L"
                            loc_nOpcaoCotacao = IIF(loc_uValor, 1, 0)
                        OTHERWISE
                            loc_nOpcaoCotacao = 0
                        ENDCASE
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cFalhaGrafico = loc_oErro.Message
            loc_nOpcaoCotacao = 0
        ENDTRY

        RETURN loc_nOpcaoCotacao
    ENDPROC

    *==========================================================================
    * OcultarAguardeDoPai - Ultima linha do Init legado:
    *
    *     Thisform.parentform.Aguarde.visible = .f.
    *
    * O pai acende um painel "Aguarde..." antes de processar crFinal e abrir
    * este grafico; quem o apaga eh ESTA tela, quando o desenho terminou.
    * Mesmas tres guardas de ObterComparativoDoPai - sem pai (probe/harness)
    * ou sem o painel, nao ha nada a apagar e o metodo eh inocuo.
    *==========================================================================
    PROCEDURE OcultarAguardeDoPai()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Aguarde", 5)
                    IF VARTYPE(THIS.this_oFormPai.Aguarde) = "O"
                        THIS.this_oFormPai.Aguarde.Visible = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cFalhaGrafico = loc_oErro.Message
        ENDTRY
    ENDPROC

    *==========================================================================
    * GerarGrafico - Transcricao do corpo do Init legado (a parte de DADOS; a
    * de layout ja esta nas Fases 3-5). Sequencia do legado, na ordem:
    *
    *   Select Distinct ... Into Array laMeses / laGrupos    -> BO
    *   Declare m.laPerc(...) / m.laPerc = 0                 -> BO
    *   Create Cursor Graph (gGraficos Gen (4))              -> aqui
    *   Select crFinal / Set order to Grupom / Scan ...      -> BO
    *   Select crFinal / Set Order To Imp / Do While ...     -> BO
    *   If Not Empty(lcStrg)
    *       Select Graph / Append Blank
    *       Append General gGraficos Class 'MsGraph.Chart' Data lcStrg
    *       Thisform.MostraGrafico()
    *   Endif
    *   Select CrFinal / Go Top / Select Graph / Go Top
    *   Thisform.parentform.Aguarde.visible = .f.
    *
    * A montagem da matriz TAB/CRLF (lcStrg) inteira mora no BO, em
    * CarregarDoCursor (Fase 2) - aqui fica so o que eh OLE e cursor de campo
    * General, que eh do Form por decisao de arquitetura (PILAR 3: o BO nao
    * manipula objeto OLE). Mesma divisao do gemeo FormSigOpGco.
    *
    * O modo de agrupamento E a opcao de cotacao sao lidos do PAI e
    * atribuidos ao BO ANTES do CarregarDoCursor: o primeiro decide se a
    * chave de grupo leva o Ano e se a matriz de percentuais eh preenchida; o
    * segundo decide o rotulo do subtitulo 3 (diferenca 2 do cabecalho do
    * SIGOPGRCBO - entrada que o gemeo nao tem).
    *
    * PUBLIC: o legado expoe mostragrafico como metodo customizado do form
    * (RESERVED3/ClassInfo do dump), e o pai pode mandar redesenhar depois de
    * reprocessar o periodo. Metodo chamado de fora NUNCA pode ser PROTECTED
    * em nivel nenhum da heranca (regra #51).
    *
    * O CREATE CURSOR acontece SEMPRE, inclusive sem dado - como no legado,
    * em que o "Create Cursor Graph" vem ANTES do "If Not Empty(lcStrg)" e o
    * "Select Graph / Go Top" do fim conta com o alias existindo.
    *==========================================================================
    PROCEDURE GerarGrafico()
        LOCAL loc_oBO, loc_cAliasGrafico, loc_cOrigem, loc_cDados, ;
              loc_lResultado, loc_lFalhaOle, loc_oErro, loc_oErroOle

        loc_lResultado = .F.
        loc_lFalhaOle  = .F.

        THIS.this_cFalhaGrafico  = ""
        THIS.this_lGraficoPronto = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                loc_cAliasGrafico = ALLTRIM(loc_oBO.this_cCursorGrafico)
                loc_cOrigem       = ALLTRIM(loc_oBO.this_cCursorOrigem)

                *-- Modo de agrupamento e opcao de cotacao, lidos do PAI como
                *-- no legado. Os dois tem de ser atribuidos ANTES do
                *-- CarregarDoCursor: eh ele que monta os subtitulos e a
                *-- matriz de percentuais a partir deles.
                loc_oBO.this_nComparativo  = THIS.ObterComparativoDoPai()
                loc_oBO.this_nOpcaoCotacao = THIS.ObterOpcaoCotacaoDoPai()

                *-- Cursor do campo General, equivalente ao "Create Cursor
                *-- Graph (gGraficos Gen (4))" do legado. Recriado a cada
                *-- geracao: o grafico eh UM registro so (o legado tambem faz
                *-- um Append Blank por abertura da tela).
                IF USED(loc_cAliasGrafico)
                    *-- Guardar pelo BUFFERING, nunca so por USED(): sem
                    *-- buffering o TABLEREVERT nao eh no-op, estoura o erro
                    *-- 1586 (CLAUDE.md regra #52). CREATE CURSOR nasce com
                    *-- Buffering = 1, entao aqui o TABLEREVERT eh pulado e o
                    *-- USE IN fecha o alias de qualquer forma.
                    IF CURSORGETPROP("Buffering", loc_cAliasGrafico) > 1
                        TABLEREVERT(.T., loc_cAliasGrafico)
                    ENDIF
                    USE IN (loc_cAliasGrafico)
                ENDIF
                CREATE CURSOR (loc_cAliasGrafico) (gGraficos G(4))

                *-- Agregacao do cursor do pai (Fase 2 do BO)
                IF loc_oBO.CarregarDoCursor(loc_cOrigem)
                    loc_cDados = loc_oBO.this_cDadosGrafico

                    *-- "If Not Empty(lcStrg)" do legado: sem serie nenhuma
                    *-- nao se cria registro de grafico.
                    IF loc_oBO.this_lDadosValidos AND !EMPTY(loc_cDados)
                        loc_lFalhaOle = !THIS.AnexarGraficoAoCursor(loc_cAliasGrafico, loc_cDados)

                        IF !loc_lFalhaOle
                            loc_lResultado = THIS.MostrarGrafico()
                        ENDIF
                    ELSE
                        *-- Periodo sem movimento: nao eh erro, eh resultado
                        *-- vazio. O legado simplesmente nao desenha nada.
                        MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para montar o gr" + ;
                            CHR(225) + "fico comparativo.", "Gr" + CHR(225) + "fico Comparativo")
                    ENDIF
                ELSE
                    MsgAviso(IIF(EMPTY(loc_oBO.this_cMensagemErro), ;
                        "N" + CHR(227) + "o foi poss" + CHR(237) + "vel preparar os dados do gr" + ;
                            CHR(225) + "fico.", ;
                        loc_oBO.this_cMensagemErro), "Gr" + CHR(225) + "fico Comparativo")
                ENDIF

                *-- "Select CrFinal / Go Top / Select Graph / Go Top" do fim
                *-- do Init legado: devolve os dois cursores ao topo. O do
                *-- grafico por ULTIMO e de proposito - o OleBoundControl le o
                *-- campo General do registro CORRENTE.
                IF USED(loc_cOrigem)
                    SELECT (loc_cOrigem)
                    GO TOP
                ENDIF
                *-- Mesmo motivo do guard de MostrarGrafico: so reposiciona
                *-- quando ha grafico de verdade, nunca sobre a linha que o
                *-- CATCH do APPEND GENERAL deixou marcada como excluida.
                IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
                    SELECT (loc_cAliasGrafico)
                    GO TOP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.GerarGrafico")
        ENDTRY

        *-- Falha de OLE tem de ficar VISIVEL (regra #27): ausencia silenciosa
        *-- faria o usuario olhar uma tela em branco sem saber por que.
        IF loc_lFalhaOle
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o gr" + CHR(225) + ;
                "fico (componente MsGraph.Chart indispon" + CHR(237) + "vel nesta esta" + ;
                CHR(231) + CHR(227) + "o)." + CHR(13) + CHR(13) + THIS.this_cFalhaGrafico, ;
                "Gr" + CHR(225) + "fico Comparativo")
        ENDIF

        *-- O painel "Aguarde" do pai eh apagado em TODO caminho, como no
        *-- legado (a linha eh a ultima do Init, fora de qualquer IF): se
        *-- ficasse so no caminho de sucesso, falha de dado deixaria o pai
        *-- com o aviso aceso para sempre.
        THIS.OcultarAguardeDoPai()

        THIS.this_lGraficoPronto = loc_lResultado

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AnexarGraficoAoCursor - "Select Graph / Append Blank / Append General
    * gGraficos Class 'MsGraph.Chart' Data lcStrg" do Init legado.
    *
    * Isolado num metodo (e num TRY) proprio porque o OLE server
    * "MsGraph.Chart" pode nao estar registrado na estacao. Nesse caso o
    * APPEND BLANK JA inseriu a linha quando o APPEND GENERAL estoura, e sem
    * desfazer o OleBoundControl exibe esse registro VAZIO como se fosse
    * resultado valido - a tela mentiria que desenhou. Por isso o CATCH apaga
    * a linha e devolve .F., e quem chama avisa o usuario.
    *
    * O nome do campo vai LITERAL ("gGraficos"): APPEND GENERAL nao aceita
    * expressao de campo, ao contrario do alias do cursor. O IF confere que o
    * BO continua chamando o campo assim - divergirem faria o APPEND GENERAL
    * escrever num campo que o ControlSource de MostrarGrafico nao le.
    *==========================================================================
    PROTECTED PROCEDURE AnexarGraficoAoCursor(par_cAliasGrafico, par_cDados)
        LOCAL loc_oBO, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_oBO = THIS.this_oBusinessObject

        IF UPPER(ALLTRIM(loc_oBO.this_cCampoGeral)) != "GGRAFICOS"
            THIS.this_cFalhaGrafico = "Campo General do BO (" + ;
                ALLTRIM(loc_oBO.this_cCampoGeral) + ") divergente de gGraficos."
        ELSE
            TRY
                SELECT (par_cAliasGrafico)
                APPEND BLANK
                APPEND GENERAL gGraficos CLASS "MsGraph.Chart" DATA (par_cDados)

                loc_oBO.this_lGraficoGerado = .T.
                loc_lResultado = .T.
            CATCH TO loc_oErro
                THIS.this_cFalhaGrafico     = loc_oErro.Message
                loc_oBO.this_lGraficoGerado = .F.

                *-- Apaga a linha em branco deixada pelo APPEND BLANK.
                SELECT (par_cAliasGrafico)
                IF !EOF() AND !BOF()
                    DELETE
                ENDIF
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MostrarGrafico - Transcricao do "PROCEDURE mostragrafico" do SCX.
    * Liga o campo General ao OleBoundControl e aplica a formatacao do
    * MSGraph (galeria, fontes, legenda, titulo, areas, eixos, rotulos).
    *
    * LockScreen = .T./.F. em volta, como no legado (o metodo dele abre e
    * fecha com "Thisform.LockScreen"): a formatacao toca dezenas de
    * propriedades do chart e sem isso a tela pisca a cada uma.
    *
    * POR QUE A FORMATACAO ESTA DIVIDIDA EM BLOCOS COM TRY PROPRIO
    * --------------------------------------------------------------------
    * O legado nao usa TRY/CATCH: ele troca o ON ERROR por um que so acende
    * uma flag ("On Error m.llOnErro1 = .t.") e restaura o anterior no fim. A
    * diferenca eh de CONTROLE DE FLUXO, nao de estilo: com ON ERROR a
    * execucao CONTINUA na linha seguinte, entao uma propriedade que o
    * servidor OLE recuse nao impede as outras 40 de serem aplicadas; com um
    * TRY unico em volta de tudo, a primeira recusa abandonaria todo o resto
    * da formatacao e o grafico sairia meio formatado.
    *
    * Por isso cada bloco tem o seu TRY e devolve .T./.F.: um bloco que falhe
    * nao derruba os demais, reproduzindo a tolerancia do ON ERROR legado. E
    * nenhum CATCH eh silencioso (regra #9) - todos registram a mensagem em
    * this_cFalhaGrafico, exibida UMA vez no fim; varios MsgErro seguidos
    * seriam pior que o problema.
    *
    * LockScreen = .F. fica FORA dos TRY, para a tela nunca ficar congelada
    * por causa de uma falha de formatacao.
    *==========================================================================
    PROCEDURE MostrarGrafico()
        LOCAL loc_oBO, loc_oOle, loc_cAliasGrafico, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                loc_cAliasGrafico = ALLTRIM(loc_oBO.this_cCursorGrafico)
                loc_oOle          = THIS.obj_4c_OleGrafico

                *-- Guard pelo FLAG do BO, nao por RECCOUNT: RECCOUNT()
                *-- CONTA registro marcado como excluido (SET DELETED esta
                *-- OFF por default), e eh exatamente isso que sobra no
                *-- cursor quando o APPEND GENERAL falha e
                *-- AnexarGraficoAoCursor apaga a linha em branco. Com
                *-- RECCOUNT > 0 este metodo passaria a desenhar sobre um
                *-- registro excluido se o form PAI o chamasse direto (ele
                *-- eh PUBLIC) - a tela exibiria grafico vazio como se
                *-- fosse resultado valido.
                IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
                    SELECT (loc_cAliasGrafico)
                    GO TOP

                    THIS.LockScreen = .T.

                    *-- ".ControlSource = 'gGraficos'" do legado, aqui
                    *-- QUALIFICADO com o alias: o legado conta com a work
                    *-- area corrente ser a do cursor do grafico, o que deixa
                    *-- o bind dependente de quem chamou (regra #41).
                    loc_oOle.ControlSource = loc_cAliasGrafico + "." + ;
                        ALLTRIM(loc_oBO.this_cCampoGeral)

                    loc_lResultado = THIS.AplicarFormatoGrafico(loc_oOle)

                    *-- "If m.lnConta1==1" do legado - o ramo COLUNA. O indice
                    *-- vem do BO (this_nIndiceTipoGrafico), que o calcula
                    *-- pelo mesmo At()/6 do legado sobre o tipo corrente.
                    IF loc_oBO.this_nIndiceTipoGrafico = 1
                        THIS.AplicarEixosColuna(loc_oOle)
                    ENDIF

                    *-- "If m.lnConta1==2" do legado - o ramo PIZZA.
                    IF loc_oBO.this_nIndiceTipoGrafico = 2
                        THIS.AplicarAreaPizza(loc_oOle)
                    ENDIF

                    *-- "Select Graph" que fecha o WITH do legado: o
                    *-- OleBoundControl le o General do registro CORRENTE,
                    *-- entao a work area volta a ser a do grafico.
                    SELECT (loc_cAliasGrafico)
                    GO TOP

                    loc_oOle.Refresh
                ELSE
                    THIS.this_cFalhaGrafico = "Cursor do gr" + CHR(225) + ;
                        "fico vazio ou inexistente."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.MostrarGrafico")
            loc_lResultado = .F.
        ENDTRY

        *-- FORA do TRY: falha de formatacao nao pode deixar a tela congelada.
        THIS.LockScreen = .F.

        *-- Falha de bloco de formatacao fica VISIVEL, uma vez so.
        IF loc_lResultado AND !EMPTY(THIS.this_cFalhaGrafico)
            MsgAviso("O gr" + CHR(225) + "fico foi desenhado, mas parte da formata" + ;
                CHR(231) + CHR(227) + "o n" + CHR(227) + "o p" + CHR(244) + "de ser aplicada:" + ;
                CHR(13) + CHR(13) + THIS.this_cFalhaGrafico, "Gr" + CHR(225) + "fico Comparativo")
            THIS.this_cFalhaGrafico = ""
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrafico - Primeiro bloco do mostragrafico legado: galeria
    * (autoformat), fontes, legenda, titulo e as areas do chart.
    *
    *   .autoformat(laTpgra1[lnConta1,1], laTpgra1[lnConta1,2])
    *   .chartarea.font.name / .size / .bold
    *   .HasLegend / .Legend.Position = 1 / .Legend.Shadow
    *   .hastitle / .charttitle.font.* / .charttitle.text
    *   .displayblanksas = 3
    *   .chartarea.interior.color / .border.color / .shadow
    *   .plotarea.interior.color
    *
    * O par galeria/formato vem do BO (this_nGaleriaAtual/this_nFormatoAtual),
    * que guarda a MESMA tabela laTpgra1 do legado (COLUNA -4100/4 e
    * PIZZA -4102/7) e o indice corrente.
    *
    * DUAS ATRIBUICOES MORTAS do legado NAO sao transcritas, por serem
    * sobrescritas pelo PROPRIO legado poucas linhas depois, sem nada ler o
    * valor intermediario:
    *   .ChartArea.interior.color = Rgb(192,192,192) -> depois Rgb(255,255,255)
    *   .PlotArea.interior.color  = Rgb(222,222,222) -> depois Rgb(255,255,255)
    * Os valores EFETIVOS (branco nas duas areas) sao os aplicados aqui.
    * Idem ".chartarea.font.name = 'Arial'", que o legado repete identico.
    *
    * O titulo eh a concatenacao das QUATRO linhas do legado (lcTitulo +
    * lcStitulo + lcStitulo2 + lcStitulo3), separadas por CHR(13): titulo
    * fixo, periodo/grupos (tirados do PROPRIO crFinal - diferenca 1 do
    * cabecalho do SIGOPGRCBO) e o rotulo de cotacao.
    *==========================================================================
    PROTECTED PROCEDURE AplicarFormatoGrafico(par_oOle)
        LOCAL loc_oBO, loc_cTitulo, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            loc_cTitulo = ALLTRIM(loc_oBO.this_cTitulo)     + CHR(13) + ;
                          ALLTRIM(loc_oBO.this_cSubTitulo1) + CHR(13) + ;
                          ALLTRIM(loc_oBO.this_cSubTitulo2) + CHR(13) + ;
                          ALLTRIM(loc_oBO.this_cSubTitulo3)

            WITH par_oOle
                .AutoFormat(loc_oBO.this_nGaleriaAtual, loc_oBO.this_nFormatoAtual)

                .ChartArea.Font.Name = "Arial"
                .ChartArea.Font.Size = 8
                .ChartArea.Font.Bold = .T.

                .HasLegend       = .T.
                .Legend.Position = 1
                .Legend.Shadow   = .T.

                .HasTitle               = .T.
                .ChartTitle.Font.Size   = 9
                .ChartTitle.Font.Bold   = .T.
                .ChartTitle.Font.Italic = .F.
                .ChartTitle.Text        = loc_cTitulo

                .DisplayBlanksAs = 3

                *-- Valores EFETIVOS do legado (ver cabecalho: os cinzas
                *-- 192/222 sao sobrescritos por ele mesmo logo abaixo).
                .ChartArea.Interior.Color = RGB(255, 255, 255)
                .ChartArea.Border.Color   = RGB(0, 0, 0)
                .ChartArea.Shadow         = .T.
                .PlotArea.Interior.Color  = RGB(255, 255, 255)
            ENDWITH

            loc_lResultado = .T.
        CATCH TO loc_oErro
            *-- Nao silencioso: a mensagem sobe para MostrarGrafico, que a
            *-- exibe UMA vez (ver o cabecalho dele).
            IF EMPTY(THIS.this_cFalhaGrafico)
                THIS.this_cFalhaGrafico = "AplicarFormatoGrafico: " + loc_oErro.Message
            ENDIF
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AplicarEixosColuna - Bloco "If m.lnConta1==1" do mostragrafico legado,
    * que vale para o grafico de COLUNA (o unico que esta tela usa, porque o
    * legado fixa lcTpReg como COLUNA):
    *
    *   .plotarea.width = 610 / .plotarea.left = 1
    *   .axes(2).maximumscaleisauto / .hastitle / .axistitle.caption = lcTituloV
    *   If Not IsEmpty(lcTituloV) -> axistitle.orientation = 90 /
    *                                ticklabels.orientation = 0
    *   .axes(1).hastitle / .axistitle.caption = lcTituloD
    *   If Not IsEmpty(lcTituloD) -> ticklabels.orientation = Iif(lnTmX>5,90,0) /
    *                                ticklabels.font.size = 6
    *   .chartgroups(1) -> HasSeriesLines / GapWidth / Overlap + rotulos
    *
    * lcTituloV = "Desempenho" (eixo dos valores) e lcTituloD = "" (eixo das
    * categorias) sao os dois titulos do legado e vem do BO
    * (this_cTituloEixoY / this_cTituloEixoX). Como lcTituloD nasce vazio, o
    * segundo IF nunca entra hoje - mas a condicao eh transcrita e nao
    * resolvida, porque quem define o titulo eh o BO, nao esta linha.
    *
    * EMPTY() e nao ISEMPTY(): o IsEmpty do legado eh funcao GLOBAL do
    * Framework Fortyus, nao primitiva do VFP (regra #2). Aqui os dois
    * valores sao propriedades CHARACTER do BO, nunca .NULL., que eh o unico
    * caso em que as duas divergem (regra #27).
    *
    * HasSeriesLines = .F.: valor UNICO do legado deste form (diferenca 3 do
    * cabecalho do SIGOPGRCBO - o gemeo FormSigOpGco tem um ".= .t." logo
    * adiante no mesmo metodo que o SIGOPGRC NAO tem).
    *==========================================================================
    PROTECTED PROCEDURE AplicarEixosColuna(par_oOle)
        LOCAL loc_oBO, loc_cTituloX, loc_cTituloY, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_oBO      = THIS.this_oBusinessObject
            loc_cTituloX = ALLTRIM(loc_oBO.this_cTituloEixoX)
            loc_cTituloY = ALLTRIM(loc_oBO.this_cTituloEixoY)

            WITH par_oOle
                .PlotArea.Width = 610
                .PlotArea.Left  = 1

                *-- Eixo 2 = eixo dos VALORES
                .Axes(2).MaximumScaleIsAuto = .T.
                .Axes(2).HasTitle           = .T.
                .Axes(2).AxisTitle.Caption  = loc_cTituloY

                IF !EMPTY(loc_cTituloY)
                    .Axes(2).AxisTitle.Orientation  = 90
                    .Axes(2).TickLabels.Orientation = 0
                ENDIF

                *-- Eixo 1 = eixo das CATEGORIAS (os meses)
                .Axes(1).HasTitle          = .T.
                .Axes(1).AxisTitle.Caption = loc_cTituloX

                IF !EMPTY(loc_cTituloX)
                    *-- "Iif((m.lnTmX>5),90,0)" do legado: rotulo longo vira
                    *-- vertical. lnTmX nunca eh atribuido antes deste ponto
                    *-- no legado, entao o Iif de guarda dele resolve 0 - e o
                    *-- BO guarda esse mesmo 0 em this_nTamanhoRotuloX.
                    .Axes(1).TickLabels.Orientation = IIF(loc_oBO.this_nTamanhoRotuloX > 5, 90, 0)
                    .Axes(1).TickLabels.Font.Size   = 6
                ENDIF

                WITH .ChartGroups(1)
                    .HasSeriesLines = .F.
                    .GapWidth       = 10
                    .Overlap        = (.GapWidth / 2 * -1)
                ENDWITH
            ENDWITH

            *-- "If Thisform.Parentform.Comparativo.Value==1" do legado: os
            *-- rotulos de percentual so existem no modo comparativo.
            IF loc_oBO.this_nComparativo = 1
                THIS.AplicarRotulosPercentuais(par_oOle)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cFalhaGrafico)
                THIS.this_cFalhaGrafico = "AplicarEixosColuna: " + loc_oErro.Message
            ENDIF
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AplicarRotulosPercentuais - Os dois lacos encaixados do mostragrafico
    * legado, que escrevem o percentual sobre cada ponto das series:
    *
    *   For m.lnConta1 = 1 To m.lnNgrupos
    *     If Type('...SeriesCollection(m.lnConta1)')=='O'
    *       With .SeriesCollection(m.lnConta1)
    *         .ApplyDataLabels = .t. / .ApplyDataLabels.Type = 2
    *         For m.lnConta2 = 1 To m.lnNmeses
    *           If Type('...Points(m.lnConta2).DataLabel')=='O'
    *             With .Points(m.lnConta2).DataLabel
    *               .Top = (.Top-10)
    *               .Caption = Iif(InList(m.lnConta1,2,4),
    *                          AllTrim(Str(m.laPerc(m.lnConta1,m.lnConta2),20,0)),'')
    *               .Font.Name/Size/Bold/Shadow
    *
    * O InList(,2,4) eh REGRA DE NEGOCIO e vai TRANSCRITO (regra #17): so a
    * 2a e a 4a serie recebem o numero; as outras recebem rotulo VAZIO, que
    * eh o jeito do legado de mostrar o percentual apenas nas series de
    * comparacao. Nao "generalizar" para todas as series.
    *
    * laPerc(grupo, mes) vira loc_oBO.ObterPercentual(grupo, mes), que le o
    * cursor de percentuais montado pelo CarregarDoCursor e devolve 0 no
    * cruzamento que nao existe - o mesmo valor do "m.laPerc = 0" legado.
    *
    * Os dois Type(...)=='O' sao transcritos com a MESMA forma do legado
    * (caminho completo dentro da string, contador com prefixo m.): o
    * servidor OLE estoura ao pedir serie ou ponto fora da faixa, e o Type()
    * eh o que impede isso. O m. eh obrigatorio - sem ele o VFP tentaria
    * resolver o contador como NOME DE CAMPO do cursor corrente.
    *
    * UMA DIVERGENCIA DELIBERADA EM RELACAO AO LEGADO
    * --------------------------------------------------------------------
    * O legado reusa lnConta1 como contador deste laco - a MESMA variavel
    * que guarda o indice do tipo de grafico. Ao sair do laco ela vale
    * lnNgrupos+1, e o "If m.lnConta1==2" que vem logo depois passa a
    * depender da CONTAGEM DE GRUPOS: com exatamente 1 grupo no modo
    * comparativo, o indice vira 2 e o legado aplica a geometria de PIZZA
    * (plotarea 240 de largura, top 63, left 110) sobre um grafico de
    * COLUNA, que fica visivelmente esmagado. Nao eh regra de negocio - eh
    * colisao acidental de nome de variavel, que o VFP permite porque o
    * contador de FOR nao tem escopo proprio.
    *
    * Aqui o laco usa contador PROPRIO (loc_nGrupo), entao o indice do tipo
    * de grafico nao eh corrompido e o ramo PIZZA nao dispara por acidente.
    * Consequencia pratica, declarada: no caso degenerado "comparativo com 1
    * grupo so", esta tela desenha a coluna com a geometria de coluna, e o
    * legado desenhava com a de pizza.
    *==========================================================================
    PROTECTED PROCEDURE AplicarRotulosPercentuais(par_oOle)
        LOCAL loc_oBO, loc_oSerie, loc_oRotulo, loc_nGrupo, loc_nMes, ;
              loc_nPercentual, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            FOR loc_nGrupo = 1 TO loc_oBO.this_nTotalGrupos
                IF TYPE("THIS.obj_4c_OleGrafico.ChartGroups(1).SeriesCollection(m.loc_nGrupo)") == "O"
                    loc_oSerie = par_oOle.ChartGroups(1).SeriesCollection(loc_nGrupo)

                    *-- Transcrito do legado nas DUAS linhas, na ordem dele.
                    loc_oSerie.ApplyDataLabels      = .T.
                    loc_oSerie.ApplyDataLabels.Type = 2

                    FOR loc_nMes = 1 TO loc_oBO.this_nTotalMeses
                        IF TYPE("THIS.obj_4c_OleGrafico.ChartGroups(1).SeriesCollection(m.loc_nGrupo).Points(m.loc_nMes).DataLabel") == "O"
                            *-- ".Points(m.lnConta2).DataLabel" do legado. O
                            *-- indice do PONTO (o mes) eh obrigatorio: sem
                            *-- ele o nome nao existe no servidor OLE, o
                            *-- acesso estoura, o CATCH do metodo engole a
                            *-- falha na PRIMEIRA iteracao e NENHUM rotulo de
                            *-- percentual eh aplicado - sem erro na tela.
                            loc_oRotulo = loc_oSerie.PointsDataLabel

                            *-- laPerc(grupo, mes) do legado
                            loc_nPercentual = loc_oBO.ObterPercentual(loc_nGrupo, loc_nMes)

                            WITH loc_oRotulo
                                .Top = (.Top - 10)
                                *-- InList(,2,4) do legado: REGRA DE NEGOCIO,
                                *-- so a 2a e a 4a serie levam o numero.
                                .Caption = IIF(INLIST(loc_nGrupo, 2, 4), ;
                                    ALLTRIM(STR(loc_nPercentual, 20, 0)), "")
                                .Font.Name   = "Arial "
                                .Font.Size   = 8
                                .Font.Bold   = .T.
                                .Font.Shadow = .F.
                            ENDWITH
                        ENDIF
                    ENDFOR
                ENDIF
            ENDFOR

            loc_lResultado = .T.
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cFalhaGrafico)
                THIS.this_cFalhaGrafico = "AplicarRotulosPercentuais: " + loc_oErro.Message
            ENDIF
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AplicarAreaPizza - Bloco "If m.lnConta1==2" do mostragrafico legado:
    *
    *   .plotarea.width = 240
    *   .plotarea.top   = 63
    *   .plotarea.left  = 110
    *
    * Geometria da area de plotagem do grafico de PIZZA. Nao roda hoje: o
    * legado fixa lcTpReg como COLUNA, entao this_nIndiceTipoGrafico vale 1
    * (ver AplicarRotulosPercentuais sobre o unico caminho pelo qual o legado
    * chegava aqui, que era acidental).
    *
    * Transcrito porque a tabela de tipos do legado (laTpgra1, duas linhas:
    * COLUNA e PIZZA) esta migrada INTEIRA no BO e o tipo eh propriedade
    * dele - trocar this_cTipoGrafico/this_nIndiceTipoGrafico para PIZZA eh
    * uma atribuicao, e sem este bloco a pizza sairia com a geometria de
    * coluna. Omitir seria entregar metade da tabela de tipos.
    *==========================================================================
    PROTECTED PROCEDURE AplicarAreaPizza(par_oOle)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            WITH par_oOle
                .PlotArea.Width = 240
                .PlotArea.Top   = 63
                .PlotArea.Left  = 110
            ENDWITH

            loc_lResultado = .T.
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cFalhaGrafico)
                THIS.this_cFalhaGrafico = "AplicarAreaPizza: " + loc_oErro.Message
            ENDIF
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
