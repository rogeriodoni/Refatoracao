# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-18 08:54:27] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 08:54:27] [INFO] Config FPW: (nao fornecido)
[2026-07-18 08:54:27] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 08:54:27] [INFO] Timeout: 300 segundos
[2026-07-18 08:54:27] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xlw3hpen.prg
[2026-07-18 08:54:27] [INFO] Conteudo do wrapper:
[2026-07-18 08:54:27] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprpre', 'C:\4c\tasks\task322', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprpre', 'C:\4c\tasks\task322', 'CRUD'
QUIT

[2026-07-18 08:54:27] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xlw3hpen.prg
[2026-07-18 08:54:27] [INFO] VFP output esperado em: C:\4c\tasks\task322\vfp_output.txt
[2026-07-18 08:54:27] [INFO] Executando Visual FoxPro 9...
[2026-07-18 08:54:27] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xlw3hpen.prg
[2026-07-18 08:54:27] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xlw3hpen.prg
[2026-07-18 08:54:27] [INFO] Timeout configurado: 300 segundos
[2026-07-18 08:54:54] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 08:54:54] [INFO] VFP9 finalizado em 27.2423977 segundos
[2026-07-18 08:54:54] [INFO] Exit Code: 
[2026-07-18 08:54:54] [INFO] 
[2026-07-18 08:54:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 08:54:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xlw3hpen.prg
[2026-07-18 08:54:54] [INFO] 
[2026-07-18 08:54:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 08:54:54] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 08:54:54] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 08:54:54] [INFO] * Parameters: 'Formsigprpre', 'C:\4c\tasks\task322', 'CRUD'
[2026-07-18 08:54:54] [INFO] 
[2026-07-18 08:54:54] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 08:54:54] [INFO] SET SAFETY OFF
[2026-07-18 08:54:54] [INFO] SET RESOURCE OFF
[2026-07-18 08:54:54] [INFO] SET TALK OFF
[2026-07-18 08:54:54] [INFO] SET NOTIFY OFF
[2026-07-18 08:54:54] [INFO] SYS(2335, 0)
[2026-07-18 08:54:54] [INFO] 
[2026-07-18 08:54:54] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprpre', 'C:\4c\tasks\task322', 'CRUD'
[2026-07-18 08:54:54] [INFO] QUIT
[2026-07-18 08:54:54] [INFO] 
[2026-07-18 08:54:54] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 08:54:54] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-18 08:57:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 08:57:46] [INFO] Config FPW: (nao fornecido)
[2026-07-18 08:57:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 08:57:46] [INFO] Timeout: 300 segundos
[2026-07-18 08:57:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kldlyre.prg
[2026-07-18 08:57:46] [INFO] Conteudo do wrapper:
[2026-07-18 08:57:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprpre', 'C:\4c\tasks\task322', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprpre', 'C:\4c\tasks\task322', 'CRUD'
QUIT

[2026-07-18 08:57:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kldlyre.prg
[2026-07-18 08:57:46] [INFO] VFP output esperado em: C:\4c\tasks\task322\vfp_output.txt
[2026-07-18 08:57:46] [INFO] Executando Visual FoxPro 9...
[2026-07-18 08:57:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kldlyre.prg
[2026-07-18 08:57:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kldlyre.prg
[2026-07-18 08:57:46] [INFO] Timeout configurado: 300 segundos
[2026-07-18 08:58:17] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 08:58:17] [INFO] VFP9 finalizado em 31.3988242 segundos
[2026-07-18 08:58:17] [INFO] Exit Code: 
[2026-07-18 08:58:17] [INFO] 
[2026-07-18 08:58:17] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 08:58:17] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kldlyre.prg
[2026-07-18 08:58:17] [INFO] 
[2026-07-18 08:58:17] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 08:58:17] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 08:58:17] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 08:58:17] [INFO] * Parameters: 'Formsigprpre', 'C:\4c\tasks\task322', 'CRUD'
[2026-07-18 08:58:17] [INFO] 
[2026-07-18 08:58:17] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 08:58:17] [INFO] SET SAFETY OFF
[2026-07-18 08:58:17] [INFO] SET RESOURCE OFF
[2026-07-18 08:58:17] [INFO] SET TALK OFF
[2026-07-18 08:58:17] [INFO] SET NOTIFY OFF
[2026-07-18 08:58:17] [INFO] SYS(2335, 0)
[2026-07-18 08:58:17] [INFO] 
[2026-07-18 08:58:17] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprpre', 'C:\4c\tasks\task322', 'CRUD'
[2026-07-18 08:58:17] [INFO] QUIT
[2026-07-18 08:58:17] [INFO] 
[2026-07-18 08:58:17] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 08:58:17] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprpre",
  "timestamp": "20260718085817",
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
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 3 (CPROSKEYPRESS, KEYPRESS, MOEVSKEYPRESS)"
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
    "passou": 8,
    "falhou": 1,
    "percentual": 89
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprpre.prg):
*==============================================================================
* Formsigprpre.prg
* Formulario: Cadastro de Alteracao de Precos
* Tipo: CRUD (frmcadastro)
* Herda de: FormBase
* Fase 7/8 - Eventos principais: BtnIncluirClick, BtnAlterarClick, BtnVisualizarClick, BtnExcluirClick
*==============================================================================

DEFINE CLASS Formsigprpre AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Alteracao de Precos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigprpre.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
            THIS.BackColor = RGB(100, 100, 100)

            THIS.this_oBusinessObject = CREATEOBJECT("sigprpreBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigprpreBO", "InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            WITH .Page1
                .Caption   = "Lista"
            ENDWITH

            WITH .Page2
                .Caption   = "Dados"
                .BackColor = RGB(100, 100, 100)
            ENDWITH
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Pagina 1: Grid e botoes CRUD completos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra) - Top compensado: 2+29=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCnt = loc_oPagina.cnt_4c_Cabecalho
        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
        ENDWITH

        *-- Container Botoes CRUD (Grupo_Op) - Top compensado: 0+29=29
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCnt = loc_oPagina.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida (canonico: Left=917, Width=90) - transparente
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
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container Filtro Periodo (CntPeriodo) - Top compensado: 90+29=119
        loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Periodo
            .Top         = 119
            .Left        = 701
            .Width       = 266
            .Height      = 27
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCnt = loc_oPagina.cnt_4c_Periodo

        loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oCnt.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 6
            .Left      = 15
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Dt_inicial", "TextBox")
        WITH loc_oCnt.txt_4c_Dt_inicial
            .Top      = 2
            .Left     = 65
            .Width    = 80
            .Height   = 23
            .Format   = "D"
            .Value    = DATE()
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")

        loc_oCnt.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oCnt.lbl_4c_Sep
            .Caption   = "-"
            .Top       = 6
            .Left      = 151
            .Width     = 10
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Dt_final", "TextBox")
        WITH loc_oCnt.txt_4c_Dt_final
            .Top      = 2
            .Left     = 165
            .Width    = 80
            .Height   = 23
            .Format   = "D"
            .Value    = DATE()
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Dt_final, "KeyPress", THIS, "ValidarDataFinal")

        *-- Container Filtro Produto/Grupo (cntProd) - Top compensado: 89+29=118
        loc_oPagina.AddObject("cnt_4c_Prod", "Container")
        WITH loc_oPagina.cnt_4c_Prod
            .Top         = 118
            .Left        = 16
            .Width       = 641
            .Height      = 27
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCnt = loc_oPagina.cnt_4c_Prod

        loc_oCnt.AddObject("lbl_4c_GrupoProd", "Label")
        WITH loc_oCnt.lbl_4c_GrupoProd
            .Caption   = "Grupo/Produto : "
            .Top       = 7
            .Left      = 38
            .Width     = 83
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Top      = 3
            .Left     = 123
            .Width    = 69
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")

        loc_oCnt.AddObject("txt_4c_Prod", "TextBox")
        WITH loc_oCnt.txt_4c_Prod
            .Top      = 3
            .Left     = 197
            .Width    = 115
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Prod, "KeyPress", THIS, "ValidarProduto")

        loc_oCnt.AddObject("txt_4c_DProd", "TextBox")
        WITH loc_oCnt.txt_4c_DProd
            .Top      = 3
            .Left     = 317
            .Width    = 317
            .Height   = 23
            .Value    = ""
            .Enabled  = .F.
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Grid de Lista (Grade) - Top compensado: 126+29=155
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top                = 155
        loc_oGrid.Left               = 29
        loc_oGrid.Width              = 940
        loc_oGrid.Height             = 459
        loc_oGrid.ColumnCount        = 8
        loc_oGrid.FontName           = "Verdana"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(90, 90, 90)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.GridLines          = 3
        loc_oGrid.ReadOnly           = .T.
        WITH loc_oGrid
            .Column1.Width = 80
            .Column2.Width = 200
            .Column3.Width = 90
            .Column4.Width = 100
            .Column5.Width = 60
            .Column6.Width = 100
            .Column7.Width = 100
            .Column8.Width = 120
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Pagina 2: Botoes + primeiros 50% dos campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar - Top compensado: 4+29=33
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
        loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao

        loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Confirmar
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cancelar
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- [CAMPO 1/5 - Fase 5] Codigo do Produto (CPros) + Descricao (DPros readonly)
        loc_oPagina.AddObject("lbl_4c_CPros", "Label")
        WITH loc_oPagina.lbl_4c_CPros
            .Caption   = "Produto :"
            .Top       = 133
            .Left      = 30
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CPros", "TextBox")
        WITH loc_oPagina.txt_4c_CPros
            .Top           = 129
            .Left          = 135
            .Width         = 100
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CPros, "KeyPress", THIS, "ValidarCPros")

        loc_oPagina.AddObject("txt_4c_DPros", "TextBox")
        WITH loc_oPagina.txt_4c_DPros
            .Top           = 129
            .Left          = 240
            .Width         = 400
            .Height        = 23
            .Value         = ""
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        *-- [CAMPO 2/5 - Fase 5] Data
        loc_oPagina.AddObject("lbl_4c_Datas", "Label")
        WITH loc_oPagina.lbl_4c_Datas
            .Caption   = "Data :"
            .Top       = 163
            .Left      = 30
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPagina.txt_4c_Datas
            .Top           = 159
            .Left          = 135
            .Width         = 80
            .Height        = 23
            .Format        = "D"
            .Value         = DATE()
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        *-- [CAMPO 3/5 - Fase 5] Moeda Atual (Moevs) + Moeda Anterior (MoevsAnt readonly)
        loc_oPagina.AddObject("lbl_4c_Moevs", "Label")
        WITH loc_oPagina.lbl_4c_Moevs
            .Caption   = "Moeda :"
            .Top       = 193
            .Left      = 30
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Moevs", "TextBox")
        WITH loc_oPagina.txt_4c_Moevs
            .Top           = 189
            .Left          = 135
            .Width         = 60
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Moevs, "KeyPress", THIS, "ValidarMoeda")

        loc_oPagina.AddObject("lbl_4c_MoevsAnt", "Label")
        WITH loc_oPagina.lbl_4c_MoevsAnt
            .Caption   = "Moeda Ant. :"
            .Top       = 193
            .Left      = 220
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
        ENDWITH

        loc_oPagina.AddObject("txt_4c_MoevsAnt", "TextBox")
        WITH loc_oPagina.txt_4c_MoevsAnt
            .Top           = 189
            .Left          = 325
            .Width         = 60
            .Height        = 23
            .Value         = ""
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        *-- BINDEVENT F4 e DblClick para campos com lookup na Page2
        BINDEVENT(loc_oPagina.txt_4c_CPros, "KeyPress", THIS, "CProsKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CPros, "DblClick", THIS, "CProsDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Moevs, "KeyPress", THIS, "MoevsKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Moevs, "DblClick", THIS, "MoevsDblClick")

        *-- [CAMPO 4/6 - Fase 6] Preco Atual (PVens) + Preco Anterior (PVensAnt readonly)
        loc_oPagina.AddObject("lbl_4c_PVens", "Label")
        WITH loc_oPagina.lbl_4c_PVens
            .Caption   = "Pre" + CHR(231) + "o Atual :"
            .Top       = 223
            .Left      = 30
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PVens", "TextBox")
        WITH loc_oPagina.txt_4c_PVens
            .Top           = 219
            .Left          = 135
            .Width         = 100
            .Height        = 23
            .Value         = 0
            .InputMask     = "9,999,999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_PVensAnt", "Label")
        WITH loc_oPagina.lbl_4c_PVensAnt
            .Caption   = "Pre" + CHR(231) + "o Ant. :"
            .Top       = 223
            .Left      = 250
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PVensAnt", "TextBox")
        WITH loc_oPagina.txt_4c_PVensAnt
            .Top           = 219
            .Left          = 355
            .Width         = 100
            .Height        = 23
            .Value         = 0
            .InputMask     = "9,999,999.99"
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        *-- [CAMPO 5/6 - Fase 6] Usuario (Usuals - readonly, preenchido automaticamente)
        loc_oPagina.AddObject("lbl_4c_Usuals", "Label")
        WITH loc_oPagina.lbl_4c_Usuals
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 253
            .Left      = 30
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Usuals", "TextBox")
        WITH loc_oPagina.txt_4c_Usuals
            .Top           = 249
            .Left          = 135
            .Width         = 150
            .Height        = 23
            .Value         = ""
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        *-- [CAMPO 6/6 - Fase 6] CheckBox Atualizar Site (CKAtuSite)
        loc_oPagina.AddObject("chk_4c_CKAtuSite", "CheckBox")
        WITH loc_oPagina.chk_4c_CKAtuSite
            .Caption   = "Atualizar Site"
            .Top       = 283
            .Left      = 135
            .Width     = 120
            .Height    = 23
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid com filtros de periodo/produto/grupo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oPagina, loc_oGrid, loc_oCntPeriodo, loc_oCntProd
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oGrid   = loc_oPagina.grd_4c_Lista

            *-- Transferir filtros de periodo para o BO
            IF PEMSTATUS(loc_oPagina, "cnt_4c_Periodo", 5)
                loc_oCntPeriodo = loc_oPagina.cnt_4c_Periodo
                THIS.this_oBusinessObject.this_dDataInicio = loc_oCntPeriodo.txt_4c_Dt_inicial.Value
                THIS.this_oBusinessObject.this_dDataFim    = loc_oCntPeriodo.txt_4c_Dt_final.Value
            ELSE
                THIS.this_oBusinessObject.this_dDataInicio = DATE()
                THIS.this_oBusinessObject.this_dDataFim    = DATE()
            ENDIF

            *-- Transferir filtros de produto/grupo para o BO
            IF PEMSTATUS(loc_oPagina, "cnt_4c_Prod", 5)
                loc_oCntProd = loc_oPagina.cnt_4c_Prod
                THIS.this_oBusinessObject.this_cFiltroCPro = ALLTRIM(loc_oCntProd.txt_4c_Prod.Value)
                THIS.this_oBusinessObject.this_cFiltroGru  = ALLTRIM(loc_oCntProd.txt_4c_Grupo.Value)
            ELSE
                THIS.this_oBusinessObject.this_cFiltroCPro = ""
                THIS.this_oBusinessObject.this_cFiltroGru  = ""
            ENDIF

            IF THIS.this_oBusinessObject.Buscar("")
                *-- Vincular grid ao cursor
                loc_oGrid.ColumnCount = 8
                loc_oGrid.RecordSource          = "cursor_4c_Lista"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.cpros"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.dpros"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.cgrus"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.datas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.moevs"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.pvensant"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Lista.pvens"
                loc_oGrid.Column8.ControlSource = "cursor_4c_Lista.usuals"

                *-- Reconfigurar cabecalhos APOS RecordSource (obrigatorio)
                loc_oGrid.Column1.Header1.Caption = "Produto"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Grupo"
                loc_oGrid.Column4.Header1.Caption = "Data"
                loc_oGrid.Column5.Header1.Caption = "Moeda"
                loc_oGrid.Column6.Header1.Caption = "Pre" + CHR(231) + "o Ant."
                loc_oGrid.Column7.Header1.Caption = "Pre" + CHR(231) + "o Atual"
                loc_oGrid.Column8.Header1.Caption = "Usu" + CHR(225) + "rio"

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("Parametro invalido em AlternarPagina: " + TRANSFORM(par_nPagina), "Erro")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
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
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves
        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF
        SELECT cursor_4c_Lista
        loc_cCidChaves = ALLTRIM(cursor_4c_Lista.cidchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves
        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF
        SELECT cursor_4c_Lista
        loc_cCidChaves = ALLTRIM(cursor_4c_Lista.cidchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves, loc_lConfirma
        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF
        SELECT cursor_4c_Lista
        loc_cCidChaves = ALLTRIM(cursor_4c_Lista.cidchaves)
        loc_lConfirma  = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Atualiza lista com filtros atuais
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
    * BtnSalvarClick - Salvar registro (Page2)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lValido
        loc_lValido = THIS.ValidarCampos()
        IF loc_lValido
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataInicial - Valida data inicial e recarrega lista (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDataInicial
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oCntPeriodo
        TRY
            loc_oCntPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
            IF loc_oCntPeriodo.txt_4c_Dt_inicial.Value > loc_oCntPeriodo.txt_4c_Dt_final.Value
                loc_oCntPeriodo.txt_4c_Dt_final.Value = loc_oCntPeriodo.txt_4c_Dt_inicial.Value
            ENDIF
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDataInicial")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataFinal - Valida data final e recarrega lista (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDataFinal
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oCntPeriodo
        TRY
            loc_oCntPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
            IF loc_oCntPeriodo.txt_4c_Dt_final.Value < loc_oCntPeriodo.txt_4c_Dt_inicial.Value
                loc_oCntPeriodo.txt_4c_Dt_inicial.Value = loc_oCntPeriodo.txt_4c_Dt_final.Value
            ENDIF
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDataFinal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Lookup de grupo de produtos (LostFocus em txt_4c_Grupo)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cGrupo, loc_oBusca, loc_oCntProd
        TRY
            loc_oCntProd = THIS.pgf_4c_Paginas.Page1.cnt_4c_Prod
            loc_cGrupo   = ALLTRIM(loc_oCntProd.txt_4c_Grupo.Value)

            IF EMPTY(loc_cGrupo)
                THIS.CarregarLista()
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cGrupo, ;
                    "Grupos")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Mercs", "", "Gde. Grupo")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_oCntProd.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
                        loc_oCntProd.txt_4c_Grupo.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProduto - Lookup de produto (LostFocus em txt_4c_Prod)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarProduto
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cProd, loc_oBusca, loc_oCntProd
        TRY
            loc_oCntProd = THIS.pgf_4c_Paginas.Page1.cnt_4c_Prod
            loc_cProd    = ALLTRIM(loc_oCntProd.txt_4c_Prod.Value)

            IF EMPTY(loc_cProd)
                loc_oCntProd.txt_4c_DProd.Value = ""
                THIS.CarregarLista()
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cProd, ;
                    "Sele" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        SELECT cursor_4c_BuscaPro
                        loc_oCntProd.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                        loc_oCntProd.txt_4c_DProd.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
                        loc_oCntProd.txt_4c_Prod.Value  = ""
                        loc_oCntProd.txt_4c_DProd.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaPro")
                    USE IN cursor_4c_BuscaPro
                ENDIF
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarProduto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCPros - Lookup de produto no campo CPros da Page2 (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCPros
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cProd, loc_oBusca, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cProd   = ALLTRIM(loc_oPagina.txt_4c_CPros.Value)

            IF EMPTY(loc_cProd)
                IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
                    loc_oPagina.txt_4c_DPros.Value = ""
                ENDIF
                THIS.this_oBusinessObject.this_cDPros = ""
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BuscaPro2", "CPros", loc_cProd, ;
                    "Sele" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro2")
                        SELECT cursor_4c_BuscaPro2
                        loc_oPagina.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaPro2.CPros)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
                            loc_oPagina.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaPro2.DPros)
                        ENDIF
                        THIS.this_oBusinessObject.this_cDPros = ALLTRIM(cursor_4c_BuscaPro2.DPros)
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
                        loc_oPagina.txt_4c_CPros.Value = ""
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
                            loc_oPagina.txt_4c_DPros.Value = ""
                        ENDIF
                        THIS.this_oBusinessObject.this_cDPros = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaPro2")
                    USE IN cursor_4c_BuscaPro2
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCPros")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeda - Lookup de moeda no campo Moevs da Page2 (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoeda
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cMoeda, loc_oBusca, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cMoeda  = ALLTRIM(loc_oPagina.txt_4c_Moevs.Value)

            IF !EMPTY(loc_cMoeda)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaMoe", "moevs", loc_cMoeda, ;
                    "Moeda")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("moevs", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        SELECT cursor_4c_BuscaMoe
                        loc_oPagina.txt_4c_Moevs.Value = ALLTRIM(cursor_4c_BuscaMoe.moevs)
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
                        loc_oPagina.txt_4c_Moevs.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
            THIS.this_oBusinessObject.this_cCPros    = ALLTRIM(loc_oPagina.txt_4c_CPros.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
            THIS.this_oBusinessObject.this_dDatas    = loc_oPagina.txt_4c_Datas.Value
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
            THIS.this_oBusinessObject.this_cMoevs    = ALLTRIM(loc_oPagina.txt_4c_Moevs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_MoevsAnt", 5)
            THIS.this_oBusinessObject.this_cMoevsAnt = ALLTRIM(loc_oPagina.txt_4c_MoevsAnt.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PVens", 5)
            THIS.this_oBusinessObject.this_nPVens    = loc_oPagina.txt_4c_PVens.Value
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PVensAnt", 5)
            THIS.this_oBusinessObject.this_nPVensAnt = loc_oPagina.txt_4c_PVensAnt.Value
        ENDIF
        THIS.this_oBusinessObject.this_cUsuals = ALLTRIM(gc_4c_UsuarioLogado)
        IF PEMSTATUS(loc_oPagina, "chk_4c_CKAtuSite", 5)
            THIS.this_oBusinessObject.this_nCKAtuSite = IIF(loc_oPagina.chk_4c_CKAtuSite.Value, 1, 0)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
            loc_oPagina.txt_4c_CPros.Value    = THIS.this_oBusinessObject.this_cCPros
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
            loc_oPagina.txt_4c_DPros.Value    = THIS.this_oBusinessObject.this_cDPros
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
            loc_oPagina.txt_4c_Datas.Value    = THIS.this_oBusinessObject.this_dDatas
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
            loc_oPagina.txt_4c_Moevs.Value    = THIS.this_oBusinessObject.this_cMoevs
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_MoevsAnt", 5)
            loc_oPagina.txt_4c_MoevsAnt.Value = THIS.this_oBusinessObject.this_cMoevsAnt
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PVens", 5)
            loc_oPagina.txt_4c_PVens.Value    = THIS.this_oBusinessObject.this_nPVens
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PVensAnt", 5)
            loc_oPagina.txt_4c_PVensAnt.Value = THIS.this_oBusinessObject.this_nPVensAnt
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuals", 5)
            loc_oPagina.txt_4c_Usuals.Value   = THIS.this_oBusinessObject.this_cUsuals
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_CKAtuSite", 5)
            loc_oPagina.chk_4c_CKAtuSite.Value = IIF(THIS.this_oBusinessObject.this_nCKAtuSite = 1, 1, 0)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
            loc_oPagina.txt_4c_CPros.Enabled    = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
            loc_oPagina.txt_4c_Datas.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
            loc_oPagina.txt_4c_Moevs.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_MoevsAnt", 5)
            loc_oPagina.txt_4c_MoevsAnt.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PVens", 5)
            loc_oPagina.txt_4c_PVens.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PVensAnt", 5)
            loc_oPagina.txt_4c_PVensAnt.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_CKAtuSite", 5)
            loc_oPagina.chk_4c_CKAtuSite.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
            loc_oPagina.txt_4c_DPros.Enabled  = .F.
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuals", 5)
            loc_oPagina.txt_4c_Usuals.Enabled = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
            loc_oPagina.txt_4c_CPros.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
            loc_oPagina.txt_4c_DPros.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
            loc_oPagina.txt_4c_Datas.Value    = DATE()
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
            loc_oPagina.txt_4c_Moevs.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_MoevsAnt", 5)
            loc_oPagina.txt_4c_MoevsAnt.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PVens", 5)
            loc_oPagina.txt_4c_PVens.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_PVensAnt", 5)
            loc_oPagina.txt_4c_PVensAnt.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuals", 5)
            loc_oPagina.txt_4c_Usuals.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_CKAtuSite", 5)
            loc_oPagina.chk_4c_CKAtuSite.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_oPagina, loc_lValido
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lValido = .T.

        IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_CPros.Value))
                MsgAviso("Informe o c" + CHR(243) + "digo do produto.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_CPros.SetFocus()
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Moevs.Value))
                MsgAviso("Informe a moeda.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Moevs.SetFocus()
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
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
    * CProsKeyPress - Handler KeyPress para campo CPros na Page2 (F4 abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE CProsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.ValidarCPros()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CProsDblClick - Handler DblClick para campo CPros na Page2
    *--------------------------------------------------------------------------
    PROCEDURE CProsDblClick()
        THIS.ValidarCPros()
    ENDPROC

    *--------------------------------------------------------------------------
    * MoevsKeyPress - Handler KeyPress para campo Moevs na Page2 (F4 abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE MoevsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.ValidarMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoevsDblClick - Handler DblClick para campo Moevs na Page2
    *--------------------------------------------------------------------------
    PROCEDURE MoevsDblClick()
        THIS.ValidarMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_oCnt, loc_lEmEdicao
        TRY
            loc_lEmEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
            loc_oPagina   = THIS.pgf_4c_Paginas.Page1

            IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
                loc_oCnt = loc_oPagina.cnt_4c_Botoes
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
                    loc_oCnt.cmd_4c_Incluir.Enabled    = !loc_lEmEdicao
                ENDIF
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
                    loc_oCnt.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
                ENDIF
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
                    loc_oCnt.cmd_4c_Alterar.Enabled    = !loc_lEmEdicao
                ENDIF
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
                    loc_oCnt.cmd_4c_Excluir.Enabled    = !loc_lEmEdicao
                ENDIF
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
                    loc_oCnt.cmd_4c_Buscar.Enabled     = !loc_lEmEdicao
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPagina, "cnt_4c_Saida", 5)
                IF PEMSTATUS(loc_oPagina.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
                    loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEmEdicao
                ENDIF
            ENDIF

            IF THIS.pgf_4c_Paginas.PageCount >= 2
                loc_oPagina = THIS.pgf_4c_Paginas.Page2
                IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
                    loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
                    IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
                        loc_oCnt.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
                        loc_oCnt.cmd_4c_Cancelar.Enabled = loc_lEmEdicao
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprpreBO.prg):
*=============================================================================
* sigprpreBO.prg - Business Object para Alteracao de Precos
* Herda de: BusinessBase
* Tabela: sigprpre (PK: cidchaves)
* Campos: cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant,
*         usuals, ckatusite
* JOIN display: dpros, cgrus (de SigCdPro)
*=============================================================================

DEFINE CLASS sigprpreBO AS BusinessBase

    *-- Campos da tabela sigprpre
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCPros      = ""   && cpros char(14) NOT NULL - Codigo do produto
    this_dDatas      = {}   && datas datetime NULL - Data da alteracao
    this_cMoevs      = ""   && moevs char(3) NOT NULL - Moeda atual
    this_cMoevsAnt   = ""   && moevsant char(3) NOT NULL - Moeda anterior
    this_nPVens      = 0    && pvens numeric(11,5) NOT NULL - Preco de venda atual
    this_nPVensAnt   = 0    && pvensant numeric(11,5) NOT NULL - Preco de venda anterior
    this_cUsuals     = ""   && usuals nvarchar(20) NULL - Usuario
    this_nCKAtuSite  = 0    && ckatusite numeric(1,0) NOT NULL - Flag atualizacao site

    *-- Campos auxiliares de exibicao (JOIN com SigCdPro)
    this_cDPros      = ""   && dpros - Descricao do produto
    this_cCGrus      = ""   && cgrus - Codigo do grupo do produto

    *-- Filtros de consulta (usados em Buscar)
    this_dDataInicio = {}   && Data de inicio do periodo
    this_dDataFim    = {}   && Data de fim do periodo
    this_cFiltroCPro = ""   && Filtro por codigo de produto
    this_cFiltroGru  = ""   && Filtro por codigo de grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprpre"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCPros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cMoevs      = TratarNulo(moevs,      "C")
            THIS.this_cMoevsAnt   = TratarNulo(moevsant,   "C")
            THIS.this_nPVens      = TratarNulo(pvens,      "N")
            THIS.this_nPVensAnt   = TratarNulo(pvensant,   "N")
            THIS.this_cUsuals     = TratarNulo(usuals,     "C")
            THIS.this_nCKAtuSite  = TratarNulo(ckatusite,  "N")
            IF TYPE("dpros") != "U"
                THIS.this_cDPros  = TratarNulo(dpros,      "C")
            ENDIF
            IF TYPE("cgrus") != "U"
                THIS.this_cCGrus  = TratarNulo(cgrus,      "C")
            ENDIF
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtros de periodo, produto e grupo
    * Cursor resultante: crSigPrPre (nome legado preservado para binding do grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFim
        LOCAL loc_cProdF, loc_cGruF, loc_oErro
        loc_lResultado = .F.
        TRY
            *-- Calcular limites para filtros "entre" (padrao do legado)
            IF EMPTY(THIS.this_cFiltroCPro)
                loc_cProdF = "zzzzzzzzzzzzzz"
            ELSE
                loc_cProdF = ALLTRIM(THIS.this_cFiltroCPro)
            ENDIF
            IF EMPTY(THIS.this_cFiltroGru)
                loc_cGruF = "zzz"
            ELSE
                loc_cGruF = ALLTRIM(THIS.this_cFiltroGru)
            ENDIF

            *-- Formatar datas
            IF EMPTY(THIS.this_dDataInicio)
                loc_cDataIni = FormatarDataSQL(DATE())
            ELSE
                loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicio)
            ENDIF
            IF EMPTY(THIS.this_dDataFim)
                loc_cDataFim = "'" + LEFT(DTOS(DATE()), 4) + "-" + SUBSTR(DTOS(DATE()),5,2) + "-" + RIGHT(DTOS(DATE()),2) + " 23:59:59'"
            ELSE
                loc_cDataFim = "'" + LEFT(DTOS(THIS.this_dDataFim), 4) + "-" + SUBSTR(DTOS(THIS.this_dDataFim),5,2) + "-" + RIGHT(DTOS(THIS.this_dDataFim),2) + " 23:59:59'"
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " AND a.cpros BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroCPro)) + ;
                       " AND " + EscaparSQL(loc_cProdF) + ;
                       " AND b.cgrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroGru)) + ;
                       " AND " + EscaparSQL(loc_cGruF) + ;
                       " ORDER BY a.datas DESC, a.cpros"

            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista") > 0
                IF USED("cursor_4c_Lista")
                    SELECT cursor_4c_Lista
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar altera" + CHR(231) + CHR(245) + "es de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar registro."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cChaveNova
        loc_lResultado = .F.
        TRY
            *-- Gerar chave unica para cidchaves (char 20)
            IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChaveNova = LEFT(ALLTRIM(nid), 20)
                USE IN cursor_4c_NewId
            ELSE
                loc_cChaveNova = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
            ENDIF
            THIS.this_cCidChaves = loc_cChaveNova

            loc_cSQL = "INSERT INTO sigprpre" + ;
                       " (cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant, usuals, ckatusite)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCPros)     + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs)     + ", " + ;
                       EscaparSQL(THIS.this_cMoevsAnt)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVens)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVensAnt) + ", " + ;
                       EscaparSQL(THIS.this_cUsuals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCKAtuSite) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprpre SET" + ;
                       " cpros    = " + EscaparSQL(THIS.this_cCPros)          + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " moevs    = " + EscaparSQL(THIS.this_cMoevs)          + ", " + ;
                       " moevsant = " + EscaparSQL(THIS.this_cMoevsAnt)       + ", " + ;
                       " pvens    = " + FormatarNumeroSQL(THIS.this_nPVens)   + ", " + ;
                       " pvensant = " + FormatarNumeroSQL(THIS.this_nPVensAnt)+ ", " + ;
                       " usuals   = " + EscaparSQL(THIS.this_cUsuals)         + ", " + ;
                       " ckatusite= " + FormatarNumeroSQL(THIS.this_nCKAtuSite) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprpre WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

