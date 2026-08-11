*==============================================================================
* Formcrp.prg - Formulario de Cadastro de Caracteristicas
* Migrado de: sigcdcrp.SCX (frmcadastro)
* Tabela: SigCrRaP | BO: crpBO
* this_nTipos: 0=Produtos, 1=Contas, 2=Movimentacoes
*==============================================================================

DEFINE CLASS Formcrp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Caracteristicas de Produtos"
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
    this_nTipos          = 0

    *==========================================================================
    * Init - Captura parametro de tipo antes do DODEFAULT()
    * par_nTipo: 0=Produtos (default), 1=Contas, 2=Movimentacoes
    * Legado: pcTipo (C/char) convertido para numerico no novo sistema
    *==========================================================================
    PROCEDURE Init(par_nTipo)
        THIS.this_nTipos = IIF(VARTYPE(par_nTipo) = "N", par_nTipo, 0)

        DO CASE
        CASE THIS.this_nTipos = 1
            THIS.Caption = "Caracter" + CHR(237) + "sticas de Contas"
        CASE THIS.this_nTipos = 2
            THIS.Caption = "Caracter" + CHR(237) + "sticas de Movimenta" + CHR(231) + CHR(245) + "es"
        OTHERWISE
            THIS.Caption = "Cadastro de Caracteristicas de Produtos"
        ENDCASE

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("crpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar crpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formcrp.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_nTipos = THIS.this_nTipos

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
            MostrarErro("Erro ao inicializar Formcrp:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formcrp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles internos compensam +29 no Top
    *==========================================================================
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

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (estrutura base Fase 3)
    * Cria: cnt_4c_Cabecalho (com labels), cnt_4c_Botoes (vazio), cnt_4c_Saida
    * Grade e botoes CRUD serao adicionados na Fase 4
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho cinza (cntSombra no legado)
        *-- Original: cntSombra.Width=1100. Com comp PageFrame +29: Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top       = 31
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackColor = RGB(100, 100, 100)
            .BackStyle = 1
            .BorderWidth = 0
            .Visible   = .T.
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=544, Top=-1, Width=385, Height=85)
        *-- Canonico: Left=542, Top=28 (-1+29 compensacao), Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top       = 28
            .Left      = 542
            .Width     = 390
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        *-- Botao Incluir (usa cadastro_inserir_26.jpg - padrao framework para Incluir)
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

        *-- Botao Visualizar
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

        *-- Botao Alterar
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

        *-- Botao Excluir
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

        *-- Botao Buscar
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

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado per CLAUDE.md regra #10)
        *-- Legado: Grupo_Saida.Left=919, Top=-1. Canonico: Left=917, Top=29, Width=90
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top       = 29
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
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

        *-- Grid de lista (Grade no legado: Top=102, Left=29, Width=940, Height=479)
        *-- Top=117 seguindo padrao framework (compensacao +29 do PageFrame)
        *-- Width=890: Left=26, termina em 916, nao sobrepoe cnt_4c_Saida (Left=917)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.ColumnCount = 5
        WITH loc_oPagina.grd_4c_Dados
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 479
            .FontName           = "Verdana"
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
            .Column1.Width      = 100
            .Column2.Width      = 300
            .Column3.Width      = 55
            .Column4.Width      = 250
            .Column5.Width      = 60
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (estrutura base Fase 3)
    * Cria: cnt_4c_BotoesAcao (vazio)
    * TextBoxes de dados e botoes Salvar/Cancelar serao adicionados nas Fases 4-6
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (Grupo_Salva no legado: Left=843, Top=-3, Width~160, Height=85)
        *-- Com comp +29: Top=26, Left=843
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top       = 26
            .Left      = 843
            .Width     = 160
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        *-- Botao Confirmar (Salva.Salva no legado: Left=5, Top=5)
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

        *-- Botao Cancelar (Salva.Cancela no legado: Left=80, Top=5)
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

        *-- Label Codigo (Say1: top=192, left=339 -> +29 comp: top=221)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 221
            .Left      = 339
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getCodigos: top=188, left=383, width=150, height=23 -> top=217)
        *-- Habilitado somente em INCLUIR e BUSCAR (PK nao pode ser alterada)
        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value     = ""
            .Top       = 217
            .Left      = 383
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- Label Descricao (Say2: top=218, left=326 -> +29 comp: top=247)
        loc_oPagina.AddObject("lbl_4c_Descrs", "Label")
        WITH loc_oPagina.lbl_4c_Descrs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 247
            .Left      = 326
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescrs: top=214, left=383, width=290, height=23 -> top=243)
        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value     = ""
            .Top       = 243
            .Left      = 383
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH

        *-- Label Ordem (Say4: top=192, left=573 -> +29 comp: top=221)
        loc_oPagina.AddObject("lbl_4c_Ordem", "Label")
        WITH loc_oPagina.lbl_4c_Ordem
            .Caption   = "Ordem :"
            .Top       = 221
            .Left      = 573
            .Width     = 44
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Ordem (Get_Ordem: top=188, left=619, width=54, height=23 -> top=217)
        *-- Validacao de ordem duplicada feita pelo BO em ValidarDados()
        loc_oPagina.AddObject("txt_4c_Ordens", "TextBox")
        WITH loc_oPagina.txt_4c_Ordens
            .Value     = 0
            .Top       = 217
            .Left      = 619
            .Width     = 54
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        *-- Label Grupo (lbl_grupo: top=244, left=343, width=38, height=15 -> +29=273)
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo :"
            .Top       = 273
            .Left      = 343
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Grupo (get_cd_grupo: top=240, left=383, width=31, height=23 -> top=269)
        *-- MaxLength=3: SigCdGrp.cgrus char(3), SigCdGpr.codigos char(3)
        loc_oPagina.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_CdGrupo
            .Value          = ""
            .Top            = 269
            .Left           = 383
            .Width          = 31
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .ForeColor      = RGB(0, 0, 0)
            .SpecialEffect  = 1
            .MaxLength      = 3
            .TabIndex       = 8
            .Visible        = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "CdGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "DblClick", THIS, "CdGrupoDblClick")

        *-- TextBox Descricao Grupo (get_ds_grupo: top=240, left=416, width=150, height=23 -> top=269)
        loc_oPagina.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsGrupo
            .Value          = ""
            .Top            = 269
            .Left           = 416
            .Width          = 150
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .ForeColor      = RGB(0, 0, 0)
            .SpecialEffect  = 1
            .MaxLength      = 40
            .TabIndex       = 9
            .Visible        = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "DsGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "DblClick", THIS, "DsGrupoDblClick")

        *-- CheckBox Obrigatorio (chkObrig: top=244, left=573, height=15, width=72 -> top=273)
        loc_oPagina.AddObject("chk_4c_Obrig", "CheckBox")
        WITH loc_oPagina.chk_4c_Obrig
            .Caption   = "Obrigat" + CHR(243) + "rio"
            .Value     = 0
            .Top       = 273
            .Left      = 573
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT para validacao de ordem duplicada (equivalente ao Valid do legado)
        BINDEVENT(loc_oPagina.txt_4c_Ordens, "KeyPress", THIS, "OrdemLostFocus")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca registros e vincula grid ao cursor
    * RecordSource FORA do WITH e APOS Buscar() (Problemas 36/48)
    * ControlSource e Headers APOS RecordSource (Problemas 32/48)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Business Object n" + CHR(227) + "o inicializado.")
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                            IF VARTYPE(loc_oGrid) = "O"
                                *-- RecordSource ANTES de ControlSource (auto-bind por ordem de campo)
                                loc_oGrid.ColumnCount = 5
                                loc_oGrid.RecordSource = "cursor_4c_Dados"
                                *-- ControlSource expl?cito APOS RecordSource
                                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Cgrus"
                                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Dgrus"
                                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ordens"
                                *-- Headers APOS ControlSource (reset pelo RecordSource)
                                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                                loc_oGrid.Column3.Header1.Caption = "Grupo"
                                loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Grupo"
                                loc_oGrid.Column5.Header1.Caption = "Ordem"
                                THIS.FormatarGridLista(loc_oGrid)
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "Formcrp.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1 recarrega a lista
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida.")
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
                "Formcrp.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara Page2 para incluir novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Descrs", 5)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo  = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
            RETURN
        ENDIF
        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da caracter" + CHR(237) + ;
            "stica '" + loc_cCodigo + "'?", "Excluir")
        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Caracter" + CHR(237) + "stica exclu" + CHR(237) + "da com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Prepara Page2 para buscar registro por codigo
    * Legado: PROCURAR navega para Page2, usuario digita codigo e pressiona OK
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "BUSCAR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos da Page2
    * Usa PEMSTATUS para ser seguro mesmo quando Page2 ainda nao tem todos os campos
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_cCodigos
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_oPagina.txt_4c_Descrs.Value = THIS.this_oBusinessObject.this_cDescrs
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
            loc_oPagina.txt_4c_Ordens.Value = THIS.this_oBusinessObject.this_nOrdens
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
            loc_oPagina.txt_4c_CdGrupo.Value = THIS.this_oBusinessObject.this_cCgrus
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
            loc_oPagina.txt_4c_DsGrupo.Value = THIS.this_oBusinessObject.this_cDgrus
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Obrig", 5)
            loc_oPagina.chk_4c_Obrig.Value = IIF(THIS.this_oBusinessObject.this_nChkobrig = 1, 1, 0)
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_oPagina.txt_4c_Descrs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
            loc_oPagina.txt_4c_Ordens.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
            loc_oPagina.txt_4c_CdGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
            loc_oPagina.txt_4c_DsGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Obrig", 5)
            loc_oPagina.chk_4c_Obrig.Value = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita os campos da Page2
    * Codigos: editavel apenas em INCLUIR e BUSCAR (PK nao pode ser alterada)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lHabilitar
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_lHabilitar = (par_lHabilitar = .T.)

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Enabled = (loc_lHabilitar AND ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_oPagina.txt_4c_Descrs.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
            loc_oPagina.txt_4c_Ordens.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
            loc_oPagina.txt_4c_CdGrupo.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
            loc_oPagina.txt_4c_DsGrupo.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Obrig", 5)
            loc_oPagina.chk_4c_Obrig.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes de Page2 conforme modo
    * Confirmar: habilitado em INCLUIR/ALTERAR/BUSCAR
    * Cancelar: sempre habilitado
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lModoEdicao
        loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
        loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")

        IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
            loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lModoEdicao
        ENDIF
        IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
            loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual padrao ao grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Necessario porque AddObject() cria controles com Visible=.F. por padrao
    *==========================================================================
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

    *==========================================================================
    * BtnSalvarClick - Valida e salva (Confirmar). Legado: Salva.Click
    * Em modo BUSCAR: filtra lista pelo codigo digitado
    * Em modo INCLUIR/ALTERAR: valida e chama BO.Salvar()
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPagina, loc_cCodigos, loc_cDescrs
        loc_lSucesso  = .F.
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_cCodigos  = ""
        loc_cDescrs   = ""

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        ENDIF

        *-- Modo BUSCAR: filtra a lista por codigo
        IF THIS.this_cModoAtual = "BUSCAR"
            IF !EMPTY(loc_cCodigos)
                THIS.this_oBusinessObject.Buscar("a.Codigos LIKE " + EscaparSQL(loc_cCodigos + "%"))
            ELSE
                THIS.this_oBusinessObject.Buscar("")
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        *-- Validacao minima antes do TRY (Problema 16)
        IF EMPTY(loc_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
                loc_oPagina.txt_4c_Codigos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
        ENDIF
        IF EMPTY(loc_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
                loc_oPagina.txt_4c_Descrs.SetFocus()
            ENDIF
            RETURN
        ENDIF

        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Caracter" + CHR(237) + "stica salva com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "Formcrp.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos campos da Page2 para as propriedades do BO
    * Inverso de BOParaForm()
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
            THIS.this_oBusinessObject.this_nOrdens = loc_oPagina.txt_4c_Ordens.Value
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
            THIS.this_oBusinessObject.this_cCgrus = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
            THIS.this_oBusinessObject.this_cDgrus = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Obrig", 5)
            THIS.this_oBusinessObject.this_nChkobrig = IIF(loc_oPagina.chk_4c_Obrig.Value = 1, 1, 0)
        ENDIF
    ENDPROC

    *==========================================================================
    * CdGrupoKeyPress - Handler KeyPress do campo Codigo Grupo (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE CdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupo("CODIGO")
        ENDIF
    ENDPROC

    *==========================================================================
    * CdGrupoDblClick - Handler DblClick do campo Codigo Grupo (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE CdGrupoDblClick()
        THIS.AbrirLookupGrupo("CODIGO")
    ENDPROC

    *==========================================================================
    * DsGrupoKeyPress - Handler KeyPress do campo Descricao Grupo (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE DsGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupo("DESCRICAO")
        ENDIF
    ENDPROC

    *==========================================================================
    * DsGrupoDblClick - Handler DblClick do campo Descricao Grupo (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE DsGrupoDblClick()
        THIS.AbrirLookupGrupo("DESCRICAO")
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupo - Abre busca auxiliar para o campo Grupo
    * par_cCampoBusca: "CODIGO" ou "DESCRICAO"
    * pnTipo=2 (Movimentacoes): busca em SigCdGpr (Grupos Grandes), cols: codigos/descs
    * pnTipo=0/1 (Produtos/Contas): busca em SigCdGrp (Grupos Produto), cols: cgrus/dgrus
    * Legado: fwBuscaExt em get_cd_grupo.Valid e get_ds_grupo.Valid
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupo(par_cCampoBusca)
        LOCAL loc_oPagina, loc_cTabela, loc_cCampoCod, loc_cCampoDesc
        LOCAL loc_cCampoPesquisa, loc_cValorBusca, loc_oBusca, loc_lMovim

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lMovim  = (THIS.this_nTipos = 2)

        IF loc_lMovim
            *-- Movimentacoes: SigCdGpr (Grande Grupo) - codigos char(3), descs char(40)
            loc_cTabela    = "SigCdGpr"
            loc_cCampoCod  = "codigos"
            loc_cCampoDesc = "descs"
        ELSE
            *-- Produtos/Contas: SigCdGrp - cgrus char(3), dgrus char(40)
            loc_cTabela    = "SigCdGrp"
            loc_cCampoCod  = "cgrus"
            loc_cCampoDesc = "dgrus"
        ENDIF

        IF par_cCampoBusca = "CODIGO"
            loc_cCampoPesquisa = loc_cCampoCod
            loc_cValorBusca    = ALLTRIM(IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5), ;
                loc_oPagina.txt_4c_CdGrupo.Value, ""))
        ELSE
            loc_cCampoPesquisa = loc_cCampoDesc
            loc_cValorBusca    = ALLTRIM(IIF(PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5), ;
                loc_oPagina.txt_4c_DsGrupo.Value, ""))
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                loc_cTabela, "cursor_4c_BuscaGrupo", ;
                loc_cCampoPesquisa, loc_cValorBusca, ;
                "Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lSelecionou OR !loc_oBusca.this_lAchouRegistro
                    IF loc_lMovim
                        loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    ENDIF
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
                        loc_oPagina.txt_4c_CdGrupo.Value = ;
                            ALLTRIM(EVALUATE("cursor_4c_BuscaGrupo." + loc_cCampoCod))
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
                        loc_oPagina.txt_4c_DsGrupo.Value = ;
                            ALLTRIM(EVALUATE("cursor_4c_BuscaGrupo." + loc_cCampoDesc))
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, ;
                "Formcrp.AbrirLookupGrupo")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *==========================================================================
    * OrdemLostFocus - Valida ordem duplicada ao sair do campo (PUBLIC para BINDEVENT)
    * Legado: Get_Ordem.Valid - SELECT Ordens FROM SigCrRap WHERE Ordens=X AND Codigos<>Y AND nTipos=Z
    *==========================================================================
    PROCEDURE OrdemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nOrdem, loc_cCodigos, loc_cSQL, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
            RETURN
        ENDIF

        loc_nOrdem = loc_oPagina.txt_4c_Ordens.Value
        IF loc_nOrdem <= 0
            RETURN
        ENDIF

        loc_cCodigos = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        ENDIF

        TRY
            loc_cSQL = "SELECT Ordens FROM SigCrRap" + ;
                " WHERE Ordens = " + FormatarNumeroSQL(loc_nOrdem) + ;
                " AND Codigos <> " + EscaparSQL(loc_cCodigos) + ;
                " AND nTipos = " + ALLTRIM(STR(THIS.this_nTipos))

            IF USED("cursor_4c_ValidaOrdem")
                USE IN cursor_4c_ValidaOrdem
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaOrdem")

            IF loc_nResult < 0
                MsgAviso("Falha ao verificar ordem.")
            ELSE
                IF USED("cursor_4c_ValidaOrdem") AND RECCOUNT("cursor_4c_ValidaOrdem") > 0
                    MsgAviso("Ordem j" + CHR(225) + " cadastrada!")
                    loc_oPagina.txt_4c_Ordens.Value = 0
                    loc_oPagina.txt_4c_Ordens.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar ordem:" + CHR(13) + loException.Message, ;
                "Formcrp.OrdemLostFocus")
        ENDTRY

        IF USED("cursor_4c_ValidaOrdem")
            USE IN cursor_4c_ValidaOrdem
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
        IF USED("cursor_4c_ValidaOrdem")
            USE IN cursor_4c_ValidaOrdem
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
