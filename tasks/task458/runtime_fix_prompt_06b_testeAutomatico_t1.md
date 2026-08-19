# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Property CARREGARLISTA is not found. | Detalhes: Linha: 350; Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-18 19:18:59] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-18 19:18:59] [INFO] Config FPW: (nao fornecido)
[2026-08-18 19:18:59] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-18 19:18:59] [INFO] Timeout: 300 segundos
[2026-08-18 19:18:59] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xx5zv35k.prg
[2026-08-18 19:18:59] [INFO] Conteudo do wrapper:
[2026-08-18 19:18:59] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormLGR', 'C:\4c\tasks\task458', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormLGR', 'C:\4c\tasks\task458', 'CRUD'
QUIT

[2026-08-18 19:18:59] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xx5zv35k.prg
[2026-08-18 19:18:59] [INFO] VFP output esperado em: C:\4c\tasks\task458\vfp_output.txt
[2026-08-18 19:18:59] [INFO] Executando Visual FoxPro 9...
[2026-08-18 19:18:59] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xx5zv35k.prg
[2026-08-18 19:18:59] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xx5zv35k.prg
[2026-08-18 19:18:59] [INFO] Timeout configurado: 300 segundos
[2026-08-18 19:20:09] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-18 19:20:09] [INFO] VFP9 finalizado em 70.193774 segundos
[2026-08-18 19:20:09] [INFO] Exit Code: 
[2026-08-18 19:20:09] [INFO] 
[2026-08-18 19:20:09] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-18 19:20:09] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xx5zv35k.prg
[2026-08-18 19:20:09] [INFO] 
[2026-08-18 19:20:09] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-18 19:20:09] [INFO] * Auto-generated wrapper for parameters
[2026-08-18 19:20:09] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-18 19:20:09] [INFO] * Parameters: 'FormLGR', 'C:\4c\tasks\task458', 'CRUD'
[2026-08-18 19:20:09] [INFO] 
[2026-08-18 19:20:09] [INFO] * Anti-dialog protections for unattended execution
[2026-08-18 19:20:09] [INFO] SET SAFETY OFF
[2026-08-18 19:20:09] [INFO] SET RESOURCE OFF
[2026-08-18 19:20:09] [INFO] SET TALK OFF
[2026-08-18 19:20:09] [INFO] SET NOTIFY OFF
[2026-08-18 19:20:09] [INFO] SYS(2335, 0)
[2026-08-18 19:20:09] [INFO] 
[2026-08-18 19:20:09] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormLGR', 'C:\4c\tasks\task458', 'CRUD'
[2026-08-18 19:20:09] [INFO] QUIT
[2026-08-18 19:20:09] [INFO] 
[2026-08-18 19:20:09] [INFO] === Fim do Wrapper.prg ===
[2026-08-18 19:20:09] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormLGR",
  "timestamp": "20260818192009",
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
      "erro": "Property CARREGARLISTA is not found.",
      "detalhes": "Linha: 350"
    },
    {
      "nome": "ModoIncluir",
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 429"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 559"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLGR.prg):
*==============================================================================
* FormLGR.prg - Formulario de Dados Gerenciais Fiscais
* Migrado de: SIGCDLGR.SCX (frmcadastro)
* Herda de: FormBase
* BO: LGRBO
* Tabela: SigFiGfd (JOIN SigFiMpm para marca do modelo)
*==============================================================================

DEFINE CLASS FormLGR AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Dados Gerenciais Fiscais"
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
    DataSession  = 2

    *-- Estado do formulario
    this_cModoAtual = "LISTA"

    *==========================================================================
    * Init - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, PageFrame e componentes da interface
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("LGRBO")

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
                IF !THIS.CarregarLista()
                    * Falha ao carregar nao impede a abertura do form
                ENDIF
            ENDIF

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"
            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormLGR:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame principal (Top=-29 para ocultar abas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(225, 225, 225)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(225, 225, 225)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
    * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza escuro com titulo (Top original=2, +29comp=31)
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

        *-- Container botoes CRUD (Grupo_Op canonico: Top=29, Left=542, Width=390)
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
        ENDWITH

        *-- Botoes CRUD dentro de cnt_4c_Botoes
        WITH loc_oPagina.cnt_4c_Botoes
            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
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
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
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
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 155
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
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 230
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
                .Visible         = .T.
            ENDWITH
            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 305
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
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container Encerrar (canonico: Left=917, Width=90, BackStyle=0)
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

        WITH loc_oPagina.cnt_4c_Saida
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
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
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container visual dos filtros (faixa de fundo, transparente)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 115
            .Left        = 0
            .Width       = 730
            .Height      = 70
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label Serie de Fabricacao (original Top=129, Left=36 -> +29=158)
        loc_oPagina.AddObject("lbl_4c_SerieFab", "Label")
        WITH loc_oPagina.lbl_4c_SerieFab
            .Caption   = "S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o :"
            .Top       = 158
            .Left      = 36
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Serie de Fabricacao (original Top=125 -> +29=154)
        loc_oPagina.AddObject("txt_4c_SerieFab", "TextBox")
        WITH loc_oPagina.txt_4c_SerieFab
            .Value     = ""
            .Top       = 154
            .Left      = 141
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .Visible   = .T.
        ENDWITH

        *-- Label Periodo (original Top=128 -> +29=157)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 158
            .Left      = 319
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Inicio (original Top=125 -> +29=154)
        loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
        WITH loc_oPagina.txt_4c_Dtini
            .Value   = DATE()
            .Top     = 154
            .Left    = 367
            .Width   = 80
            .Height  = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        *-- Label Ate (original Top=129 -> +29=158)
        loc_oPagina.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPagina.lbl_4c_Ate
            .Caption   = "At" + CHR(233)
            .Top       = 158
            .Left      = 455
            .Width     = 22
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Fim (original Top=125 -> +29=154)
        loc_oPagina.AddObject("txt_4c_Dtfim", "TextBox")
        WITH loc_oPagina.txt_4c_Dtfim
            .Value   = DATE()
            .Top     = 154
            .Left    = 483
            .Width   = 80
            .Height  = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        *-- Grid de lista (original Top=157 -> +29=186, Left=12)
        *-- Width=893 (form 1000 - left 12 - margem 5 = 983; deixa espaco para cnt_4c_Saida)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 186
            .Left              = 12
            .Width             = 893
            .Height            = 435
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .GridLines         = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 3
            .ReadOnly          = .T.
            .Visible           = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes CRUD (PUBLIC methods - sem PROTECTED)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        *-- BINDEVENTs dos campos de filtro
        BINDEVENT(loc_oPagina.txt_4c_SerieFab, "KeyPress", THIS, "ValidarSerieFab")
        BINDEVENT(loc_oPagina.txt_4c_Dtini,    "KeyPress", THIS, "ValidarDtini")
        BINDEVENT(loc_oPagina.txt_4c_Dtfim,    "KeyPress", THIS, "ValidarDtfim")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos de edicao e botoes salvar/cancelar
    * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (grupo_salva canonico)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.cnt_4c_Salva
            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
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
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Label NFAB (Say1: original top=151 -> +29=180, left=167)
        loc_oPagina.AddObject("lbl_4c_Nfab", "Label")
        WITH loc_oPagina.lbl_4c_Nfab
            .Caption   = "No Fabrica" + CHR(231) + CHR(227) + "o - NFAB. :"
            .Top       = 180
            .Left      = 167
            .Width     = 140
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo/NFAB (Get_codigo: original top=148 -> +29=177; When=.F. = readOnly)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 177
            .Left      = 312
            .Width     = 157
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .MaxLength = 40
            .Visible   = .T.
        ENDWITH

        *-- Label Modelo (Say16: original top=178 -> +29=207, left=253)
        loc_oPagina.AddObject("lbl_4c_Modelo", "Label")
        WITH loc_oPagina.lbl_4c_Modelo
            .Caption   = "Modelo :"
            .Top       = 207
            .Left      = 253
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Modelo (GetModelo: original top=175 -> +29=204, left=312, width=150)
        loc_oPagina.AddObject("txt_4c_Modelo", "TextBox")
        WITH loc_oPagina.txt_4c_Modelo
            .Value     = ""
            .Top       = 204
            .Left      = 312
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .Visible   = .T.
        ENDWITH

        *-- Label COO (Say2: original top=205 -> +29=234, left=266)
        loc_oPagina.AddObject("lbl_4c_Coo", "Label")
        WITH loc_oPagina.lbl_4c_Coo
            .Caption   = "COO :"
            .Top       = 234
            .Left      = 266
            .Width     = 40
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox COO (Getcoo: original top=202 -> +29=231, left=312, width=50)
        loc_oPagina.AddObject("txt_4c_Coo", "TextBox")
        WITH loc_oPagina.txt_4c_Coo
            .Value     = "000000"
            .Top       = 231
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH

        *-- Label Cupom nao Fiscal (Say3: original top=232 -> +29=261, left=192)
        loc_oPagina.AddObject("lbl_4c_Cnf", "Label")
        WITH loc_oPagina.lbl_4c_Cnf
            .Caption   = "Cupom n" + CHR(227) + "o Fiscal :"
            .Top       = 261
            .Left      = 192
            .Width     = 115
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cupom nao Fiscal (Getcnf: original top=229 -> +29=258, left=312, width=50)
        loc_oPagina.AddObject("txt_4c_Cnf", "TextBox")
        WITH loc_oPagina.txt_4c_Cnf
            .Value     = ""
            .Top       = 258
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH

        *-- Label Relatorios Gerenciais (Say4: original top=259 -> +29=288, left=171)
        loc_oPagina.AddObject("lbl_4c_Rg", "Label")
        WITH loc_oPagina.lbl_4c_Rg
            .Caption   = "Relat" + CHR(243) + "rios Gerenciais :"
            .Top       = 288
            .Left      = 171
            .Width     = 135
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Relatorios Gerenciais (Getrg: original top=256 -> +29=285, left=312, width=50)
        loc_oPagina.AddObject("txt_4c_Rg", "TextBox")
        WITH loc_oPagina.txt_4c_Rg
            .Value     = ""
            .Top       = 285
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH

        *-- Label Demonstrativo Credito/Debito (Say5: original top=286 -> +29=315, left=92)
        loc_oPagina.AddObject("lbl_4c_Dcd", "Label")
        WITH loc_oPagina.lbl_4c_Dcd
            .Caption   = "Demonstrativo de Cr" + CHR(233) + "dito e D" + CHR(233) + "bito :"
            .Top       = 315
            .Left      = 92
            .Width     = 215
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Demonstrativo (Getdcd: original top=283 -> +29=312, left=312, width=38)
        loc_oPagina.AddObject("txt_4c_Dcd", "TextBox")
        WITH loc_oPagina.txt_4c_Dcd
            .Value     = ""
            .Top       = 312
            .Left      = 312
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 4
            .Visible   = .T.
        ENDWITH

        *-- Label Reducao Z (Say6: original top=313 -> +29=342, left=231)
        loc_oPagina.AddObject("lbl_4c_Rz", "Label")
        WITH loc_oPagina.lbl_4c_Rz
            .Caption   = "Redu" + CHR(231) + CHR(227) + "o Z :"
            .Top       = 342
            .Left      = 231
            .Width     = 75
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Reducao Z (Getrz: original top=310 -> +29=339, left=312, width=50)
        loc_oPagina.AddObject("txt_4c_Rz", "TextBox")
        WITH loc_oPagina.txt_4c_Rz
            .Value     = ""
            .Top       = 339
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 6
            .Visible   = .T.
        ENDWITH

        *-- Label Tipo de Documento (Say7: original top=340 -> +29=369, left=181)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Caption   = "Tipo de Documento :"
            .Top       = 369
            .Left      = 181
            .Width     = 125
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Tipo de Documento (Gettipo: original top=337 -> +29=366, left=312, width=24)
        loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oPagina.txt_4c_Tipo
            .Value     = ""
            .Top       = 366
            .Left      = 312
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 2
            .Visible   = .T.
        ENDWITH

        *-- Label Data do Movimento (Say23: original top=367 -> +29=396, left=181)
        loc_oPagina.AddObject("lbl_4c_Dtmov", "Label")
        WITH loc_oPagina.lbl_4c_Dtmov
            .Caption   = "Data do Movimento :"
            .Top       = 396
            .Left      = 181
            .Width     = 125
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data do Movimento (Getdtmov: original top=364 -> +29=393; cdatas=YYYYMMDD string)
        loc_oPagina.AddObject("txt_4c_Dtmov", "TextBox")
        WITH loc_oPagina.txt_4c_Dtmov
            .Value   = DATE()
            .Top     = 393
            .Left    = 312
            .Width   = 80
            .Height  = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        *-- Label Hora do Movimento (Say24: original top=394 -> +29=423, left=181)
        loc_oPagina.AddObject("lbl_4c_Hrmov", "Label")
        WITH loc_oPagina.lbl_4c_Hrmov
            .Caption   = "Hora do Movimento :"
            .Top       = 423
            .Left      = 181
            .Width     = 125
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Hora do Movimento (Gethrmov: original top=391 -> +29=420; choras=HHMMSS string)
        loc_oPagina.AddObject("txt_4c_Hrmov", "TextBox")
        WITH loc_oPagina.txt_4c_Hrmov
            .Value     = ""
            .Top       = 420
            .Left      = 312
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 8
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs botoes Page2 (PUBLIC methods)
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- BINDEVENTs formatadores e lookups de campos Page2
        BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ValidarModelo")
        BINDEVENT(loc_oPagina.txt_4c_Coo,    "LostFocus", THIS, "FormatarCoo")
        BINDEVENT(loc_oPagina.txt_4c_Cnf,    "LostFocus", THIS, "FormatarCnf")
        BINDEVENT(loc_oPagina.txt_4c_Rg,     "LostFocus", THIS, "FormatarRg")
        BINDEVENT(loc_oPagina.txt_4c_Dcd,    "LostFocus", THIS, "FormatarDcd")
        BINDEVENT(loc_oPagina.txt_4c_Rz,     "LostFocus", THIS, "FormatarRz")
        BINDEVENT(loc_oPagina.txt_4c_Tipo,   "KeyPress", THIS, "ValidarTipo")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca registros via BO e configura o grid
    * Le filtros de Page1, chama Buscar(), monta colunas do grid
    *==========================================================================
    PROTECTED FUNCTION CarregarLista()
        LOCAL loc_lResultado, loc_oPg1, loc_oGrid
        LOCAL loc_cSerifab, loc_dDtini, loc_dDtfim
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1
                loc_oGrid = loc_oPg1.grd_4c_Lista

                *-- Ler filtros atuais
                loc_cSerifab = ""
                loc_dDtini   = {}
                loc_dDtfim   = {}

                IF PEMSTATUS(loc_oPg1, "txt_4c_SerieFab", 5)
                    loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Dtini", 5)
                    IF VARTYPE(loc_oPg1.txt_4c_Dtini.Value) = "D"
                        loc_dDtini = loc_oPg1.txt_4c_Dtini.Value
                    ENDIF
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Dtfim", 5)
                    IF VARTYPE(loc_oPg1.txt_4c_Dtfim.Value) = "D"
                        loc_dDtfim = loc_oPg1.txt_4c_Dtfim.Value
                    ENDIF
                ENDIF

                IF THIS.this_oBusinessObject.Buscar(loc_cSerifab, loc_dDtini, loc_dDtfim)
                    *-- RecordSource e ColumnCount FORA do WITH para garantir criacao das colunas
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 8

                    WITH loc_oGrid
                        .Column1.ControlSource    = "cursor_4c_Dados.cserifab"
                        .Column1.Width            = 120
                        .Column1.Header1.Caption  = "S" + CHR(233) + "rie"
                        .Column1.ReadOnly         = .T.

                        .Column2.ControlSource    = "cursor_4c_Dados.cmarcas"
                        .Column2.Width            = 120
                        .Column2.Header1.Caption  = "Marca"
                        .Column2.ReadOnly         = .T.

                        .Column3.ControlSource    = "cursor_4c_Dados.cmodelos"
                        .Column3.Width            = 100
                        .Column3.Header1.Caption  = "Modelo"
                        .Column3.ReadOnly         = .T.

                        .Column4.ControlSource    = "cursor_4c_Dados.ccoos"
                        .Column4.Width            = 60
                        .Column4.Header1.Caption  = "COO"
                        .Column4.ReadOnly         = .T.

                        .Column5.ControlSource    = "cursor_4c_Dados.cdatas"
                        .Column5.Width            = 80
                        .Column5.Header1.Caption  = "Data"
                        .Column5.ReadOnly         = .T.

                        .Column6.ControlSource    = "cursor_4c_Dados.choras"
                        .Column6.Width            = 60
                        .Column6.Header1.Caption  = "Hora"
                        .Column6.ReadOnly         = .T.

                        .Column7.ControlSource    = "cursor_4c_Dados.ctipos"
                        .Column7.Width            = 60
                        .Column7.Header1.Caption  = "Tipo"
                        .Column7.ReadOnly         = .T.

                        .Column8.ControlSource    = "cursor_4c_Dados.cincmans"
                        .Column8.Width            = 60
                        .Column8.Header1.Caption  = "Inc.Man."
                        .Column8.ReadOnly         = .T.
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormLGR.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Modelo.SetFocus
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChaves = ALLTRIM(cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    * Regra do legado: so permite alterar registros com cincmans='M' (manual)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cIdChaves, loc_cIncMans
        loc_cIdChaves = ""
        loc_cIncMans  = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChaves = ALLTRIM(cidchaves)
        loc_cIncMans  = ALLTRIM(cincmans)

        IF loc_cIncMans <> "M"
            MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
                     "do manualmente, n" + CHR(227) + "o pode ser Alterado.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado (somente inclusao manual)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cIdChaves, loc_cIncMans
        loc_cIdChaves = ""
        loc_cIncMans  = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChaves = ALLTRIM(cidchaves)
        loc_cIncMans  = ALLTRIM(cincmans)

        IF loc_cIncMans <> "M"
            MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
                     "do manualmente, n" + CHR(227) + "o pode ser Exclu" + CHR(237) + "do.", "Aviso")
            RETURN
        ENDIF

        IF MsgConfirma("Deseja excluir este registro?", "Confirma" + CHR(231) + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Executa busca com os filtros preenchidos em Page1
    * Valida que serie foi informada (conforme legado)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPg1, loc_cSerifab
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)

        IF EMPTY(loc_cSerifab)
            MsgAviso("Informe a S" + CHR(233) + "rie de Fabrica" + CHR(231) + ;
                     CHR(227) + "o e as datas para pesquisar.", "Aviso")
            loc_oPg1.txt_4c_SerieFab.SetFocus
            RETURN
        ENDIF

        IF EMPTY(loc_oPg1.txt_4c_Dtini.Value) OR EMPTY(loc_oPg1.txt_4c_Dtfim.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo de datas para pesquisar.", "Aviso")
            RETURN
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva registro (INSERT ou UPDATE via BO)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes de UI antes do TRY (nao usar RETURN dentro de TRY)
        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
            MsgAviso("Modelo n" + CHR(227) + "o pode estar em branco.", "Aviso")
            loc_oPg2.txt_4c_Modelo.SetFocus
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg1, loc_oPg2, loc_cHoras
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cModelos = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
            .this_cCoos    = ALLTRIM(loc_oPg2.txt_4c_Coo.Value)
            .this_cGnfs    = ALLTRIM(loc_oPg2.txt_4c_Cnf.Value)
            .this_cGrgs    = ALLTRIM(loc_oPg2.txt_4c_Rg.Value)
            .this_cCdcs    = ALLTRIM(loc_oPg2.txt_4c_Dcd.Value)
            .this_cCrzs    = ALLTRIM(loc_oPg2.txt_4c_Rz.Value)
            .this_cDoctos  = ALLTRIM(loc_oPg2.txt_4c_Tipo.Value)

            *-- Data: TextBox.Value eh Date -> converter para string YYYYMMDD
            IF VARTYPE(loc_oPg2.txt_4c_Dtmov.Value) = "D" AND !EMPTY(loc_oPg2.txt_4c_Dtmov.Value)
                .this_cDatas = DTOS(loc_oPg2.txt_4c_Dtmov.Value)
            ELSE
                .this_cDatas = ""
            ENDIF

            *-- Hora: string HH:MM:SS -> HHMMSS (strip colons)
            loc_cHoras   = STRTRAN(ALLTRIM(loc_oPg2.txt_4c_Hrmov.Value), ":", "")
            .this_cHoras = loc_cHoras

            *-- Inclusao manual flag
            IF THIS.this_cModoAtual = "INCLUIR"
                .this_cIncMans = "M"
                *-- Serie vem do filtro de Page1
                .this_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cDatas, loc_cHoras
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Codigo.Value = .this_cIdChaves
            loc_oPg2.txt_4c_Modelo.Value = .this_cModelos
            loc_oPg2.txt_4c_Coo.Value    = .this_cCoos
            loc_oPg2.txt_4c_Cnf.Value    = .this_cGnfs
            loc_oPg2.txt_4c_Rg.Value     = .this_cGrgs
            loc_oPg2.txt_4c_Dcd.Value    = .this_cCdcs
            loc_oPg2.txt_4c_Rz.Value     = .this_cCrzs
            loc_oPg2.txt_4c_Tipo.Value   = .this_cDoctos

            *-- Data: string YYYYMMDD -> Date (via STOD)
            loc_cDatas = ALLTRIM(.this_cDatas)
            IF LEN(loc_cDatas) = 8
                loc_oPg2.txt_4c_Dtmov.Value = STOD(loc_cDatas)
            ELSE
                loc_oPg2.txt_4c_Dtmov.Value = {}
            ENDIF

            *-- Hora: string HHMMSS -> HH:MM:SS
            loc_cHoras = ALLTRIM(.this_cHoras)
            IF LEN(loc_cHoras) = 6
                loc_oPg2.txt_4c_Hrmov.Value = LEFT(loc_cHoras, 2) + ":" + ;
                                               SUBSTR(loc_cHoras, 3, 2) + ":" + ;
                                               RIGHT(loc_cHoras, 2)
            ELSE
                loc_oPg2.txt_4c_Hrmov.Value = ""
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2 para edicao
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- txt_4c_Codigo (NFAB) sempre ReadOnly
        loc_oPg2.txt_4c_Modelo.ReadOnly = !par_lHabilitar
        loc_oPg2.txt_4c_Coo.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Cnf.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Rg.ReadOnly     = !par_lHabilitar
        loc_oPg2.txt_4c_Dcd.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Rz.ReadOnly     = !par_lHabilitar
        loc_oPg2.txt_4c_Tipo.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_Dtmov.ReadOnly  = !par_lHabilitar
        loc_oPg2.txt_4c_Hrmov.ReadOnly  = !par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value = ""
        loc_oPg2.txt_4c_Modelo.Value = ""
        loc_oPg2.txt_4c_Coo.Value    = "000000"
        loc_oPg2.txt_4c_Cnf.Value    = ""
        loc_oPg2.txt_4c_Rg.Value     = ""
        loc_oPg2.txt_4c_Dcd.Value    = ""
        loc_oPg2.txt_4c_Rz.Value     = ""
        loc_oPg2.txt_4c_Tipo.Value   = ""
        loc_oPg2.txt_4c_Dtmov.Value  = DATE()
        loc_oPg2.txt_4c_Hrmov.Value  = ""
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditar
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditar
        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *==========================================================================
    * ValidarSerieFab - LostFocus do campo serie em Page1
    * Valida serie contra SigFiMpf e abre picker se nao encontrar exato
    *==========================================================================
    PROCEDURE ValidarSerieFab(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1, loc_cSerifab, loc_oBusca
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)

        IF EMPTY(loc_cSerifab)
            RETURN
        ENDIF

        *-- Buscar serie exata em SigFiMpf
        IF THIS.this_oBusinessObject.BuscarImpressoras("a.cimpfabs = " + EscaparSQL(loc_cSerifab))
            IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 1
                SELECT cursor_4c_Impressoras
                loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(cimpfabs)
                USE IN cursor_4c_Impressoras
                RETURN
            ENDIF
            IF USED("cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF
        ENDIF

        *-- Nao encontrou exato: buscar por LIKE e exibir picker
        IF !THIS.this_oBusinessObject.BuscarImpressoras( ;
                "a.cimpfabs LIKE " + EscaparSQL(loc_cSerifab + "%"))
            THIS.this_oBusinessObject.BuscarImpressoras("")
        ELSE
            IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 0
                USE IN cursor_4c_Impressoras
                THIS.this_oBusinessObject.BuscarImpressoras("")
            ENDIF
        ENDIF

        IF USED("cursor_4c_Impressoras")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Impressoras"
                loc_oBusca.DefinirCursor("cursor_4c_Impressoras", "cimpfabs", "cmarcas", ;
                    "S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Mostrar()
                IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                    loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDtini - LostFocus da data inicio (valida tipo Date)
    *==========================================================================
    PROCEDURE ValidarDtini(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg1.txt_4c_Dtini.Value) <> "D"
            loc_oPg1.txt_4c_Dtini.Value = DATE()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDtfim - LostFocus da data fim (valida tipo Date)
    *==========================================================================
    PROCEDURE ValidarDtfim(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg1.txt_4c_Dtfim.Value) <> "D"
            loc_oPg1.txt_4c_Dtfim.Value = DATE()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarModelo - LostFocus do campo modelo em Page2
    * Busca em SigFiMpm e abre picker se nao encontrar exato
    *==========================================================================
    PROCEDURE ValidarModelo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cModelo, loc_oBusca
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cModelo = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)

        IF EMPTY(loc_cModelo) OR !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        *-- Buscar modelo exato em SigFiMpm
        IF THIS.this_oBusinessObject.BuscarModelos("cModelos = " + EscaparSQL(loc_cModelo))
            IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 1
                SELECT cursor_4c_Modelos
                loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cModelos)
                USE IN cursor_4c_Modelos
                RETURN
            ENDIF
            IF USED("cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF
        ENDIF

        *-- Nao encontrou: buscar por LIKE e exibir picker
        IF !THIS.this_oBusinessObject.BuscarModelos( ;
                "cModelos LIKE " + EscaparSQL(loc_cModelo + "%"))
            THIS.this_oBusinessObject.BuscarModelos("")
        ELSE
            IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 0
                USE IN cursor_4c_Modelos
                THIS.this_oBusinessObject.BuscarModelos("")
            ENDIF
        ENDIF

        IF USED("cursor_4c_Modelos")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Modelos"
                loc_oBusca.DefinirCursor("cursor_4c_Modelos", "cModelos", "cMarcas", "Modelos")
                loc_oBusca.Mostrar()
                IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                    loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarTipo - LostFocus do campo tipo de documento em Page2
    *==========================================================================
    PROCEDURE ValidarTipo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF LEN(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value)) > 2
            loc_oPg2.txt_4c_Tipo.Value = LEFT(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value), 2)
        ENDIF
    ENDPROC

    *==========================================================================
    * FormatarCoo - LostFocus do COO: formata como string numerica 6 digitos
    * Replica comportamento do legado: Transform(VAL(Value), '@L 999999')
    *==========================================================================
    PROCEDURE FormatarCoo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Coo
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarCnf - LostFocus do Cupom nao Fiscal: mesma formatacao
    *==========================================================================
    PROCEDURE FormatarCnf()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Cnf
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarRg - LostFocus do Relatorio Gerencial: mesma formatacao
    *==========================================================================
    PROCEDURE FormatarRg()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Rg
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarDcd - LostFocus do DCD: formata como string numerica 4 digitos
    *==========================================================================
    PROCEDURE FormatarDcd()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Dcd
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 9999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarRz - LostFocus da Reducao Z: formata como string numerica 6 digitos
    *==========================================================================
    PROCEDURE FormatarRz()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        WITH loc_oPg2.txt_4c_Rz
            IF !EMPTY(ALLTRIM(.Value))
                .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
                .Refresh()
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles do container visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata fonte do grid apos carregar dados
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) <> "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos do form
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\LGRBO.prg):
*==============================================================================
* LGRBO.prg - Business Object para Livro de Gerenciamento Fiscal (SigFiGfd)
* Herda de: BusinessBase
* Tabela: SigFiGfd
* PK: cidchaves (gerado via SYS(2015)+SYS(2015))
*==============================================================================

DEFINE CLASS LGRBO AS BusinessBase

    *-- Propriedades da classe
    this_cTabela      = "SigFiGfd"
    this_cCampoChave  = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades mapeadas da tabela SigFiGfd
    *--------------------------------------------------------------------------
    this_cIdChaves  = ""    && cidchaves char(20) - PK
    this_cSerifab   = ""    && cserifab  char(20) - Serie de Fabricacao (FK SigFiMpf)
    this_cModelos   = ""    && cmodelos  char(20) - Modelo (FK SigFiMpm)
    this_cCoos      = ""    && ccoos     char(6)  - COO
    this_cGnfs      = ""    && cgnfs     char(6)  - Cupom nao Fiscal
    this_cGrgs      = ""    && cgrgs     char(6)  - Relatorios Gerenciais
    this_cCdcs      = ""    && ccdcs     char(4)  - Demonstrativo Credito e Debito
    this_cCrzs      = ""    && ccrzs     char(6)  - Reducao Z
    this_cDoctos    = ""    && cdoctos   char(2)  - Tipo de Documento
    this_cDatas     = ""    && cdatas    char(8)  - Data YYYYMMDD (sem barras)
    this_cHoras     = ""    && choras    char(6)  - Hora HHMMSS
    this_cIncMans   = ""    && cincmans  char(1)  - Flag inclusao manual ('M')
    this_cTipos     = ""    && ctipos    char(3)  - Tipo (ex: 'E16')
    this_cMfs       = ""    && cmfs      char(1)  - Memoria Fiscal
    this_cUsuarios  = ""    && cusuarios char(2)  - Usuario
    this_cCancel    = ""    && ccancel   char(1)  - Flag cancelamento
    this_cDescons   = ""    && cdescons  char(13) - Desconto
    this_cDescrs    = ""    && cdescrs   char(100) - Descricao
    this_cFpagtos   = ""    && cfpagtos  char(14) - Forma de Pagamento
    this_cItems     = ""    && citems    char(4)  - Item
    this_cPros      = ""    && cpros     char(14) - Pro
    this_cQtds      = ""    && cqtds     char(7)  - Quantidade
    this_cTribs     = ""    && ctribs    char(7)  - Tributos
    this_cUnids     = ""    && cunids    char(3)  - Unidade
    this_cValors    = ""    && cvalors   char(14) - Valor
    this_cLocals    = ""    && locals    char(10) - Local
    this_cDocorigs  = ""    && cdocorigs char(10) - Documento de origem
    this_cConcatda  = ""    && concatda  text     - Concatenado
    this_lCopias    = .F.   && copias    bit      - Copias
    this_nNtrans    = 0     && ntrans    numeric(6,0) - Numero transacao
    this_dDatatrans = {}    && datatrans datetime - Data transacao auditoria

    *-- Propriedade auxiliar da juncao (SigFiMpm.cmarcas - apenas para exibicao no grid)
    this_cMarcas    = ""    && cmarcas (vem de SigFiMpm via JOIN)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiGfd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para o sistema de auditoria do BusinessBase
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com JOIN SigFiMpm para exibir marca
    * par_cFiltro: filtro WHERE adicional (sem a palavra WHERE)
    * par_cSerifab: serie de fabricacao para filtrar
    * par_dDtini: data inicio do periodo
    * par_dDtfim: data fim do periodo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cSerifab, par_dDtini, par_dDtfim)
        LOCAL loc_cSQL, loc_cSerifab, loc_cDtini, loc_cDtfim, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSerifab = IIF(VARTYPE(par_cSerifab) = "C", ALLTRIM(par_cSerifab), "")
            loc_cDtini   = IIF(VARTYPE(par_dDtini) = "D" AND !EMPTY(par_dDtini), ;
                               STRTRAN(DTOC(par_dDtini), "/", ""), "")
            loc_cDtfim   = IIF(VARTYPE(par_dDtfim) = "D" AND !EMPTY(par_dDtfim), ;
                               STRTRAN(DTOC(par_dDtfim), "/", ""), "")

            loc_cSQL = "SELECT b.cmarcas, a.cidchaves, a.cserifab, a.cmodelos," + ;
                       " a.ccoos, a.cgnfs, a.cgrgs, a.ccdcs, a.ccrzs, a.cdoctos," + ;
                       " a.cdatas, a.choras, a.cincmans, a.ctipos, a.cmfs," + ;
                       " a.cusuarios, a.ccancel, a.cdescons, a.cdescrs," + ;
                       " a.cfpagtos, a.citems, a.cpros, a.cqtds, a.ctribs," + ;
                       " a.cunids, a.cvalors, a.locals, a.ntrans, a.cdocorigs" + ;
                       " FROM SigFiGfd a" + ;
                       " INNER JOIN SigFiMpm b ON a.cmodelos = b.cModelos"

            IF !EMPTY(loc_cSerifab) OR !EMPTY(loc_cDtini) OR !EMPTY(loc_cDtfim)
                loc_cSQL = loc_cSQL + " WHERE"
                IF !EMPTY(loc_cSerifab)
                    loc_cSQL = loc_cSQL + " a.cserifab = " + EscaparSQL(loc_cSerifab)
                    IF !EMPTY(loc_cDtini) OR !EMPTY(loc_cDtfim)
                        loc_cSQL = loc_cSQL + " AND"
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cDtini) AND !EMPTY(loc_cDtfim)
                    loc_cSQL = loc_cSQL + " a.cdatas BETWEEN " + EscaparSQL(loc_cDtini) + ;
                               " AND " + EscaparSQL(loc_cDtfim)
                ELSE
                    IF !EMPTY(loc_cDtini)
                    loc_cSQL = loc_cSQL + " a.cdatas >= " + EscaparSQL(loc_cDtini)
                ELSE
                    IF !EMPTY(loc_cDtfim)
                    loc_cSQL = loc_cSQL + " a.cdatas <= " + EscaparSQL(loc_cDtfim)
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.cdatas, a.ccoos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Buscar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cIdChaves) <> "C" OR EMPTY(par_cIdChaves)
                MsgErro("Chave inv" + CHR(225) + "lida para carregamento.", "Erro")
            ELSE
                loc_cSQL = "SELECT b.cmarcas, a.*" + ;
                           " FROM SigFiGfd a" + ;
                           " INNER JOIN SigFiMpm b ON a.cmodelos = b.cModelos" + ;
                           " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Carrega")
                    TABLEREVERT(.T., "cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.CarregarPorCodigo: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cSerifab   = TratarNulo(cserifab,  "C")
            THIS.this_cModelos   = TratarNulo(cmodelos,  "C")
            THIS.this_cCoos      = TratarNulo(ccoos,     "C")
            THIS.this_cGnfs      = TratarNulo(cgnfs,     "C")
            THIS.this_cGrgs      = TratarNulo(cgrgs,     "C")
            THIS.this_cCdcs      = TratarNulo(ccdcs,     "C")
            THIS.this_cCrzs      = TratarNulo(ccrzs,     "C")
            THIS.this_cDoctos    = TratarNulo(cdoctos,   "C")
            THIS.this_cDatas     = TratarNulo(cdatas,    "C")
            THIS.this_cHoras     = TratarNulo(choras,    "C")
            THIS.this_cIncMans   = TratarNulo(cincmans,  "C")
            THIS.this_cTipos     = TratarNulo(ctipos,    "C")
            THIS.this_cMfs       = TratarNulo(cmfs,      "C")
            THIS.this_cUsuarios  = TratarNulo(cusuarios, "C")
            THIS.this_cCancel    = TratarNulo(ccancel,   "C")
            THIS.this_cDescons   = TratarNulo(cdescons,  "C")
            THIS.this_cDescrs    = TratarNulo(cdescrs,   "C")
            THIS.this_cFpagtos   = TratarNulo(cfpagtos,  "C")
            THIS.this_cItems     = TratarNulo(citems,    "C")
            THIS.this_cPros      = TratarNulo(cpros,     "C")
            THIS.this_cQtds      = TratarNulo(cqtds,     "C")
            THIS.this_cTribs     = TratarNulo(ctribs,    "C")
            THIS.this_cUnids     = TratarNulo(cunids,    "C")
            THIS.this_cValors    = TratarNulo(cvalors,   "C")
            THIS.this_cLocals    = TratarNulo(locals,    "C")
            THIS.this_nNtrans    = TratarNulo(ntrans,    "N")
            THIS.this_cDocorigs  = TratarNulo(cdocorigs, "C")
            THIS.this_lCopias    = (TratarNulo(copias,   "N") <> 0)
            IF TYPE("cmarcas") = "C"
                THIS.this_cMarcas = TratarNulo(cmarcas, "C")
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cNovaChave
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = SYS(2015) + SYS(2015)
            THIS.this_cIdChaves = loc_cNovaChave

            loc_cSQL = "INSERT INTO SigFiGfd" + ;
                       " (cidchaves, cserifab, cmodelos, ccoos, cgnfs, cgrgs," + ;
                       "  ccdcs, ccrzs, cdoctos, cdatas, choras, cincmans," + ;
                       "  ctipos, cmfs, cusuarios, ccancel, cdescons, cdescrs," + ;
                       "  cfpagtos, citems, cpros, cqtds, ctribs, cunids," + ;
                       "  cvalors, locals, ntrans, cdocorigs, copias)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)  + ", " + ;
                       EscaparSQL(THIS.this_cSerifab)   + ", " + ;
                       EscaparSQL(THIS.this_cModelos)   + ", " + ;
                       EscaparSQL(THIS.this_cCoos)      + ", " + ;
                       EscaparSQL(THIS.this_cGnfs)      + ", " + ;
                       EscaparSQL(THIS.this_cGrgs)      + ", " + ;
                       EscaparSQL(THIS.this_cCdcs)      + ", " + ;
                       EscaparSQL(THIS.this_cCrzs)      + ", " + ;
                       EscaparSQL(THIS.this_cDoctos)    + ", " + ;
                       EscaparSQL(THIS.this_cDatas)     + ", " + ;
                       EscaparSQL(THIS.this_cHoras)     + ", " + ;
                       EscaparSQL(THIS.this_cIncMans)   + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cMfs)       + ", " + ;
                       EscaparSQL(THIS.this_cUsuarios)  + ", " + ;
                       EscaparSQL(THIS.this_cCancel)    + ", " + ;
                       EscaparSQL(THIS.this_cDescons)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cFpagtos)   + ", " + ;
                       EscaparSQL(THIS.this_cItems)     + ", " + ;
                       EscaparSQL(THIS.this_cPros)      + ", " + ;
                       EscaparSQL(THIS.this_cQtds)      + ", " + ;
                       EscaparSQL(THIS.this_cTribs)     + ", " + ;
                       EscaparSQL(THIS.this_cUnids)     + ", " + ;
                       EscaparSQL(THIS.this_cValors)    + ", " + ;
                       EscaparSQL(THIS.this_cLocals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                       EscaparSQL(THIS.this_cDocorigs)  + ", " + ;
                       IIF(THIS.this_lCopias, "1", "0") + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Inserir: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiGfd SET" + ;
                       "  cserifab  = " + EscaparSQL(THIS.this_cSerifab)  + "," + ;
                       "  cmodelos  = " + EscaparSQL(THIS.this_cModelos)  + "," + ;
                       "  ccoos     = " + EscaparSQL(THIS.this_cCoos)     + "," + ;
                       "  cgnfs     = " + EscaparSQL(THIS.this_cGnfs)     + "," + ;
                       "  cgrgs     = " + EscaparSQL(THIS.this_cGrgs)     + "," + ;
                       "  ccdcs     = " + EscaparSQL(THIS.this_cCdcs)     + "," + ;
                       "  ccrzs     = " + EscaparSQL(THIS.this_cCrzs)     + "," + ;
                       "  cdoctos   = " + EscaparSQL(THIS.this_cDoctos)   + "," + ;
                       "  cdatas    = " + EscaparSQL(THIS.this_cDatas)    + "," + ;
                       "  choras    = " + EscaparSQL(THIS.this_cHoras)    + "," + ;
                       "  cincmans  = " + EscaparSQL(THIS.this_cIncMans)  + "," + ;
                       "  ctipos    = " + EscaparSQL(THIS.this_cTipos)    + "," + ;
                       "  cmfs      = " + EscaparSQL(THIS.this_cMfs)      + "," + ;
                       "  cusuarios = " + EscaparSQL(THIS.this_cUsuarios) + "," + ;
                       "  ccancel   = " + EscaparSQL(THIS.this_cCancel)   + "," + ;
                       "  cdescons  = " + EscaparSQL(THIS.this_cDescons)  + "," + ;
                       "  cdescrs   = " + EscaparSQL(THIS.this_cDescrs)   + "," + ;
                       "  cfpagtos  = " + EscaparSQL(THIS.this_cFpagtos)  + "," + ;
                       "  citems    = " + EscaparSQL(THIS.this_cItems)    + "," + ;
                       "  cpros     = " + EscaparSQL(THIS.this_cPros)     + "," + ;
                       "  cqtds     = " + EscaparSQL(THIS.this_cQtds)     + "," + ;
                       "  ctribs    = " + EscaparSQL(THIS.this_cTribs)    + "," + ;
                       "  cunids    = " + EscaparSQL(THIS.this_cUnids)    + "," + ;
                       "  cvalors   = " + EscaparSQL(THIS.this_cValors)   + "," + ;
                       "  locals    = " + EscaparSQL(THIS.this_cLocals)   + "," + ;
                       "  ntrans    = " + FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                       "  cdocorigs = " + EscaparSQL(THIS.this_cDocorigs) + "," + ;
                       "  copias    = " + IIF(THIS.this_lCopias, "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Atualizar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiGfd WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ExecutarExclusao: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarAntesDeSalvar - Validacoes de negocio antes do INSERT/UPDATE
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarAntesDeSalvar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cSerifab)
            MsgErro("S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o n" + ;
                    CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_cCoos = "000000"
            MsgErro("COO n" + CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cGnfs)
            MsgErro("Cupom n" + CHR(227) + "o Fiscal n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cGrgs)
            MsgErro("Relat" + CHR(243) + "rios Gerenciais n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCdcs)
            MsgErro("Demonstrativo D" + CHR(233) + "bito e Cr" + CHR(233) + "dito n" + ;
                    CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCrzs)
            MsgErro("Redu" + CHR(231) + CHR(227) + "o Z n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDoctos)
            MsgErro("Tipo de Documento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDatas)
            MsgErro("Data do Movimento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cHoras)
            MsgErro("Hora do Movimento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCOODuplicado - Verifica se COO ja existe para a serie (INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCOODuplicado(par_cSerifab, par_cCoos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT ccoos FROM SigFiGfd" + ;
                       " WHERE cserifab = " + EscaparSQL(ALLTRIM(par_cSerifab)) + ;
                       " AND ccoos = " + EscaparSQL(ALLTRIM(par_cCoos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_VerCoo")
                TABLEREVERT(.T., "cursor_4c_VerCoo")
                USE IN cursor_4c_VerCoo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerCoo")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VerCoo") > 0
                loc_lDuplicado = .T.
            ENDIF

            IF USED("cursor_4c_VerCoo")
                USE IN cursor_4c_VerCoo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.VerificarCOODuplicado: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterModeloDaSerie - Busca o modelo associado a uma serie de fabricacao
    * (faz query em SigFiMpf pois cserifab e criptografado)
    *--------------------------------------------------------------------------
    FUNCTION ObterModeloDaSerie(par_cSerifab)
        LOCAL loc_cSQL, loc_nResult, loc_cModelo
        loc_cModelo = ""

        TRY
            loc_cSQL = "SELECT cModelos FROM SigFiMpf WHERE cImpFabs = " + ;
                       EscaparSQL(ALLTRIM(par_cSerifab))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpFab")
                TABLEREVERT(.T., "cursor_4c_TmpFab")
                USE IN cursor_4c_TmpFab
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFab")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpFab") > 0
                SELECT cursor_4c_TmpFab
                loc_cModelo = ALLTRIM(cModelos)
            ENDIF

            IF USED("cursor_4c_TmpFab")
                USE IN cursor_4c_TmpFab
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterModeloDaSerie: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cModelo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMFAdis - Busca o cMFAdis do modelo (tabela SigFiMpm)
    *--------------------------------------------------------------------------
    FUNCTION ObterMFAdis(par_cModelos)
        LOCAL loc_cSQL, loc_nResult, loc_cMFAdis
        loc_cMFAdis = ""

        TRY
            loc_cSQL = "SELECT cMFAdis FROM SigFiMpm WHERE cModelos = " + ;
                       EscaparSQL(ALLTRIM(par_cModelos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpMpm")
                TABLEREVERT(.T., "cursor_4c_TmpMpm")
                USE IN cursor_4c_TmpMpm
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMpm")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpMpm") > 0
                SELECT cursor_4c_TmpMpm
                loc_cMFAdis = ALLTRIM(cMFAdis)
            ENDIF

            IF USED("cursor_4c_TmpMpm")
                USE IN cursor_4c_TmpMpm
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterMFAdis: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cMFAdis
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNumUsuars - Busca o cNumUsuars de uma serie (tabela SigFiMpf)
    *--------------------------------------------------------------------------
    FUNCTION ObterNumUsuars(par_cSerifabDecriptografada)
        LOCAL loc_cSQL, loc_nResult, loc_cNumUsuars
        loc_cNumUsuars = ""

        TRY
            loc_cSQL = "SELECT cNumUsuars FROM SigFiMpf WHERE cImpFabs = " + ;
                       EscaparSQL(ALLTRIM(par_cSerifabDecriptografada))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpMpf")
                TABLEREVERT(.T., "cursor_4c_TmpMpf")
                USE IN cursor_4c_TmpMpf
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMpf")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpMpf") > 0
                SELECT cursor_4c_TmpMpf
                loc_cNumUsuars = ALLTRIM(cNumUsuars)
            ENDIF

            IF USED("cursor_4c_TmpMpf")
                USE IN cursor_4c_TmpMpf
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterNumUsuars: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cNumUsuars
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarImpressoras - Busca lista de impressoras (SigFiMpf JOIN SigFiMpm)
    * Retorna cursor cursor_4c_Impressoras com campos: cimpfabs, cmarcas, cmodelos
    *--------------------------------------------------------------------------
    FUNCTION BuscarImpressoras(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT b.cmarcas, a.cmodelos, a.cimpfabs" + ;
                       " FROM SigFiMpf a" + ;
                       " INNER JOIN SigFiMpm b ON a.cmodelos = b.cmodelos"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Impressoras")
                TABLEREVERT(.T., "cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Impressoras")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar impressoras: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.BuscarImpressoras: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarModelos - Busca lista de modelos (SigFiMpm)
    * Retorna cursor cursor_4c_Modelos com campos: cModelos, cMarcas
    *--------------------------------------------------------------------------
    FUNCTION BuscarModelos(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cModelos, cMarcas FROM SigFiMpm"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Modelos")
                TABLEREVERT(.T., "cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Modelos")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar modelos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.BuscarModelos: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

