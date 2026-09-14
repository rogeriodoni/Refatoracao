# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[17/07/2026 01:44:24 PM] Erro: Function requires row or table buffering mode.
[17/07/2026 01:44:24 PM] Erro: Function requires row or table buffering mode.
[17/07/2026 01:44:24 PM] Erro: Function requires row or table buffering mode.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-17 13:42:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-17 13:42:25] [INFO] Config FPW: (nao fornecido)
[2026-07-17 13:42:25] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 13:42:25] [INFO] Timeout: 300 segundos
[2026-07-17 13:42:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3v32fj12.prg
[2026-07-17 13:42:25] [INFO] Conteudo do wrapper:
[2026-07-17 13:42:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRINT', 'C:\4c\tasks\task306', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRINT', 'C:\4c\tasks\task306', 'CRUD'
QUIT

[2026-07-17 13:42:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3v32fj12.prg
[2026-07-17 13:42:25] [INFO] VFP output esperado em: C:\4c\tasks\task306\vfp_output.txt
[2026-07-17 13:42:25] [INFO] Executando Visual FoxPro 9...
[2026-07-17 13:42:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3v32fj12.prg
[2026-07-17 13:42:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3v32fj12.prg
[2026-07-17 13:42:25] [INFO] Timeout configurado: 300 segundos
[2026-07-17 13:42:49] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-17 13:42:49] [INFO] VFP9 finalizado em 24.0571793 segundos
[2026-07-17 13:42:49] [INFO] Exit Code: 
[2026-07-17 13:42:49] [INFO] 
[2026-07-17 13:42:49] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-17 13:42:49] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3v32fj12.prg
[2026-07-17 13:42:49] [INFO] 
[2026-07-17 13:42:49] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-17 13:42:49] [INFO] * Auto-generated wrapper for parameters
[2026-07-17 13:42:49] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 13:42:49] [INFO] * Parameters: 'FormSIGPRINT', 'C:\4c\tasks\task306', 'CRUD'
[2026-07-17 13:42:49] [INFO] 
[2026-07-17 13:42:49] [INFO] * Anti-dialog protections for unattended execution
[2026-07-17 13:42:49] [INFO] SET SAFETY OFF
[2026-07-17 13:42:49] [INFO] SET RESOURCE OFF
[2026-07-17 13:42:49] [INFO] SET TALK OFF
[2026-07-17 13:42:49] [INFO] SET NOTIFY OFF
[2026-07-17 13:42:49] [INFO] SYS(2335, 0)
[2026-07-17 13:42:49] [INFO] 
[2026-07-17 13:42:49] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRINT', 'C:\4c\tasks\task306', 'CRUD'
[2026-07-17 13:42:49] [INFO] QUIT
[2026-07-17 13:42:49] [INFO] 
[2026-07-17 13:42:49] [INFO] === Fim do Wrapper.prg ===
[2026-07-17 13:42:49] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-17 13:43:57] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-17 13:43:57] [INFO] Config FPW: (nao fornecido)
[2026-07-17 13:43:57] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 13:43:57] [INFO] Timeout: 300 segundos
[2026-07-17 13:43:57] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hhdpyujw.prg
[2026-07-17 13:43:57] [INFO] Conteudo do wrapper:
[2026-07-17 13:43:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRINT', 'C:\4c\tasks\task306', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRINT', 'C:\4c\tasks\task306', 'CRUD'
QUIT

[2026-07-17 13:43:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hhdpyujw.prg
[2026-07-17 13:43:57] [INFO] VFP output esperado em: C:\4c\tasks\task306\vfp_output.txt
[2026-07-17 13:43:57] [INFO] Executando Visual FoxPro 9...
[2026-07-17 13:43:57] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hhdpyujw.prg
[2026-07-17 13:43:57] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hhdpyujw.prg
[2026-07-17 13:43:57] [INFO] Timeout configurado: 300 segundos
[2026-07-17 13:44:24] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-17 13:44:24] [INFO] VFP9 finalizado em 27.4066801 segundos
[2026-07-17 13:44:24] [INFO] Exit Code: 
[2026-07-17 13:44:24] [INFO] 
[2026-07-17 13:44:24] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-17 13:44:24] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hhdpyujw.prg
[2026-07-17 13:44:24] [INFO] 
[2026-07-17 13:44:24] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-17 13:44:24] [INFO] * Auto-generated wrapper for parameters
[2026-07-17 13:44:24] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 13:44:24] [INFO] * Parameters: 'FormSIGPRINT', 'C:\4c\tasks\task306', 'CRUD'
[2026-07-17 13:44:24] [INFO] 
[2026-07-17 13:44:24] [INFO] * Anti-dialog protections for unattended execution
[2026-07-17 13:44:24] [INFO] SET SAFETY OFF
[2026-07-17 13:44:24] [INFO] SET RESOURCE OFF
[2026-07-17 13:44:24] [INFO] SET TALK OFF
[2026-07-17 13:44:24] [INFO] SET NOTIFY OFF
[2026-07-17 13:44:24] [INFO] SYS(2335, 0)
[2026-07-17 13:44:24] [INFO] 
[2026-07-17 13:44:24] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRINT', 'C:\4c\tasks\task306', 'CRUD'
[2026-07-17 13:44:24] [INFO] QUIT
[2026-07-17 13:44:24] [INFO] 
[2026-07-17 13:44:24] [INFO] === Fim do Wrapper.prg ===
[2026-07-17 13:44:24] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRINT",
  "timestamp": "20260717134424",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.prg):
*==============================================================================
* FormSIGPRINT.prg - Formulario de Cadastro de Instrucoes de Impressao
* Migrado de: SIGPRINT.SCX (frmcadastro)
* Tabela: SigOpIns
*==============================================================================

DEFINE CLASS FormSIGPRINT AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Instrucoes"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.Caption   = "Cadastro de Instru" + CHR(231) + CHR(245) + "es"
            loc_lResultado = DODEFAULT()
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa (chamado via FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRINTBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao criar SIGPRINTBO", "Erro")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.InicializarForm")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height
            .Tabs            = .F.
            .Visible         = .T.
            .Page1.Caption   = "Lista"
            .Page2.Caption   = "Dados"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo (cntSombra no legado)
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

        *-- Container botoes CRUD (Grupo_op no legado: Left=344, Width=385)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
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

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
        ENDWITH

        *-- Container Encerrar (padrao canonico: Left=917)
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de listagem (SigOpIns: cods, descrs, tipos)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 860
            .Height             = 450
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes CRUD
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes de acao + campos (parte 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (Grupo_Salva: Left=642, Top=-3 -> +29 = 26)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 26
            .Left        = 642
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
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
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
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
        ENDWITH

        *-- Label Codigo (Say8: Top=162 -> +29 = 191, Left=118, Width=42)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 191
            .Left      = 118
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getCods: Top=159 -> +29 = 188, Left=162, Width=80, MaxLength=10)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 188
            .Left      = 162
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Format    = "!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .TabIndex  = 1
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Descricao (Say1: Top=187 -> +29 = 216, Left=105, Width=55)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 216
            .Left      = 105
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescrs: Top=184 -> +29 = 213, Left=162, Width=537)
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value     = ""
            .Top       = 213
            .Left      = 162
            .Width     = 537
            .Height    = 23
            .MaxLength = 76
            .Format    = "!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .TabIndex  = 2
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Mensagem (Say3: Top=210 -> +29 = 239, Left=100, Width=60)
        loc_oPagina.AddObject("lbl_4c_Mensagem", "Label")
        WITH loc_oPagina.lbl_4c_Mensagem
            .Caption   = "Mensagem :"
            .Top       = 239
            .Left      = 100
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- EditBox Mensagem (getMensas: Top=209 -> +29 = 238, Left=162, Width=537, Height=103)
        loc_oPagina.AddObject("txt_4c_Mensagem", "EditBox")
        WITH loc_oPagina.txt_4c_Mensagem
            .Value     = ""
            .Top       = 238
            .Left      = 162
            .Width     = 537
            .Height    = 103
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .TabIndex  = 3
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Tipo (Say2: Top=320 -> +29 = 349, Left=131, Width=29)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Caption   = "Tipo :"
            .Top       = 349
            .Left      = 131
            .Width     = 29
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Tipo (optTipo: Top=314 -> +29 = 343, Left=156, Width=292, Height=27)
        loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Tipo
            .ButtonCount = 3
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 343
            .Left        = 156
            .Width       = 292
            .Height      = 27
            .Enabled     = .F.
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Cheque"
                .Left      = 7
                .Top       = 5
                .Width     = 62
                .Height    = 17
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "T" + CHR(237) + "tulo"
                .Left      = 84
                .Top       = 5
                .Width     = 62
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Follow Up"
                .Left      = 148
                .Top       = 5
                .Width     = 64
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- BINDEVENTs dos botoes de Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros de SigOpIns no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (cods C(10), descrs C(76), tipos N(1,0))
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    WITH loc_oGrid
                        .Column1.ControlSource    = "cursor_4c_Dados.cods"
                        .Column2.ControlSource    = "cursor_4c_Dados.descrs"
                        .Column3.ControlSource    = "cursor_4c_Dados.tipos"
                        .Column1.Width            = 100
                        .Column2.Width            = 680
                        .Column3.Width            = 60
                        .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
                        .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                        .Column3.Header1.Caption  = "Tipo"
                        .Column1.Alignment        = 0
                        .Column2.Alignment        = 0
                        .Column3.Alignment        = 2
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual ao grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
            .SetAll("ForeColor", RGB(90, 90, 90), "Column")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes de Page2 conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Enabled = (THIS.this_cModoAtual = "INCLUIR")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mensagem", 5)
                loc_oPg2.txt_4c_Mensagem.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_Tipo", 5)
                loc_oPg2.opt_4c_Tipo.Value = 1
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mensagem", 5)
                loc_oPg2.txt_4c_Mensagem.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_Tipo", 5)
                loc_oPg2.opt_4c_Tipo.Enabled = par_lHabilitar
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mensagem", 5)
                THIS.this_oBusinessObject.this_cMensagem  = loc_oPg2.txt_4c_Mensagem.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_Tipo", 5)
                THIS.this_oBusinessObject.this_nTipo = loc_oPg2.opt_4c_Tipo.Value
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os campos do Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value    = THIS.this_oBusinessObject.this_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mensagem", 5)
                loc_oPg2.txt_4c_Mensagem.Value  = THIS.this_oBusinessObject.this_cMensagem
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_Tipo", 5)
                loc_oPg2.opt_4c_Tipo.Value = IIF(THIS.this_oBusinessObject.this_nTipo > 0, ;
                    THIS.this_oBusinessObject.this_nTipo, 1)
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza registro selecionado no grid (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_lPode
        loc_cCodigo = ""
        loc_lPode   = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
            loc_lPode   = !EMPTY(loc_cCodigo)
        ENDIF

        IF !loc_lPode
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para alteracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_lPode
        loc_cCodigo = ""
        loc_lPode   = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
            loc_lPode   = !EMPTY(loc_cCodigo)
        ENDIF

        IF !loc_lPode
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lPode, loc_lConfirmou
        loc_cCodigo    = ""
        loc_lPode      = .F.
        loc_lConfirmou = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
            loc_lPode   = !EMPTY(loc_cCodigo)
        ENDIF

        IF !loc_lPode
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o da instru" + ;
            CHR(231) + CHR(227) + "o '" + loc_cCodigo + "'?", "Excluir")

        IF loc_lConfirmou
            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.Excluir()
                        THIS.this_cModoAtual = "LISTA"
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            CATCH TO loException
                MsgErro(loException.Message, "FormSIGPRINT.BtnExcluirClick")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre picker para localizar instrucao de impressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            THIS.this_oBusinessObject.Buscar("")
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.BtnBuscarClick")
        ENDTRY

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Dados"
                loc_oBusca.this_cTitulo        = "Buscar Instru" + CHR(231) + CHR(227) + ;
                    "o de Impress" + CHR(227) + "o"
                loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.BtnBuscarClick")
        ENDTRY

        IF !EMPTY(loc_cCodigo)
            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            CATCH TO loException
                MsgErro(loException.Message, "FormSIGPRINT.BtnBuscarClick")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva registro (Confirmar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodigo, loc_cDescricao, loc_cMensagem
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo    = ""
        loc_cDescricao = ""
        loc_cMensagem  = ""

        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BtnCancelarClick()
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
            loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Mensagem", 5)
            loc_cMensagem = ALLTRIM(loc_oPg2.txt_4c_Mensagem.Value)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Validar")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Validar")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF EMPTY(loc_cMensagem)
            MsgAviso("Mensagem inv" + CHR(225) + "lida! " + ;
                "Aten" + CHR(231) + CHR(227) + "o: esta mensagem ser" + CHR(225) + ;
                " utilizada na impress" + CHR(227) + "o da solicita" + CHR(231) + CHR(227) + "o!" + ;
                " Portanto " + CHR(233) + " necess" + CHR(225) + "rio preenche-la.", "Validar")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mensagem", 5)
                loc_oPg2.txt_4c_Mensagem.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- Verificar codigo duplicado no INSERT (logica de getCods.Valid do legado)
        IF THIS.this_cModoAtual = "INCLUIR"
            LOCAL loc_lExiste, loc_cSQLChk, loc_nResultChk
            loc_lExiste    = .F.
            loc_cSQLChk    = "SELECT COUNT(*) AS qtd FROM SigOpIns WHERE Cods = " + EscaparSQL(loc_cCodigo)
            loc_nResultChk = 0
            TRY
                loc_nResultChk = SQLEXEC(gnConnHandle, loc_cSQLChk, "cursor_4c_ChkCod")
                IF loc_nResultChk > 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                    USE IN cursor_4c_ChkCod
                ENDIF
            CATCH TO loExcChk
                MsgErro(loExcChk.Message, "FormSIGPRINT.BtnSalvarClick.ChkCod")
            ENDTRY
            IF loc_lExiste
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Validar")
                IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                    loc_oPg2.txt_4c_Codigo.Value = ""
                    loc_oPg2.txt_4c_Codigo.SetFocus()
                ENDIF
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.CarregarLista()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela a operacao e retorna para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
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


### BO (C:\4c\projeto\app\classes\SIGPRINTBO.prg):
*==============================================================================
* SIGPRINTBO.prg - Business Object para Cadastro de Instru????es de Impress??o
* Tabela: SigOpIns
* Gerado em: 2026-07-17
*==============================================================================

DEFINE CLASS SIGPRINTBO AS BusinessBase

    *-- Propriedades da entidade (mapeiam colunas de SigOpIns)
    this_cCodigo    = ""   && cods    char(10) NOT NULL - PK
    this_cDescricao = ""   && descrs  char(76) NOT NULL
    this_cMensagem  = ""   && mensas  text NULL
    this_nTipo      = 0    && tipos   numeric(1,0) NOT NULL - 1=Cheque, 2=Titulos, 3=FollowUp
    this_cCidChaves = ""   && cidchaves char(20) NOT NULL

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpIns"
            THIS.this_cCampoChave = "cods"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros de SigOpIns
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                       " FROM SigOpIns ORDER BY cods"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                           " FROM SigOpIns" + ;
                           " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY cods"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (cods)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                       " FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,      "C")
            THIS.this_cDescricao = TratarNulo(descrs,    "C")
            THIS.this_cMensagem  = TratarNulo(mensas,    "C")
            THIS.this_nTipo      = TratarNulo(tipos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigOpIns
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigOpIns (cods, descrs, mensas, tipos, cidchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescricao), 76)) + ", " + ;
                       EscaparSQL(THIS.this_cMensagem) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigOpIns (PK = cods)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpIns SET" + ;
                       " descrs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescricao), 76)) + ", " + ;
                       " mensas = " + EscaparSQL(THIS.this_cMensagem) + ", " + ;
                       " tipos = "  + FormatarNumeroSQL(THIS.this_nTipo) + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigOpIns (PK = cods)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe (para validar unicidade)
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigo(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ValCod")
                TABLEREVERT(.T., "cursor_4c_ValCod")
                USE IN cursor_4c_ValCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCod")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCod") > 0
                SELECT cursor_4c_ValCod
                loc_lExiste = (qtd > 0)
            ENDIF

            IF USED("cursor_4c_ValCod")
                USE IN cursor_4c_ValCod
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

