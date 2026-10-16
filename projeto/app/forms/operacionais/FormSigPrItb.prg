*==============================================================================
* FormSigPrItb.prg
*
* Origem legado: SIGPRITB.SCX (task632)
* Herda de: FormBase
* Tipo: OPERACIONAL - form PLANO sem PageFrame (layout.json: todos os objetos
*       sao filhos diretos de SIGPRITB, sem Pagina.Lista/Pagina.Dados). Tela
*       de FILTRO (periodo obrigatorio + empresa opcional) que processa os
*       lancamentos financeiros do periodo (SigMvCcr), classifica a conta
*       contabil de cada um (SigCdGcr/SigCdCli) e gera o arquivo texto de
*       integracao contabil (um arquivo por empresa) no diretorio configurado
*       em SigCdPam.DirContabv.
*
* BO: SigPrItbBO (sem tabela propria - processamento em lote, sem CRUD; ver
*     SigPrItbBO.Processar/GerarArquivoContabil/ValidarPeriodo)
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init, cabecalho)
*            Fase 4 - ConfigurarBotoesAcao() (botao solto + 2 CommandGroup)
*            Fase 5 - ConfigurarFiltroPeriodo() estrutural: cnt_4c_Mvt1
*            com os campos de periodo (Data Inicial/Data Final) e empresa
*            (codigo/razao), posicoes e valores iniciais do Init legado.
*            Fase 6 (esta) - Format="K" dos 4 campos do filtro (transcrito do
*            dump - regra #49), SpecialEffect/Alignment/Themes de getData1/
*            getData2 (herdados da classe fweditdata do legado) + lookup de
*            empresa (Valid de getEmp1/getDsemp1 do SCX legado -> KeyPress
*            Enter/Tab/F4 em txt_4c_Emp1/txt_4c_Dsemp1, usando
*            SigPrItbBO.CarregarEmpresa para o match exato e
*            FormBuscaAuxiliar para o picker quando nao casa). O When de
*            getDsemp1 ("Return Empty(getEmp1.Value)" - so permite buscar
*            por razao social quando o codigo esta vazio) e replicado como
*            guarda no inicio do handler, padrao ValidarDemp de
*            Formsigatcrp.prg (fAcessoEmpresa).
*            Fase 7/8 (esta) - ConfigurarAguarde() (cnt_4c_Aguarde + Shape1
*            decorativo); eventos dos botoes de acao: cmd_4c_Processar
*            (BtnProcessarClick -> valida periodo via SigPrItbBO.
*            ValidarPeriodo, confirma e delega para ExecutarProcessamento,
*            equivalente ao PROCEDURE "Processamento" do SCX legado);
*            cmg_4c_Relatorio Buttons(1)/(2) (BtnImprimirClick/
*            BtnVisualizarClick -> REPORT FORM SigPrIct via
*            PrepararCursoresRelatorio + ExecutarReportForm - canonico
*            #117/#147, mesmo FRX e mesmo contrato de cursores literais
*            "Cabecalho"/"SemConta" de FormSigPrIct.prg); cmg_4c_Sair
*            Buttons(1) (BtnEncerrarClick -> THIS.Release()).
*            Fase 8 (esta) - consolidacao final. Entraram os quatro metodos
*            de FUNIL que o legado escreve espalhado em atribuicao inline:
*              FormParaBO()/BOParaForm() - par canonico de transporte dos
*                quatro campos do filtro (periodo + empresa);
*              HabilitarCampos()         - o bloco ".Enabled" dos campos do
*                filtro (Init e ramo de inconsistencia do "processamento");
*              AjustarBotoesPorModo()    - o bloco ".Enabled" de Processar/
*                btnImprimir/btnVisualizar, escrito pelo legado nos MESMOS
*                pontos.
*            InicializarForm, BtnProcessarClick e ExecutarProcessamento
*            passaram a chamar esses metodos no lugar das atribuicoes
*            inline, para o estado da tela ter fonte unica.
*
* DECISOES DE PROJETO REGISTRADAS NA FASE 8
* -----------------------------------------
* 1) NAO existem CarregarLista(), LimparCampos(), BtnSalvarClick(),
*    BtnCancelarClick() nem BtnBuscarClick(): SIGPRITB nao tem grade, nao tem
*    lista, nao tem Page1/Page2, nao tem os modos LISTA/INCLUIR/ALTERAR/
*    VISUALIZAR e nao grava registro em tabela nenhuma - eh tela de FILTRO +
*    PROCESSAMENTO EM LOTE cujo produto eh arquivo TEXTO (um por empresa) em
*    SigCdPam.DirContabv. O dump legado tem exatamente 14 metodos com codigo
*    (gravar, processamento, Init, Load, Release, getDsemp1.Valid,
*    getDsemp1.When, getEmp1.Valid, Botoes_de_Acao.Click, Sair.Click,
*    Processar.Click, cntBotoes.Botoes_de_Acao.Click, btnImprimir.Click e
*    btnVisualizar.Click) e TODOS estao migrados. Criar aqui metodos de CRUD
*    produziria casca vazia sem correspondente no legado, o que a regra de
*    completude proibe. Mesma decisao ja registrada em FormSigPrGf1.
* 2) O unico botao de fechar do legado eh o CommandGroup "Botoes_de_Acao"
*    (membro "Sair", Click = "ThisForm.Release", Cancel = .T.) - o handler
*    chama-se BtnEncerrarClick, nao BtnCancelarClick: o Click so faz Release,
*    nao desfaz nem interrompe nada. Como o botao migrado mantem
*    .Cancel = .T., o ESC continua caindo nesse mesmo handler, igual ao
*    legado; batizar o handler de "Cancelar" daria ao botao o verbo de uma
*    acao que a tela nao tem e violaria o PILAR 3.
* 3) ExecutarGravacaoArquivo() NAO passa por HabilitarCampos()/
*    AjustarBotoesPorModo(), de proposito: o "gravar" legado reabilita APENAS
*    getData1/getData2 e desabilita APENAS os dois botoes de relatorio - nao
*    toca em getEmp1/getDsemp1 nem em Processar. Rotear pelo funil
*    reabilitaria esses tres a mais e divergiria do legado (regra #17 -
*    transcrever, nunca "melhorar"). As quatro linhas ficam literais la.
* 4) O Load legado faz "=fConfigGeral()" e cria o cursor MovAux. O
*    utils\fconfiggeral.prg eh wrapper no-op que existe apenas para o p-code
*    dos VCX legado (em codigo nosso nunca se chama), e MovAux virou
*    cursor_4c_MovAux, criado por SigPrItbBO.Processar() - por isso este form
*    nao declara Load.
* 5) O Release legado faz "ThisForm.poDataMgr.Release". Nao existe poDataMgr
*    no migrado (a conexao eh o gnConnHandle global, de vida mais longa que o
*    form), entao o equivalente do Release eh o Destroy, que fecha os
*    cursores deste form e encadeia DODEFAULT().
*==============================================================================

DEFINE CLASS FormSigPrItb AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    *-- SIGPRITB.SCX: BorderStyle=2, Height=229, Width=800, AutoCenter=.T.,
    *-- ControlBox=.F., Closable=.F., MinButton=.F., ClipControls=.F.,
    *-- TitleBar=0 (todas transcritas do dump - SECAO 2, PROPRIEDADES DE
    *-- SIGPRITB). DataSession nao consta do dump - mantem o default herdado
    *-- (sessao corrente, regra "DataSession 1 eh a sessao corrente").
    Width        = 800
    Height       = 229
    AutoCenter   = .T.
    Caption      = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil Total"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MinButton    = .F.
    TitleBar     = 0
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.

    *-- WindowType = 1 eh canonico do projeto, NAO transcricao: o SCX herda o
    *-- default 0 (modeless) do baseclass form, mas o menu.prg abre a tela com
    *-- CREATEOBJECT + variavel LOCAL + Show(), e com modeless o Show()
    *-- retorna na hora, a LOCAL sai de escopo e o form eh destruido.

    *==========================================================================
    * Init - Sem parametros recebidos do chamador (form aberto direto pelo
    * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual base.
    * Fase 3 (esta) monta apenas o cabecalho (cnt_4c_Sombra); os demais
    * blocos (botoes de acao, filtro de periodo/empresa, aguarde) entram nas
    * proximas fases, dentro de ConfigurarPageFrame().
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lModoSemBanco, loc_lParametrosOk, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrItbBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Init legado aborta a tela se "Select DirContabv From
                *-- SigCdPam" falhar (MessageBox + Return 0) - em validacao de
                *-- UI/modo teste nao ha conexao SQL, e o form so monta a
                *-- estrutura visual (mesmo padrao de FormSIGPRIMP.CarregarLista).
                *-- IF ... OR CarregarParametros() avaliaria CarregarParametros()
                *-- de qualquer jeito (VFP9 nao faz short-circuit em OR - regra
                *-- #27), disparando SQLEXEC mesmo em modo teste - por isso o
                *-- IF/ELSE separado abaixo, que so chama o BO quando necessario.
                loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                    (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)

                IF loc_lModoSemBanco
                    loc_lParametrosOk = .T.
                ELSE
                    loc_lParametrosOk = THIS.this_oBusinessObject.CarregarParametros()
                ENDIF

                IF loc_lParametrosOk
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                    THIS.ConfigurarPageFrame()

                    THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Estado inicial do Init legado (".getData1.Enabled = .t.",
                    *-- ".getData2.Enabled = .t.", ".btnImprimir.Enabled = .f." e
                    *-- ".btnVisualizar.Enabled = .f.") pelo funil unico da Fase 8
                    THIS.this_cModoAtual = "FILTRO"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()

                    THIS.Visible = .T.

                    loc_lSucesso = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "FormSigPrItb.InicializarForm")
                ENDIF
            ELSE
                MsgErro("Erro ao criar SigPrItbBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrItb.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrItb.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRITB nao tem
    * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
    * como ponto de entrada arquitetural padrao (mesmo papel em FormSigPrGf1/
    * FormSigPrChr/FormFop/FormEnd).
    *
    * Roteiro:
    *   Fase 3 (feita) - ConfigurarCabecalho()
    *   Fase 4 (feita) - ConfigurarBotoesAcao()
    *   Fase 5 (feita) - ConfigurarFiltroPeriodo() estrutural
    *   Fase 6 (feita) - refinamento do filtro (Format/SpecialEffect/Themes) +
    *                     BINDEVENT dos handlers de lookup de empresa, dentro
    *                     do proprio ConfigurarFiltroPeriodo()
    *   Fase 7/8 (feita) - ConfigurarAguarde() (cnt_4c_Aguarde + Shape1) +
    *                      BINDEVENT dos botoes de acao, dentro do proprio
    *                      ConfigurarBotoesAcao()
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarFiltroPeriodo()
        THIS.ConfigurarAguarde()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes de acao do form (layout.json): botao
    * "Processar" solto (fwbtng do legado -> CommandButton canonico) e dois
    * CommandGroup, EXATAMENTE como no SCX original - este form NAO tem
    * botoes CRUD (Incluir/Alterar/Excluir/Buscar): eh tela de PROCESSAMENTO
    * EM LOTE (filtro de periodo + empresa -> gera arquivo de integracao
    * contabil), sem Lista/Grid e sem Page1/Page2.
    *
    *   cmd_4c_Processar  - solto no form (SIGPRITB.Processar, Top=3/Left=649)
    *   cnt_4c_Botoes     - container (SIGPRITB.cntBotoes, Top=1/Left=496)
    *     cmg_4c_Relatorio  - CommandGroup com 2 botoes (legado chama o
    *                         container interno de "BtnReport" no codigo -
    *                         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.btnImprimir/
    *                         btnVisualizar.Enabled = .f./.t. na Fase 7/8):
    *                         Buttons(1) Impressora, Buttons(2) Video
    *   cmg_4c_Sair       - CommandGroup com 1 botao (SIGPRITB.Botoes_de_Acao,
    *                       Top=-2/Left=719) - Buttons(1) Encerrar
    *
    * Eventos (Click) dos tres sao ligados na Fase 7/8, junto com Shape1 e
    * cnt_4c_Aguarde - aqui entra apenas a estrutura visual.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oCmg, loc_oErro

        TRY
            *-- cmd_4c_Processar (SIGPRITB.Processar, classe fwbtng do legado -
            *-- defaults Height=100/Width=80/FontName="Comic Sans MS" herdados
            *-- de framework.vcx, mas o canonico do projeto para botao de acao
            *-- solto com icone eh 75x75, igual ao FormSIGMVCMV/Processa)
            THIS.AddObject("cmd_4c_Processar", "CommandButton")
            WITH THIS.cmd_4c_Processar
                .Top             = 3
                .Left            = 649
                .Height          = 75
                .Width           = 75
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption         = "\<Processar"
                .FontName        = "Comic Sans MS"
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
            BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

            *-- cnt_4c_Botoes (SIGPRITB.cntBotoes)
            THIS.AddObject("cnt_4c_Botoes", "Container")
            WITH THIS.cnt_4c_Botoes
                .Top         = 1
                .Left        =  496
                .Width       = 156
                .Height      = 84
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- cmg_4c_Relatorio (SIGPRITB.cntBotoes.Botoes_de_Acao, 2 botoes)
            THIS.cnt_4c_Botoes.AddObject("cmg_4c_Relatorio", "CommandGroup")
            loc_oCmg = THIS.cnt_4c_Botoes.cmg_4c_Relatorio
            WITH loc_oCmg
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Top         = -3
                .Left        = -2
                .Width       = 160
                .Height      = 85
                .Value       = 1
                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 80
                    .Height          = 75
                    .Width           = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .WordWrap        = .T.
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                    .Caption         = "\<Impressora"
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    *-- Init legado: .cntBotoes.BtnReport.btnImprimir.Enabled = .f.
                    .Enabled         = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 5
                    .Height          = 75
                    .Width           = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .WordWrap        = .T.
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                    .Caption         = "\<Video"
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    *-- Init legado: .cntBotoes.BtnReport.btnVisualizar.Enabled = .f.
                    .Enabled         = .F.
                ENDWITH
            ENDWITH
            *-- btnImprimir (Buttons(1)) / btnVisualizar (Buttons(2)) do dump -
            *-- o Click do GRUPO (SIGPRITB.cntBotoes.Botoes_de_Acao) eh vazio
            *-- no legado, so os botoes individuais tem codigo
            BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnVisualizarClick")

            *-- cmg_4c_Sair (SIGPRITB.Botoes_de_Acao, 1 botao - Encerrar)
            THIS.AddObject("cmg_4c_Sair", "CommandGroup")
            loc_oCmg = THIS.cmg_4c_Sair
            WITH loc_oCmg
                .ButtonCount   = 1
                .AutoSize      = .T.
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .Top           = -2
                .Left          = 719
                .Width         = 85
                .Height        = 85
                .Value         = 0
                WITH .Buttons(1)
                    .Top       = 5
                    .Left      = 5
                    .Height    = 75
                    .Width     = 75
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .WordWrap  = .T.
                    .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel    = .T.
                    .Caption   = "Encerrar"
                    .ForeColor = RGB(90, 90, 90)
                    .BackColor = RGB(255, 255, 255)
                    .Themes    = .F.
                ENDWITH
            ENDWITH
            *-- Sair.Click do dump ("ThisForm.Release") no botao MEMBRO; o
            *-- Click do GRUPO (This.Value=0, botao unico) faz a mesma coisa -
            *-- bindar so o Buttons(1) cobre os dois, sem fechar duas vezes
            BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=RGB(100,100,100) (layout.json) - copiado sem escala, pois
    * THIS.Width ja eh 800 (identico ao legado). lblSombra/lblTitulo usam
    * THIS.Caption (nao o texto literal "Cadastro de Testes" do dump, que eh
    * residuo de copia do SCX original e diverge do Caption real do form).
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
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .AutoSize   = .F.
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarFiltroPeriodo - Container cnt_4c_Mvt1 (SIGPRITB.cntMvt1, layout.json
    * Top=94/Left=132/Width=389/Height=60) com os campos de filtro do
    * processamento: periodo (Data Inicial/Data Final, obrigatorio - validado
    * por SigPrItbBO.ValidarPeriodo) e empresa (codigo/razao social, OPCIONAL -
    * vazio processa TODAS as empresas, regra de SigPrItbBO.Processar que so
    * acrescenta "AND Emps = ..." quando THIS.this_cEmpresa nao esta vazio).
    *
    * Posicoes, tamanhos e valores iniciais espelham o Init do SCX legado
    * (getData1.Value=Date(), getData2.Value=Date(), getEmp1.Value=Space(3),
    * getDsemp1.Value=Space(40) - comportamento.json, metodo Init).
    * Format="K" nos 4 campos + SpecialEffect/Alignment/Themes de getData1/
    * getData2 sao transcritos do dump (SECAO 2 do codigo fonte original).
    * BINDEVENT KeyPress liga o lookup de empresa (equivalente ao Valid de
    * getEmp1/getDsemp1 do SCX legado) aos handlers ValidarEmp1KeyPress/
    * ValidarDsemp1KeyPress, definidos apos este metodo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltroPeriodo()
        LOCAL loc_oErro

        TRY
            *-- cnt_4c_Mvt1 (SIGPRITB.cntMvt1) - container transparente sobre
            *-- o fundo do form (new_background.jpg), igual ao cnt_4c_Botoes
            *-- da Fase 4
            THIS.AddObject("cnt_4c_Mvt1", "Container")
            WITH THIS.cnt_4c_Mvt1
                .Top         = 94
                .Left        = 132
                .Width       = 389
                .Height      = 60
                .BackStyle   = 0
                .BorderWidth = 0
                .SpecialEffect = 0
                .Visible     = .T.
            ENDWITH

            *-- lbl_4c_Lbl_periodo (SIGPRITB.cntMvt1.lbl_periodo, classe say)
            THIS.cnt_4c_Mvt1.AddObject("lbl_4c_Lbl_periodo", "Label")
            WITH THIS.cnt_4c_Mvt1.lbl_4c_Lbl_periodo
                .Top       = 10
                .Left      = 13
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Per" + CHR(237) + "odo :"
                .Visible   = .T.
            ENDWITH

            *-- lbl_4c_Lbl_periodo_a (SIGPRITB.cntMvt1.lbl_periodo_a) - "a"
            *-- entre as duas datas (Data Inicial "a" Data Final)
            THIS.cnt_4c_Mvt1.AddObject("lbl_4c_Lbl_periodo_a", "Label")
            WITH THIS.cnt_4c_Mvt1.lbl_4c_Lbl_periodo_a
                .Top       = 9
                .Left      = 146
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = CHR(224)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Data1 (SIGPRITB.cntMvt1.getData1, classe fweditdata) -
            *-- Data Inicial do periodo. .Value = {} aqui so para o controle
            *-- nascer DATE - o valor real vem do BO logo no fim do metodo.
            *-- SpecialEffect/Alignment/Themes = defaults da classe fweditdata
            *-- (docs/FRAMEWORK_class_codigo_fonte.txt); Format="K" eh override
            *-- do dump (SECAO 2 - PROPRIEDADES DE SIGPRITB.cntMvt1.getData1)
            THIS.cnt_4c_Mvt1.AddObject("txt_4c_Data1", "TextBox")
            WITH THIS.cnt_4c_Mvt1.txt_4c_Data1
                .Top           = 5
                .Left          = 63
                .Width         = 79
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 1
                .Alignment     = 3
                .Format        = "K"
                .Themes        = .F.
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_Data2 (SIGPRITB.cntMvt1.getData2, classe fweditdata) -
            *-- Data Final do periodo
            THIS.cnt_4c_Mvt1.AddObject("txt_4c_Data2", "TextBox")
            WITH THIS.cnt_4c_Mvt1.txt_4c_Data2
                .Top           = 5
                .Left          = 155
                .Width         = 79
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 1
                .Alignment     = 3
                .Format        = "K"
                .Themes        = .F.
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Lbl_empresa (SIGPRITB.cntMvt1.lbl_empresa, classe say)
            THIS.cnt_4c_Mvt1.AddObject("lbl_4c_Lbl_empresa", "Label")
            WITH THIS.cnt_4c_Mvt1.lbl_4c_Lbl_empresa
                .Top       = 37
                .Left      = 8
                .Width     = 50
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Empresa :"
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Emp1 (SIGPRITB.cntMvt1.getEmp1) - codigo da empresa,
            *-- OPCIONAL (vazio processa todas as empresas). SigCdEmp.Cemps
            *-- eh char(3) no schema - MaxLength vem do SCHEMA, nunca do
            *-- Width em pixels (regra #19 / Erro158). Alignment/BackStyle/
            *-- BorderStyle/SpecialEffect/Format transcritos do dump (SECAO 2
            *-- - PROPRIEDADES DE SIGPRITB.cntMvt1.getEmp1)
            THIS.cnt_4c_Mvt1.AddObject("txt_4c_Emp1", "TextBox")
            WITH THIS.cnt_4c_Mvt1.txt_4c_Emp1
                .Top           = 32
                .Left          = 63
                .Width         = 31
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Format        = "K"
                .MaxLength     = 3
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_Dsemp1 (SIGPRITB.cntMvt1.getDsemp1) - razao social da
            *-- empresa, preenchida pelo lookup de ida-e-volta (handlers apos
            *-- este metodo). SigCdEmp.Razas eh char(40) no schema
            THIS.cnt_4c_Mvt1.AddObject("txt_4c_Dsemp1", "TextBox")
            WITH THIS.cnt_4c_Mvt1.txt_4c_Dsemp1
                .Top       = 32
                .Left      = 94
                .Width     = 290
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Format    = "K"
                .MaxLength = 40
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Carga inicial a partir do BO (SigPrItbBO.Init ja espelha o
            *-- Init legado: this_dDataInicial/this_dDataFinal = DATE(),
            *-- this_cEmpresa = Space(3), this_cDescricaoEmpresa = Space(40) -
            *-- ALLTRIM aqui converte os espacos em branco para campo vazio,
            *-- que eh o estado "processa todas as empresas")
            THIS.BOParaForm()

            *-- Lookup de empresa (Valid de getEmp1/getDsemp1 do SCX legado).
            *-- KeyPress (nao LostFocus) porque os handlers testam a tecla
            *-- (Enter/Tab/F4) antes de abrir qualquer picker - padrao
            *-- ValidarEmp/ValidarDemp de Formsigatcrp.prg (fAcessoEmpresa).
            *-- Handlers sao PUBLIC (regra BINDEVENT so liga metodo PUBLIC).
            BINDEVENT(THIS.cnt_4c_Mvt1.txt_4c_Emp1, "KeyPress", THIS, "ValidarEmp1KeyPress")
            BINDEVENT(THIS.cnt_4c_Mvt1.txt_4c_Dsemp1, "KeyPress", THIS, "ValidarDsemp1KeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltroPeriodo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarEmp1KeyPress - KeyPress em txt_4c_Emp1 (SIGPRITB.cntMvt1.getEmp1.
    * Valid do SCX legado). F4 abre o picker direto; Enter/Tab tentam o match
    * exato por codigo via SigPrItbBO.CarregarEmpresa e, nao achando, abrem o
    * picker com o valor digitado como prefixo (regra #50 - sem MsgAviso e
    * sem apagar o codigo digitado, porque ha picker na sequencia). Campo
    * vazio (Enter/Tab) limpa a descricao, igual ao Else do Valid legado.
    *==========================================================================
    PROCEDURE ValidarEmp1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cVal

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa(.F.)
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oCnt = THIS.cnt_4c_Mvt1
        loc_cVal = ALLTRIM(loc_oCnt.txt_4c_Emp1.Value)

        IF EMPTY(loc_cVal)
            loc_oCnt.txt_4c_Dsemp1.Value = ""
            loc_oCnt.txt_4c_Dsemp1.Refresh
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarEmpresa(loc_cVal, .F.)
            loc_oCnt.txt_4c_Emp1.Value   = THIS.this_oBusinessObject.this_cEmpresa
            loc_oCnt.txt_4c_Dsemp1.Value = THIS.this_oBusinessObject.this_cDescricaoEmpresa
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Empresa")
            ELSE
                THIS.AbrirBuscaEmpresa(.F.)
            ENDIF
        ENDIF

        loc_oCnt.txt_4c_Emp1.Refresh
        loc_oCnt.txt_4c_Dsemp1.Refresh
    ENDPROC

    *==========================================================================
    * ValidarDsemp1KeyPress - KeyPress em txt_4c_Dsemp1 (getDsemp1.Valid do
    * SCX legado). A guarda !EMPTY(txt_4c_Emp1.Value) -> RETURN replica o
    * When do legado ("Return Empty(getEmp1.Value)") - busca por razao social
    * so eh permitida quando o codigo ainda esta vazio.
    *==========================================================================
    PROCEDURE ValidarDsemp1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cVal

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa(.T.)
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oCnt = THIS.cnt_4c_Mvt1

        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Emp1.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oCnt.txt_4c_Dsemp1.Value)

        IF EMPTY(loc_cVal)
            loc_oCnt.txt_4c_Emp1.Value = ""
            loc_oCnt.txt_4c_Emp1.Refresh
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarEmpresa(loc_cVal, .T.)
            loc_oCnt.txt_4c_Emp1.Value   = THIS.this_oBusinessObject.this_cEmpresa
            loc_oCnt.txt_4c_Dsemp1.Value = THIS.this_oBusinessObject.this_cDescricaoEmpresa
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Empresa")
            ELSE
                THIS.AbrirBuscaEmpresa(.T.)
            ENDIF
        ENDIF

        loc_oCnt.txt_4c_Emp1.Refresh
        loc_oCnt.txt_4c_Dsemp1.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - Picker de SigCdEmp (FormBuscaAuxiliar) quando o
    * match exato de CarregarEmpresa nao resolveu. Lista por LIKE 'valor%' no
    * campo pesquisado (Cemps ou Razas, conforme par_lPorDescricao) com
    * fallback para a lista completa quando o filtro nao acha nada - mesmo
    * padrao de Formsigatcrp.AbrirBuscaEmp/AbrirBuscaDemp (fAcessoEmpresa).
    * CREATEOBJECT sem parametros + mAddColuna/this_cCursorDestino manuais
    * (nao o Init com 9 parametros - regra #36): o cursor ja vem pronto desta
    * consulta, SEM re-executar outro SELECT dentro do picker.
    *==========================================================================
    PROCEDURE AbrirBuscaEmpresa(par_lPorDescricao)
        LOCAL loc_oCnt, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, ;
              loc_lProsseguir, loc_oErro

        loc_oCnt    = THIS.cnt_4c_Mvt1
        loc_cValor  = ALLTRIM(IIF(par_lPorDescricao, loc_oCnt.txt_4c_Dsemp1.Value, loc_oCnt.txt_4c_Emp1.Value))
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY " + IIF(par_lPorDescricao, "Razas", "Cemps")
            ELSE
                IF par_lPorDescricao
                    loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) LIKE " + ;
                        EscaparSQL(loc_cValor + "%") + " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                        " ORDER BY Razas"
                ELSE
                    loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps LIKE " + ;
                        EscaparSQL(loc_cValor + "%") + " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                        " ORDER BY Cemps"
                ENDIF
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

            *-- Fallback: se o filtro nao trouxe nada, mostra a lista completa
            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY " + IIF(par_lPorDescricao, "Razas", "Cemps"), ;
                    "cursor_4c_BuscaEmp")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    IF par_lPorDescricao
                        loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                        loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    ELSE
                        loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    ENDIF
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        loc_oCnt.txt_4c_Emp1.Value   = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oCnt.txt_4c_Dsemp1.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        loc_oCnt.txt_4c_Emp1.Refresh
        loc_oCnt.txt_4c_Dsemp1.Refresh
    ENDPROC

    *==========================================================================
    * ConfigurarAguarde - cnt_4c_Aguarde (SIGPRITB.cntAguarde), o painel
    * "Aguarde... / Processando Dados..." mostrado durante o Processar
    * (equivalente a .cntAguarde.Visible = .t./.f. do PROCEDURE "processamento"
    * legado), e shp_4c_Shape1 (SIGPRITB.Shape1), linha decorativa sem
    * comportamento. cnt_4c_Aguarde nasce Visible=.F. (Init legado:
    * .cntAguarde.Visible = .f.) - TornarControlesVisiveis ja pula este
    * container por nome (CNT_4C_AGUARDE), entao a atribuicao aqui nao eh
    * sobrescrita depois.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAguarde()
        LOCAL loc_oErro

        TRY
            *-- Shape1 (SIGPRITB.Shape1) - decorativo, sem BINDEVENT
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 48
                .Left        = 372
                .Height      = 12
                .Width       = 36
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- cnt_4c_Aguarde (SIGPRITB.cntAguarde)
            THIS.AddObject("cnt_4c_Aguarde", "Container")
            WITH THIS.cnt_4c_Aguarde
                .Top         = 163
                .Left        = 284
                .Width       = 207
                .Height      = 49
                .BorderWidth = 5
                .SpecialEffect = 0
                .BackColor   = RGB(255, 255, 255)
                .Visible     = .F.
            ENDWITH

            THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Aguarde.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 10
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Aguarde..."
                .Height    = 18
                .Left      = 68
                .Top       = 7
                .Width     = 78
                .ForeColor = RGB(255, 0, 0)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.cnt_4c_Aguarde.lbl_4c_Label2
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 9
                .FontCondense  = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = "Processando Dados..."
                .Height        = 16
                .Left          = 38
                .Top           = 24
                .Width         = 133
                .ForeColor     = RGB(90, 90, 90)
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAguarde")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Click de cmd_4c_Processar (SIGPRITB.Processar.Click).
    * Replica as 3 validacoes do legado (via SigPrItbBO.ValidarPeriodo - mesmas
    * mensagens e ordem) + confirmacao "Confirma o Processamento ?"; so entao
    * delega para ExecutarProcessamento (PROCEDURE "Processamento" do legado).
    * PUBLIC: ligado via BINDEVENT em ConfigurarBotoesAcao.
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oBO, loc_oErro, loc_lProsseguir

        *-- Regra #1: RETURN (inclusive o BARE de guarda) e PROIBIDO dentro de
        *-- TRY/CATCH. O early-exit da validacao do periodo vira flag, e o resto
        *-- do bloco fica envolvido em IF loc_lProsseguir (so trocar o RETURN por
        *-- atribuicao, sem envolver o resto, descartaria o early-exit e abriria
        *-- a confirmacao de processamento com periodo invalido).
        loc_lProsseguir = .T.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            *-- Transporte Form -> BO pelo funil (Fase 8): o Click legado le
            *-- getData1/getData2/getEmp1 direto dos controles, aqui os quatro
            *-- campos viajam de uma vez para as properties do BO
            THIS.FormParaBO()

            IF !loc_oBO.ValidarPeriodo()
                MsgAviso(loc_oBO.this_cMensagemErro)
                IF EMPTY(loc_oBO.this_dDataInicial)
                    THIS.cnt_4c_Mvt1.txt_4c_Data1.SetFocus()
                ELSE
                    THIS.cnt_4c_Mvt1.txt_4c_Data2.SetFocus()
                ENDIF
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF MsgConfirma("Confirma o Processamento ?")
                    THIS.ExecutarProcessamento()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ExecutarProcessamento - PROCEDURE "processamento" do SCX legado: mostra
    * cnt_4c_Aguarde durante SigPrItbBO.Processar() e, concluido, decide o
    * desfecho pela MESMA ordem do legado:
    *   1) ha inconsistencia (this_lTemInconsistencia)  -> trava o filtro e o
    *      botao Processar, habilita os botoes de relatorio, avisa
    *   2) sem inconsistencia mas com movimento (this_nTotalRegistros > 0) ->
    *      avisa "Nenhuma Inconsistencia" e grava o arquivo (ExecutarGravacaoArquivo)
    *   3) sem movimento nenhum no periodo -> so avisa
    *==========================================================================
    PROTECTED PROCEDURE ExecutarProcessamento()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro

        loc_oBO = THIS.this_oBusinessObject

        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.Refresh()

        TRY
            loc_lSucesso = loc_oBO.Processar()
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            loc_oBO.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        THIS.cnt_4c_Aguarde.Visible = .F.
        THIS.Refresh()

        IF !loc_lSucesso
            MsgErro(loc_oBO.this_cMensagemErro, "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil")
            RETURN
        ENDIF

        IF loc_oBO.this_lTemInconsistencia
            *-- Ramo "If Not Eof('semconta')" do processamento legado: trava os
            *-- quatro campos do filtro e o Processar, e libera os dois botoes de
            *-- relatorio. As tres linhas abaixo sao o funil desse bloco (Fase 8)
            THIS.HabilitarCampos(.F.)
            THIS.this_cModoAtual = "INCONSISTENCIA"
            THIS.AjustarBotoesPorModo()

            MsgAviso("Existem Inconsist" + CHR(234) + "ncia(s), Favor Checar Pelo Relat" + ;
                CHR(243) + "rio Gerado.", "ATEN" + CHR(199) + CHR(195) + "O")
        ELSE
            IF loc_oBO.this_nTotalRegistros > 0
                MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada.", "ATEN" + CHR(199) + CHR(195) + "O")
                THIS.ExecutarGravacaoArquivo()
            ELSE
                MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + ;
                    "o no Per" + CHR(237) + "odo.", "ATEN" + CHR(199) + CHR(195) + "O")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ExecutarGravacaoArquivo - PROCEDURE "gravar" do SCX legado: reabilita o
    * periodo e desabilita os botoes de relatorio (incondicional, igual ao
    * dump), confirma "Confirma a Geracao do Arquivo?" e, so entao, delega a
    * geracao do arquivo texto para SigPrItbBO.GerarArquivoContabil().
    *==========================================================================
    PROTECTED PROCEDURE ExecutarGravacaoArquivo()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        THIS.cnt_4c_Mvt1.txt_4c_Data1.Enabled = .T.
        THIS.cnt_4c_Mvt1.txt_4c_Data2.Enabled = .T.
        THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(1).Enabled = .F.
        THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(2).Enabled = .F.

        IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
            IF !loc_oBO.GerarArquivoContabil()
                MsgErro(loc_oBO.this_cMensagemErro, "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Click do botao "Impressora" (cmg_4c_Relatorio.
    * Buttons(1) = btnImprimir do dump). Legado: "Report Form SigPrIct to
    * Print Prompt NoConsole" - sem chamada a Gravar depois (diferente de
    * FormSigPrIct/SIGPRICT). PUBLIC: ligado via BINDEVENT.
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro

        TRY
            IF THIS.PrepararCursoresRelatorio()
                THIS.ExecutarReportForm("SigPrIct", "PRINTER_PROMPT", "SemConta")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Click do botao "Video" (cmg_4c_Relatorio.
    * Buttons(2) = btnVisualizar do dump). Legado: "Report Form SigPrIct
    * Preview NoConsole". PUBLIC: ligado via BINDEVENT.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF THIS.PrepararCursoresRelatorio()
                THIS.ExecutarReportForm("SigPrIct", "PREVIEW", "SemConta")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Click de cmg_4c_Sair.Buttons(1) (SIGPRITB.
    * Botoes_de_Acao.Sair.Click + Click do grupo, ambos "ThisForm.Release").
    * PUBLIC: ligado via BINDEVENT.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * PrepararCursoresRelatorio - monta os dois alias de NOME LITERAL que o
    * SigPrIct.frx consome por contrato (mesmo contrato de
    * FormSigPrIct.PrepararCursoresRelatorio - os nomes NAO levam prefixo
    * cursor_4c_ porque pertencem ao FRX, nao a arquitetura nova; renomear
    * quebraria as expressoes "Cabecalho.Titulo"/"Cabecalho.SubTit"/
    * "Cabecalho.Periodo" gravadas no relatorio e os campos sem prefixo do
    * detalhe, que resolvem contra o ALIAS CORRENTE):
    *
    *   SemConta  - detalhe do relatorio (Contas/Datas/Hists/Valors/Ocors),
    *               espelho ORDENADO de cursor_4c_SemConta (SigPrItbBO.
    *               Processar ja populou). ORDER BY Contas, Datas reproduz o
    *               "Select SemConta / Set Order to ('conta')" do legado - o
    *               TAG Conta eh "Contas + Dtos(Datas)".
    *   Cabecalho - titulo/periodo do cabecalho impresso. cursor_4c_Cabecalho
    *               ja foi montado por SigPrItbBO.Processar() (via o metodo
    *               PROTECTED MontarCabecalhoRelatorio - nunca chamado direto
    *               de fora, regra #51); aqui so se copia o alias.
    *==========================================================================
    PROTECTED FUNCTION PrepararCursoresRelatorio()
        IF !USED("cursor_4c_SemConta") OR RECCOUNT("cursor_4c_SemConta") = 0
            MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia dispon" + CHR(237) + ;
                "vel para o relat" + CHR(243) + "rio.")
            RETURN .F.
        ENDIF

        IF USED("SemConta")
            USE IN SemConta
        ENDIF
        SELECT * FROM cursor_4c_SemConta ORDER BY Contas, Datas ;
            INTO CURSOR SemConta READWRITE

        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            SELECT * FROM cursor_4c_Cabecalho INTO CURSOR Cabecalho READWRITE
        ELSE
            *-- Defensivo: nao deveria ocorrer no fluxo normal (Processar() ja
            *-- monta cursor_4c_Cabecalho antes de habilitar estes botoes)
            CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarReportForm - helper canonico de REPORT FORM (CorretorAutomatico
    * #117/#147): guard de existencia do FRX, guard de cursor vazio,
    * isolamento de locale (POINT/SEPARATOR/REPORTBEHAVIOR 80 - FRX Fortyus
    * com PICTURE americana) e restauracao do menu (REPORT FORM PREVIEW
    * corrompe o cache visual do _MSYSMENU - Erro63).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER".
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Transporte Form -> BO dos quatro campos do filtro
    * (SIGPRITB.cntMvt1): periodo (getData1/getData2, que no PROCEDURE
    * "processamento" legado alimentam IniPer/FinPer) e empresa (getEmp1 ->
    * m.lcEmp1 do mesmo metodo; getDsemp1 eh somente exibicao e nao entra em
    * SQL nenhum, mas viaja junto para a property espelho do BO).
    * FUNIL unico: BtnProcessarClick chama este metodo antes de validar, no
    * lugar de atribuir property por property.
    *
    * PROTECTED EXPLICITO e obrigatorio: FormBase declara "PROTECTED PROCEDURE
    * FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever
    * sem PROTECTED nao tornaria o metodo publico, so esconderia que ele
    * continua protegido. Chamar sempre por THIS. de dentro da classe.
    *
    * ConverterParaData() normaliza o Value do TextBox: com DATE (como nasce
    * aqui, .Value = {}) devolve a propria data; com DATETIME devolve a data
    * sem a hora. TTOD() direto estouraria o erro 11 do VFP9 com DATE.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oCnt, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO  = THIS.this_oBusinessObject
            loc_oCnt = THIS.cnt_4c_Mvt1

            loc_oBO.this_dDataInicial      = ConverterParaData(loc_oCnt.txt_4c_Data1.Value)
            loc_oBO.this_dDataFinal        = ConverterParaData(loc_oCnt.txt_4c_Data2.Value)
            loc_oBO.this_cEmpresa          = ALLTRIM(loc_oCnt.txt_4c_Emp1.Value)
            loc_oBO.this_cDescricaoEmpresa = ALLTRIM(loc_oCnt.txt_4c_Dsemp1.Value)

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BOParaForm - Transporte BO -> Form dos mesmos quatro campos. Reproduz o
    * bloco de carga inicial do Init legado:
    *     .cntMvt1.getData1.Value  = Date()
    *     .cntMvt1.getData2.Value  = Date()
    *     .cntMvt1.getEmp1.Value   = Space(03)
    *     .cntMvt1.getDsemp1.Value = Space(40)
    * (SigPrItbBO.Init ja espelha esses valores nas properties; o ALLTRIM
    * converte os Space(N) em campo vazio, que eh o estado "processa todas as
    * empresas").
    *
    * Chamado SO na carga inicial (ConfigurarFiltroPeriodo). Os handlers de
    * lookup de empresa continuam atribuindo o PAR codigo/descricao direto:
    * rotear o lookup por aqui sobrescreveria as duas datas com o valor que
    * estiver na property no momento, apagando em silencio o periodo que o
    * usuario tivesse acabado de digitar e ainda nao empurrado para o BO.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO (FormBase declara o
    * nome como PROTECTED e o escopo vem da heranca).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oCnt, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO  = THIS.this_oBusinessObject
            loc_oCnt = THIS.cnt_4c_Mvt1

            loc_oCnt.txt_4c_Data1.Value  = ConverterParaData(loc_oBO.this_dDataInicial)
            loc_oCnt.txt_4c_Data2.Value  = ConverterParaData(loc_oBO.this_dDataFinal)
            loc_oCnt.txt_4c_Emp1.Value   = ALLTRIM(TratarNulo(loc_oBO.this_cEmpresa, ""))
            loc_oCnt.txt_4c_Dsemp1.Value = ALLTRIM(TratarNulo(loc_oBO.this_cDescricaoEmpresa, ""))

            loc_oCnt.txt_4c_Data1.Refresh
            loc_oCnt.txt_4c_Data2.Refresh
            loc_oCnt.txt_4c_Emp1.Refresh
            loc_oCnt.txt_4c_Dsemp1.Refresh

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Funil do bloco ".Enabled" dos QUATRO campos do filtro,
    * que o legado escreve em dois pontos:
    *   Init             -> getData1/getData2.Enabled = .t.
    *   processamento    -> getData1/getData2/getEmp1/getDsemp1.Enabled = .f.
    *                       (ramo "If Not Eof('semconta')")
    * Sem parametro assume .T. (PCOUNT() = 0): parametro ausente em VFP9 chega
    * como .F. logico, e sem esse teste uma chamada sem argumento DESABILITARIA
    * o filtro em vez de habilita-lo.
    *
    * PUBLIC de verdade (HabilitarCampos nao existe em FormBase, logo nao ha
    * escopo herdado para alargar) - eh o que permite ao harness de teste
    * automatizado exercitar o metodo de fora.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oCnt

        IF PCOUNT() = 0
            loc_lHab = .T.
        ELSE
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        ENDIF

        loc_oCnt = THIS.cnt_4c_Mvt1

        loc_oCnt.txt_4c_Data1.Enabled  = loc_lHab
        loc_oCnt.txt_4c_Data2.Enabled  = loc_lHab
        loc_oCnt.txt_4c_Emp1.Enabled   = loc_lHab
        loc_oCnt.txt_4c_Dsemp1.Enabled = loc_lHab
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Funil do bloco ".Enabled" dos TRES botoes, que o
    * legado escreve nos mesmos pontos do HabilitarCampos:
    *   Init          -> btnImprimir/btnVisualizar.Enabled = .f.
    *   processamento -> Processar.Enabled = .f. e
    *                    btnImprimir/btnVisualizar.Enabled = .t.
    *                    (ramo "If Not Eof('semconta')")
    *
    * Os modos deste form NAO sao os do CRUD (LISTA/INCLUIR/ALTERAR/
    * VISUALIZAR) porque nao ha Lista nem edicao de registro - sao os dois
    * estados que o legado de fato tem:
    *   "FILTRO"         - estado inicial e apos a geracao do arquivo: o
    *                      periodo/empresa sao editaveis, Processar ativo e os
    *                      botoes de relatorio desligados (nao ha o que
    *                      imprimir).
    *   "INCONSISTENCIA" - sobraram lancamentos sem conta contabil: o filtro e
    *                      o Processar travam e os dois botoes de relatorio
    *                      ligam, para o usuario conferir o SigPrIct.frx.
    *
    * PUBLIC de verdade (nome ausente em FormBase).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lInconsistencia

        loc_lInconsistencia = (UPPER(ALLTRIM(THIS.this_cModoAtual)) == "INCONSISTENCIA")

        THIS.cmd_4c_Processar.Enabled = !loc_lInconsistencia
        THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(1).Enabled = loc_lInconsistencia
        THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(2).Enabled = loc_lInconsistencia
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Containers/PageFrames tornando tudo
    * visivel, exceto containers que precisam nascer ocultos (cnt_4c_Aguarde,
    * adicionado na Fase 7/8) - esses sao pulados com LOOP mas ainda recursam
    * para que os FILHOS deles nao fiquem hidden quando o container, mais
    * tarde, for exibido.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_AGUARDE")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Equivalente do "PROCEDURE Release" legado (que soltava o
    * poDataMgr; aqui a conexao eh o gnConnHandle global e nao pertence ao
    * form). Os cursores de trabalho do processamento moram no BO
    * (cursor_4c_MovAux/cursor_4c_SemConta/cursor_4c_Cabecalho/etc) e sao
    * recriados a cada chamada de Processar() - fecha-los aqui evita vazar
    * work area entre instancias do form. "SemConta"/"Cabecalho" (sem
    * prefixo) sao os alias literais montados por PrepararCursoresRelatorio()
    * para o SigPrIct.frx. DODEFAULT() SEMPRE por ultimo (Destroy sem
    * DODEFAULT deixa o menu do sistema encolhido - regra #145).
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_MovAux")
            USE IN cursor_4c_MovAux
        ENDIF
        IF USED("cursor_4c_SemConta")
            USE IN cursor_4c_SemConta
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_Gcr")
            USE IN cursor_4c_Gcr
        ENDIF
        IF USED("cursor_4c_MvCcr")
            USE IN cursor_4c_MvCcr
        ENDIF
        IF USED("cursor_4c_Cli")
            USE IN cursor_4c_Cli
        ENDIF
        IF USED("SemConta")
            USE IN SemConta
        ENDIF
        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
