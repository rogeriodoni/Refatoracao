*==============================================================================
* FormSigOpCbl.prg - Form Operacional: Configuracao de Boletos Bancarios
* Herda de: FormBase
* Tipo: OPERACIONAL - tela unica de parametrizacao de impressao de boletos
*         (posicoes linha/coluna dos campos do boleto, fonte/impressora
*         padrao e tamanho de folha). Registro UNICO em SigCnFBl (o legado
*         faz Append Blank no Init quando a tabela esta vazia).
* SCX Origem: SIGOPCBL.SCX
*==============================================================================
DEFINE CLASS FormSigOpCbl AS FormBase

    *-- Dimensoes pixel-perfect do SCX original (PILAR 1)
    Width        = 800
    Height       = 600
    Caption      = "Configura" + CHR(231) + CHR(227) + "o de Boletos Banc" + CHR(225) + "rios"
    AutoCenter   = .T.
    ShowTips     = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    BorderStyle  = 2
    DataSession  = 2

    *-- Guarda de reentrancia dos campos Impressora/Fonte/Folha: os tres
    *-- handlers de LostFocus abrem dialogo MODAL do Windows (GetPrinter /
    *-- GetFont / GetPaperSize), que tira e devolve o foco ao campo e faz o
    *-- proprio LostFocus disparar de novo - sem a guarda o dialogo empilha
    *-- (regra CLAUDE.md #37/#47). Liberada SEMPRE no wrapper, inclusive
    *-- quando o corpo sai por CATCH.
    this_lEmDialogo = .F.

    *--------------------------------------------------------------------------
    * Init - FormBase.Init() ja chama THIS.InicializarForm() via DODEFAULT().
    * Regra CLAUDE.md "Problema 8": nunca chamar InicializarForm() de novo aqui.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, carrega o registro UNICO de
    * SigCnFBl (regra CLAUDE.md OPERACIONAL: tabela de configuracao unica) e
    * monta a estrutura visual (cabecalho + botoes Confirmar/Encerrar).
    *
    * Equivalente ao Init legado: ".AddCursor('SigCnFBl', ... lcQryCfgBl)" +
    * ".poDataMgr.ReQuery(...)" + "Go Top" + "If Eof() / Append Blank / EndIf"
    * -> aqui replicado por SigOpCblBO.CarregarRegistroUnico(), que carrega o
    * registro existente (modo ALTERAR) ou prepara um novo quando a tabela
    * esta vazia (modo INCLUIR), sem nunca deixar o form sem registro
    * corrente. THIS.BOParaForm() espelha o registro carregado nos campos ja
    * ligados (FASE 5/8: primeira metade - Text1..Text16/Text40); a segunda
    * metade entra na fase seguinte do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCblBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.ConfigurarPageFrame()

                *-- Guard gb_4c_ValidandoUI/gb_4c_ModoTeste (padrao FormSigOpAlC):
                *-- em validacao de UI ou teste headless nao ha gnConnHandle real,
                *-- e SQLEXEC com handle invalido dispara EXCECAO (nao apenas
                *-- devolve erro) - pular a carga preserva a instanciacao do form
                *-- para o harness inspecionar os controles. Sem conexao, o
                *-- BOParaForm sozinho ja espelha os defaults das properties do
                *-- BO (equivalente ao registro em branco do Append Blank legado).
                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                        (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
                    THIS.CarregarLista()
                ELSE
                    THIS.BOParaForm()
                ENDIF

                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigOpCblBO. VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Entry point de layout. Este form OPERACIONAL nao
    * usa PageFrame (tela unica de parametrizacao, igual ao SIGOPCBL.SCX
    * original): cabecalho + area de campos + grupo Confirmar/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta o cabecalho (cntSombra do SCX original) e
    * reserva a area do grupo de botoes Confirmar/Encerrar (os botoes em si
    * sao adicionados na fase de botoes do pipeline).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra do SCX)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

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
        ENDWITH
        loc_oCab = THIS.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top       = 18
            .Left      = 10
            .Width     = loc_oCab.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = loc_oCab.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Container do grupo Confirmar/Encerrar (replica
    * cmdGsalva do SCX: Top=-2 Left=643 Width=160 Height=85, ButtonCount=2)
    * com os dois botoes de acao, transcritos de Command1 (cmdOk/"Confirmar")
    * e Command2 (cmdCancelar/"Encerrar", Cancel=.T.). O legado usa
    * CommandGroup; aqui os botoes sao standalone (CommandButton direto no
    * Container), por isso levam Themes=.T. + DisabledPicture (regra
    * [[feedback_standalone_commandbutton_themes]] - sem isso o icone nao
    * renderiza em runtime).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = -2
            .Left        = 643
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Command1 (cmdOk) do cmdGsalva legado - "Confirma a Configuracao do Boleto?"
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .ToolTipText     = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
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
            .Visible         = .T.
        ENDWITH

        *-- Command2 (cmdCancelar) do cmdGsalva legado - "Deseja Abandonar as Alteracoes Realizadas?"
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .ToolTipText     = "[ESC] Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
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
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENT exige metodo PUBLIC (regra CLAUDE.md #3) - BtnConfirmarClick
        *-- e BtnEncerrarClick estao declarados mais abaixo nesta mesma classe.
        *-- BtnEncerrarClick delega para BtnCancelarClick, que guarda o corpo
        *-- do Click legado: o objeto do SCX chama-se cmdCancelar mas tem
        *-- Caption "Encerrar" (PILAR 1 - a legenda eh a do legado).
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Campos de posicionamento de impressao do boleto
    * (linha x coluna de cada bloco), transcritos do SIGOPCBL.SCX direto no
    * Form (layout FLAT - tela unica, sem PageFrame/paginas).
    *
    * Secoes: Cabecalho, Local de Pagamento, Vencimento, Data Documento,
    * Numero do Documento, Valor do Documento, Texto de Responsabilidade do
    * Cedente (posicao + Numero de Linhas/Colunas), Sacado (Razao Social,
    * C.G.C./C.P.F., Endereco, Bairro, Cidade, U.F., C.E.P.), Impressora/
    * Fonte (Nome da Impressora, Fonte Padrao + Tamanho) e Folha (Text40,
    * fwget no legado). Analise.json confirma lookups=[] para este form -
    * nao ha FormBuscaAuxiliar: os unicos campos com validacao em tempo de
    * UI sao Text29/Text30/Text40 (impressora/fonte/papel), tratados com
    * BINDEVENT "LostFocus" apos o AddObject de cada um.
    *
    * Os campos de posicao (nlnXxx/nclXxx) sao numeric(5,2) no schema -
    * InputMask "999.99"; Numero de Linhas/Colunas (ntxtlins/ntxtcols) sao
    * numeric(3,0) - InputMask "999". Labels sem Width/Alignment no dump do
    * legado (classe say) usam Alignment=0 (regra CLAUDE.md #23); os que o
    * SCX declara com Width usam a largura exata do dump.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Secao "Cabecalho"
        THIS.AddObject("lbl_4c_Label27", "Label")
        WITH THIS.lbl_4c_Label27
            .Top       = 119
            .Left      = 122
            .Width     = 60
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cabe" + CHR(231) + "alho"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top        = 135
            .Left       = 109
            .Width      = 570
            .Height     = 2
            .BackStyle  = 1
            .BackColor  = RGB(192, 192, 192)
            .BorderStyle = 0
            .Visible    = .T.
        ENDWITH

        *-- Local de Pagamento (nlnlocals x ncllocals)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 142
            .Left      = 109
            .Width     = 98
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Local de Pagamento"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text1", "TextBox")
        WITH THIS.txt_4c_Text1
            .Top       = 156
            .Left      = 109
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 158
            .Left      = 151
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text2", "TextBox")
        WITH THIS.txt_4c_Text2
            .Top       = 156
            .Left      = 158
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Vencimento (nlndtvencs x ncldtvencs)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 142
            .Left      = 235
            .Width     = 57
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Vencimento"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text3", "TextBox")
        WITH THIS.txt_4c_Text3
            .Top       = 156
            .Left      = 235
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 158
            .Left      = 277
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text4", "TextBox")
        WITH THIS.txt_4c_Text4
            .Top       = 156
            .Left      = 284
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Data Documento (nlndtdocs x ncldtdocs)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 142
            .Left      = 342
            .Width     = 82
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Data Documento"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text5", "TextBox")
        WITH THIS.txt_4c_Text5
            .Top       = 156
            .Left      = 342
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 158
            .Left      = 384
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text6", "TextBox")
        WITH THIS.txt_4c_Text6
            .Top       = 156
            .Left      = 391
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Numero do Documento (nlnnrdocs x nclnrdocs)
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 142
            .Left      = 452
            .Width     = 86
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "N" + CHR(186) + " do Documento"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text7", "TextBox")
        WITH THIS.txt_4c_Text7
            .Top       = 156
            .Left      = 452
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Top       = 158
            .Left      = 494
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text8", "TextBox")
        WITH THIS.txt_4c_Text8
            .Top       = 156
            .Left      = 501
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Valor do Documento (nlnvldocs x nclvldocs)
        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Top       = 142
            .Left      = 562
            .Width     = 98
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor do Documento"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text9", "TextBox")
        WITH THIS.txt_4c_Text9
            .Top       = 157
            .Left      = 562
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .Top       = 158
            .Left      = 604
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text10", "TextBox")
        WITH THIS.txt_4c_Text10
            .Top       = 157
            .Left      = 611
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Secao "Texto de Responsabilidade do Cedente"
        THIS.AddObject("lbl_4c_Label28", "Label")
        WITH THIS.lbl_4c_Label28
            .Top       = 183
            .Left      = 122
            .Width     = 221
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Texto de Responsabilidade do Cedente"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top        = 199
            .Left       = 109
            .Width      = 570
            .Height     = 2
            .BackStyle  = 1
            .BackColor  = RGB(192, 192, 192)
            .BorderStyle = 0
            .Visible    = .T.
        ENDWITH

        *-- Texto (nlntxtcds x ncltxtcds) + Numero de Colunas/Linhas (ntxtcols/ntxtlins)
        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .Top       = 206
            .Left      = 122
            .Width     = 30
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Texto"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text11", "TextBox")
        WITH THIS.txt_4c_Text11
            .Top       = 221
            .Left      = 122
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .Top       = 222
            .Left      = 164
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text12", "TextBox")
        WITH THIS.txt_4c_Text12
            .Top       = 221
            .Left      = 171
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label30", "Label")
        WITH THIS.lbl_4c_Label30
            .Top       = 206
            .Left      = 232
            .Width     = 55
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "N" + CHR(186) + " Colunas"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text13", "TextBox")
        WITH THIS.txt_4c_Text13
            .Top       = 221
            .Left      = 232
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label29", "Label")
        WITH THIS.lbl_4c_Label29
            .Top       = 206
            .Left      = 308
            .Width     = 47
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "N" + CHR(186) + " Linhas"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text14", "TextBox")
        WITH THIS.txt_4c_Text14
            .Top       = 221
            .Left      = 308
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Secao "Sacado" - Razao Social (nlnrazclis x nclrazclis)
        THIS.AddObject("lbl_4c_Label31", "Label")
        WITH THIS.lbl_4c_Label31
            .Top       = 248
            .Left      = 122
            .Width     = 43
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Sacado"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top        = 264
            .Left       = 109
            .Width      = 570
            .Height     = 2
            .BackStyle  = 1
            .BackColor  = RGB(192, 192, 192)
            .BorderStyle = 0
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label13", "Label")
        WITH THIS.lbl_4c_Label13
            .Top       = 271
            .Left      = 122
            .Width     = 62
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Raz" + CHR(227) + "o Social"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text15", "TextBox")
        WITH THIS.txt_4c_Text15
            .Top       = 286
            .Left      = 122
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label14", "Label")
        WITH THIS.lbl_4c_Label14
            .Top       = 287
            .Left      = 164
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text16", "TextBox")
        WITH THIS.txt_4c_Text16
            .Top       = 286
            .Left      = 171
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Sacado: C.G.C./C.P.F. (nlncgcclis x nclcgcclis)
        THIS.AddObject("lbl_4c_Label15", "Label")
        WITH THIS.lbl_4c_Label15
            .Top       = 271
            .Left      = 232
            .Width     = 70
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C.G.C./C.P.F."
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text17", "TextBox")
        WITH THIS.txt_4c_Text17
            .Top       = 286
            .Left      = 232
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label16", "Label")
        WITH THIS.lbl_4c_Label16
            .Top       = 287
            .Left      = 274
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text18", "TextBox")
        WITH THIS.txt_4c_Text18
            .Top       = 286
            .Left      = 281
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Sacado: Endereco (nlnendcobs x nclendcobs)
        THIS.AddObject("lbl_4c_Label17", "Label")
        WITH THIS.lbl_4c_Label17
            .Top       = 271
            .Left      = 342
            .Width     = 47
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Endere" + CHR(231) + "o"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text19", "TextBox")
        WITH THIS.txt_4c_Text19
            .Top       = 286
            .Left      = 342
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label18", "Label")
        WITH THIS.lbl_4c_Label18
            .Top       = 287
            .Left      = 394
            .Width     = 9
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label36", "Label")
        WITH THIS.lbl_4c_Label36
            .Top       = 288
            .Left      = 384
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text20", "TextBox")
        WITH THIS.txt_4c_Text20
            .Top       = 286
            .Left      = 391
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Sacado: Bairro (nlnbaicobs x nclbaicobs)
        THIS.AddObject("lbl_4c_Label19", "Label")
        WITH THIS.lbl_4c_Label19
            .Top       = 271
            .Left      = 452
            .Width     = 30
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Bairro"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text21", "TextBox")
        WITH THIS.txt_4c_Text21
            .Top       = 286
            .Left      = 452
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label20", "Label")
        WITH THIS.lbl_4c_Label20
            .Top       = 287
            .Left      = 494
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text22", "TextBox")
        WITH THIS.txt_4c_Text22
            .Top       = 286
            .Left      = 501
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Sacado: Cidade (nlncidcobs x nclcidcobs)
        THIS.AddObject("lbl_4c_Label21", "Label")
        WITH THIS.lbl_4c_Label21
            .Top       = 306
            .Left      = 122
            .Width     = 35
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cidade"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text23", "TextBox")
        WITH THIS.txt_4c_Text23
            .Top       = 320
            .Left      = 122
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label22", "Label")
        WITH THIS.lbl_4c_Label22
            .Top       = 321
            .Left      = 164
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text24", "TextBox")
        WITH THIS.txt_4c_Text24
            .Top       = 320
            .Left      = 171
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Sacado: U.F. (nlnestcobs x nclestcobs)
        THIS.AddObject("lbl_4c_Label23", "Label")
        WITH THIS.lbl_4c_Label23
            .Top       = 306
            .Left      = 232
            .Width     = 23
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "U.F."
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text25", "TextBox")
        WITH THIS.txt_4c_Text25
            .Top       = 320
            .Left      = 232
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label24", "Label")
        WITH THIS.lbl_4c_Label24
            .Top       = 321
            .Left      = 274
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text26", "TextBox")
        WITH THIS.txt_4c_Text26
            .Top       = 320
            .Left      = 282
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Sacado: C.E.P. (nlncepcobs x nclcepcobs)
        THIS.AddObject("lbl_4c_Label25", "Label")
        WITH THIS.lbl_4c_Label25
            .Top       = 306
            .Left      = 342
            .Width     = 33
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C.E.P."
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text27", "TextBox")
        WITH THIS.txt_4c_Text27
            .Top       = 320
            .Left      = 342
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        THIS.AddObject("lbl_4c_Label26", "Label")
        WITH THIS.lbl_4c_Label26
            .Top       = 321
            .Left      = 384
            .Width     = 8
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "x"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text28", "TextBox")
        WITH THIS.txt_4c_Text28
            .Top       = 320
            .Left      = 391
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Secao "Impressora / Fonte"
        THIS.AddObject("lbl_4c_Label35", "Label")
        WITH THIS.lbl_4c_Label35
            .Top       = 348
            .Left      = 122
            .Width     = 112
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Impressora / Fonte"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top        = 364
            .Left       = 109
            .Width      = 262
            .Height     = 2
            .BackStyle  = 1
            .BackColor  = RGB(192, 192, 192)
            .BorderStyle = 0
            .Visible    = .T.
        ENDWITH

        *-- Nome da Impressora (cnomeimps) - validado em Text29LostFocus
        THIS.AddObject("lbl_4c_Label32", "Label")
        WITH THIS.lbl_4c_Label32
            .Top       = 371
            .Left      = 122
            .Width     = 101
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome da Impressora"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text29", "TextBox")
        WITH THIS.txt_4c_Text29
            .Top       = 384
            .Left      = 122
            .Width     = 240
            .Height    = 18
            .Value     = ""
            .MaxLength = 128
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH
        BINDEVENT(THIS.txt_4c_Text29, "LostFocus", THIS, "Text29LostFocus")

        *-- Fonte Padrao (cfontepdrs) - validada em Text30LostFocus
        THIS.AddObject("lbl_4c_Label33", "Label")
        WITH THIS.lbl_4c_Label33
            .Top       = 404
            .Left      = 122
            .Width     = 67
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Fonte Padr" + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text30", "TextBox")
        WITH THIS.txt_4c_Text30
            .Top       = 418
            .Left      = 122
            .Width     = 192
            .Height    = 18
            .Value     = ""
            .MaxLength = 128
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH
        BINDEVENT(THIS.txt_4c_Text30, "LostFocus", THIS, "Text30LostFocus")

        *-- Tamanho da fonte (ntamfontes) - atualizado automaticamente por Text30LostFocus
        THIS.AddObject("lbl_4c_Label34", "Label")
        WITH THIS.lbl_4c_Label34
            .Top       = 404
            .Left      = 323
            .Width     = 46
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tamanho"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text31", "TextBox")
        WITH THIS.txt_4c_Text31
            .Top       = 418
            .Left      = 323
            .Width     = 41
            .Height    = 18
            .Value     = 0
            .InputMask = "999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH

        *-- Secao "Folha" - Tamanho da Folha (ctamfolha, fwget no legado)
        THIS.AddObject("lbl_4c_Label39", "Label")
        WITH THIS.lbl_4c_Label39
            .Top       = 446
            .Left      = 126
            .Width     = 32
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Folha"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape5", "Shape")
        WITH THIS.shp_4c_Shape5
            .Top        = 462
            .Left       = 109
            .Width      = 262
            .Height     = 2
            .BackStyle  = 1
            .BackColor  = RGB(192, 192, 192)
            .BorderStyle = 0
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label38", "Label")
        WITH THIS.lbl_4c_Label38
            .Top       = 468
            .Left      = 125
            .Width     = 75
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tamanho Folha"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Text40", "TextBox")
        WITH THIS.txt_4c_Text40
            .Top       = 481
            .Left      = 124
            .Width     = 244
            .Height    = 19
            .Value     = ""
            .MaxLength = 50
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
            .Format    = "K"
        ENDWITH
        BINDEVENT(THIS.txt_4c_Text40, "LostFocus", THIS, "Text40LostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - carga de dados da tela. Este form OPERACIONAL nao tem
    * grade nem pagina de Lista: a "lista" dele eh o registro UNICO de
    * SigCnFBl (uma configuracao de boleto por instalacao), por isso o metodo
    * canonico de carga do projeto aqui recarrega esse registro e espelha nos
    * campos.
    *
    * Equivalente ao bloco de carga do Init legado:
    *
    *   .AddCursor('SigCnFBl', 'cIdChaves', 'crSigCnFBl', '', '', lcQryCfgBl)
    *   .poDataMgr.ReQuery('crSigCnFBl')
    *   Select crSigCnFBl / Go Top
    *   If Eof() / Append Blank / EndIf
    *   ... ThisForm.Text40.value = <descricao de ctamfolha> ...
    *   ThisForm.Refresh
    *   ThisForm.Text1.SetFocus
    *
    * SigOpCblBO.CarregarRegistroUnico() cobre o AddCursor/ReQuery/Go Top e o
    * "Append Blank" (tabela vazia -> NovoRegistro(), com os defaults das
    * properties, que eh o equivalente do registro em branco do cursor legado);
    * THIS.BOParaForm() cobre o espelhamento dos campos, inclusive o Text40
    * (ExtrairDescricaoTamanhoFolha). PUBLIC de proposito: o harness
    * TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da classe,
    * e PROTECTED falharia em runtime (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = THIS.this_oBusinessObject.CarregarRegistroUnico()

                *-- Mesmo quando a carga falha (erro de SQL - a propria
                *-- CarregarRegistroUnico ja exibiu a mensagem), espelhar o BO
                *-- mantem a tela coerente com o estado dele em vez de deixar
                *-- os campos com valor de outra carga.
                THIS.BOParaForm()
                THIS.Refresh()

                *-- "ThisForm.Text1.SetFocus" do Init legado. So com a tela JA
                *-- visivel: chamado de dentro do Init (form ainda nao exibido)
                *-- SetFocus estoura. O guard por THIS.Visible evita o CATCH
                *-- vazio que a regra CLAUDE.md #9 proibe - e na primeira carga
                *-- nada se perde, porque o TabIndex = 1 do Text1 ja lhe da o
                *-- foco inicial quando o form abre.
                IF THIS.Visible
                    THIS.txt_4c_Text1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transfere TODOS os campos do Business Object para os
    * controles da tela. Chamado em InicializarForm() apos ConfigurarPageFrame().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        THIS.txt_4c_Text1.Value  = loc_oBO.this_nNlnlocals
        THIS.txt_4c_Text2.Value  = loc_oBO.this_nNcllocals
        THIS.txt_4c_Text3.Value  = loc_oBO.this_nNlndtvencs
        THIS.txt_4c_Text4.Value  = loc_oBO.this_nNcldtvencs
        THIS.txt_4c_Text5.Value  = loc_oBO.this_nNlndtdocs
        THIS.txt_4c_Text6.Value  = loc_oBO.this_nNcldtdocs
        THIS.txt_4c_Text7.Value  = loc_oBO.this_nNlnnrdocs
        THIS.txt_4c_Text8.Value  = loc_oBO.this_nNclnrdocs
        THIS.txt_4c_Text9.Value  = loc_oBO.this_nNlnvldocs
        THIS.txt_4c_Text10.Value = loc_oBO.this_nNclvldocs
        THIS.txt_4c_Text11.Value = loc_oBO.this_nNlntxtcds
        THIS.txt_4c_Text12.Value = loc_oBO.this_nNcltxtcds
        THIS.txt_4c_Text13.Value = loc_oBO.this_nNtxtcols
        THIS.txt_4c_Text14.Value = loc_oBO.this_nNtxtlins
        THIS.txt_4c_Text15.Value = loc_oBO.this_nNlnrazclis
        THIS.txt_4c_Text16.Value = loc_oBO.this_nNclrazclis
        THIS.txt_4c_Text17.Value = loc_oBO.this_nNlncgcclis
        THIS.txt_4c_Text18.Value = loc_oBO.this_nNclcgcclis
        THIS.txt_4c_Text19.Value = loc_oBO.this_nNlnendcobs
        THIS.txt_4c_Text20.Value = loc_oBO.this_nNclendcobs
        THIS.txt_4c_Text21.Value = loc_oBO.this_nNlnbaicobs
        THIS.txt_4c_Text22.Value = loc_oBO.this_nNclbaicobs
        THIS.txt_4c_Text23.Value = loc_oBO.this_nNlncidcobs
        THIS.txt_4c_Text24.Value = loc_oBO.this_nNclcidcobs
        THIS.txt_4c_Text25.Value = loc_oBO.this_nNlnestcobs
        THIS.txt_4c_Text26.Value = loc_oBO.this_nNclestcobs
        THIS.txt_4c_Text27.Value = loc_oBO.this_nNlncepcobs
        THIS.txt_4c_Text28.Value = loc_oBO.this_nNclcepcobs
        THIS.txt_4c_Text29.Value = loc_oBO.this_cNomeimps
        THIS.txt_4c_Text30.Value = loc_oBO.this_cFontepdrs
        THIS.txt_4c_Text31.Value = loc_oBO.this_nTamfontes
        THIS.txt_4c_Text40.Value = THIS.ExtrairDescricaoTamanhoFolha(loc_oBO.this_cTamfolha)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere TODOS os campos dos controles da tela para o
    * Business Object. Chamado em BtnConfirmarClick() antes de Salvar().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oBO.this_nNlnlocals  = THIS.txt_4c_Text1.Value
        loc_oBO.this_nNcllocals  = THIS.txt_4c_Text2.Value
        loc_oBO.this_nNlndtvencs = THIS.txt_4c_Text3.Value
        loc_oBO.this_nNcldtvencs = THIS.txt_4c_Text4.Value
        loc_oBO.this_nNlndtdocs  = THIS.txt_4c_Text5.Value
        loc_oBO.this_nNcldtdocs  = THIS.txt_4c_Text6.Value
        loc_oBO.this_nNlnnrdocs  = THIS.txt_4c_Text7.Value
        loc_oBO.this_nNclnrdocs  = THIS.txt_4c_Text8.Value
        loc_oBO.this_nNlnvldocs  = THIS.txt_4c_Text9.Value
        loc_oBO.this_nNclvldocs  = THIS.txt_4c_Text10.Value
        loc_oBO.this_nNlntxtcds  = THIS.txt_4c_Text11.Value
        loc_oBO.this_nNcltxtcds  = THIS.txt_4c_Text12.Value
        loc_oBO.this_nNtxtcols   = THIS.txt_4c_Text13.Value
        loc_oBO.this_nNtxtlins   = THIS.txt_4c_Text14.Value
        loc_oBO.this_nNlnrazclis = THIS.txt_4c_Text15.Value
        loc_oBO.this_nNclrazclis = THIS.txt_4c_Text16.Value
        loc_oBO.this_nNlncgcclis = THIS.txt_4c_Text17.Value
        loc_oBO.this_nNclcgcclis = THIS.txt_4c_Text18.Value
        loc_oBO.this_nNlnendcobs = THIS.txt_4c_Text19.Value
        loc_oBO.this_nNclendcobs = THIS.txt_4c_Text20.Value
        loc_oBO.this_nNlnbaicobs = THIS.txt_4c_Text21.Value
        loc_oBO.this_nNclbaicobs = THIS.txt_4c_Text22.Value
        loc_oBO.this_nNlncidcobs = THIS.txt_4c_Text23.Value
        loc_oBO.this_nNclcidcobs = THIS.txt_4c_Text24.Value
        loc_oBO.this_nNlnestcobs = THIS.txt_4c_Text25.Value
        loc_oBO.this_nNclestcobs = THIS.txt_4c_Text26.Value
        loc_oBO.this_nNlncepcobs = THIS.txt_4c_Text27.Value
        loc_oBO.this_nNclcepcobs = THIS.txt_4c_Text28.Value
        loc_oBO.this_cNomeimps   = ALLTRIM(THIS.txt_4c_Text29.Value)
        loc_oBO.this_cFontepdrs  = ALLTRIM(THIS.txt_4c_Text30.Value)
        loc_oBO.this_nTamfontes  = THIS.txt_4c_Text31.Value
        *-- this_cTamfolha NAO vem de txt_4c_Text40.Value: o TextBox so exibe a
        *-- DESCRICAO (3o segmento de "Fonte/Codigo/Descricao" - ver
        *-- ExtrairDescricaoTamanhoFolha). O valor completo eh mantido por
        *-- Text40LostFocus (GetPaperSize) e remontado em
        *-- MontarTamanhoFolhaComFonte, chamado por BtnConfirmarClick.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExtrairDescricaoTamanhoFolha - equivalente ao bloco do Init legado que
    * calcula ThisForm.Text40.value a partir de crSigCnFBl.ctamfolha, que
    * guarda o composto "Fonte/Codigo/Descricao" (3 segmentos separados por
    * "/"). Devolve so a Descricao (3o segmento); "" quando o composto nao
    * tem os 3 segmentos (registro novo ou ainda no formato cru do
    * GetPaperSize(), sem nenhum "/").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExtrairDescricaoTamanhoFolha(par_cTamFolha)
        LOCAL loc_nPos1, loc_cResto, loc_nPos2

        IF EMPTY(par_cTamFolha)
            RETURN ""
        ENDIF

        loc_nPos1 = AT("/", par_cTamFolha)
        IF loc_nPos1 = 0
            RETURN ""
        ENDIF

        loc_cResto = SUBSTR(par_cTamFolha, loc_nPos1 + 1)
        loc_nPos2  = AT("/", loc_cResto)

        IF loc_nPos2 > 0
            RETURN SUBSTR(loc_cResto, loc_nPos2 + 1)
        ENDIF

        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarTamanhoFolhaComFonte - equivalente a logica do cmdOk.Click legado
    * que remonta "m.ctamfolha" antes do Gather/Update:
    *
    *   If Not Empty(crSigCnFBl.ctamfolha)
    *       If At('/',crSigCnFBl.ctamfolha) = 0
    *           lcTamFolha = Fonte+'/'+SubStr(ctamfolha,1,10)+'/'+SubStr(ctamfolha,11)
    *       Else
    *           ... reaproveita Codigo/Descricao ja presentes, troca so a Fonte
    *       EndIf
    *   Else
    *       lcTamFolha = Fonte+'/'
    *   EndIf
    *
    * par_cTamFolhaAtual chega no formato CRU do GetPaperSize() (10 chars de
    * codigo + descricao, sem "/") na 1a configuracao, ou ja remontado
    * ("Fonte/Codigo/Descricao") nas confirmacoes seguintes.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarTamanhoFolhaComFonte(par_cFonteAtual, par_cTamFolhaAtual)
        LOCAL loc_cTamFolha, loc_cResto, loc_cStringTamFolha, loc_cCodigo, loc_cDescricao

        IF !EMPTY(par_cTamFolhaAtual)
            IF AT("/", par_cTamFolhaAtual) = 0
                loc_cTamFolha = ALLTRIM(par_cFonteAtual) + "/" + ;
                    SUBSTR(par_cTamFolhaAtual, 1, 10) + "/" + SUBSTR(par_cTamFolhaAtual, 11)
            ELSE
                loc_cResto = SUBSTR(par_cTamFolhaAtual, AT("/", par_cTamFolhaAtual) + 1)

                IF AT("/", loc_cResto) > 0
                    loc_cStringTamFolha = loc_cResto
                    loc_cCodigo    = ALLTRIM(SUBSTR(loc_cStringTamFolha, 1, AT("/", loc_cStringTamFolha) - 1))
                    loc_cDescricao = ALLTRIM(SUBSTR(loc_cStringTamFolha, AT("/", loc_cStringTamFolha) + 1))
                    loc_cTamFolha  = ALLTRIM(par_cFonteAtual) + "/" + loc_cCodigo + "/" + loc_cDescricao
                ELSE
                    loc_cTamFolha = ALLTRIM(par_cFonteAtual) + "/"
                ENDIF
            ENDIF
        ELSE
            loc_cTamFolha = ALLTRIM(par_cFonteAtual) + "/"
        ENDIF

        RETURN loc_cTamFolha
    ENDFUNC

    *--------------------------------------------------------------------------
    * Text29LostFocus - valida a impressora ao sair do campo. Transcricao do
    * Valid legado de Text29 (regra CLAUDE.md #17 - transcrever, nao reescrever):
    *
    *   Declare laPrinters[1]
    *   If Aprinters(m.laPrinters)>0
    *       m.llNtem = .t.
    *       For ... If Upper(AllTrim(laPrinters[i,1]))==Upper(AllTrim(This.Value))
    *                   m.llNtem = .f. ... EndIf ... EndFor
    *       If m.llNtem / This.Value = GetPrinter() / EndIf
    *   Else
    *       MessageBox("Nenhuma Impressora Instalada.",0+16)
    *       This.Value = ""
    *   EndIf
    *   This.Refresh
    *
    * O legado NAO tem guard de campo vazio: valor em branco nunca casa com
    * impressora nenhuma, entao llNtem continua .T. e o seletor do Windows
    * abre - eh assim que a tela garante que a configuracao nunca fica sem
    * impressora. O ramo ELSE ("Nenhuma Impressora Instalada.") eh legitimo
    * manter: nao ha picker nesse caminho, logo a regra #50 (nao avisar antes
    * do picker) nao se aplica - e limpar o campo eh o que o legado faz.
    *
    * APRINTERS exige destino declarado como LOCAL ARRAY: medido no VFP9 em
    * 2026-10-17, com LOCAL simples estoura erro 232 "LOC_APRINTERS is not an
    * array" em RUNTIME (o .prg compila limpo). O legado escapava porque usava
    * "Declare laPrinters[1]".
    *--------------------------------------------------------------------------
    PROCEDURE Text29LostFocus()
        IF THIS.this_lEmDialogo
            RETURN
        ENDIF

        THIS.this_lEmDialogo = .T.
        THIS.Text29LostFocusExec()
        THIS.this_lEmDialogo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text29LostFocusExec - corpo do handler acima. Separado para que a guarda
    * de reentrancia seja liberada mesmo quando o corpo sai por RETURN
    * antecipado ou por CATCH (regra CLAUDE.md #47 - flag presa ligada MATA o
    * campo pelo resto da vida do form).
    *--------------------------------------------------------------------------
    PROCEDURE Text29LostFocusExec()
        LOCAL ARRAY loc_aPrinters[1]
        LOCAL loc_cNome, loc_nQtd, loc_nI, loc_lNaoTem, loc_cImpressora, loc_oErro

        TRY
            loc_cNome = ALLTRIM(THIS.txt_4c_Text29.Value)
            loc_nQtd  = APRINTERS(loc_aPrinters)

            IF loc_nQtd > 0
                loc_lNaoTem = .T.

                FOR loc_nI = 1 TO ALEN(loc_aPrinters, 1)
                    IF UPPER(ALLTRIM(loc_aPrinters[loc_nI, 1])) == UPPER(loc_cNome)
                        loc_lNaoTem = .F.
                        EXIT
                    ENDIF
                ENDFOR

                IF loc_lNaoTem
                    *-- Impressora invalida/vazia: seletor de impressoras do
                    *-- Windows. GETPRINTER() devolve "" quando o usuario
                    *-- cancela - nesse caso o campo fica como estava.
                    loc_cImpressora = GETPRINTER()
                    IF !EMPTY(loc_cImpressora)
                        THIS.txt_4c_Text29.Value = loc_cImpressora
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhuma Impressora Instalada.", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Text29.Value = ""
            ENDIF

            THIS.txt_4c_Text29.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Text29LostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Text30LostFocus - valida a fonte padrao ao sair do campo e atualiza o
    * tamanho em Text31. Transcricao do Valid legado de Text30:
    *
    *   ThisForm.LockScreen = .t.
    *   Declare laFonts[1]
    *   = Afont(m.laFonts)
    *   m.llNtem = .t.
    *   For ... If Upper(AllTrim(laFonts[i]))==Upper(AllTrim(This.Value))
    *               m.llNtem = .f. ... EndIf ... EndFor
    *   If m.llNtem
    *       m.lcFonte    = GetFont()
    *       m.lnPos1     = At(",",m.lcFonte,1)
    *       m.lnPos2     = At(",",m.lcFonte,2)
    *       m.nTamFontes = Val(SubStr(m.lcFonte,(m.lnPos1+1),(m.lnPos2-1)))
    *       m.cFontePdrs = Left(m.lcFonte,(m.lnPos1-1))
    *       Select crSigCnFBl
    *       Gather Memvar Fields cFontePdrs,nTamFontes
    *       This.Refresh / ThisForm.Text31.Refresh
    *   EndIf
    *   ThisForm.LockScreen = .f.
    *
    * O "Gather Memvar Fields cFontePdrs,nTamFontes" do legado grava os dois
    * campos no registro corrente; aqui o equivalente eh escrever nos dois
    * controles (Text30/Text31), que o FormParaBO leva ao BO na gravacao.
    *
    * DOIS detalhes medidos no VFP9 em 2026-10-17, ambos defeito no codigo que
    * vinha das fases anteriores:
    *   1. AFONT() devolve LOGICO (.T./.F.), NAO contagem - "IF <logico> > 0"
    *      estoura erro 107 "Operator/operand type mismatch" em RUNTIME. A
    *      contagem vem de ALEN(array, 1), exatamente como o legado faz.
    *   2. AFONT exige destino LOCAL ARRAY (erro 232 com LOCAL simples).
    *--------------------------------------------------------------------------
    PROCEDURE Text30LostFocus()
        IF THIS.this_lEmDialogo
            RETURN
        ENDIF

        THIS.this_lEmDialogo = .T.
        THIS.Text30LostFocusExec()
        THIS.this_lEmDialogo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text30LostFocusExec - corpo do handler acima (ver Text29LostFocusExec
    * para o motivo da separacao). O LockScreen eh reposto em TODOS os
    * caminhos, inclusive depois do CATCH: deixa-lo ligado congela a tela.
    *--------------------------------------------------------------------------
    PROCEDURE Text30LostFocusExec()
        LOCAL ARRAY loc_aFontes[1]
        LOCAL loc_cFonte, loc_nI, loc_lNaoTem, loc_cResultado
        LOCAL loc_nPos1, loc_nPos2, loc_nTam, loc_oErro

        TRY
            THIS.LockScreen = .T.

            loc_cFonte = ALLTRIM(THIS.txt_4c_Text30.Value)
            = AFONT(loc_aFontes)
            loc_lNaoTem = .T.

            FOR loc_nI = 1 TO ALEN(loc_aFontes, 1)
                IF UPPER(ALLTRIM(loc_aFontes[loc_nI])) == UPPER(loc_cFonte)
                    loc_lNaoTem = .F.
                    EXIT
                ENDIF
            ENDFOR

            IF loc_lNaoTem
                *-- Fonte invalida/vazia: seletor de fontes do Windows.
                *-- GETFONT() devolve "Nome,Tamanho,Estilo" (ou "" se cancelar).
                loc_cResultado = GETFONT()

                IF !EMPTY(loc_cResultado)
                    loc_nPos1 = AT(",", loc_cResultado, 1)
                    loc_nPos2 = AT(",", loc_cResultado, 2)

                    IF loc_nPos1 > 0
                        THIS.txt_4c_Text30.Value = LEFT(loc_cResultado, loc_nPos1 - 1)

                        IF loc_nPos2 > loc_nPos1
                            loc_nTam = VAL(SUBSTR(loc_cResultado, loc_nPos1 + 1, ;
                                loc_nPos2 - loc_nPos1 - 1))
                            THIS.txt_4c_Text31.Value = loc_nTam
                        ENDIF

                        THIS.txt_4c_Text30.Refresh()
                        THIS.txt_4c_Text31.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Text30LostFocus")
        ENDTRY

        THIS.LockScreen = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text40LostFocus - tamanho de folha. Transcricao do Valid legado de
    * Text40 (classe fwget):
    *
    *   m.lcTamFolha = ""
    *   If IsEmpty(This.Value)
    *       m.lcTamFolha = GetPaperSize()
    *       If IsEmpty(m.lcTamFolha)
    *           m.lcTamFolha = (Str(256,10)+"Personalizado")
    *       EndIf
    *       This.Value = SubStr(m.lcTamFolha,11)
    *   EndIf
    *   If (Not Eof("crSigCnFBl")) And (Not IsEmpty(m.lcTamFolha))
    *       Replace ctamfolha With m.lcTamFolha In crSigCnFBl
    *   EndIf
    *
    * lcTamFolha so eh preenchido DENTRO do If, entao o Replace acontece
    * apenas quando o campo estava vazio - comportamento reproduzido aqui.
    * GetPaperSize() devolve codigo(10 chars) + descricao SEM separador: o
    * TextBox exibe so a descricao (SUBSTR a partir de 11) e o composto CRU
    * inteiro vai para this_cTamfolha (equivalente ao Replace no cursor);
    * MontarTamanhoFolhaComFonte, chamado no Confirmar, eh quem acrescenta a
    * Fonte e os separadores na gravacao final.
    *
    * O fallback STR(256,10)+"Personalizado" (256 = DMPAPER_USER) eh
    * OBRIGATORIO e faltava: sem ele, impressora sem papel reportado deixa o
    * campo vazio para sempre e o dialogo reabre a cada saida do campo.
    * Medido no VFP9: SUBSTR(STR(256,10)+"Personalizado", 11) = "Personalizado".
    *
    * GetPaperSize() NAO eh funcao nativa do VFP9 nem veio no acervo legado -
    * foi definida como wrapper de contrato em utils\functions.prg (regra
    * CLAUDE.md #13/#27); sem ela a chamada estoura "File
    * getpapersize.prg does not exist" em RUNTIME.
    *--------------------------------------------------------------------------
    PROCEDURE Text40LostFocus()
        IF THIS.this_lEmDialogo
            RETURN
        ENDIF

        THIS.this_lEmDialogo = .T.
        THIS.Text40LostFocusExec()
        THIS.this_lEmDialogo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Text40LostFocusExec - corpo do handler acima (ver Text29LostFocusExec
    * para o motivo da separacao).
    *--------------------------------------------------------------------------
    PROCEDURE Text40LostFocusExec()
        LOCAL loc_cTam, loc_oErro

        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Text40.Value))
                loc_cTam = GetPaperSize()

                IF EMPTY(loc_cTam)
                    loc_cTam = STR(256, 10) + "Personalizado"
                ENDIF

                THIS.txt_4c_Text40.Value = SUBSTR(loc_cTam, 11)

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_cTamfolha = loc_cTam
                ENDIF

                THIS.txt_4c_Text40.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Text40LostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - equivalente ao cmdOk.Click (Command1) do legado:
    *
    *   ThisForm.LockScreen = .t.
    *   If MessageBox("Confirma a Configuracao do Boleto?",32+4,...)==6
    *       ... remonta m.ctamfolha (Fonte+Codigo+Descricao)
    *       ... Gather dDatas,cHoras,cUsuarios,ctamfolha / Update / Commit
    *       ... Update SigCqMat Set ctamanho=<ctamfolha> (quando ha registro)
    *       ThisForm.Release
    *   Else
    *       ThisForm.Text1.SetFocus
    *   EndIf
    *   ThisForm.LockScreen = .f.
    *
    * THIS.FormParaBO() ja transfere TODOS os campos do boleto
    * (Text1..Text31); this_cTamfolha eh remontado aqui com
    * MontarTamanhoFolhaComFonte (regra CLAUDE.md #17 - formula do legado
    * transcrita literalmente, nunca reescrita) antes de Salvar().
    *
    * Cada falha do legado faz "Return 0" SEM Release - a tela fica aberta com
    * os dados na mao do usuario. Reproduzido aqui: Release() so acontece
    * quando Salvar() E SincronizarTamanhoFolhaSigCqMat() tiverem sucesso.
    *
    * FALHA NUNCA EH MUDA (regra CLAUDE.md #20): BusinessBase.Salvar() ja
    * chama ExibirFalha()/MsgErro() em todo caminho de recusa - por isso nao
    * ha ELSE no IF Salvar(). SincronizarTamanhoFolhaSigCqMat ja exibe a
    * mensagem do legado ("Favor Reinicializar o Processo!!!") quando falha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro, loc_lSucesso, loc_cTamFolha, loc_lLiberou

        loc_lLiberou = .F.

        TRY
            THIS.LockScreen = .T.

            IF MsgConfirma("Confirma a Configura" + CHR(231) + CHR(227) + "o do Boleto?", ;
                    "Confirma" + CHR(231) + CHR(227) + "o")

                THIS.FormParaBO()

                loc_cTamFolha = THIS.MontarTamanhoFolhaComFonte(THIS.txt_4c_Text30.Value, ;
                    THIS.this_oBusinessObject.this_cTamfolha)
                THIS.this_oBusinessObject.this_cTamfolha = loc_cTamFolha

                loc_lSucesso = THIS.this_oBusinessObject.Salvar()

                IF loc_lSucesso
                    loc_lSucesso = THIS.this_oBusinessObject.SincronizarTamanhoFolhaSigCqMat(loc_cTamFolha)
                ENDIF

                IF loc_lSucesso
                    *-- LockScreen reposto ANTES do Release: depois dele nao se
                    *-- toca mais no form (loc_lLiberou impede o reset final).
                    THIS.LockScreen = .F.
                    loc_lLiberou = .T.
                    THIS.Release()
                ENDIF
            ELSE
                THIS.txt_4c_Text1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnConfirmarClick")
        ENDTRY

        *-- Reposto em TODO caminho que NAO liberou o form (recusa na
        *-- confirmacao, falha na gravacao, CATCH): LockScreen ligado congela
        *-- a tela. No caminho do Release o reset ja aconteceu antes dele.
        IF !loc_lLiberou
            THIS.LockScreen = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - equivalente ao cmdCancelar.Click (Command2) do legado:
    *
    *   ThisForm.LockScreen = .t.
    *   If Messagebox("Deseja Abandonar as Alteracoes Realizadas?",4+32+256,...)==6
    *       ThisForm.Release
    *   EndIf
    *
    * Unico caminho de saida da tela (form OPERACIONAL flat, sem Page2/Dados
    * para "cancelar a edicao" - abandonar aqui EH fechar). O nome segue o
    * objeto do legado, cmdCancelar; o CommandButton que o dispara chama-se
    * cmd_4c_Encerrar porque "Encerrar" eh a Caption que o SCX declara em
    * Command2 (regra PILAR 1 - a legenda eh a do legado).
    *
    * Recusar a confirmacao mantem a tela aberta, igual ao legado (nao ha
    * ELSE no If dele).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LockScreen = .T.

        IF MsgConfirma("Deseja Abandonar as Altera" + CHR(231) + CHR(245) + "es Realizadas?", ;
                "Confirma" + CHR(231) + CHR(227) + "o")
            THIS.LockScreen = .F.
            THIS.Release()
        ELSE
            THIS.LockScreen = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - o MESMO botao, pelo outro nome que ele tem.
    *
    * O objeto do SCX legado tem duas identidades: Name = "cmdCancelar" (de
    * onde sai BtnCancelarClick, que guarda o corpo transcrito do Click) e
    * Caption = "Encerrar" (de onde sai o nome do controle migrado,
    * cmd_4c_Encerrar, e este metodo). Nao ha dois comportamentos: esta tela
    * eh FLAT, sem Page2/modo de edicao, entao "abandonar as alteracoes" e
    * "encerrar" sao a mesma acao - por isso aqui se DELEGA em vez de
    * duplicar a logica (dois corpos iguais divergiriam na primeira mudanca).
    *
    * Os dois nomes existem porque as duas convencoes do projeto apontam para
    * identidades diferentes do mesmo objeto: 88 dos 112 forms OPERACIONAIS
    * declaram os dois, e o harness TesteAutomatico.prg procura justamente por
    * BtnEncerrarClick/BtnFecharClick/BtnSairClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis apos
    * AddObject (que os cria com Visible=.F. por padrao). Percorre Pages de
    * PageFrame e Controls de Container recursivamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - DODEFAULT() libera this_oBusinessObject e restaura o menu
    * principal (FormBase.Destroy). Regra CLAUDE.md #145: DODEFAULT() sempre
    * como ultima linha do override.
    *
    * Equivalente ao "PROCEDURE Release" do legado
    * ("ThisForm.poDataMgr.Release" + "=DoDefault()"): o poDataMgr era o
    * gerenciador de conexao/cursores do Framework Fortyus, substituido pela
    * dupla BO + DataAccess - quem libera o BO eh FormBase.Destroy, via o
    * DODEFAULT() abaixo. Os cursores desta tela (cursor_4c_Dados,
    * cursor_4c_SigCqMat) sao fechados pelo proprio SigOpCblBO no fim de cada
    * metodo que os abre, por isso nao ha USE IN aqui.
    *
    * O "PROCEDURE Load" do legado ("=fConfigGeral()") NAO tem equivalente
    * neste form de proposito: fConfigGeral era a inicializacao global da
    * aplicacao legado, que na arquitetura nova acontece ANTES, em
    * start\config.prg (SETs, paths, variaveis globais) e start\main.prg
    * (conexao, empresa). O utils\fconfiggeral.prg existe APENAS como wrapper
    * para o p-code dos VCX legado e o proprio arquivo documenta que codigo
    * NOSSO nunca deve chama-lo (regra CLAUDE.md #27).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
