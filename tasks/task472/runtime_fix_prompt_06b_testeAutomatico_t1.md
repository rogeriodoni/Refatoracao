# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 56% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559; Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[21/08/2026 17:32:12] mtzBO.GerarProximoCodigo: Connection handle is invalid.
[21/08/2026 17:32:12] mtzBO.NovoRegistro: Impossível gerar código para nova matriz.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-21 17:30:52] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-21 17:30:52] [INFO] Config FPW: (nao fornecido)
[2026-08-21 17:30:52] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-21 17:30:52] [INFO] Timeout: 300 segundos
[2026-08-21 17:30:52] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_axl3ftqn.prg
[2026-08-21 17:30:52] [INFO] Conteudo do wrapper:
[2026-08-21 17:30:52] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formmtz', 'C:\4c\tasks\task472', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formmtz', 'C:\4c\tasks\task472', 'CRUD'
QUIT

[2026-08-21 17:30:52] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_axl3ftqn.prg
[2026-08-21 17:30:52] [INFO] VFP output esperado em: C:\4c\tasks\task472\vfp_output.txt
[2026-08-21 17:30:52] [INFO] Executando Visual FoxPro 9...
[2026-08-21 17:30:52] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_axl3ftqn.prg
[2026-08-21 17:30:52] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_axl3ftqn.prg
[2026-08-21 17:30:52] [INFO] Timeout configurado: 300 segundos
[2026-08-21 17:32:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-21 17:32:12] [INFO] VFP9 finalizado em 79.9253645 segundos
[2026-08-21 17:32:12] [INFO] Exit Code: 
[2026-08-21 17:32:12] [INFO] 
[2026-08-21 17:32:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-21 17:32:12] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_axl3ftqn.prg
[2026-08-21 17:32:12] [INFO] 
[2026-08-21 17:32:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-21 17:32:12] [INFO] * Auto-generated wrapper for parameters
[2026-08-21 17:32:12] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-21 17:32:12] [INFO] * Parameters: 'Formmtz', 'C:\4c\tasks\task472', 'CRUD'
[2026-08-21 17:32:12] [INFO] 
[2026-08-21 17:32:12] [INFO] * Anti-dialog protections for unattended execution
[2026-08-21 17:32:12] [INFO] SET SAFETY OFF
[2026-08-21 17:32:12] [INFO] SET RESOURCE OFF
[2026-08-21 17:32:12] [INFO] SET TALK OFF
[2026-08-21 17:32:12] [INFO] SET NOTIFY OFF
[2026-08-21 17:32:12] [INFO] SYS(2335, 0)
[2026-08-21 17:32:12] [INFO] 
[2026-08-21 17:32:12] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formmtz', 'C:\4c\tasks\task472', 'CRUD'
[2026-08-21 17:32:12] [INFO] QUIT
[2026-08-21 17:32:12] [INFO] 
[2026-08-21 17:32:12] [INFO] === Fim do Wrapper.prg ===
[2026-08-21 17:32:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formmtz",
  "timestamp": "20260821173212",
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
      "passou": false,
      "erro": "BtnIncluirClick nao navegou para Page2 (ActivePage=1)",
      "detalhes": ""
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
    "passou": 5,
    "falhou": 4,
    "percentual": 56
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formmtz.prg):
*******************************************************************************
* Formmtz.prg - Cadastro: Matriz de Saldos por Centro de Custo
* Legado  : SIGCDMTZ.SCX / frmcadastro
* Tabelas : SigCdMtz (cabecalho) + SigCdMtI (linhas mensais)
* Herda de: FormBase
*******************************************************************************

DEFINE CLASS Formmtz AS FormBase

    *-- =========================================================================
    *-- PROPRIEDADES VISUAIS (PILAR 1 - UX fidelity)
    *-- =========================================================================
    Height      = 600
    Width       = 1105
    Caption     = "Matriz de Saldos por Centro de Custo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    MinButton   = .F.
    MaxButton   = .F.

    *-- =========================================================================
    *-- PROPRIEDADES DO FORM
    *-- =========================================================================
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- =========================================================================
    *-- INIT - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
    *-- =========================================================================

    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- INICIALIZAR FORM - Chamado pelo FormBase.Init()
    *-- =========================================================================

    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Instancia o Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("mtzBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao instanciar mtzBO", "Formmtz.InicializarForm")
                loc_lResultado = .F.
            ENDIF

            *-- Configura estrutura de paginas
            THIS.ConfigurarPageFrame()
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Carrega lista inicial (pula se validando UI)
            IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
                THIS.CarregarLista()
            ENDIF

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- CONFIGURAR PAGE FRAME - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *-- =========================================================================

    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Cria PageFrame principal
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.

            *-- Imagens de fundo nas duas paginas
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page1.Caption = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        *-- Configura cada pagina
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *-- =========================================================================
    *-- CONFIGURAR PAGINA LISTA (Page1) - Cabecalho + Botoes CRUD + area grid
    *-- =========================================================================

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *--------------------------------------------------------------------------
        *-- Container cabecalho (fundo escuro com titulo)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 2
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Matriz de Saldos por Centro de Custo"
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Matriz de Saldos por Centro de Custo"
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Container botoes CRUD (lado direito)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 0
            .Left        = 542
            .Width       = 475
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Visualizar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Alterar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Excluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Buscar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Container Saida (canonico: Left=917, Width=90)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Grid lista de matrizes - cursor_4c_Dados (7 colunas)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 7

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 88
            .Left               = 5
            .Width              = 905
            .Height             = 480
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
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Header1.Caption = ""
            .Column1.Width           = 50
            .Column2.Header1.Caption = ""
            .Column2.Width           = 50
            .Column3.Header1.Caption = "Grupo"
            .Column3.Width           = 80
            .Column4.Header1.Caption = "Conta"
            .Column4.Width           = 80
            .Column5.Header1.Caption = ""
            .Column5.Width           = 440
            .Column6.Header1.Caption = ""
            .Column6.Width           = 60
            .Column7.Header1.Caption = "Valida"
            .Column7.Width           = 55
        ENDWITH

        *-- Vincular eventos da Page1
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *-- =========================================================================
    *-- CONFIGURAR PAGINA DADOS (Page2) - Cabecalho fields + Grid mensal + Botoes Salvar/Cancelar
    *-- =========================================================================

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *--------------------------------------------------------------------------
        *-- Container botoes Salvar/Cancelar (lado direito topo)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Label "Codigo :" + TextBox Codigo (getCodigo)
        *-- Original: lbl_grupo.Top=43,Left=334 / getCodigo.Top=39,Left=382
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_grupo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 72
            .Left      = 334
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .MaxLength = 10
            .Top       = 68
            .Left      = 382
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- CheckBox "Inativa" (Check1)
        *-- Original: Top=43, Left=440
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("chk_4c_Inativa", "CheckBox")
        WITH loc_oPagina.chk_4c_Inativa
            .Caption   = "Inativa"
            .Value     = 0
            .Top       = 72
            .Left      = 440
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Label "Moeda :" + TextBox Moeda (getMoeda)
        *-- Original: Say2.Top=43,Left=718 / getMoeda.Top=39,Left=764
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Moeda :"
            .Top       = 72
            .Left      = 718
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Moeda
            .Value     = ""
            .MaxLength = 3
            .Top       = 68
            .Left      = 764
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Label "Ano Competencia :" + TextBox Ano (getAno)
        *-- Original: lbl_Ano.Top=70,Left=283 / getAno.Top=66,Left=382
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_Ano", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_Ano
            .Caption   = "Ano Compet" + CHR(234) + "ncia :"
            .Top       = 99
            .Left      = 283
            .Width     = 93
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
        WITH loc_oPagina.txt_4c_Ano
            .Value     = ""
            .MaxLength = 4
            .Top       = 95
            .Left      = 382
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Label "Valor Acumulado :" + TextBox ValorTotal (readonly/calculado)
        *-- Original: Say1.Top=70,Left=671 / getValorTotal.Top=66,Left=764
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Valor Acumulado :"
            .Top       = 99
            .Left      = 671
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ValorTotal", "TextBox")
        WITH loc_oPagina.txt_4c_ValorTotal
            .Value     = 0
            .Top       = 95
            .Left      = 764
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- "Centro de Custo :" + Grupo + "/" + Conta + Desc + Class3
        *-- Original: lblCentroCusto.Top=97,Left=288 / Get_sgrupo.Top=93,Left=382
        *--   Say14("/").Top=97,Left=466 / Get_sconta.Top=93,Left=473
        *--   Get_sdconta.Top=93,Left=554,Width=290 / Get_class3.Top=93,Left=845
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblCentroCusto", "Label")
        WITH loc_oPagina.lbl_4c_LblCentroCusto
            .Caption   = "Centro de Custo :"
            .Top       = 126
            .Left      = 288
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Sgrupo", "TextBox")
        WITH loc_oPagina.txt_4c_Sgrupo
            .Value     = ""
            .MaxLength = 10
            .Top       = 122
            .Left      = 382
            .Width     = 82
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "/"
            .Top       = 126
            .Left      = 466
            .Width     = 10
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Sconta", "TextBox")
        WITH loc_oPagina.txt_4c_Sconta
            .Value     = ""
            .MaxLength = 20
            .Top       = 122
            .Left      = 473
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Sdconta", "TextBox")
        WITH loc_oPagina.txt_4c_Sdconta
            .Value     = ""
            .Top       = 122
            .Left      = 554
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Class3", "TextBox")
        WITH loc_oPagina.txt_4c_Class3
            .Value     = ""
            .MaxLength = 3
            .Top       = 122
            .Left      = 845
            .Width     = 27
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- getSaldo - exibe total saldo do registro (readonly, acima do grid)
        *-- Original: getSaldo.Top=109, Left=11, Width=100, Height=17
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Saldo", "TextBox")
        WITH loc_oPagina.txt_4c_Saldo
            .Value     = 0
            .Top       = 138
            .Left      = 11
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Grade grd_4c_Dados (grdSaldos) - 28 colunas
        *-- Original: grdSaldos.Top=129, Left=11, Width=1045, Height=419
        *--------------------------------------------------------------------------
        LOCAL loc_oGrid
        loc_oGrid = .NULL.

        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top         = 158     && 129+29
            .Left        = 11
            .Width       = 1045
            .Height      = 419
            .ColumnCount = 28
            .ReadOnly    = .T.     && HabilitarCampos gerencia
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Visible     = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        loc_oGrid = loc_oPagina.grd_4c_Dados

        *-- Coluna 1 - Grupos
        WITH loc_oGrid.Column1
            .Header1.Caption = "Grupo"
            .Width           = 65
        ENDWITH

        *-- Coluna 2 - Contas
        WITH loc_oGrid.Column2
            .Header1.Caption = "Conta"
            .Width           = 65
        ENDWITH

        *-- Coluna 3 - Janeiro
        WITH loc_oGrid.Column3
            .Header1.Caption = "Janeiro"
            .Width           = 70
        ENDWITH

        *-- Coluna 4 - Fevereiro
        WITH loc_oGrid.Column4
            .Header1.Caption = "Fevereiro"
            .Width           = 70
        ENDWITH

        *-- Coluna 5 - Marco
        WITH loc_oGrid.Column5
            .Header1.Caption = "Mar" + CHR(231) + "o"
            .Width           = 70
        ENDWITH

        *-- Coluna 6 - Abril
        WITH loc_oGrid.Column6
            .Header1.Caption = "Abril"
            .Width           = 70
        ENDWITH

        *-- Coluna 7 - Maio
        WITH loc_oGrid.Column7
            .Header1.Caption = "Maio"
            .Width           = 70
        ENDWITH

        *-- Coluna 8 - Junho
        WITH loc_oGrid.Column8
            .Header1.Caption = "Junho"
            .Width           = 70
        ENDWITH

        *-- Coluna 9 - Julho
        WITH loc_oGrid.Column9
            .Header1.Caption = "Julho"
            .Width           = 70
        ENDWITH

        *-- Coluna 10 - Agosto
        WITH loc_oGrid.Column10
            .Header1.Caption = "Agosto"
            .Width           = 70
        ENDWITH

        *-- Coluna 11 - Setembro
        WITH loc_oGrid.Column11
            .Header1.Caption = "Setembro"
            .Width           = 70
        ENDWITH

        *-- Coluna 12 - Outubro
        WITH loc_oGrid.Column12
            .Header1.Caption = "Outubro"
            .Width           = 70
        ENDWITH

        *-- Coluna 13 - Novembro
        WITH loc_oGrid.Column13
            .Header1.Caption = "Novembro"
            .Width           = 70
        ENDWITH

        *-- Coluna 14 - Dezembro
        WITH loc_oGrid.Column14
            .Header1.Caption = "Dezembro"
            .Width           = 70
        ENDWITH

        *-- Coluna 15 - Total (calculado, readonly)
        WITH loc_oGrid.Column15
            .Header1.Caption = "Total"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        *-- Colunas 16-27: Acumulados mensais (readonly)
        WITH loc_oGrid.Column16
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column17
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column18
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column19
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column20
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column21
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column22
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column23
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column24
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column25
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column26
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column27
            .Header1.Caption = ""
            .Width           = 75
            .ReadOnly        = .T.
        ENDWITH

        *-- Coluna 28 - Valida (CheckBox)
        WITH loc_oGrid.Column28
            .Header1.Caption = "Valida"
            .Width           = 45
            .Sparse          = .F.
        ENDWITH

        loc_oGrid.Column28.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oGrid.Column28.chk_4c_Check1
            .Caption   = ""
            .Alignment = 0
            .ReadOnly  = .F.
            .Visible   = .T.
            .Top       = 25
            .Left      = 31
            .Height    = 17
            .Width     = 22
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Container botoes Inserir/Excluir linha (cmdInsFtc)
        *-- Original: cmdInsFtc.Top=253, Left=1055, Width=50, Height=90
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_InsFtc", "Container")
        WITH loc_oPagina.cnt_4c_InsFtc
            .Top         = 282     && 253+29
            .Left        = 1055
            .Width       = 45
            .Height      = 90
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_InsFtc.AddObject("cmd_4c_InserirLinha", "CommandButton")
        WITH loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha
            .Caption       = "+"
            .Top           = 5
            .Left          = 2
            .Width         = 40
            .Height        = 36
            .FontName      = "Tahoma"
            .FontSize      = 12
            .FontBold      = .T.
            .ForeColor     = RGB(0, 128, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_InsFtc.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
        WITH loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha
            .Caption       = "-"
            .Top           = 49
            .Left          = 2
            .Width         = 40
            .Height        = 36
            .FontName      = "Tahoma"
            .FontSize      = 14
            .FontBold      = .T.
            .ForeColor     = RGB(192, 0, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Shape separador (Shape3)
        *-- Original: Shape3.Top=569, Left=5, Width=504, Height=2
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top         = 598     && 569+29
            .Left        = 5
            .Width       = 504
            .Height      = 2
            .BackStyle   = 1
            .BackColor   = RGB(128, 128, 128)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Campos de Auditoria (readonly)
        *-- Original: Say20.Top=553, Say24/Say25.Top=578, Get_DtIncs/etc.Top=574
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPagina.lbl_4c_Label20
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 582     && 553+29
            .Left      = 11
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPagina.lbl_4c_Label24
            .Caption   = "Inclus" + CHR(227) + "o :"
            .Top       = 607     && 578+29
            .Left      = 10
            .Width     = 49
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPagina.txt_4c_DtIncs
            .Value     = {}
            .Top       = 603     && 574+29
            .Left      = 67
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPagina.txt_4c_Usuario
            .Value     = ""
            .MaxLength = 20
            .Top       = 603     && 574+29
            .Left      = 148
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Caption   = "Altera" + CHR(231) + CHR(227) + "o :"
            .Top       = 607     && 578+29
            .Left      = 251
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DataAlts", "TextBox")
        WITH loc_oPagina.txt_4c_DataAlts
            .Value     = {}
            .Top       = 603     && 574+29
            .Left      = 319
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH loc_oPagina.txt_4c_UsuaAlts
            .Value     = ""
            .MaxLength = 20
            .Top       = 603     && 574+29
            .Left      = 400
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Vincular eventos Page2 (botoes Salvar/Cancelar)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Vincular validacao/lookup campos header
        BINDEVENT(loc_oPagina.txt_4c_Ano,    "KeyPress", THIS, "ValidarAnoMtz")
        BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress", THIS, "ValidarGrupoMtz")
        BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress", THIS, "ValidarContaMtz")
        BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress", THIS, "ValidarMoedaMtz")
        BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress",  THIS, "TeclaF4Sgrupo")
        BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress",  THIS, "TeclaF4Sconta")
        BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress",  THIS, "TeclaF4Moeda")

        *-- Vincular eventos da grade e botoes de linha
        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha, "Click", THIS, "BtnInserirLinhaClick")
        BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *-- =========================================================================
    *-- CARREGAR LISTA - Carrega cursor_4c_Dados no Grid da Page1
    *-- =========================================================================

    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 7
                loc_oGrid.RecordSource            = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
                loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
                loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
                loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
                loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
                loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
                loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ALTERNAR PAGINA - Navega entre Page1 (1=Lista) e Page2 (2=Dados)
    *-- =========================================================================

    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) # "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- FORM PARA BO - Transfere dados do Form para o BO
    *-- =========================================================================

    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            THIS.this_oBusinessObject.this_cCodigo   = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
            THIS.this_oBusinessObject.this_cAno      = ALLTRIM(loc_oPagina.txt_4c_Ano.Value)
            THIS.this_oBusinessObject.this_cSGrupos  = ALLTRIM(loc_oPagina.txt_4c_Sgrupo.Value)
            THIS.this_oBusinessObject.this_cSContas  = ALLTRIM(loc_oPagina.txt_4c_Sconta.Value)
            THIS.this_oBusinessObject.this_cMoeda    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
            THIS.this_oBusinessObject.this_lInativas = (loc_oPagina.chk_4c_Inativa.Value = 1)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BO PARA FORM - Transfere dados do BO para o Form
    *-- =========================================================================

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            loc_oPagina.txt_4c_Codigo.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
            loc_oPagina.txt_4c_Ano.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cAno)
            loc_oPagina.txt_4c_Sgrupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cSGrupos)
            loc_oPagina.txt_4c_Sconta.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cSContas)
            loc_oPagina.txt_4c_Sdconta.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cSDesconta)
            loc_oPagina.txt_4c_Moeda.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
            loc_oPagina.chk_4c_Inativa.Value    = THIS.this_oBusinessObject.this_lInativas
            loc_oPagina.txt_4c_ValorTotal.Value = THIS.this_oBusinessObject.this_nValorTotal

            *-- Datas auditoria (readonly)
            IF !EMPTY(THIS.this_oBusinessObject.this_tDtIncs)
                loc_oPagina.txt_4c_DtIncs.Value  = THIS.this_oBusinessObject.this_tDtIncs
            ENDIF
            IF !EMPTY(THIS.this_oBusinessObject.this_cUsuIncs)
                loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuIncs)
            ENDIF
            IF !EMPTY(THIS.this_oBusinessObject.this_tDtAlts)
                loc_oPagina.txt_4c_DataAlts.Value = THIS.this_oBusinessObject.this_tDtAlts
            ENDIF
            IF !EMPTY(THIS.this_oBusinessObject.this_cUsuAlts)
                loc_oPagina.txt_4c_UsuaAlts.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuAlts)
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- LIMPAR CAMPOS - Zera todos os campos da Page2
    *-- =========================================================================

    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            loc_oPagina.txt_4c_Codigo.Value     = ""
            loc_oPagina.txt_4c_Ano.Value         = ""
            loc_oPagina.txt_4c_Sgrupo.Value      = ""
            loc_oPagina.txt_4c_Sconta.Value      = ""
            loc_oPagina.txt_4c_Sdconta.Value     = ""
            loc_oPagina.txt_4c_Moeda.Value       = ""
            loc_oPagina.txt_4c_ValorTotal.Value  = 0
            loc_oPagina.chk_4c_Inativa.Value      = 0
            loc_oPagina.txt_4c_DtIncs.Value      = {}
            loc_oPagina.txt_4c_Usuario.Value     = ""
            loc_oPagina.txt_4c_DataAlts.Value    = {}
            loc_oPagina.txt_4c_UsuaAlts.Value    = ""

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.LimparCampos")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- HABILITAR CAMPOS - Habilita/desabilita campos editaveis por modo
    *-- =========================================================================

    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEdicao

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_lEdicao = par_lHabilitar AND THIS.this_cModoAtual # "VISUALIZAR"

            *-- Codigo: editavel apenas no INCLUIR
            loc_oPagina.txt_4c_Codigo.Enabled  = (THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Codigo.ReadOnly = (THIS.this_cModoAtual # "INCLUIR")

            *-- Campos editaveis em INCLUIR e ALTERAR
            loc_oPagina.txt_4c_Ano.Enabled      = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Ano.ReadOnly     = !(THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Sgrupo.Enabled   = loc_lEdicao
            loc_oPagina.txt_4c_Sgrupo.ReadOnly  = !loc_lEdicao
            loc_oPagina.txt_4c_Sconta.Enabled   = loc_lEdicao
            loc_oPagina.txt_4c_Sconta.ReadOnly  = !loc_lEdicao
            loc_oPagina.txt_4c_Moeda.Enabled    = loc_lEdicao
            loc_oPagina.txt_4c_Moeda.ReadOnly   = !loc_lEdicao
            loc_oPagina.chk_4c_Inativa.Enabled   = loc_lEdicao

            *-- Grade de saldos: editavel em INCLUIR e ALTERAR
            IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
                loc_oPagina.grd_4c_Dados.ReadOnly = !loc_lEdicao
            ENDIF

            *-- Botoes Confirmar/Cancelar
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar

            *-- Campos readonly sempre
            loc_oPagina.txt_4c_Sdconta.ReadOnly    = .T.
            loc_oPagina.txt_4c_ValorTotal.ReadOnly = .T.
            loc_oPagina.txt_4c_DtIncs.ReadOnly     = .T.
            loc_oPagina.txt_4c_Usuario.ReadOnly     = .T.
            loc_oPagina.txt_4c_DataAlts.ReadOnly   = .T.
            loc_oPagina.txt_4c_UsuaAlts.ReadOnly   = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.HabilitarCampos")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- AJUSTAR BOTOES POR MODO
    *-- =========================================================================

    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            IF THIS.this_cModoAtual = "VISUALIZAR"
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ELSE
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- BTN INCLUIR CLICK
    *-- =========================================================================

    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.NovoRegistro()
                loc_lResultado = .F.
            ELSE
                THIS.LimparCampos()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.this_oBusinessObject.CriarCursorDetalheVazio(THIS.this_oBusinessObject.this_cCodigo)
                THIS.AlternarGradeDetalhe()
                THIS.AlternarPaginaDados()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN VISUALIZAR CLICK
    *-- =========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
                THIS.AlternarGradeDetalhe()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPaginaDados()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN ALTERAR CLICK
    *-- =========================================================================

    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
                THIS.AlternarGradeDetalhe()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPaginaDados()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN EXCLUIR CLICK
    *-- =========================================================================

    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Matriz " + loc_cCodigo + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN BUSCAR CLICK
    *-- =========================================================================

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMtz", "cursor_4c_BuscaMtz", "Codigo", "", ;
                "Buscar Matriz de Saldos")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigo", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Ano",    "", "Ano")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
                    SELECT cursor_4c_BuscaMtz
                    IF !EOF()
                        LOCAL loc_oGrid
                        THIS.this_oBusinessObject.Buscar( ;
                            "a.Codigo = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMtz.Codigo)))
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        IF VARTYPE(loc_oGrid) = "O"
                            loc_oGrid.ColumnCount = 7
                            loc_oGrid.RecordSource            = "cursor_4c_Dados"
                            loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
                            loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
                            loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
                            loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
                            loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
                            loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
                            loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
                            THIS.FormatarGridLista(loc_oGrid)
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaMtz")
            USE IN cursor_4c_BuscaMtz
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN ENCERRAR CLICK
    *-- =========================================================================

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *-- =========================================================================
    *-- BTN SALVAR CLICK
    *-- =========================================================================

    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (CLAUDE.md regra #1)
        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value))
            MsgAviso("Ano de Compet" + CHR(234) + "ncia " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value))
            MsgAviso("Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarDuplicatas()
            RETURN .F.
        ENDIF

        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso.")
                    THIS.AlternarPagina(1)
                    THIS.this_cModoAtual = "LISTA"
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN CANCELAR CLICK
    *-- =========================================================================

    PROCEDURE BtnCancelarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnCancelarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ALTERNAR PAGINA DADOS - Navega para Page2 sem recarregar lista
    *-- =========================================================================

    PROTECTED PROCEDURE AlternarPaginaDados()
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *-- =========================================================================
    *-- ALTERNAR GRADE DETALHE - Vincula cursor_4c_MtI ao grid da Page2
    *-- (sera completado na Fase 4 quando o grid for criado)
    *-- =========================================================================

    PROTECTED PROCEDURE AlternarGradeDetalhe()
        LOCAL loc_oGrid, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
            IF VARTYPE(loc_oGrid) = "O" AND USED("cursor_4c_MtI")
                loc_oGrid.ColumnCount = 28
                loc_oGrid.RecordSource = "cursor_4c_MtI"

                *-- Wires ControlSources apos RecordSource estar definido
                loc_oGrid.Column1.ControlSource  = "cursor_4c_MtI.Grupos"
                loc_oGrid.Column2.ControlSource  = "cursor_4c_MtI.Contas"
                loc_oGrid.Column3.ControlSource  = "cursor_4c_MtI.Val_Jan"
                loc_oGrid.Column4.ControlSource  = "cursor_4c_MtI.Val_Fev"
                loc_oGrid.Column5.ControlSource  = "cursor_4c_MtI.Val_Mar"
                loc_oGrid.Column6.ControlSource  = "cursor_4c_MtI.Val_Abr"
                loc_oGrid.Column7.ControlSource  = "cursor_4c_MtI.Val_Mai"
                loc_oGrid.Column8.ControlSource  = "cursor_4c_MtI.Val_Jun"
                loc_oGrid.Column9.ControlSource  = "cursor_4c_MtI.Val_Jul"
                loc_oGrid.Column10.ControlSource = "cursor_4c_MtI.Val_Ago"
                loc_oGrid.Column11.ControlSource = "cursor_4c_MtI.Val_Set"
                loc_oGrid.Column12.ControlSource = "cursor_4c_MtI.Val_Out"
                loc_oGrid.Column13.ControlSource = "cursor_4c_MtI.Val_Nov"
                loc_oGrid.Column14.ControlSource = "cursor_4c_MtI.Val_Dez"
                loc_oGrid.Column15.ControlSource = "cursor_4c_MtI.Total"
                loc_oGrid.Column16.ControlSource = "cursor_4c_MtI.Acm_Jan"
                loc_oGrid.Column17.ControlSource = "cursor_4c_MtI.Acm_Fev"
                loc_oGrid.Column18.ControlSource = "cursor_4c_MtI.Acm_Mar"
                loc_oGrid.Column19.ControlSource = "cursor_4c_MtI.Acm_Abr"
                loc_oGrid.Column20.ControlSource = "cursor_4c_MtI.Acm_Mai"
                loc_oGrid.Column21.ControlSource = "cursor_4c_MtI.Acm_Jun"
                loc_oGrid.Column22.ControlSource = "cursor_4c_MtI.Acm_Jul"
                loc_oGrid.Column23.ControlSource = "cursor_4c_MtI.Acm_Ago"
                loc_oGrid.Column24.ControlSource = "cursor_4c_MtI.Acm_Set"
                loc_oGrid.Column25.ControlSource = "cursor_4c_MtI.Acm_Out"
                loc_oGrid.Column26.ControlSource = "cursor_4c_MtI.Acm_Nov"
                loc_oGrid.Column27.ControlSource = "cursor_4c_MtI.Acm_Dez"
                loc_oGrid.Column28.chk_4c_Check1.ControlSource = "cursor_4c_MtI.ChkValida"

                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AlternarGradeDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR ANO MTZ - Valida ano de competencia (range 2000-2999)
    *-- Original: getAno.Valid
    *-- =========================================================================

    PROCEDURE ValidarAnoMtz
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cAno, loc_nAno
        loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value)

        IF EMPTY(loc_cAno)
            RETURN
        ENDIF

        loc_nAno = VAL(loc_cAno)

        IF loc_nAno <= 2000 OR loc_nAno >= 2999
            MsgAviso("Informe um Ano V" + CHR(225) + "lido.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value = TRANSFORM(loc_nAno)
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR GRUPO MTZ - Valida grupo em SigCdGcr e preenche Classes
    *-- Original: Get_sgrupo.Valid - CursorQuery em SigCdGcr para Classes
    *-- =========================================================================

    PROCEDURE ValidarGrupoMtz
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cGrupo, loc_cSQL, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)

        IF EMPTY(loc_cGrupo)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(loc_cGrupo)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcBusca") > 0 AND ;
               !EOF("cursor_4c_GcBusca")
                SELECT cursor_4c_GcBusca
                THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
                    ALLTRIM(cursor_4c_GcBusca.Classes)

                IF EMPTY(ALLTRIM(cursor_4c_GcBusca.Classes))
                    MsgErro("Imposs" + CHR(237) + "vel efetuar lan" + ;
                            CHR(231) + CHR(227) + "amento para este grupo!" + CHR(13) + ;
                            "A classe do grupo n" + CHR(227) + "o est" + CHR(225) + ;
                            " informada!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
                ELSE
                    loc_lResultado = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_GcBusca")
                    USE IN cursor_4c_GcBusca
                ENDIF
                THIS.AbrirBuscaGrupoMtz()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoMtz")
        ENDTRY

        IF USED("cursor_4c_GcBusca")
            USE IN cursor_4c_GcBusca
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- ABRIR BUSCA GRUPO MTZ - FormBuscaAuxiliar em SigCdGcr
    *-- =========================================================================

    PROCEDURE AbrirBuscaGrupoMtz()
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_GcBusca2", "Codigos", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value), ;
                "Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcBusca2")
                    SELECT cursor_4c_GcBusca2
                    IF !EOF()
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ;
                            ALLTRIM(cursor_4c_GcBusca2.Codigos)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
                            ALLTRIM(cursor_4c_GcBusca2.Classes)
                    ENDIF
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaGrupoMtz")
        ENDTRY

        IF USED("cursor_4c_GcBusca2")
            USE IN cursor_4c_GcBusca2
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- TECLA F4 SGRUPO - Abre busca de grupo ao pressionar F4
    *-- =========================================================================

    PROCEDURE TeclaF4Sgrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaGrupoMtz()
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR CONTA MTZ - Valida conta em SigCdCli e preenche descricao
    *-- Original: Get_sconta.Valid - fAcessoContas + fChecarInativas
    *-- =========================================================================

    PROCEDURE ValidarContaMtz
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cConta, loc_cGrupo, loc_cSQL, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value)
        loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)

        IF EMPTY(loc_cConta)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 IClis, Rclis, Grupos, Inativa FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(loc_cConta)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliBusca") > 0 AND ;
               !EOF("cursor_4c_CliBusca")
                SELECT cursor_4c_CliBusca
                IF NVL(cursor_4c_CliBusca.Inativa, 0) = 1
                    MsgAviso("Conta Inativa...", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.SetFocus()
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
                        ALLTRIM(cursor_4c_CliBusca.Rclis)
                    loc_lResultado = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_CliBusca")
                    USE IN cursor_4c_CliBusca
                ENDIF
                THIS.AbrirBuscaContaMtz()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarContaMtz")
        ENDTRY

        IF USED("cursor_4c_CliBusca")
            USE IN cursor_4c_CliBusca
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- ABRIR BUSCA CONTA MTZ - FormBuscaAuxiliar em SigCdCli
    *-- =========================================================================

    PROCEDURE AbrirBuscaContaMtz()
        LOCAL loc_oBusca, loc_cGrupo, loc_cFiltro, loc_oErro

        TRY
            loc_cGrupo  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_CliBusca2", "IClis", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value), ;
                "Conta Corrente", .F., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliBusca2")
                    SELECT cursor_4c_CliBusca2
                    IF !EOF()
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ;
                            ALLTRIM(cursor_4c_CliBusca2.IClis)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
                            ALLTRIM(cursor_4c_CliBusca2.Rclis)
                    ENDIF
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaContaMtz")
        ENDTRY

        IF USED("cursor_4c_CliBusca2")
            USE IN cursor_4c_CliBusca2
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- TECLA F4 SCONTA - Abre busca de conta ao pressionar F4
    *-- =========================================================================

    PROCEDURE TeclaF4Sconta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaContaMtz()
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR MOEDA MTZ - Valida moeda em SigCdMoe (fwBuscaExt original)
    *-- Original: getMoeda.Valid - fwBuscaExt('SigCdMoe','CMoes','DMoes')
    *-- =========================================================================

    PROCEDURE ValidarMoedaMtz
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cMoeda, loc_cSQL, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_cMoeda = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value)

        IF EMPTY(loc_cMoeda)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe" + ;
                       " WHERE CMoes = " + EscaparSQL(loc_cMoeda)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeBusca") > 0 AND ;
               !EOF("cursor_4c_MoeBusca")
                SELECT cursor_4c_MoeBusca
                THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
                    ALLTRIM(cursor_4c_MoeBusca.CMoes)
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_MoeBusca")
                    USE IN cursor_4c_MoeBusca
                ENDIF
                THIS.AbrirBuscaMoedaMtz()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarMoedaMtz")
        ENDTRY

        IF USED("cursor_4c_MoeBusca")
            USE IN cursor_4c_MoeBusca
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- ABRIR BUSCA MOEDA MTZ - FormBuscaAuxiliar em SigCdMoe
    *-- =========================================================================

    PROCEDURE AbrirBuscaMoedaMtz()
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_MoeBusca2", "CMoes", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value), ;
                "Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeBusca2")
                    SELECT cursor_4c_MoeBusca2
                    IF !EOF()
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
                            ALLTRIM(cursor_4c_MoeBusca2.CMoes)
                    ENDIF
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaMoedaMtz")
        ENDTRY

        IF USED("cursor_4c_MoeBusca2")
            USE IN cursor_4c_MoeBusca2
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- TECLA F4 MOEDA - Abre busca de moeda ao pressionar F4
    *-- =========================================================================

    PROCEDURE TeclaF4Moeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaMoedaMtz()
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- ATUALIZA TOTAL - Recalcula Total da linha e atualiza ValorTotal header
    *-- Original: ThisForm.AtualizaTotal(csSigCdMti.cIdChaves)
    *-- =========================================================================

    PROCEDURE AtualizaTotal(par_cIdChaves)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.AtualizarTotal(par_cIdChaves)
                THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal.Value = ;
                    THIS.this_oBusinessObject.this_nValorTotal
                THIS.pgf_4c_Paginas.Page2.txt_4c_Saldo.Value = ;
                    THIS.this_oBusinessObject.this_nValorTotal
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AtualizaTotal")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN INSERIR LINHA CLICK - Adiciona linha em branco na grade de detalhe
    *-- Original: cmdInsFtc.Buttons(1).Click
    *-- =========================================================================

    PROCEDURE BtnInserirLinhaClick()
        LOCAL loc_cCodigo, loc_oGrid

        TRY
            IF THIS.this_cModoAtual # "INCLUIR" AND THIS.this_cModoAtual # "ALTERAR"
                RETURN
            ENDIF

            loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)

            IF THIS.this_oBusinessObject.InserirLinhaDetalhe(loc_cCodigo)
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                IF VARTYPE(loc_oGrid) = "O"
                    loc_oGrid.Refresh()
                    loc_oGrid.Column1.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnInserirLinhaClick")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- BTN EXCLUIR LINHA CLICK - Remove linha atual da grade de detalhe
    *-- Original: cmdInsFtc.Buttons(2).Click
    *-- =========================================================================

    PROCEDURE BtnExcluirLinhaClick()
        LOCAL loc_oGrid

        TRY
            IF THIS.this_cModoAtual # "INCLUIR" AND THIS.this_cModoAtual # "ALTERAR"
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.ExcluirLinhaDetalhe()
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                IF VARTYPE(loc_oGrid) = "O"
                    loc_oGrid.SetFocus()
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnExcluirLinhaClick")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- GRD DADOS AFTER ROW COL CHANGE - Valida celulas e atualiza totais
    *-- Original: Column1.Text1.Valid, Column2.Text1.Valid, Column3-14.Text1.Valid
    *-- =========================================================================

    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_cChave

        IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
            RETURN
        ENDIF

        SELECT cursor_4c_MtI
        loc_cChave = ALLTRIM(NVL(cursor_4c_MtI.CidChaves, ""))

        DO CASE
        CASE par_nColIndex >= 3 AND par_nColIndex <= 14
            IF !EMPTY(loc_cChave)
                THIS.AtualizaTotal(loc_cChave)
            ENDIF

        CASE par_nColIndex = 1
            THIS.ValidarGrupoLinhaGrid()

        CASE par_nColIndex = 2
            THIS.ValidarContaLinhaGrid()

        ENDCASE
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR GRUPO LINHA GRID - Valida SigCdGcr.Codigos na coluna Grupos
    *-- Original: Column1.Text1.Valid (fAcessoContab)
    *-- =========================================================================

    PROCEDURE ValidarGrupoLinhaGrid()
        LOCAL loc_cGrupo, loc_cSQL

        IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
            RETURN
        ENDIF

        SELECT cursor_4c_MtI
        loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))

        IF EMPTY(loc_cGrupo)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Codigos, Classes FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(loc_cGrupo)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcGrid") <= 0 OR ;
               EOF("cursor_4c_GcGrid")
                MsgErro("Acesso Negado!!! Grupo n" + CHR(227) + "o encontrado.", "")
                SELECT cursor_4c_MtI
                REPLACE Grupos WITH "" IN cursor_4c_MtI
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoLinhaGrid")
        ENDTRY

        IF USED("cursor_4c_GcGrid")
            USE IN cursor_4c_GcGrid
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR CONTA LINHA GRID - Valida SigCdCli.IClis na coluna Contas
    *-- Original: Column2.Text1.Valid (fAcessoContas)
    *-- =========================================================================

    PROCEDURE ValidarContaLinhaGrid()
        LOCAL loc_cConta, loc_cGrupo, loc_cSQL

        IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
            RETURN
        ENDIF

        SELECT cursor_4c_MtI
        loc_cConta = ALLTRIM(NVL(cursor_4c_MtI.Contas, ""))
        loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))

        IF EMPTY(loc_cConta)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 IClis, Rclis, Inativa FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(loc_cConta)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrid") > 0 AND ;
               !EOF("cursor_4c_CliGrid")
                SELECT cursor_4c_CliGrid
                IF NVL(cursor_4c_CliGrid.Inativa, 0) = 1
                    MsgErro("Acesso Negado!!! Conta Inativa.", "")
                    SELECT cursor_4c_MtI
                    REPLACE Contas WITH "" IN cursor_4c_MtI
                    IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
                        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
                        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
                    ENDIF
                ENDIF
            ELSE
                MsgErro("Acesso Negado!!! Conta n" + CHR(227) + "o encontrada.", "")
                SELECT cursor_4c_MtI
                REPLACE Contas WITH "" IN cursor_4c_MtI
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarContaLinhaGrid")
        ENDTRY

        IF USED("cursor_4c_CliGrid")
            USE IN cursor_4c_CliGrid
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- TORNAR CONTROLES VISIVEIS - Percorre containers e pages recursivamente
    *-- =========================================================================

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

    *-- =========================================================================
    *-- FORMATAR GRID LISTA - Aplica fonte padrao no grid
    *-- =========================================================================

    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *-- =========================================================================
    *-- DESTROY - Libera recursos
    *-- =========================================================================

    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\mtzBO.prg):
*******************************************************************************
* mtzBO.prg - Business Object: Matriz de Saldos por Centro de Custo
* Tabela principal : SigCdMtz  (cabecalho da matriz)
* Tabela detalhe   : SigCdMtI  (linhas de centro de custo / meses)
* Herda de         : BusinessBase
*******************************************************************************

DEFINE CLASS mtzBO AS BusinessBase

    *-- =========================================================================
    *-- PROPRIEDADES: SigCdMtz (cabecalho)
    *-- =========================================================================

    *-- Chave usuario (char 3 - gerada por GerarProximoCodigo na insercao)
    this_cCodigo    = ""

    *-- Ano de competencia da matriz (char 4, ex: "2026")
    this_cAno       = ""

    *-- Grupo de conta corrente (SigCdGcr.Codigos)
    this_cSGrupos   = ""

    *-- Conta de centro de custo (SigCdCli.IClis)
    this_cSContas   = ""

    *-- Flag inativa (0=ativa / 1=inativa -> convertido para .T./.F.)
    this_lInativas  = .F.

    *-- Moeda da matriz (SigCdMoe.CMoes, char 4)
    this_cMoeda     = ""

    *-- Auditoria de inclusao
    this_tDtIncs    = {}
    this_cUsuIncs   = ""

    *-- Auditoria de alteracao
    this_tDtAlts    = {}
    this_cUsuAlts   = ""

    *-- =========================================================================
    *-- PROPRIEDADES DERIVADAS / AUXILIARES (nao armazenadas diretamente)
    *-- =========================================================================

    *-- Descricao da conta - derivada do JOIN: SigCdCli.rclis AS sDContas
    *-- Nao existe como coluna em SigCdMtz; carregada via SELECT com JOIN
    this_cSDesconta = ""

    *-- Valor total acumulado dos meses de SigCdMtI (calculado, exibicao)
    this_nValorTotal = 0

    *-- =========================================================================
    *-- INIT
    *-- =========================================================================

    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMtz"
            THIS.this_cCampoChave = "Codigo"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- OBTER CHAVE PRIMARIA (requerido pelo sistema de auditoria)
    *-- =========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *-- =========================================================================
    *-- NOVO REGISTRO - Gera codigo unico para insercao
    *-- =========================================================================

    FUNCTION NovoRegistro()
        LOCAL loc_lResultado, loc_nProximo
        loc_lResultado = DODEFAULT()

        IF loc_lResultado
            TRY
                loc_nProximo = THIS.GerarProximoCodigo()
                IF loc_nProximo > 0
                    THIS.this_cCodigo = ALLTRIM(STR(loc_nProximo, 3))
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel gerar c" + CHR(243) + "digo para nova matriz.", "mtzBO.NovoRegistro")
                    loc_lResultado = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "mtzBO.NovoRegistro")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- GERAR PROXIMO CODIGO (PROTECTED) - MAX(Codigo)+1 em SigCdMtz
    *-- =========================================================================

    PROTECTED FUNCTION GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(Codigo) AS INT)), 0) + 1 AS ProximoCodigo" + ;
                       " FROM SigCdMtz" + ;
                       " WHERE ISNUMERIC(LTRIM(Codigo)) = 1"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ProxCod")
                TABLEREVERT(.T., "cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = NVL(ProximoCodigo, 1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.GerarProximoCodigo")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *-- =========================================================================
    *-- BUSCAR - SELECT para grid Page1 (lista de matrizes)
    *-- =========================================================================

    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " ORDER BY a.Ano, a.sGrupos, a.sContas"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                           " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                           " a.DtIncs, a.UsuIncs" + ;
                           " FROM SigCdMtz a" + ;
                           " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY a.Ano, a.sGrupos, a.sContas"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR POR CODIGO - Carrega registro SigCdMtz no BO
    *-- =========================================================================

    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs, a.DtAlts, a.UsuAlts, a.CidChaves" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DO CURSOR - Mapeia cursor para propriedades do BO
    *-- =========================================================================

    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(Codigo, "C")
            THIS.this_cAno       = TratarNulo(Ano, "C")
            THIS.this_cSGrupos   = TratarNulo(sGrupos, "C")
            THIS.this_cSContas   = TratarNulo(sContas, "C")
            THIS.this_cSDesconta = TratarNulo(sDContas, "C")
            THIS.this_cMoeda     = TratarNulo(Moeda, "C")
            IF VARTYPE(Inativas) = "L"
                THIS.this_lInativas = Inativas
            ELSE
                THIS.this_lInativas = (NVL(Inativas, 0) = 1)
            ENDIF
            THIS.this_tDtIncs    = TratarNulo(DtIncs, "T")
            THIS.this_cUsuIncs   = TratarNulo(UsuIncs, "C")
            THIS.this_tDtAlts    = TratarNulo(DtAlts, "T")
            THIS.this_cUsuAlts   = TratarNulo(UsuAlts, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DETALHE - Carrega SigCdMtI para cursor_4c_MtI (grid Page2)
    *-- =========================================================================

    FUNCTION CarregarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_cSQL = "SELECT a.Codigo, a.CidChaves, a.Grupos, a.Contas," + ;
                       " a.Val_Jan, a.Val_Fev, a.Val_Mar, a.Val_Abr," + ;
                       " a.Val_Mai, a.Val_Jun, a.Val_Jul, a.Val_Ago," + ;
                       " a.Val_Set, a.Val_Out, a.Val_Nov, a.Val_Dez," + ;
                       " a.Acm_Jan, a.Acm_Fev, a.Acm_Mar, a.Acm_Abr," + ;
                       " a.Acm_Mai, a.Acm_Jun, a.Acm_Jul, a.Acm_Ago," + ;
                       " a.Acm_Set, a.Acm_Out, a.Acm_Nov, a.Acm_Dez," + ;
                       " (a.Val_Jan+a.Val_Fev+a.Val_Mar+a.Val_Abr+a.Val_Mai+a.Val_Jun+" + ;
                       "  a.Val_Jul+a.Val_Ago+a.Val_Set+a.Val_Out+a.Val_Nov+a.Val_Dez)" + ;
                       " AS Total, a.ChkValida" + ;
                       " FROM SigCdMtI a" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.Grupos, a.Contas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_MtI")
                TABLEREVERT(.T., "cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtI")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.CarregarDetalhe")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CRIAR CURSOR DETALHE VAZIO - Cria cursor_4c_MtI vazio para insercao
    *-- =========================================================================

    FUNCTION CriarCursorDetalheVazio(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_MtI ( ;
                Codigo    C(3), ;
                CidChaves C(36), ;
                Grupos    C(10), ;
                Contas    C(10), ;
                Val_Jan   N(14,2), ;
                Val_Fev   N(14,2), ;
                Val_Mar   N(14,2), ;
                Val_Abr   N(14,2), ;
                Val_Mai   N(14,2), ;
                Val_Jun   N(14,2), ;
                Val_Jul   N(14,2), ;
                Val_Ago   N(14,2), ;
                Val_Set   N(14,2), ;
                Val_Out   N(14,2), ;
                Val_Nov   N(14,2), ;
                Val_Dez   N(14,2), ;
                Acm_Jan   N(14,2), ;
                Acm_Fev   N(14,2), ;
                Acm_Mar   N(14,2), ;
                Acm_Abr   N(14,2), ;
                Acm_Mai   N(14,2), ;
                Acm_Jun   N(14,2), ;
                Acm_Jul   N(14,2), ;
                Acm_Ago   N(14,2), ;
                Acm_Set   N(14,2), ;
                Acm_Out   N(14,2), ;
                Acm_Nov   N(14,2), ;
                Acm_Dez   N(14,2), ;
                Total     N(18,2), ;
                ChkValida L ;
            )
            SET NULL OFF

            *-- Adiciona linha em branco inicial para o usuario comecar a inserir
            INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                Total, ChkValida) ;
                VALUES (par_cCodigo, "", "", "", ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, .F.)

            GO TOP IN cursor_4c_MtI
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CriarCursorDetalheVazio")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR LINHA DETALHE - Adiciona linha em branco no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION InserirLinhaDetalhe(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                *-- Verifica se ja existe uma linha vazia (sem Grupos e Contas)
                SELECT cursor_4c_MtI
                GO TOP
                LOCATE FOR EMPTY(ALLTRIM(Grupos)) AND EMPTY(ALLTRIM(Contas))
                IF !FOUND()
                    INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                        Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                        Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                        Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                        Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                        Total, ChkValida) ;
                        VALUES (par_cCodigo, "", "", "", ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, .F.)
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.InserirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- EXCLUIR LINHA DETALHE - Remove linha atual do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ExcluirLinhaDetalhe()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExcluirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- ATUALIZAR TOTAL - Calcula Total na linha do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION AtualizarTotal(par_cChave)
        LOCAL loc_nTotal, loc_nTotalGeral, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                IF !EMPTY(ALLTRIM(par_cChave))
                    SELECT cursor_4c_MtI
                    LOCATE FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    IF FOUND()
                        loc_nTotal = NVL(Val_Jan, 0) + NVL(Val_Fev, 0) + NVL(Val_Mar, 0) + ;
                                     NVL(Val_Abr, 0) + NVL(Val_Mai, 0) + NVL(Val_Jun, 0) + ;
                                     NVL(Val_Jul, 0) + NVL(Val_Ago, 0) + NVL(Val_Set, 0) + ;
                                     NVL(Val_Out, 0) + NVL(Val_Nov, 0) + NVL(Val_Dez, 0)
                        REPLACE Total WITH loc_nTotal IN cursor_4c_MtI ;
                            FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    ENDIF
                ENDIF

                *-- Calcula total geral de todas as linhas
                SELECT SUM(NVL(Total, 0)) AS TotalGeral FROM cursor_4c_MtI INTO CURSOR cursor_4c_TmpTot READWRITE
                SELECT cursor_4c_TmpTot
                THIS.this_nValorTotal = NVL(TotalGeral, 0)
                USE IN cursor_4c_TmpTot

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.AtualizarTotal")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VALIDAR DUPLICATAS - Verifica Grupos+Contas duplicados no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ValidarDuplicatas()
        LOCAL loc_lValido, loc_lResultado
        loc_lValido = .T.
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                SELECT COUNT(*) AS Qtds, Grupos, Contas ;
                    FROM cursor_4c_MtI ;
                    WHERE !EMPTY(ALLTRIM(Contas)) AND !EMPTY(ALLTRIM(Grupos)) ;
                    GROUP BY Grupos, Contas ;
                    HAVING COUNT(*) >= 2 ;
                    INTO CURSOR cursor_4c_Dup READWRITE

                SELECT cursor_4c_Dup
                IF RECCOUNT("cursor_4c_Dup") > 0
                    MsgErro("H" + CHR(225) + " registros duplicados na grade de Contas, Verifique.", "Aviso")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                loc_lResultado = loc_lValido
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ValidarDuplicatas")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR (PROTECTED) - INSERT SigCdMtz + SigCdMtI via cursor_4c_MtI
    *-- =========================================================================

    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdMtz" + ;
                       " (Codigo, Ano, sGrupos, sContas, Moeda, Inativas," + ;
                       "  DtIncs, UsuIncs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cAno) + "," + ;
                       EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       EscaparSQL(THIS.this_cSContas) + "," + ;
                       EscaparSQL(THIS.this_cMoeda) + "," + ;
                       IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .T.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ATUALIZAR (PROTECTED) - UPDATE SigCdMtz + re-inserir SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMtz SET" + ;
                       " Ano = " + EscaparSQL(THIS.this_cAno) + "," + ;
                       " sGrupos = " + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       " sContas = " + EscaparSQL(THIS.this_cSContas) + "," + ;
                       " Moeda = " + EscaparSQL(THIS.this_cMoeda) + "," + ;
                       " Inativas = " + IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .F.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- EXECUTAR EXCLUSAO (PROTECTED) - DELETE SigCdMtz + SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- DELETE SigCdMtI (detalhe) primeiro por FK
            loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdMtz WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtz)")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtI)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- SALVAR DETALHE (PROTECTED) - INSERT SigCdMtI a partir de cursor_4c_MtI
    *-- =========================================================================

    PROTECTED FUNCTION SalvarDetalhe(par_cCodigo, par_lSomenteInserir)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupos, loc_cContas, loc_cChave
        LOCAL loc_nJan, loc_nFev, loc_nMar, loc_nAbr, loc_nMai, loc_nJun
        LOCAL loc_nJul, loc_nAgo, loc_nSet, loc_nOut, loc_nNov, loc_nDez
        loc_lResultado = .F.

        TRY
            IF !par_lSomenteInserir
                loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(par_cCodigo)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            loc_lResultado = .T.

            IF USED("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                GO TOP
                SCAN FOR !EMPTY(ALLTRIM(Grupos)) AND !EMPTY(ALLTRIM(Contas))
                    loc_cGrupos = ALLTRIM(Grupos)
                    loc_cContas = ALLTRIM(Contas)
                    loc_cChave  = ALLTRIM(CidChaves)
                    loc_nJan    = NVL(Val_Jan, 0)
                    loc_nFev    = NVL(Val_Fev, 0)
                    loc_nMar    = NVL(Val_Mar, 0)
                    loc_nAbr    = NVL(Val_Abr, 0)
                    loc_nMai    = NVL(Val_Mai, 0)
                    loc_nJun    = NVL(Val_Jun, 0)
                    loc_nJul    = NVL(Val_Jul, 0)
                    loc_nAgo    = NVL(Val_Ago, 0)
                    loc_nSet    = NVL(Val_Set, 0)
                    loc_nOut    = NVL(Val_Out, 0)
                    loc_nNov    = NVL(Val_Nov, 0)
                    loc_nDez    = NVL(Val_Dez, 0)

                    IF EMPTY(loc_cChave)
                        loc_cChave = ALLTRIM(SYS(2015)) + ALLTRIM(STR(SECONDS(), 10, 0))
                    ENDIF

                    loc_cSQL = "INSERT INTO SigCdMtI" + ;
                               " (Codigo, CidChaves, Grupos, Contas," + ;
                               "  Val_Jan, Val_Fev, Val_Mar, Val_Abr," + ;
                               "  Val_Mai, Val_Jun, Val_Jul, Val_Ago," + ;
                               "  Val_Set, Val_Out, Val_Nov, Val_Dez)" + ;
                               " VALUES (" + ;
                               EscaparSQL(par_cCodigo) + "," + ;
                               EscaparSQL(loc_cChave) + "," + ;
                               EscaparSQL(loc_cGrupos) + "," + ;
                               EscaparSQL(loc_cContas) + "," + ;
                               FormatarNumeroSQL(loc_nJan) + "," + ;
                               FormatarNumeroSQL(loc_nFev) + "," + ;
                               FormatarNumeroSQL(loc_nMar) + "," + ;
                               FormatarNumeroSQL(loc_nAbr) + "," + ;
                               FormatarNumeroSQL(loc_nMai) + "," + ;
                               FormatarNumeroSQL(loc_nJun) + "," + ;
                               FormatarNumeroSQL(loc_nJul) + "," + ;
                               FormatarNumeroSQL(loc_nAgo) + "," + ;
                               FormatarNumeroSQL(loc_nSet) + "," + ;
                               FormatarNumeroSQL(loc_nOut) + "," + ;
                               FormatarNumeroSQL(loc_nNov) + "," + ;
                               FormatarNumeroSQL(loc_nDez) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro(CapturarErroSQL(), "mtzBO.SalvarDetalhe (linha " + loc_cGrupos + "/" + loc_cContas + ")")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.SalvarDetalhe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VERIFICAR DUPLICADO - Verifica se Ano+Grupo+Conta ja existe em SigCdMtz
    *-- =========================================================================

    FUNCTION VerificarDuplicado(par_cAno, par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigCdMtz" + ;
                       " WHERE Ano = " + EscaparSQL(par_cAno) + ;
                       " AND sGrupos = " + EscaparSQL(par_cGrupo) + ;
                       " AND sContas = " + EscaparSQL(par_cConta)

            IF !EMPTY(ALLTRIM(THIS.this_cCodigo)) AND !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                           " AND Codigo <> " + EscaparSQL(THIS.this_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMtz")
                TABLEREVERT(.T., "cursor_4c_ChkMtz")
                USE IN cursor_4c_ChkMtz
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMtz")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkMtz") > 0
                SELECT cursor_4c_ChkMtz
                loc_lExiste = (NVL(Qtd, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.VerificarDuplicado")
        ENDTRY

        IF USED("cursor_4c_ChkMtz")
            USE IN cursor_4c_ChkMtz
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *-- =========================================================================
    *-- DESTRUIR - Fecha cursores abertos pelo BO
    *-- =========================================================================

    PROCEDURE Destroy()
        IF USED("cursor_4c_MtI")
            USE IN cursor_4c_MtI
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

