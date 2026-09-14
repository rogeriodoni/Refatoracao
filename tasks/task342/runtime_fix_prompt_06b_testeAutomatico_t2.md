# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[21/07/2026 12:28:48 PM] Erro: Erro ao buscar grupos:Connection handle is invalid.
[21/07/2026 12:28:48 PM] Erro: Erro ao buscar usuários:Connection handle is invalid.
[21/07/2026 12:28:48 PM] Erro: Erro ao carregar programas:Connection handle is invalid.
[21/07/2026 12:28:48 PM] Erro: Erro ao carregar barra:Connection handle is invalid.
[21/07/2026 12:28:48 PM] Erro: Erro ao carregar acesso telas:Connection handle is invalid.
[21/07/2026 12:28:48 PM] Erro: Erro ao buscar grupos:Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-21 11:59:47] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 11:59:47] [INFO] Config FPW: (nao fornecido)
[2026-07-21 11:59:47] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 11:59:47] [INFO] Timeout: 300 segundos
[2026-07-21 11:59:47] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ofwfmiv.prg
[2026-07-21 11:59:47] [INFO] Conteudo do wrapper:
[2026-07-21 11:59:47] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formacg', 'C:\4c\tasks\task342', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formacg', 'C:\4c\tasks\task342', 'CRUD'
QUIT

[2026-07-21 11:59:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ofwfmiv.prg
[2026-07-21 11:59:47] [INFO] VFP output esperado em: C:\4c\tasks\task342\vfp_output.txt
[2026-07-21 11:59:47] [INFO] Executando Visual FoxPro 9...
[2026-07-21 11:59:47] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ofwfmiv.prg
[2026-07-21 11:59:47] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ofwfmiv.prg
[2026-07-21 11:59:47] [INFO] Timeout configurado: 300 segundos
[2026-07-21 12:00:27] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 12:00:27] [INFO] VFP9 finalizado em 40.0912732 segundos
[2026-07-21 12:00:27] [INFO] Exit Code: 
[2026-07-21 12:00:27] [INFO] 
[2026-07-21 12:00:27] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 12:00:27] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ofwfmiv.prg
[2026-07-21 12:00:27] [INFO] 
[2026-07-21 12:00:27] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 12:00:27] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 12:00:27] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 12:00:27] [INFO] * Parameters: 'Formacg', 'C:\4c\tasks\task342', 'CRUD'
[2026-07-21 12:00:27] [INFO] 
[2026-07-21 12:00:27] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 12:00:27] [INFO] SET SAFETY OFF
[2026-07-21 12:00:27] [INFO] SET RESOURCE OFF
[2026-07-21 12:00:27] [INFO] SET TALK OFF
[2026-07-21 12:00:27] [INFO] SET NOTIFY OFF
[2026-07-21 12:00:27] [INFO] SYS(2335, 0)
[2026-07-21 12:00:27] [INFO] 
[2026-07-21 12:00:27] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formacg', 'C:\4c\tasks\task342', 'CRUD'
[2026-07-21 12:00:27] [INFO] QUIT
[2026-07-21 12:00:27] [INFO] 
[2026-07-21 12:00:27] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 12:00:27] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-21 12:27:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 12:27:54] [INFO] Config FPW: (nao fornecido)
[2026-07-21 12:27:54] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 12:27:54] [INFO] Timeout: 300 segundos
[2026-07-21 12:27:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pqrvnsvm.prg
[2026-07-21 12:27:54] [INFO] Conteudo do wrapper:
[2026-07-21 12:27:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formacg', 'C:\4c\tasks\task342', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formacg', 'C:\4c\tasks\task342', 'CRUD'
QUIT

[2026-07-21 12:27:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pqrvnsvm.prg
[2026-07-21 12:27:54] [INFO] VFP output esperado em: C:\4c\tasks\task342\vfp_output.txt
[2026-07-21 12:27:54] [INFO] Executando Visual FoxPro 9...
[2026-07-21 12:27:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pqrvnsvm.prg
[2026-07-21 12:27:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pqrvnsvm.prg
[2026-07-21 12:27:54] [INFO] Timeout configurado: 300 segundos
[2026-07-21 12:28:48] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 12:28:48] [INFO] VFP9 finalizado em 53.5286612 segundos
[2026-07-21 12:28:48] [INFO] Exit Code: 
[2026-07-21 12:28:48] [INFO] 
[2026-07-21 12:28:48] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 12:28:48] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pqrvnsvm.prg
[2026-07-21 12:28:48] [INFO] 
[2026-07-21 12:28:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 12:28:48] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 12:28:48] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 12:28:48] [INFO] * Parameters: 'Formacg', 'C:\4c\tasks\task342', 'CRUD'
[2026-07-21 12:28:48] [INFO] 
[2026-07-21 12:28:48] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 12:28:48] [INFO] SET SAFETY OFF
[2026-07-21 12:28:48] [INFO] SET RESOURCE OFF
[2026-07-21 12:28:48] [INFO] SET TALK OFF
[2026-07-21 12:28:48] [INFO] SET NOTIFY OFF
[2026-07-21 12:28:48] [INFO] SYS(2335, 0)
[2026-07-21 12:28:48] [INFO] 
[2026-07-21 12:28:48] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formacg', 'C:\4c\tasks\task342', 'CRUD'
[2026-07-21 12:28:48] [INFO] QUIT
[2026-07-21 12:28:48] [INFO] 
[2026-07-21 12:28:48] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 12:28:48] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formacg",
  "timestamp": "20260721122848",
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
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 412"
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
    "passou": 6,
    "falhou": 3,
    "percentual": 67
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formacg.prg):
*==============================================================================
* Formacg.prg - Formulario de Cadastro de Acesso de Grupos (SIGCDACG)
* Tabela: sigcdgra (PK: Grupos, NComps)
* Relacionados: sigcdacg, sigcdacu, sigcdacb, sigactel
* Legado: SIGCDACG.SCX (frmcadastro)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS Formacg AS FormBase

    *-- Propriedades visuais
    Caption      = "Acesso de Grupos"
    Height       = 600
    Width        = 1000
    DataSession  = 2
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    this_cTituloForm       = "Acesso de Grupos"
    this_oBusinessObject   = .NULL.
    this_cFiltroPrograma   = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("acgBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O" OR ISNULL(THIS.this_oBusinessObject)
                MsgErro("Erro ao criar acgBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.AjustarBotoesPorModo()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar: " + loc_oErro.Message + ;
                " [" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = 1000
            .Height    = 629
            .Tabs      = .F.
        ENDWITH
        THIS.pgf_4c_Paginas.Page1.Caption  = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.Caption  = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: grid de grupos + botoes CRUD
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oP1
        loc_oP1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (sombra + titulo)
        loc_oP1.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oP1.cnt_4c_Cabecalho
            .Top       = 31
            .Left      = 0
            .Width     = 1000
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(215,215,215)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH
        loc_oP1.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = ""
            .Top       = 0
            .Left      = 0
            .Width     = 1000
            .Height    = 85
            .AutoSize  = .F.
            .BackStyle = 1
            .BackColor = RGB(215,215,215)
        ENDWITH
        loc_oP1.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Acesso de Grupos"
            .Top       = 30
            .Left      = 10
            .Width     = 500
            .Height    = 25
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        *-- Container botoes CRUD (Incluir, Alterar, Excluir, Buscar, Copiar)
        loc_oP1.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oP1.cnt_4c_Botoes
            .Top       = 29
            .Left      =  542
            .Width     = 465
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Left            = 85
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Left            = 165
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Left            = 245
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_CopiarAcesso", "CommandButton")
        WITH loc_oP1.cnt_4c_Botoes.cmd_4c_CopiarAcesso
            .Caption         = "Copiar" + CHR(13) + "Acessos"
            .Left            = 325
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_copiar_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_CopiarAcesso, "Click", THIS, "BtnCopiarAcessoClick")

        *-- Painel de copia (oculto por padrao - ativado por BtnCopiarAcessoClick)
        loc_oP1.AddObject("cnt_4c_PainelCopia", "Container")
        WITH loc_oP1.cnt_4c_PainelCopia
            .Top       = 29
            .Left      = 480
            .Width     = 430
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(235,235,255)
            .BorderWidth = 1
            .Visible   = .F.
        ENDWITH
        loc_oP1.cnt_4c_PainelCopia.AddObject("lbl_4c_CopiarDe", "Label")
        WITH loc_oP1.cnt_4c_PainelCopia.lbl_4c_CopiarDe
            .Caption   = "Copiar do Grupo:"
            .Top       = 10
            .Left      = 10
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH
        loc_oP1.cnt_4c_PainelCopia.AddObject("txt_4c_GrupoOrigem", "TextBox")
        WITH loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem
            .Top           = 30
            .Left          = 10
            .Width         = 120
            .Height        = 23
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = RGB(255,255,255)
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem, "KeyPress", THIS, "TxtGrupoOrigemValid")
        loc_oP1.cnt_4c_PainelCopia.AddObject("cmd_4c_CopiarOk", "CommandButton")
        WITH loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarOk
            .Caption = "Copiar"
            .Left    = 145
            .Top     = 18
            .Width   = 75
            .Height  = 50
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .T.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarOk, "Click", THIS, "BtnCopiarOkClick")
        loc_oP1.cnt_4c_PainelCopia.AddObject("cmd_4c_CopiarCancelar", "CommandButton")
        WITH loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarCancelar
            .Caption = "Cancelar"
            .Left    = 235
            .Top     = 18
            .Width   = 75
            .Height  = 50
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .T.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarCancelar, "Click", THIS, "BtnCopiarCancelarClick")

        *-- Container Saida canonico (Left=917, Width=90)
        loc_oP1.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oP1.cnt_4c_Saida
            .Top       = 29
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH
        loc_oP1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid principal
        loc_oP1.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oP1.grd_4c_Lista
            .Top             = 121
            .Left            = 12
            .Width           = 976
            .Height          = 455
            .ColumnCount     = 2
            .RecordSourceType = 1
            .ReadOnly        = .T.
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .ScrollBars      = 3
            .GridLines       = 3
            .AllowHeaderSizing = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .GridLineColor   = RGB(238,238,238)
            .Visible         = .T.
            .Column1.Width   = 120
            .Column1.Header1.Caption = ""
            .Column2.Width   = 500
            .Column2.Header1.Caption = ""
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oP1)
        loc_oP1.cnt_4c_PainelCopia.Visible = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos + 4 abas internas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oP2
        loc_oP2 = THIS.pgf_4c_Paginas.Page2

        *-- Cabecalho cinza
        loc_oP2.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oP2.cnt_4c_Cabecalho
            .Top       = 29
            .Left      = 0
            .Width     = 1000
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(215,215,215)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH
        loc_oP2.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = ""
            .Top       = 0
            .Left      = 0
            .Width     = 1000
            .Height    = 85
            .AutoSize  = .F.
            .BackStyle = 1
            .BackColor = RGB(215,215,215)
        ENDWITH
        loc_oP2.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Acesso de Grupos - Dados"
            .Top       = 30
            .Left      = 10
            .Width     = 500
            .Height    = 25
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        *-- Botoes Salvar/Cancelar (sobrepostos ao cabecalho, lado direito)
        loc_oP2.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oP2.cnt_4c_BotoesDados
            .Top       = 29
            .Left      = 830
            .Width     = 170
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH
        loc_oP2.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oP2.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP2.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
        loc_oP2.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oP2.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Left            = 85
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oP2.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Campo Grupo
        loc_oP2.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oP2.lbl_4c_Grupo
            .Caption   = "Grupo:"
            .Top       = 126
            .Left      = 401
            .Width     = 50
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
            .Alignment = 1
        ENDWITH
        loc_oP2.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oP2.txt_4c_Grupo
            .Top           = 122
            .Left          = 456
            .Width         = 100
            .Height        = 23
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = RGB(255,255,255)
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Campo NomeCompleto
        loc_oP2.AddObject("lbl_4c_NomeCompleto", "Label")
        WITH loc_oP2.lbl_4c_NomeCompleto
            .Caption   = "Nome:"
            .Top       = 152
            .Left      = 401
            .Width     = 45
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
            .Alignment = 1
        ENDWITH
        loc_oP2.AddObject("txt_4c_NomeCompleto", "TextBox")
        WITH loc_oP2.txt_4c_NomeCompleto
            .Top           = 148
            .Left          = 456
            .Width         = 280
            .Height        = 23
            .MaxLength     = 30
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = RGB(255,255,255)
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Inner PageFrame com 4 abas (COM tabs visiveis)
        loc_oP2.AddObject("pgf_4c_Abas", "PageFrame")
        WITH loc_oP2.pgf_4c_Abas
            .Top       = 180
            .Left      = 0
            .Width     = 1000
            .Height    = 436
            .PageCount = 4
            .Tabs      = .T.
            .Visible   = .T.
        ENDWITH
        loc_oP2.pgf_4c_Abas.Page1.Caption = "Usu" + CHR(225) + "rios"
        loc_oP2.pgf_4c_Abas.Page2.Caption = "Programas"
        loc_oP2.pgf_4c_Abas.Page3.Caption = "Barra de Ferramentas"
        loc_oP2.pgf_4c_Abas.Page4.Caption = "Acesso a Telas"

        THIS.ConfigurarAbaUsuarios()
        THIS.ConfigurarAbaProgramas()
        THIS.ConfigurarAbaBarra()
        THIS.ConfigurarPgPage1()

        THIS.TornarControlesVisiveis(loc_oP2)
    ENDPROC

    *==========================================================================
    * ConfigurarAbaUsuarios - Page1 interna: listboxes de usuarios
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaUsuarios()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1

        loc_oAba.AddObject("lbl_4c_Disponiveis", "Label")
        WITH loc_oAba.lbl_4c_Disponiveis
            .Caption  = "Usu" + CHR(225) + "rios Dispon" + CHR(237) + "veis"
            .Top      = 8
            .Left     = 80
            .Width    = 200
            .Height   = 17
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        loc_oAba.AddObject("lbx_4c_Disponiveis", "ListBox")
        WITH loc_oAba.lbx_4c_Disponiveis
            .Top           = 28
            .Left          = 80
            .Width         = 200
            .Height        = 350
            .MultiSelect   = .T.
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oAba.lbx_4c_Disponiveis, "Click", THIS, "LbxDisponiveisClick")

        loc_oAba.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oAba.lbl_4c_Label3
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 426
            .Left      = 327
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_StatusDisp", "Label")
        WITH loc_oAba.lbl_4c_StatusDisp
            .Caption   = ""
            .Top       = 382
            .Left      = 143
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0,128,0)
        ENDWITH

        *-- Botoes de transferencia
        loc_oAba.AddObject("cmd_4c_AddUsu", "CommandButton")
        WITH loc_oAba.cmd_4c_AddUsu
            .Caption     = CHR(187)
            .Top         = 75
            .Left        = 295
            .Width       = 45
            .Height      = 30
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .T.
            .Visible     = .T.
            .ToolTipText = "Adicionar selecionados"
        ENDWITH
        BINDEVENT(loc_oAba.cmd_4c_AddUsu, "Click", THIS, "BtnAddUsuClick")

        loc_oAba.AddObject("cmd_4c_AddAllUsu", "CommandButton")
        WITH loc_oAba.cmd_4c_AddAllUsu
            .Caption     = CHR(187) + CHR(187)
            .Top         = 120
            .Left        = 295
            .Width       = 45
            .Height      = 30
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .T.
            .Visible     = .T.
            .ToolTipText = "Adicionar todos"
        ENDWITH
        BINDEVENT(loc_oAba.cmd_4c_AddAllUsu, "Click", THIS, "BtnAddAllUsuClick")

        loc_oAba.AddObject("cmd_4c_RemUsu", "CommandButton")
        WITH loc_oAba.cmd_4c_RemUsu
            .Caption     = CHR(171)
            .Top         = 170
            .Left        = 295
            .Width       = 45
            .Height      = 30
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .T.
            .Visible     = .T.
            .ToolTipText = "Remover selecionados"
        ENDWITH
        BINDEVENT(loc_oAba.cmd_4c_RemUsu, "Click", THIS, "BtnRemUsuClick")

        loc_oAba.AddObject("cmd_4c_RemAllUsu", "CommandButton")
        WITH loc_oAba.cmd_4c_RemAllUsu
            .Caption     = CHR(171) + CHR(171)
            .Top         = 215
            .Left        = 295
            .Width       = 45
            .Height      = 30
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .T.
            .Visible     = .T.
            .ToolTipText = "Remover todos"
        ENDWITH
        BINDEVENT(loc_oAba.cmd_4c_RemAllUsu, "Click", THIS, "BtnRemAllUsuClick")

        loc_oAba.AddObject("lbl_4c_Selecionados", "Label")
        WITH loc_oAba.lbl_4c_Selecionados
            .Caption  = "Usu" + CHR(225) + "rios do Grupo"
            .Top      = 8
            .Left     = 356
            .Width    = 200
            .Height   = 17
            .AutoSize = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        loc_oAba.AddObject("lbx_4c_Selecionados", "ListBox")
        WITH loc_oAba.lbx_4c_Selecionados
            .Top           = 28
            .Left          = 356
            .Width         = 200
            .Height        = 350
            .MultiSelect   = .T.
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oAba.lbx_4c_Selecionados, "Click", THIS, "LbxSelecionadosClick")

        loc_oAba.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oAba.lbl_4c_Label5
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 426
            .Left      = 529
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_StatusSel", "Label")
        WITH loc_oAba.lbl_4c_StatusSel
            .Caption   = ""
            .Top       = 382
            .Left      = 419
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0,128,0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaProgramas - Page2 interna: grid de programas com checkbox
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaProgramas()
        LOCAL loc_oAba, loc_oGrid
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2

        loc_oAba.AddObject("lbl_4c_FiltroAcesso", "Label")
        WITH loc_oAba.lbl_4c_FiltroAcesso
            .Caption   = "Filtro:"
            .Top       = 10
            .Left      = 10
            .Width     = 45
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60,60,60)
        ENDWITH
        loc_oAba.AddObject("txt_4c_FiltroAcesso", "TextBox")
        WITH loc_oAba.txt_4c_FiltroAcesso
            .Top           = 7
            .Left          = 60
            .Width         = 300
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = RGB(255,255,255)
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_FiltroAcesso, "LostFocus", THIS, "TxtFiltroAcessoValid")

        loc_oAba.AddObject("grd_4c_Programas", "Grid")
        loc_oGrid = loc_oAba.grd_4c_Programas
        WITH loc_oGrid
            .Top              = 35
            .Left             = 5
            .Width            = 990
            .Height           = 400
            .ColumnCount      = 4
            .RecordSourceType = 1
            .ReadOnly         = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ScrollBars       = 3
            .GridLines        = 3
            .AllowHeaderSizing = .T.
            .FontName         = "Tahoma"
            .FontSize         = 8
            .GridLineColor    = RGB(238,238,238)
            .Visible          = .T.
            .Column1.Width    = 380
            .Column1.ReadOnly = .T.
            .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width    = 120
            .Column2.ReadOnly = .T.
            .Column2.Header1.Caption = "Programa"
            .Column3.Width    = 65
            .Column3.ReadOnly = .F.
            .Column3.Sparse   = .F.
            .Column3.Header1.Caption = ""
            .Column4.Width    = 120
            .Column4.ReadOnly = .T.
            .Column4.Header1.Caption = "Parametro"
        ENDWITH
        WITH loc_oGrid.Column3
            .AddObject("chk_4c_Marcas", "CheckBox")
        ENDWITH
        WITH loc_oGrid.Column3.chk_4c_Marcas
            .Caption   = ""
            .Width     = 60
            .Height    = 17
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oGrid.Column3.chk_4c_Marcas, "When", THIS, "ChkMarcasWhen")
    ENDPROC

    *==========================================================================
    * ConfigurarAbaBarra - Page3 interna: grid barra de ferramentas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaBarra()
        LOCAL loc_oAba, loc_oGrid
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3

        loc_oAba.AddObject("grd_4c_Barra", "Grid")
        loc_oGrid = loc_oAba.grd_4c_Barra
        WITH loc_oGrid
            .Top              = 10
            .Left             = 5
            .Width            = 990
            .Height           = 430
            .ColumnCount      = 2
            .RecordSourceType = 1
            .ReadOnly         = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ScrollBars       = 3
            .GridLines        = 3
            .AllowHeaderSizing = .T.
            .FontName         = "Tahoma"
            .FontSize         = 8
            .GridLineColor    = RGB(238,238,238)
            .Visible          = .T.
            .Column1.Width    = 550
            .Column1.ReadOnly = .T.
            .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width    = 80
            .Column2.ReadOnly = .F.
            .Column2.Sparse   = .F.
            .Column2.Header1.Caption = ""
        ENDWITH
        WITH loc_oGrid.Column2
            .AddObject("chk_4c_SelBarras", "CheckBox")
        ENDWITH
        WITH loc_oGrid.Column2.chk_4c_SelBarras
            .Caption   = ""
            .Width     = 75
            .Height    = 17
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oGrid.Column2.chk_4c_SelBarras, "When", THIS, "ChkSelBarrasWhen")
    ENDPROC

    *==========================================================================
    * ConfigurarPgPage1 - Page4 interna: grid "Acesso Tela" com ComboBox Status
    * Corresponde a SIGCDACG.Pagina.Dados.Pagina.Page1 (caption "Acesso Tela")
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage1()
        LOCAL loc_oAba, loc_oGrid
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4

        loc_oAba.AddObject("grd_4c_Telas", "Grid")
        loc_oGrid = loc_oAba.grd_4c_Telas
        WITH loc_oGrid
            .Top               = 26
            .Left              = 13
            .Width             = 969
            .Height            = 414
            .ColumnCount       = 3
            .RecordSourceType  = 1
            .ReadOnly          = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .GridLineColor     = RGB(238,238,238)
            .RowHeight         = 16
            .Visible           = .T.
            .Column1.Width     = 360
            .Column1.ReadOnly  = .T.
            .Column1.Header1.Caption = "Tela"
            .Column2.Width     = 360
            .Column2.ReadOnly  = .T.
            .Column2.Header1.Caption = "Campo"
            .Column3.Width     = 168
            .Column3.ReadOnly  = .F.
            .Column3.Sparse    = .F.
            .Column3.Header1.Caption = "Status"
        ENDWITH
        WITH loc_oGrid.Column3
            .AddObject("cbo_4c_CmbStatus", "ComboBox")
        ENDWITH
        WITH loc_oGrid.Column3.cbo_4c_CmbStatus
            .RowSourceType = 1
            .RowSource     = "Padr" + CHR(227) + "o," + ;
                             "Invis" + CHR(237) + "vel," + ;
                             "N" + CHR(227) + "o Edit" + CHR(225) + "vel," + ;
                             "Obrigat" + CHR(243) + "rio"
            .BoundTo       = .T.
            .Style         = 2
            .Width         = 160
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
        BINDEVENT(loc_oGrid.Column3.cbo_4c_CmbStatus, "When", THIS, "ChkStatusWhen")
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor_4c_Dados e vincula ao grd_4c_Lista
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.
        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Grupos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.NComps"
                loc_oGrid.Column1.Header1.Caption = ""
                loc_oGrid.Column2.Header1.Caption = ""
                loc_oGrid.Column1.Width = 120
                loc_oGrid.Column2.Width = 500
                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8
                loc_oGrid.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDadosGrupo - Carrega todas as 4 abas para o grupo
    *==========================================================================
    PROCEDURE CarregarDadosGrupo(par_cGrupos)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.CarregarUsuariosAbas(par_cGrupos)
            THIS.CarregarProgramasAba(par_cGrupos)
            THIS.CarregarBarraAba(par_cGrupos)
            THIS.CarregarTelasAba(par_cGrupos)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar dados do grupo: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarUsuariosAbas - Preenche as duas listboxes de usuarios
    *==========================================================================
    PROCEDURE CarregarUsuariosAbas(par_cGrupos)
        LOCAL loc_oAba, loc_lNovoGrupo, loc_cUsu, loc_lNaGrupo
        TRY
            loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
            loc_oAba.lbx_4c_Disponiveis.Clear()
            loc_oAba.lbx_4c_Selecionados.Clear()
            loc_oAba.lbl_4c_StatusDisp.Caption = ""
            loc_oAba.lbl_4c_StatusSel.Caption  = ""

            loc_lNovoGrupo = EMPTY(ALLTRIM(par_cGrupos))

            *-- Carregar usuarios do grupo (se grupo existente)
            IF !loc_lNovoGrupo
                THIS.this_oBusinessObject.CarregarUsuariosDoGrupo(par_cGrupos)
            ENDIF

            *-- Carregar todos os usuarios do sistema
            IF THIS.this_oBusinessObject.BuscarTodosUsuarios() AND USED("cursor_4c_TodosUsuarios")
                SELECT cursor_4c_TodosUsuarios
                GO TOP
                SCAN
                    loc_cUsu = ALLTRIM(Usuarios)
                    loc_lNaGrupo = .F.
                    IF !loc_lNovoGrupo AND USED("cursor_4c_UsuariosGrupo")
                        SELECT cursor_4c_UsuariosGrupo
                        LOCATE FOR ALLTRIM(Usuarios) == m.loc_cUsu
                        IF !EOF()
                            loc_lNaGrupo = .T.
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_TodosUsuarios
                    IF loc_lNaGrupo
                        loc_oAba.lbx_4c_Selecionados.AddItem(loc_cUsu)
                    ELSE
                        loc_oAba.lbx_4c_Disponiveis.AddItem(loc_cUsu)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar usu" + CHR(225) + "rios: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarProgramasAba - Vincula cursor_4c_Programas ao grd_4c_Programas
    *==========================================================================
    PROCEDURE CarregarProgramasAba(par_cGrupos)
        LOCAL loc_oGrid
        TRY
            IF THIS.this_oBusinessObject.CarregarProgramas(par_cGrupos)
                THIS.this_cFiltroPrograma = ""
                IF USED("cursor_4c_Programas")
                    SELECT cursor_4c_Programas
                    SET FILTER TO
                ENDIF
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Programas"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Programas.Descricaos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Programas.Programas"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Programas.Marcas"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Programas.Parametros"
                loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption = "Programa"
                loc_oGrid.Column3.Header1.Caption = ""
                loc_oGrid.Column4.Header1.Caption = "Parametro"
                loc_oGrid.Column1.Width = 380
                loc_oGrid.Column2.Width = 120
                loc_oGrid.Column3.Width = 65
                loc_oGrid.Column4.Width = 120
                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar programas: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarBarraAba - Vincula TmpBarra ao grd_4c_Barra
    *==========================================================================
    PROCEDURE CarregarBarraAba(par_cGrupos)
        LOCAL loc_oGrid
        TRY
            IF THIS.this_oBusinessObject.CarregarBarra(par_cGrupos)
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "TmpBarra"
                loc_oGrid.Column1.ControlSource = "TmpBarra.Descricaos"
                loc_oGrid.Column2.ControlSource = "TmpBarra.SelBarras"
                loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption = ""
                loc_oGrid.Column1.Width = 550
                loc_oGrid.Column2.Width = 80
                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar barra: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarTelasAba - Vincula crSigAcTel ao grd_4c_Telas
    *==========================================================================
    PROCEDURE CarregarTelasAba(par_cGrupos)
        LOCAL loc_oGrid
        TRY
            IF THIS.this_oBusinessObject.CarregarAcessoTelas(par_cGrupos)
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "crSigAcTel"
                loc_oGrid.Column1.ControlSource = "crSigAcTel.cDescTelas"
                loc_oGrid.Column2.ControlSource = "crSigAcTel.cDescCamps"
                loc_oGrid.Column3.ControlSource = "crSigAcTel.nStatus"
                loc_oGrid.Column1.Header1.Caption = "Tela"
                loc_oGrid.Column2.Header1.Caption = "Campo"
                loc_oGrid.Column3.Header1.Caption = "Status"
                loc_oGrid.Column1.Width = 360
                loc_oGrid.Column2.Width = 360
                loc_oGrid.Column3.Width = 168
                loc_oGrid.Column3.cbo_4c_CmbStatus.RowSourceType = 1
                loc_oGrid.Column3.cbo_4c_CmbStatus.RowSource = "Padr" + CHR(227) + "o," + ;
                    "Invis" + CHR(237) + "vel," + ;
                    "N" + CHR(227) + "o Edit" + CHR(225) + "vel," + ;
                    "Obrigat" + CHR(243) + "rio"
                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso a telas: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
            .this_cNComps = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Grupo.Value        = THIS.this_oBusinessObject.this_cGrupos
            .txt_4c_NomeCompleto.Value = THIS.this_oBusinessObject.this_cNComps
        ENDWITH
    ENDPROC

    *==========================================================================
    * LimparCampos
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oP2, loc_oAbas
        loc_oP2   = THIS.pgf_4c_Paginas.Page2
        loc_oAbas = loc_oP2.pgf_4c_Abas
        loc_oP2.txt_4c_Grupo.Value        = ""
        loc_oP2.txt_4c_NomeCompleto.Value = ""
        loc_oAbas.Page1.lbx_4c_Disponiveis.Clear()
        loc_oAbas.Page1.lbx_4c_Selecionados.Clear()
        loc_oAbas.Page1.lbl_4c_StatusDisp.Caption = ""
        loc_oAbas.Page1.lbl_4c_StatusSel.Caption  = ""
        loc_oAbas.Page2.txt_4c_FiltroAcesso.Value = ""
        loc_oAbas.Page2.grd_4c_Programas.RecordSource = ""
        loc_oAbas.Page3.grd_4c_Barra.RecordSource = ""
        loc_oAbas.Page4.grd_4c_Telas.RecordSource = ""
        THIS.this_cFiltroPrograma = ""
    ENDPROC

    *==========================================================================
    * HabilitarCampos
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oP2
        loc_oP2 = THIS.pgf_4c_Paginas.Page2
        *-- Grupo: so editavel no INCLUIR
        loc_oP2.txt_4c_Grupo.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oP2.txt_4c_NomeCompleto.Enabled = par_lHabilitar
        THIS.HabilitarAbaUsuarios(par_lHabilitar)
        THIS.HabilitarColunasGrid(par_lHabilitar)
    ENDPROC

    *==========================================================================
    * HabilitarAbaUsuarios
    *==========================================================================
    PROTECTED PROCEDURE HabilitarAbaUsuarios(par_lHabilitar)
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_oAba.cmd_4c_AddUsu.Enabled    = par_lHabilitar
        loc_oAba.cmd_4c_AddAllUsu.Enabled = par_lHabilitar
        loc_oAba.cmd_4c_RemUsu.Enabled    = par_lHabilitar
        loc_oAba.cmd_4c_RemAllUsu.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    * HabilitarColunasGrid - Habilita/desabilita colunas de checkbox nos grids
    *==========================================================================
    PROTECTED PROCEDURE HabilitarColunasGrid(par_lHabilitar)
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Column3.ReadOnly = !par_lHabilitar
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra.Column2.ReadOnly     = !par_lHabilitar
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas.Column3.ReadOnly     = !par_lHabilitar
        CATCH TO loc_oErro
            MsgErro("Erro ao habilitar grids: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme modo atual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lNaLista, loc_oBotoes
        TRY
            loc_lNaLista = (THIS.this_cModoAtual = "LISTA")
            loc_oBotoes  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oBotoes.cmd_4c_Incluir.Enabled      = .T.
            loc_oBotoes.cmd_4c_Alterar.Enabled      = loc_lNaLista
            loc_oBotoes.cmd_4c_Excluir.Enabled      = loc_lNaLista
            loc_oBotoes.cmd_4c_Buscar.Enabled       = loc_lNaLista
            loc_oBotoes.cmd_4c_CopiarAcesso.Enabled = loc_lNaLista
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AtivaCopia - Mostra/oculta painel de copia de acessos na Page1
    *==========================================================================
    PROCEDURE AtivaCopia(par_lAtivo)
        LOCAL loc_oP1
        loc_oP1 = THIS.pgf_4c_Paginas.Page1
        loc_oP1.cnt_4c_PainelCopia.Visible = par_lAtivo
        loc_oP1.cnt_4c_Botoes.Visible      = !par_lAtivo
        loc_oP1.grd_4c_Lista.Enabled       = !par_lAtivo
        IF par_lAtivo
            loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.Value = ""
            loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * SalvarDadosRelacionados - Salva usuarios, programas, barra e telas
    *==========================================================================
    PROCEDURE SalvarDadosRelacionados(par_cGrupos)
        LOCAL loc_lSucesso, loc_oAba1, loc_nI, loc_cUsu
        loc_lSucesso = .T.
        TRY
            loc_oAba1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1

            *-- Cursor temporario com usuarios selecionados
            IF USED("cursor_4c_UsrSalvar")
                USE IN cursor_4c_UsrSalvar
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_UsrSalvar (Usuarios C(10))
            SET NULL OFF
            FOR loc_nI = 1 TO loc_oAba1.lbx_4c_Selecionados.ListCount
                loc_cUsu = ALLTRIM(loc_oAba1.lbx_4c_Selecionados.List(loc_nI))
                IF !EMPTY(loc_cUsu)
                    INSERT INTO cursor_4c_UsrSalvar VALUES (m.loc_cUsu)
                ENDIF
            ENDFOR

            IF !THIS.this_oBusinessObject.SalvarUsuarios(par_cGrupos, "cursor_4c_UsrSalvar")
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_UsrSalvar")
                USE IN cursor_4c_UsrSalvar
            ENDIF

            *-- Salvar programas (limpar filtro antes)
            IF USED("cursor_4c_Programas")
                SELECT cursor_4c_Programas
                SET FILTER TO
                GO TOP
                IF !THIS.this_oBusinessObject.SalvarProgramas(par_cGrupos, "cursor_4c_Programas")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Salvar barra
            IF USED("TmpBarra")
                IF !THIS.this_oBusinessObject.SalvarBarra(par_cGrupos, "TmpBarra")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Salvar acesso a telas
            IF USED("crSigAcTel")
                IF !THIS.this_oBusinessObject.SalvarAcessoTelas(par_cGrupos, "crSigAcTel")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar dados relacionados: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterStatusUsuario - Retorna "Ativo" ou "Inativo" para um usuario
    *==========================================================================
    PROCEDURE ObterStatusUsuario(par_cUsuarios)
        LOCAL loc_cStatus, loc_nResult
        loc_cStatus = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cAtivos FROM sigcdusu WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cUsuarios)), ;
                "cursor_4c_TmpUsu")
            IF loc_nResult >= 0 AND USED("cursor_4c_TmpUsu") AND RECCOUNT("cursor_4c_TmpUsu") > 0
                SELECT cursor_4c_TmpUsu
                IF ALLTRIM(cAtivos) = "N"
                    loc_cStatus = "Inativo"
                ELSE
                    loc_cStatus = "Ativo"
                ENDIF
            ENDIF
            IF USED("cursor_4c_TmpUsu")
                USE IN cursor_4c_TmpUsu
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao obter status do usu" + CHR(225) + "rio: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cStatus
    ENDPROC

    *==========================================================================
    * --- HANDLERS DE BOTOES ---
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.CarregarDadosGrupo("")
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGrupos
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupos = ALLTRIM(Grupos)
        IF EMPTY(loc_cGrupos)
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.CarregarDadosGrupo(loc_cGrupos)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGrupos
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupos = ALLTRIM(Grupos)
        IF EMPTY(loc_cGrupos)
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.CarregarDadosGrupo(loc_cGrupos)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGrupos
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupos = ALLTRIM(Grupos)
        IF EMPTY(loc_cGrupos)
            MsgAviso("Selecione um grupo na lista.")
            RETURN
        ENDIF
        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo " + loc_cGrupos + "?")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Grupo exclu" + CHR(237) + "do com sucesso.")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cGrupoSel
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdgra", ;
                "cursor_4c_Busca", "Grupos", "", "Buscar Grupo")
            loc_oBusca.mAddColuna("Grupos", "", "Grupo")
            loc_oBusca.mAddColuna("NComps", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                SELECT cursor_4c_Busca
                loc_cGrupoSel = ALLTRIM(Grupos)
                USE IN cursor_4c_Busca
                THIS.this_oBusinessObject.Buscar(loc_cGrupoSel)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 2
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.Grupos"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.NComps"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = ""
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = ""
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ELSE
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
        LOCAL loc_cGrupos, loc_cNome
        loc_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
        loc_cNome   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)

        IF EMPTY(loc_cGrupos)
            MsgAviso("C" + CHR(243) + "digo do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cNome)
            MsgAviso("Nome do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.SetFocus()
            RETURN
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarDuplicidade(loc_cGrupos)
                MsgAviso("Grupo " + loc_cGrupos + " j" + CHR(225) + " cadastrado.")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            IF !THIS.SalvarDadosRelacionados(loc_cGrupos)
                MsgAviso("Grupo salvo, mas houve erro ao salvar dados relacionados.")
            ELSE
                MsgInfo("Grupo salvo com sucesso.")
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnCopiarAcessoClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo destino para copiar acessos.")
            RETURN
        ENDIF
        THIS.AtivaCopia(.T.)
    ENDPROC

    *==========================================================================
    * TxtGrupoOrigemValid - Lookup do grupo de origem no painel de copia
    *==========================================================================
    PROCEDURE TxtGrupoOrigemValid(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        LOCAL loc_oTxt, loc_oBusca, loc_cValor
        TRY
            loc_oTxt = THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem
            loc_cValor = ALLTRIM(loc_oTxt.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdgra", ;
                "cursor_4c_BuscaOrigem", "Grupos", loc_cValor, "Selecionar Grupo Origem")
            loc_oBusca.mAddColuna("Grupos", "", "Grupo")
            loc_oBusca.mAddColuna("NComps", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
                SELECT cursor_4c_BuscaOrigem
                loc_oTxt.Value = ALLTRIM(Grupos)
                USE IN cursor_4c_BuscaOrigem
            ELSE
                IF USED("cursor_4c_BuscaOrigem")
                    USE IN cursor_4c_BuscaOrigem
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo de origem: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCopiarOkClick - Executa copia de acessos entre grupos
    *==========================================================================
    PROCEDURE BtnCopiarOkClick()
        LOCAL loc_cGrupoOrigem, loc_cGrupoDestino
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo destino na lista.")
            RETURN
        ENDIF
        loc_cGrupoOrigem = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.Value)
        IF EMPTY(loc_cGrupoOrigem)
            MsgAviso("Informe o grupo de origem.")
            THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.SetFocus()
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupoDestino = ALLTRIM(Grupos)
        IF UPPER(loc_cGrupoOrigem) = UPPER(loc_cGrupoDestino)
            MsgAviso("Grupo de origem e destino s" + CHR(227) + "o iguais.")
            RETURN
        ENDIF
        IF MsgConfirma("Copiar acessos de [" + loc_cGrupoOrigem + "] para [" + loc_cGrupoDestino + "]?")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupoDestino)
                IF THIS.this_oBusinessObject.CopiarAcessos(loc_cGrupoOrigem)
                    MsgInfo("Acessos copiados com sucesso.")
                    THIS.AtivaCopia(.F.)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnCopiarCancelarClick()
        THIS.AtivaCopia(.F.)
    ENDPROC

    *==========================================================================
    * --- HANDLERS DE LISTBOX ---
    *==========================================================================

    PROCEDURE LbxDisponiveisClick()
        LOCAL loc_oAba, loc_cUsu, loc_cStatus
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        IF loc_oAba.lbx_4c_Disponiveis.ListIndex > 0
            loc_cUsu    = ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_oAba.lbx_4c_Disponiveis.ListIndex))
            loc_cStatus = THIS.ObterStatusUsuario(loc_cUsu)
            loc_oAba.lbl_4c_StatusDisp.Caption  = loc_cStatus
            loc_oAba.lbl_4c_StatusDisp.ForeColor = IIF(loc_cStatus = "Inativo", RGB(200,0,0), RGB(0,128,0))
        ENDIF
    ENDPROC

    PROCEDURE LbxSelecionadosClick()
        LOCAL loc_oAba, loc_cUsu, loc_cStatus
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        IF loc_oAba.lbx_4c_Selecionados.ListIndex > 0
            loc_cUsu    = ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_oAba.lbx_4c_Selecionados.ListIndex))
            loc_cStatus = THIS.ObterStatusUsuario(loc_cUsu)
            loc_oAba.lbl_4c_StatusSel.Caption  = loc_cStatus
            loc_oAba.lbl_4c_StatusSel.ForeColor = IIF(loc_cStatus = "Inativo", RGB(200,0,0), RGB(0,128,0))
        ENDIF
    ENDPROC

    *==========================================================================
    * --- HANDLERS DE TRANSFERENCIA DE USUARIOS ---
    *==========================================================================

    PROCEDURE BtnAddUsuClick()
        LOCAL loc_oAba, loc_nI, loc_cUsu
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        FOR loc_nI = loc_oAba.lbx_4c_Disponiveis.ListCount TO 1 STEP -1
            IF loc_oAba.lbx_4c_Disponiveis.Selected(loc_nI)
                loc_cUsu = ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_nI))
                loc_oAba.lbx_4c_Selecionados.AddItem(loc_cUsu)
                loc_oAba.lbx_4c_Disponiveis.RemoveItem(loc_nI)
            ENDIF
        ENDFOR
    ENDPROC

    PROCEDURE BtnAddAllUsuClick()
        LOCAL loc_oAba, loc_nI
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        FOR loc_nI = 1 TO loc_oAba.lbx_4c_Disponiveis.ListCount
            loc_oAba.lbx_4c_Selecionados.AddItem(ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_nI)))
        ENDFOR
        loc_oAba.lbx_4c_Disponiveis.Clear()
    ENDPROC

    PROCEDURE BtnRemUsuClick()
        LOCAL loc_oAba, loc_nI, loc_cUsu
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        FOR loc_nI = loc_oAba.lbx_4c_Selecionados.ListCount TO 1 STEP -1
            IF loc_oAba.lbx_4c_Selecionados.Selected(loc_nI)
                loc_cUsu = ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_nI))
                loc_oAba.lbx_4c_Disponiveis.AddItem(loc_cUsu)
                loc_oAba.lbx_4c_Selecionados.RemoveItem(loc_nI)
            ENDIF
        ENDFOR
    ENDPROC

    PROCEDURE BtnRemAllUsuClick()
        LOCAL loc_oAba, loc_nI
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        FOR loc_nI = 1 TO loc_oAba.lbx_4c_Selecionados.ListCount
            loc_oAba.lbx_4c_Disponiveis.AddItem(ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_nI)))
        ENDFOR
        loc_oAba.lbx_4c_Selecionados.Clear()
    ENDPROC

    *==========================================================================
    * TxtFiltroAcessoValid - Aplica filtro na grid de programas
    *==========================================================================
    PROCEDURE TxtFiltroAcessoValid()
        THIS.this_cFiltroPrograma = UPPER(ALLTRIM( ;
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.txt_4c_FiltroAcesso.Value))
        IF USED("cursor_4c_Programas")
            SELECT cursor_4c_Programas
            IF EMPTY(THIS.this_cFiltroPrograma)
                SET FILTER TO
            ELSE
                SET FILTER TO THISFORM.this_cFiltroPrograma $ UPPER(ALLTRIM(Descricaos))
            ENDIF
            GO TOP
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkMarcasWhen - Permite editar checkbox Marcas somente em INCLUIR/ALTERAR
    *==========================================================================
    PROCEDURE ChkMarcasWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * ChkSelBarrasWhen - Permite editar checkbox SelBarras somente em INCLUIR/ALTERAR
    *==========================================================================
    PROCEDURE ChkSelBarrasWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * ChkStatusWhen - Permite editar checkbox nStatus somente em INCLUIR/ALTERAR
    *==========================================================================
    PROCEDURE ChkStatusWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oCtrl, loc_cNome
        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O"
                loc_cNome = UPPER(loc_oCtrl.Name)
                IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_SAIDA", "CNT_4C_PAINELCOPIA")
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Programas")
            USE IN cursor_4c_Programas
        ENDIF
        IF USED("TmpBarra")
            USE IN TmpBarra
        ENDIF
        IF USED("crSigAcTel")
            USE IN crSigAcTel
        ENDIF
        IF USED("cursor_4c_TodosUsuarios")
            USE IN cursor_4c_TodosUsuarios
        ENDIF
        IF USED("cursor_4c_UsuariosGrupo")
            USE IN cursor_4c_UsuariosGrupo
        ENDIF
        IF USED("cursor_4c_UsrSalvar")
            USE IN cursor_4c_UsrSalvar
        ENDIF
        IF USED("cursor_4c_BuscaOrigem")
            USE IN cursor_4c_BuscaOrigem
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
        IF USED("cursor_4c_TmpUsu")
            USE IN cursor_4c_TmpUsu
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\acgBO.prg):
*==============================================================================
* acgBO.prg - Business Object para Acesso de Grupos (SIGCDACG)
* Tabela Principal: sigcdgra (PK: Grupos)
* Tabelas Relacionadas:
*   - sigcdacg (usuarios do grupo)
*   - sigcdacu (acessos de programa por grupo/usuario)
*   - sigcdacb (barra de ferramentas por grupo)
*   - sigactel (acesso a campos em telas por grupo)
*   - sigcdprg (programas disponiveis)
*   - sigcdusu (usuarios cadastrados)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS acgBO AS BusinessBase

    *-- Propriedades: sigcdgra
    this_cGrupos    = ""   && grupos char(10) NOT NULL - PK
    this_cNComps    = ""   && ncomps char(30) NOT NULL - nome do grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdgra"
        THIS.this_cCampoChave = "Grupos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(Grupos, "C")
            THIS.this_cNComps = TratarNulo(NComps, "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca grupos com filtro opcional para exibir no grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                    " WHERE Grupos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega grupo pela PK
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT sigcdgra (registro principal)
    * Dados relacionados sao salvos separadamente via SalvarUsuarios,
    * SalvarProgramas, SalvarBarra, SalvarAcessoTelas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigcdgra (Grupos, NComps) VALUES (" + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigcdgra (registro principal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigcdgra SET NComps = " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ;
                " WHERE Grupos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigcdgra e todas as tabelas relacionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        TRY
            *-- Excluir dependencias (ordem importa para FK)
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del1")
            IF USED("cursor_4c_Del1")
                USE IN cursor_4c_Del1
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del2")
            IF USED("cursor_4c_Del2")
                USE IN cursor_4c_Del2
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del3")
            IF USED("cursor_4c_Del3")
                USE IN cursor_4c_Del3
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del4")
            IF USED("cursor_4c_Del4")
                USE IN cursor_4c_Del4
            ENDIF

            *-- Excluir registro principal
            loc_cSQL = "DELETE FROM sigcdgra WHERE Grupos = " + loc_cGrupoSQL
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del5")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                IF USED("cursor_4c_Del5")
                    USE IN cursor_4c_Del5
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosGrupos - Lista todos os grupos (para listbox de copia)
    * Retorna cursor: cursor_4c_ListaGrupos (Grupos, NComps)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosGrupos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaGrupos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_ListaGrupos")
                    SELECT cursor_4c_ListaGrupos
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosUsuarios - Lista todos os usuarios do sistema
    * Retorna cursor: cursor_4c_TodosUsuarios (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosUsuarios()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Usuarios, NComps, cAtivos FROM sigcdusu ORDER BY NComps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TodosUsuarios")
            IF loc_nResult >= 0
                IF USED("cursor_4c_TodosUsuarios")
                    SELECT cursor_4c_TodosUsuarios
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarUsuariosDoGrupo - Carrega usuarios pertencentes ao grupo
    * Retorna cursor: cursor_4c_UsuariosGrupo (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarUsuariosDoGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Usuarios, u.NComps, u.cAtivos" + ;
                " FROM sigcdacg a" + ;
                " LEFT JOIN sigcdusu u ON u.Usuarios = a.Usuarios" + ;
                " WHERE a.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " ORDER BY a.Usuarios"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosGrupo")
            IF loc_nResult >= 0
                IF USED("cursor_4c_UsuariosGrupo")
                    SELECT cursor_4c_UsuariosGrupo
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarProgramas - Carrega programas disponiveis com marcacao do grupo
    * Retorna cursor: cursor_4c_Programas (Descricaos, Programas, Parametros,
    *                 BarraForms, Marcas)
    * Marcas=1: programa ja liberado ao grupo; Marcas=0: nao liberado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarProgramas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Descricaos, a.Programas, a.Parametros, a.BarraForms," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS Marcas" + ;
                " FROM sigcdprg a" + ;
                " LEFT JOIN sigcdacu b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " ORDER BY a.Descricaos, a.Programas, a.Parametros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Programas")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Programas")
                    SELECT cursor_4c_Programas
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar programas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar programas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarra - Carrega itens de barra de ferramentas com marcacao do grupo
    * Retorna cursor: TmpBarra (BarraOrdem, Descricaos, BarraForms, Programas,
    *                           Parametros, SelBarras, Usuarios)
    * SelBarras=1: item ativo no grupo; SelBarras=0: inativo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarra(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT DISTINCT a.BarraOrdem, a.Descricaos, a.BarraForms," + ;
                " a.Programas, a.Parametros," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS SelBarras," + ;
                " '' AS Usuarios" + ;
                " FROM sigcdacb a" + ;
                " LEFT JOIN sigcdacb b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                " ORDER BY a.BarraOrdem, a.Descricaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpBarra")
            IF loc_nResult >= 0
                IF USED("TmpBarra")
                    SELECT TmpBarra
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar barra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessoTelas - Carrega controle de acesso a campos nas telas
    * par_cGrupos: codigo do grupo (vazio = inserindo novo, traz template com nStatus=1)
    * Retorna cursor: crSigAcTel (cCodigos, cDescTelas, cCampos, cObjetos,
    *                              cDescCamps, nStatus, Grupos, Usuarios, pkchaves)
    * nStatus=0: campo liberado; nStatus=1: campo bloqueado (default)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessoTelas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(ALLTRIM(par_cGrupos))
        TRY
            IF EMPTY(ALLTRIM(par_cGrupos))
                *-- Novo grupo: retorna template com todos os campos bloqueados
                loc_cSQL = "SELECT cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps," + ;
                    " 1 AS nStatus, '' AS Grupos, '' AS Usuarios, '' AS pkchaves" + ;
                    " FROM sigactel WHERE grupos = '' AND usuarios = ''" + ;
                    " ORDER BY cCodigos"
            ELSE
                *-- Grupo existente: mostra estado real com defaults bloqueados
                loc_cSQL = "SELECT a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps," + ;
                    " ISNULL(b.nStatus, 1) AS nStatus," + ;
                    " ISNULL(b.Grupos, '') AS Grupos," + ;
                    " ISNULL(b.Usuarios, '') AS Usuarios," + ;
                    " ISNULL(b.pkchaves, '') AS pkchaves" + ;
                    " FROM sigactel a" + ;
                    " LEFT JOIN sigactel b ON b.cCodigos = a.cCodigos" + ;
                    " AND b.cCampos = a.cCampos" + ;
                    " AND b.grupos = " + loc_cGrupoSQL + ;
                    " AND b.usuarios = ''" + ;
                    " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                    " ORDER BY a.cCodigos"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigAcTel")
            IF loc_nResult >= 0
                IF USED("crSigAcTel")
                    SELECT crSigAcTel
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar acesso telas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarUsuarios - Salva lista de usuarios do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorUsuarios: cursor com campo Usuarios char(10)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarUsuarios(par_cGrupos, par_cCursorUsuarios)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL, loc_cUsuario
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar usuarios existentes do grupo
            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcg")
            IF USED("cursor_4c_DelAcg")
                USE IN cursor_4c_DelAcg
            ENDIF

            *-- Reinserir usuarios selecionados
            IF USED(par_cCursorUsuarios) AND RECCOUNT(par_cCursorUsuarios) > 0
                SELECT (par_cCursorUsuarios)
                GO TOP
                SCAN
                    loc_cUsuario = ALLTRIM(Usuarios)
                    IF !EMPTY(loc_cUsuario)
                        loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cUsuario, 10)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcg")
                        IF USED("cursor_4c_InsAcg")
                            USE IN cursor_4c_InsAcg
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorUsuarios)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarProgramas - Salva acessos de programa do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorProgramas: cursor com campos Programas, Parametros, Marcas
    *   Marcas=1: programa liberado ao grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarProgramas(par_cGrupos, par_cCursorProgramas)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cProg, loc_cParam, loc_nMarcas
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar acessos de programa do grupo (somente nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcu")
            IF USED("cursor_4c_DelAcu")
                USE IN cursor_4c_DelAcu
            ENDIF

            *-- Reinserir programas selecionados (Marcas=1)
            IF USED(par_cCursorProgramas) AND RECCOUNT(par_cCursorProgramas) > 0
                SELECT (par_cCursorProgramas)
                GO TOP
                SCAN
                    loc_nMarcas = Marcas
                    loc_cProg   = ALLTRIM(Programas)
                    loc_cParam  = ALLTRIM(Parametros)
                    IF loc_nMarcas = 1 AND !EMPTY(loc_cProg)
                        loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", '', " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcu")
                        IF USED("cursor_4c_InsAcu")
                            USE IN cursor_4c_InsAcu
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorProgramas)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar programas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarBarra - Salva configuracao da barra de ferramentas do grupo
    * par_cGrupos: codigo do grupo
    * par_cCursorBarra: cursor TmpBarra com campos BarraOrdem, Descricaos,
    *   BarraForms, Programas, Parametros, SelBarras
    *   SelBarras=.T./1: item selecionado para o grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarBarra(par_cGrupos, par_cCursorBarra)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cDescricaos, loc_cBarraForms, loc_nBarraOrdem
        LOCAL loc_cProg, loc_cParam, loc_lSel
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar barra existente do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcb")
            IF USED("cursor_4c_DelAcb")
                USE IN cursor_4c_DelAcb
            ENDIF

            *-- Reinserir itens selecionados
            IF USED(par_cCursorBarra) AND RECCOUNT(par_cCursorBarra) > 0
                SELECT (par_cCursorBarra)
                GO TOP
                SCAN
                    loc_lSel        = SelBarras
                    loc_cDescricaos = ALLTRIM(Descricaos)
                    loc_cBarraForms = ALLTRIM(BarraForms)
                    loc_nBarraOrdem = BarraOrdem
                    loc_cProg       = ALLTRIM(Programas)
                    loc_cParam      = ALLTRIM(Parametros)
                    IF loc_lSel
                        loc_cSQL = "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", '', " + ;
                            EscaparSQL(LEFT(loc_cDescricaos, 73)) + ", " + ;
                            EscaparSQL(LEFT(loc_cBarraForms, 50)) + ", " + ;
                            FormatarNumeroSQL(loc_nBarraOrdem) + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", 1, " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcb")
                        IF USED("cursor_4c_InsAcb")
                            USE IN cursor_4c_InsAcb
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorBarra)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar barra:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessoTelas - Salva configuracao de acesso a campos nas telas
    * par_cGrupos: codigo do grupo
    * par_cCursorAcTel: cursor crSigAcTel com campos cCodigos, cDescTelas,
    *   cCampos, cObjetos, cDescCamps, nStatus
    *   nStatus=0: campo liberado (salva); nStatus=1: bloqueado (nao salva)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessoTelas(par_cGrupos, par_cCursorAcTel)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cCampos, loc_cCodigos, loc_cDescCamps, loc_cDescTelas
        LOCAL loc_cObjetos, loc_nStatus
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar registros existentes do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcTel")
            IF USED("cursor_4c_DelAcTel")
                USE IN cursor_4c_DelAcTel
            ENDIF

            *-- Reinserir apenas campos liberados (nStatus=0)
            IF USED(par_cCursorAcTel) AND RECCOUNT(par_cCursorAcTel) > 0
                SELECT (par_cCursorAcTel)
                GO TOP
                SCAN
                    loc_nStatus    = nStatus
                    loc_cCodigos   = ALLTRIM(cCodigos)
                    loc_cCampos    = ALLTRIM(cCampos)
                    loc_cDescCamps = ALLTRIM(cDescCamps)
                    loc_cDescTelas = ALLTRIM(cDescTelas)
                    loc_cObjetos   = ALLTRIM(cObjetos)
                    IF loc_nStatus <> 1
                        loc_cSQL = "INSERT INTO sigactel" + ;
                            " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                            " VALUES (" + ;
                            EscaparSQL(LEFT(loc_cCampos, 30)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCodigos, 10)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescCamps, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescTelas, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cObjetos, 100)) + ", " + ;
                            FormatarNumeroSQL(loc_nStatus) + ", " + ;
                            loc_cGrupoSQL + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcTel")
                        IF USED("cursor_4c_InsAcTel")
                            USE IN cursor_4c_InsAcTel
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorAcTel)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarAcessos - Copia todos os acessos de par_cGrupoOrigem para THIS.this_cGrupos
    * Usa INSERT ... SELECT direto no SQL Server para eficiencia
    *--------------------------------------------------------------------------
    PROCEDURE CopiarAcessos(par_cGrupoOrigem)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupoDest, loc_cGrupoOri
        loc_lResultado = .F.
        loc_cGrupoDest = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        loc_cGrupoOri  = EscaparSQL(LEFT(ALLTRIM(par_cGrupoOrigem), 10))
        TRY
            *-- Copiar usuarios: apenas os que o destino ainda nao tem
            loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.usuarios, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacg a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacg b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = a.usuarios)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcg")
            IF USED("cursor_4c_CpAcg")
                USE IN cursor_4c_CpAcg
            ENDIF

            *-- Copiar acessos de programa (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.programas, a.parametros, '', LEFT(NEWID(), 45)" + ;
                " FROM sigcdacu a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacu b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcu")
            IF USED("cursor_4c_CpAcu")
                USE IN cursor_4c_CpAcu
            ENDIF

            *-- Copiar barra de ferramentas (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacb" + ;
                " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", '', a.descricaos, a.barraforms, a.barraordem," + ;
                " a.programas, a.parametros, a.selbarras, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacb a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacb b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcb")
            IF USED("cursor_4c_CpAcb")
                USE IN cursor_4c_CpAcb
            ENDIF

            *-- Copiar acesso a telas (nivel grupo)
            loc_cSQL = "INSERT INTO sigactel" + ;
                " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                " SELECT a.ccampos, a.ccodigos, a.cdesccamps, a.cdesctelas, a.cobjetos," + ;
                " a.nstatus, " + loc_cGrupoDest + ", LEFT(NEWID(), 20), ''" + ;
                " FROM sigactel a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigactel b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.ccodigos = a.ccodigos AND b.ccampos = a.ccampos)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcTel")
            IF USED("cursor_4c_CpAcTel")
                USE IN cursor_4c_CpAcTel
            ENDIF

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao copiar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao copiar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo de grupo ja existe
    * Retorna .T. se ja existe (duplicado), .F. se disponivel
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            loc_cSQL = "SELECT Grupos FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dup") AND RECCOUNT("cursor_4c_Dup") > 0
                    loc_lDuplicado = .T.
                ENDIF
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

ENDDEFINE

