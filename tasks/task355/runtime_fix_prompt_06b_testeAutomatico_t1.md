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
[2026-07-22 04:54:58] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-22 04:54:58] [INFO] Config FPW: (nao fornecido)
[2026-07-22 04:54:58] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-22 04:54:58] [INFO] Timeout: 300 segundos
[2026-07-22 04:54:58] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q0uxbfhp.prg
[2026-07-22 04:54:58] [INFO] Conteudo do wrapper:
[2026-07-22 04:54:58] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCat', 'C:\4c\tasks\task355', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCat', 'C:\4c\tasks\task355', 'CRUD'
QUIT

[2026-07-22 04:54:58] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q0uxbfhp.prg
[2026-07-22 04:54:58] [INFO] VFP output esperado em: C:\4c\tasks\task355\vfp_output.txt
[2026-07-22 04:54:58] [INFO] Executando Visual FoxPro 9...
[2026-07-22 04:54:58] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q0uxbfhp.prg
[2026-07-22 04:54:58] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q0uxbfhp.prg
[2026-07-22 04:54:58] [INFO] Timeout configurado: 300 segundos
[2026-07-22 04:55:34] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-22 04:55:34] [INFO] VFP9 finalizado em 36.5251192 segundos
[2026-07-22 04:55:34] [INFO] Exit Code: 
[2026-07-22 04:55:34] [INFO] 
[2026-07-22 04:55:34] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-22 04:55:34] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q0uxbfhp.prg
[2026-07-22 04:55:34] [INFO] 
[2026-07-22 04:55:34] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-22 04:55:34] [INFO] * Auto-generated wrapper for parameters
[2026-07-22 04:55:34] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-22 04:55:34] [INFO] * Parameters: 'FormCat', 'C:\4c\tasks\task355', 'CRUD'
[2026-07-22 04:55:34] [INFO] 
[2026-07-22 04:55:34] [INFO] * Anti-dialog protections for unattended execution
[2026-07-22 04:55:34] [INFO] SET SAFETY OFF
[2026-07-22 04:55:34] [INFO] SET RESOURCE OFF
[2026-07-22 04:55:34] [INFO] SET TALK OFF
[2026-07-22 04:55:34] [INFO] SET NOTIFY OFF
[2026-07-22 04:55:34] [INFO] SYS(2335, 0)
[2026-07-22 04:55:34] [INFO] 
[2026-07-22 04:55:34] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCat', 'C:\4c\tasks\task355', 'CRUD'
[2026-07-22 04:55:34] [INFO] QUIT
[2026-07-22 04:55:34] [INFO] 
[2026-07-22 04:55:34] [INFO] === Fim do Wrapper.prg ===
[2026-07-22 04:55:34] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCat",
  "timestamp": "20260722045534",
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPGDEGRP) | KeyPress handlers: 2 (GDEGRPLOOKUPKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCat.prg):
*====================================================================
* FormCat.prg
*
* Formulario de Cadastro de Categorias de Produto
* Tabela principal: SIGCDCAT
* Herda de: FormBase
*====================================================================

DEFINE CLASS FormCat AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Categorias de Produto"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades da instancia
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *====================================================================
    * Init - Inicializa o formulario
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormCat:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lBOOk
        loc_lSucesso = .F.
        loc_lBOOk    = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CatBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lBOOk = .T.
            ELSE
                MsgErro("Erro ao criar CatBO", "Erro")
            ENDIF

            IF loc_lBOOk
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formulario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(225, 225, 225)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(225, 225, 225)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *====================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho cinza (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")

        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = "Categorias de Produto"
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = "Categorias de Produto"
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (Grupo_op no legado) - LADO DIREITO
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Botoes

        WITH loc_oCnt
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
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

        *-- Botao Visualizar
        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
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

        *-- Botao Alterar
        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
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

        *-- Botao Excluir
        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
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

        *-- Botao Buscar
        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
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

        *-- Container saida - PADRAO CANONICO (prevalece sobre PILAR 1)
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

        *-- Grid de listagem (Grade no legado)
        *-- Colunas: Cods(52), descs(115), gdegrps(50), prazos(50)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista

        loc_oGrid.Top               = 117
        loc_oGrid.Left              = 26
        loc_oGrid.Width             = 890
        loc_oGrid.Height            = 470
        loc_oGrid.FontName          = "Verdana"
        loc_oGrid.FontSize          = 8
        loc_oGrid.ForeColor         = RGB(90, 90, 90)
        loc_oGrid.BackColor         = RGB(255, 255, 255)
        loc_oGrid.GridLineColor     = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle    = 2
        loc_oGrid.DeleteMark        = .F.
        loc_oGrid.RecordMark        = .F.
        loc_oGrid.RowHeight         = 16
        loc_oGrid.ScrollBars        = 2
        loc_oGrid.GridLines         = 3
        loc_oGrid.ColumnCount       = 4
        loc_oGrid.Visible           = .T.

        *-- BINDEVENTs para botoes CRUD e duplo clique no grid
        BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *====================================================================
    * ConfigurarPaginaDados - Page2: campos e botoes acao
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes salvar/cancelar (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao

        WITH loc_oCnt
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar)
        loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Confirmar
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

        *-- Botao Cancelar
        loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cancelar
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

        *-- BINDEVENTs para botoes de acao
        BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- ============================================================
        *-- Container cabecalho Page2 (cinza, mesmo estilo da Page1)
        *-- ============================================================
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")

        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
            .AddObject("lbl_4c_Sombra", "Label")
            .AddObject("lbl_4c_Titulo", "Label")
        ENDWITH

        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Categorias de Produto"
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

        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Categorias de Produto"
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

        *-- ============================================================
        *-- Campos - Primeiros 50% (Fase 5/8)
        *-- Posicoes originais compensadas +29 (PageFrame.Top=-29)
        *-- ============================================================

        *-- Label "Codigo :" (Say1: top=200+29=229, left=256, width~45)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 229
            .Left      = 256
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_Cods: top=197+29=226, left=301, width=52) - cods char(6)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .MaxLength = 6
            .Top       = 226
            .Left      = 301
            .Width     = 52
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Descricao :" (Say2: top=224+29=253, left=243, width~58)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 253
            .Left      = 243
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao curta (Get_Descs: top=221+29=250, left=301, width=115) - descs char(15)
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value     = ""
            .MaxLength = 15
            .Top       = 250
            .Left      = 301
            .Width     = 115
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Descricao Completa :" (Say5: top=248+29=277, left=195, width~106)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Completa :"
            .Top       = 277
            .Left      = 195
            .Width     = 106
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao completa (Get_Desc2s: top=245+29=274, left=301, width=290) - desc2s char(40)
        loc_oPagina.AddObject("txt_4c_Desc2s", "TextBox")
        WITH loc_oPagina.txt_4c_Desc2s
            .Value     = ""
            .MaxLength = 40
            .Top       = 274
            .Left      = 301
            .Width     = 290
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Gde.Grp.:" (Say13: top=273+29=302, left=248, width=50)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Gde.Grp.:"
            .Top       = 302
            .Left      = 248
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grande Grupo (getGdeGrp: top=270+29=299, left=301, width=34, height=23) - gdegrps char(3)
        loc_oPagina.AddObject("txt_4c_GdeGrp", "TextBox")
        WITH loc_oPagina.txt_4c_GdeGrp
            .Value     = ""
            .MaxLength = 3
            .Top       = 299
            .Left      = 301
            .Width     = 34
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Prazo de Entrega :" (Say3: top=297+29=326, left=206, width=92)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Prazo de Entrega :"
            .Top       = 326
            .Left      = 206
            .Width     = 92
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Prazo de Entrega (getPrazo: top=294+29=323, left=301, width=24) - prazos numeric(2,0)
        loc_oPagina.AddObject("txt_4c_Prazo", "TextBox")
        WITH loc_oPagina.txt_4c_Prazo
            .Value     = 0
            .Top       = 323
            .Left      = 301
            .Width     = 24
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .InputMask = "99"
            .Visible   = .T.
        ENDWITH

        *-- Label "Dias" (Say4: top=298+29=327, left=329, width=22)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Dias"
            .Top       = 327
            .Left      = 329
            .Width     = 22
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs para lookup de Grande Grupo (SigCdGpr) - F4 e DblClick
        BINDEVENT(loc_oPagina.txt_4c_GdeGrp, "KeyPress", THIS, "GdeGrpLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_GdeGrp, "DblClick", THIS, "GdeGrpLookupDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *====================================================================
    * CarregarLista - Carrega dados e configura grid da Page1
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 4

                    WITH loc_oGrid
                        .Column1.ControlSource = "cursor_4c_Dados.cods"
                        .Column2.ControlSource = "cursor_4c_Dados.descs"
                        .Column3.ControlSource = "cursor_4c_Dados.gdegrps"
                        .Column4.ControlSource = "cursor_4c_Dados.prazos"

                        .Column1.Width = 70
                        .Column2.Width = 200
                        .Column3.Width = 80
                        .Column4.Width = 60

                        .Column1.Header1.Caption = "C" + CHR(243) + "digos"
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        .Column3.Header1.Caption = "Gde. Grp"
                        .Column4.Header1.Caption = "Prazo"

                        .Column1.ReadOnly = .T.
                        .Column2.ReadOnly = .T.
                        .Column3.ReadOnly = .T.
                        .Column4.ReadOnly = .T.
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *====================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BtnIncluirClick - Abrir Page2 para incluir novo registro
    *====================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
        ENDIF
    ENDPROC

    *====================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *====================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidchaves
        loc_cCidchaves = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ELSE
            MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Visualizar")
        ENDIF
    ENDPROC

    *====================================================================
    * BtnAlterarClick - Abrir Page2 para alterar registro selecionado
    *====================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidchaves
        loc_cCidchaves = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Descricao", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
            ENDIF
        ELSE
            MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Alterar")
        ENDIF
    ENDPROC

    *====================================================================
    * BtnExcluirClick - Excluir registro selecionado com confirmacao
    *====================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidchaves, loc_lConfirma
        loc_cCidchaves = ""
        loc_lConfirma  = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", "Excluir")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir registro.", "Excluir")
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Excluir")
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * BtnBuscarClick - Abrir busca para filtrar lista
    *====================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oBusca, loc_oGrid
        loc_cFiltro = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDCAT", "cursor_4c_BuscaCat", "cods", "", ;
                "Buscar Categoria de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
                    SELECT cursor_4c_BuscaCat
                    loc_cFiltro = ALLTRIM(cursor_4c_BuscaCat.cods)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCat")
                USE IN cursor_4c_BuscaCat
            ENDIF

            IF !EMPTY(loc_cFiltro)
                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 4

                    WITH loc_oGrid
                        .Column1.ControlSource = "cursor_4c_Dados.cods"
                        .Column2.ControlSource = "cursor_4c_Dados.descs"
                        .Column3.ControlSource = "cursor_4c_Dados.gdegrps"
                        .Column4.ControlSource = "cursor_4c_Dados.prazos"

                        .Column1.Header1.Caption = "C" + CHR(243) + "digos"
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        .Column3.Header1.Caption = "Gde. Grp"
                        .Column4.Header1.Caption = "Prazo"
                    ENDWITH

                    loc_oGrid.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaCat")
                USE IN cursor_4c_BuscaCat
            ENDIF
        ENDTRY
    ENDPROC

    *====================================================================
    * BtnEncerrarClick - Fechar o formulario
    *====================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnSalvarClick - Salvar registro (Inserir ou Atualizar)
    *====================================================================
    PROCEDURE BtnSalvarClick()
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            MsgErro("Erro ao salvar registro.", "Confirmar")
        ENDIF
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *====================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *====================================================================
    * FormParaBO - Transfere valores do Form para o BO
    *====================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lValido, loc_oPg2
        loc_lValido = .T.

        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
            RETURN .T.
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                THIS.this_oBusinessObject.this_cCods    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Desc2s", 5)
                THIS.this_oBusinessObject.this_cDesc2s  = ALLTRIM(loc_oPg2.txt_4c_Desc2s.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GdeGrp", 5)
                THIS.this_oBusinessObject.this_cGdegrps = ALLTRIM(loc_oPg2.txt_4c_GdeGrp.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Prazo", 5)
                THIS.this_oBusinessObject.this_nPrazos  = IIF(VARTYPE(loc_oPg2.txt_4c_Prazo.Value) = "N", ;
                    loc_oPg2.txt_4c_Prazo.Value, 0)
            ENDIF

            IF EMPTY(THIS.this_oBusinessObject.this_cCods)
                MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Validar")
                loc_lValido = .F.
            ENDIF

            IF loc_lValido AND EMPTY(THIS.this_oBusinessObject.this_cDescs)
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.", "Validar")
                loc_lValido = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao transferir dados:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * BOParaForm - Transfere valores do BO para o Form
    *====================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Desc2s", 5)
                loc_oPg2.txt_4c_Desc2s.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cDesc2s)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GdeGrp", 5)
                loc_oPg2.txt_4c_GdeGrp.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGdegrps)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Prazo", 5)
                loc_oPg2.txt_4c_Prazo.Value     = THIS.this_oBusinessObject.this_nPrazos
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar dados no form:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *====================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *====================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value    = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Desc2s", 5)
                loc_oPg2.txt_4c_Desc2s.Value    = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GdeGrp", 5)
                loc_oPg2.txt_4c_GdeGrp.Value    = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Prazo", 5)
                loc_oPg2.txt_4c_Prazo.Value     = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao limpar campos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *====================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *====================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Enabled    = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
                loc_oPg2.txt_4c_Descricao.Enabled  = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Desc2s", 5)
                loc_oPg2.txt_4c_Desc2s.Enabled     = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GdeGrp", 5)
                loc_oPg2.txt_4c_GdeGrp.Enabled     = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Prazo", 5)
                loc_oPg2.txt_4c_Prazo.Enabled      = par_lHabilitar
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao habilitar campos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *====================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *====================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCntAcao
        loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
                loc_oCntAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
            ENDIF
            IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Cancelar", 5)
                loc_oCntAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *====================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto

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

    *====================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *====================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
            .SetAll("ForeColor", RGB(90, 90, 90), "Column")
        ENDWITH
    ENDPROC

    *====================================================================
    * GdeGrpLookupKeyPress - Handler de KeyPress para lookup Grande Grupo
    *====================================================================
    PROCEDURE GdeGrpLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupGdeGrp()
        ENDIF
    ENDPROC

    *====================================================================
    * GdeGrpLookupDblClick - Handler de DblClick para lookup Grande Grupo
    *====================================================================
    PROCEDURE GdeGrpLookupDblClick()
        THIS.AbrirLookupGdeGrp()
    ENDPROC

    *====================================================================
    * AbrirLookupGdeGrp - Abre busca de Grande Grupo (SigCdGpr)
    *====================================================================
    PROCEDURE AbrirLookupGdeGrp()
        LOCAL loc_oPg2, loc_oBusca, loc_cCodigo
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ""

        IF !PEMSTATUS(loc_oPg2, "txt_4c_GdeGrp", 5)
            RETURN
        ENDIF

        IF !loc_oPg2.txt_4c_GdeGrp.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", ;
                "cursor_4c_BuscaGdeGrp", ;
                "codigos", ;
                ALLTRIM(loc_oPg2.txt_4c_GdeGrp.Value), ;
                "Grandes Grupos de Produtos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGdeGrp")
                    SELECT cursor_4c_BuscaGdeGrp
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaGdeGrp.codigos)
                    loc_oPg2.txt_4c_GdeGrp.Value = loc_cCodigo
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGdeGrp")
                USE IN cursor_4c_BuscaGdeGrp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar Grande Grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaGdeGrp")
                USE IN cursor_4c_BuscaGdeGrp
            ENDIF
        ENDTRY
    ENDPROC

    *====================================================================
    * Destroy - Libera recursos
    *====================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CatBO.prg):
*====================================================================
* CatBO.prg
*
* Business Object para Categorias de Produto
* Tabela principal: SIGCDCAT (cidchaves PK, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CatBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDCAT)
	this_cCidchaves = ""   && cidchaves char(20)    - PK tecnica (UUID fUniqueIds)
	this_cCods      = ""   && cods char(6)          - codigo de categoria
	this_cDescs     = ""   && descs char(15)        - descricao curta
	this_cDesc2s    = ""   && desc2s char(40)       - descricao completa
	this_cGdegrps   = ""   && gdegrps char(3)       - grande grupo (FK SigCdGpr.Codigos)
	this_nPrazos    = 0    && prazos numeric(2,0)   - prazo de entrega (dias)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCAT"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de categorias no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cidchaves, cods, descs, gdegrps, prazos" + ;
				           " FROM SIGCDCAT" + ;
				           " ORDER BY cods"
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descs, gdegrps, prazos" + ;
				           " FROM SIGCDCAT" + ;
				           " WHERE RTRIM(cods) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY cods"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs, desc2s, gdegrps, prazos" + ;
			           " FROM SIGCDCAT" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar categoria:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cCods      = TratarNulo(cods, "C")
			THIS.this_cDescs     = TratarNulo(descs, "C")
			THIS.this_cDesc2s    = TratarNulo(desc2s, "C")
			THIS.this_cGdegrps   = TratarNulo(gdegrps, "C")
			THIS.this_nPrazos    = TratarNulo(prazos, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SIGCDCAT (cidchaves, cods, descs, desc2s, gdegrps, prazos)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 6)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 15)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDesc2s), 40)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cGdegrps), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrazos) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCAT SET" + ;
			           " cods = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 6)) + "," + ;
			           " descs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 15)) + "," + ;
			           " desc2s = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDesc2s), 40)) + "," + ;
			           " gdegrps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGdegrps), 3)) + "," + ;
			           " prazos = " + FormatarNumeroSQL(THIS.this_nPrazos) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDCAT WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

