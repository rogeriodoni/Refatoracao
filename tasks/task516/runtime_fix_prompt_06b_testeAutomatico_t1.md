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
[2026-09-02 01:46:03] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-02 01:46:03] [INFO] Config FPW: (nao fornecido)
[2026-09-02 01:46:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 01:46:03] [INFO] Timeout: 300 segundos
[2026-09-02 01:46:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ap1jlwv.prg
[2026-09-02 01:46:03] [INFO] Conteudo do wrapper:
[2026-09-02 01:46:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formrst', 'C:\4c\tasks\task516', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formrst', 'C:\4c\tasks\task516', 'CRUD'
QUIT

[2026-09-02 01:46:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ap1jlwv.prg
[2026-09-02 01:46:03] [INFO] VFP output esperado em: C:\4c\tasks\task516\vfp_output.txt
[2026-09-02 01:46:03] [INFO] Executando Visual FoxPro 9...
[2026-09-02 01:46:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ap1jlwv.prg
[2026-09-02 01:46:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ap1jlwv.prg
[2026-09-02 01:46:03] [INFO] Timeout configurado: 300 segundos
[2026-09-02 01:47:38] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-02 01:47:38] [INFO] VFP9 finalizado em 94.6956373 segundos
[2026-09-02 01:47:38] [INFO] Exit Code: 
[2026-09-02 01:47:38] [INFO] 
[2026-09-02 01:47:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-02 01:47:38] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ap1jlwv.prg
[2026-09-02 01:47:38] [INFO] 
[2026-09-02 01:47:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-02 01:47:38] [INFO] * Auto-generated wrapper for parameters
[2026-09-02 01:47:38] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 01:47:38] [INFO] * Parameters: 'Formrst', 'C:\4c\tasks\task516', 'CRUD'
[2026-09-02 01:47:38] [INFO] 
[2026-09-02 01:47:38] [INFO] * Anti-dialog protections for unattended execution
[2026-09-02 01:47:38] [INFO] SET SAFETY OFF
[2026-09-02 01:47:38] [INFO] SET RESOURCE OFF
[2026-09-02 01:47:38] [INFO] SET TALK OFF
[2026-09-02 01:47:38] [INFO] SET NOTIFY OFF
[2026-09-02 01:47:38] [INFO] SYS(2335, 0)
[2026-09-02 01:47:38] [INFO] 
[2026-09-02 01:47:38] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formrst', 'C:\4c\tasks\task516', 'CRUD'
[2026-09-02 01:47:38] [INFO] QUIT
[2026-09-02 01:47:38] [INFO] 
[2026-09-02 01:47:38] [INFO] === Fim do Wrapper.prg ===
[2026-09-02 01:47:38] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formrst",
  "timestamp": "20260902014738",
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrst.prg):
*==============================================================================
* Formrst.prg - Formulario de Cadastro de Exclusividade Por Contas
* Migrado de: SIGCDRST.SCX (frmcadastro)
* Tabelas: SigCdRst (principal), SigCdRsi (municipios e produtos)
*==============================================================================

DEFINE CLASS Formrst AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: valores exatos do original)
    Height      = 600
    Width       = 1000
    Caption     = "Exclusividade Por Contas"
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

    *===========================================================================
    * Init - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
    * REGRA CRITICA: NAO chamar THIS.InicializarForm() aqui - evita chamada dupla
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
            THIS.this_oBusinessObject = CREATEOBJECT("rstBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar rstBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formrst.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formrst:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formrst.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * PageFrame.Top = -29 para esconder abas
    * Todos os controles internos compensam +29 no Top
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
    * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
    * Cabecalho, cnt_4c_Botoes (5 botoes), cnt_4c_Saida (Encerrar), grd_4c_Lista
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho escuro com titulo (cntSombra no legado)
        *-- Top original=2; compensacao PageFrame +29 -> Top=31
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

        *-- Container Botoes CRUD (Grupo_op no legado - lado direito)
        *-- Canonico: Left=542, Top=29 (0+29 compensacao), Width=390, Height=85
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

        *-- Container Saida (Grupo_Saida - padrao canonico: Left=917, Width=90)
        *-- Transparente sobre a Page - NAO subtrair da largura do cabecalho/grade
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

        *-- Botao Encerrar
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

        *-- Grid grd_4c_Lista - exibe SigCdRst + SigCdCli
        *-- Top=88+29=117 (compensacao PageFrame); Width=890; Height=483
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista

        loc_oGrid.RecordSource  = ""
        loc_oGrid.ColumnCount   = 2

        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 483
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width              = 100
            .Resizable          = .T.
            .Header1.Caption    = "Conta"
        ENDWITH

        WITH loc_oGrid.Column2
            .Width              = 450
            .Resizable          = .T.
            .Header1.Caption    = "Nome"
        ENDWITH

        BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Fase 5: cnt_4c_Salva + labels + TextBoxes + OptionGroup + Shape + Image
    * Fase 6: GradMuni + GradProd (grids com botoes inline)
    * Top de todos os controles = Top_original_legado + 29 (compensacao PageFrame)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- ===================================================================
        *-- cnt_4c_Salva (Grupo_Salva) - Confirmar + Cancelar
        *-- Canonico: Top=4+29=33, Left=842, Width=160, Height=85
        *-- ===================================================================
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

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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

        *-- ===================================================================
        *-- Say2: "Conta :" - Top=51+29=80, Left=82
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPagina.lbl_4c_Conta
            .Caption   = "Conta :"
            .Top       = 80
            .Left      = 82
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_codigo: txt_4c_Codigo - Top=47+29=76, Left=129, Width=80
        *-- When original: pcescolha='INSERIR' (habilitado so em INCLUIR)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value       = ""
            .Top         = 76
            .Left        = 129
            .Width       = 80
            .Height      = 25
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarContaCodigo")

        *-- Get_Desc: txt_4c_Desc - Top=47+29=76, Left=212, Width=290
        *-- When original: EMPTY(get_codigo) AND pcescolha='INSERIR'
        loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPagina.txt_4c_Desc
            .Value       = ""
            .Top         = 76
            .Left        = 212
            .Width       = 290
            .Height      = 25
            .MaxLength   = 40
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Desc, "KeyPress", THIS, "ValidarContaDescricao")

        *-- ===================================================================
        *-- Say11: "Checa Matriz :" - Top=79+29=108, Left=42, Width=71
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_ChkMatrix", "Label")
        WITH loc_oPagina.lbl_4c_ChkMatrix
            .Caption   = "Checa Matriz :"
            .Top       = 108
            .Left      = 42
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- op_con: opt_4c_ChkMatrix - Top=77+29=106, Left=124, Width=98, Height=22
        *-- Value=1 = Sim (this_nChkMatrs=1), Value=2 = Nao (this_nChkMatrs=0)
        *-- When original: INLIST(pcEscolha,'INSERIR','ALTERAR')
        loc_oPagina.AddObject("opt_4c_ChkMatrix", "OptionGroup")
        WITH loc_oPagina.opt_4c_ChkMatrix
            .ButtonCount = 2
            .Top         = 106
            .Left        = 124
            .Width       = 103
            .Height      = 22
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_ChkMatrix.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 42
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_ChkMatrix.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 50
            .Top       = 3
            .Width     = 43
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- ===================================================================
        *-- Shape4: shp_4c_Shape4 - borda decorativa em volta da imagem do produto
        *-- Top=10+29=39, Left=648, Width=163, Height=111
        *-- ===================================================================
        loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPagina.shp_4c_Shape4
            .Top         = 39
            .Left        = 648
            .Width       = 163
            .Height      = 111
            .BorderStyle = 1
            .BorderColor = RGB(128, 128, 128)
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- imgProds: img_4c_ImgProds - Top=12+29=41, Left=650, Width=159, Height=107
        *-- Inicia OCULTA - exibida somente quando produto da grade tem imagem
        loc_oPagina.AddObject("img_4c_ImgProds", "Image")
        WITH loc_oPagina.img_4c_ImgProds
            .Top     = 41
            .Left    = 650
            .Width   = 159
            .Height  = 107
            .Stretch = 2
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.img_4c_ImgProds, "Click", THIS, "ImgProdsClick")

        *-- ===================================================================
        *-- Say3: "Municípios pertencentes a esta restrição:"
        *-- Top=116+29=145, Left=44, Width=199, Height=15
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_TituloMunis", "Label")
        WITH loc_oPagina.lbl_4c_TituloMunis
            .Caption   = "Munic" + CHR(237) + "pios pertencentes a esta restri" + CHR(231) + CHR(227) + "o:"
            .Top       = 145
            .Left      = 44
            .Width     = 199
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- Say4: "Produtos restringidos:"
        *-- Top=116+29=145, Left=418, Width=108, Height=15
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_TituloProds", "Label")
        WITH loc_oPagina.lbl_4c_TituloProds
            .Caption   = "Produtos restringidos:"
            .Top       = 145
            .Left      = 418
            .Width     = 108
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- Cursores placeholder para configuracao inicial dos grids
        *-- (estrutura identica aos criados pelos metodos BuscarMunicipios/BuscarProdutos do BO)
        *-- ===================================================================
        IF !USED("cursor_4c_Munis")
            SET NULL ON
            CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
                tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
            SET NULL OFF
            APPEND BLANK
        ENDIF

        IF !USED("cursor_4c_Prods")
            SET NULL ON
            CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
                dpros C(40), tipos C(1))
            SET NULL OFF
            APPEND BLANK
        ENDIF

        *-- ===================================================================
        *-- cmd_4c_InserirMuni - Inserir linha no GradMuni (inserir do legado)
        *-- Top=305+29=334, Left=356, Width=45, Height=45
        *-- ===================================================================
        loc_oPagina.AddObject("cmd_4c_InserirMuni", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirMuni
            .Caption         = ""
            .ToolTipText     = "Inserir Munic" + CHR(237) + "pio"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 0
            .Top             = 334
            .Left            = 356
            .Width           = 45
            .Height          = 45
            .FontBold        = .T.
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InserirMuni, "Click", THIS, "BtnInserirMuniClick")

        *-- cmd_4c_ExcluirMuni - Excluir linha do GradMuni (excluir do legado)
        *-- Top=350+29=379, Left=356, Width=45, Height=45
        loc_oPagina.AddObject("cmd_4c_ExcluirMuni", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirMuni
            .Caption         = ""
            .ToolTipText     = "Excluir Munic" + CHR(237) + "pio"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 0
            .Top             = 379
            .Left            = 356
            .Width           = 45
            .Height          = 45
            .FontBold        = .T.
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirMuni, "Click", THIS, "BtnExcluirMuniClick")

        *-- ===================================================================
        *-- grd_4c_Munis (GradMuni) - Grade de Municipios
        *-- Top=133+29=162, Left=41, Width=309, Height=456
        *-- Col1=UF(24), Col2=Municipio(263)
        *-- ===================================================================
        loc_oPagina.AddObject("grd_4c_Munis", "Grid")
        loc_oPagina.grd_4c_Munis.ColumnCount = 3
        loc_oPagina.grd_4c_Munis.RecordSource = "cursor_4c_Munis"
        loc_oPagina.grd_4c_Munis.ColumnCount  = 2

        WITH loc_oPagina.grd_4c_Munis
            .Top                = 162
            .Left               = 41
            .Width              = 309
            .Height             = 456
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HeaderHeight       = 20
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .Visible            = .T.

            .Column1.ControlSource     = "cursor_4c_Munis.uf"
            .Column1.Width             = 24
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Resizable         = .T.
            .Column1.Header1.Caption   = "UF"
            .Column1.Header1.Alignment = 2

            .Column2.ControlSource     = "cursor_4c_Munis.munici"
            .Column2.Width             = 263
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Resizable         = .T.
            .Column2.Header1.Caption   = "Munic" + CHR(237) + "pio"
            .Column2.Header1.Alignment = 2
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Munis.Column1.Text1, "KeyPress", THIS, "GradMuniUFLostFocus")
        BINDEVENT(loc_oPagina.grd_4c_Munis.Column2.Text1, "KeyPress", THIS, "GradMuniMunLostFocus")

        *-- ===================================================================
        *-- cmd_4c_InserirProd - Inserir linha no GradProd (InserirV do legado)
        *-- Top=305+29=334, Left=912, Width=45, Height=45
        *-- ===================================================================
        loc_oPagina.AddObject("cmd_4c_InserirProd", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirProd
            .Caption         = ""
            .ToolTipText     = "Inserir Produto"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 0
            .Top             = 334
            .Left            = 912
            .Width           = 45
            .Height          = 45
            .FontBold        = .T.
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InserirProd, "Click", THIS, "BtnInserirProdClick")

        *-- cmd_4c_ExcluirProd - Excluir linha do GradProd (ExcluirV do legado)
        *-- Top=350+29=379, Left=912, Width=45, Height=45
        loc_oPagina.AddObject("cmd_4c_ExcluirProd", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirProd
            .Caption         = ""
            .ToolTipText     = "Excluir Produto"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 0
            .Top             = 379
            .Left            = 912
            .Width           = 45
            .Height          = 45
            .FontBold        = .T.
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirProd, "Click", THIS, "BtnExcluirProdClick")

        *-- ===================================================================
        *-- grd_4c_Prods (GradProd) - Grade de Produtos
        *-- Top=133+29=162, Left=417, Width=490, Height=456
        *-- Col1=Codigo(108), Col2=Descricao(360)
        *-- ===================================================================
        loc_oPagina.AddObject("grd_4c_Prods", "Grid")
        loc_oPagina.grd_4c_Prods.ColumnCount = 3
        loc_oPagina.grd_4c_Prods.RecordSource = "cursor_4c_Prods"
        loc_oPagina.grd_4c_Prods.ColumnCount  = 2

        WITH loc_oPagina.grd_4c_Prods
            .Top                = 162
            .Left               = 417
            .Width              = 490
            .Height             = 456
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HeaderHeight       = 20
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .Visible            = .T.

            .Column1.ControlSource     = "cursor_4c_Prods.cpros"
            .Column1.Width             = 108
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Resizable         = .T.
            .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column1.Header1.Alignment = 2

            .Column2.ControlSource     = "cursor_4c_Prods.dpros"
            .Column2.Width             = 360
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Resizable         = .T.
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Alignment = 2
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Prods.Column1.Text1, "KeyPress", THIS, "GradProdCodLostFocus")
        BINDEVENT(loc_oPagina.grd_4c_Prods.Column2.Text1, "KeyPress", THIS, "GradProdDescLostFocus")
        BINDEVENT(loc_oPagina.grd_4c_Prods, "AfterRowColChange", THIS, "GradProdAfterRowColChange")

        *-- BINDEVENTs para Confirmar e Cancelar (criados acima no cnt_4c_Salva)
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- img_4c_ImgProds inicia oculta (TornarControlesVisiveis setou .T. acima)
        loc_oPagina.img_4c_ImgProds.Visible = .F.
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1 via BO
    * Vincula RecordSource, ControlSource e Header1.Caption apos Buscar()
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 2

                    *-- Reconfigurar ControlSource e Headers apos RecordSource
                    *-- (RecordSource reseta essas propriedades - Problema #2 FORMCOR_LICOES)
                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.iclis"
                        .Column1.Width           = 100
                        .Column1.Header1.Caption = "Conta"

                        .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
                        .Column2.Width           = 450
                        .Column2.Header1.Caption = "Nome"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)

                    IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                        GO TOP IN cursor_4c_Dados
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "Formrst.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1 recarrega a lista automaticamente
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
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
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "Formrst.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara modo INCLUIR e navega para Page2
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.InicializarGradesVazias()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cSkChaves
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.CarregarGrades(loc_cSkChaves)
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cSkChaves
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.CarregarGrades(loc_cSkChaves)
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cSkChaves, loc_cIclis
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
        loc_cIclis    = ALLTRIM(cursor_4c_Dados.iclis)
        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da exclusividade" + CHR(13) + ;
                "da conta: " + loc_cIclis + " ?", "Excluir")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Exclusividade exclu" + CHR(237) + "da com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega a lista completa (reset de filtro)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * Destroy - Limpa cursores e recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Munis")
            USE IN cursor_4c_Munis
        ENDIF
        IF USED("cursor_4c_Prods")
            USE IN cursor_4c_Prods
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles do container visiveis
    * Percorre Pages de PageFrames e controles de Containers recursivamente
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
                    IF !INLIST(UPPER(ALLTRIM(loc_oObjeto.Name)), "CNT_4C_CABECALHO")
                        loc_oObjeto.Visible = .T.
                    ENDIF
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
    * FormatarGridLista - Formata visual do grid da lista (fonte padrao)
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
    * ValidarContaCodigo - Handler LostFocus txt_4c_Codigo
    * Valida conta por codigo via fAcessoContas (sigacess.PRG)
    * Equivalente ao Get_codigo.Valid do legado SIGCDRST
    *===========================================================================
    PROCEDURE ValidarContaCodigo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCodigo, loc_oPg2, loc_cGrupo, loc_nResult
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPg2.txt_4c_Desc.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ""
        TRY
            *-- fAcessoContas: busca por codigo ('C'), preenche ambos os controles
            IF !fAcessoContas(Usuar, loc_cGrupo, "C", loc_cCodigo, ;
                              loc_oPg2.txt_4c_Codigo, loc_oPg2.txt_4c_Desc)
                MsgAviso("Acesso Negado !!", "Aviso")
                loc_oPg2.txt_4c_Codigo.Value = ""
                loc_oPg2.txt_4c_Desc.Value   = ""
                loc_oPg2.txt_4c_Codigo.SetFocus()
            ENDIF
        CATCH TO loException
            *-- fAcessoContas indisponivel: busca direta em SigCdCli
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
                " WHERE Iclis = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaCli")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
                loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
                loc_oPg2.txt_4c_Codigo.Value = ""
                loc_oPg2.txt_4c_Desc.Value   = ""
                loc_oPg2.txt_4c_Codigo.SetFocus()
            ENDIF
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarContaDescricao - Handler LostFocus txt_4c_Desc
    * Valida conta por descricao via fAcessoContas (sigacess.PRG)
    * Equivalente ao Get_Desc.Valid do legado SIGCDRST
    *===========================================================================
    PROCEDURE ValidarContaDescricao
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cDesc, loc_oPg2, loc_cGrupo, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)

        IF EMPTY(loc_cDesc)
            loc_oPg2.txt_4c_Codigo.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ""
        TRY
            *-- fAcessoContas: busca por descricao ('D'), preenche ambos os controles
            IF !fAcessoContas(Usuar, loc_cGrupo, "D", loc_cDesc, ;
                              loc_oPg2.txt_4c_Codigo, loc_oPg2.txt_4c_Desc)
                MsgAviso("Acesso Negado !!", "Aviso")
                loc_oPg2.txt_4c_Desc.Value   = ""
                loc_oPg2.txt_4c_Codigo.Value = ""
                loc_oPg2.txt_4c_Desc.SetFocus()
            ENDIF
        CATCH TO loException
            *-- fAcessoContas indisponivel: busca direta em SigCdCli por nome
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
                " WHERE Rclis LIKE " + EscaparSQL(loc_cDesc + "%"), ;
                "cursor_4c_BuscaCli")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
                loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
                loc_oPg2.txt_4c_Desc.Value   = ""
                loc_oPg2.txt_4c_Codigo.Value = ""
                loc_oPg2.txt_4c_Desc.SetFocus()
            ENDIF
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * ImgProdsClick - Handler Click em img_4c_ImgProds
    * Recarrega imagem do produto selecionado em GradProd (cursor_4c_Prods)
    * Equivalente ao imgProds.Click do legado SIGCDRST
    *===========================================================================
    PROCEDURE ImgProdsClick()
        LOCAL loc_cCodPro, loc_nResult, loc_cArquivo, loc_cFoto, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods")
            RETURN
        ENDIF

        SELECT cursor_4c_Prods
        loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
        IF EMPTY(loc_cCodPro)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.cpros, a.FigJpgs FROM SigCdPro a" + ;
                " WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
                "cursor_4c_ImgPro")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgPro") > 0
                SELECT cursor_4c_ImgPro
                IF !EMPTY(NVL(cursor_4c_ImgPro.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgPro.FigJpgs)
                    loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
                    loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgPro.FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, loc_cArquivo)
                    loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
                    loc_oPg2.img_4c_ImgProds.Visible = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao exibir imagem:" + CHR(13) + loException.Message, ;
                "Formrst.ImgProdsClick")
            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e persiste o registro (INCLUIR ou ALTERAR)
    * Chamado via BINDEVENT cnt_4c_Salva.cmd_4c_Confirmar Click
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_cIclis, loc_nQtdProd, loc_oPg2, loc_lValido, loc_nRec
        loc_lResultado = .F.
        loc_lValido    = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Validar conta obrigatoria
            loc_cIclis = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            IF EMPTY(loc_cIclis)
                MsgAviso("Conta obrigat" + CHR(243) + "ria.", "Aviso")
                loc_oPg2.txt_4c_Codigo.SetFocus()
            ELSE
                *-- Contar produtos com cpros valido
                loc_nQtdProd = 0
                IF USED("cursor_4c_Prods")
                    SELECT cursor_4c_Prods
                    loc_nRec = RECNO()
                    GO TOP
                    SCAN FOR !DELETED()
                        IF !EMPTY(ALLTRIM(cpros))
                            loc_nQtdProd = loc_nQtdProd + 1
                        ENDIF
                    ENDSCAN
                    IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
                        GO (loc_nRec) IN cursor_4c_Prods
                    ENDIF
                ENDIF
                IF loc_nQtdProd = 0
                    MsgAviso("Informe ao menos um produto.", "Aviso")
                ELSE
                    IF THIS.this_cModoAtual = "INCLUIR"
                        IF THIS.this_oBusinessObject.VerificarContaCadastrada(loc_cIclis)
                            MsgAviso("Esta conta j" + CHR(225) + " possui exclusividade cadastrada.", "Aviso")
                            loc_oPg2.txt_4c_Codigo.SetFocus()
                        ELSE
                            loc_lValido = .T.
                        ENDIF
                    ELSE
                        loc_lValido = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lValido
                THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Exclusividade gravada com sucesso!")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Formrst.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    * Chamado via BINDEVENT cnt_4c_Salva.cmd_4c_Cancelar Click
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos controles para propriedades do BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        THIS.this_oBusinessObject.this_cIclis    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cRclis    = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
        THIS.this_oBusinessObject.this_nChkMatrs = IIF(loc_oPg2.opt_4c_ChkMatrix.Value = 1, 1, 0)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BO para controles do formulario
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cIclis)
        loc_oPg2.txt_4c_Desc.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cRclis)
        loc_oPg2.opt_4c_ChkMatrix.Value = IIF(THIS.this_oBusinessObject.this_nChkMatrs = 1, 1, 2)
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Liga/desliga edicao dos controles da Page2
    * par_lHabilitar=.T.: INCLUIR/ALTERAR; .F.: VISUALIZAR (somente leitura)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Codigo.ReadOnly      = !par_lHabilitar
        loc_oPg2.opt_4c_ChkMatrix.Enabled    = par_lHabilitar
        loc_oPg2.grd_4c_Munis.ReadOnly       = !par_lHabilitar
        loc_oPg2.grd_4c_Prods.ReadOnly       = !par_lHabilitar
    ENDPROC

    *===========================================================================
    * LimparCampos - Reseta controles da Page2 para estado inicial
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Codigo.Value     = ""
        loc_oPg2.txt_4c_Desc.Value       = ""
        loc_oPg2.opt_4c_ChkMatrix.Value  = 2
        loc_oPg2.img_4c_ImgProds.Visible = .F.
    ENDPROC

    *===========================================================================
    * CarregarGrades - Popula ambas as grids via BO para o skChaves dado
    *===========================================================================
    PROTECTED PROCEDURE CarregarGrades(par_cSkChaves)
        THIS.this_oBusinessObject.BuscarMunicipios(par_cSkChaves)
        THIS.this_oBusinessObject.BuscarProdutos(par_cSkChaves)
        THIS.RefreshGridMunis()
        THIS.RefreshGridProds()
    ENDPROC

    *===========================================================================
    * InicializarGradesVazias - Cria cursores locais vazios (1 linha em branco)
    * Usado em modo INCLUIR para permitir digitacao imediata nas grades
    *===========================================================================
    PROTECTED PROCEDURE InicializarGradesVazias()
        IF USED("cursor_4c_Munis")
            USE IN cursor_4c_Munis
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
            tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
        SET NULL OFF
        APPEND BLANK IN cursor_4c_Munis
        GO TOP IN cursor_4c_Munis

        IF USED("cursor_4c_Prods")
            USE IN cursor_4c_Prods
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
            dpros C(40), tipos C(1))
        SET NULL OFF
        APPEND BLANK IN cursor_4c_Prods
        GO TOP IN cursor_4c_Prods

        THIS.RefreshGridMunis()
        THIS.RefreshGridProds()
    ENDPROC

    *===========================================================================
    * RefreshGridMunis - Rebinda grd_4c_Munis ao cursor_4c_Munis
    * Necessario apos BuscarMunicipios() recriar o cursor (Problema #2/#48)
    *===========================================================================
    PROTECTED PROCEDURE RefreshGridMunis()
        LOCAL loc_oGrid
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Munis
            loc_oGrid.ColumnCount = 3
            loc_oGrid.RecordSource = "cursor_4c_Munis"
            loc_oGrid.ColumnCount  = 2
            WITH loc_oGrid
                .Column1.ControlSource   = "cursor_4c_Munis.uf"
                .Column1.Width           = 24
                .Column1.Header1.Caption = "UF"
                .Column2.ControlSource   = "cursor_4c_Munis.munici"
                .Column2.Width           = 263
                .Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
            ENDWITH
            loc_oGrid.Refresh()
        CATCH TO loException
            MsgErro("Erro ao atualizar grade munic" + CHR(237) + "pios:" + CHR(13) + ;
                loException.Message, "Formrst.RefreshGridMunis")
        ENDTRY
    ENDPROC

    *===========================================================================
    * RefreshGridProds - Rebinda grd_4c_Prods ao cursor_4c_Prods
    * Necessario apos BuscarProdutos() recriar o cursor (Problema #2/#48)
    *===========================================================================
    PROTECTED PROCEDURE RefreshGridProds()
        LOCAL loc_oGrid
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Prods
            loc_oGrid.ColumnCount = 3
            loc_oGrid.RecordSource = "cursor_4c_Prods"
            loc_oGrid.ColumnCount  = 2
            WITH loc_oGrid
                .Column1.ControlSource   = "cursor_4c_Prods.cpros"
                .Column1.Width           = 108
                .Column1.Header1.Caption = CHR(67) + CHR(243) + "digo"
                .Column2.ControlSource   = "cursor_4c_Prods.dpros"
                .Column2.Width           = 360
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH
            loc_oGrid.Refresh()
        CATCH TO loException
            MsgErro("Erro ao atualizar grade produtos:" + CHR(13) + loException.Message, ;
                "Formrst.RefreshGridProds")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GradMuniUFLostFocus - Valida UF digitada na Column1 de grd_4c_Munis
    * Busca em SigCdUfs; se nao encontrado abre FormBuscaAuxiliar
    *===========================================================================
    PROCEDURE GradMuniUFLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cUF, loc_nResult, loc_oBusca

        IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
            RETURN
        ENDIF

        SELECT cursor_4c_Munis
        loc_cUF = ALLTRIM(cursor_4c_Munis.uf)

        IF EMPTY(loc_cUF)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
                " WHERE estados = " + EscaparSQL(loc_cUF), ;
                "cursor_4c_BuscaUf")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaUf") > 0
                SELECT cursor_4c_Munis
                REPLACE uf      WITH ALLTRIM(cursor_4c_BuscaUf.estados), ;
                        UFIBGEs WITH cursor_4c_BuscaUf.ufibges
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs" + ;
                    " WHERE estados LIKE " + EscaparSQL(loc_cUF + "%") + ;
                    " ORDER BY estados", ;
                    "cursor_4c_BuscaUfs")
                IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaUfs") = 0
                    IF USED("cursor_4c_BuscaUfs")
                        USE IN cursor_4c_BuscaUfs
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs ORDER BY estados", ;
                        "cursor_4c_BuscaUfs")
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUfs"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaUfs", "codigo", "descricao", "UF")
                    loc_oBusca.Mostrar()
                    IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
                            " WHERE estados = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
                            "cursor_4c_UfSel")
                        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_UfSel") > 0
                            SELECT cursor_4c_Munis
                            REPLACE uf      WITH ALLTRIM(cursor_4c_UfSel.estados), ;
                                    UFIBGEs WITH cursor_4c_UfSel.ufibges
                        ENDIF
                        IF USED("cursor_4c_UfSel")
                            USE IN cursor_4c_UfSel
                        ENDIF
                    ELSE
                        SELECT cursor_4c_Munis
                        REPLACE uf WITH "", UFIBGEs WITH 0
                    ENDIF
                    IF USED("cursor_4c_BuscaUfs")
                        USE IN cursor_4c_BuscaUfs
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaUf")
                USE IN cursor_4c_BuscaUf
            ENDIF
            THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
        CATCH TO loException
            MsgErro("Erro ao validar UF:" + CHR(13) + loException.Message, ;
                "Formrst.GradMuniUFLostFocus")
            IF USED("cursor_4c_BuscaUf")
                USE IN cursor_4c_BuscaUf
            ENDIF
            IF USED("cursor_4c_BuscaUfs")
                USE IN cursor_4c_BuscaUfs
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * GradMuniMunLostFocus - Valida municipio digitado na Column2 de grd_4c_Munis
    * Verifica duplicidade + busca em SigCdMun; se nao encontrado abre picker
    *===========================================================================
    PROCEDURE GradMuniMunLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cMunici, loc_cUF, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec

        IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
            RETURN
        ENDIF

        SELECT cursor_4c_Munis
        loc_cMunici = ALLTRIM(cursor_4c_Munis.munici)
        loc_cUF     = ALLTRIM(cursor_4c_Munis.uf)

        IF EMPTY(loc_cMunici)
            RETURN
        ENDIF

        TRY
            *-- Verificar duplicidade: mesmo uf + munici em outra linha
            SELECT cursor_4c_Munis
            loc_nRec = RECNO()
            GO TOP
            loc_nContagem = 0
            SCAN FOR !DELETED()
                IF ALLTRIM(uf) = loc_cUF AND ALLTRIM(munici) = loc_cMunici
                    loc_nContagem = loc_nContagem + 1
                ENDIF
            ENDSCAN
            IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Munis")
                GO (loc_nRec) IN cursor_4c_Munis
            ENDIF

            IF loc_nContagem > 1
                MsgAviso("Munic" + CHR(237) + "pio j" + CHR(225) + ;
                    " adicionado para este estado.", "Aviso")
                SELECT cursor_4c_Munis
                REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
                THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
            ELSE
                *-- Busca exata em SigCdMun pelo nome do municipio
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 a.codigos, a.descs," + ;
                    " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
                    " FROM SigCdMun a" + ;
                    " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
                    " WHERE a.descs = " + EscaparSQL(loc_cMunici), ;
                    "cursor_4c_BuscaMun")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaMun") > 0
                    SELECT cursor_4c_Munis
                    REPLACE codibges WITH ALLTRIM(cursor_4c_BuscaMun.codigos), ;
                            munici   WITH ALLTRIM(cursor_4c_BuscaMun.descs), ;
                            uf       WITH ALLTRIM(cursor_4c_BuscaMun.uf), ;
                            UFIBGEs  WITH cursor_4c_BuscaMun.UFIBGEs
                ELSE
                    *-- Abrir picker de municipios
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
                        " FROM SigCdMun a" + ;
                        " WHERE a.descs LIKE " + EscaparSQL(loc_cMunici + "%") + ;
                        " ORDER BY a.descs", ;
                        "cursor_4c_BuscaMuns")
                    IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaMuns") = 0
                        IF USED("cursor_4c_BuscaMuns")
                            USE IN cursor_4c_BuscaMuns
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
                            " FROM SigCdMun a ORDER BY a.descs", ;
                            "cursor_4c_BuscaMuns")
                    ENDIF
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMuns"
                        loc_oBusca.DefinirCursor("cursor_4c_BuscaMuns", "codigo", "descricao", ;
                            "Munic" + CHR(237) + "pio")
                        loc_oBusca.Mostrar()
                        IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT TOP 1 a.codigos, a.descs," + ;
                                " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
                                " FROM SigCdMun a" + ;
                                " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
                                " WHERE a.codigos = " + ;
                                EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
                                "cursor_4c_MunSel")
                            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MunSel") > 0
                                SELECT cursor_4c_Munis
                                REPLACE codibges WITH ALLTRIM(cursor_4c_MunSel.codigos), ;
                                        munici   WITH ALLTRIM(cursor_4c_MunSel.descs), ;
                                        uf       WITH ALLTRIM(cursor_4c_MunSel.uf), ;
                                        UFIBGEs  WITH cursor_4c_MunSel.UFIBGEs
                            ENDIF
                            IF USED("cursor_4c_MunSel")
                                USE IN cursor_4c_MunSel
                            ENDIF
                        ELSE
                            SELECT cursor_4c_Munis
                            REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
                        ENDIF
                        IF USED("cursor_4c_BuscaMuns")
                            USE IN cursor_4c_BuscaMuns
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaMun")
                    USE IN cursor_4c_BuscaMun
                ENDIF
                THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
                "Formrst.GradMuniMunLostFocus")
            IF USED("cursor_4c_BuscaMun")
                USE IN cursor_4c_BuscaMun
            ENDIF
            IF USED("cursor_4c_BuscaMuns")
                USE IN cursor_4c_BuscaMuns
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * GradProdCodLostFocus - Valida codigo de produto (cpros) na Column1 de grd_4c_Prods
    * Busca em SigCdPro; se nao encontrado abre FormBuscaAuxiliar
    *===========================================================================
    PROCEDURE GradProdCodLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cCpros, loc_nResult, loc_oBusca

        IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
            RETURN
        ENDIF

        SELECT cursor_4c_Prods
        loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)

        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
                " WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
                "cursor_4c_BuscaPro")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaPro") > 0
                SELECT cursor_4c_Prods
                REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.cpros), ;
                        dpros WITH ALLTRIM(cursor_4c_BuscaPro.dpros)
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
                    " WHERE a.cpros LIKE " + EscaparSQL(loc_cCpros + "%") + ;
                    " ORDER BY a.cpros", ;
                    "cursor_4c_BuscaPros")
                IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaPros") = 0
                    IF USED("cursor_4c_BuscaPros")
                        USE IN cursor_4c_BuscaPros
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
                        " ORDER BY a.cpros", ;
                        "cursor_4c_BuscaPros")
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaPros"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaPros", "codigo", "descricao", ;
                        CHR(67) + CHR(243) + "digo do Produto")
                    loc_oBusca.Mostrar()
                    IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
                            " WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
                            "cursor_4c_ProSel")
                        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProSel") > 0
                            SELECT cursor_4c_Prods
                            REPLACE cpros WITH ALLTRIM(cursor_4c_ProSel.cpros), ;
                                    dpros WITH ALLTRIM(cursor_4c_ProSel.dpros)
                        ENDIF
                        IF USED("cursor_4c_ProSel")
                            USE IN cursor_4c_ProSel
                        ENDIF
                    ELSE
                        SELECT cursor_4c_Prods
                        REPLACE cpros WITH "", dpros WITH ""
                    ENDIF
                    IF USED("cursor_4c_BuscaPros")
                        USE IN cursor_4c_BuscaPros
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaPro")
                USE IN cursor_4c_BuscaPro
            ENDIF
            THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
        CATCH TO loException
            MsgErro("Erro ao validar produto:" + CHR(13) + loException.Message, ;
                "Formrst.GradProdCodLostFocus")
            IF USED("cursor_4c_BuscaPro")
                USE IN cursor_4c_BuscaPro
            ENDIF
            IF USED("cursor_4c_BuscaPros")
                USE IN cursor_4c_BuscaPros
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * GradProdDescLostFocus - Valida descricao (dpros) na Column2 de grd_4c_Prods
    * Verifica duplicidade de cpros + busca em SigCdPro por descricao
    *===========================================================================
    PROCEDURE GradProdDescLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cDpros, loc_cCpros, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec

        IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
            RETURN
        ENDIF

        SELECT cursor_4c_Prods
        loc_cDpros = ALLTRIM(cursor_4c_Prods.dpros)
        loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)

        IF EMPTY(loc_cDpros)
            RETURN
        ENDIF

        TRY
            IF !EMPTY(loc_cCpros)
                *-- Verificar duplicidade: mesmo cpros em outra linha
                SELECT cursor_4c_Prods
                loc_nRec = RECNO()
                GO TOP
                loc_nContagem = 0
                SCAN FOR !DELETED()
                    IF ALLTRIM(cpros) = loc_cCpros
                        loc_nContagem = loc_nContagem + 1
                    ENDIF
                ENDSCAN
                IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
                    GO (loc_nRec) IN cursor_4c_Prods
                ENDIF
                IF loc_nContagem > 1
                    MsgAviso("Produto j" + CHR(225) + " adicionado a esta exclusividade.", "Aviso")
                    SELECT cursor_4c_Prods
                    REPLACE cpros WITH "", dpros WITH ""
                ENDIF
                THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
            ELSE
                *-- cpros vazio: buscar produto por descricao digitada
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
                    " WHERE a.dpros LIKE " + EscaparSQL(loc_cDpros + "%") + ;
                    " ORDER BY a.dpros", ;
                    "cursor_4c_BuscaDpros")
                IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaDpros") = 0
                    IF USED("cursor_4c_BuscaDpros")
                        USE IN cursor_4c_BuscaDpros
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
                        " ORDER BY a.dpros", ;
                        "cursor_4c_BuscaDpros")
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDpros"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaDpros", "codigo", "descricao", ;
                        "Descri" + CHR(231) + CHR(227) + "o do Produto")
                    loc_oBusca.Mostrar()
                    IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
                        SELECT cursor_4c_Prods
                        REPLACE cpros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado), ;
                                dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ELSE
                        SELECT cursor_4c_Prods
                        REPLACE cpros WITH "", dpros WITH ""
                    ENDIF
                    IF USED("cursor_4c_BuscaDpros")
                        USE IN cursor_4c_BuscaDpros
                    ENDIF
                ENDIF
                THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "Formrst.GradProdDescLostFocus")
            IF USED("cursor_4c_BuscaDpros")
                USE IN cursor_4c_BuscaDpros
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * GradProdAfterRowColChange - Exibe imagem do produto selecionado em grd_4c_Prods
    * LPARAMETERS obrigatorio para AfterRowColChange via BINDEVENT
    *===========================================================================
    PROCEDURE GradProdAfterRowColChange(par_nColIndex)
        LOCAL loc_cCodPro, loc_nResult, loc_cArquivo, loc_cFoto, loc_oPg2, loc_lTemImagem
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
            loc_oPg2.img_4c_ImgProds.Visible = .F.
            RETURN
        ENDIF

        SELECT cursor_4c_Prods
        loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)

        IF EMPTY(loc_cCodPro)
            loc_oPg2.img_4c_ImgProds.Visible = .F.
            RETURN
        ENDIF

        TRY
            loc_lTemImagem = .F.
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
                "cursor_4c_ImgArc")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgArc") > 0
                SELECT cursor_4c_ImgArc
                IF !EMPTY(NVL(cursor_4c_ImgArc.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgArc.FigJpgs)
                    loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
                    loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgArc.FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, loc_cArquivo)
                    loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
                    loc_oPg2.img_4c_ImgProds.Visible = .T.
                    loc_lTemImagem = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_ImgArc")
                USE IN cursor_4c_ImgArc
            ENDIF
            IF !loc_lTemImagem
                loc_oPg2.img_4c_ImgProds.Visible = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar imagem:" + CHR(13) + loException.Message, ;
                "Formrst.GradProdAfterRowColChange")
            IF USED("cursor_4c_ImgArc")
                USE IN cursor_4c_ImgArc
            ENDIF
            loc_oPg2.img_4c_ImgProds.Visible = .F.
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnInserirMuniClick - Adiciona linha em branco na grade de municipios
    *===========================================================================
    PROCEDURE BtnInserirMuniClick()
        TRY
            IF !USED("cursor_4c_Munis")
                THIS.InicializarGradesVazias()
            ELSE
                SELECT cursor_4c_Munis
                APPEND BLANK
                REPLACE tipos    WITH "M", ;
                        pkchaves WITH "", ;
                        munici   WITH "", ;
                        codibges WITH "", ;
                        uf       WITH "", ;
                        UFIBGEs  WITH 0
                THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
                "Formrst.BtnInserirMuniClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirMuniClick - Remove municipio selecionado da grade
    *===========================================================================
    PROCEDURE BtnExcluirMuniClick()
        IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
            MsgAviso("Selecione um munic" + CHR(237) + "pio para excluir.", "Aviso")
            RETURN
        ENDIF
        TRY
            SELECT cursor_4c_Munis
            DELETE
            THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
        CATCH TO loException
            MsgErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
                "Formrst.BtnExcluirMuniClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnInserirProdClick - Adiciona linha em branco na grade de produtos
    *===========================================================================
    PROCEDURE BtnInserirProdClick()
        TRY
            IF !USED("cursor_4c_Prods")
                THIS.InicializarGradesVazias()
            ELSE
                SELECT cursor_4c_Prods
                APPEND BLANK
                REPLACE tipos    WITH "P", ;
                        pkchaves WITH "", ;
                        cpros    WITH "", ;
                        dpros    WITH ""
                THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir produto:" + CHR(13) + loException.Message, ;
                "Formrst.BtnInserirProdClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirProdClick - Remove produto selecionado da grade
    *===========================================================================
    PROCEDURE BtnExcluirProdClick()
        IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
            MsgAviso("Selecione um produto para excluir.", "Aviso")
            RETURN
        ENDIF
        TRY
            SELECT cursor_4c_Prods
            DELETE
            THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
        CATCH TO loException
            MsgErro("Erro ao excluir produto:" + CHR(13) + loException.Message, ;
                "Formrst.BtnExcluirProdClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo atual
    * INCLUIR/ALTERAR -> Confirmar habilitado; VISUALIZAR -> Confirmar desabilitado
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        TRY
            loc_oPg2      = THIS.pgf_4c_Paginas.Page2
            loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.

            loc_oPg2.cmd_4c_InserirMuni.Enabled = loc_lEditando
            loc_oPg2.cmd_4c_ExcluirMuni.Enabled = loc_lEditando
            loc_oPg2.cmd_4c_InserirProd.Enabled = loc_lEditando
            loc_oPg2.cmd_4c_ExcluirProd.Enabled = loc_lEditando
            loc_oPg2.grd_4c_Munis.ReadOnly       = !loc_lEditando
            loc_oPg2.grd_4c_Prods.ReadOnly       = !loc_lEditando
        CATCH TO loException
            MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
                "Formrst.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\rstBO.prg):
*==============================================================================
* rstBO.prg - Business Object para Exclusividade Por Contas (SigCdRst/SigCdRsi)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS rstBO AS BusinessBase

    *-- SigCdRst - Propriedades principais
    this_cSkChaves  = ""    && skchaves  C(20) PK
    this_cIclis     = ""    && iclis     C(10) FK SigCdCli
    this_nChkMatrs  = 0     && chkmatrs  N(1,0) Checa Matriz (op_con)
    this_dDatas     = {}    && datas     D nullable
    this_dDtAlts    = {}    && dtalts    D nullable (auditoria)

    *-- Propriedade derivada (JOIN SigCdCli) - somente exibicao
    this_cRclis     = ""    && Rclis C(40) nome do cliente

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRst"
            THIS.this_cCampoChave = "skChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de exclusividades com nome do cliente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " ORDER BY b.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar exclusividades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (skchaves C(20), iclis C(10), Rclis C(40), ;
                    chkmatrs N(1,0), datas T, dtalts T)
                SET NULL OFF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro SigCdRst por skChaves
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves)
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
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSkChaves = TratarNulo(skchaves, "C")
            THIS.this_cIclis    = TratarNulo(iclis,    "C")
            THIS.this_cRclis    = TratarNulo(Rclis,    "C")
            THIS.this_nChkMatrs = TratarNulo(chkmatrs, "N")
            THIS.this_dDatas    = TratarNulo(datas,    "D")
            THIS.this_dDtAlts   = TratarNulo(dtalts,   "D")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMunicipios - Carrega SigCdRsi tipo 'M' para o skChaves dado
    * Popula cursor_4c_Munis com: skchaves, pkchaves, codibges, tipos, UFIBGEs, munici, uf
    *--------------------------------------------------------------------------
    FUNCTION BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Munis")
                USE IN cursor_4c_Munis
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
                tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.codibges, a.tipos," + ;
                           " a.ufibges AS UFIBGEs," + ;
                           " ISNULL(c.descs,'') AS munici, ISNULL(d.estados,'') AS uf" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdMun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN SigCdUfs d ON d.ufibges = a.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'M'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MunisTmp")
                    TABLEREVERT(.T., "cursor_4c_MunisTmp")
                    USE IN cursor_4c_MunisTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MunisTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_MunisTmp
                    SCAN
                        SELECT cursor_4c_Munis
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.pkchaves, "")), ;
                                codibges WITH ALLTRIM(NVL(cursor_4c_MunisTmp.codibges, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_MunisTmp.tipos, "")), ;
                                UFIBGEs  WITH NVL(cursor_4c_MunisTmp.UFIBGEs, 0), ;
                                munici   WITH ALLTRIM(NVL(cursor_4c_MunisTmp.munici, "")), ;
                                uf       WITH ALLTRIM(NVL(cursor_4c_MunisTmp.uf, ""))
                        SELECT cursor_4c_MunisTmp
                    ENDSCAN
                    IF USED("cursor_4c_MunisTmp")
                        USE IN cursor_4c_MunisTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Munis
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Munis
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar munic" + CHR(237) + "pios:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_MunisTmp")
                USE IN cursor_4c_MunisTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Carrega SigCdRsi tipo 'P' para o skChaves dado
    * Popula cursor_4c_Prods com: skchaves, pkchaves, cpros, dpros, tipos
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutos(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Prods")
                USE IN cursor_4c_Prods
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
                dpros C(40), tipos C(1))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.cpros," + ;
                           " ISNULL(c.dpros,'') AS dpros, a.tipos" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdPro c ON c.cpros = a.cpros" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'P'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ProdsTmp")
                    TABLEREVERT(.T., "cursor_4c_ProdsTmp")
                    USE IN cursor_4c_ProdsTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdsTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_ProdsTmp
                    SCAN
                        SELECT cursor_4c_Prods
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.pkchaves, "")), ;
                                cpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.cpros, "")), ;
                                dpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.dpros, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.tipos, ""))
                        SELECT cursor_4c_ProdsTmp
                    ENDSCAN
                    IF USED("cursor_4c_ProdsTmp")
                        USE IN cursor_4c_ProdsTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Prods
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Prods
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar produtos:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProdsTmp")
                USE IN cursor_4c_ProdsTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarContaCadastrada - Checa se Iclis ja tem exclusividade em SigCdRst
    *--------------------------------------------------------------------------
    FUNCTION VerificarContaCadastrada(par_cIclis)
        LOCAL loc_lExiste, loc_nResult
        loc_lExiste = .F.
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 skchaves FROM SigCdRst WHERE iclis = " + EscaparSQL(par_cIclis), ;
                "cursor_4c_ChkRst")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkRst") > 0
                loc_lExiste = .T.
            ENDIF
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave C(20) via NEWID do SQL Server
    *--------------------------------------------------------------------------
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS novachave", ;
                "cursor_4c_NewId")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChave = ALLTRIM(novachave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        ENDTRY
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirItensSigCdRsi - INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    * Metodo auxiliar compartilhado por Inserir() e Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirItensSigCdRsi()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cPkChave
        loc_lResultado = .T.

        *-- INSERT municipios (tipo 'M')
        IF USED("cursor_4c_Munis")
            SELECT cursor_4c_Munis
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Munis.codibges)) OR cursor_4c_Munis.UFIBGEs <> 0
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Munis.codibges)) + "," + ;
                                   "'M'," + ;
                                   FormatarNumeroSQL(cursor_4c_Munis.UFIBGEs) + "," + ;
                                   "''," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Munis
            ENDSCAN
        ENDIF

        *-- INSERT produtos (tipo 'P')
        IF USED("cursor_4c_Prods")
            SELECT cursor_4c_Prods
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Prods.cpros))
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "''," + ;
                                   "'P'," + ;
                                   "0," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Prods.cpros)) + "," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Prods
            ENDSCAN
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRst + INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = THIS.GerarChaveUnica()
            IF EMPTY(loc_cSQL)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cSkChaves = loc_cSQL

                loc_cSQL = "INSERT INTO SigCdRst (skchaves, iclis, chkmatrs, datas, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cSkChaves) + "," + ;
                           EscaparSQL(THIS.this_cIclis) + "," + ;
                           FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           "GETDATE(), NULL)"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRst")
                    TABLEREVERT(.T., "cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRst")
                IF USED("cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRst + DELETE SigCdRsi + INSERT SigCdRsi novos itens
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi antigos
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi")
            IF USED("cursor_4c_DelRsi")
                USE IN cursor_4c_DelRsi
            ENDIF

            IF loc_nResult >= 0
                *-- UPDATE SigCdRst
                loc_cSQL = "UPDATE SigCdRst SET" + ;
                           " iclis = " + EscaparSQL(THIS.this_cIclis) + "," + ;
                           " chkmatrs = " + FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           " dtalts = GETDATE()" + ;
                           " WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_UpdRst")
                    TABLEREVERT(.T., "cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRst")
                IF USED("cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao atualizar exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao limpar itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRsi e SigCdRst (nesta ordem - FK constraint)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi primeiro (filho)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi2")
            IF USED("cursor_4c_DelRsi2")
                USE IN cursor_4c_DelRsi2
            ENDIF

            IF loc_nResult >= 0
                *-- DELETE SigCdRst (pai)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdRst WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                    "cursor_4c_DelRst")
                IF USED("cursor_4c_DelRst")
                    USE IN cursor_4c_DelRst
                ENDIF

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

