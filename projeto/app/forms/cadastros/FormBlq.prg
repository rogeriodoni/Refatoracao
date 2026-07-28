*==============================================================================
* FormBlq.PRG - Fase 3/8: Form - Estrutura Base
* Formulario de Cadastro de Bloqueios por Periodo (SIGCDBLQ)
*
* Tabela: SigCdBlq
* Tipo: CRUD (frmcadastro)
* BO: BlqBO
*==============================================================================

DEFINE CLASS FormBlq AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Bloqueios por Periodo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

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
            MsgErro(loc_oErro.Message, "FormBlq.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Conecta BO e cria estrutura PageFrame
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("BlqBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar BlqBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBlq.InicializarForm")
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
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
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
    * ConfigurarPaginaLista - Cria containers base da Page1 (Lista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (cntSombra.Top=1 + 29 compensacao = 30)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 30
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
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

        *-- Container botoes CRUD (Grupo_op.Left=538, Top=-1 + 29 = 28)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top           = 28
            .Left          =  542
            .Width         = 390
            .Height        = 85
            .BackStyle     = 1
            .BackColor     = RGB(53, 53, 53)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Container Encerrar (canonico: Left=917, Top=29)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top           = 29
            .Left          = 917
            .Width         = 90
            .Height        = 85
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Botoes dentro de cnt_4c_Botoes (Incluir, Visualizar, Alterar, Excluir, Buscar)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Botao Encerrar no cnt_4c_Saida (canonico: Left=5, Top=5, Width=75, Height=75)
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
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Top=117=88+29, Left=26, Width=890, Height=490)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.RecordSource = ""
        loc_oPg1.grd_4c_Lista.ColumnCount  = 5
        WITH loc_oPg1.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 490
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
            .Column1.Width           = 80
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Width           = 74
            .Column2.Header1.Caption = "Data Inicial"
            .Column3.Width           = 74
            .Column3.Header1.Caption = "Data Final"
            .Column4.Width           = 80
            .Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
            .Column5.Width           = 52
            .Column5.Header1.Caption = "Inativo"
        ENDWITH
        BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca registros e popula o grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            CREATE CURSOR cursor_4c_Dados (Codigos C(10), dtInicial D, dtFinal D, ;
                UsuIncs C(20), DtIncs T, UsuAlts C(20), DtAlts T, inativo L)
            loc_lResultado = .T.
        ELSE
            TRY
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dtInicial"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dtFinal"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.UsuIncs"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.inativo"
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Data Inicial"
                    loc_oGrid.Column3.Header1.Caption = "Data Final"
                    loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
                    loc_oGrid.Column5.Header1.Caption = "Inativo"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBlq.CarregarLista")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            loc_lResultado = .F.
        ELSE
            TRY
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBlq.AlternarPagina")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria Page2 (Dados): parte 1/2 de campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container Confirmar/Cancelar (Grupo_Salva.Left=812, Top=24 + 29 = 53)
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top           = 53
            .Left          = 812
            .Width         = 160
            .Height        = 85
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
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
        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
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
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Say1: Label "C" + CHR(243) + "digo :"
        *-- Original: top=141, left=390 -> top+29=170
        loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPg2.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 170
            .Left      = 390
            .Width     = 45
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_Codigo: Campo codigo (auto-gerado no INSERT, editavel so em VISUALIZAR)
        *-- Original: top=137, left=435, width=82, height=23 -> top+29=166
        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Value       = ""
            .Top         = 166
            .Left        = 435
            .Width       = 82
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .ReadOnly    = .T.
            .Enabled     = .T.
            .Visible     = .T.
        ENDWITH

        *-- Check1: CheckBox "Inativo"
        *-- Original: top=141, left=542, width=52, height=15 -> top+29=170
        loc_oPg2.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oPg2.chk_4c_Check1
            .Caption   = "Inativo"
            .Value     = 0
            .Top       = 170
            .Left      = 542
            .Width     = 52
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say15: Label "Per" + CHR(237) + "odo :"
        *-- Original: top=167, left=387, width=45, height=13 -> top+29=196
        loc_oPg2.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg2.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 196
            .Left      = 387
            .Width     = 45
            .Height    = 13
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Say2: Label "At" + CHR(233)
        *-- Original: top=167, left=508, width=19 -> top+29=196
        loc_oPg2.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPg2.lbl_4c_Ate
            .Caption   = "At" + CHR(233)
            .Top       = 196
            .Left      = 508
            .Width     = 19
            .Height    = 13
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Getdtinicial: Data inicial do periodo
        *-- Original: top=163, left=435, width=66, height=23 -> top+29=192
        loc_oPg2.AddObject("txt_4c_Dtinicial", "TextBox")
        WITH loc_oPg2.txt_4c_Dtinicial
            .Value     = {}
            .Top       = 192
            .Left      = 435
            .Width     = 66
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- getdtfinal: Data final do periodo
        *-- Original: top=163, left=530, width=66, height=23 -> top+29=192
        loc_oPg2.AddObject("txt_4c_Dtfinal", "TextBox")
        WITH loc_oPg2.txt_4c_Dtfinal
            .Value     = {}
            .Top       = 192
            .Left      = 530
            .Width     = 66
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Shape3: Linha separadora horizontal da secao de auditoria
        *-- Original: top=235, left=435, width=161, height=2 -> top+29=264
        loc_oPg2.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPg2.shp_4c_Shape3
            .Top         = 264
            .Left        = 435
            .Width       = 161
            .Height      = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Say20: Titulo da secao de auditoria "Data / Usuario"
        *-- Original: top=220, left=435, width=84 -> top+29=249
        loc_oPg2.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPg2.lbl_4c_Label20
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 249
            .Left      = 435
            .Width     = 84
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say24: Label "Inclusao"
        *-- Original: top=239, left=435, width=42, height=15 -> top+29=268
        loc_oPg2.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPg2.lbl_4c_Label24
            .Caption   = "Inclus" + CHR(227) + "o"
            .Top       = 268
            .Left      = 435
            .Width     = 42
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say25: Label "Alteracao"
        *-- Original: top=239, left=515, width=48, height=15 -> top+29=268
        loc_oPg2.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPg2.lbl_4c_Label25
            .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
            .Top       = 268
            .Left      = 515
            .Width     = 48
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_DtIncs: Data de inclusao (readonly - auditoria)
        *-- Original: top=254, left=435, width=79, height=23 -> top+29=283
        loc_oPg2.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPg2.txt_4c_DtIncs
            .Value     = {}
            .Top       = 283
            .Left      = 435
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(200, 200, 200)
            .ReadOnly  = .T.
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Usuario: Usuario de inclusao (readonly - auditoria)
        *-- Original: top=279, left=435, width=79, height=23 -> top+29=308
        loc_oPg2.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPg2.txt_4c_Usuario
            .Value     = ""
            .Top       = 308
            .Left      = 435
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(200, 200, 200)
            .ReadOnly  = .T.
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- getDataAlts: Data de alteracao (readonly - auditoria)
        *-- Original: top=254, left=515, width=79, height=23 -> top+29=283
        loc_oPg2.AddObject("txt_4c_DataAlts", "TextBox")
        WITH loc_oPg2.txt_4c_DataAlts
            .Value     = {}
            .Top       = 283
            .Left      = 515
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(200, 200, 200)
            .ReadOnly  = .T.
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- getUsuaAlts: Usuario de alteracao (readonly - auditoria)
        *-- Original: top=279, left=515, width=79, height=23 -> top+29=308
        loc_oPg2.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH loc_oPg2.txt_4c_UsuaAlts
            .Value     = ""
            .Top       = 308
            .Left      = 515
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(200, 200, 200)
            .ReadOnly  = .T.
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
    * FormParaBO - Transfere valores do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigos   = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_dDtInicial = loc_oPg2.txt_4c_Dtinicial.Value
        THIS.this_oBusinessObject.this_dDtFinal   = loc_oPg2.txt_4c_Dtfinal.Value
        *-- CheckBox.Value eh numerico (0/1); converter para logico pois
        *-- prop this_lInativo eh logical (evita "Data type mismatch" no BO)
        THIS.this_oBusinessObject.this_lInativo   = (loc_oPg2.chk_4c_Check1.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(loc_oBO.this_cCodigos)
        loc_oPg2.txt_4c_Dtinicial.Value = loc_oBO.this_dDtInicial
        loc_oPg2.txt_4c_Dtfinal.Value   = loc_oBO.this_dDtFinal
        loc_oPg2.chk_4c_Check1.Value    = loc_oBO.this_lInativo
        loc_oPg2.txt_4c_DtIncs.Value    = loc_oBO.this_dDtIncs
        loc_oPg2.txt_4c_Usuario.Value    = ALLTRIM(loc_oBO.this_cUsuIncs)
        loc_oPg2.txt_4c_DataAlts.Value   = loc_oBO.this_dDtAlts
        loc_oPg2.txt_4c_UsuaAlts.Value   = ALLTRIM(loc_oBO.this_cUsuAlts)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value    = ""
        loc_oPg2.txt_4c_Dtinicial.Value = {}
        loc_oPg2.txt_4c_Dtfinal.Value   = {}
        loc_oPg2.chk_4c_Check1.Value    = 0
        loc_oPg2.txt_4c_DtIncs.Value    = {}
        loc_oPg2.txt_4c_Usuario.Value    = ""
        loc_oPg2.txt_4c_DataAlts.Value   = {}
        loc_oPg2.txt_4c_UsuaAlts.Value   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lModoEdicao
        loc_oPg2        = THIS.pgf_4c_Paginas.Page2
        loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Codigo: sempre ReadOnly (auto-gerado pelo BO)
        loc_oPg2.txt_4c_Codigo.ReadOnly = .T.
        loc_oPg2.txt_4c_Codigo.Enabled  = .T.

        *-- Periodo: editavel apenas em INCLUIR/ALTERAR
        loc_oPg2.txt_4c_Dtinicial.Enabled = loc_lModoEdicao
        loc_oPg2.txt_4c_Dtfinal.Enabled   = loc_lModoEdicao

        *-- Inativo: editavel apenas em INCLUIR/ALTERAR
        loc_oPg2.chk_4c_Check1.Enabled = loc_lModoEdicao

        *-- Campos de auditoria: sempre ReadOnly
        loc_oPg2.txt_4c_DtIncs.ReadOnly   = .T.
        loc_oPg2.txt_4c_DtIncs.Enabled    = .T.
        loc_oPg2.txt_4c_Usuario.ReadOnly   = .T.
        loc_oPg2.txt_4c_Usuario.Enabled    = .T.
        loc_oPg2.txt_4c_DataAlts.ReadOnly  = .T.
        loc_oPg2.txt_4c_DataAlts.Enabled   = .T.
        loc_oPg2.txt_4c_UsuaAlts.ReadOnly  = .T.
        loc_oPg2.txt_4c_UsuaAlts.Enabled   = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme o modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_oSalva
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_oSalva = loc_oPg2.cnt_4c_Salva

        loc_oSalva.cmd_4c_Confirmar.Enabled = !INLIST(THIS.this_cModoAtual, "VISUALIZAR")
        loc_oSalva.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Abre Page2 para inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)

        TRY
            THIS.pgf_4c_Paginas.Page2.txt_4c_Dtinicial.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBlq.BtnIncluirClick.SetFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN loc_lResultado
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBlq.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN loc_lResultado
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBlq.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do bloqueio" + CHR(13) + ;
                                    loc_cCodigo + "?", "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBlq.BtnExcluirClick")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Navega para Page2 em modo BUSCAR por codigo
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.F.)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.ReadOnly = .F.
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Enabled  = .T.
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBlq.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida dados e salva ou executa busca conforme o modo
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_dIni, loc_dFin, loc_lResultado
        LOCAL loc_cCodFiltro, loc_cFiltro, loc_oGrid
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        *-- Modo BUSCAR: pesquisar por codigo e voltar para lista
        IF THIS.this_cModoAtual = "BUSCAR"
            loc_cCodFiltro = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            loc_cFiltro    = IIF(EMPTY(loc_cCodFiltro), "", ;
                             "Codigos LIKE " + EscaparSQL(loc_cCodFiltro + "%"))

            TRY
                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource            = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigos"
                    loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.dtInicial"
                    loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.dtFinal"
                    loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.UsuIncs"
                    loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.inativo"
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Data Inicial"
                    loc_oGrid.Column3.Header1.Caption = "Data Final"
                    loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
                    loc_oGrid.Column5.Header1.Caption = "Inativo"
                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBlq.BtnSalvarClick.Buscar")
            ENDTRY

            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual           = "LISTA"
            RETURN
        ENDIF

        *-- Validar Data Inicial (fora do TRY - regra critica)
        loc_dIni = loc_oPg2.txt_4c_Dtinicial.Value
        IF EMPTY(loc_dIni)
            MsgAviso("Data Inicial inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Dtinicial.SetFocus()
            RETURN loc_lResultado
        ENDIF

        *-- Validar Data Final
        loc_dFin = loc_oPg2.txt_4c_Dtfinal.Value
        IF EMPTY(loc_dFin)
            MsgAviso("Data Final inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Dtfinal.SetFocus()
            RETURN loc_lResultado
        ENDIF

        *-- Validar: Data Final deve ser >= Data Inicial
        IF loc_dFin < loc_dIni
            MsgAviso("Data Final inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Dtfinal.SetFocus()
            RETURN loc_lResultado
        ENDIF

        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                IF THIS.this_cModoAtual = "INCLUIR"
                    loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
                ENDIF
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBlq.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela operacao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o BO e chama destrutor da classe base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
