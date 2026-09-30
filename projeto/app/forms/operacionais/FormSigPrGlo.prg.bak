*==============================================================================
* FormSigPrGlo.prg - Processamento de O.P.
* Tipo: OPERACIONAL (layout flat, sem PageFrame de conteudo - tela de parametros)
* Herda de: FormBase
* Legado: SIGPRGLO.SCX
*
* Tela de parametros que dispara o processamento em lote de Ordens de
* Producao a partir das movimentacoes em aberto (SigMvCab/SigMvItn),
* filtradas por periodo de emissao/entrega, operacao, conta (compradora) e
* conta responsavel (vendedor). Reusada pelo legado em tres modos, todos
* controlados pelas flags abaixo (espelhadas em SigPrGloBO):
*   - Processamento normal de O.P. (this_lReserva=.F., this_lGerPorTp=.F.)
*   - Reserva Automatica (this_lReserva=.T.)
*   - Processamento por Tipo de O.P. (this_lGerPorTp=.T., habilita cnt_4c_Container1)
*
* CHAMADA:
*   CREATEOBJECT("FormSigPrGlo", par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
*
* FASE 3/8 - Estrutura Base: DEFINE CLASS, Init/Destroy/InicializarForm,
* cabecalho e containers de agrupamento de campos VAZIOS.
* FASE 4/8 - Botoes de acao (Processar/Cancelar) e AlternarPagina() (funil de
* bloqueio/desbloqueio da UI durante o processamento - este form OPERACIONAL
* eh flat, sem PageFrame de conteudo, entao "pagina" aqui significa o MODO da
* tela: "ENTRADA" (usuario preenche os filtros) ou "PROCESSANDO" (BO executa
* o processamento em lote e a UI fica bloqueada)).
* FASE 5/8 - Campos Principais (Parte 1/2): primeira metade dos campos sem
* lookup - periodo de emissao (GetDataei/GetDataef), prazo de entrega
* (GetDatapi/GetDatapf), Movimentacao (cnt_4c_Operacao: Get_Operacao/
* Get_Operacaoi/Get_Operacaof) e Tipo de O.P. (cnt_4c_Container1:
* Get_TpGOp).
* FASE 6/8 - Campos Restantes e Lookups (Parte 2/2): cnt_4c_Conta/
* cnt_4c_Responsavel (Grupo/Conta/Descricao, SigCdGcr+SigCdCli filtrado por
* grupos), cnt_4c_Empresa (SigCdEmp.Cemps/Razas + Chec_pedra), cnt_4c_Previsao
* (data previsao/geracao, default vindo do BO) e cnt_4c_Op (numero manual da
* OP + checagem de duplicidade em SigOpPic). fAcessoContab/fAcessoContas/
* fAcessoEmpresa (funcoes globais Fortyus NAO portadas) substituidas pelo
* lookup canonico FormBase.AbrirLookupCanonico(). TODOS os BINDEVENT de
* KeyPress (Enter/Tab/F4) registrados em ConfigurarBindEvents(), chamado no
* fim de InicializarForm. AjustarVisibilidadeCondicional() reaplica, depois
* de TornarControlesVisiveis(), a ocultacao condicional do Init legado
* (Cnt_Previsao quando Reserva, Chec_pedra conforme parametros de
* transferencia, Cnt_Op conforme GlobAutos).
* FASE 7/8 - Eventos Principais: este form OPERACIONAL nao tem verbos CRUD
* (Incluir/Alterar/Visualizar/Excluir) - os "eventos principais" do legado
* sao BtnProcessarClick/BtnCancelarClick, ligados via BINDEVENT em
* ConfigurarBindEvents. BtnCancelarClick e so THIS.Release(). BtnProcessarClick
* transcreve as validacoes do Click legado e delega a varredura de
* SigMvCab/SigMvItn/SigMvIts para SigPrGloBO.Processar() (monta TmpCabec/
* TmpItens/TmpOper na DataSession corrente); com pelo menos 1 item
* selecionado, abre FormSigPrGl2 (CREATEOBJECT + VARTYPE + Show FORA do TRY -
* regra #29) reproduzindo "Do Form SigPrGl2 With ThisForm, DataSessionId,
* Reserva, poDataMgr, (Chec_pedra.Value=0), automatico, GetNop.Value" do
* legado (poDataMgr sai, pCnx nao existe mais - gnConnHandle global).
* FASE 8/8 - Consolidacao Final: FormParaBO()/BOParaForm() cobrindo TODOS os
* 18 campos de filtro da tela contra as properties this_* de SigPrGloBO
* (FormParaBO chamado em BtnProcessarClick logo antes de Processar();
* BOParaForm no fim de ConfigurarCamposPrevisaoOp, primeiro ponto em que
* todos os controles ja existem, aplicando os defaults calculados no Init do
* BO). Os handlers dos dois botoes do legado foram renomeados de Cmd*Click
* para Btn*Click - prefixo canonico do projeto, que eh o que torna handler de
* botao ENUMERAVEL pelos gates das Fases 7/8 (o objeto segue cmd_4c_Processar/
* cmd_4c_Cancelar, entao mapeamento.json nao muda).
*
* SUPERFICIE QUE ESTE LEGADO NAO TEM (ausencias deliberadas, nao omissoes):
*   - carga de grade de LISTA: o SCX nao tem Grid, PageFrame nem ListBox, e as
*     12 chamadas .AddCursor do Init legado passam string VAZIA na posicao do
*     grid (5o argumento) - sao registro de cursor para o processamento em
*     lote, nao ligacao de grade;
*   - verbos CRUD (Incluir/Alterar/Visualizar/Excluir) e botao de GRAVAR: a
*     tela filtra, monta TmpCabec/TmpItens em cursor LOCAL e entrega o
*     resultado ao FormSigPrGl2 ("Do Form SigPrGl2 With ..." do legado);
*     nenhuma escrita do dump tem tabela como alvo.
*==============================================================================

DEFINE CLASS FormSigPrGlo AS FormBase

    Top          = 0
    Left         = 0
    Width        = 680
    Height       = 379
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    DataSession  = 2
    ClipControls = .F.
    Caption      = "Processamento de O.P."
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Flags de modo de operacao (recebidas via Init, repassadas ao BO em
    *-- InicializarForm - equivalem a ThisForm.Reserva/automatico/Pordestino/
    *-- GerPorTp do legado)
    this_lReserva     = .F.   && .T. = "Processar Reserva Automatica"
    this_lAutomatico  = .F.   && .T. = processamento automatico (sem interacao)
    this_lPorDestino  = .F.   && .T. = globalizacao por destino
    this_lGerPorTp    = .F.   && .T. = "Processar Ordem de Producao por Tipo" (habilita cnt_4c_Container1)

    *--------------------------------------------------------------------------
    * Init - recebe as flags de modo (equivalente a LParameters _Reserva,
    * _Autom, _PorDestino, lcNomeFrm1, pTipo do legado - lcNomeFrm1 nao e
    * usado no migrado, o Caption e resolvido por modo em InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
        THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)      = "L", par_lAutom,      .F.)
        THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino) = "L", par_lPorDestino, .F.)
        THIS.this_lGerPorTp   = IIF(VARTYPE(par_pTipo)       = "L", par_pTipo,       .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - os cursores de trabalho de Processar() (TmpOper/TmpCabec/
    * TmpItens/Produtos/cursor_4c_Temp*) ficam ABERTOS de proposito enquanto a
    * tela vive: sao o contrato do FormSigPrGl2, que roda MODAL por cima desta
    * (equivalente ao "Do Form SigPrGl2 With ThisForm.Datasessionid" do
    * legado). Todos vivem na datasession PRIVADA deste form (DataSession = 2),
    * que o VFP encerra junto com ele - nao ha o que fechar a mao aqui, so
    * delegar ao FormBase (libera this_oBusinessObject e restaura o menu
    * principal; DODEFAULT() eh obrigatorio como ULTIMA linha do Destroy).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, repassa as flags de modo e
    * monta a estrutura visual (cabecalho + containers de agrupamento vazios +
    * botoes de acao Processar/Cancelar). Os campos internos dos containers e
    * os eventos (BINDEVENT) sao adicionados nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cCaption
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGloBO.", "Erro")
            ELSE
                WITH THIS.this_oBusinessObject
                    .this_lReserva    = THIS.this_lReserva
                    .this_lAutomatico = THIS.this_lAutomatico
                    .this_lPorDestino = THIS.this_lPorDestino
                    .this_lGerPorTp   = THIS.this_lGerPorTp
                ENDWITH

                *-- Caption dinamico conforme modo de operacao (equivalente ao
                *-- If ThisForm.Reserva ... Else ... EndIf do Init legado)
                loc_cCaption = "Processamento de O.P."
                IF THIS.this_lReserva
                    loc_cCaption = "Processar Reserva Autom" + CHR(225) + "tica"
                ELSE
                    IF THIS.this_lGerPorTp
                        loc_cCaption = "Processar Ordem de Produ" + CHR(231) + CHR(227) + "o por Tipo"
                    ENDIF
                ENDIF
                THIS.Caption = loc_cCaption

                THIS.ConfigurarPageFrame()

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarShape()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarBindEvents()

                THIS.TornarControlesVisiveis()

                *-- Visibilidade condicional (Chec_pedra/Cnt_Op/Cnt_Previsao)
                *-- roda DEPOIS de TornarControlesVisiveis, que forca .Visible
                *-- = .T. em tudo - sem isso a ocultacao condicional do legado
                *-- seria sobrescrita.
                THIS.AjustarVisibilidadeCondicional()

                *-- Estado inicial: aguardando entrada do usuario (equivalente
                *-- ao form legado antes do Click em Processar)
                THIS.AlternarPagina("ENTRADA")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
                    loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - imagem de fundo do form (OPERACIONAL flat, sem
    * PageFrame de conteudo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
        THIS.ScrollBars = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa cinza escuro com titulo (cntSombra legado)
    * Top=0, Left=0, Width=680, Height=80 - BackColor=RGB(100,100,100)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width
                .ForeColor     = RGB(255, 255, 255)
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape - retangulo decorativo por tras dos botoes de acao
    * (Shape3 legado: Top=7, Left=486, Height=110, Width=173)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 7
            .Left        = 486
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - botoes de acao principais (Processar/Cancelar do
    * legado). Ficam sobre o shp_4c_Shape3 (Top=7, Left=486, W=173, H=110),
    * standalone (fora de CommandGroup), posicoes EXATAS do SIGPRGLO.SCX:
    *   Processar: Top=3, Left=528, 75x75, Caption="Processar"
    *   Cancelar : Top=3, Left=603, 75x75, Caption="Encerrar" (Cancel=.T. -
    *              ativa ESC, unica forma de fechar o form: ControlBox=.F.,
    *              Closable=.F., TitleBar=0)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 528
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 603
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - monta os containers de agrupamento de campos
    * (ainda VAZIOS - os campos internos e os eventos sao adicionados nas
    * proximas fases). Nome mantido por convencao do FormBase; este form
    * OPERACIONAL nao tem Page1=Lista/Page2=Dados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarContainers()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - nome mantido por convencao do FormBase (form
    * OPERACIONAL flat, sem Page2/Dados real). Monta a primeira metade dos
    * campos do SIGPRGLO.SCX (Fase 5/8) - os que nao dependem de lookup.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCamposPeriodo()
        THIS.ConfigurarCamposOperacao()
        THIS.ConfigurarCamposTipoOp()
        THIS.ConfigurarCamposContas()
        THIS.ConfigurarCamposPrevisaoOp()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposPeriodo - campos diretos do form (nao ficam dentro de
    * container no legado): faixa de Periodo de Emissao (GetDataei/GetDataef)
    * e faixa de Previsao de Entrega/Prazo (GetDatapi/GetDatapf), alem do
    * label "Movimentacao :" (TxtPedido) que fica acima do cnt_4c_Operacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposPeriodo()
        *-- Label1: "Periodo de Emissao :" (Top=115, Left=32, Width=101)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
            .Left      = 32
            .Top       = 115
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetDataei: inicio do periodo de emissao (Top=111, Left=142, W=80)
        THIS.AddObject("txt_4c_Dataei", "TextBox")
        WITH THIS.txt_4c_Dataei
            .Top           = 111
            .Left          = 142
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Label2: "ate" (Top=115, Left=227, Width=18)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 227
            .Top       = 115
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetDataef: fim do periodo de emissao (Top=111, Left=255, W=80)
        THIS.AddObject("txt_4c_Dataef", "TextBox")
        WITH THIS.txt_4c_Dataef
            .Top           = 111
            .Left          = 255
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Label3: "Previsao de Entrega :" (Top=142, Left=27, Width=106)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Previs" + CHR(227) + "o de Entrega :"
            .Left      = 27
            .Top       = 142
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetDatapi: inicio da faixa de prazo de entrega (Top=138, Left=142, W=80)
        THIS.AddObject("txt_4c_Datapi", "TextBox")
        WITH THIS.txt_4c_Datapi
            .Top           = 138
            .Left          = 142
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Label4: "ate" (Top=142, Left=227, Width=18)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 227
            .Top       = 142
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetDatapf: fim da faixa de prazo de entrega (Top=138, Left=254, W=80)
        THIS.AddObject("txt_4c_Datapf", "TextBox")
        WITH THIS.txt_4c_Datapf
            .Top           = 138
            .Left          = 254
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- TxtPedido: "Movimentacao :" (Top=196, Left=55, Width=78) - label
        *-- do cnt_4c_Operacao (container ja criado em ConfigurarContainers)
        THIS.AddObject("lbl_4c_TxtPedido", "Label")
        WITH THIS.lbl_4c_TxtPedido
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Left      = 55
            .Top       = 196
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposOperacao - preenche o cnt_4c_Operacao (ja criado vazio
    * em ConfigurarContainers): codigo da Operacao (Movimentacao) + faixa
    * de numero (de/ate). ControlSource fica em branco, igual ao legado -
    * o valor eh resolvido por codigo (Valid/lookup), adicionado na Fase 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposOperacao()
        WITH THIS.cnt_4c_Operacao
            *-- Get_Operacao: codigo da operacao/movimentacao (Dopes char(20))
            .AddObject("txt_4c_Operacao", "TextBox")
            WITH .txt_4c_Operacao
                .Top           = 1
                .Left          = 3
                .Width         = 151
                .Height        = 23
                .FontName      = "Courier New"
                .MaxLength     = 20
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label1: "de" (Top=5, Left=180, Width=14)
            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "de"
                .Left      = 180
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Operacaoi: numero inicial da faixa (Numes, numerico)
            .AddObject("txt_4c_Operacaoi", "TextBox")
            WITH .txt_4c_Operacaoi
                .Top           = 1
                .Left          = 201
                .Width         = 55
                .Height        = 23
                .FontName      = "Courier New"
                .Alignment     = 3
                .Format        = "K"
                .InputMask     = "999999"
                .MaxLength     = 6
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Label9: "ate" (Top=4, Left=262, Width=18)
            .AddObject("lbl_4c_Label9", "Label")
            WITH .lbl_4c_Label9
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "at" + CHR(233)
                .Left      = 262
                .Top       = 4
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Operacaof: numero final da faixa (Numes, numerico)
            .AddObject("txt_4c_Operacaof", "TextBox")
            WITH .txt_4c_Operacaof
                .Top           = 1
                .Left          = 286
                .Width         = 55
                .Height        = 23
                .FontName      = "Courier New"
                .Alignment     = 3
                .Format        = "K"
                .InputMask     = "999999"
                .MaxLength     = 6
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposTipoOp - Label5 ("Tipo de O.P.:", direto no form) +
    * Get_TpGOp (dentro do cnt_4c_Container1, ja criado com .Enabled
    * condicionado a this_lGerPorTp em ConfigurarContainers).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposTipoOp()
        *-- Label5: "Tipo de O.P.:" (Top=169, Left=67, Width=66)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Tipo de O.P.:"
            .Left      = 67
            .Top       = 169
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_TpGOp: codigo do Tipo de Geracao de OP (char(10), Courier New)
        WITH THIS.cnt_4c_Container1
            .AddObject("txt_4c_TpGOp", "TextBox")
            WITH .txt_4c_TpGOp
                .Top           = 1
                .Left          = 3
                .Width         = 80
                .Height        = 23
                .FontName      = "Courier New"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposContas - preenche os containers cnt_4c_Conta,
    * cnt_4c_Responsavel e cnt_4c_Empresa (ja criados vazios em
    * ConfigurarContainers), alem dos labels diretos do form Label6
    * ("Conta :"), Label7 ("Vendedor :") e lbl_empresa ("Empresa :").
    * ControlSource fica em branco, igual ao legado - o valor eh resolvido
    * por lookup (BINDEVENT em ConfigurarBindEvents).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposContas()
        LOCAL loc_cEmpPadrao, loc_nResultado

        *-- Label6: "Conta :" (Top=223, Left=95, Width=38)
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Conta :"
            .Left      = 95
            .Top       = 223
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label7: "Vendedor :" (Top=250, Left=78, Width=55)
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Vendedor :"
            .Left      = 78
            .Top       = 250
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_empresa: "Empresa :" (Top=277, Left=83, Width=50)
        THIS.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH THIS.lbl_4c_LblEmpresa
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Empresa :"
            .Left      = 83
            .Top       = 277
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- cnt_4c_Conta: Grupo/Conta/Descricao - filtro de movimentacao
        *-- (compradora) - SigMvCab.GrupoOs/ContaOs quando Globalizas=1
        WITH THIS.cnt_4c_Conta
            .AddObject("txt_4c_Grupo", "TextBox")
            WITH .txt_4c_Grupo
                .Top           = 1
                .Left          = 3
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Top           = 1
                .Left          = 86
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .Top           = 1
                .Left          = 170
                .Width         = 360
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- cnt_4c_Responsavel: Grupo/Conta/Descricao do vendedor -
        *-- SigMvCab.GrVends/Vends
        WITH THIS.cnt_4c_Responsavel
            .AddObject("txt_4c_Grupo", "TextBox")
            WITH .txt_4c_Grupo
                .Top           = 1
                .Left          = 3
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Top           = 1
                .Left          = 86
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .Top           = 1
                .Left          = 170
                .Width         = 360
                .Height        = 23
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- cnt_4c_Empresa: codigo/razao social + Chec_pedra ("Nao Empenhar
        *-- Pedras") - SigCdEmp.Cemps/Razas. AlterEmp do legado eh sempre
        *-- .T. no Init (ThisForm.AlterEmp = .t.), entao o campo fica sempre
        *-- editavel, sem gating adicional.
        WITH THIS.cnt_4c_Empresa
            .AddObject("txt_4c_CdEmpresa", "TextBox")
            WITH .txt_4c_CdEmpresa
                .Top           = 1
                .Left          = 4
                .Width         = 31
                .Height        = 23
                .FontName      = "Courier New"
                .FontSize      = 9
                .Alignment     = 0
                .BackStyle     = 1
                .Format        = "K"
                .InputMask     = "XXX"
                .MaxLength     = 3
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_DsEmpresa", "TextBox")
            WITH .txt_4c_DsEmpresa
                .Top           = 1
                .Left          = 38
                .Width         = 282
                .Height        = 23
                .FontName      = "Courier New"
                .Format        = "K"
                .MaxLength     = 40
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            .AddObject("chk_4c_ChecPedra", "CheckBox")
            WITH .chk_4c_ChecPedra
                .Top       = 5
                .Left      = 330
                .Width     = 124
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Empenhar Pedras"
                .ForeColor = RGB(90, 90, 90)
                .Value     = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Empresa padrao = go_4c_Sistema.cCodEmpresa (equivalente a
        *-- .Empresa.Get_cd_empresa.Value = _Empr do Init legado), com a
        *-- razao social resolvida direto de SigCdEmp (mesmo CursorQuery
        *-- ('SigCdEmp','TempEmp','Cemps',_Empr,'Razas') do legado)
        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_cEmpPadrao = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            IF !EMPTY(loc_cEmpPadrao)
                THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = loc_cEmpPadrao
                IF USED("cursor_4c_ChkEmpPad")
                    USE IN cursor_4c_ChkEmpPad
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpPadrao), ;
                    "cursor_4c_ChkEmpPad")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpPad") AND RECCOUNT("cursor_4c_ChkEmpPad") > 0
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpPad.Razas)
                ENDIF
                IF USED("cursor_4c_ChkEmpPad")
                    USE IN cursor_4c_ChkEmpPad
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposPrevisaoOp - preenche os containers cnt_4c_Previsao
    * (data de previsao de entrega + data de geracao) e cnt_4c_Op (numero
    * manual da O.P.), ja criados vazios em ConfigurarContainers. Os valores
    * default de Previsao/Geracao vem do BO (ja calculados no Init:
    * this_dPrevisaoEntrega = Date()+SigCdPam.PrevProds, this_dDataGeracao =
    * Date() quando !this_lAutomatico).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposPrevisaoOp()
        WITH THIS.cnt_4c_Previsao
            *-- Label8: "Previsao de Entrega :" (Top=9, Left=7, Width=106)
            .AddObject("lbl_4c_Label8", "Label")
            WITH .lbl_4c_Label8
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontItalic = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Previs" + CHR(227) + "o de Entrega :"
                .Left      = 7
                .Top       = 9
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- GetPrevisao: data de previsao de entrega (Top=5, Left=134, W=80)
            .AddObject("txt_4c_Previsao", "TextBox")
            WITH .txt_4c_Previsao
                .Top           = 5
                .Left          = 134
                .Width         = 80
                .Height        = 23
                .Alignment     = 3
                .Format        = "K"
                .SpecialEffect = 1
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- Label9: "Data de Geracao :" (Top=9, Left=244, Width=90)
            .AddObject("lbl_4c_Label9", "Label")
            WITH .lbl_4c_Label9
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontItalic = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
                .Left      = 244
                .Top       = 9
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- GetGeracao: data de geracao (Top=5, Left=353, W=80)
            .AddObject("txt_4c_Geracao", "TextBox")
            WITH .txt_4c_Geracao
                .Top           = 5
                .Left          = 353
                .Width         = 80
                .Height        = 23
                .Alignment     = 3
                .Format        = "K"
                .SpecialEffect = 1
                .Value         = {}
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- cnt_4c_Op: numero manual da O.P. (visibilidade condicional -
        *-- GlobAutos=2 e !Reserva - aplicada em AjustarVisibilidadeCondicional)
        WITH THIS.cnt_4c_Op
            *-- Label8: "N. da O.P.:" (Top=5, Left=0, Width=58)
            .AddObject("lbl_4c_Label8", "Label")
            WITH .lbl_4c_Label8
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontItalic = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(186) + " da O.P.:"
                .Left      = 0
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- GetNop: numero manual da OP (Top=1, Left=71, W=59)
            .AddObject("txt_4c_Nop", "TextBox")
            WITH .txt_4c_Nop
                .Top           = 1
                .Left          = 71
                .Width         = 59
                .Height        = 23
                .Alignment     = 3
                .InputMask     = "999999"
                .MaxLength     = 6
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- Valores default vindos do BO (ja calculados no Init) - via
        *-- BOParaForm, que tambem cobre os demais campos de filtro. Chamado
        *-- so agora porque eh o primeiro ponto em que TODOS os controles de
        *-- filtro (inclusive cnt_4c_Op.txt_4c_Nop, criado acima) ja existem.
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainers - cria VAZIOS os containers de agrupamento de
    * campos, nas posicoes do SIGPRGLO.SCX legado (tasks\task615\layout.json).
    * cnt_4c_Container1 fica desabilitado fora do modo "Gerar por Tipo".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainers()
        *-- Container1: Tipo de O.P. (Get_TpGOp) - habilitado so quando this_lGerPorTp
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top         = 164
            .Left        = 139
            .Width       = 346
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Enabled     = THIS.this_lGerPorTp
            .Visible     = .T.
        ENDWITH

        *-- Operacao: codigo + faixa de/ate (Get_Operacao/Get_Operacaoi/Get_Operacaof)
        THIS.AddObject("cnt_4c_Operacao", "Container")
        WITH THIS.cnt_4c_Operacao
            .Top         = 191
            .Left        = 139
            .Width       = 350
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Conta: grupo/conta/descricao - filtro de movimentacao (compradora)
        THIS.AddObject("cnt_4c_Conta", "Container")
        WITH THIS.cnt_4c_Conta
            .Top         = 218
            .Left        = 139
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Responsavel: grupo/conta/descricao do vendedor
        THIS.AddObject("cnt_4c_Responsavel", "Container")
        WITH THIS.cnt_4c_Responsavel
            .Top         = 245
            .Left        = 139
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Empresa: cd_empresa + ds_empresa + Chec_pedra (Nao Empenhar Pedras)
        THIS.AddObject("cnt_4c_Empresa", "Container")
        WITH THIS.cnt_4c_Empresa
            .Top         = 272
            .Left        = 138
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Previsao: data de previsao de entrega + data de geracao
        THIS.AddObject("cnt_4c_Previsao", "Container")
        WITH THIS.cnt_4c_Previsao
            .Top         = 309
            .Left        = 7
            .Width       = 660
            .Height      = 33
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Op: numero da O.P. manual - visibilidade condicional (GlobAutos=2
        *-- e !Reserva) sera aplicada na Fase 5/6, junto com o campo txt_4c_Nop
        THIS.AddObject("cnt_4c_Op", "Container")
        WITH THIS.cnt_4c_Op
            .Top         = 313
            .Left        = 478
            .Width       = 130
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarVisibilidadeCondicional - reaplica, DEPOIS de
    * TornarControlesVisiveis (que forca .Visible = .T. em tudo), a
    * ocultacao condicional do Init legado:
    *   - Cnt_Previsao.Visible = .F. quando this_lReserva
    *   - Chec_pedra.Visible = .T. so quando os 4 parametros de transferencia
    *     de reserva estao configurados (DopEmphs/DopReqcs/DopPedcs/TransfRes)
    *   - Cnt_Op.Visible = (GlobAutos = 2 And !this_lReserva)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarVisibilidadeCondicional()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        THIS.cnt_4c_Previsao.Visible = !THIS.this_lReserva

        THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Visible = ;
            !EMPTY(ALLTRIM(loc_oBO.this_cPamDopEmphs))  AND ;
            !EMPTY(ALLTRIM(loc_oBO.this_cPamDopReqcs))  AND ;
            !EMPTY(ALLTRIM(loc_oBO.this_cPamDopPedcs))  AND ;
            !EMPTY(ALLTRIM(loc_oBO.this_cPamTransfRes))

        THIS.cnt_4c_Op.Visible = (loc_oBO.this_nPamGlobAutos = 2 AND !THIS.this_lReserva)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBindEvents - registra os handlers de KeyPress (Enter/Tab/F4)
    * de TODOS os campos com lookup do form. Chamado em InicializarForm,
    * depois que todos os controles ja existem (ConfigurarPaginaDados +
    * ConfigurarBotoes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBindEvents()
        BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao, "KeyPress", THIS, "OperacaoKeyPress")
        BINDEVENT(THIS.cnt_4c_Container1.txt_4c_TpGOp,  "KeyPress", THIS, "TpGOpKeyPress")

        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,  "KeyPress", THIS, "ConGrupoKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,  "KeyPress", THIS, "ConContaKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta, "KeyPress", THIS, "ConDcontaKeyPress")

        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Grupo,  "KeyPress", THIS, "RespGrupoKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Conta,  "KeyPress", THIS, "RespContaKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Dconta, "KeyPress", THIS, "RespDcontaKeyPress")

        BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa, "KeyPress", THIS, "EmpresaCodKeyPress")
        BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa, "KeyPress", THIS, "EmpresaDescKeyPress")

        BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop, "KeyPress", THIS, "NopKeyPress")

        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - copia os campos de filtro da tela para as properties
    * this_* de THIS.this_oBusinessObject (SigPrGloBO.prg, declaradas na
    * Fase 1). Este form OPERACIONAL nao grava registro nenhum diretamente
    * (Processar() recebe os valores por parametro posicional, ja que e
    * transcricao literal do Click legado - ver cabecalho de
    * BtnProcessarClick), mas as properties de filtro do BO existem
    * justamente para refletir o estado corrente da tela - chamado logo
    * antes de THIS.this_oBusinessObject.Processar(...) em BtnProcessarClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_dDataEmissaoIni = THIS.txt_4c_Dataei.Value
        loc_oBO.this_dDataEmissaoFim = THIS.txt_4c_Dataef.Value
        loc_oBO.this_dDataPrazoIni   = THIS.txt_4c_Datapi.Value
        loc_oBO.this_dDataPrazoFim   = THIS.txt_4c_Datapf.Value

        loc_oBO.this_cOperacao       = PADR(ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value), 20)
        loc_oBO.this_nOperacaoIni    = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
        loc_oBO.this_nOperacaoFim    = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value

        loc_oBO.this_cContaGrupo     = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cContaConta     = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value), 10)
        loc_oBO.this_cContaDescricao = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value), 40)

        loc_oBO.this_cRespGrupo      = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cRespConta      = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Conta.Value), 10)
        loc_oBO.this_cRespDescricao  = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Dconta.Value), 40)

        loc_oBO.this_cEmpresaCodigo    = PADR(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value), 3)
        loc_oBO.this_cEmpresaRazao     = PADR(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value), 40)
        loc_oBO.this_lNaoEmpenharPedra = (THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = 1)

        loc_oBO.this_dPrevisaoEntrega = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
        loc_oBO.this_dDataGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value

        loc_oBO.this_nNumeroOP      = THIS.cnt_4c_Op.txt_4c_Nop.Value
        loc_oBO.this_cTipoGeracaoOP = PADR(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value), 10)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - espelha as properties this_* de THIS.this_oBusinessObject
    * de volta para os campos da tela. Chamado ao final de
    * ConfigurarCamposPrevisaoOp (primeiro ponto em InicializarForm em que
    * TODOS os controles de filtro ja existem) para aplicar os defaults
    * calculados no Init do BO (this_dPrevisaoEntrega/this_dDataGeracao -
    * equivalente ao GetPrevisao.Value/GetGeracao.Value do Init legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_Dataei.Value = loc_oBO.this_dDataEmissaoIni
        THIS.txt_4c_Dataef.Value = loc_oBO.this_dDataEmissaoFim
        THIS.txt_4c_Datapi.Value = loc_oBO.this_dDataPrazoIni
        THIS.txt_4c_Datapf.Value = loc_oBO.this_dDataPrazoFim

        THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ALLTRIM(loc_oBO.this_cOperacao)
        THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = loc_oBO.this_nOperacaoIni
        THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = loc_oBO.this_nOperacaoFim

        THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cContaGrupo)
        THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cContaConta)
        THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(loc_oBO.this_cContaDescricao)

        THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cRespGrupo)
        THIS.cnt_4c_Responsavel.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cRespConta)
        THIS.cnt_4c_Responsavel.txt_4c_Dconta.Value = ALLTRIM(loc_oBO.this_cRespDescricao)

        *-- Empresa/Chec_pedra: so aplica quando o BO ja tem codigo resolvido
        *-- (ConfigurarCamposContas roda ANTES e ja fez o lookup default de
        *-- go_4c_Sistema.cCodEmpresa direto na tela, sem passar pelo BO) -
        *-- sem esse guard, BOParaForm apagaria o default com o SPACE(3)
        *-- inicial da property.
        IF !EMPTY(ALLTRIM(loc_oBO.this_cEmpresaCodigo))
            THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(loc_oBO.this_cEmpresaCodigo)
            THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(loc_oBO.this_cEmpresaRazao)
        ENDIF
        THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = IIF(loc_oBO.this_lNaoEmpenharPedra, 1, 0)

        THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = loc_oBO.this_dPrevisaoEntrega
        THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = loc_oBO.this_dDataGeracao

        THIS.cnt_4c_Op.txt_4c_Nop.Value = loc_oBO.this_nNumeroOP
        THIS.cnt_4c_Container1.txt_4c_TpGOp.Value = ALLTRIM(loc_oBO.this_cTipoGeracaoOP)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - equivalente ao SIGPRGLO.Cancelar.Click legado
    * (ThisForm.Release). PUBLIC porque e alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - equivalente ao SIGPRGLO.Processar.Click legado
    * (tasks\task615\SigPrGlo_form_codigo_fonte.txt linhas 1383-1703):
    * validacoes de UI identicas ao legado (early-exit com foco no campo que
    * falhou), depois delega a varredura de SigMvCab/SigMvItn/SigMvIts para
    * THIS.this_oBusinessObject.Processar() (SigPrGloBO.prg), que monta
    * TmpCabec/TmpItens na DataSession corrente. Com pelo menos um item
    * selecionado, abre FormSigPrGl2 exatamente como o legado fazia com
    * "Do Form SigPrGl2 With ThisForm, ThisForm.Datasessionid, ThisForm.
    * Reserva, ThisForm.poDataMgr, (ThisForm.Empresa.Chec_pedra.Value=0),
    * ThisForm.automatico, ThisForm.Cnt_Op.GetNop.Value" - mapeamento
    * posicional contra o LParameters real de SigPrGl2 (tasks\task614\
    * SigPrGl2_form_codigo_fonte.txt:1171 - _ParentForm,_Data,_ReservaAuto,
    * pCnx,_nGerEmphPdr,_Autom,_NumeroOp; pCnx sai, pois a conexao agora vem
    * de gnConnHandle - regra Global Variables).
    * PUBLIC porque e alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_oErro

        IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
            MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
            RETURN
        ENDIF
        IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
            MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.this_nPamGlobAutos = 2 AND THIS.cnt_4c_Op.txt_4c_Nop.Value = 0 AND !THIS.this_lReserva
            MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
            RETURN
        ENDIF
        IF THIS.this_lGerPorTp AND EMPTY(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value)
            MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + " Obrigat" + CHR(243) + "rio ser Preenchido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Container1.txt_4c_TpGOp.SetFocus
            RETURN
        ENDIF
        IF !EMPTY(THIS.txt_4c_Dataei.Value) AND !EMPTY(THIS.txt_4c_Dataef.Value) AND THIS.txt_4c_Dataef.Value < THIS.txt_4c_Dataei.Value
            MsgAviso("A Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Dataei.SetFocus
            RETURN
        ENDIF
        IF !EMPTY(THIS.txt_4c_Datapi.Value) AND !EMPTY(THIS.txt_4c_Datapf.Value) AND THIS.txt_4c_Datapf.Value < THIS.txt_4c_Datapi.Value
            MsgAviso("A Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Datapi.SetFocus
            RETURN
        ENDIF

        THIS.FormParaBO()

        THIS.AlternarPagina("PROCESSANDO")

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.Processar( ;
                THIS.txt_4c_Dataei.Value, THIS.txt_4c_Dataef.Value, ;
                THIS.txt_4c_Datapi.Value, THIS.txt_4c_Datapf.Value, ;
                ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value), ;
                THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value, THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value, ;
                ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value), ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value), ;
                ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value), ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Conta.Value), ;
                IIF(EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)), ;
                    ALLTRIM(go_4c_Sistema.cCodEmpresa), ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)), ;
                ALLTRIM(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value))
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro ao Processar")
        ENDTRY

        THIS.AlternarPagina("ENTRADA")

        IF !loc_lSucesso
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            RETURN
        ENDIF

        IF !USED("TmpItens") OR !USED("TmpCabec") OR EOF("TmpItens") OR EOF("TmpCabec")
            MsgAviso("Nenhum Item Selecionado Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Dataei.SetFocus
            RETURN
        ENDIF

        *-- CREATEOBJECT/Show FORA de qualquer TRY (regra #29 - Show() de
        *-- form modal dentro de TRY fecha a tela a cada erro de runtime).
        *-- FormSigPrGl2 desabilita/reabilita THIS sozinho (Init/Destroy),
        *-- entao nao duplicamos THIS.Enabled = .F. aqui.
        LOCAL loc_oFormFilho
        loc_oFormFilho = CREATEOBJECT("FormSigPrGl2", THIS, THIS.DataSessionId, THIS.this_lReserva, ;
            (THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = 0), THIS.this_lAutomatico, ;
            THIS.cnt_4c_Op.txt_4c_Nop.Value, THIS.this_lPorDestino)
        IF VARTYPE(loc_oFormFilho) = "O"
            loc_oFormFilho.Show()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OperacaoKeyPress - lookup de Movimentacao (cnt_4c_Operacao.txt_4c_
    * Operacao, equivalente ao Get_Operacao.Valid legado). SigCdOpe so tem
    * Dopes como coluna de texto (nao ha Descrs) - filtro adicional por
    * Globalizas IN (1,2), igual ao TmpOper do Init legado. Enter/Tab vazio
    * zera a faixa de numero (Get_Operacaoi/Get_Operacaof), igual ao legado.
    *--------------------------------------------------------------------------
    PROCEDURE OperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Operacao
            loc_cValor = ALLTRIM(.txt_4c_Operacao.Value)

            IF EMPTY(loc_cValor)
                .txt_4c_Operacaoi.Value = 0
                .txt_4c_Operacaof.Value = 0
                IF par_nKeyCode != 115
                    RETURN
                ENDIF
            ENDIF

            IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkOper")
                    USE IN cursor_4c_ChkOper
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor) + ;
                    " AND Globalizas IN (1,2)", "cursor_4c_ChkOper")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkOper") AND RECCOUNT("cursor_4c_ChkOper") > 0
                    IF USED("cursor_4c_ChkOper")
                        USE IN cursor_4c_ChkOper
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkOper")
                    USE IN cursor_4c_ChkOper
                ENDIF
            ENDIF

            THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
                "Movimenta" + CHR(231) + CHR(227) + "o", loc_cValor, ;
                .txt_4c_Operacao, .NULL., "Globalizas IN (1,2)")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TpGOpKeyPress - lookup do Tipo de Geracao da OP (cnt_4c_Container1.
    * txt_4c_TpGOp, equivalente ao Get_TpGOp.Valid legado - fwBuscaSel sobre
    * CrTmpTpGop, aqui reproduzido como lookup direto em SigInTgo). O filtro
    * de acesso por usuario (fChecaAcesso) nao foi portado - ver regra de
    * funcoes de acesso Fortyus nao portadas.
    *--------------------------------------------------------------------------
    PROCEDURE TpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Container1
            loc_cValor = ALLTRIM(.txt_4c_TpGOp.Value)

            IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkTpGOp")
                    USE IN cursor_4c_ChkTpGOp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos FROM SigInTgo WHERE Codigos = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkTpGOp")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkTpGOp") AND RECCOUNT("cursor_4c_ChkTpGOp") > 0
                    IF USED("cursor_4c_ChkTpGOp")
                        USE IN cursor_4c_ChkTpGOp
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkTpGOp")
                    USE IN cursor_4c_ChkTpGOp
                ENDIF
            ENDIF

            THIS.AbrirLookupCanonico("SigInTgo", "Codigos", "Descs", ;
                "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP", loc_cValor, ;
                .txt_4c_TpGOp, .NULL.)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConGrupoKeyPress / RespGrupoKeyPress - lookup do Grupo de Conta
    * (SigCdGcr), equivalente ao Get_grupo.Valid (fAcessoContab) das duas
    * containers Conta/Responsavel. Nao ha campo de descricao visivel para
    * o Grupo no form - so validacao/preenchimento do codigo.
    *--------------------------------------------------------------------------
    PROCEDURE ConGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarLookupGrupo(par_nKeyCode, THIS.cnt_4c_Conta.txt_4c_Grupo)
    ENDPROC

    PROCEDURE RespGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarLookupGrupo(par_nKeyCode, THIS.cnt_4c_Responsavel.txt_4c_Grupo)
    ENDPROC

    PROTECTED PROCEDURE ProcessarLookupGrupo(par_nKeyCode, par_oTxtGrupo)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(par_oTxtGrupo.Value)

        IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_ChkGrupo")
                USE IN cursor_4c_ChkGrupo
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
                "cursor_4c_ChkGrupo")
            IF loc_nResultado > 0 AND USED("cursor_4c_ChkGrupo") AND RECCOUNT("cursor_4c_ChkGrupo") > 0
                IF USED("cursor_4c_ChkGrupo")
                    USE IN cursor_4c_ChkGrupo
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_ChkGrupo")
                USE IN cursor_4c_ChkGrupo
            ENDIF
        ENDIF

        THIS.AbrirLookupCanonico("SigCdGcr", "Codigos", "Descrs", ;
            "Grupo de Conta", loc_cValor, par_oTxtGrupo, .NULL.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConContaKeyPress / RespContaKeyPress - lookup da Conta por CODIGO
    * (SigCdCli.Iclis, filtrado por grupos = grupo digitado), equivalente ao
    * Get_conta.Valid (fAcessoContas modo 'C') das containers Conta/
    * Responsavel. Ao selecionar/casar, preenche a descricao (Rclis) no
    * txt_4c_Dconta irmao.
    *--------------------------------------------------------------------------
    PROCEDURE ConContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        WITH THIS.cnt_4c_Conta
            THIS.ProcessarLookupConta(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROCEDURE RespContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        WITH THIS.cnt_4c_Responsavel
            THIS.ProcessarLookupConta(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ProcessarLookupConta(par_nKeyCode, par_oTxtGrupo, par_oTxtConta, par_oTxtDconta)
        LOCAL loc_cValor, loc_cGrupo, loc_cFiltroExtra, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(par_oTxtConta.Value)
        loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
        loc_cFiltroExtra = ""
        IF !EMPTY(loc_cGrupo)
            loc_cFiltroExtra = "grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF

        IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_ChkConta")
                USE IN cursor_4c_ChkConta
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor) + ;
                IIF(EMPTY(loc_cFiltroExtra), "", " AND " + loc_cFiltroExtra), ;
                "cursor_4c_ChkConta")
            IF loc_nResultado > 0 AND USED("cursor_4c_ChkConta") AND RECCOUNT("cursor_4c_ChkConta") > 0
                par_oTxtDconta.Value = ALLTRIM(cursor_4c_ChkConta.Rclis)
                IF USED("cursor_4c_ChkConta")
                    USE IN cursor_4c_ChkConta
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_ChkConta")
                USE IN cursor_4c_ChkConta
            ENDIF
        ENDIF

        THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
            "Conta", loc_cValor, par_oTxtConta, par_oTxtDconta, loc_cFiltroExtra)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConDcontaKeyPress / RespDcontaKeyPress - lookup da Conta por
    * DESCRICAO (SigCdCli.Rclis, filtrado por grupos), equivalente ao
    * Get_dconta.Valid (fAcessoContas modo 'D'). Ao casar/selecionar,
    * preenche TAMBEM o codigo (Iclis) no txt_4c_Conta irmao.
    *--------------------------------------------------------------------------
    PROCEDURE ConDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        WITH THIS.cnt_4c_Conta
            THIS.ProcessarLookupContaPorDescricao(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROCEDURE RespDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        WITH THIS.cnt_4c_Responsavel
            THIS.ProcessarLookupContaPorDescricao(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ProcessarLookupContaPorDescricao(par_nKeyCode, par_oTxtGrupo, par_oTxtConta, par_oTxtDconta)
        LOCAL loc_cValor, loc_cGrupo, loc_cFiltroExtra, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(par_oTxtDconta.Value)
        loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
        loc_cFiltroExtra = ""
        IF !EMPTY(loc_cGrupo)
            loc_cFiltroExtra = "grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF

        IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_ChkContaD")
                USE IN cursor_4c_ChkContaD
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Iclis, Rclis FROM SigCdCli WHERE Rclis = " + EscaparSQL(loc_cValor) + ;
                IIF(EMPTY(loc_cFiltroExtra), "", " AND " + loc_cFiltroExtra), ;
                "cursor_4c_ChkContaD")
            IF loc_nResultado > 0 AND USED("cursor_4c_ChkContaD") AND RECCOUNT("cursor_4c_ChkContaD") > 0
                par_oTxtConta.Value  = ALLTRIM(cursor_4c_ChkContaD.Iclis)
                par_oTxtDconta.Value = ALLTRIM(cursor_4c_ChkContaD.Rclis)
                IF USED("cursor_4c_ChkContaD")
                    USE IN cursor_4c_ChkContaD
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_ChkContaD")
                USE IN cursor_4c_ChkContaD
            ENDIF
        ENDIF

        THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
            "Conta", loc_cValor, par_oTxtConta, par_oTxtDconta, loc_cFiltroExtra)
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresaCodKeyPress / EmpresaDescKeyPress - lookup de Empresa
    * (SigCdEmp.Cemps/Razas), equivalente ao par get_cd_empresa.Valid /
    * get_ds_empresa.Valid (fAcessoEmpresa modos 'C'/'D') - fAcessoEmpresa
    * NAO foi portada (funcao global Fortyus - ver regra de funcoes de
    * acesso nao portadas), substituida pelo lookup canonico em SigCdEmp.
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaCodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Empresa
            loc_cValor = ALLTRIM(.txt_4c_CdEmpresa.Value)

            IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkEmpCod")
                    USE IN cursor_4c_ChkEmpCod
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkEmpCod")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpCod") AND RECCOUNT("cursor_4c_ChkEmpCod") > 0
                    .txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpCod.Razas)
                    IF USED("cursor_4c_ChkEmpCod")
                        USE IN cursor_4c_ChkEmpCod
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkEmpCod")
                    USE IN cursor_4c_ChkEmpCod
                ENDIF
            ENDIF

            THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
                .txt_4c_CdEmpresa, .txt_4c_DsEmpresa)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    PROCEDURE EmpresaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Empresa
            loc_cValor = ALLTRIM(.txt_4c_DsEmpresa.Value)

            IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkEmpDesc")
                    USE IN cursor_4c_ChkEmpDesc
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkEmpDesc")
                IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpDesc") AND RECCOUNT("cursor_4c_ChkEmpDesc") > 0
                    .txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpDesc.Cemps)
                    .txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpDesc.Razas)
                    IF USED("cursor_4c_ChkEmpDesc")
                        USE IN cursor_4c_ChkEmpDesc
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkEmpDesc")
                    USE IN cursor_4c_ChkEmpDesc
                ENDIF
            ENDIF

            THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
                .txt_4c_CdEmpresa, .txt_4c_DsEmpresa)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * NopKeyPress - Numero manual da O.P. (cnt_4c_Op.txt_4c_Nop), equivalente
    * ao GetNop.Valid legado: NAO eh um picker, eh checagem de duplicidade
    * contra SigOpPic.Numps. Se ja existe, avisa e limpa o campo.
    *--------------------------------------------------------------------------
    PROCEDURE NopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nValor, loc_nResultado
        IF !(par_nKeyCode = 13 OR par_nKeyCode = 9)
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Op
            loc_nValor = .txt_4c_Nop.Value
            IF loc_nValor > 0 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ChkNop")
                    USE IN cursor_4c_ChkNop
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Numps FROM SigOpPic WHERE Numps = " + FormatarNumeroSQL(loc_nValor, 0), ;
                    "cursor_4c_ChkNop")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkNop") AND RECCOUNT("cursor_4c_ChkNop") > 0
                    MsgAviso("N" + CHR(250) + "mero de Op j" + CHR(225) + " existe. Favor Corrigir!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    .txt_4c_Nop.Value = 0
                    .txt_4c_Nop.SetFocus
                ENDIF
                IF USED("cursor_4c_ChkNop")
                    USE IN cursor_4c_ChkNop
                ENDIF
            ENDIF
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - funil de bloqueio/desbloqueio da UI durante o
    * processamento em lote. Este form OPERACIONAL eh flat (sem PageFrame de
    * conteudo), entao nao ha pagina para navegar - "par_cModo" alterna o
    * ESTADO da tela entre:
    *   "ENTRADA"     - usuario preenche os filtros (UI liberada)
    *   "PROCESSANDO" - THIS.this_oBusinessObject executa o processamento em
    *                   lote (UI bloqueada, equivalente ao trecho do Click
    *                   legado que roda entre a validacao e o Messagebox de
    *                   conclusao)
    * Chamado no fim de InicializarForm ("ENTRADA") e, nas proximas fases,
    * no BtnProcessarClick (antes/depois de THIS.this_oBusinessObject.Processar)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_cModo)
        LOCAL loc_lLiberado
        loc_lLiberado = (UPPER(ALLTRIM(par_cModo)) != "PROCESSANDO")

        THIS.cmd_4c_Processar.Enabled = loc_lLiberado

        THIS.cnt_4c_Container1.Enabled   = loc_lLiberado AND THIS.this_lGerPorTp
        THIS.cnt_4c_Operacao.Enabled     = loc_lLiberado
        THIS.cnt_4c_Conta.Enabled        = loc_lLiberado
        THIS.cnt_4c_Responsavel.Enabled  = loc_lLiberado
        THIS.cnt_4c_Empresa.Enabled      = loc_lLiberado
        THIS.cnt_4c_Previsao.Enabled     = loc_lLiberado
        THIS.cnt_4c_Op.Enabled           = loc_lLiberado

        IF loc_lLiberado
            THIS.MousePointer = 0
        ELSE
            THIS.MousePointer = 11
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna visiveis (recursivamente) os controles
    * criados via AddObject, que nascem com Visible = .F.
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls[loc_i]
            IF VARTYPE(loc_oCtrl) != "O"
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls[loc_i]
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
