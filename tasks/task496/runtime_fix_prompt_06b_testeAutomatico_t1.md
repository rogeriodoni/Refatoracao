# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 20:29:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 20:29:48] [INFO] Config FPW: (nao fornecido)
[2026-08-22 20:29:48] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 20:29:48] [INFO] Timeout: 300 segundos
[2026-08-22 20:29:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aifk203u.prg
[2026-08-22 20:29:48] [INFO] Conteudo do wrapper:
[2026-08-22 20:29:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormPcp', 'C:\4c\tasks\task496', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormPcp', 'C:\4c\tasks\task496', 'CRUD'
QUIT

[2026-08-22 20:29:48] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aifk203u.prg
[2026-08-22 20:29:48] [INFO] VFP output esperado em: C:\4c\tasks\task496\vfp_output.txt
[2026-08-22 20:29:48] [INFO] Executando Visual FoxPro 9...
[2026-08-22 20:29:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aifk203u.prg
[2026-08-22 20:29:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aifk203u.prg
[2026-08-22 20:29:48] [INFO] Timeout configurado: 300 segundos
[2026-08-22 20:31:17] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 20:31:17] [INFO] VFP9 finalizado em 89.6851532 segundos
[2026-08-22 20:31:17] [INFO] Exit Code: 
[2026-08-22 20:31:17] [INFO] 
[2026-08-22 20:31:17] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 20:31:17] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aifk203u.prg
[2026-08-22 20:31:17] [INFO] 
[2026-08-22 20:31:17] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 20:31:17] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 20:31:17] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 20:31:17] [INFO] * Parameters: 'FormPcp', 'C:\4c\tasks\task496', 'CRUD'
[2026-08-22 20:31:17] [INFO] 
[2026-08-22 20:31:17] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 20:31:17] [INFO] SET SAFETY OFF
[2026-08-22 20:31:17] [INFO] SET RESOURCE OFF
[2026-08-22 20:31:17] [INFO] SET TALK OFF
[2026-08-22 20:31:17] [INFO] SET NOTIFY OFF
[2026-08-22 20:31:17] [INFO] SYS(2335, 0)
[2026-08-22 20:31:17] [INFO] 
[2026-08-22 20:31:17] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormPcp', 'C:\4c\tasks\task496', 'CRUD'
[2026-08-22 20:31:17] [INFO] QUIT
[2026-08-22 20:31:17] [INFO] 
[2026-08-22 20:31:17] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 20:31:17] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormPcp",
  "timestamp": "20260822203117",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPcp.prg):
*==============================================================================
* FormPcp.prg - Cadastro de Planejamento e Controle da Producao
* Entidade : Pcp
* Tabela   : SigCdPcz (PK: Codigos numeric(10,0))
* BO       : PcpBO.prg
* Origem   : SIGCDPCP (frmcadastro)
* Fase     : 8/8 - Form - Consolidacao Final (COMPLETO)
*==============================================================================

DEFINE CLASS FormPcp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Planejamento e Controle da Produ" + CHR(231) + CHR(227) + "o"
    AutoCenter   = .T.
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    TitleBar     = 0
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades de negocio
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Delega para FormBase.Init() (que chama InicializarForm())
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO e monta estrutura completa do formulario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("PcpBO")

            IF ISNULL(THIS.this_oBusinessObject) OR VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar PcpBO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.InicializarForm: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista / Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf, loc_oErro

        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            loc_oPgf = THIS.pgf_4c_Paginas

            WITH loc_oPgf
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .Tabs      = .F.
                .PageCount = 2
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPgf.Pages(1).Caption = "Lista"
            loc_oPgf.Pages(2).Caption = "Dados"

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            loc_oPgf.Pages(1).cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            loc_oPgf.Pages(1).cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            loc_oPgf.ActivePage = 1
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.ConfigurarPageFrame: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria Page1 completa (Lista)
    *   cnt_4c_Cabecalho  : barra de titulo escura
    *   cnt_4c_Botoes     : Incluir/Visualizar/Alterar/Excluir/Buscar
    *   cnt_4c_Saida      : Encerrar (canonico Left=917)
    *   cmd_4c_Processa   : abre mapa SigPcCpc (Top orig=84 -> 113)
    *   cmd_4c_Previsao   : abre relatorio SigRePcp
    *   cmd_4c_Prioridade : abre SigPrPcp
    *   grd_4c_Lista      : grid Codigos/Titulos/Datas (Top orig=145 -> 174)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPage, loc_oCntCab, loc_oCntBot, loc_oCntSai, loc_oGrid, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Pages(1)
            loc_oPage.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Barra de titulo escura
            loc_oPage.AddObject("cnt_4c_Cabecalho", "Container")
            loc_oCntCab = loc_oPage.cnt_4c_Cabecalho
            WITH loc_oCntCab
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oCntCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCntCab.lbl_4c_Sombra
                .Caption   = THIS.Caption
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

            loc_oCntCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCntCab.lbl_4c_Titulo
                .Caption   = THIS.Caption
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

            *-- Container CRUD (lado direito da barra)
            loc_oPage.AddObject("cnt_4c_Botoes", "Container")
            loc_oCntBot = loc_oPage.cnt_4c_Botoes
            WITH loc_oCntBot
                .Top         = 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(53, 53, 53)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oCntBot.AddObject("cmd_4c_Incluir", "CommandButton")
            WITH loc_oCntBot.cmd_4c_Incluir
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
                .WordWrap        = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oCntBot.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

            loc_oCntBot.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH loc_oCntBot.cmd_4c_Visualizar
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
                .WordWrap        = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oCntBot.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

            loc_oCntBot.AddObject("cmd_4c_Alterar", "CommandButton")
            WITH loc_oCntBot.cmd_4c_Alterar
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
                .WordWrap        = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oCntBot.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

            loc_oCntBot.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oCntBot.cmd_4c_Excluir
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
                .WordWrap        = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oCntBot.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

            loc_oCntBot.AddObject("cmd_4c_Buscar", "CommandButton")
            WITH loc_oCntBot.cmd_4c_Buscar
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
                .WordWrap        = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oCntBot.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

            *-- Encerrar canonico (Left=917 conforme padrao do sistema)
            loc_oPage.AddObject("cnt_4c_Saida", "Container")
            loc_oCntSai = loc_oPage.cnt_4c_Saida
            WITH loc_oCntSai
                .Top         = 29
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oCntSai.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oCntSai.cmd_4c_Encerrar
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
                .WordWrap        = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oCntSai.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Botoes operacionais especificos do PCP
            *-- Top original=84; PageFrame.Top=-29 => compensacao +29 => Top=113
            loc_oPage.AddObject("cmd_4c_Processa", "CommandButton")
            WITH loc_oPage.cmd_4c_Processa
                .Caption       = "\<Mapa"
                .Top           = 113
                .Left          = 13
                .Width         = 120
                .Height        = 45
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPage.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")

            loc_oPage.AddObject("cmd_4c_Previsao", "CommandButton")
            WITH loc_oPage.cmd_4c_Previsao
                .Caption       = "\<Previsao"
                .Top           = 113
                .Left          = 133
                .Width         = 120
                .Height        = 45
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPage.cmd_4c_Previsao, "Click", THIS, "BtnPrevisaoClick")

            loc_oPage.AddObject("cmd_4c_Prioridade", "CommandButton")
            WITH loc_oPage.cmd_4c_Prioridade
                .Caption       = "Priori\<zar"
                .Top           = 113
                .Left          = 251
                .Width         = 120
                .Height        = 45
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPage.cmd_4c_Prioridade, "Click", THIS, "BtnPrioridadeClick")

            *-- Grid de lista SigCdPcz
            *-- Top original=145; compensacao PageFrame.Top=-29 => Top=174
            *-- Width=890 para nao cobrir cnt_4c_Saida (Left=917)
            loc_oPage.AddObject("grd_4c_Lista", "Grid")
            loc_oGrid = loc_oPage.grd_4c_Lista
            loc_oGrid.Top         = 174
            loc_oGrid.Left        = 12
            loc_oGrid.Width       = 890
            loc_oGrid.Height      = 446
            loc_oGrid.ColumnCount = 3
            WITH loc_oGrid
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
            ENDWITH

            WITH loc_oGrid.Column1
                .Width           = 80
                .Alignment       = 0
                .Header1.Caption = "C" + CHR(243) + "digo"
            ENDWITH

            WITH loc_oGrid.Column2
                .Width           = 350
                .Alignment       = 0
                .Header1.Caption = "T" + CHR(237) + "tulo"
            ENDWITH

            WITH loc_oGrid.Column3
                .Width           = 150
                .Alignment       = 0
                .Header1.Caption = "Data Gera" + CHR(231) + CHR(227) + "o"
            ENDWITH

            BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridListaAfterRowColChange")

            THIS.TornarControlesVisiveis(loc_oPage)
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria Page2: botoes + primeira metade dos campos
    *   Fase 5: BotoesAcao + Processar + Shapes + Codigo/Titulo + 4 datas
    *   Fase 6: containers Operacao/Conta/Responsavel/Empresa + Geracao + Mensagem
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPage, loc_oCntAcao, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPage.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Container botoes Confirmar/Cancelar (Top orig=4 +29=33)
            loc_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
            loc_oCntAcao = loc_oPage.cnt_4c_BotoesAcao
            WITH loc_oCntAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oCntAcao.cmd_4c_Confirmar
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
                .WordWrap        = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oCntAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

            loc_oCntAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oCntAcao.cmd_4c_Cancelar
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
                .WordWrap        = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oCntAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- Botao Processar (Top orig=12 +29=41, Left=750)
            loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
            WITH loc_oPage.cmd_4c_Processar
                .Caption         = "Processar"
                .Top             = 41
                .Left            = 750
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPage.cmd_4c_Processar, "Click", THIS, "BtnProcessarDadosClick")

            *-- Shape1: retangulo principal de parametros (Top orig=157 +29=186)
            loc_oPage.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPage.shp_4c_Shape1
                .Top     = 186
                .Left    = 126
                .Width   = 675
                .Height  = 226
                .Visible = .T.
            ENDWITH

            *-- Shape4: retangulo destaque periodo de emissao (Top orig=157 +29=186)
            loc_oPage.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPage.shp_4c_Shape4
                .Top     = 186
                .Left    = 338
                .Width   = 232
                .Height  = 53
                .Visible = .T.
            ENDWITH

            *-- Shape2: separador horizontal (Top orig=209 +29=238)
            loc_oPage.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPage.shp_4c_Shape2
                .Top     = 238
                .Left    = 126
                .Width   = 673
                .Height  = 1
                .Visible = .T.
            ENDWITH

            *-- Label5 "Codigo :" (Top orig=130 +29=159)
            loc_oPage.AddObject("lbl_4c_Codigo", "Label")
            WITH loc_oPage.lbl_4c_Codigo
                .Caption   = "C" + CHR(243) + "digo : "
                .Top       = 159
                .Left      = 136
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- GetCodigos: txt_4c_Codigos (Top orig=127 +29=156; apenas em PROCURAR)
            loc_oPage.AddObject("txt_4c_Codigos", "TextBox")
            WITH loc_oPage.txt_4c_Codigos
                .Value    = 0
                .Top      = 156
                .Left     = 195
                .Width    = 80
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- Label8 "Titulo :" (Top orig=130 +29=159)
            loc_oPage.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oPage.lbl_4c_LblTitulo
                .Caption   = "T" + CHR(237) + "tulo : "
                .Top       = 159
                .Left      = 282
                .Width     = 38
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Get_Titulo: txt_4c_Titulo (Top orig=127 +29=156; apenas em INSERIR)
            loc_oPage.AddObject("txt_4c_Titulo", "TextBox")
            WITH loc_oPage.txt_4c_Titulo
                .Value     = ""
                .Top       = 156
                .Left      = 332
                .Width     = 360
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 50
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            *-- Label_Titulo: descricao dos parametros (Top orig=160 +29=189)
            loc_oPage.AddObject("lbl_4c_TituloParam", "Label")
            WITH loc_oPage.lbl_4c_TituloParam
                .Caption   = " Par" + CHR(226) + "metros para Processamento" + ;
                             " da Ordem de Produ" + CHR(231) + CHR(227) + "o"
                .Top       = 189
                .Left      = 137
                .Width     = 168
                .Height    = 50
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .WordWrap  = .T.
                .Visible   = .T.
            ENDWITH

            *-- Label1 "Periodo de Emissao" (Top orig=162 +29=191)
            loc_oPage.AddObject("lbl_4c_PeriEmissao", "Label")
            WITH loc_oPage.lbl_4c_PeriEmissao
                .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o"
                .Top       = 191
                .Left      = 390
                .Width     = 107
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- GetDataei: txt_4c_Dataei (Top orig=179 +29=208; apenas em INSERIR)
            loc_oPage.AddObject("txt_4c_Dataei", "TextBox")
            WITH loc_oPage.txt_4c_Dataei
                .Value    = {}
                .Top      = 208
                .Left     = 364
                .Width    = 77
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- Label2 "a" separador emissao (Top orig=184 +29=213)
            loc_oPage.AddObject("lbl_4c_SepEmissao", "Label")
            WITH loc_oPage.lbl_4c_SepEmissao
                .Caption   = CHR(224)
                .Top       = 213
                .Left      = 447
                .Width     = 8
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- GetDataef: txt_4c_Dataef (Top orig=179 +29=208; apenas em INSERIR)
            loc_oPage.AddObject("txt_4c_Dataef", "TextBox")
            WITH loc_oPage.txt_4c_Dataef
                .Value    = {}
                .Top      = 208
                .Left     = 459
                .Width    = 77
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- Label3 "Periodo de Previsao de Entrega" (Top orig=161 +29=190)
            loc_oPage.AddObject("lbl_4c_PeriPrevisao", "Label")
            WITH loc_oPage.lbl_4c_PeriPrevisao
                .Caption   = "Per" + CHR(237) + "odo de Previs" + CHR(227) + "o de Entrega"
                .Top       = 190
                .Left      = 579
                .Width     = 174
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- GetDatapi: txt_4c_Datapi (Top orig=179 +29=208; apenas em INSERIR)
            loc_oPage.AddObject("txt_4c_Datapi", "TextBox")
            WITH loc_oPage.txt_4c_Datapi
                .Value    = {}
                .Top      = 208
                .Left     = 599
                .Width    = 77
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- Label4 "a" separador previsao (Top orig=184 +29=213)
            loc_oPage.AddObject("lbl_4c_SepPrevisao", "Label")
            WITH loc_oPage.lbl_4c_SepPrevisao
                .Caption   = CHR(224)
                .Top       = 213
                .Left      = 681
                .Width     = 8
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- GetDatapf: txt_4c_Datapf (Top orig=179 +29=208; apenas em INSERIR)
            loc_oPage.AddObject("txt_4c_Datapf", "TextBox")
            WITH loc_oPage.txt_4c_Datapf
                .Value    = {}
                .Top      = 208
                .Left     = 693
                .Width    = 77
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- TxtPedido "Operacao :" (Top orig=223 +29=252, Left=175)
            loc_oPage.AddObject("lbl_4c_TxtPedido", "Label")
            WITH loc_oPage.lbl_4c_TxtPedido
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
                .Top       = 252
                .Left      = 175
                .Width     = 62
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- cnt_4c_Operacao (Top orig=215 +29=244, Left=240, Width=553, Height=33)
            loc_oPage.AddObject("cnt_4c_Operacao", "Container")
            WITH loc_oPage.cnt_4c_Operacao
                .Top         = 244
                .Left        = 240
                .Width       = 553
                .Height      = 33
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            loc_oPage.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
            WITH loc_oPage.cnt_4c_Operacao.txt_4c_Operacao
                .Value     = ""
                .Top       = 5
                .Left      = 3
                .Width     = 151
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 20
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPage.cnt_4c_Operacao.AddObject("lbl_4c_OpDe", "Label")
            WITH loc_oPage.cnt_4c_Operacao.lbl_4c_OpDe
                .Caption   = "de :"
                .Top       = 10
                .Left      = 189
                .Width     = 24
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPage.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
            WITH loc_oPage.cnt_4c_Operacao.txt_4c_Operacaoi
                .Value    = 0
                .Top      = 5
                .Left     = 214
                .Width    = 55
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            loc_oPage.cnt_4c_Operacao.AddObject("lbl_4c_OpA", "Label")
            WITH loc_oPage.cnt_4c_Operacao.lbl_4c_OpA
                .Caption   = CHR(224)
                .Top       = 10
                .Left      = 275
                .Width     = 8
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPage.cnt_4c_Operacao.AddObject("txt_4c_Operacaof", "TextBox")
            WITH loc_oPage.cnt_4c_Operacao.txt_4c_Operacaof
                .Value    = 0
                .Top      = 5
                .Left     = 289
                .Width    = 55
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- Label6 "Conta :" (Top orig=257 +29=286, Left=195)
            loc_oPage.AddObject("lbl_4c_LblConta", "Label")
            WITH loc_oPage.lbl_4c_LblConta
                .Caption   = "Conta :"
                .Top       = 286
                .Left      = 195
                .Width     = 42
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- cnt_4c_Conta (Top orig=249 +29=278, Left=240, Width=553, Height=33)
            loc_oPage.AddObject("cnt_4c_Conta", "Container")
            WITH loc_oPage.cnt_4c_Conta
                .Top         = 278
                .Left        = 240
                .Width       = 553
                .Height      = 33
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            loc_oPage.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
            WITH loc_oPage.cnt_4c_Conta.txt_4c_Grupo
                .Value     = ""
                .Top       = 5
                .Left      = 3
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPage.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPage.cnt_4c_Conta.txt_4c_Conta
                .Value     = ""
                .Top       = 5
                .Left      = 86
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPage.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
            WITH loc_oPage.cnt_4c_Conta.txt_4c_Dconta
                .Value    = ""
                .Top      = 5
                .Left     = 168
                .Width    = 360
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .MaxLength= 60
                .ReadOnly = .T.
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- Label7 "Representante :" (Top orig=291 +29=320, Left=146)
            loc_oPage.AddObject("lbl_4c_LblResp", "Label")
            WITH loc_oPage.lbl_4c_LblResp
                .Caption   = "Representante :"
                .Top       = 320
                .Left      = 146
                .Width     = 91
                .Height    = 16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- cnt_4c_Responsavel (Top orig=283 +29=312, Left=240, Width=553, Height=33)
            loc_oPage.AddObject("cnt_4c_Responsavel", "Container")
            WITH loc_oPage.cnt_4c_Responsavel
                .Top         = 312
                .Left        = 240
                .Width       = 553
                .Height      = 33
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            loc_oPage.cnt_4c_Responsavel.AddObject("txt_4c_Grupo", "TextBox")
            WITH loc_oPage.cnt_4c_Responsavel.txt_4c_Grupo
                .Value     = ""
                .Top       = 5
                .Left      = 3
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPage.cnt_4c_Responsavel.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPage.cnt_4c_Responsavel.txt_4c_Conta
                .Value     = ""
                .Top       = 5
                .Left      = 86
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPage.cnt_4c_Responsavel.AddObject("txt_4c_Dconta", "TextBox")
            WITH loc_oPage.cnt_4c_Responsavel.txt_4c_Dconta
                .Value    = ""
                .Top      = 5
                .Left     = 168
                .Width    = 360
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .MaxLength= 60
                .ReadOnly = .T.
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- lbl_empresa "Empresa :" (Top orig=325 +29=354, Left=187)
            loc_oPage.AddObject("lbl_4c_LblEmpresa", "Label")
            WITH loc_oPage.lbl_4c_LblEmpresa
                .Caption   = "Empresa :"
                .Top       = 354
                .Left      = 187
                .Width     = 50
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- cnt_4c_Empresa (Top orig=317 +29=346, Left=240, Width=553, Height=33)
            loc_oPage.AddObject("cnt_4c_Empresa", "Container")
            WITH loc_oPage.cnt_4c_Empresa
                .Top         = 346
                .Left        = 240
                .Width       = 553
                .Height      = 33
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            loc_oPage.cnt_4c_Empresa.AddObject("txt_4c__cd_empresa", "TextBox")
            WITH loc_oPage.cnt_4c_Empresa.txt_4c__cd_empresa
                .Value     = ""
                .Top       = 4
                .Left      = 4
                .Width     = 31
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .Enabled   = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPage.cnt_4c_Empresa.AddObject("txt_4c__ds_empresa", "TextBox")
            WITH loc_oPage.cnt_4c_Empresa.txt_4c__ds_empresa
                .Value    = ""
                .Top      = 4
                .Left     = 37
                .Width    = 282
                .Height   = 25
                .FontName = "Tahoma"
                .FontSize = 8
                .MaxLength= 60
                .ReadOnly = .T.
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH

            *-- Label9 "Inserir as Operacoes na fabrica a partir do dia :"
            *-- Top orig=355 +29=384, Left=206, Width=276, Height=18
            loc_oPage.AddObject("lbl_4c_LblGeracao", "Label")
            WITH loc_oPage.lbl_4c_LblGeracao
                .Caption   = "Inserir as Opera" + CHR(231) + CHR(245) + "es na f" + ;
                             CHR(225) + "brica a partir do dia :"
                .Top       = 384
                .Left      = 206
                .Width     = 276
                .Height    = 18
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- GetGeracao: txt_4c_Geracao (Top orig=353 +29=382, Left=483, Width=77)
            loc_oPage.AddObject("txt_4c_Geracao", "TextBox")
            WITH loc_oPage.txt_4c_Geracao
                .Value    = {}
                .Top      = 382
                .Left     = 483
                .Width    = 77
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oPage.txt_4c_Geracao, "LostFocus", THIS, "ValidarDataGeracao")

            *-- Mensagem: lbl_4c_Mensagem (Top orig=399 +29=428, Left=304)
            loc_oPage.AddObject("lbl_4c_Mensagem", "Label")
            WITH loc_oPage.lbl_4c_Mensagem
                .Caption   = ""
                .Top       = 428
                .Left      = 304
                .Width     = 600
                .Height    = 18
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(0, 100, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPage)
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.ConfigurarPaginaDados: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados do BO no Grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_lValidandoUI, loc_oErro
        loc_lResultado   = .F.
        loc_lValidandoUI = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        IF loc_lValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Titulos"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Datas"

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
                loc_oGrid.Column3.Header1.Caption = "Data Gera" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.CarregarLista: " + loc_oErro.Message, "Erro")
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
            MsgErro("Erro em FormPcp.AlternarPagina: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do Grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * GridListaAfterRowColChange - Handler de mudanca de linha no Grid
    *==========================================================================
    PROCEDURE GridListaAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia modo INCLUIR
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BtnIncluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe registro selecionado em modo somente-leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo, loc_lOk, loc_oErro
        loc_lOk = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
                    RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para visualizar.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_nCodigo = cursor_4c_Dados.Codigos

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lOk = .T.
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo, loc_lOk, loc_oErro
        loc_lOk = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
                    RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para alterar.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_nCodigo = cursor_4c_Dados.Codigos

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lOk = .T.
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BtnAlterarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui o registro selecionado no Grid
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
                    RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para excluir.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_nCodigo = cursor_4c_Dados.Codigos

                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
                        TRANSFORM(loc_nCodigo) + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                            THIS.CarregarLista()
                            loc_lResultado = .T.
                        ELSE
                            MsgErro("Erro ao excluir o registro.", "Erro")
                        ENDIF
                    ELSE
                        MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BtnExcluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtra registros pelo titulo informado
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_oGrid, loc_oErro

        TRY
            loc_cBusca = INPUTBOX("Informe o t" + CHR(237) + "tulo para busca:", ;
                         "Buscar Registro", "")

            IF !EMPTY(loc_cBusca)
                IF !THIS.this_oBusinessObject.Buscar("Titulos LIKE '%" + STRTRAN(loc_cBusca, "'", "''") + "%'")
                    MsgAviso("Nenhum registro encontrado.", "Busca")
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Titulos"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Datas"
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
                    loc_oGrid.Column3.Header1.Caption = "Data Gera" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BtnBuscarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessaClick - Abre mapa de producao para o registro selecionado
    *   Legado: DO Form SigPcCpc With CrSigCdPcz.Codigos
    *==========================================================================
    PROCEDURE BtnProcessaClick()
        LOCAL loc_nCodigo, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
                    RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para processar.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_nCodigo = cursor_4c_Dados.Codigos
                DO FORM SigPcCpc WITH loc_nCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BtnProcessaClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnPrevisaoClick - Abre relatorio de previsao para o registro selecionado
    *   Legado: DO Form SigRePcp With CrSigCdPcz.Codigos, CrSigCdPcz.titulos
    *==========================================================================
    PROCEDURE BtnPrevisaoClick()
        LOCAL loc_nCodigo, loc_cTitulo, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
                    RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para ver a previs" + CHR(227) + "o.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_nCodigo = cursor_4c_Dados.Codigos
                loc_cTitulo = ALLTRIM(cursor_4c_Dados.Titulos)
                DO FORM SigRePcp WITH loc_nCodigo, loc_cTitulo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BtnPrevisaoClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnPrioridadeClick - Abre priorizacao de producao
    *   Legado: DO Form SigPrPcp
    *==========================================================================
    PROCEDURE BtnPrioridadeClick()
        LOCAL loc_oErro

        TRY
            DO FORM SigPrPcp
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BtnPrioridadeClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva alteracoes em modo ALTERAR (botao Confirmar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Pages(2).txt_4c_Titulo.Value))
            MsgAviso("T" + CHR(237) + "tulo da Gera" + CHR(231) + CHR(227) + "o n" + ;
                     CHR(227) + "o informado!", "Obrigat" + CHR(243) + "rio")
        ELSE
            TRY
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao salvar o registro.", "Erro")
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro em FormPcp.BtnSalvarClick: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para a lista (Page1)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnProcessarDadosClick - Executa criacao de novo PCP (botao Processar)
    *   Legado: Processar.Click (784 linhas - itera CrSigCdPcz e gera entradas)
    *==========================================================================
    PROCEDURE BtnProcessarDadosClick()
        LOCAL loc_oPag2, loc_cTitulo, loc_lResultado, loc_oErro
        loc_lResultado = .F.
        loc_oPag2      = THIS.pgf_4c_Paginas.Pages(2)

        loc_cTitulo = ALLTRIM(loc_oPag2.txt_4c_Titulo.Value)
        IF EMPTY(loc_cTitulo)
            MsgAviso("T" + CHR(237) + "tulo da Gera" + CHR(231) + CHR(227) + "o n" + ;
                     CHR(227) + "o informado!!!", "Obrigat" + CHR(243) + "rio")
        ELSE
            IF EMPTY(loc_oPag2.txt_4c_Dataei.Value) OR EMPTY(loc_oPag2.txt_4c_Dataef.Value)
                MsgAviso("Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o n" + ;
                         CHR(227) + "o informado!", "Obrigat" + CHR(243) + "rio")
            ELSE
                TRY
                    THIS.FormParaBO()
                    THIS.this_oBusinessObject.this_nCodigos = THIS.this_oBusinessObject.GerarCodigoUnico()
                    THIS.this_oBusinessObject.this_dDatas   = DATETIME()
                    THIS.this_oBusinessObject.this_dDtLancs = DATE()
                    THIS.this_oBusinessObject.this_cEmps    = go_4c_Sistema.cCodEmpresa

                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Registro de PCP criado com sucesso!")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao criar registro de PCP.", "Erro")
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro("Erro em FormPcp.BtnProcessarDadosClick: " + loc_oErro.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag2, loc_oErro

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Pages(2)

            THIS.this_oBusinessObject.this_cTitulos  = ALLTRIM(loc_oPag2.txt_4c_Titulo.Value)
            THIS.this_oBusinessObject.this_dEmissaoI = loc_oPag2.txt_4c_Dataei.Value
            THIS.this_oBusinessObject.this_dEmissaoF = loc_oPag2.txt_4c_Dataef.Value
            THIS.this_oBusinessObject.this_dPrevis   = loc_oPag2.txt_4c_Datapi.Value
            THIS.this_oBusinessObject.this_dPrevfs   = loc_oPag2.txt_4c_Datapf.Value
            THIS.this_oBusinessObject.this_cDopes    = ALLTRIM(loc_oPag2.cnt_4c_Operacao.txt_4c_Operacao.Value)
            THIS.this_oBusinessObject.this_nNumeis   = loc_oPag2.cnt_4c_Operacao.txt_4c_Operacaoi.Value
            THIS.this_oBusinessObject.this_nNumefs   = loc_oPag2.cnt_4c_Operacao.txt_4c_Operacaof.Value
            THIS.this_oBusinessObject.this_cContas   = ALLTRIM(loc_oPag2.cnt_4c_Conta.txt_4c_Conta.Value)
            THIS.this_oBusinessObject.this_cCvens    = ALLTRIM(loc_oPag2.cnt_4c_Responsavel.txt_4c_Conta.Value)
            THIS.this_oBusinessObject.this_cEmps     = ALLTRIM(loc_oPag2.cnt_4c_Empresa.txt_4c__cd_empresa.Value)
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.FormParaBO: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag2, loc_oErro

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Pages(2)

            loc_oPag2.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_nCodigos
            loc_oPag2.txt_4c_Titulo.Value  = THIS.this_oBusinessObject.this_cTitulos
            loc_oPag2.txt_4c_Dataei.Value  = THIS.this_oBusinessObject.this_dEmissaoI
            loc_oPag2.txt_4c_Dataef.Value  = THIS.this_oBusinessObject.this_dEmissaoF
            loc_oPag2.txt_4c_Datapi.Value  = THIS.this_oBusinessObject.this_dPrevis
            loc_oPag2.txt_4c_Datapf.Value  = THIS.this_oBusinessObject.this_dPrevfs
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacao.Value   = THIS.this_oBusinessObject.this_cDopes
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacaoi.Value  = THIS.this_oBusinessObject.this_nNumeis
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacaof.Value  = THIS.this_oBusinessObject.this_nNumefs
            loc_oPag2.cnt_4c_Conta.txt_4c_Conta.Value         = THIS.this_oBusinessObject.this_cContas
            loc_oPag2.cnt_4c_Responsavel.txt_4c_Conta.Value   = THIS.this_oBusinessObject.this_cCvens
            loc_oPag2.cnt_4c_Empresa.txt_4c__cd_empresa.Value = THIS.this_oBusinessObject.this_cEmps
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.BOParaForm: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores de todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2, loc_oErro

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Pages(2)

            loc_oPag2.txt_4c_Codigos.Value = 0
            loc_oPag2.txt_4c_Titulo.Value  = ""
            loc_oPag2.txt_4c_Dataei.Value  = {}
            loc_oPag2.txt_4c_Dataef.Value  = {}
            loc_oPag2.txt_4c_Datapi.Value  = {}
            loc_oPag2.txt_4c_Datapf.Value  = {}
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacao.Value   = ""
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacaoi.Value  = 0
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacaof.Value  = 0
            loc_oPag2.cnt_4c_Conta.txt_4c_Grupo.Value         = ""
            loc_oPag2.cnt_4c_Conta.txt_4c_Conta.Value         = ""
            loc_oPag2.cnt_4c_Conta.txt_4c_Dconta.Value        = ""
            loc_oPag2.cnt_4c_Responsavel.txt_4c_Grupo.Value   = ""
            loc_oPag2.cnt_4c_Responsavel.txt_4c_Conta.Value   = ""
            loc_oPag2.cnt_4c_Responsavel.txt_4c_Dconta.Value  = ""
            loc_oPag2.cnt_4c_Empresa.txt_4c__cd_empresa.Value = go_4c_Sistema.cCodEmpresa
            loc_oPag2.cnt_4c_Empresa.txt_4c__ds_empresa.Value = ""
            loc_oPag2.txt_4c_Geracao.Value                    = {}
            loc_oPag2.lbl_4c_Mensagem.Caption                 = ""
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.LimparCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo atual
    *   Codigos: apenas PROCURAR | Titulo/Datas: apenas INSERIR (legado When)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2, loc_lModoIncluir, loc_oErro

        TRY
            loc_oPag2        = THIS.pgf_4c_Paginas.Pages(2)
            loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR") AND par_lHabilitar

            loc_oPag2.txt_4c_Codigos.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "PROCURAR")
            loc_oPag2.txt_4c_Titulo.Enabled  = loc_lModoIncluir
            loc_oPag2.txt_4c_Dataei.Enabled  = loc_lModoIncluir
            loc_oPag2.txt_4c_Dataef.Enabled  = loc_lModoIncluir
            loc_oPag2.txt_4c_Datapi.Enabled  = loc_lModoIncluir
            loc_oPag2.txt_4c_Datapf.Enabled  = loc_lModoIncluir
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacao.Enabled    = loc_lModoIncluir
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacaoi.Enabled   = loc_lModoIncluir
            loc_oPag2.cnt_4c_Operacao.txt_4c_Operacaof.Enabled   = loc_lModoIncluir
            loc_oPag2.cnt_4c_Conta.txt_4c_Grupo.Enabled          = loc_lModoIncluir
            loc_oPag2.cnt_4c_Conta.txt_4c_Conta.Enabled          = loc_lModoIncluir
            loc_oPag2.cnt_4c_Responsavel.txt_4c_Grupo.Enabled    = loc_lModoIncluir
            loc_oPag2.cnt_4c_Responsavel.txt_4c_Conta.Enabled    = loc_lModoIncluir
            loc_oPag2.cnt_4c_Empresa.txt_4c__cd_empresa.Enabled  = loc_lModoIncluir
            loc_oPag2.txt_4c_Geracao.Enabled                     = loc_lModoIncluir
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.HabilitarCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estados dos botoes conforme modo atual
    *   INCLUIR: Processar habilitado, Confirmar desabilitado
    *   ALTERAR: Confirmar habilitado, Processar desabilitado
    *   VISUALIZAR: ambos desabilitados
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag2, loc_oCntAcao, loc_lModoIncluir, loc_lModoVisualizar, loc_oErro

        TRY
            loc_oPag2           = THIS.pgf_4c_Paginas.Pages(2)
            loc_oCntAcao        = loc_oPag2.cnt_4c_BotoesAcao
            loc_lModoIncluir    = (THIS.this_cModoAtual = "INCLUIR")
            loc_lModoVisualizar = (THIS.this_cModoAtual = "VISUALIZAR")

            loc_oCntAcao.cmd_4c_Confirmar.Enabled = !loc_lModoVisualizar AND !loc_lModoIncluir
            loc_oCntAcao.cmd_4c_Cancelar.Enabled  = .T.
            loc_oPag2.cmd_4c_Processar.Enabled    = loc_lModoIncluir
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
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
    * ValidarDataGeracao - Valida data de geracao (deve ser >= hoje)
    *   Legado: GetGeracao.Valid - "If This.Value < Date() -> Return .F."
    *==========================================================================
    PROCEDURE ValidarDataGeracao()
        LOCAL loc_oPag2, loc_dGeracao, loc_oErro

        TRY
            loc_oPag2    = THIS.pgf_4c_Paginas.Pages(2)
            loc_dGeracao = loc_oPag2.txt_4c_Geracao.Value

            IF VARTYPE(loc_dGeracao) = "D" AND !EMPTY(loc_dGeracao)
                IF loc_dGeracao < DATE()
                    MsgAviso("Data Inv" + CHR(225) + "lida!!!", "")
                    loc_oPag2.txt_4c_Geracao.Value = {}
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPcp.ValidarDataGeracao: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e delega para FormBase
    *==========================================================================
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oBusinessObject) AND VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\PcpBO.prg):
*==============================================================================
* PcpBO.prg - Business Object: Planejamento e Controle da Produ??o
* Tabela principal: SigCdPcz
* Criado: 2026-08-22 | Task496
*==============================================================================

DEFINE CLASS PcpBO AS BusinessBase

    *-- Propriedades da tabela SigCdPcz
    this_nCodigos   = 0       && codigos numeric(10,0) - PK
    this_cContas    = ""      && contas  char(10)
    this_cCvens     = ""      && cvens   char(10)
    this_dDatas     = {}      && datas   datetime
    this_cDopes     = ""      && dopes   char(20)
    this_dDtLancs   = {}      && dtlancs datetime
    this_dEmissaoF  = {}      && emissaof datetime
    this_dEmissaoI  = {}      && emissaoi datetime
    this_cEmps      = ""      && emps    char(3)
    this_nNumefs    = 0       && numefs  numeric(6,0)
    this_nNumeis    = 0       && numeis  numeric(6,0)
    this_dPrevfs    = {}      && prevfs  datetime
    this_dPrevis    = {}      && previs  datetime
    this_cTitulos   = ""      && titulos char(50)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPcz"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodigos  = TratarNulo(Codigos,  "N")
            THIS.this_cContas   = TratarNulo(Contas,   "C")
            THIS.this_cCvens    = TratarNulo(Cvens,    "C")
            THIS.this_dDatas    = TratarNulo(Datas,    "D")
            THIS.this_cDopes    = TratarNulo(Dopes,    "C")
            THIS.this_dDtLancs  = TratarNulo(Dtlancs,  "D")
            THIS.this_dEmissaoF = TratarNulo(Emissaof, "D")
            THIS.this_dEmissaoI = TratarNulo(Emissaoi, "D")
            THIS.this_cEmps     = TratarNulo(Emps,     "C")
            THIS.this_nNumefs   = TratarNulo(Numefs,   "N")
            THIS.this_nNumeis   = TratarNulo(Numeis,   "N")
            THIS.this_dPrevfs   = TratarNulo(Prevfs,   "D")
            THIS.this_dPrevis   = TratarNulo(Previs,   "D")
            THIS.this_cTitulos  = TratarNulo(Titulos,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros no cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Titulos, Datas, Emps" + ;
                       " FROM SigCdPcz" + ;
                       " ORDER BY Codigos"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT Codigos, Titulos, Datas, Emps" + ;
                           " FROM SigCdPcz" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY Codigos"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Contas, Cvens, Datas, Dopes," + ;
                       " Dtlancs, Emissaof, Emissaoi, Emps," + ;
                       " Numefs, Numeis, Prevfs, Previs, Titulos" + ;
                       " FROM SigCdPcz" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdPcz" + ;
                       " (Codigos, Contas, Cvens, Datas, Dopes," + ;
                       "  Dtlancs, Emissaof, Emissaoi, Emps," + ;
                       "  Numefs, Numeis, Prevfs, Previs, Titulos)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cContas)  + ", " + ;
                       EscaparSQL(THIS.this_cCvens)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cDopes)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                       FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                       FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                       EscaparSQL(THIS.this_cEmps)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumefs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumeis) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrevfs) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrevis) + ", " + ;
                       EscaparSQL(THIS.this_cTitulos) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPcz SET" + ;
                       " Contas    = " + EscaparSQL(THIS.this_cContas)   + ", " + ;
                       " Cvens     = " + EscaparSQL(THIS.this_cCvens)    + ", " + ;
                       " Datas     = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       " Dopes     = " + EscaparSQL(THIS.this_cDopes)    + ", " + ;
                       " Dtlancs   = " + FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                       " Emissaof  = " + FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                       " Emissaoi  = " + FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                       " Emps      = " + EscaparSQL(THIS.this_cEmps)     + ", " + ;
                       " Numefs    = " + FormatarNumeroSQL(THIS.this_nNumefs) + ", " + ;
                       " Numeis    = " + FormatarNumeroSQL(THIS.this_nNumeis) + ", " + ;
                       " Prevfs    = " + FormatarDataSQL(THIS.this_dPrevfs) + ", " + ;
                       " Previs    = " + FormatarDataSQL(THIS.this_dPrevis) + ", " + ;
                       " Titulos   = " + EscaparSQL(THIS.this_cTitulos) + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro das 4 tabelas relacionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCodigo
        loc_lResultado = .F.

        TRY
            loc_cCodigo = FormatarNumeroSQL(THIS.this_nCodigos)

            *-- Excluir da tabela principal SigCdPcz (1/4)
            loc_cSQL = "DELETE FROM SigCdPcz WHERE Codigos = " + loc_cCodigo
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir SigCdPcz: " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Excluir SigCdPco (2/4)
                loc_cSQL = "DELETE FROM SigCdPco WHERE Codigos = " + loc_cCodigo
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir SigCdPco: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Excluir SigCdPcp (3/4)
                    loc_cSQL = "DELETE FROM SigCdPcp WHERE Codigos = " + loc_cCodigo
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao excluir SigCdPcp: " + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- Excluir SigCdPcg (4/4)
                        loc_cSQL = "DELETE FROM SigCdPcg WHERE Codigos = " + loc_cCodigo
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao excluir SigCdPcg: " + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega cursor TmpOper com operacoes de producao
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Dopes, NDopes, Globalizas, Reservas" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE Globalizas IN (1, 2)" + ;
                       " ORDER BY Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarOperacoes: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarParametros - Carrega parametros do sistema (SigCdPam)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarParametros()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCampos
        loc_lResultado = .F.

        TRY
            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, DoppPads," + ;
                          " DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, GruReservs," + ;
                          " ConReservs, AgrupEmph, grTrans, DoppServs, mascnums, GruEstps, ConEstps," + ;
                          " transfencs, Ouros, GruConfs, ConConfs, GlobAutos"

            loc_cSQL = "SELECT " + loc_cCampos + " FROM SigCdPam"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Parametros")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar par" + CHR(226) + "metros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarParametros: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe na base
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigo(par_nCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdPcz" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Valid") > 0
                SELECT cursor_4c_Valid
                loc_lExiste = (cursor_4c_Valid.Total > 0)
            ENDIF

            IF USED("cursor_4c_Valid")
                USE IN cursor_4c_Valid
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCodigoUnico - Gera proximo codigo unico (substitui fGerUniqueKey)
    *--------------------------------------------------------------------------
    PROCEDURE GerarCodigoUnico()
        LOCAL loc_nCodigo, loc_cSQL, loc_nResult
        loc_nCodigo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Codigos), 0) + 1 AS ProxCodigo FROM SigCdPcz"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCodigo")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxCodigo") > 0
                SELECT cursor_4c_ProxCodigo
                loc_nCodigo = cursor_4c_ProxCodigo.ProxCodigo
            ENDIF

            IF USED("cursor_4c_ProxCodigo")
                USE IN cursor_4c_ProxCodigo
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GerarCodigoUnico: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_nCodigo
    ENDPROC

ENDDEFINE

