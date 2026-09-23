*==============================================================================
* FormUSA.prg
* Formulario de Cadastro de Usuarios Automaticos (SIGCDUSA)
*
* Tabela principal: SigSyMov (PK: cidchaves)
* Tipo: CRUD (frmcadastro)
* BO: USABO
*==============================================================================

DEFINE CLASS FormUSA AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Usu" + CHR(225) + "rios Autom" + CHR(225) + "ticos"
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
            MsgErro(loc_oErro.Message, "FormUSA.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("USABO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar USABO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUSA.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles internos compensam +29 no Top
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
    * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (cntSombra no legado) - CLAUDE.md #11
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
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

        *-- Container botoes CRUD (canonico: Left=542, Width=390)
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90) - CLAUDE.md #10
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid lista: usuars/Dopes/Emps (espelha AddCursor+pColuna do legado Init)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.RecordSource = ""
        loc_oPg1.grd_4c_Lista.ColumnCount  = 3

        WITH loc_oPg1.grd_4c_Lista
            .Top                     = 117
            .Left                    = 12
            .Width                   = 890
            .Height                  = 493
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 2
            .GridLines               = 3
            .ReadOnly                = .T.
            .Visible                 = .T.
            .Column1.Width           = 270
            .Column2.Width           = 510
            .Column3.Width           = 110
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column3.ReadOnly        = .T.
            .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
            .Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption = "Emp"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: cabecalho + container de botoes de acao
    * NOTA (Fase 3/8 - Estrutura Base): campos e botoes Confirmar/Cancelar
    * sao adicionados nas Fases 4/5/6 - aqui apenas os containers estruturais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md #11 / Erro152
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPg2.cnt_4c_Cabecalho
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

        *-- Container botoes Confirmar/Cancelar (canonico) - vazio, Fase 6 adiciona os botoes
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Campos Page2 (Parte 1/2 - Fase 5): linha Usuario + linha Empresa
        *-- Coordenadas do SCX legado (layout.json) + compensacao PageFrame.Top=-29
        *-- Label1/Label3 declaram Width no SCX (terminam 1px antes do textbox) ->
        *-- Alignment=1 e legitimo aqui (CLAUDE.md #23, excecao "Width declarada")

        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .Caption   = "Usu" + CHR(225) + "rio : "
            .Top       = 298
            .Left      = 197
            .Width     = 55
            .Height    = 17
            .Alignment = 1
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oPg2.txt_4c_Usuars
            .Top       = 295
            .Left      = 251
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DUsuars", "TextBox")
        WITH loc_oPg2.txt_4c_DUsuars
            .Top       = 295
            .Left      = 333
            .Width     = 290
            .Height    = 23
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .ReadOnly  = .T.
            .TabStop   = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .Caption   = "Empresa :"
            .Top       = 324
            .Left      = 202
            .Width     = 50
            .Height    = 15
            .Alignment = 1
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPg2.txt_4c_Emps
            .Top       = 320
            .Left      = 251
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oPg2.txt_4c_DEmps
            .Top       = 320
            .Left      = 284
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .ReadOnly  = .T.
            .TabStop   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Campos Page2 (Parte 2/2 - Fase 6): linha Operacao
        *-- layout.json: Label2 top=319,left=185,width=67,height=17 / getDopes top=316,left=251,width=150
        *-- SigCdOpe eh single-column (Dopes = PK + descricao) - NAO existe campo de descricao separado

        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
            .Top       = 348
            .Left      = 185
            .Width     = 67
            .Height    = 17
            .Alignment = 1
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPg2.txt_4c_Dopes
            .Top       = 345
            .Left      = 251
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Botoes Confirmar/Cancelar (canonico framework_frmcadastro_layout.md)
        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- BINDEVENTs de lookup (F4 + DblClick) - CLAUDE.md #3 (metodos PUBLIC)
        BINDEVENT(loc_oPg2.txt_4c_Usuars,  "KeyPress", THIS, "UsuarsLookupKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_Usuars,  "DblClick", THIS, "UsuarsLookupDblClick")
        BINDEVENT(loc_oPg2.txt_4c_DUsuars, "KeyPress", THIS, "DUsuarsLookupKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_DUsuars, "DblClick", THIS, "DUsuarsLookupDblClick")
        BINDEVENT(loc_oPg2.txt_4c_Dopes,   "KeyPress", THIS, "DopesLookupKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_Dopes,   "DblClick", THIS, "DopesLookupDblClick")
        BINDEVENT(loc_oPg2.txt_4c_Emps,    "KeyPress", THIS, "EmpsLookupKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_Emps,    "DblClick", THIS, "EmpsLookupDblClick")
        BINDEVENT(loc_oPg2.txt_4c_DEmps,   "KeyPress", THIS, "DEmpsLookupKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_DEmps,   "DblClick", THIS, "DEmpsLookupDblClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages (PageFrame) e Controls (Container) recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Popula cursor_4c_Dados (USABO.Buscar) e liga ao Grid
    * da Page1. GO TOP + Refresh sao obrigatorios (CLAUDE.md - popular cursor
    * nao repinta a grade sozinho); Header1.Caption e redefinido APOS
    * RecordSource porque o VFP reseta os cabecalhos ao (re)atribuir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista(par_cFiltro)
        LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
        loc_lResultado = .F.
        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, "")

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), usuars C(10), dopes C(20), emps C(3))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount  = 3
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.usuars"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dopes"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.emps"

                        loc_oGrid.Column1.Width = 270
                        loc_oGrid.Column2.Width = 510
                        loc_oGrid.Column3.Width = 110

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.
                        loc_oGrid.Column3.ReadOnly = .T.

                        loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
                        loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Emp"

                        IF USED("cursor_4c_Dados")
                            GO TOP IN cursor_4c_Dados
                        ENDIF
                        loc_oGrid.Refresh()

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUSA.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, "FormUSA.FormatarGridLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormUSA.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos de Page2 para o BusinessObject
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cUsuars = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
        THIS.this_oBusinessObject.this_cDopes  = ALLTRIM(loc_oPg2.txt_4c_Dopes.Value)
        THIS.this_oBusinessObject.this_cEmps   = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BusinessObject para os campos de Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Usuars.Value  = THIS.this_oBusinessObject.this_cUsuars
        loc_oPg2.txt_4c_DUsuars.Value = THIS.this_oBusinessObject.this_cNComps
        loc_oPg2.txt_4c_Dopes.Value   = THIS.this_oBusinessObject.this_cDopes
        loc_oPg2.txt_4c_Emps.Value    = THIS.this_oBusinessObject.this_cEmps
        loc_oPg2.txt_4c_DEmps.Value   = THIS.this_oBusinessObject.this_cRazas
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Usuars.Enabled = par_lHabilitar
        loc_oPg2.txt_4c_Dopes.Enabled  = par_lHabilitar
        loc_oPg2.txt_4c_Emps.Enabled   = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos (editaveis e de exibicao) da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Usuars.Value  = ""
        loc_oPg2.txt_4c_DUsuars.Value = ""
        loc_oPg2.txt_4c_Dopes.Value   = ""
        loc_oPg2.txt_4c_Emps.Value    = ""
        loc_oPg2.txt_4c_DEmps.Value   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta o botao Confirmar conforme this_cModoAtual
    * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
    * PUBLIC: chamado diretamente pelo harness de teste (TesteAutomatico.prg)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida campos obrigatorios (NOT NULL no schema),
    * transfere Form->BO e grava (Salvar decide INSERT/UPDATE internamente).
    * BusinessBase.Salvar ja exibe a falha (CLAUDE.md - falha nunca eh muda);
    * so avisamos aqui se this_lErroExibido continuar .F.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Usuars.Value))
            MsgAviso("Informe o usu" + CHR(225) + "rio!")
            loc_oPg2.txt_4c_Usuars.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Dopes.Value))
            MsgAviso("Informe a opera" + CHR(231) + CHR(227) + "o!")
            loc_oPg2.txt_4c_Dopes.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Emps.Value))
            MsgAviso("Informe a empresa!")
            loc_oPg2.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Volta para a lista SEM gravar, recarregando o grid
    * (CLAUDE.md Problema 2 - Cancelar precisa recarregar, senao grid fica vazio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Localiza um usuario automatico pelo campo Usuars
    * (SigSyMov) e filtra a lista pelo registro selecionado - mesmo padrao
    * de FormUfs.BtnBuscarClick. PUBLIC: BINDEVENT requer metodo publico
    * (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cUsuario

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigSyMov", "cursor_4c_BuscaUSA", "usuars", "", ;
                "Buscar Usu" + CHR(225) + "rio Autom" + CHR(225) + "tico")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuars", "", "Usu" + CHR(225) + "rio")
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Emps", "", "Emp")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUSA")
                    SELECT cursor_4c_BuscaUSA
                    loc_cUsuario = ALLTRIM(usuars)
                    THIS.CarregarLista("usuars = " + EscaparSQL(loc_cUsuario))
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "FormUSA.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaUSA")
            USE IN cursor_4c_BuscaUSA
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO e formulario para um NOVO registro.
    * NovoRegistro() ANTES de limpar campos (Salvar() decide INSERT/UPDATE via
    * this_lNovoRegistro); this_cModoAtual setado ANTES de habilitar os campos
    * (CLAUDE.md Problema 19).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.NovoRegistro()

        THIS.LimparCampos()

        THIS.this_cModoAtual = "INCLUIR"

        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()

        THIS.AlternarPagina(2)

        loc_oPg2.txt_4c_Usuars.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Le o registro selecionado na grade (cidchaves = PK,
    * nao exibida no grid), carrega do BO, prepara para UPDATE e habilita os
    * campos editaveis. EditarRegistro() APOS CarregarPorCodigo() (CLAUDE.md
    * Problema 18/22 - reseta this_lNovoRegistro para nao violar a PK).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves, loc_oPg2

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves = ALLTRIM(cidchaves)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.EditarRegistro()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.BOParaForm()

        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        THIS.AlternarPagina(2)

        loc_oPg2.txt_4c_Usuars.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Le o registro selecionado, carrega do BO e exibe
    * em Page2 SOMENTE LEITURA (campos e Confirmar desabilitados).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves = ALLTRIM(cidchaves)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            RETURN
        ENDIF

        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.BOParaForm()

        THIS.HabilitarCampos(.F.)
        THIS.AjustarBotoesPorModo()

        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Le o registro selecionado na grade, confirma com o
    * usuario (MsgConfirma retorna LOGICAL - CLAUDE.md #7), carrega do BO e
    * exclui. BusinessBase.Excluir() ja exibe a falha (this_lErroExibido) -
    * so avisamos aqui se ela continuar .F. (CLAUDE.md - falha nunca eh muda).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves = ALLTRIM(cidchaves)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
            THIS.CarregarLista()
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Lookups - Usuario (SigCdUsu.Usuarios / Ncomps)
    *--------------------------------------------------------------------------
    PROCEDURE UsuarsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupUsuario()
        ENDIF
    ENDPROC

    PROCEDURE UsuarsLookupDblClick()
        THIS.AbrirLookupUsuario()
    ENDPROC

    PROCEDURE AbrirLookupUsuario()
        LOCAL loc_oBusca, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPg2.txt_4c_Usuars.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", ;
            ALLTRIM(loc_oPg2.txt_4c_Usuars.Value), "Sele" + CHR(231) + CHR(227) + "o de Usu" + CHR(225) + "rios")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Ncomps", "", "Nome")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                SELECT cursor_4c_BuscaUsu
                loc_oPg2.txt_4c_Usuars.Value  = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                loc_oPg2.txt_4c_DUsuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Ncomps)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Lookups - Usuario por Nome (busca reversa - SigCdUsu.Ncomps)
    * txt_4c_DUsuars eh ReadOnly (display), DblClick preenche via codigo mesmo
    * assim - Value programatico nao respeita ReadOnly.
    *--------------------------------------------------------------------------
    PROCEDURE DUsuarsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupUsuarioPorNome()
        ENDIF
    ENDPROC

    PROCEDURE DUsuarsLookupDblClick()
        THIS.AbrirLookupUsuarioPorNome()
    ENDPROC

    PROCEDURE AbrirLookupUsuarioPorNome()
        LOCAL loc_oBusca, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsu", "Ncomps", ;
            ALLTRIM(loc_oPg2.txt_4c_DUsuars.Value), "Sele" + CHR(231) + CHR(227) + "o de Usu" + CHR(225) + "rios")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Ncomps", "", "Nome")
            loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                SELECT cursor_4c_BuscaUsu
                loc_oPg2.txt_4c_DUsuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Ncomps)
                loc_oPg2.txt_4c_Usuars.Value  = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Lookups - Operacao (SigCdOpe.Dopes) - tabela single-column: Dopes eh
    * PK e descricao ao mesmo tempo (CLAUDE.md - nao existe campo separado)
    *--------------------------------------------------------------------------
    PROCEDURE DopesLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupOperacao()
        ENDIF
    ENDPROC

    PROCEDURE DopesLookupDblClick()
        THIS.AbrirLookupOperacao()
    ENDPROC

    PROCEDURE AbrirLookupOperacao()
        LOCAL loc_oBusca, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPg2.txt_4c_Dopes.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
            ALLTRIM(loc_oPg2.txt_4c_Dopes.Value), "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                SELECT cursor_4c_BuscaOpe
                loc_oPg2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Lookups - Empresa (SigCdEmp.Cemps / Razas)
    *--------------------------------------------------------------------------
    PROCEDURE EmpsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE EmpsLookupDblClick()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPg2.txt_4c_Emps.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", ;
            ALLTRIM(loc_oPg2.txt_4c_Emps.Value), "Sele" + CHR(231) + CHR(227) + "o de Empresas")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Empresa")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                SELECT cursor_4c_BuscaEmp
                loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Lookups - Empresa por Nome (busca reversa - SigCdEmp.Razas)
    * txt_4c_DEmps eh ReadOnly (display), DblClick preenche via codigo mesmo
    * assim - Value programatico nao respeita ReadOnly.
    *--------------------------------------------------------------------------
    PROCEDURE DEmpsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupEmpresaPorNome()
        ENDIF
    ENDPROC

    PROCEDURE DEmpsLookupDblClick()
        THIS.AbrirLookupEmpresaPorNome()
    ENDPROC

    PROCEDURE AbrirLookupEmpresaPorNome()
        LOCAL loc_oBusca, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", ;
            ALLTRIM(loc_oPg2.txt_4c_DEmps.Value), "Sele" + CHR(231) + CHR(227) + "o de Empresas")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Razas", "", "Empresa")
            loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                SELECT cursor_4c_BuscaEmp
                loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
