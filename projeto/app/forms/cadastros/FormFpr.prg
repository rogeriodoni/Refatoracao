*====================================================================
* FormFpr.prg
*
* Formul" + CHR(225) + "rio de Cadastro de Modelos de Produtos
* Tabela: SigCdFip | Campos: Cods (PK), Descs
* Migrado de: SIGCDFPR.SCX
*====================================================================

DEFINE CLASS FormFpr AS FormBase

	*-- Propriedades visuais (PILAR 1 - UX Fidelity)
	Height      = 600
	Width       = 1000
	Caption     = "Cadastro de Modelos de Produtos"
	AutoCenter  = .T.
	ShowWindow  = 1
	WindowType  = 1
	ControlBox  = .F.
	TitleBar    = 0
	Themes      = .F.
	BorderStyle = 2

	*-- Propriedades do formul" + CHR(225) + "rio
	this_oBusinessObject = .NULL.
	this_cModoAtual      = "LISTA"

	*====================================================================
	* Init - Inicializa formul" + CHR(225) + "rio
	* REGRA: apenas RETURN DODEFAULT() (FormBase.Init chama InicializarForm)
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			loc_lSucesso = DODEFAULT()
		CATCH TO loException
			MostrarErro(loException, "FormFpr.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InicializarForm - Configura" + CHR(231) + CHR(227) + "o estrutural completa
	* Chamado automaticamente por FormBase.Init()
	*====================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Criar Business Object
			THIS.this_oBusinessObject = CREATEOBJECT("FprBO")

			IF VARTYPE(THIS.this_oBusinessObject) != "O"
				MostrarErro("Erro ao criar FprBO", "FormFpr.InicializarForm")
			ELSE
				THIS.ConfigurarPageFrame()
				THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
				THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
				IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
					THIS.CarregarLista()
				ENDIF
				THIS.pgf_4c_Paginas.ActivePage = 1
				THIS.this_cModoAtual = "LISTA"
				loc_lSucesso = .T.
			ENDIF

		CATCH TO loException
			MostrarErro(loException, "FormFpr.InicializarForm")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfigurarPageFrame - Cria PageFrame com 2 p" + CHR(225) + "ginas
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPageFrame()
		THIS.AddObject("pgf_4c_Paginas", "PageFrame")

		THIS.pgf_4c_Paginas.Top       = -29
		THIS.pgf_4c_Paginas.Left      = 0
		THIS.pgf_4c_Paginas.Width     = THIS.Width
		THIS.pgf_4c_Paginas.Height    = THIS.Height + 29
		THIS.pgf_4c_Paginas.Tabs      = .F.
		THIS.pgf_4c_Paginas.PageCount = 2
		THIS.pgf_4c_Paginas.Visible   = .T.

		*-- Page1: Lista
		THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
		THIS.pgf_4c_Paginas.Page1.BackColor = RGB(160, 160, 160)
		THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"

		*-- Page2: Dados
		THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
		THIS.pgf_4c_Paginas.Page2.BackColor = RGB(160, 160, 160)
		THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"

		THIS.ConfigurarPaginaLista()
		THIS.ConfigurarPaginaDados()
	ENDPROC

	*====================================================================
	* ConfigurarPaginaLista - Page1 (Lista) completa com Grid e Bot" + CHR(245) + "es CRUD
	* Grupo_op: Left=512,Top=-1 -> canonical Left=542, Top=28
	* Grupo_Saida: Left=918,Top=-1 -> canonical Left=917, Top=28
	* cntSombra: Top=1 -> Top=30; Grade: Top=121 -> Top=150
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaLista()
		LOCAL loc_oPagina, loc_oGrid
		loc_oPagina = THIS.pgf_4c_Paginas.Page1

		*-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
		loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

		*-- Container cabe" + CHR(231) + "alho (cntSombra: Top=1+29=30)
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
			.Caption   = THIS.Caption
			.Top       = 15
			.Left      = 10
			.Width     = 769
			.Height    = 40
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 16
			.FontBold  = .T.
			.ForeColor = RGB(0, 0, 0)
			.BackStyle = 0
			.Visible   = .T.
		ENDWITH

		loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
		WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
			.Caption   = THIS.Caption
			.Top       = 18
			.Left      = 10
			.Width     = 769
			.Height    = 46
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 16
			.FontBold  = .T.
			.ForeColor = RGB(255, 255, 255)
			.BackStyle = 0
			.Visible   = .T.
		ENDWITH

		*-- Container bot" + CHR(245) + "es CRUD (canonical Left=542, Top=28)
		loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
		WITH loc_oPagina.cnt_4c_Botoes
			.Top         = 28
			.Left        = 542
			.Width       = 390
			.Height      = 85
			.BackStyle = 0
			.BorderWidth = 0
			.Visible     = .T.
		ENDWITH

		*-- Bot" + CHR(227) + "o Incluir
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

		*-- Bot" + CHR(227) + "o Visualizar
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

		*-- Bot" + CHR(227) + "o Alterar
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

		*-- Bot" + CHR(227) + "o Excluir
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

		*-- Bot" + CHR(227) + "o Buscar
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

		*-- Container sa" + CHR(237) + "da - valores can" + CHR(244) + "nicos (CLAUDE.md Regra #10)
		loc_oPagina.AddObject("cnt_4c_Saida", "Container")
		WITH loc_oPagina.cnt_4c_Saida
			.Top         = 28
			.Left        = 917
			.Width       = 90
			.Height      = 85
			.BackStyle   = 0
			.BorderWidth = 0
			.Visible     = .T.
		ENDWITH

		*-- Bot" + CHR(227) + "o Encerrar (can" + CHR(244) + "nico)
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

		*-- Grid de lista (Grade: Top=121+29=150, Left=12, Width=935, Height=470)
		loc_oPagina.AddObject("grd_4c_Lista", "Grid")
		loc_oGrid = loc_oPagina.grd_4c_Lista

		loc_oGrid.ColumnCount  = 2

		WITH loc_oGrid
			.Top                = 150
			.Left               = 12
			.Width              = 935
			.Height             = 470
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

		WITH loc_oGrid.Column1
			.Width           = 60
			.Header1.Caption = "C" + CHR(243) + "digos"
		ENDWITH

		WITH loc_oGrid.Column2
			.Width           = 150
			.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
		ENDWITH

		THIS.TornarControlesVisiveis(loc_oPagina)
	ENDPROC

	*====================================================================
	* ConfigurarPaginaDados - Page2 (Dados)
	* Grupo_Salva: Left=819,Top=10 -> Top=10+29=39
	* Say1 (C" + CHR(243) + "digo): Top=157+29=186, Left=374
	* getCods (txt_4c_Codigo): Top=153+29=182, Left=422, Width=31
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaDados()
		LOCAL loc_oPagina
		loc_oPagina = THIS.pgf_4c_Paginas.Page2

		*-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
		loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

		*-- Container bot" + CHR(245) + "es a" + CHR(231) + CHR(227) + "o (Grupo_Salva: Left=819, Top=10+29=39)
		loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
		WITH loc_oPagina.cnt_4c_BotoesAcao
			.Top         = 39
			.Left        = 819
			.Width       = 160
			.Height      = 85
			.BackStyle   = 0
			.BorderWidth = 0
			.Visible     = .T.
		ENDWITH

		*-- Bot" + CHR(227) + "o Confirmar (Salvar)
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
		BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

		*-- Bot" + CHR(227) + "o Cancelar
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

		*-- Label C" + CHR(243) + "digo (Say1: Top=157+29=186, Left=374, Width=42, Height=15)
		loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
		WITH loc_oPagina.lbl_4c_Codigo
			.Caption   = "C" + CHR(243) + "digo :"
			.Top       = 186
			.Left      = 374
			.Width     = 42
			.Height    = 15
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.FontBold  = .F.
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Alignment = 1
			.Visible   = .T.
		ENDWITH

		*-- TextBox C" + CHR(243) + "digo (getCods: Top=153+29=182, Left=422, Width=31, Height=24)
		loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
		WITH loc_oPagina.txt_4c_Codigo
			.Value         = ""
			.Top           = 182
			.Left          = 422
			.Width         = 31
			.Height        = 24
			.FontName      = "Tahoma"
			.FontSize      = 8
			.MaxLength     = 5
			.Alignment     = 0
			.BackColor     = RGB(255, 255, 255)
			.ForeColor     = RGB(0, 0, 0)
			.Visible       = .T.
		ENDWITH

		*-- Label Descricao (Say2: Top=185+29=214, Left=361, Width=55, Height=15)
		loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
		WITH loc_oPagina.lbl_4c_Descricao
			.Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
			.Top       = 214
			.Left      = 361
			.Width     = 55
			.Height    = 15
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.FontBold  = .F.
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Alignment = 1
			.Visible   = .T.
		ENDWITH

		*-- TextBox Descricao (getDescs: Top=181+29=210, Left=422, Width=150, Height=24)
		loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
		WITH loc_oPagina.txt_4c_Descricao
			.Value         = ""
			.Top           = 210
			.Left          = 422
			.Width         = 150
			.Height        = 24
			.FontName      = "Tahoma"
			.FontSize      = 8
			.MaxLength     = 50
			.SpecialEffect = 1
			.Alignment     = 0
			.BackColor     = RGB(255, 255, 255)
			.ForeColor     = RGB(0, 0, 0)
			.Visible       = .T.
		ENDWITH

		THIS.TornarControlesVisiveis(loc_oPagina)
	ENDPROC

	*====================================================================
	* CarregarLista - Carrega dados no Grid da Page1
	* Busca todos os registros de SigCdFip e popula grd_4c_Lista
	*====================================================================
	PROCEDURE CarregarLista()
		LOCAL loc_lResultado, loc_oGrid
		loc_lResultado = .F.

		TRY
			loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

			IF !THIS.this_oBusinessObject.Buscar("")
				loc_lResultado = .F.
			ELSE
				loc_oGrid.ColumnCount = 2
				loc_oGrid.RecordSource = "cursor_4c_Dados"
				loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
				loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
				loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
				loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
				loc_oGrid.Column1.Width           = 60
				loc_oGrid.Column2.Width           = 150
				THIS.FormatarGridLista(loc_oGrid)
				loc_lResultado = .T.
			ENDIF

		CATCH TO loException
			MostrarErro(loException, "FormFpr.CarregarLista")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* FormatarGridLista - Aplica formata" + CHR(231) + CHR(227) + "o visual ao Grid
	*====================================================================
	PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
		WITH par_oGrid
			.FontName = "Tahoma"
			.FontSize = 8
		ENDWITH
	ENDPROC

	*====================================================================
	* AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
	* par_nPagina: 1 = Lista, 2 = Dados
	*====================================================================
	PROCEDURE AlternarPagina(par_nPagina)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
			loc_lResultado = .F.
		ELSE
			THIS.pgf_4c_Paginas.ActivePage = par_nPagina

			IF par_nPagina = 1
				THIS.CarregarLista()
			ENDIF

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* TornarControlesVisiveis - Torna controles vis" + CHR(237) + "veis recursivamente
	* Itera Pages de PageFrames E Controls de Containers
	*====================================================================
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

	*====================================================================
	* FormParaBO - Transfere dados do Form para o BO
	*====================================================================
	PROTECTED PROCEDURE FormParaBO()
		LOCAL loc_oPagina
		loc_oPagina = THIS.pgf_4c_Paginas.Page2
		THIS.this_oBusinessObject.this_cCods  = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
		THIS.this_oBusinessObject.this_cDescs = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
	ENDPROC

	*====================================================================
	* BOParaForm - Transfere dados do BO para o Form
	*====================================================================
	PROTECTED PROCEDURE BOParaForm()
		LOCAL loc_oPagina
		loc_oPagina = THIS.pgf_4c_Paginas.Page2
		loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
		loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
	ENDPROC

	*====================================================================
	* LimparCampos - Limpa valores dos campos da Page2
	*====================================================================
	PROTECTED PROCEDURE LimparCampos()
		LOCAL loc_oPagina
		loc_oPagina = THIS.pgf_4c_Paginas.Page2
		loc_oPagina.txt_4c_Codigo.Value    = ""
		loc_oPagina.txt_4c_Descricao.Value = ""
	ENDPROC

	*====================================================================
	* HabilitarCampos - Habilita/desabilita campos conforme modo
	* txt_4c_Codigo:    editavel em INCLUIR/BUSCAR (legado: INSERIR/PROCURAR)
	* txt_4c_Descricao: editavel em INCLUIR/ALTERAR/BUSCAR (legado: INSERIR/ALTERAR/PROCURAR)
	*====================================================================
	PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
		LOCAL loc_oPagina
		loc_oPagina = THIS.pgf_4c_Paginas.Page2
		loc_oPagina.txt_4c_Codigo.Enabled    = (par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))
		loc_oPagina.txt_4c_Descricao.Enabled = (par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR"))
	ENDPROC

	*====================================================================
	* AjustarBotoesPorModo - Ajusta estado dos botoes da Page2
	*====================================================================
	PROCEDURE AjustarBotoesPorModo()
		LOCAL loc_oBtnConf, loc_oBtnCanc
		loc_oBtnConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
		loc_oBtnCanc = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar

		DO CASE
			CASE THIS.this_cModoAtual = "VISUALIZAR"
				loc_oBtnConf.Enabled = .F.
			OTHERWISE
				loc_oBtnConf.Enabled = .T.
		ENDCASE

		loc_oBtnCanc.Enabled = .T.
	ENDPROC

	*====================================================================
	* BtnIncluirClick - Prepara Page2 para incluir novo registro
	*====================================================================
	PROCEDURE BtnIncluirClick()
		THIS.this_oBusinessObject.NovoRegistro()
		THIS.LimparCampos()
		THIS.this_cModoAtual = "INCLUIR"
		THIS.HabilitarCampos(.T.)
		THIS.AjustarBotoesPorModo()
		THIS.AlternarPagina(2)
		THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
	ENDPROC

	*====================================================================
	* BtnVisualizarClick - Abre Page2 para visualizar registro (so leitura)
	*====================================================================
	PROCEDURE BtnVisualizarClick()
		LOCAL loc_cCodigo
		loc_cCodigo = ""

		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
			SELECT cursor_4c_Dados
			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
		ENDIF

		IF EMPTY(loc_cCodigo)
			MsgAviso("Selecione um registro na lista!")
			RETURN
		ENDIF

		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
			THIS.BOParaForm()
			THIS.this_cModoAtual = "VISUALIZAR"
			THIS.HabilitarCampos(.F.)
			THIS.AjustarBotoesPorModo()
			THIS.AlternarPagina(2)
			THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
		ENDIF
	ENDPROC

	*====================================================================
	* BtnAlterarClick - Abre Page2 para alterar registro selecionado
	*====================================================================
	PROCEDURE BtnAlterarClick()
		LOCAL loc_cCodigo
		loc_cCodigo = ""

		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
			SELECT cursor_4c_Dados
			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
		ENDIF

		IF EMPTY(loc_cCodigo)
			MsgAviso("Selecione um registro na lista!")
			RETURN
		ENDIF

		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
			THIS.this_oBusinessObject.EditarRegistro()
			THIS.BOParaForm()
			THIS.this_cModoAtual = "ALTERAR"
			THIS.HabilitarCampos(.T.)
			THIS.AjustarBotoesPorModo()
			THIS.AlternarPagina(2)
			THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
		ENDIF
	ENDPROC

	*====================================================================
	* BtnExcluirClick - Abre Page2 para confirmar exclusao
	*====================================================================
	PROCEDURE BtnExcluirClick()
		LOCAL loc_cCodigo
		loc_cCodigo = ""

		IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
			SELECT cursor_4c_Dados
			loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
		ENDIF

		IF EMPTY(loc_cCodigo)
			MsgAviso("Selecione um registro na lista!")
			RETURN
		ENDIF

		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
			THIS.BOParaForm()
			THIS.this_cModoAtual = "EXCLUIR"
			THIS.HabilitarCampos(.F.)
			THIS.AjustarBotoesPorModo()
			THIS.AlternarPagina(2)
			THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
		ENDIF
	ENDPROC

	*====================================================================
	* BtnBuscarClick - Abre Page2 em modo busca (equivale ao PROCURAR do legado)
	*====================================================================
	PROCEDURE BtnBuscarClick()
		THIS.LimparCampos()
		THIS.this_cModoAtual = "BUSCAR"
		THIS.HabilitarCampos(.T.)
		THIS.AjustarBotoesPorModo()
		THIS.AlternarPagina(2)
		THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
	ENDPROC

	*====================================================================
	* BtnEncerrarClick - Fecha o formulario
	*====================================================================
	PROCEDURE BtnEncerrarClick()
		THIS.Release()
	ENDPROC

	*====================================================================
	* BtnSalvarClick - Confirma operacao da Page2 conforme this_cModoAtual
	* VISUALIZAR: volta para lista
	* BUSCAR:     filtra cursor_4c_Dados e volta para lista
	* EXCLUIR:    chama Excluir() (BO valida dependencias em SigCdPro)
	* INCLUIR/ALTERAR: FormParaBO + Salvar()
	*====================================================================
	PROCEDURE BtnSalvarClick()
		LOCAL loc_lSucesso, loc_oPagina, loc_cFiltro, loc_cCodigo, loc_cDescricao
		loc_lSucesso = .F.
		loc_oPagina  = THIS.pgf_4c_Paginas.Page2

		DO CASE
			CASE THIS.this_cModoAtual = "VISUALIZAR"
				THIS.this_cModoAtual = "LISTA"
				THIS.AlternarPagina(1)
				loc_lSucesso = .T.

			CASE THIS.this_cModoAtual = "BUSCAR"
				loc_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
				loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
				loc_cFiltro    = ""

				IF !EMPTY(loc_cCodigo)
					loc_cFiltro = "Cods LIKE " + EscaparSQL(loc_cCodigo + "%")
				ENDIF

				IF !EMPTY(loc_cDescricao)
					IF !EMPTY(loc_cFiltro)
						loc_cFiltro = loc_cFiltro + " AND "
					ENDIF
					loc_cFiltro = loc_cFiltro + "Descs LIKE " + EscaparSQL("%" + loc_cDescricao + "%")
				ENDIF

				THIS.this_oBusinessObject.Buscar(loc_cFiltro)
				IF USED("cursor_4c_Dados")
					GO TOP IN cursor_4c_Dados
				ENDIF
				THIS.this_cModoAtual = "LISTA"
				THIS.pgf_4c_Paginas.ActivePage = 1
				loc_lSucesso = .T.

			CASE THIS.this_cModoAtual = "EXCLUIR"
				TRY
					loc_lSucesso = THIS.this_oBusinessObject.Excluir()
					IF loc_lSucesso
						MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
						THIS.this_cModoAtual = "LISTA"
						THIS.AlternarPagina(1)
					ENDIF
				CATCH TO loException
					MostrarErro(loException, "FormFpr.BtnSalvarClick.Excluir")
				ENDTRY

			OTHERWISE
				THIS.FormParaBO()
				TRY
					loc_lSucesso = THIS.this_oBusinessObject.Salvar()
					IF loc_lSucesso
						MsgInfo("Registro salvo com sucesso!")
						THIS.this_cModoAtual = "LISTA"
						THIS.AlternarPagina(1)
					ENDIF
				CATCH TO loException
					MostrarErro(loException, "FormFpr.BtnSalvarClick.Salvar")
				ENDTRY
		ENDCASE
	ENDPROC

	*====================================================================
	* BtnCancelarClick - Cancela operacao e retorna para lista com todos registros
	*====================================================================
	PROCEDURE BtnCancelarClick()
		THIS.this_cModoAtual = "LISTA"
		THIS.AlternarPagina(1)
	ENDPROC

	*====================================================================
	* Destroy - Libera recursos
	*====================================================================
	PROCEDURE Destroy()
		IF VARTYPE(THIS.this_oBusinessObject) = "O"
			THIS.this_oBusinessObject = .NULL.
		ENDIF
		DODEFAULT()
	ENDPROC

ENDDEFINE
