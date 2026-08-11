*====================================================================
* FormFap.prg
*
* Formulario de Cadastro de Envio para Recuperacao
* Tabela: SigCdFea
* BO: FapBO
*====================================================================

DEFINE CLASS FormFap AS FormBase

	*-- Propriedades visuais (PILAR 1 - UX Fidelity)
	Height      = 600
	Width       = 1000
	Caption     = "Envio para Recuperacao"
	AutoCenter  = .T.
	ShowWindow  = 1
	WindowType  = 1
	ControlBox  = .F.
	TitleBar    = 0
	Themes      = .F.
	BorderStyle = 2

	*-- Business Object
	this_oBusinessObject = .NULL.

	*-- Modo atual (LISTA / INCLUIR / ALTERAR / VISUALIZAR)
	this_cModoAtual = "LISTA"

	*-- Tipo de registro ('F' = default, conforme parametro original _Tipo)
	this_cTipo = "F"

	*====================================================================
	* Init - Apenas delega ao FormBase (NAO chamar InicializarForm aqui!)
	*====================================================================
	PROCEDURE Init(par_cTipo)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF VARTYPE(par_cTipo) = "C" AND !EMPTY(par_cTipo)
				THIS.this_cTipo = ALLTRIM(par_cTipo)
			ENDIF
			loc_lResultado = DODEFAULT()
		CATCH TO loc_oErro
			MsgErro("Erro ao inicializar FormFap: " + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* InicializarForm - Montagem da estrutura (chamado pelo FormBase.Init)
	*====================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Criar e configurar Business Object
			THIS.this_oBusinessObject = CREATEOBJECT("FapBO")

			IF VARTYPE(THIS.this_oBusinessObject) != "O"
				MsgErro("Erro ao criar FapBO." + CHR(13) + "VARTYPE retornou: " + ;
					VARTYPE(THIS.this_oBusinessObject), "Erro")
			ELSE
				*-- Propagar tipo para o BO
				THIS.this_oBusinessObject.this_cTipos = THIS.this_cTipo

				*-- Montar estrutura visual
				THIS.ConfigurarPageFrame()
				THIS.ConfigurarPaginaLista()
				THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
				THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
				THIS.ConfigurarPaginaDados()

				*-- Carregar lista inicial (pular se validando UI sem conexao)
				IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
					THIS.CarregarLista()
				ENDIF

				THIS.pgf_4c_Paginas.Visible = .T.
				THIS.pgf_4c_Paginas.ActivePage = 1
				THIS.this_cModoAtual = "LISTA"

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FormFap.InicializarForm: " + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPageFrame()
		TRY
			THIS.AddObject("pgf_4c_Paginas", "PageFrame")

			WITH THIS.pgf_4c_Paginas
				.PageCount  = 2
				.Top        = -29
				.Left       = 0
				.Width      = THIS.Width
				.Height     = THIS.Height + 29
				.Tabs       = .F.
				.TabStop    = .F.
				.Visible    = .T.

				.Page1.Caption    = "Lista"
				.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
				.Page1.BackColor  = RGB(255, 255, 255)

				.Page2.Caption    = "Dados"
				.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
				.Page2.BackColor  = RGB(255, 255, 255)
			ENDWITH
		CATCH TO loc_oErro
			MsgErro("Erro em ConfigurarPageFrame: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* ConfigurarPaginaLista - Monta Page1: cabecalho + botoes CRUD + grid
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaLista()
		LOCAL loc_oPagina, loc_oGrid
		loc_oPagina = .NULL.
		loc_oGrid   = .NULL.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page1

			*-- Imagem de fundo da pagina
			loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

			*------------------------------------------------------------
			*-- Container cabecalho (faixa cinza escura com titulo)
			*------------------------------------------------------------
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
				.Caption    = THIS.Caption
				.Top        = 15
				.Left       = 10
				.Width      = 769
				.Height     = 40
				.AutoSize   = .F.
				.FontName   = "Tahoma"
				.FontSize   = 16
				.FontBold   = .T.
				.ForeColor  = RGB(0, 0, 0)
				.BackStyle  = 0
				.Visible    = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
			WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
				.Caption    = THIS.Caption
				.Top        = 18
				.Left       = 10
				.Width      = 769
				.Height     = 46
				.AutoSize   = .F.
				.FontName   = "Tahoma"
				.FontSize   = 16
				.FontBold   = .T.
				.ForeColor  = RGB(255, 255, 255)
				.BackStyle  = 0
				.Visible    = .T.
			ENDWITH

			*------------------------------------------------------------
			*-- Container botoes CRUD (faixa cinza direita)
			*------------------------------------------------------------
			loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
			WITH loc_oPagina.cnt_4c_Botoes
				.Top         = 29
				.Left        = 542
				.Width       = 390
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
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
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
				.BackColor       = RGB(255, 255, 255)
				.ForeColor       = RGB(90, 90, 90)
				.FontName        = "Tahoma"
				.FontSize        = 8
				.FontBold        = .T.
				.FontItalic      = .T.
				.Themes          = .F.
				.SpecialEffect   = 0
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
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
				.BackColor       = RGB(255, 255, 255)
				.ForeColor       = RGB(90, 90, 90)
				.FontName        = "Tahoma"
				.FontSize        = 8
				.FontBold        = .T.
				.FontItalic      = .T.
				.Themes          = .F.
				.SpecialEffect   = 0
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
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
				.BackColor       = RGB(255, 255, 255)
				.ForeColor       = RGB(90, 90, 90)
				.FontName        = "Tahoma"
				.FontSize        = 8
				.FontBold        = .T.
				.FontItalic      = .T.
				.Themes          = .F.
				.SpecialEffect   = 0
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
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
				.BackColor       = RGB(255, 255, 255)
				.ForeColor       = RGB(90, 90, 90)
				.FontName        = "Tahoma"
				.FontSize        = 8
				.FontBold        = .T.
				.FontItalic      = .T.
				.Themes          = .F.
				.SpecialEffect   = 0
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
				.Visible         = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

			*------------------------------------------------------------
			*-- Container saida - padrao canonico (Left=917, Width=90)
			*------------------------------------------------------------
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
				.BackColor       = RGB(255, 255, 255)
				.ForeColor       = RGB(90, 90, 90)
				.FontName        = "Tahoma"
				.FontSize        = 8
				.FontBold        = .T.
				.FontItalic      = .T.
				.Themes          = .F.
				.SpecialEffect   = 0
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
				.Visible         = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

			*------------------------------------------------------------
			*-- Cursor placeholder para vincular ao grid antes da primeira carga
			*-- SET NULL ON: aceita NULLs do SQL Server no APPEND FROM
			*------------------------------------------------------------
			SET NULL ON
			CREATE CURSOR cursor_4c_Dados ( ;
				numes     N(10,0), ;
				datas     D, ;
				ifors     C(20), ;
				grupos    C(10), ;
				contas    C(20), ;
				tpmats    C(10), ;
				brutos    N(14,4), ;
				trabs     N(14,4), ;
				falhas    N(14,4), ;
				produzidos N(14,4), ;
				pesoccbs  N(14,4), ;
				pesoscbs  N(14,4), ;
				baixas    L, ;
				cidchaves C(20), ;
				emps      C(3), ;
				tipos     C(1), ;
				numbals   N(10,0))
			SET NULL OFF

			*------------------------------------------------------------
			*-- Grid de listagem
			*-- RecordSource e ColumnCount FORA do WITH (Problem 36)
			*------------------------------------------------------------
			loc_oPagina.AddObject("grd_4c_Lista", "Grid")
			loc_oGrid = loc_oPagina.grd_4c_Lista

			loc_oGrid.Top          = 117
			loc_oGrid.Left         = 26
			loc_oGrid.Width        = 890
			loc_oGrid.Height       = 450
			loc_oGrid.ColumnCount  = 12
			loc_oGrid.RecordSource = "cursor_4c_Dados"

			WITH loc_oGrid
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

				.Column1.ControlSource   = "cursor_4c_Dados.numes"
				.Column1.Width           = 55
				.Column1.Header1.Caption = "N" + CHR(250) + "mero"
				.Column1.Alignment       = 1

				.Column2.ControlSource   = "cursor_4c_Dados.datas"
				.Column2.Width           = 78
				.Column2.Header1.Caption = "Data"
				.Column2.Alignment       = 1

				.Column3.ControlSource   = "cursor_4c_Dados.grupos"
				.Column3.Width           = 65
				.Column3.Header1.Caption = "Grupo"

				.Column4.ControlSource   = "cursor_4c_Dados.contas"
				.Column4.Width           = 75
				.Column4.Header1.Caption = "Conta"

				.Column5.ControlSource   = "cursor_4c_Dados.ifors"
				.Column5.Width           = 100
				.Column5.Header1.Caption = "Recuperadora"

				.Column6.ControlSource   = "cursor_4c_Dados.tpmats"
				.Column6.Width           = 68
				.Column6.Header1.Caption = "Tp. Material"

				.Column7.ControlSource   = "cursor_4c_Dados.brutos"
				.Column7.Width           = 68
				.Column7.Header1.Caption = "Bruto (g)"
				.Column7.Alignment       = 1

				.Column8.ControlSource   = "cursor_4c_Dados.trabs"
				.Column8.Width           = 78
				.Column8.Header1.Caption = "Trabalhado (g)"
				.Column8.Alignment       = 1

				.Column9.ControlSource   = "cursor_4c_Dados.falhas"
				.Column9.Width           = 65
				.Column9.Header1.Caption = "Falha (g)"
				.Column9.Alignment       = 1

				.Column10.ControlSource   = "cursor_4c_Dados.produzidos"
				.Column10.Width           = 75
				.Column10.Header1.Caption = "Produzido (g)"
				.Column10.Alignment       = 1

				.Column11.ControlSource   = "cursor_4c_Dados.pesoccbs"
				.Column11.Width           = 72
				.Column11.Header1.Caption = "Total C/Cob."
				.Column11.Alignment       = 1

				.Column12.ControlSource   = "cursor_4c_Dados.pesoscbs"
				.Column12.Width           = 71
				.Column12.Header1.Caption = "Total S/Cob."
				.Column12.Alignment       = 1
			ENDWITH

			THIS.TornarControlesVisiveis(loc_oPagina)
		CATCH TO loc_oErro
			MsgErro("Erro em ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* ConfigurarPaginaDados - Monta Page2: area de campos + botoes acao
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaDados()
		LOCAL loc_oPagina
		loc_oPagina = .NULL.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			*-- Imagem de fundo da pagina
			loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

			*-- Container botoes de acao (Confirmar/Cancelar)
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

			*-- Container saida na pagina de dados (padrao canonico)
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

			*------------------------------------------------------------
			*-- Botoes de acao: Confirmar e Cancelar
			*------------------------------------------------------------
			loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
			WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
				.Visible         = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

			loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
			WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
				.Visible         = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

			*-- Botao Encerrar na pagina de dados (padrao canonico)
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
				.WordWrap        = .T.
				.AutoSize        = .F.
				.MousePointer    = 15
				.Visible         = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

			*------------------------------------------------------------
			*-- Label e campo Numero/Codigo
			*-- getCodigos -> txt_4c_Codigos: editavel somente no modo BUSCAR
			*------------------------------------------------------------
			loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
			WITH loc_oPagina.lbl_4c_Codigo
				.Caption   = "C" + CHR(243) + "digo :"
				.Top       = 221
				.Left      = 189
				.Width     = 42
				.Height    = 17
				.AutoSize  = .T.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
			WITH loc_oPagina.txt_4c_Codigos
				.Value     = ""
				.InputMask = "999999"
				.MaxLength = 7
				.Top       = 216
				.Left      = 242
				.Width     = 52
				.Height    = 25
				.FontName  = "Tahoma"
				.FontSize  = 8
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH

			*------------------------------------------------------------
			*-- Label e campo Data
			*-- getDatas -> txt_4c_Datas: editavel em INCLUIR/ALTERAR
			*------------------------------------------------------------
			loc_oPagina.AddObject("lbl_4c_Data", "Label")
			WITH loc_oPagina.lbl_4c_Data
				.Caption   = "Data :"
				.Top       = 220
				.Left      = 496
				.Width     = 32
				.Height    = 17
				.AutoSize  = .T.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
			WITH loc_oPagina.txt_4c_Datas
				.Value     = {}
				.MaxLength = 10
				.Top       = 216
				.Left      = 534
				.Width     = 79
				.Height    = 25
				.FontName  = "Tahoma"
				.FontSize  = 8
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH

			*------------------------------------------------------------
			*-- Shape decorativo (bordas da area de campos)
			*------------------------------------------------------------
			loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
			WITH loc_oPagina.shp_4c_Shape1
				.Top         = 203
				.Left        = 166
				.Width       = 466
				.Height      = 296
				.BackStyle   = 0
				.BorderStyle = 0
				.BorderColor = RGB(136, 189, 188)
				.Visible     = .T.
			ENDWITH

			*------------------------------------------------------------
			*-- Label e campos de Grupo
			*-- getCdGrupo -> txt_4c_CdGrupo: lookup SigCdGcr (BalFalPers=1)
			*-- getDsGrupo -> txt_4c_DsGrupo: descricao somente leitura
			*------------------------------------------------------------
			loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
			WITH loc_oPagina.lbl_4c_Grupo
				.Caption   = "Grupo :"
				.Top       = 247
				.Left      = 195
				.Width     = 38
				.Height    = 17
				.AutoSize  = .T.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.AddObject("txt_4c_CdGrupo", "TextBox")
			WITH loc_oPagina.txt_4c_CdGrupo
				.Value     = ""
				.MaxLength = 10
				.Top       = 243
				.Left      = 242
				.Width     = 79
				.Height    = 25
				.FontName  = "Courier New"
				.FontSize  = 9
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "ValidarGrupo")
			BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "CdGrupoKeyPress")
			BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "DblClick", THIS, "CdGrupoDblClick")

			loc_oPagina.AddObject("txt_4c_DsGrupo", "TextBox")
			WITH loc_oPagina.txt_4c_DsGrupo
				.Value     = ""
				.MaxLength = 20
				.Top       = 243
				.Left      = 323
				.Width     = 290
				.Height    = 25
				.FontName  = "Courier New"
				.FontSize  = 9
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH

			*------------------------------------------------------------
			*-- Label e campos de Conta
			*-- getCdConta -> txt_4c_CdConta: lookup SigCdCli filtrado por Grupo
			*-- getDsConta -> txt_4c_DsConta: descricao somente leitura
			*------------------------------------------------------------
			loc_oPagina.AddObject("lbl_4c_Conta", "Label")
			WITH loc_oPagina.lbl_4c_Conta
				.Caption   = "Conta :"
				.Top       = 275
				.Left      = 196
				.Width     = 38
				.Height    = 17
				.AutoSize  = .T.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.AddObject("txt_4c_CdConta", "TextBox")
			WITH loc_oPagina.txt_4c_CdConta
				.Value     = ""
				.MaxLength = 10
				.Top       = 270
				.Left      = 242
				.Width     = 79
				.Height    = 25
				.FontName  = "Courier New"
				.FontSize  = 9
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.txt_4c_CdConta, "KeyPress", THIS, "ValidarConta")
			BINDEVENT(loc_oPagina.txt_4c_CdConta, "KeyPress", THIS, "CdContaKeyPress")
			BINDEVENT(loc_oPagina.txt_4c_CdConta, "DblClick", THIS, "CdContaDblClick")

			loc_oPagina.AddObject("txt_4c_DsConta", "TextBox")
			WITH loc_oPagina.txt_4c_DsConta
				.Value     = ""
				.MaxLength = 40
				.Top       = 270
				.Left      = 323
				.Width     = 290
				.Height    = 25
				.FontName  = "Courier New"
				.FontSize  = 9
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH

			*------------------------------------------------------------
			*-- Container4: Produzido (g)
			*-- txt_4c_Prdz editavel somente quando CdGrupo e CdConta vazios
			*------------------------------------------------------------
			loc_oPagina.AddObject("cnt_4c_Container4", "Container")
			WITH loc_oPagina.cnt_4c_Container4
				.Top         = 298
				.Left        = 192
				.Width       = 421
				.Height      = 29
				.BackStyle   = 0
				.BorderWidth = 0
				.Visible     = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container4.AddObject("lbl_4c_Produzido", "Label")
			WITH loc_oPagina.cnt_4c_Container4.lbl_4c_Produzido
				.Caption   = "Produzido (g) :"
				.Top       = 6
				.Left      = 15
				.Width     = 73
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container4.AddObject("txt_4c_Prdz", "TextBox")
			WITH loc_oPagina.cnt_4c_Container4.txt_4c_Prdz
				.Value     = .F.
				.MaxLength = 15
				.Top       = 3
				.Left      = 104
				.Width     = 80
				.Height    = 23
				.FontName  = "Tahoma"
				.FontSize  = 8
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH

			*------------------------------------------------------------
			*-- Container3: Trabalhado (g) / Falha (g)
			*-- Ativo apenas para Tipo='F' (Fundicao)
			*------------------------------------------------------------
			loc_oPagina.AddObject("cnt_4c_Container3", "Container")
			WITH loc_oPagina.cnt_4c_Container3
				.Top         = 330
				.Left        = 192
				.Width       = 421
				.Height      = 29
				.BackStyle   = 0
				.BorderWidth = 0
				.Visible     = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container3.AddObject("lbl_4c_Trabalhado", "Label")
			WITH loc_oPagina.cnt_4c_Container3.lbl_4c_Trabalhado
				.Caption   = "Trabalhado (g) :"
				.Top       = 6
				.Left      = 9
				.Width     = 80
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container3.AddObject("txt_4c_PTrab", "TextBox")
			WITH loc_oPagina.cnt_4c_Container3.txt_4c_PTrab
				.Value     = .F.
				.MaxLength = 15
				.Top       = 3
				.Left      = 104
				.Width     = 80
				.Height    = 23
				.FontName  = "Tahoma"
				.FontSize  = 8
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container3.AddObject("lbl_4c_Falha", "Label")
			WITH loc_oPagina.cnt_4c_Container3.lbl_4c_Falha
				.Caption   = "Falha  (g):"
				.Top       = 6
				.Left      = 233
				.Width     = 55
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container3.AddObject("txt_4c_Pfalha", "TextBox")
			WITH loc_oPagina.cnt_4c_Container3.txt_4c_Pfalha
				.Value     = .F.
				.MaxLength = 15
				.Top       = 3
				.Left      = 295
				.Width     = 80
				.Height    = 23
				.FontName  = "Tahoma"
				.FontSize  = 8
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH

			*------------------------------------------------------------
			*-- Container1: Peso Bruto / Recuperadora / Tipo de Material
			*-- Ativo apenas para Tipo != 'F'
			*------------------------------------------------------------
			loc_oPagina.AddObject("cnt_4c_Container1", "Container")
			WITH loc_oPagina.cnt_4c_Container1
				.Top         = 362
				.Left        = 192
				.Width       = 421
				.Height      = 58
				.BackStyle   = 0
				.BorderWidth = 0
				.Visible     = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container1.AddObject("lbl_4c_PesoBruto", "Label")
			WITH loc_oPagina.cnt_4c_Container1.lbl_4c_PesoBruto
				.Caption   = "Peso Bruto (g) :"
				.Top       = 8
				.Left      = 9
				.Width     = 78
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container1.AddObject("txt_4c_pesob", "TextBox")
			WITH loc_oPagina.cnt_4c_Container1.txt_4c_pesob
				.Value     = .F.
				.MaxLength = 15
				.Top       = 5
				.Left      = 103
				.Width     = 80
				.Height    = 23
				.FontName  = "Tahoma"
				.FontSize  = 8
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container1.AddObject("lbl_4c_Recuperadora", "Label")
			WITH loc_oPagina.cnt_4c_Container1.lbl_4c_Recuperadora
				.Caption   = "Recuperadora :"
				.Top       = 32
				.Left      = 11
				.Width     = 77
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container1.AddObject("txt_4c_ifor", "TextBox")
			WITH loc_oPagina.cnt_4c_Container1.txt_4c_ifor
				.Value     = ""
				.MaxLength = 20
				.Top       = 30
				.Left      = 103
				.Width     = 80
				.Height    = 23
				.FontName  = "Courier New"
				.FontSize  = 9
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_ifor, "KeyPress", THIS, "ValidarIfor")
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_ifor, "KeyPress", THIS, "IforKeyPress")
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_ifor, "DblClick", THIS, "IforDblClick")

			loc_oPagina.cnt_4c_Container1.AddObject("lbl_4c_TpMat", "Label")
			WITH loc_oPagina.cnt_4c_Container1.lbl_4c_TpMat
				.Caption   = "Tipo de Material :"
				.Top       = 8
				.Left      = 193
				.Width     = 85
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container1.AddObject("txt_4c_tpmat", "TextBox")
			WITH loc_oPagina.cnt_4c_Container1.txt_4c_tpmat
				.Value     = ""
				.MaxLength = 10
				.Top       = 5
				.Left      = 294
				.Width     = 115
				.Height    = 23
				.FontName  = "Courier New"
				.FontSize  = 9
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_tpmat, "KeyPress", THIS, "ValidarTpmat")
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_tpmat, "KeyPress", THIS, "TpmatKeyPress")
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_tpmat, "DblClick", THIS, "TpmatDblClick")

			loc_oPagina.cnt_4c_Container1.AddObject("txt_4c_dfor", "TextBox")
			WITH loc_oPagina.cnt_4c_Container1.txt_4c_dfor
				.Value     = ""
				.MaxLength = 40
				.Top       = 30
				.Left      = 184
				.Width     = 225
				.Height    = 23
				.FontName  = "Courier New"
				.FontSize  = 9
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_dfor, "KeyPress", THIS, "ValidarDfor")
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_dfor, "KeyPress", THIS, "DforKeyPress")
			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_dfor, "DblClick", THIS, "DforDblClick")

			*------------------------------------------------------------
			*-- Container2: Material Recuperado (Total C/ e S/ Cobranca)
			*-- Ativo apenas para Tipo != 'F'
			*-- LostFocus dos totais atualiza this_lBaixas no BO
			*------------------------------------------------------------
			loc_oPagina.AddObject("cnt_4c_Container2", "Container")
			WITH loc_oPagina.cnt_4c_Container2
				.Top         = 423
				.Left        = 192
				.Width       = 421
				.Height      = 53
				.BackStyle   = 0
				.BorderWidth = 0
				.Visible     = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container2.AddObject("lbl_4c_MatRec", "Label")
			WITH loc_oPagina.cnt_4c_Container2.lbl_4c_MatRec
				.Caption   = "Material Recuperado"
				.Top       = 4
				.Left      = 146
				.Width     = 120
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container2.AddObject("lbl_4c_TotCCob", "Label")
			WITH loc_oPagina.cnt_4c_Container2.lbl_4c_TotCCob
				.Caption   = "Total C/ Cobran" + CHR(231) + "a :"
				.Top       = 28
				.Left      = 14
				.Width     = 96
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container2.AddObject("txt_4c_Totccb", "TextBox")
			WITH loc_oPagina.cnt_4c_Container2.txt_4c_Totccb
				.Value     = .F.
				.MaxLength = 15
				.Top       = 24
				.Left      = 129
				.Width     = 80
				.Height    = 23
				.FontName  = "Tahoma"
				.FontSize  = 8
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_Container2.txt_4c_Totccb, "LostFocus", THIS, "AtualizarBaixas")

			loc_oPagina.cnt_4c_Container2.AddObject("lbl_4c_TotSCob", "Label")
			WITH loc_oPagina.cnt_4c_Container2.lbl_4c_TotSCob
				.Caption   = "Total S/ Cobran" + CHR(231) + "a :"
				.Top       = 27
				.Left      = 217
				.Width     = 95
				.Height    = 15
				.AutoSize  = .F.
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Visible   = .T.
			ENDWITH

			loc_oPagina.cnt_4c_Container2.AddObject("txt_4c_totscb", "TextBox")
			WITH loc_oPagina.cnt_4c_Container2.txt_4c_totscb
				.Value     = .F.
				.MaxLength = 15
				.Top       = 23
				.Left      = 332
				.Width     = 80
				.Height    = 23
				.FontName  = "Tahoma"
				.FontSize  = 8
				.ReadOnly  = .T.
				.Visible   = .T.
			ENDWITH
			BINDEVENT(loc_oPagina.cnt_4c_Container2.txt_4c_totscb, "LostFocus", THIS, "AtualizarBaixas")

			THIS.TornarControlesVisiveis(loc_oPagina)
		CATCH TO loc_oErro
			MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* CarregarLista - Carrega/recarrega dados no Grid da Page1
	* Usa cursor temporario para preservar estrutura de colunas do grid
	*====================================================================
	PROCEDURE CarregarLista()
		LOCAL loc_lResultado, loc_oGrid, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
				loc_lResultado = .T.
			ELSE
				IF VARTYPE(THIS.this_oBusinessObject) != "O"
					loc_lResultado = .F.
				ELSE
					loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

					loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
						" a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
						" a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
						" a.emps, a.tipos, a.numbals" + ;
						" FROM SigCdFea a" + ;
						" WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
						" AND a.tipos = " + EscaparSQL(THIS.this_cTipo) + ;
						" ORDER BY a.numes"

					IF USED("cursor_4c_DadosTemp")
						USE IN cursor_4c_DadosTemp
					ENDIF

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

					IF loc_nResultado > 0
						SELECT cursor_4c_Dados
						SELECT cursor_4c_Dados
						ZAP
						APPEND FROM DBF("cursor_4c_DadosTemp")
						GO TOP IN cursor_4c_Dados
						USE IN cursor_4c_DadosTemp
						loc_oGrid.Refresh()
						THIS.FormatarGridLista(loc_oGrid)
						loc_lResultado = .T.
					ELSE
						MsgErro("Erro ao carregar lista: " + CapturarErroSQL(), "Erro SQL")
						IF USED("cursor_4c_DadosTemp")
							USE IN cursor_4c_DadosTemp
						ENDIF
						loc_lResultado = .F.
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CarregarLista: " + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
	*====================================================================
	PROCEDURE AlternarPagina(par_nPagina)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
				loc_lResultado = .F.
			ELSE
				THIS.pgf_4c_Paginas.ActivePage = par_nPagina

				IF par_nPagina = 1
					THIS.this_cModoAtual = "LISTA"
					THIS.CarregarLista()
				ENDIF

				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AlternarPagina: " + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BtnIncluirClick - Incluir novo registro
	*====================================================================
	PROCEDURE BtnIncluirClick()
		LOCAL loc_oPagina
		loc_oPagina = .NULL.

		TRY
			THIS.this_oBusinessObject.NovoRegistro()
			THIS.LimparCampos()
			THIS.this_cModoAtual = "INCLUIR"
			THIS.HabilitarCampos(.T.)
			THIS.AjustarBotoesPorModo()

			*-- Setar data para hoje (comportamento do legado em INSERIR)
			loc_oPagina = THIS.pgf_4c_Paginas.Page2
			IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
				loc_oPagina.txt_4c_Datas.Value = DATE()
			ENDIF

			*-- Ajustar containers por tipo (Tipo='F': Container3 ativo, Container1+2 desativados)
			THIS.AjustarContainersPorTipo()

			THIS.pgf_4c_Paginas.ActivePage = 2

			IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
				loc_oPagina.txt_4c_CdGrupo.SetFocus
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao iniciar inclus" + CHR(227) + "o: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
	*====================================================================
	PROCEDURE BtnVisualizarClick()
		LOCAL loc_cChave
		loc_cChave = ""

		TRY
			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
				MsgAviso("Selecione um registro para visualizar.", "Aviso")
			ELSE
				SELECT cursor_4c_Dados
				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

				IF !EMPTY(loc_cChave) AND THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
					THIS.this_cModoAtual = "VISUALIZAR"
					THIS.BOParaForm()
					THIS.HabilitarCampos(.F.)
					THIS.AjustarBotoesPorModo()
					THIS.AjustarPrdzReadOnly()
					THIS.pgf_4c_Paginas.ActivePage = 2
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao visualizar registro: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BtnAlterarClick - Alterar registro selecionado
	*====================================================================
	PROCEDURE BtnAlterarClick()
		LOCAL loc_cChave
		loc_cChave = ""

		TRY
			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
				MsgAviso("Selecione um registro para alterar.", "Aviso")
			ELSE
				SELECT cursor_4c_Dados
				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

				IF !EMPTY(loc_cChave) AND THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
					THIS.this_oBusinessObject.EditarRegistro()
					THIS.this_cModoAtual = "ALTERAR"
					THIS.BOParaForm()
					THIS.HabilitarCampos(.T.)
					THIS.AjustarBotoesPorModo()
					THIS.AjustarPrdzReadOnly()
					THIS.pgf_4c_Paginas.ActivePage = 2
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao iniciar altera" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BtnExcluirClick - Excluir registro selecionado
	*====================================================================
	PROCEDURE BtnExcluirClick()
		LOCAL loc_cChave, loc_lConfirmado
		loc_cChave      = ""
		loc_lConfirmado = .F.

		TRY
			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
				MsgAviso("Selecione um registro para excluir.", "Aviso")
			ELSE
				SELECT cursor_4c_Dados
				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

				IF !EMPTY(loc_cChave)
					loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
						"Excluir Registro")

					IF loc_lConfirmado
						IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
							IF THIS.this_oBusinessObject.Excluir()
								MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
								THIS.CarregarLista()
							ENDIF
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir registro: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BtnBuscarClick - Modo BUSCAR: vai para Page2 com campo codigo ativo
	* Equivalente ao Procurar do legado
	*====================================================================
	PROCEDURE BtnBuscarClick()
		LOCAL loc_oPagina
		loc_oPagina = .NULL.

		TRY
			THIS.LimparCampos()
			THIS.this_cModoAtual = "BUSCAR"
			THIS.HabilitarCampos(.F.)
			THIS.AjustarBotoesPorModo()

			*-- Habilitar somente o campo de codigo para busca
			loc_oPagina = THIS.pgf_4c_Paginas.Page2
			IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
				loc_oPagina.txt_4c_Codigos.Value  = ""
				loc_oPagina.txt_4c_Codigos.ReadOnly = .F.
			ENDIF

			THIS.pgf_4c_Paginas.ActivePage = 2

			IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
				loc_oPagina.txt_4c_Codigos.SetFocus
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao iniciar busca: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BtnEncerrarClick - Fechar o formulario
	*====================================================================
	PROCEDURE BtnEncerrarClick()
		THIS.Release()
	ENDPROC

	*====================================================================
	* LimparCampos - Limpa propriedades do BO (campos de Page2 na Fase 5)
	*====================================================================
	PROTECTED PROCEDURE LimparCampos()
		TRY
			THIS.this_oBusinessObject.this_cCidChaves  = ""
			THIS.this_oBusinessObject.this_nNumes      = 0
			THIS.this_oBusinessObject.this_cEmps       = ""
			THIS.this_oBusinessObject.this_cTipos      = THIS.this_cTipo
			THIS.this_oBusinessObject.this_dDatas      = {}
			THIS.this_oBusinessObject.this_cGrupos     = ""
			THIS.this_oBusinessObject.this_cDsGrupos   = ""
			THIS.this_oBusinessObject.this_cContas     = ""
			THIS.this_oBusinessObject.this_cDsContas   = ""
			THIS.this_oBusinessObject.this_cIfors      = ""
			THIS.this_oBusinessObject.this_cDsIfors    = ""
			THIS.this_oBusinessObject.this_cTpmats     = ""
			THIS.this_oBusinessObject.this_nBrutos     = 0
			THIS.this_oBusinessObject.this_nTrabs      = 0
			THIS.this_oBusinessObject.this_nFalhas     = 0
			THIS.this_oBusinessObject.this_nProduzidos = 0
			THIS.this_oBusinessObject.this_nPesoccbs   = 0
			THIS.this_oBusinessObject.this_nPesoscbs   = 0
			THIS.this_oBusinessObject.this_lBaixas     = .F.
			THIS.this_oBusinessObject.this_nNumbals    = 0
		CATCH TO loc_oErro
			MsgErro("Erro em LimparCampos: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* HabilitarCampos - Habilita/desabilita controles editaveis de Page2
	*====================================================================
	PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
		LOCAL loc_oPagina, loc_cGrupoAtualH
		loc_oPagina      = .NULL.
		loc_cGrupoAtualH = ""

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			*-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
			IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
					loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
				ENDIF
			ENDIF

			*-- Campo Codigo: editavel somente no modo BUSCAR
			IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
				loc_oPagina.txt_4c_Codigos.ReadOnly = (THIS.this_cModoAtual != "BUSCAR")
			ENDIF

			*-- Data: editavel em INCLUIR/ALTERAR
			IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
				loc_oPagina.txt_4c_Datas.ReadOnly = !par_lHabilitar
			ENDIF

			*-- Grupo: editavel em INCLUIR/ALTERAR
			IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
				loc_oPagina.txt_4c_CdGrupo.ReadOnly = !par_lHabilitar
			ENDIF
			IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
				loc_oPagina.txt_4c_DsGrupo.ReadOnly = .T.
			ENDIF

			*-- Conta: editavel em INCLUIR/ALTERAR somente quando Grupo esta preenchido
			IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
				loc_cGrupoAtualH = ""
				IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
					loc_cGrupoAtualH = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
				ENDIF
				loc_oPagina.txt_4c_CdConta.ReadOnly = !par_lHabilitar OR EMPTY(loc_cGrupoAtualH)
			ENDIF
			IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
				loc_oPagina.txt_4c_DsConta.ReadOnly = .T.
			ENDIF

			*-- Container4: Produzido (ReadOnly refinado por AjustarPrdzReadOnly)
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container4", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container4, "txt_4c_Prdz", 5)
					loc_oPagina.cnt_4c_Container4.txt_4c_Prdz.ReadOnly = !par_lHabilitar
				ENDIF
			ENDIF

			*-- Container3: Trabalhado e Falha
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container3", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container3, "txt_4c_PTrab", 5)
					loc_oPagina.cnt_4c_Container3.txt_4c_PTrab.ReadOnly = !par_lHabilitar
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container3, "txt_4c_Pfalha", 5)
					loc_oPagina.cnt_4c_Container3.txt_4c_Pfalha.ReadOnly = !par_lHabilitar
				ENDIF
			ENDIF

			*-- Container1: Peso Bruto, Recuperadora (ifor+dfor), Tipo Material
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_pesob", 5)
					loc_oPagina.cnt_4c_Container1.txt_4c_pesob.ReadOnly = !par_lHabilitar
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_ifor", 5)
					loc_oPagina.cnt_4c_Container1.txt_4c_ifor.ReadOnly = !par_lHabilitar
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_dfor", 5)
					loc_oPagina.cnt_4c_Container1.txt_4c_dfor.ReadOnly = .T.
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_tpmat", 5)
					loc_oPagina.cnt_4c_Container1.txt_4c_tpmat.ReadOnly = !par_lHabilitar
				ENDIF
			ENDIF

			*-- Container2: Totais com/sem cobranca
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container2", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container2, "txt_4c_Totccb", 5)
					loc_oPagina.cnt_4c_Container2.txt_4c_Totccb.ReadOnly = !par_lHabilitar
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container2, "txt_4c_totscb", 5)
					loc_oPagina.cnt_4c_Container2.txt_4c_totscb.ReadOnly = !par_lHabilitar
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 por modo
	*====================================================================
	PROCEDURE AjustarBotoesPorModo()
		LOCAL loc_lEdicao, loc_oCnt
		loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
		loc_oCnt    = .NULL.

		TRY
			loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

			IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
				loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEdicao
			ENDIF

			IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
				loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BOParaForm - Transfere BO -> controles de Page2
	*====================================================================
	PROTECTED PROCEDURE BOParaForm()
		LOCAL loc_oPagina
		loc_oPagina = .NULL.

		TRY
			IF VARTYPE(THIS.this_oBusinessObject) != "O"
				MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
			ELSE
				loc_oPagina = THIS.pgf_4c_Paginas.Page2

				*-- Numero (somente leitura - gerado automaticamente)
				IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
					loc_oPagina.txt_4c_Codigos.Value = ;
						IIF(THIS.this_oBusinessObject.this_nNumes = 0, "", ;
							ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nNumes)))
				ENDIF

				*-- Data
				IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
					loc_oPagina.txt_4c_Datas.Value = THIS.this_oBusinessObject.this_dDatas
				ENDIF

				*-- Grupo e descricao
				IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
					loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
				ENDIF
				IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
					loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDsGrupos)
				ENDIF

				*-- Conta e descricao
				IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
					loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
				ENDIF
				IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
					loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDsContas)
				ENDIF

				*-- Container4: Produzido
				IF PEMSTATUS(loc_oPagina, "cnt_4c_Container4", 5)
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container4, "txt_4c_Prdz", 5)
						loc_oPagina.cnt_4c_Container4.txt_4c_Prdz.Value = ;
							THIS.this_oBusinessObject.this_nProduzidos
					ENDIF
				ENDIF

				*-- Container3: Trabalhado e Falha
				IF PEMSTATUS(loc_oPagina, "cnt_4c_Container3", 5)
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container3, "txt_4c_PTrab", 5)
						loc_oPagina.cnt_4c_Container3.txt_4c_PTrab.Value = ;
							THIS.this_oBusinessObject.this_nTrabs
					ENDIF
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container3, "txt_4c_Pfalha", 5)
						loc_oPagina.cnt_4c_Container3.txt_4c_Pfalha.Value = ;
							THIS.this_oBusinessObject.this_nFalhas
					ENDIF
				ENDIF

				*-- Container1: Peso Bruto, Recuperadora, Tipo Material
				IF PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_pesob", 5)
						loc_oPagina.cnt_4c_Container1.txt_4c_pesob.Value = ;
							THIS.this_oBusinessObject.this_nBrutos
					ENDIF
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_ifor", 5)
						loc_oPagina.cnt_4c_Container1.txt_4c_ifor.Value = ;
							ALLTRIM(THIS.this_oBusinessObject.this_cIfors)
					ENDIF
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_dfor", 5)
						loc_oPagina.cnt_4c_Container1.txt_4c_dfor.Value = ;
							ALLTRIM(THIS.this_oBusinessObject.this_cDsIfors)
					ENDIF
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_tpmat", 5)
						loc_oPagina.cnt_4c_Container1.txt_4c_tpmat.Value = ;
							ALLTRIM(THIS.this_oBusinessObject.this_cTpmats)
					ENDIF
				ENDIF

				*-- Container2: Totais com/sem cobranca
				IF PEMSTATUS(loc_oPagina, "cnt_4c_Container2", 5)
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container2, "txt_4c_Totccb", 5)
						loc_oPagina.cnt_4c_Container2.txt_4c_Totccb.Value = ;
							THIS.this_oBusinessObject.this_nPesoccbs
					ENDIF
					IF PEMSTATUS(loc_oPagina.cnt_4c_Container2, "txt_4c_totscb", 5)
						loc_oPagina.cnt_4c_Container2.txt_4c_totscb.Value = ;
							THIS.this_oBusinessObject.this_nPesoscbs
					ENDIF
				ENDIF

				THIS.AjustarContainersPorTipo()
				THIS.AjustarPrdzReadOnly()
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* FormParaBO - Transfere controles de Page2 -> BO
	*====================================================================
	PROTECTED PROCEDURE FormParaBO()
		LOCAL loc_oPagina
		loc_oPagina = .NULL.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			*-- Empresa e tipo (sempre da sessao atual)
			THIS.this_oBusinessObject.this_cEmps  = go_4c_Sistema.cCodEmpresa
			THIS.this_oBusinessObject.this_cTipos = THIS.this_cTipo

			*-- Data
			IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
				THIS.this_oBusinessObject.this_dDatas = loc_oPagina.txt_4c_Datas.Value
			ENDIF

			*-- Grupo e descricao
			IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
				THIS.this_oBusinessObject.this_cGrupos   = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
				THIS.this_oBusinessObject.this_cDsGrupos = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)
			ENDIF

			*-- Conta e descricao
			IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
				THIS.this_oBusinessObject.this_cContas   = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
				THIS.this_oBusinessObject.this_cDsContas = ALLTRIM(loc_oPagina.txt_4c_DsConta.Value)
			ENDIF

			*-- Container4: Produzido
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container4", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container4, "txt_4c_Prdz", 5)
					THIS.this_oBusinessObject.this_nProduzidos = ;
						loc_oPagina.cnt_4c_Container4.txt_4c_Prdz.Value
				ENDIF
			ENDIF

			*-- Container3: Trabalhado e Falha
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container3", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container3, "txt_4c_PTrab", 5)
					THIS.this_oBusinessObject.this_nTrabs = ;
						loc_oPagina.cnt_4c_Container3.txt_4c_PTrab.Value
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container3, "txt_4c_Pfalha", 5)
					THIS.this_oBusinessObject.this_nFalhas = ;
						loc_oPagina.cnt_4c_Container3.txt_4c_Pfalha.Value
				ENDIF
			ENDIF

			*-- Container1: Peso Bruto, Recuperadora, Tipo Material
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_pesob", 5)
					THIS.this_oBusinessObject.this_nBrutos = ;
						loc_oPagina.cnt_4c_Container1.txt_4c_pesob.Value
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_ifor", 5)
					THIS.this_oBusinessObject.this_cIfors = ;
						ALLTRIM(loc_oPagina.cnt_4c_Container1.txt_4c_ifor.Value)
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_dfor", 5)
					THIS.this_oBusinessObject.this_cDsIfors = ;
						ALLTRIM(loc_oPagina.cnt_4c_Container1.txt_4c_dfor.Value)
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_tpmat", 5)
					THIS.this_oBusinessObject.this_cTpmats = ;
						ALLTRIM(loc_oPagina.cnt_4c_Container1.txt_4c_tpmat.Value)
				ENDIF
			ENDIF

			*-- Container2: Totais com/sem cobranca + derivar lBaixas
			LOCAL loc_nTotccb, loc_nTotscb
			loc_nTotccb = 0
			loc_nTotscb = 0
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container2", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container2, "txt_4c_Totccb", 5)
					loc_nTotccb = loc_oPagina.cnt_4c_Container2.txt_4c_Totccb.Value
					THIS.this_oBusinessObject.this_nPesoccbs = loc_nTotccb
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container2, "txt_4c_totscb", 5)
					loc_nTotscb = loc_oPagina.cnt_4c_Container2.txt_4c_totscb.Value
					THIS.this_oBusinessObject.this_nPesoscbs = loc_nTotscb
				ENDIF
			ENDIF
			THIS.this_oBusinessObject.this_lBaixas = (loc_nTotccb <> 0 OR loc_nTotscb <> 0)
		CATCH TO loc_oErro
			MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* TornarControlesVisiveis - Torna todos os controles visiveis
	*====================================================================
	PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
		LOCAL loc_nI, loc_oObjeto

		FOR loc_nI = 1 TO par_oContainer.ControlCount
			loc_oObjeto = par_oContainer.Controls(loc_nI)

			IF VARTYPE(loc_oObjeto) = "O"
				IF PEMSTATUS(loc_oObjeto, "Visible", 5)
					loc_oObjeto.Visible = .T.
				ENDIF

				IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
					LOCAL loc_nP
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
	* FormatarGridLista - Formata visual do grid da lista
	*====================================================================
	PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
		TRY
			WITH par_oGrid
				.FontName = "Tahoma"
				.FontSize = 8
				*-- Registros com baixas=1 aparecem em vermelho (equivalente ao legado)
				.SetAll("DynamicForeColor", ;
					"IIF(cursor_4c_Dados.baixas=1,RGB(255,0,0),RGB(0,0,0))", "Column")
			ENDWITH
		CATCH TO loc_oErro
			MsgErro("Erro em FormatarGridLista: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BtnSalvarClick - Salvar (Confirmar) ou executar busca por codigo
	*====================================================================
	PROCEDURE BtnSalvarClick()
		LOCAL loc_lSalvou, loc_oPagina, loc_cGrupo, loc_cConta, loc_cProduzido
		loc_lSalvou = .F.
		loc_oPagina = THIS.pgf_4c_Paginas.Page2

		*-- Modo BUSCAR: localizar registro por numero e voltar para lista
		IF THIS.this_cModoAtual = "BUSCAR"
			LOCAL loc_cCodBusca, loc_nBusca
			loc_cCodBusca = ""
			loc_nBusca    = 0

			IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
				loc_cCodBusca = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
			ENDIF

			IF !EMPTY(loc_cCodBusca)
				loc_nBusca = VAL(loc_cCodBusca)
				IF USED("cursor_4c_Dados") AND loc_nBusca > 0
					SELECT cursor_4c_Dados
					LOCATE FOR cursor_4c_Dados.numes = loc_nBusca
					IF !FOUND()
						MsgAviso("N" + CHR(250) + "mero " + loc_cCodBusca + " n" + ;
							CHR(227) + "o encontrado.", "Busca")
					ENDIF
				ENDIF
			ENDIF

			THIS.AlternarPagina(1)
			RETURN
		ENDIF

		*-- INCLUIR/ALTERAR: validacoes antes do TRY (critico: validacoes fora do TRY)
		IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
			THIS.AlternarPagina(1)
			RETURN
		ENDIF

		*-- Validar Data (obrigatoria)
		IF EMPTY(loc_oPagina.txt_4c_Datas.Value)
			MsgAviso("Data inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
			loc_oPagina.txt_4c_Datas.SetFocus
			RETURN
		ENDIF

		*-- Coletar valores para validacoes cruzadas
		loc_cGrupo = ""
		loc_cConta = ""
		loc_cProduzido = ""
		IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
			loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
		ENDIF
		IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
			loc_cConta = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
		ENDIF
		IF PEMSTATUS(loc_oPagina, "cnt_4c_Container4", 5)
			IF PEMSTATUS(loc_oPagina.cnt_4c_Container4, "txt_4c_Prdz", 5)
				loc_cProduzido = ALLTRIM(TRANSFORM(loc_oPagina.cnt_4c_Container4.txt_4c_Prdz.Value))
			ENDIF
		ENDIF

		*-- Validar Grupo (obrigatorio se Tipo='F' e Produzido vazio)
		IF EMPTY(loc_cGrupo) AND THIS.this_cTipo = "F" AND EMPTY(loc_cProduzido)
			MsgAviso("Grupo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
			IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
				loc_oPagina.txt_4c_CdGrupo.SetFocus
			ENDIF
			RETURN
		ENDIF

		*-- Validar Conta (obrigatoria se Tipo='F' e Produzido vazio)
		IF EMPTY(loc_cConta) AND THIS.this_cTipo = "F" AND EMPTY(loc_cProduzido)
			MsgAviso("Conta inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
			IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
				loc_oPagina.txt_4c_CdConta.SetFocus
			ENDIF
			RETURN
		ENDIF

		TRY
			THIS.FormParaBO()

			IF THIS.this_oBusinessObject.Salvar()
				MsgInfo("Registro salvo com sucesso!", "Sucesso")
				loc_lSalvou = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao salvar: " + loc_oErro.Message, "Erro")
			loc_lSalvou = .F.
		ENDTRY

		IF loc_lSalvou
			THIS.AlternarPagina(1)
		ENDIF
	ENDPROC

	*====================================================================
	* BtnCancelarClick - Cancelar e voltar para lista
	*====================================================================
	PROCEDURE BtnCancelarClick()
		TRY
			THIS.AlternarPagina(1)
			THIS.this_cModoAtual = "LISTA"
		CATCH TO loc_oErro
			MsgErro("Erro ao cancelar: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* ValidarGrupo - LostFocus de txt_4c_CdGrupo: lookup em SigCdGcr
	* (BalFalPers=1 conforme comportamento original do legado)
	*====================================================================
	PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cGrupo, loc_nResult, loc_oPagina, loc_oBusca
		loc_cGrupo  = ""
		loc_nResult = 0
		loc_oBusca  = .NULL.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			IF !PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
			ELSE
				loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)

				IF EMPTY(loc_cGrupo)
					*-- Grupo vazio: zerar descricao, conta e descricao de conta
					IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
						loc_oPagina.txt_4c_DsGrupo.Value = ""
					ENDIF
					IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
						loc_oPagina.txt_4c_CdConta.Value = ""
					ENDIF
					IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
						loc_oPagina.txt_4c_DsConta.Value = ""
					ENDIF
				ELSE
					*-- Buscar correspondencia exata em SigCdGcr (BalFalPers=1)
					IF USED("cursor_4c_BuscaGrupo")
						USE IN cursor_4c_BuscaGrupo
					ENDIF
					loc_nResult = SQLEXEC(gnConnHandle, ;
						"SELECT Codigos, Descrs FROM SigCdGcr" + ;
						" WHERE BalFalPers = 1 ORDER BY Codigos", ;
						"cursor_4c_BuscaGrupo")

					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
						SELECT cursor_4c_BuscaGrupo
						LOCATE FOR ALLTRIM(Codigos) = ALLTRIM(loc_cGrupo)
						IF FOUND()
							*-- Encontrou exato
							IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
								loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
							ENDIF
							*-- Limpar conta pois grupo pode ter mudado
							IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
								loc_oPagina.txt_4c_CdConta.Value = ""
							ENDIF
							IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
								loc_oPagina.txt_4c_DsConta.Value = ""
							ENDIF
						ELSE
							*-- Nao encontrou: abrir picker
							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
							IF VARTYPE(loc_oBusca) = "O"
								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrupo"
								loc_oBusca.this_cTitulo = "Grupos"
								loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
								loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
								loc_oBusca.Show()

								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
									SELECT cursor_4c_BuscaGrupo
									IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
										loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
									ENDIF
									IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
										loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
									ENDIF
									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
										loc_oPagina.txt_4c_CdConta.Value = ""
									ENDIF
									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
										loc_oPagina.txt_4c_DsConta.Value = ""
									ENDIF
								ELSE
									IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
										loc_oPagina.txt_4c_CdGrupo.Value = ""
									ENDIF
									IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
										loc_oPagina.txt_4c_DsGrupo.Value = ""
									ENDIF
									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
										loc_oPagina.txt_4c_CdConta.Value = ""
									ENDIF
									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
										loc_oPagina.txt_4c_DsConta.Value = ""
									ENDIF
								ENDIF
								loc_oBusca.Release()
							ENDIF
						ENDIF
					ELSE
						MsgAviso("Nenhum grupo encontrado!", "Aviso")
						IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
							loc_oPagina.txt_4c_CdGrupo.Value = ""
						ENDIF
						IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
							loc_oPagina.txt_4c_DsGrupo.Value = ""
						ENDIF
					ENDIF

					IF USED("cursor_4c_BuscaGrupo")
						USE IN cursor_4c_BuscaGrupo
					ENDIF
				ENDIF
			ENDIF
			THIS.AjustarPrdzReadOnly()
		CATCH TO loc_oErro
			MsgErro("Erro em ValidarGrupo: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* ValidarConta - LostFocus de txt_4c_CdConta
	* Lookup em SigCdCli filtrado por Grupo (com BalFalPers=1 via SigCdGcr)
	*====================================================================
	PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cConta, loc_cGrupo, loc_nResult, loc_oPagina, loc_oBusca
		loc_cConta  = ""
		loc_cGrupo  = ""
		loc_nResult = 0
		loc_oBusca  = .NULL.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			IF !PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
			ELSE
				loc_cConta = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
				IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
					loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
				ENDIF

				IF EMPTY(loc_cGrupo)
					*-- Sem grupo, nao permite selecionar conta
					IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
						loc_oPagina.txt_4c_CdConta.Value = ""
					ENDIF
					IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
						loc_oPagina.txt_4c_DsConta.Value = ""
					ENDIF
				ELSE
				    IF EMPTY(loc_cConta)
					IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
						loc_oPagina.txt_4c_DsConta.Value = ""
					ENDIF
				ELSE
					*-- Buscar correspondencia exata: SigCdCli filtrado por grupo
					IF USED("cursor_4c_BuscaConta")
						USE IN cursor_4c_BuscaConta
					ENDIF
					loc_nResult = SQLEXEC(gnConnHandle, ;
						"SELECT a.Iclis, a.Rclis FROM SigCdCli a" + ;
						" INNER JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
						" WHERE b.BalFalPers = 1 AND a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
						" ORDER BY a.Rclis", ;
						"cursor_4c_BuscaConta")

					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
						SELECT cursor_4c_BuscaConta
						LOCATE FOR ALLTRIM(Iclis) = ALLTRIM(loc_cConta)
						IF FOUND()
							*-- Encontrou exato
							IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
								loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
							ENDIF
						ELSE
							*-- Nao encontrou: abrir picker com contas do grupo
							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
							IF VARTYPE(loc_oBusca) = "O"
								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
								loc_oBusca.this_cTitulo = "Contas"
								loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
								loc_oBusca.mAddColuna("Rclis", "", "Nome")
								loc_oBusca.Show()

								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
									SELECT cursor_4c_BuscaConta
									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
										loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
									ENDIF
									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
										loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
									ENDIF
								ELSE
									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
										loc_oPagina.txt_4c_CdConta.Value = ""
									ENDIF
									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
										loc_oPagina.txt_4c_DsConta.Value = ""
									ENDIF
								ENDIF
								loc_oBusca.Release()
							ENDIF
						ENDIF
					ELSE
						MsgAviso("Nenhuma conta encontrada para o grupo!", "Aviso")
						IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
							loc_oPagina.txt_4c_CdConta.Value = ""
						ENDIF
						IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
							loc_oPagina.txt_4c_DsConta.Value = ""
						ENDIF
					ENDIF

					IF USED("cursor_4c_BuscaConta")
						USE IN cursor_4c_BuscaConta
					ENDIF
				    ENDIF
				ENDIF
			ENDIF
			THIS.AjustarPrdzReadOnly()
		CATCH TO loc_oErro
			MsgErro("Erro em ValidarConta: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* ValidarIfor - LostFocus de txt_4c_ifor: lookup em SigCdCli por IClis
	* Preenche txt_4c_dfor com RClis (nome da recuperadora)
	*====================================================================
	PROCEDURE ValidarIfor(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cIfor, loc_nResult, loc_oPagina, loc_oBusca, loc_oCnt
		loc_cIfor   = ""
		loc_nResult = 0
		loc_oBusca  = .NULL.
		loc_oCnt    = .NULL.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
			ELSE
				loc_oCnt = loc_oPagina.cnt_4c_Container1

				IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
					loc_cIfor = ALLTRIM(loc_oCnt.txt_4c_ifor.Value)
				ENDIF

				IF EMPTY(loc_cIfor)
					*-- Limpar descricao
					IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
						loc_oCnt.txt_4c_dfor.Value = ""
					ENDIF
				ELSE
					IF USED("cursor_4c_BuscaIfor")
						USE IN cursor_4c_BuscaIfor
					ENDIF
					loc_nResult = SQLEXEC(gnConnHandle, ;
						"SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
						"cursor_4c_BuscaIfor")

					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaIfor") > 0
						SELECT cursor_4c_BuscaIfor
						LOCATE FOR ALLTRIM(IClis) = ALLTRIM(loc_cIfor)
						IF FOUND()
							IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
								loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
							ENDIF
						ELSE
							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
							IF VARTYPE(loc_oBusca) = "O"
								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaIfor"
								loc_oBusca.this_cTitulo = "Recuperadoras"
								loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
								loc_oBusca.mAddColuna("RClis", "", "Nome")
								loc_oBusca.Show()

								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
									SELECT cursor_4c_BuscaIfor
									IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
										loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.IClis)
									ENDIF
									IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
										loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
									ENDIF
								ELSE
									IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
										loc_oCnt.txt_4c_ifor.Value = ""
									ENDIF
									IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
										loc_oCnt.txt_4c_dfor.Value = ""
									ENDIF
								ENDIF
								loc_oBusca.Release()
							ENDIF
						ENDIF
					ELSE
						MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")
						IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
							loc_oCnt.txt_4c_ifor.Value = ""
						ENDIF
						IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
							loc_oCnt.txt_4c_dfor.Value = ""
						ENDIF
					ENDIF

					IF USED("cursor_4c_BuscaIfor")
						USE IN cursor_4c_BuscaIfor
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ValidarIfor: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* ValidarDfor - LostFocus de txt_4c_dfor: lookup em SigCdCli por RClis
	* Ativo apenas quando txt_4c_ifor estiver vazio (busca por nome)
	* Preenche txt_4c_ifor com IClis e txt_4c_dfor com RClis
	*====================================================================
	PROCEDURE ValidarDfor(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cDfor, loc_cIfor, loc_nResult, loc_oPagina, loc_oBusca, loc_oCnt
		loc_cDfor   = ""
		loc_cIfor   = ""
		loc_nResult = 0
		loc_oBusca  = .NULL.
		loc_oCnt    = .NULL.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
			ELSE
				loc_oCnt = loc_oPagina.cnt_4c_Container1

				IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
					loc_cIfor = ALLTRIM(loc_oCnt.txt_4c_ifor.Value)
				ENDIF

				*-- Dfor so ativo quando ifor esta vazio
				IF !EMPTY(loc_cIfor)
				ELSE
					IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
						loc_cDfor = ALLTRIM(loc_oCnt.txt_4c_dfor.Value)
					ENDIF

					IF EMPTY(loc_cDfor)
					ELSE
						IF USED("cursor_4c_BuscaDfor")
							USE IN cursor_4c_BuscaDfor
						ENDIF
						loc_nResult = SQLEXEC(gnConnHandle, ;
							"SELECT IClis, RClis FROM SigCdCli ORDER BY RClis", ;
							"cursor_4c_BuscaDfor")

						IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaDfor") > 0
							SELECT cursor_4c_BuscaDfor
							LOCATE FOR ALLTRIM(RClis) = ALLTRIM(loc_cDfor)
							IF FOUND()
								IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
									loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
								ENDIF
								IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
									loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
								ENDIF
							ELSE
								loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
								IF VARTYPE(loc_oBusca) = "O"
									loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDfor"
									loc_oBusca.this_cTitulo = "Recuperadoras"
									loc_oBusca.mAddColuna("RClis", "", "Nome")
									loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
									loc_oBusca.Show()

									IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDfor")
										SELECT cursor_4c_BuscaDfor
										IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
											loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
										ENDIF
										IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
											loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
										ENDIF
									ELSE
										IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
											loc_oCnt.txt_4c_dfor.Value = ""
										ENDIF
									ENDIF
									loc_oBusca.Release()
								ENDIF
							ENDIF
						ELSE
							MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")
							IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
								loc_oCnt.txt_4c_dfor.Value = ""
							ENDIF
						ENDIF

						IF USED("cursor_4c_BuscaDfor")
							USE IN cursor_4c_BuscaDfor
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ValidarDfor: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* ValidarTpmat - LostFocus de txt_4c_tpmat: lookup em SigOpOpt (Situas=3)
	*====================================================================
	PROCEDURE ValidarTpmat(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cTpmat, loc_nResult, loc_oPagina, loc_oBusca, loc_oCnt
		loc_cTpmat  = ""
		loc_nResult = 0
		loc_oBusca  = .NULL.
		loc_oCnt    = .NULL.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
			ELSE
				loc_oCnt = loc_oPagina.cnt_4c_Container1

				IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
					loc_cTpmat = ALLTRIM(loc_oCnt.txt_4c_tpmat.Value)
				ENDIF

				IF EMPTY(loc_cTpmat)
				ELSE
					IF USED("cursor_4c_BuscaTpmat")
						USE IN cursor_4c_BuscaTpmat
					ENDIF
					loc_nResult = SQLEXEC(gnConnHandle, ;
						"SELECT Cods, Descs FROM SigOpOpt ORDER BY Cods", ;
						"cursor_4c_BuscaTpmat")

					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaTpmat") > 0
						SELECT cursor_4c_BuscaTpmat
						LOCATE FOR ALLTRIM(Cods) = ALLTRIM(loc_cTpmat)
						IF !FOUND()
							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
							IF VARTYPE(loc_oBusca) = "O"
								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpmat"
								loc_oBusca.this_cTitulo = "Tipo de Material"
								loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
								loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
								loc_oBusca.Show()

								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpmat")
									SELECT cursor_4c_BuscaTpmat
									IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
										loc_oCnt.txt_4c_tpmat.Value = ALLTRIM(cursor_4c_BuscaTpmat.Cods)
									ENDIF
								ELSE
									IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
										loc_oCnt.txt_4c_tpmat.Value = ""
									ENDIF
								ENDIF
								loc_oBusca.Release()
							ENDIF
						ENDIF
					ELSE
						MsgAviso("Nenhum tipo de material encontrado!", "Aviso")
						IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
							loc_oCnt.txt_4c_tpmat.Value = ""
						ENDIF
					ENDIF

					IF USED("cursor_4c_BuscaTpmat")
						USE IN cursor_4c_BuscaTpmat
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ValidarTpmat: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* AtualizarBaixas - LostFocus de txt_4c_Totccb / txt_4c_totscb
	* this_lBaixas = .T. se qualquer total preenchido (comportamento legado)
	* Container1 fica read-only quando AMBOS os totais estiverem preenchidos
	*====================================================================
	PROCEDURE AtualizarBaixas()
		LOCAL loc_oPagina, loc_nTotccb, loc_nTotscb, loc_lAmbosPreench
		loc_nTotccb      = 0
		loc_nTotscb      = 0
		loc_lAmbosPreench = .F.

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container2", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container2, "txt_4c_Totccb", 5)
					loc_nTotccb = loc_oPagina.cnt_4c_Container2.txt_4c_Totccb.Value
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container2, "txt_4c_totscb", 5)
					loc_nTotscb = loc_oPagina.cnt_4c_Container2.txt_4c_totscb.Value
				ENDIF
			ENDIF

			*-- Atualizar flag no BO
			IF VARTYPE(THIS.this_oBusinessObject) = "O"
				THIS.this_oBusinessObject.this_lBaixas = (loc_nTotccb <> 0 OR loc_nTotscb <> 0)
			ENDIF

			*-- Container1 so editavel se ao menos um total estiver zerado (legado: When=Empty(totccb) OR Empty(totscb))
			loc_lAmbosPreench = (loc_nTotccb <> 0 AND loc_nTotscb <> 0)
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_pesob", 5)
					loc_oPagina.cnt_4c_Container1.txt_4c_pesob.ReadOnly = loc_lAmbosPreench
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_ifor", 5)
					loc_oPagina.cnt_4c_Container1.txt_4c_ifor.ReadOnly = loc_lAmbosPreench
				ENDIF
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container1, "txt_4c_tpmat", 5)
					loc_oPagina.cnt_4c_Container1.txt_4c_tpmat.ReadOnly = loc_lAmbosPreench
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AtualizarBaixas: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* AjustarPrdzReadOnly - Prdz so editavel quando CdGrupo e CdConta vazios
	* (equivalente ao When=Empty(getCdGrupo) AND Empty(getCdConta) do legado)
	*====================================================================
	PROTECTED PROCEDURE AjustarPrdzReadOnly()
		LOCAL loc_oPagina, loc_lReadOnly, loc_cGrupo, loc_cConta
		loc_lReadOnly = .T.
		loc_cGrupo    = ""
		loc_cConta    = ""

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
				loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
			ENDIF
			IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
				loc_cConta = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
			ENDIF

			*-- Editavel apenas quando AMBOS grupo e conta estiverem vazios
			loc_lReadOnly = !(EMPTY(loc_cGrupo) AND EMPTY(loc_cConta))

			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container4", 5)
				IF PEMSTATUS(loc_oPagina.cnt_4c_Container4, "txt_4c_Prdz", 5)
					loc_oPagina.cnt_4c_Container4.txt_4c_Prdz.ReadOnly = loc_lReadOnly
					*-- Se passou a ser read-only, limpar valor (grupo/conta preenchem o fluxo)
					IF loc_lReadOnly
						loc_oPagina.cnt_4c_Container4.txt_4c_Prdz.Value = .F.
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AjustarPrdzReadOnly: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* AjustarContainersPorTipo - Habilita/desabilita containers conforme tipo
	* Tipo='F' (fundicao): Container3 ativo, Container1+2 desativados
	* Outros tipos:        Container1+2 ativos, Container3 desativado
	*====================================================================
	PROTECTED PROCEDURE AjustarContainersPorTipo()
		LOCAL loc_oPagina, loc_lFundicao
		loc_oPagina  = .NULL.
		loc_lFundicao = (THIS.this_cTipo = "F")

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2

			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
				loc_oPagina.cnt_4c_Container1.Enabled = !loc_lFundicao
			ENDIF
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container2", 5)
				loc_oPagina.cnt_4c_Container2.Enabled = !loc_lFundicao
			ENDIF
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container3", 5)
				loc_oPagina.cnt_4c_Container3.Enabled = loc_lFundicao
			ENDIF
			IF PEMSTATUS(loc_oPagina, "cnt_4c_Container4", 5)
				loc_oPagina.cnt_4c_Container4.Enabled = loc_lFundicao
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AjustarContainersPorTipo: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* CdGrupoKeyPress - KeyPress em txt_4c_CdGrupo (F4 abre picker)
	*====================================================================
	PROCEDURE CdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode = 28
			THIS.AbrirLookupGrupo()
		ENDIF
	ENDPROC

	*====================================================================
	* CdGrupoDblClick - DblClick em txt_4c_CdGrupo (abre picker)
	*====================================================================
	PROCEDURE CdGrupoDblClick()
		THIS.AbrirLookupGrupo()
	ENDPROC

	*====================================================================
	* AbrirLookupGrupo - Abre picker de grupos (SigCdGcr, BalFalPers=1)
	*====================================================================
	PROCEDURE AbrirLookupGrupo()
		LOCAL loc_oPagina, loc_oBusca, loc_nResult
		loc_oPagina = .NULL.
		loc_oBusca  = .NULL.
		loc_nResult = 0

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2
			IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
			ELSE
			    IF !PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5) OR ;
				loc_oPagina.txt_4c_CdGrupo.ReadOnly
			ELSE
				IF USED("cursor_4c_BuscaGrupo")
					USE IN cursor_4c_BuscaGrupo
				ENDIF
				loc_nResult = SQLEXEC(gnConnHandle, ;
					"SELECT Codigos, Descrs FROM SigCdGcr" + ;
					" WHERE BalFalPers = 1 ORDER BY Codigos", ;
					"cursor_4c_BuscaGrupo")

				IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
					loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
					IF VARTYPE(loc_oBusca) = "O"
						loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrupo"
						loc_oBusca.this_cTitulo = "Grupos"
						loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
						loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
						loc_oBusca.Show()

						IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
							SELECT cursor_4c_BuscaGrupo
							IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
								loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
							ENDIF
							IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
								loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
							ENDIF
							IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
								loc_oPagina.txt_4c_CdConta.Value = ""
							ENDIF
							IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
								loc_oPagina.txt_4c_DsConta.Value = ""
							ENDIF
						ENDIF
						loc_oBusca.Release()
					ENDIF
				ELSE
					MsgAviso("Nenhum grupo encontrado!", "Aviso")
				ENDIF

				IF USED("cursor_4c_BuscaGrupo")
					USE IN cursor_4c_BuscaGrupo
				ENDIF
				THIS.AjustarPrdzReadOnly()
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AbrirLookupGrupo: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* CdContaKeyPress - KeyPress em txt_4c_CdConta (F4 abre picker)
	*====================================================================
	PROCEDURE CdContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode = 28
			THIS.AbrirLookupConta()
		ENDIF
	ENDPROC

	*====================================================================
	* CdContaDblClick - DblClick em txt_4c_CdConta (abre picker)
	*====================================================================
	PROCEDURE CdContaDblClick()
		THIS.AbrirLookupConta()
	ENDPROC

	*====================================================================
	* AbrirLookupConta - Abre picker de contas (SigCdCli filtrado por grupo)
	*====================================================================
	PROCEDURE AbrirLookupConta()
		LOCAL loc_oPagina, loc_oBusca, loc_nResult, loc_cGrupo
		loc_oPagina = .NULL.
		loc_oBusca  = .NULL.
		loc_nResult = 0
		loc_cGrupo  = ""

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2
			IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
			ELSE
			    IF !PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5) OR ;
				loc_oPagina.txt_4c_CdConta.ReadOnly
			ELSE
				IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
					loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
				ENDIF

				IF EMPTY(loc_cGrupo)
					MsgAviso("Selecione um grupo primeiro!", "Aviso")
				ELSE
					IF USED("cursor_4c_BuscaConta")
						USE IN cursor_4c_BuscaConta
					ENDIF
					loc_nResult = SQLEXEC(gnConnHandle, ;
						"SELECT a.Iclis, a.Rclis FROM SigCdCli a" + ;
						" INNER JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
						" WHERE b.BalFalPers = 1 AND a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
						" ORDER BY a.Rclis", ;
						"cursor_4c_BuscaConta")

					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
						IF VARTYPE(loc_oBusca) = "O"
							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
							loc_oBusca.this_cTitulo = "Contas"
							loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
							loc_oBusca.mAddColuna("Rclis", "", "Nome")
							loc_oBusca.Show()

							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
								SELECT cursor_4c_BuscaConta
								IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
									loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
								ENDIF
								IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
									loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
								ENDIF
							ENDIF
							loc_oBusca.Release()
						ENDIF
					ELSE
						MsgAviso("Nenhuma conta encontrada para o grupo!", "Aviso")
					ENDIF

					IF USED("cursor_4c_BuscaConta")
						USE IN cursor_4c_BuscaConta
					ENDIF
					THIS.AjustarPrdzReadOnly()
				ENDIF
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AbrirLookupConta: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* IforKeyPress - KeyPress em txt_4c_ifor (F4 abre picker)
	*====================================================================
	PROCEDURE IforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode = 28
			THIS.AbrirLookupIfor()
		ENDIF
	ENDPROC

	*====================================================================
	* IforDblClick - DblClick em txt_4c_ifor (abre picker)
	*====================================================================
	PROCEDURE IforDblClick()
		THIS.AbrirLookupIfor()
	ENDPROC

	*====================================================================
	* AbrirLookupIfor - Abre picker de recuperadoras (SigCdCli por IClis)
	*====================================================================
	PROCEDURE AbrirLookupIfor()
		LOCAL loc_oPagina, loc_oCnt, loc_oBusca, loc_nResult
		loc_oPagina = .NULL.
		loc_oCnt    = .NULL.
		loc_oBusca  = .NULL.
		loc_nResult = 0

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2
			IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
			ELSE
			    IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
			ELSE
				loc_oCnt = loc_oPagina.cnt_4c_Container1
				IF !PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5) OR loc_oCnt.txt_4c_ifor.ReadOnly
				ELSE
					IF USED("cursor_4c_BuscaIfor")
						USE IN cursor_4c_BuscaIfor
					ENDIF
					loc_nResult = SQLEXEC(gnConnHandle, ;
						"SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
						"cursor_4c_BuscaIfor")

					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaIfor") > 0
						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
						IF VARTYPE(loc_oBusca) = "O"
							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaIfor"
							loc_oBusca.this_cTitulo = "Recuperadoras"
							loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
							loc_oBusca.mAddColuna("RClis", "", "Nome")
							loc_oBusca.Show()

							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
								SELECT cursor_4c_BuscaIfor
								IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
									loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.IClis)
								ENDIF
								IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
									loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
								ENDIF
							ENDIF
							loc_oBusca.Release()
						ENDIF
					ELSE
						MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")
					ENDIF

					IF USED("cursor_4c_BuscaIfor")
						USE IN cursor_4c_BuscaIfor
					ENDIF
				ENDIF
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AbrirLookupIfor: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* TpmatKeyPress - KeyPress em txt_4c_tpmat (F4 abre picker)
	*====================================================================
	PROCEDURE TpmatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode = 28
			THIS.AbrirLookupTpmat()
		ENDIF
	ENDPROC

	*====================================================================
	* TpmatDblClick - DblClick em txt_4c_tpmat (abre picker)
	*====================================================================
	PROCEDURE TpmatDblClick()
		THIS.AbrirLookupTpmat()
	ENDPROC

	*====================================================================
	* AbrirLookupTpmat - Abre picker de tipos de material (SigOpOpt, Situas=3)
	*====================================================================
	PROCEDURE AbrirLookupTpmat()
		LOCAL loc_oPagina, loc_oCnt, loc_oBusca, loc_nResult
		loc_oPagina = .NULL.
		loc_oCnt    = .NULL.
		loc_oBusca  = .NULL.
		loc_nResult = 0

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2
			IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
			ELSE
			    IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
			ELSE
				loc_oCnt = loc_oPagina.cnt_4c_Container1
				IF !PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5) OR loc_oCnt.txt_4c_tpmat.ReadOnly
				ELSE
					IF USED("cursor_4c_BuscaTpmat")
						USE IN cursor_4c_BuscaTpmat
					ENDIF
					loc_nResult = SQLEXEC(gnConnHandle, ;
						"SELECT Cods, Descs FROM SigOpOpt ORDER BY Cods", ;
						"cursor_4c_BuscaTpmat")

					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaTpmat") > 0
						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
						IF VARTYPE(loc_oBusca) = "O"
							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpmat"
							loc_oBusca.this_cTitulo = "Tipo de Material"
							loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
							loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
							loc_oBusca.Show()

							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpmat")
								SELECT cursor_4c_BuscaTpmat
								IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
									loc_oCnt.txt_4c_tpmat.Value = ALLTRIM(cursor_4c_BuscaTpmat.Cods)
								ENDIF
							ENDIF
							loc_oBusca.Release()
						ENDIF
					ELSE
						MsgAviso("Nenhum tipo de material encontrado!", "Aviso")
					ENDIF

					IF USED("cursor_4c_BuscaTpmat")
						USE IN cursor_4c_BuscaTpmat
					ENDIF
				ENDIF
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AbrirLookupTpmat: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* DforKeyPress - KeyPress em txt_4c_dfor (F4 abre picker por nome)
	*====================================================================
	PROCEDURE DforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode = 28
			THIS.AbrirLookupDfor()
		ENDIF
	ENDPROC

	*====================================================================
	* DforDblClick - DblClick em txt_4c_dfor (abre picker por nome)
	*====================================================================
	PROCEDURE DforDblClick()
		THIS.AbrirLookupDfor()
	ENDPROC

	*====================================================================
	* AbrirLookupDfor - Abre picker de recuperadoras por nome (SigCdCli por RClis)
	* Ativo somente quando txt_4c_ifor estiver vazio
	*====================================================================
	PROCEDURE AbrirLookupDfor()
		LOCAL loc_oPagina, loc_oCnt, loc_oBusca, loc_nResult, loc_cIfor
		loc_oPagina = .NULL.
		loc_oCnt    = .NULL.
		loc_oBusca  = .NULL.
		loc_nResult = 0
		loc_cIfor   = ""

		TRY
			loc_oPagina = THIS.pgf_4c_Paginas.Page2
			IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
			ELSE
			    IF !PEMSTATUS(loc_oPagina, "cnt_4c_Container1", 5)
			ELSE
				loc_oCnt = loc_oPagina.cnt_4c_Container1
				IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
					loc_cIfor = ALLTRIM(loc_oCnt.txt_4c_ifor.Value)
				ENDIF

				IF !EMPTY(loc_cIfor)
					*-- dfor so ativo quando ifor estiver vazio
				ELSE
				    IF !PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5) OR loc_oCnt.txt_4c_dfor.ReadOnly
				ELSE
					IF USED("cursor_4c_BuscaDfor")
						USE IN cursor_4c_BuscaDfor
					ENDIF
					loc_nResult = SQLEXEC(gnConnHandle, ;
						"SELECT IClis, RClis FROM SigCdCli ORDER BY RClis", ;
						"cursor_4c_BuscaDfor")

					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaDfor") > 0
						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
						IF VARTYPE(loc_oBusca) = "O"
							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDfor"
							loc_oBusca.this_cTitulo = "Recuperadoras"
							loc_oBusca.mAddColuna("RClis", "", "Nome")
							loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
							loc_oBusca.Show()

							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDfor")
								SELECT cursor_4c_BuscaDfor
								IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
									loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
								ENDIF
								IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
									loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
								ENDIF
							ENDIF
							loc_oBusca.Release()
						ENDIF
					ELSE
						MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")
					ENDIF

					IF USED("cursor_4c_BuscaDfor")
						USE IN cursor_4c_BuscaDfor
					ENDIF
				    ENDIF
				ENDIF
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em AbrirLookupDfor: " + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* Destroy - Libera recursos
	*====================================================================
	PROCEDURE Destroy()
		TRY
			IF VARTYPE(THIS.this_oBusinessObject) = "O"
				THIS.this_oBusinessObject = .NULL.
			ENDIF

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			IF USED("cursor_4c_DadosTemp")
				USE IN cursor_4c_DadosTemp
			ENDIF
		CATCH TO loc_oErro
			*-- Silencioso no Destroy para nao bloquear encerramento
		ENDTRY

		DODEFAULT()
	ENDPROC

ENDDEFINE
