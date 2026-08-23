# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[23/08/2026 00:47:42] Erro: Erro ao gerar código:Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-23 00:46:11] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-23 00:46:11] [INFO] Config FPW: (nao fornecido)
[2026-08-23 00:46:11] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 00:46:11] [INFO] Timeout: 300 segundos
[2026-08-23 00:46:11] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qngpmkiq.prg
[2026-08-23 00:46:11] [INFO] Conteudo do wrapper:
[2026-08-23 00:46:11] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormPrl', 'C:\4c\tasks\task502', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormPrl', 'C:\4c\tasks\task502', 'CRUD'
QUIT

[2026-08-23 00:46:11] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qngpmkiq.prg
[2026-08-23 00:46:11] [INFO] VFP output esperado em: C:\4c\tasks\task502\vfp_output.txt
[2026-08-23 00:46:11] [INFO] Executando Visual FoxPro 9...
[2026-08-23 00:46:11] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qngpmkiq.prg
[2026-08-23 00:46:11] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qngpmkiq.prg
[2026-08-23 00:46:11] [INFO] Timeout configurado: 300 segundos
[2026-08-23 00:47:42] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-23 00:47:42] [INFO] VFP9 finalizado em 91.5254897 segundos
[2026-08-23 00:47:42] [INFO] Exit Code: 
[2026-08-23 00:47:42] [INFO] 
[2026-08-23 00:47:42] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-23 00:47:42] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qngpmkiq.prg
[2026-08-23 00:47:42] [INFO] 
[2026-08-23 00:47:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-23 00:47:42] [INFO] * Auto-generated wrapper for parameters
[2026-08-23 00:47:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 00:47:42] [INFO] * Parameters: 'FormPrl', 'C:\4c\tasks\task502', 'CRUD'
[2026-08-23 00:47:42] [INFO] 
[2026-08-23 00:47:42] [INFO] * Anti-dialog protections for unattended execution
[2026-08-23 00:47:42] [INFO] SET SAFETY OFF
[2026-08-23 00:47:42] [INFO] SET RESOURCE OFF
[2026-08-23 00:47:42] [INFO] SET TALK OFF
[2026-08-23 00:47:42] [INFO] SET NOTIFY OFF
[2026-08-23 00:47:42] [INFO] SYS(2335, 0)
[2026-08-23 00:47:42] [INFO] 
[2026-08-23 00:47:42] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormPrl', 'C:\4c\tasks\task502', 'CRUD'
[2026-08-23 00:47:42] [INFO] QUIT
[2026-08-23 00:47:42] [INFO] 
[2026-08-23 00:47:42] [INFO] === Fim do Wrapper.prg ===
[2026-08-23 00:47:42] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormPrl",
  "timestamp": "20260823004742",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrl.prg):
*==============================================================================
* FormPrl.prg - Formulario Cadastro de Localizacao
* Migrado de: SIGCDPRL.SCX (frmcadastro)
* Tabela: SigPrLcl
*==============================================================================

DEFINE CLASS FormPrl AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Apenas delega ao FormBase.Init() que chama InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormPrl:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("PrlBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar PrlBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.ConfigurarPageFrame()

            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormPrl:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
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
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: Cabecalho, botoes CRUD, grid e painel etiquetas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro: Top=1+29=30
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
            .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
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
            .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
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

        *-- Container botoes CRUD: Top=0+29=29 (original Grupo_op.Top=-1 -> 28, canonical ~29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
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
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
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
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico - prevalece sobre PILAR 1)
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
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botao Etiquetas (cmdEtiquetas original: Top=-1+29=28, Left=464)
        loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
        WITH loc_oPagina.cmd_4c_Etiquetas
            .Caption         = "Etiquetas"
            .Top             = 28
            .Left            = 464
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
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Etiquetas, "Click", THIS, "BtnEtiquetasClick")

        *-- Grid lista (Grade original: codigos 100px, descricaos 290px)
        *-- Top=88+29=117, Left=26, Width=890, Height=498
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
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
        ENDWITH

        *-- Definir colunas FORA de WITH para que existam imediatamente
        loc_oPagina.grd_4c_Lista.ColumnCount = 2

        WITH loc_oPagina.grd_4c_Lista.Column1
            .Width               = 100
            .Alignment           = 0
            .Header1.Caption     = "C" + CHR(243) + "digo"
        ENDWITH

        WITH loc_oPagina.grd_4c_Lista.Column2
            .Width               = 290
            .Alignment           = 0
            .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Painel etiquetas: inicia OCULTO (ativado via BtnEtiquetasClick)
        loc_oPagina.AddObject("cnt_4c_Etiquetas", "Container")
        WITH loc_oPagina.cnt_4c_Etiquetas
            .Top           = 202
            .Left          = 289
            .Width         = 420
            .Height        = 259
            .BorderWidth   = 2
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .F.
        ENDWITH

        THIS.ConfigurarPainelEtiquetas(loc_oPagina.cnt_4c_Etiquetas)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: cabecalho, campos (Parte 1) e botoes acao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro (mesmo estilo da Page1): Top=1+29=30
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
            .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
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
            .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
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

        *-- Container botoes Salvar/Cancelar: Top=9+29=38, Left=819
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 38
            .Left        = 819
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label "Codigo :" (Say8): Top=155+29=184, Left=319, Width=42
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 184
            .Left      = 319
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (get_codigos): Top=152+29=181, Left=366, Width=80, Height=23
        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Top           = 181
            .Left          = 366
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .BorderStyle   = 1
            .Themes        = .F.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox "Imprime Etiqueta" (chkEtiqueta): Top=155+29=184, Left=455
        loc_oPagina.AddObject("chk_4c_Etiqueta", "CheckBox")
        WITH loc_oPagina.chk_4c_Etiqueta
            .Caption   = "Imprime Etiqueta"
            .Value     = 0
            .Top       = 184
            .Left      = 455
            .Width     = 120
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Localização :" (Say1): Top=182+29=211, Left=298, Width=63
        loc_oPagina.AddObject("lbl_4c_Localizacao", "Label")
        WITH loc_oPagina.lbl_4c_Localizacao
            .Caption   = "Localiza" + CHR(231) + CHR(227) + "o :"
            .Top       = 211
            .Left      = 298
            .Width     = 63
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricaos (get_descricaos): Top=178+29=207, Left=366, Width=150, MaxLength=20
        loc_oPagina.AddObject("txt_4c_Descricaos", "TextBox")
        WITH loc_oPagina.txt_4c_Descricaos
            .Value         = ""
            .Top           = 207
            .Left          = 366
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Themes        = .F.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Campos sem uso do legado (mapeados para fidelidade, iniciam ocultos)
        loc_oPagina.AddObject("lbl_4c_SemUso2", "Label")
        WITH loc_oPagina.lbl_4c_SemUso2
            .Caption  = "sem uso :"
            .Top      = 527
            .Left     = 315
            .Width    = 59
            .Height   = 17
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .Visible  = .F.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Divisaos", "TextBox")
        WITH loc_oPagina.txt_4c_Divisaos
            .Value         = 0
            .Top           = 546
            .Left          = 377
            .Width         = 24
            .Height        = 23
            .MaxLength     = 2
            .InputMask     = "99"
            .FontName      = "Courier New"
            .FontSize      = 8
            .ForeColor     = RGB(36, 84, 155)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_SemUso3", "Label")
        WITH loc_oPagina.lbl_4c_SemUso3
            .Caption  = "sem uso :"
            .Top      = 550
            .Left     = 315
            .Width    = 59
            .Height   = 15
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .Visible  = .F.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Bloqueios", "TextBox")
        WITH loc_oPagina.txt_4c_Bloqueios
            .Value         = 0
            .Top           = 570
            .Left          = 377
            .Width         = 24
            .Height        = 23
            .MaxLength     = 2
            .InputMask     = "99"
            .FontName      = "Courier New"
            .FontSize      = 8
            .ForeColor     = RGB(36, 84, 155)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_SemUso22", "Label")
        WITH loc_oPagina.lbl_4c_SemUso22
            .Caption  = "sem uso :"
            .Top      = 573
            .Left     = 315
            .Width    = 59
            .Height   = 15
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .Visible  = .F.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Tipos", "OptionGroup")
        loc_oPagina.opt_4c_Tipos.ButtonCount = 3
        WITH loc_oPagina.opt_4c_Tipos
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 522
            .Left        = 377
            .Width       = 262
            .Height      = 27
            .Value       = 1
            .Visible     = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipos.Buttons(1)
            .Caption  = "Produto"
            .Left     = 5
            .Top      = 5
            .Width    = 63
            .AutoSize = .T.
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipos.Buttons(2)
            .Caption  = "Agendamento"
            .Left     = 81
            .Top      = 5
            .Width    = 98
            .AutoSize = .T.
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipos.Buttons(3)
            .Caption  = "Dep" + CHR(243) + "sito"
            .Left     = 183
            .Top      = 7
            .Width    = 69
            .AutoSize = .T.
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca registros e vincula ao grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 2

                    loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
                    loc_oGrid.Column1.Width          = 100
                    loc_oGrid.Column2.Width          = 290
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ELSE
                    loc_lResultado = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"

        *-- Gerar codigo automatico (equivalente a Padl(fGerUniqueKey([SigPrLcl]),10,'0'))
        TRY
            loc_cCodigo = THIS.this_oBusinessObject.GerarCodigo()
            THIS.this_oBusinessObject.this_cCodigos = loc_cCodigo
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)

        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = ALLTRIM(loc_cCodigo)
            loc_oPagina.txt_4c_Descricaos.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)

            LOCAL loc_oPagina
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
                ENDIF
            ENDIF
        ELSE
            MsgErro("Erro ao carregar registro.", "Visualizar")
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
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)

            LOCAL loc_oPagina
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
                loc_oPagina.txt_4c_Descricaos.SetFocus()
            ENDIF
        ELSE
            MsgErro("Erro ao carregar registro.", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
            loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricaos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        IF MsgConfirma("Excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                       loc_cCodigo + " - " + loc_cDescricao + "?", "Excluir")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir registro.", "Excluir")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra registros por codigo ou descricao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_cSQL, loc_nResult, loc_oGrid
        loc_cBusca = ""

        loc_cBusca = INPUTBOX("Informe o c" + CHR(243) + "digo ou descri" + ;
                              CHR(231) + CHR(227) + "o:", ;
                              "Buscar Localiza" + CHR(231) + CHR(227) + "o", "")

        IF VARTYPE(loc_cBusca) != "C"
            RETURN
        ENDIF

        TRY
            IF !EMPTY(ALLTRIM(loc_cBusca))
                loc_cSQL = "SELECT codigos, descricaos, etiquetas" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(loc_cBusca) + "%") + ;
                           " ORDER BY codigos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

                IF loc_nResult >= 0
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTemp")
                    ENDIF
                    IF USED("cursor_4c_DadosTemp")
                        USE IN cursor_4c_DadosTemp
                    ENDIF
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource    = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount     = 2
                    loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
                    loc_oGrid.Column1.Width          = 100
                    loc_oGrid.Column2.Width          = 290
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)

                    IF RECCOUNT("cursor_4c_Dados") = 0
                        MsgAviso("Nenhum registro encontrado para '" + ALLTRIM(loc_cBusca) + "'.", "Buscar")
                    ENDIF
                ELSE
                    IF USED("cursor_4c_DadosTemp")
                        USE IN cursor_4c_DadosTemp
                    ENDIF
                    MsgErro("Erro na busca:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                THIS.CarregarLista()
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
    * BtnEtiquetasClick - Alterna visibilidade do painel de impressao de etiquetas
    * Logica baseada em SIGCDPRL.Pagina.Lista.cntEtiquetas.CmdCancel.Click
    *--------------------------------------------------------------------------
    PROCEDURE BtnEtiquetasClick()
        THIS.ImprimirEtiquetas()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva registro (Confirmar na Page2)
    * Validacoes do legado: descricao obrigatoria, codigo <= 3 chars se etiqueta
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cDescricao, loc_cCodigo, loc_nEtiqueta
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_cDescricao = ""
        loc_cCodigo    = ""
        loc_nEtiqueta  = 0

        *-- Coletar valores para validacao pre-TRY
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
            loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
            loc_nEtiqueta = IIF(loc_oPagina.chk_4c_Etiqueta.Value = 1, 1, 0)
        ENDIF

        *-- Validacoes fora do TRY (REGRA CRITICA)
        IF EMPTY(loc_cDescricao)
            MsgAviso("Localiza" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Validar")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
                loc_oPagina.txt_4c_Descricaos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF loc_nEtiqueta = 1 AND LEN(loc_cCodigo) > 3
            MsgAviso("Para Impress" + CHR(227) + "o de Etiquetas o C" + CHR(243) + ;
                     "digo Deve Ter no M" + CHR(225) + "ximo 3 Caracteres!!!", "Validar")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
                loc_oPagina.txt_4c_Codigos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Erro ao salvar registro.", "Salvar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
            THIS.this_oBusinessObject.this_cDescricaos = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
            THIS.this_oBusinessObject.this_nEtiquetas = ;
                IIF(loc_oPagina.chk_4c_Etiqueta.Value = 1, 1, 0)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
            loc_oPagina.txt_4c_Descricaos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricaos)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
            loc_oPagina.chk_4c_Etiqueta.Value = (THIS.this_oBusinessObject.this_nEtiquetas .Value = IIF(THIS.this_oBusinessObject.this_nEtiquetas = 1, 1, 0))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: editavel apenas em INCLUIR
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Enabled = ;
                (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
            loc_oPagina.txt_4c_Descricaos.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
            loc_oPagina.chk_4c_Etiqueta.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
            loc_oPagina.txt_4c_Descricaos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
            loc_oPagina.chk_4c_Etiqueta.Value   = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar por modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * cnt_4c_Etiquetas preservado oculto (painel flutuante de etiquetas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Pular painel flutuante (deve iniciar oculto), mas recursionar filhos
                IF INLIST(loc_cNome, "CNT_4C_ETIQUETAS")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                *-- Pular campos sem uso (devem permanecer ocultos)
                IF INLIST(loc_cNome, "LBL_4C_SEMUSO2", "LBL_4C_SEMUSO3", "LBL_4C_SEMUSO22", ;
                                     "TXT_4C_DIVISAOS", "TXT_4C_BLOQUEIOS", "OPT_4C_TIPOS")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * FormatarGridLista - Formata visual do grid (FontName Tahoma, size 8)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPainelEtiquetas - Cria controles internos do painel de etiquetas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPainelEtiquetas(par_oCnt)
        LOCAL loc_oErro
        TRY
            *-- Titulo
            par_oCnt.AddObject("lbl_4c_TituloEtq", "Label")
            WITH par_oCnt.lbl_4c_TituloEtq
                .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 12
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 21
                .Left      = 113
                .Top       = 5
                .Width     = 194
                .Visible   = .T.
            ENDWITH

            *-- Label Codigo
            par_oCnt.AddObject("lbl_4c_CodigoEtq", "Label")
            WITH par_oCnt.lbl_4c_CodigoEtq
                .Caption   = "C" + CHR(243) + "digo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 15
                .Left      = 7
                .Top       = 36
                .Width     = 42
                .Visible   = .T.
            ENDWITH

            *-- TextBox Codigo (getCodigos: MaxLength=3, codigo da localizacao)
            par_oCnt.AddObject("txt_4c_CodigosEtq", "TextBox")
            WITH par_oCnt.txt_4c_CodigosEtq
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .Height        = 23
                .Left          = 58
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 33
                .Width         = 31
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oCnt.txt_4c_CodigosEtq, "KeyPress", THIS, "CodigosEtqLostFocus")

            *-- Label Quantidade
            par_oCnt.AddObject("lbl_4c_QuantEtq", "Label")
            WITH par_oCnt.lbl_4c_QuantEtq
                .Caption   = "Quantidade :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 15
                .Left      = 99
                .Top       = 37
                .Width     = 65
                .Visible   = .T.
            ENDWITH

            *-- TextBox Quantidade (getQtde: numero de copias)
            par_oCnt.AddObject("txt_4c_QtdeEtq", "TextBox")
            WITH par_oCnt.txt_4c_QtdeEtq
                .Value         = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .Height        = 23
                .InputMask     = "999"
                .Left          = 173
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 34
                .Width         = 31
                .Visible       = .T.
            ENDWITH

            *-- Label Tipo
            par_oCnt.AddObject("lbl_4c_TipoEtq", "Label")
            WITH par_oCnt.lbl_4c_TipoEtq
                .Caption   = "Tipo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 15
                .Left      = 23
                .Top       = 65
                .Width     = 31
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup Tipo (optTipo: Pequena=1, Grande=2)
            par_oCnt.AddObject("opt_4c_TipoEtq", "OptionGroup")
            par_oCnt.opt_4c_TipoEtq.ButtonCount = 2
            WITH par_oCnt.opt_4c_TipoEtq
                .BackStyle   = 0
                .BorderStyle = 0
                .Height      = 25
                .Left        = 52
                .Top         = 61
                .Value       = 1
                .Width       = 141
                .Visible     = .T.
            ENDWITH
            WITH par_oCnt.opt_4c_TipoEtq.Buttons(1)
                .AutoSize  = .T.
                .BackStyle = 0
                .Caption   = "Pequena"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Height    = 15
                .Left      = 5
                .Themes    = .F.
                .Top       = 5
                .Width     = 60
            ENDWITH
            WITH par_oCnt.opt_4c_TipoEtq.Buttons(2)
                .AutoSize  = .T.
                .BackStyle = 0
                .Caption   = "Grande"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Height    = 15
                .Left      = 78
                .Themes    = .F.
                .Top       = 5
                .Width     = 53
            ENDWITH

            *-- OptionGroup Impressora (optImpressora: populado dinamicamente em ImprimirEtiquetas)
            par_oCnt.AddObject("opt_4c_Impressora", "OptionGroup")
            par_oCnt.opt_4c_Impressora.ButtonCount = 1
            WITH par_oCnt.opt_4c_Impressora
                .AutoSize    = .F.
                .BackStyle   = 0
                .BorderStyle = 0
                .Height      = 156
                .Left        = 12
                .Top         = 94
                .Value       = 1
                .Width       = 200
                .Visible     = .T.
            ENDWITH
            WITH par_oCnt.opt_4c_Impressora.Buttons(1)
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = " \<1. Gen" + CHR(233) + "rico/Somente Texto"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Height    = 17
                .Left      = 4
                .Themes    = .F.
                .Top       = 10
                .Width     = 186
            ENDWITH

            *-- Label Densidade
            par_oCnt.AddObject("lbl_4c_DensidadeEtq", "Label")
            WITH par_oCnt.lbl_4c_DensidadeEtq
                .Caption   = "Densidade"
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Left      = 234
                .Top       = 37
                .Width     = 45
                .Visible   = .T.
            ENDWITH

            *-- Spinner Densidade (spnDensidade: range 0-20, default 20)
            par_oCnt.AddObject("spn_4c_Densidade", "Spinner")
            WITH par_oCnt.spn_4c_Densidade
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(90, 90, 90)
                .Height            = 26
                .KeyboardHighValue = 20
                .KeyboardLowValue  = 0
                .Left              = 234
                .SpecialEffect     = 1
                .SpinnerHighValue  = 20
                .SpinnerLowValue   = 0
                .Top               = 53
                .Value             = 20
                .Width             = 55
                .Visible           = .T.
            ENDWITH

            *-- Label Horizontal
            par_oCnt.AddObject("lbl_4c_HorizontalEtq", "Label")
            WITH par_oCnt.lbl_4c_HorizontalEtq
                .Caption   = "Horizontal"
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Left      = 292
                .Top       = 37
                .Width     = 43
                .Visible   = .T.
            ENDWITH

            *-- Spinner Horizontal (spnHorizontal: range 0-20, default 0)
            par_oCnt.AddObject("spn_4c_Horizontal", "Spinner")
            WITH par_oCnt.spn_4c_Horizontal
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(90, 90, 90)
                .Height            = 26
                .KeyboardHighValue = 20
                .KeyboardLowValue  = 0
                .Left              = 292
                .SpecialEffect     = 1
                .SpinnerHighValue  = 20
                .SpinnerLowValue   = 0
                .Top               = 53
                .Value             = 0
                .Width             = 55
                .Visible           = .T.
            ENDWITH

            *-- Label Vertical
            par_oCnt.AddObject("lbl_4c_VerticalEtq", "Label")
            WITH par_oCnt.lbl_4c_VerticalEtq
                .Caption   = "Vertical"
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 13
                .Left      = 350
                .Top       = 37
                .Width     = 33
                .Visible   = .T.
            ENDWITH

            *-- Spinner Vertical (spnVertical: range 0-20, default carregado de SigCdPam.AjVerts)
            par_oCnt.AddObject("spn_4c_Vertical", "Spinner")
            WITH par_oCnt.spn_4c_Vertical
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(90, 90, 90)
                .Height            = 26
                .KeyboardHighValue = 20
                .KeyboardLowValue  = 0
                .Left              = 350
                .SpecialEffect     = 1
                .SpinnerHighValue  = 20
                .SpinnerLowValue   = 0
                .Top               = 53
                .Value             = 0
                .Width             = 55
                .Visible           = .T.
            ENDWITH

            *-- Botao OK (CmdOk: confirma impressao)
            par_oCnt.AddObject("cmd_4c_OkEtq", "CommandButton")
            WITH par_oCnt.cmd_4c_OkEtq
                .Caption       = "OK"
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 45
                .Left          = 321
                .MousePointer  = 15
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Confirmar"
                .Top           = 206
                .Width         = 45
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oCnt.cmd_4c_OkEtq, "Click", THIS, "CmdOkEtqClick")

            *-- Botao Cancelar (CmdCancel: fecha painel sem imprimir)
            par_oCnt.AddObject("cmd_4c_CancelEtq", "CommandButton")
            WITH par_oCnt.cmd_4c_CancelEtq
                .Caption       = "Sair"
                .BackColor     = RGB(255, 255, 255)
                .Cancel        = .T.
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 45
                .Left          = 367
                .MousePointer  = 15
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "[ESC] Sair"
                .Top           = 206
                .Width         = 45
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oCnt.cmd_4c_CancelEtq, "Click", THIS, "CmdCancelEtqClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar painel de etiquetas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirEtiquetas - Popula impressoras e exibe painel de etiquetas
    * Equivalente ao metodo impetiqueta do legado SIGCDPRL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ImprimirEtiquetas()
        LOCAL loc_oPagina, loc_oCnt, loc_lSucesso
        LOCAL loc_nPrinters, loc_nI, loc_cI
        LOCAL loc_cSQL, loc_nResult, loc_oErro
        LOCAL loc_nMaxImpEti, loc_nAjVerts, loc_nAjHorzs
        LOCAL loc_nImpres, loc_nOk, loc_nBtnCount, loc_nTop, loc_nHeight

        DIMENSION laPrinters(1)
        DIMENSION laImpOk(1)

        loc_lSucesso   = .F.
        loc_nMaxImpEti = 3
        loc_nAjVerts   = 0
        loc_nAjHorzs   = 0

        *-- Verificar impressoras instaladas (fora do TRY para sair cedo)
        loc_nPrinters = APrinters(laPrinters)
        IF loc_nPrinters = 0
            MsgAviso("N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!", "Etiquetas")
            RETURN loc_lSucesso
        ENDIF

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oCnt    = loc_oPagina.cnt_4c_Etiquetas

            *-- Uppercase e ordenar nomes de impressoras (coluna 1)
            FOR loc_nI = 1 TO loc_nPrinters
                laPrinters(loc_nI, 1) = UPPER(laPrinters(loc_nI, 1))
            ENDFOR
            ASORT(laPrinters)

            *-- Parametros de etiquetas em SigCdPam
            loc_cSQL    = "SELECT nMaxImpEti, AjVerts, AjHorzs FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamEtq")
            IF loc_nResult > 0 AND USED("cursor_4c_ParamEtq") AND RECCOUNT("cursor_4c_ParamEtq") > 0
                SELECT cursor_4c_ParamEtq
                loc_nMaxImpEti = IIF(ISNULL(cursor_4c_ParamEtq.nMaxImpEti), 3, cursor_4c_ParamEtq.nMaxImpEti)
                loc_nAjVerts   = IIF(ISNULL(cursor_4c_ParamEtq.AjVerts),    0, cursor_4c_ParamEtq.AjVerts)
                loc_nAjHorzs   = IIF(ISNULL(cursor_4c_ParamEtq.AjHorzs),    0, cursor_4c_ParamEtq.AjHorzs)
            ENDIF
            IF USED("cursor_4c_ParamEtq")
                USE IN cursor_4c_ParamEtq
            ENDIF

            *-- Impressoras de etiquetas cadastradas em SigCdMp (nTpImpres=2)
            loc_cSQL    = "SELECT Impres, nTpImpres FROM SigCdMp ORDER BY Impres"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdMpEtq")
            loc_nImpres = 1
            IF loc_nResult > 0 AND USED("cursor_4c_SigCdMpEtq") AND RECCOUNT("cursor_4c_SigCdMpEtq") > 0
                SELECT cursor_4c_SigCdMpEtq
                SCAN FOR cursor_4c_SigCdMpEtq.nTpImpres = 2
                    loc_nOk = ASCAN(laPrinters, ALLTRIM(UPPER(cursor_4c_SigCdMpEtq.Impres)))
                    IF loc_nOk > 0
                        DIMENSION laImpOk(loc_nImpres)
                        laImpOk(loc_nImpres) = laPrinters(loc_nOk)
                        loc_nImpres = loc_nImpres + 1
                    ENDIF
                ENDSCAN
            ENDIF
            IF USED("cursor_4c_SigCdMpEtq")
                USE IN cursor_4c_SigCdMpEtq
            ENDIF
            loc_nImpres = loc_nImpres - 1

            *-- Popular OptionGroup de impressoras dinamicamente
            loc_nTop    = loc_oCnt.opt_4c_Impressora.Top
            loc_nHeight = 15
            IF loc_nImpres > 0
                loc_nBtnCount = MIN(loc_nImpres, MAX(loc_nMaxImpEti, 3))
                loc_oCnt.opt_4c_Impressora.ButtonCount = loc_nBtnCount
                FOR loc_nI = 1 TO loc_nBtnCount
                    loc_cI = ALLTRIM(STR(loc_nI))
                    WITH loc_oCnt.opt_4c_Impressora.Buttons(loc_nI)
                        .AutoSize  = .F.
                        .Caption   = " \<" + loc_cI + ". " + laImpOk(loc_nI)
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .ForeColor = RGB(90, 90, 90)
                        .Left      = 4
                        .Tag       = UPPER(laImpOk(loc_nI))
                        .Themes    = .F.
                        .Top       = loc_nTop
                        .Width     = 180
                    ENDWITH
                    loc_nTop    = loc_nTop + 20
                    loc_nHeight = loc_nHeight + 20
                ENDFOR
            ELSE
                loc_oCnt.opt_4c_Impressora.ButtonCount = 1
                loc_nOk = ASCAN(laPrinters, "GEN" + CHR(233) + "RICO/SOMENTE TEXTO")
                WITH loc_oCnt.opt_4c_Impressora.Buttons(1)
                    .AutoSize = .F.
                    .Caption  = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
                    .BackStyle = 0
                    .Enabled  = (loc_nOk > 0)
                    .FontSize = 8
                    .Tag      = "GEN" + CHR(233) + "RICO/SOMENTE TEXTO"
                    .Width    = 180
                ENDWITH
                loc_nImpres  = IIF(loc_oCnt.opt_4c_Impressora.Buttons(1).Enabled, 1, 0)
                loc_nHeight  = loc_nHeight + 20
            ENDIF
            loc_oCnt.opt_4c_Impressora.Enabled = (loc_nImpres > 1)
            loc_oCnt.opt_4c_Impressora.Height  = loc_nHeight

            *-- Inicializar spinners com ajustes de SigCdPam
            loc_oCnt.spn_4c_Vertical.Value   = loc_nAjVerts
            loc_oCnt.spn_4c_Horizontal.Value = loc_nAjHorzs

            *-- Mostrar painel e bloquear demais controles da lista
            loc_oCnt.Visible                      = .T.
            loc_oCnt.Enabled                      = .T.
            loc_oPagina.grd_4c_Lista.Enabled      = .F.
            loc_oPagina.cnt_4c_Botoes.Enabled     = .F.
            loc_oPagina.cnt_4c_Saida.Enabled      = .F.
            loc_oPagina.cmd_4c_Etiquetas.Enabled  = .F.

            loc_oCnt.txt_4c_QtdeEtq.Value    = 1
            loc_oCnt.txt_4c_CodigosEtq.Value = ""

            THIS.Refresh()
            loc_oCnt.txt_4c_CodigosEtq.SetFocus()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar etiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CodigosEtqLostFocus - Valida codigo de localizacao ao sair do campo
    * Handler PUBLIC pois é alvo de BINDEVENT
    *--------------------------------------------------------------------------
    PROCEDURE CodigosEtqLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oCnt, loc_oTxt, loc_cValor, loc_cSQL, loc_nResult, loc_cEncontrado, loc_oErro

        loc_cEncontrado = ""

        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Etiquetas
            IF VARTYPE(loc_oCnt) = "O" AND PEMSTATUS(loc_oCnt, "txt_4c_CodigosEtq", 5)
                loc_oTxt   = loc_oCnt.txt_4c_CodigosEtq
                loc_cValor = ALLTRIM(loc_oTxt.Value)

                IF !EMPTY(loc_cValor)
                    loc_cSQL    = "SELECT TOP 1 Codigos FROM SigPrLcl" + ;
                                  " WHERE Etiquetas = 1 AND Codigos = " + EscaparSQL(loc_cValor)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidEtq")

                    IF loc_nResult > 0 AND USED("cursor_4c_ValidEtq") AND RECCOUNT("cursor_4c_ValidEtq") > 0
                        SELECT cursor_4c_ValidEtq
                        loc_cEncontrado = ALLTRIM(cursor_4c_ValidEtq.Codigos)
                    ELSE
                        IF USED("cursor_4c_ValidEtq")
                            USE IN cursor_4c_ValidEtq
                        ENDIF
                        loc_cEncontrado = THIS.AbrirBuscaCodigosEtq(loc_cValor)
                    ENDIF

                    IF USED("cursor_4c_ValidEtq")
                        USE IN cursor_4c_ValidEtq
                    ENDIF

                    IF PEMSTATUS(loc_oTxt, "Value", 5)
                        loc_oTxt.Value = loc_cEncontrado
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCodigosEtq - Abre FormBuscaAuxiliar para localizacoes com etiqueta
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaCodigosEtq(par_cValor)
        LOCAL loc_cSQL, loc_nResult, loc_oBusca, loc_cCodigo, loc_oErro

        loc_cCodigo = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cValor))
                loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl" + ;
                           " WHERE Etiquetas = 1 AND Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
                           " ORDER BY Codigos"
            ELSE
                loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtqLst")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaEtqLst")
                IF RECCOUNT("cursor_4c_BuscaEtqLst") = 0
                    USE IN cursor_4c_BuscaEtqLst
                    loc_cSQL    = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtqLst")
                ENDIF

                IF loc_nResult > 0 AND USED("cursor_4c_BuscaEtqLst") AND RECCOUNT("cursor_4c_BuscaEtqLst") > 0
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEtqLst"
                        loc_oBusca.DefinirCursor("cursor_4c_BuscaEtqLst", "Codigos", "Descricaos", ;
                                                 "Localiza" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Mostrar()
                        IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                            loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        ENDIF
                        loc_oBusca = .NULL.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaEtqLst")
                    USE IN cursor_4c_BuscaEtqLst
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca")
        ENDTRY

        RETURN loc_cCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkEtqClick - Imprime etiquetas Eltron/Zebra via saida raw (???)
    * Equivalente ao CmdOk.Click do legado SIGCDPRL
    * Handler PUBLIC pois e alvo de BINDEVENT
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkEtqClick()
        LOCAL loc_oCnt, loc_cCod, loc_nQtd, loc_nTip, loc_nDen, loc_nHor, loc_nVer
        LOCAL loc_nImp, loc_cImp, loc_cSQL, loc_nResult, loc_lProsseguir, loc_lCursorOk
        LOCAL loc_nVezes, loc_nCnt, loc_nInc, loc_nLin, loc_nCol, loc_nI
        LOCAL loc_lPrinterSet, loc_oErro

        loc_lProsseguir = .T.
        loc_lCursorOk   = .F.
        loc_lPrinterSet = .F.

        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Etiquetas

            loc_cCod = ALLTRIM(loc_oCnt.txt_4c_CodigosEtq.Value)
            loc_nQtd = INT(loc_oCnt.txt_4c_QtdeEtq.Value)
            loc_nTip = loc_oCnt.opt_4c_TipoEtq.Value
            loc_nDen = INT(loc_oCnt.spn_4c_Densidade.Value)
            loc_nHor = INT(loc_oCnt.spn_4c_Horizontal.Value)
            loc_nVer = INT(loc_oCnt.spn_4c_Vertical.Value)
            loc_nImp = loc_oCnt.opt_4c_Impressora.Value
            loc_cImp = ALLTRIM(loc_oCnt.opt_4c_Impressora.Buttons(loc_nImp).Tag)

            IF loc_nQtd < 1
                loc_nQtd = 1
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_LocalPrLoc (Codigos C(10))
            SET NULL OFF

            IF EMPTY(loc_cCod)
                *-- Todas as localizacoes com etiqueta habilitada
                loc_cSQL    = "SELECT Codigos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SrcPrLoc")
                IF loc_nResult > 0 AND USED("cursor_4c_SrcPrLoc") AND RECCOUNT("cursor_4c_SrcPrLoc") > 0
                    SELECT cursor_4c_SrcPrLoc
                    SCAN
                        INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES (cursor_4c_SrcPrLoc.Codigos)
                    ENDSCAN
                    loc_lCursorOk = .T.
                ELSE
                    MsgAviso("N" + CHR(227) + "o Existem Localiza" + CHR(231) + CHR(245) + "es a Serem Impressas!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o!!!")
                    loc_lProsseguir = .F.
                ENDIF
                IF USED("cursor_4c_SrcPrLoc")
                    USE IN cursor_4c_SrcPrLoc
                ENDIF
            ELSE
                *-- Codigo especifico: inserir lnQtd copias
                loc_cSQL    = "SELECT Codigos FROM SigPrLcl" + ;
                              " WHERE Etiquetas = 1 AND Codigos = " + EscaparSQL(loc_cCod)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SrcPrLoc")
                IF loc_nResult > 0 AND USED("cursor_4c_SrcPrLoc") AND RECCOUNT("cursor_4c_SrcPrLoc") > 0
                    IF USED("cursor_4c_SrcPrLoc")
                        USE IN cursor_4c_SrcPrLoc
                    ENDIF
                    FOR loc_nI = 1 TO loc_nQtd
                        INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES (loc_cCod)
                    ENDFOR
                    loc_nQtd      = 1
                    loc_lCursorOk = .T.
                ELSE
                    IF USED("cursor_4c_SrcPrLoc")
                        USE IN cursor_4c_SrcPrLoc
                    ENDIF
                    MsgAviso("N" + CHR(227) + "o Existem Localiza" + CHR(231) + CHR(245) + "es a Serem Impressas!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o!!!")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND loc_lCursorOk
                INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES ("*FIM*")

                SET PRINTER TO NAME (loc_cImp)
                SET DEVICE TO PRINTER
                loc_lPrinterSet = .T.

                FOR loc_nVezes = 1 TO loc_nQtd
                    loc_nCnt = 1
                    SELECT cursor_4c_LocalPrLoc
                    GO TOP
                    SCAN
                        IF loc_nCnt = 1
                            ??? CHR(02) + "L" + CHR(13)
                            ??? "H" + ALLTRIM(STR(loc_nDen)) + CHR(13)
                            ??? "D11" + CHR(13)
                        ENDIF

                        DO CASE
                            CASE loc_nTip = 1
                                loc_nInc = (85 * loc_nCnt) - 85
                                IF ALLTRIM(cursor_4c_LocalPrLoc.Codigos) <> "*FIM*"
                                    loc_nLin = 15 + loc_nHor
                                    loc_nCol = 10 + loc_nVer + loc_nInc
                                    ??? "1e42034" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + "B" + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
                                    loc_nLin = 5 + loc_nHor
                                    loc_nCol = 36 + loc_nVer + loc_nInc
                                    ??? "1911001" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
                                ELSE
                                    loc_nLin = 5 + loc_nHor
                                    loc_nCol = 36 + loc_nVer + loc_nInc
                                    ??? "1911001" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 5) + CHR(13)
                                ENDIF

                            CASE loc_nTip = 2
                                loc_nInc = (89 * loc_nCnt) - 89
                                IF ALLTRIM(cursor_4c_LocalPrLoc.Codigos) <> "*FIM*"
                                    loc_nLin = 22 + loc_nHor
                                    loc_nCol = 50 + loc_nVer + loc_nInc
                                    ??? "4e42034" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + "B" + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
                                    loc_nLin = 45 + loc_nHor
                                    loc_nCol = 65 + loc_nVer + loc_nInc
                                    ??? "4911002" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
                                ELSE
                                    loc_nLin = 45 + loc_nHor
                                    loc_nCol = 65 + loc_nVer + loc_nInc
                                    ??? "1911001" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 5) + CHR(13)
                                ENDIF
                        ENDCASE

                        loc_nCnt = loc_nCnt + 1
                        IF loc_nCnt > 4 OR ALLTRIM(cursor_4c_LocalPrLoc.Codigos) = "*FIM*"
                            loc_nCnt = 1
                            ??? "Q0001" + CHR(13)
                            ??? "E" + CHR(13)
                        ENDIF
                    ENDSCAN
                ENDFOR

                SET PRINTER TO DEFAULT
                SET DEVICE TO SCREEN
                loc_lPrinterSet = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir etiquetas")
        ENDTRY

        IF loc_lPrinterSet
            SET PRINTER TO DEFAULT
            SET DEVICE TO SCREEN
        ENDIF

        IF USED("cursor_4c_LocalPrLoc")
            USE IN cursor_4c_LocalPrLoc
        ENDIF

        THIS.CmdCancelEtqClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCancelEtqClick - Fecha painel de etiquetas e restaura controles
    * Handler PUBLIC pois e alvo de BINDEVENT
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelEtqClick()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oCnt    = loc_oPagina.cnt_4c_Etiquetas

        loc_oCnt.Visible                      = .F.
        loc_oCnt.Enabled                      = .F.
        loc_oPagina.grd_4c_Lista.Enabled      = .T.
        loc_oPagina.cnt_4c_Botoes.Enabled     = .T.
        loc_oPagina.cnt_4c_Saida.Enabled      = .T.
        loc_oPagina.cmd_4c_Etiquetas.Enabled  = .T.
        THIS.Refresh()
        loc_oPagina.grd_4c_Lista.SetFocus()
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

ENDDEFINE


### BO (C:\4c\projeto\app\classes\PrlBO.prg):
*==============================================================================
* PrlBO.prg - Business Object para Cadastro de Localizacao
* Tabela: SigPrLcl
* Herdado de: BusinessBase
*==============================================================================

DEFINE CLASS PrlBO AS BusinessBase

    *-- Propriedades da tabela SigPrLcl
    this_cCodigos    = ""   && codigos char(10) PK
    this_cDescricaos = ""   && descricaos char(20)
    this_nTipos      = 0    && tipos numeric(1,0): 1=Produto 2=Agendamento 3=Deposito
    this_nEtiquetas  = 0    && etiquetas numeric(1,0): 0=Nao 1=Sim
    this_nBloqueios  = 0    && bloqueios numeric(2,0)
    this_nDivisaos   = 0    && divisaos numeric(2,0)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrLcl"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os registros (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, etiquetas" + ;
                       " FROM SigPrLcl" + ;
                       " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo PK (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, tipos, etiquetas, bloqueios, divisaos" + ;
                       " FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescricaos = TratarNulo(descricaos, "C")
            THIS.this_nTipos      = TratarNulo(tipos,      "N")
            THIS.this_nEtiquetas  = TratarNulo(etiquetas,  "N")
            THIS.this_nBloqueios  = TratarNulo(bloqueios,  "N")
            THIS.this_nDivisaos   = TratarNulo(divisaos,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrLcl" + ;
                       " (codigos, descricaos, tipos, etiquetas, bloqueios, divisaos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)         + ", " + ;
                       EscaparSQL(THIS.this_cDescricaos)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEtiquetas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBloqueios) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDivisaos)  + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrLcl SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricaos)      + "," + ;
                       " tipos      = " + FormatarNumeroSQL(THIS.this_nTipos)     + "," + ;
                       " etiquetas  = " + FormatarNumeroSQL(THIS.this_nEtiquetas) + "," + ;
                       " bloqueios  = " + FormatarNumeroSQL(THIS.this_nBloqueios) + "," + ;
                       " divisaos   = " + FormatarNumeroSQL(THIS.this_nDivisaos)  + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida regras de negocio antes de salvar (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        *-- Localizacao invalida (descricao vazia)
        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Localiza" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        *-- Para etiqueta, codigo deve ter no maximo 3 caracteres
        IF loc_lResultado AND THIS.this_nEtiquetas = 1 AND LEN(ALLTRIM(THIS.this_cCodigos)) > 3
            MsgAviso("Para Impress" + CHR(227) + "o de Etiquetas o C" + CHR(243) + "digo Deve Ter no M" + CHR(225) + "ximo 3 Caracteres!!!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarEtiquetas - Retorna localizacoes com etiqueta habilitada (PUBLIC por padrao)
    * Usado pelo painel de impressao de etiquetas (cntEtiquetas)
    *--------------------------------------------------------------------------
    FUNCTION BuscarEtiquetas(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT codigos, descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE etiquetas = 1" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE codigos = " + EscaparSQL(PADR(par_cCodigo, 6))
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Etiquetas")
                TABLEREVERT(.T., "cursor_4c_Etiquetas")
                USE IN cursor_4c_Etiquetas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiquetas")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar etiquetas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar etiquetas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoExiste - Verifica se codigo ja cadastrado (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoExiste(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT codigos FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkCod")
                TABLEREVERT(.T., "cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarCodigo - Gera proximo codigo unico para SigPrLcl (PUBLIC por padrao)
    * Equivalente a Padl(fGerUniqueKey([SigPrLcl]), 10, [0]) do legado
    *--------------------------------------------------------------------------
    FUNCTION GerarCodigo()
        LOCAL loc_cNovoCodigo, loc_cSQL, loc_nResult
        loc_cNovoCodigo = ""

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CASE WHEN ISNUMERIC(LTRIM(RTRIM(codigos))) = 1" + ;
                       " THEN CAST(LTRIM(RTRIM(codigos)) AS INT) ELSE 0 END), 0) + 1 AS proximo" + ;
                       " FROM SigPrLcl"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_GerarCod")
                TABLEREVERT(.T., "cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_cNovoCodigo = PADL(ALLTRIM(STR(cursor_4c_GerarCod.proximo)), 10, "0")
            ENDIF

            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        ENDTRY

        RETURN loc_cNovoCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Etiquetas")
            USE IN cursor_4c_Etiquetas
        ENDIF
        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF
        IF USED("cursor_4c_GerarCod")
            USE IN cursor_4c_GerarCod
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

