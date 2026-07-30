*==============================================================================
* FormCNQ.prg - Formulario de Cadastro de Conquilhas
* Tabela: SigCdCnq | PK: conquilhas+codtams (chave composta de negocio)
* Legado: SIGCDCNQ.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormCNQ AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Cadastro de Conquilhas"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cPkSelecionado  = ""
    this_cFiltroBusca    = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial (chamado pelo FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CNQBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar Business Object CNQBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCNQ:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame principal com 2 paginas
    * Legado: Pagina Width=1003, Top=-29 (oculta abas do framework)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e Grid
    * Compensacao PageFrame +29 aplicada em todos os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra original: Top=2 -> 31 com compensacao)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackStyle   = 0
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
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
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
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op original: Top=-1 -> 29, Left=338 -> canonical 542)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 400
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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

        *-- Container saida canonico (CLAUDE.md regra #10: Left=917, Width=90)
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
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
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

        *-- Grid grd_4c_Lista - Legado: Grade (conquilhas/codtams/valors)
        *-- RecordSource e ControlSource configurados em CarregarLista() apos Buscar()
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid                    = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top                = 117
        loc_oGrid.Left               = 2
        loc_oGrid.Width              = 910
        loc_oGrid.Height             = 477
        loc_oGrid.ColumnCount        = 3
        loc_oGrid.GridLines          = 3
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.FontName           = "Verdana"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(90, 90, 90)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.Visible            = .T.

        *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,  "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: campos Conquilha/CodTam/Valor + botoes
    * Legado: Get_conquilha(top=147,left=402,w=115), Get_codtam(top=174,left=402,w=59)
    *         Get_valor(top=202,left=402,w=59) | Compensacao PageFrame +29 aplicada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Label Conquilha (Say1: top=150+29=179, left=343)
        loc_oPagina.AddObject("lbl_4c_Conquilha", "Label")
        WITH loc_oPagina.lbl_4c_Conquilha
            .Caption   = "Conquilha :"
            .Top       = 179
            .Left      = 343
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conquilha (Get_conquilha: top=147+29=176, left=402, width=115)
        loc_oPagina.AddObject("txt_4c_Conquilha", "TextBox")
        WITH loc_oPagina.txt_4c_Conquilha
            .Value        = ""
            .Top          = 176
            .Left         = 402
            .Width        = 115
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MaxLength    = 30
            .BackColor    = RGB(255, 255, 255)
            .ForeColor    = RGB(90, 90, 90)
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH

        *-- Label Codigo Tamanho/Aro (Say2: top=177+29=206, left=282)
        loc_oPagina.AddObject("lbl_4c_CodTam", "Label")
        WITH loc_oPagina.lbl_4c_CodTam
            .Caption   = "C" + CHR(243) + "digo Tamanho (Aro) :"
            .Top       = 206
            .Left      = 282
            .Width     = 118
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox CodTam (Get_codtam: top=174+29=203, left=402, width=59)
        *-- Lookup: fwBuscaExt em SigCdTam (cods/descs) - implementado em ValidarCodTam
        loc_oPagina.AddObject("txt_4c_CodTam", "TextBox")
        WITH loc_oPagina.txt_4c_CodTam
            .Value        = ""
            .Top          = 203
            .Left         = 402
            .Width        = 59
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MaxLength    = 10
            .BackColor    = RGB(255, 255, 255)
            .ForeColor    = RGB(90, 90, 90)
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH

        *-- Label Valor (Say8: top=205+29=234, left=366)
        loc_oPagina.AddObject("lbl_4c_Valor", "Label")
        WITH loc_oPagina.lbl_4c_Valor
            .Caption   = "Valor :"
            .Top       = 234
            .Left      = 366
            .Width     = 34
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Valor (Get_valor: top=202+29=231, left=402, width=59)
        loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPagina.txt_4c_Valor
            .Value        = 0
            .Top          = 231
            .Left         = 402
            .Width        = 59
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .InputMask    = "999999.99"
            .Alignment    = 1
            .BackColor    = RGB(255, 255, 255)
            .ForeColor    = RGB(90, 90, 90)
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH

        *-- Container botoes de acao (Grupo_Salva original: Top=4 -> 33, Left=842)
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

        *-- BINDEVENTs campos (LostFocus, F4 e DblClick para lookup de Tamanho/Aro)
        BINDEVENT(loc_oPagina.txt_4c_CodTam, "KeyPress", THIS, "ValidarCodTam")
        BINDEVENT(loc_oPagina.txt_4c_CodTam, "KeyPress",  THIS, "CodTamKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CodTam, "DblClick",  THIS, "CodTamDblClick")

        *-- BINDEVENTs botoes
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da Page1
    * Aplica this_cFiltroBusca como WHERE clause (vazio = todos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (conquilhas C(10), codtams C(4), valors N(6,3))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroBusca)
                IF USED("cursor_4c_Dados")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- Problema 36/48: RecordSource e ColumnCount FORA de WITH
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    *-- Problema 32: redefinir Headers APOS RecordSource + ControlSource
                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.conquilhas"
                        .Column1.Width           = 150
                        .Column1.Header1.Caption = "Conquilha"
                        .Column1.Alignment       = 0

                        .Column2.ControlSource   = "cursor_4c_Dados.codtams"
                        .Column2.Width           = 100
                        .Column2.Header1.Caption = "Aro"
                        .Column2.Alignment       = 1

                        .Column3.ControlSource   = "cursor_4c_Dados.valors"
                        .Column3.Width           = 100
                        .Column3.Header1.Caption = "Valor"
                        .Column3.Alignment       = 1
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "FormCNQ.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "FormCNQ.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Conquilha", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cPK
        loc_cPK = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
        ENDIF

        IF EMPTY(STRTRAN(loc_cPK, "|", ""))
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
            THIS.BOParaForm()
            THIS.this_cPkSelecionado = loc_cPK
            THIS.this_cModoAtual     = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cPK
        loc_cPK = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
        ENDIF

        IF EMPTY(STRTRAN(loc_cPK, "|", ""))
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cPkSelecionado = loc_cPK
            THIS.this_cModoAtual     = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cPK, loc_lConfirma
        loc_cPK = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
        ENDIF

        IF EMPTY(STRTRAN(loc_cPK, "|", ""))
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
                                     "Confirmar Exclus" + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                THIS.this_cFiltroBusca = ""
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Buscar/filtrar registros por conquilha
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cConquilha, loc_cFiltro
        loc_cConquilha = INPUTBOX("Informe a conquilha para buscar (vazio = todos):", ;
                                   "Buscar Conquilha", "")

        IF EMPTY(ALLTRIM(loc_cConquilha))
            loc_cFiltro = ""
        ELSE
            loc_cFiltro = "conquilhas LIKE " + EscaparSQL("%" + ALLTRIM(loc_cConquilha) + "%")
        ENDIF

        THIS.this_cFiltroBusca = loc_cFiltro
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar alteracoes (chamado por cmd_4c_Confirmar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar campos obrigatorios ANTES do TRY (RETURN fora do TRY - regra #1)
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Conquilha", 5)
            IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.Value))
                MsgAviso("Obrigat" + CHR(243) + "rio informar a Conquilha.")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.this_cModoAtual   = "LISTA"
                THIS.this_cFiltroBusca = ""
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "FormCNQ.BtnSalvarClick")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
            THIS.this_oBusinessObject.this_cConquilha = ALLTRIM(loc_oPg2.txt_4c_Conquilha.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            THIS.this_oBusinessObject.this_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
            THIS.this_oBusinessObject.this_nValor = loc_oPg2.txt_4c_Valor.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
            loc_oPg2.txt_4c_Conquilha.Value = THIS.this_oBusinessObject.this_cConquilha
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            loc_oPg2.txt_4c_CodTam.Value = THIS.this_oBusinessObject.this_cCodTam
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
            loc_oPg2.txt_4c_Valor.Value = THIS.this_oBusinessObject.this_nValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos do formulario (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
            loc_oPg2.txt_4c_Conquilha.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            loc_oPg2.txt_4c_CodTam.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
            loc_oPg2.txt_4c_Valor.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Conquilha e CodTam: editaveis apenas no INCLUIR (chave de negocio nao muda)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
            loc_oPg2.txt_4c_Conquilha.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            loc_oPg2.txt_4c_CodTam.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
            loc_oPg2.txt_4c_Valor.Enabled = par_lHabilitar
        ENDIF

        *-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme o modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lNaLista
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_lNaLista = (THIS.this_cModoAtual = "LISTA")

        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lNaLista
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Obrigatorio: percorre Pages de PageFrames E Controls de Containers
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
    * FormatarGridLista - Aplica formatacao visual padrao no grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, "FormCNQ.FormatarGridLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodTam - LostFocus: aciona lookup apenas se valor nao vazio
    * Legado: Get_codtam.Valid usava fwBuscaExt em SigCdTam (cods/descs)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodTam(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCodTam
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cCodTam = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            loc_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
        ENDIF

        IF !EMPTY(loc_cCodTam)
            THIS.AbrirLookupCodTam()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CodTamKeyPress - Handler de KeyPress: abre lookup ao pressionar F4 (28)
    *--------------------------------------------------------------------------
    PROCEDURE CodTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCodTam()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CodTamDblClick - Handler de DblClick: abre lookup de Tamanho/Aro
    *--------------------------------------------------------------------------
    PROCEDURE CodTamDblClick()
        THIS.AbrirLookupCodTam()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCodTam - Lookup em SigCdTam (cods/descs) via FormBuscaAuxiliar
    * Campo vazio: exibe lista completa. Nao-vazio: tenta exato primeiro.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCodTam()
        LOCAL loc_oPg2, loc_cCodTam, loc_oBusca
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cCodTam = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            IF !loc_oPg2.txt_4c_CodTam.Enabled
                RETURN
            ENDIF
            loc_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cCodTam, ;
                "Selecionar Tamanho (Aro)")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Registro exato encontrado e selecionado automaticamente
                    IF USED("cursor_4c_BuscaTam") AND PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
                        loc_oPg2.txt_4c_CodTam.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
                    ENDIF
                ELSE
                    *-- Nao encontrou exato (ou campo vazio): mostrar grid para selecao
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d Tam")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
                            loc_oPg2.txt_4c_CodTam.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup Tamanho:" + CHR(13) + loException.Message, "FormCNQ.AbrirLookupCodTam")
        ENDTRY

        IF USED("cursor_4c_BuscaTam")
            USE IN cursor_4c_BuscaTam
        ENDIF
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
        CATCH TO loException
            MostrarErro("Erro ao destruir FormCNQ:" + CHR(13) + loException.Message, "FormCNQ.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
