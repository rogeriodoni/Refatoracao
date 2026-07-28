*==============================================================================
* Formsigpres2.prg - Pedido de Estoque (SIGPRES2)
* Herda de: FormBase
* Tipo: Operacional (detalhe de pedido - aberto pelo form pai)
* Tabela: SigMvPec / SigMvItn
*==============================================================================
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg") ADDITIVE

DEFINE CLASS Formsigpres2 AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Pedido de Estoque"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Business object e estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Propriedades especificas do SIGPRES2
    this_cDopes         = ""
    this_oParentForm    = .NULL.
    this_cPcEscolha     = ""
    this_lPlCancelar    = .F.
    this_lPlAcinserir   = .F.
    this_lPlAcalterar   = .F.
    this_lPlAcexcluir   = .F.
    this_cEmpdopnums    = ""

    *--------------------------------------------------------------------------
    * Init - Aceita parametros do form pai: tipo de operacao e referencia
    * par_cChave        = descricao/tipo de operacao (Caption + cDopes)
    * par_nDataSession  = datasession do pai (legado - nao usada no novo sistema)
    * par_oParentForm   = referencia ao form que abriu este
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cChave, par_nDataSession, par_oParentForm)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF VARTYPE(par_cChave) = "C" AND !EMPTY(ALLTRIM(par_cChave))
                THIS.this_cDopes = ALLTRIM(par_cChave)
                THIS.Caption     = ALLTRIM(par_cChave)
            ENDIF
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
            ENDIF
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura base do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpres2BO")

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                *-- Carregar dados do csTemporario (cursor passado pelo form pai)
                IF USED("csTemporario")
                    GO TOP IN csTemporario
                    THIS.this_oBusinessObject.CarregarDoCursorTemporario("csTemporario")
                    THIS.this_cEmpdopnums = THIS.this_oBusinessObject.this_cEmpdopnums
                ENDIF
                THIS.this_oBusinessObject.CarregarMascaraNumeracao()
                IF !EMPTY(THIS.this_cDopes)
                    THIS.this_oBusinessObject.CarregarTipoOperacao(THIS.this_cDopes)
                ENDIF
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29, Tabs=.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Page1.Caption   = "Lista"
            .Page2.Caption   = "Dados"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page2.BackColor = RGB(255, 255, 255)
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho + grade (csTemporario) + botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro (cntSombra no legado): Top=1+29=30
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container de botoes - legado Grupo_op Width=90 (so Consultar visivel)
        *-- Top=-1+29=28
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 90
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Consultar", "CommandButton")
            WITH .cmd_4c_Consultar
                .Caption         = "Consultar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container saida - padrao canonico (Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 917
                .Width           = 90
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grade (grd_4c_Lista): RecordSource = csTemporario (cursor do form pai)
        *-- Top=88+29=117, Left=26, Width=960
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.ColumnCount = 11
        IF USED("csTemporario")
            loc_oGrid.RecordSource = "csTemporario"
        ENDIF
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 960
            .Height             = 468
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

            .Column1.Width            = 60
            .Column1.Header1.Caption  = "C" + CHR(243) + "digo"

            .Column2.Width            = 80
            .Column2.Header1.Caption  = "Data"

            .Column3.Width            = 60
            .Column3.Header1.Caption  = "Grupo"

            .Column4.Width            = 100
            .Column4.Header1.Caption  = "Origem"

            .Column5.Width            = 60
            .Column5.Header1.Caption  = "Grupo"

            .Column6.Width            = 100
            .Column6.Header1.Caption  = "Destino"

            .Column7.Width            = 80
            .Column7.Header1.Caption  = "Doc.Op"

            .Column8.Width            = 100
            .Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"

            .Column9.Width            = 60
            .Column9.Header1.Caption  = "Status"

            .Column10.Width           = 50
            .Column10.Header1.Caption = "EmpO"

            .Column11.Width           = 50
            .Column11.Header1.Caption = "EmpD"
        ENDWITH

        IF USED("csTemporario")
            loc_oGrid.Column1.ControlSource    = "csTemporario.Numes"
            loc_oGrid.Column2.ControlSource    = "csTemporario.Datas"
            loc_oGrid.Column3.ControlSource    = "csTemporario.GrupoOs"
            loc_oGrid.Column4.ControlSource    = "csTemporario.ContaOs"
            loc_oGrid.Column5.ControlSource    = "csTemporario.GrupoDs"
            loc_oGrid.Column6.ControlSource    = "csTemporario.ContaDs"
            loc_oGrid.Column7.ControlSource    = "csTemporario.Nops"
            loc_oGrid.Column8.ControlSource    = "csTemporario.Usuars"
            loc_oGrid.Column9.ControlSource    = "csTemporario.PStatus"
            loc_oGrid.Column10.ControlSource   = "csTemporario.Emps"
            loc_oGrid.Column11.ControlSource   = "csTemporario.Empds"
        ENDIF

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", THIS, "BtnConsultarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")

        THIS.FormatarGridLista(loc_oGrid)
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes, grade operacoes, campos header
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container salvar/cancelar (Grupo_Salva no legado)
        *-- Top=4+29=33, Left=829, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 829
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- GradeOperacao: grade de tipos de operacao no topo direito
        *-- Top=10+29=39, Left=679, Width=112, Height=148 (1 coluna: Operacao)
        loc_oPagina.AddObject("grd_4c_Operacao", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Operacao
        loc_oGrid.ColumnCount = 1
        WITH loc_oGrid
            .Top                = 39
            .Left               = 679
            .Width              = 112
            .Height             = 148
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
            .GridLines          = 1
            .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Visible = .T.
        ENDWITH

        *-- cmd_4c_Entrega: botao de consulta/agendamento de entrega
        *-- Legado: cmdEntrega CommandGroup Top=7+29=36, Left=23, Width=90, Height=110
        loc_oPagina.AddObject("cmd_4c_Entrega", "CommandButton")
        WITH loc_oPagina.cmd_4c_Entrega
            .Caption       = "Entrega"
            .Top           = 36
            .Left          = 23
            .Width         = 90
            .Height        = 40
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .FontName      = "Tahoma"
            .FontBold      = .F.
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Say3 "Codigo" + txt_4c_Codigo (read-only)
        *-- Say3 Top=14+29=43, Left=131
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo"
            .Top       = 43
            .Left      = 131
            .Width     = 65
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- Get_codigo: Top=31+29=60, Left=131, Width=61, Height=23
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 60
            .Left          = 131
            .Width         = 61
            .Height        = 23
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Say4 "Data" + txt_4c_Data (read-only; When=INLIST(pcEscolha,'INSERIR','ALTERAR'))
        *-- Say4 Top=14+29=43, Left=201
        loc_oPagina.AddObject("lbl_4c_Data", "Label")
        WITH loc_oPagina.lbl_4c_Data
            .Caption   = "Data"
            .Top       = 43
            .Left      = 201
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- fweditdata_data: Top=31+29=60, Left=201, Width=80, Height=23
        loc_oPagina.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPagina.txt_4c_Data
            .Value         = {}
            .Top           = 60
            .Left          = 201
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Say1 "Prz Entrega" + txt_4c_PrvEnts (read-only)
        *-- Say1 Top=14+29=43, Left=289
        loc_oPagina.AddObject("lbl_4c_PrvEnts", "Label")
        WITH loc_oPagina.lbl_4c_PrvEnts
            .Caption   = "Prz Entrega"
            .Top       = 43
            .Left      = 289
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- Get_prvEnts: Top=31+29=60, Left=289, Width=80, Height=23
        loc_oPagina.AddObject("txt_4c_PrvEnts", "TextBox")
        WITH loc_oPagina.txt_4c_PrvEnts
            .Value         = {}
            .Top           = 60
            .Left          = 289
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Say_Nota "Docto" + txt_4c_Nota (visivel)
        *-- Say_Nota Top=62+29=91, Left=193, Width=30, Height=15
        loc_oPagina.AddObject("lbl_4c_Nota", "Label")
        WITH loc_oPagina.lbl_4c_Nota
            .Caption   = "Docto"
            .Top       = 91
            .Left      = 193
            .Width     = 30
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- Get_nota: Top=78+29=107, Left=193, Width=66, Height=23
        loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oPagina.txt_4c_Nota
            .Value         = ""
            .Top           = 107
            .Left          = 193
            .Width         = 66
            .Height        = 23
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Say_nop "OP" + txt_4c_Nop (read-only: When=.F. no legado)
        *-- Say_nop Top=62+29=91, Left=131
        loc_oPagina.AddObject("lbl_4c_Nop", "Label")
        WITH loc_oPagina.lbl_4c_Nop
            .Caption   = "OP"
            .Top       = 91
            .Left      = 131
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- Get_nop: Top=79+29=108, Left=131, Width=55, Height=23
        loc_oPagina.AddObject("txt_4c_Nop", "TextBox")
        WITH loc_oPagina.txt_4c_Nop
            .Value         = ""
            .Top           = 108
            .Left          = 131
            .Width         = 55
            .Height        = 23
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Say13 "Tb. Desconto" + txt_4c_Tabd (read-only: When=.F. no legado)
        *-- Say13 Top=62+29=91, Left=269
        loc_oPagina.AddObject("lbl_4c_Tabd", "Label")
        WITH loc_oPagina.lbl_4c_Tabd
            .Caption   = "Tb. Desconto"
            .Top       = 91
            .Left      = 269
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- Get_tabd: Top=79+29=108, Left=269, Width=80, Height=23
        loc_oPagina.AddObject("txt_4c_Tabd", "TextBox")
        WITH loc_oPagina.txt_4c_Tabd
            .Value         = ""
            .Top           = 108
            .Left          = 269
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Say5 "Status" + txt_4c_PStatus (read-only: When=.F. no legado)
        *-- Say5 Top=62+29=91, Left=358
        loc_oPagina.AddObject("lbl_4c_PStatus", "Label")
        WITH loc_oPagina.lbl_4c_PStatus
            .Caption   = "Status"
            .Top       = 91
            .Left      = 358
            .Width     = 36
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- getPStatus: Top=79+29=108, Left=358, Width=36, Height=23
        loc_oPagina.AddObject("txt_4c_PStatus", "TextBox")
        WITH loc_oPagina.txt_4c_PStatus
            .Value         = ""
            .Top           = 108
            .Left          = 358
            .Width         = 36
            .Height        = 23
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- cmd_4c_SubNiveis: abre form SigMvSbn para sub-niveis do pedido
        *-- Top=125+29=154, Left=833, Width=137, Height=40
        loc_oPagina.AddObject("cmd_4c_SubNiveis", "CommandButton")
        WITH loc_oPagina.cmd_4c_SubNiveis
            .Caption       = "   Sub" + CHR(237) + "veis    "
            .Top           = 154
            .Left          = 833
            .Width         = 137
            .Height        = 40
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .FontName      = "Tahoma"
            .FontBold      = .F.
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Container Origem/Destino/Representante (cnt_4c_Origem)
        *-- Top=173+29=202, Left=27, Width=582, Height=164
        loc_oPagina.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPagina.cnt_4c_Origem
            .Top         = 202
            .Left        = 27
            .Width       = 582
            .Height      = 164
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Say8 "Origem"
            .AddObject("lbl_4c_LblOrigem", "Label")
            WITH .lbl_4c_LblOrigem
                .Caption   = "Origem"
                .Top       = 5
                .Left      = 5
                .Width     = 80
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_Line1", "Line")
            WITH .lin_4c_Line1
                .Top         = 20
                .Left        = 5
                .Width       = 560
                .Height      = 0
                .BorderColor = RGB(150, 150, 150)
                .Visible     = .T.
            ENDWITH

            *-- Say2 "Grupo :" + txt_4c_GrupoO
            .AddObject("lbl_4c_GrupoOLbl", "Label")
            WITH .lbl_4c_GrupoOLbl
                .Caption   = "Grupo :"
                .Top       = 30
                .Left      = 19
                .Width     = 40
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            .AddObject("txt_4c_GrupoO", "TextBox")
            WITH .txt_4c_GrupoO
                .Value         = ""
                .Top           = 27
                .Left          = 61
                .Width         = 80
                .Height        = 21
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Say5 "Conta :" + txt_4c_ContaO + txt_4c_DcontaO
            .AddObject("lbl_4c_ContaOLbl", "Label")
            WITH .lbl_4c_ContaOLbl
                .Caption   = "Conta :"
                .Top       = 30
                .Left      = 154
                .Width     = 40
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            .AddObject("txt_4c_ContaO", "TextBox")
            WITH .txt_4c_ContaO
                .Value         = ""
                .Top           = 27
                .Left          = 197
                .Width         = 80
                .Height        = 21
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            .AddObject("txt_4c_DcontaO", "TextBox")
            WITH .txt_4c_DcontaO
                .Value         = ""
                .Top           = 27
                .Left          = 277
                .Width         = 267
                .Height        = 21
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Say_Origem1 "Destino"
            .AddObject("lbl_4c_LblDestino", "Label")
            WITH .lbl_4c_LblDestino
                .Caption   = "Destino"
                .Top       = 59
                .Left      = 5
                .Width     = 80
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_Line2", "Line")
            WITH .lin_4c_Line2
                .Top         = 74
                .Left        = 5
                .Width       = 560
                .Height      = 0
                .BorderColor = RGB(150, 150, 150)
                .Visible     = .T.
            ENDWITH

            *-- Say4 "Grupo :" + txt_4c_GrupoD
            .AddObject("lbl_4c_GrupoDLbl", "Label")
            WITH .lbl_4c_GrupoDLbl
                .Caption   = "Grupo :"
                .Top       = 85
                .Left      = 19
                .Width     = 40
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            .AddObject("txt_4c_GrupoD", "TextBox")
            WITH .txt_4c_GrupoD
                .Value         = ""
                .Top           = 82
                .Left          = 61
                .Width         = 80
                .Height        = 21
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Say6 "Conta :" + txt_4c_ContaD + txt_4c_DcontaD
            .AddObject("lbl_4c_ContaDLbl", "Label")
            WITH .lbl_4c_ContaDLbl
                .Caption   = "Conta :"
                .Top       = 85
                .Left      = 154
                .Width     = 40
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            .AddObject("txt_4c_ContaD", "TextBox")
            WITH .txt_4c_ContaD
                .Value         = ""
                .Top           = 82
                .Left          = 196
                .Width         = 80
                .Height        = 21
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            .AddObject("txt_4c_DcontaD", "TextBox")
            WITH .txt_4c_DcontaD
                .Value         = ""
                .Top           = 82
                .Left          = 277
                .Width         = 267
                .Height        = 21
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- btnCadastros: abre SIGCDCTA com ContaD
            .AddObject("cmd_4c_BtnCadastros", "CommandButton")
            WITH .cmd_4c_BtnCadastros
                .Caption       = ""
                .Top           = 79
                .Left          = 549
                .Width         = 27
                .Height        = 31
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH

            *-- Say3 "Representante"
            .AddObject("lbl_4c_LblResp", "Label")
            WITH .lbl_4c_LblResp
                .Caption   = "Representante"
                .Top       = 113
                .Left      = 5
                .Width     = 90
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_Line3", "Line")
            WITH .lin_4c_Line3
                .Top         = 129
                .Left        = 5
                .Width       = 560
                .Height      = 0
                .BorderColor = RGB(150, 150, 150)
                .Visible     = .T.
            ENDWITH

            *-- Say9 "Grupo :" + txt_4c_GruResp (read-only)
            .AddObject("lbl_4c_GruRespLbl", "Label")
            WITH .lbl_4c_GruRespLbl
                .Caption   = "Grupo :"
                .Top       = 138
                .Left      = 19
                .Width     = 40
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            .AddObject("txt_4c_GruResp", "TextBox")
            WITH .txt_4c_GruResp
                .Value         = ""
                .Top           = 135
                .Left          = 61
                .Width         = 80
                .Height        = 21
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Say7 "Conta :" + txt_4c_Resps + txt_4c_Dresps (ambos When=.F. no legado)
            .AddObject("lbl_4c_RespLbl", "Label")
            WITH .lbl_4c_RespLbl
                .Caption   = "Conta :"
                .Top       = 138
                .Left      = 154
                .Width     = 40
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            .AddObject("txt_4c_Resps", "TextBox")
            WITH .txt_4c_Resps
                .Value         = ""
                .Top           = 135
                .Left          = 195
                .Width         = 80
                .Height        = 21
                .ReadOnly      = .T.
                .Enabled       = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            .AddObject("txt_4c_Dresps", "TextBox")
            WITH .txt_4c_Dresps
                .Value         = ""
                .Top           = 135
                .Left          = 277
                .Width         = 267
                .Height        = 21
                .ReadOnly      = .T.
                .Enabled       = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(240, 240, 240)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- Grid de itens do pedido (fwgrade1 -> grd_4c_Itens)
        *-- Top=350+29=379, Left=23, Width=732, Height=191, 10 colunas -> xEestI
        LOCAL loc_oGridItens
        loc_oPagina.AddObject("grd_4c_Itens", "Grid")
        loc_oGridItens = loc_oPagina.grd_4c_Itens
        loc_oGridItens.ColumnCount = 10
        WITH loc_oGridItens
            .Top                = 379
            .Left               = 23
            .Width              = 732
            .Height             = 191
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
            .Column1.Header1.Caption  = "Produto"
            .Column1.Width            = 90
            .Column2.Header1.Caption  = "Produzido"
            .Column2.Width            = 65
            .Column3.Header1.Caption  = "Qtd."
            .Column3.Width            = 65
            .Column4.Header1.Caption  = "Saldo"
            .Column4.Width            = 65
            .Column5.Header1.Caption  = "Qtd.Baixa"
            .Column5.Width            = 65
            .Column6.Header1.Caption  = "Produzir"
            .Column6.Width            = 65
            .Column7.Header1.Caption  = ""
            .Column7.Width            = 50
            .Column8.Header1.Caption  = "Peso"
            .Column8.Width            = 65
            .Column9.Header1.Caption  = CHR(37) + "Ent."
            .Column9.Width            = 55
            .Column10.Header1.Caption = "Tam."
            .Column10.Width           = 50
            .Visible = .T.
        ENDWITH

        *-- Container de observacoes do pedido (Container1 no legado)
        *-- Top=173+29=202, Left=614, Width=373, Height=164
        loc_oPagina.AddObject("cnt_4c_ObsItem", "Container")
        WITH loc_oPagina.cnt_4c_ObsItem
            .Top         = 202
            .Left        = 614
            .Width       = 373
            .Height      = 164
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_ObsLbl", "Label")
            WITH .lbl_4c_ObsLbl
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                .Top       = 3
                .Left      = 7
                .Width     = 69
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_ObsMemo", "EditBox")
            WITH .txt_4c_ObsMemo
                .Value         = ""
                .Top           = 20
                .Left          = 7
                .Width         = 359
                .Height        = 138
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(250, 250, 250)
                .Visible       = .T.
            ENDWITH
        ENDWITH

        *-- Say2 "Descricao" + txt_4c_Descr (produto selecionado no grid)
        *-- Say2 Top=546+29=575, Left=23
        loc_oPagina.AddObject("lbl_4c_DescrLbl", "Label")
        WITH loc_oPagina.lbl_4c_DescrLbl
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Top       = 575
            .Left      = 23
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- Get_descr Top=562+29=591, Left=23, Width=454, Height=23
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value         = ""
            .Top           = 591
            .Left          = 23
            .Width         = 454
            .Height        = 23
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- img_4c_FigJpg: imagem do produto (Visible=.F. ate selecionar produto)
        *-- Top=365+29=394, Left=762, Width=225, Height=163
        loc_oPagina.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPagina.img_4c_FigJpg
            .Top     = 394
            .Left    = 762
            .Width   = 225
            .Height  = 163
            .Visible = .F.
            .Stretch = 2
        ENDWITH

        *-- Say_Obs "Observacao do item" + txt_4c_ObsItem (editbox, read-only)
        *-- Say_Obs Top=544+29=573, Left=496
        loc_oPagina.AddObject("lbl_4c_ObsItemLbl", "Label")
        WITH loc_oPagina.lbl_4c_ObsItemLbl
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do item"
            .Top       = 573
            .Left      = 496
            .Width     = 100
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        *-- Get_obs Top=561+29=590, Left=496, Width=454, Height=24
        loc_oPagina.AddObject("txt_4c_ObsItem", "EditBox")
        WITH loc_oPagina.txt_4c_ObsItem
            .Value         = ""
            .Top           = 590
            .Left          = 496
            .Width         = 454
            .Height        = 24
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar,         "Click",             THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,          "Click",             THIS, "BtnCancelarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Entrega,                         "Click",             THIS, "BtnEntregaClick")
        BINDEVENT(loc_oPagina.cmd_4c_SubNiveis,                       "Click",             THIS, "BtnSubNiveisClick")
        BINDEVENT(loc_oPagina.grd_4c_Itens,                           "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaO,            "KeyPress",          THIS, "ContaOKeyPress")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaO,            "DblClick",          THIS, "ContaODblClick")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD,            "KeyPress",          THIS, "ContaDKeyPress")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD,            "DblClick",          THIS, "ContaDDblClick")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros,      "Click",             THIS, "BtnCadastrosClick")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_DcontaD,           "KeyPress",         THIS, "DcontaDLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_Dresps,            "KeyPress",         THIS, "DrespsDLostFocus")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.pgf_4c_Paginas.Page1.Enabled = .T.
                    THIS.this_cPcEscolha = ""
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Vincula grid ao csTemporario e redefine headers
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.
        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Lista")
                    CREATE CURSOR cursor_4c_Lista (Numes N(6,0), Datas D, GrupoOs C(4), ;
                        ContaOs C(20), GrupoDs C(4), ContaDs C(20), Nops N(6,0), ;
                        Usuars C(20), PStatus C(1), Emps C(3), Empds C(3))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF USED("csTemporario")
                GO TOP IN csTemporario
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.RecordSource = "csTemporario"
                loc_oGrid.Column1.ControlSource    = "csTemporario.Numes"
                loc_oGrid.Column2.ControlSource    = "csTemporario.Datas"
                loc_oGrid.Column3.ControlSource    = "csTemporario.GrupoOs"
                loc_oGrid.Column4.ControlSource    = "csTemporario.ContaOs"
                loc_oGrid.Column5.ControlSource    = "csTemporario.GrupoDs"
                loc_oGrid.Column6.ControlSource    = "csTemporario.ContaDs"
                loc_oGrid.Column7.ControlSource    = "csTemporario.Nops"
                loc_oGrid.Column8.ControlSource    = "csTemporario.Usuars"
                loc_oGrid.Column9.ControlSource    = "csTemporario.PStatus"
                loc_oGrid.Column10.ControlSource   = "csTemporario.Emps"
                loc_oGrid.Column11.ControlSource   = "csTemporario.Empds"
                loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption  = "Data"
                loc_oGrid.Column3.Header1.Caption  = "Grupo"
                loc_oGrid.Column4.Header1.Caption  = "Origem"
                loc_oGrid.Column5.Header1.Caption  = "Grupo"
                loc_oGrid.Column6.Header1.Caption  = "Destino"
                loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
                loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
                loc_oGrid.Column9.Header1.Caption  = "Status"
                loc_oGrid.Column10.Header1.Caption = "EmpO"
                loc_oGrid.Column11.Header1.Caption = "EmpD"
                loc_oGrid.Refresh()
                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultarClick - Navega para Page2 carregando dados do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultarClick()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.
        TRY
            IF !USED("csTemporario") OR EOF("csTemporario")
                MsgAviso("Selecione um registro na lista!", "")
            ELSE
                THIS.this_cPcEscolha = "CONSULTAR"
                THIS.pgf_4c_Paginas.Page1.Enabled = .F.
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2

                SELECT csTemporario
                *-- Preencher campos basicos a partir do cursor csTemporario
                loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(TRANSFORM(csTemporario.Numes))
                loc_oPg2.txt_4c_Data.Value    = IIF(EMPTY(csTemporario.Datas), {}, csTemporario.Datas)
                loc_oPg2.txt_4c_PrvEnts.Value = IIF(EMPTY(csTemporario.PrazoEnts), {}, csTemporario.PrazoEnts)
                loc_oPg2.txt_4c_Nop.Value     = ALLTRIM(NVL(csTemporario.Nops, ""))
                loc_oPg2.txt_4c_PStatus.Value = ALLTRIM(NVL(csTemporario.PStatus, ""))

                *-- Guardar chave composta do pedido (Emps+Dopes+Numes)
                THIS.this_cEmpdopnums = ALLTRIM(csTemporario.Emps) + ;
                    ALLTRIM(csTemporario.Dopes) + ;
                    TRANSFORM(csTemporario.Numes, "@@@@@@")

                *-- Carregar grade de tipos de operacao
                THIS.CarregarGradeOperacao()

                *-- Carregar propriedades do BO a partir do cursor
                THIS.this_oBusinessObject.CarregarDoCursorTemporario("csTemporario")

                *-- Preencher campos Origem/Destino
                THIS.CarregarCamposOrigem()

                *-- Carregar grade de itens do pedido
                THIS.CarregarGradeItens()

                THIS.pgf_4c_Paginas.ActivePage = 2
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCamposOrigem - Preenche campos de Origem/Destino do cnt_4c_Origem
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCamposOrigem()
        LOCAL loc_lResultado, loc_oCnt, loc_oBO
        loc_lResultado = .F.
        TRY
            loc_oBO  = THIS.this_oBusinessObject
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem

            loc_oCnt.txt_4c_GrupoO.Value  = ALLTRIM(NVL(loc_oBO.this_cGrupoOs, ""))
            loc_oCnt.txt_4c_ContaO.Value  = ALLTRIM(NVL(loc_oBO.this_cContaOs, ""))
            loc_oCnt.txt_4c_GrupoD.Value  = ALLTRIM(NVL(loc_oBO.this_cGrupoDs, ""))
            loc_oCnt.txt_4c_ContaD.Value  = ALLTRIM(NVL(loc_oBO.this_cContaDs, ""))
            loc_oCnt.txt_4c_Dresps.Value  = ALLTRIM(NVL(loc_oBO.this_cDresps, ""))

            *-- Descricao da conta de Origem
            loc_oBO.CarregarDescricaoCliente(ALLTRIM(NVL(loc_oBO.this_cContaOs, "")))
            loc_oCnt.txt_4c_DcontaO.Value = ALLTRIM(NVL(loc_oBO.this_cDconta, ""))

            *-- Descricao da conta de Destino via SQL (SigCdCli)
            LOCAL loc_cSQL, loc_nRes
            IF !EMPTY(ALLTRIM(NVL(loc_oBO.this_cContaDs, "")))
                loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(ALLTRIM(loc_oBO.this_cContaDs))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DcontaD")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_DcontaD") > 0
                    loc_oCnt.txt_4c_DcontaD.Value = ALLTRIM(cursor_4c_DcontaD.Rclis)
                ENDIF
                IF USED("cursor_4c_DcontaD")
                    USE IN cursor_4c_DcontaD
                ENDIF
            ELSE
                loc_oCnt.txt_4c_DcontaD.Value = ""
            ENDIF

            *-- Campos GruResp e Resps/Dresps (When=.F. no legado -> ReadOnly + Enabled=.F.)
            IF USED("csTemporario")
                SELECT csTemporario
                IF PEMSTATUS(loc_oCnt, "txt_4c_GruResp", 5)
                    loc_oCnt.txt_4c_GruResp.Value = ALLTRIM(NVL(csTemporario.GrupoDs, ""))
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_Resps", 5)
                    loc_oCnt.txt_4c_Resps.Value   = ALLTRIM(NVL(csTemporario.ContaDs, ""))
                ENDIF
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeItens - Carrega cursor de itens e vincula ao grd_4c_Itens
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeItens()
        LOCAL loc_lResultado, loc_oGrid, loc_cSQL
        loc_lResultado = .F.
        TRY
            *-- Acionar BO para construir xEestI
            IF !THIS.this_oBusinessObject.MontarCursorItens(THIS.this_cEmpdopnums)
                loc_lResultado = .T.
            ELSE
                *-- Criar cursor_4c_Itens com Saldo calculado a partir de xEestI
                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF
                SELECT empdopnums, cpros, codcors, codtams, ;
                       qtds, (qtds - qtbaixas) AS Saldos, qtbaixas, ;
                       qtprods, qtbxprods, tpesos, descvals, DPros, OBS ;
                    FROM xEestI ;
                    INTO CURSOR cursor_4c_Itens READWRITE

                loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
                loc_oGrid.ColumnCount = 10
                loc_oGrid.RecordSource = "cursor_4c_Itens"
                loc_oGrid.ColumnCount  = 10

                loc_oGrid.Column1.ControlSource   = "cursor_4c_Itens.cpros"
                loc_oGrid.Column2.ControlSource   = "cursor_4c_Itens.qtprods"
                loc_oGrid.Column3.ControlSource   = "cursor_4c_Itens.qtds"
                loc_oGrid.Column4.ControlSource   = "cursor_4c_Itens.Saldos"
                loc_oGrid.Column5.ControlSource   = "cursor_4c_Itens.qtbaixas"
                loc_oGrid.Column6.ControlSource   = "cursor_4c_Itens.qtbxprods"
                loc_oGrid.Column7.ControlSource   = "cursor_4c_Itens.codcors"
                loc_oGrid.Column8.ControlSource   = "cursor_4c_Itens.tpesos"
                loc_oGrid.Column9.ControlSource   = "cursor_4c_Itens.descvals"
                loc_oGrid.Column10.ControlSource  = "cursor_4c_Itens.codtams"

                loc_oGrid.Column1.Header1.Caption  = "Produto"
                loc_oGrid.Column2.Header1.Caption  = "Produzido"
                loc_oGrid.Column3.Header1.Caption  = "Qtd."
                loc_oGrid.Column4.Header1.Caption  = "Saldo"
                loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
                loc_oGrid.Column6.Header1.Caption  = "Produzir"
                loc_oGrid.Column7.Header1.Caption  = ""
                loc_oGrid.Column8.Header1.Caption  = "Peso"
                loc_oGrid.Column9.Header1.Caption  = CHR(37) + "Ent."
                loc_oGrid.Column10.Header1.Caption = "Tam."

                loc_oGrid.Refresh()

                *-- Exibir descricao/foto do primeiro item se houver registros
                IF RECCOUNT("cursor_4c_Itens") > 0
                    GO TOP IN cursor_4c_Itens
                    THIS.GradeItensAfterRowColChange(1)
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - Atualiza descricao/foto ao mudar linha do grid
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        LOCAL loc_lResultado, loc_cCpros, loc_oPg2
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
                loc_oPg2  = THIS.pgf_4c_Paginas.Page2
                loc_cCpros = ALLTRIM(NVL(cursor_4c_Itens.cpros, ""))

                loc_oPg2.txt_4c_Descr.Value   = ALLTRIM(NVL(cursor_4c_Itens.DPros, ""))
                loc_oPg2.txt_4c_ObsItem.Value = ALLTRIM(NVL(cursor_4c_Itens.OBS, ""))

                THIS.CarregarImagemProduto(loc_cCpros)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImagemProduto - Busca FigJpgs de SigCdPro e exibe img_4c_FigJpg
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImagemProduto(par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes, loc_cArqTemp, loc_oImg
        loc_lResultado = .F.
        TRY
            loc_oImg = THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg
            loc_oImg.Visible = .F.
            loc_oImg.Picture = ""

            IF !EMPTY(ALLTRIM(par_cCpros)) AND gnConnHandle > 0
                loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro" + ;
                           " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigJpg")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_FigJpg") > 0
                    IF !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
                       LEN(cursor_4c_FigJpg.FigJpgs) > 0
                        loc_cArqTemp = ADDBS(SYS(2023)) + "Temp3.jpg"
                        STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp, 0)
                        IF FILE(loc_cArqTemp)
                            loc_oImg.Picture = loc_cArqTemp
                            loc_oImg.Visible = .T.
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_FigJpg")
                    USE IN cursor_4c_FigJpg
                ENDIF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaO - Lookup FormBuscaAuxiliar para conta de Origem
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaO()
        LOCAL loc_lResultado, loc_oLookup, loc_oCnt
        loc_lResultado = .F.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaContaO", "Iclis", ;
                ALLTRIM(loc_oCnt.txt_4c_ContaO.Value), ;
                "Conta de Origem")
            loc_oLookup.mAddColuna("Iclis",  "", "Conta")
            loc_oLookup.mAddColuna("Rclis",  "", "Nome")
            loc_oLookup.Show()
            IF loc_oLookup.this_lSelecionou
                loc_oCnt.txt_4c_ContaO.Value  = ALLTRIM(cursor_4c_BuscaContaO.Iclis)
                loc_oCnt.txt_4c_DcontaO.Value = ALLTRIM(cursor_4c_BuscaContaO.Rclis)
                THIS.this_oBusinessObject.this_cContaOs = ALLTRIM(cursor_4c_BuscaContaO.Iclis)
            ENDIF
            IF USED("cursor_4c_BuscaContaO")
                USE IN cursor_4c_BuscaContaO
            ENDIF
            loc_oLookup.Release()
            loc_oLookup = .NULL.
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaD - Lookup FormBuscaAuxiliar para conta de Destino
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaD()
        LOCAL loc_lResultado, loc_oLookup, loc_oCnt
        loc_lResultado = .F.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaContaD", "Iclis", ;
                ALLTRIM(loc_oCnt.txt_4c_ContaD.Value), ;
                "Conta de Destino")
            loc_oLookup.mAddColuna("Iclis",  "", "Conta")
            loc_oLookup.mAddColuna("Rclis",  "", "Nome")
            loc_oLookup.Show()
            IF loc_oLookup.this_lSelecionou
                loc_oCnt.txt_4c_ContaD.Value  = ALLTRIM(cursor_4c_BuscaContaD.Iclis)
                loc_oCnt.txt_4c_DcontaD.Value = ALLTRIM(cursor_4c_BuscaContaD.Rclis)
                THIS.this_oBusinessObject.this_cContaDs = ALLTRIM(cursor_4c_BuscaContaD.Iclis)
            ENDIF
            IF USED("cursor_4c_BuscaContaD")
                USE IN cursor_4c_BuscaContaD
            ENDIF
            loc_oLookup.Release()
            loc_oLookup = .NULL.
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaOKeyPress - Abre lookup de Origem com Enter (keycode 28 = F4)
    *--------------------------------------------------------------------------
    PROCEDURE ContaOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28 OR par_nKeyCode = 9 OR par_nKeyCode = 13 OR ;
           par_nKeyCode = 115
            IF par_nKeyCode = 28 OR par_nKeyCode = 115
                THIS.AbrirLookupContaO()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaODblClick - Abre lookup de Origem ao dar duplo clique
    *--------------------------------------------------------------------------
    PROCEDURE ContaODblClick()
        THIS.AbrirLookupContaO()
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaDKeyPress - Abre lookup de Destino com F4 (keycode 115)
    *--------------------------------------------------------------------------
    PROCEDURE ContaDKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28 OR par_nKeyCode = 9 OR par_nKeyCode = 13 OR ;
           par_nKeyCode = 115
            IF par_nKeyCode = 28 OR par_nKeyCode = 115
                THIS.AbrirLookupContaD()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaDDblClick - Abre lookup de Destino ao dar duplo clique
    *--------------------------------------------------------------------------
    PROCEDURE ContaDDblClick()
        THIS.AbrirLookupContaD()
    ENDPROC

    *--------------------------------------------------------------------------
    * DcontaDLostFocus - Move foco para botao Confirmar
    *--------------------------------------------------------------------------
    PROCEDURE DcontaDLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DrespsDLostFocus - Move foco para botao Confirmar
    *--------------------------------------------------------------------------
    PROCEDURE DrespsDLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCadastrosClick - Abre formulario de cadastro de contas (SIGCDCTA)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCadastrosClick()
        LOCAL loc_oErro, loc_cContaD
        TRY
            loc_cContaD = ""
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem, "txt_4c_ContaD", 5)
                loc_cContaD = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD.Value)
            ENDIF
            DO FORM SIGCDCTA WITH 0, "SIGCDCTA", loc_cContaD, .T., "", "", .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF
            IF USED("xEestI")
                USE IN xEestI
            ENDIF
            IF USED("crSigMvItn")
                USE IN crSigMvItn
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            THIS.this_oParentForm = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                *-- Controles com Visible=.F. por design devem permanecer ocultos (nao forcar .T.)
                *-- Recursar filhos antes do LOOP para que sub-controles sejam visiveis
                IF PEMSTATUS(loc_oObjeto, "Name", 5) AND ;
                   INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "IMG_4C_FIGJPG")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
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
    * BtnConfirmarClick - Volta para Page1 (OK no detalhe)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Page1.Enabled = .T.
            THIS.this_cPcEscolha = ""
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela visualizacao e volta para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Page1.Enabled = .T.
            THIS.this_lPlCancelar = .T.
            THIS.this_cPcEscolha  = ""
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEntregaClick - Abre form SigOpEnt para agendamento de entrega
    *--------------------------------------------------------------------------
    PROCEDURE BtnEntregaClick()
        LOCAL loc_lResultado, loc_dData, loc_dEst, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED("csTemporario") OR EOF("csTemporario")
                MsgAviso("Nenhum pedido selecionado!", "")
            ELSE
                SELECT csTemporario
                loc_dData = IIF(EMPTY(csTemporario.PrazoEnts), DATE(), csTemporario.PrazoEnts)
                loc_dEst  = IIF(EMPTY(csTemporario.Datas), DATE(), csTemporario.Datas)
                DO FORM SigOpEnt WITH csTemporario.Emps, csTemporario.Dopes, ;
                    csTemporario.Numes, loc_dData, THIS, 0, loc_dEst, .T., 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSubNiveisClick - Abre form SigMvSbn para sub-niveis do pedido
    *--------------------------------------------------------------------------
    PROCEDURE BtnSubNiveisClick()
        LOCAL loc_oErro
        TRY
            IF !USED("csTemporario") OR EOF("csTemporario")
                MsgAviso("Nenhum pedido selecionado!", "")
            ELSE
                SELECT csTemporario
                DO FORM SigMvSbn WITH THIS, csTemporario.Emps, csTemporario.Dopes, ;
                    csTemporario.Numes, "csTemporario"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeOperacao - Carrega grade de tipos de operacao (SigCdOpe)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGradeOperacao()
        LOCAL loc_lResultado, loc_oGrid, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao
                loc_cSQL    = "SELECT Dopes FROM SigCdOpe"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacaoTemp")
                IF loc_nResult > 0
                    IF USED("cursor_4c_Operacao")
                        SELECT cursor_4c_Operacao
                        ZAP
                        APPEND FROM DBF("cursor_4c_OperacaoTemp")
                    ELSE
                        SELECT Dopes FROM cursor_4c_OperacaoTemp ;
                            INTO CURSOR cursor_4c_Operacao READWRITE
                    ENDIF
                    IF USED("cursor_4c_OperacaoTemp")
                        USE IN cursor_4c_OperacaoTemp
                    ENDIF
                    loc_oGrid.ColumnCount = 1
                    loc_oGrid.RecordSource = "cursor_4c_Operacao"
                    loc_oGrid.ColumnCount  = 1
                    loc_oGrid.Column1.ControlSource   = "cursor_4c_Operacao.Dopes"
                    loc_oGrid.Column1.Width           = 110
                    loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Refresh()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC


    *--------------------------------------------------------------------------
    * BtnIncluirClick - Nao disponivel neste form operacional
    * Legado: Inserir.Enabled=.F. + Visible=.F. (form e somente consulta)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Nao disponivel neste form operacional
    * Legado: Alterar.Enabled=.F. + Visible=.F. (form e somente consulta)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Navega para Page2 com dados do pedido selecionado
    * Equivalente ao BtnConsultarClick (mesmo comportamento)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.BtnConsultarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Nao disponivel neste form operacional
    * Legado: Excluir.Enabled=.F. + Visible=.F. (form e somente consulta)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Procurar oculto no legado; recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Equivalente ao BtnConfirmarClick neste form operacional
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Form e somente leitura; BO ja foi carregado do csTemporario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO para os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = THIS.CarregarCamposOrigem()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Form operacional de consulta; campos sao todos ReadOnly
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lResultado, loc_oPg2, loc_oCnt
        loc_lResultado = .F.
        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2
                IF PEMSTATUS(loc_oPg2, "txt_4c_Nota", 5)
                    loc_oPg2.txt_4c_Nota.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                    loc_oCnt = loc_oPg2.cnt_4c_Origem
                    IF PEMSTATUS(loc_oCnt, "txt_4c_ContaO", 5)
                        loc_oCnt.txt_4c_ContaO.ReadOnly = .T.
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "txt_4c_ContaD", 5)
                        loc_oCnt.txt_4c_ContaD.ReadOnly = .T.
                    ENDIF
                ENDIF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos de exibicao da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_lResultado, loc_oPg2, loc_oCnt
        loc_lResultado = .F.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.txt_4c_Codigo.Value  = ""
            loc_oPg2.txt_4c_Data.Value    = {}
            loc_oPg2.txt_4c_PrvEnts.Value = {}
            loc_oPg2.txt_4c_Nota.Value    = ""
            loc_oPg2.txt_4c_Nop.Value     = ""
            loc_oPg2.txt_4c_Tabd.Value    = ""
            loc_oPg2.txt_4c_PStatus.Value = ""
            loc_oPg2.txt_4c_Descr.Value   = ""
            loc_oPg2.txt_4c_ObsItem.Value = ""

            loc_oCnt = loc_oPg2.cnt_4c_Origem
            loc_oCnt.txt_4c_GrupoO.Value  = ""
            loc_oCnt.txt_4c_ContaO.Value  = ""
            loc_oCnt.txt_4c_DcontaO.Value = ""
            loc_oCnt.txt_4c_GrupoD.Value  = ""
            loc_oCnt.txt_4c_ContaD.Value  = ""
            loc_oCnt.txt_4c_DcontaD.Value = ""
            loc_oCnt.txt_4c_GruResp.Value = ""
            loc_oCnt.txt_4c_Resps.Value   = ""
            loc_oCnt.txt_4c_Dresps.Value  = ""

            loc_oPg2.cnt_4c_ObsItem.txt_4c_ObsMemo.Value = ""

            loc_oPg2.img_4c_FigJpg.Visible = .F.
            loc_oPg2.img_4c_FigJpg.Picture = ""

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Modo fixo: apenas Consultar disponivel
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Consultar", 5)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Consultar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
