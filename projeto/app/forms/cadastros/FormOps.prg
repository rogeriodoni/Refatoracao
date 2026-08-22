*==============================================================================
* FormOps.prg - Formulario de Cadastro Simplificado de Operacoes
* Migrado de: SIGCDOPS.SCX (frmcadastro)
* Tabela: SigCdOpe (dopes, ndopes, titopes, menus, submenus, ordes, cmoes,
*                   copers, obsopes, tipoops, abrevs, nivels, nfiscals)
* Inativacao: SigOpCdc (opeinatvs)
* Gerado: Fase 8/8 COMPLETO - Todos os metodos implementados + integrado ao menu.prg
*==============================================================================

DEFINE CLASS FormOps AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    MaxButton   = .F.
    Closable    = .F.
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2
    ShowTips    = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, cursor placeholder, PageFrame e controles
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("OpsBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OpsBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOps.InicializarForm")
            ELSE
                *-- Cursor placeholder para o grid (DataSession=2 isolado)
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ;
                    (Dopes C(20), NDopes N(4,0), Abrevs C(20), CMoes C(3), ;
                     Nivels C(20), Menus C(10), SubMenus C(15), Ordes N(4,0), ;
                     TipoOps N(2,0), DopMenus C(30), Inativas N(1,0))
                SET NULL OFF

                THIS.ConfigurarPageFrame()

                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                    .lbl_4c_Sombra.Caption = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
                    .lbl_4c_Titulo.Caption = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
                    .Visible = .T.
                ENDWITH

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormOps:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormOps.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame com 2 paginas (Lista + Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
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
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtro e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra: top=1+29=30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
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
            .Caption   = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op.Top=0, Left=539; compensado Top=29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Container Saida - PADRAO CANONICO (Left=917, Width=90; Top compensado=29)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- OptionGroup Filtro Situacao (optFilSituas: top=85+29=114, left=13)
        *-- 1=Geral, 2=Ativos, 3=Inativos (original: pStI/pStF controla WHERE OpeInatvs)
        loc_oPagina.AddObject("opt_4c_FilSituas", "OptionGroup")
        WITH loc_oPagina.opt_4c_FilSituas
            .ButtonCount = 3
            .Top         = 114
            .Left        = 13
            .Width       = 201
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_FilSituas.Buttons(1)
            .Caption   = "Geral"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 55
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 1
        ENDWITH
        WITH loc_oPagina.opt_4c_FilSituas.Buttons(2)
            .Caption   = "Ativos"
            .BackStyle = 0
            .Left      = 63
            .Top       = 5
            .Width     = 60
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_FilSituas.Buttons(3)
            .Caption   = "Inativos"
            .BackStyle = 0
            .Left      = 126
            .Top       = 5
            .Width     = 65
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_FilSituas, "InteractiveChange", THIS, "OptFilSituasChanged")

        *-- Botao Cond. Pagto (cmdFPOper: top=82+29=111, left=510, w=136, h=45)
        loc_oPagina.AddObject("cmd_4c_CmdFPOper", "CommandButton")
        WITH loc_oPagina.cmd_4c_CmdFPOper
            .Caption       = "Cond. Pagto."
            .Top           = 111
            .Left          = 510
            .Width         = 136
            .Height        = 45
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_CmdFPOper, "Click", THIS, "BtnFpOperClick")

        *-- Botao Tabelas (TabDesconto: top=82+29=111, left=647, w=136, h=45)
        loc_oPagina.AddObject("cmd_4c_TabDesconto", "CommandButton")
        WITH loc_oPagina.cmd_4c_TabDesconto
            .Caption       = "Tabelas"
            .Top           = 111
            .Left          = 647
            .Width         = 136
            .Height        = 45
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_TabDesconto, "Click", THIS, "BtnTabDescontoClick")

        *-- Botao Monta Grade (MontaLista: top=82+29=111, left=783, w=136, h=45)
        loc_oPagina.AddObject("cmd_4c_MontaLista", "CommandButton")
        WITH loc_oPagina.cmd_4c_MontaLista
            .Caption       = "Monta Grade"
            .Top           = 111
            .Left          = 783
            .Width         = 136
            .Height        = 45
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_MontaLista, "Click", THIS, "BtnMontaListaClick")

        *-- Grid (Grade: top=130+29=159; left=13; w=938; h=420)
        *-- RecordSource/ColumnCount definidos em CarregarLista() - Problema 36/48
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.Top            = 159
        loc_oPagina.grd_4c_Lista.Left           = 13
        loc_oPagina.grd_4c_Lista.Width          = 938
        loc_oPagina.grd_4c_Lista.Height         = 420
        loc_oPagina.grd_4c_Lista.FontName       = "Tahoma"
        loc_oPagina.grd_4c_Lista.FontSize       = 8
        loc_oPagina.grd_4c_Lista.ForeColor      = RGB(90, 90, 90)
        loc_oPagina.grd_4c_Lista.BackColor      = RGB(255, 255, 255)
        loc_oPagina.grd_4c_Lista.GridLineColor  = RGB(238, 238, 238)
        loc_oPagina.grd_4c_Lista.HighlightBackColor = RGB(255, 255, 255)
        loc_oPagina.grd_4c_Lista.HighlightForeColor = RGB(15, 41, 104)
        loc_oPagina.grd_4c_Lista.HighlightStyle = 2
        loc_oPagina.grd_4c_Lista.GridLines      = 3
        loc_oPagina.grd_4c_Lista.DeleteMark     = .F.
        loc_oPagina.grd_4c_Lista.RecordMark     = .F.
        loc_oPagina.grd_4c_Lista.RowHeight      = 16
        loc_oPagina.grd_4c_Lista.ScrollBars     = 2
        loc_oPagina.grd_4c_Lista.ReadOnly       = .T.
        loc_oPagina.grd_4c_Lista.Visible        = .T.

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: COMPLETO (botoes + todos os campos e labels)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Botoes Acao (Grupo_Salva: top=7+29=36, left=821, w=160, h=85)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 36
            .Left        = 821
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (cmd_Confirmar: left=5, top=5, w=75, h=75)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (cmd_Cancelar: left=80, top=5, w=75, h=75)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- OptionGroup Movimento (op_ocx: top=61+29=90, left=298, w=123, h=25)
        *-- Copers: 1=Entrada, 2=Saida (Value=1 mapeado para Copers=0, Value=2 para Copers=1)
        loc_oPagina.AddObject("obj_4c_Op_ocx", "OptionGroup")
        WITH loc_oPagina.obj_4c_Op_ocx
            .ButtonCount = 2
            .Top         = 90
            .Left        = 298
            .Width       = 128
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Op_ocx.Buttons(1)
            .Caption   = "Entrada"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 60
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 1
        ENDWITH
        WITH loc_oPagina.obj_4c_Op_ocx.Buttons(2)
            .Caption   = "Sa" + CHR(237) + "da"
            .BackStyle = 0
            .Left      = 63
            .Top       = 5
            .Width     = 55
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Movimento (Say23: top=65+29=94, left=238, w=61, h=15)
        loc_oPagina.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oPagina.lbl_4c_Label23
            .Caption   = "Movimento :"
            .Top       = 94
            .Left      = 238
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_desc/txt_4c_Desc: top=87+29=116, left=303, w=179, h=23)
        *-- Bind: Dopes (PK) - editavel apenas em INCLUIR
        loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPagina.txt_4c_Desc
            .Value     = ""
            .Top       = 116
            .Left      = 303
            .Width     = 179
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .ReadOnly  = .T.
            .MaxLength = 20
            .Visible   = .T.
        ENDWITH

        *-- Label Codigo (Say1: top=91+29=120, left=257, w=42, h=15)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 120
            .Left      = 257
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- CheckBox Inativar (Chk_Inativar/chk_4c_Chk_Inativar: top=91+29=120, left=495, w=65, h=15)
        *-- Bind: OpeInatvs (0=Ativa, 1=Inativa) -> Logical
        loc_oPagina.AddObject("chk_4c_Chk_Inativar", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_Inativar
            .Caption   = "INATIVA"
            .Value     = 0
            .Top       = 120
            .Left      = 495
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao/TitOpes (Get1/txt_4c_1: top=112+29=141, left=303, w=179, h=23)
        loc_oPagina.AddObject("txt_4c_1", "TextBox")
        WITH loc_oPagina.txt_4c_1
            .Value     = ""
            .Top       = 141
            .Left      = 303
            .Width     = 179
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .ReadOnly  = .T.
            .MaxLength = 30
            .Visible   = .T.
        ENDWITH

        *-- Label Descricao (Say28: top=116+29=145, left=244, w=57, h=15)
        loc_oPagina.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPagina.lbl_4c_Label28
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 145
            .Left      = 244
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- ComboBox Menu (cmbMenus/cbo_4c_CmbMenus: top=137+29=166, left=303, w=179, h=23)
        *-- Bind: Menus (char 10)
        loc_oPagina.AddObject("cbo_4c_CmbMenus", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbMenus
            .Value         = ""
            .Top           = 166
            .Left          = 303
            .Width         = 179
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .RowSourceType = 0
            .Style         = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Menu (Say3: top=141+29=170, left=264, w=35, h=15)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Menu :"
            .Top       = 170
            .Left      = 264
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox SubMenu (getSubMenus/txt_4c_SubMenus: top=163+29=192, left=303, w=108, h=23)
        *-- Bind: SubMenus (char 15)
        loc_oPagina.AddObject("txt_4c_SubMenus", "TextBox")
        WITH loc_oPagina.txt_4c_SubMenus
            .Value     = ""
            .Top       = 192
            .Left      = 303
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .ReadOnly  = .T.
            .MaxLength = 15
            .Visible   = .T.
        ENDWITH

        *-- Label Submenu (Say12: top=167+29=196, left=246, w=57, h=15)
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Submenu :"
            .Top       = 196
            .Left      = 246
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Label Ord. (Say5: top=167+29=196, left=417, w=28, h=15)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Ord.:"
            .Top       = 196
            .Left      = 417
            .Width     = 28
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Ordem (Get_ordem/txt_4c_Ordem: top=163+29=192, left=448, w=34, h=23)
        *-- Bind: Ordes (numeric 4,0)
        loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
        WITH loc_oPagina.txt_4c_Ordem
            .Value     = 0
            .Top       = 192
            .Left      = 448
            .Width     = 34
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .ReadOnly  = .T.
            .MaxLength = 4
            .Visible   = .T.
        ENDWITH

        *-- Label Tipo (Say4: top=192+29=221, left=270, w=29, h=15)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Tipo :"
            .Top       = 221
            .Left      = 270
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- ComboBox TipoOps (cmbTOpers/cbo_4c_CmbTOpers: top=188+29=217, left=303, w=179, h=23)
        *-- Bind: TipoOps (numeric 2,0) - exibido como string no combo
        loc_oPagina.AddObject("cbo_4c_CmbTOpers", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbTOpers
            .Value         = ""
            .Top           = 217
            .Left          = 303
            .Width         = 179
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .RowSourceType = 0
            .Style         = 2
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Numero (Say25: top=219+29=248, left=253, w=46, h=15)
        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Caption   = "N" + CHR(250) + "mero :"
            .Top       = 248
            .Left      = 253
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox NDopes (Get_NDopes/txt_4c_NDopes: top=215+29=244, left=303, w=31, h=23)
        *-- Bind: NDopes (numeric 4,0)
        loc_oPagina.AddObject("txt_4c_NDopes", "TextBox")
        WITH loc_oPagina.txt_4c_NDopes
            .Value     = 0
            .Top       = 244
            .Left      = 303
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .ReadOnly  = .T.
            .MaxLength = 4
            .Visible   = .T.
        ENDWITH

        *-- Label Moeda (Say7: top=219+29=248, left=404, w=41, h=15)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Moeda :"
            .Top       = 248
            .Left      = 404
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Moeda (Get_moeda/txt_4c_Moeda: top=215+29=244, left=448, w=34, h=23)
        *-- Bind: CMoes (char 3)
        loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Moeda
            .Value     = ""
            .Top       = 244
            .Left      = 448
            .Width     = 34
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .ReadOnly  = .T.
            .MaxLength = 3
            .Visible   = .T.
        ENDWITH

        *-- Label Observacao (Say2: top=242+29=271, left=232, w=67, h=15)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 271
            .Left      = 232
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- EditBox Observacoes (MemoObs/obj_4c_MemoObs: top=241+29=270, left=302, w=505, h=201)
        *-- Bind: ObsOpes (text/memo)
        loc_oPagina.AddObject("obj_4c_MemoObs", "EditBox")
        WITH loc_oPagina.obj_4c_MemoObs
            .Value      = ""
            .Top        = 270
            .Left       = 302
            .Width      = 505
            .Height     = 201
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .ReadOnly   = .T.
            .ScrollBars = 2
            .Visible    = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no grid com filtro de situacao
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                *-- Determinar filtro com base no OptionGroup (se ja existir)
                loc_cFiltro = ""
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "opt_4c_FilSituas", 5)
                        DO CASE
                            CASE THIS.pgf_4c_Paginas.Page1.opt_4c_FilSituas.Value = 2
                                loc_cFiltro = "Ativo"
                            CASE THIS.pgf_4c_Paginas.Page1.opt_4c_FilSituas.Value = 3
                                loc_cFiltro = "Inativo"
                        ENDCASE
                    ENDIF
                ENDIF

                IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA de WITH (Problema 36/48)
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 10

                    *-- ControlSource + captions + larguras APOS RecordSource
                    WITH loc_oGrid
                        .Column1.ControlSource     = "cursor_4c_Dados.Dopes"
                        .Column1.Width             = 80
                        .Column1.Alignment         = 0
                        .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
                        .Column1.Header1.Alignment = 2

                        .Column2.ControlSource     = "cursor_4c_Dados.NDopes"
                        .Column2.Width             = 50
                        .Column2.Alignment         = 1
                        .Column2.Header1.Caption   = "N" + CHR(250) + "m."
                        .Column2.Header1.Alignment = 2

                        .Column3.ControlSource     = "cursor_4c_Dados.Abrevs"
                        .Column3.Width             = 60
                        .Column3.Alignment         = 0
                        .Column3.Header1.Caption   = "Abrev."
                        .Column3.Header1.Alignment = 2

                        .Column4.ControlSource     = "cursor_4c_Dados.CMoes"
                        .Column4.Width             = 50
                        .Column4.Alignment         = 0
                        .Column4.Header1.Caption   = "Moeda"
                        .Column4.Header1.Alignment = 2

                        .Column5.ControlSource     = "cursor_4c_Dados.Menus"
                        .Column5.Width             = 70
                        .Column5.Alignment         = 0
                        .Column5.Header1.Caption   = "Menu"
                        .Column5.Header1.Alignment = 2

                        .Column6.ControlSource     = "cursor_4c_Dados.SubMenus"
                        .Column6.Width             = 100
                        .Column6.Alignment         = 0
                        .Column6.Header1.Caption   = "Submenu"
                        .Column6.Header1.Alignment = 2

                        .Column7.ControlSource     = "cursor_4c_Dados.Ordes"
                        .Column7.Width             = 50
                        .Column7.Alignment         = 1
                        .Column7.Header1.Caption   = "Ordem"
                        .Column7.Header1.Alignment = 2

                        .Column8.ControlSource     = "cursor_4c_Dados.TipoOps"
                        .Column8.Width             = 50
                        .Column8.Alignment         = 1
                        .Column8.Header1.Caption   = "Tipo"
                        .Column8.Header1.Alignment = 2

                        .Column9.ControlSource     = "cursor_4c_Dados.DopMenus"
                        .Column9.Width             = 140
                        .Column9.Alignment         = 0
                        .Column9.Header1.Caption   = "Menu Op."
                        .Column9.Header1.Alignment = 2

                        .Column10.ControlSource     = "cursor_4c_Dados.Inativas"
                        .Column10.Width             = 50
                        .Column10.Alignment         = 1
                        .Column10.Header1.Caption   = "Inativa"
                        .Column10.Header1.Alignment = 2
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, ;
                "FormOps.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, ;
                "FormOps.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Dopes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada!")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Dopes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada!")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Dopes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada!")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da opera" + ;
            CHR(231) + CHR(227) + "o '" + loc_cCodigo + "'?", "Excluir")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista com filtro atual do OptionGroup
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnFpOperClick - Abre form de Condicao de Pagamento (SigCdFpo)
    * Original: If Reccount() <> 0 / Do Form SigCdFpo With Thisform, DataSessionId
    *==========================================================================
    PROCEDURE BtnFpOperClick()
        LOCAL loc_cDopes
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cDopes = ALLTRIM(cursor_4c_Dados.Dopes)
        IF !EMPTY(loc_cDopes)
            MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento para: " + loc_cDopes + ;
                CHR(13) + "(SigCdFpo - migrar como tarefa separada)")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnTabDescontoClick - Abre form de Tabela de Desconto (SigCdTbO)
    * Original: If Reccount() <> 0 / Do Form SigCdTbO With Thisform, DataSessionId
    *==========================================================================
    PROCEDURE BtnTabDescontoClick()
        LOCAL loc_cDopes
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cDopes = ALLTRIM(cursor_4c_Dados.Dopes)
        IF !EMPTY(loc_cDopes)
            MsgAviso("Tabelas de Desconto para: " + loc_cDopes + ;
                CHR(13) + "(SigCdTbO - migrar como tarefa separada)")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMontaListaClick - Abre form de Listagem de Operacoes (SigLlOpe)
    * Original: If Reccount() <> 0 / Do Form SigLlOpe With Thisform, CrSigCdOpe.Dopes
    *==========================================================================
    PROCEDURE BtnMontaListaClick()
        LOCAL loc_cDopes
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cDopes = ALLTRIM(cursor_4c_Dados.Dopes)
        IF !EMPTY(loc_cDopes)
            MsgAviso("Monta Grade para: " + loc_cDopes + ;
                CHR(13) + "(SigLlOpe - migrar como tarefa separada)")
        ENDIF
    ENDPROC

    *==========================================================================
    * OptFilSituasChanged - Recarrega lista ao mudar filtro de situacao
    *==========================================================================
    PROCEDURE OptFilSituasChanged()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos da Page2 por modo
    * Fase 5: campos da primeira metade (txt_4c_Desc, txt_4c_1, cbo_4c_CmbMenus,
    *         txt_4c_SubMenus, chk_4c_Chk_Inativar, obj_4c_Op_ocx)
    * Fase 6 completara com os demais campos
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdt
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lEdt = (par_lHabilitar = .T.)

        *-- Dopes (PK): editavel apenas em INCLUIR (nunca alterar PK)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            loc_oPg2.txt_4c_Desc.ReadOnly = !(loc_lEdt AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_1", 5)
            loc_oPg2.txt_4c_1.ReadOnly = !loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbMenus", 5)
            loc_oPg2.cbo_4c_CmbMenus.Enabled = loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_SubMenus", 5)
            loc_oPg2.txt_4c_SubMenus.ReadOnly = !loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
            loc_oPg2.chk_4c_Chk_Inativar.Enabled = loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Op_ocx", 5)
            loc_oPg2.obj_4c_Op_ocx.Enabled = loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.ReadOnly = !loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTOpers", 5)
            loc_oPg2.cbo_4c_CmbTOpers.Enabled = loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_NDopes", 5)
            loc_oPg2.txt_4c_NDopes.ReadOnly = !loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
            loc_oPg2.txt_4c_Moeda.ReadOnly = !loc_lEdt
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_MemoObs", 5)
            loc_oPg2.obj_4c_MemoObs.ReadOnly = !loc_lEdt
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            loc_oPg2.txt_4c_Desc.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_1", 5)
            loc_oPg2.txt_4c_1.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbMenus", 5)
            loc_oPg2.cbo_4c_CmbMenus.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_SubMenus", 5)
            loc_oPg2.txt_4c_SubMenus.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
            loc_oPg2.chk_4c_Chk_Inativar.Value = 0
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Op_ocx", 5)
            loc_oPg2.obj_4c_Op_ocx.Value = 1
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.Value = 0
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTOpers", 5)
            loc_oPg2.cbo_4c_CmbTOpers.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_NDopes", 5)
            loc_oPg2.txt_4c_NDopes.Value = 0
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
            loc_oPg2.txt_4c_Moeda.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_MemoObs", 5)
            loc_oPg2.obj_4c_MemoObs.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            THIS.this_oBusinessObject.this_cDopes    = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_1", 5)
            THIS.this_oBusinessObject.this_cTitOpes  = ALLTRIM(loc_oPg2.txt_4c_1.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbMenus", 5)
            THIS.this_oBusinessObject.this_cMenus    = ALLTRIM(loc_oPg2.cbo_4c_CmbMenus.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_SubMenus", 5)
            THIS.this_oBusinessObject.this_cSubMenus = ALLTRIM(loc_oPg2.txt_4c_SubMenus.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
            THIS.this_oBusinessObject.this_nOpeInatvs = ;
                IIF(loc_oPg2.chk_4c_Chk_Inativar.Value = 1, 1, 0)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Op_ocx", 5)
            *-- Value=1 -> Copers=0(Entrada), Value=2 -> Copers=1(Saida)
            THIS.this_oBusinessObject.this_nCopers = loc_oPg2.obj_4c_Op_ocx.Value - 1
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            THIS.this_oBusinessObject.this_nOrdes   = loc_oPg2.txt_4c_Ordem.Value
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTOpers", 5)
            THIS.this_oBusinessObject.this_nTipoOps = ;
                IIF(EMPTY(ALLTRIM(loc_oPg2.cbo_4c_CmbTOpers.Value)), ;
                    0, VAL(ALLTRIM(loc_oPg2.cbo_4c_CmbTOpers.Value)))
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_NDopes", 5)
            THIS.this_oBusinessObject.this_nNDopes  = loc_oPg2.txt_4c_NDopes.Value
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
            THIS.this_oBusinessObject.this_cCmoes   = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_MemoObs", 5)
            THIS.this_oBusinessObject.this_cObsOpes = loc_oPg2.obj_4c_MemoObs.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Desc", 5)
            loc_oPg2.txt_4c_Desc.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_1", 5)
            loc_oPg2.txt_4c_1.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTitOpes)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbMenus", 5)
            loc_oPg2.cbo_4c_CmbMenus.Value = ALLTRIM(THIS.this_oBusinessObject.this_cMenus)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_SubMenus", 5)
            loc_oPg2.txt_4c_SubMenus.Value = ALLTRIM(THIS.this_oBusinessObject.this_cSubMenus)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
            loc_oPg2.chk_4c_Chk_Inativar.Value = ;
                (THIS.this_oBusinessObject.this_nOpeInatvs = 1)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Op_ocx", 5)
            *-- Copers=0 -> Value=1(Entrada), Copers=1 -> Value=2(Saida)
            loc_oPg2.obj_4c_Op_ocx.Value = THIS.this_oBusinessObject.this_nCopers + 1
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.Value   = THIS.this_oBusinessObject.this_nOrdes
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTOpers", 5)
            loc_oPg2.cbo_4c_CmbTOpers.Value = ;
                IIF(THIS.this_oBusinessObject.this_nTipoOps = 0, "", ;
                    ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nTipoOps)))
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_NDopes", 5)
            loc_oPg2.txt_4c_NDopes.Value  = THIS.this_oBusinessObject.this_nNDopes
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
            loc_oPg2.txt_4c_Moeda.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cCmoes)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_MemoObs", 5)
            loc_oPg2.obj_4c_MemoObs.Value = THIS.this_oBusinessObject.this_cObsOpes
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botoes de Page2 conforme modo atual
    * INCLUIR/ALTERAR: Salvar habilitado | VISUALIZAR: Salvar desabilitado
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lSalvar
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lSalvar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Salvar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lSalvar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva registro (Confirmar): chama FormParaBO + BO.Salvar()
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Opera" + CHR(231) + CHR(227) + "o salva com sucesso!")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
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
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
