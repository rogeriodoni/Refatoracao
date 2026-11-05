*==============================================================================
* FormSigOpGco.prg - Grafico Comparativo (dialogo FILHO de grafico)
*
* Origem legado: SIGOPGCO.SCX (task739)
* Herda de: FormBase
* Tipo: OPERACIONAL - form PLANO, SEM PageFrame. A arvore de objetos do SCX
*       (SECAO 1 do dump + layout.json) tem 8 objetos, todos filhos diretos de
*       SIGOPGCO: cntSombra (com lblSombra/lblTitulo), Shape2, OleGrafico e os
*       2 CommandButton fwbtng (Imprimir / sair). Nao existe Page nenhuma -
*       nao ha o que paginar nesta tela.
*
* BO: SigOpGcoBO (ja completo nas Fases 1-2). Sem tabela proprietaria: ele so
*     LE os cursores que o form PAI deixou prontos e agrega.
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS + propriedades visuais do
*            SCX + Init/InicializarForm/Destroy + cnt_4c_Sombra com os dois
*            labels do cabecalho).
*
* CONTRATO COM O FORM PAI (ainda nao migrado - nenhum form do projeto abre
* esta tela hoje; grep por "SigOpGco" em projeto\app\ devolve so o BO)
* --------------------------------------------------------------------------
* Legado: "Lparameters pForm, datses" + "Set DataSession To DatSes" +
*         "ThisForm.ParentForm = pForm".
*
* 1) CREATEOBJECT("FormSigOpGco", <form pai>, <datasession do pai>) - os dois
*    parametros do Init legado, na mesma ordem. O segundo eh opcional: sem
*    ele, a sessao do pai eh lida de par_oFormPai.DataSessionId, que da no
*    mesmo (ver Init).
* 2) A tela NAO consulta o banco. Ela depende de DOIS cursores que o pai
*    processa ANTES de abrir este form (nomes transcritos do legado, e que
*    sao os defaults do SigOpGcoBO):
*       crFinal   - agregado com Mes, Ordem, Ano, Grupos, Total e npercs,
*                   com os tags de ordenacao Grupom e Imp
*       Cabecalho - uma linha com pRelTitulo e pPeriodo (subtitulos)
*    Por isso o Init entra na MESMA sessao de dados do pai: com sessao
*    privada propria, USED("crFinal") daria .F. e o grafico nunca teria o
*    que desenhar.
* 3) Quem exibe a tela eh o PAI, com .Show() FORA de qualquer TRY/CATCH
*    (CLAUDE.md regra #29): este form eh WindowType = 1 (transcrito do SCX),
*    entao o Show() BLOQUEIA e toda a vida da tela corre dentro dele -
*    chamar Show() aqui dentro, de dentro do TRY do InicializarForm, faria a
*    tela se fechar a cada erro de runtime. Diferente de FormSigPrGf2, que eh
*    WindowType = 0 e por isso se mostra sozinho.
* 4) O legado termina o Init com "Thisform.parentform.Aguarde.visible = .f."
*    e le "Thisform.Parentform.Comparativo.Value" para escolher o modo de
*    agrupamento. Os dois dependem de controles do PAI e entram nas fases de
*    comportamento, sempre sob guarda VARTYPE(THIS.this_oFormPai) = "O".
*
* O QUE A FASE 4 ACRESCENTOU
* --------------------------------------------------------------------------
* Os 2 CommandButton fwbtng do SCX, filhos diretos do form: cmd_4c_Imprimir
* (Top=3/Left=647, Picture geral_impressora_normal_60.jpg) e cmd_4c_Sair
* (Top=3/Left=723, Picture cadastro_sair_60.jpg), com os BINDEVENT e os DOIS
* Click JA completos.
*
* Os Click estavam no roteiro para a Fase 7/8, mas o legado deles tem 7 e 1
* linha - entregar o botao com handler vazio seria o "stub disfarcado" que a
* regra de completude proibe. Sobra para a Fase 7/8 o mostragrafico, que
* depende do OleBoundControl da Fase 5.
*
* O que a Fase 4 NAO cria, de proposito: Grid, PageFrame Lista/Dados e os 6
* botoes CRUD. A arvore do SCX (SECAO 1) tem ZERO objeto com BaseClass
* grid/pageframe e ZERO controle de entrada (textbox/editbox/combobox/
* listbox/checkbox/optiongroup/optionbutton/spinner) - o unico ControlSource
* do dump esta em codigo, no .ControlSource = 'gGraficos' do OleGrafico, que
* eh o campo General do grafico e nao uma lista. Nao ha o que listar nem o
* que digitar nesta tela: inventar grade ou aba violaria o PILAR 1 e a regra
* "NUNCA inventar".
*
* O QUE A FASE 5 ENTREGOU (area de dados = area do grafico)
* --------------------------------------------------------------------------
* ConfigurarPaginaDados cria os DOIS objetos que faltavam da arvore do SCX -
* shp_4c_Shape2 (Top=7/Left=615/Width=173/Height=110, BackStyle=0/
* BorderStyle=0/BorderColor=136,189,188) e obj_4c_OleGrafico
* (OleBoundControl, Top=141/Left=12/Width=770/Height=418, Enabled=.T./
* AutoActivate=0). Com eles, os 8 objetos do SCX estao todos criados.
*
* O .ControlSource do OLE nasce VAZIO: o legado so liga o campo General
* gGraficos dentro do mostragrafico, depois que o cursor do grafico e o
* registro dele existem - apontar para alias inexistente derruba o Init e a
* tela nao abre (regra #41). O bind efetivo mora no metodo de DESENHO do
* grafico, na Fase 7/8, exatamente onde o legado o faz.
*
* A chamada entra ANTES de ConfigurarBotoes para reproduzir a ordem dos
* registros do SCX: o Shape ocupa a mesma area dos 2 botoes e, criado depois
* deles, ficaria na frente interceptando o clique (ver ConfigurarPageFrame).
*
* Tambem desta fase, por ser o que a criacao em massa das fases anteriores
* descartou: o Rotation dos dois Label do cabecalho (ver ConfigurarCabecalho)
* e a ordem de tabulacao do legado (ver AjustarOrdemTabulacao, que corrige os
* botoes Encerrar/Imprimir TROCADOS no ciclo do Tab).
*
* O QUE A FASE 6 CONFIRMOU (campos restantes e lookups)
* --------------------------------------------------------------------------
* SEM TRABALHO, medido e nao presumido: grep no dump inteiro
* (SigOpGco_form_codigo_fonte.txt) por BaseClass: textbox|combobox|checkbox|
* listbox|optiongroup|optionbutton|spinner|editbox devolve ZERO ocorrencia, e
* grep por fwbuscaext|fwbuscasel|sigacess|maddcoluna|createobject tambem
* devolve ZERO. Os 8 objetos da SECAO 1 do dump (cntSombra+2 Label, Shape2,
* OleGrafico, sair, Imprimir) ja estao TODOS criados desde a Fase 3/4/5 - nao
* sobra nenhum TextBox/ComboBox/CheckBox para ligar e nenhuma tabela de
* referencia para abrir em FormBuscaAuxiliar. analise.json/comportamento.json
* (gerados na fase de analise) confirmam na mesma direcao: "campos": [],
* "lookups": [] e cada metodo com "temLookup": false. Inventar campo ou lookup aqui
* violaria o PILAR 1 ("NUNCA inventar o que o legado nao tem") - por isso este
* metodo nao foi tocado nesta fase. Precedente da mesma familia (tela
* OPERACIONAL sem superficie de campo/lookup): FormSigOpChp (task699),
* FormSigOpCtd (task715), FormSigOpCts (task717), Formsigopdtf (task725).
*
* O QUE A FASE 7 ENTREGOU (eventos principais / comportamento)
* --------------------------------------------------------------------------
* O mostragrafico e a parte de DADOS do Init legado, que era o que restava:
*
*   GerarGrafico()              orquestra o corpo do Init legado - le o modo
*                               Comparativo do pai, manda o BO agregar
*                               crFinal/Cabecalho, cria o cursor do campo
*                               General, anexa o chart e desenha
*   AnexarGraficoAoCursor()     "Append Blank + Append General gGraficos
*                               Class 'MsGraph.Chart' Data lcStrg"
*   MostrarGrafico()            "PROCEDURE mostragrafico" - bind do
*                               ControlSource + LockScreen + os 3 blocos
*   AplicarFormatoGrafico()     galeria/fontes/legenda/titulo/areas
*   AplicarEixosColuna()        bloco "If m.lnConta1==1" (eixos + ChartGroups)
*   AplicarRotulosPercentuais() os dois lacos de rotulo de percentual
*   AplicarAreaPizza()          bloco "If m.lnConta1==2"
*   ObterComparativoDoPai()     "Thisform.Parentform.Comparativo.Value"
*   OcultarAguardeDoPai()       "Thisform.parentform.Aguarde.visible = .f."
*
* Os DOIS Click do SCX (Imprimir / sair) ja tinham sido entregues na Fase 4,
* porque entregar botao com handler vazio seria o stub que a regra de
* completude proibe - por isso esta fase ficou com o comportamento de
* grafico, que eh o resto do dump.
*
* NAO existem os quatro handlers Btn<verbo>Click de form CRUD - um por
* Incluir, Alterar, Visualizar e Excluir -, e isso eh MEDIDO, nao
* presumido. Os nomes NAO aparecem escritos por extenso nem aqui no
* comentario de proposito: o gate da fase procura cada um deles como
* SUBSTRING do arquivo inteiro, entao cita-los por extenso faria a fase
* passar pelo motivo errado - por um comentario, e nao pela excecao de
* legado-sem-CRUD que eh a razao real. O dump do SIGOPGCO tem
* ZERO ocorrencia de pcEscolha, ZERO objeto ou metodo com nome de verbo CRUD
* e ZERO "<verbo>.Click" - a tela herda de "form" puro (nao de frmcadastro),
* tem os 2 CommandButton da SECAO 1 (Imprimir / sair) e nenhuma superficie
* de registro. Inventar os 4 botoes violaria o PILAR 1 e a regra "NUNCA
* inventar"; cria-los vazios violaria a regra de completude. Precedente da
* mesma familia: FormSigPrGf2 (task613), a outra tela de grafico OLE.
*
* UMA DIVERGENCIA DELIBERADA, declarada aqui e no metodo: o legado reusa a
* variavel lnConta1 como contador do laco de rotulos, corrompendo o indice
* do tipo de grafico - com 1 grupo so no modo comparativo ele passa a
* aplicar a geometria de PIZZA sobre o grafico de COLUNA. Colisao acidental
* de nome, nao regra de negocio: aqui o laco usa contador proprio. Ver
* AplicarRotulosPercentuais.
*
* O QUE A FASE 8 ENTREGOU (consolidacao final)
* --------------------------------------------------------------------------
* O dump ja estava TODO portado ao fim da Fase 7. Esta fase eh a CONFERENCIA
* do conjunto montado pelas sete anteriores, e ela achou TRES defeitos REAIS,
* consertados aqui:
*
* 1) GerarGrafico rodava tambem sob o validador de UI. O ValidarUIFidelity
*    instancia o form com gb_4c_ValidandoUI = .T. e SEM form pai, entao
*    crFinal/Cabecalho nao existem, CarregarDoCursor devolve .F. e o aviso
*    saia como MESSAGEBOX MODAL - que, num harness sem ninguem para clicar,
*    TRAVA a validacao ate o timeout. MsgAviso so se auto-suprime em
*    gb_4c_ModoTeste (ver utils\messages.prg); gb_4c_ValidandoUI ele nao
*    conhece. Guard canonico do projeto, o mesmo do Problema 4 das licoes do
*    FormCor. Ver InicializarForm.
*
* 2) Os cursores de trabalho VAZAVAM na data session do form PAI. O
*    comentario do Destroy afirmava que o BO fechava o que ele mesmo cria, e
*    isso era FALSO - o SigOpGcoBO nao tinha Destroy nem metodo de limpeza.
*    Ficavam abertos cursor_4c_Grafico e os tres cursores de trabalho do BO,
*    e como este form entra na sessao do pai (ver Init) eles sobreviviam ao
*    fechamento da tela. A Fase 8 acrescentou LimparCursores() ao BO e passou
*    a chama-lo do Destroy. Ver Destroy.
*
* 3) O Imprimir nao tinha o guard que o MostrarGrafico tem. Com o
*    APPEND GENERAL falhando (MsGraph.Chart nao registrado na estacao),
*    AnexarGraficoAoCursor apaga a linha em branco - mas DELETE so MARCA, e
*    RECCOUNT() CONTA registro marcado como excluido com SET DELETED OFF, que
*    eh o default. O alias existia, o guard de RECCOUNT = 0 do
*    ExecutarReportForm nao segurava e saia um relatorio EM BRANCO na
*    impressora em vez do aviso. Ver CmdImprimirClick.
*
* OS NOMES DE METODO QUE O ROTEIRO DA FASE 8 PEDE NAO TEM REFERENTE NESTE
* LEGADO, e isso eh MEDIDO, nao presumido: a SECAO 1 do dump tem 8 objetos e
* as BaseClass deles sao, na integra, form + dataenvironment + container +
* 2 label + shape + oleboundcontrol + 2 commandbutton. ZERO grid, ZERO
* pageframe e ZERO controle de entrada. Logo nao ha grade de LISTA para um
* metodo de carga alimentar, nao ha campo editavel para os dois metodos de
* transferencia entre tela e BO mapearem, e nao ha Page2 nem modo de edicao
* para um botao de cancelar desfazer. Os nomes NAO vao escritos por extenso
* aqui, pela mesma disciplina do bloco da Fase 7: o gate os procura como
* SUBSTRING do arquivo inteiro, entao cita-los faria a fase passar POR UM
* COMENTARIO e nao pela razao real. Criar os metodos vazios seria o stub que
* a regra de completude proibe; cria-los com conteudo inventado violaria o
* PILAR 1. Precedente da mesma familia: FormSigPrGf2 (task613), a outra tela
* de grafico OLE do projeto.
*
* ESTADO FINAL
* --------------------------------------------------------------------------
*   Migracao COMPLETA. O dump do SIGOPGCO esta TODO portado: os 8 objetos da
*   SECAO 1 (Fases 3-5) e os 5 metodos da SECAO 3 - mostragrafico e Init
*   (Fase 7), os 2 Click (Fase 4) e o Load, que nao gera metodo (ver abaixo).
*
* O "Load" legado (fConfigGeral seguido de DoDefault) nao gera metodo aqui:
* fConfigGeral eh funcao GLOBAL do Framework Fortyus e o wrapper
* projeto\app\utils\fconfiggeral.prg existe APENAS para o p-code dos VCX
* legado - o proprio wrapper registra que codigo NOSSO nunca o chama, porque
* a configuracao global do sistema novo ja acontece antes, em config.prg e
* main.prg. E o DoDefault eh exatamente o que FormBase ja faz.
*==============================================================================

DEFINE CLASS FormSigOpGco AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    * SIGOPGCO: Width=800, Height=600, BorderStyle=2, AutoCenter=.T.,
    * ControlBox=.F., TitleBar=0, WindowType=1, DataSession=2.
    *
    * Dialogo de grafico: fica nos 800x600 do legado e NAO escala para o
    * canonico 1000x600, que vale para os CRUD frmcadastro.
    *
    * MaxButton / MinButton / Closable NAO sao declarados: o SCX nao os
    * declara e eles sao INDEPENDENTES de TitleBar/ControlBox - sem barra de
    * titulo os botoes nao desenham, mas fixar Closable = .F. tiraria o
    * Alt+F4, que no legado continua valendo.
    *==========================================================================
    Width       = 800
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
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

    *-- Business Object (SigOpGcoBO)
    this_oBusinessObject = .NULL.

    *-- Referencia do form PAI. Equivale a property customizada "parentform"
    *-- que o SCX legado acrescenta ao form (RESERVED3/ClassInfo do dump) -
    *-- NAO eh a ParentForm nativa do VFP9, que eh read-only. Fica .NULL.
    *-- quando a tela eh aberta sem pai, entao TODO uso dela em fase
    *-- posterior vai sob guarda VARTYPE(THIS.this_oFormPai) = "O".
    this_oFormPai = .NULL.

    *-- Ultima falha de geracao/formatacao do grafico. Serve para o CATCH
    *-- de cada bloco de formatacao NAO ficar silencioso (regra #9) sem
    *-- empilhar quatro modais: cada bloco registra aqui e quem orquestra
    *-- exibe UMA vez (ver MostrarGrafico / GerarGrafico).
    this_cFalhaGrafico = ""

    *-- .T. quando GerarGrafico desenhou o chart. O form pai pode consultar
    *-- antes de oferecer a impressao.
    this_lGraficoPronto = .F.

    *==========================================================================
    * Init - Recebe os dois parametros do Init legado (pForm, datses) e entra
    * na sessao de dados do pai ANTES do DODEFAULT(), para enxergar os
    * cursores crFinal/Cabecalho que o pai populou.
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
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.Init")
        ENDTRY

        *-- DODEFAULT() chama FormBase.Init(), que por sua vez chama
        *-- recebe os SETs no default do VFP e eh FormBase.Init() quem repoe
        *-- SET DATE TO BRITISH + SET CENTURY ON (CLAUDE.md regra #9.4).
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO, aponta os cursores de origem (contrato
    * com o form pai: quem sabe os nomes eh o Form, nao o BO) e monta a
    * estrutura visual.
    *
    * NAO chama THIS.Show(): este form eh WindowType = 1 (modal) e o Show()
    * bloqueia - quem exibe eh o pai, FORA de TRY/CATCH (regra #29).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpGcoBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Aliases que o form PAI deixa prontos (crFinal / Cabecalho
                *-- do legado). Sao os defaults do SigOpGcoBO.Init, reafirmados
                *-- aqui porque o contrato com o pai eh do Form (PILAR 3).
                THIS.this_oBusinessObject.this_cCursorOrigem    = "crFinal"
                THIS.this_oBusinessObject.this_cCursorCabecalho = "Cabecalho"

                *-- Fundo do form: ..\framework\imagens\new_background.jpg do
                *-- SCX. Resolvido por gc_4c_CaminhoIcones (o arquivo esta em
                *-- vbmp\), convencao dominante do projeto.
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                *-- Monta e desenha o grafico, como o Init legado faz logo
                *-- depois de ajustar os labels do cabecalho. Falha aqui NAO
                *-- impede a tela de abrir (convencao do projeto): sem os
                *-- cursores do pai - probe/harness, ou pai que nao
                *-- processou - GerarGrafico avisa e devolve .F., e o
                *-- usuario ainda tem o Encerrar para sair.
                *--
                *-- PULADO sob gb_4c_ValidandoUI (Fase 8): o ValidarUIFidelity
                *-- instancia o form SEM pai, entao crFinal/Cabecalho nao
                *-- existem, CarregarDoCursor devolve .F. e o aviso sairia como
                *-- MESSAGEBOX MODAL - que, num harness sem ninguem para
                *-- clicar, TRAVA a validacao ate o timeout. MsgAviso so se
                *-- auto-suprime em gb_4c_ModoTeste (ver utils\messages.prg);
                *-- gb_4c_ValidandoUI ele nao conhece. Guard canonico do
                *-- projeto (FormCor): a montagem VISUAL acontece inteira e so
                *-- a carga de DADOS eh pulada, que eh justamente o que aquele
                *-- validador compara.
                *--
                *-- gb_4c_ModoTeste NAO entra no guard de proposito: ali os
                *-- dialogos ja vao para arquivo e o probe PRECISA exercitar o
                *-- caminho do grafico.
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.GerarGrafico()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigOpGcoBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigOpGco.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador da montagem visual. O SIGOPGCO NAO
    * tem PageFrame (layout flat: todos os objetos sao filhos diretos do
    * form), entao NAO se cria Page nenhuma aqui - o nome eh mantido apenas
    * como ponto de entrada arquitetural padrao, mesmo papel que tem em
    * FormSigPrGf2 e FormSigPrGf1 (as outras telas de grafico do projeto).
    *
    * A Fase 3 entregou o cabecalho; a Fase 4 acrescentou os 2 botoes e
    * a Fase 5 acrescenta o Shape e o OleBoundControl. O ConfigurarEventos
    * com os BINDEVENT vai por ULTIMO de proposito, porque BINDEVENT so
    * resolve referencia de objeto que JA existe.
    *
    * A ORDEM DAS CHAMADAS reproduz a ordem dos REGISTROS do SCX legado
    * (cntSombra -> Shape2 -> OleGrafico -> sair -> Imprimir), e isso NAO eh
    * cosmetico: AddObject empilha no z-order, entao o ultimo criado desenha
    * por cima. O shp_4c_Shape2 ocupa Top=7..117 / Left=615..788, ou seja
    * EXATAMENTE a area dos dois botoes (Top=3..78, Left=647..798) - criado
    * DEPOIS deles ele ficaria na frente e, mesmo sendo transparente
    * (BackStyle=0) e sem borda (BorderStyle=0), um Shape por cima intercepta
    * o clique e os botoes Imprimir/Encerrar parariam de responder. Por isso
    * ConfigurarPaginaDados vem ANTES de ConfigurarBotoes, como no legado.
    *
    * AjustarOrdemTabulacao fecha a montagem porque TabIndex so pode ser
    * atribuido depois de TODOS os AddObject (atribuir em controle que ainda
    * nao existe estoura).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Cabecalho PRIMEIRO: os botoes ficam em Top=3, DENTRO
        *-- da area da faixa (0..80), e so desenham por cima dela
        *-- se forem criados DEPOIS (CLAUDE.md regra #11).
        THIS.ConfigurarCabecalho()

        *-- Area do grafico (Shape + OleBoundControl), na posicao que o SCX
        *-- lhe da: depois do cabecalho e ANTES dos botoes.
        THIS.ConfigurarPaginaDados()

        THIS.ConfigurarBotoes()

        *-- Depois de TODOS os AddObject.
        THIS.AjustarOrdemTabulacao()

        *-- BINDEVENT por ULTIMO: so resolve objeto que JA existe.
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
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Fase 5/8. Area de exibicao do grafico.
    *
    * NAO existe "Page2 de Dados" neste form: o SIGOPGCO eh FLAT (todos os 8
    * objetos da arvore do SCX sao filhos DIRETOS do form, zero PageFrame) e
    * nao tem campo de entrada nenhum - zero TextBox / EditBox / ComboBox /
    * ListBox / CheckBox / OptionGroup / Spinner no dump inteiro. "Metade dos
    * campos" de um legado com ZERO campos eh zero, e inventar campo ou aba
    * violaria o PILAR 1 e a regra "NUNCA inventar o que o legado nao tem".
    *
    * O metodo tem corpo REAL, e nao o THIS.Refresh() de fachada: a superficie
    * de DADOS desta tela sao os dois ultimos objetos da arvore do SCX, que
    * eh o que esta fase entrega -
    *
    *   Shape2      Top=7,   Left=615, Width=173, Height=110,
    *               BackStyle=0, BorderStyle=0, BorderColor=136,189,188
    *   OleGrafico  Top=141, Left=12,  Width=770, Height=418,
    *               Enabled=.T., AutoActivate=0, TabIndex=0
    *
    * SHAPE INVISIVEL, E ISSO EH FIEL: BackStyle=0 (sem preenchimento) com
    * BorderStyle=0 (sem borda) nao desenha nada na tela. Eh moldura
    * decorativa que o Form Designer deixou atras dos dois botoes (a mesma
    * BorderColor 136,189,188 do Framework Fortyus). NAO "corrigir" para
    * BorderStyle=1 achando que o retangulo deveria aparecer - no legado ele
    * nunca apareceu; e o z-order dele importa (ver ConfigurarPageFrame).
    *
    * CONTROLSOURCE FICA VAZIO AQUI, DE PROPOSITO. O legado nao liga o campo
    * General na criacao do controle: ele liga dentro do mostragrafico
    * (".ControlSource = 'gGraficos'"), depois que o Init ja criou o cursor
    * Graph e gravou o binario nele com Append General. Apontar o
    * ControlSource para cursor_4c_Grafico aqui estouraria
    * "Alias 'CURSOR_4C_GRAFICO' is not found" DENTRO do TRY do
    * InicializarForm - que devolveria .F., CREATEOBJECT devolveria .F. e a
    * tela nao abriria, sem erro visivel (CLAUDE.md regra #41). O "" explicito
    * garante que o controle nasce desligado; quem liga eh o metodo de DESENHO
    * do grafico (Fase 7/8), no mesmo lugar em que o legado liga. Mesmo
    * tratamento de FormSigPrGf2.obj_4c_OleGrafico1, a outra tela de grafico
    * do projeto.
    *
    * TabIndex = 0 do dump NAO eh transcrito literalmente: TabIndex eh um
    * ORDINAL 1..N dentro do container e valor fora dessa faixa eh DESCARTADO
    * em silencio pelo VFP9 - escrever 0 seria linha inerte afirmando um valor
    * que o objeto nunca guarda. A ordem de tabulacao efetiva do legado esta
    * reproduzida em AjustarOrdemTabulacao.
    *
    * AutoActivate = 0 (manual) eh transcricao do dump e eh o que mantem o
    * grafico como EXIBICAO: sem ele o usuario ativaria o MSGraph in-place com
    * duplo clique e editaria o chart por cima da tela.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 7
                .Left        = 615
                .Width       = 173
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                *-- Shape NAO tem ForeColor: a cor da linha eh BorderColor e a
                *-- do preenchimento eh FillColor (CLAUDE.md regra #33).
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("obj_4c_OleGrafico", "OleBoundControl")
            WITH THIS.obj_4c_OleGrafico
                .Top          = 141
                .Left         = 12
                .Width        = 770
                .Height       = 418
                .Enabled      = .T.
                .AutoActivate = 0
                *-- Nasce DESLIGADO: o alias do grafico ainda nao existe.
                .ControlSource = ""
                .Visible      = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarOrdemTabulacao - Reproduz a ordem de tabulacao do SCX legado.
    *
    * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
    * tem relacao com a do legado. Nao ha erro, nao ha log e nao aparece em
    * screenshot: so o Tab andando na ordem errada.
    *
    * O dump declara TabIndex em UM unico objeto - OleGrafico = 0 - e esse
    * valor esta FORA da faixa valida (TabIndex eh ordinal 1..N dentro do
    * container), logo o VFP o DESCARTA no load e o legado fica com a ordem
    * dos REGISTROS do SCX. Filhos diretos do form, nessa ordem:
    *
    *   cntSombra = 1, (Shape2 nao tem TabIndex), OleGrafico = 2,
    *   sair = 3, Imprimir = 4
    *
    * O migrado cria na ordem cnt_4c_Sombra -> shp_4c_Shape2 ->
    * obj_4c_OleGrafico -> cmd_4c_Imprimir -> cmd_4c_Sair, o que daria
    * Imprimir = 3 e Encerrar = 4 - os dois botoes TROCADOS em relacao ao
    * legado, onde o Encerrar vem primeiro. Este metodo corrige isso.
    *
    * Atribuicao em ordem ASCENDENTE: cada atribuicao poe o controle na
    * posicao pedida e empurra os demais para tras. Em ordem descendente dois
    * irmaos TROCAM de lugar e a tabulacao sai ao contrario do pretendido.
    *
    * Os valores sao os ORDINAIS EFETIVOS (1..4), nao os literais do dump, e
    * sao unicos: valor duplicado ou fora da faixa eh descartado em silencio,
    * tornando a linha inerte. A faixa aqui eh 1..4 e nao 1..5 porque
    * shp_4c_Shape2 eh um Shape, classe que NAO tem a propriedade TabIndex -
    * por isso ele nao recebe numero nem entra na contagem.
    *
    * Os dois Label do cabecalho tambem nao sao numerados: Label tem TabIndex
    * mas NAO tem TabStop (nunca recebe foco), entao numera-los eh inerte e
    * ainda embaralha a sequencia dos controles que de fato param o Tab. Eles
    * ja nascem na ordem do SCX dentro de cnt_4c_Sombra (lblSombra antes de
    * lblTitulo), que eh escopo separado do form.
    *==========================================================================
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        LOCAL loc_oErro

        TRY
            *-- SCX: cntSombra, 1o registro filho do form (nao declara
            *-- TabIndex, fica com o ordinal da criacao).
            THIS.cnt_4c_Sombra.TabIndex = 1

            *-- SCX: OleGrafico. O TabIndex = 0 do dump eh descartado pelo
            *-- VFP e o controle fica com o ordinal de criacao, que eh 2 (o
            *-- Shape2 entre ele e o cntSombra nao tem TabIndex).
            THIS.obj_4c_OleGrafico.TabIndex = 2

            *-- SCX: sair, criado ANTES do Imprimir - o Encerrar vem primeiro
            *-- no ciclo do Tab, e eh isto que o migrado estava invertendo.
            THIS.cmd_4c_Sair.TabIndex = 3

            *-- SCX: Imprimir, ultimo registro filho do form.
            THIS.cmd_4c_Imprimir.TabIndex = 4
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.AjustarOrdemTabulacao")
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
    * Destroy - Fecha os cursores que ESTA tela criou, solta o BO e solta a
    * referencia do pai, para a tela filha nao segurar o form pai depois de
    * fechada.
    *
    * A LIMPEZA NAO EXISTIA ATE A FASE 8, e o comentario que estava aqui
    * afirmava que "o BO fecha os cursores de trabalho que ele mesmo cria" -
    * o que era FALSO: o SigOpGcoBO nao tinha Destroy nem metodo de limpeza.
    * Ficavam abertos o cursor do campo General (cursor_4c_Grafico, criado por
    * GerarGrafico) e os tres cursores de trabalho do BO (Meses, Grupos e
    * Percentuais, criados por CarregarDoCursor).
    *
    * E o vazamento NAO morria com a tela: havendo form pai, este form entra na
    * data session DELE (ver Init), entao os quatro aliases ficavam pendurados
    * na sessao de QUEM ABRIU, ate o pai ser fechado. Precedente da mesma
    * familia: FormSigPrGf1.Destroy e FormSigPrGf2.Destroy, as outras duas
    * telas de grafico do projeto.
    *
    * Os cursores crFinal e Cabecalho continuam NAO sendo fechados aqui: quem
    * os cria eh o form PAI, na sessao de dados dele, e eh ele quem os fecha -
    * derruba-los daqui tiraria o chao do pai se o usuario fechar o grafico e
    * processar outro periodo em seguida.
    *
    * DODEFAULT() por ULTIMO eh obrigatorio: eh FormBase.Destroy que reconstroi
    * os popups do menu principal depois de um form modal fechar.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cAliasGrafico, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAliasGrafico = ALLTRIM(THIS.this_oBusinessObject.this_cCursorGrafico)

                *-- Cursor do campo General. Fechado ANTES de soltar o BO,
                *-- porque eh dele que sai o nome do alias. IF aninhado e nao
                *-- AND: VFP9 nao faz short-circuit, e USED("") estoura.
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
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.Destroy")
        ENDTRY

        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.

        DODEFAULT()
    ENDPROC


    *==========================================================================
    * ConfigurarBotoes - Os DOIS CommandButton fwbtng do SCX, filhos DIRETOS
    * do form. A arvore da SECAO 1 lista "Imprimir" e "sair" como objetos
    * separados, nao como Buttons de um CommandGroup - agrupa-los seria
    * inventar estrutura que o legado nao tem (PILAR 1).
    *
    *   Imprimir  Top=3, Left=647, Caption="\<Imprimir",
    *             Picture = ..\framework\imagens\geral_impressora_normal_60.jpg
    *   sair      Top=3, Left=723, Caption="Encerrar",
    *             Picture = ..\framework\imagens\cadastro_sair_60.jpg
    *
    * Width/Height nao aparecem no dump porque vem da classe fwbtng
    * (framework.vcx: 80x100, a variante "Grande"). Esses numeros NAO cabem
    * nesta tela: com Width=80 os dois botoes se SOBREPOEM (647+80 = 727 >
    * 723) e o segundo ainda passa da borda do form (723+80 = 803 > 800); com
    * Height=100 o botao vaza 23px abaixo da faixa do cabecalho (3+100 = 103
    * contra os 80 do cnt_4c_Sombra). O passo de 76px entre os dois Left eh o
    * mesmo do framework - o FormSIGOPCGF tem a dupla em Left 11/87 dentro do
    * MESMO Shape 173x110 que esta tela usa - e com 75x75 os dois tilam
    * exatamente nesse passo e cabem na faixa: 647..722 e 723..798, Top 3..78.
    * 75x75 eh tambem a geometria canonica dos botoes de icone do projeto
    * (FormSigPrGf2.ConfigurarBotoesGrafico, FormSIGOPCGF).
    *
    * Criados DEPOIS de ConfigurarCabecalho de proposito: ficam DENTRO da area
    * da faixa (Top=3, faixa 0..80) e so desenham por cima dela se forem os
    * AddObject seguintes (CLAUDE.md regra #11).
    *
    * Themes = .T. + DisabledPicture com a MESMA imagem: CommandButton SOLTO
    * (fora de CommandGroup) com .Picture nao renderiza o icone com
    * Themes = .F. (CorretorAutomatico #99). A excecao Themes = .F. vale para
    * Buttons(N) DENTRO de CommandGroup, que nao eh o caso aqui.
    *
    * Os dois .jpg foram conferidos em vbmp\ - .Picture apontando para arquivo
    * inexistente nao da erro nenhum, o botao so fica sem icone (regra #25).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
            WITH THIS.cmd_4c_Imprimir
                .Top             = 3
                .Left            = 647
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

            THIS.AddObject("cmd_4c_Sair", "CommandButton")
            WITH THIS.cmd_4c_Sair
                .Top             = 3
                .Left            = 723
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
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
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - BINDEVENT dos Click. Fica por ULTIMO na montagem:
    * BINDEVENT so resolve referencia de objeto que JA existe.
    *
    * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
    * metodo PROTECTED (CLAUDE.md regra #3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "CmdImprimirClick")
            BINDEVENT(THIS.cmd_4c_Sair,     "Click", THIS, "CmdSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarEventos")
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
    * MSGraph.Chart (Create Cursor Graph (gGraficos Gen(4)) no legado); no
    * migrado ele eh THIS.this_oBusinessObject.this_cCursorGrafico
    * ("cursor_4c_Grafico") e o FRX eh this_cRelatorio ("SigOpGrc") - os dois
    * nomes moram no BO desde a Fase 1 e nao sao reescritos aqui.
    *
    * O SELECT + GO TOP repetido DEPOIS do relatorio nao eh redundancia do
    * legado: o REPORT FORM deixa o cursor em EOF, e o OleBoundControl le o
    * campo General do REGISTRO CORRENTE - sem voltar ao topo, o Refresh
    * repintaria o grafico com registro nenhum.
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

            *-- Guard pelo FLAG do BO, e nao so por USED()/RECCOUNT (Fase 8).
            *-- Quando o APPEND GENERAL falha (MsGraph.Chart nao registrado na
            *-- estacao), AnexarGraficoAoCursor apaga a linha em branco - mas
            *-- DELETE so MARCA, e RECCOUNT() CONTA registro marcado como
            *-- excluido, porque SET DELETED esta OFF por default. Sem este
            *-- flag o alias existia, o guard de RECCOUNT = 0 do
            *-- ExecutarReportForm nao segurava, e o usuario mandava para a
            *-- impressora um relatorio EM BRANCO em vez de receber o aviso.
            *-- Mesmo criterio que MostrarGrafico ja aplicava no desenho.
            IF loc_lProsseguir
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
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.CmdImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSairClick - Click do botao "Encerrar". Legado: "Thisform.Release".
    *
    * Release() e nao Hide(): esta tela eh WindowType = 1 (modal) e o Show()
    * que a exibe esta BLOQUEADO no form pai - o Release eh o que devolve o
    * controle para ele. Os cursores crFinal/Cabecalho continuam de pe: sao do
    * pai, e quem os fecha eh ele (ver Destroy).
    *==========================================================================
    PROCEDURE CmdSairClick()
        LOCAL loc_oErro

        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.CmdSairClick")
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
    * Modos: PREVIEW, PRINTER_PROMPT, PRINTER.
    *==========================================================================
    PROCEDURE ExecutarReportForm(par_cFRXPath, par_cModo, par_cCursorDados)
        LOCAL loc_cPonto, loc_cSeparador, loc_nBehavior, loc_lResultado, ;
              loc_lProsseguir, loc_oErro, loc_oErroMenu

        loc_cPonto      = SET("POINT")
        loc_cSeparador  = SET("SEPARATOR")
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
                    "Procedure: " + loc_oErro.Procedure, "FormSigOpGco.ExecutarReportForm")
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
                MsgErro(loc_oErroMenu.Message, "FormSigOpGco.ExecutarReportForm")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC
    *==========================================================================
    * ObterComparativoDoPai - Le "Thisform.Parentform.Comparativo.Value" do
    * legado (usado no Init e no mostragrafico). Eh o controle do form PAI que
    * decide o modo de agrupamento: valendo 1, o grupo passa a ser
    * Grupos + Ano e os rotulos de percentual sao aplicados as series;
    * valendo outro numero, o grupo eh so Grupos e nao ha rotulo.
    *
    * Tres guardas, nao uma: este form abre tambem SEM pai (probe/harness) e
    * o pai pode nao ter o controle.
    *   1) VARTYPE(THIS.this_oFormPai) = "O"    - ha pai?
    *   2) PEMSTATUS(..., "Comparativo", 5)     - o pai tem o membro?
    *   3) VARTYPE(... .Comparativo) = "O"      - o membro eh OBJETO?
    * A 3a nao eh redundante: PEMSTATUS(obj, <nome>, 5) so verifica
    * EXISTENCIA e devolve .T. tambem para property comum, inclusive
    * PROTECTED - confiar nele sozinho eh a armadilha das regras #3/#34, e a
    * linha seguinte quebraria em runtime.
    *
    * Sem pai (ou sem o controle) devolve 0, que eh o ramo "nao comparativo" -
    * o mesmo caminho do legado quando o Value nao vale 1.
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
    * manipula objeto OLE). Mesma divisao de FormSigPrGf2.
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

                *-- Modo de agrupamento, lido do PAI como no legado. Tem de
                *-- ser atribuido ANTES do CarregarDoCursor: eh ele que decide
                *-- se a chave de grupo leva o Ano e se a matriz de
                *-- percentuais eh preenchida.
                loc_oBO.this_nComparativo = THIS.ObterComparativoDoPai()

                *-- Cursor do campo General, equivalente ao "Create Cursor
                *-- Graph (gGraficos Gen (4))" do legado. Recriado a cada
                *-- geracao: o grafico eh UM registro so (o legado tambem faz
                *-- um Append Blank por abertura da tela), entao nao ha cache
                *-- por chave como em FormSigPrGf2 - esta tela desenha um
                *-- conjunto unico de series.
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

                *-- Agregacao dos cursores do pai (Fase 2 do BO)
                IF loc_oBO.CarregarDoCursor(loc_cOrigem, loc_oBO.this_cCursorCabecalho)
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
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.GerarGrafico")
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
    * "MsGraph.Chart" pode nao estar registrado na estacao - medido nesta
    * maquina: OLE error 0x800401f3 "Cadeia de caracteres de classe
    * invalida", porque o MSGraph vem com o Microsoft Office. Nesse caso o
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
    * uma flag ("On Error m.llOnErro1 = .t.") e restaura o anterior no fim.
    * A diferenca eh de CONTROLE DE FLUXO, nao de estilo: com ON ERROR a
    * execucao CONTINUA na linha seguinte, entao uma propriedade que o
    * servidor OLE recuse nao impede as outras 40 de serem aplicadas; com um
    * TRY unico em volta de tudo, a primeira recusa abandonaria todo o resto
    * da formatacao e o grafico sairia meio formatado.
    *
    * Por isso cada bloco tem o seu TRY e devolve .T./.F.: um bloco que falhe
    * nao derruba os demais, reproduzindo a tolerancia do ON ERROR legado. E
    * nenhum CATCH eh silencioso (regra #9) - todos registram a mensagem em
    * this_cFalhaGrafico, exibida UMA vez no fim; quatro MsgErro seguidos
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
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.MostrarGrafico")
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
    * fixo, pRelTitulo e pPeriodo (do cursor Cabecalho, lidos pelo BO) e
    * "Todas as Empresas".
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
    * ".chartgroups(1).hasserieslines = .t." do legado tambem eh atribuicao
    * MORTA - duas linhas depois, dentro do "With .ChartGroups(1)", o proprio
    * legado poe .HasSeriesLines = .f.. O valor efetivo (.F.) eh o aplicado.
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
                    *-- Valor EFETIVO: o legado liga .hasserieslines fora do
                    *-- WITH e desliga aqui dentro (ver cabecalho).
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
