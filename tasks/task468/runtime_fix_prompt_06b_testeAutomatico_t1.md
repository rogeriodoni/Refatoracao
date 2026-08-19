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
[2026-08-19 08:50:29] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-19 08:50:29] [INFO] Config FPW: (nao fornecido)
[2026-08-19 08:50:29] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 08:50:29] [INFO] Timeout: 300 segundos
[2026-08-19 08:50:29] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_on1l4rba.prg
[2026-08-19 08:50:29] [INFO] Conteudo do wrapper:
[2026-08-19 08:50:29] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormMrc', 'C:\4c\tasks\task468', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMrc', 'C:\4c\tasks\task468', 'CRUD'
QUIT

[2026-08-19 08:50:29] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_on1l4rba.prg
[2026-08-19 08:50:29] [INFO] VFP output esperado em: C:\4c\tasks\task468\vfp_output.txt
[2026-08-19 08:50:29] [INFO] Executando Visual FoxPro 9...
[2026-08-19 08:50:29] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_on1l4rba.prg
[2026-08-19 08:50:29] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_on1l4rba.prg
[2026-08-19 08:50:29] [INFO] Timeout configurado: 300 segundos
[2026-08-19 08:51:43] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-19 08:51:43] [INFO] VFP9 finalizado em 74.2779812 segundos
[2026-08-19 08:51:43] [INFO] Exit Code: 
[2026-08-19 08:51:43] [INFO] 
[2026-08-19 08:51:43] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-19 08:51:43] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_on1l4rba.prg
[2026-08-19 08:51:43] [INFO] 
[2026-08-19 08:51:43] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-19 08:51:43] [INFO] * Auto-generated wrapper for parameters
[2026-08-19 08:51:43] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 08:51:43] [INFO] * Parameters: 'FormMrc', 'C:\4c\tasks\task468', 'CRUD'
[2026-08-19 08:51:43] [INFO] 
[2026-08-19 08:51:43] [INFO] * Anti-dialog protections for unattended execution
[2026-08-19 08:51:43] [INFO] SET SAFETY OFF
[2026-08-19 08:51:43] [INFO] SET RESOURCE OFF
[2026-08-19 08:51:43] [INFO] SET TALK OFF
[2026-08-19 08:51:43] [INFO] SET NOTIFY OFF
[2026-08-19 08:51:43] [INFO] SYS(2335, 0)
[2026-08-19 08:51:43] [INFO] 
[2026-08-19 08:51:43] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMrc', 'C:\4c\tasks\task468', 'CRUD'
[2026-08-19 08:51:43] [INFO] QUIT
[2026-08-19 08:51:43] [INFO] 
[2026-08-19 08:51:43] [INFO] === Fim do Wrapper.prg ===
[2026-08-19 08:51:43] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormMrc",
  "timestamp": "20260819085143",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMrc.prg):
*==============================================================================
* FormMrc.prg - Formulario de Cadastro de Demonstrativos
* Migrado de: SigCdMrc.SCX (frmcadastro)
* Tabela principal: SigCdMrr (Demonstrativos)
* Tabela relacionada: SigCdMri (Itens do Demonstrativo)
*==============================================================================
DEFINE CLASS FormMrc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Demonstrativos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cCursorDados    = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - FormBase.Init() chama InicializarForm() automaticamente
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormMrc:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("MrcBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar MrcBO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF
                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF THIS.DataSession = 2
                    SET DATE TO BRITISH
                    SET CENTURY ON
                ENDIF

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formulario:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o PageFrame com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height
            .Tabs      = .F.

            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 com cabecalho, botoes CRUD e grade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza escuro (cntSombra no legado)
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
            .Width     = THIS.Width - 20
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
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op no legado: Left=343, Top=-1 -> canonico Left=542, Top=29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir (Inserir no legado: Left=5, Top=5)
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

        *-- Visualizar (Consultar no legado: Left=80, Top=5)
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

        *-- Alterar (Left=155, Top=5)
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

        *-- Excluir (Left=230, Top=5)
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

        *-- Buscar (Procurar no legado: Left=305, Top=5)
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

        *-- Container Saida - padrao canonico (Grupo_Saida no legado: Left=718, Top=-1)
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botao Itens (Legado: Top=86, Left=347, Width=105, Height=45 -> Top compensado +29)
        loc_oPagina.AddObject("cmd_4c_Itens", "CommandButton")
        WITH loc_oPagina.cmd_4c_Itens
            .Caption         = "Itens"
            .Picture         = gc_4c_CaminhoIcones + "folder31.ico"
            .PicturePosition = 13
            .Top             = 115
            .Left            = 347
            .Width           = 105
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .F.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Itens"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Itens, "Click", THIS, "BtnItensClick")

        *-- Grade (Legado: Grade.Top=133, Left=32, Width=736, Height=433 -> Top +29=162)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 162
            .Left               = 32
            .Width              = 736
            .Height             = 433
            .FontName           = "Tahoma"
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
        *-- ColumnCount FORA de WITH para criar colunas imediatamente (Problema 36)
        loc_oPagina.grd_4c_Lista.ColumnCount = 3

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: botoes Confirmar/Cancelar,
    * labels e campos (txt_4c_Balanco, txt_4c_Titulo, opt_4c_Impressao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label: Demonstrativo (Say1: Top=195, Left=210, Height=15 -> Top +29=224)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Demonstrativo : "
            .Top       = 224
            .Left      = 210
            .Height    = 15
            .Width     = 87
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Titulo (Say2: Top=220, Left=254 -> Top +29=249)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "T" + CHR(237) + "tulo : "
            .Top       = 249
            .Left      = 254
            .Height    = 15
            .Width     = 43
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Impressao (Say3: Top=247, Left=230 -> Top +29=276)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Impress" + CHR(227) + "o : "
            .Top       = 276
            .Left      = 230
            .Height    = 15
            .Width     = 67
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Campo Demonstrativo (Get_balanco: Top=192, Left=299, Width=150 -> Top +29=221)
        *-- Format="!K" = uppercase + clear-on-focus; chave primaria char(20)
        loc_oPagina.AddObject("txt_4c_Balanco", "TextBox")
        WITH loc_oPagina.txt_4c_Balanco
            .Value     = ""
            .Top       = 221
            .Left      = 299
            .Width     = 150
            .Height    = 20
            .MaxLength = 20
            .Format    = "!K"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- Campo Titulo (Get_titulo: Top=217, Left=299, Width=290 -> Top +29=246)
        *-- char(40)
        loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
        WITH loc_oPagina.txt_4c_Titulo
            .Value     = ""
            .Top       = 246
            .Left      = 299
            .Width     = 290
            .Height    = 20
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Impressao (fwoption1: Top=242, Left=299, Width=239, Height=27 -> Top +29=271)
        *-- Option1="Plano de Contas" (Value=1), Option2="Mapa de Contas" (Value=2)
        *-- ATENCAO: NAO setar .Value em Buttons(N) - causa todos radios marcados
        loc_oPagina.AddObject("opt_4c_Impressao", "OptionGroup")
        loc_oPagina.opt_4c_Impressao.ButtonCount = 2
        WITH loc_oPagina.opt_4c_Impressao
            .Value       = 1
            .Top         = 271
            .Left        = 299
            .Width       = 246
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .TabIndex    = 3
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.opt_4c_Impressao.Buttons(1)
            .Caption   = "Plano de Contas"
            .Top       = 5
            .Left      = 5
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        WITH loc_oPagina.opt_4c_Impressao.Buttons(2)
            .Caption   = "Mapa de Contas"
            .Top       = 5
            .Left      = 126
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Executa Buscar() e configura RecordSource/Colunas/Headers
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lSucesso = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
                    loc_oGrid.RecordSource = THIS.this_cCursorDados
                    loc_oGrid.ColumnCount  = 3

                    *-- ControlSources APOS RecordSource (Problema 48: auto-bind reseta)
                    loc_oGrid.Column1.ControlSource = THIS.this_cCursorDados + ".Balancos"
                    loc_oGrid.Column2.ControlSource = THIS.this_cCursorDados + ".Titulos"
                    loc_oGrid.Column3.ControlSource = ;
                        "IIF(cursor_4c_Dados.Mapas=2,'MAPA','PLANO')"

                    *-- Headers APOS RecordSource (Problema 6/32: VFP reseta headers)
                    loc_oGrid.Column1.Header1.Caption = "Demonstrativo"
                    loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
                    loc_oGrid.Column3.Header1.Caption = "Impress" + CHR(227) + "o"

                    *-- Larguras conforme legado
                    loc_oGrid.Column1.Width = 150
                    loc_oGrid.Column2.Width = 290
                    loc_oGrid.Column3.Width = 75

                    *-- DynamicForeColor: Mapa de Contas em azul, Plano em preto (legado)
                    loc_oGrid.SetAll("DynamicForeColor", ;
                        "IIF(cursor_4c_Dados.Mapas=2,RGB(0,0,255),RGB(0,0,0))", ;
                        "Column")

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            loc_lSucesso = .F.
        ELSE
            TRY
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgErro("Erro ao alternar pagina:" + CHR(13) + loc_oErro.Message, "Erro")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO para INSERT e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
            THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
           RECCOUNT(THIS.this_cCursorDados) = 0
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        LOCAL loc_cBalanco
        SELECT cursor_4c_Dados
        loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar") = "O"
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro para edicao e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
           RECCOUNT(THIS.this_cCursorDados) = 0
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        LOCAL loc_cBalanco
        SELECT cursor_4c_Dados
        loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Titulo") = "O"
                THIS.pgf_4c_Paginas.Page2.txt_4c_Titulo.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Carrega registro para confirmacao de exclusao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
           RECCOUNT(THIS.this_cCursorDados) = 0
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        LOCAL loc_cBalanco
        SELECT cursor_4c_Dados
        loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
            THIS.this_cModoAtual = "EXCLUIR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre picker e posiciona grade no registro selecionado
    * Pattern A canonico: SQL no caller + DefinirCursor + Mostrar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_nSQL, loc_cBalanco, loc_oBusca
        loc_cBalanco = ""

        TRY
            loc_nSQL = SQLEXEC(gnConnHandle, ;
                "SELECT Balancos, Titulos FROM SigCdMrr ORDER BY Balancos", ;
                "cursor_4c_BuscaMrc")

            IF loc_nSQL >= 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaMrc", "Balancos", "Titulos", ;
                        "Buscar Demonstrativo")
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMrc"
                    IF loc_oBusca.Mostrar()
                        loc_cBalanco = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao buscar demonstrativos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaMrc")
            USE IN cursor_4c_BuscaMrc
        ENDIF

        IF !EMPTY(loc_cBalanco) AND USED(THIS.this_cCursorDados)
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(Balancos) == loc_cBalanco
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnItensClick - Abre formulario de Itens do Demonstrativo (SigCdCmr)
    * Legado: do form SigCdCmr with Thisform,thisform.datasessionid
    *--------------------------------------------------------------------------
    PROCEDURE BtnItensClick()
        IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
           RECCOUNT(THIS.this_cCursorDados) = 0
            MsgAviso("Selecione um demonstrativo para visualizar seus itens.", "Itens")
            RETURN
        ENDIF

        LOCAL loc_cBalanco, loc_oItens
        SELECT cursor_4c_Dados
        loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)

        TRY
            loc_oItens = CREATEOBJECT("FormCmr", loc_cBalanco)
            IF VARTYPE(loc_oItens) = "O"
                loc_oItens.Show()
            ELSE
                MsgErro("Erro ao criar formul" + CHR(225) + "rio de Itens." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oItens), "Erro")
            ENDIF
        CATCH TO loc_oErro
            LOCAL loc_cMsg
            loc_cMsg = "Erro ao abrir Itens do Demonstrativo:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loc_oErro.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                       "Procedure: " + loc_oErro.Procedure
            MsgErro(loc_cMsg, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirmar na Page2: salva em INCLUIR/ALTERAR, exclui em EXCLUIR
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        *-- VISUALIZAR: apenas voltar para lista
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        *-- EXCLUIR: confirmar e executar exclusao cascade (SigCdMri + SigCdMrr)
        IF THIS.this_cModoAtual = "EXCLUIR"
            IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do demonstrativo?" + CHR(13) + ;
                "Todos os itens associados tamb" + CHR(233) + "m ser" + CHR(227) + "o exclu" + ;
                CHR(237) + "dos.", "Excluir")
                RETURN
            ENDIF
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
            RETURN
        ENDIF

        *-- INCLUIR / ALTERAR: validar campo obrigatorio Balancos
        IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
            IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.Value))
                MsgAviso("Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF !THIS.this_oBusinessObject.ValidarDados()
            IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
                THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
            ENDIF
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso.")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do Form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
            THIS.this_oBusinessObject.this_cBalanco = ALLTRIM(loc_oPagina.txt_4c_Balanco.Value)
            THIS.this_oBusinessObject.this_cTitulo  = ALLTRIM(loc_oPagina.txt_4c_Titulo.Value)
            THIS.this_oBusinessObject.this_nMapa    = loc_oPagina.opt_4c_Impressao.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os campos do Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
            loc_oPagina.txt_4c_Balanco.Value   = THIS.this_oBusinessObject.this_cBalanco
            loc_oPagina.txt_4c_Titulo.Value    = THIS.this_oBusinessObject.this_cTitulo
            loc_oPagina.opt_4c_Impressao.Value = THIS.this_oBusinessObject.this_nMapa
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
            loc_oPagina.txt_4c_Balanco.Value   = ""
            loc_oPagina.txt_4c_Titulo.Value    = ""
            loc_oPagina.opt_4c_Impressao.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
            *-- Balanco editavel apenas em INCLUIR (chave primaria nao pode ser alterada)
            loc_oPagina.txt_4c_Balanco.Enabled   = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Titulo.Enabled    = par_lHabilitar
            loc_oPagina.opt_4c_Impressao.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita Confirmar apenas em modos que permitem acao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "EXCLUIR")
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual da grade (Tahoma 8 conforme legado)
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
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\MrcBO.prg):
*==============================================================================
* MrcBO.prg - Business Object para Cadastro de Demonstrativos
* Tabela principal: SigCdMrr (Demonstrativos)
* Tabela relacionada: SigCdMri (Itens do Demonstrativo)
*==============================================================================
DEFINE CLASS MrcBO AS BusinessBase

    *-- Propriedades da entidade SigCdMrr
    this_cBalanco   = ""   && balancos char(20) - chave primaria
    this_cTitulo    = ""   && titulos  char(40)
    this_nMapa      = 1    && mapas    numeric(1,0): 1=Plano de Contas, 2=Mapa de Contas

    *-- Nome do cursor principal
    this_cCursorDados = "cursor_4c_Dados"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMrr"
        THIS.this_cCampoChave = "Balancos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cBalanco
    ENDFUNC

    *--------------------------------------------------------------------------
    * NovoRegistro - Prepara BO para INSERT
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cBalanco = ""
        THIS.this_cTitulo  = ""
        THIS.this_nMapa    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara BO para UPDATE
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBalanco = TratarNulo(Balancos, "C")
            THIS.this_cTitulo  = TratarNulo(Titulos,  "C")
            THIS.this_nMapa    = TratarNulo(Mapas,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cBalanco))
            THIS.this_cMensagemErro = "Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio."
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros de SigCdMrr para a grade
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Balancos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       loc_cWhere + ;
                       " ORDER BY Balancos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar demonstrativos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar demonstrativos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um demonstrativo pelo codigo (Balancos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Balancos ja existe em SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupChk") > 0
                SELECT cursor_4c_DupChk
                loc_lExiste = (cursor_4c_DupChk.Total > 0)
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo demonstrativo em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                THIS.this_cMensagemErro = "Demonstrativo j" + CHR(225) + " cadastrado."
                MsgAviso(THIS.this_cMensagemErro, "Registro Duplicado")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdMrr (Balancos, Titulos, Mapas)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cBalanco) + ;
                           ", " + EscaparSQL(THIS.this_cTitulo) + ;
                           ", " + FormatarNumeroSQL(THIS.this_nMapa) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao inserir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza demonstrativo existente em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMrr" + ;
                       " SET Titulos = " + EscaparSQL(THIS.this_cTitulo) + ;
                       ", Mapas = " + FormatarNumeroSQL(THIS.this_nMapa) + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar demonstrativo: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui demonstrativo e seus itens (PROTECTED)
    * Cascade: DELETE SigCdMri primeiro, depois SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- 1. Excluir itens do demonstrativo (SigCdMri) - cascade
            loc_cSQL = "DELETE FROM SigCdMri WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMri")

            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao excluir itens: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                *-- 2. Excluir o demonstrativo principal (SigCdMrr)
                loc_cSQL = "DELETE FROM SigCdMrr WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMrr")

                IF USED("cursor_4c_DelMrr")
                    USE IN cursor_4c_DelMrr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao excluir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao excluir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF
            IF USED("cursor_4c_DelMrr")
                USE IN cursor_4c_DelMrr
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

