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
[2026-08-01 03:53:29] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 03:53:29] [INFO] Config FPW: (nao fornecido)
[2026-08-01 03:53:29] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 03:53:29] [INFO] Timeout: 300 segundos
[2026-08-01 03:53:29] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ifyfydde.prg
[2026-08-01 03:53:29] [INFO] Conteudo do wrapper:
[2026-08-01 03:53:29] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDpi', 'C:\4c\tasks\task396', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDpi', 'C:\4c\tasks\task396', 'CRUD'
QUIT

[2026-08-01 03:53:29] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ifyfydde.prg
[2026-08-01 03:53:29] [INFO] VFP output esperado em: C:\4c\tasks\task396\vfp_output.txt
[2026-08-01 03:53:29] [INFO] Executando Visual FoxPro 9...
[2026-08-01 03:53:29] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ifyfydde.prg
[2026-08-01 03:53:29] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ifyfydde.prg
[2026-08-01 03:53:29] [INFO] Timeout configurado: 300 segundos
[2026-08-01 03:54:16] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 03:54:16] [INFO] VFP9 finalizado em 46.7390206 segundos
[2026-08-01 03:54:16] [INFO] Exit Code: 
[2026-08-01 03:54:16] [INFO] 
[2026-08-01 03:54:16] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 03:54:16] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ifyfydde.prg
[2026-08-01 03:54:16] [INFO] 
[2026-08-01 03:54:16] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 03:54:16] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 03:54:16] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 03:54:16] [INFO] * Parameters: 'FormDpi', 'C:\4c\tasks\task396', 'CRUD'
[2026-08-01 03:54:16] [INFO] 
[2026-08-01 03:54:16] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 03:54:16] [INFO] SET SAFETY OFF
[2026-08-01 03:54:16] [INFO] SET RESOURCE OFF
[2026-08-01 03:54:16] [INFO] SET TALK OFF
[2026-08-01 03:54:16] [INFO] SET NOTIFY OFF
[2026-08-01 03:54:16] [INFO] SYS(2335, 0)
[2026-08-01 03:54:16] [INFO] 
[2026-08-01 03:54:16] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDpi', 'C:\4c\tasks\task396', 'CRUD'
[2026-08-01 03:54:16] [INFO] QUIT
[2026-08-01 03:54:16] [INFO] 
[2026-08-01 03:54:16] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 03:54:16] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormDpi",
  "timestamp": "20260801035416",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDpi.prg):
*==============================================================================
* FormDpi.prg - Formulario de Cadastro de Departamentos do Site
* Tabela: SigCdDpi (cods char(2), descs char(30), pkchaves char(20))
* Fase 3/8: Estrutura Base (PageFrame + Containers)
*==============================================================================
DEFINE CLASS FormDpi AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Departamentos do Site"
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

    *--------------------------------------------------------------------------
    * Init - Inicializacao (FormBase.Init chama InicializarForm automaticamente)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDpi.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DpiBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar DpiBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura do form
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDpi.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
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
            .Visible   = .T.

            .Page1.Caption    = "Lista"
            .Page1.BackColor  = RGB(100, 100, 100)
            .Page1.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.Caption    = "Dados"
            .Page2.BackColor  = RGB(100, 100, 100)
            .Page2.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1: cabecalho + container botoes + saida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container sombra/cabecalho cinza superior
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
            .Width     = THIS.Width - 10
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
            .Width     = THIS.Width - 10
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD lado direito
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - padrao canonico (Left=917, Width=90)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista de departamentos
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 478
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
            .Visible            = .T.
        ENDWITH

        loc_oPagina.grd_4c_Lista.ColumnCount = 2

        WITH loc_oPagina.grd_4c_Lista.Column1
            .Width     = 80
            .Alignment = 2
        ENDWITH

        WITH loc_oPagina.grd_4c_Lista.Column2
            .Width     = 300
            .Alignment = 1
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: botoes acao + campos (Fase 5/8)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (padrao canonico Left=842, Width=160)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label Codigo (Say1: top=141+29=170, left=354)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 170
            .Left      = 354
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getCods: top=137+29=166, left=400, width=40, height=24)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 166
            .Left          = 400
            .Width         = 40
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 2
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao (Say2: top=167+29=196, left=341)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 196
            .Left      = 341
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescs: top=163+29=192, left=400, width=264, height=24)
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 192
            .Left          = 400
            .Width         = 264
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 30
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados do BO (grid binding adicionado na Fase 4)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.ColumnCount           = 2
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"

                *-- Reconfigurar headers apos RecordSource (VFP reseta captions)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar departamentos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDpi.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
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
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDpi.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
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
    * FormParaBO - Transfere valores do Form para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        THIS.this_oBusinessObject.this_cCods  = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescs = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
        loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.txt_4c_Codigo.Value    = ""
        loc_oPagina.txt_4c_Descricao.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos conforme modo atual
    * Codigo: habilitado apenas no modo INCLUIR (getCods.When = INSERIR/PROCURAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.txt_4c_Codigo.Enabled    = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lModoLista, loc_lModoEdicao
        loc_oPg1      = THIS.pgf_4c_Paginas.Page1
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lModoLista = (THIS.this_cModoAtual = "LISTA")
        loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Botoes da Page1: habilitados apenas no modo LISTA
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lModoLista
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lModoLista
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lModoLista
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lModoLista
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lModoLista

        *-- Botoes da Page2: Confirmar habilitado apenas em edicao, Cancelar sempre
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lModoEdicao
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro: limpa campos, vai para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao, loc_lConfirma
        loc_cCodigo    = ""
        loc_cDescricao = ""
        loc_lConfirma  = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cods)
        loc_cDescricao = ALLTRIM(cursor_4c_Dados.descs)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Excluir o departamento:" + CHR(13) + ;
            CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo + ;
            CHR(13) + "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDescricao + ;
            CHR(13) + CHR(13) + "Confirma a exclus" + CHR(227) + "o?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Departamento exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre FormBuscaAuxiliar para pesquisa/selecao de registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdDpi", "cursor_4c_BuscaDpi", "cods", "", ;
                "Buscar Departamento do Site")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpi")
                    SELECT cursor_4c_BuscaDpi
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaDpi.cods)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaDpi")
                USE IN cursor_4c_BuscaDpi
            ENDIF

            IF !EMPTY(loc_cCodigo)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDpi.BtnBuscarClick")
            IF USED("cursor_4c_BuscaDpi")
                USE IN cursor_4c_BuscaDpi
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro (Inserir ou Atualizar via BO)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodigo, loc_cDescricao
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Descricao.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Departamento salvo com sucesso!", "")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.HabilitarCampos(.F.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\DpiBO.prg):
*==============================================================================
* DpiBO.prg - Business Object para Departamentos do Site
* Tabela: SigCdDpi (cods char(2), descs char(30), pkchaves char(20))
*==============================================================================
DEFINE CLASS DpiBO AS BusinessBase

    *-- Propriedades da entidade
    this_cCods      = ""   && cods     char(2)  - codigo do departamento
    this_cDescs     = ""   && descs    char(30) - descricao
    this_cPkChaves  = ""   && pkchaves char(20) - chave primaria (PK)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDpi"
            THIS.this_cCampoChave = "pkchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCods     = TratarNulo(cods,     "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros (ou filtrados por texto livre)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT cods, descs, pkchaves FROM SigCdDpi"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                           " WHERE cods LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pela chave de negocio (cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, pkchaves FROM SigCdDpi" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cSQLDup, loc_nDup
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verificar duplicidade de codigo
            loc_cSQLDup = "SELECT cods FROM SigCdDpi WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods))
            loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_Dup")
            IF loc_nDup >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF

                *-- Gerar PK
                THIS.this_cPkChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigCdDpi (cods, descs, pkchaves)" + ;
                           " VALUES (" + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ;
                           ", " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                           ", " + EscaparSQL(THIS.this_cPkChaves) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdDpi" + ;
                       " SET descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdDpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDpi WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

