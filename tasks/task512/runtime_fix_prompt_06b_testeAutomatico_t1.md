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
[23/08/2026 12:01:56 PM] FormRPT.ConfigurarPageFrame: Property WIDTH is not found.
[23/08/2026 12:01:56 PM] FormRPT.BOParaForm: Unknown member PGF_4C_DADOS.
[23/08/2026 12:01:56 PM] FormRPT.ConfigurarModoEditor: Unknown member PGF_4C_DADOS.
[23/08/2026 12:01:56 PM] FormRPT.AlternarPagina: Unknown member PGF_4C_DADOS.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-23 12:00:21] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-23 12:00:21] [INFO] Config FPW: (nao fornecido)
[2026-08-23 12:00:21] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 12:00:21] [INFO] Timeout: 300 segundos
[2026-08-23 12:00:21] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_puwaetun.prg
[2026-08-23 12:00:21] [INFO] Conteudo do wrapper:
[2026-08-23 12:00:21] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormRPT', 'C:\4c\tasks\task512', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormRPT', 'C:\4c\tasks\task512', 'CRUD'
QUIT

[2026-08-23 12:00:21] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_puwaetun.prg
[2026-08-23 12:00:21] [INFO] VFP output esperado em: C:\4c\tasks\task512\vfp_output.txt
[2026-08-23 12:00:21] [INFO] Executando Visual FoxPro 9...
[2026-08-23 12:00:21] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_puwaetun.prg
[2026-08-23 12:00:21] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_puwaetun.prg
[2026-08-23 12:00:21] [INFO] Timeout configurado: 300 segundos
[2026-08-23 12:01:57] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-23 12:01:57] [INFO] VFP9 finalizado em 95.7417335 segundos
[2026-08-23 12:01:57] [INFO] Exit Code: 
[2026-08-23 12:01:57] [INFO] 
[2026-08-23 12:01:57] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-23 12:01:57] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_puwaetun.prg
[2026-08-23 12:01:57] [INFO] 
[2026-08-23 12:01:57] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-23 12:01:57] [INFO] * Auto-generated wrapper for parameters
[2026-08-23 12:01:57] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 12:01:57] [INFO] * Parameters: 'FormRPT', 'C:\4c\tasks\task512', 'CRUD'
[2026-08-23 12:01:57] [INFO] 
[2026-08-23 12:01:57] [INFO] * Anti-dialog protections for unattended execution
[2026-08-23 12:01:57] [INFO] SET SAFETY OFF
[2026-08-23 12:01:57] [INFO] SET RESOURCE OFF
[2026-08-23 12:01:57] [INFO] SET TALK OFF
[2026-08-23 12:01:57] [INFO] SET NOTIFY OFF
[2026-08-23 12:01:57] [INFO] SYS(2335, 0)
[2026-08-23 12:01:57] [INFO] 
[2026-08-23 12:01:57] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormRPT', 'C:\4c\tasks\task512', 'CRUD'
[2026-08-23 12:01:57] [INFO] QUIT
[2026-08-23 12:01:57] [INFO] 
[2026-08-23 12:01:57] [INFO] === Fim do Wrapper.prg ===
[2026-08-23 12:01:57] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormRPT",
  "timestamp": "20260823120156",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg):
*==============================================================================
* FormRPT.prg - Cadastro Customizado de Relatorios 4Report
* Migrado de: SIGCDRPT.SCX (Framework Fortyus MC)
* Data: 2026-08-23
* Fase: 9/9 - COMPLETO: janelas flutuantes F8/F9 (InicializarListas/AtivarListas)
*             + labels clicaveis F8/F9 em cnt_4c_HintF8F9 + LstDblClick handlers
*==============================================================================

DEFINE CLASS FormRPT AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1003
    Caption     = "Cadastro Customizado de Relatorios 4Report"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de controle
    this_oBusinessObject  = .NULL.
    this_cModoAtual       = "LISTA"

    *-- Propriedades especificas do SIGCDRPT (comportamento legado)
    this_cSetExact         = ""
    this_pcEscolha         = ""
    this_plCancelar        = .F.
    this_cArquivoRelatorio = ""
    this_oWLstTABs         = .NULL.
    this_oWLstVARs         = .NULL.

    *==========================================================================
    * Init - Apenas delega ao FormBase (que chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Fix DataSession=2: restaurar SET DATE/CENTURY (CLAUDE.md regra 9.4)
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.Caption = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    MsgErro("Conex" + CHR(227) + "o com banco de dados n" + CHR(227) + ;
                            "o estabelecida.", "Erro")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("RPTBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar RPTBO.", "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            THIS.ConfigurarPageFrame()

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.InicializarListas()
                THIS.CarregarLista()
            ENDIF

            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame externo com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .PageCount = 2
                .Tabs      = .F.
            ENDWITH

            WITH THIS.pgf_4c_Paginas.Page1
                .Caption = "Lista"
                .Width   = THIS.Width
                .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH

            WITH THIS.pgf_4c_Paginas.Page2
                .Caption = "Dados"
                .Width   = THIS.Width
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.pgf_4c_Paginas.Visible = .T.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPageFrame")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de relatorios
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top        = 31
                .Left       = 0
                .Width      = 1003
                .Height     = 80
                .BackColor  = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible    = .T.
            ENDWITH

            loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = 980
                .Height    = 40
                .Caption   = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = 980
                .Height    = 46
                .Caption   = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top        = 29
                .Left       = 542
                .Width      = 375
                .Height     = 85
                .BackStyle = 0
                .BorderWidth = 0
                .Visible    = .T.
            ENDWITH

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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

            *-- Container saida - padrao canonico (CLAUDE.md regra #10)
            loc_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPagina.cnt_4c_Saida
                .Top        = 29
                .Left       = 917
                .Width      = 90
                .Height     = 85
                .BackStyle  = 0
                .BorderWidth = 0
                .Visible    = .T.
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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            WITH loc_oPagina.grd_4c_Lista
                .Top                = 117
                .Left               = 2
                .Width              = 998
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
                .ColumnCount        = 5
                .Visible            = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 externa: botoes Confirmar/Cancelar + PageFrame interno
    *   pgf_4c_Dados.Page1 = Editor SQL (campos + editor + grade resultado)
    *   pgf_4c_Dados.Page2 = Designer layout (Fase 6)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Botoes Confirmar + Cancelar (Grupo_Salva no legado)
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top        = 33
                .Left       = 842
                .Width      = 160
                .Height     = 85
                .BackStyle = 1
                .BackColor = RGB(255, 255, 255)
                .BorderWidth = 0
                .Visible    = .T.
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
                .Visible         = .T.
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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- PageFrame interno (Pageframe1 no legado)
            *-- Top=-29 oculta abas; conteudo de Page1 usa coords SCX direto (sem offset adicional)
            loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
            WITH loc_oPagina.pgf_4c_Dados
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = 631
                .PageCount = 2
                .Tabs      = .F.
                .Visible   = .T.
            ENDWITH

            WITH loc_oPagina.pgf_4c_Dados.Page1
                .Caption = "Editor SQL"
                .Width   = THIS.Width
            ENDWITH

            WITH loc_oPagina.pgf_4c_Dados.Page2
                .Caption = "Designer"
                .Width   = THIS.Width
            ENDWITH

            THIS.ConfigurarEditorSQL(loc_oPagina.pgf_4c_Dados.Page1)
            THIS.ConfigurarDesignerLayout(loc_oPagina.pgf_4c_Dados.Page2)

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarEditorSQL - Controles da Page1 interna (Editor SQL + campos cadastro)
    * Coordenadas: direto do SCX (relativos a Page1 de pgf_4c_Dados)
    * O duplo Top=-29 dos dois pageframes se cancela: coords SCX usadas sem ajuste
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEditorSQL(par_oPage)
        TRY
            *-- Container botoes de acao SQL (CmdGrp_Acoes no legado - 3 botoes)
            par_oPage.AddObject("cnt_4c_AcoesSQL", "Container")
            WITH par_oPage.cnt_4c_AcoesSQL
                .Top        = 9
                .Left       = 15
                .Width      = 235
                .Height     = 85
                .BackColor  = RGB(53, 53, 53)
                .BackStyle  = 1
                .BorderWidth = 0
                .Visible    = .T.
            ENDWITH

            par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_Processar", "CommandButton")
            WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_Processar
                .Caption         = "Processar"
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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

            par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_VisualizarRpt", "CommandButton")
            WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_VisualizarRpt
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
            BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_VisualizarRpt, "Click", THIS, "BtnVisualizarRptClick")

            par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_Estrutura", "CommandButton")
            WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_Estrutura
                .Caption         = "Layout"
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
            BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_Estrutura, "Click", THIS, "BtnLayoutClick")

            *-- Label "Nome do Arquivo do Report:"
            par_oPage.AddObject("lbl_4c_NmReport", "Label")
            WITH par_oPage.lbl_4c_NmReport
                .Top       = 2
                .Left      = 326
                .Width     = 139
                .Height    = 15
                .Caption   = "Nome do Arquivo do Report:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox nome do relatorio (Txt_NmReport no legado)
            par_oPage.AddObject("txt_4c_NmReport", "TextBox")
            WITH par_oPage.txt_4c_NmReport
                .Top       = 14
                .Left      = 326
                .Width     = 361
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 100
                .Visible   = .T.
            ENDWITH

            *-- ComboBox para selecionar report existente (Cbo_NmReports no legado)
            par_oPage.AddObject("cbo_4c_NmReports", "ComboBox")
            WITH par_oPage.cbo_4c_NmReports
                .Top           = 13
                .Left          = 691
                .Width         = 200
                .Height        = 24
                .Style         = 2
                .FontName      = "Tahoma"
                .FontSize      = 8
                .RowSourceType = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPage.cbo_4c_NmReports, "InteractiveChange", THIS, "CboNmReportsChange")
            BINDEVENT(par_oPage.txt_4c_NmReport, "KeyPress", THIS, "NmReportLostFocus")

            *-- CheckBox Ativo (Chk_Ativo no legado)
            par_oPage.AddObject("chk_4c_Ativo", "CheckBox")
            WITH par_oPage.chk_4c_Ativo
                .Top       = 19
                .Left      = 733
                .Width     = 48
                .Height    = 15
                .Caption   = "Ativo"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Value     = 1
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Label "Descricao desse Report:"
            par_oPage.AddObject("lbl_4c_Descr", "Label")
            WITH par_oPage.lbl_4c_Descr
                .Top       = 38
                .Left      = 326
                .Width     = 119
                .Height    = 15
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o desse Report:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- EditBox descricao (Edt_Descricao no legado)
            par_oPage.AddObject("edt_4c_Descricao", "EditBox")
            WITH par_oPage.edt_4c_Descricao
                .Top        = 50
                .Left       = 326
                .Width      = 454
                .Height     = 41
                .FontName   = "Tahoma"
                .FontSize   = 8
                .ScrollBars = 3
                .Visible    = .T.
            ENDWITH

            *-- Label "Data de Criacao:"
            par_oPage.AddObject("lbl_4c_DtCriacao", "Label")
            WITH par_oPage.lbl_4c_DtCriacao
                .Top       = 92
                .Left      = 326
                .Width     = 83
                .Height    = 15
                .Caption   = "Data de Cria" + CHR(231) + CHR(227) + "o:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox data criacao - somente leitura (Txt_DtCriacao no legado)
            par_oPage.AddObject("txt_4c_DtCriacao", "TextBox")
            WITH par_oPage.txt_4c_DtCriacao
                .Top       = 104
                .Left      = 326
                .Width     = 184
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ReadOnly  = .T.
                .BackColor = RGB(240, 240, 240)
                .Visible   = .T.
            ENDWITH

            *-- Label "Data de Alteracao:"
            par_oPage.AddObject("lbl_4c_DtAlteracao", "Label")
            WITH par_oPage.lbl_4c_DtAlteracao
                .Top       = 92
                .Left      = 596
                .Width     = 93
                .Height    = 15
                .Caption   = "Data de Altera" + CHR(231) + CHR(227) + "o:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox data alteracao - somente leitura (Txt_DtAlteracao no legado)
            par_oPage.AddObject("txt_4c_DtAlteracao", "TextBox")
            WITH par_oPage.txt_4c_DtAlteracao
                .Top       = 104
                .Left      = 596
                .Width     = 184
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ReadOnly  = .T.
                .BackColor = RGB(240, 240, 240)
                .Visible   = .T.
            ENDWITH

            *-- Labels "De:" e "Ate:" para filtros de data da query SQL
            par_oPage.AddObject("lbl_4c_De", "Label")
            WITH par_oPage.lbl_4c_De
                .Top       = 132
                .Left      = 26
                .Width     = 25
                .Height    = 16
                .Caption   = "De:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPage.AddObject("txt_4c_DtDe", "TextBox")
            WITH par_oPage.txt_4c_DtDe
                .Top       = 128
                .Left      = 53
                .Width     = 100
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            par_oPage.AddObject("lbl_4c_Ate", "Label")
            WITH par_oPage.lbl_4c_Ate
                .Top       = 131
                .Left      = 164
                .Width     = 28
                .Height    = 16
                .Caption   = "At" + CHR(233) + ":"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPage.AddObject("txt_4c_DtAte", "TextBox")
            WITH par_oPage.txt_4c_DtAte
                .Top       = 128
                .Left      = 195
                .Width     = 100
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Container dica F8/F9 (Container1 no legado)
            par_oPage.AddObject("cnt_4c_HintF8F9", "Container")
            WITH par_oPage.cnt_4c_HintF8F9
                .Top        = 141
                .Left       = 326
                .Width      = 397
                .Height     = 24
                .BackStyle  = 0
                .BorderWidth = 0
                .Visible    = .T.
            ENDWITH

            par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_HintTexto", "Label")
            WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_HintTexto
                .Top       = 2
                .Left      = 3
                .Width     = 392
                .Height    = 15
                .Caption   = "Use: F8 para listar as Tabelas, e F9 para listar as Vari" + CHR(225) + "veis."
                .FontName  = "Verdana"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Lbl_F8: "F8" azul clicavel (overlay sobre texto do lbl_4c_HintTexto)
            par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_F8", "Label")
            WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F8
                .AutoSize     = .T.
                .Top          = 2
                .Left         = 35
                .Height       = 15
                .Width        = 18
                .Caption      = "F8"
                .FontName     = "Verdana"
                .FontSize     = 8
                .FontBold     = .T.
                .ForeColor    = RGB(0, 0, 255)
                .BackStyle    = 0
                .MousePointer = 15
                .Visible      = .T.
            ENDWITH
            BINDEVENT(par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F8, "Click", THIS, "LblF8Click")

            *-- Lbl_Tabelas: "Tabelas" sublinhado (overlay)
            par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_Tabelas", "Label")
            WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_Tabelas
                .AutoSize      = .T.
                .Top           = 2
                .Left          = 146
                .Height        = 15
                .Width         = 53
                .Caption       = "Tabelas"
                .FontName      = "Verdana"
                .FontSize      = 8
                .FontBold      = .T.
                .FontUnderline = .T.
                .ForeColor     = RGB(90, 90, 90)
                .BackStyle     = 0
                .Visible       = .T.
            ENDWITH

            *-- Lbl_F9: "F9" azul clicavel (overlay)
            par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_F9", "Label")
            WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F9
                .AutoSize     = .T.
                .Top          = 2
                .Left         = 217
                .Height       = 15
                .Width        = 18
                .Caption      = "F9"
                .FontName     = "Verdana"
                .FontSize     = 8
                .FontBold     = .T.
                .ForeColor    = RGB(0, 0, 255)
                .BackStyle    = 0
                .MousePointer = 15
                .Visible      = .T.
            ENDWITH
            BINDEVENT(par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F9, "Click", THIS, "LblF9Click")

            *-- Lbl_Variaveis: "Variaveis" sublinhado (overlay)
            par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_Variaveis", "Label")
            WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_Variaveis
                .AutoSize      = .T.
                .Top           = 2
                .Left          = 328
                .Height        = 15
                .Width         = 63
                .Caption       = "Vari" + CHR(225) + "veis"
                .FontName      = "Verdana"
                .FontSize      = 8
                .FontBold      = .T.
                .FontUnderline = .T.
                .ForeColor     = RGB(90, 90, 90)
                .BackStyle     = 0
                .Visible       = .T.
            ENDWITH

            *-- Indicador SQL modificado (Lbl_SQL_Alterado no legado - asterisco vermelho)
            par_oPage.AddObject("lbl_4c_SqlAlterado", "Label")
            WITH par_oPage.lbl_4c_SqlAlterado
                .Top       = 147
                .Left      = 8
                .Width     = 27
                .Height    = 17
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(255, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- EditBox SQL (OleRTF_SqlCMD no legado - substituido por EditBox nativo)
            par_oPage.AddObject("edt_4c_SqlCMD", "EditBox")
            WITH par_oPage.edt_4c_SqlCMD
                .Top        = 158
                .Left       = 8
                .Width      = 986
                .Height     = 214
                .FontName   = "Courier New"
                .FontSize   = 9
                .ScrollBars = 3
                .ReadOnly   = .F.
                .Visible    = .T.
            ENDWITH
            BINDEVENT(par_oPage.edt_4c_SqlCMD, "Change", THIS, "SqlCMDChange")

            *-- Grade de resultados SQL (FwGrade1_Resultado no legado)
            par_oPage.AddObject("grd_4c_Resultado", "Grid")
            WITH par_oPage.grd_4c_Resultado
                .Top                = 379
                .Left               = 8
                .Width              = 986
                .Height             = 218
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
                .ScrollBars         = 3
                .GridLines          = 3
                .ColumnCount        = 0
                .ReadOnly           = .T.
                .Visible            = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.ConfigurarEditorSQL")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega lista de relatorios no grid
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCad"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtModif"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"

                    *-- Redefinir headers APOS RecordSource (CRITICO - Problema 6)
                    loc_oGrid.Column1.Header1.Caption = "Titulo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Dt. Cria" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column4.Header1.Caption = "Dt. Altera" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column5.Header1.Caption = "Ativo"

                    loc_oGrid.Column1.Width = 350
                    loc_oGrid.Column2.Width = 350
                    loc_oGrid.Column3.Width = 90
                    loc_oGrid.Column4.Width = 90
                    loc_oGrid.Column5.Width = 50

                    THIS.FormatarGridLista(loc_oGrid)

                    loc_lResultado = .T.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ELSE
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo relatorio
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_pcEscolha  = "INSERIR"
            THIS.this_cModoAtual = "INCLUIR"
            THIS.BOParaForm()
            THIS.ConfigurarModoEditor(.F.)
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 para visualizar relatorio selecionado
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cRptId, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um relat" + CHR(243) + "rio para visualizar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Dados
                loc_cRptId = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
                    THIS.this_pcEscolha  = "CONSULTAR"
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.ConfigurarModoEditor(.T.)
                    THIS.AlternarPagina(2)
                ELSE
                    MsgErro("Erro ao carregar relat" + CHR(243) + "rio selecionado.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para alterar relatorio selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cRptId, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um relat" + CHR(243) + "rio para alterar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Dados
                loc_cRptId = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_pcEscolha  = "ALTERAR"
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.ConfigurarModoEditor(.F.)
                    THIS.AlternarPagina(2)
                ELSE
                    MsgErro("Erro ao carregar relat" + CHR(243) + "rio selecionado.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui relatorio selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cRptId, loc_cNmReport, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um relat" + CHR(243) + "rio para excluir.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Dados
                loc_cRptId    = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
                loc_cNmReport = ALLTRIM(NVL(cursor_4c_Dados.NmReport, ""))

                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do relat" + CHR(243) + "rio:" + ;
                               CHR(13) + loc_cNmReport + "?", ;
                               "Confirmar Exclus" + CHR(227) + "o")

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Relat" + CHR(243) + "rio exclu" + CHR(237) + "do com sucesso!")
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("Erro ao excluir relat" + CHR(243) + "rio.", "Erro")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao carregar relat" + CHR(243) + "rio para exclus" + CHR(227) + "o.", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtra lista por nome ou descricao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oGrid
        TRY
            loc_cFiltro = INPUTBOX("Digite o nome ou descri" + CHR(231) + CHR(227) + "o para buscar:", ;
                          "Buscar Relat" + CHR(243) + "rio", "")

            IF VARTYPE(loc_cFiltro) = "C"
                IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCad"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtModif"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"

                    loc_oGrid.Column1.Header1.Caption = "Titulo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Dt. Cria" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column4.Header1.Caption = "Dt. Altera" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column5.Header1.Caption = "Ativo"

                    loc_oGrid.Column1.Width = 350
                    loc_oGrid.Column2.Width = 350
                    loc_oGrid.Column3.Width = 90
                    loc_oGrid.Column4.Width = 90
                    loc_oGrid.Column5.Width = 50

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Coleta dados do form, salva via BO e volta para lista
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Relat" + CHR(243) + "rio salvo com sucesso!")
                THIS.this_plCancelar = .F.
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Erro ao salvar relat" + CHR(243) + "rio.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_plCancelar = .T.
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Executa SQL e exibe resultado na grade
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_cSQL, loc_nResultado, loc_oPage, loc_oGrid, loc_nCols, loc_nI, loc_lProsseguir
        LOCAL laFields[1]
        loc_lProsseguir = .T.
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cSQL  = ALLTRIM(loc_oPage.edt_4c_SqlCMD.Value)

            IF EMPTY(loc_cSQL)
                MsgAviso("Digite o comando SQL antes de processar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oGrid = loc_oPage.grd_4c_Resultado
                loc_oGrid.ColumnCount = 0
                IF USED("cursor_4c_SqlResult")
                    USE IN cursor_4c_SqlResult
                ENDIF
                IF USED("cursor_4c_SqlResultTemp")
                    USE IN cursor_4c_SqlResultTemp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResultTemp")

                IF loc_nResultado >= 0
                    loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResultTemp")
                    SELECT * FROM cursor_4c_SqlResultTemp INTO CURSOR cursor_4c_SqlResult READWRITE
                    IF USED("cursor_4c_SqlResultTemp")
                        USE IN cursor_4c_SqlResultTemp
                    ENDIF

                    loc_oGrid.ColumnCount = 0
                    loc_oGrid.RecordSource = "cursor_4c_SqlResult"
                    loc_oGrid.ColumnCount  = loc_nCols

                    FOR loc_nI = 1 TO loc_nCols
                        loc_oGrid.Columns(loc_nI).ControlSource = "cursor_4c_SqlResult." + laFields[loc_nI, 1]
                        loc_oGrid.Columns(loc_nI).Header1.Caption = laFields[loc_nI, 1]
                        loc_oGrid.Columns(loc_nI).Width = 100
                    ENDFOR

                    loc_oPage.lbl_4c_SqlAlterado.Caption = ""
                    THIS.this_oBusinessObject.this_cSqlQuery = loc_cSQL
                    loc_oGrid.Refresh()

                    MsgInfo(ALLTRIM(STR(RECCOUNT("cursor_4c_SqlResult"))) + ;
                            " registro(s) retornado(s).")
                ELSE
                    MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarRptClick - Executa SQL e exibe relatorio FRX correspondente
    *==========================================================================
    PROCEDURE BtnVisualizarRptClick()
        LOCAL loc_cSQL, loc_cNmReport, loc_oPage, loc_nResultado, loc_cFrxPath, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cSQL     = ALLTRIM(loc_oPage.edt_4c_SqlCMD.Value)
            loc_cNmReport = ALLTRIM(loc_oPage.txt_4c_NmReport.Value)

            IF EMPTY(loc_cSQL)
                MsgAviso("SQL n" + CHR(227) + "o definido. Processe o SQL primeiro.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(loc_cNmReport)
                MsgAviso("Nome do relat" + CHR(243) + "rio n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cFrxPath = ADDBS(gc_4c_CaminhoReports) + loc_cNmReport

                IF !FILE(loc_cFrxPath + ".frx")
                    MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                            CHR(13) + loc_cFrxPath + ".frx", "Erro")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_SqlResultTemp")
                    USE IN cursor_4c_SqlResultTemp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResultTemp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_SqlResult")
                        USE IN cursor_4c_SqlResult
                    ENDIF
                    SELECT * FROM cursor_4c_SqlResultTemp INTO CURSOR cursor_4c_SqlResult READWRITE
                    IF USED("cursor_4c_SqlResultTemp")
                        USE IN cursor_4c_SqlResultTemp
                    ENDIF
                    REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE
                ELSE
                    MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnVisualizarRptClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnLayoutClick - Executa SQL e abre o Designer de Layout
    *==========================================================================
    PROCEDURE BtnLayoutClick()
        LOCAL loc_cSQL, loc_nResultado, loc_nCols, loc_nI, loc_lProsseguir
        LOCAL laFields[1]
        LOCAL loc_oEditorPage, loc_oDesignerPage, loc_oPgfDados
        loc_lProsseguir = .T.
        TRY
            loc_oPgfDados   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados
            loc_oEditorPage = loc_oPgfDados.Page1
            loc_cSQL        = ALLTRIM(loc_oEditorPage.edt_4c_SqlCMD.Value)

            IF EMPTY(loc_cSQL)
                MsgAviso("Digite o comando SQL antes de abrir o designer.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Executa SQL para obter estrutura dos campos
                IF USED("cursor_4c_SqlResultTemp")
                    USE IN cursor_4c_SqlResultTemp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResultTemp")

                IF loc_nResultado >= 0
                    loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResultTemp")
                    IF USED("cursor_4c_SqlResult")
                        USE IN cursor_4c_SqlResult
                    ENDIF
                    SELECT * FROM cursor_4c_SqlResultTemp INTO CURSOR cursor_4c_SqlResult READWRITE
                    IF USED("cursor_4c_SqlResultTemp")
                        USE IN cursor_4c_SqlResultTemp
                    ENDIF

                    IF loc_nCols = 0
                        MsgAviso("O SQL n" + CHR(227) + "o retornou campos.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lProsseguir = .F.
                    ENDIF
                ELSE
                    MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Cria/recria cursores do designer
                THIS.CriarCursoresDesigner()

                *-- Popula CrsProps_Titulo com 1 linha de titulo
                IF USED("CrsProps_Titulo")
                    SELECT CrsProps_Titulo
                    IF RECCOUNT("CrsProps_Titulo") = 0
                        APPEND BLANK
                        REPLACE CrsProps_Titulo.NmCampo    WITH "TITULO"
                        REPLACE CrsProps_Titulo.LblCaption WITH ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)
                        REPLACE CrsProps_Titulo.LblFonte   WITH "Arial,12,B"
                        REPLACE CrsProps_Titulo.LblAlinhar WITH "C"
                        REPLACE CrsProps_Titulo.LblTamCmp  WITH 200
                    ENDIF
                ENDIF

                *-- Popula CrsProps_Campos com um registro por campo do resultado SQL
                IF USED("CrsProps_Campos")
                    SELECT CrsProps_Campos
                    ZAP
                    FOR loc_nI = 1 TO loc_nCols
                        APPEND BLANK
                        REPLACE CrsProps_Campos.NmCampo    WITH ALLTRIM(laFields[loc_nI, 1])
                        REPLACE CrsProps_Campos.TpCampo    WITH ALLTRIM(laFields[loc_nI, 2])
                        REPLACE CrsProps_Campos.CkOutRPT   WITH 1
                        REPLACE CrsProps_Campos.CkFiltro   WITH 0
                        REPLACE CrsProps_Campos.CkSubTot   WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), 1, 0)
                        REPLACE CrsProps_Campos.CkTotal    WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), 1, 0)
                        REPLACE CrsProps_Campos.LblCaption WITH ALLTRIM(laFields[loc_nI, 1])
                        REPLACE CrsProps_Campos.LblFonte   WITH "Arial,9,N"
                        REPLACE CrsProps_Campos.LblAlinhar WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), "R", "L")
                        REPLACE CrsProps_Campos.LblTamCmp  WITH IIF(laFields[loc_nI, 3] > 0, laFields[loc_nI, 3], 10)
                        REPLACE CrsProps_Campos.LblTipoCmp WITH laFields[loc_nI, 2]
                    ENDFOR
                    GO TOP
                ENDIF

                *-- Vincula cursores as grades do designer
                loc_oDesignerPage = loc_oPgfDados.Page2
                loc_oDesignerPage.grd_4c_TIT.RecordSource  = "CrsProps_Titulo"
                loc_oDesignerPage.grd_4c_CMPs.RecordSource = "CrsProps_Campos"
                loc_oDesignerPage.grd_4c_GRP.RecordSource  = "CrsProps_GRP"
                loc_oDesignerPage.grd_4c_TIT.Refresh()
                loc_oDesignerPage.grd_4c_CMPs.Refresh()
                loc_oDesignerPage.grd_4c_GRP.Refresh()

                *-- Navega para o Designer (Page2 do pgf_4c_Dados)
                loc_oPgfDados.ActivePage = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnLayoutClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SqlCMDChange - Marca asterisco quando SQL e editado (evento BINDEVENT)
    *==========================================================================
    PROCEDURE SqlCMDChange()
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.lbl_4c_SqlAlterado.Caption = "*"
        CATCH TO loc_oErro
            *-- Indicador nao critico; silencioso
        ENDTRY
    ENDPROC

    *==========================================================================
    * CboNmReportsChange - Preenche txt_4c_NmReport ao selecionar report existente
    *==========================================================================
    PROCEDURE CboNmReportsChange()
        LOCAL loc_oPage, loc_cSelecionado
        TRY
            loc_oPage        = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cSelecionado = ALLTRIM(loc_oPage.cbo_4c_NmReports.Value)
            IF !EMPTY(loc_cSelecionado)
                loc_oPage.txt_4c_NmReport.Value = loc_cSelecionado
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.CboNmReportsChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPage, loc_oBO
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_oBO   = THIS.this_oBusinessObject

            loc_oBO.this_cNmReport = ALLTRIM(loc_oPage.txt_4c_NmReport.Value)
            loc_oBO.this_cDescr    = ALLTRIM(loc_oPage.edt_4c_Descricao.Value)
            loc_oBO.this_lAtivo    = (loc_oPage.chk_4c_Ativo.Value = 1)
            loc_oBO.this_cSqlQuery = loc_oPage.edt_4c_SqlCMD.Value
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para o Form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPage, loc_oBO, loc_cSqlQuery
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_oBO   = THIS.this_oBusinessObject

            loc_oPage.txt_4c_NmReport.Value    = loc_oBO.this_cNmReport
            loc_oPage.edt_4c_Descricao.Value   = loc_oBO.this_cDescr
            loc_oPage.chk_4c_Ativo.Value       = IIF(loc_oBO.this_lAtivo, 1, 0)
            loc_oPage.txt_4c_DtCriacao.Value   = IIF(EMPTY(loc_oBO.this_dDtCriacao), "", DTOC(loc_oBO.this_dDtCriacao))
            loc_oPage.txt_4c_DtAlteracao.Value = IIF(EMPTY(loc_oBO.this_dDtAlteracao), "", DTOC(loc_oBO.this_dDtAlteracao))

            *-- SqlQuery pode estar vazio se CarregarPorCodigo nao trouxe o campo memo
            loc_cSqlQuery = loc_oBO.this_cSqlQuery
            IF EMPTY(ALLTRIM(loc_cSqlQuery)) AND !EMPTY(ALLTRIM(loc_oBO.this_cRptId))
                loc_cSqlQuery = loc_oBO.CarregarSqlQuery(loc_oBO.this_cRptId)
            ENDIF
            loc_oPage.edt_4c_SqlCMD.Value = loc_cSqlQuery

            loc_oPage.lbl_4c_SqlAlterado.Caption = ""

            THIS.PopularComboReports()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarModoEditor - Habilita/desabilita campos conforme modo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarModoEditor(par_lSomenteLeitura)
        LOCAL loc_oPage, loc_lRO
        loc_lRO = (VARTYPE(par_lSomenteLeitura) = "L" AND par_lSomenteLeitura)
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

            loc_oPage.txt_4c_NmReport.ReadOnly  = loc_lRO
            loc_oPage.edt_4c_Descricao.ReadOnly = loc_lRO
            loc_oPage.chk_4c_Ativo.Enabled      = !loc_lRO
            loc_oPage.edt_4c_SqlCMD.ReadOnly    = loc_lRO
            loc_oPage.cbo_4c_NmReports.Enabled  = !loc_lRO

            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lRO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.ConfigurarModoEditor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PopularComboReports - Carrega nomes de relatorios existentes no combobox
    *==========================================================================
    PROTECTED PROCEDURE PopularComboReports()
        LOCAL loc_nRes
        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                RETURN
            ENDIF

            IF USED("cursor_4c_ReportNomes")
                USE IN cursor_4c_ReportNomes
            ENDIF

            loc_nRes = SQLEXEC(gnConnHandle, ;
                       "SELECT DISTINCT NmReport FROM SIGCDRLC ORDER BY NmReport", ;
                       "cursor_4c_ReportNomes")

            IF loc_nRes >= 0
                WITH THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.cbo_4c_NmReports
                    .RowSourceType = 2
                    .RowSource     = "cursor_4c_ReportNomes"
                    .BoundColumn   = 1
                    .ColumnCount   = 1
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.PopularComboReports")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarDesignerLayout - Page2 interna (Designer de Layout do Relatorio)
    * Fase 5 Parte 2: botoes Voltar/SalvarRPT, labels, orientacao, tamanho papel
    * Coords: direto do SCX Pageframe1.Page2 (sem ajuste - simetria dos dois Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDesignerLayout(par_oPage)
        TRY
            *-- Container botoes de acao do designer (CmdGrp_Acoes no legado - 2 botoes)
            par_oPage.AddObject("cnt_4c_AcoesDesigner", "Container")
            WITH par_oPage.cnt_4c_AcoesDesigner
                .Top         = 8
                .Left        = 11
                .Width       = 160
                .Height      = 85
                .BackColor   = RGB(53, 53, 53)
                .BackStyle   = 1
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            par_oPage.cnt_4c_AcoesDesigner.AddObject("cmd_4c_VoltarEditor", "CommandButton")
            WITH par_oPage.cnt_4c_AcoesDesigner.cmd_4c_VoltarEditor
                .Caption         = "Voltar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(par_oPage.cnt_4c_AcoesDesigner.cmd_4c_VoltarEditor, "Click", THIS, "BtnVoltarEditorClick")

            par_oPage.cnt_4c_AcoesDesigner.AddObject("cmd_4c_SalvarRPT", "CommandButton")
            WITH par_oPage.cnt_4c_AcoesDesigner.cmd_4c_SalvarRPT
                .Caption         = "Salvar RPT"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
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
            BINDEVENT(par_oPage.cnt_4c_AcoesDesigner.cmd_4c_SalvarRPT, "Click", THIS, "BtnSalvarRPTClick")

            *-- Imagem orientacao (Img_Orientacao no legado)
            par_oPage.AddObject("img_4c_Orientacao", "Image")
            WITH par_oPage.img_4c_Orientacao
                .Top     = 6
                .Left    = 603
                .Width   = 130
                .Height  = 116
                .Stretch = 2
                .Picture = gc_4c_CaminhoIcones + "rpt_orientacao_retrato_26.jpg"
                .Visible = .T.
            ENDWITH

            *-- OptionGroup orientacao Retrato/Paisagem (OptGrp_Orientacao no legado)
            par_oPage.AddObject("opt_4c_Orientacao", "OptionGroup")
            WITH par_oPage.opt_4c_Orientacao
                .Top         = 126
                .Left        = 580
                .Width       = 185
                .Height      = 28
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.
            ENDWITH
            WITH par_oPage.opt_4c_Orientacao.Buttons(1)
                .Caption   = "Retrato"
                .BackStyle = 0
                .Left      = 5
                .Top       = 5
                .Width     = 72
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH par_oPage.opt_4c_Orientacao.Buttons(2)
                .Caption   = "Paisagem"
                .BackStyle = 0
                .Left      = 90
                .Top       = 5
                .Width     = 85
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            BINDEVENT(par_oPage.opt_4c_Orientacao, "InteractiveChange", THIS, "OptOrientacaoChanged")

            *-- Label "Tamanho do Papel:" (Lbl_TamPapel no legado)
            par_oPage.AddObject("lbl_4c_TamPapel", "Label")
            WITH par_oPage.lbl_4c_TamPapel
                .Top       = 48
                .Left      = 202
                .Width     = 108
                .Height    = 16
                .Caption   = "Tamanho do Papel:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- ComboBox tamanho papel (Cbo_TamPapel no legado)
            par_oPage.AddObject("cbo_4c_TamPapel", "ComboBox")
            WITH par_oPage.cbo_4c_TamPapel
                .Top           = 71
                .Left          = 202
                .Width         = 348
                .Height        = 24
                .Style         = 2
                .FontName      = "Tahoma"
                .FontSize      = 8
                .RowSourceType = 0
                .ColumnCount   = 1
                .BoundColumn   = 1
                .Visible       = .T.
            ENDWITH
            THIS.PopularCboTamPapel(par_oPage.cbo_4c_TamPapel)

            *-- Label nome do relatorio (Lbl_Nm_Relatorio no legado)
            par_oPage.AddObject("lbl_4c_NmRelatorio", "Label")
            WITH par_oPage.lbl_4c_NmRelatorio
                .Top       = 131
                .Left      = 10
                .Width     = 540
                .Height    = 22
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 10
                .FontBold  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Label "Titulo do Relatorio:" (Label1 no legado)
            par_oPage.AddObject("lbl_4c_TituloRel", "Label")
            WITH par_oPage.lbl_4c_TituloRel
                .Top       = 162
                .Left      = 10
                .Width     = 110
                .Height    = 16
                .Caption   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio: "
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            THIS.ConfigurarGradesDesigner(par_oPage)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.ConfigurarDesignerLayout")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVoltarEditorClick - Volta para Page1 do designer (Editor SQL)
    *==========================================================================
    PROCEDURE BtnVoltarEditorClick()
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnVoltarEditorClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarRPTClick - Salva FRX do relatorio com configuracoes do designer
    *==========================================================================
    PROCEDURE BtnSalvarRPTClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            this.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Layout do relat" + CHR(243) + "rio salvo com sucesso!")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao salvar layout do relat" + CHR(243) + "rio.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnSalvarRPTClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * OptOrientacaoChanged - Atualiza imagem ao mudar orientacao
    *==========================================================================
    PROCEDURE OptOrientacaoChanged()
        LOCAL loc_oPage, loc_cImg
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF loc_oPage.opt_4c_Orientacao.Value = 1
                loc_cImg = gc_4c_CaminhoIcones + "rpt_orientacao_retrato_26.jpg"
            ELSE
                loc_cImg = gc_4c_CaminhoIcones + "rpt_orientacao_paisagem_26.jpg"
            ENDIF
            IF FILE(loc_cImg)
                loc_oPage.img_4c_Orientacao.Picture = loc_cImg
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.OptOrientacaoChanged")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PopularCboTamPapel - Popula ComboBox com 41 tamanhos de papel (legado exato)
    *==========================================================================
    PROTECTED PROCEDURE PopularCboTamPapel(par_oCbo)
        LOCAL laPaperSize[41], loc_i, loc_cItems
        TRY
            laPaperSize[ 1] = "Letter, 8 1/2 x 11 in"
            laPaperSize[ 2] = "Letter Small, 8 1/2 x 11 in"
            laPaperSize[ 3] = "Tabloid, 11 x 17 in"
            laPaperSize[ 4] = "Ledger, 17 x 11 in"
            laPaperSize[ 5] = "Legal, 8 1/2 x 14 in"
            laPaperSize[ 6] = "Statement, 5 1/2 x 8 1/2 in"
            laPaperSize[ 7] = "Executive, 7 1/4 x 10 1/2 in"
            laPaperSize[ 8] = "A3, 297 x 420 mm"
            laPaperSize[ 9] = "A4, 210 x 297 mm"
            laPaperSize[10] = "A4, Small 210 x 297 mm"
            laPaperSize[11] = "A5, 148 x 210 mm"
            laPaperSize[12] = "B4 (JIS) 250 x 354 mm"
            laPaperSize[13] = "B5 (JIS) 182 x 257 mm"
            laPaperSize[14] = "Folio, 8 1/2 x 13 in"
            laPaperSize[15] = "Quarto, 215 x 275 mm"
            laPaperSize[16] = "10x14 in"
            laPaperSize[17] = "11x17 in"
            laPaperSize[18] = "Note, 8 1/2 x 11 in"
            laPaperSize[19] = "#9 Envelope, 3 7/8 x 8 7/8 in"
            laPaperSize[20] = "#10 Envelope, 4 1/8 x 9 1/2 in"
            laPaperSize[21] = "#11 Envelope, 4 1/2 x 10 3/8 in"
            laPaperSize[22] = "#12 Envelope, 4 3/4 x 11 in"
            laPaperSize[23] = "#14 Envelope, 5 x 11 1/2 in"
            laPaperSize[24] = "C size sheet"
            laPaperSize[25] = "D size sheet"
            laPaperSize[26] = "E size sheet"
            laPaperSize[27] = "DL Envelope, 110 x 220 mm"
            laPaperSize[28] = "C5 Envelope, 162 x 229 mm"
            laPaperSize[29] = "C3 Envelope, 324 x 458 mm"
            laPaperSize[30] = "C4 Envelope, 229 x 324 mm"
            laPaperSize[31] = "C6 Envelope, 114 x 162 mm"
            laPaperSize[32] = "C65 Envelope, 114 x 229 mm"
            laPaperSize[33] = "B4 Envelope, 250 x 353 mm"
            laPaperSize[34] = "B5 Envelope, 176 x 250 mm"
            laPaperSize[35] = "B6 Envelope, 176 x 125 mm"
            laPaperSize[36] = "Italy Envelope, 110 x 230 mm"
            laPaperSize[37] = "Monarch Envelope, 3 7/8 x 7 1/2 in"
            laPaperSize[38] = "6 3/4 Envelope, 3 5/8 x 6 1/2 in"
            laPaperSize[39] = "US Std Fanfold, 14 7/8 x 11 in"
            laPaperSize[40] = "German Std Fanfold, 8 1/2 x 12 in"
            laPaperSize[41] = "German Legal Fanfold, 8 1/2 x 13 in"

            loc_cItems = ""
            FOR loc_i = 1 TO 41
                loc_cItems = loc_cItems + IIF(loc_i > 1, ",", "") + laPaperSize[loc_i]
            ENDFOR

            par_oCbo.RowSourceType = 1
            par_oCbo.RowSource     = loc_cItems
            par_oCbo.ListIndex     = 9
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.PopularCboTamPapel")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGradesDesigner - Fase 6: 3 grades da Page2 interna (Designer)
    * grd_4c_TIT (5 cols/Top=180), grd_4c_CMPs (12 cols/Top=258), grd_4c_GRP (7 cols/Top=529)
    * RecordSource definido em runtime quando cursor de dados e carregado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradesDesigner(par_oPage)
        LOCAL loc_oGrd, loc_oCol
        TRY
            *=== GRADE 1: grd_4c_TIT (FwGrade1_TIT) - titulo/cabecalho, 5 colunas ===
            par_oPage.AddObject("grd_4c_TIT", "Grid")
            loc_oGrd = par_oPage.grd_4c_TIT
            WITH loc_oGrd
                .Top              = 180
                .Left             = 4
                .Width            = 990
                .Height           = 65
                .ColumnCount      = 5
                .RecordSourceType = 1
                .RecordSource     = ""
                .GridLines        = 1
                .HeaderHeight     = 25
                .RowHeight        = 30
                .DeleteMark       = .F.
                .RecordMark       = .F.
                .ScrollBars       = 2
                .Visible          = .T.
            ENDWITH

            *- Col1: LblCaption - "Titulo" (EditBox)
            loc_oCol = loc_oGrd.Column1
            loc_oCol.Header1.Caption = "Titulo"
            loc_oCol.Width  = 300
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("edt_4c_TitCaption", "EditBox")
            loc_oCol.CurrentControl = "edt_4c_TitCaption"
            WITH loc_oCol.edt_4c_TitCaption
                .Width      = 298
                .Height     = 28
                .ScrollBars = 0
            ENDWITH

            *- Col2: LblFonte - "Fonte" (EditBox - string "FontName,Size,Style")
            loc_oCol = loc_oGrd.Column2
            loc_oCol.Header1.Caption = "Fonte"
            loc_oCol.Width  = 230
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("edt_4c_TitFonte", "EditBox")
            loc_oCol.CurrentControl = "edt_4c_TitFonte"
            WITH loc_oCol.edt_4c_TitFonte
                .Width      = 228
                .Height     = 28
                .ScrollBars = 0
            ENDWITH

            *- Col3: BtFonte - "Fte" (CommandButton - abre dialogo GETFONT)
            loc_oCol = loc_oGrd.Column3
            loc_oCol.Header1.Caption = "Fte"
            loc_oCol.Width  = 80
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cmd_4c_FonteTIT", "CommandButton")
            loc_oCol.CurrentControl = "cmd_4c_FonteTIT"
            WITH loc_oCol.cmd_4c_FonteTIT
                .Caption       = "..."
                .Width         = 75
                .Height        = 25
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH
            BINDEVENT(loc_oCol.cmd_4c_FonteTIT, "Click", THIS, "BtnFonteTITClick")

            *- Col4: BtCor - "Cor" (CommandButton - abre GETCOLOR)
            loc_oCol = loc_oGrd.Column4
            loc_oCol.Header1.Caption = "Cor"
            loc_oCol.Width  = 80
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cmd_4c_CorTIT", "CommandButton")
            loc_oCol.CurrentControl = "cmd_4c_CorTIT"
            WITH loc_oCol.cmd_4c_CorTIT
                .Caption       = "..."
                .Width         = 75
                .Height        = 25
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH
            BINDEVENT(loc_oCol.cmd_4c_CorTIT, "Click", THIS, "BtnCorTITClick")

            *- Col5: LblAlinhar - "Alinhar" (ComboBox Esq./Cen./Dir.)
            loc_oCol = loc_oGrd.Column5
            loc_oCol.Header1.Caption = "Alinhar"
            loc_oCol.Width  = 300
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cbo_4c_AlinharTIT", "ComboBox")
            loc_oCol.CurrentControl = "cbo_4c_AlinharTIT"
            WITH loc_oCol.cbo_4c_AlinharTIT
                .Style         = 2
                .RowSourceType = 1
                .RowSource     = "Esq.,Cen.,Dir."
                .Width         = 120
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH

            *=== GRADE 2: grd_4c_CMPs (FwGrade2_CMPs) - campos do relatorio, 12 colunas ===
            par_oPage.AddObject("grd_4c_CMPs", "Grid")
            loc_oGrd = par_oPage.grd_4c_CMPs
            WITH loc_oGrd
                .Top              = 258
                .Left             = 4
                .Width            = 990
                .Height           = 238
                .ColumnCount      = 12
                .RecordSourceType = 1
                .RecordSource     = ""
                .GridLines        = 1
                .HeaderHeight     = 25
                .RowHeight        = 30
                .DeleteMark       = .F.
                .RecordMark       = .F.
                .ScrollBars       = 3
                .Visible          = .T.
            ENDWITH

            *- Col1: NmCampo - "Campo" (TextBox, readonly - nome do campo do SQL)
            loc_oCol = loc_oGrd.Column1
            loc_oCol.Header1.Caption = "Campo"
            loc_oCol.Width    = 140
            loc_oCol.Sparse   = .F.
            loc_oCol.ReadOnly = .T.
            loc_oCol.AddObject("txt_4c_NmCampo", "TextBox")
            loc_oCol.CurrentControl = "txt_4c_NmCampo"
            WITH loc_oCol.txt_4c_NmCampo
                .Width     = 138
                .Height    = 23
                .ReadOnly  = .T.
                .BackColor = RGB(240, 240, 240)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH

            *- Col2: TpCampo - "Tipo" (TextBox, readonly - tipo do campo)
            loc_oCol = loc_oGrd.Column2
            loc_oCol.Header1.Caption = "Tipo"
            loc_oCol.Width    = 75
            loc_oCol.Sparse   = .F.
            loc_oCol.ReadOnly = .T.
            loc_oCol.AddObject("txt_4c_TpCampo", "TextBox")
            loc_oCol.CurrentControl = "txt_4c_TpCampo"
            WITH loc_oCol.txt_4c_TpCampo
                .Width     = 73
                .Height    = 23
                .ReadOnly  = .T.
                .BackColor = RGB(240, 240, 240)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH

            *- Col3: CkOutRPT - "Saida Rel." (CheckBox - inclui campo na saida do relatorio)
            loc_oCol = loc_oGrd.Column3
            loc_oCol.Header1.Caption = "Sa" + CHR(237) + "da Rel."
            loc_oCol.Width  = 60
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("chk_4c_SaidaRPT", "CheckBox")
            loc_oCol.CurrentControl = "chk_4c_SaidaRPT"
            WITH loc_oCol.chk_4c_SaidaRPT
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .F.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
            ENDWITH

            *- Col4: CkFiltro - "Filtro" (CheckBox - habilita como filtro)
            loc_oCol = loc_oGrd.Column4
            loc_oCol.Header1.Caption = "Filtro"
            loc_oCol.Width  = 50
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("chk_4c_CkFiltro", "CheckBox")
            loc_oCol.CurrentControl = "chk_4c_CkFiltro"
            WITH loc_oCol.chk_4c_CkFiltro
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .F.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
            ENDWITH

            *- Col5: CkSubTot - "SubTot" (CheckBox - subtotalizar)
            loc_oCol = loc_oGrd.Column5
            loc_oCol.Header1.Caption = "SubTot"
            loc_oCol.Width  = 55
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("chk_4c_CkSubTot", "CheckBox")
            loc_oCol.CurrentControl = "chk_4c_CkSubTot"
            WITH loc_oCol.chk_4c_CkSubTot
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .F.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
            ENDWITH

            *- Col6: CkTotal - "Total" (CheckBox - total final)
            loc_oCol = loc_oGrd.Column6
            loc_oCol.Header1.Caption = "Total"
            loc_oCol.Width  = 50
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("chk_4c_CkTotal", "CheckBox")
            loc_oCol.CurrentControl = "chk_4c_CkTotal"
            WITH loc_oCol.chk_4c_CkTotal
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .F.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
            ENDWITH

            *- Col7: LblCaption - "Titulo do Campo" (EditBox - rotulo da coluna no relatorio)
            loc_oCol = loc_oGrd.Column7
            loc_oCol.Header1.Caption = "Titulo do Campo"
            loc_oCol.Width  = 130
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("edt_4c_LblCaption", "EditBox")
            loc_oCol.CurrentControl = "edt_4c_LblCaption"
            WITH loc_oCol.edt_4c_LblCaption
                .Width      = 128
                .Height     = 28
                .ScrollBars = 0
                .FontName   = "Tahoma"
                .FontSize   = 8
            ENDWITH

            *- Col8: LblFonte - "Fonte" (EditBox - fonte da coluna)
            loc_oCol = loc_oGrd.Column8
            loc_oCol.Header1.Caption = "Fonte"
            loc_oCol.Width  = 130
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("edt_4c_LblFonte", "EditBox")
            loc_oCol.CurrentControl = "edt_4c_LblFonte"
            WITH loc_oCol.edt_4c_LblFonte
                .Width      = 128
                .Height     = 28
                .ScrollBars = 0
                .FontName   = "Tahoma"
                .FontSize   = 8
            ENDWITH

            *- Col9: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
            loc_oCol = loc_oGrd.Column9
            loc_oCol.Header1.Caption = "Fte"
            loc_oCol.Width  = 65
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cmd_4c_FonteCMP", "CommandButton")
            loc_oCol.CurrentControl = "cmd_4c_FonteCMP"
            WITH loc_oCol.cmd_4c_FonteCMP
                .Caption       = "..."
                .Width         = 60
                .Height        = 25
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH
            BINDEVENT(loc_oCol.cmd_4c_FonteCMP, "Click", THIS, "BtnFonteCMPClick")

            *- Col10: LblBtCor - "Cor" (CommandButton - abre GETCOLOR)
            loc_oCol = loc_oGrd.Column10
            loc_oCol.Header1.Caption = "Cor"
            loc_oCol.Width  = 65
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cmd_4c_CorCMP", "CommandButton")
            loc_oCol.CurrentControl = "cmd_4c_CorCMP"
            WITH loc_oCol.cmd_4c_CorCMP
                .Caption       = "..."
                .Width         = 60
                .Height        = 25
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH
            BINDEVENT(loc_oCol.cmd_4c_CorCMP, "Click", THIS, "BtnCorCMPClick")

            *- Col11: LblAlinhar - "Alinhar" (ComboBox)
            loc_oCol = loc_oGrd.Column11
            loc_oCol.Header1.Caption = "Alinhar"
            loc_oCol.Width  = 80
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cbo_4c_AlinharCMP", "ComboBox")
            loc_oCol.CurrentControl = "cbo_4c_AlinharCMP"
            WITH loc_oCol.cbo_4c_AlinharCMP
                .Style         = 2
                .RowSourceType = 1
                .RowSource     = "Esq.,Cen.,Dir."
                .Width         = 75
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH

            *- Col12: LblTamCmp - "Tam." (Spinner - tamanho da fonte)
            loc_oCol = loc_oGrd.Column12
            loc_oCol.Header1.Caption = "Tam."
            loc_oCol.Width  = 90
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("spn_4c_TamCMP", "Spinner")
            loc_oCol.CurrentControl = "spn_4c_TamCMP"
            WITH loc_oCol.spn_4c_TamCMP
                .Width            = 85
                .Height           = 24
                .SpinnerLowValue  = 6
                .SpinnerHighValue = 72
                .Increment        = 1
            ENDWITH

            *=== Label "Totalizar pelo Campo:..." (Lbl_CmpGrupo) ===
            par_oPage.AddObject("lbl_4c_CmpGrupo", "Label")
            WITH par_oPage.lbl_4c_CmpGrupo
                .Top       = 510
                .Left      = 10
                .Width     = 316
                .Height    = 16
                .Caption   = "Totalizar pelo Campo: ( Use o clique direito, para apagar )"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *=== GRADE 3: grd_4c_GRP (FwGrade3_GRP) - grupos/totalizacao, 7 colunas ===
            par_oPage.AddObject("grd_4c_GRP", "Grid")
            loc_oGrd = par_oPage.grd_4c_GRP
            WITH loc_oGrd
                .Top              = 529
                .Left             = 4
                .Width            = 989
                .Height           = 67
                .ColumnCount      = 7
                .RecordSourceType = 1
                .RecordSource     = ""
                .GridLines        = 1
                .HeaderHeight     = 25
                .RowHeight        = 30
                .DeleteMark       = .F.
                .RecordMark       = .F.
                .ScrollBars       = 2
                .Visible          = .T.
            ENDWITH

            *- Col1: NmCampo - "Grupo" (ComboBox - escolhe campo do SQL como agrupador)
            loc_oCol = loc_oGrd.Column1
            loc_oCol.Header1.Caption = "Grupo"
            loc_oCol.Width  = 200
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cbo_4c_NmCampoGRP", "ComboBox")
            loc_oCol.CurrentControl = "cbo_4c_NmCampoGRP"
            WITH loc_oCol.cbo_4c_NmCampoGRP
                .Style         = 2
                .RowSourceType = 1
                .RowSource     = ""
                .Width         = 195
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH

            *- Col2: LblCaption - "Titulo do Campo" (EditBox)
            loc_oCol = loc_oGrd.Column2
            loc_oCol.Header1.Caption = "Titulo do Campo"
            loc_oCol.Width  = 160
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("edt_4c_GrpCaption", "EditBox")
            loc_oCol.CurrentControl = "edt_4c_GrpCaption"
            WITH loc_oCol.edt_4c_GrpCaption
                .Width      = 158
                .Height     = 28
                .ScrollBars = 0
                .FontName   = "Tahoma"
                .FontSize   = 8
            ENDWITH

            *- Col3: LblFonte - "Fonte" (EditBox)
            loc_oCol = loc_oGrd.Column3
            loc_oCol.Header1.Caption = "Fonte"
            loc_oCol.Width  = 160
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("edt_4c_GrpFonte", "EditBox")
            loc_oCol.CurrentControl = "edt_4c_GrpFonte"
            WITH loc_oCol.edt_4c_GrpFonte
                .Width      = 158
                .Height     = 28
                .ScrollBars = 0
                .FontName   = "Tahoma"
                .FontSize   = 8
            ENDWITH

            *- Col4: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
            loc_oCol = loc_oGrd.Column4
            loc_oCol.Header1.Caption = "Fte"
            loc_oCol.Width  = 80
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cmd_4c_FonteGRP", "CommandButton")
            loc_oCol.CurrentControl = "cmd_4c_FonteGRP"
            WITH loc_oCol.cmd_4c_FonteGRP
                .Caption       = "..."
                .Width         = 75
                .Height        = 25
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH
            BINDEVENT(loc_oCol.cmd_4c_FonteGRP, "Click", THIS, "BtnFonteGRPClick")

            *- Col5: BtCor - "Cor" (CommandButton - abre GETCOLOR)
            loc_oCol = loc_oGrd.Column5
            loc_oCol.Header1.Caption = "Cor"
            loc_oCol.Width  = 80
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cmd_4c_CorGRP", "CommandButton")
            loc_oCol.CurrentControl = "cmd_4c_CorGRP"
            WITH loc_oCol.cmd_4c_CorGRP
                .Caption       = "..."
                .Width         = 75
                .Height        = 25
                .SpecialEffect = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH
            BINDEVENT(loc_oCol.cmd_4c_CorGRP, "Click", THIS, "BtnCorGRPClick")

            *- Col6: LblAlinhar - "Alinhar" (ComboBox)
            loc_oCol = loc_oGrd.Column6
            loc_oCol.Header1.Caption = "Alinhar"
            loc_oCol.Width  = 160
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("cbo_4c_AlinharGRP", "ComboBox")
            loc_oCol.CurrentControl = "cbo_4c_AlinharGRP"
            WITH loc_oCol.cbo_4c_AlinharGRP
                .Style         = 2
                .RowSourceType = 1
                .RowSource     = "Esq.,Cen.,Dir."
                .Width         = 155
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
            ENDWITH

            *- Col7: LblTamCmp - "Tam." (Spinner)
            loc_oCol = loc_oGrd.Column7
            loc_oCol.Header1.Caption = "Tam."
            loc_oCol.Width  = 149
            loc_oCol.Sparse = .F.
            loc_oCol.AddObject("spn_4c_TamGRP", "Spinner")
            loc_oCol.CurrentControl = "spn_4c_TamGRP"
            WITH loc_oCol.spn_4c_TamGRP
                .Width            = 120
                .Height           = 24
                .SpinnerLowValue  = 6
                .SpinnerHighValue = 72
                .Increment        = 1
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.ConfigurarGradesDesigner")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnFonteTITClick - Abre GETFONT para o campo TpFonte da grade grd_4c_TIT
    *==========================================================================
    PROCEDURE BtnFonteTITClick()
        LOCAL loc_cFonte
        TRY
            loc_cFonte = GETFONT()
            IF !EMPTY(loc_cFonte) AND USED("CrsProps_Titulo") AND !EOF("CrsProps_Titulo")
                REPLACE CrsProps_Titulo.LblFonte WITH loc_cFonte IN CrsProps_Titulo
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_TIT.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnFonteTITClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCorTITClick - Abre GETCOLOR para o campo LblBtCor da grade grd_4c_TIT
    *==========================================================================
    PROCEDURE BtnCorTITClick()
        LOCAL loc_nCor
        TRY
            loc_nCor = GETCOLOR()
            IF loc_nCor >= 0 AND USED("CrsProps_Titulo") AND !EOF("CrsProps_Titulo")
                REPLACE CrsProps_Titulo.LblBtCor WITH loc_nCor IN CrsProps_Titulo
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_TIT.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnCorTITClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnFonteCMPClick - Abre GETFONT para LblFonte da linha atual de grd_4c_CMPs
    *==========================================================================
    PROCEDURE BtnFonteCMPClick()
        LOCAL loc_cFonte
        TRY
            loc_cFonte = GETFONT()
            IF !EMPTY(loc_cFonte) AND USED("CrsProps_Campos") AND !EOF("CrsProps_Campos")
                REPLACE CrsProps_Campos.LblFonte WITH loc_cFonte IN CrsProps_Campos
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_CMPs.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnFonteCMPClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCorCMPClick - Abre GETCOLOR para LblBtCor da linha atual de grd_4c_CMPs
    *==========================================================================
    PROCEDURE BtnCorCMPClick()
        LOCAL loc_nCor
        TRY
            loc_nCor = GETCOLOR()
            IF loc_nCor >= 0 AND USED("CrsProps_Campos") AND !EOF("CrsProps_Campos")
                REPLACE CrsProps_Campos.LblBtCor WITH loc_nCor IN CrsProps_Campos
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_CMPs.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnCorCMPClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnFonteGRPClick - Abre GETFONT para LblFonte da linha atual de grd_4c_GRP
    *==========================================================================
    PROCEDURE BtnFonteGRPClick()
        LOCAL loc_cFonte
        TRY
            loc_cFonte = GETFONT()
            IF !EMPTY(loc_cFonte) AND USED("CrsProps_GRP") AND !EOF("CrsProps_GRP")
                REPLACE CrsProps_GRP.LblFonte WITH loc_cFonte IN CrsProps_GRP
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_GRP.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnFonteGRPClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCorGRPClick - Abre GETCOLOR para LblBtCor da linha atual de grd_4c_GRP
    *==========================================================================
    PROCEDURE BtnCorGRPClick()
        LOCAL loc_nCor
        TRY
            loc_nCor = GETCOLOR()
            IF loc_nCor >= 0 AND USED("CrsProps_GRP") AND !EOF("CrsProps_GRP")
                REPLACE CrsProps_GRP.LblBtCor WITH loc_nCor IN CrsProps_GRP
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_GRP.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.BtnCorGRPClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
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
                ELSE
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            *-- Limpar key labels ANTES de liberar janelas flutuantes
            ON Key Label F8
            ON Key Label F9
            IF TYPE("g_oFormRPT_4c_") = "O"
                RELEASE g_oFormRPT_4c_
            ENDIF

            IF VARTYPE(THIS.this_oWLstTABs) = "O"
                THIS.this_oWLstTABs = .NULL.
            ENDIF

            IF VARTYPE(THIS.this_oWLstVARs) = "O"
                THIS.this_oWLstVARs = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_SqlResult")
                USE IN cursor_4c_SqlResult
            ENDIF
            IF USED("cursor_4c_SqlResultTemp")
                USE IN cursor_4c_SqlResultTemp
            ENDIF
            IF USED("cursor_4c_ReportNomes")
                USE IN cursor_4c_ReportNomes
            ENDIF
            IF USED("crSIGCDRLC")
                USE IN crSIGCDRLC
            ENDIF
            IF USED("Crs_RPT_C")
                USE IN Crs_RPT_C
            ENDIF
            IF USED("CrsTmp_SqlResult")
                USE IN CrsTmp_SqlResult
            ENDIF
            IF USED("CrsProps_Titulo")
                USE IN CrsProps_Titulo
            ENDIF
            IF USED("CrsProps_Campos")
                USE IN CrsProps_Campos
            ENDIF
            IF USED("CrsProps_GRP")
                USE IN CrsProps_GRP
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.Destroy")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CriarCursoresDesigner - Cria cursores de trabalho para o designer de layout
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresDesigner()
        TRY
            *-- Cursor de titulos do relatorio
            IF USED("CrsProps_Titulo")
                USE IN CrsProps_Titulo
            ENDIF
            CREATE CURSOR CrsProps_Titulo ( ;
                NmCampo    C(40),  ;
                TpCampo    C(10),  ;
                CkOutRPT   I,      ;
                CkFiltro   I,      ;
                CkSubTot   I,      ;
                CkTotal    I,      ;
                LblCaption C(200), ;
                LblFonte   C(50),  ;
                LblBtFonte C(1),   ;
                LblBtCor   I,      ;
                LblAlinhar C(6),   ;
                LblTamCmp  I,      ;
                LblTipoCmp C(1)    ;
            )

            *-- Cursor de campos do relatorio
            IF USED("CrsProps_Campos")
                USE IN CrsProps_Campos
            ENDIF
            CREATE CURSOR CrsProps_Campos ( ;
                NmCampo    C(40),  ;
                TpCampo    C(10),  ;
                CkOutRPT   I,      ;
                CkFiltro   I,      ;
                CkSubTot   I,      ;
                CkTotal    I,      ;
                LblCaption C(200), ;
                LblFonte   C(50),  ;
                LblBtFonte C(1),   ;
                LblBtCor   I,      ;
                LblAlinhar C(6),   ;
                LblTamCmp  I,      ;
                LblTipoCmp C(1)    ;
            )

            *-- Cursor de agrupamento do relatorio
            IF USED("CrsProps_GRP")
                USE IN CrsProps_GRP
            ENDIF
            CREATE CURSOR CrsProps_GRP ( ;
                NmCampo    C(40),  ;
                TpCampo    C(10),  ;
                LblCaption C(200), ;
                LblFonte   C(50),  ;
                LblBtFonte C(1),   ;
                LblBtCor   I,      ;
                LblAlinhar C(6),   ;
                LblTamCmp  I       ;
            )
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.CriarCursoresDesigner")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos do formulario de edicao
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.ConfigurarModoEditor(!par_lHabilitar)
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do formulario de edicao
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPage, loc_oErro
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_oPage.txt_4c_NmReport.Value      = ""
            loc_oPage.edt_4c_Descricao.Value     = ""
            loc_oPage.chk_4c_Ativo.Value         = 1
            loc_oPage.txt_4c_DtCriacao.Value     = ""
            loc_oPage.txt_4c_DtAlteracao.Value   = ""
            loc_oPage.edt_4c_SqlCMD.Value        = ""
            loc_oPage.lbl_4c_SqlAlterado.Caption = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lModoLista, loc_lModoEdicao, loc_oErro
        TRY
            loc_lModoLista  = (THIS.this_cModoAtual = "LISTA")
            loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lModoLista
            loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lModoLista
            loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lModoLista
            loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lModoLista
            loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lModoLista

            WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
                .cmd_4c_Confirmar.Enabled = loc_lModoEdicao
                .cmd_4c_Cancelar.Enabled  = !loc_lModoLista
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * InicializarListas - Cria janelas flutuantes Tabelas (F8) e Variaveis (F9)
    * Equivalente ao Init legado que criava oWLstTABs/oWLstVARs (CreateObject Form)
    *==========================================================================
    PROTECTED PROCEDURE InicializarListas()
        LOCAL loc_nRes
        TRY
            *-- Janela flutuante de Tabelas (F8)
            THIS.this_oWLstTABs = CREATEOBJECT("Form")
            WITH THIS.this_oWLstTABs
                .BorderStyle       = 1
                .Caption           = "Tabelas (ESC para fechar)"
                .HalfHeightCaption = .T.
                .Left              = 0
                .Top               = 0
                .Height            = 280
                .Width             = 180
                .Closable          = .F.
                .MaxButton         = .F.
                .MinButton         = .F.
                .Name              = "FrmLstTABs"
                .ShowTips          = .T.
            ENDWITH
            THIS.this_oWLstTABs.AddObject("Lst_TABs", "ListBox")
            WITH THIS.this_oWLstTABs.Lst_TABs
                .Left    = 0
                .Top     = 0
                .Height  = 280
                .Width   = 180
                .Visible = .T.
            ENDWITH
            BINDEVENT(THIS.this_oWLstTABs.Lst_TABs, "DblClick", THIS, "LstTABsDblClick")

            *-- Popula lista com tabelas do SQL Server (sys.tables = catalogo)
            IF USED("cursor_4c_Tables")
                USE IN cursor_4c_Tables
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT UPPER(name) AS NmTable FROM sysobjects WHERE xtype = 'U' ORDER BY name", ;
                "cursor_4c_Tables")
            IF loc_nRes >= 0
                SELECT cursor_4c_Tables
                SCAN
                    THIS.this_oWLstTABs.Lst_TABs.AddItem(ALLTRIM(cursor_4c_Tables.NmTable))
                ENDSCAN
                USE IN cursor_4c_Tables
            ENDIF

            *-- Janela flutuante de Variaveis (F9)
            THIS.this_oWLstVARs = CREATEOBJECT("Form")
            WITH THIS.this_oWLstVARs
                .BorderStyle       = 1
                .Caption           = "Vari" + CHR(225) + "veis (ESC para fechar)"
                .HalfHeightCaption = .T.
                .Left              = 0
                .Top               = 0
                .Height            = 100
                .Width             = 180
                .Closable          = .F.
                .MaxButton         = .F.
                .MinButton         = .F.
                .Name              = "FrmLstVARs"
                .ShowTips          = .T.
            ENDWITH
            THIS.this_oWLstVARs.AddObject("Lst_VARs", "ListBox")
            WITH THIS.this_oWLstVARs.Lst_VARs
                .Left    = 0
                .Top     = 0
                .Height  = 100
                .Width   = 180
                .Visible = .T.
            ENDWITH
            THIS.this_oWLstVARs.Lst_VARs.AddItem("?_vp_DtInicial")
            THIS.this_oWLstVARs.Lst_VARs.AddItem("?_vp_DtFinal")
            BINDEVENT(THIS.this_oWLstVARs.Lst_VARs, "DblClick", THIS, "LstVARsDblClick")

            *-- Vincular F8/F9 globalmente via PUBLIC ref (ON Key Label requer scope global)
            PUBLIC g_oFormRPT_4c_
            g_oFormRPT_4c_ = THIS
            ON Key Label F8 g_oFormRPT_4c_.AtivarListas("oWLstTABs")
            ON Key Label F9 g_oFormRPT_4c_.AtivarListas("oWLstVARs")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.InicializarListas")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtivarListas - Exibe ou oculta janela flutuante de Tabelas ou Variaveis
    * PUBLIC: chamado via ON Key Label F8/F9 e pelos labels clicaveis F8/F9
    *==========================================================================
    PROCEDURE AtivarListas(par_cTipo)
        LOCAL loc_oWLst, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF par_cTipo = "oWLstTABs"
                loc_oWLst = THIS.this_oWLstTABs
            ELSE
                loc_oWLst = THIS.this_oWLstVARs
            ENDIF

            IF VARTYPE(loc_oWLst) != "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF loc_oWLst.Visible
                    loc_oWLst.Hide()
                ELSE
                    loc_oWLst.Top  = 420
                    loc_oWLst.Left = 20
                    loc_oWLst.Show()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.AtivarListas")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LblF8Click - Clique no label "F8" abre lista de Tabelas (equivalente F8 key)
    *==========================================================================
    PROCEDURE LblF8Click()
        TRY
            THIS.AtivarListas("oWLstTABs")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.LblF8Click")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LblF9Click - Clique no label "F9" abre lista de Variaveis (equivalente F9 key)
    *==========================================================================
    PROCEDURE LblF9Click()
        TRY
            THIS.AtivarListas("oWLstVARs")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.LblF9Click")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LstTABsDblClick - Duplo clique em Tabelas insere nome da tabela no editor SQL
    *==========================================================================
    PROCEDURE LstTABsDblClick()
        LOCAL loc_cTabela, loc_oPage
        TRY
            loc_cTabela = ALLTRIM(THIS.this_oWLstTABs.Lst_TABs.DisplayValue)
            IF !EMPTY(loc_cTabela)
                loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                loc_oPage.edt_4c_SqlCMD.SelText = loc_cTabela
            ENDIF
            THIS.this_oWLstTABs.Hide()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.LstTABsDblClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LstVARsDblClick - Duplo clique em Variaveis insere var no editor SQL
    *==========================================================================
    PROCEDURE LstVARsDblClick()
        LOCAL loc_cVar, loc_oPage
        TRY
            loc_cVar = ALLTRIM(THIS.this_oWLstVARs.Lst_VARs.DisplayValue)
            IF !EMPTY(loc_cVar)
                loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                loc_oPage.edt_4c_SqlCMD.SelText = loc_cVar
            ENDIF
            THIS.this_oWLstVARs.Hide()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.LstVARsDblClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * NmReportLostFocus - Substitui "-" por "~" no nome do relatorio (comportamento legado)
    *==========================================================================
    PROCEDURE NmReportLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPage
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_oPage.txt_4c_NmReport.Value = ;
                STRTRAN(loc_oPage.txt_4c_NmReport.Value, "-", "~")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormRPT.NmReportLostFocus")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\RPTBO.prg):
*------------------------------------------------------------------------------
* RPTBO.prg - Business Object para Cadastro Customizado de Relatorios 4Report
* Herda de BusinessBase
* Tabelas principais: SIGCDRLC (cabecalho), SIGCDRLD (detalhes/layout FRX)
* Migrado de: SIGCDRPT (tasks/task512)
*------------------------------------------------------------------------------
DEFINE CLASS RPTBO AS BusinessBase

    *-- Propriedades: Cabecalho do Relatorio (SIGCDRLC)
    this_cRptId        = ""    && RPT_ID - Chave Primaria: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    this_cNmReport     = ""    && NmReport - Nome do arquivo do report
    this_cDescr        = ""    && Descr - Descricao do report
    this_lAtivo        = .T.   && Ativo - Flag ativo (1=Ativo, 0=Inativo)
    this_dDtCriacao    = {}    && DtCad - Data de criacao do report
    this_dDtAlteracao  = {}    && DtModif - Data da ultima alteracao
    this_cSqlQuery     = ""    && SqlQuery - Comando SQL do report (memo)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDRLC"
        THIS.this_cCampoChave = "RPT_ID"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cRptId
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRptId - Gera novo RPT_ID no formato original: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarRptId()
        RETURN DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT para listar relatorios no grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso  = .F.
        loc_cFiltro   = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCad, DtModif" + ;
                       " FROM SIGCDRLC"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE NmReport LIKE " + EscaparSQL("%" + loc_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY NmReport"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar relat" + CHR(243) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do relatorio por RPT_ID
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            MsgErro("RPT_ID inv" + CHR(225) + "lido para carregamento.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCad, DtModif, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorNome - Carrega cabecalho do relatorio por NmReport
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorNome(par_cNmReport)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNmReport) != "C" OR EMPTY(ALLTRIM(par_cNmReport))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCad, DtModif, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE NmReport = " + EscaparSQL(ALLTRIM(par_cNmReport))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSqlQuery - Carrega apenas o SqlQuery de um relatorio (campo memo)
    *--------------------------------------------------------------------------
    FUNCTION CarregarSqlQuery(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.
        loc_cQuery   = ""

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN ""
        ENDIF

        TRY
            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF

            loc_cSQL = "SELECT SqlQuery FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlQuery")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_SqlQuery") > 0
                SELECT cursor_4c_SqlQuery
                loc_cQuery = NVL(SqlQuery, "")
            ENDIF

            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cQuery
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCad,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtModif, "D")

            IF PEMSTATUS(ALIAS() + "", "SqlQuery", 5) OR ;
               AFIELDS(laFields, par_cAliasCursor) > 0
                IF ASCAN(laFields, "SQLQUERY") > 0
                    THIS.this_cSqlQuery = TratarNulo(SqlQuery, "C")
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursorCompleto - Mapeia TODOS os campos incluindo SqlQuery
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursorCompleto(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCad,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtModif, "D")
            THIS.this_cSqlQuery    = TratarNulo(SqlQuery,    "C")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursorCompleto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cNmReport))
            MsgAviso("Campo NOME do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cSqlQuery))
            MsgAviso("Campo SQL do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cRptId
        loc_lSucesso = .F.

        TRY
            *-- Gerar RPT_ID unico no formato original
            loc_cRptId = THIS.GerarRptId()
            THIS.this_cRptId      = loc_cRptId
            THIS.this_dDtCriacao  = DATE()
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "INSERT INTO SIGCDRLC" + ;
                       " (RPT_ID, NmReport, Descr, Ativo, DtCad, DtModif, SqlQuery)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cRptId) + ", " + ;
                       EscaparSQL(THIS.this_cNmReport) + ", " + ;
                       EscaparSQL(THIS.this_cDescr) + ", " + ;
                       IIF(THIS.this_lAtivo, "1", "0") + ", " + ;
                       FormatarDataSQL(THIS.this_dDtCriacao) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlteracao) + ", " + ;
                       EscaparSQL(THIS.this_cSqlQuery) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " NmReport = " + EscaparSQL(THIS.this_cNmReport) + "," + ;
                       " Descr = " + EscaparSQL(THIS.this_cDescr) + "," + ;
                       " Ativo = " + IIF(THIS.this_lAtivo, "1", "0") + "," + ;
                       " DtModif = " + FormatarDataSQL(THIS.this_dDtAlteracao) + "," + ;
                       " SqlQuery = " + EscaparSQL(THIS.this_cSqlQuery) + ;
                       " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SIGCDRLD + SIGCDRLC (PROTECTED)
    * Ordem obrigatoria: SIGCDRLD primeiro (filhos), depois SIGCDRLC (pai)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para exclus" + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- 1. Excluir detalhes/layout FRX (SIGCDRLD) - filhos primeiro
            loc_cSQL = "DELETE FROM SIGCDRLD WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhes do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Excluir cabecalho (SIGCDRLC) - pai depois
            loc_cSQL = "DELETE FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarSqlQuery - Atualiza apenas o campo SqlQuery de um relatorio existente
    * Chamado pelo editor SQL quando o usuario edita a query sem alterar outros campos
    *--------------------------------------------------------------------------
    FUNCTION SalvarSqlQuery(par_cRptId, par_cSqlQuery)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " SqlQuery = " + EscaparSQL(par_cSqlQuery) + "," + ;
                       " DtModif = " + FormatarDataSQL(THIS.this_dDtAlteracao) + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao salvar SQL do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.SalvarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarSqlQuery - Executa o SqlQuery e retorna cursor com resultado
    * Usado pelo editor SQL para pre-visualizar resultados
    *--------------------------------------------------------------------------
    FUNCTION ExecutarSqlQuery(par_cSqlQuery, par_cCursorDestino)
        LOCAL loc_nResultado, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
                           par_cCursorDestino, "cursor_4c_SqlResult")

        IF VARTYPE(par_cSqlQuery) != "C" OR EMPTY(ALLTRIM(par_cSqlQuery))
            MsgAviso("SQL n" + CHR(227) + "o informado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ALLTRIM(par_cSqlQuery), loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTabelasSqlServer - Lista tabelas do banco para o editor SQL (F8)
    *--------------------------------------------------------------------------
    FUNCTION BuscarTabelasSqlServer()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Tabelas")
                USE IN cursor_4c_Tabelas
            ENDIF

            loc_cSQL = "SELECT UPPER(name) AS NmTable, id AS Object_ID, crdate AS Modify_Date" + ;
                       " FROM sysobjects" + ;
                       " WHERE xtype = 'U'" + ;
                       " ORDER BY name"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tabelas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarTabelasSqlServer:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarColunasDaTabela - Lista colunas de uma tabela especifica (F9)
    *--------------------------------------------------------------------------
    FUNCTION BuscarColunasDaTabela(par_cNomeTabela)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNomeTabela) != "C" OR EMPTY(ALLTRIM(par_cNomeTabela))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Colunas")
                USE IN cursor_4c_Colunas
            ENDIF

            loc_cSQL = "SELECT c.colid AS Column_ID, c.name AS Column_Name, t.name AS Type, c.length AS Max_Length" + ;
                       " FROM syscolumns c" + ;
                       " JOIN systypes t ON t.xtype = c.xtype AND t.usertype < 256" + ;
                       " WHERE c.id = OBJECT_ID(" + EscaparSQL(ALLTRIM(par_cNomeTabela)) + ")" + ;
                       " ORDER BY c.colid"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Colunas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar colunas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarColunasDaTabela:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

