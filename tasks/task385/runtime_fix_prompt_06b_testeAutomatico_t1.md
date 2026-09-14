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
[2026-07-30 03:10:02] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-30 03:10:02] [INFO] Config FPW: (nao fornecido)
[2026-07-30 03:10:02] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-30 03:10:02] [INFO] Timeout: 300 segundos
[2026-07-30 03:10:02] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ppcktdft.prg
[2026-07-30 03:10:02] [INFO] Conteudo do wrapper:
[2026-07-30 03:10:02] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCrt', 'C:\4c\tasks\task385', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCrt', 'C:\4c\tasks\task385', 'CRUD'
QUIT

[2026-07-30 03:10:02] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ppcktdft.prg
[2026-07-30 03:10:02] [INFO] VFP output esperado em: C:\4c\tasks\task385\vfp_output.txt
[2026-07-30 03:10:02] [INFO] Executando Visual FoxPro 9...
[2026-07-30 03:10:02] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ppcktdft.prg
[2026-07-30 03:10:02] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ppcktdft.prg
[2026-07-30 03:10:02] [INFO] Timeout configurado: 300 segundos
[2026-07-30 03:10:46] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-30 03:10:46] [INFO] VFP9 finalizado em 43.1842901 segundos
[2026-07-30 03:10:46] [INFO] Exit Code: 
[2026-07-30 03:10:46] [INFO] 
[2026-07-30 03:10:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-30 03:10:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ppcktdft.prg
[2026-07-30 03:10:46] [INFO] 
[2026-07-30 03:10:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-30 03:10:46] [INFO] * Auto-generated wrapper for parameters
[2026-07-30 03:10:46] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-30 03:10:46] [INFO] * Parameters: 'FormCrt', 'C:\4c\tasks\task385', 'CRUD'
[2026-07-30 03:10:46] [INFO] 
[2026-07-30 03:10:46] [INFO] * Anti-dialog protections for unattended execution
[2026-07-30 03:10:46] [INFO] SET SAFETY OFF
[2026-07-30 03:10:46] [INFO] SET RESOURCE OFF
[2026-07-30 03:10:46] [INFO] SET TALK OFF
[2026-07-30 03:10:46] [INFO] SET NOTIFY OFF
[2026-07-30 03:10:46] [INFO] SYS(2335, 0)
[2026-07-30 03:10:46] [INFO] 
[2026-07-30 03:10:46] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCrt', 'C:\4c\tasks\task385', 'CRUD'
[2026-07-30 03:10:46] [INFO] QUIT
[2026-07-30 03:10:46] [INFO] 
[2026-07-30 03:10:46] [INFO] === Fim do Wrapper.prg ===
[2026-07-30 03:10:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCrt",
  "timestamp": "20260730031045",
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPEMPRESA) | KeyPress handlers: 2 (EMPPADLOOKUPKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCrt.prg):
*==============================================================================
* FORMCRT.PRG
* Formulario de Cadastro de Retrabalhos (SigPrCrt)
* Herda de: FormBase
* Fase 3/8 - Estrutura base: PageFrame, containers principais, Destroy
*==============================================================================

DEFINE CLASS FormCrt AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Retrabalhos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 1

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CrtBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar CrtBO", "FormCrt.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormCrt:" + CHR(13) + loc_oErro.Message, "FormCrt.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o PageFrame principal com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            THIS.pgf_4c_Paginas.Top       = -29
            THIS.pgf_4c_Paginas.Left      = 0
            THIS.pgf_4c_Paginas.Width     = 1000
            THIS.pgf_4c_Paginas.Height    = 629
            THIS.pgf_4c_Paginas.PageCount = 2
            THIS.pgf_4c_Paginas.Tabs      = .F.
            THIS.pgf_4c_Paginas.Visible   = .T.

            WITH THIS.pgf_4c_Paginas
                .Page1.Caption = "Lista"
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Caption = "Dados"
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar PageFrame:" + CHR(13) + loc_oErro.Message, "FormCrt.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (lista de registros)
    * Cabecalho e containers principais (grid e botoes na Fase 4)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Cabecalho cinza (cntSombra legado: Top=1, Left=-1, Width=1008, Height=80)
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 30
                .Left        = 0
                .Width       = 1000
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = "Cadastro de Retrabalhos"
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Caption   = "Cadastro de Retrabalhos"
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Container botoes CRUD (canonico: Left=542, Top=28, Width=385, Height=85)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 28
                .Left        = 542
                .Width       = 385
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
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

            *-- Container saida canonico (Left=917, Top=28, Width=90, Height=85)
            loc_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPagina.cnt_4c_Saida
                .Top         = 28
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Botao Encerrar (canonico: Left=5, Top=5, Width=75, Height=75)
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
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Botao Justificativas (original: Left=604, Top=82 -> +29 compensacao = Top=111)
            loc_oPagina.AddObject("cmd_4c_Justifica", "CommandButton")
            WITH loc_oPagina.cmd_4c_Justifica
                .Caption       = "\<Justificativas"
                .Top           = 111
                .Left          = 604
                .Width         = 120
                .Height        = 40
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_Justifica, "Click", THIS, "BtnJustificaClick")

            *-- Grid de listagem (Grade: Top=82 -> +29 = 111; framework padrao Top=88+29=117)
            *-- Justifica ocupa Left=604..724 na mesma faixa vertical - grid fica abaixo em Top=117
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oPagina.grd_4c_Lista.ColumnCount = 3
            WITH loc_oPagina.grd_4c_Lista
                .Top                = 117
                .Left               = 26
                .Width              = 868
                .Height             = 450
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
                .Column1.Width      = 80
                .Column2.Width      = 220
                .Column3.Width      = 80
                .Column3.Alignment  = 1
                .Visible            = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar pagina Lista:" + CHR(13) + loc_oErro.Message, "FormCrt.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (dados do registro)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container botoes Confirmar/Cancelar (original Grupo_Salva Top=17+29=46, Left=619)
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 46
                .Left        = 619
                .Width       = 165
                .Height      = 85
                .BackStyle = 1
                .BackColor = RGB(255, 255, 255)
                .BorderWidth = 0
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
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

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
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- CAMPO 1: Codigo (Say2/Get_codigo - original top=256/254, +29=285/283)
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "C" + CHR(243) + "digo :"
                .Top       = 285
                .Left      = 274
                .Width     = 45
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value     = ""
                .Top       = 283
                .Left      = 319
                .Width     = 52
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 6
                .Visible   = .T.
            ENDWITH

            *-- CAMPO 2: Descricao (Say3/Get_descricao - original top=287/284, +29=316/313)
            loc_oPagina.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPagina.lbl_4c_Label3
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 316
                .Left      = 261
                .Width     = 58
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPagina.txt_4c_Descricao
                .Value     = ""
                .Top       = 313
                .Left      = 319
                .Width     = 220
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            *-- CAMPO 3: Fator (Say1/fwget1 - original top=316/313, +29=345/342)
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "Fator :"
                .Top       = 345
                .Left      = 278
                .Width     = 41
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
            WITH loc_oPagina.txt_4c_Fwget1
                .Value     = 0
                .Top       = 342
                .Left      = 319
                .Width     = 60
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .InputMask = "9999.99"
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- CAMPO 4: Ordem (Say4/fwget2 - original top=344/341, +29=373/370)
            loc_oPagina.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPagina.lbl_4c_Label4
                .Caption   = "Ordem :"
                .Top       = 373
                .Left      = 272
                .Width     = 47
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Fwget2", "TextBox")
            WITH loc_oPagina.txt_4c_Fwget2
                .Value     = 0
                .Top       = 370
                .Left      = 319
                .Width     = 24
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .InputMask = "99"
                .MaxLength = 2
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- CAMPO 5: Empresa (Say20/Get_EmpPad - original top=372/369, +29=401/398)
            *-- Get_EmpPad: FontName=Courier New, Alignment=3, Width=34, SigCdEmp.Cemps (char(3))
            loc_oPagina.AddObject("lbl_4c_Label20", "Label")
            WITH loc_oPagina.lbl_4c_Label20
                .Caption   = "Empresa :"
                .Top       = 401
                .Left      = 266
                .Width     = 53
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_EmpPad", "TextBox")
            WITH loc_oPagina.txt_4c_EmpPad
                .Value     = ""
                .Top       = 398
                .Left      = 319
                .Width     = 34
                .Height    = 23
                .FontName  = "Courier New"
                .FontSize  = 8
                .MaxLength = 3
                .Alignment = 3
                .Visible   = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.txt_4c_EmpPad, "KeyPress", THIS, "EmpPadLookupKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_EmpPad, "DblClick", THIS, "EmpPadLookupDblClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar pagina Dados:" + CHR(13) + loc_oErro.Message, "FormCrt.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid e configura cabecalhos
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

                    *-- RecordSource FORA do WITH para garantir criacao das colunas
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    *-- ControlSource APOS RecordSource
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Fators"

                    *-- Reconfigurar cabecalhos APOS RecordSource (VFP9 reseta cabecalhos)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Fator"
                    loc_oGrid.Column3.Header1.Alignment = 1

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormCrt.CarregarLista: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            loc_lResultado = .F.
        ELSE
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            *-- Erros no Destroy sao ignorados para nao bloquear fechamento
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara novo registro e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!", "Visualizar")
        ELSE
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)

            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Visualizar")
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar registro:" + CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!", "Alterar")
        ELSE
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)

            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Alterar")
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar registro:" + CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!", "Excluir")
        ELSE
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)

            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do retrabalho: " + loc_cCodigo + "?", "Excluir")
                TRY
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                            THIS.CarregarLista()
                            loc_lResultado = .T.
                        ELSE
                            MsgErro("Erro ao excluir o registro!", "Excluir")
                        ENDIF
                    ELSE
                        MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Excluir")
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro("Erro ao excluir registro:" + CHR(13) + loc_oErro.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre picker para localizar retrabalho
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrCrt", "cursor_4c_BuscaCrt", "Cods", "", ;
                "Buscar Retrabalho")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Fators", "", "Fator")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCrt")
                    SELECT cursor_4c_BuscaCrt
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCrt.Cods)

                    IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(Cods) = loc_cCodigo
                        loc_lResultado = FOUND()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar registro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaCrt")
            USE IN cursor_4c_BuscaCrt
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnJustificaClick - Abre formulario de Justificativas para o retrabalho selecionado
    * Original: Do Form SigCdJus With Thisform, CrSigPrCrt.Cods
    *--------------------------------------------------------------------------
    PROCEDURE BtnJustificaClick()
        LOCAL loc_cCodigo, loc_oJus

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!", "Justificativas")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)

        TRY
            loc_oJus = CREATEOBJECT("FormJus", loc_cCodigo)
            IF VARTYPE(loc_oJus) = "O"
                loc_oJus.Show()
            ELSE
                MsgAviso("Formul" + CHR(225) + "rio de Justificativas n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Justificativas")
            ENDIF
        CATCH TO loc_oErro
            MsgAviso("Formul" + CHR(225) + "rio de Justificativas n" + CHR(227) + "o dispon" + CHR(237) + "vel." + CHR(13) + loc_oErro.Message, "Justificativas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro (INSERT ou UPDATE via BusinessBase.Salvar)
    * Validacoes: codigo nao pode estar vazio em INCLUIR + sem codigo duplicado
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)

        *-- Validacoes ANTES do TRY (origem: Salva.Click do legado)
        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(loc_cCodigo)
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar registro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nFator     = loc_oPagina.txt_4c_Fwget1.Value
        THIS.this_oBusinessObject.this_nSeq       = loc_oPagina.txt_4c_Fwget2.Value
        THIS.this_oBusinessObject.this_cEmpresa   = ALLTRIM(loc_oPagina.txt_4c_EmpPad.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPagina.txt_4c_Fwget1.Value    = THIS.this_oBusinessObject.this_nFator
        loc_oPagina.txt_4c_Fwget2.Value    = THIS.this_oBusinessObject.this_nSeq
        loc_oPagina.txt_4c_EmpPad.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmpresa)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos conforme o modo
    * Codigo: somente editavel em INCLUIR (original: When = NOT pcEscolha $ 'ALTERAR/EXCLUIR/CONSULTAR')
    * EmpPad: somente editavel em INSERIR ou ALTERAR (original: When = Inlist(pcEscolha,"INSERIR","ALTERAR"))
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.ReadOnly    = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oPagina.txt_4c_Descricao.ReadOnly = !par_lHabilitar
        loc_oPagina.txt_4c_Fwget1.ReadOnly    = !par_lHabilitar
        loc_oPagina.txt_4c_Fwget2.ReadOnly    = !par_lHabilitar
        loc_oPagina.txt_4c_EmpPad.ReadOnly    = !par_lHabilitar

        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta valores de todos os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ""
        loc_oPagina.txt_4c_Descricao.Value = ""
        loc_oPagina.txt_4c_Fwget1.Value    = 0
        loc_oPagina.txt_4c_Fwget2.Value    = 0
        loc_oPagina.txt_4c_EmpPad.Value    = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acordo com this_cModoAtual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        DO CASE
            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.

            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.

            OTHERWISE
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpPadLookupKeyPress - Handler KeyPress para lookup de Empresa (F4)
    *--------------------------------------------------------------------------
    PROCEDURE EmpPadLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpPadLookupDblClick - Handler DblClick para lookup de Empresa
    *--------------------------------------------------------------------------
    PROCEDURE EmpPadLookupDblClick()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - Abre picker de Empresa em SigCdEmp (CEmps/Razas)
    * Original: fwBuscaExt em SigCdEmp, campo cEmps, filtro Cemps (When=INSERIR/ALTERAR)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF loc_oPagina.txt_4c_EmpPad.ReadOnly
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPagina.txt_4c_EmpPad.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "CEmps", loc_cValor, ;
                "Empresas")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaEmp")
                        loc_oPagina.txt_4c_EmpPad.Value = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPagina.txt_4c_EmpPad.Value = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
                    ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar empresa:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CrtBO.prg):
*==============================================================================
* CRTBO.PRG
* Business Object para Cadastro de Retrabalhos (SigPrCrt)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CrtBO AS BusinessBase

    *-- Propriedades de dados da tabela SigPrCrt
    this_cCodigo    = ""    && cods   CHAR(6)  - Codigo do Retrabalho (PK)
    this_cDescricao = ""    && descs  CHAR(30) - Descricao
    this_nFator     = 0     && fators NUMERIC  - Fator (9999.99)
    this_nSeq       = 0     && Seqs   NUMERIC  - Sequencia/Ordem
    this_cEmpresa   = ""    && Cemps   CHAR(3)  - Empresa Padrao (FK SigCdEmp)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCrt"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        THIS.this_nFator     = 0
        THIS.this_nSeq       = 0
        THIS.this_cEmpresa   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,  "C")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            THIS.this_nFator     = TratarNulo(fators,"N")
            THIS.this_nSeq       = TratarNulo(Seqs,  "N")
            THIS.this_cEmpresa   = TratarNulo(Emps,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista retrabalhos (SELECT para o grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                       " FROM SigPrCrt" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " OR Emps = ' '" + ;
                       " ORDER BY Cods"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar retrabalhos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                       " FROM SigPrCrt" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                THIS.this_cMensagemErro = "Retrabalho n" + CHR(227) + "o encontrado."
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        FINALLY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrCrt (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrCrt (Cods, Descs, Fators, Seqs, Emps)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFator) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeq) + ", " + ;
                       EscaparSQL(THIS.this_cEmpresa) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrCrt (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCrt SET" + ;
                       " Descs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " Fators = " + FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       " Seqs = " + FormatarNumeroSQL(THIS.this_nSeq) + "," + ;
                       " Emps = " + EscaparSQL(THIS.this_cEmpresa) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigPrCrt (chamado por BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCrt" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes de negocio antes de Salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            LOCAL loc_lExiste, loc_nVerif
            loc_lExiste = .F.
            TRY
                loc_nVerif = SQLEXEC(gnConnHandle, ;
                    "SELECT Cods FROM SigPrCrt WHERE Cods = " + EscaparSQL(THIS.this_cCodigo), ;
                    "cursor_4c_Verif")
                IF loc_nVerif > 0 AND RECCOUNT("cursor_4c_Verif") > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                    loc_lExiste = .T.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao verificar c" + CHR(243) + "digo: " + loc_oErro.Message, "Erro")
                loc_lValido = .F.
            FINALLY
                IF USED("cursor_4c_Verif")
                    USE IN cursor_4c_Verif
                ENDIF
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDFUNC

ENDDEFINE

