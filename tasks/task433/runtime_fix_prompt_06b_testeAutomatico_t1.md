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
[2026-08-06 07:43:45] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 07:43:45] [INFO] Config FPW: (nao fornecido)
[2026-08-06 07:43:45] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 07:43:45] [INFO] Timeout: 300 segundos
[2026-08-06 07:43:45] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_raq4hi0g.prg
[2026-08-06 07:43:45] [INFO] Conteudo do wrapper:
[2026-08-06 07:43:45] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFTF', 'C:\4c\tasks\task433', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFTF', 'C:\4c\tasks\task433', 'CRUD'
QUIT

[2026-08-06 07:43:45] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_raq4hi0g.prg
[2026-08-06 07:43:45] [INFO] VFP output esperado em: C:\4c\tasks\task433\vfp_output.txt
[2026-08-06 07:43:45] [INFO] Executando Visual FoxPro 9...
[2026-08-06 07:43:45] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_raq4hi0g.prg
[2026-08-06 07:43:45] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_raq4hi0g.prg
[2026-08-06 07:43:45] [INFO] Timeout configurado: 300 segundos
[2026-08-06 07:44:46] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 07:44:46] [INFO] VFP9 finalizado em 60.8427282 segundos
[2026-08-06 07:44:46] [INFO] Exit Code: 
[2026-08-06 07:44:46] [INFO] 
[2026-08-06 07:44:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 07:44:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_raq4hi0g.prg
[2026-08-06 07:44:46] [INFO] 
[2026-08-06 07:44:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 07:44:46] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 07:44:46] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 07:44:46] [INFO] * Parameters: 'FormFTF', 'C:\4c\tasks\task433', 'CRUD'
[2026-08-06 07:44:46] [INFO] 
[2026-08-06 07:44:46] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 07:44:46] [INFO] SET SAFETY OFF
[2026-08-06 07:44:46] [INFO] SET RESOURCE OFF
[2026-08-06 07:44:46] [INFO] SET TALK OFF
[2026-08-06 07:44:46] [INFO] SET NOTIFY OFF
[2026-08-06 07:44:46] [INFO] SYS(2335, 0)
[2026-08-06 07:44:46] [INFO] 
[2026-08-06 07:44:46] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFTF', 'C:\4c\tasks\task433', 'CRUD'
[2026-08-06 07:44:46] [INFO] QUIT
[2026-08-06 07:44:46] [INFO] 
[2026-08-06 07:44:46] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 07:44:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFTF",
  "timestamp": "20260806074446",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFTF.prg):
*==============================================================================
* FormFTF.prg - Cadastro de Finalizadoras (Tef)
* Migrado de: SIGCDFTF.SCX
* Tabela: SigFiNz
*==============================================================================

DEFINE CLASS FormFTF AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Finalizadoras (Tef)"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *==========================================================================
    * Init - Apenas delega para FormBase (que chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("FTFBO")

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
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao criar FTFBO", "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inicializar FormFTF:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(100, 100, 100)
            .Visible   = .T.
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 2 + 29
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
            .Left      = 12
            .Width     = 769
            .Height    = 40
            .Caption   = THIS.Caption
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
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_Op no legado)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 0 + 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .Visible         = .T.
        ENDWITH

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
            .Visible         = .T.
        ENDWITH

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
            .Visible         = .T.
        ENDWITH

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
            .Visible         = .T.
        ENDWITH

        *-- Container Saida - padrao canonico (prevalece sobre PILAR 1)
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

        *-- Grid de lista (nordems=Ordem 80px, cdescrs=Descricao 337px)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 88 + 29
            .Left               = 26
            .Width              = 890
            .Height             = 498
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
            .Visible            = .T.
        ENDWITH

        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.ColumnCount = 2

        WITH loc_oGrid
            .Column1.Width           = 80
            .Column1.Alignment       = 0
            .Column1.Header1.Caption = "Ordem"
            .Column2.Width           = 337
            .Column2.Alignment       = 0
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- BINDEVENTs para botoes (metodos PUBLIC para funcionar com BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar e campos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 4 + 29
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
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
            .Visible         = .T.
        ENDWITH

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
            .Visible         = .T.
        ENDWITH

        *-- Label e TextBox: Ordem (Say1 / Get_ordem - nordems numeric 2,0)
        *-- Posicoes do original compensadas +29 (PageFrame.Top=-29)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Ordem : "
            .Top       = 147 + 29
            .Left      = 200
            .Width     = 50
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
        WITH loc_oPagina.txt_4c_Ordem
            .Value     = 0
            .Top       = 144 + 29
            .Left      = 251
            .Width     = 24
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99"
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label e TextBox: Descricao (Say2 / Get_descr - cdescrs char 20)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 172 + 29
            .Left      = 183
            .Width     = 67
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value     = ""
            .Top       = 169 + 29
            .Left      = 252
            .Width     = 149
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 20
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs botoes Page2 (metodos PUBLIC para BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 via FTFBO.Buscar()
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.RecordSource        = "crSigFiNz"
                loc_oGrid.Column1.ControlSource = "crSigFiNz.nordems"
                loc_oGrid.Column2.ControlSource = "crSigFiNz.cdescrs"

                WITH loc_oGrid
                    .Column1.Width           = 80
                    .Column1.Alignment       = 0
                    .Column1.Header1.Caption = "Ordem"
                    .Column2.Width           = 337
                    .Column2.Alignment       = 0
                    .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos do Form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.Value = THIS.this_oBusinessObject.this_nOrdem
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            loc_oPg2.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDescricao
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            THIS.this_oBusinessObject.this_nOrdem = loc_oPg2.txt_4c_Ordem.Value
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- txt_4c_Ordem: habilitado apenas no modo INCLUIR (PK nao editavel em ALTERAR)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            loc_oPg2.txt_4c_Descr.Enabled = par_lHabilitar
        ENDIF

        *-- Botao Confirmar: desabilitado em modo VISUALIZAR
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos na Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5)
            loc_oPg2.txt_4c_Ordem.Value = 0
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            loc_oPg2.txt_4c_Descr.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lTemRegistro
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Page1: habilitar botoes de acao apenas quando ha registro selecionado
        loc_lTemRegistro = USED("crSigFiNz") AND !EOF("crSigFiNz") AND RECCOUNT("crSigFiNz") > 0

        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            WITH loc_oPg1.cnt_4c_Botoes
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                    .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                    .cmd_4c_Alterar.Enabled = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                    .cmd_4c_Excluir.Enabled = loc_lTemRegistro
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF

        *-- Page2: ajustar Confirmar conforme modo (desabilitado em VISUALIZAR)
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                    (THIS.this_cModoAtual != "VISUALIZAR")
            ENDIF
        ENDIF

        *-- Posicionar foco conforme modo (replica logica do legado)
        DO CASE
            CASE THIS.this_cModoAtual = "INCLUIR"
                IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 5) AND loc_oPg2.txt_4c_Ordem.Enabled
                    loc_oPg2.txt_4c_Ordem.SetFocus()
                ENDIF
            CASE THIS.this_cModoAtual = "ALTERAR"
                IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
                    loc_oPg2.txt_4c_Descr.SetFocus()
                ENDIF
            CASE INLIST(THIS.this_cModoAtual, "VISUALIZAR")
                IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                    ENDIF
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado para consulta
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nOrdem
        loc_nOrdem = 0

        IF !USED("crSigFiNz") OR EOF("crSigFiNz")
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        SELECT crSigFiNz
        loc_nOrdem = crSigFiNz.nordems

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nOrdem)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nOrdem
        loc_nOrdem = 0

        IF !USED("crSigFiNz") OR EOF("crSigFiNz")
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        SELECT crSigFiNz
        loc_nOrdem = crSigFiNz.nordems

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nOrdem)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nOrdem
        loc_nOrdem = 0

        IF !USED("crSigFiNz") OR EOF("crSigFiNz")
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        SELECT crSigFiNz
        loc_nOrdem = crSigFiNz.nordems

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Finalizadora ordem " + ;
                        TRANSFORM(loc_nOrdem) + "?", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nOrdem)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar e posiciona cursor no registro
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_nOrdemSel, loc_oGrid
        loc_nOrdemSel = 0

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigFiNz", "cursor_4c_BuscaFTF", "nordems", 0, ;
                "Buscar Finalizadora (Tef)")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("nordems", "", "Ordem")
                loc_oBusca.mAddColuna("cdescrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFTF")
                    SELECT cursor_4c_BuscaFTF
                    loc_nOrdemSel = cursor_4c_BuscaFTF.nordems
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFTF")
                USE IN cursor_4c_BuscaFTF
            ENDIF

            IF loc_nOrdemSel > 0 AND USED("crSigFiNz")
                SELECT crSigFiNz
                LOCATE FOR nordems = loc_nOrdemSel
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva o registro (Confirmar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_nOrdem, loc_oPg2
        loc_lSucesso = .F.
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_nOrdem   = loc_oPg2.txt_4c_Ordem.Value

        *-- Validacao: ordem invalida em INCLUIR (antes do TRY - RETURN permitido)
        IF THIS.this_cModoAtual = "INCLUIR" AND loc_nOrdem <= 0
            MsgAviso("Ordem inv" + CHR(225) + "lida!", "Validar")
            loc_oPg2.txt_4c_Ordem.SetFocus()
            RETURN .F.
        ENDIF

        *-- Validacao: ordem duplicada em INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarOrdemExistente(loc_nOrdem)
                MsgAviso("Ordem j" + CHR(225) + " cadastrada!", "Validar")
                loc_oPg2.txt_4c_Ordem.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        *-- Validacao: descricao obrigatoria em INCLUIR e ALTERAR
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descr.Value))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Validar")
                loc_oPg2.txt_4c_Descr.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
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
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Limpa recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FTFBO.prg):
*==============================================================================
* FTFBO.prg - Business Object para Finalizadoras (Tef)
* Tabela: SigFiNz
* PK: nordems (numeric 2,0)
*==============================================================================

DEFINE CLASS FTFBO AS BusinessBase

    *-- Propriedades da tabela SigFiNz
    this_nOrdem    = 0    && nordems numeric(2,0) - PK
    this_cDescricao = ""  && cdescrs char(20)

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela    = "SigFiNz"
        THIS.this_cCampoChave = "nordems"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nOrdem)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nOrdem     = TratarNulo(nordems, "N")
            THIS.this_cDescricao = ALLTRIM(TratarNulo(cdescrs, "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros (PUBLIC)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT nordems, cdescrs" + ;
                       " FROM SigFiNz" + ;
                       " ORDER BY nordems"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT nordems, cdescrs" + ;
                           " FROM SigFiNz" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY nordems"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiNz")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Finalizadoras (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela PK (PUBLIC)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nOrdem)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT nordems, cdescrs" + ;
                       " FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(par_nOrdem)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiNz (nordems, cdescrs)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nOrdem) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiNz" + ;
                       " SET cdescrs = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE nordems = " + FormatarNumeroSQL(THIS.this_nOrdem)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(THIS.this_nOrdem)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarOrdemExistente - Valida unicidade do campo Ordem (PUBLIC)
    *==========================================================================
    FUNCTION VerificarOrdemExistente(par_nOrdem)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(par_nOrdem)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkOrdem")
                TABLEREVERT(.T., "cursor_4c_ChkOrdem")
                USE IN cursor_4c_ChkOrdem
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOrdem")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkOrdem") > 0
                SELECT cursor_4c_ChkOrdem
                loc_lExiste = (cursor_4c_ChkOrdem.Total > 0)
            ENDIF

            IF USED("cursor_4c_ChkOrdem")
                USE IN cursor_4c_ChkOrdem
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.VerificarOrdemExistente:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

