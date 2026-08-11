*==============================================================================
* FormSigPrEtq.prg - Impressao de Etiquetas Selecionadas
* Herda de: FormBase
* Tipo: OPERACIONAL
* Migrado de: SIGPRETQ.SCX
*==============================================================================

DEFINE CLASS FormSigPrEtq AS FormBase

	Height = 700
	Width = 1000
	Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
	TitleBar = 0
	ShowWindow = 1
	WindowType = 1
	ControlBox = .F.
	MaxButton = .F.
	MinButton = .F.
	Movable = .T.
	AutoCenter = .T.
	DataSession = 2
	BorderStyle = 2
	ShowTips = .T.

	this_oBusinessObject = .NULL.

	*====================================================================
	* Init - DODEFAULT chama FormBase.Init -> InicializarForm
	*====================================================================
	PROCEDURE Init()
		RETURN DODEFAULT()
	ENDPROC

	*====================================================================
	* InicializarForm - Cria BO, cursor local e componentes
	*====================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			THIS.this_oBusinessObject = CREATEOBJECT("SigPrEtqBO")
			IF VARTYPE(THIS.this_oBusinessObject) != "O"
				MsgErro("Erro ao criar SigPrEtqBO", "Erro")
				loc_lSucesso = .F.
			ENDIF

			SET NULL ON
			CREATE CURSOR cursor_4c_Etiquetas ;
				(Cpros C(14) NULL, DPros C(40) NULL, Reffs C(40) NULL, ;
				 Qtds N(10,3) NULL, QtdeEtiq N(10,3) NULL, ;
				 Pedido C(30) NULL, Obs C(10) NULL, PVens N(12,2) NULL, ;
				 PrecoDe N(12,2) NULL, Parcelas N(2,0) NULL, ;
				 Cpros2 C(14) NULL, Cpros3 C(14) NULL, Cpros4 C(14) NULL, ;
				 empos C(3) NULL, empdopnums C(29) NULL, ;
				 citens N(10,0) NULL, Pesos N(12,2) NULL, ;
				 CodTams C(4) NULL, DPro2s C(45) NULL)
			SET NULL OFF

			INDEX ON Cpros TAG Cpros
			INDEX ON RECNO() TAG Registros
			SET ORDER TO

			THIS.ConfigurarPageFrame()
			THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
			THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
			THIS.TornarControlesVisiveis(THIS)

			IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
				THIS.this_oBusinessObject.CarregarConfiguracoes()
				THIS.PopularTiposEtiqueta()
				THIS.AplicarConfiguracoes()
			ENDIF

			loc_lSucesso = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
			        " PROC=" + loc_oErro.Procedure, "Erro ao inicializar")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfigurarPageFrame - Orquestrador de layout do form OPERACIONAL
	* Form SIGPRETQ nao tem PageFrame no SCX legado (form flat).
	* Este metodo prepara a superficie do form (Picture de fundo) e
	* delega para as sub-configuracoes: cabecalho e botoes de acao.
	* Containers de trabalho (grid, filtros, impressora) serao criados
	* nas proximas fases (4-8).
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPageFrame()
		THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
		THIS.ConfigurarCabecalho()
		THIS.ConfigurarBotoesAcao()
		THIS.ConfigurarPaginaLista()
		THIS.ConfigurarPaginaDados()
	ENDPROC

	*====================================================================
	* ConfigurarCabecalho - Cabecalho cinza superior com titulo
	*====================================================================
	PROTECTED PROCEDURE ConfigurarCabecalho()
		THIS.AddObject("cnt_4c_Cabecalho", "Container")
		WITH THIS.cnt_4c_Cabecalho
			.Top = 0
			.Left = 0
			.Width = THIS.Width
			.Height = 80
			.BackStyle = 1
			.BackColor = RGB(100, 100, 100)
			.BorderWidth = 0
			.Visible = .T.

			.AddObject("lbl_4c_Sombra", "Label")
			WITH .lbl_4c_Sombra
				.AutoSize = .F.
				.FontBold = .T.
				.FontName = "Tahoma"
				.FontSize = 18
				.WordWrap = .T.
				.Alignment = 0
				.BackStyle = 0
				.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
				.Height = 40
				.Left = 10
				.Top = 18
				.Width = THIS.Width
				.ForeColor = RGB(0, 0, 0)
			ENDWITH

			.AddObject("lbl_4c_Titulo", "Label")
			WITH .lbl_4c_Titulo
				.AutoSize = .F.
				.FontBold = .T.
				.FontName = "Tahoma"
				.FontSize = 18
				.WordWrap = .T.
				.Alignment = 0
				.BackStyle = 0
				.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
				.Height = 46
				.Left = 10
				.Top = 17
				.Width = THIS.Width
				.ForeColor = RGB(255, 255, 255)
			ENDWITH
		ENDWITH
	ENDPROC

	*====================================================================
	* ConfigurarBotoesAcao - CommandGroup Imprimir + Encerrar
	*====================================================================
	PROTECTED PROCEDURE ConfigurarBotoesAcao()
		THIS.AddObject("cmg_4c_BtnReport", "CommandGroup")
		WITH THIS.cmg_4c_BtnReport
			.Top = -2
			.Left = THIS.Width - 162
			.Width = 162
			.Height = 85
			.BackStyle = 0
			.BorderStyle = 0
			.SpecialEffect = 1
			.ButtonCount = 2
			.Themes = .F.
			.ZOrder(0)

			WITH .Buttons(1)
				.Top = 5
				.Left = 5
				.Height = 75
				.Width = 75
				.FontBold = .T.
				.FontItalic = .T.
				.WordWrap = .T.
				.Picture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
				.Caption = "\<Imprimir"
				.ForeColor = RGB(90, 90, 90)
				.BackColor = RGB(255, 255, 255)
				.Themes = .F.
			ENDWITH

			WITH .Buttons(2)
				.Top = 5
				.Left = 81
				.Height = 75
				.Width = 75
				.FontBold = .T.
				.FontItalic = .T.
				.FontName = "Tahoma"
				.FontSize = 8
				.WordWrap = .T.
				.Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
				.Cancel = .T.
				.Caption = "Encerrar"
				.ForeColor = RGB(90, 90, 90)
				.BackColor = RGB(255, 255, 255)
				.Themes = .F.
			ENDWITH
		ENDWITH
	ENDPROC

	*====================================================================
	* TornarControlesVisiveis - Torna controles visiveis recursivamente
	* obj_4c_Opt_Impressora: skip Visible mas recursa filhos (Pattern #109)
	*====================================================================
	PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
		LOCAL loc_i, loc_oControl
		IF VARTYPE(par_oContainer) != "O"
			RETURN
		ENDIF
		IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
			RETURN
		ENDIF
		FOR loc_i = 1 TO par_oContainer.ControlCount
			loc_oControl = par_oContainer.Controls(loc_i)
			IF VARTYPE(loc_oControl) != "O"
				LOOP
			ENDIF
			IF INLIST(UPPER(loc_oControl.Name), "OBJ_4C_OPT_IMPRESSORA", "CNT_4C_CABECALHO")
				IF PEMSTATUS(loc_oControl, "ControlCount", 5)
					THIS.TornarControlesVisiveis(loc_oControl)
				ENDIF
				LOOP
			ENDIF
			IF PEMSTATUS(loc_oControl, "Visible", 5)
				loc_oControl.Visible = .T.
			ENDIF
			IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
				THIS.TornarControlesVisiveis(loc_oControl)
			ENDIF
		ENDFOR
	ENDPROC

	*====================================================================
	* Destroy - Libera BO e cursor local
	*====================================================================
	PROCEDURE Destroy()
		IF VARTYPE(THIS.this_oBusinessObject) = "O"
			THIS.this_oBusinessObject = .NULL.
		ENDIF
		IF USED("cursor_4c_Etiquetas")
			USE IN cursor_4c_Etiquetas
		ENDIF
		DODEFAULT()
	ENDPROC

	*====================================================================
	* ConfigurarPaginaLista - Filtros, grid e botoes de acao
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaLista()
		LOCAL loc_nTop

		*-- Linha 1: Empresa / Operacao (top=88)
		loc_nTop = 88

		THIS.AddObject("lbl_4c_LEmps", "Label")
		WITH THIS.lbl_4c_LEmps
			.AutoSize  = .F.
			.Caption   = "Empresa:"
			.Top       = loc_nTop + 3
			.Left      = 12
			.Width     = 58
			.Height    = 18
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
		ENDWITH

		THIS.AddObject("txt_4c_Emps", "TextBox")
		WITH THIS.txt_4c_Emps
			.Top       = loc_nTop
			.Left      = 73
			.Width     = 36
			.Height    = 22
			.FontName  = "Tahoma"
			.FontSize  = 8
			.MaxLength = 3
		ENDWITH

		THIS.AddObject("lbl_4c_DEmps", "Label")
		WITH THIS.lbl_4c_DEmps
			.AutoSize  = .F.
			.Caption   = ""
			.Top       = loc_nTop + 3
			.Left      = 112
			.Width     = 200
			.Height    = 18
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
		ENDWITH

		THIS.AddObject("lbl_4c_LDopes", "Label")
		WITH THIS.lbl_4c_LDopes
			.AutoSize  = .F.
			.Caption   = "Opera" + CHR(231) + CHR(227) + "o:"
			.Top       = loc_nTop + 3
			.Left      = 320
			.Width     = 65
			.Height    = 18
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
		ENDWITH

		THIS.AddObject("txt_4c_Dopes", "TextBox")
		WITH THIS.txt_4c_Dopes
			.Top       = loc_nTop
			.Left      = 388
			.Width     = 195
			.Height    = 22
			.FontName  = "Tahoma"
			.FontSize  = 8
			.MaxLength = 20
		ENDWITH

		THIS.AddObject("lbl_4c_LNumes", "Label")
		WITH THIS.lbl_4c_LNumes
			.AutoSize  = .F.
			.Caption   = "N" + CHR(250) + "m.:"
			.Top       = loc_nTop + 3
			.Left      = 590
			.Width     = 35
			.Height    = 18
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
		ENDWITH

		THIS.AddObject("txt_4c_Numes", "TextBox")
		WITH THIS.txt_4c_Numes
			.Top       = loc_nTop
			.Left      = 628
			.Width     = 55
			.Height    = 22
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Value     = 0
		ENDWITH

		*-- Linha 2: Produto / Qtde (top=116)
		loc_nTop = 116

		THIS.AddObject("lbl_4c_LCpros", "Label")
		WITH THIS.lbl_4c_LCpros
			.AutoSize  = .F.
			.Caption   = "Produto:"
			.Top       = loc_nTop + 3
			.Left      = 12
			.Width     = 58
			.Height    = 18
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
		ENDWITH

		THIS.AddObject("txt_4c_Cpros", "TextBox")
		WITH THIS.txt_4c_Cpros
			.Top       = loc_nTop
			.Left      = 73
			.Width     = 110
			.Height    = 22
			.FontName  = "Tahoma"
			.FontSize  = 8
			.MaxLength = 14
		ENDWITH

		THIS.AddObject("txt_4c_Dpros", "TextBox")
		WITH THIS.txt_4c_Dpros
			.Top       = loc_nTop
			.Left      = 186
			.Width     = 270
			.Height    = 22
			.FontName  = "Tahoma"
			.FontSize  = 8
			.MaxLength = 40
		ENDWITH

		THIS.AddObject("lbl_4c_LQtds", "Label")
		WITH THIS.lbl_4c_LQtds
			.AutoSize  = .F.
			.Caption   = "Qtd:"
			.Top       = loc_nTop + 3
			.Left      = 460
			.Width     = 30
			.Height    = 18
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
		ENDWITH

		THIS.AddObject("txt_4c_Qtds", "TextBox")
		WITH THIS.txt_4c_Qtds
			.Top       = loc_nTop
			.Left      = 493
			.Width     = 65
			.Height    = 22
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Value     = 0
		ENDWITH

		THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
		WITH THIS.cmd_4c_BtnCarregar
			.Top             = loc_nTop
			.Left            = 373
			.Width           = 26
			.Height          = 26
			.Caption         = ""
			.Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
			.ToolTipText     = "Carregar de movimento"
			.Themes          = .T.
		ENDWITH

		THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
		WITH THIS.cmd_4c_BtnExcluir
			.Top             = loc_nTop
			.Left            = 21
			.Width           = 26
			.Height          = 26
			.Caption         = ""
			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
			.ToolTipText     = "Excluir linha selecionada"
			.Themes          = .T.
		ENDWITH

		*-- Linha 3: Lista de Precos (top=144)
		loc_nTop = 144

		THIS.AddObject("lbl_4c_LLpreco", "Label")
		WITH THIS.lbl_4c_LLpreco
			.AutoSize  = .F.
			.Caption   = "Lista Pre" + CHR(231) + "o:"
			.Top       = loc_nTop + 3
			.Left      = 12
			.Width     = 70
			.Height    = 18
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
		ENDWITH

		THIS.AddObject("txt_4c_Lpreco", "TextBox")
		WITH THIS.txt_4c_Lpreco
			.Top       = loc_nTop
			.Left      = 85
			.Width     = 80
			.Height    = 22
			.FontName  = "Tahoma"
			.FontSize  = 8
			.MaxLength = 10
		ENDWITH

		THIS.AddObject("txt_4c_LPreco2", "TextBox")
		WITH THIS.txt_4c_LPreco2
			.Top      = loc_nTop
			.Left     = 170
			.Width    = 210
			.Height   = 22
			.FontName = "Tahoma"
			.FontSize = 8
			.ReadOnly = .T.
		ENDWITH

		THIS.AddObject("chk_4c_Lista", "CheckBox")
		WITH THIS.chk_4c_Lista
			.Top       = loc_nTop
			.Left      = 390
			.Width     = 130
			.Height    = 22
			.Caption   = "Usar Lista Pre" + CHR(231) + "o"
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
			.Value     = 0
		ENDWITH

		THIS.AddObject("chk_4c_Precio", "CheckBox")
		WITH THIS.chk_4c_Precio
			.Top       = loc_nTop
			.Left      = 528
			.Width     = 145
			.Height    = 22
			.Caption   = "Usar Pre" + CHR(231) + "o Produto"
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(255, 255, 255)
			.Value     = 0
		ENDWITH

		*-- Grid de Etiquetas (top=172)
		THIS.AddObject("grd_4c_Etiquetas", "GridBase")
		THIS.grd_4c_Etiquetas.RecordSourceType = 1
		THIS.grd_4c_Etiquetas.ColumnCount = 3
		THIS.grd_4c_Etiquetas.RecordSource     = "cursor_4c_Etiquetas"
		THIS.grd_4c_Etiquetas.ColumnCount      = 7
		WITH THIS.grd_4c_Etiquetas
			.Top              = 172
			.Left             = 12
			.Width            = 818
			.Height           = 200
			.GridLines        = 1
			.DeleteMark       = .F.
			.RecordMark       = .F.
			.AllowRowSizing   = .F.
			.HeaderHeight     = 22
			.RowHeight        = 20
			.FontName         = "Tahoma"
			.FontSize         = 8

			WITH .Columns(1)
				.Header1.Caption = "Produto"
				.Width           = 110
				.ControlSource   = "cursor_4c_Etiquetas.Cpros"
				.Sparse          = .F.
				.AddObject("txt_4c_GrdCpros", "TextBox")
				WITH .txt_4c_GrdCpros
					.FontName = "Tahoma"
					.FontSize = 8
				ENDWITH
				.CurrentControl = "txt_4c_GrdCpros"
			ENDWITH

			WITH .Columns(2)
				.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
				.Width           = 270
				.ControlSource   = "cursor_4c_Etiquetas.DPros"
				.Sparse          = .F.
				.AddObject("txt_4c_GrdDpros", "TextBox")
				WITH .txt_4c_GrdDpros
					.FontName = "Tahoma"
					.FontSize = 8
				ENDWITH
				.CurrentControl = "txt_4c_GrdDpros"
			ENDWITH

			WITH .Columns(3)
				.Header1.Caption = "Quantidade"
				.Width           = 65
				.ControlSource   = "cursor_4c_Etiquetas.Qtds"
				.Sparse          = .F.
				.AddObject("txt_4c_GrdQtds", "TextBox")
				WITH .txt_4c_GrdQtds
					.FontName = "Tahoma"
					.FontSize = 8
				ENDWITH
				.CurrentControl = "txt_4c_GrdQtds"
			ENDWITH

			WITH .Columns(4)
				.Header1.Caption = "Refer" + CHR(234) + "ncia Fornecedor"
				.Width           = 135
				.ControlSource   = "cursor_4c_Etiquetas.Reffs"
				.Sparse          = .F.
				.AddObject("txt_4c_GrdReffs", "TextBox")
				WITH .txt_4c_GrdReffs
					.FontName = "Tahoma"
					.FontSize = 8
				ENDWITH
				.CurrentControl = "txt_4c_GrdReffs"
			ENDWITH

			WITH .Columns(5)
				.Header1.Caption = "Parcelas"
				.Width           = 60
				.ControlSource   = "cursor_4c_Etiquetas.Parcelas"
				.Sparse          = .F.
				.AddObject("txt_4c_GrdParcelas", "TextBox")
				WITH .txt_4c_GrdParcelas
					.FontName = "Tahoma"
					.FontSize = 8
				ENDWITH
				.CurrentControl = "txt_4c_GrdParcelas"
			ENDWITH

			WITH .Columns(6)
				.Header1.Caption = "Pre" + CHR(231) + "o"
				.Width           = 70
				.ControlSource   = "cursor_4c_Etiquetas.PVens"
				.ReadOnly        = .T.
				.Sparse          = .F.
				.AddObject("txt_4c_GrdPvens", "TextBox")
				WITH .txt_4c_GrdPvens
					.FontName = "Tahoma"
					.FontSize = 8
					.ReadOnly = .T.
				ENDWITH
				.CurrentControl = "txt_4c_GrdPvens"
			ENDWITH

			WITH .Columns(7)
				.Header1.Caption = "Pre" + CHR(231) + "o De"
				.Width           = 70
				.ControlSource   = "cursor_4c_Etiquetas.PrecoDe"
				.ReadOnly        = .T.
				.Sparse          = .F.
				.AddObject("txt_4c_GrdPrecoDe", "TextBox")
				WITH .txt_4c_GrdPrecoDe
					.FontName = "Tahoma"
					.FontSize = 8
					.ReadOnly = .T.
				ENDWITH
				.CurrentControl = "txt_4c_GrdPrecoDe"
			ENDWITH
		ENDWITH

		*-- Re-definir ControlSource apos AddObject (Column gerencia binding dos TextBoxes internos)
		THIS.grd_4c_Etiquetas.Columns(1).ControlSource = "cursor_4c_Etiquetas.Cpros"
		THIS.grd_4c_Etiquetas.Columns(2).ControlSource = "cursor_4c_Etiquetas.DPros"
		THIS.grd_4c_Etiquetas.Columns(3).ControlSource = "cursor_4c_Etiquetas.Qtds"
		THIS.grd_4c_Etiquetas.Columns(4).ControlSource = "cursor_4c_Etiquetas.Reffs"
		THIS.grd_4c_Etiquetas.Columns(5).ControlSource = "cursor_4c_Etiquetas.Parcelas"
		THIS.grd_4c_Etiquetas.Columns(6).ControlSource = "cursor_4c_Etiquetas.PVens"
		THIS.grd_4c_Etiquetas.Columns(7).ControlSource = "cursor_4c_Etiquetas.PrecoDe"

		*-- Primeira linha em branco para edicao imediata
		IF USED("cursor_4c_Etiquetas") AND RECCOUNT("cursor_4c_Etiquetas") = 0
			SELECT cursor_4c_Etiquetas
			APPEND BLANK
		ENDIF

		*-- BINDEVENTs
		BINDEVENT(THIS.txt_4c_Emps,                  "KeyPress", THIS, "TxtEmpsKeyPress")
		BINDEVENT(THIS.txt_4c_Dopes,                 "KeyPress", THIS, "TxtDopesKeyPress")
		BINDEVENT(THIS.txt_4c_Cpros,                 "KeyPress", THIS, "TxtCprosKeyPress")
		BINDEVENT(THIS.txt_4c_Dpros,                 "KeyPress", THIS, "TxtDprosKeyPress")
		BINDEVENT(THIS.txt_4c_Qtds,                  "KeyPress", THIS, "TxtQtdsKeyPress")
		BINDEVENT(THIS.txt_4c_Lpreco,                "KeyPress", THIS, "TxtLprecoKeyPress")
		BINDEVENT(THIS.txt_4c_LPreco2,               "KeyPress", THIS, "TxtLPreco2KeyPress")
		BINDEVENT(THIS.cmd_4c_BtnCarregar,           "Click",    THIS, "CmdBtnCarregarClick")
		BINDEVENT(THIS.cmd_4c_BtnExcluir,            "Click",    THIS, "CmdBtnExcluirClick")
		BINDEVENT(THIS.grd_4c_Etiquetas,             "KeyPress", THIS, "GrdEtiquetasKeyPress")
		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(1), "Click",    THIS, "BtnImprimirClick")
		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(2), "Click",    THIS, "BtnEncerrarClick")
		BINDEVENT(THIS.txt_4c_Numes,                 "KeyPress", THIS, "TxtNumesKeyPress")
		BINDEVENT(THIS.chk_4c_Lista,                 "Click",    THIS, "ChkListaClick")
		BINDEVENT(THIS.chk_4c_Precio,                "Click",    THIS, "ChkPrecioClick")
	ENDPROC

	*====================================================================
	* AlternarPagina - Stub (form flat, sem PageFrame)
	*====================================================================
	PROTECTED PROCEDURE AlternarPagina(par_nPagina)
		RETURN
	ENDPROC

	*====================================================================
	* GrdEtiquetasKeyPress - Enter na coluna 4 (Reffs) abre busca por ref
	*====================================================================
	PROCEDURE GrdEtiquetasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		IF THIS.grd_4c_Etiquetas.ActiveColumn = 4
			THIS.AbrirBuscaProdutoRef()
		ENDIF
	ENDPROC

	*====================================================================
	* TxtEmpsKeyPress - Valida ou abre busca de empresa
	*====================================================================
	PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		LOCAL loc_cEmps, loc_nRet, loc_oBusca
		loc_cEmps = ALLTRIM(NVL(THIS.txt_4c_Emps.Value, ""))
		IF !EMPTY(loc_cEmps)
			loc_nRet = SQLEXEC(gnConnHandle, ;
				"SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Cemps)=" + EscaparSQL(loc_cEmps), ;
				"cursor_4c_BuscaEmp")
			IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
				SELECT cursor_4c_BuscaEmp
				THIS.lbl_4c_DEmps.Caption = ALLTRIM(cursor_4c_BuscaEmp.Razas)
				USE IN cursor_4c_BuscaEmp
				THIS.txt_4c_Dopes.SetFocus()
				RETURN
			ENDIF
			IF USED("cursor_4c_BuscaEmp")
				USE IN cursor_4c_BuscaEmp
			ENDIF
		ENDIF
		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
			"SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", ;
			loc_cEmps, "Empresa", .T., .T., "")
		IF VARTYPE(loc_oBusca) = "O"
			IF !loc_oBusca.this_lAchouRegistro
				loc_oBusca.mAddColuna("Cemps",  "XXX", "C" + CHR(243) + "d.")
				loc_oBusca.mAddColuna("Razas", "", "Empresa")
				loc_oBusca.Show()
			ENDIF
			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
				SELECT cursor_4c_BuscaEmp
				THIS.txt_4c_Emps.Value     = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
				THIS.lbl_4c_DEmps.Caption  = ALLTRIM(cursor_4c_BuscaEmp.Razas)
				USE IN cursor_4c_BuscaEmp
				THIS.txt_4c_Dopes.SetFocus()
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* TxtDopesKeyPress - Valida ou abre busca de operacao (SigCdOpe)
	*====================================================================
	PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		LOCAL loc_cDopes, loc_nRet, loc_oBusca
		loc_cDopes = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
		IF !EMPTY(loc_cDopes)
			loc_nRet = SQLEXEC(gnConnHandle, ;
				"SELECT TOP 1 Dopes FROM SigCdOpe WHERE RTRIM(Dopes)=" + EscaparSQL(loc_cDopes), ;
				"cursor_4c_BuscaOpe")
			IF loc_nRet > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
				USE IN cursor_4c_BuscaOpe
				THIS.txt_4c_Cpros.SetFocus()
				RETURN
			ENDIF
			IF USED("cursor_4c_BuscaOpe")
				USE IN cursor_4c_BuscaOpe
			ENDIF
		ENDIF
		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
			"SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
			loc_cDopes, "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
		IF VARTYPE(loc_oBusca) = "O"
			IF !loc_oBusca.this_lAchouRegistro
				loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
				loc_oBusca.Show()
			ENDIF
			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
				SELECT cursor_4c_BuscaOpe
				THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
				USE IN cursor_4c_BuscaOpe
				THIS.txt_4c_Cpros.SetFocus()
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* TxtCprosKeyPress - Busca produto por codigo, EAN13 ou codigo de barras
	*====================================================================
	PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		LOCAL loc_cCodigo, loc_nRet
		loc_cCodigo = ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, ""))
		IF !EMPTY(loc_cCodigo)
			loc_nRet = SQLEXEC(gnConnHandle, ;
				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
				"WHERE RTRIM(Cpros)=" + EscaparSQL(loc_cCodigo) + ;
				" OR RTRIM(Ean13)="  + EscaparSQL(loc_cCodigo) + ;
				" OR RTRIM(CBars)="  + EscaparSQL(loc_cCodigo), ;
				"cursor_4c_BuscaProd")
			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
				SELECT cursor_4c_BuscaProd
				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
				USE IN cursor_4c_BuscaProd
				THIS.txt_4c_Qtds.SetFocus()
				RETURN
			ENDIF
			IF USED("cursor_4c_BuscaProd")
				USE IN cursor_4c_BuscaProd
			ENDIF
		ENDIF
		THIS.AbrirBuscaProdutoCodigo()
	ENDPROC

	*====================================================================
	* TxtDprosKeyPress - Busca produto por descricao
	*====================================================================
	PROCEDURE TxtDprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		LOCAL loc_cDesc, loc_nRet
		loc_cDesc = ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, ""))
		IF !EMPTY(loc_cDesc)
			loc_nRet = SQLEXEC(gnConnHandle, ;
				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
				"WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc), ;
				"cursor_4c_BuscaProd")
			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
				SELECT cursor_4c_BuscaProd
				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
				USE IN cursor_4c_BuscaProd
				THIS.txt_4c_Qtds.SetFocus()
				RETURN
			ENDIF
			IF USED("cursor_4c_BuscaProd")
				USE IN cursor_4c_BuscaProd
			ENDIF
		ENDIF
		THIS.AbrirBuscaProdutoDescricao()
	ENDPROC

	*====================================================================
	* TxtQtdsKeyPress - Valida qtde e adiciona produto ao grid
	*====================================================================
	PROCEDURE TxtQtdsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		LOCAL loc_cCpros, loc_nQtds
		loc_cCpros = ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, ""))
		loc_nQtds  = NVL(THIS.txt_4c_Qtds.Value, 0)
		IF EMPTY(loc_cCpros)
			MsgAviso("Informe o c" + CHR(243) + "digo do produto.", "Aten" + CHR(231) + CHR(227) + "o")
			THIS.txt_4c_Cpros.SetFocus()
			RETURN
		ENDIF
		IF loc_nQtds <= 0
			MsgAviso("Quantidade deve ser maior que zero.", "Aten" + CHR(231) + CHR(227) + "o")
			THIS.txt_4c_Qtds.SetFocus()
			RETURN
		ENDIF
		SELECT cursor_4c_Etiquetas
		GO BOTTOM
		IF !EMPTY(cursor_4c_Etiquetas.Cpros)
			APPEND BLANK
		ENDIF
		REPLACE Cpros WITH loc_cCpros, ;
		        DPros WITH ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, "")), ;
		        Qtds  WITH loc_nQtds
		THIS.CarregarPrecoProduto(loc_cCpros)
		IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, "")))
			THIS.AtualizarPrecoPorLista(loc_cCpros)
		ENDIF
		APPEND BLANK
		THIS.txt_4c_Cpros.Value = ""
		THIS.txt_4c_Dpros.Value = ""
		THIS.txt_4c_Qtds.Value  = 0
		THIS.grd_4c_Etiquetas.Refresh()
		THIS.txt_4c_Cpros.SetFocus()
	ENDPROC

	*====================================================================
	* TxtLprecoKeyPress - Valida ou abre busca de lista de precos
	*====================================================================
	PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		LOCAL loc_cLpreco, loc_nRet, loc_oBusca
		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
		IF !EMPTY(loc_cLpreco)
			loc_nRet = SQLEXEC(gnConnHandle, ;
				"SELECT TOP 1 LPrecos, DLPrecos FROM SigCdLpc " + ;
				"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco), ;
				"cursor_4c_BuscaLpc")
			IF loc_nRet > 0 AND USED("cursor_4c_BuscaLpc") AND RECCOUNT("cursor_4c_BuscaLpc") > 0
				SELECT cursor_4c_BuscaLpc
				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
				USE IN cursor_4c_BuscaLpc
				THIS.chk_4c_Lista.SetFocus()
				RETURN
			ENDIF
			IF USED("cursor_4c_BuscaLpc")
				USE IN cursor_4c_BuscaLpc
			ENDIF
		ENDIF
		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
			"SigCdLpc", "cursor_4c_BuscaLpc", "LPrecos", ;
			loc_cLpreco, "Lista de Pre" + CHR(231) + "os", .T., .T., "")
		IF VARTYPE(loc_oBusca) = "O"
			IF !loc_oBusca.this_lAchouRegistro
				loc_oBusca.mAddColuna("LPrecos",  "", "C" + CHR(243) + "digo")
				loc_oBusca.mAddColuna("DLPrecos", "", "Descri" + CHR(231) + CHR(227) + "o")
				loc_oBusca.Show()
			ENDIF
			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLpc")
				SELECT cursor_4c_BuscaLpc
				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
				USE IN cursor_4c_BuscaLpc
				THIS.chk_4c_Lista.SetFocus()
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* TxtLPreco2KeyPress - ReadOnly, redireciona foco para txt_4c_Lpreco
	*====================================================================
	PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		THIS.txt_4c_Lpreco.SetFocus()
	ENDPROC

	*====================================================================
	* AbrirBuscaProdutoCodigo - Picker de produto por codigo
	*====================================================================
	PROTECTED PROCEDURE AbrirBuscaProdutoCodigo()
		LOCAL loc_oBusca
		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
			"SigCdPro", "cursor_4c_BuscaProd", "Cpros", ;
			ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, "")), ;
			"Busca de Produto", .T., .T., "")
		IF VARTYPE(loc_oBusca) = "O"
			IF !loc_oBusca.this_lAchouRegistro
				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
				loc_oBusca.Show()
			ENDIF
			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
				SELECT cursor_4c_BuscaProd
				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
				USE IN cursor_4c_BuscaProd
				THIS.txt_4c_Qtds.SetFocus()
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* AbrirBuscaProdutoDescricao - Picker de produto por descricao
	*====================================================================
	PROTECTED PROCEDURE AbrirBuscaProdutoDescricao()
		LOCAL loc_oBusca
		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
			"SigCdPro", "cursor_4c_BuscaProd", "DPros", ;
			ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, "")), ;
			"Busca de Produto", .T., .T., "")
		IF VARTYPE(loc_oBusca) = "O"
			IF !loc_oBusca.this_lAchouRegistro
				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
				loc_oBusca.Show()
			ENDIF
			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
				SELECT cursor_4c_BuscaProd
				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
				USE IN cursor_4c_BuscaProd
				THIS.txt_4c_Qtds.SetFocus()
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* AbrirBuscaProdutoRef - Picker de produto por referencia (DPro2s)
	*====================================================================
	PROTECTED PROCEDURE AbrirBuscaProdutoRef()
		LOCAL loc_cRef, loc_oBusca
		loc_cRef = ""
		IF USED("cursor_4c_Etiquetas") AND !EOF("cursor_4c_Etiquetas")
			loc_cRef = ALLTRIM(NVL(cursor_4c_Etiquetas.Reffs, ""))
		ENDIF
		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
			"SigCdPro", "cursor_4c_BuscaProd", "DPro2s", ;
			loc_cRef, "Busca por Refer" + CHR(234) + "ncia", .T., .T., "")
		IF VARTYPE(loc_oBusca) = "O"
			IF !loc_oBusca.this_lAchouRegistro
				loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
				loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
				loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
				loc_oBusca.Show()
			ENDIF
			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
				SELECT cursor_4c_BuscaProd
				LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
				loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.Cpros)
				loc_cDPros  = ALLTRIM(cursor_4c_BuscaProd.DPros)
				loc_cDPro2s = ALLTRIM(cursor_4c_BuscaProd.DPro2s)
				USE IN cursor_4c_BuscaProd
				SELECT cursor_4c_Etiquetas
				REPLACE Cpros WITH loc_cCpros, ;
				        DPros WITH loc_cDPros, ;
				        Reffs WITH loc_cDPro2s
				THIS.CarregarPrecoProduto(loc_cCpros)
				THIS.grd_4c_Etiquetas.Refresh()
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarPrecoProduto - Carrega PVens/PrecoDe/Pesos/DPro2s na linha
	*====================================================================
	PROTECTED PROCEDURE CarregarPrecoProduto(par_cCpros)
		LOCAL loc_nRet, loc_nPVens, loc_nPrecoDe, loc_nPesos, loc_cDPro2s
		IF EMPTY(par_cCpros)
			RETURN
		ENDIF
		loc_nRet = SQLEXEC(gnConnHandle, ;
			"SELECT TOP 1 PVens, PrecoDe, PesoMs, DPro2s " + ;
			"FROM SigCdPro WHERE RTRIM(Cpros)=" + EscaparSQL(par_cCpros), ;
			"cursor_4c_PrecosProd")
		IF loc_nRet > 0 AND USED("cursor_4c_PrecosProd") AND RECCOUNT("cursor_4c_PrecosProd") > 0
			SELECT cursor_4c_PrecosProd
			loc_nPVens   = NVL(cursor_4c_PrecosProd.PVens,   0)
			loc_nPrecoDe = NVL(cursor_4c_PrecosProd.PrecoDe,  0)
			loc_nPesos   = NVL(cursor_4c_PrecosProd.PesoMs,  0)
			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_PrecosProd.DPro2s, ""))
			USE IN cursor_4c_PrecosProd
			SELECT cursor_4c_Etiquetas
			IF THIS.chk_4c_Precio.Value = 1
				REPLACE PVens   WITH loc_nPVens, ;
				        PrecoDe WITH loc_nPrecoDe, ;
				        Pesos   WITH loc_nPesos, ;
				        DPro2s  WITH loc_cDPro2s
			ELSE
				REPLACE Pesos  WITH loc_nPesos, ;
				        DPro2s WITH loc_cDPro2s
			ENDIF
		ENDIF
		IF USED("cursor_4c_PrecosProd")
			USE IN cursor_4c_PrecosProd
		ENDIF
	ENDPROC

	*====================================================================
	* AtualizarPrecoPorLista - Substitui PVens/PrecoDe pelo preco da lista
	*====================================================================
	PROTECTED PROCEDURE AtualizarPrecoPorLista(par_cCpros)
		LOCAL loc_cLpreco, loc_nRet
		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
		IF EMPTY(loc_cLpreco) OR EMPTY(par_cCpros)
			RETURN
		ENDIF
		loc_nRet = SQLEXEC(gnConnHandle, ;
			"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
			"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
			" AND RTRIM(CPros)=" + EscaparSQL(par_cCpros), ;
			"cursor_4c_PrecoLista")
		IF loc_nRet > 0 AND USED("cursor_4c_PrecoLista") AND RECCOUNT("cursor_4c_PrecoLista") > 0
			SELECT cursor_4c_PrecoLista
			LOCAL loc_nPVens, loc_nPrecoDe
			loc_nPVens   = NVL(cursor_4c_PrecoLista.PVens,   0)
			loc_nPrecoDe = NVL(cursor_4c_PrecoLista.PrecoDe, 0)
			USE IN cursor_4c_PrecoLista
			SELECT cursor_4c_Etiquetas
			REPLACE PVens   WITH loc_nPVens, ;
			        PrecoDe WITH loc_nPrecoDe
		ENDIF
		IF USED("cursor_4c_PrecoLista")
			USE IN cursor_4c_PrecoLista
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarItensDaLista - Popula grid com todos itens de SigCdLpi
	*====================================================================
	PROTECTED PROCEDURE CarregarItensDaLista()
		LOCAL loc_cLpreco, loc_nRet
		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
		IF EMPTY(loc_cLpreco)
			MsgAviso("Informe a lista de pre" + CHR(231) + "os.", "Aten" + CHR(231) + CHR(227) + "o")
			THIS.txt_4c_Lpreco.SetFocus()
			RETURN
		ENDIF
		loc_nRet = SQLEXEC(gnConnHandle, ;
			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
			" i.PVens AS iPVens, i.PrecoDe AS iPrecoDe, p.PesoMs AS iPesoMs " + ;
			"FROM SigCdLpi i " + ;
			"INNER JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
			"WHERE RTRIM(i.LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
			" ORDER BY i.CPros", ;
			"cursor_4c_ItensList")
		IF loc_nRet <= 0 OR !USED("cursor_4c_ItensList") OR RECCOUNT("cursor_4c_ItensList") = 0
			IF USED("cursor_4c_ItensList")
				USE IN cursor_4c_ItensList
			ENDIF
			MsgAviso("Nenhum item encontrado para a lista selecionada.", "Aten" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s, loc_nPVens, loc_nPrecoDe, loc_nPesos
		SELECT cursor_4c_Etiquetas
		ZAP
		SELECT cursor_4c_ItensList
		SCAN
			loc_cCpros   = ALLTRIM(cursor_4c_ItensList.iCPros)
			loc_cDPros   = ALLTRIM(cursor_4c_ItensList.iDPros)
			loc_cDPro2s  = ALLTRIM(cursor_4c_ItensList.iDPro2s)
			loc_nPVens   = NVL(cursor_4c_ItensList.iPVens,   0)
			loc_nPrecoDe = NVL(cursor_4c_ItensList.iPrecoDe, 0)
			loc_nPesos   = NVL(cursor_4c_ItensList.iPesoMs,  0)
			SELECT cursor_4c_Etiquetas
			APPEND BLANK
			REPLACE Cpros   WITH loc_cCpros, ;
			        DPros   WITH loc_cDPros, ;
			        DPro2s  WITH loc_cDPro2s, ;
			        PVens   WITH loc_nPVens, ;
			        PrecoDe WITH loc_nPrecoDe, ;
			        Pesos   WITH loc_nPesos, ;
			        Qtds    WITH 1
			SELECT cursor_4c_ItensList
		ENDSCAN
		USE IN cursor_4c_ItensList
		SELECT cursor_4c_Etiquetas
		APPEND BLANK
		GO TOP
		THIS.grd_4c_Etiquetas.Refresh()
	ENDPROC

	*====================================================================
	* CmdBtnCarregarClick - Carrega itens de SigMvItn por empresa/operacao
	*====================================================================
	PROCEDURE CmdBtnCarregarClick()
		LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cLpreco, loc_nRet
		loc_cEmps   = ALLTRIM(NVL(THIS.txt_4c_Emps.Value,  ""))
		loc_cDopes  = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
		loc_nNumes  = IIF(PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O", ;
		                  NVL(THIS.txt_4c_Numes.Value, 0), 0)
		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,""))
		IF EMPTY(loc_cEmps)
			MsgAviso("Informe a empresa.", "Aten" + CHR(231) + CHR(227) + "o")
			THIS.txt_4c_Emps.SetFocus()
			RETURN
		ENDIF
		IF EMPTY(loc_cDopes)
			MsgAviso("Informe a opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
			THIS.txt_4c_Dopes.SetFocus()
			RETURN
		ENDIF
		IF loc_nNumes <= 0
			MsgAviso("Informe o n" + CHR(250) + "mero do documento.", "Aten" + CHR(231) + CHR(227) + "o")
			IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
				THIS.txt_4c_Numes.SetFocus()
			ENDIF
			RETURN
		ENDIF
		loc_nRet = SQLEXEC(gnConnHandle, ;
			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
			" i.Qtds AS iQtds, i.Citens AS iCitens, i.Numes AS iNumes, " + ;
			" i.Emps AS iEmps, i.Dopes AS iDopes, " + ;
			" p.PVens AS iPVens, p.PrecoDe AS iPrecoDe, p.PesoMs AS iPesoMs " + ;
			"FROM SigMvItn i " + ;
			"LEFT JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
			"WHERE RTRIM(i.Emps)=" + EscaparSQL(loc_cEmps) + ;
			" AND RTRIM(i.Dopes)=" + EscaparSQL(loc_cDopes) + ;
			" AND i.Numes = " + FormatarNumeroSQL(loc_nNumes, 0) + ;
			" ORDER BY i.CPros", ;
			"cursor_4c_SigMvItn")
		IF loc_nRet <= 0 OR !USED("cursor_4c_SigMvItn") OR RECCOUNT("cursor_4c_SigMvItn") = 0
			IF USED("cursor_4c_SigMvItn")
				USE IN cursor_4c_SigMvItn
			ENDIF
			MsgAviso("Nenhum item encontrado para empresa/opera" + CHR(231) + CHR(227) + "o informada.", ;
			         "Aten" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
		LOCAL loc_nQtds, loc_nCitens, loc_nNumes
		LOCAL loc_cIEmps, loc_cIDopes
		LOCAL loc_nPVens, loc_nPrecoDe, loc_nPesos
		LOCAL loc_cEmpDoNum, loc_nRetLpi
		SELECT cursor_4c_Etiquetas
		ZAP
		SELECT cursor_4c_SigMvItn
		SCAN
			loc_cCpros   = ALLTRIM(cursor_4c_SigMvItn.iCPros)
			loc_cDPros   = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPros,  ""))
			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPro2s, ""))
			loc_nQtds    = NVL(cursor_4c_SigMvItn.iQtds,    0)
			loc_nCitens  = NVL(cursor_4c_SigMvItn.iCitens,  0)
			loc_nNumes   = NVL(cursor_4c_SigMvItn.iNumes,   0)
			loc_cIEmps   = ALLTRIM(NVL(cursor_4c_SigMvItn.iEmps,   ""))
			loc_cIDopes  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDopes,  ""))
			loc_nPVens   = NVL(cursor_4c_SigMvItn.iPVens,   0)
			loc_nPrecoDe = NVL(cursor_4c_SigMvItn.iPrecoDe,  0)
			loc_nPesos   = NVL(cursor_4c_SigMvItn.iPesoMs,  0)
			*-- Aplica lista de precos se habilitada
			IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(loc_cLpreco)
				loc_nRetLpi = SQLEXEC(gnConnHandle, ;
					"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
					"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
					" AND RTRIM(CPros)=" + EscaparSQL(loc_cCpros), ;
					"cursor_4c_Lpi")
				IF loc_nRetLpi > 0 AND USED("cursor_4c_Lpi") AND RECCOUNT("cursor_4c_Lpi") > 0
					SELECT cursor_4c_Lpi
					loc_nPVens   = NVL(cursor_4c_Lpi.PVens,   loc_nPVens)
					loc_nPrecoDe = NVL(cursor_4c_Lpi.PrecoDe, loc_nPrecoDe)
				ENDIF
				IF USED("cursor_4c_Lpi")
					USE IN cursor_4c_Lpi
				ENDIF
			ENDIF
			loc_cEmpDoNum = PADR(loc_cIEmps, 3) + PADR(loc_cIDopes, 20) + STR(loc_nNumes, 6, 0)
			SELECT cursor_4c_Etiquetas
			APPEND BLANK
			REPLACE Cpros      WITH loc_cCpros, ;
			        DPros      WITH loc_cDPros, ;
			        DPro2s     WITH loc_cDPro2s, ;
			        Qtds       WITH loc_nQtds, ;
			        citens     WITH loc_nCitens, ;
			        empos      WITH LEFT(loc_cIEmps, 3), ;
			        empdopnums WITH loc_cEmpDoNum, ;
			        PVens      WITH loc_nPVens, ;
			        PrecoDe    WITH loc_nPrecoDe, ;
			        Pesos      WITH loc_nPesos, ;
			        Pedido     WITH LEFT(TRANSFORM(loc_nNumes), 30)
			SELECT cursor_4c_SigMvItn
		ENDSCAN
		USE IN cursor_4c_SigMvItn
		SELECT cursor_4c_Etiquetas
		APPEND BLANK
		GO TOP
		THIS.grd_4c_Etiquetas.Refresh()
	ENDPROC

	*====================================================================
	* CmdBtnExcluirClick - Remove linha selecionada do grid
	*====================================================================
	PROCEDURE CmdBtnExcluirClick()
		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
			RETURN
		ENDIF
		SELECT cursor_4c_Etiquetas
		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
			RETURN
		ENDIF
		DELETE
		PACK
		IF RECCOUNT("cursor_4c_Etiquetas") = 0
			APPEND BLANK
		ENDIF
		GO TOP
		THIS.grd_4c_Etiquetas.Refresh()
	ENDPROC

	*====================================================================
	* BtnIncluirClick - Adiciona linha em branco no grid para o usuario
	* preencher manualmente (produto/quantidade). Adaptacao CRUD do
	* fluxo OPERACIONAL: nao ha modo de edicao separado, o grid eh
	* editavel diretamente.
	*====================================================================
	PROCEDURE BtnIncluirClick()
		IF !USED("cursor_4c_Etiquetas")
			MsgAviso("Grid n" + CHR(227) + "o inicializado.", "Aten" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		SELECT cursor_4c_Etiquetas
		*-- Se ja existe linha em branco no final, apenas posiciona nela
		GO BOTTOM
		IF EMPTY(cursor_4c_Etiquetas.Cpros)
			THIS.grd_4c_Etiquetas.Refresh()
			THIS.grd_4c_Etiquetas.SetFocus()
			RETURN
		ENDIF
		*-- Adiciona nova linha em branco para digitacao
		APPEND BLANK
		GO BOTTOM
		THIS.grd_4c_Etiquetas.Refresh()
		THIS.grd_4c_Etiquetas.SetFocus()
	ENDPROC

	*====================================================================
	* BtnAlterarClick - Coloca o foco no campo Cpros (produto) da linha
	* corrente do grid, permitindo alterar quantidade/produto. Adaptacao
	* CRUD do fluxo OPERACIONAL - a edicao eh inline no grid.
	*====================================================================
	PROCEDURE BtnAlterarClick()
		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
			MsgAviso("Nenhum item para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		SELECT cursor_4c_Etiquetas
		IF EOF() OR BOF()
			GO TOP
		ENDIF
		THIS.grd_4c_Etiquetas.Refresh()
		THIS.grd_4c_Etiquetas.SetFocus()
		*-- Tenta focar na primeira coluna editavel (Cpros)
		IF PEMSTATUS(THIS.grd_4c_Etiquetas, "Column1", 5) AND ;
		   VARTYPE(THIS.grd_4c_Etiquetas.Column1) = "O"
			IF PEMSTATUS(THIS.grd_4c_Etiquetas.Column1, "Text1", 5) AND ;
			   VARTYPE(THIS.grd_4c_Etiquetas.Column1.Text1) = "O"
				THIS.grd_4c_Etiquetas.Column1.Text1.SetFocus()
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* BtnVisualizarClick - Reposiciona no topo do grid, atualiza contagem
	* e mostra resumo dos itens carregados. Adaptacao CRUD do fluxo
	* OPERACIONAL - equivale a visualizar a lista selecionada.
	*====================================================================
	PROCEDURE BtnVisualizarClick()
		LOCAL loc_nTotal, loc_nQtdTotal, loc_cMensagem
		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		SELECT cursor_4c_Etiquetas
		loc_nTotal    = 0
		loc_nQtdTotal = 0
		SCAN FOR !EMPTY(cursor_4c_Etiquetas.Cpros)
			loc_nTotal    = loc_nTotal + 1
			loc_nQtdTotal = loc_nQtdTotal + NVL(cursor_4c_Etiquetas.Qtds, 0)
		ENDSCAN
		GO TOP
		THIS.grd_4c_Etiquetas.Refresh()
		THIS.grd_4c_Etiquetas.SetFocus()
		loc_cMensagem = "Itens selecionados: " + TRANSFORM(loc_nTotal) + CHR(13) + ;
		                "Quantidade total: " + TRANSFORM(loc_nQtdTotal, "@Z 9,999,999.999")
		MsgInfo(loc_cMensagem, "Resumo da Sele" + CHR(231) + CHR(227) + "o")
	ENDPROC

	*====================================================================
	* BtnExcluirClick - Remove linha selecionada do grid (com confirmacao).
	* Delega para CmdBtnExcluirClick que faz a exclusao efetiva.
	*====================================================================
	PROCEDURE BtnExcluirClick()
		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
			MsgAviso("Nenhum item para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		SELECT cursor_4c_Etiquetas
		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
			MsgAviso("Selecione um item v" + CHR(225) + "lido para excluir.", ;
			         "Aten" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do item selecionado?", ;
		                "Confirma" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		THIS.CmdBtnExcluirClick()
	ENDPROC

	*====================================================================
	* BtnImprimirClick - Coleta parametros dos controles e chama BO
	*====================================================================
	PROCEDURE BtnImprimirClick()
		IF !USED("cursor_4c_Etiquetas")
			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
			RETURN
		ENDIF
		SELECT cursor_4c_Etiquetas
		LOCATE FOR EMPTY(cursor_4c_Etiquetas.Cpros)
		IF FOUND()
			DELETE
			PACK
		ENDIF
		IF RECCOUNT("cursor_4c_Etiquetas") = 0
			MsgAviso("Nenhum produto adicionado para impress" + CHR(227) + "o.", ;
			         "Aten" + CHR(231) + CHR(227) + "o")
			APPEND BLANK
			RETURN
		ENDIF
		GO TOP

		*-- Coleta parametros dos controles de configuracao
		LOCAL loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo
		LOCAL loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs
		LOCAL loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, loc_nOrdem
		LOCAL loc_cLp1, loc_cLp2

		*-- Defaults do BO
		loc_nImpPreco = 1
		loc_lImpSepar = .T.
		loc_lImpPeso  = .T.
		loc_lCompo    = .T.
		loc_nTpEti    = 1
		loc_nTpImp    = 1
		loc_nAjVerts  = 0
		loc_nAjHorzs  = 0
		loc_nAjDenss  = 20
		loc_nAjVelos  = 3
		loc_cNomeImp  = ""
		loc_nOrdem    = 1
		loc_cLp1      = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,  ""))
		loc_cLp2      = ALLTRIM(NVL(THIS.txt_4c_LPreco2.Value, ""))

		*-- Tipo de etiqueta (obj_4c_Opt_Tipo)
		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
			loc_nTpEti = NVL(THIS.obj_4c_Opt_Tipo.Value, 1)
		ENDIF

		*-- Configuracoes da impressora (cnt_4c_Impressora)
		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
			*-- Tipo impressora (OptionGroup OpcaoImp)
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5) AND ;
			   VARTYPE(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp) = "O"
				loc_nTpImp = NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
			ENDIF
			*-- Ajustes (spinners)
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5) AND ;
			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjVerts) = "O"
				loc_nAjVerts = NVL(THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value, 0)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5) AND ;
			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjHorzs) = "O"
				loc_nAjHorzs = NVL(THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value, 0)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5) AND ;
			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjDenss) = "O"
				loc_nAjDenss = NVL(THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value, 20)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5) AND ;
			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjVelos) = "O"
				loc_nAjVelos = NVL(THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value, 3)
			ENDIF
		ENDIF

		*-- Nome da impressora (cbo_4c_GetPrinter)
		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
			loc_cNomeImp = ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
		ENDIF

		*-- Opcoes de impressao da Fase 6 (opt_separador, opt_Preco, opt_peso, optCompos, OptOrdem)
		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
			loc_lImpSepar = (THIS.obj_4c_OptSeparador.Value = 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
			loc_nImpPreco = NVL(THIS.obj_4c_OptPreco.Value, 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptPeso", 5) AND VARTYPE(THIS.obj_4c_OptPeso) = "O"
			loc_lImpPeso = (THIS.obj_4c_OptPeso.Value = 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptCompos", 5) AND VARTYPE(THIS.obj_4c_OptCompos) = "O"
			loc_lCompo = (THIS.obj_4c_OptCompos.Value = 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptOrdem", 5) AND VARTYPE(THIS.obj_4c_OptOrdem) = "O"
			loc_nOrdem = NVL(THIS.obj_4c_OptOrdem.Value, 1)
		ENDIF

		IF VARTYPE(THIS.this_oBusinessObject) = "O"
			THIS.this_oBusinessObject.PrepararImpressao( ;
				loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo, ;
				loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, ;
				loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, loc_nOrdem, ;
				loc_cLp1, loc_cLp2)
		ENDIF

		SELECT cursor_4c_Etiquetas
		IF RECCOUNT("cursor_4c_Etiquetas") = 0 OR !EMPTY(cursor_4c_Etiquetas.Cpros)
			APPEND BLANK
		ENDIF
		THIS.grd_4c_Etiquetas.Refresh()
	ENDPROC

	*====================================================================
	* BtnEncerrarClick - Fecha o formulario
	*====================================================================
	PROCEDURE BtnEncerrarClick()
		THIS.Release()
	ENDPROC

	*====================================================================
	* ConfigurarPaginaDados - Secao inferior: tipo etiqueta e impressora
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaDados()

		*-- Label titulo secao (sobre o grid)
		THIS.AddObject("lbl_4c_LblTituloGrd", "Label")
		WITH THIS.lbl_4c_LblTituloGrd
			.AutoSize  = .F.
			.Caption   = " \<Etiquetas Selecionadas "
			.Top       = 375
			.Left      = 10
			.Width     = 210
			.Height    = 15
			.FontBold  = .T.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- Label "Tipo de Etiqueta"
		THIS.AddObject("lbl_4c_TipoEtq", "Label")
		WITH THIS.lbl_4c_TipoEtq
			.AutoSize  = .F.
			.FontBold  = .T.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = " Tipo de Etiqueta "
			.Height    = 15
			.Left      = 23
			.Top       = 415
			.Width     = 110
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- OptionGroup Tipo Etiqueta (1 botao inicial: Rabicho)
		*-- PopularTiposEtiqueta() adiciona botoes dinamicamente via BO.CarregarTiposEtiqueta()
		THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
		WITH THIS.obj_4c_Opt_Tipo
			.ButtonCount   = 1
			.BackStyle     = 0
			.Value         = 1
			.Height        = 182
			.Left          = 13
			.SpecialEffect = 1
			.Top           = 431
			.Width         = 240
			.Themes        = .F.
			WITH .Buttons(1)
				.BackStyle = 0
				.Caption   = "Rabicho"
				.Height    = 16
				.Left      = 9
				.Style     = 0
				.Top       = 10
				.Width     = 197
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH

		*-- Shape3 (borda visual do bloco impressora)
		THIS.AddObject("shp_4c_Shape3", "Shape")
		WITH THIS.shp_4c_Shape3
			.Top           = 431
			.Left          = 260
			.Height        = 106
			.Width         = 254
			.BackStyle     = 0
			.BorderWidth   = 1
			.SpecialEffect = 1
		ENDWITH

		*-- Label "Impressora"
		THIS.AddObject("lbl_4c_LImpressora", "Label")
		WITH THIS.lbl_4c_LImpressora
			.AutoSize  = .F.
			.FontBold  = .T.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = " Impressora "
			.Height    = 15
			.Left      = 271
			.Top       = 415
			.Width     = 80
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- Opt_Impressora (legado - Visible=.F., mantido por compatibilidade)
		THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
		WITH THIS.obj_4c_Opt_Impressora
			.ButtonCount   = 1
			.BackStyle     = 0
			.Value         = 1
			.Height        = 47
			.Left          = 260
			.SpecialEffect = 1
			.Top           = 431
			.Width         = 254
			.Themes        = .F.
			.Visible       = .F.
			WITH .Buttons(1)
				.BackStyle = 0
				.Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
				.Height    = 16
				.Left      = 9
				.Style     = 0
				.Top       = 52
				.Width     = 210
				.ForeColor = RGB(36, 84, 155)
			ENDWITH
		ENDWITH

		*-- Label "Sistema" (impressora sistema)
		THIS.AddObject("lbl_4c_LSistema", "Label")
		WITH THIS.lbl_4c_LSistema
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "Sistema"
			.Height    = 15
			.Left      = 270
			.Top       = 437
			.Width     = 55
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- Label "Windows" (impressora Windows)
		THIS.AddObject("lbl_4c_LWindows", "Label")
		WITH THIS.lbl_4c_LWindows
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "Windows"
			.Height    = 15
			.Left      = 383
			.Top       = 437
			.Width     = 60
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- ComboBox lista de impressoras (Get_Printer)
		THIS.AddObject("cbo_4c_GetPrinter", "ComboBox")
		WITH THIS.cbo_4c_GetPrinter
			.FontName      = "Tahoma"
			.FontSize      = 8
			.RowSourceType = 0
			.RowSource     = ""
			.BoundColumn   = 1
			.BoundTo       = .F.
			.Height        = 23
			.Left          = 268
			.SpecialEffect = 1
			.Style         = 2
			.Top           = 453
			.Width         = 239
		ENDWITH

		*-- Container ajustes impressora (Cnt_Impressora)
		THIS.AddObject("cnt_4c_Impressora", "Container")
		WITH THIS.cnt_4c_Impressora
			.Top         = 539
			.Left        = 260
			.Width       = 254
			.Height      = 80
			.BackStyle   = 0
			.BorderWidth = 0

			*-- OptionGroup tipo impressora: 1=Allegro 2=Zebra ZPL 3=Zebra EPL
			.AddObject("obj_4c_OpcaoImp", "OptionGroup")
			WITH .obj_4c_OpcaoImp
				.ButtonCount = 3
				.Height      = 24
				.Left        = 5
				.Top         = 3
				.Width       = 241
				WITH .Buttons(1)
					.Caption   = "Allegro"
					.Left      = 2
					.Top       = 4
					.Width     = 51
					.AutoSize  = .F.
					.ForeColor = RGB(90, 90, 90)
					.BackStyle = 0
				ENDWITH
				WITH .Buttons(2)
					.Caption   = "Zebra ZPL"
					.Left      = 75
					.Top       = 4
					.Width     = 70
					.AutoSize  = .F.
					.FontName  = "Tahoma"
					.FontSize  = 8
					.ForeColor = RGB(90, 90, 90)
					.BackStyle = 0
				ENDWITH
				WITH .Buttons(3)
					.Caption   = "Zebra EPL"
					.Left      = 164
					.Top       = 4
					.Width     = 70
					.AutoSize  = .F.
					.Height    = 15
					.FontName  = "Tahoma"
					.FontSize  = 8
					.BackStyle = 0
					.ForeColor = RGB(90, 90, 90)
				ENDWITH
			ENDWITH

			*-- Labels ajuste
			.AddObject("lbl_4c_SAjVerts", "Label")
			WITH .lbl_4c_SAjVerts
				.AutoSize  = .F.
				.Caption   = "Vertical"
				.Left      = 5
				.Top       = 32
				.Width     = 55
				.Height    = 15
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.ForeColor = RGB(90, 90, 90)
			ENDWITH

			.AddObject("lbl_4c_SAjHorzs", "Label")
			WITH .lbl_4c_SAjHorzs
				.AutoSize  = .F.
				.Caption   = "Horizontal"
				.Left      = 70
				.Top       = 32
				.Width     = 62
				.Height    = 15
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.ForeColor = RGB(90, 90, 90)
			ENDWITH

			.AddObject("lbl_4c_SAjDenss", "Label")
			WITH .lbl_4c_SAjDenss
				.AutoSize  = .F.
				.Caption   = "Densidade"
				.Left      = 140
				.Top       = 32
				.Width     = 60
				.Height    = 15
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.ForeColor = RGB(90, 90, 90)
			ENDWITH

			.AddObject("lbl_4c_SAjVelos", "Label")
			WITH .lbl_4c_SAjVelos
				.AutoSize  = .F.
				.Caption   = "Velocidade"
				.Left      = 205
				.Top       = 32
				.Width     = 65
				.Height    = 15
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.ForeColor = RGB(90, 90, 90)
			ENDWITH

			*-- Spinners ajuste impressora
			.AddObject("spn_4c_AjVerts", "Spinner")
			WITH .spn_4c_AjVerts
				.SpinnerLowValue  = 0
				.SpinnerHighValue = 999
				.Value            = 0
				.Increment        = 1
				.FontName         = "Tahoma"
				.FontSize         = 8
				.Left             = 5
				.Top              = 50
				.Width            = 57
				.Height           = 22
				.SpecialEffect    = 1
			ENDWITH

			.AddObject("spn_4c_AjHorzs", "Spinner")
			WITH .spn_4c_AjHorzs
				.SpinnerLowValue  = -999
				.SpinnerHighValue = 999
				.Value            = 0
				.Increment        = 1
				.FontName         = "Tahoma"
				.FontSize         = 8
				.Left             = 70
				.Top              = 50
				.Width            = 57
				.Height           = 22
				.SpecialEffect    = 1
			ENDWITH

			.AddObject("spn_4c_AjDenss", "Spinner")
			WITH .spn_4c_AjDenss
				.SpinnerLowValue  = 1
				.SpinnerHighValue = 20
				.Value            = 20
				.Increment        = 1
				.FontName         = "Tahoma"
				.FontSize         = 8
				.Left             = 140
				.Top              = 50
				.Width            = 57
				.Height           = 22
				.SpecialEffect    = 1
			ENDWITH

			.AddObject("spn_4c_AjVelos", "Spinner")
			WITH .spn_4c_AjVelos
				.SpinnerLowValue  = 1
				.SpinnerHighValue = 3
				.Value            = 3
				.Increment        = 1
				.FontName         = "Tahoma"
				.FontSize         = 8
				.Left             = 205
				.Top              = 50
				.Width            = 45
				.Height           = 22
				.SpecialEffect    = 1
			ENDWITH
		ENDWITH

		*-- Label "Separadora"
		THIS.AddObject("lbl_4c_LblSeparador", "Label")
		WITH THIS.lbl_4c_LblSeparador
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "Separadora :"
			.Height    = 15
			.Left      = 532
			.Top       = 417
			.Width     = 65
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- OptionGroup Separadora (opt_separador): 1=Sim 2=Nao
		THIS.AddObject("obj_4c_OptSeparador", "OptionGroup")
		WITH THIS.obj_4c_OptSeparador
			.ButtonCount   = 2
			.BackStyle     = 0
			.Value         = 1
			.Height        = 25
			.Left          = 601
			.SpecialEffect = 1
			.Top           = 412
			.Width         = 198
			.Themes        = .F.
			WITH .Buttons(1)
				.BackStyle = 0
				.Caption   = "Sim"
				.Height    = 15
				.Left      = 5
				.Top       = 5
				.Width     = 34
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(2)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "N" + CHR(227) + "o"
				.Height    = 15
				.Left      = 70
				.Top       = 5
				.Width     = 37
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH

		*-- Label "Preco"
		THIS.AddObject("lbl_4c_LblPreco", "Label")
		WITH THIS.lbl_4c_LblPreco
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "Pre" + CHR(231) + "o :"
			.Height    = 15
			.Left      = 561
			.Top       = 440
			.Width     = 36
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- OptionGroup Preco (opt_Preco): 1=Sim 2=Nao 3=Ideal 4=Atual 5=PrecoDe/Por 6=Parcelamento
		THIS.AddObject("obj_4c_OptPreco", "OptionGroup")
		WITH THIS.obj_4c_OptPreco
			.ButtonCount   = 6
			.BackStyle     = 0
			.Value         = 1
			.Height        = 95
			.Left          = 601
			.SpecialEffect = 1
			.Top           = 439
			.Width         = 198
			.Themes        = .F.
			WITH .Buttons(1)
				.BackStyle = 0
				.Caption   = "Sim"
				.Height    = 15
				.Left      = 8
				.Top       = 7
				.Width     = 34
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(2)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "N" + CHR(227) + "o"
				.Height    = 15
				.Left      = 61
				.Top       = 7
				.Width     = 37
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(3)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "Ideal"
				.Height    = 15
				.Left      = 8
				.Top       = 28
				.Width     = 42
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(4)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "Atual"
				.Height    = 15
				.Left      = 61
				.Top       = 28
				.Width     = 43
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(5)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "Pre" + CHR(231) + "o DE \ Por"
				.Height    = 15
				.Left      = 8
				.Top       = 51
				.Width     = 87
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(6)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "Parcelamento"
				.Height    = 15
				.Left      = 8
				.Top       = 73
				.Width     = 83
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH

		*-- Label "Peso"
		THIS.AddObject("lbl_4c_LblPeso", "Label")
		WITH THIS.lbl_4c_LblPeso
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "Peso :"
			.Height    = 15
			.Left      = 565
			.Top       = 540
			.Width     = 32
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- OptionGroup Peso (opt_peso): 1=Sim 2=Nao
		THIS.AddObject("obj_4c_OptPeso", "OptionGroup")
		WITH THIS.obj_4c_OptPeso
			.ButtonCount   = 2
			.BackStyle     = 0
			.Value         = 1
			.Height        = 25
			.Left          = 601
			.SpecialEffect = 1
			.Top           = 535
			.Width         = 198
			.Themes        = .F.
			WITH .Buttons(1)
				.BackStyle = 0
				.Caption   = "Sim"
				.Height    = 15
				.Left      = 5
				.Top       = 5
				.Width     = 41
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(2)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "N" + CHR(227) + "o"
				.Height    = 15
				.Left      = 70
				.Top       = 5
				.Width     = 41
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH

		*-- Label "Composicao"
		THIS.AddObject("lbl_4c_LblCompos", "Label")
		WITH THIS.lbl_4c_LblCompos
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
			.Height    = 15
			.Left      = 531
			.Top       = 567
			.Width     = 70
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- OptionGroup Composicao (optCompos): 1=Sim 2=Nao
		THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
		WITH THIS.obj_4c_OptCompos
			.ButtonCount   = 2
			.BackStyle     = 0
			.Value         = 1
			.Height        = 25
			.Left          = 601
			.SpecialEffect = 1
			.Top           = 562
			.Width         = 198
			.Themes        = .F.
			WITH .Buttons(1)
				.BackStyle = 0
				.Caption   = "Sim"
				.Height    = 15
				.Left      = 5
				.Top       = 5
				.Width     = 41
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(2)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "N" + CHR(227) + "o"
				.Height    = 15
				.Left      = 70
				.Top       = 5
				.Width     = 41
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH

		*-- Label "Ordem"
		THIS.AddObject("lbl_4c_LblOrdem", "Label")
		WITH THIS.lbl_4c_LblOrdem
			.AutoSize  = .F.
			.FontName  = "Tahoma"
			.FontSize  = 8
			.BackStyle = 0
			.Caption   = "Ordem :"
			.Height    = 15
			.Left      = 556
			.Top       = 594
			.Width     = 41
			.ForeColor = RGB(90, 90, 90)
		ENDWITH

		*-- OptionGroup Ordem (OptOrdem): 1=Produto 2=Nenhuma
		THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
		WITH THIS.obj_4c_OptOrdem
			.ButtonCount   = 2
			.BackStyle     = 0
			.Value         = 1
			.Height        = 25
			.Left          = 601
			.SpecialEffect = 1
			.Top           = 589
			.Width         = 198
			.Themes        = .F.
			WITH .Buttons(1)
				.BackStyle = 0
				.Caption   = "Produto"
				.Height    = 15
				.Left      = 5
				.Top       = 4
				.Width     = 56
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(2)
				.FontName  = "Tahoma"
				.FontSize  = 8
				.BackStyle = 0
				.Caption   = "Nenhuma"
				.Height    = 15
				.Left      = 70
				.Top       = 4
				.Width     = 63
				.AutoSize  = .F.
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH

		*-- BINDEVENTs (handlers sao PUBLIC - obrigatorio para BINDEVENT)
		BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "ObjOptTipoChange")
		BINDEVENT(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp, "InteractiveChange", THIS, "ObjOpcaoImpChange")
		BINDEVENT(THIS.cbo_4c_GetPrinter, "InteractiveChange", THIS, "CboGetPrinterChange")
	ENDPROC

	*====================================================================
	* PopularTiposEtiqueta - Adiciona botoes ao obj_4c_Opt_Tipo via BO
	*====================================================================
	PROTECTED PROCEDURE PopularTiposEtiqueta()
		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF
		IF !PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) OR VARTYPE(THIS.obj_4c_Opt_Tipo) != "O"
			RETURN
		ENDIF
		THIS.this_oBusinessObject.CarregarTiposEtiqueta()
		IF !USED("cursor_4c_TiposEtq")
			RETURN
		ENDIF
		SELECT cursor_4c_TiposEtq
		LOCAL loc_nCount, loc_nTopo, loc_i, loc_cCaption
		loc_nCount = RECCOUNT("cursor_4c_TiposEtq")
		IF loc_nCount = 0
			RETURN
		ENDIF
		*-- Adiciona botoes conforme tipos retornados pelo BO (1 por linha)
		WITH THIS.obj_4c_Opt_Tipo
			.ButtonCount = loc_nCount
			loc_nTopo    = 10
			GO TOP IN cursor_4c_TiposEtq
			FOR loc_i = 1 TO loc_nCount
				SELECT cursor_4c_TiposEtq
				loc_cCaption = ALLTRIM(NVL(cursor_4c_TiposEtq.cEtiquetas, "Tipo " + TRANSFORM(loc_i)))
				WITH .Buttons(loc_i)
					.BackStyle = 0
					.Caption   = loc_cCaption
					.Tag       = TRANSFORM(NVL(cursor_4c_TiposEtq.nTipos, loc_i))
					.Height    = 16
					.Left      = 9
					.Style     = 0
					.Top       = loc_nTopo
					.Width     = 197
					.ForeColor = RGB(90, 90, 90)
				ENDWITH
				loc_nTopo = loc_nTopo + 18
				SKIP IN cursor_4c_TiposEtq
			ENDFOR
			.Height = loc_nTopo + 10
		ENDWITH
		USE IN cursor_4c_TiposEtq
	ENDPROC

	*====================================================================
	* AplicarConfiguracoes - Carrega impressoras e preenche controles
	*====================================================================
	PROTECTED PROCEDURE AplicarConfiguracoes()
		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF
		*-- Carrega lista de impressoras no ComboBox
		THIS.this_oBusinessObject.CarregarImpressoras()
		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
			THIS.cbo_4c_GetPrinter.RowSourceType = 2
			THIS.cbo_4c_GetPrinter.RowSource     = "cursor_4c_SigCdmp"
			IF USED("cursor_4c_SigCdmp") AND RECCOUNT("cursor_4c_SigCdmp") > 0
				THIS.cbo_4c_GetPrinter.Requery()
			ENDIF
			*-- Seleciona impressora padrao do BO
			IF !EMPTY(THIS.this_oBusinessObject.this_cNomeImp)
				THIS.cbo_4c_GetPrinter.Value = ALLTRIM(THIS.this_oBusinessObject.this_cNomeImp)
			ENDIF
		ENDIF
		*-- Preenche spinners com valores das configuracoes lidas pelo BO
		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
				THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
				THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
				THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
				THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
			ENDIF
			*-- Tipo de impressora
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5) AND ;
			   VARTYPE(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp) = "O"
				THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value = THIS.this_oBusinessObject.this_nTpImp
			ENDIF
		ENDIF
		*-- Tipo de etiqueta padrao
		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
			THIS.obj_4c_Opt_Tipo.Value = THIS.this_oBusinessObject.this_nTpEtiPadrao
		ENDIF
		*-- Separadora padrao (EtqSeps de SigCdPac, carregado em CarregarConfiguracoes)
		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
			THIS.obj_4c_OptSeparador.Value = IIF(THIS.this_oBusinessObject.this_lImpSepar, 1, 2)
		ENDIF
	ENDPROC

	*====================================================================
	* ObjOptTipoChange - Atualiza tipo etiqueta no BO (PUBLIC p/ BINDEVENT)
	*====================================================================
	PROCEDURE ObjOptTipoChange()
		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF
		IF !PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) OR VARTYPE(THIS.obj_4c_Opt_Tipo) != "O"
			RETURN
		ENDIF
		LOCAL loc_nSel, loc_cTag
		loc_nSel = THIS.obj_4c_Opt_Tipo.Value
		IF loc_nSel >= 1 AND loc_nSel <= THIS.obj_4c_Opt_Tipo.ButtonCount
			loc_cTag = ALLTRIM(NVL(THIS.obj_4c_Opt_Tipo.Buttons(loc_nSel).Tag, ""))
			IF !EMPTY(loc_cTag) AND VAL(loc_cTag) > 0
				THIS.this_oBusinessObject.this_nTpEti = VAL(loc_cTag)
			ELSE
				THIS.this_oBusinessObject.this_nTpEti = loc_nSel
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* ObjOpcaoImpChange - Atualiza tipo impressora no BO (PUBLIC p/ BINDEVENT)
	*====================================================================
	PROCEDURE ObjOpcaoImpChange()
		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF
		IF !PEMSTATUS(THIS, "cnt_4c_Impressora", 5)
			RETURN
		ENDIF
		IF !PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
			RETURN
		ENDIF
		THIS.this_oBusinessObject.this_nTpImp = ;
			NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
	ENDPROC

	*====================================================================
	* CboGetPrinterChange - Atualiza impressora no BO (PUBLIC p/ BINDEVENT)
	*====================================================================
	PROCEDURE CboGetPrinterChange()
		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF
		IF !PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) OR VARTYPE(THIS.cbo_4c_GetPrinter) != "O"
			RETURN
		ENDIF
		THIS.this_oBusinessObject.this_cNomeImp = ;
			ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
	ENDPROC

	*====================================================================
	* TxtNumesKeyPress - Valida numero do documento (PUBLIC p/ BINDEVENT)
	*====================================================================
	PROCEDURE TxtNumesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
			RETURN
		ENDIF
		IF !PEMSTATUS(THIS, "txt_4c_Numes", 5) OR VARTYPE(THIS.txt_4c_Numes) != "O"
			RETURN
		ENDIF
		LOCAL loc_nNumes
		loc_nNumes = NVL(THIS.txt_4c_Numes.Value, 0)
		IF loc_nNumes <= 0
			MsgAviso("Informe o n" + CHR(250) + "mero do documento.", ;
			         "Aten" + CHR(231) + CHR(227) + "o")
			THIS.txt_4c_Numes.SetFocus()
			RETURN
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
			THIS.txt_4c_Lpreco.SetFocus()
		ENDIF
	ENDPROC

	*====================================================================
	* ChkListaClick - Valida preenchimento da lista de precos (PUBLIC p/ BINDEVENT)
	*====================================================================
	PROCEDURE ChkListaClick()
		IF !PEMSTATUS(THIS, "chk_4c_Lista", 5) OR VARTYPE(THIS.chk_4c_Lista) != "O"
			RETURN
		ENDIF
		IF THIS.chk_4c_Lista.Value != 1
			RETURN
		ENDIF
		IF !PEMSTATUS(THIS, "txt_4c_Lpreco", 5) OR VARTYPE(THIS.txt_4c_Lpreco) != "O"
			RETURN
		ENDIF
		IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, "")))
			MsgAviso("Informe a lista de pre" + CHR(231) + "os para usar este filtro.", ;
			         "Aten" + CHR(231) + CHR(227) + "o")
			THIS.txt_4c_Lpreco.SetFocus()
		ENDIF
	ENDPROC

	*====================================================================
	* ChkPrecioClick - Recarrega precos ao ativar filtro (PUBLIC p/ BINDEVENT)
	*====================================================================
	PROCEDURE ChkPrecioClick()
		IF !PEMSTATUS(THIS, "chk_4c_Precio", 5) OR VARTYPE(THIS.chk_4c_Precio) != "O"
			RETURN
		ENDIF
		IF THIS.chk_4c_Precio.Value = 1
			THIS.AtualizarPrecoPorLista()
		ENDIF
	ENDPROC

	*====================================================================
	* FormParaBO - Copia todos os campos do form para o BO
	*====================================================================
	PROCEDURE FormParaBO()
		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF
		THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(NVL(THIS.txt_4c_Emps.Value,  ""))
		THIS.this_oBusinessObject.this_cDopes = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
			THIS.this_oBusinessObject.this_nNumes = NVL(THIS.txt_4c_Numes.Value, 0)
		ENDIF
		THIS.this_oBusinessObject.this_cLpreco  = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,  ""))
		THIS.this_oBusinessObject.this_cLpreco2 = ALLTRIM(NVL(THIS.txt_4c_LPreco2.Value, ""))
		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
			THIS.this_oBusinessObject.this_nTpEti = NVL(THIS.obj_4c_Opt_Tipo.Value, 1)
		ENDIF
		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
				THIS.this_oBusinessObject.this_nTpImp = ;
					NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
				THIS.this_oBusinessObject.this_nAjVerts = ;
					NVL(THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value, 0)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
				THIS.this_oBusinessObject.this_nAjHorzs = ;
					NVL(THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value, 0)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
				THIS.this_oBusinessObject.this_nAjDenss = ;
					NVL(THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value, 0)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
				THIS.this_oBusinessObject.this_nAjVelos = ;
					NVL(THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value, 0)
			ENDIF
		ENDIF
		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
			THIS.this_oBusinessObject.this_cNomeImp = ;
				ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
			THIS.this_oBusinessObject.this_nImpPreco = NVL(THIS.obj_4c_OptPreco.Value, 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
			THIS.this_oBusinessObject.this_lImpSepar = ;
				(NVL(THIS.obj_4c_OptSeparador.Value, 1) = 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptPeso", 5) AND VARTYPE(THIS.obj_4c_OptPeso) = "O"
			THIS.this_oBusinessObject.this_lImpPeso = ;
				(NVL(THIS.obj_4c_OptPeso.Value, 1) = 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptCompos", 5) AND VARTYPE(THIS.obj_4c_OptCompos) = "O"
			THIS.this_oBusinessObject.this_lCompo = ;
				(NVL(THIS.obj_4c_OptCompos.Value, 1) = 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptOrdem", 5) AND VARTYPE(THIS.obj_4c_OptOrdem) = "O"
			THIS.this_oBusinessObject.this_nOrdem = NVL(THIS.obj_4c_OptOrdem.Value, 1)
		ENDIF
	ENDPROC

	*====================================================================
	* BOParaForm - Aplica propriedades do BO nos controles do form
	*====================================================================
	PROCEDURE BOParaForm()
		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF
		THIS.txt_4c_Emps.Value  = NVL(THIS.this_oBusinessObject.this_cEmps,  "")
		THIS.txt_4c_Dopes.Value = NVL(THIS.this_oBusinessObject.this_cDopes, "")
		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
			THIS.txt_4c_Numes.Value = NVL(THIS.this_oBusinessObject.this_nNumes, 0)
		ENDIF
		THIS.txt_4c_Lpreco.Value  = NVL(THIS.this_oBusinessObject.this_cLpreco,  "")
		THIS.txt_4c_LPreco2.Value = NVL(THIS.this_oBusinessObject.this_cLpreco2, "")
		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
			THIS.obj_4c_Opt_Tipo.Value = NVL(THIS.this_oBusinessObject.this_nTpEti, 1)
		ENDIF
		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
				THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value = ;
					NVL(THIS.this_oBusinessObject.this_nTpImp, 1)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
				THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value = ;
					NVL(THIS.this_oBusinessObject.this_nAjVerts, 0)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
				THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value = ;
					NVL(THIS.this_oBusinessObject.this_nAjHorzs, 0)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
				THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value = ;
					NVL(THIS.this_oBusinessObject.this_nAjDenss, 20)
			ENDIF
			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
				THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value = ;
					NVL(THIS.this_oBusinessObject.this_nAjVelos, 3)
			ENDIF
		ENDIF
		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
			THIS.cbo_4c_GetPrinter.Value = NVL(THIS.this_oBusinessObject.this_cNomeImp, "")
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
			THIS.obj_4c_OptPreco.Value = NVL(THIS.this_oBusinessObject.this_nImpPreco, 1)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
			THIS.obj_4c_OptSeparador.Value = ;
				IIF(THIS.this_oBusinessObject.this_lImpSepar, 1, 2)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptPeso", 5) AND VARTYPE(THIS.obj_4c_OptPeso) = "O"
			THIS.obj_4c_OptPeso.Value = ;
				IIF(THIS.this_oBusinessObject.this_lImpPeso, 1, 2)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptCompos", 5) AND VARTYPE(THIS.obj_4c_OptCompos) = "O"
			THIS.obj_4c_OptCompos.Value = ;
				IIF(THIS.this_oBusinessObject.this_lCompo, 1, 2)
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptOrdem", 5) AND VARTYPE(THIS.obj_4c_OptOrdem) = "O"
			THIS.obj_4c_OptOrdem.Value = NVL(THIS.this_oBusinessObject.this_nOrdem, 1)
		ENDIF
	ENDPROC

	*====================================================================
	* HabilitarCampos - Habilita ou desabilita controles de entrada
	*====================================================================
	PROCEDURE HabilitarCampos(par_lHabilitar)
		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
			THIS.txt_4c_Emps.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Dopes", 5) AND VARTYPE(THIS.txt_4c_Dopes) = "O"
			THIS.txt_4c_Dopes.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
			THIS.txt_4c_Numes.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
			THIS.txt_4c_Lpreco.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5) AND VARTYPE(THIS.txt_4c_LPreco2) = "O"
			THIS.txt_4c_LPreco2.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "chk_4c_Lista", 5) AND VARTYPE(THIS.chk_4c_Lista) = "O"
			THIS.chk_4c_Lista.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "chk_4c_Precio", 5) AND VARTYPE(THIS.chk_4c_Precio) = "O"
			THIS.chk_4c_Precio.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
			THIS.obj_4c_OptPreco.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
			THIS.obj_4c_OptSeparador.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptPeso", 5) AND VARTYPE(THIS.obj_4c_OptPeso) = "O"
			THIS.obj_4c_OptPeso.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptCompos", 5) AND VARTYPE(THIS.obj_4c_OptCompos) = "O"
			THIS.obj_4c_OptCompos.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_OptOrdem", 5) AND VARTYPE(THIS.obj_4c_OptOrdem) = "O"
			THIS.obj_4c_OptOrdem.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
			THIS.obj_4c_Opt_Tipo.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
			THIS.cnt_4c_Impressora.Enabled = par_lHabilitar
		ENDIF
		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
			THIS.cbo_4c_GetPrinter.Enabled = par_lHabilitar
		ENDIF
	ENDPROC

	*====================================================================
	* LimparCampos - Reseta filtros e zera a lista de etiquetas
	*====================================================================
	PROCEDURE LimparCampos()
		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
			THIS.txt_4c_Emps.Value = ""
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Dopes", 5) AND VARTYPE(THIS.txt_4c_Dopes) = "O"
			THIS.txt_4c_Dopes.Value = ""
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
			THIS.txt_4c_Numes.Value = 0
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
			THIS.txt_4c_Lpreco.Value = ""
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5) AND VARTYPE(THIS.txt_4c_LPreco2) = "O"
			THIS.txt_4c_LPreco2.Value = ""
		ENDIF
		IF PEMSTATUS(THIS, "lbl_4c_DEmps", 5) AND VARTYPE(THIS.lbl_4c_DEmps) = "O"
			THIS.lbl_4c_DEmps.Caption = ""
		ENDIF
		IF PEMSTATUS(THIS, "chk_4c_Lista", 5) AND VARTYPE(THIS.chk_4c_Lista) = "O"
			THIS.chk_4c_Lista.Value = 0
		ENDIF
		IF PEMSTATUS(THIS, "chk_4c_Precio", 5) AND VARTYPE(THIS.chk_4c_Precio) = "O"
			THIS.chk_4c_Precio.Value = 0
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Cpros", 5) AND VARTYPE(THIS.txt_4c_Cpros) = "O"
			THIS.txt_4c_Cpros.Value = ""
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Dpros", 5) AND VARTYPE(THIS.txt_4c_Dpros) = "O"
			THIS.txt_4c_Dpros.Value = ""
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Qtds", 5) AND VARTYPE(THIS.txt_4c_Qtds) = "O"
			THIS.txt_4c_Qtds.Value = 0
		ENDIF
		IF USED("cursor_4c_Etiquetas")
			SELECT cursor_4c_Etiquetas
			ZAP
			APPEND BLANK
			GO TOP
		ENDIF
		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"
			THIS.grd_4c_Etiquetas.Refresh()
		ENDIF
		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
			THIS.txt_4c_Emps.SetFocus()
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarLista - Reposiciona no topo e atualiza grid (OPERACIONAL)
	*====================================================================
	PROCEDURE CarregarLista()
		IF !USED("cursor_4c_Etiquetas")
			RETURN
		ENDIF
		SELECT cursor_4c_Etiquetas
		GO TOP
		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"
			THIS.grd_4c_Etiquetas.Refresh()
		ENDIF
	ENDPROC

	*====================================================================
	* AjustarBotoesPorModo - Stub (OPERACIONAL nao tem modos CRUD)
	*====================================================================
	PROCEDURE AjustarBotoesPorModo()
		RETURN
	ENDPROC

	*====================================================================
	* BtnBuscarClick - Carrega itens da lista por empresa/operacao/numes
	*====================================================================
	PROCEDURE BtnBuscarClick()
		THIS.CarregarItensDaLista()
	ENDPROC

	*====================================================================
	* BtnSalvarClick - Equivale a imprimir no contexto OPERACIONAL
	*====================================================================
	PROCEDURE BtnSalvarClick()
		THIS.BtnImprimirClick()
	ENDPROC

	*====================================================================
	* BtnCancelarClick - Limpa campos e zera lista (OPERACIONAL)
	*====================================================================
	PROCEDURE BtnCancelarClick()
		THIS.LimparCampos()
	ENDPROC

ENDDEFINE
