*==============================================================================
* FormTpt.prg - Formulario de Cadastro de Tipos de Transporte
* Migrado de: SigCdTpt.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormTpt AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Transportes"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TptBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TptBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTpt.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTpt:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTpt.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 com Grid e botoes CRUD completos
    * Colunas do grid: codigos, descrs, extensao (cursor_4c_Dados do TptBO.Buscar)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
        *-- Original: Top=1. Com compensacao +29: Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado: Inserir/Consultar/Alterar/Excluir/procurar)
        *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5) - legado: Inserir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80) - legado: Consultar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305) - legado: procurar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
        *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem de tipos de transporte (Grade no legado)
        *-- Original: Grade.Top=133, Left=32, Width=736, Height=433, FontName=Tahoma, FontSize=8, ForeColor=90,90,90
        *-- Com compensacao PageFrame +29: Top=162
        *-- Colunas do legado (Init/pColuna): Codigos, Descrs, Extensao
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 162
            .Left               = 32
            .Width              = 736
            .Height             = 433
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (estrutura base)
    * TextBoxes de dados sao adicionados nas Fases 5-6
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- ==========================================================================
        *-- CAMPOS PRINCIPAIS (FASE 5/8 - primeira metade da Pagina.Dados)
        *-- Transcrito de tasks\task546\layout.json (SIGCDTPT.Pagina.Dados)
        *-- Compensacao PageFrame +29 aplicada a TODOS os Top
        *-- ==========================================================================

        *-- Codigo (getCodigos / Say1 "Codigo :") - PK char(6)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 164
            .Left      = 90
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top       = 161
            .Left      = 140
            .Width     = 52
            .Height    = 23
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Descricao (getDescrs / Say4 "Descricao :") - char(20)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 189
            .Left      = 74
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Top       = 186
            .Left      = 140
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Extensao (getExtens / Say3 "Tipo de Extensao do Arquivo :") - char(3)
        *-- Say3 nao declara Width no SCX legado (classe say pura, regra #23) - largura calculada p/ caber o texto
        loc_oPagina.AddObject("lbl_4c_Extensao", "Label")
        WITH loc_oPagina.lbl_4c_Extensao
            .Caption   = "Tipo de Extens" + CHR(227) + "o do Arquivo :"
            .Top       = 189
            .Left      = 338
            .Width     = 145
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Extensao", "TextBox")
        WITH loc_oPagina.txt_4c_Extensao
            .Top       = 186
            .Left      = 489
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Shape3 - moldura ao redor de Proximo Transporte / Proximo Recebe / Transporte Ok
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top         = 193
            .Left        = 554
            .Width       = 172
            .Height      = 48
            .BackStyle   = 0
            .BorderWidth = 1
            .BorderColor = RGB(0, 0, 0)
            .Visible     = .T.
        ENDWITH

        *-- No. Transporte Ok (Get_ClrArqOks / Say10) - numeric(3,0)
        loc_oPagina.AddObject("lbl_4c_TransporteOk", "Label")
        WITH loc_oPagina.lbl_4c_TransporteOk
            .Caption   = "No. Transporte Ok :"
            .Top       = 214
            .Left      = 387
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_TransporteOk", "TextBox")
        WITH loc_oPagina.txt_4c_TransporteOk
            .Top        = 211
            .Left       = 489
            .Width      = 31
            .Height     = 23
            .InputMask  = "999"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Value      = 0
            .Visible    = .T.
        ENDWITH

        *-- Proximo Transporte / Proximo Recebe (Get_Transp / get_Recebe) - dentro do shp_4c_Shape3
        loc_oPagina.AddObject("lbl_4c_ProxTransporte", "Label")
        WITH loc_oPagina.lbl_4c_ProxTransporte
            .Caption   = "Pr" + CHR(243) + "x.Transp."
            .Top       = 198
            .Left      = 565
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ProxTransporte", "TextBox")
        WITH loc_oPagina.txt_4c_ProxTransporte
            .Top       = 213
            .Left      = 571
            .Width     = 58
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_ProxRecebe", "Label")
        WITH loc_oPagina.lbl_4c_ProxRecebe
            .Caption   = "Pr" + CHR(243) + "x.Recebe"
            .Top       = 197
            .Left      = 643
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ProxRecebe", "TextBox")
        WITH loc_oPagina.txt_4c_ProxRecebe
            .Top       = 212
            .Left      = 647
            .Width     = 58
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Nao Checar Sequencia de Recepcao (chkSeqnum) - bit
        loc_oPagina.AddObject("chk_4c_NaoChecarSequencia", "CheckBox")
        WITH loc_oPagina.chk_4c_NaoChecarSequencia
            .Caption   = "N" + CHR(227) + "o Checar Sequ" + CHR(234) + "ncia de Recep" + CHR(231) + CHR(227) + "o"
            .Top       = 214
            .Left      = 140
            .Width     = 222
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Executar Muda Conta na Recepcao dos Dados (fwcheckbox1) - numeric(1,0), tratado como logico
        loc_oPagina.AddObject("chk_4c_ExecutarMudaConta", "CheckBox")
        WITH loc_oPagina.chk_4c_ExecutarMudaConta
            .Caption   = "Executar Muda Conta na Recepcao dos Dados"
            .Top       = 234
            .Left      = 140
            .Width     = 240
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Shape2 - linha divisoria acima da secao "Configuracao do Transporte"
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top          = 256
            .Left         = 79
            .Width        = 615
            .Height       = 2
            .BackStyle    = 0
            .SpecialEffect = 1
            .Visible      = .T.
        ENDWITH

        *-- Titulo da secao "Configuracao do Transporte" (Say7)
        loc_oPagina.AddObject("lbl_4c_TituloTransporte", "Label")
        WITH loc_oPagina.lbl_4c_TituloTransporte
            .Caption   = " Configura" + CHR(231) + CHR(227) + "o do Transporte"
            .Top       = 257
            .Left      = 104
            .Width     = 187
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Geracao / Transporte (Get_Geracao / Say2 "Transporte :") - drivets char(60)
        loc_oPagina.AddObject("lbl_4c_Transporte", "Label")
        WITH loc_oPagina.lbl_4c_Transporte
            .Caption   = "Transporte :"
            .Top       = 280
            .Left      = 142
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Geracao", "TextBox")
        WITH loc_oPagina.txt_4c_Geracao
            .Top       = 277
            .Left      = 208
            .Width     = 430
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Leitura (Get_Leitura / Say25) - drivels char(60)
        loc_oPagina.AddObject("lbl_4c_Leitura", "Label")
        WITH loc_oPagina.lbl_4c_Leitura
            .Caption   = "Leitura :"
            .Top       = 305
            .Left      = 162
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Leitura", "TextBox")
        WITH loc_oPagina.txt_4c_Leitura
            .Top       = 302
            .Left      = 208
            .Width     = 430
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Recepcao (Get_Recepcao / Say26) - drivers char(60)
        loc_oPagina.AddObject("lbl_4c_Recepcao", "Label")
        WITH loc_oPagina.lbl_4c_Recepcao
            .Caption   = "Recep" + CHR(231) + CHR(227) + "o :"
            .Top       = 330
            .Left      = 148
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Recepcao", "TextBox")
        WITH loc_oPagina.txt_4c_Recepcao
            .Top       = 327
            .Left      = 208
            .Width     = 430
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Arquivar (get_Arquivar / Say15) - paths char(60)
        loc_oPagina.AddObject("lbl_4c_Arquivar", "Label")
        WITH loc_oPagina.lbl_4c_Arquivar
            .Caption   = "Arquivar :"
            .Top       = 355
            .Left      = 154
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Arquivar", "TextBox")
        WITH loc_oPagina.txt_4c_Arquivar
            .Top       = 352
            .Left      = 208
            .Width     = 430
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- ==========================================================================
        *-- CAMPOS RESTANTES (FASE 6/8 - segunda metade da Pagina.Dados)
        *-- Transcrito de tasks\task546\layout.json (SIGCDTPT.Pagina.Dados)
        *-- Compensacao PageFrame +29 aplicada a TODOS os Top
        *-- ==========================================================================

        *-- Shape1 - linha divisoria acima da secao "Configuracao da Area do FTP"
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top          = 390
            .Left         = 79
            .Width        = 615
            .Height       = 2
            .BackStyle    = 0
            .SpecialEffect = 1
            .Visible      = .T.
        ENDWITH

        *-- Titulo da secao "Configuracao da Area do FTP" (Say12)
        loc_oPagina.AddObject("lbl_4c_TituloFtp", "Label")
        WITH loc_oPagina.lbl_4c_TituloFtp
            .Caption   = " Configura" + CHR(231) + CHR(227) + "o da " + CHR(193) + "rea do FTP "
            .Top       = 392
            .Left      = 104
            .Width     = 194
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Tipo de Conexao (Get_tpconexao / Say5 "Tipo de Conexao :") - char(1) D/B
        loc_oPagina.AddObject("lbl_4c_TipoConexao", "Label")
        WITH loc_oPagina.lbl_4c_TipoConexao
            .Caption   = "Tipo de Conex" + CHR(227) + "o :"
            .Top       = 417
            .Left      = 115
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_TipoConexao", "TextBox")
        WITH loc_oPagina.txt_4c_TipoConexao
            .Top       = 413
            .Left      = 208
            .Width     = 28
            .Height    = 23
            .MaxLength = 1
            .Format    = "!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say19 "(D/B) Dial-Up / Banda Larga" - nota explicativa em negrito
        loc_oPagina.AddObject("lbl_4c_NotaConexao", "Label")
        WITH loc_oPagina.lbl_4c_NotaConexao
            .Caption   = "(D/B) Dial-Up / Banda Larga"
            .Top       = 416
            .Left      = 239
            .Width     = 159
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Endereco FTP (Get_ftpend / Say6) - ftpend char(50)
        loc_oPagina.AddObject("lbl_4c_FtpEndereco", "Label")
        WITH loc_oPagina.lbl_4c_FtpEndereco
            .Caption   = "Endere" + CHR(231) + CHR(227) + "o FTP :"
            .Top       = 440
            .Left      = 130
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_FtpEndereco", "TextBox")
        WITH loc_oPagina.txt_4c_FtpEndereco
            .Top       = 438
            .Left      = 208
            .Width     = 330
            .Height    = 23
            .MaxLength = 50
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Nome do Usuario FTP (Get_ftpusuario / Say8) - ftpusuario char(30)
        loc_oPagina.AddObject("lbl_4c_FtpUsuario", "Label")
        WITH loc_oPagina.lbl_4c_FtpUsuario
            .Caption   = "Nome do Usu" + CHR(225) + "rio :"
            .Top       = 465
            .Left      = 115
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_FtpUsuario", "TextBox")
        WITH loc_oPagina.txt_4c_FtpUsuario
            .Top       = 463
            .Left      = 208
            .Width     = 160
            .Height    = 23
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Senha do Usuario FTP (Get_ftpsenha / Say13) - ftpsenha char(20), PasswordChar
        loc_oPagina.AddObject("lbl_4c_FtpSenha", "Label")
        WITH loc_oPagina.lbl_4c_FtpSenha
            .Caption   = "Senha do Usu" + CHR(225) + "rio :"
            .Top       = 491
            .Left      = 112
            .Width     = 93
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ftpsenha", "TextBox")
        WITH loc_oPagina.txt_4c_Ftpsenha
            .Top          = 488
            .Left         = 208
            .Width        = 130
            .Height       = 23
            .MaxLength    = 20
            .PasswordChar = "*"
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Value        = ""
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Ftpsenha, "KeyPress", THIS, "ValidarFtpSenha")

        *-- Redigita (Get_senha2 / Say14) - confirmacao da senha, NAO gravada (ControlSource vazio no legado)
        loc_oPagina.AddObject("lbl_4c_Redigita", "Label")
        WITH loc_oPagina.lbl_4c_Redigita
            .Caption   = "Redigita :"
            .Top       = 491
            .Left      = 353
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Senha2", "TextBox")
        WITH loc_oPagina.txt_4c_Senha2
            .Top          = 488
            .Left         = 408
            .Width        = 130
            .Height       = 23
            .MaxLength    = 20
            .PasswordChar = "*"
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Value        = ""
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Senha2, "KeyPress", THIS, "ValidarSenha2")

        *-- Pasta para Envio no FTP (Get_dirftpts / Say9) - dirftpts char(60)
        loc_oPagina.AddObject("lbl_4c_DirFtpEnvio", "Label")
        WITH loc_oPagina.lbl_4c_DirFtpEnvio
            .Caption   = "Pasta para Envio :"
            .Top       = 515
            .Left      = 115
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DirFtpEnvio", "TextBox")
        WITH loc_oPagina.txt_4c_DirFtpEnvio
            .Top       = 513
            .Left      = 208
            .Width     = 330
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Pasta para Recepcao no FTP (Get_dirftpls / Say11) - dirftpls char(60)
        loc_oPagina.AddObject("lbl_4c_DirFtpRecepcao", "Label")
        WITH loc_oPagina.lbl_4c_DirFtpRecepcao
            .Caption   = "Pasta para Recep" + CHR(231) + CHR(227) + "o :"
            .Top       = 540
            .Left      = 94
            .Width     = 111
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DirFtpRecepcao", "TextBox")
        WITH loc_oPagina.txt_4c_DirFtpRecepcao
            .Top       = 538
            .Left      = 208
            .Width     = 330
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Limpa diretorio de envio (chklocdel) - locdel bit
        loc_oPagina.AddObject("chk_4c_LimpaDirLocal", "CheckBox")
        WITH loc_oPagina.chk_4c_LimpaDirLocal
            .Caption   = "Limpa diret" + CHR(243) + "rio de envio"
            .Top       = 565
            .Left      = 208
            .Width     = 160
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Limpa diretorio do FTP (chkftpdel) - ftpdel bit
        loc_oPagina.AddObject("chk_4c_LimpaDirFtp", "CheckBox")
        WITH loc_oPagina.chk_4c_LimpaDirFtp
            .Caption   = "Limpa diret" + CHR(243) + "rio do FTP"
            .Top       = 565
            .Left      = 386
            .Width     = 160
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Container BotoesAcao (Grupo_Salva legado) - Confirmar/Cancelar
        *-- Com compensacao PageFrame +29: Top=33 (4+29), Left=842
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva no legado, Left=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Left=80)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
    * OBRIGATORIO: ControlSource e Headers APOS RecordSource (Problema 2/48)
    * PUBLIC: chamado diretamente pelo TesteAutomatico.prg (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount  = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.extensao"

                loc_oGrid.Column1.Width = 100
                loc_oGrid.Column2.Width = 430
                loc_oGrid.Column3.Width = 120

                *-- Headers APOS RecordSource (OBRIGATORIO) - captions EXATOS do pColuna legado
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Extens" + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTpt.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    * PUBLIC: chamado diretamente pelo TesteAutomatico.prg (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "FormTpt.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara Page2 para inclusao de novo registro
    * PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3 CLAUDE.md) e
    * exigido pelo BINDEVENT do botao (Problema 17)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17); tambem chamado
    * pelo DblClick da grade
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione Um Tipo de Transporte Na Grade!!!")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar o registro selecionado na grade
    * PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3 CLAUDE.md) e
    * exigido pelo BINDEVENT do botao (Problema 17)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione Um Tipo de Transporte Na Grade!!!")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado na grade, com confirmacao
    * this_lErroExibido evita repetir a mensagem: BusinessBase.Excluir() ja
    * chama ExibirFalha() em todo caminho de falha (regra #20 CLAUDE.md)
    * PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3 CLAUDE.md) e
    * exigido pelo BINDEVENT do botao (Problema 17)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione Um Tipo de Transporte Na Grade!!!")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do Tipo de Transporte [" + loc_cCodigo + "] ?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
                        THIS.CarregarLista()
                    ELSE
                        IF !THIS.this_oBusinessObject.this_lErroExibido
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar um Tipo de
    * Transporte pelo codigo e posiciona a grade da Page1 no registro
    * encontrado. PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3
    * CLAUDE.md) e exigido pelo BINDEVENT do botao (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrTrn", "cursor_4c_BuscaTpt", "codigos", "", ;
                "Buscar Tipo de Transporte")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpt")
                    SELECT cursor_4c_BuscaTpt
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaTpt.codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTpt")
                USE IN cursor_4c_BuscaTpt
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar tipo de transporte:" + CHR(13) + loException.Message, ;
                "FormTpt.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: exigido pelo BINDEVENT do botao (Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os valores dos controles da Page2 para o
    * BusinessObject. txt_4c_Senha2 (redigita) NUNCA e transferido - e apenas
    * confirmacao de digitacao, sem ControlSource no legado (comentario em
    * ConfigurarPaginaDados)
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oBO.this_cCodigo             = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        loc_oBO.this_cDescricao          = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        loc_oBO.this_cExtensao           = ALLTRIM(loc_oPagina.txt_4c_Extensao.Value)
        loc_oBO.this_nTransporteOk       = loc_oPagina.txt_4c_TransporteOk.Value
        loc_oBO.this_nProximoTransporte  = loc_oPagina.txt_4c_ProxTransporte.Value
        loc_oBO.this_nProximoRecebe      = loc_oPagina.txt_4c_ProxRecebe.Value
        loc_oBO.this_lNaoChecarSequencia = loc_oPagina.chk_4c_NaoChecarSequencia.Value
        loc_oBO.this_lExecutarMudaConta  = loc_oPagina.chk_4c_ExecutarMudaConta.Value
        loc_oBO.this_cGeracao            = ALLTRIM(loc_oPagina.txt_4c_Geracao.Value)
        loc_oBO.this_cLeitura            = ALLTRIM(loc_oPagina.txt_4c_Leitura.Value)
        loc_oBO.this_cRecepcao           = ALLTRIM(loc_oPagina.txt_4c_Recepcao.Value)
        loc_oBO.this_cArquivar           = ALLTRIM(loc_oPagina.txt_4c_Arquivar.Value)
        loc_oBO.this_cTipoConexao        = ALLTRIM(loc_oPagina.txt_4c_TipoConexao.Value)
        loc_oBO.this_cFtpEndereco        = ALLTRIM(loc_oPagina.txt_4c_FtpEndereco.Value)
        loc_oBO.this_cFtpUsuario         = ALLTRIM(loc_oPagina.txt_4c_FtpUsuario.Value)
        loc_oBO.this_cFtpSenha           = ALLTRIM(loc_oPagina.txt_4c_Ftpsenha.Value)
        loc_oBO.this_cDirFtpEnvio        = ALLTRIM(loc_oPagina.txt_4c_DirFtpEnvio.Value)
        loc_oBO.this_cDirFtpRecepcao     = ALLTRIM(loc_oPagina.txt_4c_DirFtpRecepcao.Value)
        loc_oBO.this_lLimpaDirLocal      = loc_oPagina.chk_4c_LimpaDirLocal.Value
        loc_oBO.this_lLimpaDirFtp        = loc_oPagina.chk_4c_LimpaDirFtp.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BusinessObject para os controles
    * da Page2. txt_4c_Senha2 (redigita) NUNCA e carregado do BO - e apenas
    * confirmacao de digitacao, sem ControlSource no legado (comentario em
    * ConfigurarPaginaDados)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oPagina.txt_4c_Codigo.Value             = loc_oBO.this_cCodigo
        loc_oPagina.txt_4c_Descricao.Value          = loc_oBO.this_cDescricao
        loc_oPagina.txt_4c_Extensao.Value           = loc_oBO.this_cExtensao
        loc_oPagina.txt_4c_TransporteOk.Value       = loc_oBO.this_nTransporteOk
        loc_oPagina.txt_4c_ProxTransporte.Value     = loc_oBO.this_nProximoTransporte
        loc_oPagina.txt_4c_ProxRecebe.Value         = loc_oBO.this_nProximoRecebe
        loc_oPagina.chk_4c_NaoChecarSequencia.Value = loc_oBO.this_lNaoChecarSequencia
        loc_oPagina.chk_4c_ExecutarMudaConta.Value  = loc_oBO.this_lExecutarMudaConta
        loc_oPagina.txt_4c_Geracao.Value            = loc_oBO.this_cGeracao
        loc_oPagina.txt_4c_Leitura.Value            = loc_oBO.this_cLeitura
        loc_oPagina.txt_4c_Recepcao.Value           = loc_oBO.this_cRecepcao
        loc_oPagina.txt_4c_Arquivar.Value           = loc_oBO.this_cArquivar
        loc_oPagina.txt_4c_TipoConexao.Value        = loc_oBO.this_cTipoConexao
        loc_oPagina.txt_4c_FtpEndereco.Value        = loc_oBO.this_cFtpEndereco
        loc_oPagina.txt_4c_FtpUsuario.Value         = loc_oBO.this_cFtpUsuario
        loc_oPagina.txt_4c_Ftpsenha.Value           = loc_oBO.this_cFtpSenha
        loc_oPagina.txt_4c_Senha2.Value             = ""
        loc_oPagina.txt_4c_DirFtpEnvio.Value        = loc_oBO.this_cDirFtpEnvio
        loc_oPagina.txt_4c_DirFtpRecepcao.Value     = loc_oBO.this_cDirFtpRecepcao
        loc_oPagina.chk_4c_LimpaDirLocal.Value      = loc_oBO.this_lLimpaDirLocal
        loc_oPagina.chk_4c_LimpaDirFtp.Value        = loc_oBO.this_lLimpaDirFtp
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos editaveis da Page2
    * Codigo (PK) so fica editavel em modo INCLUIR. txt_4c_ProxTransporte e
    * txt_4c_ProxRecebe sao sempre somente-leitura (sequencia calculada,
    * sem Valid no legado - apenas tracking peAntvalue no When)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lCodEditavel
        loc_oPagina     = THIS.pgf_4c_Paginas.Page2
        loc_lCodEditavel = (THIS.this_cModoAtual = "INCLUIR")

        loc_oPagina.txt_4c_Codigo.Enabled              = par_lHabilitar AND loc_lCodEditavel
        loc_oPagina.txt_4c_Descricao.Enabled           = par_lHabilitar
        loc_oPagina.txt_4c_Extensao.Enabled            = par_lHabilitar
        loc_oPagina.txt_4c_TransporteOk.Enabled        = par_lHabilitar
        loc_oPagina.txt_4c_ProxTransporte.Enabled      = .F.
        loc_oPagina.txt_4c_ProxRecebe.Enabled          = .F.
        loc_oPagina.chk_4c_NaoChecarSequencia.Enabled  = par_lHabilitar
        loc_oPagina.chk_4c_ExecutarMudaConta.Enabled   = par_lHabilitar
        loc_oPagina.txt_4c_Geracao.Enabled             = par_lHabilitar
        loc_oPagina.txt_4c_Leitura.Enabled             = par_lHabilitar
        loc_oPagina.txt_4c_Recepcao.Enabled            = par_lHabilitar
        loc_oPagina.txt_4c_Arquivar.Enabled            = par_lHabilitar
        loc_oPagina.txt_4c_TipoConexao.Enabled         = par_lHabilitar
        loc_oPagina.txt_4c_FtpEndereco.Enabled         = par_lHabilitar
        loc_oPagina.txt_4c_FtpUsuario.Enabled          = par_lHabilitar
        loc_oPagina.txt_4c_Ftpsenha.Enabled            = par_lHabilitar
        loc_oPagina.txt_4c_Senha2.Enabled              = par_lHabilitar
        loc_oPagina.txt_4c_DirFtpEnvio.Enabled         = par_lHabilitar
        loc_oPagina.txt_4c_DirFtpRecepcao.Enabled      = par_lHabilitar
        loc_oPagina.chk_4c_LimpaDirLocal.Enabled       = par_lHabilitar
        loc_oPagina.chk_4c_LimpaDirFtp.Enabled         = par_lHabilitar
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 para um novo registro
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value             = ""
        loc_oPagina.txt_4c_Descricao.Value          = ""
        loc_oPagina.txt_4c_Extensao.Value           = ""
        loc_oPagina.txt_4c_TransporteOk.Value       = 0
        loc_oPagina.txt_4c_ProxTransporte.Value     = 0
        loc_oPagina.txt_4c_ProxRecebe.Value         = 0
        loc_oPagina.chk_4c_NaoChecarSequencia.Value = 0
        loc_oPagina.chk_4c_ExecutarMudaConta.Value  = 0
        loc_oPagina.txt_4c_Geracao.Value            = ""
        loc_oPagina.txt_4c_Leitura.Value            = ""
        loc_oPagina.txt_4c_Recepcao.Value           = ""
        loc_oPagina.txt_4c_Arquivar.Value           = ""
        loc_oPagina.txt_4c_TipoConexao.Value        = ""
        loc_oPagina.txt_4c_FtpEndereco.Value        = ""
        loc_oPagina.txt_4c_FtpUsuario.Value         = ""
        loc_oPagina.txt_4c_Ftpsenha.Value           = ""
        loc_oPagina.txt_4c_Senha2.Value             = ""
        loc_oPagina.txt_4c_DirFtpEnvio.Value        = ""
        loc_oPagina.txt_4c_DirFtpRecepcao.Value     = ""
        loc_oPagina.chk_4c_LimpaDirLocal.Value      = 0
        loc_oPagina.chk_4c_LimpaDirFtp.Value        = 0
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma a gravacao de Page2 (Incluir/Alterar)
    * PUBLIC: BINDEVENT requer metodo publico. Salvar() SEM parametro - o BO
    * decide INSERT/UPDATE por this_lNovoRegistro (regra #4 do guia).
    * Falha de gravacao ja e reportada pelo BusinessBase (regra #20 CLAUDE.md).
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao/visualizacao e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico.
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta o botao Confirmar conforme o modo atual
    * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
    * PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao, loc_lEditando
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
        loc_lEditando   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormTpt.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarFtpSenha - LostFocus para txt_4c_Ftpsenha. Reproduz o Valid legado:
    * codifica o valor digitado usando fDecriptografar() (funcao do Framework
    * legado Fortyus que, apesar do nome, CODIFICA o valor para gravacao - mesmo
    * padrao ja adotado em FormTme.prg).
    * PUBLIC: obrigatorio para funcionar com BINDEVENT (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE ValidarFtpSenha(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)

        IF !EMPTY(loc_cValor)
            loc_oPg2.txt_4c_Ftpsenha.Value = fDecriptografar(loc_cValor)
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarSenha2 - LostFocus para txt_4c_Senha2 (campo "Redigita"). Reproduz
    * o Valid legado: compara a senha ja codificada de txt_4c_Ftpsenha com a
    * codificacao do valor redigitado. Se nao conferir, pergunta se o usuario
    * deseja continuar com a senha em branco:
    *   - Confirmou (Sim): limpa AMBOS os campos (senha + redigita)
    *   - Recusou (Nao): limpa apenas o campo de redigita
    * PUBLIC: obrigatorio para funcionar com BINDEVENT (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE ValidarSenha2(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cSenhaCodificada, loc_cRedigitaCodificada

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value))
            loc_cSenhaCodificada    = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
            loc_cRedigitaCodificada = fDecriptografar(ALLTRIM(loc_oPg2.txt_4c_Senha2.Value))

            IF loc_cSenhaCodificada != loc_cRedigitaCodificada
                IF MsgConfirma("A Senha N" + CHR(227) + "o Confere!!! Deseja Continuar Com a Senha em Branco ?", ;
                        "Erro na Confirma" + CHR(231) + CHR(227) + "o da Senha...")
                    *-- Confirmou: limpa senha + redigita
                    loc_oPg2.txt_4c_Ftpsenha.Value = ""
                    loc_oPg2.txt_4c_Senha2.Value    = ""
                ELSE
                    *-- Recusou: limpa apenas a redigita
                    loc_oPg2.txt_4c_Senha2.Value = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
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

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
