*====================================================================
* FormMtt.prg
*
* Formulario: Cadastro de Metal/Teor
* Tabela: SigCdMtl (PK: cidchaves, chave negocio: tipos+codigos)
* Herda de: FormBase
*
* Fase 3/8 - Estrutura base: PageFrame, cabecalho, containers
*====================================================================

DEFINE CLASS FormMtt AS FormBase

	*-- Propriedades visuais (PILAR 1 - UX Fidelity - SIGCDMTT)
	Height      = 600
	Width       = 1000
	Caption     = "Cadastro de Metal/Teor"
	AutoCenter  = .T.
	ShowWindow  = 1
	WindowType  = 1
	ControlBox  = .F.
	TitleBar    = 0
	Themes      = .F.
	BorderStyle = 2
	DataSession = 2

	*-- Estado do formulario
	this_oBusinessObject = .NULL.
	this_cModoAtual      = "LISTA"

	*====================================================================
	* Init - Delega para FormBase.Init() que chama InicializarForm()
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			loc_lSucesso = DODEFAULT()
		CATCH TO loException
			MsgErro("Erro ao inicializar FormMtt: " + loException.Message, "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InicializarForm - Configura estrutura completa (chamado por FormBase.Init)
	*====================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lSucesso, loc_lBoOK
		loc_lSucesso = .F.
		TRY
			*-- DataSession=2 reseta SET DATE/CENTURY - corrigir sistematicamente
			SET DATE TO BRITISH
			SET CENTURY ON

			*-- Criar Business Object
			THIS.this_oBusinessObject = CREATEOBJECT("MttBO")
			loc_lBoOK = (VARTYPE(THIS.this_oBusinessObject) = "O")

			IF loc_lBoOK
				*-- Construir interface
				THIS.ConfigurarPageFrame()
				THIS.ConfigurarPaginaLista()
				THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
				THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
				THIS.ConfigurarPaginaDados()

				*-- Carregar dados iniciais (ignorar em validacao de UI sem conexao SQL)
				IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
					THIS.CarregarLista()
				ENDIF

				THIS.pgf_4c_Paginas.Visible = .T.
				THIS.pgf_4c_Paginas.ActivePage = 1
				THIS.this_cModoAtual = "LISTA"
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao criar MttBO", "Erro")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em InicializarForm: " + loException.Message + CHR(13) + ;
			        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29 oculta abas)
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPageFrame()
		THIS.AddObject("pgf_4c_Paginas", "PageFrame")
		THIS.pgf_4c_Paginas.PageCount = 2
		WITH THIS.pgf_4c_Paginas
			.Top     = -29
			.Left    = 0
			.Width   = THIS.Width
			.Height  = THIS.Height + 29
			.Tabs    = .F.
			.TabStop = .F.
			.Visible = .T.
		ENDWITH
		THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
		THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
	ENDPROC

	*====================================================================
	* ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid e saida
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaLista()
		LOCAL loc_oPagina
		loc_oPagina = THIS.pgf_4c_Paginas.Page1
		loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

		*-- Cabecalho escuro com sombra e titulo
		loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
		WITH loc_oPagina.cnt_4c_Cabecalho
			.Top         = 1 + 29
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
			.Width     = THIS.Width - 30
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
			.Width     = THIS.Width - 30
			.Height    = 46
			.FontName  = "Tahoma"
			.FontSize  = 16
			.FontBold  = .T.
			.ForeColor = RGB(255, 255, 255)
			.BackStyle = 0
			.AutoSize  = .F.
			.Visible   = .T.
		ENDWITH

		*-- Container de botoes CRUD (Grupo_op: Left=543, Top=29)
		loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
		WITH loc_oPagina.cnt_4c_Botoes
			.Top         = 0 + 29
			.Left        =  542
			.Width       = 385
			.Height      = 85
			.BackStyle = 0
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

		*-- Container de saida - padrao canonico (Left=917, Width=90)
		loc_oPagina.AddObject("cnt_4c_Saida", "Container")
		WITH loc_oPagina.cnt_4c_Saida
			.Top         = 0 + 29
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

		*-- Grid de listagem (3 colunas: Tipo, Codigo, Descricao)
		*-- RecordSource/ControlSources configurados em CarregarLista()
		loc_oPagina.AddObject("grd_4c_Lista", "Grid")
		WITH loc_oPagina.grd_4c_Lista
			.Top                = 117
			.Left               = 26
			.Width              = 890
			.Height             = 490
			.FontName           = "Verdana"
			.FontSize           = 8
			.ForeColor          = RGB(90, 90, 90)
			.BackColor          = RGB(255, 255, 255)
			.GridLineColor      = RGB(238, 238, 238)
			.GridLines          = 3
			.HighlightBackColor = RGB(255, 255, 255)
			.HighlightForeColor = RGB(15, 41, 104)
			.HighlightStyle     = 2
			.DeleteMark         = .F.
			.RecordMark         = .F.
			.RowHeight          = 16
			.ScrollBars         = 2
			.Visible            = .T.
		ENDWITH
		*-- ColumnCount fora de WITH para garantir criacao imediata das colunas
		loc_oPagina.grd_4c_Lista.ColumnCount = 3

		*-- BINDEVENTs para botoes CRUD e Encerrar
		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
		BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

		THIS.TornarControlesVisiveis(loc_oPagina)
	ENDPROC

	*====================================================================
	* ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar + primeira metade dos campos
	* Fase 5/8: botoes + Label Tipos + TextBox Tipos + Label Codigo
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaDados()
		LOCAL loc_oPagina
		loc_oPagina = THIS.pgf_4c_Paginas.Page2
		loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

		*-- Container de botoes Confirmar/Cancelar (Grupo_Salva: Left=821, Top=8)
		loc_oPagina.AddObject("cnt_4c_Salva", "Container")
		WITH loc_oPagina.cnt_4c_Salva
			.Top         = 8 + 29
			.Left        = 821
			.Width       = 160
			.Height      = 85
			.BackStyle   = 0
			.Visible     = .T.
		ENDWITH

		*-- Botao Confirmar (Grupo_Salva.Salva: Left=5, Top=5)
		loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
		WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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

		*-- Botao Cancelar (Grupo_Salva.Cancelar: Left=80, Top=5)
		loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
		WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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

		*-- BINDEVENTs dos botoes de Page2
		BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
		BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

		*-- Label [M]etal / [T]eor (Say3: Top=120, Left=296, Width=83, ForeColor=90,90,90)
		loc_oPagina.AddObject("lbl_4c_Label3", "Label")
		WITH loc_oPagina.lbl_4c_Label3
			.Caption   = "[M]etal / [T]eor :"
			.Top       = 120 + 29
			.Left      = 296
			.Width     = 83
			.Height    = 17
			.FontName  = "Tahoma"
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.AutoSize  = .F.
			.Visible   = .T.
		ENDWITH

		*-- TextBox Tipos (GetTipos: Top=117, Left=383, Width=17, Height=23, SpecialEffect=1)
		*-- Valid no legado: Inlist(This.Value,"M","T") -> implementado em ValidarTipos()
		loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
		WITH loc_oPagina.txt_4c_Tipos
			.Value         = ""
			.Top           = 117 + 29
			.Left          = 383
			.Width         = 17
			.Height        = 23
			.MaxLength     = 1
			.SpecialEffect = 1
			.FontName      = "Tahoma"
			.FontSize      = 8
			.Visible       = .T.
		ENDWITH

		*-- Label Codigo (Say1: Top=146, Left=337, Width=42, ForeColor=90,90,90)
		loc_oPagina.AddObject("lbl_4c_Label1", "Label")
		WITH loc_oPagina.lbl_4c_Label1
			.Caption   = "C" + CHR(243) + "digo :"
			.Top       = 146 + 29
			.Left      = 337
			.Width     = 42
			.Height    = 17
			.FontName  = "Tahoma"
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.AutoSize  = .F.
			.Visible   = .T.
		ENDWITH

		*-- BINDEVENT para validacao do tipo (Valid: Inlist(Value,"M","T"))
		BINDEVENT(loc_oPagina.txt_4c_Tipos, "LostFocus", THIS, "ValidarTipos")

		*-- TextBox Codigo (getCodigos: Top=143, Left=383, Width=30, Height=23)
		loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
		WITH loc_oPagina.txt_4c_Codigos
			.Value         = ""
			.Top           = 143 + 29
			.Left          = 383
			.Width         = 30
			.Height        = 23
			.MaxLength     = 10
			.SpecialEffect = 1
			.FontName      = "Tahoma"
			.FontSize      = 8
			.Visible       = .T.
		ENDWITH

		*-- Label Descricao (Say2: Top=172, Left=324, Caption="Descricao :")
		loc_oPagina.AddObject("lbl_4c_Label2", "Label")
		WITH loc_oPagina.lbl_4c_Label2
			.Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
			.Top       = 172 + 29
			.Left      = 324
			.Width     = 55
			.Height    = 17
			.FontName  = "Tahoma"
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.AutoSize  = .F.
			.Visible   = .T.
		ENDWITH

		*-- TextBox Descricao (getDescrs: Top=169, Left=383, Width=150, Height=23)
		loc_oPagina.AddObject("txt_4c_Descs", "TextBox")
		WITH loc_oPagina.txt_4c_Descs
			.Value         = ""
			.Top           = 169 + 29
			.Left          = 383
			.Width         = 150
			.Height        = 23
			.MaxLength     = 60
			.SpecialEffect = 1
			.FontName      = "Tahoma"
			.FontSize      = 8
			.Visible       = .T.
		ENDWITH

		THIS.TornarControlesVisiveis(loc_oPagina)
	ENDPROC

	*====================================================================
	* CarregarLista - Busca registros e configura grid da Page1
	*====================================================================
	PROCEDURE CarregarLista()
		LOCAL loc_lResultado, loc_oGrid
		loc_lResultado = .F.

		TRY
			IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				CREATE CURSOR cursor_4c_Dados (tipos C(1), codigos C(10), descs C(60), cidchaves C(10))
				loc_lResultado = .T.
			ELSE
				IF THIS.this_oBusinessObject.Buscar("")
					loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

					*-- RecordSource fora de WITH (Problem 36: garante criacao imediata)
					loc_oGrid.ColumnCount = 3
					loc_oGrid.RecordSource = "cursor_4c_Dados"

					*-- ControlSources APOS RecordSource (Problem 48: evita auto-bind errado)
					WITH loc_oGrid
						.Column1.ControlSource = "cursor_4c_Dados.tipos"
						.Column2.ControlSource = "cursor_4c_Dados.codigos"
						.Column3.ControlSource = "cursor_4c_Dados.descs"

						.Column1.Width     = 30
						.Column2.Width     = 75
						.Column3.Width     = 300

						*-- Headers reconfigurados apos RecordSource (Problem 6/32)
						.Column1.Header1.Caption = "Tipo"
						.Column2.Header1.Caption = "C" + CHR(243) + "digo"
						.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

						.Column1.Alignment = 2
						.Column2.Alignment = 2
						.Column3.Alignment = 0
					ENDWITH

					THIS.FormatarGridLista(loc_oGrid)
					loc_lResultado = .T.
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarLista: " + loException.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
	*====================================================================
	PROCEDURE AlternarPagina(par_nPagina)
		IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
			RETURN .F.
		ENDIF
		THIS.pgf_4c_Paginas.ActivePage = par_nPagina
		IF par_nPagina = 1
			THIS.this_cModoAtual = "LISTA"
			THIS.CarregarLista()
		ENDIF
		RETURN .T.
	ENDPROC

	*====================================================================
	* FormatarGridLista - Formata visual do grid (chamado apos RecordSource)
	*====================================================================
	PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
		WITH par_oGrid
			.FontName = "Tahoma"
			.FontSize = 8
		ENDWITH
	ENDPROC

	*====================================================================
	* TornarControlesVisiveis - Torna controles visiveis recursivamente
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
	* BtnIncluirClick - Inicia inclusao de novo registro
	*====================================================================
	PROCEDURE BtnIncluirClick()
		THIS.this_oBusinessObject.NovoRegistro()
		THIS.LimparCampos()
		THIS.this_cModoAtual = "INCLUIR"
		THIS.HabilitarCampos(.T.)
		THIS.AjustarBotoesPorModo()
		THIS.AlternarPagina(2)
		IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Tipos", 5)
			THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus
		ENDIF
	ENDPROC

	*====================================================================
	* BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
	*====================================================================
	PROCEDURE BtnVisualizarClick()
		LOCAL loc_cCidchaves
		loc_cCidchaves = ""

		IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
			MsgAviso("Selecione um registro para visualizar!", "")
			RETURN
		ENDIF

		SELECT cursor_4c_Dados
		loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

		IF EMPTY(loc_cCidchaves)
			MsgAviso("Selecione um registro para visualizar!", "")
			RETURN
		ENDIF

		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
			THIS.this_cModoAtual = "VISUALIZAR"
			THIS.BOParaForm()
			THIS.HabilitarCampos(.F.)
			THIS.AjustarBotoesPorModo()
			THIS.AlternarPagina(2)
		ELSE
			MsgAviso("Erro ao carregar registro selecionado!", "")
		ENDIF
	ENDPROC

	*====================================================================
	* BtnAlterarClick - Altera registro selecionado
	*====================================================================
	PROCEDURE BtnAlterarClick()
		LOCAL loc_cCidchaves
		loc_cCidchaves = ""

		IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
			MsgAviso("Selecione um registro para alterar!", "")
			RETURN
		ENDIF

		SELECT cursor_4c_Dados
		loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

		IF EMPTY(loc_cCidchaves)
			MsgAviso("Selecione um registro para alterar!", "")
			RETURN
		ENDIF

		IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
			THIS.this_oBusinessObject.EditarRegistro()
			THIS.this_cModoAtual = "ALTERAR"
			THIS.BOParaForm()
			THIS.HabilitarCampos(.T.)
			THIS.AjustarBotoesPorModo()
			THIS.AlternarPagina(2)
			IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Descs", 5)
				THIS.pgf_4c_Paginas.Page2.txt_4c_Descs.SetFocus
			ENDIF
		ELSE
			MsgAviso("Erro ao carregar registro selecionado!", "")
		ENDIF
	ENDPROC

	*====================================================================
	* BtnExcluirClick - Exclui registro selecionado com confirmacao
	*====================================================================
	PROCEDURE BtnExcluirClick()
		LOCAL loc_cCidchaves, loc_lConfirmar
		loc_cCidchaves = ""
		loc_lConfirmar = .F.

		IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
			MsgAviso("Selecione um registro para excluir!", "")
			RETURN
		ENDIF

		SELECT cursor_4c_Dados
		loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

		IF EMPTY(loc_cCidchaves)
			MsgAviso("Selecione um registro para excluir!", "")
			RETURN
		ENDIF

		loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", "Excluir")
		IF loc_lConfirmar
			IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
				IF THIS.this_oBusinessObject.Excluir()
					MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
					THIS.CarregarLista()
				ELSE
					MsgAviso("Erro ao excluir registro!", "")
				ENDIF
			ELSE
				MsgAviso("Erro ao carregar registro para exclus" + CHR(227) + "o!", "")
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* BtnBuscarClick - Recarrega lista com todos os registros
	*====================================================================
	PROCEDURE BtnBuscarClick()
		THIS.LimparCampos()
		THIS.this_cModoAtual = "BUSCAR"
		THIS.HabilitarCampos(.T.)
		THIS.AjustarBotoesPorModo()
		THIS.AlternarPagina(2)
		IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
			THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
		ENDIF
	ENDPROC

	*====================================================================
	* BtnEncerrarClick - Fecha o formulario
	*====================================================================
	PROCEDURE BtnEncerrarClick()
		THIS.Release()
	ENDPROC

	*====================================================================
	* BOParaForm - Transfere propriedades do BO para controles de Page2
	*====================================================================
	PROTECTED PROCEDURE BOParaForm()
		LOCAL loc_oPg2
		loc_oPg2 = THIS.pgf_4c_Paginas.Page2
		IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
			loc_oPg2.txt_4c_Tipos.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
		ENDIF
		IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
			loc_oPg2.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
		ENDIF
		IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
			loc_oPg2.txt_4c_Descs.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
		ENDIF
	ENDPROC

	*====================================================================
	* FormParaBO - Transfere valores dos controles de Page2 para o BO
	*====================================================================
	PROTECTED PROCEDURE FormParaBO()
		LOCAL loc_oPg2
		loc_oPg2 = THIS.pgf_4c_Paginas.Page2
		IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
			THIS.this_oBusinessObject.this_cTipos   = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tipos.Value))
		ENDIF
		IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
			THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
		ENDIF
		IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
			THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(loc_oPg2.txt_4c_Descs.Value)
		ENDIF
	ENDPROC

	*====================================================================
	* LimparCampos - Limpa valores dos controles de Page2
	*====================================================================
	PROTECTED PROCEDURE LimparCampos()
		LOCAL loc_oPg2
		loc_oPg2 = THIS.pgf_4c_Paginas.Page2
		IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
			loc_oPg2.txt_4c_Tipos.Value   = ""
		ENDIF
		IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
			loc_oPg2.txt_4c_Codigos.Value = ""
		ENDIF
		IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
			loc_oPg2.txt_4c_Descs.Value   = ""
		ENDIF
	ENDPROC

	*====================================================================
	* HabilitarCampos - Habilita ou desabilita controles editaveis de Page2
	* Em INCLUIR: codigos habilitado; em ALTERAR/VISUALIZAR: codigos desabilitado
	*====================================================================
	PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
		LOCAL loc_oPg2, loc_lCodigosEnabled
		loc_oPg2 = THIS.pgf_4c_Paginas.Page2
		loc_lCodigosEnabled = (par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))

		IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
			loc_oPg2.txt_4c_Tipos.Enabled   = par_lHabilitar
		ENDIF
		IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
			loc_oPg2.txt_4c_Codigos.Enabled = loc_lCodigosEnabled
		ENDIF
		IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
			loc_oPg2.txt_4c_Descs.Enabled   = par_lHabilitar
		ENDIF
	ENDPROC

	*====================================================================
	* AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual
	*====================================================================
	PROCEDURE AjustarBotoesPorModo()
		LOCAL loc_oCnt, loc_lEditando
		loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
		loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva

		IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
			loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
		ENDIF
		IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
			loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
		ENDIF
	ENDPROC

	*====================================================================
	* BtnSalvarClick - Confirmar: valida, transfere para BO e salva
	*====================================================================
	PROCEDURE BtnSalvarClick()
		LOCAL loc_oPg2, loc_cFiltro, loc_cTiposFlt, loc_cCodFlt, loc_cDescFlt, loc_oGrid
		loc_oPg2 = THIS.pgf_4c_Paginas.Page2

		*-- Modo BUSCAR: filtra lista por criterios digitados na Page2
		IF THIS.this_cModoAtual = "BUSCAR"
			loc_cFiltro   = ""
			loc_cTiposFlt = ""
			loc_cCodFlt   = ""
			loc_cDescFlt  = ""
			IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
				loc_cTiposFlt = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tipos.Value))
			ENDIF
			IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
				loc_cCodFlt = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
			ENDIF
			IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
				loc_cDescFlt = ALLTRIM(loc_oPg2.txt_4c_Descs.Value)
			ENDIF
			IF !EMPTY(loc_cTiposFlt)
				loc_cFiltro = "tipos = " + EscaparSQL(loc_cTiposFlt)
			ENDIF
			IF !EMPTY(loc_cCodFlt)
				IF !EMPTY(loc_cFiltro)
					loc_cFiltro = loc_cFiltro + " AND "
				ENDIF
				loc_cFiltro = loc_cFiltro + "codigos LIKE " + EscaparSQL(loc_cCodFlt + "%")
			ENDIF
			IF !EMPTY(loc_cDescFlt)
				IF !EMPTY(loc_cFiltro)
					loc_cFiltro = loc_cFiltro + " AND "
				ENDIF
				loc_cFiltro = loc_cFiltro + "descs LIKE " + EscaparSQL(loc_cDescFlt + "%")
			ENDIF
			IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
				THIS.this_cModoAtual = "LISTA"
				THIS.pgf_4c_Paginas.Visible = .T.
				THIS.pgf_4c_Paginas.ActivePage = 1
				loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
				loc_oGrid.ColumnCount = 3
				loc_oGrid.RecordSource = "cursor_4c_Dados"
				WITH loc_oGrid
					.Column1.ControlSource   = "cursor_4c_Dados.tipos"
					.Column2.ControlSource   = "cursor_4c_Dados.codigos"
					.Column3.ControlSource   = "cursor_4c_Dados.descs"
					.Column1.Width           = 30
					.Column2.Width           = 75
					.Column3.Width           = 300
					.Column1.Header1.Caption = "Tipo"
					.Column2.Header1.Caption = "C" + CHR(243) + "digo"
					.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
					.Column1.Alignment       = 2
					.Column2.Alignment       = 2
					.Column3.Alignment       = 0
				ENDWITH
				THIS.FormatarGridLista(loc_oGrid)
			ENDIF
			RETURN
		ENDIF

		*-- Validacao de Codigo obrigatorio em INCLUIR (antes do TRY - Problem 16)
		IF THIS.this_cModoAtual = "INCLUIR" AND ;
		   PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5) AND ;
		   EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigos.Value))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!", "")
			IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
				loc_oPg2.txt_4c_Codigos.SetFocus
			ENDIF
			RETURN
		ENDIF

		THIS.FormParaBO()

		IF THIS.this_oBusinessObject.ValidarDados()
			IF THIS.this_oBusinessObject.Salvar()
				MsgInfo("Registro salvo com sucesso!", "")
				THIS.AlternarPagina(1)
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* BtnCancelarClick - Cancela edicao e retorna para lista
	*====================================================================
	PROCEDURE BtnCancelarClick()
		THIS.AlternarPagina(1)
	ENDPROC

	*====================================================================
	* ValidarTipos - Valid event de txt_4c_Tipos: aceita apenas "M" ou "T"
	*====================================================================
	PROCEDURE ValidarTipos()
		LOCAL loc_cValor
		loc_cValor = UPPER(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.Value))
		IF EMPTY(loc_cValor)
			RETURN .T.
		ENDIF
		IF !INLIST(loc_cValor, "M", "T")
			MsgAviso("[M]etal / [T]eor: informe M ou T!", "")
			RETURN .F.
		ENDIF
		THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.Value = loc_cValor
		RETURN .T.
	ENDPROC

	*====================================================================
	* Destroy - Libera recursos ao fechar o formulario
	*====================================================================
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
