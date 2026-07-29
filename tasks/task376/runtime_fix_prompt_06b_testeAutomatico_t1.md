# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-29 09:30:47] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 09:30:47] [INFO] Config FPW: (nao fornecido)
[2026-07-29 09:30:47] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 09:30:47] [INFO] Timeout: 300 segundos
[2026-07-29 09:30:47] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ocdmzbwo.prg
[2026-07-29 09:30:47] [INFO] Conteudo do wrapper:
[2026-07-29 09:30:47] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formcnl', 'C:\4c\tasks\task376', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcnl', 'C:\4c\tasks\task376', 'CRUD'
QUIT

[2026-07-29 09:30:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ocdmzbwo.prg
[2026-07-29 09:30:47] [INFO] VFP output esperado em: C:\4c\tasks\task376\vfp_output.txt
[2026-07-29 09:30:47] [INFO] Executando Visual FoxPro 9...
[2026-07-29 09:30:47] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ocdmzbwo.prg
[2026-07-29 09:30:47] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ocdmzbwo.prg
[2026-07-29 09:30:47] [INFO] Timeout configurado: 300 segundos
[2026-07-29 09:31:30] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 09:31:30] [INFO] VFP9 finalizado em 42.3189716 segundos
[2026-07-29 09:31:30] [INFO] Exit Code: 
[2026-07-29 09:31:30] [INFO] 
[2026-07-29 09:31:30] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 09:31:30] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ocdmzbwo.prg
[2026-07-29 09:31:30] [INFO] 
[2026-07-29 09:31:30] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 09:31:30] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 09:31:30] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 09:31:30] [INFO] * Parameters: 'Formcnl', 'C:\4c\tasks\task376', 'CRUD'
[2026-07-29 09:31:30] [INFO] 
[2026-07-29 09:31:30] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 09:31:30] [INFO] SET SAFETY OFF
[2026-07-29 09:31:30] [INFO] SET RESOURCE OFF
[2026-07-29 09:31:30] [INFO] SET TALK OFF
[2026-07-29 09:31:30] [INFO] SET NOTIFY OFF
[2026-07-29 09:31:30] [INFO] SYS(2335, 0)
[2026-07-29 09:31:30] [INFO] 
[2026-07-29 09:31:30] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcnl', 'C:\4c\tasks\task376', 'CRUD'
[2026-07-29 09:31:30] [INFO] QUIT
[2026-07-29 09:31:30] [INFO] 
[2026-07-29 09:31:30] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 09:31:30] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formcnl",
  "timestamp": "20260729093130",
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (KEYPRESS, TECLACONTAKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcnl.prg):
*===========================================================================
* Formcnl.prg - Formulario de Contagem de Produtos por Localizacao
* Migrado de: SIGCDCNL (frmcadastro)
* Tabelas   : SigCdCnL (cabecalho) + SigCdCnI (itens/localizacoes)
* Criado em : 2026-07-29
*
* ESTRUTURA DO FORM:
*   Page1 (Lista): grid de contagens + botoes CRUD + botoes especiais
*   Page2 (Dados): campos do cabecalho + grid de itens (GrdLoc) + OptionGroup
*===========================================================================

DEFINE CLASS Formcnl AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
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

    *==========================================================================
    * Init - Inicializa o formulario
    * DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formcnl:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("cnlBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object cnlBO", ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Configurar estrutura de paginas
                THIS.ConfigurarPageFrame()

                *-- Propagar titulo para labels do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar lista inicial (pular se validando UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista + Dados)
    * PageFrame.Top = -29 oculta as abas (Tabs=.F.)
    * Todos os controles nas Pages precisam compensar +29 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            WITH THIS.pgf_4c_Paginas
                .Top       = -29
                .Left      = 0
                .Width     = 1000
                .Height    = 629
                .PageCount = 2
                .Tabs      = .F.
                .Visible   = .T.

                *-- Page1: Lista de contagens
                .Page1.Caption   = "Lista"
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page1.BackColor = RGB(100, 100, 100)

                *-- Page2: Dados da contagem (cabecalho + itens)
                .Page2.Caption   = "Dados"
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.BackColor = RGB(100, 100, 100)
            ENDWITH

            *-- Imagens de fundo das paginas
            THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Configurar conteudo das paginas
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar PageFrame:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD,
    *   botoes especiais (Espelho/Fechar/Abrir) e grid de listagem
    * TOPS compensados (+29 por PageFrame.Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *--------------------------------------------------------------
            * Container Cabecalho cinza (cntSombra no legado)
            * Original: Top=2 -> Compensado: Top=31
            *--------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Container Botoes CRUD (Grupo_Op no legado) - lado direito
            * Original: Top=0 -> Compensado: Top=29
            *--------------------------------------------------------------
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

            *--------------------------------------------------------------
            * Container Saida - padrao canonico (PREVALECE SOBRE PILAR 1)
            *--------------------------------------------------------------
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *--------------------------------------------------------------
            * Botoes especiais do legado: Espelho / Fechar / Abrir
            * Original: Top=82 -> Compensado: Top=111
            * Posicoes: Left=14, 119, 224 (direto na Page1)
            *--------------------------------------------------------------
            loc_oPagina.AddObject("cmd_4c_Espelho", "CommandButton")
            WITH loc_oPagina.cmd_4c_Espelho
                .Caption       = "Espelho"
                .Top           = 111
                .Left          = 14
                .Width         = 105
                .Height        = 40
                .BackColor     = RGB(200, 200, 200)
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .F.
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_Espelho, "Click", THIS, "BtnEspelhoClick")

            loc_oPagina.AddObject("cmd_4c_Fechar", "CommandButton")
            WITH loc_oPagina.cmd_4c_Fechar
                .Caption       = "Encerrar"
                .Top           = 111
                .Left          = 119
                .Width         = 75
                .Height        = 75
                .BackColor     = RGB(200, 200, 200)
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .F.
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_Fechar, "Click", THIS, "BtnFecharContagemClick")

            loc_oPagina.AddObject("cmd_4c_Abrir", "CommandButton")
            WITH loc_oPagina.cmd_4c_Abrir
                .Caption       = "Abrir"
                .Top           = 111
                .Left          = 224
                .Width         = 105
                .Height        = 40
                .BackColor     = RGB(200, 200, 200)
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .F.
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_Abrir, "Click", THIS, "BtnAbrirContagemClick")

            *--------------------------------------------------------------
            * Grid de listagem de contagens
            * Abaixo dos botoes especiais: 111+40+4=155 -> Top=155
            * Width=900 para nao sobrepor cnt_4c_Saida (Left=917)
            *--------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oPagina.grd_4c_Dados.RecordSource = ""
            loc_oPagina.grd_4c_Dados.ColumnCount  = 7

            WITH loc_oPagina.grd_4c_Dados
                .Top                = 155
                .Left               = 12
                .Width              = 900
                .Height             = 440
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
                .RowHeight          = 18
                .ScrollBars         = 3
                .GridLines          = 3
                .Visible            = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina Lista:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes, campos cabecalho (Fase 5)
    * TOPS compensados (+29 por PageFrame.Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *--------------------------------------------------------------
            * Container Botoes de Acao (Salvar/Cancelar) - Grupo_Salva no legado
            * Original: Top=4 -> Compensado: Top=33
            *--------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            *-- Confirmar (Salvar)
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

            *-- Cancelar
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *--------------------------------------------------------------
            * Shape1 - elemento visual decorativo da area de niveis
            * Original: Top=169, Left=626 -> Compensado: Top=198
            *--------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPagina.shp_4c_Shape1
                .Top         = 198
                .Left        = 626
                .Width       = 364
                .Height      = 144
                .BackStyle   = 0
                .BorderWidth = 1
                .BorderColor = RGB(128, 128, 128)
                .Visible     = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Label4 "Codigo :" + txt_4c_Codigo (getCods - somente leitura)
            * Original: Label4.Top=99, getCods.Top=94 -> Compensados: +29
            *--------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPagina.lbl_4c_Label4
                .Caption   = "C" + CHR(243) + "digo : "
                .Top       = 128
                .Left      = 301
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value         = ""
                .Top           = 123
                .Left          = 349
                .Width         = 80
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Label2 "Vendedor :" + txt_4c_Conta (getConta) + txt_4c_DConta
            * Original: Label2.Top=127, getConta.Top=122, getDConta.Top=122 -> +29
            * getConta: habilitado apenas em INSERIR (When = INSERIR ou CONSULTAR)
            * getDConta: descricao do vendedor - somente leitura
            *--------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Vendedor : "
                .Top       = 156
                .Left      = 288
                .Width     = 58
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPagina.txt_4c_Conta
                .Value         = ""
                .Top           = 151
                .Left          = 349
                .Width         = 80
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .MaxLength     = 10
                .Enabled       = .T.
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarVendedor")
            BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress",  THIS, "TeclaContaKeyPress")

            loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
            WITH loc_oPagina.txt_4c_DConta
                .Value         = ""
                .Top           = 151
                .Left          = 431
                .Width         = 290
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Label9 "Ordenacao :" + opt_4c_OptOrdem (4 opcoes)
            * Original: Label9.Top=150, OptOrdem.Top=145 -> Compensados: +29
            * Opcoes: Local / Nv.2 / Nv.3 / Nv.4  (muda ordem do GrdLoc)
            *--------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPagina.lbl_4c_Label9
                .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
                .Top       = 179
                .Left      = 284
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("opt_4c_OptOrdem", "OptionGroup")
            WITH loc_oPagina.opt_4c_OptOrdem
                .ButtonCount = 4
                .Top         = 174
                .Left        = 346
                .Width       = 355
                .Height      = 25
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.
            ENDWITH
            WITH loc_oPagina.opt_4c_OptOrdem.Buttons(1)
                .Caption   = "Local"
                .BackStyle = 0
                .Left      = 5
                .Top       = 3
                .Width     = 60
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.opt_4c_OptOrdem.Buttons(2)
                .Caption   = "Nv. 2"
                .BackStyle = 0
                .Left      = 90
                .Top       = 3
                .Width     = 60
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.opt_4c_OptOrdem.Buttons(3)
                .Caption   = "Nv. 3"
                .BackStyle = 0
                .Left      = 180
                .Top       = 3
                .Width     = 60
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.opt_4c_OptOrdem.Buttons(4)
                .Caption   = "Nv. 4"
                .BackStyle = 0
                .Left      = 270
                .Top       = 3
                .Width     = 60
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            BINDEVENT(loc_oPagina.opt_4c_OptOrdem, "InteractiveChange", THIS, "OptOrdemChanged")

            *--------------------------------------------------------------
            * Label1 "Local :" - cabecalho da area do GrdLoc
            * Original: Top=172 -> Compensado: Top=201
            *--------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "Local : "
                .Top       = 201
                .Left      = 310
                .Width     = 36
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *--------------------------------------------------------------
            * GrdLoc - grid de itens (localizacoes + quantidades contadas)
            * Original: Top=169, Left=349, Width=263, Height=419 -> Top=198
            * Column1: Locals (readonly), Column2: QtdCtg (editavel), Column3: Qtde (readonly)
            *--------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_GrdLoc", "Grid")
            loc_oPagina.grd_4c_GrdLoc.RecordSource = ""
            loc_oPagina.grd_4c_GrdLoc.ColumnCount  = 3

            WITH loc_oPagina.grd_4c_GrdLoc
                .Top                = 198
                .Left               = 349
                .Width              = 263
                .Height             = 419
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
                .RowHeight          = 18
                .ScrollBars         = 2
                .GridLines          = 3
                .Visible            = .T.
            ENDWITH
            WITH loc_oPagina.grd_4c_GrdLoc.Column1
                .Width    = 80
                .ReadOnly = .T.
                .Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH loc_oPagina.grd_4c_GrdLoc.Column2
                .Width    = 60
                .ReadOnly = .F.
                .Header1.Caption = "Qtde."
            ENDWITH
            WITH loc_oPagina.grd_4c_GrdLoc.Column3
                .Width    = 60
                .ReadOnly = .T.
                .Header1.Caption = "Estoque"
            ENDWITH
            BINDEVENT(loc_oPagina.grd_4c_GrdLoc, "AfterRowColChange", THIS, "GrdLocAfterRowColChange")

            *--------------------------------------------------------------
            * Painel direito: codigos e descricoes de cada nivel de localizacao
            * Todos dentro da area do Shape1 (Top=198, Left=626, Width=364, Height=144)
            * Label7 "Base :" / Label6 "Segundo Nivel :" / Label5 "Terceiro Nivel :" / Label3 "Quarto Nivel :"
            *--------------------------------------------------------------

            *-- Label7 "Base :"  Original: Top=192 -> Compensado: Top=221
            loc_oPagina.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPagina.lbl_4c_Label7
                .Caption   = "Base :"
                .Top       = 221
                .Left      = 707
                .Width     = 32
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Base (getBase) - somente leitura; preenchido por GrdLocAfterRowColChange
            loc_oPagina.AddObject("txt_4c_Base", "TextBox")
            WITH loc_oPagina.txt_4c_Base
                .Value         = ""
                .Top           = 216
                .Left          = 743
                .Width         = 54
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_DBase (getDBase) - descricao do nivel Base, somente leitura
            loc_oPagina.AddObject("txt_4c_DBase", "TextBox")
            WITH loc_oPagina.txt_4c_DBase
                .Value         = ""
                .Top           = 216
                .Left          = 799
                .Width         = 174
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- Label6 "Segundo Nivel :"  Original: Top=220 -> Compensado: Top=249
            loc_oPagina.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPagina.lbl_4c_Label6
                .Caption   = "Segundo N" + CHR(237) + "vel :"
                .Top       = 249
                .Left      = 662
                .Width     = 77
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Nvl2 (getNvl2) - somente leitura  Original: Top=215 -> Compensado: Top=244
            loc_oPagina.AddObject("txt_4c_Nvl2", "TextBox")
            WITH loc_oPagina.txt_4c_Nvl2
                .Value         = ""
                .Top           = 244
                .Left          = 743
                .Width         = 54
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_DNvl2 (getDNvl2) - descricao Nivel2, somente leitura
            loc_oPagina.AddObject("txt_4c_DNvl2", "TextBox")
            WITH loc_oPagina.txt_4c_DNvl2
                .Value         = ""
                .Top           = 244
                .Left          = 799
                .Width         = 174
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- Label5 "Terceiro Nivel :"  Original: Top=248 -> Compensado: Top=277
            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Caption   = "Terceiro N" + CHR(237) + "vel :"
                .Top       = 277
                .Left      = 665
                .Width     = 74
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Nvl3 (getNvl3) - somente leitura  Original: Top=243 -> Compensado: Top=272
            loc_oPagina.AddObject("txt_4c_Nvl3", "TextBox")
            WITH loc_oPagina.txt_4c_Nvl3
                .Value         = ""
                .Top           = 272
                .Left          = 743
                .Width         = 54
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_DNvl3 (getDNvl3) - descricao Nivel3, somente leitura
            loc_oPagina.AddObject("txt_4c_DNvl3", "TextBox")
            WITH loc_oPagina.txt_4c_DNvl3
                .Value         = ""
                .Top           = 272
                .Left          = 799
                .Width         = 174
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- Label3 "Quarto Nivel :"  Original: Top=276 -> Compensado: Top=305
            loc_oPagina.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPagina.lbl_4c_Label3
                .Caption   = "Quarto N" + CHR(237) + "vel :"
                .Top       = 305
                .Left      = 670
                .Width     = 69
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Nvl4 (getNvl4) - somente leitura  Original: Top=271 -> Compensado: Top=300
            loc_oPagina.AddObject("txt_4c_Nvl4", "TextBox")
            WITH loc_oPagina.txt_4c_Nvl4
                .Value         = ""
                .Top           = 300
                .Left          = 743
                .Width         = 54
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_DNvl4 (getDNvl4) - descricao Nivel4, somente leitura
            loc_oPagina.AddObject("txt_4c_DNvl4", "TextBox")
            WITH loc_oPagina.txt_4c_DNvl4
                .Value         = ""
                .Top           = 300
                .Left          = 799
                .Width         = 174
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .ReadOnly      = .T.
                .Enabled       = .F.
                .Visible       = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina Dados:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 e configura colunas
    * Colunas: Cods, Datas, Vends, DesVends, Locals, DLocals, Conferido
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oErro, loc_oGrid, loc_cCursor
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
                    loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                    loc_oGrid.RecordSource = loc_cCursor
                    loc_oGrid.ColumnCount  = 7

                    loc_oGrid.Column1.ControlSource = loc_cCursor + ".cods"
                    loc_oGrid.Column2.ControlSource = loc_cCursor + ".datas"
                    loc_oGrid.Column3.ControlSource = loc_cCursor + ".vends"
                    loc_oGrid.Column4.ControlSource = loc_cCursor + ".desvends"
                    loc_oGrid.Column5.ControlSource = loc_cCursor + ".locals"
                    loc_oGrid.Column6.ControlSource = loc_cCursor + ".dlocals"
                    loc_oGrid.Column7.ControlSource = loc_cCursor + ".conferido"

                    loc_oGrid.Column1.Width = 80
                    loc_oGrid.Column2.Width = 90
                    loc_oGrid.Column3.Width = 70
                    loc_oGrid.Column4.Width = 200
                    loc_oGrid.Column5.Width = 80
                    loc_oGrid.Column6.Width = 200
                    loc_oGrid.Column7.Width = 60

                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Data"
                    loc_oGrid.Column3.Header1.Caption = "Vendedor"
                    loc_oGrid.Column4.Header1.Caption = "Nome Vendedor"
                    loc_oGrid.Column5.Header1.Caption = "Local"
                    loc_oGrid.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Local"
                    loc_oGrid.Column7.Header1.Caption = "Conferido"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
            ENDIF

            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            THIS.AjustarBotoesPorModo()

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Controls de containers E Pages de PageFrames
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- PageFrame: iterar Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Container/Page: iterar controles filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista (fonte padrao)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inclui nova contagem
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro, loc_oPg2

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()

            *-- Criar cursor vazio para novo registro (colunas que SalvarItens espera)
            IF USED("csSigCdCnI")
                USE IN csSigCdCnI
            ENDIF
            CREATE CURSOR csSigCdCnI (Locals C(10), QtdCtg N(5,0), Qtde N(10,2))

            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
                loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
                loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
                loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
                loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
                loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
                loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
                loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
                loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
                loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
                loc_oPg2.grd_4c_GrdLoc.Refresh()
            ENDIF

            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza contagem selecionada (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Altera contagem selecionada
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.this_nConferido = 1
                        MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        THIS.this_oBusinessObject.EditarRegistro()
                        THIS.this_cModoAtual = "ALTERAR"
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.T.)
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui contagem selecionada
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.this_nConferido = 1
                        MsgAviso("Contagem J" + CHR(225) + " Encerrada - n" + CHR(227) + "o pode excluir.", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da contagem [" + ;
                                       ALLTRIM(loc_cCodigo) + "] ?", "Exclus" + CHR(227) + "o")
                            IF THIS.this_oBusinessObject.Excluir()
                                MsgSucesso("Contagem exclu" + CHR(237) + "da com sucesso!", "Sucesso")
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre busca de contagens por codigo
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "sigcdcnl", "cursor_4c_BuscaCnl", "cods", "", ;
                "Buscar Contagem")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cods",      "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("conferido", "", "Status")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnl")
                    SELECT cursor_4c_BuscaCnl
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCnl.cods)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCnl")
                USE IN cursor_4c_BuscaCnl
            ENDIF

            IF !EMPTY(loc_cCodigo)
                THIS.CarregarLista()
                IF USED(THIS.this_oBusinessObject.this_cCursorDados)
                    SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                    LOCATE FOR ALLTRIM(cods) == loc_cCodigo
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaCnl")
                USE IN cursor_4c_BuscaCnl
            ENDIF
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEspelhoClick - Gera espelho do inventario por localizacao
    * Replica logica de cmdEspelho.Click do legado
    *==========================================================================
    PROCEDURE BtnEspelhoClick()
        LOCAL loc_cSQL, loc_oErro, loc_cEmpresa
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED("cursor_4c_Espelho")
                USE IN cursor_4c_Espelho
            ENDIF

            loc_cSQL = "SELECT localizas AS Locals, grupos, contas, empos," + ;
                       " SUM(Qtde) AS qtde, CONVERT(numeric(5,0),0) AS QtdCtg," + ;
                       " SPACE(100) AS Descr" + ;
                       " FROM (" + ;
                       " SELECT localizas, SPACE(10) AS grupos, SPACE(10) AS contas, a.empos," + ;
                       " COUNT(1) AS Qtde" + ;
                       " FROM SigOpEtq A" + ;
                       " LEFT JOIN (SELECT Cpros, Cgrus, Mercs, Colecoes, SGrus" + ;
                       " FROM SigCdPro) B ON b.cpros = a.cpros" + ;
                       " WHERE a.empos = " + EscaparSQL(loc_cEmpresa) + ;
                       " AND a.contas NOT IN ('15000','15001','15002','15003')" + ;
                       " GROUP BY localizas, a.empos" + ;
                       " ) AS dados" + ;
                       " GROUP BY localizas, grupos, contas, empos" + ;
                       " ORDER BY localizas"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Espelho") > 0
                MsgInfo("Espelho gerado com " + LTRIM(STR(RECCOUNT("cursor_4c_Espelho"))) + ;
                        " localiza" + CHR(231) + CHR(245) + "es.", "Espelho")
            ELSE
                MsgErro("Erro ao gerar espelho: " + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao gerar espelho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Espelho")
            USE IN cursor_4c_Espelho
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnFecharContagemClick - Encerra contagem selecionada (Fecha no legado)
    * Legado: Conferido=1 -> Update -> Commit
    *==========================================================================
    PROCEDURE BtnFecharContagemClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.this_nConferido = 1
                        MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF MsgConfirma("Este Contagem ser" + CHR(225) + " Finalizada," + ;
                                       " Deseja encerrar a Contagem ???", ;
                                       "ATEN" + CHR(199) + CHR(195) + "O !!!")
                            IF THIS.this_oBusinessObject.FecharContagem(loc_cCodigo)
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao fechar contagem:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAbrirContagemClick - Reabre contagem encerrada (Abre no legado)
    * Legado: Conferido=0 -> Update -> Commit
    *==========================================================================
    PROCEDURE BtnAbrirContagemClick()
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
               !EOF(THIS.this_oBusinessObject.this_cCursorDados)
                SELECT (THIS.this_oBusinessObject.this_cCursorDados)
                loc_cCodigo = ALLTRIM(cods)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.this_nConferido = 0
                        MsgAviso("Contagem N" + CHR(227) + "o est" + CHR(225) + " Encerrada !!!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF MsgConfirma("Este Contagem ser" + CHR(225) + " Aberta Novamente," + ;
                                       " Deseja Continuar a Contagem ???", ;
                                       "ATEN" + CHR(199) + CHR(195) + "O !!!")
                            IF THIS.this_oBusinessObject.ReobrirContagem(loc_cCodigo)
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao reabrir contagem:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do formulario
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro, loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cVends)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesVends)
            ENDIF

            *-- Resetar ordenacao ao carregar registro
            IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
                loc_oPg2.opt_4c_OptOrdem.Value = 1
            ENDIF

            *-- Carregar itens (csSigCdCnI) via SQL com aliasing correto para SalvarItens
            IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
                LOCAL loc_cSQLItens
                loc_cSQLItens = "SELECT locals AS Locals, qtds AS QtdCtg, estoque AS Qtde" + ;
                                " FROM sigcdcni WHERE cods = " + ;
                                EscaparSQL(THIS.this_oBusinessObject.this_cCodigo) + ;
                                " ORDER BY locals"
                IF USED("csSigCdCnI")
                    USE IN csSigCdCnI
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQLItens, "csSigCdCnI") > 0
                    SELECT csSigCdCnI
                    GO TOP
                    IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
                        loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
                        loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
                        loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
                        loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
                        loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
                        loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
                        loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
                        loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
                        loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
                        loc_oPg2.grd_4c_GrdLoc.Refresh()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do formulario para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro, loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                THIS.this_oBusinessObject.this_cVends = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos editaveis por modo
    * getCods  : sempre somente leitura (codigo gerado automaticamente)
    * getConta : habilitado apenas em INCLUIR (When legado: INSERIR ou CONSULTAR)
    * getDConta: sempre somente leitura (descricao preenchida pelo lookup)
    * OptOrdem : habilitado em INCLUIR e ALTERAR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oErro, loc_oPg2, loc_lModoIncluir, loc_lModoEdicao

        TRY
            loc_oPg2        = THIS.pgf_4c_Paginas.Page2
            loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR")
            loc_lModoEdicao  = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")

            *-- Codigo: sempre desabilitado (gerado pelo sistema)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Enabled = .F.
            ENDIF

            *-- Vendedor: apenas em INCLUIR (conforme When legado)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.Enabled = (par_lHabilitar AND loc_lModoIncluir)
            ENDIF

            *-- Descricao vendedor: sempre somente leitura
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Enabled = .F.
            ENDIF

            *-- Ordenacao: habilitada em edicao quando ha itens carregados
            IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
                loc_oPg2.opt_4c_OptOrdem.Enabled = (par_lHabilitar AND loc_lModoEdicao)
            ENDIF

            *-- Grid de localizacoes: coluna Qtde. editavel apenas em INCLUIR/ALTERAR
            IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
                loc_oPg2.grd_4c_GrdLoc.Column2.ReadOnly = !(par_lHabilitar AND loc_lModoEdicao)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos do formulario
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro, loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
                loc_oPg2.opt_4c_OptOrdem.Value = 1
            ENDIF

            *-- Campos de nivel de localizacao (painel direito)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Base", 5)
                loc_oPg2.txt_4c_Base.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DBase", 5)
                loc_oPg2.txt_4c_DBase.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl2", 5)
                loc_oPg2.txt_4c_Nvl2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl2", 5)
                loc_oPg2.txt_4c_DNvl2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl3", 5)
                loc_oPg2.txt_4c_Nvl3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl3", 5)
                loc_oPg2.txt_4c_DNvl3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl4", 5)
                loc_oPg2.txt_4c_Nvl4.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl4", 5)
                loc_oPg2.txt_4c_DNvl4.Value = ""
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva a contagem (Confirmar)
    * Valida campos obrigatorios fora do TRY conforme regra critica
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro, loc_oPg2, loc_cVend

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cVend = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
            loc_cVend = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
        ENDIF

        IF EMPTY(loc_cVend)
            MsgAviso("Vendedor obrigat" + CHR(243) + "rio!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.SetFocus()
            ENDIF
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                *-- Salvar itens de localizacao (csSigCdCnI) apos cabecalho
                IF USED("csSigCdCnI")
                    THIS.this_oBusinessObject.SalvarItens("csSigCdCnI", ;
                        THIS.this_oBusinessObject.this_cCodigo)
                ENDIF
                MsgSucesso("Contagem salva com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            IF USED("csSigCdCnI")
                USE IN csSigCdCnI
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro("Erro ao cancelar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OptOrdemChanged - Muda ordenacao do GrdLoc ao trocar opcao no OptionGroup
    * Replica OptOrdem.Valid do legado: SET ORDER TO {Locals/Nivel2s/Nivel3s/Nivel4s}
    *==========================================================================
    PROCEDURE OptOrdemChanged()
        LOCAL loc_oErro, loc_nOrdem, loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF !PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
                RETURN
            ENDIF

            loc_nOrdem = loc_oPg2.opt_4c_OptOrdem.Value

            IF USED("csSigCdCnI")
                SELECT csSigCdCnI
                SET ORDER TO
                DO CASE
                CASE loc_nOrdem = 1
                    SET ORDER TO Locals
                CASE loc_nOrdem = 2
                    SET ORDER TO Nivel2s
                CASE loc_nOrdem = 3
                    SET ORDER TO Nivel3s
                CASE loc_nOrdem = 4
                    SET ORDER TO Nivel4s
                ENDCASE
                GO TOP IN csSigCdCnI

                *-- Atualizar grid de itens (adicionado na Fase 6)
                IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
                    loc_oPg2.grd_4c_GrdLoc.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao ordenar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarVendedor - Valida campo getConta (Vendedor) via SQL + lookup
    * Replica getConta.Valid do legado (busca em SigCdCli)
    * Preenche txt_4c_DConta com nome do vendedor encontrado
    *==========================================================================
    PROCEDURE ValidarVendedor
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oErro, loc_oPg2, loc_cVend, loc_cSQL, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
            RETURN
        ENDIF

        loc_cVend = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

        IF EMPTY(loc_cVend)
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT a.iclis, a.rclis, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND a.iclis = " + EscaparSQL(loc_cVend)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidVend") > 0 AND ;
               RECCOUNT("cursor_4c_ValidVend") > 0
                SELECT cursor_4c_ValidVend
                IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                    loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidVend.rclis)
                ENDIF
                THIS.this_oBusinessObject.this_cVends    = loc_cVend
                THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_ValidVend.rclis)
            ELSE
                *-- Nao encontrado: abrir FormBuscaAuxiliar para selecao
                IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                    loc_oPg2.txt_4c_DConta.Value = ""
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaVend", "iclis", loc_cVend, ;
                    "Vendedor")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
                        SELECT cursor_4c_BuscaVend
                        loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaVend.iclis)
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                            loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaVend.rclis)
                        ENDIF
                        THIS.this_oBusinessObject.this_cVends    = ALLTRIM(cursor_4c_BuscaVend.iclis)
                        THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_BuscaVend.rclis)
                    ELSE
                        loc_oPg2.txt_4c_Conta.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaVend")
                    USE IN cursor_4c_BuscaVend
                ENDIF
            ENDIF

            IF USED("cursor_4c_ValidVend")
                USE IN cursor_4c_ValidVend
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_ValidVend")
                USE IN cursor_4c_ValidVend
            ENDIF
            MsgErro("Erro ao validar vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaContaKeyPress - Intercepta F4 em txt_4c_Conta para abrir lookup
    *==========================================================================
    PROCEDURE TeclaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.ValidarVendedor()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdLocAfterRowColChange - Atualiza painel de niveis ao navegar no GrdLoc
    * Parseia Locals (10 chars) em 4 niveis: Base(1,2) Nvl2(3,2) Nvl3(5,2) Nvl4(7,3)
    *==========================================================================
    PROCEDURE GrdLocAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro, loc_oPg2, loc_cLocal, loc_cBase, loc_cNvl2, loc_cNvl3, loc_cNvl4

        TRY
            IF !USED("csSigCdCnI") OR EOF("csSigCdCnI")
                RETURN
            ENDIF

            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cLocal = ALLTRIM(csSigCdCnI.Locals)
            loc_cBase  = ""
            loc_cNvl2  = ""
            loc_cNvl3  = ""
            loc_cNvl4  = ""

            IF LEN(loc_cLocal) >= 2
                loc_cBase = SUBSTR(loc_cLocal, 1, 2)
            ENDIF
            IF LEN(loc_cLocal) >= 4
                loc_cNvl2 = SUBSTR(loc_cLocal, 3, 2)
            ENDIF
            IF LEN(loc_cLocal) >= 6
                loc_cNvl3 = SUBSTR(loc_cLocal, 5, 2)
            ENDIF
            IF LEN(loc_cLocal) >= 9
                loc_cNvl4 = SUBSTR(loc_cLocal, 7, 3)
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Base", 5)
                loc_oPg2.txt_4c_Base.Value = loc_cBase
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DBase", 5)
                loc_oPg2.txt_4c_DBase.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl2", 5)
                loc_oPg2.txt_4c_Nvl2.Value = loc_cNvl2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl2", 5)
                loc_oPg2.txt_4c_DNvl2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl3", 5)
                loc_oPg2.txt_4c_Nvl3.Value = loc_cNvl3
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl3", 5)
                loc_oPg2.txt_4c_DNvl3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl4", 5)
                loc_oPg2.txt_4c_Nvl4.Value = loc_cNvl4
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl4", 5)
                loc_oPg2.txt_4c_DNvl4.Value = ""
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em GrdLocAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo atual
    * LISTA: todos os botoes habilitados
    * INCLUIR/ALTERAR/VISUALIZAR: botoes CRUD desabilitados (usuario esta em Page2)
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro, loc_oPg1, loc_lEmLista

        TRY
            loc_oPg1    = THIS.pgf_4c_Paginas.Page1
            loc_lEmLista = (THIS.this_cModoAtual = "LISTA")

            IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = loc_lEmLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = loc_lEmLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = loc_lEmLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = loc_lEmLista
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPg1, "cmd_4c_Espelho", 5)
                loc_oPg1.cmd_4c_Espelho.Enabled = loc_lEmLista
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_Fechar", 5)
                loc_oPg1.cmd_4c_Fechar.Enabled  = loc_lEmLista
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_Abrir", 5)
                loc_oPg1.cmd_4c_Abrir.Enabled   = loc_lEmLista
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF USED("csSigCdCnI")
                USE IN csSigCdCnI
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            DODEFAULT()

        CATCH TO loc_oErro
            MsgErro("Erro ao fechar formul" + CHR(225) + "rio:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            DODEFAULT()
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\cnlBO.prg):
*===========================================================================
* cnlBO.prg - Business Object para Contagem de Produtos por Localizacao
* Tabela principal: SigCdCnL (cabecalho da contagem)
* Tabela detalhe  : SigCdCnI (itens / localizacoes)
* Criado em: 2026-07-29
*===========================================================================

DEFINE CLASS cnlBO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela     = "SigCdCnL"
    this_cCampoChave = "Cods"

    *--------------------------------------------------------------------------
    * Propriedades de SigCdCnL (schema: sigcdcnl)
    *--------------------------------------------------------------------------

    *-- Chave de negocio (cods char 10) - usada em WHERE das operacoes
    this_cCodigo     = ""

    *-- Chave tecnica interna (cidchaves char 20) - PK fisica
    this_cCidChaves  = ""

    *-- Empresa (emps char 3)
    this_cEmps       = ""

    *-- Vendedor responsavel (vends char 10 - FK SigCdCli.Iclis)
    this_cVends      = ""

    *-- Localizacao principal (locals char 10 - FK SigPrLcl.codigos)
    this_cLocals     = ""

    *-- Data da contagem (datas datetime)
    this_dDatas      = {}

    *-- Ordenacao do grid (qtds numeric 5,0): 0/1=Base, 2=Nvl2, 3=Nvl3, 4=Nvl4
    this_nQtds       = 0

    *-- Status (conferido numeric 1,0): 0=aberta, 1=encerrada
    this_nConferido  = 0

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (resultado de JOINs na query Buscar)
    *--------------------------------------------------------------------------

    *-- Descricao do vendedor (alias desvends = SigCdCli.Rclis)
    this_cDesVends   = ""

    *-- Descricao da localizacao (alias dlocals = SigPrLcl.descricaos)
    this_cDLocals    = ""

    *--------------------------------------------------------------------------
    * Nomes dos cursores de trabalho
    *--------------------------------------------------------------------------

    *-- Cursor de itens criado pelo form (csSigCdCnI)
    this_cCursorItens = "csSigCdCnI"

    *-- Cursor principal da lista (Buscar)
    this_cCursorDados = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnL"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * Buscar - Carrega lista de contagens com JOINs
    * par_cFiltro: condicao SQL adicional (opcional)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.datas DESC, a.cods"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de contagens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro de SigCdCnL pelo Cods
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND a.emps = " + EscaparSQL(loc_cEmpresa)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor posicionado
    * REGRA: SEMPRE SELECT (alias) antes de acessar campos
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(cods,       "C")
            THIS.this_nConferido  = TratarNulo(conferido,  "N")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cLocals     = TratarNulo(locals,     "C")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")
            THIS.this_cVends      = TratarNulo(vends,      "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cDesVends   = TratarNulo(desvends,   "C")
            THIS.this_cDLocals    = TratarNulo(dlocals,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigCdCnL (chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_cCodigo
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = THIS.ObterNovoCidChaves()
            IF !EMPTY(loc_cCidChaves)
                loc_cCodigo = THIS.ObterProximoCodigo()
                IF !EMPTY(loc_cCodigo)
                    THIS.this_cCidChaves = loc_cCidChaves
                    THIS.this_cCodigo    = loc_cCodigo
                    THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa
                    THIS.this_nConferido = 0

                    loc_cSQL = "INSERT INTO sigcdcnl" + ;
                               " (cidchaves, cods, conferido, datas, locals, qtds, vends, emps)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                               EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                               FormatarNumeroSQL(THIS.this_nConferido) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(THIS.this_cLocals) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                               EscaparSQL(THIS.this_cVends) + ", " + ;
                               EscaparSQL(THIS.this_cEmps)  + ;
                               ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir contagem: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar chave interna da contagem.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigCdCnL (vends, locals, qtds)
    * O legado fazia delete+reinsert via cursor; aqui usamos UPDATE direto.
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET" + ;
                       " vends  = " + EscaparSQL(THIS.this_cVends)  + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " qtds   = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " datas  = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de SigCdCnI (itens) + SigCdCnL (cabecalho)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM sigcdcnl" + ;
                           " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                           " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir contagem: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * SalvarItens - Salva itens do cursor csSigCdCnI em SigCdCnI
    * par_cCursorItens: nome do cursor com colunas Locals, QtdCtg, Qtde
    * par_cCodigo: Cods do cabecalho (SigCdCnL.cods)
    * Mapeamento: sigcdcni.qtds <- csSigCdCnI.QtdCtg (contagem)
    *             sigcdcni.estoque <- csSigCdCnI.Qtde (estoque)
    *==========================================================================
    FUNCTION SalvarItens(par_cCursorItens, par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_nResultado
        LOCAL loc_cLocals, loc_nQtdCtg, loc_nQtde
        loc_lSucesso = .F.

        IF !USED(par_cCursorItens)
            MsgErro("Cursor de itens n" + CHR(227) + "o encontrado: " + par_cCursorItens, "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Limpar itens existentes para este codigo
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                *-- Inserir itens do cursor
                SELECT (par_cCursorItens)
                GO TOP
                loc_lSucesso = .T.

                SCAN WHILE loc_lSucesso
                    *-- Capturar campos ANTES de chamar ObterNovoCidChaves (muda SELECT)
                    loc_cLocals  = ALLTRIM(locals)
                    loc_nQtdCtg  = qtdctg
                    loc_nQtde    = qtde

                    loc_cCidChaves = THIS.ObterNovoCidChaves()
                    IF EMPTY(loc_cCidChaves)
                        loc_lSucesso = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO sigcdcni" + ;
                                   " (cidchaves, cods, locals, qtds, estoque, mercs)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCodigo)    + ", " + ;
                                   EscaparSQL(loc_cLocals)    + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdCtg) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtde)   + ", " + ;
                                   EscaparSQL("") + ;
                                   ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir item [" + loc_cLocals + "]: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF

                    *-- Restaurar selecao para proxima iteracao do SCAN
                    SELECT (par_cCursorItens)
                ENDSCAN
            ELSE
                MsgErro("Erro ao limpar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SalvarItens: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarItens - Carrega itens de SigCdCnI para um cursor
    * par_cCodigo: Cods do cabecalho
    * par_cCursorDestino: nome do cursor destino (default: crSigCdCnI)
    *==========================================================================
    FUNCTION CarregarItens(par_cCodigo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "crSigCdCnI", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT cidchaves, cods, locals, qtds, estoque, mercs" + ;
                       " FROM sigcdcni" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY locals"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarItens: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FecharContagem - Define Conferido=1 (encerra a contagem)
    *==========================================================================
    FUNCTION FecharContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 1" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao fechar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FecharContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ReobrirContagem - Define Conferido=0 (reabre a contagem encerrada)
    *==========================================================================
    FUNCTION ReobrirContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 0" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao reabrir contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ReobrirContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametrosVendedor - Carrega SigCdPam para obter GrPadVens
    * Replica CursorQuery([SigCdPam], [LocalPam], ...)
    * par_cCursorDestino: nome do cursor destino (default: cursor_4c_LocalPam)
    *==========================================================================
    FUNCTION CarregarParametrosVendedor(par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_LocalPam", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                IF !EOF()
                    loc_lSucesso = !EMPTY(ALLTRIM(GrPadVens))
                ENDIF
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros de vendedor: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarParametrosVendedor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarVendedores - Carrega vendedores validos para lookup
    * Replica a query dos eventos Valid de getConta/getDConta
    * par_cFiltro    : usuario logado ou valor digitado no campo
    * par_cGrPadVens : grupo padrao de vendedores (de SigCdPam)
    * par_cCursorDestino: cursor de resultado (default: cursor_4c_Vendedores)
    *==========================================================================
    FUNCTION BuscarVendedores(par_cFiltro, par_cGrPadVens, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_Vendedores", par_cCursorDestino)
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs," + ;
                       " a.inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce ace ON a.Iclis = ace.Usuarios" + ;
                       " WHERE (NOT b.Coletors = 10 OR (b.Coletors = 10" + ;
                       " AND a.IClis NOT IN" + ;
                       " (SELECT DISTINCT c.Jobs FROM SigCdAcJ c" + ;
                       " WHERE c.Jobs NOT IN" + ;
                       " (SELECT DISTINCT d.Jobs FROM SigCdAcJ d" + ;
                       " WHERE d.Usuars = " + EscaparSQL(par_cFiltro) + "))))" + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND ace.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                       " ORDER BY a.iclis"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar vendedores: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BuscarVendedores: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoesNivel - Carrega SigLcNv1/2/3/4 para cursor local
    * par_nNivel: 1, 2, 3 ou 4
    * par_cCursorDestino: cursor destino (ex: "csNivel1")
    *==========================================================================
    FUNCTION CarregarLocalizacoesNivel(par_nNivel, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cTabela, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "csNivel" + LTRIM(STR(par_nNivel)), par_cCursorDestino)

        TRY
            DO CASE
            CASE par_nNivel = 1
                loc_cTabela = "SigLcNv1"
            CASE par_nNivel = 2
                loc_cTabela = "SigLcNv2"
            CASE par_nNivel = 3
                loc_cTabela = "SigLcNv3"
            CASE par_nNivel = 4
                loc_cTabela = "SigLcNv4"
            OTHERWISE
                MsgErro("N" + CHR(237) + "vel inv" + CHR(225) + "lido: " + ;
                        LTRIM(STR(par_nNivel)), "Erro")
                loc_lSucesso = .F.
            ENDCASE

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT * FROM " + loc_cTabela

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar " + loc_cTabela + ": " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLocalizacoesNivel: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterNovoCidChaves - Gera novo cidchaves unico (char 20) via NEWID()
    *==========================================================================
    PROTECTED FUNCTION ObterNovoCidChaves()
        LOCAL loc_cChave, loc_lSucesso
        loc_cChave   = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36), NEWID()),'-',''), 20) AS nova_chave", ;
                "cursor_4c_NovaChave") > 0
            IF loc_lSucesso
                SELECT cursor_4c_NovaChave
                loc_cChave = ALLTRIM(nova_chave)
            ELSE
                MsgErro("Erro ao gerar chave interna: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterNovoCidChaves: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_NovaChave")
            USE IN cursor_4c_NovaChave
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * ObterProximoCodigo - Gera proximo Cods numerico disponivel em SigCdCnL
    *==========================================================================
    PROTECTED FUNCTION ObterProximoCodigo()
        LOCAL loc_cCodigo, loc_lSucesso
        loc_cCodigo  = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(CAST(cods AS bigint)), 0) + 1 AS proximo FROM sigcdcnl", ;
                "cursor_4c_ProxCod") > 0
            IF loc_lSucesso
                SELECT cursor_4c_ProxCod
                loc_cCodigo = ALLTRIM(STR(cursor_4c_ProxCod.proximo, 10))
            ELSE
                MsgErro("Erro ao obter pr" + CHR(243) + "ximo c" + CHR(243) + "digo: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterProximoCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_cCodigo
    ENDFUNC

ENDDEFINE

