# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 8/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-26 16:11:27] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-26 16:11:27] [INFO] Config FPW: (nao fornecido)
[2026-09-26 16:11:27] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 16:11:27] [INFO] Timeout: 300 segundos
[2026-09-26 16:11:27] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r2c20ngi.prg
[2026-09-26 16:11:27] [INFO] Conteudo do wrapper:
[2026-09-26 16:11:27] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprccp', 'C:\4c\tasks\task587\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprccp', 'C:\4c\tasks\task587\logs\06_testForm.log'
QUIT

[2026-09-26 16:11:27] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r2c20ngi.prg
[2026-09-26 16:11:27] [INFO] VFP output esperado em: C:\4c\tasks\task587\vfp_output.txt
[2026-09-26 16:11:27] [INFO] Executando Visual FoxPro 9...
[2026-09-26 16:11:27] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r2c20ngi.prg
[2026-09-26 16:11:27] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r2c20ngi.prg
[2026-09-26 16:11:27] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprccp
Inicio: 26/09/2026 16:11:27

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 26/09/2026 16:14:44
Duracao: 197 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-26 16:14:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-26 16:14:44] [INFO] VFP9 finalizado em 197.0322011 segundos
[2026-09-26 16:14:44] [INFO] Exit Code: 
[2026-09-26 16:14:44] [INFO] 
[2026-09-26 16:14:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-26 16:14:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r2c20ngi.prg
[2026-09-26 16:14:44] [INFO] 
[2026-09-26 16:14:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-26 16:14:44] [INFO] * Auto-generated wrapper for parameters
[2026-09-26 16:14:44] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 16:14:44] [INFO] * Parameters: 'Formsigprccp', 'C:\4c\tasks\task587\logs\06_testForm.log'
[2026-09-26 16:14:44] [INFO] 
[2026-09-26 16:14:44] [INFO] * Anti-dialog protections for unattended execution
[2026-09-26 16:14:44] [INFO] SET SAFETY OFF
[2026-09-26 16:14:44] [INFO] SET RESOURCE OFF
[2026-09-26 16:14:44] [INFO] SET TALK OFF
[2026-09-26 16:14:44] [INFO] SET NOTIFY OFF
[2026-09-26 16:14:44] [INFO] SYS(2335, 0)
[2026-09-26 16:14:44] [INFO] 
[2026-09-26 16:14:44] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprccp', 'C:\4c\tasks\task587\logs\06_testForm.log'
[2026-09-26 16:14:44] [INFO] QUIT
[2026-09-26 16:14:44] [INFO] 
[2026-09-26 16:14:44] [INFO] === Fim do Wrapper.prg ===
[2026-09-26 16:14:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg):
*==============================================================================*
* Formsigprccp.prg - Formulario Operacional: Recalculo de Precos
*==============================================================================*
* Tipo: OPERACIONAL (layout customizado - sem PageFrame/Page1-Page2, igual ao
* legado SIGPRCCP.SCX, cujos controles sao todos filhos diretos do form)
* Migrado de SIGPRCCP.SCX
*
* Pilares:
*   UX   -> layout e comportamento identicos ao legado (1000x600)
*   BD   -> SigCdPro atualizado pelo recalculo; SigCdCcp somente leitura (presets)
*   CODE -> arquitetura em camadas (FormBase / sigprccpBO)
*
* CHAMADA:
*   loForm = CREATEOBJECT("Formsigprccp", lAutomatico)
*   loForm.Show()
*==============================================================================*

DEFINE CLASS Formsigprccp AS FormBase

	*-- Dimensoes identicas ao legado
	Height       = 600
	Width        = 1000
	BorderStyle  = 2
	AutoCenter   = .T.
	TitleBar     = 0
	ShowWindow   = 1
	WindowType   = 1
	ControlBox   = .F.
	Closable     = .F.
	MaxButton    = .F.
	MinButton    = .F.
	ClipControls = .F.
	DataSession  = 2
	ShowTips     = .T.

	*-- Propriedades do Form
	this_cTituloForm = ""

	*-- Flag operacional (mirror do "automatico" do legado - controla o modo
	*-- ProcessaAutomatico, percorrendo os presets de SigCdCcp sem interacao)
	this_lAutomatico = .F.

	*-- Guarda de disparo unico do lote automatico. O legado chama
	*-- "=ThisForm.ProcessaAutomatico()" na ULTIMA linha do Init, mas ali esse
	*-- metodo termina em "Sair.Cancela.Click()" -> Release: liberar o form
	*-- DENTRO do Init derrubaria a referencia e CREATEOBJECT devolveria .F.,
	*-- fazendo o menu acusar "erro ao criar formulario" no fim de um lote que
	*-- rodou certo. Por isso o disparo fica no Activate (primeira ativacao,
	*-- depois do Show), onde o Release fecha a tela normalmente - mesmo
	*-- comportamento observavel: abre, processa o lote, fecha sozinho.
	this_lAutomaticoDisparado = .F.

	*====================================================================
	* Init - Recebe o flag Automatico (equivalente a "Parameters pAuto"
	* do legado) e delega o restante para FormBase.Init()/InicializarForm()
	*====================================================================
	PROCEDURE Init()
		LPARAMETERS par_lAutomatico

		THIS.this_lAutomatico = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
		THIS.this_cTituloForm = "Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os"

		*-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
		RETURN DODEFAULT()
	ENDPROC

	*====================================================================
	* Activate - Dispara o lote automatico UMA unica vez, na primeira
	* ativacao da janela. Equivale a "If ThisForm.Automatico /
	* =ThisForm.ProcessaAutomatico()" da ultima linha do Init legado (ver
	* this_lAutomaticoDisparado para o motivo de nao ser no Init).
	*
	* O lote nao roda em modo de teste/validacao automatizada: ali nao ha
	* conexao valida e o objetivo eh apenas instanciar o form.
	*====================================================================
	PROCEDURE Activate()
		IF THIS.this_lAutomatico AND !THIS.this_lAutomaticoDisparado
			THIS.this_lAutomaticoDisparado = .T.

			IF !((TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
					(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI))
				THIS.ProcessaAutomatico()
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* InicializarForm - Cria o Business Object e monta a estrutura base
	* (background + faixa de cabecalho). Grid, filtros e botoes ficam
	* para as proximas fases.
	*====================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			*-- DataSession = 2 nasce com os SETs no DEFAULT do VFP9: o
			*-- FormBase.Init() repoe apenas DATE/CENTURY, entao os dois SETs
			*-- de que ESTE form depende tem de ser repostos aqui, DENTRO da
			*-- datasession privada:
			*--   SAFETY  - com SAFETY ON (default), o "Zap In cursor_4c_Produtos"
			*--             de Processar/Atualizar abre o dialogo modal "Zap ...
			*--             Are you sure?" e CONGELA a tela (o SET SAFETY OFF do
			*--             main.prg roda na sessao 1 e nao alcanca esta).
			*--   DELETED - com DELETED OFF (default), o "Delete For PVarias ..."
			*--             do filtro de Variacao marca a linha mas ela CONTINUA
			*--             aparecendo na grade (o SET DELETED ON do config.prg
			*--             tambem so vale na sessao 1).
			SET SAFETY OFF
			SET DELETED ON

			THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")

			IF VARTYPE(THIS.this_oBusinessObject) != "O"
				MsgErro("Falha ao criar sigprccpBO", "Erro")
			ELSE
				THIS.this_oBusinessObject.this_lAutomatico = THIS.this_lAutomatico

				THIS.ConfigurarPageFrame()
				THIS.ConfigurarCabecalho()

				THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_cTituloForm
				THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_cTituloForm

				*-- Campos de filtro (area "Filtros" do legado, acima da grade) -
				*-- Fase 5 trouxe a 1a metade (Fornecedor/Linha/Grande Grupo/
				*-- Grupo Venda/Grupo/Markup/Subgrupo/Encargo); Fase 6 completa
				*-- a 2a metade (Unidade/Moeda/Variacao/Feitio/OpcaoMoeda/
				*-- Situacao/Compra) + a area "Dados" (Reajuste/NovoMarkup/
				*-- NovoEncargo/AtualizaVenda/Recalcula/NovoMkp) + TODOS os
				*-- lookups (F4/Enter/Tab) das duas metades.
				THIS.ConfigurarFiltrosParte1()
				THIS.ConfigurarFiltrosParte2()
				THIS.ConfigurarDados()
				THIS.ConfigurarLookupsFiltros()

				*-- Sincroniza a tela com os defaults que o BO declara
				*-- (this_nOpcaoMoeda=1 / this_nSituacao=1 / this_nOpcaoCompra=3
				*-- / this_nTipoRecalculo=1 / this_nAtualizaVenda=2, os mesmos
				*-- valores que o SCX legado traz nos OptionGroups). Com isso o
				*-- BO fica FONTE UNICA dos defaults e nao ha como tela e BO
				*-- divergirem em silencio. BOParaForm termina chamando
				*-- AtualizarEstadoCalculo, que aplica as regras de When do
				*-- legado sobre Reajuste/NovoMarkup/Variacao/NovoMkp.
				THIS.BOParaForm()

				*-- Grade de produtos (Grd_Produto no legado) + botoes de acao
				*-- (Sair/Impress?o/cmdSelemp/CmdApgEmp no legado) - criados
				*-- DEPOIS do cabecalho para desenhar por cima dele na faixa
				*-- superior (Top negativo dos botoes, igual ao SCX legado)
				THIS.ConfigurarGridProdutos()
				THIS.ConfigurarBotoesAcao()

				*-- Foto do produto da linha corrente (Image FigJpg do legado).
				*-- Criada DEPOIS da grade porque depende dela para ligar o
				*-- AfterRowColChange que recarrega a imagem a cada linha.
				THIS.ConfigurarFotoProduto()

				*-- Estado inicial dos botoes de acao: "ThisForm.Sair.Atualiza.
				*-- Enabled = .F." + "ThisForm.Impress?o.Enabled = .f." das duas
				*-- ultimas linhas do Init legado. Passa pelo FUNIL para nao
				*-- existir mais de um lugar decidindo o Enabled desses botoes.
				THIS.this_cModoAtual = "LISTA"
				THIS.AjustarBotoesPorModo()

				THIS.TornarControlesVisiveis()
				THIS.Refresh()

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inicializar Formsigprccp: " + loc_oErro.Message + ;
				" Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
				" Proc=" + loc_oErro.Procedure, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfigurarPageFrame - Este form NAO tem PageFrame (o legado SIGPRCCP
	* nao usa Pagina.Lista/Pagina.Dados - todos os controles sao filhos
	* diretos do form). Metodo mantido apenas para aplicar o background
	* do Framework legado (Picture = new_background.jpg no SCX).
	*====================================================================
	PROTECTED PROCEDURE ConfigurarPageFrame()
		LOCAL loc_cImg
		loc_cImg = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

		IF FILE(loc_cImg)
			THIS.Picture = loc_cImg
		ENDIF
	ENDPROC

	*====================================================================
	* ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado),
	* com os dois labels sobrepostos (sombra preta + titulo branco).
	* Valores identicos ao legado: Top=0, Left=0, Height=80.
	*====================================================================
	PROTECTED PROCEDURE ConfigurarCabecalho()
		THIS.AddObject("cnt_4c_Cabecalho", "Container")
		WITH THIS.cnt_4c_Cabecalho
			.Top         = 0
			.Left        = 0
			.Width       = THIS.Width
			.Height      = 80
			.BackStyle   = 1
			.BackColor   = RGB(100, 100, 100)
			.BorderWidth = 0
			.Visible     = .T.

			.AddObject("lbl_4c_Sombra", "Label")
			WITH .lbl_4c_Sombra
				.AutoSize  = .F.
				.Top       = 18
				.Left      = 10
				.Width     = THIS.Width
				.Height    = 40
				.FontBold  = .T.
				.FontName  = "Tahoma"
				.FontSize  = 18
				.BackStyle = 0
				.ForeColor = RGB(0, 0, 0)
				.Caption   = " "
			ENDWITH

			.AddObject("lbl_4c_Titulo", "Label")
			WITH .lbl_4c_Titulo
				.AutoSize  = .F.
				.Top       = 17
				.Left      = 10
				.Width     = THIS.Width
				.Height    = 46
				.FontBold  = .T.
				.FontName  = "Tahoma"
				.FontSize  = 18
				.BackStyle = 0
				.ForeColor = RGB(255, 255, 255)
				.Caption   = " "
			ENDWITH
		ENDWITH
	ENDPROC

	*====================================================================
	* TornarControlesVisiveis - Torna visiveis todos os controles do form
	* e de seus containers, recursivamente. AddObject cria com Visible=.F.
	* por padrao.
	*====================================================================
	PROTECTED PROCEDURE TornarControlesVisiveis()
		LOCAL loc_nI, loc_oCtrl

		FOR loc_nI = 1 TO THIS.ControlCount
			loc_oCtrl = THIS.Controls(loc_nI)

			*-- Controles cuja visibilidade NAO eh decidida aqui:
			*--   IMG_4C_FIGJPG    - nasce OCULTA no legado (FigJpg.Visible =
			*--                      .F.) e so aparece quando o produto da linha
			*--                      corrente tem foto; quem decide eh
			*--                      GrdProdutosAfterRowColChange. Mostrar aqui
			*--                      deixaria um retangulo vazio permanente.
			*--   CMD_4C_IMPRIMIR  - Visible vem de fChecaAcesso("SigPrCcp",
			*--   SHP_4C_SHAPE2      "IMPRIMIR"), igual ao legado
			*--                      (Impress?o.Visible = fChecaAcesso(...) no
			*--                      Init); o Shape acompanha o botao. Forcar
			*--                      .T. aqui REVERTERIA o controle de acesso e
			*--                      exibiria o botao para quem nao pode
			*--                      imprimir - sem erro nenhum na tela.
			IF INLIST(UPPER(loc_oCtrl.Name), "IMG_4C_FIGJPG", "CMD_4C_IMPRIMIR", "SHP_4C_SHAPE2")
				LOOP
			ENDIF

			IF PEMSTATUS(loc_oCtrl, "Visible", 5)
				loc_oCtrl.Visible = .T.
			ENDIF

			IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
				THIS.TornarSubControlesVisiveis(loc_oCtrl)
			ENDIF
		ENDFOR
	ENDPROC

	*====================================================================
	* TornarSubControlesVisiveis - Recursao auxiliar de TornarControlesVisiveis
	*====================================================================
	PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
		LOCAL loc_nI, loc_oCtrl

		FOR loc_nI = 1 TO par_oContainer.ControlCount
			loc_oCtrl = par_oContainer.Controls(loc_nI)

			IF PEMSTATUS(loc_oCtrl, "Visible", 5)
				loc_oCtrl.Visible = .T.
			ENDIF

			IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
				THIS.TornarSubControlesVisiveis(loc_oCtrl)
			ENDIF
		ENDFOR
	ENDPROC

	*====================================================================
	* ConfigurarFiltrosParte1 - Metade dos campos de filtro da area
	* "Filtros" do legado (Label1, Top=94, acima da grade). Cada TextBox
	* mapeia 1:1 para uma propriedade this_c*/this_n* ja declarada em
	* sigprccpBO (Fases 1/2) e consumida por MontarWhereFiltros/
	* AcrescentarFaixa. Posicoes/legendas EXATAS do layout.json (form flat
	* 1000x600, sem PageFrame - nao ha offset de compensacao a aplicar).
	*
	* Nomes dos controles seguem o SIGNIFICADO exibido na tela (rotulo),
	* nao a abreviacao do objeto legado - Say17 "Grupo Venda :" rotula
	* GetColi/GetColf, que apesar do nome persistem como this_cColecaoI/F
	* no BO (coluna real "Colecoes" da tabela SigCdCol).
	*
	* Sem BINDEVENT de lookup (F4/Enter/Tab) nesta fase - fica para a fase
	* de lookups, quando as duas metades de campos ja existirem.
	*====================================================================
	PROTECTED PROCEDURE ConfigurarFiltrosParte1()
		LOCAL loc_cFonte
		loc_cFonte = "Tahoma"

		*-- Titulo da secao "Filtros" (Label1 do legado) - Tahoma 12 Bold,
		*-- ForeColor(90,90,90) EXATOS do dump (nao 36,84,155 - essa cor eh
		*-- so para titulo de secao COM declaracao explicita no SCX legado)
		THIS.AddObject("lbl_4c_TituloFiltros", "Label")
		WITH THIS.lbl_4c_TituloFiltros
			.Top       = 94
			.Left      = 11
			.Width     = 53
			.Height    = 21
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = "Tahoma"
			.FontSize  = 12
			.FontBold  = .T.
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Filtros"
		ENDWITH

		*-- Fornecedor (getCFornecs/getDFornecs) - SigCdPro.ifors char(10).
		*-- Lookup (fAcessoContas no legado) fica para fase posterior -
		*-- txt_4c_DescFornecedor eh somente-leitura (When retorna .F. no
		*-- legado: getDFornecs so eh preenchido pelo lookup).
		THIS.AddObject("lbl_4c_Fornecedor", "Label")
		WITH THIS.lbl_4c_Fornecedor
			.Top       = 92
			.Left      = 79
			.Width     = 64
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Fornecedor :"
		ENDWITH

		THIS.AddObject("txt_4c_Fornecedor", "TextBox")
		WITH THIS.txt_4c_Fornecedor
			.Top       = 88
			.Left      = 145
			.Width     = 80
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.Format    = "K!"
			.MaxLength = 10
			.Value     = ""
		ENDWITH

		THIS.AddObject("txt_4c_DescFornecedor", "TextBox")
		WITH THIS.txt_4c_DescFornecedor
			.Top       = 88
			.Left      = 228
			.Width     = 197
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 40
			.ReadOnly  = .T.
			.TabStop   = .F.
			.Value     = ""
		ENDWITH

		*-- Linha (GetLini/GetLinf) - SigCdPro.linhas char(10)
		THIS.AddObject("lbl_4c_Linha", "Label")
		WITH THIS.lbl_4c_Linha
			.Top       = 92
			.Left      = 503
			.Width     = 34
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Linha :"
		ENDWITH

		THIS.AddObject("txt_4c_LinhaI", "TextBox")
		WITH THIS.txt_4c_LinhaI
			.Top       = 88
			.Left      = 539
			.Width     = 84
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 10
			.Value     = ""
		ENDWITH

		THIS.AddObject("lbl_4c_AteLinha", "Label")
		WITH THIS.lbl_4c_AteLinha
			.Top       = 92
			.Left      = 627
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_LinhaF", "TextBox")
		WITH THIS.txt_4c_LinhaF
			.Top       = 88
			.Left      = 649
			.Width     = 84
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 10
			.Value     = ""
		ENDWITH

		*-- Grande Grupo (getMercI/getMercF) - SigCdPro.mercs char(3),
		*-- mapeia this_cMercI/this_cMercF no BO ("Mercs" em AcrescentarFaixa)
		THIS.AddObject("txt_4c_GrandeGrupoI", "TextBox")
		WITH THIS.txt_4c_GrandeGrupoI
			.Top       = 113
			.Left      = 145
			.Width     = 31
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 3
			.Value     = ""
		ENDWITH

		THIS.AddObject("lbl_4c_GrandeGrupo", "Label")
		WITH THIS.lbl_4c_GrandeGrupo
			.Top       = 117
			.Left      = 67
			.Width     = 76
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Grande Grupo :"
		ENDWITH

		THIS.AddObject("lbl_4c_AteGrandeGrupo", "Label")
		WITH THIS.lbl_4c_AteGrandeGrupo
			.Top       = 117
			.Left      = 179
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_GrandeGrupoF", "TextBox")
		WITH THIS.txt_4c_GrandeGrupoF
			.Top       = 113
			.Left      = 198
			.Width     = 31
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 3
			.Value     = ""
		ENDWITH

		*-- Grupo Venda (GetColi/GetColf) - SigCdPro.colecoes char(10),
		*-- mapeia this_cColecaoI/this_cColecaoF no BO ("Colecoes" em
		*-- AcrescentarFaixa). Rotulo "Grupo Venda :" transcrito do SCX -
		*-- diverge do nome interno do objeto legado (Col = SigCdCol),
		*-- mas o texto exibido eh a fonte de verdade da UI (Pilar 1).
		THIS.AddObject("lbl_4c_GrupoVenda", "Label")
		WITH THIS.lbl_4c_GrupoVenda
			.Top       = 117
			.Left      = 466
			.Width     = 71
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Grupo Venda :"
		ENDWITH

		THIS.AddObject("txt_4c_ColecaoI", "TextBox")
		WITH THIS.txt_4c_ColecaoI
			.Top       = 113
			.Left      = 539
			.Width     = 84
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 10
			.Value     = ""
		ENDWITH

		THIS.AddObject("lbl_4c_AteColecao", "Label")
		WITH THIS.lbl_4c_AteColecao
			.Top       = 117
			.Left      = 627
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_ColecaoF", "TextBox")
		WITH THIS.txt_4c_ColecaoF
			.Top       = 113
			.Left      = 649
			.Width     = 84
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 10
			.Value     = ""
		ENDWITH

		*-- Grupo (getCgrui/getCgruf) - SigCdPro.cgrus char(3)
		THIS.AddObject("txt_4c_GrupoI", "TextBox")
		WITH THIS.txt_4c_GrupoI
			.Top       = 138
			.Left      = 145
			.Width     = 31
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 3
			.Value     = ""
		ENDWITH

		THIS.AddObject("lbl_4c_Grupo", "Label")
		WITH THIS.lbl_4c_Grupo
			.Top       = 142
			.Left      = 105
			.Width     = 38
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Grupo :"
		ENDWITH

		THIS.AddObject("lbl_4c_AteGrupo", "Label")
		WITH THIS.lbl_4c_AteGrupo
			.Top       = 142
			.Left      = 179
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_GrupoF", "TextBox")
		WITH THIS.txt_4c_GrupoF
			.Top       = 138
			.Left      = 198
			.Width     = 31
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 3
			.Value     = ""
		ENDWITH

		*-- Markup (GetMrki/GetMrkf) - SigCdPro.margems numeric(9,6),
		*-- BO formata/compara com 2 casas (FormatarNumeroSQL(...,2))
		THIS.AddObject("lbl_4c_Markup", "Label")
		WITH THIS.lbl_4c_Markup
			.Top       = 142
			.Left      = 493
			.Width     = 44
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Markup :"
		ENDWITH

		THIS.AddObject("txt_4c_MarkupI", "TextBox")
		WITH THIS.txt_4c_MarkupI
			.Top       = 138
			.Left      = 539
			.Width     = 84
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.InputMask = "999.99"
			.Value     = 0
		ENDWITH

		THIS.AddObject("lbl_4c_AteMarkup", "Label")
		WITH THIS.lbl_4c_AteMarkup
			.Top       = 142
			.Left      = 627
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_MarkupF", "TextBox")
		WITH THIS.txt_4c_MarkupF
			.Top       = 138
			.Left      = 649
			.Width     = 84
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.InputMask = "999.99"
			.Value     = 0
		ENDWITH

		*-- Subgrupo (getSgruI/getSgruF) - SigCdPro.sgrus char(6)
		THIS.AddObject("txt_4c_SubGrupoI", "TextBox")
		WITH THIS.txt_4c_SubGrupoI
			.Top       = 163
			.Left      = 145
			.Width     = 52
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 6
			.Value     = ""
		ENDWITH

		THIS.AddObject("lbl_4c_Subgrupo", "Label")
		WITH THIS.lbl_4c_Subgrupo
			.Top       = 167
			.Left      = 88
			.Width     = 55
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Subgrupo :"
		ENDWITH

		THIS.AddObject("lbl_4c_AteSubgrupo", "Label")
		WITH THIS.lbl_4c_AteSubgrupo
			.Top       = 167
			.Left      = 201
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_SubGrupoF", "TextBox")
		WITH THIS.txt_4c_SubGrupoF
			.Top       = 163
			.Left      = 220
			.Width     = 52
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 6
			.Value     = ""
		ENDWITH

		*-- Encargo (Get_EncI/Get_Encf) - SigCdPro.encargos numeric(7,4),
		*-- BO formata/compara com 2 casas (FormatarNumeroSQL(...,2))
		THIS.AddObject("lbl_4c_Encargo", "Label")
		WITH THIS.lbl_4c_Encargo
			.Top       = 167
			.Left      = 486
			.Width     = 51
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Encargo :"
		ENDWITH

		THIS.AddObject("txt_4c_EncargoI", "TextBox")
		WITH THIS.txt_4c_EncargoI
			.Top       = 163
			.Left      = 539
			.Width     = 84
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.InputMask = "999.99"
			.Value     = 0
		ENDWITH

		THIS.AddObject("lbl_4c_AteEncargo", "Label")
		WITH THIS.lbl_4c_AteEncargo
			.Top       = 167
			.Left      = 627
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_EncargoF", "TextBox")
		WITH THIS.txt_4c_EncargoF
			.Top       = 163
			.Left      = 649
			.Width     = 84
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.InputMask = "999.99"
			.Value     = 0
		ENDWITH
	ENDPROC

	*====================================================================
	* ConfigurarFiltrosParte2 - 2a metade dos campos da area "Filtros":
	* Unidade (getCunii/getCunif), Moeda (GetMoedai/GetMoedaf), Variacao
	* (Get_Variacao), Codigo MKP/Feitio (Get_Feitio), Opcao de calculo de
	* Moeda (fwoption1: Ideal/Venda), Situacao (Opc_situacao) e Compra
	* (Opc_Compra). Posicoes/legendas EXATAS do layout.json/dump do
	* legado (form flat 1000x600, sem PageFrame - sem offset a aplicar).
	*====================================================================
	PROTECTED PROCEDURE ConfigurarFiltrosParte2()
		LOCAL loc_cFonte
		loc_cFonte = "Tahoma"

		*-- Unidade (getCunii/getCunif) - SigCdPro.unids char(3)
		THIS.AddObject("txt_4c_UnidadeI", "TextBox")
		WITH THIS.txt_4c_UnidadeI
			.Top       = 189
			.Left      = 145
			.Width     = 31
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 3
			.Value     = ""
		ENDWITH

		THIS.AddObject("lbl_4c_Unidade", "Label")
		WITH THIS.lbl_4c_Unidade
			.Top       = 193
			.Left      = 95
			.Width     = 48
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Unidade :"
		ENDWITH

		THIS.AddObject("lbl_4c_AteUnidade", "Label")
		WITH THIS.lbl_4c_AteUnidade
			.Top       = 193
			.Left      = 179
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_UnidadeF", "TextBox")
		WITH THIS.txt_4c_UnidadeF
			.Top       = 189
			.Left      = 198
			.Width     = 31
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 3
			.Value     = ""
		ENDWITH

		*-- Variacao (%) (Get_Variacao) - faixa usada em BtnProcessarClick
		*-- para excluir da grade linhas com PVarias fora da faixa
		THIS.AddObject("lbl_4c_Variacao", "Label")
		WITH THIS.lbl_4c_Variacao
			.Top       = 193
			.Left      = 456
			.Width     = 81
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Varia" + CHR(231) + CHR(227) + "o ( % ) : "
		ENDWITH

		THIS.AddObject("txt_4c_Variacao", "TextBox")
		WITH THIS.txt_4c_Variacao
			.Top       = 189
			.Left      = 539
			.Width     = 80
			.Height    = 23
			.Alignment = 3
			.FontName  = loc_cFonte
			.FontSize  = 8
			.InputMask = "999.99"
			.Value     = 0
		ENDWITH

		*-- Codigo MKP / Feitio (Get_Feitio) - SigPrFti.cods char(2),
		*-- casa cFtios OU cFtioCs em MontarWhereFiltros
		THIS.AddObject("lbl_4c_Feitio", "Label")
		WITH THIS.lbl_4c_Feitio
			.Top       = 193
			.Left      = 639
			.Width     = 68
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "C" + CHR(243) + "digo MKP : "
		ENDWITH

		THIS.AddObject("txt_4c_Feitio", "TextBox")
		WITH THIS.txt_4c_Feitio
			.Top       = 189
			.Left      = 709
			.Width     = 24
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 2
			.Value     = ""
		ENDWITH

		*-- Moeda (GetMoedai/GetMoedaf) - SigCdPro.moedas/moevs char(3)
		*-- (qual dos dois campos eh filtrado depende de obj_4c_OpcaoMoeda)
		THIS.AddObject("txt_4c_MoedaI", "TextBox")
		WITH THIS.txt_4c_MoedaI
			.Top       = 213
			.Left      = 145
			.Width     = 31
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 3
			.Value     = ""
		ENDWITH

		THIS.AddObject("lbl_4c_Moeda", "Label")
		WITH THIS.lbl_4c_Moeda
			.Top       = 217
			.Left      = 102
			.Width     = 41
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Moeda :"
		ENDWITH

		THIS.AddObject("lbl_4c_AteMoeda", "Label")
		WITH THIS.lbl_4c_AteMoeda
			.Top       = 217
			.Left      = 179
			.Width     = 20
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "at" + CHR(233)
		ENDWITH

		THIS.AddObject("txt_4c_MoedaF", "TextBox")
		WITH THIS.txt_4c_MoedaF
			.Top       = 213
			.Left      = 198
			.Width     = 31
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 3
			.Value     = ""
		ENDWITH

		*-- Opcao de Moeda para a faixa acima (fwoption1 no legado):
		*-- Ideal (Moedas) / Venda (Moevs) - Value=1 default ("Ideal")
		THIS.AddObject("obj_4c_OpcaoMoeda", "OptionGroup")
		WITH THIS.obj_4c_OpcaoMoeda
			.Top         = 211
			.Left        = 234
			.Width       = 106
			.Height      = 26
			.ButtonCount = 2
			.Value       = 1

			WITH .Buttons(1)
				.Caption  = "Ideal"
				.Top      = 5
				.Left     = 5
				.FontName = loc_cFonte
				.FontSize = 8
			ENDWITH
			WITH .Buttons(2)
				.Caption  = "Venda"
				.Top      = 6
				.Left     = 53
				.Width    = 48
				.FontName = loc_cFonte
				.FontSize = 8
			ENDWITH
		ENDWITH

		*-- Situacao (Opc_situacao) - Ativos/Inativos/Todos - Value=1 default
		THIS.AddObject("lbl_4c_Situacao", "Label")
		WITH THIS.lbl_4c_Situacao
			.Top       = 217
			.Left      = 486
			.Width     = 58
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
		ENDWITH

		THIS.AddObject("obj_4c_Situacao", "OptionGroup")
		WITH THIS.obj_4c_Situacao
			.Top         = 214
			.Left        = 536
			.Width       = 189
			.Height      = 21
			.ButtonCount = 3
			.Value       = 1

			WITH .Buttons(1)
				.Caption  = "Ativos"
				.Top      = 3
				.Left     = 5
				.FontName = loc_cFonte
				.FontSize = 8
			ENDWITH
			WITH .Buttons(2)
				.Caption  = "Inativos"
				.Top      = 2
				.Left     = 59
				.FontName = loc_cFonte
				.FontSize = 8
			ENDWITH
			WITH .Buttons(3)
				.Caption   = "Todos"
				.Top       = 2
				.Left      = 125
				.Width     = 61
				.Height    = 17
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH

		*-- Compra (Opc_Compra) - Comprar/Nao Comprar/Todos - Value=3
		*-- default ("Todos") - EXATO do dump legado
		THIS.AddObject("lbl_4c_Compra", "Label")
		WITH THIS.lbl_4c_Compra
			.Top       = 237
			.Left      = 490
			.Width     = 46
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Compra :"
		ENDWITH

		THIS.AddObject("obj_4c_Compra", "OptionGroup")
		WITH THIS.obj_4c_Compra
			.Top         = 234
			.Left        = 536
			.Width       = 204
			.Height      = 21
			.ButtonCount = 3
			.Value       = 3

			WITH .Buttons(1)
				.Caption  = "Comprar"
				.Top      = 3
				.Left     = 5
				.FontName = loc_cFonte
				.FontSize = 8
			ENDWITH
			WITH .Buttons(2)
				.Caption  = "N" + CHR(227) + "o Comprar"
				.Top      = 3
				.Left     = 67
				.FontName = loc_cFonte
				.FontSize = 8
			ENDWITH
			WITH .Buttons(3)
				.Caption   = "Todos"
				.Top       = 2
				.Left      = 152
				.Width     = 61
				.Height    = 17
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH
	ENDPROC

	*====================================================================
	* ConfigurarDados - Area "Dados" do legado (Label2, abaixo da linha
	* separadora Line1): Reajuste, Novo Markup, Novo Encargo, Atualiza
	* Val.Venda (Opc_pven), Recalcula (Opc_Recalc, 8 opcoes) e Novo MKP
	* (getNewMkp - so habilitado quando Recalcula = Markup Custo/Venda).
	*====================================================================
	PROTECTED PROCEDURE ConfigurarDados()
		LOCAL loc_cFonte
		loc_cFonte = "Tahoma"

		*-- Linha separadora (Line1 do legado)
		THIS.AddObject("lin_4c_Separador", "Line")
		WITH THIS.lin_4c_Separador
			.Top    = 258
			.Left   = 13
			.Width  = 738
			.Height = 0
		ENDWITH

		*-- Titulo da secao "Dados" (Label2 do legado)
		THIS.AddObject("lbl_4c_TituloDados", "Label")
		WITH THIS.lbl_4c_TituloDados
			.Top       = 270
			.Left      = 12
			.Width     = 52
			.Height    = 21
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = "Tahoma"
			.FontSize  = 12
			.FontBold  = .T.
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Dados"
		ENDWITH

		*-- Reajuste (Get_Reajuste) - percentual de reajuste (1 + Value/100)
		THIS.AddObject("lbl_4c_Reajuste", "Label")
		WITH THIS.lbl_4c_Reajuste
			.Top       = 304
			.Left      = 91
			.Width     = 52
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Reajuste :"
		ENDWITH

		THIS.AddObject("txt_4c_Reajuste", "TextBox")
		WITH THIS.txt_4c_Reajuste
			.Top       = 300
			.Left      = 148
			.Width     = 80
			.Height    = 23
			.Alignment = 3
			.FontName  = loc_cFonte
			.FontSize  = 8
			.InputMask = "999,999.999"
			.Value     = 0
		ENDWITH

		*-- Novo Encargo (get_Encargo)
		THIS.AddObject("lbl_4c_NovoEncargo", "Label")
		WITH THIS.lbl_4c_NovoEncargo
			.Top       = 304
			.Left      = 245
			.Width     = 79
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Novo Encargo : "
		ENDWITH

		THIS.AddObject("txt_4c_NovoEncargo", "TextBox")
		WITH THIS.txt_4c_NovoEncargo
			.Top       = 300
			.Left      = 326
			.Width     = 80
			.Height    = 23
			.Alignment = 3
			.FontName  = loc_cFonte
			.FontSize  = 8
			.InputMask = "999,999.99"
			.Value     = 0
		ENDWITH

		*-- Atualiza Val.Venda (Opc_pven) - Sim/Nao - Value=2 default
		*-- ("Nao") - EXATO do dump legado
		THIS.AddObject("lbl_4c_AtualizaVenda", "Label")
		WITH THIS.lbl_4c_AtualizaVenda
			.Top       = 304
			.Left      = 448
			.Width     = 98
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Atualiza Val.Venda :"
		ENDWITH

		THIS.AddObject("obj_4c_AtualizaVenda", "OptionGroup")
		WITH THIS.obj_4c_AtualizaVenda
			.Top         = 298
			.Left        = 544
			.Width       = 102
			.Height      = 27
			.ButtonCount = 2
			.Value       = 2

			WITH .Buttons(1)
				.Caption  = "Sim"
				.Top      = 5
				.Left     = 5
				.FontName = loc_cFonte
				.FontSize = 8
			ENDWITH
			WITH .Buttons(2)
				.Caption   = "N" + CHR(227) + "o"
				.Top       = 5
				.Left      = 53
				.Width     = 44
				.Height    = 17
				.FontName  = loc_cFonte
				.FontSize  = 8
			ENDWITH
		ENDWITH

		*-- Novo Markup (GetnMrk)
		THIS.AddObject("lbl_4c_NovoMarkup", "Label")
		WITH THIS.lbl_4c_NovoMarkup
			.Top       = 330
			.Left      = 71
			.Width     = 72
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Novo Markup :"
		ENDWITH

		THIS.AddObject("txt_4c_NovoMarkup", "TextBox")
		WITH THIS.txt_4c_NovoMarkup
			.Top       = 326
			.Left      = 148
			.Width     = 80
			.Height    = 23
			.Alignment = 3
			.FontName  = loc_cFonte
			.FontSize  = 8
			.InputMask = "999,999.99"
			.Value     = 0
		ENDWITH

		*-- Novo MKP (getNewMkp) - codigo do feitio novo, so usado quando
		*-- Recalcula = Markup Custo(7)/Markup Venda(8) - ver
		*-- AtualizarEstadoCalculo()
		THIS.AddObject("lbl_4c_NovoMkp", "Label")
		WITH THIS.lbl_4c_NovoMkp
			.Top       = 330
			.Left      = 264
			.Width     = 60
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Novo MKP : "
		ENDWITH

		THIS.AddObject("txt_4c_NovoMkp", "TextBox")
		WITH THIS.txt_4c_NovoMkp
			.Top       = 326
			.Left      = 326
			.Width     = 24
			.Height    = 23
			.FontName  = loc_cFonte
			.FontSize  = 8
			.MaxLength = 2
			.Value     = ""
		ENDWITH

		*-- Recalcula (Opc_Recalc) - 8 opcoes de tipo de recalculo -
		*-- Value=1 default ("Composicao")
		THIS.AddObject("lbl_4c_Recalcula", "Label")
		WITH THIS.lbl_4c_Recalcula
			.Top       = 263
			.Left      = 89
			.Width     = 58
			.Height    = 15
			.AutoSize  = .F.
			.BackStyle = 0
			.FontName  = loc_cFonte
			.FontSize  = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption   = "Recalcula :"
		ENDWITH

		THIS.AddObject("obj_4c_Recalcula", "OptionGroup")
		WITH THIS.obj_4c_Recalcula
			.Top         = 258
			.Left        = 142
			.Width       = 439
			.Height      = 41
			.ButtonCount = 8
			.Value       = 1

			WITH .Buttons(1)
				.Caption   = "Composi" + CHR(231) + CHR(227) + "o"
				.Top       = 5
				.Left      = 5
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(2)
				.Caption   = "Custo Venda"
				.Top       = 5
				.Left      = 98
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(3)
				.Caption   = "Ambos"
				.Top       = 5
				.Left      = 213
				.Width     = 50
				.Height    = 15
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(4)
				.Caption   = "Peso Componentes"
				.Top       = 4
				.Left      = 312
				.Width     = 110
				.Height    = 15
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(5)
				.Caption   = "C" + CHR(226) + "mbio"
				.Top       = 23
				.Left      = 5
				.Width     = 53
				.Height    = 15
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(6)
				.Caption   = "C" + CHR(226) + "mbio (Inteiros)"
				.Top       = 23
				.Left      = 98
				.Width     = 101
				.Height    = 15
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(7)
				.Caption   = "Markup Custo"
				.Top       = 23
				.Left      = 213
				.Width     = 84
				.Height    = 15
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
			WITH .Buttons(8)
				.Caption   = "Markup Venda"
				.Top       = 22
				.Left      = 312
				.Width     = 86
				.Height    = 15
				.FontName  = loc_cFonte
				.FontSize  = 8
				.ForeColor = RGB(90, 90, 90)
			ENDWITH
		ENDWITH
		BINDEVENT(THIS.obj_4c_Recalcula, "InteractiveChange", THIS, "RecalculaValorAlterado")
		BINDEVENT(THIS.obj_4c_Recalcula, "Click", THIS, "RecalculaValorAlterado")
	ENDPROC

	*====================================================================
	* ConfigurarLookupsFiltros - Registra os BINDEVENT de KeyPress
	* (Enter/Tab/F4) de TODOS os campos de filtro com lookup - das duas
	* metades (Fase 5 e Fase 6). Feito num metodo unico (em vez de dentro
	* de cada ConfigurarFiltrosParteN) para manter os lookups juntos e
	* faceis de auditar.
	*====================================================================
	PROTECTED PROCEDURE ConfigurarLookupsFiltros()
		*-- Fornecedor (getCFornecs/getDFornecs) - substitui fAcessoContas
		*-- (regra: fAcessoContas NAO deve ser usado como lookup de UX)
		BINDEVENT(THIS.txt_4c_Fornecedor, "KeyPress", THIS, "FornecedorKeyPress")

		*-- Grupo (getCgrui/getCgruf) - SigCdGrp
		BINDEVENT(THIS.txt_4c_GrupoI, "KeyPress", THIS, "GrupoIKeyPress")
		BINDEVENT(THIS.txt_4c_GrupoF, "KeyPress", THIS, "GrupoFKeyPress")

		*-- Grande Grupo (getMercI/getMercF) - SigCdGpr
		BINDEVENT(THIS.txt_4c_GrandeGrupoI, "KeyPress", THIS, "GrandeGrupoIKeyPress")
		BINDEVENT(THIS.txt_4c_GrandeGrupoF, "KeyPress", THIS, "GrandeGrupoFKeyPress")

		*-- Grupo Venda / Colecao (GetColi/GetColf) - SigCdCol
		BINDEVENT(THIS.txt_4c_ColecaoI, "KeyPress", THIS, "ColecaoIKeyPress")
		BINDEVENT(THIS.txt_4c_ColecaoF, "KeyPress", THIS, "ColecaoFKeyPress")

		*-- Subgrupo (getSgruI/getSgruF) - SigCdPsg
		BINDEVENT(THIS.txt_4c_SubGrupoI, "KeyPress", THIS, "SubGrupoIKeyPress")
		BINDEVENT(THIS.txt_4c_SubGrupoF, "KeyPress", THIS, "SubGrupoFKeyPress")

		*-- Linha (GetLini/GetLinf) - SigCdLin
		BINDEVENT(THIS.txt_4c_LinhaI, "KeyPress", THIS, "LinhaIKeyPress")
		BINDEVENT(THIS.txt_4c_LinhaF, "KeyPress", THIS, "LinhaFKeyPress")

		*-- Unidade (getCunii/getCunif) - SigCdUni
		BINDEVENT(THIS.txt_4c_UnidadeI, "KeyPress", THIS, "UnidadeIKeyPress")
		BINDEVENT(THIS.txt_4c_UnidadeF, "KeyPress", THIS, "UnidadeFKeyPress")

		*-- Moeda (GetMoedai/GetMoedaf) - SigCdMoe
		BINDEVENT(THIS.txt_4c_MoedaI, "KeyPress", THIS, "MoedaIKeyPress")
		BINDEVENT(THIS.txt_4c_MoedaF, "KeyPress", THIS, "MoedaFKeyPress")

		*-- Feitio (Get_Feitio) e Novo MKP (getNewMkp) - SigPrFti
		BINDEVENT(THIS.txt_4c_Feitio, "KeyPress", THIS, "FeitioKeyPress")
		BINDEVENT(THIS.txt_4c_NovoMkp, "KeyPress", THIS, "NovoMkpKeyPress")

		*-- Reajuste/Novo Markup/Variacao - exclusao mutua (Valid legado)
		BINDEVENT(THIS.txt_4c_Reajuste, "KeyPress", THIS, "ReajusteKeyPress")
		BINDEVENT(THIS.txt_4c_NovoMarkup, "KeyPress", THIS, "NovoMarkupKeyPress")
		BINDEVENT(THIS.txt_4c_Variacao, "KeyPress", THIS, "VariacaoKeyPress")

		*-- Novo Encargo - validacao simples (>= 0)
		BINDEVENT(THIS.txt_4c_NovoEncargo, "KeyPress", THIS, "NovoEncargoKeyPress")
	ENDPROC

	*====================================================================
	* ExecutarLookupFiltro - Helper compartilhado pelos campos de faixa
	* que tem SOMENTE codigo na tela (sem TextBox de descricao ao lado):
	* tenta match EXATO por SQL e, sem achar, delega para o picker
	* canonico (AbrirLookupCanonico, FormBase.prg) filtrado pelo prefixo
	* digitado - equivalente ao fwBuscaExt(...) do legado.
	*====================================================================
	PROTECTED PROCEDURE ExecutarLookupFiltro(par_oTxt, par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo)
		LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_cCursor
		loc_cValor = ALLTRIM(UPPER(TratarNulo(par_oTxt.Value, "")))

		IF EMPTY(loc_cValor)
			RETURN
		ENDIF

		loc_cCursor = "cursor_4c_LkpFiltro"
		IF USED(loc_cCursor)
			USE IN (loc_cCursor)
		ENDIF

		loc_cSQL = "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
			" WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cValor)
		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

		IF loc_nResultado > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
			par_oTxt.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoCod))
			USE IN (loc_cCursor)
		ELSE
			IF USED(loc_cCursor)
				USE IN (loc_cCursor)
			ENDIF
			THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, loc_cValor, par_oTxt)
		ENDIF

		par_oTxt.Refresh()
	ENDPROC

	*====================================================================
	* ExecutarLookupFeitio - Helper compartilhado por Get_Feitio/getNewMkp
	* (ambos consultam SigPrFti.Cods; getNewMkp acrescenta "Tipos = 1").
	*====================================================================
	PROTECTED PROCEDURE ExecutarLookupFeitio(par_oTxt, par_cFiltroExtra, par_cTitulo)
		LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_cCursor, loc_cWhere
		loc_cValor = ALLTRIM(UPPER(TratarNulo(par_oTxt.Value, "")))

		IF EMPTY(loc_cValor)
			RETURN
		ENDIF

		loc_cCursor = "cursor_4c_LkpFeitio"
		IF USED(loc_cCursor)
			USE IN (loc_cCursor)
		ENDIF

		loc_cWhere = "Cods = " + EscaparSQL(loc_cValor)
		IF VARTYPE(par_cFiltroExtra) = "C" AND !EMPTY(par_cFiltroExtra)
			loc_cWhere = loc_cWhere + " AND " + par_cFiltroExtra
		ENDIF

		loc_cSQL = "SELECT Cods FROM SigPrFti WHERE " + loc_cWhere
		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

		IF loc_nResultado > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
			par_oTxt.Value = ALLTRIM(EVALUATE(loc_cCursor + ".Cods"))
			USE IN (loc_cCursor)
		ELSE
			IF USED(loc_cCursor)
				USE IN (loc_cCursor)
			ENDIF
			THIS.AbrirLookupCanonico("SigPrFti", "Cods", "Descs", par_cTitulo, loc_cValor, par_oTxt, .NULL., par_cFiltroExtra)
		ENDIF

		par_oTxt.Refresh()
	ENDPROC

	*====================================================================
	* AbrirLookup<Campo> - Ponto de entrada canonico de lookup, um por
	* campo com fwBuscaExt/fwBuscaInt no legado (17 no total). Cada um
	* carrega a tabela/coluna/titulo EXATOS do CreateObject legado e
	* delega para o motor compartilhado, que tenta o match exato e, sem
	* achar, abre o picker filtrado pelo prefixo digitado.
	* Todos PUBLIC: sao chamados pelos handlers de KeyPress ligados por
	* BINDEVENT (CLAUDE.md regra #3).
	*====================================================================
	PROCEDURE AbrirLookupGrupoI()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_GrupoI, "SigCdGrp", "CGrus", "DGrus", "Grupo")
	ENDPROC

	PROCEDURE AbrirLookupGrupoF()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_GrupoF, "SigCdGrp", "CGrus", "DGrus", "Grupo")
	ENDPROC

	PROCEDURE AbrirLookupGrandeGrupoI()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_GrandeGrupoI, "SigCdGpr", "Codigos", "Descs", "Grande Grupo")
	ENDPROC

	PROCEDURE AbrirLookupGrandeGrupoF()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_GrandeGrupoF, "SigCdGpr", "Codigos", "Descs", "Grande Grupo")
	ENDPROC

	PROCEDURE AbrirLookupColecaoI()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_ColecaoI, "SigCdCol", "Colecoes", "Descs", "Grupo Venda")
	ENDPROC

	PROCEDURE AbrirLookupColecaoF()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_ColecaoF, "SigCdCol", "Colecoes", "Descs", "Grupo Venda")
	ENDPROC

	PROCEDURE AbrirLookupSubGrupoI()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_SubGrupoI, "SigCdPsg", "Codigos", "Descricaos", "Subgrupo")
	ENDPROC

	PROCEDURE AbrirLookupSubGrupoF()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_SubGrupoF, "SigCdPsg", "Codigos", "Descricaos", "Subgrupo")
	ENDPROC

	PROCEDURE AbrirLookupLinhaI()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_LinhaI, "SigCdLin", "Linhas", "Descs", "Linha")
	ENDPROC

	PROCEDURE AbrirLookupLinhaF()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_LinhaF, "SigCdLin", "Linhas", "Descs", "Linha")
	ENDPROC

	PROCEDURE AbrirLookupUnidadeI()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_UnidadeI, "SigCdUni", "CUnis", "DUnis", "Unidade")
	ENDPROC

	PROCEDURE AbrirLookupUnidadeF()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_UnidadeF, "SigCdUni", "CUnis", "DUnis", "Unidade")
	ENDPROC

	PROCEDURE AbrirLookupMoedaI()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_MoedaI, "SigCdMoe", "CMoes", "DMoes", "Moeda")
	ENDPROC

	PROCEDURE AbrirLookupMoedaF()
		THIS.ExecutarLookupFiltro(THIS.txt_4c_MoedaF, "SigCdMoe", "CMoes", "DMoes", "Moeda")
	ENDPROC

	PROCEDURE AbrirLookupFeitio()
		THIS.ExecutarLookupFeitio(THIS.txt_4c_Feitio, "", "Feitios")
	ENDPROC

	PROCEDURE AbrirLookupNovoMkp()
		THIS.ExecutarLookupFeitio(THIS.txt_4c_NovoMkp, "Tipos = 1", "Feitios de Venda")
	ENDPROC

	*====================================================================
	* AbrirLookupFornecedor - Lookup de Fornecedor (getCFornecs/getDFornecs).
	* O legado usa fAcessoContas(Usuar, [], 'C', This.Value, This,
	* ThisForm.getDFornecs) - PROIBIDO como lookup de UX (auto-preenche com
	* o 1o match PARCIAL sem o usuario escolher). Substituido pelo padrao
	* canonico: match exato em SigCdCli.Iclis e, sem achar, picker filtrado
	* por prefixo. Unico lookup do form que preenche DOIS controles
	* (codigo + razao social).
	*====================================================================
	PROCEDURE AbrirLookupFornecedor()
		LOCAL loc_cValor, loc_cSQL, loc_nResultado

		loc_cValor = ALLTRIM(UPPER(TratarNulo(THIS.txt_4c_Fornecedor.Value, "")))

		IF EMPTY(loc_cValor)
			THIS.txt_4c_DescFornecedor.Value = ""
			THIS.txt_4c_DescFornecedor.Refresh()
			RETURN
		ENDIF

		IF USED("cursor_4c_LkpFornecedor")
			USE IN cursor_4c_LkpFornecedor
		ENDIF

		loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor)
		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpFornecedor")

		IF loc_nResultado > 0 AND USED("cursor_4c_LkpFornecedor") AND ;
				RECCOUNT("cursor_4c_LkpFornecedor") > 0
			THIS.txt_4c_Fornecedor.Value     = ALLTRIM(cursor_4c_LkpFornecedor.Iclis)
			THIS.txt_4c_DescFornecedor.Value = ALLTRIM(cursor_4c_LkpFornecedor.Rclis)
			USE IN cursor_4c_LkpFornecedor
		ELSE
			IF USED("cursor_4c_LkpFornecedor")
				USE IN cursor_4c_LkpFornecedor
			ENDIF
			THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
				"Sele" + CHR(231) + CHR(227) + "o de Fornecedor", loc_cValor, ;
				THIS.txt_4c_Fornecedor, THIS.txt_4c_DescFornecedor)
		ENDIF

		THIS.txt_4c_Fornecedor.Refresh()
		THIS.txt_4c_DescFornecedor.Refresh()
	ENDPROC

	*====================================================================
	* Handlers de KeyPress dos lookups de faixa - todos PUBLIC (alvo de
	* BINDEVENT, CLAUDE.md regra #3), todos com o mesmo guard Enter(13)/
	* Tab(9)/F4(115), delegando para ExecutarLookupFiltro.
	*====================================================================
	PROCEDURE GrupoIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_GrupoI, "SigCdGrp", "CGrus", "DGrus", "Grupo")
		ENDIF
	ENDPROC

	PROCEDURE GrupoFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_GrupoF, "SigCdGrp", "CGrus", "DGrus", "Grupo")
		ENDIF
	ENDPROC

	PROCEDURE GrandeGrupoIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_GrandeGrupoI, "SigCdGpr", "Codigos", "Descs", "Grande Grupo")
		ENDIF
	ENDPROC

	PROCEDURE GrandeGrupoFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_GrandeGrupoF, "SigCdGpr", "Codigos", "Descs", "Grande Grupo")
		ENDIF
	ENDPROC

	PROCEDURE ColecaoIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_ColecaoI, "SigCdCol", "Colecoes", "Descs", "Grupo Venda")
		ENDIF
	ENDPROC

	PROCEDURE ColecaoFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_ColecaoF, "SigCdCol", "Colecoes", "Descs", "Grupo Venda")
		ENDIF
	ENDPROC

	PROCEDURE SubGrupoIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_SubGrupoI, "SigCdPsg", "Codigos", "Descricaos", "Subgrupo")
		ENDIF
	ENDPROC

	PROCEDURE SubGrupoFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_SubGrupoF, "SigCdPsg", "Codigos", "Descricaos", "Subgrupo")
		ENDIF
	ENDPROC

	PROCEDURE LinhaIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_LinhaI, "SigCdLin", "Linhas", "Descs", "Linha")
		ENDIF
	ENDPROC

	PROCEDURE LinhaFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_LinhaF, "SigCdLin", "Linhas", "Descs", "Linha")
		ENDIF
	ENDPROC

	PROCEDURE UnidadeIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_UnidadeI, "SigCdUni", "CUnis", "DUnis", "Unidade")
		ENDIF
	ENDPROC

	PROCEDURE UnidadeFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_UnidadeF, "SigCdUni", "CUnis", "DUnis", "Unidade")
		ENDIF
	ENDPROC

	PROCEDURE MoedaIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_MoedaI, "SigCdMoe", "CMoes", "DMoes", "Moeda")
		ENDIF
	ENDPROC

	PROCEDURE MoedaFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFiltro(THIS.txt_4c_MoedaF, "SigCdMoe", "CMoes", "DMoes", "Moeda")
		ENDIF
	ENDPROC

	PROCEDURE FeitioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFeitio(THIS.txt_4c_Feitio, "", "Feitios")
		ENDIF
	ENDPROC

	PROCEDURE NovoMkpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.ExecutarLookupFeitio(THIS.txt_4c_NovoMkp, "Tipos = 1", "Feitios de Venda")
		ENDIF
	ENDPROC

	*====================================================================
	* FornecedorKeyPress - PUBLIC (BINDEVENT KeyPress em txt_4c_Fornecedor).
	* Guard Enter(13)/Tab(9)/F4(115) e delega para AbrirLookupFornecedor.
	*====================================================================
	PROCEDURE FornecedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 9, 115)
			THIS.AbrirLookupFornecedor()
		ENDIF
	ENDPROC

	*====================================================================
	* ReajusteKeyPress/NovoMarkupKeyPress/VariacaoKeyPress - exclusao
	* mutua transcrita literalmente do Valid do legado: informar um
	* zera os outros campos concorrentes, e o estado Enabled dos tres eh
	* recalculado (ver AtualizarEstadoCalculo) porque GetnMrk/Get_Variacao
	* so ficam habilitados quando Get_Reajuste = 0.
	*====================================================================
	PROCEDURE ReajusteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF !INLIST(par_nKeyCode, 13, 9)
			RETURN
		ENDIF
		IF THIS.txt_4c_Reajuste.Value > 0
			THIS.txt_4c_NovoMarkup.Value = 0
			THIS.txt_4c_NovoMarkup.Refresh()
		ENDIF
		THIS.AtualizarEstadoCalculo()
	ENDPROC

	PROCEDURE NovoMarkupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF !INLIST(par_nKeyCode, 13, 9)
			RETURN
		ENDIF
		IF THIS.txt_4c_NovoMarkup.Value > 0
			THIS.txt_4c_Reajuste.Value = 0
			THIS.txt_4c_Reajuste.Refresh()
		ENDIF
		THIS.AtualizarEstadoCalculo()
	ENDPROC

	PROCEDURE VariacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF !INLIST(par_nKeyCode, 13, 9)
			RETURN
		ENDIF
		IF THIS.txt_4c_Variacao.Value > 0
			THIS.txt_4c_Reajuste.Value = 0
			THIS.txt_4c_Reajuste.Refresh()
		ENDIF
		THIS.AtualizarEstadoCalculo()
	ENDPROC

	*====================================================================
	* NovoEncargoKeyPress - Espelha o Valid de get_Encargo do legado
	* (rejeita valor negativo).
	*====================================================================
	PROCEDURE NovoEncargoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF !INLIST(par_nKeyCode, 13, 9)
			RETURN
		ENDIF
		IF THIS.txt_4c_NovoEncargo.Value < 0
			MsgAviso("Valor Invalido!!!", "Aten" + CHR(231) + CHR(227) + "o")
			THIS.txt_4c_NovoEncargo.Value = 0
			THIS.txt_4c_NovoEncargo.Refresh()
			THIS.txt_4c_NovoEncargo.SetFocus()
		ENDIF
	ENDPROC

	*====================================================================
	* RecalculaValorAlterado - PUBLIC (BINDEVENT Click/InteractiveChange
	* em obj_4c_Recalcula). So delega para AtualizarEstadoCalculo, que
	* concentra as regras "When" do legado.
	*====================================================================
	PROCEDURE RecalculaValorAlterado()
		THIS.AtualizarEstadoCalculo()
	ENDPROC

	*====================================================================
	* AtualizarEstadoCalculo - Reproduz os "When" do legado que ligam o
	* Enabled de Reajuste/Novo Markup/Variacao/Novo MKP ao tipo de
	* recalculo escolhido (obj_4c_Recalcula) e ao valor de Reajuste:
	*   Get_Reajuste.When    = Opc_Recalc.Value <> 2
	*   GetnMrk.When         = (Get_Reajuste.Value = 0) And (Opc_Recalc.Value <> 2)
	*   Get_Variacao.When    = (Get_Reajuste.Value = 0) And (Opc_Recalc.Value <> 2)
	*   getNewMkp.When       = InList(Opc_Recalc.Value, 7, 8)
	*====================================================================
	PROTECTED PROCEDURE AtualizarEstadoCalculo()
		LOCAL loc_nTipoRecalculo, loc_lReajusteZerado

		loc_nTipoRecalculo  = THIS.obj_4c_Recalcula.Value
		loc_lReajusteZerado = (THIS.txt_4c_Reajuste.Value = 0)

		THIS.txt_4c_Reajuste.Enabled   = (loc_nTipoRecalculo <> 2)
		THIS.txt_4c_NovoMarkup.Enabled = loc_lReajusteZerado AND (loc_nTipoRecalculo <> 2)
		THIS.txt_4c_Variacao.Enabled   = loc_lReajusteZerado AND (loc_nTipoRecalculo <> 2)
		THIS.txt_4c_NovoMkp.Enabled    = INLIST(loc_nTipoRecalculo, 7, 8)

		THIS.txt_4c_Reajuste.Refresh()
		THIS.txt_4c_NovoMarkup.Refresh()
		THIS.txt_4c_Variacao.Refresh()
		THIS.txt_4c_NovoMkp.Refresh()
	ENDPROC

	*====================================================================
	* ConfigurarGridProdutos - Grade de recalculo (Grd_Produto no legado):
	* 9 colunas (Column1 = checkbox de selecao/lMarca, Column2..Column9
	* somente leitura), cria o cursor local que a alimenta e liga o
	* RecordSource - transcricao literal do "Create Cursor CrProdutos(...)"
	* + WITH ThisForm.Grd_Produto do Init legado. Dimensoes/mascaras/
	* captions EXATAS do SCX (form flat 1000x600, sem PageFrame - nao ha
	* compensacao de offset a aplicar).
	*
	* cursor_4c_Produtos carrega 5 colunas ALEM das 9 da grade (pvideals/
	* fcustos/fvendas/moecs/moevs): sao os demais campos que
	* this_oBusinessObject.Atualizar() grava em SigCdPro. Sem guarda-las
	* aqui, BtnAtualizarClick teria de gravar esses campos com o default
	* (0/vazio) e apagaria dado que nao veio para a tela.
	*====================================================================
	PROTECTED PROCEDURE ConfigurarGridProdutos()
		THIS.AddObject("grd_4c_Produtos", "Grid")
		WITH THIS.grd_4c_Produtos
			.Top         = 351
			.Left        = 12
			.Width       = 935
			.Height      = 244
			.FontName    = "Tahoma"
			.FontSize    = 8
			.RowHeight   = 16
			.ScrollBars  = 2
			.DeleteMark  = .F.
			.RecordMark  = .F.
			.ColumnCount = 9

			.Column1.FontName        = "Tahoma"
			.Column1.FontSize        = 8
			.Column1.Alignment       = 3
			.Column1.Width           = 17
			.Column1.Movable         = .F.
			.Column1.Resizable       = .F.
			.Column1.Sparse          = .F.
			.Column1.Header1.Caption = ""

			*-- Coluna checkbox (Check1 no legado) - regra #18: precisa de
			*-- AddObject + CurrentControl para o controle realmente aparecer
			.Column1.AddObject("chk_4c_Marca", "CheckBox")
			.Column1.chk_4c_Marca.Caption = ""
			.Column1.chk_4c_Marca.Visible = .T.
			.Column1.CurrentControl       = "chk_4c_Marca"
			.Column1.ReadOnly             = .F.

			.Column2.FontName          = "Tahoma"
			.Column2.FontSize          = 8
			.Column2.Width             = 108
			.Column2.Movable           = .F.
			.Column2.Resizable         = .F.
			.Column2.ReadOnly          = .T.
			.Column2.Header1.FontName  = "Tahoma"
			.Column2.Header1.FontSize  = 8
			.Column2.Header1.Alignment = 2
			.Column2.Header1.Caption   = "Produto"
			.Column2.Header1.ForeColor = RGB(36, 84, 155)

			.Column3.FontName          = "Tahoma"
			.Column3.FontSize          = 8
			.Column3.Width             = 290
			.Column3.Movable           = .F.
			.Column3.Resizable         = .F.
			.Column3.ReadOnly          = .T.
			.Column3.Header1.FontName  = "Tahoma"
			.Column3.Header1.FontSize  = 8
			.Column3.Header1.Alignment = 2
			.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
			.Column3.Header1.ForeColor = RGB(36, 84, 155)

			.Column4.FontName          = "Tahoma"
			.Column4.FontSize          = 8
			.Column4.Width             = 80
			.Column4.Movable           = .F.
			.Column4.Resizable         = .F.
			.Column4.ReadOnly          = .T.
			.Column4.Header1.FontName  = "Tahoma"
			.Column4.Header1.FontSize  = 8
			.Column4.Header1.Alignment = 2
			.Column4.Header1.Caption   = "Venda Ant."
			.Column4.Header1.ForeColor = RGB(36, 84, 155)
			.Column4.Text1.InputMask   = "999,999,999.99"

			.Column5.FontName          = "Tahoma"
			.Column5.FontSize          = 8
			.Column5.Width             = 80
			.Column5.Movable           = .F.
			.Column5.Resizable         = .F.
			.Column5.ReadOnly          = .T.
			.Column5.Header1.FontName  = "Tahoma"
			.Column5.Header1.FontSize  = 8
			.Column5.Header1.Alignment = 2
			.Column5.Header1.Caption   = "Venda Atual"
			.Column5.Header1.ForeColor = RGB(36, 84, 155)
			.Column5.Text1.InputMask   = "9,999,999.99"

			.Column6.FontName          = "Tahoma"
			.Column6.FontSize          = 8
			.Column6.Width             = 80
			.Column6.Movable           = .F.
			.Column6.Resizable         = .F.
			.Column6.ReadOnly          = .T.
			.Column6.Header1.FontName  = "Tahoma"
			.Column6.Header1.FontSize  = 8
			.Column6.Header1.Alignment = 2
			.Column6.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
			.Column6.Header1.ForeColor = RGB(36, 84, 155)
			.Column6.Text1.InputMask   = "999,999.99"
			.Column6.Text1.ForeColor   = RGB(0, 0, 0)
			.Column6.Text1.BackColor   = RGB(255, 255, 255)

			.Column7.FontName          = "Tahoma"
			.Column7.FontSize          = 8
			.Column7.Width             = 80
			.Column7.Movable           = .F.
			.Column7.Resizable         = .F.
			.Column7.ReadOnly          = .T.
			.Column7.Header1.FontName  = "Tahoma"
			.Column7.Header1.FontSize  = 8
			.Column7.Header1.Alignment = 2
			.Column7.Header1.Caption   = "Custo Ant."
			.Column7.Text1.InputMask   = "999,999,999.9999"
			.Column7.Text1.ForeColor   = RGB(0, 0, 0)
			.Column7.Text1.BackColor   = RGB(255, 255, 255)

			.Column8.FontName          = "Tahoma"
			.Column8.FontSize          = 8
			.Column8.Width             = 80
			.Column8.Movable           = .F.
			.Column8.Resizable         = .F.
			.Column8.ReadOnly          = .T.
			.Column8.Header1.FontName  = "Tahoma"
			.Column8.Header1.FontSize  = 8
			.Column8.Header1.Alignment = 2
			.Column8.Header1.Caption   = "Custo Atual"
			.Column8.Text1.InputMask   = "999,999,999.9999"
			.Column8.Text1.ForeColor   = RGB(0, 0, 0)
			.Column8.Text1.BackColor   = RGB(255, 255, 255)

			.Column9.FontName          = "Tahoma"
			.Column9.FontSize          = 8
			.Column9.Width             = 80
			.Column9.Movable           = .F.
			.Column9.Resizable         = .F.
			.Column9.ReadOnly          = .T.
			.Column9.Header1.FontName  = "Tahoma"
			.Column9.Header1.FontSize  = 8
			.Column9.Header1.Alignment = 2
			.Column9.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
			.Column9.Text1.InputMask   = "999,999.99"
			.Column9.Text1.ForeColor   = RGB(0, 0, 0)
			.Column9.Text1.BackColor   = RGB(255, 255, 255)
		ENDWITH

		*-- Cursor local da grade (Create Cursor CrProdutos(...) do legado)
		IF USED("cursor_4c_Produtos")
			USE IN cursor_4c_Produtos
		ENDIF

		*-- Os 9 primeiros campos sao os do "Create Cursor CrProdutos" legado, na
		*-- MESMA ordem (as 9 colunas da grade). Os seguintes nao existem no
		*-- legado porque la o registro recalculado ficava em CrSigCdPro: aqui
		*-- viajam junto com a linha para que AtualizarPrecos() grave sem
		*-- reconsultar SigCdPro (cgrus eh usado na reclassificacao de subgrupo
		*-- por faixa, e nao aparece na grade).
		SET NULL ON
		CREATE CURSOR cursor_4c_Produtos (lMarca N(1), cpros C(14), dpros C(40), ;
			valant N(14,2), valatu N(14,2), custoafs N(12,4), custofs N(12,4), ;
			pvarias N(8,2), cvarias N(8,2), pvideals N(14,5), fcustos N(11,5), ;
			fvendas N(7,3), moecs C(3), moevs C(3), cgrus C(3))
		SET NULL OFF
		INDEX ON cpros TAG cpros
		SELECT cursor_4c_Produtos
		SET ORDER TO
		GO TOP

		THIS.grd_4c_Produtos.ColumnCount = 9
		THIS.grd_4c_Produtos.RecordSource          = "cursor_4c_Produtos"
		THIS.grd_4c_Produtos.Column1.ControlSource  = "cursor_4c_Produtos.lMarca"
		THIS.grd_4c_Produtos.Column2.ControlSource  = "cursor_4c_Produtos.cpros"
		THIS.grd_4c_Produtos.Column3.ControlSource  = "cursor_4c_Produtos.dpros"
		THIS.grd_4c_Produtos.Column4.ControlSource  = "cursor_4c_Produtos.valant"
		THIS.grd_4c_Produtos.Column5.ControlSource  = "cursor_4c_Produtos.valatu"
		THIS.grd_4c_Produtos.Column6.ControlSource  = "cursor_4c_Produtos.pvarias"
		THIS.grd_4c_Produtos.Column7.ControlSource  = "cursor_4c_Produtos.custoafs"
		THIS.grd_4c_Produtos.Column8.ControlSource  = "cursor_4c_Produtos.custofs"
		THIS.grd_4c_Produtos.Column9.ControlSource  = "cursor_4c_Produtos.cvarias"

		*-- RecordSource/ControlSource resetam Width e Header1.Caption -
		*-- reconfigurar SEMPRE depois de vincular (CLAUDE.md Problema 48)
		THIS.grd_4c_Produtos.Column1.Width           = 17
		THIS.grd_4c_Produtos.Column2.Width           = 108
		THIS.grd_4c_Produtos.Column2.Header1.Caption = "Produto"
		THIS.grd_4c_Produtos.Column3.Width           = 290
		THIS.grd_4c_Produtos.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
		THIS.grd_4c_Produtos.Column4.Width           = 80
		THIS.grd_4c_Produtos.Column4.Header1.Caption = "Venda Ant."
		THIS.grd_4c_Produtos.Column5.Width           = 80
		THIS.grd_4c_Produtos.Column5.Header1.Caption = "Venda Atual"
		THIS.grd_4c_Produtos.Column6.Width           = 80
		THIS.grd_4c_Produtos.Column6.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o (%)"
		THIS.grd_4c_Produtos.Column7.Width           = 80
		THIS.grd_4c_Produtos.Column7.Header1.Caption = "Custo Ant."
		THIS.grd_4c_Produtos.Column8.Width           = 80
		THIS.grd_4c_Produtos.Column8.Header1.Caption = "Custo Atual"
		THIS.grd_4c_Produtos.Column9.Width           = 80
		THIS.grd_4c_Produtos.Column9.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o (%)"

		*-- RecordSource tambem pode derrubar CurrentControl/Sparse da coluna checkbox
		THIS.grd_4c_Produtos.Column1.CurrentControl = "chk_4c_Marca"
		THIS.grd_4c_Produtos.Column1.Sparse         = .F.
		THIS.grd_4c_Produtos.Column1.ReadOnly       = .F.

		*-- CheckBox de coluna de Grid nao alterna pelo binding nativo: os 4
		*-- eventos tem de ser ligados (KeyPress alterna; Click/MouseDown/
		*-- MouseUp suprimem o toggle padrao para nao alternar duas vezes)
		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "MouseUp", THIS, "ChkMarcaMouseUp")
		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "MouseDown", THIS, "ChkMarcaMouseDown")
		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "Click", THIS, "ChkMarcaClick")

		THIS.grd_4c_Produtos.Refresh()
	ENDPROC

	*====================================================================
	* ConfigurarFotoProduto - Image FigJpg do legado (foto do produto da
	* linha corrente da grade): Top=128, Left=764, Width=223, Height=190,
	* Stretch=1, Visible=.F. - nasce OCULTA e so aparece quando o produto
	* selecionado tem imagem (identico ao SCX).
	*
	* Liga os dois eventos que o legado tem em volta dela:
	*   Grd_Produto.AfterRowColChange -> recarrega a foto da nova linha
	*   FigJpg.DblClick               -> abre a foto ampliada (SigOpZom)
	*====================================================================
	PROTECTED PROCEDURE ConfigurarFotoProduto()
		THIS.AddObject("img_4c_FigJpg", "Image")
		WITH THIS.img_4c_FigJpg
			.Top     = 128
			.Left    = 764
			.Width   = 223
			.Height  = 190
			.Stretch = 1
			.Picture = ""
			.Visible = .F.
		ENDWITH

		BINDEVENT(THIS.grd_4c_Produtos, "AfterRowColChange", THIS, "GrdProdutosAfterRowColChange")
		BINDEVENT(THIS.img_4c_FigJpg, "DblClick", THIS, "FigJpgDblClick")
	ENDPROC

	*====================================================================
	* GrdProdutosAfterRowColChange - PUBLIC e com o parametro do evento
	* declarado (CLAUDE.md regra #3: handler de AfterRowColChange precisa
	* receber par_nColIndex, senao BINDEVENT falha em runtime).
	*
	* Transcricao do AfterRowColChange legado: le SigCdPro.FigJpgs do
	* produto da linha corrente, decodifica o base64 (STRCONV(...,14) UMA
	* unica vez - decodificar duas vezes corrompe o JPEG), grava num
	* arquivo temporario e aponta a Image para ele. Sem foto, a Image volta
	* a ficar oculta - igual ao legado, que sempre limpa antes de tentar.
	*====================================================================
	PROCEDURE GrdProdutosAfterRowColChange(par_nColIndex)
		LOCAL loc_cCpros, loc_cSQL, loc_nResultado, loc_cFigJpgs
		LOCAL loc_cArqTemp, loc_cFoto, loc_oErro, loc_lProsseguir
		loc_lProsseguir = .T.

		TRY
			*-- Legado sempre ESCONDE antes de tentar carregar
			THIS.img_4c_FigJpg.Visible = .F.
			THIS.img_4c_FigJpg.Picture = ""

			IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				loc_cCpros = ALLTRIM(TratarNulo(cursor_4c_Produtos.cpros, ""))
				IF EMPTY(loc_cCpros)
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF USED("cursor_4c_TmpFoto")
					USE IN cursor_4c_TmpFoto
				ENDIF
				loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCpros)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFoto")

				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFoto") OR ;
						RECCOUNT("cursor_4c_TmpFoto") = 0
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				SELECT cursor_4c_TmpFoto
				GO TOP
				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFoto.FigJpgs, "")
				USE IN cursor_4c_TmpFoto

				IF !EMPTY(loc_cFigJpgs)
					loc_cArqTemp = SYS(2023) + "\TempCj.jpg"
					loc_cFoto = STRCONV( ;
						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
							"data:image/png;base64,", ""), ;
							"data:image/jpeg;base64,", ""), ;
							"data:image/jpg;base64,", ""), 14)
					STRTOFILE(loc_cFoto, loc_cArqTemp)
					IF FILE(loc_cArqTemp)
						THIS.img_4c_FigJpg.Picture = loc_cArqTemp
						THIS.img_4c_FigJpg.Visible = .T.
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_TmpFoto")
				USE IN cursor_4c_TmpFoto
			ENDIF
		CATCH TO loc_oErro
			IF USED("cursor_4c_TmpFoto")
				USE IN cursor_4c_TmpFoto
			ENDIF
			MsgErro("Erro ao carregar a foto do produto:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* FigJpgDblClick - PUBLIC (BINDEVENT DblClick em img_4c_FigJpg).
	* Transcricao do DblClick legado: reextrai a foto do produto corrente
	* para um arquivo temporario proprio e abre o visualizador ampliado
	* (o legado faz "Do Form SigOpZom With lcArquivo, titulo, ' '").
	* FormSigOpZom ainda nao foi migrado - o fallback abre a imagem no
	* visualizador do Windows (ShellExecute), padrao canonico ja usado em
	* FormSigPrCtr/Formsigmvdis.
	*====================================================================
	PROCEDURE FigJpgDblClick()
		LOCAL loc_cCpros, loc_cDpros, loc_cSQL, loc_nResultado, loc_cFigJpgs
		LOCAL loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro, loc_lProsseguir
		loc_lProsseguir = .T.

		TRY
			IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				loc_cCpros = ALLTRIM(TratarNulo(cursor_4c_Produtos.cpros, ""))
				loc_cDpros = ALLTRIM(TratarNulo(cursor_4c_Produtos.dpros, ""))
				IF EMPTY(loc_cCpros)
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF USED("cursor_4c_TmpFotoZom")
					USE IN cursor_4c_TmpFotoZom
				ENDIF
				loc_cSQL = "SELECT a.Cpros, a.FigJpgs FROM SigCdPro a WHERE a.Cpros = " + ;
					EscaparSQL(loc_cCpros)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoZom")

				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFotoZom") OR ;
						RECCOUNT("cursor_4c_TmpFotoZom") = 0
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				SELECT cursor_4c_TmpFotoZom
				GO TOP
				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoZom.FigJpgs, "")
				USE IN cursor_4c_TmpFotoZom

				IF !EMPTY(loc_cFigJpgs)
					loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
					loc_cFoto = STRCONV( ;
						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
							"data:image/png;base64,", ""), ;
							"data:image/jpeg;base64,", ""), ;
							"data:image/jpg;base64,", ""), 14)
					STRTOFILE(loc_cFoto, loc_cArqTemp)

					IF FILE(loc_cArqTemp)
						loc_cCaption = "Produto : " + loc_cCpros + " - " + loc_cDpros

						IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
								FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
							DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
								WITH loc_cArqTemp, loc_cCaption, " "
						ELSE
							DECLARE INTEGER ShellExecute IN shell32.dll ;
								INTEGER hWnd, STRING lpOperation, STRING lpFile, ;
								STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
							ShellExecute(0, "open", loc_cArqTemp, "", "", 1)
						ENDIF
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_TmpFotoZom")
				USE IN cursor_4c_TmpFotoZom
			ENDIF
		CATCH TO loc_oErro
			IF USED("cursor_4c_TmpFotoZom")
				USE IN cursor_4c_TmpFotoZom
			ENDIF
			MsgErro("Erro ao ampliar a foto do produto:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* Toggle do CheckBox da coluna 1 da grade (Column1.Check1 do legado).
	* CheckBox em coluna de Grid NAO alterna pelo binding nativo: o valor
	* tem de ser trocado por codigo, e os tres eventos de mouse precisam
	* suprimir o comportamento padrao (NODEFAULT) para nao alternar duas
	* vezes. Os quatro handlers sao PUBLIC (alvo de BINDEVENT).
	*
	* O gate vem do "When" legado (Return(!Empty(CrProdutos.CPros))): a
	* celula so aceita marcacao em linha que tenha produto - por isso ele
	* mora DENTRO do KeyPress, nao num When ligado por BINDEVENT (BINDEVENT
	* descarta o retorno do delegate e um When assim nao bloquearia nada).
	*====================================================================
	PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Produtos") AND ;
				!EOF("cursor_4c_Produtos") AND ;
				!EMPTY(TratarNulo(cursor_4c_Produtos.cpros, ""))
			REPLACE lMarca WITH IIF(cursor_4c_Produtos.lMarca = 0, 1, 0) IN cursor_4c_Produtos
			THIS.grd_4c_Produtos.Refresh()
			NODEFAULT
		ENDIF
	ENDPROC

	PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
		THIS.ChkMarcaKeyPress(13, 0)
		NODEFAULT
	ENDPROC

	PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
		NODEFAULT
	ENDPROC

	PROCEDURE ChkMarcaClick()
		NODEFAULT
	ENDPROC

	*====================================================================
	* ConfigurarBotoesAcao - Botoes de acao do legado: CommandGroup Sair
	* (Processar/Atualizar/Encerrar), Impress?o (abre o relatorio
	* FormSIGPRCCR ja migrado - "Do Form SigPrCcr" no legado) e
	* cmdSelemp/CmdApgEmp (Selecionar/Desmarcar Tudo, ao lado da grade).
	* Posicoes/icones EXATOS do SCX (form 1000x600, sem PageFrame).
	*====================================================================
	PROTECTED PROCEDURE ConfigurarBotoesAcao()
		LOCAL loc_cIcones
		loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

		*-- CommandGroup Sair do legado -> Processar / Atualizar / Encerrar
		THIS.AddObject("cmg_4c_Acoes", "CommandGroup")
		WITH THIS.cmg_4c_Acoes
			.Top         = -2
			.Left        = 770
			.Width       = 235
			.Height      = 85
			.BackStyle   = 0
			.BorderStyle = 0
			.ButtonCount = 3
			.Themes      = .F.
			.Value       = 1

			WITH .Buttons(1)
				.Top        = 5
				.Left       = 5
				.Width      = 75
				.Height     = 75
				.Caption    = "Processar"
				.Picture    = loc_cIcones + "geral_processar_60.jpg"
				.FontName   = "Comic Sans MS"
				.FontBold   = .T.
				.FontItalic = .T.
				.FontSize   = 8
				.ForeColor  = RGB(90, 90, 90)
				.BackColor  = RGB(255, 255, 255)
				.Themes     = .F.
				.WordWrap   = .T.
			ENDWITH

			WITH .Buttons(2)
				.Top        = 5
				.Left       = 80
				.Width      = 75
				.Height     = 75
				.Caption    = "Atualizar"
				.Picture    = loc_cIcones + "cadastro_salvar_60.jpg"
				.FontName   = "Comic Sans MS"
				.FontBold   = .T.
				.FontItalic = .T.
				.FontSize   = 8
				.ForeColor  = RGB(90, 90, 90)
				.BackColor  = RGB(255, 255, 255)
				.Themes     = .F.
				.WordWrap   = .T.
				.Enabled    = .F.
			ENDWITH

			WITH .Buttons(3)
				.Top        = 5
				.Left       = 155
				.Width      = 75
				.Height     = 75
				.Cancel     = .T.
				.Caption    = "Encerrar"
				.Picture    = loc_cIcones + "cadastro_sair_60.jpg"
				.FontName   = "Comic Sans MS"
				.FontBold   = .T.
				.FontItalic = .T.
				.FontSize   = 8
				.ForeColor  = RGB(90, 90, 90)
				.BackColor  = RGB(255, 255, 255)
				.Themes     = .F.
				.WordWrap   = .T.
			ENDWITH
		ENDWITH
		BINDEVENT(THIS.cmg_4c_Acoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
		BINDEVENT(THIS.cmg_4c_Acoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
		BINDEVENT(THIS.cmg_4c_Acoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")

		*-- Decorativo (Shape2 do legado) - acompanha a visibilidade do Imprimir
		THIS.AddObject("shp_4c_Shape2", "Shape")
		WITH THIS.shp_4c_Shape2
			.Top         = 6
			.Left        = 650
			.Width       = 10
			.Height      = 6
			.BackStyle   = 0
			.BorderStyle = 0
			.BorderColor = RGB(136, 189, 188)
		ENDWITH

		*-- Imprimir (Impress?o no legado) - abre o relatorio ja migrado
		*-- (FormSIGPRCCR), equivalente a "Do Form SigPrCcr". Comeca
		*-- desabilitado ate o 1o Processar bem sucedido (Init legado:
		*-- Impress?o.Enabled = .f.)
		THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
		WITH THIS.cmd_4c_Imprimir
			.Top             = 3
			.Left            = 700
			.Width           = 75
			.Height          = 75
			.Caption         = "Imprimir"
			.Picture         = loc_cIcones + "geral_impressora_normal_60.jpg"
			.DisabledPicture = loc_cIcones + "geral_impressora_normal_60.jpg"
			.Themes          = .T.
			.FontName        = "Comic Sans MS"
			.FontBold        = .T.
			.FontItalic      = .T.
			.FontSize        = 8
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.SpecialEffect   = 0
			.PicturePosition = 13
			.MousePointer    = 15
			.WordWrap        = .T.
			.AutoSize        = .F.
			.Enabled         = .F.
			.Visible         = fChecaAcesso("SigPrCcp", "IMPRIMIR")
		ENDWITH
		BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "BtnImprimirClick")
		THIS.shp_4c_Shape2.Visible = THIS.cmd_4c_Imprimir.Visible

		*-- Selecionar/Desmarcar Tudo (cmdSelemp/CmdApgEmp no legado)
		THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
		WITH THIS.cmd_4c_SelTudo
			.Top             = 433
			.Left            = 955
			.Width           = 33
			.Height          = 33
			.Caption         = ""
			.Picture         = loc_cIcones + "geral_adicao_26.jpg"
			.DisabledPicture = loc_cIcones + "geral_adicao_26.jpg"
			.Themes          = .T.
			.ToolTipText     = "Selecionar Tudo"
			.TabStop         = .F.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")

		THIS.AddObject("cmd_4c_Apaga", "CommandButton")
		WITH THIS.cmd_4c_Apaga
			.Top             = 473
			.Left            = 955
			.Width           = 33
			.Height          = 33
			.Caption         = ""
			.Picture         = loc_cIcones + "cadastro_excluir_26.jpg"
			.DisabledPicture = loc_cIcones + "cadastro_excluir_26.jpg"
			.Themes          = .T.
			.ToolTipText     = "Desmarcar Tudo"
			.TabStop         = .F.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
	ENDPROC

	*====================================================================
	* FormParaBO - Hook canonico de FormBase: copia o Value de TODOS os
	* campos/grupos da tela (area "Filtros" + area "Dados") para as
	* propriedades this_c*/this_n* de this_oBusinessObject, consumidas por
	* MontarWhereFiltros/BuscarProdutosFiltrados/Atualizar. Espelha o bloco
	* inicial do metodo "processar" legado (lcMercI = Thisform.getMercI.
	* Value, etc.) - chamado SEMPRE antes de BuscarProdutosFiltrados, senao
	* os filtros digitados na tela nunca chegam ao SQL (o BO ficaria so com
	* os defaults de Init).
	*
	* PROTECTED porque o hook homonimo de FormBase eh PROTECTED e subclasse
	* NAO pode alargar o escopo herdado.
	*
	* Inverso exato de BOParaForm() - ao acrescentar campo, mexer NOS DOIS.
	*====================================================================
	PROTECTED PROCEDURE FormParaBO()
		WITH THIS.this_oBusinessObject
			.this_cFornecs    = ALLTRIM(THIS.txt_4c_Fornecedor.Value)
			.this_cDFornecs   = ALLTRIM(THIS.txt_4c_DescFornecedor.Value)

			.this_cMercI      = ALLTRIM(THIS.txt_4c_GrandeGrupoI.Value)
			.this_cMercF      = ALLTRIM(THIS.txt_4c_GrandeGrupoF.Value)
			.this_cGrupoI     = ALLTRIM(THIS.txt_4c_GrupoI.Value)
			.this_cGrupoF     = ALLTRIM(THIS.txt_4c_GrupoF.Value)
			.this_cSubGrupoI  = ALLTRIM(THIS.txt_4c_SubGrupoI.Value)
			.this_cSubGrupoF  = ALLTRIM(THIS.txt_4c_SubGrupoF.Value)
			.this_cUnidadeI   = ALLTRIM(THIS.txt_4c_UnidadeI.Value)
			.this_cUnidadeF   = ALLTRIM(THIS.txt_4c_UnidadeF.Value)
			.this_cLinhaI     = ALLTRIM(THIS.txt_4c_LinhaI.Value)
			.this_cLinhaF     = ALLTRIM(THIS.txt_4c_LinhaF.Value)
			.this_cColecaoI   = ALLTRIM(THIS.txt_4c_ColecaoI.Value)
			.this_cColecaoF   = ALLTRIM(THIS.txt_4c_ColecaoF.Value)
			.this_cMoedaI     = ALLTRIM(THIS.txt_4c_MoedaI.Value)
			.this_cMoedaF     = ALLTRIM(THIS.txt_4c_MoedaF.Value)

			.this_nMarkupI    = THIS.txt_4c_MarkupI.Value
			.this_nMarkupF    = THIS.txt_4c_MarkupF.Value
			.this_nEncargoI   = THIS.txt_4c_EncargoI.Value
			.this_nEncargoF   = THIS.txt_4c_EncargoF.Value
			.this_nVariacao   = THIS.txt_4c_Variacao.Value

			.this_cFeitio     = ALLTRIM(THIS.txt_4c_Feitio.Value)
			.this_cNovoFeitio = ALLTRIM(THIS.txt_4c_NovoMkp.Value)

			.this_nOpcaoMoeda    = THIS.obj_4c_OpcaoMoeda.Value
			.this_nSituacao      = THIS.obj_4c_Situacao.Value
			.this_nOpcaoCompra   = THIS.obj_4c_Compra.Value
			.this_nTipoRecalculo = THIS.obj_4c_Recalcula.Value
			.this_nAtualizaVenda = THIS.obj_4c_AtualizaVenda.Value

			.this_nReajuste      = THIS.txt_4c_Reajuste.Value
			.this_nNovoMarkup    = THIS.txt_4c_NovoMarkup.Value
			.this_nNovoEncargo   = THIS.txt_4c_NovoEncargo.Value
		ENDWITH
	ENDPROC

	*====================================================================
	* BOParaForm - Hook canonico de FormBase, INVERSO exato de FormParaBO:
	* joga as propriedades de filtro/dados do BO nos controles da tela, na
	* mesma ordem e com os mesmos pares.
	*
	* Usado no fim da montagem (InicializarForm) para que os DEFAULTS
	* venham de um lugar so - o DEFINE CLASS do sigprccpBO - em vez de
	* ficarem repetidos nos AddObject dos OptionGroups; e por LimparCampos,
	* que devolve a tela ao estado inicial resetando o BO.
	*
	* Os OptionGroups passam por AplicarValorOptionGroup porque .Value eh o
	* INDICE do botao (1..ButtonCount) e o VFP9 recusa indice fora da
	* faixa - o valor pode ter vindo de SigCdCcp, que eh dado de usuario.
	*
	* PROTECTED porque o hook homonimo de FormBase eh PROTECTED e subclasse
	* NAO pode alargar o escopo herdado.
	*====================================================================
	PROTECTED PROCEDURE BOParaForm()
		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN
		ENDIF

		WITH THIS.this_oBusinessObject
			*-- Filtros
			THIS.txt_4c_Fornecedor.Value     = ALLTRIM(.this_cFornecs)
			THIS.txt_4c_DescFornecedor.Value = ALLTRIM(.this_cDFornecs)

			THIS.txt_4c_GrandeGrupoI.Value   = ALLTRIM(.this_cMercI)
			THIS.txt_4c_GrandeGrupoF.Value   = ALLTRIM(.this_cMercF)
			THIS.txt_4c_GrupoI.Value         = ALLTRIM(.this_cGrupoI)
			THIS.txt_4c_GrupoF.Value         = ALLTRIM(.this_cGrupoF)
			THIS.txt_4c_SubGrupoI.Value      = ALLTRIM(.this_cSubGrupoI)
			THIS.txt_4c_SubGrupoF.Value      = ALLTRIM(.this_cSubGrupoF)
			THIS.txt_4c_UnidadeI.Value       = ALLTRIM(.this_cUnidadeI)
			THIS.txt_4c_UnidadeF.Value       = ALLTRIM(.this_cUnidadeF)
			THIS.txt_4c_LinhaI.Value         = ALLTRIM(.this_cLinhaI)
			THIS.txt_4c_LinhaF.Value         = ALLTRIM(.this_cLinhaF)
			THIS.txt_4c_ColecaoI.Value       = ALLTRIM(.this_cColecaoI)
			THIS.txt_4c_ColecaoF.Value       = ALLTRIM(.this_cColecaoF)
			THIS.txt_4c_MoedaI.Value         = ALLTRIM(.this_cMoedaI)
			THIS.txt_4c_MoedaF.Value         = ALLTRIM(.this_cMoedaF)

			THIS.txt_4c_MarkupI.Value        = .this_nMarkupI
			THIS.txt_4c_MarkupF.Value        = .this_nMarkupF
			THIS.txt_4c_EncargoI.Value       = .this_nEncargoI
			THIS.txt_4c_EncargoF.Value       = .this_nEncargoF
			THIS.txt_4c_Variacao.Value       = .this_nVariacao

			THIS.txt_4c_Feitio.Value         = ALLTRIM(.this_cFeitio)
			THIS.txt_4c_NovoMkp.Value        = ALLTRIM(.this_cNovoFeitio)

			*-- Dados
			THIS.txt_4c_Reajuste.Value       = .this_nReajuste
			THIS.txt_4c_NovoMarkup.Value     = .this_nNovoMarkup
			THIS.txt_4c_NovoEncargo.Value    = .this_nNovoEncargo
		ENDWITH

		*-- OptionGroups FORA do WITH, com o caminho escrito por inteiro: um
		*-- WITH aberto sequestra a resolucao de todo nome que comeca por ponto,
		*-- e chamada de metodo do form com argumentos ".this_n*" dentro dele eh
		*-- justamente o que produz "Property X is not found" (CLAUDE.md #33).
		THIS.AplicarValorOptionGroup(THIS.obj_4c_OpcaoMoeda, ;
			THIS.this_oBusinessObject.this_nOpcaoMoeda)
		THIS.AplicarValorOptionGroup(THIS.obj_4c_Situacao, ;
			THIS.this_oBusinessObject.this_nSituacao)
		THIS.AplicarValorOptionGroup(THIS.obj_4c_Compra, ;
			THIS.this_oBusinessObject.this_nOpcaoCompra)
		THIS.AplicarValorOptionGroup(THIS.obj_4c_Recalcula, ;
			THIS.this_oBusinessObject.this_nTipoRecalculo)
		THIS.AplicarValorOptionGroup(THIS.obj_4c_AtualizaVenda, ;
			THIS.this_oBusinessObject.this_nAtualizaVenda)

		*-- Recalcula comanda o Enabled de Reajuste/NovoMarkup/Variacao/NovoMkp
		*-- (as clausulas When do legado) - tem de rodar DEPOIS dos valores.
		THIS.AtualizarEstadoCalculo()
	ENDPROC

	*====================================================================
	* LimparCampos - Hook canonico de FormBase. Aqui NAO limpa os filtros
	* digitados (o legado nunca os apaga - eles ficam na tela para o
	* usuario reprocessar variando um parametro so); limpa o RESULTADO:
	* zera o cursor da grade, esconde a foto do produto e devolve a tela ao
	* modo "LISTA", que desabilita Atualizar/Imprimir.
	*
	* Eh a transcricao do "Zap In CrProdutos" que o legado repete em tres
	* lugares - no inicio de Processa.Click (antes de reprocessar), no fim
	* de "atualizar" (junto dos Zap dos demais cursores de trabalho) e em
	* cada volta do Scan de "processaautomatico".
	*
	* ZAP, nunca USE IN + CREATE CURSOR: recriar o cursor derrubaria
	* RecordSource/ControlSource do Grid (e com eles Column.Width,
	* Header1.Caption, Sparse e CurrentControl do CheckBox).
	*
	* PROTECTED porque o hook homonimo de FormBase eh PROTECTED e subclasse
	* NAO pode alargar o escopo herdado.
	*====================================================================
	PROTECTED PROCEDURE LimparCampos()
		IF USED("cursor_4c_Produtos")
			ZAP IN cursor_4c_Produtos
		ENDIF

		*-- "ThisForm.FigJpg.Visible = .F. / .Picture = ''" do legado: sem
		*-- linha na grade nao ha produto, logo nao ha foto a exibir.
		IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
			THIS.img_4c_FigJpg.Visible = .F.
			THIS.img_4c_FigJpg.Picture = ""
		ENDIF

		THIS.this_cModoAtual = "LISTA"
		THIS.AjustarBotoesPorModo()

		IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
			THIS.grd_4c_Produtos.Refresh()
		ENDIF
	ENDPROC

	*====================================================================
	* HabilitarCampos - Liga/desliga em bloco TODOS os campos de entrada da
	* tela (area "Filtros" + area "Dados" + os dois botoes de marcacao da
	* grade). Existe porque AtualizarPrecos roda um lote longo com barra de
	* progresso, e a barra faz o VFP processar eventos: sem travar a
	* entrada, o usuario consegue reescrever um filtro ou (re)marcar linhas
	* NO MEIO da gravacao, e a partir dai a tela deixa de descrever o que
	* esta sendo gravado.
	*
	* Ao REABILITAR, as regras condicionais do legado sao repostas por
	* AtualizarEstadoCalculo (clausulas When de Reajuste/NovoMarkup/
	* Variacao/NovoMkp) e a Descricao do Fornecedor volta a ser somente
	* leitura - ela tem "Return .F." no When do legado (getDFornecs), isto
	* eh, NUNCA recebe foco.
	*
	* PUBLIC - chamado de fora da classe pelo harness de teste (CLAUDE.md
	* regra #3).
	*====================================================================
	PROCEDURE HabilitarCampos(par_lHabilitar)
		LOCAL loc_lLiga, loc_nI, loc_aCampos[1]

		loc_lLiga = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

		*-- Campos de FILTRO
		DIMENSION loc_aCampos[28]
		loc_aCampos[ 1] = "txt_4c_Fornecedor"
		loc_aCampos[ 2] = "txt_4c_DescFornecedor"
		loc_aCampos[ 3] = "txt_4c_GrandeGrupoI"
		loc_aCampos[ 4] = "txt_4c_GrandeGrupoF"
		loc_aCampos[ 5] = "txt_4c_GrupoI"
		loc_aCampos[ 6] = "txt_4c_GrupoF"
		loc_aCampos[ 7] = "txt_4c_SubGrupoI"
		loc_aCampos[ 8] = "txt_4c_SubGrupoF"
		loc_aCampos[ 9] = "txt_4c_UnidadeI"
		loc_aCampos[10] = "txt_4c_UnidadeF"
		loc_aCampos[11] = "txt_4c_LinhaI"
		loc_aCampos[12] = "txt_4c_LinhaF"
		loc_aCampos[13] = "txt_4c_ColecaoI"
		loc_aCampos[14] = "txt_4c_ColecaoF"
		loc_aCampos[15] = "txt_4c_MoedaI"
		loc_aCampos[16] = "txt_4c_MoedaF"
		loc_aCampos[17] = "txt_4c_MarkupI"
		loc_aCampos[18] = "txt_4c_MarkupF"
		loc_aCampos[19] = "txt_4c_EncargoI"
		loc_aCampos[20] = "txt_4c_EncargoF"
		loc_aCampos[21] = "txt_4c_Variacao"
		loc_aCampos[22] = "txt_4c_Feitio"
		loc_aCampos[23] = "obj_4c_OpcaoMoeda"
		loc_aCampos[24] = "obj_4c_Situacao"
		loc_aCampos[25] = "obj_4c_Compra"
		*-- Campos da area DADOS
		loc_aCampos[26] = "txt_4c_NovoMkp"
		loc_aCampos[27] = "obj_4c_AtualizaVenda"
		loc_aCampos[28] = "obj_4c_Recalcula"

		FOR loc_nI = 1 TO ALEN(loc_aCampos)
			IF PEMSTATUS(THIS, loc_aCampos[loc_nI], 5)
				STORE loc_lLiga TO ("THIS." + loc_aCampos[loc_nI] + ".Enabled")
			ENDIF
		ENDFOR

		*-- Reajuste/NovoMarkup entram aqui e NAO no laco acima: quando
		*-- loc_lLiga eh .T. quem manda neles eh AtualizarEstadoCalculo
		*-- (clausulas When do legado), chamado no fim deste metodo.
		IF !loc_lLiga
			THIS.txt_4c_Reajuste.Enabled    = .F.
			THIS.txt_4c_NovoMarkup.Enabled  = .F.
			THIS.txt_4c_NovoEncargo.Enabled = .F.
		ELSE
			THIS.txt_4c_NovoEncargo.Enabled = .T.
		ENDIF

		*-- Marcar/Desmarcar Tudo acompanham a entrada, mas por VISIBLE e nao
		*-- por Enabled: sao botoes SO de icone (Caption = "") e, com
		*-- Enabled = .F., o VFP9 nao desenha o icone - o botao viraria um
		*-- retangulo vazio na tela em vez de um botao apagado.
		IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
			THIS.cmd_4c_SelTudo.Visible = loc_lLiga
		ENDIF
		IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
			THIS.cmd_4c_Apaga.Visible = loc_lLiga
		ENDIF

		IF loc_lLiga
			*-- getDFornecs tem "Return .F." no When do legado: a descricao do
			*-- fornecedor eh preenchida pelo lookup e nunca recebe foco.
			THIS.txt_4c_DescFornecedor.Enabled = .F.
			THIS.AtualizarEstadoCalculo()
		ENDIF
	ENDPROC

	*====================================================================
	* AjustarBotoesPorModo - FUNIL unico do Enabled dos botoes de acao.
	* Esta tela tem dois estados, exatamente os que o legado liga e
	* desliga:
	*
	*   "LISTA"      - nada processado (grade vazia). Atualizar e Imprimir
	*                  DESABILITADOS: "ThisForm.Sair.Atualiza.Enabled = .F."
	*                  + "ThisForm.Impress?o.Enabled = .f." no fim do Init,
	*                  e de novo no fim de "atualizar", que zera a grade.
	*   "PROCESSADO" - Processar trouxe linhas. Os dois HABILITADOS:
	*                  "This.Parent.Atualiza.Enabled = .T." +
	*                  "Thisform.Impress?o.Enabled = .T." em Processa.Click.
	*
	* Processar e Encerrar NUNCA sao desabilitados (o legado tambem nao os
	* toca): sem Processar a tela nao tem entrada, e sem Encerrar nao tem
	* saida - este form eh modal, com TitleBar = 0 e ControlBox = .F.
	*
	* O Enabled sai do modo E da contagem real de linhas, para a grade
	* vazia nunca habilitar a gravacao mesmo que o modo esteja errado.
	* Imprimir respeita o controle de acesso: se fChecaAcesso o escondeu no
	* Init, ele segue invisivel - habilitar o que nao se ve eh inofensivo,
	* mas mexer no Visible aqui reverteria o acesso.
	*
	* PUBLIC - chamado de fora da classe pelo harness de teste (CLAUDE.md
	* regra #3).
	*====================================================================
	PROCEDURE AjustarBotoesPorModo()
		LOCAL loc_lProcessado, loc_nLinhas

		loc_nLinhas = 0
		IF USED("cursor_4c_Produtos")
			loc_nLinhas = RECCOUNT("cursor_4c_Produtos")
		ENDIF

		loc_lProcessado = (THIS.this_cModoAtual == "PROCESSADO") AND (loc_nLinhas > 0)

		IF PEMSTATUS(THIS, "cmg_4c_Acoes", 5)
			THIS.cmg_4c_Acoes.Buttons(2).Enabled = loc_lProcessado
			THIS.cmg_4c_Acoes.Buttons(2).Refresh()
		ENDIF

		IF PEMSTATUS(THIS, "cmd_4c_Imprimir", 5)
			THIS.cmd_4c_Imprimir.Enabled = loc_lProcessado
			THIS.cmd_4c_Imprimir.Refresh()
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarLista - Consulta os produtos que atendem aos filtros
	* correntes (this_oBusinessObject.BuscarProdutosFiltrados, que
	* transcreve a fase de consulta do metodo "processar" legado) e
	* transfere o resultado para o cursor da grade - espelha o
	* "Insert Into crProdutos (Cpros, DPros, ValAnt, CustoAfs) Values
	* (CrSigCdPro.Cpros, CrSigCdPro.DPros, CrSigCdPro.Pvens,
	* CrSigCdPro.CustoFs)" do Scan principal do legado.
	*
	* PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do form
	* direto de fora da classe (CLAUDE.md regra #3).
	*====================================================================
	PROCEDURE CarregarLista()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN loc_lSucesso
		ENDIF

		THIS.FormParaBO()

		*-- Guard transcrito do inicio de "processar" legado: Recalcula
		*-- Markup Custo/Venda (7/8) exige o Novo Codigo do MKP
		IF INLIST(THIS.this_oBusinessObject.this_nTipoRecalculo, 7, 8) AND ;
				EMPTY(THIS.this_oBusinessObject.this_cNovoFeitio)
			IF !THIS.this_lAutomatico
				MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", "Aten" + CHR(231) + CHR(227) + "o")
				THIS.txt_4c_NovoMkp.SetFocus()
			ENDIF
			RETURN loc_lSucesso
		ENDIF

		IF THIS.this_oBusinessObject.BuscarProdutosFiltrados()
			IF USED("cursor_4c_Produtos")
				ZAP IN cursor_4c_Produtos
			ENDIF

			IF USED("cursor_4c_ProdutosSQL")
				SELECT cursor_4c_ProdutosSQL
				SCAN
					INSERT INTO cursor_4c_Produtos ;
						(lMarca, cpros, dpros, valant, valatu, custoafs, custofs, ;
						 pvarias, cvarias, pvideals, fcustos, fvendas, moecs, moevs, cgrus) ;
					VALUES ;
						(0, ;
						 cursor_4c_ProdutosSQL.cpros, ;
						 cursor_4c_ProdutosSQL.dpros, ;
						 TratarNulo(cursor_4c_ProdutosSQL.pvens, 0), ;
						 TratarNulo(cursor_4c_ProdutosSQL.pvens, 0), ;
						 TratarNulo(cursor_4c_ProdutosSQL.custofs, 0), ;
						 TratarNulo(cursor_4c_ProdutosSQL.custofs, 0), ;
						 0, ;
						 0, ;
						 TratarNulo(cursor_4c_ProdutosSQL.pvideals, 0), ;
						 TratarNulo(cursor_4c_ProdutosSQL.fcustos, 0), ;
						 TratarNulo(cursor_4c_ProdutosSQL.fvendas, 0), ;
						 TratarNulo(cursor_4c_ProdutosSQL.moecs, ""), ;
						 TratarNulo(cursor_4c_ProdutosSQL.moevs, ""), ;
						 TratarNulo(cursor_4c_ProdutosSQL.cgrus, ""))
				ENDSCAN
				USE IN cursor_4c_ProdutosSQL
			ENDIF

			SELECT cursor_4c_Produtos
			SET ORDER TO cpros
			GO TOP

			THIS.grd_4c_Produtos.Refresh()
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BtnProcessarClick - Espelha Sair.Processa.Click do legado: confirma
	* reprocessamento se ja existem dados na grade, zera o cursor e chama
	* CarregarLista(). Ao terminar com sucesso, habilita Atualizar e
	* Imprimir (This.Parent.Atualiza.Enabled = .T. / ThisForm.Impress?o.
	* Enabled = .T. do legado) e devolve o foco para a coluna de selecao.
	*
	* PUBLIC - alvo de BINDEVENT (CLAUDE.md regra #3).
	*====================================================================
	PROCEDURE BtnProcessarClick()
		*-- "If Thisform.Automatico / =ThisForm.ProcessaAutomatico()" - no modo
		*-- automatico o botao NAO processa a tela: delega o lote de presets.
		IF THIS.this_lAutomatico
			THIS.ProcessaAutomatico()
			RETURN
		ENDIF

		IF USED("cursor_4c_Produtos")
			SELECT cursor_4c_Produtos
			IF RECCOUNT() > 0
				IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?", ;
						"Aten" + CHR(231) + CHR(227) + "o")
					RETURN
				ENDIF
			ENDIF
		ENDIF

		*-- "Zap In CrProdutos" do legado: descarta o resultado anterior antes
		*-- de reprocessar (e com ele a foto e o estado dos botoes de acao).
		THIS.LimparCampos()

		IF THIS.CarregarLista()
			*-- Filtro de Variacao (%) aplicado DEPOIS do processamento, sobre
			*-- as linhas ja calculadas - transcricao literal do legado:
			*--   lnVaria = Thisform.Get_Variacao.Value
			*--   If lnVaria > 0 -> Delete For PVarias < lnVaria
			*--   If lnVaria < 0 -> Delete For PVarias > lnVaria
			*-- O SINAL eh regra: variacao negativa mantem as QUEDAS de preco
			*-- (descarta o que subiu mais que o limite) e vice-versa.
			THIS.AplicarFiltroVariacao()

			SELECT cursor_4c_Produtos
			SET ORDER TO cpros
			GO TOP

			*-- "This.Parent.Atualiza.Enabled = .T. / Thisform.Impress?o.
			*-- Enabled = .T." do legado, pelo FUNIL - que tambem recusa
			*-- habilitar quando o filtro de Variacao apagou TODAS as linhas
			*-- (grade vazia nao tem o que gravar nem o que imprimir).
			THIS.this_cModoAtual = "PROCESSADO"
			THIS.AjustarBotoesPorModo()

			THIS.grd_4c_Produtos.Column1.SetFocus()
			THIS.grd_4c_Produtos.Refresh()
		ENDIF
	ENDPROC

	*====================================================================
	* AplicarFiltroVariacao - Descarta da grade as linhas cuja variacao de
	* preco nao alcanca o limite informado em Variacao (%). Transcricao do
	* bloco que o legado repete IDENTICO em Processa.Click e em
	* ProcessaAutomatico:
	*     lnVaria = Thisform.Get_Variacao.Value
	*     If lnVaria > 0 / Delete For PVarias < lnVaria / Endif
	*     If lnVaria < 0 / Delete For PVarias > lnVaria / Endif
	*
	* Variacao ZERO nao filtra nada (o legado nao tem ramo para ela).
	* O DELETE so faz a linha desaparecer com SET DELETED ON, reposto em
	* InicializarForm porque DataSession = 2 nasce com DELETED OFF.
	*
	* PUBLIC - chamado tambem por ProcessaAutomatico.
	*====================================================================
	PROCEDURE AplicarFiltroVariacao()
		LOCAL loc_nVariacao

		IF !USED("cursor_4c_Produtos")
			RETURN
		ENDIF

		loc_nVariacao = THIS.txt_4c_Variacao.Value

		SELECT cursor_4c_Produtos
		IF loc_nVariacao > 0
			DELETE FOR cursor_4c_Produtos.pvarias < loc_nVariacao
		ENDIF
		IF loc_nVariacao < 0
			DELETE FOR cursor_4c_Produtos.pvarias > loc_nVariacao
		ENDIF
	ENDPROC

	*====================================================================
	* BtnAtualizarClick - Espelha Sair.Atualiza.Click do legado, que eh
	* apenas o disparo do metodo de gravacao:
	*     If Not ThisForm.Atualizar()
	*         Return .F.
	*     EndIf
	* Toda a logica fica em AtualizarPrecos(), igual ao legado, porque o
	* modo Automatico tambem a chama direto (sem passar pelo botao).
	*
	* PUBLIC - alvo de BINDEVENT (CLAUDE.md regra #3).
	*====================================================================
	PROCEDURE BtnAtualizarClick()
		THIS.AtualizarPrecos()
	ENDPROC

	*====================================================================
	* AtualizarPrecos - Transcricao do metodo "atualizar" legado. Grava os
	* produtos MARCADOS na grade, na ordem exata do legado:
	*
	*   1. Confirma "Atualiza ???"                (Automatico assume Sim)
	*   2. Confirma "Impressao das Etiquetas?"    (Automatico assume Nao)
	*   3. Exige ao menos um produto marcado      (lMarca = 1)
	*   4. Le SigCdPaC.nchksubgrs (liga a reclassificacao de subgrupo)
	*   5. Por produto, DENTRO de uma transacao:
	*        a) SigCdPrc  <- retrato do registro ANTES da gravacao
	*        b) SigPrCp2  <- retrato da composicao corrente
	*        c) SigPrPrt  -> apaga os precos de tabela, agora defasados
	*        d) SigCdPro  -> grava preco/custo novos + ImpEtiqs (+ sGrus)
	*   6. Commit se TUDO gravou; Rollback em qualquer falha
	*   7. Zera a grade e desabilita o proprio botao Atualizar
	*
	* A ORDEM de (a)/(b) antes de (d) eh regra, nao detalhe: o historico
	* guarda o valor ANTIGO. No legado isso acontece porque os cursores
	* remotos so sao descarregados no poDataMgr.Update() do fim; aqui, como
	* cada passo grava na hora, inverter (a) e (d) faria o historico
	* registrar o preco NOVO - errado e sem nenhum sintoma visivel.
	*
	* PUBLIC - alvo de BINDEVENT e chamado por ProcessaAutomatico.
	*====================================================================
	PROCEDURE AtualizarPrecos()
		LOCAL loc_lRetorno, loc_lConfirma, loc_nImpEtiq, loc_nMarcados
		LOCAL loc_oBarra, loc_oBarraFim, loc_nChkSub, loc_cSubGru, loc_nVenda
		LOCAL loc_lTudoOk, loc_nGravados, loc_cCpros, loc_lProsseguir, loc_oErro
		LOCAL loc_cAvisoRollback, loc_oErroRb

		loc_lRetorno = .F.

		IF !USED("cursor_4c_Produtos") OR VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN loc_lRetorno
		ENDIF

		*-- 1) "Atualiza ???" - no modo Automatico o legado assume Sim (lnOk = 6)
		IF THIS.this_lAutomatico
			loc_lConfirma = .T.
		ELSE
			loc_lConfirma = MsgConfirma("Atualiza ???", ;
				"Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
		ENDIF

		IF !loc_lConfirma
			RETURN loc_lRetorno
		ENDIF

		*-- 2) "Confirma a Impressao das Etiquetas?" - o legado grava a resposta
		*-- em SigCdPro.impetiqs de CADA produto atualizado (m.ImpEtiqs =
		*-- llImpEtiq) e assume Nao no modo Automatico. NUMERICO 0/1 porque
		*-- impetiqs eh bit e comparar Logico com 1 estoura type mismatch.
		IF THIS.this_lAutomatico
			loc_nImpEtiq = 0
		ELSE
			loc_nImpEtiq = IIF(MsgConfirma("Confirma a Impress" + CHR(227) + ;
				"o das Etiquetas?", "Etiquetas"), 1, 0)
		ENDIF

		*-- 3) Exige selecao - legado: "Select * From CrProdutos Where lMarca = 1
		*-- Order By CPros Into Cursor CsProdutos" + "If Eof()"
		SELECT cursor_4c_Produtos
		SET ORDER TO cpros
		COUNT FOR lMarca = 1 TO loc_nMarcados

		IF loc_nMarcados = 0
			IF !THIS.this_lAutomatico
				MsgAviso("Nenhum Produto Selecionado !!!", ;
					"Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
				THIS.grd_4c_Produtos.Column1.SetFocus()
			ENDIF
			RETURN loc_lRetorno
		ENDIF

		*-- 4) Parametro que liga a reclassificacao de subgrupo por faixa
		*-- (legado: If crSigCdPac.nChkSubGrs = 1, no fim de "atualizar")
		loc_nChkSub = THIS.this_oBusinessObject.ObterChkSubGrupos()

		loc_lTudoOk    = .T.
		loc_nGravados  = 0
		loc_lProsseguir = .T.
		loc_oBarra     = .NULL.
		loc_oBarraFim  = .NULL.

		TRY
			*-- Trava a entrada durante o lote: a barra de progresso faz o VFP
			*-- processar eventos, e sem isso o usuario consegue reescrever um
			*-- filtro ou desmarcar linhas NO MEIO da gravacao - a partir dai a
			*-- tela deixa de descrever o que esta sendo gravado. Reabilitado
			*-- DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara.
			THIS.HabilitarCampos(.F.)

			*-- Barra "Atualizando os Precos..." (loBarra do legado)
			loc_oBarra = THIS.CriarBarraProgresso("Atualizando os Pre" + CHR(231) + ;
				"os...", loc_nMarcados)

			IF !THIS.this_oBusinessObject.IniciarTransacao()
				MsgErro("Sem conex" + CHR(227) + "o com o banco de dados. " + ;
					"Favor Reinicializar o Processo!!!", "Erro")
				loc_lProsseguir = .F.
				loc_lTudoOk     = .F.
			ENDIF

			IF loc_lProsseguir
				THIS.this_oBusinessObject.this_nImpEtiqs = loc_nImpEtiq

				SELECT cursor_4c_Produtos
				SET ORDER TO cpros
				GO TOP
				SCAN FOR lMarca = 1
					loc_cCpros = ALLTRIM(cursor_4c_Produtos.cpros)

					IF VARTYPE(loc_oBarra) = "O"
						loc_oBarra.Update("Produto: " + loc_cCpros)
					ENDIF

					WITH THIS.this_oBusinessObject
						*-- (a) historico do preco ANTIGO + (b) da composicao
						*-- corrente + (c) expurgo dos precos de tabela: tudo
						*-- ANTES do UPDATE de SigCdPro
						IF !.GravarHistoricoPreco(loc_cCpros)
							loc_lTudoOk = .F.
						ENDIF

						IF loc_lTudoOk AND !.GravarHistoricoComposicao(loc_cCpros)
							loc_lTudoOk = .F.
						ENDIF

						IF loc_lTudoOk AND !.ExcluirPrecosTabela(loc_cCpros)
							loc_lTudoOk = .F.
						ENDIF

						IF loc_lTudoOk
							*-- Reclassificacao de subgrupo por faixa de preco.
							*-- Legado: "If crSigCdPro.pVens = 0 -> lnPVens =
							*-- grSigCdPro.pvideals / Else lnPVens = grSigCdPro.pVens"
							IF loc_nChkSub = 1
								loc_nVenda = IIF(cursor_4c_Produtos.valatu = 0, ;
									cursor_4c_Produtos.pvideals, cursor_4c_Produtos.valatu)
								loc_cSubGru = .ResolverSubGrupoPorFaixa( ;
									ALLTRIM(cursor_4c_Produtos.cgrus), loc_nVenda)
								.this_cSubGrupo          = loc_cSubGru
								.this_lAtualizarSubGrupo = !EMPTY(loc_cSubGru)
							ELSE
								.this_cSubGrupo          = ""
								.this_lAtualizarSubGrupo = .F.
							ENDIF

							*-- (d) preco/custo novos em SigCdPro
							.this_cCpros            = cursor_4c_Produtos.cpros
							.this_cDescricaoProduto = cursor_4c_Produtos.dpros
							.this_nCustoAtual       = cursor_4c_Produtos.custofs
							.this_nVendaAtual       = cursor_4c_Produtos.valatu
							.this_nVendaIdeal       = cursor_4c_Produtos.pvideals
							.this_nFatorCusto       = cursor_4c_Produtos.fcustos
							.this_nFatorVenda       = cursor_4c_Produtos.fvendas
							.this_cMoedaCusto       = cursor_4c_Produtos.moecs
							.this_cMoedaVenda       = cursor_4c_Produtos.moevs

							*-- BusinessBase.Salvar ja reporta a falha sozinho
							*-- (CLAUDE.md regra #20) - nao repetir a mensagem
							IF .EditarRegistro() AND .Salvar()
								loc_nGravados = loc_nGravados + 1
							ELSE
								loc_lTudoOk = .F.
							ENDIF
						ENDIF
					ENDWITH

					IF !loc_lTudoOk
						EXIT
					ENDIF

					SELECT cursor_4c_Produtos
				ENDSCAN
			ENDIF

			IF VARTYPE(loc_oBarra) = "O"
				loc_oBarra.Complete(.T.)
				loc_oBarra = .NULL.
			ENDIF

			IF loc_lProsseguir
				*-- Barra "Atualizando Fisicamente os Arquivos..." (loBarraFim)
				loc_oBarraFim = THIS.CriarBarraProgresso("Atualizando Fisicamente " + ;
					"os Arquivos...", 2)

				IF loc_lTudoOk
					IF VARTYPE(loc_oBarraFim) = "O"
						loc_oBarraFim.Update("Confirmando a grava" + CHR(231) + CHR(227) + "o...")
					ENDIF

					loc_lTudoOk = THIS.this_oBusinessObject.ConfirmarTransacao()

					IF !loc_lTudoOk AND !THIS.this_lAutomatico
						MsgAviso("Falha na Atualiza" + CHR(231) + CHR(227) + ;
							"o. Reinicie o Processo !!!", "Confirma" + CHR(231) + CHR(227) + "o")
					ENDIF
				ELSE
					IF VARTYPE(loc_oBarraFim) = "O"
						loc_oBarraFim.Update("Desfazendo a grava" + CHR(231) + CHR(227) + "o...")
					ENDIF

					THIS.this_oBusinessObject.DesfazerTransacao()

					IF !THIS.this_lAutomatico
						MsgAviso("Falha na Atualiza" + CHR(231) + CHR(227) + ;
							"o. Reinicie o Processo !!!", "Confirma" + CHR(231) + CHR(227) + "o")
					ENDIF
				ENDIF

				IF VARTYPE(loc_oBarraFim) = "O"
					loc_oBarraFim.Complete(.T.)
					loc_oBarraFim = .NULL.
				ENDIF

				IF loc_lTudoOk AND !THIS.this_lAutomatico
					MsgInfo("Processamento Finalizado com Sucesso !!!", "Confirmar")
				ENDIF

				*-- 7) O legado zera TODOS os cursores de trabalho no fim, com
				*-- sucesso OU com falha (os Zap ficam fora do If llOk). Aqui so
				*-- existe o cursor local da grade, e quem o zera eh
				*-- LimparCampos - que faz o ZAP (nao USE IN + CREATE CURSOR,
				*-- que derrubaria RecordSource/ControlSource do Grid), esconde a
				*-- foto e devolve a tela ao modo "LISTA", desabilitando
				*-- Atualizar/Imprimir junto ("ThisForm.Sair.Atualiza.Enabled =
				*-- .F." do Init, repetido na ultima linha de "atualizar").
				THIS.LimparCampos()

				loc_lRetorno = loc_lTudoOk
			ENDIF
		CATCH TO loc_oErro
			*-- Qualquer excecao no meio do lote desfaz TUDO: gravacao parcial de
			*-- preco eh pior que gravacao nenhuma. O rollback vai num TRY
			*-- proprio porque ele tambem pode falhar (conexao caida) e nesse
			*-- caso o que interessa reportar eh o erro ORIGINAL - mas a falha
			*-- do rollback entra na mensagem, senao ninguem fica sabendo que
			*-- a gravacao ficou incompleta.
			loc_cAvisoRollback = ""
			TRY
				THIS.this_oBusinessObject.DesfazerTransacao()
			CATCH TO loc_oErroRb
				loc_cAvisoRollback = CHR(13) + "ATEN" + CHR(199) + CHR(195) + ;
					"O: falha ao desfazer a grava" + CHR(231) + CHR(227) + "o (" + ;
					loc_oErroRb.Message + ") - conferir os pre" + CHR(231) + ;
					"os dos produtos marcados."
			ENDTRY

			MsgErro("Erro ao atualizar os pre" + CHR(231) + "os:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure + loc_cAvisoRollback, "Erro")

			loc_lRetorno = .F.
		ENDTRY

		*-- Libera as barras tambem quando o CATCH disparou no meio
		IF VARTYPE(loc_oBarra) = "O"
			loc_oBarra.Release()
		ENDIF
		IF VARTYPE(loc_oBarraFim) = "O"
			loc_oBarraFim.Release()
		ENDIF

		*-- Devolve a entrada ao usuario. Fica aqui, junto da liberacao das
		*-- barras, para valer TAMBEM quando o CATCH disparou: deixar a tela
		*-- travada depois de um erro seria pior que o erro.
		THIS.HabilitarCampos(.T.)

		*-- "This.Enabled = .F. / This.Refresh" do fim do metodo legado.
		*--
		*-- DIVERGENCIA DELIBERADA, em dois pontos, por bug do legado:
		*--
		*-- 1) ALVO. "atualizar" eh metodo do FORM, entao ali "This" eh o FORM,
		*--    nao o botao. Medido no VFP9 (2026-09-26): Form.Enabled = .F. eh
		*--    aceito e NAO mexe no Enabled dos filhos - o form simplesmente
		*--    para de receber input. Como esta tela eh modal com TitleBar = 0,
		*--    ControlBox = .F. e Closable = .F., reproduzir isso ao pe da letra
		*--    deixaria o usuario SEM SAIDA (nem Encerrar responderia) e nada no
		*--    legado reabilita o form. O alvo pretendido eh o BOTAO Atualizar:
		*--    "Processa.Click" faz "This.Parent.Atualiza.Enabled = .T.", isto
		*--    eh, so o botao Atualizar eh reabilitado - Processar/Atualizar
		*--    formam um ciclo coerente, Processar/Form nao formam nenhum.
		*--
		*-- 2) ALCANCE. No legado a linha fica FORA do "If lnOk = 6", entao
		*--    recusar "Atualiza ???" ou nao ter produto marcado tambem
		*--    desabilitava - travando a tela sem ter gravado nada. Aqui os
		*--    caminhos de recusa saem ANTES (RETURN acima do TRY) e nada muda:
		*--    so desabilita quando a gravacao realmente rodou, que eh quando a
		*--    grade foi zerada e de fato nao ha mais o que gravar.
		*--
		*-- Passa pelo FUNIL (e nao por atribuicao direta ao Enabled do botao)
		*-- para que o caminho do CATCH - onde LimparCampos nao chegou a rodar -
		*-- tambem volte ao modo "LISTA", em vez de deixar Atualizar habilitado
		*-- sobre um lote que abortou no meio.
		THIS.this_cModoAtual = "LISTA"
		THIS.AjustarBotoesPorModo()
		THIS.grd_4c_Produtos.Refresh()

		RETURN loc_lRetorno
	ENDPROC

	*====================================================================
	* CriarBarraProgresso - Instancia a fwprogressbar (stub portado em
	* app/classes/fwprogressbar.prg) usada pelo legado em "processar" e
	* "atualizar". Devolve .NULL. quando a classe nao esta disponivel ou
	* quando o form roda em modo de teste/validacao automatizada - assim o
	* chamador segue processando sem barra em vez de abortar.
	*====================================================================
	PROTECTED FUNCTION CriarBarraProgresso(par_cTitulo, par_nTotal)
		LOCAL loc_oBarra, loc_oErro
		loc_oBarra = .NULL.

		IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
				(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
			RETURN loc_oBarra
		ENDIF

		TRY
			loc_oBarra = CREATEOBJECT("fwprogressbar", par_cTitulo, par_nTotal)

			IF VARTYPE(loc_oBarra) = "O"
				loc_oBarra.Show()
			ELSE
				loc_oBarra = .NULL.
			ENDIF
		CATCH TO loc_oErro
			*-- Barra de progresso eh cosmetica: falhar em cria-la NAO pode
			*-- impedir a gravacao, mas tambem nao pode passar calado
			MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a barra " + ;
				"de progresso (" + loc_oErro.Message + "). O processamento " + ;
				"continua sem ela.", "Aviso")
			loc_oBarra = .NULL.
		ENDTRY

		RETURN loc_oBarra
	ENDFUNC

	*====================================================================
	* ProcessaAutomatico - Transcricao do metodo "processaautomatico"
	* legado: percorre os presets ATIVOS de SigCdCcp (Inativas <> 1),
	* joga cada preset nos campos da tela, processa e ATUALIZA sem
	* interacao nenhuma; ao terminar, fecha o formulario.
	*
	* Aborta o lote no primeiro preset cuja atualizacao falhar - o "If Not
	* ThisForm.Atualizar() / Exit / EndIf" do legado - para nao seguir
	* gravando em cima de uma base em estado incerto.
	*
	* PUBLIC - chamado por BtnProcessarClick e pelo Init (par_lAutomatico).
	*====================================================================
	PROCEDURE ProcessaAutomatico()
		LOCAL loc_lRetorno, loc_oErro
		loc_lRetorno = .F.

		IF VARTYPE(THIS.this_oBusinessObject) != "O"
			RETURN loc_lRetorno
		ENDIF

		TRY
			IF USED("cursor_4c_Produtos")
				ZAP IN cursor_4c_Produtos
			ENDIF

			IF THIS.this_oBusinessObject.BuscarPresetsAutomaticos() AND ;
					USED("cursor_4c_PresetsCcp")

				loc_lRetorno = .T.

				SELECT cursor_4c_PresetsCcp
				GO TOP
				SCAN
					IF USED("cursor_4c_Produtos")
						ZAP IN cursor_4c_Produtos
					ENDIF

					SELECT cursor_4c_PresetsCcp
					THIS.AplicarPresetNaTela()

					IF THIS.CarregarLista()
						THIS.AplicarFiltroVariacao()

						SELECT cursor_4c_Produtos
						SET ORDER TO cpros
						GO TOP

						*-- O legado marca implicitamente: "atualizar" grava so
						*-- lMarca = 1, e no modo automatico nao ha usuario para
						*-- clicar - "cmdSelemp.Click" (Update Set lMarca = 1) eh
						*-- o equivalente de "todos os produtos do preset"
						UPDATE cursor_4c_Produtos SET lMarca = 1

						IF !THIS.AtualizarPrecos()
							loc_lRetorno = .F.
							EXIT
						ENDIF
					ENDIF

					SELECT cursor_4c_PresetsCcp
				ENDSCAN

				IF USED("cursor_4c_PresetsCcp")
					USE IN cursor_4c_PresetsCcp
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro no processamento autom" + CHR(225) + "tico:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
			loc_lRetorno = .F.
		ENDTRY

		*-- "ThisForm.Sair.Cancela.Click()" da ultima linha do legado: o modo
		*-- automatico fecha a tela sozinho quando termina o lote
		THIS.BtnEncerrarClick()

		RETURN loc_lRetorno
	ENDPROC

	*====================================================================
	* AplicarPresetNaTela - Copia o preset corrente de cursor_4c_PresetsCcp
	* para os controles da tela, na ORDEM e com os PARES exatos do metodo
	* "processaautomatico" legado (Thisform.getCFornecs.Value =
	* crSigCdCcp.cfornecs, etc.). Escrever nos CONTROLES, e nao direto nas
	* properties do BO, eh o que o legado faz - e o que mantem a tela
	* coerente com o que esta sendo processado, alem de deixar
	* FormParaBO como fonte unica dos filtros.
	*
	* Opc_Compra NAO recebe nada: o legado tambem nao o inclui no preset
	* (SigCdCcp nao tem coluna para ele) - fica no valor corrente da tela.
	*
	* PUBLIC - chamado por ProcessaAutomatico.
	*====================================================================
	PROCEDURE AplicarPresetNaTela()
		IF !USED("cursor_4c_PresetsCcp")
			RETURN
		ENDIF

		SELECT cursor_4c_PresetsCcp

		*-- Filtros
		THIS.txt_4c_Fornecedor.Value    = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cfornecs, ""))
		THIS.txt_4c_GrandeGrupoI.Value  = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.merci, ""))
		THIS.txt_4c_GrandeGrupoF.Value  = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.mercf, ""))
		THIS.txt_4c_GrupoI.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cgrui, ""))
		THIS.txt_4c_GrupoF.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cgruf, ""))
		THIS.txt_4c_SubGrupoI.Value     = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.sgrui, ""))
		THIS.txt_4c_SubGrupoF.Value     = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.sgruf, ""))
		THIS.txt_4c_UnidadeI.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cunii, ""))
		THIS.txt_4c_UnidadeF.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cunif, ""))
		THIS.txt_4c_LinhaI.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.lini, ""))
		THIS.txt_4c_LinhaF.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.linf, ""))
		THIS.txt_4c_ColecaoI.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.coli, ""))
		THIS.txt_4c_ColecaoF.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.colf, ""))
		THIS.txt_4c_MoedaI.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.moedai, ""))
		THIS.txt_4c_MoedaF.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.moedaf, ""))
		THIS.txt_4c_MarkupI.Value       = TratarNulo(cursor_4c_PresetsCcp.mrki, 0)
		THIS.txt_4c_MarkupF.Value       = TratarNulo(cursor_4c_PresetsCcp.mrkf, 0)
		THIS.txt_4c_EncargoI.Value      = TratarNulo(cursor_4c_PresetsCcp.enci, 0)
		THIS.txt_4c_EncargoF.Value      = TratarNulo(cursor_4c_PresetsCcp.encf, 0)
		THIS.txt_4c_Variacao.Value      = TratarNulo(cursor_4c_PresetsCcp.variacao, 0)
		THIS.txt_4c_Feitio.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.feitio, ""))

		*-- Dados
		THIS.txt_4c_Reajuste.Value      = TratarNulo(cursor_4c_PresetsCcp.reajuste, 0)
		THIS.txt_4c_NovoEncargo.Value   = TratarNulo(cursor_4c_PresetsCcp.encargo, 0)
		THIS.txt_4c_NovoMarkup.Value    = TratarNulo(cursor_4c_PresetsCcp.nmrk, 0)
		THIS.txt_4c_NovoMkp.Value       = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.newmkp, ""))

		*-- OptionGroups: Value eh o INDICE do botao (1..ButtonCount) e o VFP9
		*-- recusa indice fora da faixa, derrubando o lote inteiro por causa de
		*-- UM preset com valor invalido - por isso a normalizacao abaixo. Zero
		*-- eh legal e significa "nenhum botao marcado".
		THIS.AplicarValorOptionGroup(THIS.obj_4c_OpcaoMoeda, ;
			TratarNulo(cursor_4c_PresetsCcp.opcmoedatp, 0))
		THIS.AplicarValorOptionGroup(THIS.obj_4c_Situacao, ;
			TratarNulo(cursor_4c_PresetsCcp.opcsit, 0))
		THIS.AplicarValorOptionGroup(THIS.obj_4c_Recalcula, ;
			TratarNulo(cursor_4c_PresetsCcp.opcrecalc, 0))
		THIS.AplicarValorOptionGroup(THIS.obj_4c_AtualizaVenda, ;
			TratarNulo(cursor_4c_PresetsCcp.opcpven, 0))

		*-- Recalcula comanda o Enabled de Reajuste/Markup/Variacao/NovoMkp
		THIS.AtualizarEstadoCalculo()
		THIS.Refresh()
	ENDPROC

	*====================================================================
	* AplicarValorOptionGroup - Atribui o indice do botao marcado a um
	* OptionGroup, recusando indice fora da faixa 0..ButtonCount (o VFP9
	* dispara erro de propriedade invalida, e o valor vem de SigCdCcp, que
	* eh dado de usuario). Fora da faixa, mantem o valor corrente.
	*====================================================================
	PROTECTED PROCEDURE AplicarValorOptionGroup(par_oGrupo, par_nValor)
		IF VARTYPE(par_oGrupo) != "O" OR VARTYPE(par_nValor) != "N"
			RETURN
		ENDIF

		IF BETWEEN(par_nValor, 0, par_oGrupo.ButtonCount)
			par_oGrupo.Value = par_nValor
		ENDIF
	ENDPROC

	*====================================================================
	* BtnEncerrarClick - Espelha Sair.Cancela.Click (ThisForm.Release) do
	* legado. PUBLIC - alvo de BINDEVENT (CLAUDE.md regra #3).
	*====================================================================
	PROCEDURE BtnEncerrarClick()
		THIS.Release()
	ENDPROC

	*====================================================================
	* BtnCancelarClick - Mesmo botao acima visto pelo OUTRO nome que o
	* legado lhe da: no SCX o objeto chama-se "Cancela" e tem Cancel = .T.,
	* isto eh, ESC cai nele; a Caption exibida eh "Encerrar". Nao ha um
	* segundo botao a migrar - esta tela nao tem Page2 de Dados nem modo de
	* edicao cancelavel, e o UNICO caminho de saida eh o Encerrar.
	*
	* Delega em vez de duplicar: a logica de saida tem de existir em um
	* lugar so, senao um dos dois caminhos fica para tras na proxima
	* mudanca.
	*
	* PUBLIC - alvo de BINDEVENT e do harness de teste (CLAUDE.md regra #3).
	*====================================================================
	PROCEDURE BtnCancelarClick()
		THIS.BtnEncerrarClick()
	ENDPROC

	*====================================================================
	* BtnSelTudoClick - Espelha cmdSelemp.Click (Update CrProdutos Set
	* lMarca = 1) do legado. PUBLIC - alvo de BINDEVENT.
	*====================================================================
	PROCEDURE BtnSelTudoClick()
		IF USED("cursor_4c_Produtos")
			UPDATE cursor_4c_Produtos SET lMarca = 1
			THIS.grd_4c_Produtos.Refresh()
		ENDIF
	ENDPROC

	*====================================================================
	* BtnApagaClick - Espelha CmdApgEmp.Click (Update CrProdutos Set
	* lMarca = 0) do legado. PUBLIC - alvo de BINDEVENT.
	*====================================================================
	PROCEDURE BtnApagaClick()
		IF USED("cursor_4c_Produtos")
			UPDATE cursor_4c_Produtos SET lMarca = 0
			THIS.grd_4c_Produtos.Refresh()
		ENDIF
	ENDPROC

	*====================================================================
	* BtnImprimirClick - Espelha Impress?o.Click (Do Form SigPrCcr) do
	* legado, abrindo o relatorio ja migrado (FormSIGPRCCR).
	* PUBLIC - alvo de BINDEVENT.
	*====================================================================
	PROCEDURE BtnImprimirClick()
		LOCAL loc_oForm, loc_oErro, loc_lErroExibido

		loc_oForm        = .NULL.
		loc_lErroExibido = .F.

		*-- O TRY cobre SO a criacao. Com o Show() dentro dele, o relatorio eh
		*-- modal: a chamada BLOQUEIA e toda a vida daquela tela (cada Valid,
		*-- cada Click) passa a rodar dentro deste bloco - e em VFP9 o TRY tem
		*-- precedencia sobre ON ERROR em qualquer ponto da pilha, entao o
		*-- primeiro erro de runtime la dentro salta para o CATCH daqui,
		*-- abandona o TRY, derruba a referencia LOCAL e o relatorio se fecha
		*-- sozinho sem nada no log (CLAUDE.md regra #29).
		TRY
			loc_oForm = CREATEOBJECT("FormSIGPRCCR")
		CATCH TO loc_oErro
			MsgErro("Erro ao abrir relat" + CHR(243) + "rio:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
			loc_oForm        = .NULL.
			loc_lErroExibido = .T.
		ENDTRY

		IF VARTYPE(loc_oForm) = "O"
			loc_oForm.Show()
		ELSE
			*-- Guarda contra mensagem DUPLA: o CATCH acima ja reportou a
			*-- excecao com linha e procedure. Aqui so avisa quando
			*-- CREATEOBJECT devolveu nao-objeto SEM disparar excecao (Init do
			*-- relatorio que devolve .F.).
			IF !loc_lErroExibido
				MsgErro("Erro ao abrir o relat" + CHR(243) + "rio de rec" + ;
					CHR(225) + "lculo.", "Erro")
			ENDIF
		ENDIF
	ENDPROC

	*====================================================================
	* Destroy - o BO nao abre conexao temporaria propria (usa apenas
	* gnConnHandle global), entao nao ha recurso proprio para liberar
	* alem do que FormBase.Destroy() ja faz (menu-shrink fix).
	*====================================================================
	PROCEDURE Destroy()
		DODEFAULT()
	ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprccpBO.prg):
*====================================================================
* sigprccpBO.prg
*
* Business Object para sigprccp (Recalculo de Precos)
* Tabela principal atualizada pelo processamento: SigCdPro (cpros)
* Tabela de presets de filtro (somente LEITURA, nunca gravada por
* este form): SigCdCcp (cIdChaves)
*
* Form legado: SIGPRCCP - "Recalculo de Precos"
* Forma OPERACIONAL: recalcula Custo/Venda de produtos filtrados,
* grava o resultado em SigCdPro e registra o historico do calculo.
*====================================================================

DEFINE CLASS sigprccpBO AS BusinessBase

	*-- Modo de execucao (Automatico = .T. quando chamado via ProcessarAutomatico,
	*-- percorrendo os presets de SigCdCcp; .F. quando disparado manualmente)
	this_lAutomatico = .F.

	*-- Filtros - Fornecedor
	this_cFornecs = ""
	this_cDFornecs = ""

	*-- Filtros - Faixas de classificacao do produto (SigCdCcp.merci/mercf etc)
	this_cMercI = ""
	this_cMercF = ""
	this_cGrupoI = ""
	this_cGrupoF = ""
	this_cSubGrupoI = ""
	this_cSubGrupoF = ""
	this_cUnidadeI = ""
	this_cUnidadeF = ""
	this_cLinhaI = ""
	this_cLinhaF = ""
	this_cColecaoI = ""
	this_cColecaoF = ""
	this_cMoedaI = ""
	this_cMoedaF = ""

	*-- Filtros - Faixas numericas (Markup/Encargo/Variacao)
	this_nMarkupI = 0
	this_nMarkupF = 0
	this_nEncargoI = 0
	this_nEncargoF = 0
	this_nVariacao = 0

	*-- Filtros - Feitio (SigPrFti) usado como referencia de calculo
	this_cFeitio = ""

	*-- Opcoes de processamento (OptionGroups do form - valores 1-based).
	*-- this_nAtualizaVenda=2 ("Nao") e this_nOpcaoCompra=3 ("Todos") sao
	*-- os defaults EXATOS do SCX legado (Opc_pven.Value=2/Opc_Compra.Value=3)
	this_nOpcaoMoeda = 1
	this_nSituacao = 1
	this_nTipoRecalculo = 1
	this_nAtualizaVenda = 2
	this_nOpcaoCompra = 3

	*-- Dados de recalculo
	this_nReajuste = 0
	this_nNovoEncargo = 0
	this_nNovoMarkup = 0
	this_cNovoFeitio = ""

	*-- Produto corrente (linha da grade marcada para gravacao do preco
	*-- recalculado) - mapeia SigCdPro.cpros, o registro efetivamente
	*-- atualizado por Inserir/Atualizar/ObterChavePrimaria/CarregarDoCursor
	this_cCpros = ""                && cpros char(14) - PK
	this_cDescricaoProduto = ""     && dpros char(65) - somente referencia
	this_nCustoAtual = 0            && custofs numeric(11,3)
	this_nVendaAtual = 0            && pvens numeric(11,5)
	this_nVendaIdeal = 0            && pvideals numeric(11,5)
	this_nFatorCusto = 0            && fcustos numeric(11,5)
	this_nFatorVenda = 0            && fvendas numeric(7,3)
	this_cMoedaCusto = ""           && moecs char(3)
	this_cMoedaVenda = ""           && moevs char(3)

	*-- Flag "Confirma a Impressao das Etiquetas?" do metodo "atualizar"
	*-- legado (m.ImpEtiqs = llImpEtiq gravado junto com o preco novo).
	*-- NUMERICO 0/1 porque impetiqs eh bit e o CheckBox/confirmacao do
	*-- form trabalha com 0/1 (nunca .T./.F.)
	this_nImpEtiqs = 0              && impetiqs bit

	*-- Subgrupo recalculado por faixa de preco (SigCdPsg.nfaixafins),
	*-- aplicado somente quando SigCdPaC.nchksubgrs = 1 - transcricao do
	*-- bloco "If crSigCdPac.nChkSubGrs = 1 ... Replace sGrus With
	*-- csSigCdPsg.Codigos" do metodo "atualizar" legado.
	*-- this_lAtualizarSubGrupo controla se Atualizar() inclui sgrus no
	*-- UPDATE: o legado so troca o subgrupo quando acha a faixa.
	this_cSubGrupo = ""             && sgrus char(6)
	this_lAtualizarSubGrupo = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Tabela efetivamente atualizada pelo processamento (SigCdPro),
		*-- pois SigCdCcp (presets de filtro) e somente LEITURA neste form.
		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "cpros"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave do produto sendo gravado
	* (usada por RegistrarAuditoria em Atualizar)
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCpros)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega os dados do produto (linha da grade de
	* recalculo) para as propriedades this_c*/this_n* correspondentes.
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				*-- TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR default do
				*-- tipo da coluna, NUNCA um codigo de tipo ("C"/"N") - com a coluna
				*-- NULL, "C" gravaria a string literal "C" na property e "N" poria
				*-- uma STRING numa property this_n*, estourando FormatarNumeroSQL.
				THIS.this_cCpros            = TratarNulo(cpros,    "")
				THIS.this_cDescricaoProduto = TratarNulo(dpros,    "")
				THIS.this_nCustoAtual       = TratarNulo(custofs,  0)
				THIS.this_nVendaAtual       = TratarNulo(pvens,    0)
				THIS.this_nVendaIdeal       = TratarNulo(pvideals, 0)
				THIS.this_nFatorCusto       = TratarNulo(fcustos,  0)
				THIS.this_nFatorVenda       = TratarNulo(fvendas,  0)
				THIS.this_cMoedaCusto       = TratarNulo(moecs,    "")
				THIS.this_cMoedaVenda       = TratarNulo(moevs,    "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar produto do cursor:" + CHR(13) + ;
				loException.Message, "sigprccpBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Grava o preco/custo recalculado de volta em SigCdPro
	* Equivalente a PROCEDURE atualizar do legado: Scatter/Gather do
	* registro com DataAlts/UsuaAlts atualizados e commit do preco novo.
	*
	* Inserir()/ExecutarExclusao() NAO sao sobrescritos neste BO: o
	* recalculo so ATUALIZA produtos ja cadastrados em SigCdPro - nunca
	* cria nem apaga produto - entao o comportamento herdado de
	* BusinessBase (recusar a operacao) ja eh o correto para os dois.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_cSubGru, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- sgrus so entra no UPDATE quando a faixa de SigCdPsg foi
			*-- localizada (legado: "If ! Eof() / Replace sGrus With
			*-- csSigCdPsg.Codigos") - fora disso o subgrupo nao se mexe.
			loc_cSubGru = ""
			IF THIS.this_lAtualizarSubGrupo AND !EMPTY(ALLTRIM(THIS.this_cSubGrupo))
				loc_cSubGru = "sgrus = " + ;
					EscaparSQL(LEFT(ALLTRIM(THIS.this_cSubGrupo), 6)) + ","
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET custofs  = <<FormatarNumeroSQL(THIS.this_nCustoAtual, 3)>>,
					pvens    = <<FormatarNumeroSQL(THIS.this_nVendaAtual, 5)>>,
					pvideals = <<FormatarNumeroSQL(THIS.this_nVendaIdeal, 5)>>,
					fcustos  = <<FormatarNumeroSQL(THIS.this_nFatorCusto, 5)>>,
					fvendas  = <<FormatarNumeroSQL(THIS.this_nFatorVenda, 3)>>,
					moecs    = <<EscaparSQL(THIS.this_cMoedaCusto)>>,
					moevs    = <<EscaparSQL(THIS.this_cMoedaVenda)>>,
					impetiqs = <<FormatarNumeroSQL(IIF(THIS.this_nImpEtiqs = 1, 1, 0), 0)>>,
					<<loc_cSubGru>>
					dtalts   = GETDATE(),
					usuaalts = <<EscaparSQL(LEFT(gc_4c_UsuarioLogado, 20))>>
				WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar pre" + CHR(231) + "o do produto:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprccpBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AcrescentarFaixa - Helper de MontarWhereFiltros: acrescenta a faixa
	* (BETWEEN/>=/<=) de UM campo a clausula WHERE em construcao. Espelha
	* o corpo do "For lnConta = 1 To 7" do metodo "processar" legado
	* (SIGPRCCP): so entra em ">= "/"<= "/"Between" quando pelo menos um
	* dos limites foi informado, e "And" so precede quando ja existe algo
	* acumulado em par_cWhereAtual.
	*====================================================================
	PROTECTED FUNCTION AcrescentarFaixa(par_cWhereAtual, par_cCampo, par_cInicio, par_cFim)
		LOCAL loc_cWhere, loc_cIni, loc_cFim
		loc_cWhere = par_cWhereAtual
		loc_cIni   = ALLTRIM(TratarNulo(par_cInicio, ""))
		loc_cFim   = ALLTRIM(TratarNulo(par_cFim, ""))

		IF !EMPTY(loc_cIni) OR !EMPTY(loc_cFim)
			IF !EMPTY(loc_cWhere)
				loc_cWhere = loc_cWhere + " And "
			ENDIF

			IF EMPTY(loc_cIni)
				loc_cWhere = loc_cWhere + par_cCampo + " <= " + EscaparSQL(loc_cFim)
			ELSE
				IF EMPTY(loc_cFim)
					loc_cWhere = loc_cWhere + par_cCampo + " >= " + EscaparSQL(loc_cIni)
				ELSE
					loc_cWhere = loc_cWhere + par_cCampo + " Between " + ;
						EscaparSQL(loc_cIni) + " And " + EscaparSQL(loc_cFim)
				ENDIF
			ENDIF
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* MontarWhereFiltros - Constroi a clausula WHERE dos filtros de faixa
	* (Grande Grupo/Grupo/Subgrupo/Unidade/Linha/Colecao/Moeda), Situacao,
	* Fornecedor, Opcao de Compra, Markup, Encargo e Feitio - transcricao
	* literal do bloco de montagem de lcWhere do metodo "processar" legado
	* (laCampo/laVarias percorrendo os 7 pares de faixa, seguido dos IIF de
	* Situas/Ifors/ForaLinha/Margems/Encargos/cFtios+cFtioCs).
	*====================================================================
	PROTECTED FUNCTION MontarWhereFiltros()
		LOCAL loc_cWhere, loc_cCampoMoeda

		*-- laCampo[5] do legado: 'Moedas', ou 'Moevs' quando fwoption1.Value = 2
		loc_cCampoMoeda = IIF(THIS.this_nOpcaoMoeda = 2, "Moevs", "Moedas")

		loc_cWhere = ""
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "CGrus",     THIS.this_cGrupoI,    THIS.this_cGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Cunis",     THIS.this_cUnidadeI,  THIS.this_cUnidadeF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Linhas",    THIS.this_cLinhaI,    THIS.this_cLinhaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Colecoes",  THIS.this_cColecaoI,  THIS.this_cColecaoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, loc_cCampoMoeda, THIS.this_cMoedaI, THIS.this_cMoedaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "SGrus",     THIS.this_cSubGrupoI, THIS.this_cSubGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Mercs",     THIS.this_cMercI,     THIS.this_cMercF)

		loc_cWhere = ALLTRIM(loc_cWhere)
		IF EMPTY(loc_cWhere)
			loc_cWhere = "1=1"
		ENDIF
		IF UPPER(RIGHT(loc_cWhere, 3)) == "AND"
			loc_cWhere = ALLTRIM(SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3))
		ENDIF

		*-- Situacao (Opc_situacao): 1=Ativos, 2=Inativos, 3=Todos (sem filtro)
		IF INLIST(THIS.this_nSituacao, 1, 2)
			loc_cWhere = loc_cWhere + " And Situas = " + FormatarNumeroSQL(THIS.this_nSituacao, 0)
		ENDIF

		*-- Fornecedor (getCFornecs)
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFornecs, "")))
			loc_cWhere = loc_cWhere + " And Ifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecs))
		ENDIF

		*-- Opc_Compra: 1=Comprar (ForaLinha=0), 2=Nao Comprar (ForaLinha=1), 3=Todos
		IF INLIST(THIS.this_nOpcaoCompra, 1, 2)
			loc_cWhere = loc_cWhere + " And ForaLinha = " + IIF(THIS.this_nOpcaoCompra = 1, "0", "1")
		ENDIF

		*-- Faixa de Markup (GetMrki/GetMrkf)
		IF THIS.this_nMarkupI > 0
			loc_cWhere = loc_cWhere + " And Margems Between " + ;
				FormatarNumeroSQL(THIS.this_nMarkupI, 2) + " And " + FormatarNumeroSQL(THIS.this_nMarkupF, 2)
		ENDIF

		*-- Faixa de Encargo (Get_EncI/Get_Encf)
		IF THIS.this_nEncargoI > 0
			loc_cWhere = loc_cWhere + " And Encargos Between " + ;
				FormatarNumeroSQL(THIS.this_nEncargoI, 2) + " And " + FormatarNumeroSQL(THIS.this_nEncargoF, 2)
		ENDIF

		*-- Feitio (Get_Feitio) - casa tanto o feitio de venda quanto o de custo
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFeitio, "")))
			loc_cWhere = loc_cWhere + " And (cFtios = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ;
				" Or cFtioCs = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ")"
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* BuscarProdutosFiltrados - Consulta SigCdPro com a clausula WHERE de
	* MontarWhereFiltros (transcricao da fase de consulta do metodo
	* "processar" legado: "lcQuery = [Select * From SigCdPro Where ] +
	* lcWhere + ..."). O calculo de reajuste (conversao de moeda, peso de
	* composicao e markup de grupo) que o legado aplica DEPOIS desta
	* consulta usa this_nReajuste/this_nNovoMarkup/this_nNovoEncargo, que
	* espelham os controles Get_Reajuste/GetnMrk/Get_Encargo do formulario.
	*
	* Resultado fica em cursor_4c_ProdutosSQL (cpros/dpros/pvens/custofs/
	* pvideals/fcustos/fvendas/moecs/moevs) para o Form transferir para o
	* cursor da grade (cursor_4c_Produtos) em CarregarLista.
	*====================================================================
	FUNCTION BuscarProdutosFiltrados()
		LOCAL loc_cWhere, loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cWhere = THIS.MontarWhereFiltros()

			IF USED("cursor_4c_ProdutosSQL")
				USE IN cursor_4c_ProdutosSQL
			ENDIF

			*-- cgrus nao aparece na grade, mas viaja junto porque a
			*-- reclassificacao de subgrupo por faixa (ResolverSubGrupoPorFaixa)
			*-- precisa do grupo do produto na hora de gravar
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cpros, dpros, pvens, custofs, pvideals, fcustos, fvendas,
					moecs, moevs, cgrus
				FROM SigCdPro
				WHERE <<loc_cWhere>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosSQL")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao consultar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao buscar produtos:" + CHR(13) + loException.Message, ;
				"sigprccpBO.BuscarProdutosFiltrados")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


	*====================================================================
	* BuscarPresetsAutomaticos - Le os presets de recalculo ativos de
	* SigCdCcp para o modo Automatico. Transcricao literal da consulta do
	* metodo "processaautomatico" legado:
	*     lcQuery = [Select * From SigCdCcp Where Inativas <> 1]
	*
	* Resultado em cursor_4c_PresetsCcp (uma linha por preset, na ordem
	* natural da tabela - o legado nao ordena).
	*====================================================================
	FUNCTION BuscarPresetsAutomaticos()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_PresetsCcp")
				USE IN cursor_4c_PresetsCcp
			ENDIF

			loc_cSQL = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PresetsCcp")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
					CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdCcp)")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler presets de rec" + CHR(225) + "lculo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.BuscarPresetsAutomaticos")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterChkSubGrupos - Le SigCdPaC.nchksubgrs, o parametro que liga a
	* reclassificacao de subgrupo por faixa de preco no fim do metodo
	* "atualizar" legado (If crSigCdPac.nChkSubGrs = 1). O legado carrega
	* esse valor no Init (CursorQuery 'SigCdPaC' ... 'Calccusts,NCHKSUBGRS').
	*
	* Retorno: NUMERICO (0 quando o parametro nao existe ou a consulta
	* falha) - nchksubgrs eh numeric(1,0), nao bit, entao chega SEMPRE
	* numerico e nao precisa de teste de VARTYPE para Logico.
	*====================================================================
	FUNCTION ObterChkSubGrupos()
		LOCAL loc_cSQL, loc_nResultado, loc_nChk
		loc_nChk = 0

		TRY
			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF

			loc_cSQL = "SELECT TOP 1 nchksubgrs FROM SigCdPaC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PacChk")

			IF loc_nResultado >= 0 AND USED("cursor_4c_PacChk")
				SELECT cursor_4c_PacChk
				GO TOP
				IF !EOF()
					loc_nChk = TratarNulo(cursor_4c_PacChk.nchksubgrs, 0)
				ENDIF
			ENDIF

			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler par" + CHR(226) + "metro de subgrupo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ObterChkSubGrupos")
		ENDTRY

		RETURN loc_nChk
	ENDFUNC

	*====================================================================
	* ResolverSubGrupoPorFaixa - Devolve o subgrupo (SigCdPsg.codigos) cuja
	* faixa comporta o preco de venda informado. Transcricao do bloco do
	* metodo "atualizar" legado:
	*     Select * From SigCdPsg Where CGrus = '<grupo>' Order By nFaixaFins
	*     Locate For nFaixaFins >= lnPVens
	*     If ! Eof() -> Replace sGrus With csSigCdPsg.Codigos
	* O "Locate" sobre o cursor ORDENADO por nFaixaFins pega a PRIMEIRA
	* faixa cujo limite superior alcanca o preco - equivalente exato ao
	* TOP 1 ... ORDER BY nfaixafins abaixo.
	*
	* Retorno: CHAR com o codigo do subgrupo, "" quando nao ha faixa
	* (caso em que o legado NAO troca o subgrupo).
	*====================================================================
	FUNCTION ResolverSubGrupoPorFaixa(par_cGrupo, par_nVenda)
		LOCAL loc_cSQL, loc_nResultado, loc_cCodigo
		loc_cCodigo = ""

		TRY
			IF !EMPTY(ALLTRIM(TratarNulo(par_cGrupo, "")))
				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF

				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT TOP 1 codigos
					FROM SigCdPsg
					WHERE cgrus = <<EscaparSQL(ALLTRIM(par_cGrupo))>>
						AND nfaixafins >= <<FormatarNumeroSQL(par_nVenda, 2)>>
					ORDER BY nfaixafins
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Psg")

				IF loc_nResultado >= 0 AND USED("cursor_4c_Psg")
					SELECT cursor_4c_Psg
					GO TOP
					IF !EOF()
						loc_cCodigo = ALLTRIM(TratarNulo(cursor_4c_Psg.codigos, ""))
					ENDIF
				ENDIF

				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao resolver subgrupo por faixa:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ResolverSubGrupoPorFaixa")
		ENDTRY

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* ColunasComunsProPrc - Lista das 121 colunas presentes ao mesmo tempo
	* em SigCdPro e SigCdPrc (extraidas de docs/schema.sql). O legado copia
	* o registro INTEIRO com "Scatter Memvar Memo" + "Insert Into
	* CrSigCdPrc From MemVar", que preenche apenas os campos de nome igual
	* nas duas tabelas - esta lista eh exatamente esse conjunto.
	*
	* par_lOrigem = .T. devolve as EXPRESSOES do SELECT sobre SigCdPro,
	* com LEFT() nas 3 colunas que sao mais CURTAS no destino (locals
	* 10->6, sittricms 3->2, codtams 4->2); sem o LEFT o SQL Server recusa
	* o INSERT com "String or binary data would be truncated".
	* par_lOrigem = .F. devolve os nomes crus, para a lista de destino.
	*====================================================================
	PROTECTED FUNCTION ColunasComunsProPrc(par_lOrigem)
		LOCAL loc_c
		loc_c = ""
		loc_c = loc_c + "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, "
		loc_c = loc_c + "cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, "
		loc_c = loc_c + "fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(locals, 6)", "locals") + ", "
		loc_c = loc_c + "margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, "
		loc_c = loc_c + "obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, "
		loc_c = loc_c + "reffs, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(sittricms, 2)", "sittricms") + ", "
		loc_c = loc_c + "tcomps, tipos, transps, valors, varias, situas, "
		loc_c = loc_c + "dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, "
		loc_c = loc_c + "codcors, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(codtams, 2)", "codtams") + ", "
		loc_c = loc_c + "compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, "
		loc_c = loc_c + "chkfunds, casas, impetiqs, qtdcpnts, dpro2s, dsccompras, encoms, obscompras, "
		loc_c = loc_c + "codacbs, cravcers, cunips, ipis, mercs, pesobs, tamhs, tamls, "
		loc_c = loc_c + "tamps, tptribs, volumes, obsetqs, ultcomps, vultcomps, multcomps, markupa, "
		loc_c = loc_c + "tinsts, cclass, cftiocs, figtecs, nivelqs, pftiocs, usuincs, diasinas, "
		loc_c = loc_c + "idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, contaccus, "
		loc_c = loc_c + "gruccus, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, "
		loc_c = loc_c + "idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, "
		loc_c = loc_c + "conjunts"

		RETURN loc_c
	ENDFUNC

	*====================================================================
	* GravarHistoricoPreco - Registra em SigCdPrc o retrato do produto
	* ANTES da gravacao do preco novo. Transcricao do bloco do metodo
	* "atualizar" legado:
	*     lcSql = [Select * From SigCdPro Where Cpros = ']+m.cpros+[']
	*     Select TmpPro2 / Scatter Memvar Memo
	*     m.DataAlts = Datetime() / m.HoraAlts = Substr(Ttoc(...),12,8)
	*     m.UsuaAlts = Usuar / m.cIdChaves = fUniqueIds()
	*     m.Origem   = Ttoc(Datetime()) + [ SigPrCcp]
	*     Insert Into CrSigCdPrc From MemVar
	* Feito com INSERT ... SELECT (server-side) para nao trazer as 121
	* colunas para o VFP so para devolve-las.
	*
	* As 15 colunas NOT NULL que existem em SigCdPrc e NAO em SigCdPro
	* recebem o valor em branco do tipo - equivalente ao registro em
	* branco do cursor do legado, que o "Insert From Memvar" nao toca.
	* SigCdPrc nao tem nenhum DEFAULT, entao omitir qualquer uma delas
	* faria o SQL Server recusar o INSERT inteiro (CLAUDE.md regra #22).
	* figuras (image) fica de fora porque aceita NULL.
	*
	* IMPORTANTE: chamar ANTES de Salvar()/Atualizar(), senao o historico
	* guarda o preco NOVO em vez do antigo.
	*====================================================================
	FUNCTION GravarHistoricoPreco(par_cCpros)
		LOCAL loc_cSQL, loc_cDestino, loc_cOrigem, loc_cExtras, loc_cValores
		LOCAL loc_cHora, loc_cOrigemTxt, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- m.HoraAlts = Substr(Ttoc(m.DataAlts),12,8) do legado
			loc_cHora = SUBSTR(TTOC(DATETIME()), 12, 8)

			*-- m.Origem = Ttoc(Datetime()) + [ SigPrCcp] do legado
			loc_cOrigemTxt = LEFT(TTOC(DATETIME()) + " SigPrCcp", 30)

			loc_cExtras  = "codcpds, cbms, caracts, cunifors, custocvs, ltmins, markcvs, pesomts, " + ;
				"pidealcvs, qtdias, retiras, codccnjs, montagens, tmontas, codconc"
			loc_cValores = EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ;
				", 0, 0, 0, 0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ;
				", " + EscaparSQL("")

			loc_cDestino = THIS.ColunasComunsProPrc(.F.)
			loc_cOrigem  = THIS.ColunasComunsProPrc(.T.)

			loc_cSQL = "INSERT INTO SigCdPrc " + ;
				"(dataalts, horaalts, usuaalts, cidchaves, origem, " + ;
				loc_cExtras + ", " + loc_cDestino + ") " + ;
				"SELECT GETDATE(), " + ;
				EscaparSQL(loc_cHora) + ", " + ;
				EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
				EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
				EscaparSQL(loc_cOrigemTxt) + ", " + ;
				loc_cValores + ", " + loc_cOrigem + " " + ;
				"FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
					"rico de pre" + CHR(231) + "o (SigCdPrc) do produto " + ;
					ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de pre" + CHR(231) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.GravarHistoricoPreco")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* GravarHistoricoComposicao - Copia a composicao corrente do produto
	* (SigPrCpo) para SigPrCp2. Transcricao do bloco do metodo "atualizar"
	* legado:
	*     Select * From SigPrCpo Where CPros = '<cpros>' -> TmpCompo
	*     Scan / Scatter MemVar Memo
	*        m.DataAlts/HoraAlts/UsuaAlts / m.cIdChaves = fUniqueIds()
	*        Insert Into CrSigPrCp2 From MemVar
	*     EndScan
	* Como o legado gera um cIdChaves NOVO por LINHA, a gravacao eh feita
	* linha a linha (um INSERT ... SELECT por cidchaves de origem) - um
	* unico INSERT em conjunto repetiria a mesma chave em todas as linhas
	* e colidiria no indice unico.
	*
	* SigPrCp2 = SigPrCpo menos PedraPrincipal, mais dataalts/horaalts/
	* usuaalts; dcompos eh char(30) contra char(40) na origem, por isso o
	* LEFT(dcompos, 30).
	*====================================================================
	FUNCTION GravarHistoricoComposicao(par_cCpros)
		LOCAL loc_cSQL, loc_cCols, loc_cColsOrig, loc_cHora, loc_cUsuario
		LOCAL loc_nResultado, loc_lSucesso, loc_lProsseguir
		loc_lSucesso    = .F.
		loc_lProsseguir = .T.

		TRY
			loc_cHora    = SUBSTR(TTOC(DATETIME()), 12, 8)
			loc_cUsuario = LEFT(gc_4c_UsuarioLogado, 10)

			loc_cCols = ""
			loc_cCols = loc_cCols + "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, "
			loc_cCols = loc_cCols + "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, "
			loc_cCols = loc_cCols + "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, "
			loc_cCols = loc_cCols + "cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, "
			loc_cCols = loc_cCols + "tipos, matriz, obsofs"

			*-- Mesma lista, com LEFT() na unica coluna mais curta no destino
			loc_cColsOrig = STRTRAN(loc_cCols, "dcompos,", "LEFT(dcompos, 30),")

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF

			loc_cSQL = "SELECT cidchaves FROM SigPrCpo WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoOrig")

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Falha ao ler composi" + CHR(231) + CHR(227) + ;
					"o do produto " + ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				*-- Produto sem composicao: nada a historiar, e o legado
				*-- tambem apenas nao entra no Scan (sucesso)
				loc_lSucesso = .T.

				SELECT cursor_4c_CompoOrig
				SCAN
					loc_cSQL = "INSERT INTO SigPrCp2 " + ;
						"(dataalts, horaalts, usuaalts, cidchaves, " + loc_cCols + ") " + ;
						"SELECT GETDATE(), " + ;
						EscaparSQL(loc_cHora) + ", " + ;
						EscaparSQL(loc_cUsuario) + ", " + ;
						EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
						loc_cColsOrig + " " + ;
						"FROM SigPrCpo WHERE cidchaves = " + ;
						EscaparSQL(ALLTRIM(cursor_4c_CompoOrig.cidchaves))

					IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
						THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
							"rico de composi" + CHR(231) + CHR(227) + "o (SigPrCp2) do produto " + ;
							ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
						MsgErro(THIS.this_cMensagemErro, "Erro SQL")
						loc_lSucesso = .F.
						EXIT
					ENDIF

					SELECT cursor_4c_CompoOrig
				ENDSCAN
			ENDIF

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de composi" + ;
				CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, ;
				"sigprccpBO.GravarHistoricoComposicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ExcluirPrecosTabela - Apaga os precos de tabela do produto, que
	* passam a estar defasados depois do recalculo. Transcricao literal do
	* metodo "atualizar" legado:
	*     [Delete From SigPrPrt Where CPros = '] + m.CPros + [' ]
	*====================================================================
	FUNCTION ExcluirPrecosTabela(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigPrPrt WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao excluir pre" + CHR(231) + ;
					"os de tabela (SigPrPrt) do produto " + ALLTRIM(par_cCpros) + ;
					": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao excluir pre" + CHR(231) + "os de tabela:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ExcluirPrecosTabela")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* IniciarTransacao / ConfirmarTransacao / DesfazerTransacao
	*
	* Equivalentes de ThisForm.poDataMgr.Commit() / .RollBack() do legado,
	* que existem porque o fSqlConector legado abre a conexao com
	* Transactions = 2 (manual). Neste ambiente a conexao JA nasce em
	* transacao manual (SQLGETPROP(0,"Transactions") = 2 num VFP9 virgem),
	* entao nao ha nada a abrir: IniciarTransacao apenas confere o handle e
	* limpa a mensagem de erro; o que importa eh o par SQLCOMMIT/
	* SQLROLLBACK no fim - sem eles a transacao nunca eh fechada e a
	* gravacao SOME se o processo morrer antes do disconnect limpo.
	*====================================================================
	FUNCTION IniciarTransacao()
		THIS.this_cMensagemErro = ""
		RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
	ENDFUNC

	FUNCTION ConfirmarTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLCOMMIT(gnConnHandle) > 0)
			IF !loc_lSucesso
				THIS.this_cMensagemErro = "Falha ao confirmar a transa" + CHR(231) + ;
					CHR(227) + "o: " + CapturarErroSQL()
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.ConfirmarTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	FUNCTION DesfazerTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLROLLBACK(gnConnHandle) > 0)
		CATCH TO loException
			MostrarErro("Erro ao desfazer transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.DesfazerTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


ENDDEFINE

