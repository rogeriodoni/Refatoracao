# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 04:56:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 04:56:38] [INFO] Config FPW: (nao fornecido)
[2026-08-22 04:56:38] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 04:56:38] [INFO] Timeout: 300 segundos
[2026-08-22 04:56:38] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n1h5mpdy.prg
[2026-08-22 04:56:38] [INFO] Conteudo do wrapper:
[2026-08-22 04:56:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormOpd', 'C:\4c\tasks\task482', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormOpd', 'C:\4c\tasks\task482', 'CRUD'
QUIT

[2026-08-22 04:56:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n1h5mpdy.prg
[2026-08-22 04:56:38] [INFO] VFP output esperado em: C:\4c\tasks\task482\vfp_output.txt
[2026-08-22 04:56:38] [INFO] Executando Visual FoxPro 9...
[2026-08-22 04:56:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n1h5mpdy.prg
[2026-08-22 04:56:38] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n1h5mpdy.prg
[2026-08-22 04:56:38] [INFO] Timeout configurado: 300 segundos
[2026-08-22 04:58:01] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 04:58:01] [INFO] VFP9 finalizado em 83.2961372 segundos
[2026-08-22 04:58:01] [INFO] Exit Code: 
[2026-08-22 04:58:01] [INFO] 
[2026-08-22 04:58:01] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 04:58:01] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n1h5mpdy.prg
[2026-08-22 04:58:01] [INFO] 
[2026-08-22 04:58:01] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 04:58:01] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 04:58:01] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 04:58:01] [INFO] * Parameters: 'FormOpd', 'C:\4c\tasks\task482', 'CRUD'
[2026-08-22 04:58:01] [INFO] 
[2026-08-22 04:58:01] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 04:58:01] [INFO] SET SAFETY OFF
[2026-08-22 04:58:01] [INFO] SET RESOURCE OFF
[2026-08-22 04:58:01] [INFO] SET TALK OFF
[2026-08-22 04:58:01] [INFO] SET NOTIFY OFF
[2026-08-22 04:58:01] [INFO] SYS(2335, 0)
[2026-08-22 04:58:01] [INFO] 
[2026-08-22 04:58:01] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormOpd', 'C:\4c\tasks\task482', 'CRUD'
[2026-08-22 04:58:01] [INFO] QUIT
[2026-08-22 04:58:01] [INFO] 
[2026-08-22 04:58:01] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 04:58:01] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormOpd",
  "timestamp": "20260822045801",
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 3 (DOPESKEYPRESS, KEYPRESS, NOPESKEYPRESS)"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOpd.prg):
*==============================================================================
* FormOpd.prg - Formulario de Cadastro de Operacoes de Pedido
* Migrado de: SigCdOpd.SCX (frmcadastro)
* Tabela: SigOpPed | BO: OpdBO
*==============================================================================

DEFINE CLASS FormOpd AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = ""
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Cadastro de Opera" + CHR(231) + CHR(245) + "es de Pedido"

            THIS.this_oBusinessObject = CREATEOBJECT("OpdBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OpdBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOpd.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormOpd:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormOpd.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; todos os controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 com Grid + botoes CRUD
    * Grid: legado Top=121/Left=12/Width=940; compensacao +29 -> Top=150
    * Botoes canonicos: cnt_4c_Botoes Left=542; cnt_4c_Saida Left=917
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado: Top=1; +29 -> Top=30)
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
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
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
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD canonico: Left=542, Top=28 (-1+29), Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
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

        *-- Botao Visualizar (Left=80)
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

        *-- Botao Alterar (Left=155)
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

        *-- Botao Excluir (Left=230)
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

        *-- Botao Buscar (Left=305)
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

        *-- Container Saida canonico: Left=917, Top=29, Width=90, Height=85
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

        *-- Grid da Lista (legado: Top=121, Left=12, Width=940; +29 -> Top=150)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 150
            .Left               = 12
            .Width              = 940
            .Height             = 470
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

        *-- ColumnCount fora do WITH para garantir criacao imediata das colunas
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.ColumnCount = 4

        WITH loc_oGrid.Column1
            .Width     = 31
            .ReadOnly  = .T.
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column2
            .Width     = 150
            .ReadOnly  = .T.
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column3
            .Width     = 80
            .ReadOnly  = .T.
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column4
            .Width     = 108
            .ReadOnly  = .T.
            .Alignment = 0
        ENDWITH

        *-- BINDEVENTs para botoes (handlers devem ser PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 com todos os campos e botoes
    * Campos: lbl_4c_OperacaoLabel, txt_4c_Nopes, txt_4c_Dopes,
    *         opt_4c_Pagos (3 buttons), opt_4c_Utils (3 buttons)
    * Botoes: cnt_4c_BotoesAcao -> cmd_4c_Confirmar, cmd_4c_Cancelar
    * Compensacao PageFrame +29 aplicada a todos os Tops
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (grupo_salva: Left=618, Top=11+29=40, Width=160, Height=85)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 40
            .Left        = 618
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (salva: Left=5, Top=5, Width=75, Height=75)
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

        *-- Botao Cancelar (cancelar: Left=80, Top=5, Width=75, Height=75)
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

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label Opera??o: (Label3: Top=121+29=150, Left=135, Width=53, Height=15)
        loc_oPagina.AddObject("lbl_4c_OperacaoLabel", "Label")
        WITH loc_oPagina.lbl_4c_OperacaoLabel
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o:"
            .Top       = 150
            .Left      = 135
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Operacao (getnopes: Top=117+29=146, Left=203, Width=37)
        *-- Value=0 (numeric: this_nNdopes); lookup abre em SigCdOpe
        loc_oPagina.AddObject("txt_4c_Nopes", "TextBox")
        WITH loc_oPagina.txt_4c_Nopes
            .Value     = 0
            .Top       = 146
            .Left      = 203
            .Width     = 37
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 1
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Nopes, "KeyPress", THIS, "ValidarNopes")
        BINDEVENT(loc_oPagina.txt_4c_Nopes, "KeyPress", THIS, "NopesKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Nopes, "DblClick", THIS, "NopesDblClick")

        *-- TextBox Descricao Operacao (GetDopes: Top=117+29=146, Left=243, Width=150)
        *-- Value="" (char: this_cDopes = PK de SigOpPed); somente em INCLUIR
        loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPagina.txt_4c_Dopes
            .Value     = ""
            .Top       = 146
            .Left      = 243
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 2
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "ValidarDopes")
        BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "DopesKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Dopes, "DblClick", THIS, "DopesDblClick")

        *-- OptionGroup Pagamentos (OptPagos: Top=143+29=172, Left=198, Width=268, Height=27)
        *-- 1=Pagos, 2=Nao Pagos, 3=Todos
        loc_oPagina.AddObject("opt_4c_Pagos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Pagos
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 172
            .Left        = 198
            .Width       = 268
            .Height      = 27
            .Value       = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Pagos.Buttons(1)
            .Caption   = "Pagos"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Pagos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o Pagos"
            .Left      = 87
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Pagos.Buttons(3)
            .Caption   = "Todos"
            .Left      = 200
            .Top       = 5
            .Height    = 15
            .Width     = 47
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- OptionGroup Utilizacao (OptUtils: Top=164+29=193, Left=198, Width=268, Height=27)
        *-- 1=Utilizados, 2=Nao Utilizados, 3=Todos; default=1 (Utilizados) conforme legado
        loc_oPagina.AddObject("opt_4c_Utils", "OptionGroup")
        WITH loc_oPagina.opt_4c_Utils
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 193
            .Left        = 198
            .Width       = 268
            .Height      = 27
            .Value       = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Utils.Buttons(1)
            .Caption   = "Utilizados"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Utils.Buttons(2)
            .Caption   = "N" + CHR(227) + "o Utilizados"
            .Left      = 87
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_Utils.Buttons(3)
            .Caption   = "Todos"
            .Left      = 200
            .Top       = 5
            .Height    = 15
            .Width     = 47
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Busca registros de SigOpPed e vincula ao grid
    * CRITICO: RecordSource, ControlSource e Headers sempre re-definidos apos Buscar
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_lResultado = THIS.this_oBusinessObject.Buscar("")

            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF VARTYPE(loc_oGrid) = "O"
                    *-- RecordSource fora de WITH para garantir auto-bind imediato
                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    *-- ControlSource re-definido APOS RecordSource (auto-bind sobrescreve)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ndopes"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dopes"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.desc_pagos"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.desc_utils"

                    *-- Larguras re-confirmadas
                    loc_oGrid.Column1.Width = 31
                    loc_oGrid.Column2.Width = 150
                    loc_oGrid.Column3.Width = 80
                    loc_oGrid.Column4.Width = 108

                    *-- Headers re-definidos APOS RecordSource (reset para nome do campo)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Pagamentos"
                    loc_oGrid.Column4.Header1.Caption = "Utilizados"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "FormOpd.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    * Grid sera adicionado na Fase 4
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Iterar Pages E Controls para PageFrames; passar container como param
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                   UPPER(loc_oObjeto.BaseClass) != "PAGEFRAME"
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    * Quando volta para Page1 recarrega a lista para refletir mudancas
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, ;
                "FormOpd.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Novo registro: limpa BO, vai para Page2 em modo INCLUIR
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        CATCH TO loException
            MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDopes, loc_lPode
        loc_cDopes = ""
        loc_lPode  = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                loc_lPode = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnVisualizarClick")
        ENDTRY

        IF loc_lPode
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
    * CarregarPorCodigo ja seta this_lNovoRegistro = .F.
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cDopes, loc_lPode
        loc_cDopes = ""
        loc_lPode  = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                loc_lPode = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnAlterarClick")
        ENDTRY

        IF loc_lPode
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cDopes, loc_lConfirmado, loc_lExcluido
        loc_cDopes      = ""
        loc_lConfirmado = .F.
        loc_lExcluido   = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)

        loc_lConfirmado = MsgConfirma("Confirma exclus" + CHR(227) + "o da opera" + ;
            CHR(231) + CHR(227) + "o '" + loc_cDopes + "'?", "Excluir")

        IF !loc_lConfirmado
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                loc_lExcluido = THIS.this_oBusinessObject.Excluir()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnExcluirClick")
        ENDTRY

        IF loc_lExcluido
            MsgInfo("Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!")
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega lista (filtro de texto sera adicionado em fase posterior)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Delega validacao ao BO e salva o registro
    * Validacoes completas estao em OpdBO.ValidarDados():
    *   - Dopes nao vazio, tpagos >= 1, tutils >= 1, duplicata em INCLUIR
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.FormParaBO()

        TRY
            loc_lResultado = THIS.this_oBusinessObject.Salvar()
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
                "FormOpd.BtnSalvarClick")
        ENDTRY

        IF loc_lResultado
            MsgInfo("Registro salvo com sucesso!")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Descarta alteracoes e volta para Page1 (lista)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores do formulario para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            .this_nNdopes = loc_oPagina2.txt_4c_Nopes.Value
            .this_cDopes  = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)
            .this_nTpagos = loc_oPagina2.opt_4c_Pagos.Value
            .this_nTutils = loc_oPagina2.opt_4c_Utils.Value
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Preenche campos do formulario a partir do BO
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            loc_oPagina2.txt_4c_Nopes.Value = .this_nNdopes
            loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(.this_cDopes)
            loc_oPagina2.opt_4c_Pagos.Value = .this_nTpagos
            loc_oPagina2.opt_4c_Utils.Value = .this_nTutils
        ENDWITH
    ENDPROC

    *===========================================================================
    * LimparCampos - Zera todos os campos da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        loc_oPagina2.txt_4c_Nopes.Value = 0
        loc_oPagina2.txt_4c_Dopes.Value = ""
        loc_oPagina2.opt_4c_Pagos.Value = 0
        loc_oPagina2.opt_4c_Utils.Value = 0
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
    * Dopes (PK) somente editavel em INCLUIR; OptionGroups somente em INCLUIR/ALTERAR
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina2, loc_lModoEdicao
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        loc_lModoEdicao = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Nopes: habilitado sempre em INCLUIR/ALTERAR (codigo pode mudar)
        loc_oPagina2.txt_4c_Nopes.ReadOnly = !loc_lModoEdicao

        *-- Dopes (PK): somente editavel em INCLUIR (nao altera PK)
        loc_oPagina2.txt_4c_Dopes.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")

        *-- OptionGroups: somente em INCLUIR/ALTERAR
        loc_oPagina2.opt_4c_Pagos.Enabled = loc_lModoEdicao
        loc_oPagina2.opt_4c_Utils.Enabled = loc_lModoEdicao

        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita Confirmar somente em INCLUIR/ALTERAR
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF
        IF VARTYPE(loc_oPagina2.cnt_4c_BotoesAcao) != "O"
            RETURN
        ENDIF

        LOCAL loc_lSalvar
        loc_lSalvar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lSalvar
        loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * ValidarNopes - Handler de LostFocus do txt_4c_Nopes
    * Busca SigCdOpe por Dopes; se nao achar abre picker
    *===========================================================================
    PROCEDURE ValidarNopes(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina2, loc_cDopes, loc_cSQL, loc_nRes
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)

        IF EMPTY(loc_cDopes)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe WHERE Dopes = " + ;
                EscaparSQL(loc_cDopes)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaOpe")

            IF loc_nRes > 0 AND USED("cursor_4c_ValidaOpe") AND RECCOUNT("cursor_4c_ValidaOpe") > 0
                SELECT cursor_4c_ValidaOpe
                loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_ValidaOpe.Ndopes
                loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ValidaOpe.Dopes)
                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
            ELSE
                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
                THIS.AbrirBuscaNopes()
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_ValidaOpe")
                USE IN cursor_4c_ValidaOpe
            ENDIF
            MostrarErro("Erro ao validar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormOpd.ValidarNopes")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaNopes - Abre picker de operacoes por codigo (SigCdOpe)
    *===========================================================================
    PROTECTED PROCEDURE AbrirBuscaNopes()
        LOCAL loc_oPagina2, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe ORDER BY Ndopes"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")

            IF loc_nRes >= 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
                    loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
                    loc_oBusca.mAddColuna("Ndopes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Dopes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        SELECT cursor_4c_BuscaOpe
                        loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
                        loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                    CapturarErroSQL(), "FormOpd.AbrirBuscaNopes")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
                "FormOpd.AbrirBuscaNopes")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarDopes - Handler de LostFocus do txt_4c_Dopes
    * Busca SigCdOpe por Dopes (LIKE); match unico preenche auto; multiplos abre picker
    *===========================================================================
    PROCEDURE ValidarDopes(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina2, loc_cDopes, loc_cSQL, loc_nRes
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina2) != "O"
            RETURN
        ENDIF

        loc_cDopes = ALLTRIM(loc_oPagina2.txt_4c_Dopes.Value)

        IF EMPTY(loc_cDopes)
            loc_oPagina2.txt_4c_Nopes.Value = 0
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe WHERE Dopes LIKE " + ;
                EscaparSQL(loc_cDopes + "%") + " ORDER BY Dopes"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")

            IF loc_nRes > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
                SELECT cursor_4c_BuscaOpe
                GO TOP
                IF RECCOUNT("cursor_4c_BuscaOpe") = 1
                    loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
                    loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    IF USED("cursor_4c_BuscaOpe")
                        USE IN cursor_4c_BuscaOpe
                    ENDIF
                ELSE
                    THIS.AbrirBuscaDopes()
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaOpe")
                    USE IN cursor_4c_BuscaOpe
                ENDIF
                THIS.AbrirBuscaDopes()
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF
            MostrarErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormOpd.ValidarDopes")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaDopes - Abre picker de operacoes por descricao (SigCdOpe)
    * Reutiliza cursor_4c_BuscaOpe se ja existir (criado em ValidarDopes)
    *===========================================================================
    PROTECTED PROCEDURE AbrirBuscaDopes()
        LOCAL loc_oPagina2, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !USED("cursor_4c_BuscaOpe")
                loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe ORDER BY Dopes"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
                IF loc_nRes < 0
                    MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "FormOpd.AbrirBuscaDopes")
                    RETURN
                ENDIF
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
                loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
                loc_oBusca.mAddColuna("Ndopes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Dopes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                    SELECT cursor_4c_BuscaOpe
                    loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
                    loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
                "FormOpd.AbrirBuscaDopes")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *===========================================================================
    * NopesKeyPress - Handler de KeyPress do txt_4c_Nopes (F4 abre picker)
    * CRITICO: handler de BINDEVENT DEVE declarar parametros do evento
    *===========================================================================
    PROCEDURE NopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Nopes.ReadOnly
                THIS.AbrirBuscaNopes()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * NopesDblClick - Handler de DblClick do txt_4c_Nopes (abre picker)
    *===========================================================================
    PROCEDURE NopesDblClick()
        IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Nopes.ReadOnly
            THIS.AbrirBuscaNopes()
        ENDIF
    ENDPROC

    *===========================================================================
    * DopesKeyPress - Handler de KeyPress do txt_4c_Dopes (F4 abre picker)
    * CRITICO: handler de BINDEVENT DEVE declarar parametros do evento
    *===========================================================================
    PROCEDURE DopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.ReadOnly
                THIS.AbrirBuscaDopes()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * DopesDblClick - Handler de DblClick do txt_4c_Dopes (abre picker)
    *===========================================================================
    PROCEDURE DopesDblClick()
        IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.ReadOnly
            THIS.AbrirBuscaDopes()
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_DadosTmp")
            USE IN cursor_4c_DadosTmp
        ENDIF

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\OpdBO.prg):
*==============================================================================
* OpdBO.prg - Business Object para Opera??es de Pedido (SigOpPed)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS OpdBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (mapeamento das colunas de SigOpPed)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && cidchaves char(20) - identificador interno
    this_cDopes     = ""   && dopes     char(20) - PK: descri��o da opera��o
    this_nNdopes    = 0    && ndopes    numeric(10,0) - c�digo num�rico
    this_nTpagos    = 0    && tpagos    numeric(10,0) - tipo pagamento (1=Pagos,2=N�o Pagos,3=Todos)
    this_nTutils    = 0    && tutils    numeric(10,0) - tipo utiliza��o (1=Utilizados,2=N�o Utilizados,3=Todos)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = "SigOpPed"
                THIS.this_cCampoChave = "Dopes"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_nNdopes    = TratarNulo(ndopes,    "N")
                THIS.this_nTpagos    = TratarNulo(tpagos,   "N")
                THIS.this_nTutils    = TratarNulo(tutils,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "OpdBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTpagos < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Pagamento!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTutils < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Utiliza" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDopesExistente(THIS.this_cDopes)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + " Cadastrada!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDopesExistente - Verifica se dopes ja existe em SigOpPed
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDopesExistente(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpPed" + ;
                " WHERE dopes = " + EscaparSQL(par_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpd")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOpd")
                SELECT cursor_4c_ChkOpd
                loc_lExiste = (cursor_4c_ChkOpd.qtd > 0)
                USE IN cursor_4c_ChkOpd
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "OpdBO.VerificarDopesExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves se nao definido (equivalente ao fUniqueIds() do legado)
            loc_cCidChaves = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cCidChaves)
                loc_cCidChaves = PADR(ALLTRIM(THIS.this_cDopes), 20)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpPed (cidchaves, dopes, ndopes, tpagos, tutils)
                VALUES (
                    <<EscaparSQL(PADR(loc_cCidChaves, 20))>>,
                    <<EscaparSQL(THIS.this_cDopes)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = loc_cCidChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OpdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigOpPed
    * Nota: dopes e a PK, nao pode ser alterado - apenas ndopes, tpagos, tutils
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpPed
                SET ndopes = <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    tpagos = <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    tutils = <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OpdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpPed WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OpdBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com ndopes, dopes, tpagos, tutils
    * Grid colunas 3 e 4 usam IIF no ControlSource para exibir texto
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (ndopes N(10,0), dopes C(20), tpagos N(10,0), tutils N(10,0), desc_pagos C(20), desc_utils C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT ndopes, dopes, tpagos, tutils," + ;
                    " CASE WHEN tpagos = 1 THEN 'Pagos'" + ;
                    " WHEN tpagos = 2 THEN 'Nao Pagos' ELSE 'Todos' END AS desc_pagos," + ;
                    " CASE WHEN tutils = 1 THEN 'Utilizados'" + ;
                    " WHEN tutils = 2 THEN 'Nao Utilizados' ELSE 'Todos' END AS desc_utils" + ;
                    " FROM SigOpPed"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY ndopes"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OpdBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (dopes)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, dopes, ndopes, tpagos, tutils" + ;
                " FROM SigOpPed WHERE dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OpdBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

