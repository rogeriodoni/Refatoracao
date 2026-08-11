# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-01 04:54:57] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 04:54:57] [INFO] Config FPW: (nao fornecido)
[2026-08-01 04:54:57] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 04:54:57] [INFO] Timeout: 300 segundos
[2026-08-01 04:54:57] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a4bfd2f3.prg
[2026-08-01 04:54:57] [INFO] Conteudo do wrapper:
[2026-08-01 04:54:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDepartamento', 'C:\4c\tasks\task397', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task397', 'CRUD'
QUIT

[2026-08-01 04:54:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a4bfd2f3.prg
[2026-08-01 04:54:57] [INFO] VFP output esperado em: C:\4c\tasks\task397\vfp_output.txt
[2026-08-01 04:54:57] [INFO] Executando Visual FoxPro 9...
[2026-08-01 04:54:57] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a4bfd2f3.prg
[2026-08-01 04:54:57] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a4bfd2f3.prg
[2026-08-01 04:54:57] [INFO] Timeout configurado: 300 segundos
[2026-08-01 04:55:45] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 04:55:45] [INFO] VFP9 finalizado em 47.379511 segundos
[2026-08-01 04:55:45] [INFO] Exit Code: 
[2026-08-01 04:55:45] [INFO] 
[2026-08-01 04:55:45] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 04:55:45] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_a4bfd2f3.prg
[2026-08-01 04:55:45] [INFO] 
[2026-08-01 04:55:45] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 04:55:45] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 04:55:45] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 04:55:45] [INFO] * Parameters: 'FormDepartamento', 'C:\4c\tasks\task397', 'CRUD'
[2026-08-01 04:55:45] [INFO] 
[2026-08-01 04:55:45] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 04:55:45] [INFO] SET SAFETY OFF
[2026-08-01 04:55:45] [INFO] SET RESOURCE OFF
[2026-08-01 04:55:45] [INFO] SET TALK OFF
[2026-08-01 04:55:45] [INFO] SET NOTIFY OFF
[2026-08-01 04:55:45] [INFO] SYS(2335, 0)
[2026-08-01 04:55:45] [INFO] 
[2026-08-01 04:55:45] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task397', 'CRUD'
[2026-08-01 04:55:45] [INFO] QUIT
[2026-08-01 04:55:45] [INFO] 
[2026-08-01 04:55:45] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 04:55:45] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormDepartamento",
  "timestamp": "20260801045544",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": false,
      "erro": "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)",
      "detalhes": ""
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "BtnIncluirClick navegou para Page2 | BtnCancelarClick retornou para Page1"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (DIRETORKEYPRESS, KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg):
*=============================================================================
* FormDepartamento.prg - Formulario: Cadastro de Departamentos
* Migrado de: SIGCDDPT.SCX
* Data      : 2026-08-01
* FASE 8/8  : Consolidacao final - AjustarBotoesPorModo + todos os metodos
*=============================================================================

DEFINE CLASS FormDepartamento AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity: copiar do legado)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Departamentos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Inicializa via FormBase (que chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e configura estrutura do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DepartamentoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar DepartamentoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar Formul" + CHR(225) + "rio:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        THIS.pgf_4c_Paginas.PageCount = 2

        WITH THIS.pgf_4c_Paginas
            .Top     = -29
            .Left    = 0
            .Width   = THIS.Width
            .Height  = THIS.Height + 29
            .Tabs    = .F.
            .Visible = .T.

            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de listagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (Top: 2+29=31 - compensa PageFrame.Top=-29)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

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

        *-- Container botoes CRUD (Top: 0+29=29; Left=542 - lado direito)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container saida (canonico: Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 917
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Top: 88+29=117; Width=890 nao sobrepoe cnt_4c_Saida)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        loc_oGrid.Top         = 117
        loc_oGrid.Left        = 26
        loc_oGrid.Width       = 890
        loc_oGrid.Height      = 498
        loc_oGrid.ColumnCount = 2
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

            .Column1.Width           = 80
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column1.Alignment       = 0

            .Column2.Width           = 290
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Alignment       = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes acao + todos os campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (grupo_salva: Top=-4+29=25; Left=841)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 25
            .Left        = 841
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 7
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

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 82
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

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label + TextBox: Codigo (getcodigos Top=133->162; Left=361/405; W=42/80; MaxLen=10)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 166
            .Left      = 361
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Top           = 162
            .Left          = 405
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Descricao (getDescricaos Top=158->187; Left=348/405; W=55/290; H=23)
        loc_oPagina.AddObject("lbl_4c_Descricaos", "Label")
        WITH loc_oPagina.lbl_4c_Descricaos
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 189
            .Left      = 348
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricaos", "TextBox")
        WITH loc_oPagina.txt_4c_Descricaos
            .Value         = ""
            .Top           = 187
            .Left          = 405
            .Width         = 290
            .Height        = 23
            .MaxLength     = 40
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Diretor (getDiretores Top=183->212; Left=361/405; W=42/80; H=23)
        *-- Lookup: F4 abre FormBuscaAuxiliar em SigCdUsu (Usuarios, NComps)
        loc_oPagina.AddObject("lbl_4c_Diretor", "Label")
        WITH loc_oPagina.lbl_4c_Diretor
            .Caption   = "Diretor :"
            .Top       = 214
            .Left      = 361
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Diretores", "TextBox")
        WITH loc_oPagina.txt_4c_Diretores
            .Value         = ""
            .Top           = 212
            .Left          = 405
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Diretores, "KeyPress", THIS, "DiretorKeyPress")

        *-- Label4 + opt_4c_SubclaEnc (Optiongroup1: nchksubs; Top=210->239; Left=249/400)
        loc_oPagina.AddObject("lbl_4c_SubclaEnc", "Label")
        WITH loc_oPagina.lbl_4c_SubclaEnc
            .Caption   = "Obriga Subclas. Encerramento :"
            .Top       = 239
            .Left      = 249
            .Width     = 154
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_SubclaEnc", "OptionGroup")
        WITH loc_oPagina.opt_4c_SubclaEnc
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 238
            .Left        = 400
            .Width       = 109
            .Height      = 24
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 5
                .Top       = 3
                .Width     = 61
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 61
                .Top       = 3
                .Width     = 61
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Label5 + opt_4c_Tipo (Optiongroup2: nchktipos; Top=232->261; Left=374/400)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Caption   = "Tipo :"
            .Top       = 261
            .Left      = 374
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Tipo
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 257
            .Left        = 400
            .Width       = 109
            .Height      = 24
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 5
                .Top       = 3
                .Width     = 61
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 61
                .Top       = 3
                .Width     = 61
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Label6 + opt_4c_Autos (optAutos: autos; Top=251->280; Left=343/400)
        *-- Convencao invertida: Sim=Option1.Value=0, Nao=Option2.Value=1; default Value=2(Nao)
        loc_oPagina.AddObject("lbl_4c_Autos", "Label")
        WITH loc_oPagina.lbl_4c_Autos
            .Caption   = "Autom" + CHR(225) + "tico:"
            .Top       = 280
            .Left      = 343
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Autos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Autos
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Top         = 276
            .Left        = 400
            .Width       = 109
            .Height      = 24
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 5
                .Top       = 3
                .Width     = 61
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 61
                .Top       = 3
                .Width     = 61
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Label7 + opt_4c_UtiLacto (Optiongroup3: UtiLacto; Top=271->300; Left=241/400)
        *-- Convencao invertida: Sim=Option1.Value=0, Nao=Option2.Value=1; default Value=2(Nao)
        *-- UtiLacto: campo de UI apenas (nao persistido no banco - SigCdDpt nao tem coluna)
        loc_oPagina.AddObject("lbl_4c_UtiLacto", "Label")
        WITH loc_oPagina.lbl_4c_UtiLacto
            .Caption   = "Utiliza nos dados de lan" + CHR(231) + "amento :"
            .Top       = 300
            .Left      = 241
            .Width     = 162
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_UtiLacto", "OptionGroup")
        WITH loc_oPagina.opt_4c_UtiLacto
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Top         = 296
            .Left        = 400
            .Width       = 109
            .Height      = 24
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 5
                .Top       = 3
                .Width     = 61
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 61
                .Top       = 3
                .Width     = 61
                .AutoSize  = .F.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Say44 (lbl_4c_GdeGrupo; Top=292->321; Left=339)
        loc_oPagina.AddObject("lbl_4c_GdeGrupo", "Label")
        WITH loc_oPagina.lbl_4c_GdeGrupo
            .Caption   = "Gde. Grupo :"
            .Top       = 321
            .Left      = 339
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- GradeGG (grd_4c_GruposGG; Top=294->323; Left=405; W=262; H=222)
        *-- Column2.ReadOnly=.T. (descricao populada por lookup - nao editavel)
        loc_oPagina.AddObject("grd_4c_GruposGG", "Grid")
        WITH loc_oPagina.grd_4c_GruposGG
            .ColumnCount   = 2
            .Top           = 323
            .Left          = 405
            .Width         = 262
            .Height        = 222
            .DeleteMark    = .F.
            .GridLines     = 3
            .GridLineColor = RGB(238, 238, 238)
            .HeaderHeight  = 20
            .ScrollBars    = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.

            .Column1.Width    = 65
            .Column1.FontSize = 8
            .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
            .Column1.Header1.FontName = "Tahoma"
            .Column1.Header1.FontSize = 8
            .Column1.Header1.FontBold = .F.

            .Column2.Width    = 165
            .Column2.FontSize = 8
            .Column2.ReadOnly = .T.
            .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName = "Tahoma"
            .Column2.Header1.FontSize = 8
            .Column2.Header1.FontBold = .F.
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_GruposGG, "AfterRowColChange", THIS, "GruposGGAfterRowColChange")

        *-- Command1 / cmd_4c_AdicionarGrupo (Top=356->385; Left=671; W=45; H=45)
        *-- Icone-only: Themes=.T. obrigatorio; nao desabilitar (icone some); guard no click handler
        loc_oPagina.AddObject("cmd_4c_AdicionarGrupo", "CommandButton")
        WITH loc_oPagina.cmd_4c_AdicionarGrupo
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
            .ToolTipText   = "Inserir"
            .Top           = 385
            .Left          = 671
            .Width         = 45
            .Height        = 45
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 128, 0)
            .FontName      = "Arial"
            .FontSize      = 9
            .FontBold      = .T.
            .Themes        = .T.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cmd_4c_AdicionarGrupo, "Click", THIS, "BtnAdicionarGrupoClick")

        *-- Command2 / cmd_4c_RemoverGrupo (Top=400->429; Left=671; W=45; H=45)
        *-- Icone-only: Themes=.T. obrigatorio; nao desabilitar; guard no click handler
        loc_oPagina.AddObject("cmd_4c_RemoverGrupo", "CommandButton")
        WITH loc_oPagina.cmd_4c_RemoverGrupo
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText   = "Excluir"
            .Top           = 429
            .Left          = 671
            .Width         = 45
            .Height        = 45
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(255, 0, 0)
            .FontName      = "Arial"
            .FontSize      = 9
            .FontBold      = .T.
            .Themes        = .T.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cmd_4c_RemoverGrupo, "Click", THIS, "BtnRemoverGrupoClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Executa Buscar no BO e vincula grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"

                    *-- Reconfigurar cabecalhos apos RecordSource (VFP reseta)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro: prepara BO e vai para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_oBusinessObject.CarregarGrupos("")
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um departamento na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.CarregarGrupos(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um departamento na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_oBusinessObject.CarregarGrupos(loc_cCodigo)
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um departamento na lista.", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.ValidarDepartamentoEmUso(loc_cCodigo)
            MsgAviso("Departamento em uso por usu" + CHR(225) + "rios. N" + ;
                CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do departamento '" + ;
            loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Departamento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra lista pelo texto digitado
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oGrid
        loc_cFiltro = InputBox("Informe parte da descri" + CHR(231) + CHR(227) + "o:", ;
            "Buscar Departamento", "")

        IF VARTYPE(loc_cFiltro) != "C"
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)

                IF RECCOUNT("cursor_4c_Dados") = 0
                    MsgAviso("Nenhum departamento encontrado.", "Buscar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida campos e chama FormParaBO + BO.Salvar()
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(loc_cCodigo)
                MsgAviso("C" + CHR(243) + "digo precisa ser informado.", "Validar")
                loc_oPagina.txt_4c_Codigos.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_cDescricao)
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o precisa ser informada.", "Validar")
                loc_oPagina.txt_4c_Descricaos.SetFocus
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Departamento salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados da Page2 para as propriedades do BO
    * OptionGroups adicionados na Fase 6 - verificados com PEMSTATUS
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBo, loc_oPagina
        loc_oBo     = THIS.this_oBusinessObject
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oBo.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        loc_oBo.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
        loc_oBo.this_cDiretor   = ALLTRIM(loc_oPagina.txt_4c_Diretores.Value)

        IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
            loc_oBo.this_nSubclaEncerr = IIF(loc_oPagina.opt_4c_SubclaEnc.Value = 1, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
            loc_oBo.this_nTipo = IIF(loc_oPagina.opt_4c_Tipo.Value = 1, 1, 0)
        ENDIF
        *-- optAutos: Sim=Value1=autos0, Nao=Value2=autos1 (convencao do legado)
        IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
            loc_oBo.this_nAutomatico = IIF(loc_oPagina.opt_4c_Autos.Value = 1, 0, 1)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
            loc_oBo.this_nUtilizaLanc = IIF(loc_oPagina.opt_4c_UtiLacto.Value = 1, 0, 1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO para os campos da Page2
    * OptionGroups/grid adicionados na Fase 6 - verificados com PEMSTATUS
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBo, loc_oPagina
        loc_oBo     = THIS.this_oBusinessObject
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigos.Value    = ALLTRIM(loc_oBo.this_cCodigo)
        loc_oPagina.txt_4c_Descricaos.Value = ALLTRIM(loc_oBo.this_cDescricao)
        loc_oPagina.txt_4c_Diretores.Value  = ALLTRIM(loc_oBo.this_cDiretor)

        IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
            loc_oPagina.opt_4c_SubclaEnc.Value = IIF(loc_oBo.this_nSubclaEncerr = 1, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
            loc_oPagina.opt_4c_Tipo.Value = IIF(loc_oBo.this_nTipo = 1, 1, 2)
        ENDIF
        *-- optAutos: autos=0?Sim(Value1), autos=1?Nao(Value2)
        IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
            loc_oPagina.opt_4c_Autos.Value = IIF(loc_oBo.this_nAutomatico = 0, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
            loc_oPagina.opt_4c_UtiLacto.Value = IIF(loc_oBo.this_nUtilizaLanc = 0, 1, 2)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
            IF USED("cursor_4c_DptGg")
                loc_oPagina.grd_4c_GruposGG.ColumnCount = 2
                loc_oPagina.grd_4c_GruposGG.RecordSource = "cursor_4c_DptGg"
                loc_oPagina.grd_4c_GruposGG.Column1.ControlSource = "cursor_4c_DptGg.CodGrupo"
                loc_oPagina.grd_4c_GruposGG.Column2.ControlSource = "cursor_4c_DptGg.descs"
                loc_oPagina.grd_4c_GruposGG.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oPagina.grd_4c_GruposGG.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                GO TOP IN cursor_4c_DptGg
                loc_oPagina.grd_4c_GruposGG.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lHab
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lHab    = (par_lHabilitar = .T.)

        *-- Codigo: editavel apenas no modo INCLUIR
        loc_oPagina.txt_4c_Codigos.Enabled    = (loc_lHab AND THIS.this_cModoAtual = "INCLUIR")
        loc_oPagina.txt_4c_Descricaos.Enabled = loc_lHab
        loc_oPagina.txt_4c_Diretores.Enabled  = loc_lHab

        IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
            loc_oPagina.opt_4c_SubclaEnc.Enabled = loc_lHab
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
            loc_oPagina.opt_4c_Tipo.Enabled = loc_lHab
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
            loc_oPagina.opt_4c_Autos.Enabled = loc_lHab
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
            loc_oPagina.opt_4c_UtiLacto.Enabled = loc_lHab
        ENDIF
        IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
            loc_oPagina.grd_4c_GruposGG.ReadOnly = !loc_lHab
        ENDIF
        *-- Icones-only: Enabled=.F. faz icone sumir (VFP9 bug); guard no click handler

        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa os valores dos campos da Page2
    * Defaults dos OptionGroups seguem os defaults originais do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigos.Value    = ""
        loc_oPagina.txt_4c_Descricaos.Value = ""
        loc_oPagina.txt_4c_Diretores.Value  = ""

        *-- Optiongroup1 (nchksubs): default Value=1 (Sim) no legado
        IF PEMSTATUS(loc_oPagina, "opt_4c_SubclaEnc", 5)
            loc_oPagina.opt_4c_SubclaEnc.Value = 1
        ENDIF
        *-- Optiongroup2 (nchktipos): default Value=1 (Sim) no legado
        IF PEMSTATUS(loc_oPagina, "opt_4c_Tipo", 5)
            loc_oPagina.opt_4c_Tipo.Value = 1
        ENDIF
        *-- optAutos (autos): default Value=2 (Nao) no legado -> autos=1
        IF PEMSTATUS(loc_oPagina, "opt_4c_Autos", 5)
            loc_oPagina.opt_4c_Autos.Value = 2
        ENDIF
        *-- Optiongroup3 (UtiLacto): default Value=2 (Nao) no legado
        IF PEMSTATUS(loc_oPagina, "opt_4c_UtiLacto", 5)
            loc_oPagina.opt_4c_UtiLacto.Value = 2
        ENDIF

        IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
            IF USED("cursor_4c_DptGg")
                SELECT cursor_4c_DptGg
                ZAP
                APPEND BLANK
                loc_oPagina.grd_4c_GruposGG.ColumnCount = 2
                loc_oPagina.grd_4c_GruposGG.RecordSource          = "cursor_4c_DptGg"
                loc_oPagina.grd_4c_GruposGG.Column1.ControlSource = "cursor_4c_DptGg.CodGrupo"
                loc_oPagina.grd_4c_GruposGG.Column2.ControlSource = "cursor_4c_DptGg.descs"
                loc_oPagina.grd_4c_GruposGG.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oPagina.grd_4c_GruposGG.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oPagina.grd_4c_GruposGG.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DiretorKeyPress - F4 abre lookup de usuarios para campo Diretor
    *--------------------------------------------------------------------------
    PROCEDURE DiretorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDiretor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDiretor - FormBuscaAuxiliar em SigCdUsu (Usuarios, NComps)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaDiretor()
        LOCAL loc_oBusca, loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Diretores.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaDiretor", ;
                "Usuarios", loc_cValor, "Selecionar Diretor")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaDiretor")
                        SELECT cursor_4c_BuscaDiretor
                        loc_oPagina.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "", "Diretor")
                    loc_oBusca.mAddColuna("NComps",   "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDiretor")
                        SELECT cursor_4c_BuscaDiretor
                        loc_oPagina.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de diretores:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaDiretor")
            USE IN cursor_4c_BuscaDiretor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GruposGGAfterRowColChange - Lookup SigCdGpr quando sai da coluna Codigo
    *--------------------------------------------------------------------------
    PROCEDURE GruposGGAfterRowColChange(par_nColIndex)
        IF par_nColIndex = 2
            THIS.ValidarCodigoGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAdicionarGrupoClick - Adiciona linha vazia ao cursor_4c_DptGg
    * Guard de modo: icone-only nao desabilitado (icone some), guard aqui
    *--------------------------------------------------------------------------
    PROCEDURE BtnAdicionarGrupoClick()
        LOCAL loc_oPagina
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF USED("cursor_4c_DptGg")
            SELECT cursor_4c_DptGg
            LOCATE FOR EMPTY(CodGrupo)
            IF !FOUND()
                APPEND BLANK
            ENDIF
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
                loc_oPagina.grd_4c_GruposGG.Refresh()
                loc_oPagina.grd_4c_GruposGG.Column1.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRemoverGrupoClick - Exclui linha corrente do cursor_4c_DptGg
    * Guard de modo: icone-only nao desabilitado (icone some), guard aqui
    *--------------------------------------------------------------------------
    PROCEDURE BtnRemoverGrupoClick()
        LOCAL loc_oPagina
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF USED("cursor_4c_DptGg") AND !EOF("cursor_4c_DptGg") AND !BOF("cursor_4c_DptGg")
            SELECT cursor_4c_DptGg
            DELETE
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPagina, "grd_4c_GruposGG", 5)
                loc_oPagina.grd_4c_GruposGG.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoGrupo - Lookup SigCdGpr para preencher descricao do grupo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodigoGrupo()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_DptGg") OR EOF("cursor_4c_DptGg") OR BOF("cursor_4c_DptGg")
            RETURN
        ENDIF

        SELECT cursor_4c_DptGg
        loc_cCodigo = ALLTRIM(cursor_4c_DptGg.CodGrupo)

        IF EMPTY(loc_cCodigo)
            REPLACE descs WITH "" IN cursor_4c_DptGg
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGrupo", ;
                "Codigos", loc_cCodigo, "Selecionar Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrupo")
                        SELECT cursor_4c_DptGg
                        REPLACE CodGrupo WITH ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                        REPLACE descs    WITH ALLTRIM(cursor_4c_BuscaGrupo.Descs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        SELECT cursor_4c_DptGg
                        REPLACE CodGrupo WITH ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                        REPLACE descs    WITH ALLTRIM(cursor_4c_BuscaGrupo.Descs)
                    ELSE
                        SELECT cursor_4c_DptGg
                        REPLACE CodGrupo WITH ""
                        REPLACE descs    WITH ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GruposGG", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_GruposGG.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita campos e botoes conforme modo
    * INCLUIR/ALTERAR: Confirmar enabled, campos editaveis
    * VISUALIZAR     : Confirmar disabled, campos readonly
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lHabilitado
        loc_lHabilitado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        THIS.HabilitarCampos(loc_lHabilitado)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
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

ENDDEFINE


### BO (C:\4c\projeto\app\classes\DepartamentoBO.prg):
*============================================================================
* DepartamentoBO.prg - Business Object: Cadastro de Departamentos
* Migrado de: SIGCDDPT.SCX
* Tabela principal : SigCdDpt  (chave: codigos)
* Tabela relacionada: sigdptgg (grupos do departamento)
*============================================================================
DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Propriedades: SigCdDpt
    this_cCodigo       = ""   && codigos     C(10) - Chave Primaria
    this_cDescricao    = ""   && descricaos  C(40) - Descricao do departamento
    this_cDiretor      = ""   && diretors    C(10) - FK SigCdUsu.Usuarios
    this_nSubclaEncerr = 0    && nchksubs    N(1)  - Obriga Subclas. Encerramento (1=Sim 2=Nao)
    this_nTipo         = 0    && nchktipos   N(1)  - Tipo do departamento (1=Sim 2=Nao)
    this_nAutomatico   = 0    && autos       N(1)  - Automatico (1=Sim 2=Nao)
    this_nUtilizaLanc  = 0    && UtiLacto - campo exibido no form (nao existe no schema atual)

    *-- Nome do cursor de grupos (sigdptgg)
    this_cCursorGrupos = "cursor_4c_DptGg"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os departamentos (filtro opcional por descricao)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors" + ;
                       " FROM SigCdDpt"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " WHERE UPPER(descricaos) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT registro por chave primaria + grupos
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors," + ;
                       " nchksubs, nchktipos, autos" + ;
                       " FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo       = ALLTRIM(TratarNulo(codigos, "C"))
                THIS.this_cDescricao    = ALLTRIM(TratarNulo(descricaos, "C"))
                THIS.this_cDiretor      = ALLTRIM(TratarNulo(diretors, "C"))
                THIS.this_nSubclaEncerr = TratarNulo(nchksubs, "N")
                THIS.this_nTipo         = TratarNulo(nchktipos, "N")
                THIS.this_nAutomatico   = TratarNulo(autos, "N")
                THIS.this_nUtilizaLanc  = 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdDpt + salvar grupos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdDpt" + ;
                       " (codigos, descricaos, diretors, nchksubs, nchktipos, autos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       EscaparSQL(THIS.this_cDiretor) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSubclaEncerr) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutomatico) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = THIS.SalvarGrupos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Departamento inserido mas erro ao salvar grupos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdDpt + reprocessar grupos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdDpt SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " diretors   = " + EscaparSQL(THIS.this_cDiretor)   + "," + ;
                       " nchksubs   = " + FormatarNumeroSQL(THIS.this_nSubclaEncerr) + "," + ;
                       " nchktipos  = " + FormatarNumeroSQL(THIS.this_nTipo)         + "," + ;
                       " autos      = " + FormatarNumeroSQL(THIS.this_nAutomatico)   + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = THIS.SalvarGrupos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Departamento atualizado mas erro ao salvar grupos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigdptgg + DELETE SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Remove grupos relacionados primeiro
            loc_cSQL = "DELETE FROM sigdptgg WHERE coddepto = " + ;
                       EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelGg")
                TABLEREVERT(.T., "cursor_4c_DelGg")
                USE IN cursor_4c_DelGg
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelGg")
            IF USED("cursor_4c_DelGg")
                USE IN cursor_4c_DelGg
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos do departamento:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remove o registro principal
                loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + ;
                           EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Del")
                    TABLEREVERT(.T., "cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir departamento:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ExecutarExclusao:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega grupos do dpto no cursor_4c_DptGg (para o grid)
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aDepto[1], loc_aGrupo[1], loc_aDescs[1]
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrupos)
                USE IN (THIS.this_cCursorGrupos)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_DptGg (CodDepto C(10), CodGrupo C(3), descs C(40))
            SET NULL OFF

            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.coddepto, a.codgrupo, b.descs" + ;
                           " FROM sigdptgg a" + ;
                           " JOIN SigCdGpr b ON a.codgrupo = b.codigos" + ;
                           " WHERE a.coddepto = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " ORDER BY a.codgrupo"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DptGgTmp")
                    TABLEREVERT(.T., "cursor_4c_DptGgTmp")
                    USE IN cursor_4c_DptGgTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DptGgTmp")
                IF loc_nResultado >= 0
                    loc_nTotal = RECCOUNT("cursor_4c_DptGgTmp")
                    IF loc_nTotal > 0
                        DIMENSION loc_aDepto[loc_nTotal]
                        DIMENSION loc_aGrupo[loc_nTotal]
                        DIMENSION loc_aDescs[loc_nTotal]
                        SELECT cursor_4c_DptGgTmp
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aDepto[loc_nI] = ALLTRIM(cursor_4c_DptGgTmp.coddepto)
                            loc_aGrupo[loc_nI] = ALLTRIM(cursor_4c_DptGgTmp.codgrupo)
                            loc_aDescs[loc_nI]  = ALLTRIM(cursor_4c_DptGgTmp.descs)
                            IF !EOF("cursor_4c_DptGgTmp")
                                SKIP IN cursor_4c_DptGgTmp
                            ENDIF
                        ENDFOR
                        FOR loc_nI = 1 TO loc_nTotal
                            SELECT cursor_4c_DptGg
                            APPEND BLANK
                            REPLACE CodDepto WITH loc_aDepto[loc_nI], ;
                                    CodGrupo WITH loc_aGrupo[loc_nI], ;
                                    descs    WITH loc_aDescs[loc_nI]
                        ENDFOR
                    ENDIF
                    IF USED("cursor_4c_DptGgTmp")
                        USE IN cursor_4c_DptGgTmp
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            *-- Garante linha em branco para o grid poder receber entrada
            IF RECCOUNT("cursor_4c_DptGg") = 0
                SELECT cursor_4c_DptGg
                APPEND BLANK
            ENDIF

            GO TOP IN cursor_4c_DptGg
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarGrupos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Persiste cursor_4c_DptGg em sigdptgg
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SalvarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aGrupos[1]
        loc_lResultado = .F.

        TRY
            *-- Remove todos os grupos existentes para este departamento
            loc_cSQL = "DELETE FROM sigdptgg WHERE coddepto = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelGrp")
                TABLEREVERT(.T., "cursor_4c_DelGrp")
                USE IN cursor_4c_DelGrp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelGrp")
            IF USED("cursor_4c_DelGrp")
                USE IN cursor_4c_DelGrp
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.

                *-- Coleta grupos nao-vazios do cursor numa array
                IF USED(THIS.this_cCursorGrupos)
                    loc_nTotal = RECCOUNT(THIS.this_cCursorGrupos)
                    IF loc_nTotal > 0
                        DIMENSION loc_aGrupos[loc_nTotal]
                        SELECT (THIS.this_cCursorGrupos)
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aGrupos[loc_nI] = ALLTRIM(cursor_4c_DptGg.CodGrupo)
                            IF !EOF("cursor_4c_DptGg")
                                SKIP IN cursor_4c_DptGg
                            ENDIF
                        ENDFOR

                        *-- Insere os grupos via SQL
                        FOR loc_nI = 1 TO loc_nTotal
                            IF !EMPTY(loc_aGrupos[loc_nI])
                                loc_cSQL = "INSERT INTO sigdptgg (pkchave, coddepto, codgrupo)" + ;
                                           " VALUES (" + ;
                                           "LEFT(REPLACE(CONVERT(VARCHAR(36),NEWID()),'-',''),20)," + ;
                                           EscaparSQL(ALLTRIM(par_cCodigo)) + "," + ;
                                           EscaparSQL(LEFT(loc_aGrupos[loc_nI], 3)) + ")"
                                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                                IF USED("cursor_4c_InsGrp")
                                    TABLEREVERT(.T., "cursor_4c_InsGrp")
                                    USE IN cursor_4c_InsGrp
                                ENDIF

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsGrp")
                                IF USED("cursor_4c_InsGrp")
                                    USE IN cursor_4c_InsGrp
                                ENDIF
                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir grupo " + loc_aGrupos[loc_nI] + ;
                                             ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                ENDIF
                            ENDIF
                        ENDFOR
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.SalvarGrupos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGruposDuplicados - Verifica se ha codigos de grupo repetidos
    *--------------------------------------------------------------------------
    FUNCTION ValidarGruposDuplicados()
        LOCAL loc_lValido, loc_nDuplic
        loc_lValido = .T.

        TRY
            IF USED(THIS.this_cCursorGrupos) AND RECCOUNT(THIS.this_cCursorGrupos) > 0
                SELECT CodGrupo FROM cursor_4c_DptGg ;
                       WHERE !EMPTY(CodGrupo) ;
                       GROUP BY CodGrupo ;
                       HAVING COUNT(*) > 1 ;
                       INTO CURSOR cursor_4c_Duplicas

                loc_nDuplic = RECCOUNT("cursor_4c_Duplicas")
                IF USED("cursor_4c_Duplicas")
                    USE IN cursor_4c_Duplicas
                ENDIF

                IF loc_nDuplic > 0
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarGruposDuplicados:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarAutomatico - Verifica se ja existe outro departamento automatico
    * par_cCodIgnorar: codigo do registro atual (para excluir da verificacao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarAutomatico(par_cCodIgnorar)
        LOCAL loc_lValido, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lValido = .T.

        TRY
            IF THIS.this_nAutomatico = 1
                loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDpt WHERE autos = 1"
                IF VARTYPE(par_cCodIgnorar) = "C" AND !EMPTY(par_cCodIgnorar)
                    loc_cSQL = loc_cSQL + ;
                        " AND codigos <> " + EscaparSQL(ALLTRIM(par_cCodIgnorar))
                ENDIF

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_AutoChk")
                    TABLEREVERT(.T., "cursor_4c_AutoChk")
                    USE IN cursor_4c_AutoChk
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AutoChk")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_AutoChk
                    loc_nTotal = cursor_4c_AutoChk.Total
                    IF loc_nTotal > 0
                        loc_lValido = .F.
                    ENDIF
                ELSE
                    MsgErro("Erro ao verificar automatico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_AutoChk")
                    USE IN cursor_4c_AutoChk
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarAutomatico:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDepartamentoEmUso - Verifica se o depto esta vinculado a usuarios
    *--------------------------------------------------------------------------
    FUNCTION ValidarDepartamentoEmUso(par_cCodigo)
        LOCAL loc_lEmUso, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lEmUso = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdUsu" + ;
                       " WHERE deptos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UsoChk")
                TABLEREVERT(.T., "cursor_4c_UsoChk")
                USE IN cursor_4c_UsoChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsoChk")
            IF loc_nResultado >= 0
                SELECT cursor_4c_UsoChk
                loc_nTotal = cursor_4c_UsoChk.Total
                IF loc_nTotal > 0
                    loc_lEmUso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar uso do departamento:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UsoChk")
                USE IN cursor_4c_UsoChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarDepartamentoEmUso:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoExistente - Verifica se o codigo ja existe na tabela
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoExistente(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_CodChk")
                TABLEREVERT(.T., "cursor_4c_CodChk")
                USE IN cursor_4c_CodChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodChk")
            IF loc_nResultado >= 0
                SELECT cursor_4c_CodChk
                loc_nTotal = cursor_4c_CodChk.Total
                IF loc_nTotal > 0
                    loc_lExiste = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar codigo:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_CodChk")
                USE IN cursor_4c_CodChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarCodigoExistente:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

