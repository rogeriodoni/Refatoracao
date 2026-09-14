# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-05 17:52:59] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-05 17:52:59] [INFO] Config FPW: (nao fornecido)
[2026-06-05 17:52:59] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-05 17:52:59] [INFO] Timeout: 300 segundos
[2026-06-05 17:52:59] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ea0yyoj.prg
[2026-06-05 17:52:59] [INFO] Conteudo do wrapper:
[2026-06-05 17:52:59] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigReGla', 'C:\4c\tasks\task107', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReGla', 'C:\4c\tasks\task107', 'OPERACIONAL'
QUIT

[2026-06-05 17:52:59] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ea0yyoj.prg
[2026-06-05 17:52:59] [INFO] VFP output esperado em: C:\4c\tasks\task107\vfp_output.txt
[2026-06-05 17:52:59] [INFO] Executando Visual FoxPro 9...
[2026-06-05 17:52:59] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ea0yyoj.prg
[2026-06-05 17:52:59] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ea0yyoj.prg
[2026-06-05 17:52:59] [INFO] Timeout configurado: 300 segundos
[2026-06-05 17:53:07] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-05 17:53:07] [INFO] VFP9 finalizado em 7.5092419 segundos
[2026-06-05 17:53:07] [INFO] Exit Code: 
[2026-06-05 17:53:07] [INFO] 
[2026-06-05 17:53:07] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-05 17:53:07] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ea0yyoj.prg
[2026-06-05 17:53:07] [INFO] 
[2026-06-05 17:53:07] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-05 17:53:07] [INFO] * Auto-generated wrapper for parameters
[2026-06-05 17:53:07] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-05 17:53:07] [INFO] * Parameters: 'FormSigReGla', 'C:\4c\tasks\task107', 'OPERACIONAL'
[2026-06-05 17:53:07] [INFO] 
[2026-06-05 17:53:07] [INFO] * Anti-dialog protections for unattended execution
[2026-06-05 17:53:07] [INFO] SET SAFETY OFF
[2026-06-05 17:53:07] [INFO] SET RESOURCE OFF
[2026-06-05 17:53:07] [INFO] SET TALK OFF
[2026-06-05 17:53:07] [INFO] SET NOTIFY OFF
[2026-06-05 17:53:07] [INFO] SYS(2335, 0)
[2026-06-05 17:53:07] [INFO] 
[2026-06-05 17:53:07] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReGla', 'C:\4c\tasks\task107', 'OPERACIONAL'
[2026-06-05 17:53:07] [INFO] QUIT
[2026-06-05 17:53:07] [INFO] 
[2026-06-05 17:53:07] [INFO] === Fim do Wrapper.prg ===
[2026-06-05 17:53:07] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigReGla",
  "timestamp": "20260605175307",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARDADOS is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "2/2 paginas navegadas com sucesso"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick e PageFrame - navegacao Page2 nao aplicavel"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReGla.prg):
*==============================================================================
* FormSigReGla.prg
* Formulario operacional - SigReGla
* Herda de: FormBase
* Fase 8/8: COMPLETO - todos os metodos implementados
*==============================================================================

DEFINE CLASS FormSigReGla AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades
    *--------------------------------------------------------------------------
    this_cTituloForm = ""
    this_cModoAtual  = "LISTA"

    *-- Configuracoes visuais (copiadas do original)
    Width        = 1000
    Height       = 600
    TitleBar     = 0
    AutoCenter   = .T.
    Caption      = "Form1"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Inicializa BO, PageFrame e containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Instancia Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigReGlaBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Configura PageFrame, Page1 e Page2
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarContaineresPage2()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Torna controles visiveis
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1

                THIS.TornarControlesVisiveis(THIS.pgf_4c_Paginas.Page1)
                THIS.TornarControlesVisiveis(THIS.pgf_4c_Paginas.Page2)

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.AjustarBotoesPorModo()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigReGlaBO.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 e Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1 com Grid e botoes CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPage

        loc_oPage = THIS.pgf_4c_Paginas.Page1
        loc_oPage.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (cntSombra do framework)
        loc_oPage.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPage.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 54
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 16
            .Left      = 11
            .Width     = THIS.Width - 22
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Caption   = "Form1"
            .Visible   = .T.
        ENDWITH

        loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 14
            .Left      = 10
            .Width     = THIS.Width - 22
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Caption   = "Form1"
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (canonico: Left=542, Width=390, lado direito)
        loc_oPage.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPage.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Incluir
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Buscar
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Encerrar (canonico: Left=917, Width=90)
        loc_oPage.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPage.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPage.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPage.cnt_4c_Saida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista (RecordSource sera definido em CarregarLista)
        loc_oPage.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPage.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 443
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs (somente metodos PUBLIC)
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPage.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPage.grd_4c_Lista,                    "DblClick", THIS, "GrdListaDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContaineresPage2 - Containers basicos da pagina Dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContaineresPage2()
        LOCAL loc_oPage
        loc_oPage = THIS.pgf_4c_Paginas.Page2

        *-- Container de botoes de acao em Page2
        loc_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPage.cnt_4c_BotoesAcao
            .Top        = 33
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 85
            .BackStyle  = 0
            .BorderWidth = 0
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 com cabecalho (primeira metade)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPage
        loc_oPage = THIS.pgf_4c_Paginas.Page2
        loc_oPage.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (identico ao de Page1)
        loc_oPage.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPage.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 54
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 16
            .Left      = 11
            .Width     = THIS.Width - 22
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Caption   = "Form1"
            .Visible   = .T.
        ENDWITH

        loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 14
            .Left      = 10
            .Width     = THIS.Width - 22
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Caption   = "Form1"
            .Visible   = .T.
        ENDWITH

        *-- Botao Confirmar
        loc_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar
        loc_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENTs
        BINDEVENT(loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles de container visiveis
    * Iteracao recursiva sobre Controls e Pages
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.AjustarBotoesPorModo()
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (cCodigo C(20) NULL)
            SET NULL OFF

            loc_oGrid.ColumnCount    = 1
            loc_oGrid.RecordSource   = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.cCodigo"
            loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"

            THIS.FormatarGridLista(loc_oGrid)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lTemRegistro

        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        WITH loc_oCnt
            .cmd_4c_Incluir.Enabled    = .T.
            .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            .cmd_4c_Buscar.Enabled     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Navega para Page2 em modo INCLUIR
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.BOParaForm()
        THIS.CarregarDados()
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Navega para Page2 em modo VISUALIZAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para visualizar.", "Aviso")
            RETURN
        ENDIF

        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
        THIS.BOParaForm()
        THIS.CarregarDados()
        THIS.HabilitarCampos(.F.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Navega para Page2 em modo ALTERAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para alterar.", "Aviso")
            RETURN
        ENDIF

        THIS.this_cModoAtual = "ALTERAR"
        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
        THIS.BOParaForm()
        THIS.CarregarDados()
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para excluir.", "Aviso")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", "Excluir")
            RETURN
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.Excluir()

        IF loc_lSucesso
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista (filtragem basica)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdListaDblClick - Duplo clique na grade: visualiza registro
    *--------------------------------------------------------------------------
    PROCEDURE GrdListaDblClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do form para o BO
    * Form operacional sem campos CRUD - sem transferencia de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Preenche campos do form com dados do BO
    * Form operacional sem campos CRUD - sem campos a preencher
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario
    * Form operacional sem campos CRUD - nenhum campo a limpar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega dados complementares para exibicao na Page2
    * Form operacional sem dados complementares - implementacao vazia
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lEditar)
        LOCAL loc_oCnt

        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            loc_oCnt.cmd_4c_Confirmar.Enabled = par_lEditar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro (Inserir ou Atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.FormParaBO()

            IF THIS.this_cModoAtual = "INCLUIR"
                loc_lSucesso = THIS.this_oBusinessObject.Inserir()
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
            ENDIF

            IF loc_lSucesso
                THIS.AlternarPagina(1)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
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


### BO (C:\4c\projeto\app\classes\SigReGlaBO.prg):
*==============================================================================
* SIGREG LABO.PRG
* Business Object para formulario operacional SigReGla
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigReGlaBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da entidade
    * Form OPERACIONAL sem tabela CRUD - sem chave primaria
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * Form operacional sem campos CRUD - implementacao vazia
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria
    * Form operacional sem tabela CRUD
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro
    * Form operacional sem tabela CRUD - nao ha insercao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            THIS.RegistrarAuditoria("I")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente
    * Form operacional sem tabela CRUD - nao ha atualizacao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            THIS.RegistrarAuditoria("A")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

