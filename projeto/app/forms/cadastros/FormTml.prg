*==============================================================================
* FormTml.prg - Formulario de Cadastro de Tipos de Material
* Migrado de: SigCdTml.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormTml AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Tipos de Material"
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

    *-- Guardas anti-repeticao para LostFocus (Problema 45: LostFocus dispara
    *-- sempre, ao contrario de Valid que so dispara quando o valor muda)
    this_cUltimoGrupo  = ""
    this_cUltimaConta  = ""

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
            THIS.this_oBusinessObject = CREATEOBJECT("TmlBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TmlBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTml.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF PEMSTATUS(THIS, "CarregarLista", 5)
                        THIS.CarregarLista()
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTml:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTml.InicializarForm")
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
    * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD (Grupo_op/Grupo_Saida
    * no legado) + Grid de listagem
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=339, Top=-1, Width=389, Height=85)
        *-- Canonico: Left=542, Top=29, Width=390, Height=85 (lado DIREITO)
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

        *-- Botao Incluir (legado: Inserir, Left=5)
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

        *-- Botao Visualizar (legado: Consultar, Left=81)
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

        *-- Botao Alterar (legado: Alterar, Left=157)
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

        *-- Botao Excluir (legado: Excluir, Left=233)
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

        *-- Botao Buscar (legado: procurar, Left=309)
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

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado: Grupo_Saida.Left=719, Top=-1)
        *-- CLAUDE.md regra #10: Left=917, Top=29, Width=90, Height=85
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

        *-- Botao Encerrar (legado: Sair) - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
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

        *-- Grid de listagem (legado: Grade Top=121, Left=11, FontName=Tahoma, FontSize=8)
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 5
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
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
    * ConfigurarPaginaDados - Page2: cabecalho + container de botoes de acao
    * (Campos de dados: Fases 5-6; botoes Confirmar/Cancelar: Fase 4)
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

        *-- Container BotoesAcao (Grupo_Salva no legado) - Confirmar/Cancelar
        *-- Canonico: Left=842, Top=33, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (legado: Salva, Left=5)
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

        *-- Botao Cancelar (legado: Cancelar, Left=80)
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

        *===========================================================================
        * CAMPOS DA PAGINA DADOS (FASE 5/8 - Primeira metade)
        * Compensacao PageFrame.Top=-29: Top_migrado = Top_original + 29
        * Ordem: Situacao, Codigo, Descricao, Falha Admitida, P/Q, Indice
        * Produtividade, Grupo, Conta, Tipo Acabamento
        *===========================================================================

        *-- Say19 "Situacao :" (Top=150+29=179, Left=331)
        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o : "
            .Top       = 179
            .Left      = 331
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Opc_situacao (OptionGroup: Ativo/Inativo/Falhas-Perdas) - crSigOpOpt.Situas -> this_nSituas
        *-- Original: Left=389 Top=144 Width=213 Height=28 (compensado Top=173)
        loc_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_situacao
            .ButtonCount = 3
            .Top         = 173
            .Left        = 389
            .Width       = 223
            .Height      = 28
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(1)
            .Caption   = "Ativ\<o"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(2)
            .Caption   = "I\<nativo"
            .BackStyle = 0
            .Left      = 54
            .Top       = 5
            .Width     = 60
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(3)
            .Caption   = "Falhas/Perdas"
            .Left      = 114
            .Top       = 6
            .Width     = 99
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Say1 "Tipo de Material :" (Top=150+29=179, Left=115) + Get_Cods -> this_cCods
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Tipo de Material :"
            .Top       = 179
            .Left      = 115
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top       = 176
            .Left      = 206
            .Width     = 115
            .Height    = 21
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say2 "Descricao :" (Top=177+29=206, Left=145) + Get_Descs -> this_cDescs
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 206
            .Left      = 145
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Top       = 203
            .Left      = 206
            .Width     = 290
            .Height    = 21
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say3 "Falha Admitida :" (Top=204+29=233, Left=121) + Get_Pfalhas -> this_nPfalhas
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Falha Admitida :"
            .Top       = 233
            .Left      = 121
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Pfalhas", "TextBox")
        WITH loc_oPagina.txt_4c_Pfalhas
            .Top       = 229
            .Left      = 206
            .Width     = 52
            .Height    = 21
            .InputMask = "999.99"
            .Format    = "9"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Say6 "[P]ercentual [Q]uantidade :" (Top=204+29=233, Left=262) + Get_tfalhas -> this_cTfalhas
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "[P]ercentual [Q]uantidade :"
            .Top       = 233
            .Left      = 262
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tfalhas", "TextBox")
        WITH loc_oPagina.txt_4c_Tfalhas
            .Top       = 229
            .Left      = 422
            .Width     = 17
            .Height    = 21
            .Format    = "M"
            .InputMask = "P,Q, "
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say14 "Indice de produtividade :" (Top=204+29=233, Left=453) + get_IndProd -> this_nIndProds
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = CHR(205) + "ndice de produtividade :"
            .Top       = 233
            .Left      = 453
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .ToolTipText = "C" + CHR(225) + "lcula o percentual de produtividade de determinado material."
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__IndProd", "TextBox")
        WITH loc_oPagina.txt_4c__IndProd
            .Top       = 229
            .Left      = 579
            .Width     = 52
            .Height    = 21
            .InputMask = "999.99"
            .Format    = "9"
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Say15 "%" (Top=204+29=233, Left=636) - decorativo, junto ao Indice de Produtividade
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "%"
            .Top       = 233
            .Left      = 636
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say4 "Grupo :" (Top=229+29=258, Left=162) + Get_Grupos -> this_cGrupos + Get_G (descricao, display)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Grupo :"
            .Top       = 258
            .Left      = 162
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Top       = 255
            .Left      = 206
            .Width     = 80
            .Height    = 21
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Get_G: descricao do grupo (SigCdGcr.Descrs) - preenchida por lookup, nao mapeada no BO
        loc_oPagina.AddObject("txt_4c_G", "TextBox")
        WITH loc_oPagina.txt_4c_G
            .Top       = 255
            .Left      = 289
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say5 "Conta :" (Top=255+29=284, Left=162) + Get_Contas -> this_cContas + Get_C (descricao, display)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Conta :"
            .Top       = 284
            .Left      = 162
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Contas", "TextBox")
        WITH loc_oPagina.txt_4c_Contas
            .Top       = 281
            .Left      = 206
            .Width     = 80
            .Height    = 21
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Get_C: descricao da conta (SigCdCli.Rclis) - preenchida por lookup, nao mapeada no BO
        loc_oPagina.AddObject("txt_4c_C", "TextBox")
        WITH loc_oPagina.txt_4c_C
            .Top       = 281
            .Left      = 289
            .Width     = 252
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say13 "Tipo Acabamento :" (Top=281+29=310, Left=108) + get_codacb -> this_cCodAcbs + get_Dacb (descricao, readonly)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Tipo Acabamento :"
            .Top       = 310
            .Left      = 108
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__codacb", "TextBox")
        WITH loc_oPagina.txt_4c__codacb
            .Top       = 307
            .Left      = 206
            .Width     = 31
            .Height    = 21
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- get_Dacb: descricao do tipo de acabamento (SigCdAca.Descrs) - readonly (When=.F. no legado)
        loc_oPagina.AddObject("txt_4c__Dacb", "TextBox")
        WITH loc_oPagina.txt_4c__Dacb
            .Top       = 307
            .Left      = 239
            .Width     = 192
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *===========================================================================
        * CAMPOS DA PAGINA DADOS (FASE 6/8 - Segunda metade)
        * Ordem: Lancar Somente E/S, Analisa Producao, Valor, Checar Devolucao,
        * Produzido/Trabalhado/Modelagem, Empresa, Checar Duplicidade, Retrabalho
        *===========================================================================

        *-- Say10 "Lancar Somente (E/S) :" (Top=359+29=388, Left=87) + Get_EntSai -> this_cAnaEsGrps
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Lancar Somente (E/S) :"
            .Top       = 388
            .Left      = 87
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EntSai", "TextBox")
        WITH loc_oPagina.txt_4c_EntSai
            .Top       = 385
            .Left      = 206
            .Width     = 17
            .Height    = 21
            .Format    = "M"
            .InputMask = "S,E, "
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say7 "Analisa Producao :" (Top=307+29=336, Left=109) + Get_AnProds -> this_cCtrlpds
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Analisa Produ" + CHR(231) + CHR(227) + "o :"
            .Top       = 336
            .Left      = 109
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_AnProds", "TextBox")
        WITH loc_oPagina.txt_4c_AnProds
            .Top       = 333
            .Left      = 206
            .Width     = 17
            .Height    = 21
            .Format    = "M"
            .InputMask = "S,N, "
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say9 "S/N" (Top=307+29=336, Left=232) - decorativo, junto a Analisa Producao
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "S/N"
            .Top       = 336
            .Left      = 232
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say8 "Valor :" (Top=333+29=362, Left=167) + Get_valor -> this_nValors
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Valor :"
            .Top       = 362
            .Left      = 167
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPagina.txt_4c_Valor
            .Top       = 359
            .Left      = 206
            .Width     = 59
            .Height    = 23
            .InputMask = "9999.99"
            .Format    = "R"
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Produzido/Trabalhado/Modelagem (checkboxes - crSigOpOpt.Prodzs/Trabas/models numeric 0/1)
        loc_oPagina.AddObject("chk_4c_Chk_produzido", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_produzido
            .Caption   = "Produzido"
            .Top       = 335
            .Left      = 291
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_trabalhado", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_trabalhado
            .Caption   = "Trabalhado"
            .Top       = 335
            .Left      = 387
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_modelagem", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_modelagem
            .Caption   = "Modelagem"
            .Top       = 335
            .Left      = 486
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Say11 "S/N" (Top=385+29=414, Left=232) - decorativo, junto a Checar Devolucao
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "S/N"
            .Top       = 414
            .Left      = 232
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say12 "Checar Devolucao :" (Top=385+29=414, Left=104) + Get_Dev -> this_cChkDevs
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Checar Devolu" + CHR(231) + CHR(227) + "o :"
            .Top       = 414
            .Left      = 104
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dev", "TextBox")
        WITH loc_oPagina.txt_4c_Dev
            .Top       = 411
            .Left      = 206
            .Width     = 17
            .Height    = 21
            .Format    = "M"
            .InputMask = "S,N, "
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say20 "Empresa :" (Top=410+29=439, Left=150) + Get_EmpPad -> this_cEmps
        loc_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPagina.lbl_4c_Label20
            .Caption   = "Empresa :"
            .Top       = 439
            .Left      = 150
            .Width     = 50
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmpPad", "TextBox")
        WITH loc_oPagina.txt_4c_EmpPad
            .Top       = 436
            .Left      = 206
            .Width     = 34
            .Height    = 23
            .MaxLength = 3
            .Alignment = 3
            .FontName  = "Courier New"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- chk_duplicidade (Top=431+29=460, Left=206) - crSigOpOpt.dupTpOps
        loc_oPagina.AddObject("chk_4c_Chk_duplicidade", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_duplicidade
            .Caption   = "Checar Duplicidade "
            .Top       = 460
            .Left      = 206
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_retrabalho (Top=448+29=477, Left=206) - crSigOpOpt.retrab
        loc_oPagina.AddObject("chk_4c_Chk_retrabalho", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_retrabalho
            .Caption   = "Aceita Retrabalho"
            .Top       = 477
            .Left      = 206
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *===========================================================================
        * LOOKUPS (FASE 6/8) - BINDEVENT de KeyPress para todos os campos com
        * lookup no legado (fAcessoContab/fAcessoContas/fwBuscaExt)
        *===========================================================================

        *-- Grupo (SigCdGcr): txt_4c_Grupo=codigo, txt_4c_G=descricao (reversa)
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_G,     "KeyPress", THIS, "GrupoDescKeyPress")

        *-- Conta (SigCdCli, com controle de acesso fAcessoContas filtrado por Grupo):
        *-- txt_4c_Contas=codigo, txt_4c_C=descricao (reversa)
        BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_C,      "KeyPress", THIS, "ContaDescKeyPress")

        *-- Tipo de Acabamento (SigCdAca): txt_4c__codacb=codigo, txt_4c__Dacb=descricao (readonly)
        *-- Habilitado apenas quando Grupo estiver preenchido (When do legado)
        BINDEVENT(loc_oPagina.txt_4c__codacb, "KeyPress", THIS, "CodAcbKeyPress")
        loc_oPagina.txt_4c__codacb.Enabled = !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))

        *-- Empresa Padrao (SigCdEmp): txt_4c_EmpPad
        BINDEVENT(loc_oPagina.txt_4c_EmpPad, "KeyPress", THIS, "EmpPadKeyPress")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * LOOKUPS DE GRUPO (SigCdGcr) - txt_4c_Grupo (codigo) + txt_4c_G (descricao)
    * Legado: Get_Grupos.Valid chamava fAcessoContab(Usuar,'C',valor,cod,desc).
    * fAcessoContab tem bug de UX conhecido (auto-carrega 1o registro sem
    * selecao explicita quando o SEEK falha parcialmente - mesma familia do
    * bug documentado para fAcessoContas). Substituido por SQL exato +
    * FormBuscaAuxiliar, no padrao consolidado em FormBch.prg (Erro155).
    *===========================================================================
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "VISUALIZAR"
            RETURN
        ENDIF
        DO CASE
            CASE par_nKeyCode = 115
                THIS.AbrirLookupGrupo()
            CASE INLIST(par_nKeyCode, 13, 9)
                THIS.ValidarGrupo()
        ENDCASE
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupo()
        LOCAL loc_oPagina, loc_cCodigo, loc_nResultado
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_G.Value = ""
            loc_oPagina.txt_4c__codacb.Enabled = .F.
            RETURN
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ChkGcr")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
                SELECT cursor_4c_ChkGcr
                loc_oPagina.txt_4c_G.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
                loc_oPagina.txt_4c__codacb.Enabled = .T.
            ELSE
                loc_oPagina.txt_4c_G.Value = ""
                THIS.AbrirLookupGrupo()
            ENDIF

            IF USED("cursor_4c_ChkGcr")
                USE IN cursor_4c_ChkGcr
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar grupo:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_ChkGcr")
                USE IN cursor_4c_ChkGcr
            ENDIF
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
                        AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                    loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                    loc_oPagina.txt_4c__codacb.Enabled = .T.
                ELSE
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                        SELECT cursor_4c_BuscaGcr
                        IF !EOF("cursor_4c_BuscaGcr")
                            loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                            loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                            loc_oPagina.txt_4c__codacb.Enabled = .T.
                        ELSE
                            loc_oPagina.txt_4c_Grupo.Value = ""
                            loc_oPagina.txt_4c_G.Value     = ""
                            loc_oPagina.txt_4c__codacb.Enabled = .F.
                        ENDIF
                    ELSE
                        loc_oPagina.txt_4c_Grupo.Value = ""
                        loc_oPagina.txt_4c_G.Value     = ""
                        loc_oPagina.txt_4c__codacb.Enabled = .F.
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        ENDTRY
    ENDPROC

    *-- Busca reversa por descricao (txt_4c_G) - ativa apenas quando Grupo vazio
    *-- (legado: Get_G.When = IsEmpty(get_grupos.Value) AND INSERIR/ALTERAR)
    PROCEDURE GrupoDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "VISUALIZAR"
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
            RETURN
        ENDIF

        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarGrupoDesc()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoDesc()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_G.Value))
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", "Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    IF !EOF("cursor_4c_BuscaGcr")
                        loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                        loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                        loc_oPagina.txt_4c__codacb.Enabled = .T.
                    ELSE
                        loc_oPagina.txt_4c_G.Value = ""
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_G.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao localizar grupo:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * LOOKUPS DE CONTA (SigCdCli) - txt_4c_Contas (codigo) + txt_4c_C (descricao)
    * Legado: Get_Contas.Valid / Get_C.Valid chamavam
    * fAcessoContas(Usuar, Grupo, 'C'/'D', valor, cod, desc). Mantido: o GRUPO
    * faz parte da regra de ACESSO (fAcessoContas cruza SigSyAgc/SigSyAcc com
    * SigCdAcG para decidir quais contas o usuario enxerga naquele grupo) -
    * excecao consciente da regra "fAcessoContas proibido em lookup UX", que
    * se aplica a autocomplete puro sem filtro de acesso. Mesmo padrao de
    * FormBch.prg (Erro155).
    *===========================================================================
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "VISUALIZAR"
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarConta()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarConta()
        LOCAL loc_oPagina, loc_cCodigo, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_C.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        TRY
            IF !fAcessoContas(Usuar, loc_cGrupo, "C", loc_cCodigo, ;
                              loc_oPagina.txt_4c_Contas, loc_oPagina.txt_4c_C)
                MsgAviso("Acesso Negado !!", "")
                loc_oPagina.txt_4c_Contas.Value = ""
                loc_oPagina.txt_4c_C.Value      = ""
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- Busca reversa por descricao (txt_4c_C) - ativa apenas quando Conta vazia
    *-- (legado: Get_C.When = IsEmpty(get_Contas.Value) AND INSERIR/ALTERAR)
    PROCEDURE ContaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "VISUALIZAR"
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Contas.Value))
            RETURN
        ENDIF

        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarContaDesc()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarContaDesc()
        LOCAL loc_oPagina, loc_cDesc, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cDesc   = ALLTRIM(loc_oPagina.txt_4c_C.Value)

        IF EMPTY(loc_cDesc)
            loc_oPagina.txt_4c_Contas.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        TRY
            IF !fAcessoContas(Usuar, loc_cGrupo, "D", loc_cDesc, ;
                              loc_oPagina.txt_4c_Contas, loc_oPagina.txt_4c_C)
                MsgAviso("Acesso Negado !!", "")
                loc_oPagina.txt_4c_C.Value      = ""
                loc_oPagina.txt_4c_Contas.Value = ""
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LOOKUP DE TIPO DE ACABAMENTO (SigCdAca) - txt_4c__codacb (codigo) +
    * txt_4c__Dacb (descricao, readonly). Legado: get_codacb.Valid usava
    * CreateObject('fwBuscaExt', ..., 'SigCdAca', ..., 'Cods', ...).
    *===========================================================================
    PROCEDURE CodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "VISUALIZAR"
            RETURN
        ENDIF
        DO CASE
            CASE par_nKeyCode = 115
                THIS.AbrirLookupCodAcb()
            CASE INLIST(par_nKeyCode, 13, 9)
                THIS.ValidarCodAcb()
        ENDCASE
    ENDPROC

    PROTECTED PROCEDURE ValidarCodAcb()
        LOCAL loc_oPagina, loc_cCodigo, loc_nResultado
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c__codacb.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c__Dacb.Value = ""
            RETURN
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ChkAcb")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkAcb") > 0
                SELECT cursor_4c_ChkAcb
                loc_oPagina.txt_4c__Dacb.Value = ALLTRIM(cursor_4c_ChkAcb.descrs)
            ELSE
                loc_oPagina.txt_4c__Dacb.Value = ""
                THIS.AbrirLookupCodAcb()
            ENDIF

            IF USED("cursor_4c_ChkAcb")
                USE IN cursor_4c_ChkAcb
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar tipo de acabamento:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_ChkAcb")
                USE IN cursor_4c_ChkAcb
            ENDIF
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupCodAcb()
        LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c__codacb.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdAca", "cursor_4c_BuscaAcb", "cods", loc_cCodigo, ;
                "Tipo de Acabamento")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
                        AND USED("cursor_4c_BuscaAcb")
                    SELECT cursor_4c_BuscaAcb
                    loc_oPagina.txt_4c__codacb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
                    loc_oPagina.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
                ELSE
                    loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
                        SELECT cursor_4c_BuscaAcb
                        IF !EOF("cursor_4c_BuscaAcb")
                            loc_oPagina.txt_4c__codacb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
                            loc_oPagina.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
                        ELSE
                            loc_oPagina.txt_4c__codacb.Value = ""
                            loc_oPagina.txt_4c__Dacb.Value   = ""
                        ENDIF
                    ELSE
                        loc_oPagina.txt_4c__codacb.Value = ""
                        loc_oPagina.txt_4c__Dacb.Value   = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaAcb")
                USE IN cursor_4c_BuscaAcb
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir busca de tipo de acabamento:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaAcb")
                USE IN cursor_4c_BuscaAcb
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * LOOKUP DE EMPRESA PADRAO (SigCdEmp) - txt_4c_EmpPad. Legado:
    * Get_EmpPad.Valid usava CreateObject('fwBuscaExt', ..., 'SigCdEmp', ...,
    * 'cEmps', ...).
    *===========================================================================
    PROCEDURE EmpPadKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "VISUALIZAR"
            RETURN
        ENDIF
        DO CASE
            CASE par_nKeyCode = 115
                THIS.AbrirLookupEmpPad()
            CASE INLIST(par_nKeyCode, 13, 9)
                THIS.ValidarEmpPad()
        ENDCASE
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpPad()
        LOCAL loc_oPagina, loc_cCodigo, loc_nResultado
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_EmpPad.Value)

        IF EMPTY(loc_cCodigo)
            RETURN
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT cEmps FROM SigCdEmp WHERE cEmps = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ChkEmp")

            IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkEmp") = 0
                THIS.AbrirLookupEmpPad()
            ENDIF

            IF USED("cursor_4c_ChkEmp")
                USE IN cursor_4c_ChkEmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar empresa:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_ChkEmp")
                USE IN cursor_4c_ChkEmp
            ENDIF
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupEmpPad()
        LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_EmpPad.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "cEmps", loc_cCodigo, "Empresas")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
                        AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_oPagina.txt_4c_EmpPad.Value = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
                ELSE
                    loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        loc_oPagina.txt_4c_EmpPad.Value = IIF(!EOF("cursor_4c_BuscaEmp"), ;
                            ALLTRIM(cursor_4c_BuscaEmp.cEmps), "")
                    ELSE
                        loc_oPagina.txt_4c_EmpPad.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir busca de empresa:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
    * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
    * Colunas (legado SIGCDTML.Init): Cods(115), descs(270), pfalhas(80),
    * Grupos(80), CodAcbs(40, invisivel no legado - .f. no pColuna)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.pfalhas"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grupos"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.codacbs"

                    loc_oGrid.Column1.Width = 115
                    loc_oGrid.Column2.Width = 270
                    loc_oGrid.Column3.Width = 80
                    loc_oGrid.Column4.Width = 80
                    loc_oGrid.Column5.Width = 40

                    *-- Coluna CodAcbs eh invisivel no legado (pColuna(..., .f.))
                    loc_oGrid.Column5.Visible = .F.

                    *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Falha"
                    loc_oGrid.Column4.Header1.Caption = "Grupo"
                    loc_oGrid.Column5.Header1.Caption = "Acab."

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTml.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
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
                "FormTml.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna visiveis, recursivamente, todos os
    * controles de um container (Pages de PageFrames incluidas)
    * Containers que controlam a propria visibilidade (ex.: cnt_4c_Cabecalho)
    * ficam de fora do INLIST para nao terem Visible=.F. sobrescrito
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5) ;
                        AND !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
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
    * FormatarGridLista - Formata visual do grid da lista (fonte/tamanho)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormTml.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Reseta todos os campos da Page2 para os valores default
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.obj_4c_Opc_situacao.Value      = 1
        loc_oPagina.txt_4c_Codigo.Value            = ""
        loc_oPagina.txt_4c_Descricao.Value         = ""
        loc_oPagina.txt_4c_Pfalhas.Value           = 0
        loc_oPagina.txt_4c_Tfalhas.Value           = ""
        loc_oPagina.txt_4c__IndProd.Value          = 0
        loc_oPagina.txt_4c_Grupo.Value             = ""
        loc_oPagina.txt_4c_G.Value                 = ""
        loc_oPagina.txt_4c_Contas.Value            = ""
        loc_oPagina.txt_4c_C.Value                 = ""
        loc_oPagina.txt_4c__codacb.Value           = ""
        loc_oPagina.txt_4c__Dacb.Value             = ""
        loc_oPagina.txt_4c__codacb.Enabled         = .F.
        loc_oPagina.txt_4c_EntSai.Value            = ""
        loc_oPagina.txt_4c_AnProds.Value           = ""
        loc_oPagina.txt_4c_Valor.Value             = 0
        loc_oPagina.chk_4c_Chk_produzido.Value     = 0
        loc_oPagina.chk_4c_Chk_trabalhado.Value    = 0
        loc_oPagina.chk_4c_Chk_modelagem.Value     = 0
        loc_oPagina.txt_4c_Dev.Value                = ""
        loc_oPagina.txt_4c_EmpPad.Value             = ""
        loc_oPagina.chk_4c_Chk_duplicidade.Value    = 0
        loc_oPagina.chk_4c_Chk_retrabalho.Value     = 0
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere as propriedades do TmlBO para os campos da Page2
    * As descricoes de Grupo/Conta/Tipo Acabamento sao buscadas diretamente por
    * SQL (SEM abrir FormBuscaAuxiliar) para nao disparar picker ao carregar
    * um registro ja existente.
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oBO, loc_nResultado
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        TRY
            loc_oPagina.obj_4c_Opc_situacao.Value = IIF(INLIST(loc_oBO.this_nSituas, 1, 2, 3), ;
                loc_oBO.this_nSituas, 1)
            loc_oPagina.txt_4c_Codigo.Value       = loc_oBO.this_cCods
            loc_oPagina.txt_4c_Descricao.Value    = loc_oBO.this_cDescs
            loc_oPagina.txt_4c_Pfalhas.Value      = loc_oBO.this_nPfalhas
            loc_oPagina.txt_4c_Tfalhas.Value      = loc_oBO.this_cTfalhas
            loc_oPagina.txt_4c__IndProd.Value     = loc_oBO.this_nIndProds
            loc_oPagina.txt_4c_Grupo.Value        = loc_oBO.this_cGrupos
            loc_oPagina.txt_4c_Contas.Value       = loc_oBO.this_cContas
            loc_oPagina.txt_4c__codacb.Value      = loc_oBO.this_cCodAcbs
            loc_oPagina.txt_4c_EntSai.Value       = loc_oBO.this_cAnaEsGrps
            loc_oPagina.txt_4c_AnProds.Value      = loc_oBO.this_cCtrlpds
            loc_oPagina.txt_4c_Valor.Value        = loc_oBO.this_nValors
            loc_oPagina.chk_4c_Chk_produzido.Value  = (loc_oBO.this_nProdzs .Value  = IIF(loc_oBO.this_nProdzs = 1, 1, 0))
            loc_oPagina.chk_4c_Chk_trabalhado.Value = (loc_oBO.this_nTrabas .Value = IIF(loc_oBO.this_nTrabas = 1, 1, 0))
            loc_oPagina.chk_4c_Chk_modelagem.Value  = (loc_oBO.this_nModels .Value  = IIF(loc_oBO.this_nModels = 1, 1, 0))
            loc_oPagina.txt_4c_Dev.Value           = loc_oBO.this_cChkDevs
            loc_oPagina.txt_4c_EmpPad.Value        = loc_oBO.this_cEmps
            loc_oPagina.chk_4c_Chk_duplicidade.Value = (loc_oBO.this_nDupTpOps .Value = IIF(loc_oBO.this_nDupTpOps = 1, 1, 0))
            loc_oPagina.chk_4c_Chk_retrabalho.Value  = (loc_oBO.this_nRetrab .Value  = IIF(loc_oBO.this_nRetrab = 1, 1, 0))

            *-- Descricao do Grupo (SigCdGcr.descrs) - somente consulta, sem abrir lookup
            loc_oPagina.txt_4c_G.Value = ""
            IF !EMPTY(ALLTRIM(loc_oBO.this_cGrupos))
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cGrupos)), ;
                    "cursor_4c_ChkGcr")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
                    loc_oPagina.txt_4c_G.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
                ENDIF
                IF USED("cursor_4c_ChkGcr")
                    USE IN cursor_4c_ChkGcr
                ENDIF
            ENDIF
            loc_oPagina.txt_4c__codacb.Enabled = !EMPTY(ALLTRIM(loc_oBO.this_cGrupos))

            *-- Descricao da Conta (SigCdCli.rclis) - somente consulta, sem abrir lookup
            loc_oPagina.txt_4c_C.Value = ""
            IF !EMPTY(ALLTRIM(loc_oBO.this_cContas))
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(ALLTRIM(loc_oBO.this_cContas)), ;
                    "cursor_4c_ChkCli")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
                    loc_oPagina.txt_4c_C.Value = ALLTRIM(cursor_4c_ChkCli.rclis)
                ENDIF
                IF USED("cursor_4c_ChkCli")
                    USE IN cursor_4c_ChkCli
                ENDIF
            ENDIF

            *-- Descricao do Tipo de Acabamento (SigCdAca.descrs) - somente consulta, sem abrir lookup
            loc_oPagina.txt_4c__Dacb.Value = ""
            IF !EMPTY(ALLTRIM(loc_oBO.this_cCodAcbs))
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(ALLTRIM(loc_oBO.this_cCodAcbs)), ;
                    "cursor_4c_ChkAcb")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkAcb") > 0
                    loc_oPagina.txt_4c__Dacb.Value = ALLTRIM(cursor_4c_ChkAcb.descrs)
                ENDIF
                IF USED("cursor_4c_ChkAcb")
                    USE IN cursor_4c_ChkAcb
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar dados no formul" + CHR(225) + "rio:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os campos da Page2 para as propriedades do TmlBO
    * (usado pelo BtnSalvarClick - Fase 8)
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oBO.this_nSituas    = loc_oPagina.obj_4c_Opc_situacao.Value
        loc_oBO.this_cCods      = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        loc_oBO.this_cDescs     = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        loc_oBO.this_nPfalhas   = loc_oPagina.txt_4c_Pfalhas.Value
        loc_oBO.this_cTfalhas   = loc_oPagina.txt_4c_Tfalhas.Value
        loc_oBO.this_nIndProds  = loc_oPagina.txt_4c__IndProd.Value
        loc_oBO.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_oBO.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
        loc_oBO.this_cCodAcbs   = ALLTRIM(loc_oPagina.txt_4c__codacb.Value)
        loc_oBO.this_cAnaEsGrps = loc_oPagina.txt_4c_EntSai.Value
        loc_oBO.this_cCtrlpds   = loc_oPagina.txt_4c_AnProds.Value
        loc_oBO.this_nValors    = loc_oPagina.txt_4c_Valor.Value
        loc_oBO.this_nProdzs    = IIF(loc_oPagina.chk_4c_Chk_produzido.Value = 1, 1, 0)
        loc_oBO.this_nTrabas    = IIF(loc_oPagina.chk_4c_Chk_trabalhado.Value = 1, 1, 0)
        loc_oBO.this_nModels    = IIF(loc_oPagina.chk_4c_Chk_modelagem.Value = 1, 1, 0)
        loc_oBO.this_cChkDevs   = loc_oPagina.txt_4c_Dev.Value
        loc_oBO.this_cEmps      = ALLTRIM(loc_oPagina.txt_4c_EmpPad.Value)
        loc_oBO.this_nDupTpOps  = IIF(loc_oPagina.chk_4c_Chk_duplicidade.Value = 1, 1, 0)
        loc_oBO.this_nRetrab    = IIF(loc_oPagina.chk_4c_Chk_retrabalho.Value = 1, 1, 0)
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos da Page2
    * Codigo (cods) so eh editavel em modo INCLUIR (legado: Get_Cods.When
    * retorna INSERIR/PROCURAR)
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lHab, loc_lCodEditavel
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lHab    = (par_lHabilitar = .T.)
        loc_lCodEditavel = loc_lHab AND THIS.this_cModoAtual = "INCLUIR"

        loc_oPagina.txt_4c_Codigo.Enabled          = loc_lCodEditavel
        loc_oPagina.txt_4c_Descricao.Enabled       = loc_lHab
        loc_oPagina.obj_4c_Opc_situacao.Enabled    = loc_lHab
        loc_oPagina.txt_4c_Pfalhas.Enabled         = loc_lHab
        loc_oPagina.txt_4c_Tfalhas.Enabled         = loc_lHab
        loc_oPagina.txt_4c__IndProd.Enabled        = loc_lHab
        loc_oPagina.txt_4c_Grupo.Enabled           = loc_lHab
        loc_oPagina.txt_4c_G.Enabled               = loc_lHab
        loc_oPagina.txt_4c_Contas.Enabled          = loc_lHab
        loc_oPagina.txt_4c_C.Enabled               = loc_lHab
        loc_oPagina.txt_4c__codacb.Enabled         = loc_lHab AND !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
        loc_oPagina.txt_4c_EntSai.Enabled          = loc_lHab
        loc_oPagina.txt_4c_AnProds.Enabled         = loc_lHab
        loc_oPagina.txt_4c_Valor.Enabled           = loc_lHab
        loc_oPagina.chk_4c_Chk_produzido.Enabled   = loc_lHab
        loc_oPagina.chk_4c_Chk_trabalhado.Enabled  = loc_lHab
        loc_oPagina.chk_4c_Chk_modelagem.Enabled   = loc_lHab
        loc_oPagina.txt_4c_Dev.Enabled             = loc_lHab
        loc_oPagina.txt_4c_EmpPad.Enabled          = loc_lHab
        loc_oPagina.chk_4c_Chk_duplicidade.Enabled = loc_lHab
        loc_oPagina.chk_4c_Chk_retrabalho.Enabled  = loc_lHab
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
    * VISUALIZAR: Confirmar desabilitado, Cancelar habilitado (padrao frmcadastro)
    * Chamado diretamente por TesteAutomatico.prg - DEVE ser PUBLIC
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes
        loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .F.
                loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
            OTHERWISE
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara o BO e o formulario para inclusao de novo
    * registro e navega para a Page2 (Dados)
    * Legado (SIGCDTML.Click com pcEscolha='INSERIR'): foco em Get_Cods
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
        CATCH TO loException
            MsgErro("Erro ao incluir registro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega o registro selecionado no grid, prepara o BO
    * para edicao e navega para a Page2 (Dados)
    * Legado (SIGCDTML.Click com pcEscolha='ALTERAR'): foco em Get_Descs
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidchaves
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.", "Erro")
                ELSE
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alterar registro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega o registro selecionado (somente leitura) e
    * navega para a Page2 (Dados). Tambem vinculado ao DblClick do grid.
    * Legado (SIGCDTML.Click com pcEscolha='CONSULTAR'): foco em Grupo_Salva.Salva
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidchaves
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.", "Erro")
                ELSE
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao visualizar registro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado no grid
    * (this_oBusinessObject.Excluir() eh PUBLIC e chama ExecutarExclusao()
    * internamente - NUNCA chamar ExecutarExclusao() diretamente do Form)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidchaves, loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
                loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cods)

                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do tipo de material " + ;
                        loc_cCodigo + " ?", "Confirma" + CHR(231) + CHR(227) + "o de Exclus" + CHR(227) + "o")
                    IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro para " + ;
                            "exclus" + CHR(227) + "o.", "Erro")
                    ELSE
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgExcluidoSucesso()
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("Erro ao excluir registro:" + CHR(13) + ;
                                THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir registro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker para localizar registro na lista
    * Apos selecao, posiciona o cursor no registro encontrado (LOCATE em
    * cursor_4c_Dados, sem nova consulta ao servidor)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpOpt", "cursor_4c_BuscaTml", "cods", "", ;
                "Buscar Tipo de Material")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTml")
                    SELECT cursor_4c_BuscaTml
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaTml.cods)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTml")
                USE IN cursor_4c_BuscaTml
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cods) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormTml.BtnBuscarClick")
            IF USED("cursor_4c_BuscaTml")
                USE IN cursor_4c_BuscaTml
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e confirma o registro atual (Confirmar)
    * Legado (SIGCDTML.Click, pcEscolha='INSERIR'): exige Get_Cods preenchido e
    * verifica duplicidade via CursorQuery('SigOpOpt', ..., 'cods', ...) ANTES
    * de gerar cIdChaves/gravar. Validacoes ficam FORA do TRY (Problema 16).
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cCodigo, loc_nResultado, loc_lDuplicado, loc_lErroValidacao

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)

        *-- Validacao OBRIGATORIA (legado: IsEmpty(Get_Cods.Value))
        IF EMPTY(loc_cCodigo)
            MsgCampoObrigatorio("Tipo de Material")
            loc_oPagina.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Descricao.Value))
            MsgCampoObrigatorio("Descri" + CHR(231) + CHR(227) + "o")
            loc_oPagina.txt_4c_Descricao.SetFocus()
            RETURN
        ENDIF

        *-- Validacao de duplicidade - somente em modo INCLUIR (legado: CursorQuery
        *-- antes do Replace cIdChaves With fUniqueIds())
        loc_lDuplicado     = .F.
        loc_lErroValidacao = .F.

        IF THIS.this_cModoAtual = "INCLUIR"
            TRY
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT cidchaves FROM SigOpOpt WHERE RTRIM(cods) = " + EscaparSQL(loc_cCodigo), ;
                    "cursor_4c_ChkDup")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
                    loc_lDuplicado = .T.
                ENDIF

                IF USED("cursor_4c_ChkDup")
                    USE IN cursor_4c_ChkDup
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao validar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "Erro")
                loc_lErroValidacao = .T.
                IF USED("cursor_4c_ChkDup")
                    USE IN cursor_4c_ChkDup
                ENDIF
            ENDTRY

            IF loc_lErroValidacao
                RETURN
            ENDIF

            IF loc_lDuplicado
                MsgDuplicado("C" + CHR(243) + "digo")
                loc_oPagina.txt_4c_Codigo.SetFocus()
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgSalvoSucesso()
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Erro ao salvar registro:" + CHR(13) + ;
                    THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar registro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    * Legado (SIGCDTML.Click, botao Cancelar): =DoDefault() seguido de
    * ThisForm.mAtivapagina1 quando ThisForm.plCancelar
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
        CATCH TO loException
            MsgErro("Erro ao cancelar edi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * Destroy - Libera Business Object e cursores abertos
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF

        IF USED("cursor_4c_ChkGcr")
            USE IN cursor_4c_ChkGcr
        ENDIF

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF

        IF USED("cursor_4c_ChkCli")
            USE IN cursor_4c_ChkCli
        ENDIF

        IF USED("cursor_4c_ChkAcb")
            USE IN cursor_4c_ChkAcb
        ENDIF

        IF USED("cursor_4c_BuscaAcb")
            USE IN cursor_4c_BuscaAcb
        ENDIF

        IF USED("cursor_4c_ChkEmp")
            USE IN cursor_4c_ChkEmp
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        IF USED("cursor_4c_BuscaTml")
            USE IN cursor_4c_BuscaTml
        ENDIF

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
