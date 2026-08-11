# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-06 23:50:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 23:50:10] [INFO] Config FPW: (nao fornecido)
[2026-08-06 23:50:10] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 23:50:10] [INFO] Timeout: 300 segundos
[2026-08-06 23:50:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3uhwse50.prg
[2026-08-06 23:50:10] [INFO] Conteudo do wrapper:
[2026-08-06 23:50:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formgem', 'C:\4c\tasks\task437', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formgem', 'C:\4c\tasks\task437', 'CRUD'
QUIT

[2026-08-06 23:50:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3uhwse50.prg
[2026-08-06 23:50:10] [INFO] VFP output esperado em: C:\4c\tasks\task437\vfp_output.txt
[2026-08-06 23:50:10] [INFO] Executando Visual FoxPro 9...
[2026-08-06 23:50:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3uhwse50.prg
[2026-08-06 23:50:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3uhwse50.prg
[2026-08-06 23:50:10] [INFO] Timeout configurado: 300 segundos
[2026-08-06 23:51:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 23:51:11] [INFO] VFP9 finalizado em 61.0338247 segundos
[2026-08-06 23:51:11] [INFO] Exit Code: 
[2026-08-06 23:51:11] [INFO] 
[2026-08-06 23:51:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 23:51:11] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3uhwse50.prg
[2026-08-06 23:51:11] [INFO] 
[2026-08-06 23:51:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 23:51:11] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 23:51:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 23:51:11] [INFO] * Parameters: 'Formgem', 'C:\4c\tasks\task437', 'CRUD'
[2026-08-06 23:51:11] [INFO] 
[2026-08-06 23:51:11] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 23:51:11] [INFO] SET SAFETY OFF
[2026-08-06 23:51:11] [INFO] SET RESOURCE OFF
[2026-08-06 23:51:11] [INFO] SET TALK OFF
[2026-08-06 23:51:11] [INFO] SET NOTIFY OFF
[2026-08-06 23:51:11] [INFO] SYS(2335, 0)
[2026-08-06 23:51:11] [INFO] 
[2026-08-06 23:51:11] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formgem', 'C:\4c\tasks\task437', 'CRUD'
[2026-08-06 23:51:11] [INFO] QUIT
[2026-08-06 23:51:11] [INFO] 
[2026-08-06 23:51:11] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 23:51:11] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-06 23:54:26] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 23:54:26] [INFO] Config FPW: (nao fornecido)
[2026-08-06 23:54:26] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 23:54:26] [INFO] Timeout: 300 segundos
[2026-08-06 23:54:26] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dgkunauq.prg
[2026-08-06 23:54:26] [INFO] Conteudo do wrapper:
[2026-08-06 23:54:26] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formgem', 'C:\4c\tasks\task437', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formgem', 'C:\4c\tasks\task437', 'CRUD'
QUIT

[2026-08-06 23:54:26] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dgkunauq.prg
[2026-08-06 23:54:26] [INFO] VFP output esperado em: C:\4c\tasks\task437\vfp_output.txt
[2026-08-06 23:54:26] [INFO] Executando Visual FoxPro 9...
[2026-08-06 23:54:26] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dgkunauq.prg
[2026-08-06 23:54:26] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dgkunauq.prg
[2026-08-06 23:54:26] [INFO] Timeout configurado: 300 segundos
[2026-08-06 23:55:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 23:55:33] [INFO] VFP9 finalizado em 67.7774696 segundos
[2026-08-06 23:55:33] [INFO] Exit Code: 
[2026-08-06 23:55:33] [INFO] 
[2026-08-06 23:55:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 23:55:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dgkunauq.prg
[2026-08-06 23:55:33] [INFO] 
[2026-08-06 23:55:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 23:55:33] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 23:55:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 23:55:33] [INFO] * Parameters: 'Formgem', 'C:\4c\tasks\task437', 'CRUD'
[2026-08-06 23:55:33] [INFO] 
[2026-08-06 23:55:33] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 23:55:33] [INFO] SET SAFETY OFF
[2026-08-06 23:55:33] [INFO] SET RESOURCE OFF
[2026-08-06 23:55:33] [INFO] SET TALK OFF
[2026-08-06 23:55:33] [INFO] SET NOTIFY OFF
[2026-08-06 23:55:33] [INFO] SYS(2335, 0)
[2026-08-06 23:55:33] [INFO] 
[2026-08-06 23:55:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formgem', 'C:\4c\tasks\task437', 'CRUD'
[2026-08-06 23:55:33] [INFO] QUIT
[2026-08-06 23:55:33] [INFO] 
[2026-08-06 23:55:33] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 23:55:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formgem",
  "timestamp": "20260806235533",
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formgem.prg):
*==============================================================================
* Formgem.prg - Formulario de Cadastro de Grupo Empresarial
* Baseado em: SIGCDGEM.SCX (frmcadastro)
* Tabela: SigCdGre
*==============================================================================

DEFINE CLASS Formgem AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Grupo Empresarial"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cCidChavesAtual = ""

    *==========================================================================
    * Init - Inicializa o formulario
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("gemBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

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
                MsgErro("Erro ao criar gemBO", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        THIS.pgf_4c_Paginas.PageCount = 2

        WITH THIS.pgf_4c_Paginas
            .Top     = -29
            .Left    = 0
            .Width   = THIS.Width
            .Height  = THIS.Height + 29
            .Tabs    = .F.
            .Visible = .T.
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra do legado: Top=2+29=31)
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
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
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
            .Width     = THIS.Width - 20
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

        *-- Container de botoes CRUD (Grupo_op: Left=544, Top=-1+29=28, Width=385, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir.Left=5, Top=5)
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

        *-- Botao Visualizar (Consultar.Left=80, Top=5)
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

        *-- Botao Alterar (Alterar.Left=155, Top=5)
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

        *-- Botao Excluir (Excluir.Left=230, Top=5)
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

        *-- Botao Buscar (Procurar.Left=305, Top=5)
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

        *-- Container de saida - padrao canonico (Left=917, Top=-1+29=28)
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

        *-- Grid (Grade: Top=97+29=126, Left=30, Width=938, Height=488)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 126
        loc_oGrid.Left        = 30
        loc_oGrid.Width       = 938
        loc_oGrid.Height      = 488
        loc_oGrid.ColumnCount = 2
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

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados) com campos e botoes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de botoes de acao (Grupo_Salva: Left=841, Top=-3+29=26, Width=165)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 26
            .Left        = 841
            .Width       = 165
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar/Salvar (Salva: Left=5, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Cancelar: Left=80, Top=5)
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

        *-- Label Grupo (Say1: Top=176+29=205, Left=430)
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo :"
            .Top       = 205
            .Left      = 430
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupo (Get_Grupo: Top=173+29=202, Left=470, Width=115)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Top           = 202
            .Left          = 470
            .Width         = 115
            .Height        = 20
            .InputMask     = "!!!!!!!!!!!!!!!"
            .MaxLength     = 15
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label Classificacao (Say2: Top=203+29=232, Left=398)
        loc_oPagina.AddObject("lbl_4c_Class", "Label")
        WITH loc_oPagina.lbl_4c_Class
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Top       = 232
            .Left      = 398
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Classificacao (Get_Class: Top=199+29=228, Left=470, Width=115)
        loc_oPagina.AddObject("txt_4c_Class", "TextBox")
        WITH loc_oPagina.txt_4c_Class
            .Value         = ""
            .Top           = 228
            .Left          = 470
            .Width         = 115
            .Height        = 20
            .InputMask     = "!!!!!!!!!!!!!!!"
            .MaxLength     = 15
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label Tipo (Say3: Top=229+29=258, Left=439, Height=15)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Caption   = "Tipo :"
            .Top       = 258
            .Left      = 439
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Tipo (fwoption1: Top=225+29=254, Left=464, Width=136, Height=25)
        *-- Option1="Industrial" (Left=5), Option2="Diversos" (Left=85)
        loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Tipo
            .ButtonCount = 2
            .Top         = 254
            .Left        = 464
            .Width       = 136
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipo.Buttons(1)
            .Caption   = "Industrial"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipo.Buttons(2)
            .Caption   = "Diversos"
            .BackStyle = 0
            .Left      = 85
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                CREATE CURSOR cursor_4c_Dados (grupo C(15), class C(15), gruclass C(30), tipos N(1,0))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource         = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.grupo"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.class"
                loc_oGrid.Column1.Width         = 115
                loc_oGrid.Column2.Width         = 115
                loc_oGrid.Column1.Header1.Caption = "Grupo"
                loc_oGrid.Column2.Header1.Caption = "Classifica" + CHR(231) + CHR(227) + "o"
                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGruClass
        loc_cGruClass = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cGruClass = ALLTRIM(cursor_4c_Dados.gruclass)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGruClass)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Inicia alteracao do registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGruClass
        loc_cGruClass = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cGruClass = ALLTRIM(cursor_4c_Dados.gruclass)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGruClass)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGruClass, loc_cGrupo, loc_cClass
        loc_cGruClass = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cGruClass  = ALLTRIM(cursor_4c_Dados.gruclass)
        loc_cGrupo     = ALLTRIM(cursor_4c_Dados.grupo)
        loc_cClass     = ALLTRIM(cursor_4c_Dados.class)

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?" + CHR(13) + ;
                       "Grupo: " + loc_cGrupo + CHR(13) + ;
                       "Classifica" + CHR(231) + CHR(227) + "o: " + loc_cClass, ;
                       "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGruClass)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista (equivalente ao msv_procurar do legado)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva registro (INCLUIR ou ALTERAR)
    * Logica do legado: valida Grupo+Class em INSERIR, verifica duplicata,
    *   depois DoDefault() (Salvar) e mAtivaPagina1 (voltar para lista)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cGrupo, loc_cClass

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cClass  = ALLTRIM(loc_oPagina.txt_4c_Class.Value)

        *-- Validacoes obrigatorias no modo INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(loc_cGrupo)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Grupo.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_cClass)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar uma Classifica" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Class.SetFocus
                RETURN
            ENDIF

            *-- Verificar duplicata (grupo+class ja cadastrado)
            THIS.this_oBusinessObject.this_cGrupo = loc_cGrupo
            THIS.this_oBusinessObject.this_cClass = loc_cClass
            IF THIS.this_oBusinessObject.ValidarDuplicata()
                MsgAviso("Grupo + Classifica" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrado ...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Class.SetFocus
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do form para o BO antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cClass = ALLTRIM(loc_oPagina.txt_4c_Class.Value)
        THIS.this_oBusinessObject.this_nTipos = loc_oPagina.opt_4c_Tipo.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o form apos carregar
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Grupo.Value = THIS.this_oBusinessObject.this_cGrupo
        loc_oPagina.txt_4c_Class.Value = THIS.this_oBusinessObject.this_cClass
        loc_oPagina.opt_4c_Tipo.Value  = THIS.this_oBusinessObject.this_nTipos
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
    * Grupo e Class: so editaveis em INCLUIR (sao parte da PK composta)
    * Tipo: editavel em INCLUIR e ALTERAR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lIncluir
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lIncluir = (THIS.this_cModoAtual = "INCLUIR")

        loc_oPagina.txt_4c_Grupo.Enabled = par_lHabilitar AND loc_lIncluir
        loc_oPagina.txt_4c_Class.Enabled = par_lHabilitar AND loc_lIncluir
        loc_oPagina.opt_4c_Tipo.Enabled  = par_lHabilitar AND !INLIST(THIS.this_cModoAtual, "VISUALIZAR")
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos do formulario
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Grupo.Value = ""
        loc_oPagina.txt_4c_Class.Value = ""
        loc_oPagina.opt_4c_Tipo.Value  = 1
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
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
    * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme o modo
    * VISUALIZAR: Confirmar desabilitado (somente leitura)
    * INCLUIR/ALTERAR: Confirmar habilitado
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lPermiteSalvar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lPermiteSalvar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lPermiteSalvar
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\gemBO.prg):
*==============================================================================
* gemBO.prg - Business Object para Grupo Empresarial (SigCdGre)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS gemBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos da tabela SigCdGre
    *--------------------------------------------------------------------------
    this_cClass     = ""   && class     C(15) - Classificacao
    this_cGruClass  = ""   && gruclass  C(30) - grupo+class concatenado (PK)
    this_cGrupo     = ""   && grupo     C(15) - Grupo
    this_nTipos     = 1    && tipos     N(1,0) - 1=Industrial, 2=Diversos

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGre"
        THIS.this_cCampoChave = "gruclass"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT grupo, class, gruclass, tipos" + ;
                       " FROM SigCdGre"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY grupo, class"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar dados: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo gruclass (grupo+class)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT grupo, class, gruclass, tipos" + ;
                       " FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupo    = TratarNulo(grupo,    "C")
            THIS.this_cClass    = TratarNulo(class,    "C")
            THIS.this_cGruClass = TratarNulo(gruclass, "C")
            THIS.this_nTipos    = TratarNulo(tipos,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna gruclass para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cGruClass
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicata - Verifica se grupo+class ja existe (usar antes de INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicata, loc_cGruClass
        loc_lDuplicata = .F.

        TRY
            loc_cGruClass = ALLTRIM(THIS.this_cGrupo) + ALLTRIM(THIS.this_cClass)
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(loc_cGruClass)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
                SELECT cursor_4c_DupCheck
                loc_lDuplicata = (qtd > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar duplicata: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF

        RETURN loc_lDuplicata
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdGre (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGruClass
        loc_lSucesso = .F.

        TRY
            *-- gruclass = grupo+class concatenado (chave natural da tabela)
            loc_cGruClass = ALLTRIM(THIS.this_cGrupo) + ALLTRIM(THIS.this_cClass)
            THIS.this_cGruClass = loc_cGruClass

            loc_cSQL = "INSERT INTO SigCdGre (grupo, class, gruclass, tipos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cGrupo) + ", " + ;
                       EscaparSQL(THIS.this_cClass) + ", " + ;
                       EscaparSQL(loc_cGruClass) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdGre (PROTECTED)
    * Nota: grupo e class nao sao editaveis no ALTERAR (apenas tipos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGre SET" + ;
                       " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                       " WHERE gruclass = " + EscaparSQL(THIS.this_cGruClass)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdGre (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(THIS.this_cGruClass)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

