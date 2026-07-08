*====================================================================
* FormSigPrDsc.prg
*
* Formulario de cadastro de SigPrDsc
*
* GERADO AUTOMATICAMENTE - Revisar e completar
*====================================================================

DEFINE CLASS FormSigPrDsc AS FormBase

	*-- Propriedades visuais (COPIAR DO ORIGINAL)
	Height = 600
	Width = 1000
	Caption = ""
	ShowWindow = 1
	WindowType = 1
	
	*-- SEM barra de titulo (padrao frmcadastro)
	ControlBox = .F.
	Closable = .F.
	MaxButton = .F.
	TitleBar = 0
	ClipControls = .F.
	Themes = .F.
	BorderStyle = 2
	
	*-- Propriedades do Form
	this_cTituloForm = ""
	
	*====================================================================
	* Init - APENAS DODEFAULT (FormBase chama InicializarForm)
	*====================================================================
	PROCEDURE Init()
		*-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
		*-- NAO chamar THIS.InicializarForm() novamente aqui!
		RETURN DODEFAULT()
	ENDPROC

	*====================================================================
	* InicializarForm - Inicializa Business Object e componentes
	*====================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lResultado
		loc_lResultado = .F.
		
		TRY
			*-- Cria Business Object
			THIS.this_oBusinessObject = CREATEOBJECT("SigPrDscBO")
			
			*-- Configura componentes
			THIS.ConfigurarPageFrame()
			THIS.ConfigurarPaginaLista()
			THIS.ConfigurarPaginaDados()
			
			*-- Carrega dados iniciais
			IF !gb_4c_ValidandoUI
				THIS.CarregarLista()
			ENDIF
			
			loc_lResultado = .T.
			
		CATCH TO loException
			MostrarErro("Erro ao inicializar: " + loException.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY
		
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ConfigurarPageFrame - Cria e configura PageFrame principal
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPageFrame()
		*-- TODO: Implementar criacao do PageFrame
		*-- Ver FormCor.prg como referencia
		
		*-- PageFrame.Top = -29 para esconder abas
		*-- COMPENSAR +29 pixels em TODOS os controles das Pages
	ENDPROC

	*====================================================================
	* ConfigurarPaginaLista - Configura Page1 (lista/grid)
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaLista()
		*-- TODO: Implementar Grid com 0 colunas
		
		*-- TODO: Implementar botoes CRUD (Incluir, Alterar, Excluir, etc)
		*-- Ver CLAUDE.md secao "Botoes CRUD"
	ENDPROC

	*====================================================================
	* ConfigurarPaginaDados - Configura Page2 (edicao)
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPaginaDados()
		*-- TODO: Implementar 0 campos
		*-- Campos:
		
		*-- TODO: Implementar 3 lookups:
		*--   txt_4c_ ->  (classe: fwbuscaext)
		*--   txt_4c_ ->  (classe: fwbuscaext)
		*--   txt_4c_ ->  (classe: fwbuscaext)
	ENDPROC

	*====================================================================
	* FormParaBO - Transfere dados do Form para Business Object
	*====================================================================
	PROCEDURE FormParaBO()
		WITH THIS.this_oBusinessObject
		ENDWITH
	ENDPROC

	*====================================================================
	* BOParaForm - Transfere dados do Business Object para Form
	*====================================================================
	PROCEDURE BOParaForm()
		WITH THIS.this_oBusinessObject
		ENDWITH
	ENDPROC

	*====================================================================
	* TornarControlesVisiveis - Torna controles do container visiveis
	*====================================================================
	PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
		LOCAL i, loc_oControl
		
		IF VARTYPE(par_oContainer) # 'O'
			RETURN
		ENDIF
		
		FOR i = 1 TO par_oContainer.ControlCount
			loc_oControl = par_oContainer.Controls(i)
			loc_oControl.Visible = .T.
			
			*-- Recursivo para containers aninhados
			IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
				THIS.TornarControlesVisiveis(loc_oControl)
			ENDIF
		ENDFOR
	ENDPROC

	*====================================================================
	* FormatarGridLista - Formata Grid apos carregar dados
	*====================================================================
	PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
		IF VARTYPE(par_oGrid) # 'O'
			RETURN
		ENDIF
		
		par_oGrid.FontName = "Tahoma"
		par_oGrid.FontSize = 8
		par_oGrid.Refresh()
	ENDPROC

ENDDEFINE
