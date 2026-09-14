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
[08/04/2026 04:00:40 PM] Erro: Erro ao inicializar FormProduto: | Linha: 501 | Property COLUMNCOUNT is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-08 16:00:37] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-08 16:00:38] [INFO] Config FPW: (nao fornecido)
[2026-04-08 16:00:38] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-08 16:00:38] [INFO] Timeout: 300 segundos
[2026-04-08 16:00:38] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_212au1la.prg
[2026-04-08 16:00:38] [INFO] Conteudo do wrapper:
[2026-04-08 16:00:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormProduto', 'C:\4c\tasks\task003', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormProduto', 'C:\4c\tasks\task003', 'CRUD'
QUIT

[2026-04-08 16:00:38] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_212au1la.prg
[2026-04-08 16:00:38] [INFO] VFP output esperado em: C:\4c\tasks\task003\vfp_output.txt
[2026-04-08 16:00:38] [INFO] Executando Visual FoxPro 9...
[2026-04-08 16:00:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_212au1la.prg
[2026-04-08 16:00:38] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_212au1la.prg
[2026-04-08 16:00:38] [INFO] Timeout configurado: 300 segundos
[2026-04-08 16:00:41] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-08 16:00:41] [INFO] VFP9 finalizado em 2.6374895 segundos
[2026-04-08 16:00:41] [INFO] Exit Code: 
[2026-04-08 16:00:41] [INFO] 
[2026-04-08 16:00:41] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-08 16:00:41] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_212au1la.prg
[2026-04-08 16:00:41] [INFO] 
[2026-04-08 16:00:41] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-08 16:00:41] [INFO] * Auto-generated wrapper for parameters
[2026-04-08 16:00:41] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-08 16:00:41] [INFO] * Parameters: 'FormProduto', 'C:\4c\tasks\task003', 'CRUD'
[2026-04-08 16:00:41] [INFO] 
[2026-04-08 16:00:41] [INFO] * Anti-dialog protections for unattended execution
[2026-04-08 16:00:41] [INFO] SET SAFETY OFF
[2026-04-08 16:00:41] [INFO] SET RESOURCE OFF
[2026-04-08 16:00:41] [INFO] SET TALK OFF
[2026-04-08 16:00:41] [INFO] SET NOTIFY OFF
[2026-04-08 16:00:41] [INFO] SYS(2335, 0)
[2026-04-08 16:00:41] [INFO] 
[2026-04-08 16:00:41] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormProduto', 'C:\4c\tasks\task003', 'CRUD'
[2026-04-08 16:00:41] [INFO] QUIT
[2026-04-08 16:00:41] [INFO] 
[2026-04-08 16:00:41] [INFO] === Fim do Wrapper.prg ===
[2026-04-08 16:00:41] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormProduto",
  "timestamp": "20260408160040",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg):
*==============================================================================
* FormProduto.prg - Formulario de Cadastro de Produtos
* Fase: 8/8 - COMPLETO: todos metodos, bindings, integracao
* Tabela: SigCdPro | PK: cpros
* Legado: SIGCDPRO.SCX (frmcadastro)
* Dimensoes: Width=1000, Height=600
*==============================================================================

DEFINE CLASS FormProduto AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Produtos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject  = .NULL.
    this_cMensagemErro    = ""    && OBRIGATORIO - nao herdado de FormBase

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar instancia do Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Se falhar ao carregar, nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 600
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            *-- Page1 - Lista
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista de Produtos)
    * Compensacao +29 aplicada a todos os controles da Page
    * Pilar 1: UX fiel ao legado SIGCDPRO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oFiltros
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Container de cabecalho escuro (Top=2 na tela -> Top=31 na Page)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Produtos"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (sobrepoem o cabecalho escuro)
        *-- Top=0 no legado -> Top=29 (compensa PageFrame.Top=-29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 0
            .Width       = 540
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (aplica filtro da cnt_4c_Filtros)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (Encerrar, alinhado a direita)
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

        *-- Botao Encerrar
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de filtros (Grupo, Data ultima alteracao, Situacao)
        *-- Legado: cntFiltros
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        loc_oFiltros = loc_oPagina.cnt_4c_Filtros
        WITH loc_oFiltros
            .Top         = 114
            .Left        = 0
            .Width       = 1003
            .Height      = 70
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Linha 1: Grupo de Produto
        loc_oFiltros.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oFiltros.lbl_4c_Grupo
            .Caption   = "Grupo de Produto :"
            .Top       = 18
            .Left      = 21
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oFiltros.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oFiltros.txt_4c_Cgru
            .Value     = ""
            .Top       = 14
            .Left      = 116
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oFiltros.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oFiltros.txt_4c_Dgru
            .Value     = ""
            .Top       = 14
            .Left      = 149
            .Width     = 156
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Situacao: Todos / Ativos / Inativos
        loc_oFiltros.AddObject("opt_4c_Situas", "OptionGroup")
        WITH loc_oFiltros.opt_4c_Situas
            .Top         = 10
            .Left        = 315
            .Width       = 156
            .Height      = 22
            .ButtonCount = 3
            .Value       = 1
            .Themes      = .F.
            .Visible     = .T.
            .Buttons(1).Caption   = "Todos"
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).Width     = 50
            .Buttons(1).Height    = 22
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(0, 0, 0)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Ativos"
            .Buttons(2).Left      = 52
            .Buttons(2).Top       = 0
            .Buttons(2).Width     = 50
            .Buttons(2).Height    = 22
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(0, 0, 0)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "Inativos"
            .Buttons(3).Left      = 104
            .Buttons(3).Top       = 0
            .Buttons(3).Width     = 52
            .Buttons(3).Height    = 22
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(0, 0, 0)
            .Buttons(3).Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oFiltros.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")

        *-- Linha 2: Data ultima alteracao
        loc_oFiltros.AddObject("lbl_4c_DtAlt", "Label")
        WITH loc_oFiltros.lbl_4c_DtAlt
            .Caption   = CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
            .Top       = 43
            .Left      = 28
            .Width     = 87
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oFiltros.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oFiltros.txt_4c_DtIni
            .Value     = {}
            .Top       = 39
            .Left      = 116
            .Width     = 84
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oFiltros.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oFiltros.lbl_4c_Ate
            .Caption   = "at" + CHR(233)
            .Top       = 43
            .Left      = 202
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oFiltros.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oFiltros.txt_4c_DtFim
            .Value     = {}
            .Top       = 39
            .Left      = 225
            .Width     = 84
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Container de mensagem de status (cntMensagem do legado)
        loc_oPagina.AddObject("cnt_4c_Mensagem", "Container")
        WITH loc_oPagina.cnt_4c_Mensagem
            .Top         = 0
            .Left        = 0
            .Width       = 1003
            .Height      = 100
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Mensagem.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.cnt_4c_Mensagem.lbl_4c_Label1
            .Caption   = ""
            .Top       = 32
            .Left      = 72
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Cursor placeholder ANTES do grid (campo L evita "Data type mismatch" no CheckBox)
        SET NULL ON
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), dpro2s C(45), cgrus C(3), sgrus C(6), reffs C(40), chkInstalas L, dtalts T, usuaalts C(20), situas N(1))
        SET NULL OFF

        *-- Grid principal da lista (7 colunas, fiel ao legado)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top               = 192
            .Left              = 0
            .Width             = 1003
            .Height            = 380
            .ColumnCount       = 7
            .RecordSourceType  = 1
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .AllowHeaderSizing = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH

        *-- Larguras iniciais das colunas (FORA do WITH para evitar conflito)
        loc_oPagina.grd_4c_Dados.Column1.Width = 100
        loc_oPagina.grd_4c_Dados.Column2.Width = 260
        loc_oPagina.grd_4c_Dados.Column3.Width = 70
        loc_oPagina.grd_4c_Dados.Column4.Width = 80
        loc_oPagina.grd_4c_Dados.Column5.Width = 180
        loc_oPagina.grd_4c_Dados.Column6.Width = 100
        loc_oPagina.grd_4c_Dados.Column7.Width = 40

        *-- Column7: CheckBox para chkInstalas (coluna I = Instalavel)
        loc_oPagina.grd_4c_Dados.Column7.ColumnCount = 1
        loc_oPagina.grd_4c_Dados.Column7.AddObject("Check1", "CheckBox")
        loc_oPagina.grd_4c_Dados.Column7.CurrentControl = "Check1"
        loc_oPagina.grd_4c_Dados.Column7.Sparse = .F.

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
    * Estrutura: BotoesAcao + AbasNavegacao + pgf_4c_DadosPrd (7 paginas)
    * Fase 5: infra Page2 completa + primeiro 50% dos campos pgDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Container de botoes de acao (Salvar, Cancelar)
        *-- Legado: Grupo_Salva.Top=9 na tela -> Top=38 na Page2
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 38
            .Left        = 819
            .Width       = 165
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- OptionGroup navegacao de abas (7 abas, simula tabs do pgframeDados oculto)
        *-- Legado: Optiongroup1.Top=5 na tela -> Top=34 na Page2, Width=535, Height=85
        loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
        WITH loc_oPagina.opt_4c_Abas
            .Top         = 34
            .Left        = 5
            .Width       = 535
            .Height      = 85
            .ButtonCount = 7
            .Value       = 1
            .Themes      = .F.
            .Buttons(1).Caption   = "Dados"
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).Width     = 75
            .Buttons(1).Height    = 85
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).FontName  = "Tahoma"
            .Buttons(1).FontSize  = 8
            .Buttons(1).ForeColor = RGB(0, 0, 0)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Composi" + CHR(231) + CHR(227) + "o"
            .Buttons(2).Left      = 76
            .Buttons(2).Top       = 0
            .Buttons(2).Width     = 75
            .Buttons(2).Height    = 85
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).FontName  = "Tahoma"
            .Buttons(2).FontSize  = 8
            .Buttons(2).ForeColor = RGB(0, 0, 0)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "Fiscal"
            .Buttons(3).Left      = 152
            .Buttons(3).Top       = 0
            .Buttons(3).Width     = 75
            .Buttons(3).Height    = 85
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).FontName  = "Tahoma"
            .Buttons(3).FontSize  = 8
            .Buttons(3).ForeColor = RGB(0, 0, 0)
            .Buttons(3).Themes    = .F.
            .Buttons(4).Caption   = "Fases P."
            .Buttons(4).Left      = 228
            .Buttons(4).Top       = 0
            .Buttons(4).Width     = 75
            .Buttons(4).Height    = 85
            .Buttons(4).AutoSize  = .F.
            .Buttons(4).FontName  = "Tahoma"
            .Buttons(4).FontSize  = 8
            .Buttons(4).ForeColor = RGB(0, 0, 0)
            .Buttons(4).Themes    = .F.
            .Buttons(5).Caption   = "Cons. P."
            .Buttons(5).Left      = 304
            .Buttons(5).Top       = 0
            .Buttons(5).Width     = 75
            .Buttons(5).Height    = 85
            .Buttons(5).AutoSize  = .F.
            .Buttons(5).FontName  = "Tahoma"
            .Buttons(5).FontSize  = 8
            .Buttons(5).ForeColor = RGB(0, 0, 0)
            .Buttons(5).Themes    = .F.
            .Buttons(6).Caption   = "Custo"
            .Buttons(6).Left      = 380
            .Buttons(6).Top       = 0
            .Buttons(6).Width     = 75
            .Buttons(6).Height    = 85
            .Buttons(6).AutoSize  = .F.
            .Buttons(6).FontName  = "Tahoma"
            .Buttons(6).FontSize  = 8
            .Buttons(6).ForeColor = RGB(0, 0, 0)
            .Buttons(6).Themes    = .F.
            .Buttons(7).Caption   = "Designer"
            .Buttons(7).Left      = 456
            .Buttons(7).Top       = 0
            .Buttons(7).Width     = 79
            .Buttons(7).Height    = 85
            .Buttons(7).AutoSize  = .F.
            .Buttons(7).FontName  = "Tahoma"
            .Buttons(7).FontSize  = 8
            .Buttons(7).ForeColor = RGB(0, 0, 0)
            .Buttons(7).Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Abas, "InteractiveChange", THIS, "OptAbasChange")

        *-- Inner PageFrame (pgframeDados: Top=-54, Left=-1 na Page2, 7 paginas sem abas)
        loc_oPagina.AddObject("pgf_4c_DadosPrd", "PageFrame")
        WITH loc_oPagina.pgf_4c_DadosPrd
            .Top       = -54
            .Left      = -1
            .Width     = 1003
            .Height    = 656
            .PageCount = 7
            .Tabs      = .F.
            .Page1.Caption = "Dados"
            .Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
            .Page3.Caption = "Fiscal"
            .Page4.Caption = "Fases P."
            .Page5.Caption = "Cons. P."
            .Page6.Caption = "Custo"
            .Page7.Caption = "Designer"
        ENDWITH

        *-- Configurar controles da aba Dados (pgDados = Page1 do pgf_4c_DadosPrd)
        THIS.ConfigurarPgDados()

        *-- Garantir visibilidade do inner PageFrame e aba inicial
        loc_oPagina.pgf_4c_DadosPrd.Visible     = .T.
        loc_oPagina.pgf_4c_DadosPrd.ActivePage  = 1

        *-- Tornar controles visiveis na Page2 e na pgDados
        THIS.TornarControlesVisiveis(loc_oPagina)
        THIS.TornarControlesVisiveis(loc_oPagina.pgf_4c_DadosPrd.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgDados - Configura controles da aba Dados (pgDados = Page1)
    * Coordenadas: layout.json form-abs + 83 (29 outer PageFrame + 54 pgframeDados)
    * Fase 5: primeiro 50% dos campos (Top form-abs ate ~331 -> +83 = ~414)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgDados()
        LOCAL loc_oPgDados
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1

        *-- Botoes de imagem do produto (form-abs Top=33 -> 116)
        loc_oPgDados.AddObject("cmd_4c_Produto", "CommandButton")
        WITH loc_oPgDados.cmd_4c_Produto
            .Caption       = "Foto"
            .Top           = 116
            .Left          = 623
            .Width         = 85
            .Height        = 85
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(90, 90, 90)
        ENDWITH

        loc_oPgDados.AddObject("cmd_4c_Arquivos", "CommandButton")
        WITH loc_oPgDados.cmd_4c_Arquivos
            .Caption       = "Arquivos"
            .Top           = 116
            .Left          = 698
            .Width         = 85
            .Height        = 85
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(90, 90, 90)
        ENDWITH

        *-- === Codigo / Descricao / Situacao (form-abs Top=130 -> 213) ===
        loc_oPgDados.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPgDados.lbl_4c_Label2
            .Caption   = "Produto :"
            .Top       = 134
            .Left      = 58
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Cpro", "TextBox")
        WITH loc_oPgDados.txt_4c_Cpro
            .Top      = 213
            .Left     = 113
            .Width    = 108
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Dpro", "TextBox")
        WITH loc_oPgDados.txt_4c_Dpro
            .Top      = 213
            .Left     = 222
            .Width    = 290
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("opt_4c_Situacao", "OptionGroup")
        WITH loc_oPgDados.opt_4c_Situacao
            .Top         = 213
            .Left        = 735
            .Width       = 142
            .Height      = 25
            .ButtonCount = 2
            .Value       = 1
            .Themes      = .F.
            .Buttons(1).Caption   = "Ativo"
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).Width     = 70
            .Buttons(1).Height    = 25
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(0, 0, 0)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Inativo"
            .Buttons(2).Left      = 71
            .Buttons(2).Top       = 0
            .Buttons(2).Width     = 71
            .Buttons(2).Height    = 25
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(0, 0, 0)
            .Buttons(2).Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPgDados.opt_4c_Situacao, "InteractiveChange", THIS, "OptSituacaoChange")

        loc_oPgDados.AddObject("txt_4c_DtSituas", "TextBox")
        WITH loc_oPgDados.txt_4c_DtSituas
            .Top       = 215
            .Left      = 878
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
        ENDWITH

        *-- Equivalente (form-abs Top=133/137 -> 216/220)
        loc_oPgDados.AddObject("lbl_4c_LblEquiv", "Label")
        WITH loc_oPgDados.lbl_4c_LblEquiv
            .Caption   = "Equivalente :"
            .Top       = 220
            .Left      = 560
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_CProEq", "TextBox")
        WITH loc_oPgDados.txt_4c_CProEq
            .Top      = 216
            .Left     = 626
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_CProEq, "KeyPress", THIS, "KeyPressEquivalente")

        *-- === Descritivo / Lote Minimo / Barra (form-abs Top=154-155 -> 237-238) ===
        loc_oPgDados.AddObject("lbl_4c_LblDesc2", "Label")
        WITH loc_oPgDados.lbl_4c_LblDesc2
            .Caption   = "Descritivo :"
            .Top       = 240
            .Left      = 55
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_DPro2s", "TextBox")
        WITH loc_oPgDados.txt_4c_DPro2s
            .Top      = 237
            .Left     = 113
            .Width    = 399
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblLtMins", "Label")
        WITH loc_oPgDados.lbl_4c_LblLtMins
            .Caption   = "Lote M" + CHR(237) + "nimo :"
            .Top       = 240
            .Left      = 812
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_LtMinsV", "TextBox")
        WITH loc_oPgDados.txt_4c_LtMinsV
            .Top      = 237
            .Left     = 878
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblBarra", "Label")
        WITH loc_oPgDados.lbl_4c_LblBarra
            .Caption   = "Barra :"
            .Top       = 240
            .Left      = 590
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Cbar", "TextBox")
        WITH loc_oPgDados.txt_4c_Cbar
            .Top      = 238
            .Left     = 626
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        *-- Produto Web OptionGroup (form-abs Top=172/176 -> 255/259, 4 botoes)
        loc_oPgDados.AddObject("lbl_4c_LblProdWeb", "Label")
        WITH loc_oPgDados.lbl_4c_LblProdWeb
            .Caption   = "Produto Web :"
            .Top       = 259
            .Left      = 805
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("opt_4c_ProdutoWeb", "OptionGroup")
        WITH loc_oPgDados.opt_4c_ProdutoWeb
            .Top         = 255
            .Left        = 879
            .Width       = 117
            .Height      = 42
            .ButtonCount = 4
            .Value       = 1
            .Themes      = .F.
            .Buttons(1).Caption   = "N"
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).Width     = 29
            .Buttons(1).Height    = 42
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(0, 0, 0)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "S"
            .Buttons(2).Left      = 30
            .Buttons(2).Top       = 0
            .Buttons(2).Width     = 29
            .Buttons(2).Height    = 42
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(0, 0, 0)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "D"
            .Buttons(3).Left      = 60
            .Buttons(3).Top       = 0
            .Buttons(3).Width     = 29
            .Buttons(3).Height    = 42
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(0, 0, 0)
            .Buttons(3).Themes    = .F.
            .Buttons(4).Caption   = "I"
            .Buttons(4).Left      = 90
            .Buttons(4).Top       = 0
            .Buttons(4).Width     = 27
            .Buttons(4).Height    = 42
            .Buttons(4).AutoSize  = .F.
            .Buttons(4).ForeColor = RGB(0, 0, 0)
            .Buttons(4).Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPgDados.opt_4c_ProdutoWeb, "InteractiveChange", THIS, "OptProdutoWebChange")

        *-- === EAN13 / Grupo / Mercadoria / Identificador (form-abs Top=177-182 -> 260-265) ===
        loc_oPgDados.AddObject("lbl_4c_LblEAN", "Label")
        WITH loc_oPgDados.lbl_4c_LblEAN
            .Caption   = "EAN/GTIN :"
            .Top       = 264
            .Left      = 568
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_EAN13", "TextBox")
        WITH loc_oPgDados.txt_4c_EAN13
            .Top      = 260
            .Left     = 626
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPgDados.lbl_4c_LblGrupo
            .Caption   = "Grupo :"
            .Top       = 265
            .Left      = 73
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPgDados.txt_4c_Cgru
            .Top      = 261
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Cgru, "KeyPress", THIS, "KeyPressCgru")

        loc_oPgDados.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPgDados.txt_4c_Dgru
            .Top       = 261
            .Left      = 145
            .Width     = 171
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Merc", "TextBox")
        WITH loc_oPgDados.txt_4c_Merc
            .Top      = 261
            .Left     = 318
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblIdent", "Label")
        WITH loc_oPgDados.lbl_4c_LblIdent
            .Caption   = "Identificador :"
            .Top       = 265
            .Left      = 408
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_IdeCPros", "TextBox")
        WITH loc_oPgDados.txt_4c_IdeCPros
            .Top      = 261
            .Left     = 481
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        *-- === Qtde Minima / Subgrupo / Conjunto / Variacao (form-abs 199-207 -> 282-290) ===
        loc_oPgDados.AddObject("lbl_4c_LblQtmin", "Label")
        WITH loc_oPgDados.lbl_4c_LblQtmin
            .Caption   = "Qtde. M" + CHR(237) + "nima :"
            .Top       = 289
            .Left      = 553
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Qmin", "TextBox")
        WITH loc_oPgDados.txt_4c_Qmin
            .Top      = 282
            .Left     = 626
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("cmd_4c_CmdQtMin", "CommandButton")
        WITH loc_oPgDados.cmd_4c_CmdQtMin
            .Caption       = ". . ."
            .Top           = 199
            .Left          = 709
            .Width         = 25
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPgDados.cmd_4c_CmdQtMin, "Click", THIS, "BtnQtMinClick")

        loc_oPgDados.AddObject("lbl_4c_LblSubgrp", "Label")
        WITH loc_oPgDados.lbl_4c_LblSubgrp
            .Caption   = "Subgrupo :"
            .Top       = 286
            .Left      = 56
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_CSGru", "TextBox")
        WITH loc_oPgDados.txt_4c_CSGru
            .Top      = 285
            .Left     = 113
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_CSGru, "KeyPress", THIS, "KeyPressCSGru")

        loc_oPgDados.AddObject("txt_4c_DsGru", "TextBox")
        WITH loc_oPgDados.txt_4c_DsGru
            .Top       = 285
            .Left      = 166
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblConj", "Label")
        WITH loc_oPgDados.lbl_4c_LblConj
            .Caption   = "Conjunto :"
            .Top       = 289
            .Left      = 408
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Conjunto", "TextBox")
        WITH loc_oPgDados.txt_4c_Conjunto
            .Top      = 285
            .Left     = 460
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Conjunto, "KeyPress", THIS, "KeyPressConjunto")

        loc_oPgDados.AddObject("lbl_4c_LblVariacao", "Label")
        WITH loc_oPgDados.lbl_4c_LblVariacao
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
            .Top       = 290
            .Left      = 827
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("opt_4c_Variacao", "OptionGroup")
        WITH loc_oPgDados.opt_4c_Variacao
            .Top         = 286
            .Left        = 874
            .Width       = 107
            .Height      = 22
            .ButtonCount = 2
            .Value       = 1
            .Themes      = .F.
            .Buttons(1).Caption   = "Normal"
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).Width     = 53
            .Buttons(1).Height    = 22
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(0, 0, 0)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Varia" + CHR(231) + CHR(227) + "o"
            .Buttons(2).Left      = 54
            .Buttons(2).Top       = 0
            .Buttons(2).Width     = 53
            .Buttons(2).Height    = 22
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(0, 0, 0)
            .Buttons(2).Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPgDados.opt_4c_Variacao, "InteractiveChange", THIS, "OptVariacaoChange")

        *-- === Qtde Pedido / Linha / Garantia (form-abs 221-230 -> 304-313) ===
        loc_oPgDados.AddObject("lbl_4c_LblQtPed", "Label")
        WITH loc_oPgDados.lbl_4c_LblQtPed
            .Caption   = "Qtde. Pedido :"
            .Top       = 308
            .Left      = 553
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_QtPed", "TextBox")
        WITH loc_oPgDados.txt_4c_QtPed
            .Top      = 304
            .Left     = 626
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblGarantia", "Label")
        WITH loc_oPgDados.lbl_4c_LblGarantia
            .Caption   = "Garantia :"
            .Top       = 311
            .Left      = 827
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_DiasGar", "TextBox")
        WITH loc_oPgDados.txt_4c_DiasGar
            .Top      = 307
            .Left     = 880
            .Width    = 34
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblDias", "Label")
        WITH loc_oPgDados.lbl_4c_LblDias
            .Caption   = "Dias"
            .Top       = 311
            .Left      = 918
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("chk_4c_ChkGarVit", "CheckBox")
        WITH loc_oPgDados.chk_4c_ChkGarVit
            .Caption   = "Vital" + CHR(237) + "cia"
            .Top       = 228
            .Left      = 943
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblLinha", "Label")
        WITH loc_oPgDados.lbl_4c_LblLinha
            .Caption   = "Linha :"
            .Top       = 313
            .Left      = 77
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Lin", "TextBox")
        WITH loc_oPgDados.txt_4c_Lin
            .Top      = 309
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Lin, "KeyPress", THIS, "KeyPressLin")

        loc_oPgDados.AddObject("txt_4c_DLin", "TextBox")
        WITH loc_oPgDados.txt_4c_DLin
            .Top       = 309
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        *-- === Obs.Comp / Altura / Col.Venda (form-abs 243-253 -> 326-336) ===
        loc_oPgDados.AddObject("lbl_4c_LblObsComp", "Label")
        WITH loc_oPgDados.lbl_4c_LblObsComp
            .Caption   = "Obs. Comp. :"
            .Top       = 330
            .Left      = 529
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Obs3", "TextBox")
        WITH loc_oPgDados.txt_4c_Obs3
            .Top      = 326
            .Left     = 626
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblAltMM", "Label")
        WITH loc_oPgDados.lbl_4c_LblAltMM
            .Caption   = "Altura :"
            .Top       = 334
            .Left      = 881
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Altura", "TextBox")
        WITH loc_oPgDados.txt_4c_Altura
            .Top      = 330
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblMM1", "Label")
        WITH loc_oPgDados.lbl_4c_LblMM1
            .Caption   = "MM"
            .Top       = 334
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblColVenda", "Label")
        WITH loc_oPgDados.lbl_4c_LblColVenda
            .Caption   = "Grupo de Venda :"
            .Top       = 336
            .Left      = 25
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Col", "TextBox")
        WITH loc_oPgDados.txt_4c_Col
            .Top      = 333
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Col, "KeyPress", THIS, "KeyPressCol")

        loc_oPgDados.AddObject("txt_4c_DCol", "TextBox")
        WITH loc_oPgDados.txt_4c_DCol
            .Top       = 333
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        *-- === Obs1 / Largura (form-abs 265-269 -> 348-352) ===
        loc_oPgDados.AddObject("lbl_4c_LblObs1", "Label")
        WITH loc_oPgDados.lbl_4c_LblObs1
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 352
            .Left      = 558
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Obs1", "TextBox")
        WITH loc_oPgDados.txt_4c_Obs1
            .Top      = 348
            .Left     = 626
            .Width    = 220
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblLargMM", "Label")
        WITH loc_oPgDados.lbl_4c_LblLargMM
            .Caption   = "Largura :"
            .Top       = 355
            .Left      = 873
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Largura", "TextBox")
        WITH loc_oPgDados.txt_4c_Largura
            .Top      = 352
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblMM2", "Label")
        WITH loc_oPgDados.lbl_4c_LblMM2
            .Caption   = "MM"
            .Top       = 355
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Fornecedor / Obs2 / Diametro (form-abs 274-293 -> 357-376) ===
        loc_oPgDados.AddObject("lbl_4c_LblForn", "Label")
        WITH loc_oPgDados.lbl_4c_LblForn
            .Caption   = "Fornecedor :"
            .Top       = 361
            .Left      = 47
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Ifor", "TextBox")
        WITH loc_oPgDados.txt_4c_Ifor
            .Top      = 357
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Ifor, "KeyPress", THIS, "KeyPressFornecedor")

        loc_oPgDados.AddObject("txt_4c_Dfor", "TextBox")
        WITH loc_oPgDados.txt_4c_Dfor
            .Top       = 357
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("cmd_4c_BotFornecedor", "CommandButton")
        WITH loc_oPgDados.cmd_4c_BotFornecedor
            .Caption       = "..."
            .Top           = 382
            .Left          = 266
            .Width         = 32
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPgDados.cmd_4c_BotFornecedor, "Click", THIS, "BtnFornecedorClick")

        loc_oPgDados.AddObject("lbl_4c_LblObs2", "Label")
        WITH loc_oPgDados.lbl_4c_LblObs2
            .Caption   = "Complemento :"
            .Top       = 373
            .Left      = 551
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Obs2", "TextBox")
        WITH loc_oPgDados.txt_4c_Obs2
            .Top      = 370
            .Left     = 626
            .Width    = 220
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblDiam", "Label")
        WITH loc_oPgDados.lbl_4c_LblDiam
            .Caption   = "Di" + CHR(226) + "metro :"
            .Top       = 376
            .Left      = 867
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Diametro", "TextBox")
        WITH loc_oPgDados.txt_4c_Diametro
            .Top      = 374
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblMM3", "Label")
        WITH loc_oPgDados.lbl_4c_LblMM3
            .Caption   = "MM"
            .Top       = 376
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Ref.Forn / Cor / Tam / Ultimo-Compra (form-abs 298-316 -> 381-399) ===
        loc_oPgDados.AddObject("lbl_4c_LblRefForn", "Label")
        WITH loc_oPgDados.lbl_4c_LblRefForn
            .Caption   = "Ref. Fornecedor :"
            .Top       = 384
            .Left      = 23
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Refs", "TextBox")
        WITH loc_oPgDados.txt_4c_Refs
            .Top      = 381
            .Left     = 113
            .Width    = 152
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblCor", "Label")
        WITH loc_oPgDados.lbl_4c_LblCor
            .Caption   = "Padr" + CHR(227) + "o > Cor :"
            .Top       = 385
            .Left      = 323
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Cor", "TextBox")
        WITH loc_oPgDados.txt_4c_Cor
            .Top      = 381
            .Left     = 401
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Cor, "KeyPress", THIS, "KeyPressCor")

        loc_oPgDados.AddObject("lbl_4c_LblTam", "Label")
        WITH loc_oPgDados.lbl_4c_LblTam
            .Caption   = "Tam:"
            .Top       = 385
            .Left      = 442
            .Width     = 26
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Tam", "TextBox")
        WITH loc_oPgDados.txt_4c_Tam
            .Top      = 381
            .Left     = 474
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("cmd_4c_CmdTamanho", "CommandButton")
        WITH loc_oPgDados.cmd_4c_CmdTamanho
            .Caption       = "..."
            .Top           = 377
            .Left          = 513
            .Width         = 32
            .Height        = 29
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPgDados.cmd_4c_CmdTamanho, "Click", THIS, "BtnTamanhoClick")

        loc_oPgDados.AddObject("lbl_4c_LblUltCmp", "Label")
        WITH loc_oPgDados.lbl_4c_LblUltCmp
            .Caption   = CHR(218) + "lt.Compra :"
            .Top       = 396
            .Left      = 562
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c__Dtucp", "TextBox")
        WITH loc_oPgDados.txt_4c__Dtucp
            .Top       = 392
            .Left      = 626
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = {}
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Vucp", "TextBox")
        WITH loc_oPgDados.txt_4c_Vucp
            .Top       = 392
            .Left      = 706
            .Width     = 106
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = 0
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Mucp", "TextBox")
        WITH loc_oPgDados.txt_4c_Mucp
            .Top       = 392
            .Left      = 813
            .Width     = 33
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Espessura", "TextBox")
        WITH loc_oPgDados.txt_4c_Espessura
            .Top      = 396
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblEspesMM", "Label")
        WITH loc_oPgDados.lbl_4c_LblEspesMM
            .Caption   = "Espessura :"
            .Top       = 399
            .Left      = 861
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblMM4", "Label")
        WITH loc_oPgDados.lbl_4c_LblMM4
            .Caption   = "MM"
            .Top       = 399
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Modelo / Peso Bruto / Qtde Ult.Compra (form-abs 322-331 -> 405-414) ===
        loc_oPgDados.AddObject("lbl_4c_LblModelo", "Label")
        WITH loc_oPgDados.lbl_4c_LblModelo
            .Caption   = "Modelo :"
            .Top       = 326
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_CodFinP", "TextBox")
        WITH loc_oPgDados.txt_4c_CodFinP
            .Top      = 405
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_CodFinP, "KeyPress", THIS, "KeyPressModelo")

        loc_oPgDados.AddObject("txt_4c_DesFinP", "TextBox")
        WITH loc_oPgDados.txt_4c_DesFinP
            .Top       = 405
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblPesoBruto", "Label")
        WITH loc_oPgDados.lbl_4c_LblPesoBruto
            .Caption   = "Peso Bruto :"
            .Top       = 409
            .Left      = 336
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Peso", "TextBox")
        WITH loc_oPgDados.txt_4c_Peso
            .Top      = 405
            .Left     = 401
            .Width    = 111
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblQtdUltCmp", "Label")
        WITH loc_oPgDados.lbl_4c_LblQtdUltCmp
            .Caption   = "Qtde " + CHR(218) + "lt.Compra :"
            .Top       = 414
            .Left      = 535
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Qtdultcomp", "TextBox")
        WITH loc_oPgDados.txt_4c_Qtdultcomp
            .Top       = 414
            .Left      = 626
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = 0
        ENDWITH

        *== FASE 6: Controles restantes (form-abs Top 335-578 -> code +83) ==

        *-- === Comprimento (form-abs Top=335-340 -> 418-423) ===
        loc_oPgDados.AddObject("txt_4c_Compriment", "TextBox")
        WITH loc_oPgDados.txt_4c_Compriment
            .Top      = 418
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label51", "Label")
        WITH loc_oPgDados.lbl_4c_Label51
            .Caption   = "Comprimento :"
            .Top       = 422
            .Left      = 847
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label56", "Label")
        WITH loc_oPgDados.lbl_4c_Label56
            .Caption   = "CM"
            .Top       = 423
            .Left      = 976
            .Width     = 17
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Acabamento / Peso Liquido / Estoque (form-abs Top=346-357 -> 429-440) ===
        loc_oPgDados.AddObject("lbl_4c_LblAcabamento", "Label")
        WITH loc_oPgDados.lbl_4c_LblAcabamento
            .Caption   = "Acabamento :"
            .Top       = 350
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c__codacb", "TextBox")
        WITH loc_oPgDados.txt_4c__codacb
            .Top      = 429
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c__codacb, "KeyPress", THIS, "KeyPressAcabamento")

        loc_oPgDados.AddObject("txt_4c__Dacb", "TextBox")
        WITH loc_oPgDados.txt_4c__Dacb
            .Top       = 429
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oPgDados.lbl_4c_Label34
            .Caption   = "Peso L" + CHR(237) + "quido :"
            .Top       = 433
            .Left      = 329
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Pmedio", "TextBox")
        WITH loc_oPgDados.txt_4c_Pmedio
            .Top      = 429
            .Left     = 401
            .Width    = 111
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPgDados.lbl_4c_Label28
            .Caption   = "Estoque :"
            .Top       = 440
            .Left      = 577
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Estoques", "TextBox")
        WITH loc_oPgDados.txt_4c_Estoques
            .Top       = 436
            .Left      = 626
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = 0
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_QtdEsts", "TextBox")
        WITH loc_oPgDados.txt_4c_QtdEsts
            .Top       = 436
            .Left      = 706
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = 0
        ENDWITH

        loc_oPgDados.AddObject("cmd_4c_CmdEstoque", "CommandButton")
        WITH loc_oPgDados.cmd_4c_CmdEstoque
            .Caption       = "Est."
            .Top           = 436
            .Left          = 788
            .Width         = 42
            .Height        = 42
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH

        *-- === Data/Usuario header (form-abs Top=365 -> 448) ===
        loc_oPgDados.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPgDados.lbl_4c_Label20
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 448
            .Left      = 833
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Classificacao / Local / Custo (form-abs Top=370-384 -> 453-467) ===
        loc_oPgDados.AddObject("lbl_4c_LblClassificacao", "Label")
        WITH loc_oPgDados.lbl_4c_LblClassificacao
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Top       = 374
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Class", "TextBox")
        WITH loc_oPgDados.txt_4c_Class
            .Top      = 453
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Class, "KeyPress", THIS, "KeyPressClassificacao")

        loc_oPgDados.AddObject("txt_4c_DClass", "TextBox")
        WITH loc_oPgDados.txt_4c_DClass
            .Top       = 453
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPgDados.lbl_4c_Label5
            .Caption   = "Local :"
            .Top       = 457
            .Left      = 364
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPgDados.txt_4c_Local
            .Top      = 453
            .Left     = 401
            .Width    = 111
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Local, "KeyPress", THIS, "KeyPressLocal")

        loc_oPgDados.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPgDados.lbl_4c_Label3
            .Caption   = "Valor de Custo :"
            .Top       = 462
            .Left      = 546
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Ctotal", "TextBox")
        WITH loc_oPgDados.txt_4c_Ctotal
            .Top       = 458
            .Left      = 626
            .Width     = 127
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = 0
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Mctotal", "TextBox")
        WITH loc_oPgDados.txt_4c_Mctotal
            .Top       = 458
            .Left      = 754
            .Width     = 31
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        *-- Inclusao/Alteracao header (form-abs 380-384 -> 463-467)
        loc_oPgDados.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPgDados.shp_4c_Shape3
            .Top    = 463
            .Left   = 833
            .Width  = 161
            .Height = 2
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPgDados.lbl_4c_Label24
            .Caption   = "Inclus" + CHR(227) + "o"
            .Top       = 467
            .Left      = 833
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPgDados.lbl_4c_Label25
            .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
            .Top       = 467
            .Left      = 914
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Unidades / Datas / Valor Venda (form-abs Top=394-400 -> 477-483) ===
        loc_oPgDados.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPgDados.lbl_4c_Label14
            .Caption   = "Unidades (1) :"
            .Top       = 481
            .Left      = 41
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Cuni", "TextBox")
        WITH loc_oPgDados.txt_4c_Cuni
            .Top      = 477
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Cuni, "KeyPress", THIS, "KeyPressUnidade")

        loc_oPgDados.AddObject("txt_4c_Duni", "TextBox")
        WITH loc_oPgDados.txt_4c_Duni
            .Top       = 477
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPgDados.lbl_4c_Label18
            .Caption   = "(2) :"
            .Top       = 481
            .Left      = 301
            .Width     = 23
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Cunip", "TextBox")
        WITH loc_oPgDados.txt_4c_Cunip
            .Top      = 477
            .Left     = 330
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH
        BINDEVENT(loc_oPgDados.txt_4c_Cunip, "KeyPress", THIS, "KeyPressUnidade2")

        loc_oPgDados.AddObject("txt_4c__dunip", "TextBox")
        WITH loc_oPgDados.txt_4c__dunip
            .Top       = 477
            .Left      = 362
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPgDados.txt_4c_DtIncs
            .Top       = 480
            .Left      = 833
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = {}
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_DataAlts", "TextBox")
        WITH loc_oPgDados.txt_4c_DataAlts
            .Top       = 480
            .Left      = 914
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = {}
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Pvenda", "TextBox")
        WITH loc_oPgDados.txt_4c_Pvenda
            .Top       = 480
            .Left      = 626
            .Width     = 127
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = 0
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Mpvenda", "TextBox")
        WITH loc_oPgDados.txt_4c_Mpvenda
            .Top       = 480
            .Left      = 754
            .Width     = 31
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPgDados.lbl_4c_Label4
            .Caption   = "Valor de Venda :"
            .Top       = 483
            .Left      = 505
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Cod.Identidade / Fator Venda / Usuarios (form-abs 418-422 -> 501-505) ===
        loc_oPgDados.AddObject("txt_4c_CodIdent", "TextBox")
        WITH loc_oPgDados.txt_4c_CodIdent
            .Top      = 501
            .Left     = 113
            .Width    = 182
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Fvenda", "TextBox")
        WITH loc_oPgDados.txt_4c_Fvenda
            .Top       = 502
            .Left      = 626
            .Width     = 127
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = 0
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Mfvenda", "TextBox")
        WITH loc_oPgDados.txt_4c_Mfvenda
            .Top       = 502
            .Left      = 754
            .Width     = 31
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPgDados.txt_4c_Usuario
            .Top       = 502
            .Left      = 833
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH loc_oPgDados.txt_4c_UsuaAlts
            .Top       = 502
            .Left      = 914
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Value     = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oPgDados.lbl_4c_Label38
            .Caption   = "Cod. Identidade :"
            .Top       = 505
            .Left      = 24
            .Width     = 87
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPgDados.lbl_4c_Label6
            .Caption   = "Fator de Venda :"
            .Top       = 505
            .Left      = 539
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Separator line (form-abs 444 -> 527) ===
        loc_oPgDados.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPgDados.shp_4c_Shape1
            .Top    = 527
            .Left   = 4
            .Width  = 991
            .Height = 2
        ENDWITH

        *-- === Desc.Compra / Entrega / Checkboxes (form-abs 447-470 -> 530-553) ===
        loc_oPgDados.AddObject("txt_4c_TEnts", "TextBox")
        WITH loc_oPgDados.txt_4c_TEnts
            .Top      = 530
            .Left     = 934
            .Width    = 31
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oPgDados.lbl_4c_Label31
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :" + CHR(13) + "Compra ."
            .Top       = 531
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .WordWrap  = .T.
        ENDWITH

        loc_oPgDados.AddObject("edt_4c_DscCompras", "EditBox")
        WITH loc_oPgDados.edt_4c_DscCompras
            .Top      = 531
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oPgDados.lbl_4c_Label39
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 534
            .Left      = 548
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("chk_4c_Get_Consig", "CheckBox")
        WITH loc_oPgDados.chk_4c_Get_Consig
            .Caption   = "Consigna"
            .Top       = 451
            .Left      = 601
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
        ENDWITH

        loc_oPgDados.AddObject("chk_4c_ChkFabrProprs", "CheckBox")
        WITH loc_oPgDados.chk_4c_ChkFabrProprs
            .Caption   = "Fabr. Pr" + CHR(243) + "pria"
            .Top       = 451
            .Left      = 681
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
        ENDWITH

        loc_oPgDados.AddObject("chk_4c_ChkEncoms", "CheckBox")
        WITH loc_oPgDados.chk_4c_ChkEncoms
            .Caption   = "Encomenda"
            .Top       = 451
            .Left      = 781
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPgDados.lbl_4c_Label9
            .Caption   = "Entrega :"
            .Top       = 451
            .Left      = 884
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPgDados.lbl_4c_Label10
            .Caption   = "Dias"
            .Top       = 451
            .Left      = 967
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Dimensoes / Volumes (form-abs 470-474 -> 553-557) ===
        loc_oPgDados.AddObject("txt_4c_Fwget6", "TextBox")
        WITH loc_oPgDados.txt_4c_Fwget6
            .Top      = 470
            .Left     = 601
            .Width    = 58
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Fwget5", "TextBox")
        WITH loc_oPgDados.txt_4c_Fwget5
            .Top      = 470
            .Left     = 688
            .Width    = 58
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Fwget4", "TextBox")
        WITH loc_oPgDados.txt_4c_Fwget4
            .Top      = 470
            .Left     = 776
            .Width    = 58
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("txt_4c_Fwget3", "TextBox")
        WITH loc_oPgDados.txt_4c_Fwget3
            .Top      = 470
            .Left     = 934
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPgDados.lbl_4c_Label27
            .Caption   = "Dimens" + CHR(227) + "o :"
            .Top       = 557
            .Left      = 543
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblProfundidade", "Label")
        WITH loc_oPgDados.lbl_4c_LblProfundidade
            .Caption   = "ppp"
            .Top       = 474
            .Left      = 661
            .Width     = 20
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblAltura", "Label")
        WITH loc_oPgDados.lbl_4c_LblAltura
            .Caption   = "aaa"
            .Top       = 474
            .Left      = 749
            .Width     = 20
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_LblComprimento", "Label")
        WITH loc_oPgDados.lbl_4c_LblComprimento
            .Caption   = "ccc"
            .Top       = 474
            .Left      = 836
            .Width     = 17
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPgDados.lbl_4c_Label26
            .Caption   = "Volumes :"
            .Top       = 557
            .Left      = 883
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- === Imagens / Desc.Completa (form-abs 496-521 -> 579-604) ===
        loc_oPgDados.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
        WITH loc_oPgDados.cmd_4c_CmdgFigCam
            .Caption       = "Cam"
            .Top           = 579
            .Left          = 717
            .Width         = 50
            .Height        = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label40", "Label")
        WITH loc_oPgDados.lbl_4c_Label40
            .Caption   = "Imagem Principal"
            .Top       = 585
            .Left      = 543
            .Width     = 101
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label41", "Label")
        WITH loc_oPgDados.lbl_4c_Label41
            .Caption   = "Imagem T" + CHR(233) + "cnica"
            .Top       = 585
            .Left      = 775
            .Width     = 96
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oPgDados.lbl_4c_Label33
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :" + CHR(13) + "Completa ."
            .Top       = 590
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .WordWrap  = .T.
        ENDWITH

        loc_oPgDados.AddObject("edt_4c_DPro3s", "EditBox")
        WITH loc_oPgDados.edt_4c_DPro3s
            .Top      = 590
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("shp_4c_ShpFig", "Shape")
        WITH loc_oPgDados.shp_4c_ShpFig
            .Top    = 603
            .Left   = 543
            .Width  = 174
            .Height = 103
        ENDWITH

        loc_oPgDados.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPgDados.shp_4c_Shape2
            .Top    = 602
            .Left   = 775
            .Width  = 174
            .Height = 103
        ENDWITH

        loc_oPgDados.AddObject("img_4c_ImgFigJpg", "Image")
        WITH loc_oPgDados.img_4c_ImgFigJpg
            .Top    = 604
            .Left   = 544
            .Width  = 172
            .Height = 101
        ENDWITH

        loc_oPgDados.AddObject("img_4c_ImgFigTec", "Image")
        WITH loc_oPgDados.img_4c_ImgFigTec
            .Top    = 603
            .Left   = 776
            .Width  = 172
            .Height = 101
        ENDWITH

        *-- === Zoom / Obs.Compra / Comandos finais (form-abs 537-578 -> 620-661) ===
        loc_oPgDados.AddObject("cmd_4c_CmdZoom", "CommandButton")
        WITH loc_oPgDados.cmd_4c_CmdZoom
            .Caption       = "Zoom"
            .Top           = 620
            .Left          = 717
            .Width         = 50
            .Height        = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH

        loc_oPgDados.AddObject("cmd_4c_Commandgroup2", "CommandButton")
        WITH loc_oPgDados.cmd_4c_Commandgroup2
            .Caption       = "..."
            .Top           = 620
            .Left          = 948
            .Width         = 50
            .Height        = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH

        loc_oPgDados.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oPgDados.lbl_4c_Label32
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :" + CHR(13) + "da  Compra ."
            .Top       = 649
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .WordWrap  = .T.
        ENDWITH

        loc_oPgDados.AddObject("edt_4c_ObsCompras", "EditBox")
        WITH loc_oPgDados.edt_4c_ObsCompras
            .Top      = 649
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
        ENDWITH

        loc_oPgDados.AddObject("cmd_4c_CmdgFigura", "CommandButton")
        WITH loc_oPgDados.cmd_4c_CmdgFigura
            .Caption       = "Fig."
            .Top           = 661
            .Left          = 717
            .Width         = 50
            .Height        = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH

        loc_oPgDados.AddObject("cmd_4c_Commandgroup1", "CommandButton")
        WITH loc_oPgDados.cmd_4c_Commandgroup1
            .Caption       = "..."
            .Top           = 661
            .Left          = 948
            .Width         = 50
            .Height        = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega produtos no grid com filtros da cnt_4c_Filtros
    * Colunas: cpros(100), dpros(260), cgrus(70), sgrus(80), reffs(180),
    *          usuaalts(100), chkInstalas(40)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_oFiltros, loc_cFiltro, loc_nSituas
        LOCAL loc_cCgru, loc_dDtIni, loc_dDtFim, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oGrid    = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros

            *-- Ler valores do filtro
            loc_cCgru   = ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value)
            loc_nSituas = loc_oFiltros.opt_4c_Situas.Value
            loc_dDtIni  = loc_oFiltros.txt_4c_DtIni.Value
            loc_dDtFim  = loc_oFiltros.txt_4c_DtFim.Value

            *-- Montar WHERE clause
            loc_cFiltro = "1=1"

            IF !EMPTY(loc_cCgru)
                loc_cFiltro = loc_cFiltro + " AND cgrus = " + EscaparSQL(loc_cCgru)
            ENDIF

            IF loc_nSituas = 2
                loc_cFiltro = loc_cFiltro + " AND situas = 1"
            ELSE
                IF loc_nSituas = 3
                    loc_cFiltro = loc_cFiltro + " AND situas = 0"
                ENDIF
            ENDIF

            IF VARTYPE(loc_dDtIni) = "D" AND !EMPTY(loc_dDtIni)
                loc_cFiltro = loc_cFiltro + " AND DataAlts >= " + FormatarDataSQL(loc_dDtIni)
            ENDIF

            IF VARTYPE(loc_dDtFim) = "D" AND !EMPTY(loc_dDtFim)
                loc_cFiltro = loc_cFiltro + " AND DataAlts <= " + FormatarDataSQL(loc_dDtFim)
            ENDIF

            *-- Buscar dados via BO
            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_lSucesso = .F.
            ELSE
                *-- RecordSource FORA de WITH (evita "Unknown member COLUMNx")
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- ControlSources APOS RecordSource (VFP9 resetaria as colunas)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.chkInstalas"

                *-- Larguras e cabecalhos APOS RecordSource (OBRIGATORIO - VFP reseta)
                loc_oGrid.Column1.Width = 100
                loc_oGrid.Column2.Width = 260
                loc_oGrid.Column3.Width = 70
                loc_oGrid.Column4.Width = 80
                loc_oGrid.Column5.Width = 180
                loc_oGrid.Column6.Width = 100
                loc_oGrid.Column7.Width = 40
                loc_oGrid.Column1.Header1.Caption = "Produto"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Grupo"
                loc_oGrid.Column4.Header1.Caption = "Subgrp."
                loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
                loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
                loc_oGrid.Column7.Header1.Caption = "I"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis apenas controles esperados
    * IMPORTANTE: Filtrar por nome para nao tornar containers flutuantes visiveis
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oPagina)
        LOCAL loc_i
        FOR loc_i = 1 TO par_oPagina.ControlCount
            IF SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "cnt_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "grd_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "lbl_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "txt_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "cmd_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "pgf_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "opt_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "chk_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "edt_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "shp_" OR ;
               SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "img_"
                par_oPagina.Controls(loc_i).Visible = .T.
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * OptSituasChange - Recarrega lista ao mudar situacao (BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE OptSituasChange()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * OptSituacaoChange - Situacao (Ativo/Inativo) no formulario de dados
    *--------------------------------------------------------------------------
    PROCEDURE OptSituacaoChange()
        *-- Campo de dados do produto, nao recarrega lista
    ENDPROC

    *--------------------------------------------------------------------------
    * OptProdutoWebChange - ProdutoWeb no formulario de dados
    *--------------------------------------------------------------------------
    PROCEDURE OptProdutoWebChange()
        *-- Campo de dados do produto, nao recarrega lista
    ENDPROC

    *--------------------------------------------------------------------------
    * OptVariacaoChange - Variacao no formulario de dados
    *--------------------------------------------------------------------------
    PROCEDURE OptVariacaoChange()
        *-- Campo de dados do produto, nao recarrega lista
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo produto
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.ActivePage = 1
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCpros
        loc_cCpros = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCpros)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.ActivePage = 1
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCpros
        loc_cCpros = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCpros)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.ActivePage = 1
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCpros
        loc_cCpros = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum produto selecionado!")
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto '" + loc_cCpros + "'?")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCpros)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao excluir")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Aplicar filtro e recarregar lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para os campos da pgDados (Phase 5)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPgDados, loc_oBO
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_oBO      = THIS.this_oBusinessObject

        TRY
            loc_oPgDados.txt_4c_Cpro.Value     = ALLTRIM(loc_oBO.this_cCpros)
            loc_oPgDados.txt_4c_Dgru.Value     = ALLTRIM(loc_oBO.this_cDgrus)
            loc_oPgDados.txt_4c_Cgru.Value     = ALLTRIM(loc_oBO.this_cCgrus)
            loc_oPgDados.txt_4c_Dpro.Value     = ALLTRIM(loc_oBO.this_cDpros)
            loc_oPgDados.txt_4c_DPro2s.Value   = ALLTRIM(loc_oBO.this_cDpro2s)
            loc_oPgDados.txt_4c_CSGru.Value    = ALLTRIM(loc_oBO.this_cCSGrus)
            loc_oPgDados.txt_4c_DsGru.Value    = ALLTRIM(loc_oBO.this_cDsGrus)
            loc_oPgDados.txt_4c_Lin.Value      = ALLTRIM(loc_oBO.this_cLins)
            loc_oPgDados.txt_4c_DLin.Value     = ALLTRIM(loc_oBO.this_cDLins)
            loc_oPgDados.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cCols)
            loc_oPgDados.txt_4c_DCol.Value     = ALLTRIM(loc_oBO.this_cDCols)
            loc_oPgDados.txt_4c_Ifor.Value     = loc_oBO.this_nIfor
            loc_oPgDados.txt_4c_Dfor.Value     = ALLTRIM(loc_oBO.this_cDfor)
            loc_oPgDados.txt_4c_Refs.Value     = ALLTRIM(loc_oBO.this_cReffs)
            loc_oPgDados.txt_4c_Cbar.Value     = ALLTRIM(loc_oBO.this_cCbars)
            loc_oPgDados.txt_4c_EAN13.Value    = ALLTRIM(loc_oBO.this_cEAN13s)
            loc_oPgDados.txt_4c_CProEq.Value   = ALLTRIM(loc_oBO.this_cCProEqs)
            loc_oPgDados.txt_4c_Merc.Value     = ALLTRIM(loc_oBO.this_cMercs)
            loc_oPgDados.txt_4c_IdeCPros.Value = ALLTRIM(loc_oBO.this_cIdeCPros)
            loc_oPgDados.txt_4c_Qmin.Value     = loc_oBO.this_nQmins
            loc_oPgDados.txt_4c_QtPed.Value    = loc_oBO.this_nQtPeds
            loc_oPgDados.txt_4c_Conjunto.Value = ALLTRIM(loc_oBO.this_cConjuntos)
            loc_oPgDados.txt_4c_DiasGar.Value  = loc_oBO.this_nDiasGar
            loc_oPgDados.chk_4c_ChkGarVit.Value = IIF(loc_oBO.this_nChkGarVit = 1, 1, 0)
            loc_oPgDados.txt_4c_Obs1.Value     = ALLTRIM(loc_oBO.this_cObs1s)
            loc_oPgDados.txt_4c_Obs2.Value     = ALLTRIM(loc_oBO.this_cObs2s)
            loc_oPgDados.txt_4c_Obs3.Value     = ALLTRIM(loc_oBO.this_cObs3s)
            loc_oPgDados.txt_4c_Cor.Value      = ALLTRIM(loc_oBO.this_cCors)
            loc_oPgDados.txt_4c_Tam.Value      = ALLTRIM(loc_oBO.this_cTams)
            loc_oPgDados.txt_4c_LtMinsV.Value  = loc_oBO.this_nLtMinsV
            loc_oPgDados.txt_4c_Peso.Value     = loc_oBO.this_nPesoBs
            loc_oPgDados.txt_4c_CodFinP.Value  = ALLTRIM(loc_oBO.this_cCodFinP)
            loc_oPgDados.txt_4c_DesFinP.Value  = ALLTRIM(loc_oBO.this_cDesFinP)
            loc_oPgDados.txt_4c_Altura.Value   = loc_oBO.this_nAltura
            loc_oPgDados.txt_4c_Largura.Value  = loc_oBO.this_nLargura
            loc_oPgDados.txt_4c_Diametro.Value = loc_oBO.this_nDiametro
            loc_oPgDados.txt_4c_Espessura.Value= loc_oBO.this_nEspessura
            loc_oPgDados.opt_4c_Situacao.Value = IIF(loc_oBO.this_nSituas = 1, 1, 2)
            loc_oPgDados.opt_4c_ProdutoWeb.Value = IIF(loc_oBO.this_nProdWeb >= 1, loc_oBO.this_nProdWeb, 1)
            loc_oPgDados.opt_4c_Variacao.Value = IIF(loc_oBO.this_nVariacao >= 1, loc_oBO.this_nVariacao, 1)
            *-- Fase 6
            loc_oPgDados.txt_4c_Compriment.Value   = loc_oBO.this_nCompriment
            loc_oPgDados.txt_4c__codacb.Value       = ALLTRIM(loc_oBO.this_c_codacb)
            loc_oPgDados.txt_4c__Dacb.Value         = ALLTRIM(loc_oBO.this_c_Dacb)
            loc_oPgDados.txt_4c_Pmedio.Value        = loc_oBO.this_nPmedio
            loc_oPgDados.txt_4c_Class.Value         = ALLTRIM(loc_oBO.this_cClass)
            loc_oPgDados.txt_4c_DClass.Value        = ALLTRIM(loc_oBO.this_cDClass)
            loc_oPgDados.txt_4c_Local.Value         = ALLTRIM(loc_oBO.this_cLocal)
            loc_oPgDados.txt_4c_Cuni.Value          = ALLTRIM(loc_oBO.this_cCuni)
            loc_oPgDados.txt_4c_Duni.Value          = ALLTRIM(loc_oBO.this_cDuni)
            loc_oPgDados.txt_4c_Cunip.Value         = ALLTRIM(loc_oBO.this_cCunip)
            loc_oPgDados.txt_4c__dunip.Value        = ALLTRIM(loc_oBO.this_c_dunip)
            loc_oPgDados.txt_4c_DtIncs.Value        = loc_oBO.this_dDtIncs
            loc_oPgDados.txt_4c_DataAlts.Value      = loc_oBO.this_dDataAlts
            loc_oPgDados.txt_4c_Pvenda.Value        = loc_oBO.this_nPvenda
            loc_oPgDados.txt_4c_Mpvenda.Value       = ALLTRIM(loc_oBO.this_cMpvenda)
            loc_oPgDados.txt_4c_Fvenda.Value        = loc_oBO.this_nFvenda
            loc_oPgDados.txt_4c_Mfvenda.Value       = ALLTRIM(loc_oBO.this_cMfvenda)
            loc_oPgDados.txt_4c_CodIdent.Value      = ALLTRIM(loc_oBO.this_cCodIdent)
            loc_oPgDados.txt_4c_Usuario.Value       = ALLTRIM(loc_oBO.this_cUsuario)
            loc_oPgDados.txt_4c_UsuaAlts.Value      = ALLTRIM(loc_oBO.this_cUsuaAlts)
            loc_oPgDados.txt_4c_TEnts.Value         = loc_oBO.this_nTEnts
            loc_oPgDados.edt_4c_DscCompras.Value    = loc_oBO.this_cDscCompras
            loc_oPgDados.chk_4c_Get_Consig.Value    = IIF(loc_oBO.this_nConsig = 1, 1, 0)
            loc_oPgDados.chk_4c_ChkFabrProprs.Value = IIF(loc_oBO.this_nFabrProprs = 1, 1, 0)
            loc_oPgDados.chk_4c_ChkEncoms.Value     = IIF(loc_oBO.this_nEncoms = 1, 1, 0)
            loc_oPgDados.txt_4c_Fwget6.Value        = loc_oBO.this_nFwget6
            loc_oPgDados.txt_4c_Fwget5.Value        = loc_oBO.this_nFwget5
            loc_oPgDados.txt_4c_Fwget4.Value        = loc_oBO.this_nFwget4
            loc_oPgDados.txt_4c_Fwget3.Value        = loc_oBO.this_nFwget3
            loc_oPgDados.edt_4c_DPro3s.Value        = loc_oBO.this_cDPro3s
            loc_oPgDados.edt_4c_ObsCompras.Value    = loc_oBO.this_cObsCompras
            *-- Campos somente-leitura (exibicao)
            loc_oPgDados.txt_4c_DtSituas.Value      = loc_oBO.this_dDtSituas
            loc_oPgDados.txt_4c_Estoques.Value      = TRANSFORM(loc_oBO.this_nEstoques)
            loc_oPgDados.txt_4c_QtdEsts.Value       = loc_oBO.this_nQtdEsts
            loc_oPgDados.txt_4c_Ctotal.Value        = loc_oBO.this_nCtotal
            loc_oPgDados.txt_4c_Mctotal.Value       = ALLTRIM(loc_oBO.this_cMctotal)
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar campos:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados dos campos (pgDados) para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPgDados, loc_oBO
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_oBO      = THIS.this_oBusinessObject

        TRY
            loc_oBO.this_cCpros    = ALLTRIM(loc_oPgDados.txt_4c_Cpro.Value)
            loc_oBO.this_cDpros    = ALLTRIM(loc_oPgDados.txt_4c_Dpro.Value)
            loc_oBO.this_cDpro2s   = ALLTRIM(loc_oPgDados.txt_4c_DPro2s.Value)
            loc_oBO.this_cCgrus    = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
            loc_oBO.this_cDgrus    = ALLTRIM(loc_oPgDados.txt_4c_Dgru.Value)
            loc_oBO.this_cCSGrus   = ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value)
            loc_oBO.this_cDsGrus   = ALLTRIM(loc_oPgDados.txt_4c_DsGru.Value)
            loc_oBO.this_cLins     = ALLTRIM(loc_oPgDados.txt_4c_Lin.Value)
            loc_oBO.this_cDLins    = ALLTRIM(loc_oPgDados.txt_4c_DLin.Value)
            loc_oBO.this_cCols     = ALLTRIM(loc_oPgDados.txt_4c_Col.Value)
            loc_oBO.this_cDCols    = ALLTRIM(loc_oPgDados.txt_4c_DCol.Value)
            loc_oBO.this_nIfor     = loc_oPgDados.txt_4c_Ifor.Value
            loc_oBO.this_cDfor     = ALLTRIM(loc_oPgDados.txt_4c_Dfor.Value)
            loc_oBO.this_cReffs    = ALLTRIM(loc_oPgDados.txt_4c_Refs.Value)
            loc_oBO.this_cCbars    = ALLTRIM(loc_oPgDados.txt_4c_Cbar.Value)
            loc_oBO.this_cEAN13s   = ALLTRIM(loc_oPgDados.txt_4c_EAN13.Value)
            loc_oBO.this_cCProEqs  = ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value)
            loc_oBO.this_cMercs    = ALLTRIM(loc_oPgDados.txt_4c_Merc.Value)
            loc_oBO.this_cIdeCPros = ALLTRIM(loc_oPgDados.txt_4c_IdeCPros.Value)
            loc_oBO.this_nQmins    = loc_oPgDados.txt_4c_Qmin.Value
            loc_oBO.this_nQtPeds   = loc_oPgDados.txt_4c_QtPed.Value
            loc_oBO.this_cConjuntos = ALLTRIM(loc_oPgDados.txt_4c_Conjunto.Value)
            loc_oBO.this_nDiasGar  = loc_oPgDados.txt_4c_DiasGar.Value
            loc_oBO.this_nChkGarVit = loc_oPgDados.chk_4c_ChkGarVit.Value
            loc_oBO.this_cObs1s    = ALLTRIM(loc_oPgDados.txt_4c_Obs1.Value)
            loc_oBO.this_cObs2s    = ALLTRIM(loc_oPgDados.txt_4c_Obs2.Value)
            loc_oBO.this_cObs3s    = ALLTRIM(loc_oPgDados.txt_4c_Obs3.Value)
            loc_oBO.this_cCors     = ALLTRIM(loc_oPgDados.txt_4c_Cor.Value)
            loc_oBO.this_cTams     = ALLTRIM(loc_oPgDados.txt_4c_Tam.Value)
            loc_oBO.this_nLtMinsV  = loc_oPgDados.txt_4c_LtMinsV.Value
            loc_oBO.this_nPesoBs   = loc_oPgDados.txt_4c_Peso.Value
            loc_oBO.this_cCodFinP  = ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value)
            loc_oBO.this_cDesFinP  = ALLTRIM(loc_oPgDados.txt_4c_DesFinP.Value)
            loc_oBO.this_nAltura   = loc_oPgDados.txt_4c_Altura.Value
            loc_oBO.this_nLargura  = loc_oPgDados.txt_4c_Largura.Value
            loc_oBO.this_nDiametro = loc_oPgDados.txt_4c_Diametro.Value
            loc_oBO.this_nEspessura= loc_oPgDados.txt_4c_Espessura.Value
            loc_oBO.this_nSituas   = IIF(loc_oPgDados.opt_4c_Situacao.Value = 1, 1, 0)
            loc_oBO.this_nProdWeb  = loc_oPgDados.opt_4c_ProdutoWeb.Value
            loc_oBO.this_nVariacao = loc_oPgDados.opt_4c_Variacao.Value
            *-- Fase 6
            loc_oBO.this_nCompriment  = loc_oPgDados.txt_4c_Compriment.Value
            loc_oBO.this_c_codacb     = ALLTRIM(loc_oPgDados.txt_4c__codacb.Value)
            loc_oBO.this_nPmedio      = loc_oPgDados.txt_4c_Pmedio.Value
            loc_oBO.this_cClass       = ALLTRIM(loc_oPgDados.txt_4c_Class.Value)
            loc_oBO.this_cLocal       = ALLTRIM(loc_oPgDados.txt_4c_Local.Value)
            loc_oBO.this_cCuni        = ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value)
            loc_oBO.this_cCunip       = ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value)
            loc_oBO.this_cCodIdent    = ALLTRIM(loc_oPgDados.txt_4c_CodIdent.Value)
            loc_oBO.this_nTEnts       = loc_oPgDados.txt_4c_TEnts.Value
            loc_oBO.this_cDscCompras  = loc_oPgDados.edt_4c_DscCompras.Value
            loc_oBO.this_nConsig      = loc_oPgDados.chk_4c_Get_Consig.Value
            loc_oBO.this_nFabrProprs  = loc_oPgDados.chk_4c_ChkFabrProprs.Value
            loc_oBO.this_nEncoms      = loc_oPgDados.chk_4c_ChkEncoms.Value
            loc_oBO.this_nFwget6      = loc_oPgDados.txt_4c_Fwget6.Value
            loc_oBO.this_nFwget5      = loc_oPgDados.txt_4c_Fwget5.Value
            loc_oBO.this_nFwget4      = loc_oPgDados.txt_4c_Fwget4.Value
            loc_oBO.this_nFwget3      = loc_oPgDados.txt_4c_Fwget3.Value
            loc_oBO.this_cDPro3s      = loc_oPgDados.edt_4c_DPro3s.Value
            loc_oBO.this_cObsCompras  = loc_oPgDados.edt_4c_ObsCompras.Value
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar campos:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da pgDados (Phase 5)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPgDados
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1

        TRY
            loc_oPgDados.txt_4c_Cpro.Value      = ""
            loc_oPgDados.txt_4c_Dpro.Value      = ""
            loc_oPgDados.txt_4c_DPro2s.Value    = ""
            loc_oPgDados.txt_4c_Cgru.Value      = ""
            loc_oPgDados.txt_4c_Dgru.Value      = ""
            loc_oPgDados.txt_4c_CSGru.Value     = ""
            loc_oPgDados.txt_4c_DsGru.Value     = ""
            loc_oPgDados.txt_4c_Lin.Value       = ""
            loc_oPgDados.txt_4c_DLin.Value      = ""
            loc_oPgDados.txt_4c_Col.Value       = ""
            loc_oPgDados.txt_4c_DCol.Value      = ""
            loc_oPgDados.txt_4c_Ifor.Value      = 0
            loc_oPgDados.txt_4c_Dfor.Value      = ""
            loc_oPgDados.txt_4c_Refs.Value      = ""
            loc_oPgDados.txt_4c_Cbar.Value      = ""
            loc_oPgDados.txt_4c_EAN13.Value     = ""
            loc_oPgDados.txt_4c_CProEq.Value    = ""
            loc_oPgDados.txt_4c_Merc.Value      = ""
            loc_oPgDados.txt_4c_IdeCPros.Value  = ""
            loc_oPgDados.txt_4c_Qmin.Value      = 0
            loc_oPgDados.txt_4c_QtPed.Value     = 0
            loc_oPgDados.txt_4c_Conjunto.Value  = ""
            loc_oPgDados.txt_4c_DiasGar.Value   = 0
            loc_oPgDados.chk_4c_ChkGarVit.Value = 0
            loc_oPgDados.txt_4c_Obs1.Value      = ""
            loc_oPgDados.txt_4c_Obs2.Value      = ""
            loc_oPgDados.txt_4c_Obs3.Value      = ""
            loc_oPgDados.txt_4c_Cor.Value       = ""
            loc_oPgDados.txt_4c_Tam.Value       = ""
            loc_oPgDados.txt_4c_LtMinsV.Value   = 0
            loc_oPgDados.txt_4c_Peso.Value      = 0
            loc_oPgDados.txt_4c_CodFinP.Value   = ""
            loc_oPgDados.txt_4c_DesFinP.Value   = ""
            loc_oPgDados.txt_4c_Altura.Value    = 0
            loc_oPgDados.txt_4c_Largura.Value   = 0
            loc_oPgDados.txt_4c_Diametro.Value  = 0
            loc_oPgDados.txt_4c_Espessura.Value = 0
            loc_oPgDados.opt_4c_Situacao.Value  = 1
            loc_oPgDados.opt_4c_ProdutoWeb.Value = 1
            loc_oPgDados.opt_4c_Variacao.Value  = 1
            *-- Fase 6
            loc_oPgDados.txt_4c_Compriment.Value   = 0
            loc_oPgDados.txt_4c__codacb.Value       = ""
            loc_oPgDados.txt_4c__Dacb.Value         = ""
            loc_oPgDados.txt_4c_Pmedio.Value        = 0
            loc_oPgDados.txt_4c_Class.Value         = ""
            loc_oPgDados.txt_4c_DClass.Value        = ""
            loc_oPgDados.txt_4c_Local.Value         = ""
            loc_oPgDados.txt_4c_Cuni.Value          = ""
            loc_oPgDados.txt_4c_Duni.Value          = ""
            loc_oPgDados.txt_4c_Cunip.Value         = ""
            loc_oPgDados.txt_4c__dunip.Value        = ""
            loc_oPgDados.txt_4c_DtIncs.Value        = {}
            loc_oPgDados.txt_4c_DataAlts.Value      = {}
            loc_oPgDados.txt_4c_Pvenda.Value        = 0
            loc_oPgDados.txt_4c_Mpvenda.Value       = ""
            loc_oPgDados.txt_4c_Fvenda.Value        = 0
            loc_oPgDados.txt_4c_Mfvenda.Value       = ""
            loc_oPgDados.txt_4c_CodIdent.Value      = ""
            loc_oPgDados.txt_4c_Usuario.Value       = ""
            loc_oPgDados.txt_4c_UsuaAlts.Value      = ""
            loc_oPgDados.txt_4c_TEnts.Value         = 0
            loc_oPgDados.edt_4c_DscCompras.Value    = ""
            loc_oPgDados.chk_4c_Get_Consig.Value    = 0
            loc_oPgDados.chk_4c_ChkFabrProprs.Value = 0
            loc_oPgDados.chk_4c_ChkEncoms.Value     = 0
            loc_oPgDados.txt_4c_Fwget6.Value        = 0
            loc_oPgDados.txt_4c_Fwget5.Value        = 0
            loc_oPgDados.txt_4c_Fwget4.Value        = 0
            loc_oPgDados.txt_4c_Fwget3.Value        = 0
            loc_oPgDados.edt_4c_DPro3s.Value        = ""
            loc_oPgDados.edt_4c_ObsCompras.Value    = ""
            *-- Campos somente-leitura (exibicao)
            loc_oPgDados.txt_4c_DtSituas.Value      = {}
            loc_oPgDados.txt_4c__Dtucp.Value        = {}
            loc_oPgDados.txt_4c_Vucp.Value          = 0
            loc_oPgDados.txt_4c_Mucp.Value          = ""
            loc_oPgDados.txt_4c_Qtdultcomp.Value    = 0
            loc_oPgDados.txt_4c_Estoques.Value      = ""
            loc_oPgDados.txt_4c_QtdEsts.Value       = 0
            loc_oPgDados.txt_4c_Ctotal.Value        = 0
            loc_oPgDados.txt_4c_Mctotal.Value       = ""
        CATCH TO loc_oErro
            MsgErro("Erro ao limpar campos:" + CHR(13) + loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da pgDados (Phase 5)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPgDados
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1

        TRY
            loc_oPgDados.txt_4c_Cpro.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_Dpro.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_DPro2s.Enabled    = par_lHabilitar
            loc_oPgDados.txt_4c_Cgru.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_CSGru.Enabled     = par_lHabilitar
            loc_oPgDados.txt_4c_Lin.Enabled       = par_lHabilitar
            loc_oPgDados.txt_4c_Col.Enabled       = par_lHabilitar
            loc_oPgDados.txt_4c_Ifor.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_Refs.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_Cbar.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_EAN13.Enabled     = par_lHabilitar
            loc_oPgDados.txt_4c_CProEq.Enabled    = par_lHabilitar
            loc_oPgDados.txt_4c_Merc.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_IdeCPros.Enabled  = par_lHabilitar
            loc_oPgDados.txt_4c_Qmin.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_QtPed.Enabled     = par_lHabilitar
            loc_oPgDados.txt_4c_Conjunto.Enabled  = par_lHabilitar
            loc_oPgDados.txt_4c_DiasGar.Enabled   = par_lHabilitar
            loc_oPgDados.chk_4c_ChkGarVit.Enabled = par_lHabilitar
            loc_oPgDados.txt_4c_Obs1.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_Obs2.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_Obs3.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_Cor.Enabled       = par_lHabilitar
            loc_oPgDados.txt_4c_Tam.Enabled       = par_lHabilitar
            loc_oPgDados.txt_4c_LtMinsV.Enabled   = par_lHabilitar
            loc_oPgDados.txt_4c_Peso.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_CodFinP.Enabled   = par_lHabilitar
            loc_oPgDados.txt_4c_Altura.Enabled    = par_lHabilitar
            loc_oPgDados.txt_4c_Largura.Enabled   = par_lHabilitar
            loc_oPgDados.txt_4c_Diametro.Enabled  = par_lHabilitar
            loc_oPgDados.txt_4c_Espessura.Enabled = par_lHabilitar
            loc_oPgDados.opt_4c_Situacao.Enabled  = par_lHabilitar
            loc_oPgDados.cmd_4c_BotFornecedor.Enabled = par_lHabilitar
            loc_oPgDados.cmd_4c_CmdQtMin.Enabled  = par_lHabilitar
            loc_oPgDados.cmd_4c_CmdTamanho.Enabled = par_lHabilitar
            *-- Fase 6
            loc_oPgDados.txt_4c_Compriment.Enabled   = par_lHabilitar
            loc_oPgDados.txt_4c__codacb.Enabled       = par_lHabilitar
            loc_oPgDados.txt_4c_Pmedio.Enabled        = par_lHabilitar
            loc_oPgDados.txt_4c_Class.Enabled         = par_lHabilitar
            loc_oPgDados.txt_4c_Local.Enabled         = par_lHabilitar
            loc_oPgDados.txt_4c_Cuni.Enabled          = par_lHabilitar
            loc_oPgDados.txt_4c_Cunip.Enabled         = par_lHabilitar
            loc_oPgDados.txt_4c_CodIdent.Enabled      = par_lHabilitar
            loc_oPgDados.txt_4c_TEnts.Enabled         = par_lHabilitar
            loc_oPgDados.edt_4c_DscCompras.Enabled    = par_lHabilitar
            loc_oPgDados.chk_4c_Get_Consig.Enabled    = par_lHabilitar
            loc_oPgDados.chk_4c_ChkFabrProprs.Enabled = par_lHabilitar
            loc_oPgDados.chk_4c_ChkEncoms.Enabled     = par_lHabilitar
            loc_oPgDados.txt_4c_Fwget6.Enabled        = par_lHabilitar
            loc_oPgDados.txt_4c_Fwget5.Enabled        = par_lHabilitar
            loc_oPgDados.txt_4c_Fwget4.Enabled        = par_lHabilitar
            loc_oPgDados.txt_4c_Fwget3.Enabled        = par_lHabilitar
            loc_oPgDados.edt_4c_DPro3s.Enabled        = par_lHabilitar
            loc_oPgDados.edt_4c_ObsCompras.Enabled    = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro("Erro ao habilitar campos:" + CHR(13) + loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptAbasChange - Muda aba ativa do pgf_4c_DadosPrd
    *--------------------------------------------------------------------------
    PROCEDURE OptAbasChange()
        THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.ActivePage = ;
            THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva registro (Inserir ou Atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Produto salvo com sucesso!")
            THIS.CarregarLista()
            THIS.AlternarPagina(1)
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao salvar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressCgru - F4/F5 abre lookup de Grupo de Produto
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressCgru(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Lookup de Grupos (SigCdGrp: cgrus / dgrus)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_Busca", "cgrus", loc_cValor, ;
            "Grupos de Produto")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_Busca.cgrus)
                loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_Busca.dgrus)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_Busca.cgrus)
                    loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_Busca.dgrus)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressCSGru - F4/F5 abre lookup de Subgrupo
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressCSGru(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupSubgrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSubgrupo - Lookup de Subgrupos (SigCdPsg filtrado por cgrus)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSubgrupo()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor, loc_cGrupo
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value)
        loc_cGrupo   = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPsg", "cursor_4c_Busca", "codigos", loc_cValor, ;
            "Subgrupos")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_Busca.codigos)
                loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_Busca.descricaos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_Busca.codigos)
                    loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_Busca.descricaos)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressLin - F4/F5 abre lookup de Linha
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressLin(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupLinha()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLinha - Lookup de Linhas (SigCdLin: codigos / descrs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLinha()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Lin.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdLin", "cursor_4c_Busca", "codigos", loc_cValor, ;
            "Linhas de Produto")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_Busca.codigos)
                loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(cursor_4c_Busca.descrs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_Busca.codigos)
                    loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(cursor_4c_Busca.descrs)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressCol - F4/F5 abre lookup de Colecao (Grupo de Venda)
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressCol(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupColecao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupColecao - Lookup de Colecoes (SigCdCol: codigos / descrs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupColecao()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Col.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCol", "cursor_4c_Busca", "codigos", loc_cValor, ;
            "Cole" + CHR(231) + CHR(245) + "es")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Col.Value  = ALLTRIM(cursor_4c_Busca.codigos)
                loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(cursor_4c_Busca.descrs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Col.Value  = ALLTRIM(cursor_4c_Busca.codigos)
                    loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(cursor_4c_Busca.descrs)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressFornecedor - F4/F5 abre lookup de Fornecedor
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressFornecedor(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupFornecedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFornecedorClick - Botao "..." abre lookup de Fornecedor
    *--------------------------------------------------------------------------
    PROCEDURE BtnFornecedorClick()
        THIS.AbrirLookupFornecedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFornecedor - Lookup de Fornecedores (SIGCDCLI: iclis / nomes)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupFornecedor()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = TRANSFORM(loc_oPgDados.txt_4c_Ifor.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SIGCDCLI", "cursor_4c_Busca", "iclis", loc_cValor, ;
            "Fornecedores")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Ifor.Value = cursor_4c_Busca.iclis
                loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_Busca.nomes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("nomes",  "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Ifor.Value = cursor_4c_Busca.iclis
                    loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_Busca.nomes)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnQtMinClick - Abre dialogo de estoque minimo por empresa
    *--------------------------------------------------------------------------
    PROCEDURE BtnQtMinClick()
        MsgInfo("Estoque m" + CHR(237) + "nimo por empresa: funcionalidade na Fase 8.")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTamanhoClick - Abre lookup de Tamanho
    *--------------------------------------------------------------------------
    PROCEDURE BtnTamanhoClick()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Tam.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdTam", "cursor_4c_Busca", "cods", loc_cValor, ;
            "Tamanhos")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Tam.Value = ALLTRIM(cursor_4c_Busca.cods)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Tam.Value = ALLTRIM(cursor_4c_Busca.cods)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressModelo - F4/F5 abre lookup de Modelo (CodFinP)
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressModelo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupModelo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupModelo - Lookup de Modelos (SigCdFin: cods / descs ou similar)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupModelo()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SIGCDFIP", "cursor_4c_Busca", "cods", loc_cValor, ;
            "Modelos")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_Busca.cods)
                loc_oPgDados.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_Busca.descs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_Busca.cods)
                    loc_oPgDados.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_Busca.descs)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressAcabamento - F4/F5 abre lookup de Acabamento
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressAcabamento(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupAcabamento()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupAcabamento - Lookup de Acabamentos (SigCdAca: cods / descrs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupAcabamento()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c__codacb.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdAca", "cursor_4c_Busca", "cods", loc_cValor, ;
            "Acabamentos")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c__codacb.Value = ALLTRIM(cursor_4c_Busca.cods)
                loc_oPgDados.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_Busca.descrs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c__codacb.Value = ALLTRIM(cursor_4c_Busca.cods)
                    loc_oPgDados.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_Busca.descrs)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressClassificacao - F4/F5 abre lookup de Classificacao
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressClassificacao(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupClassificacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupClassificacao - Lookup de Classificacao (SIGCDCLS: cods / descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupClassificacao()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Class.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SIGCDCLS", "cursor_4c_Busca", "cods", loc_cValor, ;
            "Classifica" + CHR(231) + CHR(245) + "es")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Class.Value  = ALLTRIM(cursor_4c_Busca.cods)
                loc_oPgDados.txt_4c_DClass.Value = ALLTRIM(cursor_4c_Busca.descs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Class.Value  = ALLTRIM(cursor_4c_Busca.cods)
                    loc_oPgDados.txt_4c_DClass.Value = ALLTRIM(cursor_4c_Busca.descs)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressUnidade - F4/F5 abre lookup de Unidade (1)
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressUnidade(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupUnidade()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUnidade - Lookup de Unidade (SigCdUni: cunis / dunis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUnidade()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUni", "cursor_4c_Busca", "cunis", loc_cValor, ;
            "Unidades")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_Busca.cunis)
                loc_oPgDados.txt_4c_Duni.Value = ALLTRIM(cursor_4c_Busca.dunis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_Busca.cunis)
                    loc_oPgDados.txt_4c_Duni.Value = ALLTRIM(cursor_4c_Busca.dunis)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressUnidade2 - F4/F5 abre lookup de Unidade (2)
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressUnidade2(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupUnidade2()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUnidade2 - Lookup de Unidade 2 (SigCdUni: cunis / dunis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUnidade2()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUni", "cursor_4c_Busca", "cunis", loc_cValor, ;
            "Unidades (2)")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Cunip.Value  = ALLTRIM(cursor_4c_Busca.cunis)
                loc_oPgDados.txt_4c__dunip.Value = ALLTRIM(cursor_4c_Busca.dunis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Cunip.Value  = ALLTRIM(cursor_4c_Busca.cunis)
                    loc_oPgDados.txt_4c__dunip.Value = ALLTRIM(cursor_4c_Busca.dunis)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressEquivalente - F4/F5 abre lookup de Produto Equivalente
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressEquivalente(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupEquivalente()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEquivalente - Lookup de Produto Equivalente (SigCdPro: cpros/dpros)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEquivalente()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_Busca", "cpros", loc_cValor, ;
            "Produto Equivalente")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_Busca.cpros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_Busca.cpros)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressCor - F4/F5 abre lookup de Cor
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressCor(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupCor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCor - Lookup de Cores (SigCdCor: cods / descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCor()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Cor.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCor", "cursor_4c_Busca", "cods", loc_cValor, ;
            "Cores")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Cor.Value = ALLTRIM(cursor_4c_Busca.cods)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Cor.Value = ALLTRIM(cursor_4c_Busca.cods)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressLocal - F4/F5 abre lookup de Localizacao
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupLocal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLocal - Lookup de Localizacao (SigPrLcl: codigos / descricaos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLocal()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Local.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_Busca", "codigos", loc_cValor, ;
            "Localiza" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Local.Value = ALLTRIM(cursor_4c_Busca.codigos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Local.Value = ALLTRIM(cursor_4c_Busca.codigos)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPressConjunto - F4/F5 abre lookup de Conjunto
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressConjunto(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupConjunto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConjunto - Lookup de Conjuntos (SigCdPro: conjuntos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConjunto()
        LOCAL loc_oBusca, loc_oPgDados, loc_cValor
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
        loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Conjunto.Value)
        loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_Busca", "conjuntos", loc_cValor, ;
            "Conjuntos")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPgDados.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_Busca.conjuntos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("conjuntos", "", "Conjunto")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_oPgDados.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_Busca.conjuntos)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes Salvar/Cancelar
    * conforme modo atual (INCLUIR/ALTERAR/VISUALIZAR)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_cModo
        loc_cModo   = THIS.this_cModoAtual
        loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            DO CASE
            CASE loc_cModo = "VISUALIZAR"
                loc_oBotoes.cmd_4c_Salvar.Enabled    = .F.
                loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Voltar"

            CASE loc_cModo = "INCLUIR" OR loc_cModo = "ALTERAR"
                loc_oBotoes.cmd_4c_Salvar.Enabled    = .T.
                loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
            ENDCASE
        CATCH TO loc_oErro
            MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - Destrutor
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos (SigCdPro)
* Herda de: BusinessBase
* Tabela: SigCdPro | PK: cpros
* Fase: 6/8 - Propriedades completas pgDados
*==============================================================================
DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Propriedades SigPrFtp (legado - mantidas para compatibilidade)
    this_cCods     = ""       && cods     char(2)
    this_nCoefs    = 0        && coefs    numeric(6,4)
    this_cPkchaves = ""       && pkchaves char(20)
    this_nValors   = 0        && valors   numeric(10,2)

    *-- Propriedades SigCdPro (campos principais pgDados)
    this_cCpros    = ""       && cpros    char(14) - PK
    this_cDpros    = ""       && dpros    char(65)
    this_cDpro2s   = ""       && dpro2s   char(45)
    this_cCgrus    = ""       && cgrus    char(3)
    this_cDgrus    = ""       && dgrus (SigCdGrp - nao em SigCdPro)
    this_cCSGrus   = ""       && sgrus    char(6) - subgrupo codigo
    this_cDsGrus   = ""       && subgrupo descricao
    this_cLins     = ""       && linhas   char(10)
    this_cDLins    = ""       && linha descricao
    this_cCols     = ""       && colecoes char(10)
    this_cDCols    = ""       && colecao descricao
    this_nIfor     = 0        && ifors    char(10) -> numerico interno
    this_cDfor     = ""       && fornecedor descricao
    this_cReffs    = ""       && reffs    char(40)
    this_cCbars    = ""       && cbars    numeric(14,0) -> char
    this_cEAN13s   = ""       && ean13    numeric(13,0) -> char
    this_cCProEqs  = ""       && cproeqs  char(14)
    this_cMercs    = ""       && mercs    char(3)
    this_cIdeCPros = ""       && idecpros char(3)
    this_nQmins    = 0        && qmins    numeric(9,3)
    this_nQtPeds   = 0        && qtped    numeric(9,3)
    this_cConjuntos = ""      && conjunts char(6)
    this_nDiasGar  = 0        && diasgar  numeric(4,0)
    this_nChkGarVit = 0       && chkgarvit numeric(1,0)
    this_cObs1s    = ""       && obspeds  char(30)
    this_cObs2s    = ""       && obspes   char(30)
    this_cObs3s    = ""       && obsetqs  char(10)
    this_cCors     = ""       && codcors  char(4)
    this_cTams     = ""       && codtams  char(4)
    this_nLtMinsV  = 0        && ltminsv  numeric(9,3)
    this_nPesoBs   = 0        && pesobs   numeric(7,3)
    this_cCodFinP  = ""       && codfinp  char(3)
    this_cDesFinP  = ""       && modelo descricao
    this_nAltura   = 0        && altura   numeric(7,4)
    this_nLargura  = 0        && largura  numeric(7,4)
    this_nDiametro = 0        && diametro numeric(7,4)
    this_nEspessura = 0       && espessura numeric(7,4)
    this_nSituas   = 1        && situas   numeric(1,0)
    this_nProdWeb  = 1        && prodwebs numeric(1,0)
    this_nVariacao = 1        && prodvars numeric(1,0)
    this_dDtSituas = {}       && dtsituas datetime
    *-- Fase 6 - campos adicionais pgDados
    this_nCompriment = 0      && compriment numeric(7,4)
    this_c_codacb  = ""       && codacbs  char(3)
    this_c_Dacb    = ""       && acabamento descricao
    this_nPmedio   = 0        && pesoms   numeric(8,3) - peso liquido/medio
    this_nEstoques = 0        && estoque (calculado)
    this_nQtdEsts  = 0        && qtd estoque (calculado)
    this_cClass    = ""       && cclass   char(3)
    this_cDClass   = ""       && classificacao descricao
    this_cLocal    = ""       && locals   char(10)
    this_nCtotal   = 0        && custofs  numeric(11,3) - custo total
    this_cMctotal  = ""       && moecusfs char(3) - moeda custo
    this_cCuni     = ""       && cunis    char(3)
    this_cDuni     = ""       && unidade descricao
    this_cCunip    = ""       && cunips   char(3)
    this_c_dunip   = ""       && unidade2 descricao
    this_dDtIncs   = {}       && dtincs   datetime
    this_dDataAlts = {}       && dtalts   datetime
    this_nPvenda   = 0        && pvens    numeric(11,5)
    this_cMpvenda  = ""       && moepvs   char(3)
    this_nFvenda   = 0        && fvendas  numeric(7,3)
    this_cMfvenda  = ""       && moevs    char(3)
    this_cCodIdent = ""       && codident char(20)
    this_cUsuario  = ""       && usuincs  char(10) - usuario inclusao
    this_cUsuaAlts = ""       && usuaalts char(20) - usuario alteracao
    this_nTEnts    = 0        && tents    numeric(3,0)
    this_cDscCompras = ""     && dsccompras text
    this_nConsig   = 0        && consigs  numeric(1,0)
    this_nFabrProprs = 0      && fabrproprs numeric(1,0)
    this_nEncoms   = 0        && encoms   numeric(1,0)
    this_nFwget6   = 0        && tamps    numeric(5,2) - profundidade
    this_nFwget5   = 0        && tamhs    numeric(5,2) - altura embalagem
    this_nFwget4   = 0        && tamls    numeric(5,2) - largura embalagem
    this_nFwget3   = 0        && volumes  numeric(3,0)
    this_cDPro3s   = ""       && dpro3s   text
    this_cObsCompras = ""     && obscompras text

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO configurando tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor ativo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCgrus     = TratarNulo(cgrus,     "C")
            THIS.this_cCods      = TratarNulo(cods,      "C")
            THIS.this_nCoefs     = TratarNulo(coefs,     "N")
            THIS.this_cCpros     = TratarNulo(cpros,     "C")
            THIS.this_cPkchaves  = TratarNulo(pkchaves,  "C")
            THIS.this_nValors    = TratarNulo(valors,    "N")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkchaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigPrFtp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrFtp (cgrus, cods, coefs, cpros, pkchaves, valors)
                VALUES (<<EscaparSQL(THIS.this_cCgrus)>>, <<EscaparSQL(THIS.this_cCods)>>,
                        <<FormatarNumeroSQL(THIS.this_nCoefs)>>, <<EscaparSQL(THIS.this_cCpros)>>,
                        <<EscaparSQL(THIS.this_cPkchaves)>>, <<FormatarNumeroSQL(THIS.this_nValors)>>)
            ENDTEXT
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigPrFtp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrFtp SET
                    cgrus     = <<EscaparSQL(THIS.this_cCgrus)>>,
                    cods      = <<EscaparSQL(THIS.this_cCods)>>,
                    coefs     = <<FormatarNumeroSQL(THIS.this_nCoefs)>>,
                    cpros     = <<EscaparSQL(THIS.this_cCpros)>>,
                    valors    = <<FormatarNumeroSQL(THIS.this_nValors)>>
                WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigPrFtp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrFtp WHERE cpros = " + EscaparSQL(THIS.this_cCpros)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca produtos em SigCdPro com filtro opcional
    * Cria cursor_4c_Dados com: cpros, dpros, dpro2s, cgrus, sgrus, reffs,
    *                           chkInstalas, dtalts, usuaalts, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.

        TRY
            *-- Sem conexao: criar cursor vazio para nao bloquear o grid
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), dpro2s C(45), cgrus C(3), sgrus C(6), reffs C(40), chkInstalas L, dtalts T, usuaalts C(20), situas N(1))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro), par_cFiltro, "1=1")

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SELECT cpros, dpros, dpro2s, cgrus, sgrus, reffs,
                           CONVERT(BIT,0) AS chkInstalas,
                           DataAlts AS dtalts, usuaalts, situas
                    FROM SigCdPro
                    WHERE <<loc_cFiltro>>
                    ORDER BY cpros
                ENDTEXT

                IF USED("cursor_4c_Dados")
                    *-- Grid ja vinculado: ZAP+APPEND para nao destruir colunas
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    SET NULL ON
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    SET NULL OFF
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ProdutoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega produto pelo codigo (cpros)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cpros, dpros, dpro2s, cgrus, sgrus, reffs,
                       CONVERT(BIT,0) AS chkInstalas,
                       dtalts, usuaalts, situas
                FROM SigCdPro
                WHERE cpros = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    SELECT cursor_4c_Carrega
                    THIS.this_cCpros    = TratarNulo(cpros,    "C")
                    THIS.this_cCgrus    = TratarNulo(cgrus,    "C")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Produto n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ProdutoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

