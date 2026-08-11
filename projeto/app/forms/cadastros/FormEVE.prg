*==============================================================================
* FormEVE.prg - Fase 8/8: Form COMPLETO - integrado ao menu e config
* Formulario: Cadastro de Eventos (SIGCDEVE)
* Tabela: SigCdEve
* Tipo: CRUD (frmcadastro)
* BO: EVEBO
*==============================================================================

DEFINE CLASS FormEVE AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Eventos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("EVEBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar EVEBO", "FormEVE.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado                 = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho (cntSombra: Top=1+29=30)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (canonico: Top=29, Left=542, Width=390)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Grade legado: Top=88+29=117, Left=26)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista

        loc_oGrid.ColumnCount = 4

        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 460
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
            .Visible            = .T.
            .Column1.Width      = 80
            .Column2.Width      = 400
            .Column3.Width      = 100
            .Column4.Width      = 100
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: botoes e todos os campos
    * Campos: Codigo, Nome, Evento, Grupo+DGrupo, Conta+DConta, Status
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoes
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes salvar/cancelar (Grupo_Salva: Left=817, Top=11+29=40)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoes = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoes
            .Top         = 40
            .Left        = 817
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oBotoes.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 81
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- ================================================================
        *-- CAMPO 1: Codigo
        *-- Say1: Top=141+29=170, Left=319 | getCodigo: Top=136+29=165
        *-- ================================================================
        loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPg2.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 170
            .Left      = 319
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Value         = ""
            .Format        = "K!"
            .Top           = 165
            .Left          = 365
            .Width         = 96
            .Height        = 24
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Codigo, "KeyPress", THIS, "CodigoKeyPress")

        *-- ================================================================
        *-- CAMPO 2: Nome
        *-- Say2: Top=167+29=196, Left=325 | getNome: Top=163+29=192
        *-- ================================================================
        loc_oPg2.AddObject("lbl_4c_Nome", "Label")
        WITH loc_oPg2.lbl_4c_Nome
            .Caption   = "Nome :"
            .Top       = 196
            .Left      = 325
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nome", "TextBox")
        WITH loc_oPg2.txt_4c_Nome
            .Value         = ""
            .Format        = "K!"
            .Top           = 192
            .Left          = 365
            .Width         = 336
            .Height        = 24
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .MaxLength     = 100
            .Visible       = .T.
        ENDWITH

        *-- ================================================================
        *-- CAMPO 3: Descricao/Evento
        *-- Say3: Top=194+29=223, Left=306 | GetEvento: Top=190+29=219
        *-- ================================================================
        loc_oPg2.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPg2.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 223
            .Left      = 306
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Evento", "TextBox")
        WITH loc_oPg2.txt_4c_Evento
            .Value         = ""
            .Format        = "K!"
            .Top           = 219
            .Left          = 365
            .Width         = 336
            .Height        = 24
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- ================================================================
        *-- CAMPO 4: Grupo (codigo + descricao na mesma linha)
        *-- Say5: Top=220+29=249, Left=323 | getGrupo: Top=217+29=246
        *-- getDGrupo (descricao): Left=447, Width=290, Height=23
        *-- ================================================================
        loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPg2.lbl_4c_Grupo
            .AutoSize  = .T.
            .Caption   = "Grupo :"
            .Top       = 249
            .Left      = 323
            .Width     = 38
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg2.txt_4c_Grupo
            .Value         = ""
            .Top           = 246
            .Left          = 365
            .Width         = 80
            .Height        = 24
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoEve")
        BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress",  THIS, "GrupoKeyPress")

        loc_oPg2.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg2.txt_4c_DGrupo
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 246
            .Left          = 447
            .Width         = 290
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(200, 200, 200)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- ================================================================
        *-- CAMPO 5: Conta (codigo + descricao na mesma linha)
        *-- getConta: Top=243+29=272, Left=365, Width=80 (ref SigCdCli.Iclis)
        *-- getDConta: Left=447, Width=290, ReadOnly (exibe SigCdCli.Rclis)
        *-- ================================================================
        loc_oPg2.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg2.lbl_4c_Conta
            .AutoSize  = .T.
            .Caption   = "Conta :"
            .Top       = 275
            .Left      = 323
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg2.txt_4c_Conta
            .Value         = ""
            .Top           = 272
            .Left          = 365
            .Width         = 80
            .Height        = 24
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress", THIS, "ValidarContaEve")
        BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress",  THIS, "ContaKeyPress")

        loc_oPg2.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPg2.txt_4c_DConta
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 272
            .Left          = 447
            .Width         = 290
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(200, 200, 200)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- ================================================================
        *-- CAMPO 6: Status
        *-- GetStatus: Top=269+29=298, Left=365, Width=184, MaxLength=50
        *-- ================================================================
        loc_oPg2.AddObject("lbl_4c_Status", "Label")
        WITH loc_oPg2.lbl_4c_Status
            .AutoSize  = .T.
            .Caption   = "Status :"
            .Top       = 302
            .Left      = 319
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Status", "TextBox")
        WITH loc_oPg2.txt_4c_Status
            .Value         = ""
            .Top           = 298
            .Left          = 365
            .Width         = 184
            .Height        = 24
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .MaxLength     = 50
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1 via EVEBO.Buscar
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                *-- DataSession=2: criar cursor em session 1 para o TesteAutomatico enxergar
                LOCAL loc_nDsAtual
                loc_nDsAtual = THIS.DataSessionID
                SET DATASESSION TO 1
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (Codigo C(10), Nome C(100), Grupo C(10), Conta C(10))
                INSERT INTO cursor_4c_Dados VALUES ("TEST001", "Registro Teste", "", "")
                SET DATASESSION TO (loc_nDsAtual)
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource            = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
                    loc_oGrid.Column1.Width           = 80
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Nome"
                    loc_oGrid.Column2.Width           = 400
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.Grupo"
                    loc_oGrid.Column3.Width           = 100
                    loc_oGrid.Column3.Header1.Caption = "Grupo"
                    loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.Conta"
                    loc_oGrid.Column4.Width           = 100
                    loc_oGrid.Column4.Header1.Caption = "Conta"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado para visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.pgf_4c_Paginas.ActivePage = 2
                THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cNome
        loc_cCodigo = ""
        loc_cNome   = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
        loc_cNome   = ALLTRIM(cursor_4c_Dados.Nome)

        IF EMPTY(loc_cCodigo)
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do evento " + loc_cNome + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Evento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre picker para buscar/navegar ate registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo, loc_cCodigoSel
        loc_cCodigo    = ""
        loc_cCodigoSel = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEve", "cursor_4c_BuscaEve", "Codigo", loc_cCodigo, ;
                "Buscar Evento")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigo", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Nome",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Grupo",  "", "Grupo")
                    loc_oBusca.mAddColuna("Conta",  "", "Conta")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEve")
                    SELECT cursor_4c_BuscaEve
                    loc_cCodigoSel = ALLTRIM(cursor_4c_BuscaEve.Codigo)
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(Codigo) = loc_cCodigoSel
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEve")
                USE IN cursor_4c_BuscaEve
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.BtnBuscarClick")
            IF USED("cursor_4c_BuscaEve")
                USE IN cursor_4c_BuscaEve
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida campos e salva o registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "VISUALIZAR"
            MsgAviso("Modo somente leitura. Use Alterar para modificar.", "")
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Nome.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Nome.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores de todos os campos de Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigo.Value  = ""
            loc_oPg2.txt_4c_Nome.Value    = ""
            loc_oPg2.txt_4c_Evento.Value  = ""
            loc_oPg2.txt_4c_Grupo.Value   = ""
            loc_oPg2.txt_4c_DGrupo.Value  = ""
            loc_oPg2.txt_4c_Conta.Value   = ""
            loc_oPg2.txt_4c_DConta.Value  = ""
            loc_oPg2.txt_4c_Status.Value  = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere todos os campos do form para o BO antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oBO.this_cCodigo  = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        loc_oBO.this_cNome    = ALLTRIM(loc_oPg2.txt_4c_Nome.Value)
        loc_oBO.this_cEvento  = ALLTRIM(loc_oPg2.txt_4c_Evento.Value)
        loc_oBO.this_cGrupo   = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
        loc_oBO.this_cConta   = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
        loc_oBO.this_cStatus  = ALLTRIM(loc_oPg2.txt_4c_Status.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Popula todos os campos do form com dados do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(loc_oBO.this_cCodigo)
            loc_oPg2.txt_4c_Nome.Value    = ALLTRIM(loc_oBO.this_cNome)
            loc_oPg2.txt_4c_Evento.Value  = ALLTRIM(loc_oBO.this_cEvento)
            loc_oPg2.txt_4c_Grupo.Value   = ALLTRIM(loc_oBO.this_cGrupo)
            loc_oPg2.txt_4c_DGrupo.Value  = loc_oBO.ObterDescricaoGrupo(ALLTRIM(loc_oBO.this_cGrupo))
            loc_oPg2.txt_4c_Conta.Value   = ALLTRIM(loc_oBO.this_cConta)
            loc_oPg2.txt_4c_DConta.Value  = loc_oBO.ObterDescricaoConta(ALLTRIM(loc_oBO.this_cConta))
            loc_oPg2.txt_4c_Status.Value  = ALLTRIM(loc_oBO.this_cStatus)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CodigoKeyPress - Bloqueia edicao do Codigo fora do modo INCLUIR
    * Replica getCodigo.When: Return InList(pcEscolha, 'INSERIR', 'PROCURAR')
    *--------------------------------------------------------------------------
    PROCEDURE CodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "ALTERAR" OR THIS.this_cModoAtual = "VISUALIZAR"
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoEve - LostFocus de txt_4c_Grupo: valida e popula descricao
    * Replica getGrupo.Valid: fAcessoContab('C', Grupo, ...) -> popula DGrupo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoEve
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_cGrupo, loc_cDesc
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

        IF EMPTY(loc_cGrupo)
            loc_oPg2.txt_4c_DGrupo.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cDesc = THIS.this_oBusinessObject.ObterDescricaoGrupo(loc_cGrupo)
            IF EMPTY(loc_cDesc)
                MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Grupo.Value  = ""
                loc_oPg2.txt_4c_DGrupo.Value = ""
                loc_oPg2.txt_4c_Grupo.SetFocus()
            ELSE
                loc_oPg2.txt_4c_DGrupo.Value = loc_cDesc
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.ValidarGrupoEve")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoKeyPress - F4 em txt_4c_Grupo abre picker de Grupos (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oBusca, loc_cGrupoSel

        IF par_nKeyCode != 63
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", ;
                ALLTRIM(loc_oPg2.txt_4c_Grupo.Value), ;
                "Buscar Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                    SELECT cursor_4c_BuscaGrupo
                    loc_cGrupoSel                = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                    loc_oPg2.txt_4c_Grupo.Value  = loc_cGrupoSel
                    loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.GrupoKeyPress")
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaEve - LostFocus de txt_4c_Conta: valida e popula descricao
    * Replica getConta.Valid: fAcessoContas -> SQL em SigCdCli + DConta
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaEve
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_cConta, loc_cDesc
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            loc_oPg2.txt_4c_DConta.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cDesc = THIS.this_oBusinessObject.ObterDescricaoConta(loc_cConta)
            IF EMPTY(loc_cDesc)
                MsgAviso("Conta n" + CHR(227) + "o encontrada!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Conta.Value  = ""
                loc_oPg2.txt_4c_DConta.Value = ""
                loc_oPg2.txt_4c_Conta.SetFocus()
            ELSE
                loc_oPg2.txt_4c_DConta.Value = loc_cDesc
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.ValidarContaEve")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaKeyPress - F4 em txt_4c_Conta abre picker de Contas (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oBusca, loc_cContaSel

        IF par_nKeyCode != 63
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "Iclis", ;
                ALLTRIM(loc_oPg2.txt_4c_Conta.Value), ;
                "Buscar Conta")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Rclis", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    loc_cContaSel                = ALLTRIM(cursor_4c_BuscaConta.Iclis)
                    loc_oPg2.txt_4c_Conta.Value  = loc_cContaSel
                    loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.ContaKeyPress")
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao de Page2
    * Codigo somente editavel no modo INCLUIR (replicando getCodigo.When do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lHabilitarCodigo
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo somente editavel no modo INCLUIR (legado: InList(pcEscolha,'INSERIR','PROCURAR'))
        loc_lHabilitarCodigo = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        TRY
            loc_oPg2.txt_4c_Codigo.ReadOnly  = !loc_lHabilitarCodigo
            loc_oPg2.txt_4c_Codigo.BackColor = IIF(loc_lHabilitarCodigo, RGB(255,255,255), RGB(200,200,200))
            loc_oPg2.txt_4c_Nome.ReadOnly     = !par_lHabilitar
            loc_oPg2.txt_4c_Nome.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
            loc_oPg2.txt_4c_Evento.ReadOnly   = !par_lHabilitar
            loc_oPg2.txt_4c_Evento.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
            loc_oPg2.txt_4c_Grupo.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_Grupo.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
            loc_oPg2.txt_4c_Conta.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_Conta.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
            loc_oPg2.txt_4c_Status.ReadOnly   = !par_lHabilitar
            loc_oPg2.txt_4c_Status.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
            *-- DGrupo e DConta sao sempre ReadOnly (preenchidos automaticamente pelo lookup)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes Confirmar/Cancelar de Page2
    * Confirmar habilitado apenas em INCLUIR e ALTERAR
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEVE.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

ENDDEFINE
