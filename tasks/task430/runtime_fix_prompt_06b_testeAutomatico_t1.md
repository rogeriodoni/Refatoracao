# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[06/08/2026 05:29:03 AM] Erro: Erro em: FormFpr.InicializarForm | Linha: 345 | Alias 'CURSOR_4C_DADOS' is not found. | Detalhes: CURSOR_4C_DADOS | Procedure: configurarpaginalista


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-06 05:28:03] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 05:28:03] [INFO] Config FPW: (nao fornecido)
[2026-08-06 05:28:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 05:28:03] [INFO] Timeout: 300 segundos
[2026-08-06 05:28:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y22xwsrr.prg
[2026-08-06 05:28:03] [INFO] Conteudo do wrapper:
[2026-08-06 05:28:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpr', 'C:\4c\tasks\task430', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpr', 'C:\4c\tasks\task430', 'CRUD'
QUIT

[2026-08-06 05:28:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y22xwsrr.prg
[2026-08-06 05:28:03] [INFO] VFP output esperado em: C:\4c\tasks\task430\vfp_output.txt
[2026-08-06 05:28:03] [INFO] Executando Visual FoxPro 9...
[2026-08-06 05:28:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y22xwsrr.prg
[2026-08-06 05:28:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y22xwsrr.prg
[2026-08-06 05:28:03] [INFO] Timeout configurado: 300 segundos
[2026-08-06 05:29:03] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 05:29:03] [INFO] VFP9 finalizado em 59.7107358 segundos
[2026-08-06 05:29:03] [INFO] Exit Code: 
[2026-08-06 05:29:03] [INFO] 
[2026-08-06 05:29:03] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 05:29:03] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y22xwsrr.prg
[2026-08-06 05:29:03] [INFO] 
[2026-08-06 05:29:03] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 05:29:03] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 05:29:03] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 05:29:03] [INFO] * Parameters: 'FormFpr', 'C:\4c\tasks\task430', 'CRUD'
[2026-08-06 05:29:03] [INFO] 
[2026-08-06 05:29:03] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 05:29:03] [INFO] SET SAFETY OFF
[2026-08-06 05:29:03] [INFO] SET RESOURCE OFF
[2026-08-06 05:29:03] [INFO] SET TALK OFF
[2026-08-06 05:29:03] [INFO] SET NOTIFY OFF
[2026-08-06 05:29:03] [INFO] SYS(2335, 0)
[2026-08-06 05:29:03] [INFO] 
[2026-08-06 05:29:03] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpr', 'C:\4c\tasks\task430', 'CRUD'
[2026-08-06 05:29:03] [INFO] QUIT
[2026-08-06 05:29:03] [INFO] 
[2026-08-06 05:29:03] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 05:29:03] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFpr",
  "timestamp": "20260806052903",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
  }
}



## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpr.prg):
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
	DataSession = 2

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
			*-- Fix DataSession=2: garantir datas no padr" + CHR(227) + "o brasileiro (Rule 9.4)
			SET DATE TO BRITISH
			SET CENTURY ON

			*-- Criar Business Object
			THIS.this_oBusinessObject = CREATEOBJECT("FprBO")

			IF VARTYPE(THIS.this_oBusinessObject) != "O"
				MostrarErro("Erro ao criar FprBO", "FormFpr.InicializarForm")
			ELSE
				THIS.ConfigurarPageFrame()
				THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
				THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
				THIS.CarregarLista()
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
		loc_oGrid.RecordSource = "cursor_4c_Dados"

		*-- ControlSource IMEDIATAMENTE apos RecordSource (evita auto-bind pela ordem dos campos)
		loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
		loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"

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
			.ControlSource   = "cursor_4c_Dados.Cods"
			.Width           = 60
			.Header1.Caption = "C" + CHR(243) + "digos"
		ENDWITH

		WITH loc_oGrid.Column2
			.ControlSource   = "cursor_4c_Dados.Descs"
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

		IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
			loc_lResultado = .T.
		ELSE
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
		ENDIF

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
	PROTECTED PROCEDURE AlternarPagina(par_nPagina)
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
	PROTECTED PROCEDURE AjustarBotoesPorModo()
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


### BO (C:\4c\projeto\app\classes\FprBO.prg):
*====================================================================
* FprBO.prg
*
* Business Object para Modelos de Produtos
* Tabela: SigCdFip
* Campos: Cods (PK), Descs
*====================================================================

DEFINE CLASS FprBO AS BusinessBase

	*-- Propriedades da entidade
	this_cCods  = ""
	this_cDescs = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdFip"
			THIS.this_cCampoChave = "Cods"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "FprBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCods)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCods  = TratarNulo(Cods,  "C")
				THIS.this_cDescs = TratarNulo(Descs, "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FprBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Regras do original: Cods e Descs nao podem ser vazios nem ter aspas
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(THIS.this_cCods) OR (AT("'", THIS.this_cCods) + AT('"', THIS.this_cCods) > 0)
			MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cCods)
				MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
				loc_lValido = .F.
			ENDIF
		ENDIF

		IF loc_lValido AND (EMPTY(THIS.this_cDescs) OR (AT("'", THIS.this_cDescs) + AT('"', THIS.this_cDescs) > 0))
			MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
			loc_lValido = .F.
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se Cods ja existe em SigCdFip
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdFip" + ;
				" WHERE Cods = " + EscaparSQL(par_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFpr")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFpr")
				SELECT cursor_4c_ChkFpr
				loc_lExiste = (cursor_4c_ChkFpr.qtd > 0)
				USE IN cursor_4c_ChkFpr
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "FprBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdFip
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdFip (Cods, Descs)" + ;
				" VALUES (" + EscaparSQL(THIS.this_cCods) + ", " + EscaparSQL(THIS.this_cDescs) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FprBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdFip
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdFip" + ;
				" SET Descs = " + EscaparSQL(THIS.this_cDescs) + ;
				" WHERE Cods = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FprBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdFip
	* Verifica se produtos usam este modelo (SigCdPro.CodFinP) antes de excluir
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso, loc_cMsg
		loc_lSucesso = .F.
		loc_nUso     = 0
		loc_cMsg     = ""

		TRY
			loc_cSQL = "SELECT CPros, DPros FROM SigCdPro" + ;
				" WHERE CodFinP = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")

			IF loc_nResultado < 0
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
			ELSE
				IF USED("cursor_4c_ChkPro")
					SELECT cursor_4c_ChkPro
					GO TOP IN cursor_4c_ChkPro
					loc_nUso = IIF(!EOF("cursor_4c_ChkPro"), RECCOUNT("cursor_4c_ChkPro"), 0)

					IF loc_nUso > 1
						loc_cMsg = "Existem " + ALLTRIM(STR(loc_nUso)) + " Produtos Utilizando Esse Modelo!!!" + ;
							" Para Excluir o" + CHR(13) + ;
							"Modelo " + CHR(233) + " Necess" + CHR(225) + "rio Alterar o Cadastro de Produtos Primeiro!!!"
						MsgAviso(loc_cMsg)
					ELSE
						IF loc_nUso = 1
							loc_cMsg = "O Produto " + ALLTRIM(cursor_4c_ChkPro.CPros) + " - " + ;
								ALLTRIM(cursor_4c_ChkPro.DPros) + " Est" + CHR(225) + ;
								" Utilizando Esse Modelo!!!" + CHR(13) + ;
								"Para Excluir o Modelo " + CHR(233) + " Necess" + CHR(225) + ;
								"rio Alterar o Cadastro do Produto Primeiro!!!"
							MsgAviso(loc_cMsg)
						ELSE
							USE IN cursor_4c_ChkPro

							loc_cSQL = "DELETE FROM SigCdFip WHERE Cods = " + EscaparSQL(THIS.this_cCods)
							loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
							IF loc_nResultado >= 0
								THIS.RegistrarAuditoria("DELETE")
								loc_lSucesso = .T.
							ELSE
								MostrarErro("Erro ao excluir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							ENDIF
						ENDIF
					ENDIF

					IF USED("cursor_4c_ChkPro")
						USE IN cursor_4c_ChkPro
					ENDIF
				ELSE
					loc_cSQL = "DELETE FROM SigCdFip WHERE Cods = " + EscaparSQL(THIS.this_cCods)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao excluir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FprBO.ExecutarExclusao")
			IF USED("cursor_4c_ChkPro")
				USE IN cursor_4c_ChkPro
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com Cods, Descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (Cods C(5), Descs C(50))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT Cods, Descs FROM SigCdFip"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY Cods"

				IF USED("cursor_4c_Dados")
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
					IF loc_nResultado >= 0
						SELECT cursor_4c_Dados
						ZAP
						SET NULL ON
						APPEND FROM DBF("cursor_4c_DadosTmp")
						SET NULL OFF
						IF USED("cursor_4c_DadosTmp")
							USE IN cursor_4c_DadosTmp
						ENDIF
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar modelos de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ELSE
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
					IF loc_nResultado >= 0
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar modelos de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FprBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (Cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Cods, Descs FROM SigCdFip" + ;
				" WHERE Cods = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Modelo de Produto n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FprBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

