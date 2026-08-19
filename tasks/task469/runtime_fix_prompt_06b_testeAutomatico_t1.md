# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-19 10:04:00] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-19 10:04:00] [INFO] Config FPW: (nao fornecido)
[2026-08-19 10:04:00] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 10:04:00] [INFO] Timeout: 300 segundos
[2026-08-19 10:04:00] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ib1jdc5i.prg
[2026-08-19 10:04:00] [INFO] Conteudo do wrapper:
[2026-08-19 10:04:00] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormMtp', 'C:\4c\tasks\task469', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMtp', 'C:\4c\tasks\task469', 'CRUD'
QUIT

[2026-08-19 10:04:00] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ib1jdc5i.prg
[2026-08-19 10:04:00] [INFO] VFP output esperado em: C:\4c\tasks\task469\vfp_output.txt
[2026-08-19 10:04:00] [INFO] Executando Visual FoxPro 9...
[2026-08-19 10:04:00] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ib1jdc5i.prg
[2026-08-19 10:04:00] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ib1jdc5i.prg
[2026-08-19 10:04:00] [INFO] Timeout configurado: 300 segundos
[2026-08-19 10:05:27] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-19 10:05:27] [INFO] VFP9 finalizado em 87.6225396 segundos
[2026-08-19 10:05:27] [INFO] Exit Code: 
[2026-08-19 10:05:27] [INFO] 
[2026-08-19 10:05:27] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-19 10:05:27] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ib1jdc5i.prg
[2026-08-19 10:05:27] [INFO] 
[2026-08-19 10:05:27] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-19 10:05:27] [INFO] * Auto-generated wrapper for parameters
[2026-08-19 10:05:27] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 10:05:27] [INFO] * Parameters: 'FormMtp', 'C:\4c\tasks\task469', 'CRUD'
[2026-08-19 10:05:27] [INFO] 
[2026-08-19 10:05:27] [INFO] * Anti-dialog protections for unattended execution
[2026-08-19 10:05:27] [INFO] SET SAFETY OFF
[2026-08-19 10:05:27] [INFO] SET RESOURCE OFF
[2026-08-19 10:05:27] [INFO] SET TALK OFF
[2026-08-19 10:05:27] [INFO] SET NOTIFY OFF
[2026-08-19 10:05:27] [INFO] SYS(2335, 0)
[2026-08-19 10:05:27] [INFO] 
[2026-08-19 10:05:27] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMtp', 'C:\4c\tasks\task469', 'CRUD'
[2026-08-19 10:05:27] [INFO] QUIT
[2026-08-19 10:05:27] [INFO] 
[2026-08-19 10:05:27] [INFO] === Fim do Wrapper.prg ===
[2026-08-19 10:05:27] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormMtp",
  "timestamp": "20260819100527",
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
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
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
      "detalhes": "AbrirLookup: 4 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPGRUPO, ABRIRLOOKUPMOEDACODIGO, ABRIRLOOKUPMOEDADESCRICAO) | KeyPress handlers: 4 (DESCMOEKEYPRESS, GRUPOKEYPRESS, KEYPRESS, MOEDASKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMtp.prg):
*==============================================================================
* FormMtp.prg - Formulario de Cadastro de Modelos de Trabalho de Producao
* Migrado de: SigCdMtp.SCX (frmcadastro)
* Tabela: SigIdPcp
*==============================================================================

DEFINE CLASS FormMtp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Modelos de Trabalho de Producao"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject     = .NULL.
    this_cModoAtual          = "LISTA"
    this_cIdChaveSelecionado = ""

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
            THIS.Caption = "Modelos de Trabalho de Produ" + CHR(231) + CHR(227) + "o"

            THIS.this_oBusinessObject = CREATEOBJECT("MtpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar MtpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormMtp.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormMtp:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormMtp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
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
    * ConfigurarPaginaLista - Configura Page1: cabecalho, 5 botoes CRUD,
    * botao Encerrar e grid de listagem com 3 colunas (Tipos/Descs/Limites)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original Top=1; com compensacao +29 para PageFrame.Top=-29: Top=31
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

        *-- Container Botoes CRUD (Grupo_op: Left=339, Top=-1, Width=389)
        *-- Canonico: Left=542, Top=29, Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir no legado: Left=5, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Consultar no legado: Left=81, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Alterar no legado: Left=157, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Excluir no legado: Left=233, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Procurar no legado: Left=309, Top=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
        *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
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

        *-- Botao Encerrar (Sair no legado: Left=5, Top=5 dentro de Grupo_Saida)
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Grade no legado: FontName=Tahoma, FontSize=8, ForeColor=90,90,90)
        *-- Colunas originais: Tipos (Codigo), descs (Descricao), limites (Prod. Minima)
        *-- Top=88+29=117 (compensacao PageFrame), Width=890 (nao sobrepoe cnt_4c_Saida)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid              = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top          = 117
        loc_oGrid.Left         = 26
        loc_oGrid.Width        = 890
        loc_oGrid.Height       = 498
        loc_oGrid.ColumnCount  = 3
        loc_oGrid.RecordSource = ""
        loc_oGrid.FontName     = "Tahoma"
        loc_oGrid.FontSize     = 8
        loc_oGrid.ForeColor    = RGB(90, 90, 90)
        loc_oGrid.BackColor    = RGB(255, 255, 255)
        loc_oGrid.RowHeight    = 16
        loc_oGrid.GridLines    = 3
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark   = .F.
        loc_oGrid.RecordMark   = .F.
        loc_oGrid.ScrollBars   = 2
        loc_oGrid.Visible      = .T.

        WITH loc_oGrid.Column1
            .Width     = 80
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column1.Header1
            .Caption  = "C" + CHR(243) + "digo"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        WITH loc_oGrid.Column2
            .Width     = 440
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        WITH loc_oGrid.Column3
            .Width     = 150
            .Alignment = 3
        ENDWITH
        WITH loc_oGrid.Column3.Header1
            .Caption  = "Prod. M" + CHR(237) + "nima"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 com todos os campos do formulario
    * Campos: Tipos, Grupos, Descs, Limites, Fmaxs, Valors, Moedas+DescMoe, Ganhos
    * Tops originais do legado compensados em +29 (PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salva/Cancelar (Grupo_Salva no legado: Left=842, Top=4+29=33)
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

        *-- Botao Confirmar (Salva.Left=5, Top=5 no legado)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Cancelar.Left=81, Top=5 no legado)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- === LINHA 1: Codigo (Say1.Top=147->176 / Get_tipos.Top=144->173) ===
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo : "
            .Top       = 176
            .Left      = 250
            .Height    = 17
            .Width     = 49
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
        WITH loc_oPagina.txt_4c_Tipos
            .Value     = ""
            .Top       = 173
            .Left      = 299
            .Width     = 24
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .MaxLength = 5
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 2: Grupo (Say8.Top=174->203 / Get_grupo.Top=171->200) ===
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo : "
            .Top       = 203
            .Left      = 254
            .Height    = 17
            .Width     = 45
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value     = ""
            .Top       = 200
            .Left      = 299
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .MaxLength = 10
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "GrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick",  THIS, "GrupoDblClick")

        *-- === LINHA 3: Descricao (Say2.Top=202->231 / Get_Descs.Top=199->228) ===
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 231
            .Left      = 237
            .Height    = 17
            .Width     = 62
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value     = ""
            .Top       = 228
            .Left      = 299
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 4: Producao Minima (Say3.Top=229->258 / Get_limites.Top=226->255) ===
        loc_oPagina.AddObject("lbl_4c_ProdMinima", "Label")
        WITH loc_oPagina.lbl_4c_ProdMinima
            .Caption   = "Produ" + CHR(231) + CHR(227) + "o M" + CHR(237) + "nima : "
            .Top       = 258
            .Left      = 203
            .Height    = 17
            .Width     = 96
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Limites", "TextBox")
        WITH loc_oPagina.txt_4c_Limites
            .Value     = 0
            .Top       = 255
            .Left      = 299
            .Width     = 94
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 3
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 5: Falha Admitida (Say4.Top=256->285 / Get_fmaxs.Top=253->282) + % (Say6.Top=256->285) ===
        loc_oPagina.AddObject("lbl_4c_FalhaAdmitida", "Label")
        WITH loc_oPagina.lbl_4c_FalhaAdmitida
            .Caption   = "Falha Admitida : "
            .Top       = 285
            .Left      = 213
            .Height    = 17
            .Width     = 86
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fmaxs", "TextBox")
        WITH loc_oPagina.txt_4c_Fmaxs
            .Value     = 0
            .Top       = 282
            .Left      = 299
            .Width     = 66
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 3
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Porcentagem", "Label")
        WITH loc_oPagina.lbl_4c_Porcentagem
            .Caption   = "%"
            .Top       = 285
            .Left      = 371
            .Height    = 17
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 6: Valor do Premio (Say5.Top=284->313 / Get_valors.Top=281->310) ===
        loc_oPagina.AddObject("lbl_4c_ValorPremio", "Label")
        WITH loc_oPagina.lbl_4c_ValorPremio
            .Caption   = "Valor do Pr" + CHR(234) + "mio : "
            .Top       = 313
            .Left      = 209
            .Height    = 17
            .Width     = 90
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valors", "TextBox")
        WITH loc_oPagina.txt_4c_Valors
            .Value     = 0
            .Top       = 310
            .Left      = 299
            .Width     = 66
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 3
            .TabIndex  = 6
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 7: Moeda (Say7.Top=311->340) + Cmoes (Top=308->337) + Dmoes (Top=308->337) ===
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Caption   = "Moeda : "
            .Top       = 340
            .Left      = 251
            .Height    = 17
            .Width     = 48
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Moedas", "TextBox")
        WITH loc_oPagina.txt_4c_Moedas
            .Value     = ""
            .Top       = 337
            .Left      = 299
            .Width     = 31
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .MaxLength = 10
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Moedas, "KeyPress", THIS, "ValidarMoedaPorCodigo")
        BINDEVENT(loc_oPagina.txt_4c_Moedas, "KeyPress",  THIS, "MoedasKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Moedas, "DblClick",  THIS, "MoedasDblClick")

        loc_oPagina.AddObject("txt_4c_DescMoe", "TextBox")
        WITH loc_oPagina.txt_4c_DescMoe
            .Value     = ""
            .Top       = 337
            .Left      = 335
            .Width     = 115
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DescMoe, "KeyPress", THIS, "ValidarMoedaPorDescricao")
        BINDEVENT(loc_oPagina.txt_4c_DescMoe, "KeyPress",  THIS, "DescMoeKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DescMoe, "DblClick",  THIS, "DescMoeDblClick")

        *-- === LINHA 8: Contabilizar Ganhos (fwcheckbox.Top=338->367) ===
        loc_oPagina.AddObject("chk_4c_Ganhos", "CheckBox")
        WITH loc_oPagina.chk_4c_Ganhos
            .Caption   = "Contabilizar Ganhos"
            .Value     = 0
            .Top       = 367
            .Left      = 298
            .Width     = 132
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
    *===========================================================================
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

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormMtp.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados do BO no grid da Page1
    * Colunas: tipos (Codigo), descs (Descricao), limites (Prod.Minima)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lResultado = .T.
        ELSE
            TRY
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.limites"

                    *-- Reconfigurar cabecalhos APOS ControlSource (VFP9 reseta ao alterar)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Prod. M" + CHR(237) + "nima"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar lista:" + CHR(13) + ;
                    loException.Message, "FormMtp.CarregarLista")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista (fonte Tahoma 8)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Navega para Page2 em modo INCLUIR
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cTipos, loc_cGrupos

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
        loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

        IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cTipos, loc_cGrupos

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
        loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

        IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cTipos, loc_cGrupos, loc_lConfirma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
        loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
            "Excluir")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
                        "Exclus" + CHR(227) + "o")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre busca (FormBuscaAuxiliar) e posiciona grid no resultado
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cTipos, loc_cGrupos, loc_nResult
        loc_cTipos  = ""
        loc_cGrupos = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT tipos, grupos, descs, limites" + ;
                " FROM SigIdPcp ORDER BY tipos, grupos", ;
                "cursor_4c_Busca")

            IF loc_nResult >= 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_Busca", "tipos", "descs", ;
                        "Buscar Modelo de Produ" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("limites", "", "Prod. M" + CHR(237) + "nima")
                    loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                    IF loc_oBusca.Mostrar()
                        IF USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_cTipos  = ALLTRIM(cursor_4c_Busca.tipos)
                            loc_cGrupos = ALLTRIM(cursor_4c_Busca.grupos)
                            IF !EMPTY(loc_cTipos) AND USED("cursor_4c_Dados")
                                SELECT cursor_4c_Dados
                                LOCATE FOR ALLTRIM(tipos) == loc_cTipos AND ALLTRIM(grupos) == loc_cGrupos
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao buscar modelos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro na busca:" + CHR(13) + loException.Message, ;
                "FormMtp.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o registro atual (INCLUIR ou ALTERAR)
    * Validacoes: Tipos e Grupos obrigatorios; duplicidade Tipos+Grupos no INCLUIR
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPag2, loc_cTipos, loc_cGrupos, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        loc_oPag2    = THIS.pgf_4c_Paginas.Page2
        loc_cTipos   = ALLTRIM(loc_oPag2.txt_4c_Tipos.Value)
        loc_cGrupos  = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)

        *-- Validacoes obrigatorias no modo INCLUIR (replicado do Salva.Click legado)
        IF THIS.this_cModoAtual == "INCLUIR"
            IF EMPTY(loc_cTipos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo...", "")
                loc_oPag2.txt_4c_Tipos.SetFocus()
                RETURN .F.
            ENDIF
            IF EMPTY(loc_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo...", "")
                loc_oPag2.txt_4c_Grupo.SetFocus()
                RETURN .F.
            ENDIF

            *-- Verificar duplicidade de Tipos+Grupos
            loc_cSQL = "SELECT Tipos, Grupos FROM SigIdPcp" + ;
                " WHERE Tipos=" + EscaparSQL(loc_cTipos) + ;
                " AND Grupos=" + EscaparSQL(loc_cGrupos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesqDup")
            IF loc_nResult >= 0 AND USED("cursor_4c_PesqDup") AND !EOF("cursor_4c_PesqDup")
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado...", "")
                loc_oPag2.txt_4c_Grupo.SetFocus()
                USE IN cursor_4c_PesqDup
                RETURN .F.
            ENDIF
            IF USED("cursor_4c_PesqDup")
                USE IN cursor_4c_PesqDup
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.Salvar()
            IF loc_lSucesso
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
                "FormMtp.BtnSalvarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Volta para Page1 sem salvar
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * ValidarGrupo - LostFocus de txt_4c_Grupo: valida em SigCdGcr (gerbals=1)
    *===========================================================================
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Gcr", "codigos", loc_cValor, ;
                "Selecionar Grupo", .F., .F., "gerbals=1")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
                        SELECT cursor_4c_Gcr
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
                    ELSE
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
                "FormMtp.ValidarGrupo")
        ENDTRY

        IF USED("cursor_4c_Gcr")
            USE IN cursor_4c_Gcr
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarMoedaPorCodigo - LostFocus de txt_4c_Moedas: valida Cmoes em SigCdMoe
    * Se encontrado, preenche txt_4c_DescMoe; se nao, abre picker
    *===========================================================================
    PROCEDURE ValidarMoedaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cValor, loc_oBusca
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPag2.txt_4c_Moedas.Value)

        IF EMPTY(loc_cValor)
            loc_oPag2.txt_4c_DescMoe.Value = ""
            loc_oPag2.txt_4c_DescMoe.ReadOnly = !((THIS.this_cModoAtual == "INCLUIR" OR ;
                THIS.this_cModoAtual == "ALTERAR"))
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Moe", "cmoes", loc_cValor, ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Moe")
                        SELECT cursor_4c_Moe
                        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                    ENDIF
                ELSE
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
                        SELECT cursor_4c_Moe
                        loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
                        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                    ELSE
                        loc_oPag2.txt_4c_Moedas.Value  = ""
                        loc_oPag2.txt_4c_DescMoe.Value = ""
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar moeda:" + CHR(13) + loException.Message, ;
                "FormMtp.ValidarMoedaPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Moe")
            USE IN cursor_4c_Moe
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarMoedaPorDescricao - LostFocus de txt_4c_DescMoe: busca Dmoes em SigCdMoe
    * Se encontrado exato, preenche Moedas; se nao, abre picker
    *===========================================================================
    PROCEDURE ValidarMoedaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cValor, loc_oBusca
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPag2.txt_4c_DescMoe.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Moe", "dmoes", loc_cValor, ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Moe")
                        SELECT cursor_4c_Moe
                        loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
                        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                    ENDIF
                ELSE
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
                        SELECT cursor_4c_Moe
                        loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
                        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                    ELSE
                        loc_oPag2.txt_4c_Moedas.Value  = ""
                        loc_oPag2.txt_4c_DescMoe.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormMtp.ValidarMoedaPorDescricao")
        ENDTRY

        IF USED("cursor_4c_Moe")
            USE IN cursor_4c_Moe
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos controles para propriedades do BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cTipos   = ALLTRIM(loc_oPag2.txt_4c_Tipos.Value)
        THIS.this_oBusinessObject.this_cGrupos  = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(loc_oPag2.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nLimites = loc_oPag2.txt_4c_Limites.Value
        THIS.this_oBusinessObject.this_nFmaxs   = loc_oPag2.txt_4c_Fmaxs.Value
        THIS.this_oBusinessObject.this_nValors  = loc_oPag2.txt_4c_Valors.Value
        THIS.this_oBusinessObject.this_cMoedas  = ALLTRIM(loc_oPag2.txt_4c_Moedas.Value)
        THIS.this_oBusinessObject.this_lGanhos  = loc_oPag2.chk_4c_Ganhos.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BO para os controles do formulario
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.txt_4c_Tipos.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
        loc_oPag2.txt_4c_Grupo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        loc_oPag2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        loc_oPag2.txt_4c_Limites.Value   = THIS.this_oBusinessObject.this_nLimites
        loc_oPag2.txt_4c_Fmaxs.Value     = THIS.this_oBusinessObject.this_nFmaxs
        loc_oPag2.txt_4c_Valors.Value    = THIS.this_oBusinessObject.this_nValors
        loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)
        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoe)
        loc_oPag2.chk_4c_Ganhos.Value    = THIS.this_oBusinessObject.this_lGanhos
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme o modo atual
    *   tipos/grupos: editaveis apenas em INCLUIR
    *   campos gerais: editaveis em INCLUIR e ALTERAR
    *   txt_4c_DescMoe: editavel apenas quando Moedas esta vazio
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2, loc_lIncluir, loc_lDescMoeHab
        loc_oPag2    = THIS.pgf_4c_Paginas.Page2
        loc_lIncluir = (THIS.this_cModoAtual == "INCLUIR")

        loc_oPag2.txt_4c_Tipos.ReadOnly      = !(par_lHabilitar AND loc_lIncluir)
        loc_oPag2.txt_4c_Grupo.ReadOnly      = !(par_lHabilitar AND loc_lIncluir)

        loc_oPag2.txt_4c_Descricao.ReadOnly  = !par_lHabilitar
        loc_oPag2.txt_4c_Limites.ReadOnly    = !par_lHabilitar
        loc_oPag2.txt_4c_Fmaxs.ReadOnly     = !par_lHabilitar
        loc_oPag2.txt_4c_Valors.ReadOnly     = !par_lHabilitar
        loc_oPag2.txt_4c_Moedas.ReadOnly     = !par_lHabilitar

        loc_lDescMoeHab = par_lHabilitar AND EMPTY(ALLTRIM(loc_oPag2.txt_4c_Moedas.Value))
        loc_oPag2.txt_4c_DescMoe.ReadOnly    = !loc_lDescMoeHab

        loc_oPag2.chk_4c_Ganhos.Enabled     = par_lHabilitar

        IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
            loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos de Page2 para valores defaults
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.txt_4c_Tipos.Value     = ""
        loc_oPag2.txt_4c_Grupo.Value     = ""
        loc_oPag2.txt_4c_Descricao.Value = ""
        loc_oPag2.txt_4c_Limites.Value   = 0
        loc_oPag2.txt_4c_Fmaxs.Value     = 0
        loc_oPag2.txt_4c_Valors.Value    = 0
        loc_oPag2.txt_4c_Moedas.Value    = ""
        loc_oPag2.txt_4c_DescMoe.Value   = ""
        loc_oPag2.chk_4c_Ganhos.Value    = 0
    ENDPROC

    *===========================================================================
    * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: abre lookup no F4
    *===========================================================================
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *===========================================================================
    * GrupoDblClick - Handler DblClick de txt_4c_Grupo
    *===========================================================================
    PROCEDURE GrupoDblClick()
        THIS.AbrirLookupGrupo()
    ENDPROC

    *===========================================================================
    * AbrirLookupGrupo - FormBuscaAuxiliar para SigCdGcr (gerbals=1)
    * Campos: codigos (Codigo), descrs (Descricao)
    *===========================================================================
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPag2.txt_4c_Grupo.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Gcr", "codigos", "", ;
                "Selecionar Grupo", .F., .F., "gerbals=1")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
                    SELECT cursor_4c_Gcr
                    loc_oPag2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de grupo:" + CHR(13) + loException.Message, ;
                "FormMtp.AbrirLookupGrupo")
        ENDTRY

        IF USED("cursor_4c_Gcr")
            USE IN cursor_4c_Gcr
        ENDIF
    ENDPROC

    *===========================================================================
    * MoedasKeyPress - Handler KeyPress de txt_4c_Moedas: abre lookup no F4
    *===========================================================================
    PROCEDURE MoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupMoedaCodigo()
        ENDIF
    ENDPROC

    *===========================================================================
    * MoedasDblClick - Handler DblClick de txt_4c_Moedas
    *===========================================================================
    PROCEDURE MoedasDblClick()
        THIS.AbrirLookupMoedaCodigo()
    ENDPROC

    *===========================================================================
    * AbrirLookupMoedaCodigo - FormBuscaAuxiliar para SigCdMoe por CMOES
    * Campos: cmoes (Codigo), dmoes (Descricao)
    *===========================================================================
    PROCEDURE AbrirLookupMoedaCodigo()
        LOCAL loc_oBusca, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPag2.txt_4c_Moedas.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Moe", "cmoes", "", ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
                    SELECT cursor_4c_Moe
                    loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
                    loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
                    loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                ELSE
                    loc_oPag2.txt_4c_Moedas.Value  = ""
                    loc_oPag2.txt_4c_DescMoe.Value = ""
                    loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de moeda:" + CHR(13) + loException.Message, ;
                "FormMtp.AbrirLookupMoedaCodigo")
        ENDTRY

        IF USED("cursor_4c_Moe")
            USE IN cursor_4c_Moe
        ENDIF
    ENDPROC

    *===========================================================================
    * DescMoeKeyPress - Handler KeyPress de txt_4c_DescMoe: abre lookup no F4
    *===========================================================================
    PROCEDURE DescMoeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupMoedaDescricao()
        ENDIF
    ENDPROC

    *===========================================================================
    * DescMoeDblClick - Handler DblClick de txt_4c_DescMoe
    *===========================================================================
    PROCEDURE DescMoeDblClick()
        THIS.AbrirLookupMoedaDescricao()
    ENDPROC

    *===========================================================================
    * AbrirLookupMoedaDescricao - FormBuscaAuxiliar para SigCdMoe por DMOES
    * Campos: cmoes (Codigo), dmoes (Descricao)
    *===========================================================================
    PROCEDURE AbrirLookupMoedaDescricao()
        LOCAL loc_oBusca, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPag2.txt_4c_DescMoe.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Moe", "dmoes", "", ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
                    SELECT cursor_4c_Moe
                    loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
                    loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
                    loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                ELSE
                    loc_oPag2.txt_4c_Moedas.Value  = ""
                    loc_oPag2.txt_4c_DescMoe.Value = ""
                    loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormMtp.AbrirLookupMoedaDescricao")
        ENDTRY

        IF USED("cursor_4c_Moe")
            USE IN cursor_4c_Moe
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta foco conforme o modo atual
    * Legado: INSERIR->get_Tipos, ALTERAR->get_descs, CONSULTAR->salva.cancelar
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        DO CASE
        CASE THIS.this_cModoAtual == "INCLUIR"
            loc_oPag2.txt_4c_Tipos.SetFocus()
        CASE THIS.this_cModoAtual == "ALTERAR"
            loc_oPag2.txt_4c_Descricao.SetFocus()
        CASE THIS.this_cModoAtual == "VISUALIZAR"
            IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
                loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
            ENDIF
        ENDCASE
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\MtpBO.prg):
*==============================================================================
* MtpBO.prg - Business Object para Modelos de Trabalho de Producao
* Tabela: SigIdPcp
* Migrado de: SigCdMtp.SCX
*==============================================================================

DEFINE CLASS MtpBO AS BusinessBase

    *-- Chave de negocio composta: Tipos + Grupos
    this_cTipos          = ""
    this_cGrupos         = ""
    this_cTiposOriginal  = ""
    this_cGruposOriginal = ""

    *-- Dados principais
    this_cDescs    = ""
    this_nLimites  = 0
    this_nFmaxs    = 0
    this_nValors   = 0
    this_cMoedas   = ""
    this_lGanhos   = .F.

    *-- Exibicao (nao persistido na tabela SigIdPcp)
    this_cDescMoe  = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigIdPcp"
        THIS.this_cCampoChave = "tipos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTipos) + "-" + ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista registros de SigIdPcp com JOIN para descricao de moeda
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.tipos LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.tipos, a.grupos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar modelos de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar modelos de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorTipoGrupo - Carrega registro pela chave de negocio tipos+grupos
    *==========================================================================
    PROCEDURE CarregarPorTipoGrupo(par_cTipos, par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes" + ;
                       " WHERE a.tipos = " + EscaparSQL(par_cTipos) + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrupos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar modelo por tipo/grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com tipos+grupos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT tipos FROM SigIdPcp" + ;
                       " WHERE tipos = " + EscaparSQL(THIS.this_cTipos) + ;
                       " AND grupos = " + EscaparSQL(THIS.this_cGrupos)

            IF !EMPTY(THIS.this_cTiposOriginal)
                loc_cSQL = loc_cSQL + ;
                           " AND NOT (tipos = " + EscaparSQL(THIS.this_cTiposOriginal) + ;
                           " AND grupos = " + EscaparSQL(THIS.this_cGruposOriginal) + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dupl")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dupl") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cTipos         = ALLTRIM(NVL(tipos,  ""))
            THIS.this_cGrupos        = ALLTRIM(NVL(grupos, ""))
            THIS.this_cTiposOriginal  = THIS.this_cTipos
            THIS.this_cGruposOriginal = THIS.this_cGrupos
            THIS.this_cDescs    = ALLTRIM(NVL(descs,     ""))
            THIS.this_nLimites  = NVL(limites, 0)
            THIS.this_nFmaxs    = NVL(fmaxs,   0)
            THIS.this_nValors   = NVL(valors,  0)
            THIS.this_cMoedas   = ALLTRIM(NVL(moedas,   ""))
            IF VARTYPE(ganhos) = "L"
                THIS.this_lGanhos = ganhos
            ELSE
                THIS.this_lGanhos = (NVL(ganhos, 0) = 1)
            ENDIF
            THIS.this_cDescMoe  = ALLTRIM(NVL(desc_moe, ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigIdPcp
    * Chave composta: tipos + grupos
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cTipos))
                MsgAviso("C" + CHR(243) + "digo do tipo obrigat" + CHR(243) + "rio!", "Erro de valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cGrupos))
                    MsgErro("Grupo obrigat" + CHR(243) + "rio!", "Erro de valida" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF THIS.VerificarDuplicidade()
                        MsgErro("J" + CHR(225) + " existe registro com este Tipo e Grupo!", "Erro de valida" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_cSQL = "INSERT INTO SigIdPcp" + ;
                                   " (tipos, grupos, descs," + ;
                                   " limites, fmaxs, valors, moedas, ganhos)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cTipos)              + ", " + ;
                                   EscaparSQL(THIS.this_cGrupos)             + ", " + ;
                                   EscaparSQL(THIS.this_cDescs)              + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nLimites, 2)  + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nFmaxs,   2)  + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nValors,  2)  + ", " + ;
                                   EscaparSQL(THIS.this_cMoedas)             + ", " + ;
                                   IIF(THIS.this_lGanhos, "1", "0")          + ;
                                   ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado >= 0
                            THIS.this_cTiposOriginal  = THIS.this_cTipos
                            THIS.this_cGruposOriginal = THIS.this_cGrupos
                            THIS.RegistrarAuditoria("INSERT")
                            loc_lSucesso = .T.
                        ELSE
                            MsgErro("Erro ao inserir modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigIdPcp (tipos+grupos sao a chave composta)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                MsgErro("J" + CHR(225) + " existe outro registro com este Tipo e Grupo!", "Erro de valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigIdPcp SET" + ;
                           " tipos   = " + EscaparSQL(THIS.this_cTipos)             + ", " + ;
                           " grupos  = " + EscaparSQL(THIS.this_cGrupos)            + ", " + ;
                           " descs   = " + EscaparSQL(THIS.this_cDescs)             + ", " + ;
                           " limites = " + FormatarNumeroSQL(THIS.this_nLimites, 2) + ", " + ;
                           " fmaxs   = " + FormatarNumeroSQL(THIS.this_nFmaxs,   2) + ", " + ;
                           " valors  = " + FormatarNumeroSQL(THIS.this_nValors,  2) + ", " + ;
                           " moedas  = " + EscaparSQL(THIS.this_cMoedas)            + ", " + ;
                           " ganhos  = " + IIF(THIS.this_lGanhos, "1", "0") + ;
                           " WHERE tipos = " + EscaparSQL(THIS.this_cTiposOriginal) + ;
                           " AND grupos = " + EscaparSQL(THIS.this_cGruposOriginal)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.this_cTiposOriginal  = THIS.this_cTipos
                    THIS.this_cGruposOriginal = THIS.this_cGrupos
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigIdPcp
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigIdPcp" + ;
                       " WHERE tipos = " + EscaparSQL(THIS.this_cTiposOriginal) + ;
                       " AND grupos = " + EscaparSQL(THIS.this_cGruposOriginal)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

