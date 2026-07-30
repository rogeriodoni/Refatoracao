# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-29 20:17:11] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 20:17:11] [INFO] Config FPW: (nao fornecido)
[2026-07-29 20:17:11] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 20:17:11] [INFO] Timeout: 300 segundos
[2026-07-29 20:17:11] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h50ubv5e.prg
[2026-07-29 20:17:11] [INFO] Conteudo do wrapper:
[2026-07-29 20:17:11] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCol', 'C:\4c\tasks\task379', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
QUIT

[2026-07-29 20:17:11] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h50ubv5e.prg
[2026-07-29 20:17:11] [INFO] VFP output esperado em: C:\4c\tasks\task379\vfp_output.txt
[2026-07-29 20:17:11] [INFO] Executando Visual FoxPro 9...
[2026-07-29 20:17:11] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h50ubv5e.prg
[2026-07-29 20:17:11] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h50ubv5e.prg
[2026-07-29 20:17:11] [INFO] Timeout configurado: 300 segundos
[2026-07-29 20:17:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 20:17:52] [INFO] VFP9 finalizado em 41.5371177 segundos
[2026-07-29 20:17:52] [INFO] Exit Code: 
[2026-07-29 20:17:52] [INFO] 
[2026-07-29 20:17:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 20:17:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h50ubv5e.prg
[2026-07-29 20:17:52] [INFO] 
[2026-07-29 20:17:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 20:17:52] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 20:17:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 20:17:52] [INFO] * Parameters: 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
[2026-07-29 20:17:52] [INFO] 
[2026-07-29 20:17:52] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 20:17:52] [INFO] SET SAFETY OFF
[2026-07-29 20:17:52] [INFO] SET RESOURCE OFF
[2026-07-29 20:17:52] [INFO] SET TALK OFF
[2026-07-29 20:17:52] [INFO] SET NOTIFY OFF
[2026-07-29 20:17:52] [INFO] SYS(2335, 0)
[2026-07-29 20:17:52] [INFO] 
[2026-07-29 20:17:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
[2026-07-29 20:17:52] [INFO] QUIT
[2026-07-29 20:17:52] [INFO] 
[2026-07-29 20:17:52] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 20:17:52] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-29 20:18:40] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 20:18:40] [INFO] Config FPW: (nao fornecido)
[2026-07-29 20:18:40] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 20:18:40] [INFO] Timeout: 300 segundos
[2026-07-29 20:18:40] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_weypkzvu.prg
[2026-07-29 20:18:40] [INFO] Conteudo do wrapper:
[2026-07-29 20:18:40] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCol', 'C:\4c\tasks\task379', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
QUIT

[2026-07-29 20:18:40] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_weypkzvu.prg
[2026-07-29 20:18:40] [INFO] VFP output esperado em: C:\4c\tasks\task379\vfp_output.txt
[2026-07-29 20:18:40] [INFO] Executando Visual FoxPro 9...
[2026-07-29 20:18:40] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_weypkzvu.prg
[2026-07-29 20:18:40] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_weypkzvu.prg
[2026-07-29 20:18:40] [INFO] Timeout configurado: 300 segundos
[2026-07-29 20:19:26] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 20:19:26] [INFO] VFP9 finalizado em 46.5095218 segundos
[2026-07-29 20:19:26] [INFO] Exit Code: 
[2026-07-29 20:19:26] [INFO] 
[2026-07-29 20:19:26] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 20:19:26] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_weypkzvu.prg
[2026-07-29 20:19:26] [INFO] 
[2026-07-29 20:19:26] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 20:19:26] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 20:19:26] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 20:19:26] [INFO] * Parameters: 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
[2026-07-29 20:19:26] [INFO] 
[2026-07-29 20:19:26] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 20:19:26] [INFO] SET SAFETY OFF
[2026-07-29 20:19:26] [INFO] SET RESOURCE OFF
[2026-07-29 20:19:26] [INFO] SET TALK OFF
[2026-07-29 20:19:26] [INFO] SET NOTIFY OFF
[2026-07-29 20:19:26] [INFO] SYS(2335, 0)
[2026-07-29 20:19:26] [INFO] 
[2026-07-29 20:19:26] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
[2026-07-29 20:19:26] [INFO] QUIT
[2026-07-29 20:19:26] [INFO] 
[2026-07-29 20:19:26] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 20:19:26] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-29 20:20:40] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 20:20:40] [INFO] Config FPW: (nao fornecido)
[2026-07-29 20:20:40] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 20:20:40] [INFO] Timeout: 300 segundos
[2026-07-29 20:20:40] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25zs3npm.prg
[2026-07-29 20:20:40] [INFO] Conteudo do wrapper:
[2026-07-29 20:20:40] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCol', 'C:\4c\tasks\task379', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
QUIT

[2026-07-29 20:20:40] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25zs3npm.prg
[2026-07-29 20:20:40] [INFO] VFP output esperado em: C:\4c\tasks\task379\vfp_output.txt
[2026-07-29 20:20:40] [INFO] Executando Visual FoxPro 9...
[2026-07-29 20:20:40] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25zs3npm.prg
[2026-07-29 20:20:40] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25zs3npm.prg
[2026-07-29 20:20:40] [INFO] Timeout configurado: 300 segundos
[2026-07-29 20:21:26] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 20:21:26] [INFO] VFP9 finalizado em 46.6760819 segundos
[2026-07-29 20:21:26] [INFO] Exit Code: 
[2026-07-29 20:21:26] [INFO] 
[2026-07-29 20:21:26] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 20:21:26] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25zs3npm.prg
[2026-07-29 20:21:26] [INFO] 
[2026-07-29 20:21:26] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 20:21:26] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 20:21:26] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 20:21:26] [INFO] * Parameters: 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
[2026-07-29 20:21:26] [INFO] 
[2026-07-29 20:21:26] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 20:21:26] [INFO] SET SAFETY OFF
[2026-07-29 20:21:26] [INFO] SET RESOURCE OFF
[2026-07-29 20:21:26] [INFO] SET TALK OFF
[2026-07-29 20:21:26] [INFO] SET NOTIFY OFF
[2026-07-29 20:21:26] [INFO] SYS(2335, 0)
[2026-07-29 20:21:26] [INFO] 
[2026-07-29 20:21:26] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCol', 'C:\4c\tasks\task379', 'CRUD'
[2026-07-29 20:21:26] [INFO] QUIT
[2026-07-29 20:21:26] [INFO] 
[2026-07-29 20:21:26] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 20:21:26] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCol",
  "timestamp": "20260729202126",
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCol.prg):
*------------------------------------------------------------------------------
* FormCol.prg - Formulario de Cadastro de Grupo de Venda
* Tabela: SigCdCol | Herda de: FormBase
* Fase 7/8 - Eventos principais CRUD - COMPLETO
*------------------------------------------------------------------------------

DEFINE CLASS FormCol AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Grupo de Venda"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ColBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar ColBO", "FormCol.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormCol:" + CHR(13) + loc_oErro.Message, "FormCol.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o PageFrame principal com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            THIS.pgf_4c_Paginas.Top       = -29
            THIS.pgf_4c_Paginas.Left      = 0
            THIS.pgf_4c_Paginas.Width     = 1000
            THIS.pgf_4c_Paginas.Height    = 629
            THIS.pgf_4c_Paginas.PageCount = 2
            THIS.pgf_4c_Paginas.Tabs      = .F.
            THIS.pgf_4c_Paginas.Visible   = .T.

            WITH THIS.pgf_4c_Paginas
                .Page1.Caption  = "Lista"
                .Page1.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page2.Caption  = "Dados"
                .Page2.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar PageFrame:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (lista de registros)
    * Cabecalho, botoes CRUD, grid e saida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Cabecalho cinza (cntSombra legado: Top=1, Left=-1, Width=1008, Height=80)
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 30
                .Left        = 0
                .Width       = 1000
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = "Cadastro de Grupo de Venda"
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Caption   = "Cadastro de Grupo de Venda"
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Container botoes CRUD (Grupo_op legado: Left=543, Top=-1, Width=385, Height=85)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 28
                .Left        =  542
                .Width       = 385
                .Height      = 85
                .BackColor   = RGB(53, 53, 53)
                .BackStyle   = 1
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
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
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
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
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
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
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
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
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *-- Container saida - PADRAO CANONICO (prevalece sobre PILAR 1)
            *-- Legado: Grupo_Saida.Left=918, Top=-1; Canonico: Left=917, Width=90
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
                    .Top             = 5
                    .Left            = 917
                    .Width           = 90
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *-- Grid de listagem (colecoes=79, descs=290, codcols=75 - do legado Init)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oPagina.grd_4c_Lista.Top              = 117
            loc_oPagina.grd_4c_Lista.Left             = 26
            loc_oPagina.grd_4c_Lista.Width            = 890
            loc_oPagina.grd_4c_Lista.Height           = 498
            loc_oPagina.grd_4c_Lista.ColumnCount      = 3
            WITH loc_oPagina.grd_4c_Lista
                .FontName             = "Verdana"
                .FontSize             = 8
                .ForeColor            = RGB(90, 90, 90)
                .BackColor            = RGB(255, 255, 255)
                .GridLineColor        = RGB(238, 238, 238)
                .GridLines            = 3
                .HighlightBackColor   = RGB(255, 255, 255)
                .HighlightForeColor   = RGB(15, 41, 104)
                .HighlightStyle       = 2
                .DeleteMark           = .F.
                .RecordMark           = .F.
                .RowHeight            = 16
                .ScrollBars           = 2
                .Visible              = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page Lista:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (campos de edicao)
    * Fase 3: container salvar/cancelar
    * Fase 5: campos principais (getColecoes, getDescs, getUsuars, getDtInicial)
    * Fase 6: OptionGroups (optConProds, optAltProds), getAgrupa - COMPLETO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container salvar/cancelar (Grupo_Salva legado: Left=820, Top=8, Width=160)
            loc_oPagina.AddObject("cnt_4c_Salva", "Container")
            WITH loc_oPagina.cnt_4c_Salva
                .Top         = 37
                .Left        = 820
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Confirmar", "CommandButton")
                WITH .cmd_4c_Confirmar
                    .Caption         = "Confirmar"
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
                    .Caption         = "Encerrar"
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
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
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            *-- Label "Grupo :" (Say1: Top=127, Left=324, compensacao +29 = 156)
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "Grupo :"
                .Top       = 156
                .Left      = 324
                .Width     = 38
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Colecoes (getColecoes: Top=123, Left=366, Width=79, compensacao +29 = 152)
            *-- Editavel apenas em INCLUIR (getColecoes.When = INSERIR no legado)
            loc_oPagina.AddObject("txt_4c_Colecoes", "TextBox")
            WITH loc_oPagina.txt_4c_Colecoes
                .Top           = 152
                .Left          = 366
                .Width         = 79
                .Height        = 25
                .InputMask     = "XXXXXXXXXX"
                .MaxLength     = 10
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label "Descricao :" (Say2: Top=155, Left=307, compensacao +29 = 184)
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 184
                .Left      = 307
                .Width     = 55
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Descricao (getDescs: Top=151, Left=366, Width=289, compensacao +29 = 180)
            loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPagina.txt_4c_Descricao
                .Top           = 180
                .Left          = 366
                .Width         = 289
                .Height        = 25
                .InputMask     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
                .MaxLength     = 40
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label "Usuario :" (Say7: Top=183, Left=317, compensacao +29 = 212)
            loc_oPagina.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPagina.lbl_4c_Label7
                .Caption   = "Usu" + CHR(225) + "rio :"
                .Top       = 212
                .Left      = 317
                .Width     = 45
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Usuars (getUsuars: Top=179, Left=366, Width=80, compensacao +29 = 208)
            *-- Lookup para SigCdUsu via ValidarUsuars (equivalente ao Valid/fwBuscaExt do legado)
            loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
            WITH loc_oPagina.txt_4c_Usuars
                .Top           = 208
                .Left          = 366
                .Width         = 80
                .Height        = 25
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label "Data de Inicio :" (Say8: Top=211, Left=287, compensacao +29 = 240)
            loc_oPagina.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPagina.lbl_4c_Label8
                .Caption   = "Data de In" + CHR(237) + "cio :"
                .Top       = 240
                .Left      = 287
                .Width     = 75
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox DtInicial (getDtInicial: Top=207, Left=366, compensacao +29 = 236)
            *-- Tipo datetime; auto-setado pelo BO no INSERT
            loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
            WITH loc_oPagina.txt_4c_DtInicial
                .Top           = 236
                .Left          = 366
                .Width         = 100
                .Height        = 25
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "D"
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- Label "Consulta de Produtos :" (Say5: Top=238, Left=250, compensacao +29 = 267)
            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Caption   = "Consulta de Produtos :"
                .Top       = 267
                .Left      = 250
                .Width     = 112
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup optConProds (Top=235, Left=362, Width=95, Height=25, comp +29 = 264)
            *-- S (Sim=1) / N (Nao=0) -> mapeado em this_nConprods; Value=1->S, Value=2->N
            loc_oPagina.AddObject("opt_4c_ConProds", "OptionGroup")
            WITH loc_oPagina.opt_4c_ConProds
                .ButtonCount = 2
                .Top         = 264
                .Left        = 362
                .Width       = 95
                .Height      = 25
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption   = "S"
                    .Left      = 5
                    .Top       = 5
                    .Width     = 40
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N"
                    .Left      = 48
                    .Top       = 5
                    .Width     = 40
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            *-- Label "Alertar ao Alterar Produtos :" (Say6: Top=260, Left=223, comp +29 = 289)
            loc_oPagina.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPagina.lbl_4c_Label6
                .Caption   = "Alertar ao Alterar Produtos :"
                .Top       = 289
                .Left      = 223
                .Width     = 139
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup optAltProds (Top=255, Left=362, Width=95, Height=25, comp +29 = 284)
            *-- S (Sim=1) / N (Nao=0) -> mapeado em this_nAltProds; Value=1->S, Value=2->N
            loc_oPagina.AddObject("opt_4c_AltProds", "OptionGroup")
            WITH loc_oPagina.opt_4c_AltProds
                .ButtonCount = 2
                .Top         = 284
                .Left        = 362
                .Width       = 95
                .Height      = 25
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption   = "S"
                    .Left      = 5
                    .Top       = 5
                    .Width     = 40
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N"
                    .Left      = 48
                    .Top       = 5
                    .Width     = 40
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            *-- Label "Agrupamento :" (Say9: Top=285, Left=288, comp +29 = 314)
            loc_oPagina.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPagina.lbl_4c_Label9
                .Caption   = "Agrupamento :"
                .Top       = 314
                .Left      = 288
                .Width     = 74
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Agrupa (getAgrupa: Top=281, Left=367, Width=79, comp +29 = 310)
            *-- Mapeado em this_cAgrupas (agrupas char(10))
            loc_oPagina.AddObject("txt_4c_Agrupa", "TextBox")
            WITH loc_oPagina.txt_4c_Agrupa
                .Top           = 310
                .Left          = 367
                .Width         = 79
                .Height        = 25
                .MaxLength     = 10
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "ValidarUsuars")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page Dados:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (colecoes C(10), descs C(40), codcols C(1))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF THIS.this_oBusinessObject.Buscar("")
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount = 3
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.colecoes"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codcols"

                        loc_oGrid.Column1.Width = 79
                        loc_oGrid.Column2.Width = 290
                        loc_oGrid.Column3.Width = 75

                        *-- Reconfigurar cabecalhos APOS RecordSource (VFP reseta captions)
                        loc_oGrid.Column1.Header1.Caption = "Grupo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Cod. Coletor"

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormCol.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormCol.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lResultado = .F.
            ELSE
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2

                THIS.this_oBusinessObject.this_cColecoes = ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value)
                THIS.this_oBusinessObject.this_cDescs    = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
                THIS.this_oBusinessObject.this_cUsuars   = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)

                IF VARTYPE(loc_oPg2.txt_4c_DtInicial.Value) = "T" OR ;
                   VARTYPE(loc_oPg2.txt_4c_DtInicial.Value) = "D"
                    THIS.this_oBusinessObject.this_tDtIncs = loc_oPg2.txt_4c_DtInicial.Value
                ENDIF

                THIS.this_oBusinessObject.this_nConprods = IIF(loc_oPg2.opt_4c_ConProds.Value = 1, 1, 0)
                THIS.this_oBusinessObject.this_nAltProds = IIF(loc_oPg2.opt_4c_AltProds.Value = 1, 1, 0)
                THIS.this_oBusinessObject.this_cAgrupas  = ALLTRIM(loc_oPg2.txt_4c_Agrupa.Value)

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "FormCol.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos do Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lResultado = .F.
            ELSE
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2

                loc_oPg2.txt_4c_Colecoes.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cColecoes)
                loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
                loc_oPg2.txt_4c_Usuars.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)

                IF !EMPTY(THIS.this_oBusinessObject.this_tDtIncs)
                    loc_oPg2.txt_4c_DtInicial.Value = THIS.this_oBusinessObject.this_tDtIncs
                ELSE
                    loc_oPg2.txt_4c_DtInicial.Value = {}
                ENDIF

                loc_oPg2.opt_4c_ConProds.Value = IIF(THIS.this_oBusinessObject.this_nConprods = 1, 1, 2)
                loc_oPg2.opt_4c_AltProds.Value = IIF(THIS.this_oBusinessObject.this_nAltProds = 1, 1, 2)
                loc_oPg2.txt_4c_Agrupa.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cAgrupas)

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "FormCol.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
                loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF

            *-- Colecoes: editavel apenas em INCLUIR (getColecoes.When = INSERIR no legado)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Colecoes", 5)
                loc_oPg2.txt_4c_Colecoes.ReadOnly = ;
                    !par_lHabilitar OR THIS.this_cModoAtual = "ALTERAR"
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.ReadOnly = !par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Usuars", 5)
                loc_oPg2.txt_4c_Usuars.ReadOnly = !par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_DtInicial", 5)
                loc_oPg2.txt_4c_DtInicial.ReadOnly = !par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "opt_4c_ConProds", 5)
                loc_oPg2.opt_4c_ConProds.Enabled = par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "opt_4c_AltProds", 5)
                loc_oPg2.opt_4c_AltProds.Enabled = par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Agrupa", 5)
                loc_oPg2.txt_4c_Agrupa.ReadOnly = !par_lHabilitar
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "FormCol.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.NovoRegistro()
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Colecoes", 5)
                loc_oPg2.txt_4c_Colecoes.Value  = ""
                loc_oPg2.txt_4c_Descricao.Value = ""
                loc_oPg2.txt_4c_Usuars.Value    = ""
                loc_oPg2.txt_4c_DtInicial.Value = {}
            ENDIF

            IF PEMSTATUS(loc_oPg2, "opt_4c_ConProds", 5)
                loc_oPg2.opt_4c_ConProds.Value = 2
                loc_oPg2.opt_4c_AltProds.Value = 2
                loc_oPg2.txt_4c_Agrupa.Value   = ""
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "FormCol.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
                    INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "FormCol.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Eventos dos botoes CRUD da Page1
    *--------------------------------------------------------------------------

    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_nResultado, loc_lPodeExcluir
        loc_cCodigo      = ""
        loc_lPodeExcluir = .T.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.")
            RETURN
        ENDIF

        *-- Verificar se existem Produtos usando este Grupo (legado: ChkRegister SigCdPro/Colecoes)
        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT COUNT(*) AS Contador FROM SigCdPro WHERE Colecoes = " + ;
            EscaparSQL(loc_cCodigo), "cursor_4c_ChkPro")
        IF loc_nResultado > 0 AND USED("cursor_4c_ChkPro")
            SELECT cursor_4c_ChkPro
            IF cursor_4c_ChkPro.Contador > 0
                MsgAviso("Existem Produtos Utilizando Esse Grupo de Venda.", ;
                    "Imposs" + CHR(237) + "vel Exclus" + CHR(227) + "o")
                loc_lPodeExcluir = .F.
            ENDIF
            USE IN cursor_4c_ChkPro
        ENDIF

        IF !loc_lPodeExcluir
            RETURN
        ENDIF

        IF MsgConfirma("Deseja excluir este Grupo de Venda?", "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Grupo de Venda exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaCol", "colecoes", "", ;
                "Buscar Grupo de Venda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("colecoes", "", "Grupo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("codcols", "", "Cod. Coletor")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
                    SELECT cursor_4c_BuscaCol
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCol.colecoes)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF

            IF !EMPTY(loc_cCodigo)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "FormCol.BtnBuscarClick")
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Evento do botao Confirmar (Salvar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Grupo de Venda salvo com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "FormCol.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
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

    *--------------------------------------------------------------------------
    * ValidarUsuars - Valida e busca usuario em SigCdUsu
    * Equivalente ao Valid do getUsuars no legado (fwBuscaExt -> FormBuscaAuxiliar)
    * Disparado via BINDEVENT LostFocus em txt_4c_Usuars
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cUsuars, loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cUsuars = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)

        IF EMPTY(loc_cUsuars)
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cUsuars, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .F., "Not cAtivos='N'")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Usuario encontrado exatamente
                    IF USED("cursor_4c_BuscaUsu")
                        SELECT cursor_4c_BuscaUsu
                        loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    *-- Nao encontrado exatamente, mostrar grid de selecao
                    loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        SELECT cursor_4c_BuscaUsu
                        loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    ELSE
                        loc_oPg2.txt_4c_Usuars.Value = ""
                    ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF

            *-- Auto-setar DtInicial se Usuars foi definido e DtInicial esta vazio (legado: Valid getUsuars)
            loc_cUsuars = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
            IF !EMPTY(loc_cUsuars) AND EMPTY(loc_oPg2.txt_4c_DtInicial.Value)
                loc_oPg2.txt_4c_DtInicial.Value = DATE()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
            MostrarErro("Erro ao validar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "FormCol.ValidarUsuars")
        ENDTRY

        RETURN loc_lResultado
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
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            *-- Erros no Destroy sao ignorados para nao bloquear fechamento
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ColBO.prg):
*------------------------------------------------------------------------------
* ColBO.prg - Business Object para Cadastro de Grupo de Venda
* Tabela: SigCdCol | PK: colecoes
* Herda de: BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS ColBO AS BusinessBase

    *-- Propriedades mapeadas da tabela SigCdCol (schema.sql)
    *-- colecoes char(10) NOT NULL (PK)
    this_cColecoes  = ""
    *-- descs char(40) NOT NULL
    this_cDescs     = ""
    *-- codcols char(1) NOT NULL
    this_cCodcols   = ""
    *-- repoauts numeric(1,0) NOT NULL
    this_nRepoauts  = 0
    *-- conprods numeric(1,0) NOT NULL
    this_nConprods  = 0
    *-- altprods numeric(1,0) NOT NULL
    this_nAltProds  = 0
    *-- dtincs datetime NULL
    this_tDtIncs    = {}
    *-- usuars char(10) NOT NULL
    this_cUsuars    = ""
    *-- agrupas char(10) NOT NULL
    this_cAgrupas   = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCol"
            THIS.this_cCampoChave = "colecoes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ColBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cColecoes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cColecoes  = TratarNulo(colecoes, "C")
                THIS.this_cDescs     = TratarNulo(descs,    "C")
                THIS.this_cCodcols   = TratarNulo(codcols,  "C")
                THIS.this_nRepoauts  = TratarNulo(repoauts, "N")
                THIS.this_nConprods  = TratarNulo(conprods, "N")
                THIS.this_nAltProds  = TratarNulo(altprods, "N")
                THIS.this_tDtIncs    = TratarNulo(dtincs,   "T")
                THIS.this_cUsuars    = TratarNulo(usuars,   "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ColBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cColecoes)
            MsgAviso("Grupo de Venda Inv" + CHR(225) + "lido.")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Definir usuario e data/hora de inclusao automaticamente
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_tDtIncs = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCol (colecoes, descs, codcols, repoauts, conprods, altprods, dtincs, usuars, agrupas)
                VALUES (
                    <<EscaparSQL(THIS.this_cColecoes)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<EscaparSQL(THIS.this_cCodcols)>>,
                    <<FormatarNumeroSQL(THIS.this_nRepoauts, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nConprods, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltProds, 0)>>,
                    GETDATE(),
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cAgrupas)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ColBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCol
                SET descs    = <<EscaparSQL(THIS.this_cDescs)>>,
                    codcols  = <<EscaparSQL(THIS.this_cCodcols)>>,
                    repoauts = <<FormatarNumeroSQL(THIS.this_nRepoauts, 0)>>,
                    conprods = <<FormatarNumeroSQL(THIS.this_nConprods, 0)>>,
                    altprods = <<FormatarNumeroSQL(THIS.this_nAltProds, 0)>>,
                    agrupas  = <<EscaparSQL(THIS.this_cAgrupas)>>
                WHERE colecoes = <<EscaparSQL(THIS.this_cColecoes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ColBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCol
    * Verifica dependencia em SigCdPro antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se produtos utilizam este grupo de venda
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPro WHERE Colecoes = " + ;
                EscaparSQL(THIS.this_cColecoes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkPro")
                SELECT cursor_4c_ChkPro
                loc_nUso = cursor_4c_ChkPro.qtd
                USE IN cursor_4c_ChkPro
                IF loc_nUso > 0
                    MsgAviso("Existem Produtos Utilizando Esse Grupo de Venda.")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCol WHERE colecoes = " + ;
                        EscaparSQL(THIS.this_cColecoes)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ELSE
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ColBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colecoes, descs, codcols
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (colecoes C(10), descs C(40), codcols C(1))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT colecoes, descs, codcols FROM SigCdCol"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY colecoes"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ColBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT colecoes, descs, codcols, repoauts, conprods, altprods," + ;
                " dtincs, usuars, agrupas" + ;
                " FROM SigCdCol WHERE colecoes = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de Venda n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ColBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoColetor - Verifica se codcols ja existe em outro registro
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoColetor(par_cCodcols)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF !EMPTY(par_cCodcols)
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCol" + ;
                    " WHERE codcols = " + EscaparSQL(par_cCodcols) + ;
                    " AND colecoes <> " + EscaparSQL(THIS.this_cColecoes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                    USE IN cursor_4c_ChkCod
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo coletor:" + CHR(13) + loException.Message, "ColBO.VerificarCodigoColetor")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarColecaoExistente - Verifica se colecoes ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarColecaoExistente(par_cColecoes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCol" + ;
                " WHERE colecoes = " + EscaparSQL(par_cColecoes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCol")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCol")
                SELECT cursor_4c_ChkCol
                loc_lExiste = (cursor_4c_ChkCol.qtd > 0)
                USE IN cursor_4c_ChkCol
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "ColBO.VerificarColecaoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE

