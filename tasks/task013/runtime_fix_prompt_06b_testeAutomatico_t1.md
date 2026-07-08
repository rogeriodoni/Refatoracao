# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[12/04/2026 02:43:40 AM] Erro: Erro ao inicializar FormProduto: | Linha: 3452 | Property CONTROLCOUNT is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-12 02:43:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-12 02:43:38] [INFO] Config FPW: (nao fornecido)
[2026-04-12 02:43:38] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-12 02:43:38] [INFO] Timeout: 300 segundos
[2026-04-12 02:43:38] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_kynrc5z2.prg
[2026-04-12 02:43:38] [INFO] Conteudo do wrapper:
[2026-04-12 02:43:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormProduto', 'C:\4c\tasks\task013', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormProduto', 'C:\4c\tasks\task013', 'CRUD'
QUIT

[2026-04-12 02:43:38] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_kynrc5z2.prg
[2026-04-12 02:43:38] [INFO] VFP output esperado em: C:\4c\tasks\task013\vfp_output.txt
[2026-04-12 02:43:38] [INFO] Executando Visual FoxPro 9...
[2026-04-12 02:43:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_kynrc5z2.prg
[2026-04-12 02:43:38] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_kynrc5z2.prg
[2026-04-12 02:43:38] [INFO] Timeout configurado: 300 segundos
[2026-04-12 02:43:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-12 02:43:40] [INFO] VFP9 finalizado em 1.5962094 segundos
[2026-04-12 02:43:40] [INFO] Exit Code: 
[2026-04-12 02:43:40] [INFO] 
[2026-04-12 02:43:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-12 02:43:40] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_kynrc5z2.prg
[2026-04-12 02:43:40] [INFO] 
[2026-04-12 02:43:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-12 02:43:40] [INFO] * Auto-generated wrapper for parameters
[2026-04-12 02:43:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-12 02:43:40] [INFO] * Parameters: 'FormProduto', 'C:\4c\tasks\task013', 'CRUD'
[2026-04-12 02:43:40] [INFO] 
[2026-04-12 02:43:40] [INFO] * Anti-dialog protections for unattended execution
[2026-04-12 02:43:40] [INFO] SET SAFETY OFF
[2026-04-12 02:43:40] [INFO] SET RESOURCE OFF
[2026-04-12 02:43:40] [INFO] SET TALK OFF
[2026-04-12 02:43:40] [INFO] SET NOTIFY OFF
[2026-04-12 02:43:40] [INFO] SYS(2335, 0)
[2026-04-12 02:43:40] [INFO] 
[2026-04-12 02:43:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormProduto', 'C:\4c\tasks\task013', 'CRUD'
[2026-04-12 02:43:40] [INFO] QUIT
[2026-04-12 02:43:40] [INFO] 
[2026-04-12 02:43:40] [INFO] === Fim do Wrapper.prg ===
[2026-04-12 02:43:40] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormProduto",
  "timestamp": "20260412024340",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg):
*==============================================================================
* FormProduto.prg - Cadastro de Produtos
* Tabela: SigCdPro | PK: cpros
* Legado: SIGCDPRO.SCX (frmcadastro)
* FASE 8/8 - COMPLETO - Eventos auxiliares e consolidacao
*==============================================================================

DEFINE CLASS FormProduto AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Cadastro de Produtos"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cModoAtual      = "LISTA"
    this_nAntOrdFase     = 0

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar instancia do Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Guards LostFocus: evita reabrir lookup se valor nao mudou
                THIS.this_cUltimoTxtTamLostFocusValidado       = ""
                THIS.this_cUltimoTxtCorLostFocusValidado       = ""
                THIS.this_cUltimoTxtConquilhaLostFocusValidado = ""
                THIS.this_cUltimoTxtClfiscalLostFocusValidado  = ""
                THIS.this_cUltimoTxtDclfiscalLostFocusValidado = ""
                THIS.this_cUltimoTxtOrigmercLostFocusValidado  = ""
                THIS.this_cUltimoTxtSittricmLostFocusValidado  = ""
                THIS.this_cUltimoTxtTpTribLostFocusValidado    = ""
                THIS.this_cUltimoTxtMetalLostFocusValidado     = ""
                THIS.this_cUltimoTxtMvalorLostFocusValidado    = ""
                THIS.this_cUltimoTxtTeorLostFocusValidado      = ""

                *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Se falhar ao carregar, nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 600
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            *-- Page1 - Lista
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +29 em TODOS os controles (Top_original + 29)
    * FASE 4: Cabecalho, Botoes CRUD, Saida, Filtros completos, Grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Container de cabecalho (cntSombra: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Sombra do titulo (lbl_4c_Sombra: Top=15, Left=10)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de Produtos"
            .Top       = 17
            .Left      = 12
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Titulo do cabecalho (lbl_4c_Titulo: Top=18, Left=10)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Produtos"
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0 -> 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (Grupo_Saida: Left=935, Top=0 -> 29)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 935
            .Width       = 60
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "X"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 50
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de filtros (cntFiltros: Top=116, Left=5, com +29 de compensacao)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 116
            .Left        = 5
            .Width       = 535
            .Height      = 65
            .BackStyle   = 1
            .BackColor   = RGB(245, 245, 245)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Grupo de Produto:"
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
            .Caption   = "Grupo de Produto:"
            .Top       = 18
            .Left      = 5
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60, 60, 60)
            .Visible   = .T.
        ENDWITH

        *-- getCgru -> txt_4c_Cgru (codigo do grupo, F4 abre lookup)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru
            .Top      = 14
            .Left     = 116
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "KeyPress",  THIS, "TxtCgruKeyPress")
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "LostFocus", THIS, "TxtCgruLostFocus")

        *-- getDgru -> txt_4c_Dgru (descricao do grupo, somente leitura)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru
            .Top      = 14
            .Left     = 149
            .Width    = 154
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- Label "Ultima Alteracao:"
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
            .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o:"
            .Top       = 43
            .Left      = 5
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60, 60, 60)
            .Visible   = .T.
        ENDWITH

        *-- getDtIni -> txt_4c_DtIni (data inicial do filtro de alteracao)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
            .Top      = 39
            .Left     = 116
            .Width    = 85
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- Label "a"
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData2", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData2
            .Caption   = "a"
            .Top       = 43
            .Left      = 203
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60, 60, 60)
            .Visible   = .T.
        ENDWITH

        *-- getDtFim -> txt_4c_DtFim (data final do filtro de alteracao)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim
            .Top      = 39
            .Left     = 220
            .Width    = 85
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- optFilSituas -> opt_4c_Situas (1=Todos, 2=Ativos, 3=Inativos)
        loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_Situas", "OptionGroup")
        WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Situas
            .Top         = 15
            .Left        = 348
            .Width       = 182
            .Height      = 20
            .ButtonCount = 3
            .Value       = 1
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Situas
            .Buttons(1).Caption   = "Todos"
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).Width     = 55
            .Buttons(1).Height    = 18
            .Buttons(1).FontName  = "Tahoma"
            .Buttons(1).FontSize  = 8
            .Buttons(1).ForeColor = RGB(60, 60, 60)
            .Buttons(1).BackStyle = 0
            .Buttons(1).Themes    = .F.
            .Buttons(1).AutoSize  = .F.

            .Buttons(2).Caption   = "Ativos"
            .Buttons(2).Left      = 60
            .Buttons(2).Top       = 0
            .Buttons(2).Width     = 55
            .Buttons(2).Height    = 18
            .Buttons(2).FontName  = "Tahoma"
            .Buttons(2).FontSize  = 8
            .Buttons(2).ForeColor = RGB(60, 60, 60)
            .Buttons(2).BackStyle = 0
            .Buttons(2).Themes    = .F.
            .Buttons(2).AutoSize  = .F.

            .Buttons(3).Caption   = "Inativos"
            .Buttons(3).Left      = 120
            .Buttons(3).Top       = 0
            .Buttons(3).Width     = 62
            .Buttons(3).Height    = 18
            .Buttons(3).FontName  = "Tahoma"
            .Buttons(3).FontSize  = 8
            .Buttons(3).ForeColor = RGB(60, 60, 60)
            .Buttons(3).BackStyle = 0
            .Buttons(3).Themes    = .F.
            .Buttons(3).AutoSize  = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")

        *----------------------------------------------------------------------
        *-- Criar cursor placeholder ANTES do grid (para RecordSource estavel)
        *-- Campos identicos ao que ProdutoBO.Buscar() cria
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_Dados")
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (;
                cpros    C(14), dpros  C(65), cgrus C(3), ;
                sgrus    C(6),  reffs  C(40), ;
                usuaalts C(20), situas N(1,0))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Grid principal da lista (Grade: Top=183, Left=5)
        *-- ColumnCount e Visible no WITH; RecordSource FORA do WITH
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top         = 183
            .Left        = 5
            .Width       = 950
            .Height      = 389
            .ColumnCount = 7
            .Visible     = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
        loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"

        *-- ControlSources e larguras APOS RecordSource
        loc_oPagina.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.cpros"
        loc_oPagina.grd_4c_Lista.Column1.Width            = 70
        loc_oPagina.grd_4c_Lista.Column1.ReadOnly         = .T.
        loc_oPagina.grd_4c_Lista.Column1.Header1.Caption  = "Produto"

        loc_oPagina.grd_4c_Lista.Column2.ControlSource   = "cursor_4c_Dados.dpros"
        loc_oPagina.grd_4c_Lista.Column2.Width            = 315
        loc_oPagina.grd_4c_Lista.Column2.ReadOnly         = .T.
        loc_oPagina.grd_4c_Lista.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"

        loc_oPagina.grd_4c_Lista.Column3.ControlSource   = "cursor_4c_Dados.cgrus"
        loc_oPagina.grd_4c_Lista.Column3.Width            = 55
        loc_oPagina.grd_4c_Lista.Column3.ReadOnly         = .T.
        loc_oPagina.grd_4c_Lista.Column3.Header1.Caption  = "Grupo"

        loc_oPagina.grd_4c_Lista.Column4.ControlSource   = "cursor_4c_Dados.sgrus"
        loc_oPagina.grd_4c_Lista.Column4.Width            = 70
        loc_oPagina.grd_4c_Lista.Column4.ReadOnly         = .T.
        loc_oPagina.grd_4c_Lista.Column4.Header1.Caption  = "Subgrp."

        loc_oPagina.grd_4c_Lista.Column5.ControlSource   = "cursor_4c_Dados.reffs"
        loc_oPagina.grd_4c_Lista.Column5.Width            = 225
        loc_oPagina.grd_4c_Lista.Column5.ReadOnly         = .T.
        loc_oPagina.grd_4c_Lista.Column5.Header1.Caption  = "Ref. Fornecedor"

        loc_oPagina.grd_4c_Lista.Column6.ControlSource   = "cursor_4c_Dados.usuaalts"
        loc_oPagina.grd_4c_Lista.Column6.Width            = 150
        loc_oPagina.grd_4c_Lista.Column6.ReadOnly         = .T.
        loc_oPagina.grd_4c_Lista.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"

        loc_oPagina.grd_4c_Lista.Column7.ControlSource   = "cursor_4c_Dados.situas"
        loc_oPagina.grd_4c_Lista.Column7.Width            = 30
        loc_oPagina.grd_4c_Lista.Column7.ReadOnly         = .T.
        loc_oPagina.grd_4c_Lista.Column7.Header1.Caption  = "I"

        *-- Formatacao padrao (Verdana 8, gridlines, RowHeight=16)
        THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)

        *-- Label de contagem de produtos (lblProdutos: Top=584 + 29 = 613 -> 575)
        loc_oPagina.AddObject("lbl_4c_Contagem", "Label")
        WITH loc_oPagina.lbl_4c_Contagem
            .Caption   = "Produtos Selecionados : 0"
            .Top       = 575
            .Left      = 38
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Tornar controles visiveis (apenas prefixos validos)
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * FASE 4/5: Botoes Salvar/Cancelar + PageFrame interno (7 abas) + pgDados
    * Compensacao +29 em controles de Page2; controles de pgf_4c_Dados sem compensacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oPgfDados
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Container de botoes de acao (Grupo_Salva: Top=4 -> 33, Left=842)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Left=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Left=80)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- PageFrame interno com 7 abas de dados
        *-- Legado: pgframeDados Top=-54, Left=-1, Width=1003, Height=656
        *-- Compensacao outer PF (-29) + inner PF (-54) = total -83 para controles internos
        *-- Top relativo a Page2: -54 + 29 = -25
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        loc_oPgfDados = loc_oPagina.pgf_4c_Dados

        WITH loc_oPgfDados
            .Top       = -25
            .Left      = -1
            .Width     = 1003
            .Height    = 656
            .PageCount = 7
            .Tabs      = .T.
            .Visible   = .T.
            .TabStyle  = 0
        ENDWITH

        *-- Aba 1: Dados Gerais (pgDados)
        WITH loc_oPgfDados.Page1
            .Caption   = "Dados"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Aba 2: Composicao (pgComposicao)
        WITH loc_oPgfDados.Page2
            .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Aba 3: Dados Fiscais (pgDadosFiscais)
        WITH loc_oPgfDados.Page3
            .Caption   = "Dados Fiscais"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Aba 4: Fases de Producao (PgDadosFaseP)
        WITH loc_oPgfDados.Page4
            .Caption   = "Fases Prod."
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Aba 5: Consulta de Componentes (PgDadosConsP)
        WITH loc_oPgfDados.Page5
            .Caption   = "Consulta Comp."
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Aba 6: Custo (pgCusto)
        WITH loc_oPgfDados.Page6
            .Caption   = "Custo"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Aba 7: Designer (pgDesigner)
        WITH loc_oPgfDados.Page7
            .Caption   = "Designer"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Configurar campos da aba Dados (Fase 5: primeiros 50%)
        THIS.ConfigurarPgDados()

        *-- Fase 9: Composicao (pgComposicao = Page2 do pgf_4c_Dados)
        THIS.ConfigurarPgpgComposicao()

        *-- Fase 10: Custo (pgCusto = Page6 do pgf_4c_Dados)
        THIS.ConfigurarPgpgCusto()

        *-- Fase 11: Consulta Componentes (PgDadosConsP = Page5 do pgf_4c_Dados)
        THIS.ConfigurarPgPgDadosConsP()

        *-- Fase 12: Fases de Producao (PgDadosFaseP = Page4 do pgf_4c_Dados)
        THIS.ConfigurarPgPgDadosFaseP()

        *-- Fase 13: Dados Fiscais (pgDadosFiscais = Page3 do pgf_4c_Dados)
        THIS.ConfigurarPgPgDadosFiscais()

        *-- Fase 14: Designer (pgDesigner = Page7 do pgf_4c_Dados)
        THIS.ConfigurarPgPgDesigner()

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * FASE 9 - Aba Composicao (pgComposicao - Page2 do pgf_4c_Dados)
    * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao
    * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
    * 144 controles: 3 grids (14+15+3 cols), 2 cmd groups, textboxes, labels, shapes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgComposicao()
        LOCAL loc_oPg, loc_oGrd

        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        *----------------------------------------------------------------------
        *-- Cursor placeholder para grdCompo (SigPrCpo)
        *-- Campos: cpros(PK), mats(material), dcomps(descricao), unicompos(un),
        *--         pcompos(valor), qtds(qtde), totals(total), bloqueio(moeda),
        *--         obscompos(obs), etiq(E), consumo(consumo), qtd2(qtde cons),
        *--         uni2(un cons), ord(ordem), matrizes(material alternativo)
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_Compo")
            SET NULL ON
            CREATE CURSOR cursor_4c_Compo (;
                cpros    C(14), mats     C(14), dcomps   C(65), ;
                unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
                totals   N(12,4), bloqueio C(5), obscompos C(40), ;
                etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
                uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
                cgrus    C(3),  moeds    C(5))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Cursor placeholder para grdsubcp (SigSubCp)
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_SubCp")
            SET NULL ON
            CREATE CURSOR cursor_4c_SubCp (;
                cpros    C(14), mats     C(14), dcomps   C(65), ;
                unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
                totals   N(12,4), bloqueio C(5), obscompos C(40), ;
                etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
                uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
                tamanhos C(20))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Cursor placeholder para GradeGRUPO (TotGrupo)
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_Grupo")
            SET NULL ON
            CREATE CURSOR cursor_4c_Grupo (cgrus C(3), valgr N(12,4), moeds C(5))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Linha OBS da OF: Say4 + getObsOFs
        *-- Say4: "Obs. da OF :" (T:300 L:36 W:64)
        *-- getObsOFs: (T:297 L:99 W:850 H:21)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_ObsOF", "Label")
        WITH loc_oPg.lbl_4c_ObsOF
            .Caption   = "Obs. da OF :"
            .Top       = 300
            .Left      = 36
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
        WITH loc_oPg.txt_4c_ObsOFs
            .Top           = 297
            .Left          = 99
            .Width         = 850
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 254
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha Descricao / Material Principal (entre grdCompo e grdsubcp)
        *-- Say16: "Descricao :" (T:324 L:45 W:55)
        *-- Get_Desc: (T:321 L:99 W:298 H:21) - readonly (When = .F.)
        *-- Say15: "Material Principal :" (T:324 L:421 W:89)
        *-- Get_MatP: (T:321 L:517 W:108 H:21) - com lookup
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblDesc", "Label")
        WITH loc_oPg.lbl_4c_LblDesc
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 324
            .Left      = 45
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPg.txt_4c_Desc
            .Top           = 321
            .Left          = 99
            .Width         = 298
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 65
            .Value         = ""
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblMatP", "Label")
        WITH loc_oPg.lbl_4c_LblMatP
            .Caption   = "Material Principal :"
            .Top       = 324
            .Left      = 421
            .Width     = 89
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_MatP", "TextBox")
        WITH loc_oPg.txt_4c_MatP
            .Top           = 321
            .Left          = 517
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 14
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_MatP, "KeyPress",  THIS, "TxtMatPKeyPress")
        BINDEVENT(loc_oPg.txt_4c_MatP, "LostFocus", THIS, "TxtMatPLostFocus")

        *----------------------------------------------------------------------
        *-- Grid grdCompo (14 colunas) - Composicao do produto
        *-- Top:148 Left:6 Width:943 Height:147
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_Compo", "Grid")
        WITH loc_oPg.grd_4c_Compo
            .Top         = 148
            .Left        = 6
            .Width       = 943
            .Height      = 147
            .ColumnCount = 14
            .FontName    = "Verdana"
            .FontSize    = 8
            .GridLines   = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(238, 238, 238)
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .AllowRowSizing = .F.
            .ReadOnly    = .F.
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle = 2
            .RowHeight   = 16
            .ScrollBars  = 2
            .Visible     = .T.
        ENDWITH

        *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
        loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"

        *-- Configurar colunas do grd_4c_Compo APOS RecordSource
        WITH loc_oPg.grd_4c_Compo
            *-- Col1: Material (C14) W:80
            .Column1.Header1.Caption       = "Material"
            .Column1.Width                 = 80
            .Column1.ControlSource         = "cursor_4c_Compo.mats"
            .Column1.Alignment             = 0

            *-- Col2: Descricao (C65) W:200
            .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width                 = 200
            .Column2.ControlSource         = "cursor_4c_Compo.dcomps"
            .Column2.Alignment             = 0

            *-- Col3: Un (C5) W:35 - readonly
            .Column3.Header1.Caption       = "Un"
            .Column3.Width                 = 35
            .Column3.ControlSource         = "cursor_4c_Compo.unicompos"
            .Column3.ReadOnly              = .T.

            *-- Col4: Valor (N) W:65
            .Column4.Header1.Caption       = "Valor"
            .Column4.Width                 = 65
            .Column4.ControlSource         = "cursor_4c_Compo.pcompos"
            .Column4.Alignment             = 1

            *-- Col5: Qtde (N) W:60
            .Column5.Header1.Caption       = "Qtde."
            .Column5.Width                 = 60
            .Column5.ControlSource         = "cursor_4c_Compo.qtds"
            .Column5.Alignment             = 1

            *-- Col6: Total (N) W:65 - readonly (calculado)
            .Column6.Header1.Caption       = "Total"
            .Column6.Width                 = 65
            .Column6.ControlSource         = "cursor_4c_Compo.totals"
            .Column6.Alignment             = 1
            .Column6.ReadOnly              = .T.

            *-- Col7: Moe (C5) W:35
            .Column7.Header1.Caption       = "Moe"
            .Column7.Width                 = 35
            .Column7.ControlSource         = "cursor_4c_Compo.bloqueio"

            *-- Col8: Observacao (C40) W:100
            .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
            .Column8.Width                 = 100
            .Column8.ControlSource         = "cursor_4c_Compo.obscompos"
            .Column8.Alignment             = 0

            *-- Col9: E (C1) W:25
            .Column9.Header1.Caption       = "E"
            .Column9.Width                 = 25
            .Column9.ControlSource         = "cursor_4c_Compo.etiq"

            *-- Col10: Consumo (N) W:65
            .Column10.Header1.Caption      = "Consumo"
            .Column10.Width                = 65
            .Column10.ControlSource        = "cursor_4c_Compo.consumo"
            .Column10.Alignment            = 1

            *-- Col11: Qtde cons (N) W:60
            .Column11.Header1.Caption      = "Qtde."
            .Column11.Width                = 60
            .Column11.ControlSource        = "cursor_4c_Compo.qtd2"
            .Column11.Alignment            = 1

            *-- Col12: Un cons (C5) W:35 - readonly
            .Column12.Header1.Caption      = "Un"
            .Column12.Width                = 35
            .Column12.ControlSource        = "cursor_4c_Compo.uni2"
            .Column12.ReadOnly             = .T.

            *-- Col13: Ord (N) W:35
            .Column13.Header1.Caption      = "Ord"
            .Column13.Width                = 35
            .Column13.ControlSource        = "cursor_4c_Compo.ord"
            .Column13.Alignment            = 1

            *-- Col14: Material alt (C14) W:83
            .Column14.Header1.Caption      = "Material"
            .Column14.Width                = 83
            .Column14.ControlSource        = "cursor_4c_Compo.matrizes"
        ENDWITH
        BINDEVENT(loc_oPg.grd_4c_Compo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")

        *----------------------------------------------------------------------
        *-- Botoes do grdCompo (cmdgCompo: 5 botoes, Right of grid)
        *-- Container em T:145 L:947 W:50 H:210 (cada botao 50x42)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cnt_4c_BotoesCompo", "Container")
        WITH loc_oPg.cnt_4c_BotoesCompo
            .Top         = 145
            .Left        = 947
            .Width       = 50
            .Height      = 210
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao 1: Inserir componente
        loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_InserirCompo", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo
            .Caption     = "+"
            .Top         = 0
            .Left        = 0
            .Width       = 50
            .Height      = 42
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 128, 0)
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo, "Click", THIS, "CmdInserirCompoClick")

        *-- Botao 2: Excluir componente
        loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_ExcluirCompo", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_ExcluirCompo
            .Caption     = "-"
            .Top         = 42
            .Left        = 0
            .Width       = 50
            .Height      = 42
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(192, 0, 0)
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_ExcluirCompo, "Click", THIS, "CmdExcluirCompoClick")

        *-- Botao 3: Calcular preco (fornecedor)
        loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_CalcFornec", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_CalcFornec
            .Caption     = "F"
            .Top         = 84
            .Left        = 0
            .Width       = 50
            .Height      = 42
            .FontName    = "Tahoma"
            .FontSize    = 9
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_CalcFornec, "Click", THIS, "CmdCalcFornecClick")

        *-- Botao 4: Atualizar composicao
        loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_AtualizarCompo", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarCompo
            .Caption     = "A"
            .Top         = 126
            .Left        = 0
            .Width       = 50
            .Height      = 42
            .FontName    = "Tahoma"
            .FontSize    = 9
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarCompo, "Click", THIS, "CmdAtualizarCompoClick")

        *-- Botao 5: Atualizar pesos
        loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_AtualizarPesos", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarPesos
            .Caption     = "P"
            .Top         = 168
            .Left        = 0
            .Width       = 50
            .Height      = 42
            .FontName    = "Tahoma"
            .FontSize    = 9
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarPesos, "Click", THIS, "CmdAtualizarPesosClick")

        *----------------------------------------------------------------------
        *-- Grid grdsubcp (15 colunas) - Sub-componentes
        *-- Top:348 Left:6 Width:943 Height:83
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_SubCp", "Grid")
        WITH loc_oPg.grd_4c_SubCp
            .Top         = 348
            .Left        = 6
            .Width       = 943
            .Height      = 83
            .ColumnCount = 15
            .FontName    = "Verdana"
            .FontSize    = 8
            .GridLines   = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(238, 238, 238)
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .AllowRowSizing = .F.
            .ReadOnly    = .F.
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle = 2
            .RowHeight   = 16
            .ScrollBars  = 2
            .Visible     = .T.
        ENDWITH

        *-- RecordSource FORA do WITH
        loc_oPg.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"

        *-- Configurar colunas do grd_4c_SubCp APOS RecordSource
        WITH loc_oPg.grd_4c_SubCp
            .Column1.Header1.Caption       = "Material"
            .Column1.Width                 = 75
            .Column1.ControlSource         = "cursor_4c_SubCp.mats"

            .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width                 = 175
            .Column2.ControlSource         = "cursor_4c_SubCp.dcomps"
            .Column2.Alignment             = 0

            .Column3.Header1.Caption       = "Un"
            .Column3.Width                 = 30
            .Column3.ControlSource         = "cursor_4c_SubCp.unicompos"
            .Column3.ReadOnly              = .T.

            .Column4.Header1.Caption       = "Valor"
            .Column4.Width                 = 60
            .Column4.ControlSource         = "cursor_4c_SubCp.pcompos"
            .Column4.Alignment             = 1

            .Column5.Header1.Caption       = "Qtde."
            .Column5.Width                 = 55
            .Column5.ControlSource         = "cursor_4c_SubCp.qtds"
            .Column5.Alignment             = 1

            .Column6.Header1.Caption       = "Total"
            .Column6.Width                 = 60
            .Column6.ControlSource         = "cursor_4c_SubCp.totals"
            .Column6.Alignment             = 1
            .Column6.ReadOnly              = .T.

            .Column7.Header1.Caption       = "Moe"
            .Column7.Width                 = 30
            .Column7.ControlSource         = "cursor_4c_SubCp.bloqueio"

            .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
            .Column8.Width                 = 90
            .Column8.ControlSource         = "cursor_4c_SubCp.obscompos"
            .Column8.Alignment             = 0

            .Column9.Header1.Caption       = "E"
            .Column9.Width                 = 25
            .Column9.ControlSource         = "cursor_4c_SubCp.etiq"

            .Column10.Header1.Caption      = "Consumo"
            .Column10.Width                = 60
            .Column10.ControlSource        = "cursor_4c_SubCp.consumo"
            .Column10.Alignment            = 1

            .Column11.Header1.Caption      = "Qtde."
            .Column11.Width                = 55
            .Column11.ControlSource        = "cursor_4c_SubCp.qtd2"
            .Column11.Alignment            = 1

            .Column12.Header1.Caption      = "Un"
            .Column12.Width                = 30
            .Column12.ControlSource        = "cursor_4c_SubCp.uni2"
            .Column12.ReadOnly             = .T.

            .Column13.Header1.Caption      = "Ord"
            .Column13.Width                = 30
            .Column13.ControlSource        = "cursor_4c_SubCp.ord"
            .Column13.Alignment            = 1

            .Column14.Header1.Caption      = "Material"
            .Column14.Width                = 80
            .Column14.ControlSource        = "cursor_4c_SubCp.matrizes"

            .Column15.Header1.Caption      = "Tam"
            .Column15.Width                = 88
            .Column15.ControlSource        = "cursor_4c_SubCp.tamanhos"
            .Column15.Alignment            = 0
        ENDWITH
        BINDEVENT(loc_oPg.grd_4c_SubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")

        *----------------------------------------------------------------------
        *-- Botoes do grdsubcp (cmdgSubCp: 2 botoes, Right of grid)
        *-- Container em T:345 L:947 W:50 H:90 (cada botao 50x45)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cnt_4c_BotoesSubCp", "Container")
        WITH loc_oPg.cnt_4c_BotoesSubCp
            .Top         = 345
            .Left        = 947
            .Width       = 50
            .Height      = 90
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao 1: Inserir sub-componente
        loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_InserirSubCp", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp
            .Caption     = "+"
            .Top         = 0
            .Left        = 0
            .Width       = 50
            .Height      = 45
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 128, 0)
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp, "Click", THIS, "CmdInserirSubCpClick")

        *-- Botao 2: Excluir sub-componente
        loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_ExcluirSubCp", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_ExcluirSubCp
            .Caption     = "-"
            .Top         = 45
            .Left        = 0
            .Width       = 50
            .Height      = 45
            .FontName    = "Tahoma"
            .FontSize    = 10
            .FontBold    = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(192, 0, 0)
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_ExcluirSubCp, "Click", THIS, "CmdExcluirSubCpClick")

        *----------------------------------------------------------------------
        *-- Descricao / Substitui (abaixo grdsubcp)
        *-- Say3: "Descricao :" (T:435 L:39 W:55)
        *-- get_desccp: (T:432 L:99 W:298 H:21) - readonly
        *-- Say5: "Substitui :" (T:435 L:465 W:50)
        *-- get_matsub: (T:432 L:517 W:108 H:21) - readonly
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_DescCp", "Label")
        WITH loc_oPg.lbl_4c_DescCp
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 435
            .Left      = 39
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DescCp", "TextBox")
        WITH loc_oPg.txt_4c_DescCp
            .Top           = 432
            .Left          = 99
            .Width         = 298
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 65
            .Value         = ""
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Substitui", "Label")
        WITH loc_oPg.lbl_4c_Substitui
            .Caption   = "Substitui :"
            .Top       = 435
            .Left      = 465
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_MatSub", "TextBox")
        WITH loc_oPg.txt_4c_MatSub
            .Top           = 432
            .Left          = 517
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 14
            .Value         = ""
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grid GradeGRUPO (3 colunas) - Totais por grupo
        *-- Top:34 Left:582 Width:229 Height:107
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_Grupo", "Grid")
        WITH loc_oPg.grd_4c_Grupo
            .Top         = 34
            .Left        = 582
            .Width       = 229
            .Height      = 107
            .ColumnCount = 3
            .FontName    = "Verdana"
            .FontSize    = 8
            .GridLines   = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(238, 238, 238)
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .AllowRowSizing = .F.
            .ReadOnly    = .T.
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle = 2
            .RowHeight   = 16
            .ScrollBars  = 2
            .Visible     = .T.
        ENDWITH

        *-- RecordSource FORA do WITH
        loc_oPg.grd_4c_Grupo.RecordSource = "cursor_4c_Grupo"

        *-- Colunas do GradeGRUPO APOS RecordSource
        WITH loc_oPg.grd_4c_Grupo
            .Column1.Header1.Caption = "Grupo"
            .Column1.Width           = 50
            .Column1.ControlSource   = "cursor_4c_Grupo.cgrus"

            .Column2.Header1.Caption = "Total"
            .Column2.Width           = 100
            .Column2.ControlSource   = "cursor_4c_Grupo.valgr"
            .Column2.Alignment       = 1

            .Column3.Header1.Caption = "Moeda"
            .Column3.Width           = 79
            .Column3.ControlSource   = "cursor_4c_Grupo.moeds"
        ENDWITH

        *----------------------------------------------------------------------
        *-- Labels de secao Custo / Venda
        *-- Say1: " Custo " (T:473 L:47 W:46 - secao de custo)
        *-- Say2: " Venda " (T:474 L:361 W:48 - secao de venda)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_SecCusto", "Label")
        WITH loc_oPg.lbl_4c_SecCusto
            .Caption   = " Custo "
            .Top       = 473
            .Left      = 47
            .Width     = 46
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 1
            .BackColor = RGB(192, 192, 192)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_SecVenda", "Label")
        WITH loc_oPg.lbl_4c_SecVenda
            .Caption   = " Venda "
            .Top       = 474
            .Left      = 361
            .Width     = 48
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 1
            .BackColor = RGB(192, 192, 192)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CheckBoxes de liberacao: chkLiberaCusto + chkLiberaVenda
        *-- chkLiberaCusto: T:458 L:9 W:39 H:38
        *-- chkLiberaVenda: T:459 L:323 W:39 H:38
        *----------------------------------------------------------------------
        loc_oPg.AddObject("chk_4c_LiberaCusto", "CheckBox")
        WITH loc_oPg.chk_4c_LiberaCusto
            .Caption   = ""
            .Top       = 458
            .Left      = 9
            .Width     = 39
            .Height    = 38
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_LiberaCusto, "Click", THIS, "ChkLiberaCustoClick")

        loc_oPg.AddObject("chk_4c_LiberaVenda", "CheckBox")
        WITH loc_oPg.chk_4c_LiberaVenda
            .Caption   = ""
            .Top       = 459
            .Left      = 323
            .Width     = 39
            .Height    = 38
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_LiberaVenda, "Click", THIS, "ChkLiberaVendaClick")

        *----------------------------------------------------------------------
        *-- Linha separadora - Shape6 (T:497 L:9 W:158 H:2 - secao custo)
        *-- Shape4 (T:498 L:323 W:158 H:2 - secao venda)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPg.shp_4c_Shape6
            .Top         = 497
            .Left        = 9
            .Width       = 158
            .Height      = 2
            .FillStyle   = 0
            .BackStyle   = 1
            .FillColor   = RGB(128, 128, 128)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPg.shp_4c_Shape4
            .Top         = 498
            .Left        = 323
            .Width       = 158
            .Height      = 2
            .FillStyle   = 0
            .BackStyle   = 1
            .FillColor   = RGB(128, 128, 128)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Secao CUSTO (controlada por chkLiberaCusto)
        *-- lblCompra: "Preco de Custo (Moeda 1)" T:502 L:9 W:127
        *-- getPcus: T:517 L:9 W:115 H:23
        *-- getMoec: T:517 L:127 W:31 H:23 (moeda custo 1)
        *-- lblCuVda: "Fator de Custo (Moeda 2)" T:502 L:161 W:126
        *-- getFcusto: T:517 L:161 W:115 H:23
        *-- getMoepc: T:517 L:279 W:31 H:23 (moeda custo 2)
        *-- Say8: "Total " T:542 L:161 W:29
        *-- getCustof: T:557 L:161 W:115 H:23
        *-- getMoecusf: T:557 L:279 W:31 H:23
        *-- Say22: "MKP" T:542 L:9 W:22
        *-- Get_cmkpc: T:557 L:9 W:24 H:23
        *-- lblValAdics: "Valor Adicional" T:542 L:64 W:71
        *-- get_pftioc: T:557 L:64 W:94 H:23
        *-- chkPlanCus: T:556 L:36 W:25 H:25
        *-- Say6: "Peso Medio" T:581 L:10 W:56
        *-- getPesom: T:596 L:10 W:79 H:23
        *-- cmdPesoM: T:597 L:92 W:26 H:23 (botao "...")
        *-- Say7: "Cotacao" T:581 L:161 W:42
        *-- GetCotaCalcP: T:596 L:161 W:115 H:23
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblCompra", "Label")
        WITH loc_oPg.lbl_4c_LblCompra
            .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
            .Top       = 502
            .Left      = 9
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
        WITH loc_oPg.txt_4c_Pcus
            .Top           = 517
            .Left          = 9
            .Width         = 115
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Pcus, "LostFocus", THIS, "TxtPcusLostFocus")

        loc_oPg.AddObject("txt_4c_Moec", "TextBox")
        WITH loc_oPg.txt_4c_Moec
            .Top           = 517
            .Left          = 127
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress",  THIS, "TxtMoecKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moec, "LostFocus", THIS, "TxtMoecLostFocus")

        loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
        WITH loc_oPg.lbl_4c_LblCuVda
            .Caption   = "Fator de Custo (Moeda 2)"
            .Top       = 502
            .Left      = 161
            .Width     = 126
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
        WITH loc_oPg.txt_4c_Fcusto
            .Top           = 517
            .Left          = 161
            .Width         = 115
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Fcusto, "LostFocus", THIS, "TxtFcustoLostFocus")

        loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
        WITH loc_oPg.txt_4c_Moepc
            .Top           = 517
            .Left          = 279
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress",  THIS, "TxtMoepcKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moepc, "LostFocus", THIS, "TxtMoepcLostFocus")

        loc_oPg.AddObject("lbl_4c_LblTotalCusto", "Label")
        WITH loc_oPg.lbl_4c_LblTotalCusto
            .Caption   = "Total "
            .Top       = 542
            .Left      = 161
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Custof", "TextBox")
        WITH loc_oPg.txt_4c_Custof
            .Top           = 557
            .Left          = 161
            .Width         = 115
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Custof, "LostFocus", THIS, "TxtCustofLostFocus")

        loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
        WITH loc_oPg.txt_4c_Moecusf
            .Top           = 557
            .Left          = 279
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress",  THIS, "TxtMoecusfKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moecusf, "LostFocus", THIS, "TxtMoecusfLostFocus")

        loc_oPg.AddObject("lbl_4c_LblMkp", "Label")
        WITH loc_oPg.lbl_4c_LblMkp
            .Caption   = "MKP"
            .Top       = 542
            .Left      = 9
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_GetCmkpc", "TextBox")
        WITH loc_oPg.txt_4c_GetCmkpc
            .Top           = 557
            .Left          = 9
            .Width         = 24
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_GetCmkpc, "KeyPress",  THIS, "TxtGetCmkpcKeyPress")
        BINDEVENT(loc_oPg.txt_4c_GetCmkpc, "LostFocus", THIS, "TxtGetCmkpcLostFocus")

        loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
        WITH loc_oPg.lbl_4c_LblValAdics
            .Caption   = "Valor Adicional"
            .Top       = 542
            .Left      = 64
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_GetPftioc", "TextBox")
        WITH loc_oPg.txt_4c_GetPftioc
            .Top           = 557
            .Left          = 64
            .Width         = 94
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_GetPftioc, "KeyPress",  THIS, "TxtGetPftiocKeyPress")
        BINDEVENT(loc_oPg.txt_4c_GetPftioc, "LostFocus", THIS, "TxtGetPftiocLostFocus")

        *-- chkPlanCus (T:556 L:36 W:25 H:25) - plano custo
        loc_oPg.AddObject("chk_4c_PlanCus", "CheckBox")
        WITH loc_oPg.chk_4c_PlanCus
            .Caption   = ""
            .Top       = 556
            .Left      = 36
            .Width     = 25
            .Height    = 25
            .Value     = 0
            .BackStyle = 0
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_PlanCus, "Click", THIS, "ChkPlanCusClick")

        loc_oPg.AddObject("lbl_4c_PesoMedio", "Label")
        WITH loc_oPg.lbl_4c_PesoMedio
            .Caption   = "Peso M" + CHR(233) + "dio"
            .Top       = 581
            .Left      = 10
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pesom", "TextBox")
        WITH loc_oPg.txt_4c_Pesom
            .Top           = 596
            .Left          = 10
            .Width         = 79
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Pesom, "LostFocus", THIS, "TxtPesomLostFocus")

        *-- cmdPesoM: "..." T:597 L:92 W:26 H:23
        loc_oPg.AddObject("cmd_4c_PesoM", "CommandButton")
        WITH loc_oPg.cmd_4c_PesoM
            .Caption     = "..."
            .Top         = 597
            .Left        = 92
            .Width       = 26
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_PesoM, "Click", THIS, "CmdPesoMClick")

        loc_oPg.AddObject("lbl_4c_LblCotacao", "Label")
        WITH loc_oPg.lbl_4c_LblCotacao
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .Top       = 581
            .Left      = 161
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
        WITH loc_oPg.txt_4c_CotaCalcP
            .Top           = 596
            .Left          = 161
            .Width         = 115
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CotaCalcP, "LostFocus", THIS, "TxtCotaCalcPLostFocus")

        *----------------------------------------------------------------------
        *-- Secao VENDA (controlada por chkLiberaVenda)
        *-- lblMkpVenda: "MKP Ideal" T:504 L:324 W:49
        *-- getMargem: T:517 L:323 W:89 H:23
        *-- Say24: "Sts" T:542 L:324 W:17
        *-- getStatus: T:557 L:324 W:31 H:23 (status lookup SigCdPst)
        *-- lblMkpApl: "MKP Aplic." T:581 L:324 W:51
        *-- getMarkupA: T:596 L:323 W:62 H:23
        *-- Chk_Pvenda: T:595 L:387 W:25 H:25
        *-- chkPlanVen: T:556 L:387 W:25 H:25
        *-- Say14: "MKP" T:542 L:360 W:22
        *-- Getftio: T:557 L:360 W:24 H:23 (MKP fator)
        *-- lblIdeal: "Preco Ideal (Moeda 1)" T:503 L:416 W:111
        *-- Say13: "Valor Adicional" T:542 L:416 W:71
        *-- Get_Pftio: T:557 L:416 W:110 H:23 (fator adicional)
        *-- getMoeda: T:517 L:529 W:31 H:23 (moeda venda ideal)
        *-- Say12: "Fator" T:542 L:563 W:28
        *-- Get_mftio: T:557 L:529 W:31 H:23 (moeda fator)
        *-- getFIdeals: T:517 L:563 W:110 H:23
        *-- getPvideal: T:517 L:416 W:110 H:23 (preco ideal)
        *-- lblVenda: "Preco Atual (Moeda 2)" T:581 L:416 W:115
        *-- getMoepv: T:557 L:677 W:31 H:23 (moeda preco venda)
        *-- getMoev: T:596 L:529 W:31 H:23 (moeda venda)
        *-- getFvenda: T:557 L:563 W:110 H:23 (fator venda)
        *-- getPven: T:596 L:416 W:110 H:23 (preco venda)
        *-- lblFIdeals: "Fator Ideal" T:503 L:563 W:55
        *-- lblFAtuals: "Fator Atual" T:581 L:563 W:56
        *-- getFAtuals: T:596 L:563 W:110 H:23
        *-- Say25: "Financeiro" T:581 L:678 W:51
        *-- Get_Encarg: T:595 L:678 W:62 H:23
        *-- cmdCalcVals: T:507 L:678 W:40 H:40
        *----------------------------------------------------------------------

        loc_oPg.AddObject("lbl_4c_LblMkpVenda", "Label")
        WITH loc_oPg.lbl_4c_LblMkpVenda
            .Caption   = "MKP Ideal"
            .Top       = 504
            .Left      = 324
            .Width     = 49
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Margem", "TextBox")
        WITH loc_oPg.txt_4c_Margem
            .Top           = 517
            .Left          = 323
            .Width         = 89
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TxtMargemLostFocus")

        loc_oPg.AddObject("lbl_4c_LblSts", "Label")
        WITH loc_oPg.lbl_4c_LblSts
            .Caption   = "Sts"
            .Top       = 542
            .Left      = 324
            .Width     = 17
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_GetStatus", "TextBox")
        WITH loc_oPg.txt_4c_GetStatus
            .Top           = 557
            .Left          = 324
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_GetStatus, "KeyPress",  THIS, "TxtGetStatusKeyPress")
        BINDEVENT(loc_oPg.txt_4c_GetStatus, "LostFocus", THIS, "TxtGetStatusLostFocus")

        loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
        WITH loc_oPg.lbl_4c_LblMkpApl
            .Caption   = "MKP Aplic."
            .Top       = 581
            .Left      = 324
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
        WITH loc_oPg.txt_4c_MarkupA
            .Top           = 596
            .Left          = 323
            .Width         = 62
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_MarkupA, "LostFocus", THIS, "TxtMarkupALostFocus")

        *-- Chk_Pvenda (T:595 L:387 W:25 H:25) - usa preco de venda atual
        loc_oPg.AddObject("chk_4c_PVenda", "CheckBox")
        WITH loc_oPg.chk_4c_PVenda
            .Caption   = ""
            .Top       = 595
            .Left      = 387
            .Width     = 25
            .Height    = 25
            .Value     = 0
            .BackStyle = 0
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_PVenda, "Click", THIS, "ChkPVendaClick")

        *-- chkPlanVen (T:556 L:387 W:25 H:25) - plano venda
        loc_oPg.AddObject("chk_4c_PlanVen", "CheckBox")
        WITH loc_oPg.chk_4c_PlanVen
            .Caption   = ""
            .Top       = 556
            .Left      = 387
            .Width     = 25
            .Height    = 25
            .Value     = 0
            .BackStyle = 0
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_PlanVen, "Click", THIS, "ChkPlanVenClick")

        loc_oPg.AddObject("lbl_4c_LblMkpFat", "Label")
        WITH loc_oPg.lbl_4c_LblMkpFat
            .Caption   = "MKP"
            .Top       = 542
            .Left      = 360
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Getftio", "TextBox")
        WITH loc_oPg.txt_4c_Getftio
            .Top           = 557
            .Left          = 360
            .Width         = 24
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Getftio, "KeyPress",  THIS, "TxtGetftioKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Getftio, "LostFocus", THIS, "TxtGetftioLostFocus")

        loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
        WITH loc_oPg.lbl_4c_LblIdeal
            .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
            .Top       = 503
            .Left      = 416
            .Width     = 111
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
        WITH loc_oPg.txt_4c_Pvideal
            .Top           = 517
            .Left          = 416
            .Width         = 110
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Pvideal, "LostFocus", THIS, "TxtPvidealLostFocus")

        loc_oPg.AddObject("lbl_4c_LblValAdicV", "Label")
        WITH loc_oPg.lbl_4c_LblValAdicV
            .Caption   = "Valor Adicional"
            .Top       = 542
            .Left      = 416
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_GetPftio", "TextBox")
        WITH loc_oPg.txt_4c_GetPftio
            .Top           = 557
            .Left          = 416
            .Width         = 110
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg.txt_4c_Moeda
            .Top           = 517
            .Left          = 529
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress",  THIS, "TxtMoedaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TxtMoedaLostFocus")

        loc_oPg.AddObject("lbl_4c_LblFatorI", "Label")
        WITH loc_oPg.lbl_4c_LblFatorI
            .Caption   = "Fator"
            .Top       = 542
            .Left      = 563
            .Width     = 28
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_GetMftio", "TextBox")
        WITH loc_oPg.txt_4c_GetMftio
            .Top           = 557
            .Left          = 529
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_GetMftio, "LostFocus", THIS, "TxtGetMftioLostFocus")

        loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
        WITH loc_oPg.lbl_4c_LblFIdeals
            .Caption   = "Fator Ideal"
            .Top       = 503
            .Left      = 563
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
        WITH loc_oPg.txt_4c_FIdeals
            .Top           = 517
            .Left          = 563
            .Width         = 110
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
        WITH loc_oPg.lbl_4c_LblVenda
            .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
            .Top       = 581
            .Left      = 416
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
        WITH loc_oPg.txt_4c_Moepv
            .Top           = 557
            .Left          = 677
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress",  THIS, "TxtMoepvKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moepv, "LostFocus", THIS, "TxtMoepvLostFocus")

        loc_oPg.AddObject("txt_4c_Moev", "TextBox")
        WITH loc_oPg.txt_4c_Moev
            .Top           = 596
            .Left          = 529
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 5
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress",  THIS, "TxtMoevKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moev, "LostFocus", THIS, "TxtMoevLostFocus")

        loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
        WITH loc_oPg.txt_4c_Fvenda
            .Top           = 557
            .Left          = 563
            .Width         = 110
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Fvenda, "LostFocus", THIS, "TxtFvendaLostFocus")

        loc_oPg.AddObject("txt_4c_Pven", "TextBox")
        WITH loc_oPg.txt_4c_Pven
            .Top           = 596
            .Left          = 416
            .Width         = 110
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Pven, "LostFocus", THIS, "TxtPvenLostFocus")

        loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
        WITH loc_oPg.lbl_4c_LblFAtuals
            .Caption   = "Fator Atual"
            .Top       = 581
            .Left      = 563
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
        WITH loc_oPg.txt_4c_FAtuals
            .Top           = 596
            .Left          = 563
            .Width         = 110
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblFinanc", "Label")
        WITH loc_oPg.lbl_4c_LblFinanc
            .Caption   = "Financeiro"
            .Top       = 581
            .Left      = 678
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_GetEncarg", "TextBox")
        WITH loc_oPg.txt_4c_GetEncarg
            .Top           = 595
            .Left          = 678
            .Width         = 62
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0.0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_GetEncarg, "LostFocus", THIS, "TxtGetEncargLostFocus")

        *-- cmdCalcVals (T:507 L:678 W:40 H:40) - calcular valores
        loc_oPg.AddObject("cmd_4c_CalcVals", "CommandButton")
        WITH loc_oPg.cmd_4c_CalcVals
            .Caption     = "Calc."
            .Top         = 507
            .Left        = 678
            .Width       = 40
            .Height      = 40
            .FontName    = "Tahoma"
            .FontSize    = 7
            .Themes      = .F.
            .SpecialEffect = 0
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CalcVals, "Click", THIS, "CmdCalcValsClick")

        *----------------------------------------------------------------------
        *-- Container cntMtPrima (T:511 L:752 W:242 H:108)
        *-- Controles internos: Composicao, Montagem, Digitos, Ordem, Casas
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
        WITH loc_oPg.cnt_4c_MtPrima
            .Top         = 511
            .Left        = 752
            .Width       = 242
            .Height      = 108
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *-- lblCompos: "Composicao :" T:1 L:6 W:66
        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblCompos", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblCompos
            .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
            .Top       = 1
            .Left      = 6
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCompos: T:18 L:6 W:233
        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Compos", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Compos
            .Top           = 18
            .Left          = 6
            .Width         = 233
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 40
            .Value         = ""
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lblMontaDescs: "Montagem :" T:42 L:6 W:59
        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblMontagem", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblMontagem
            .Caption   = "Montagem :"
            .Top       = 42
            .Left      = 6
            .Width     = 59
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- cmbMontaDescs: T:59 L:6 W:233 (ComboBox)
        loc_oPg.cnt_4c_MtPrima.AddObject("cmb_4c_MontaDescs", "ComboBox")
        WITH loc_oPg.cnt_4c_MtPrima.cmb_4c_MontaDescs
            .Top       = 59
            .Left      = 6
            .Width     = 233
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Style     = 2
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- lblDigiMaxs: "Digitos :" T:88 L:4 W:41
        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblDigiMaxs", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblDigiMaxs
            .Caption   = "D" + CHR(237) + "gitos :"
            .Top       = 88
            .Left      = 4
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getDigiMaxs: T:84 L:54 W:25
        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_DigiMaxs", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_DigiMaxs
            .Top           = 84
            .Left          = 54
            .Width         = 25
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = 0
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lblOrdCompos: "Ordem :" T:88 L:85 W:41
        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblOrdCompos", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblOrdCompos
            .Caption   = "Ordem :"
            .Top       = 88
            .Left      = 85
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getOrdCompos: T:84 L:136 W:25
        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_OrdCompos", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_OrdCompos
            .Top           = 84
            .Left          = 136
            .Width         = 25
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = 0
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lblCasas: "Casas :" T:88 L:165 W:38
        loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblCasas", "Label")
        WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblCasas
            .Caption   = "Casas :"
            .Top       = 88
            .Left      = 165
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCasas: T:84 L:213 W:25
        loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Casas", "TextBox")
        WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Casas
            .Top           = 84
            .Left          = 213
            .Width         = 25
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = 0
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * FASE 9 - Handlers publicos da aba Composicao
    * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrdCompoAfterRowColChange - Atualiza Get_Desc e getObsOFs ao navegar
    *--------------------------------------------------------------------------
    PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
                loc_oPg.txt_4c_Desc.Value  = ALLTRIM(cursor_4c_Compo.dcomps)
                loc_oPg.txt_4c_MatSub.Value = ALLTRIM(cursor_4c_Compo.matrizes)
            ENDIF
        CATCH TO loc_oErro
            *-- silencioso: refresh de display nao deve bloquear navegacao
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdSubCpAfterRowColChange - Atualiza get_desccp e get_matsub ao navegar
    *--------------------------------------------------------------------------
    PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
                loc_oPg.txt_4c_DescCp.Value  = ALLTRIM(cursor_4c_SubCp.dcomps)
                loc_oPg.txt_4c_MatSub.Value  = ALLTRIM(cursor_4c_SubCp.matrizes)
            ENDIF
        CATCH TO loc_oErro
            *-- silencioso
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkLiberaCustoClick - Habilita/desabilita campos de custo
    *--------------------------------------------------------------------------
    PROCEDURE ChkLiberaCustoClick()
        LOCAL loc_oPg, loc_lLivre
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_lLivre = (loc_oPg.chk_4c_LiberaCusto.Value = 1) AND ;
                         INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oPg.txt_4c_Pcus.Enabled       = loc_lLivre
            loc_oPg.txt_4c_Moec.Enabled        = loc_lLivre
            loc_oPg.txt_4c_Fcusto.Enabled      = loc_lLivre
            loc_oPg.txt_4c_Moepc.Enabled       = loc_lLivre
            loc_oPg.txt_4c_Custof.Enabled      = loc_lLivre
            loc_oPg.txt_4c_Moecusf.Enabled     = loc_lLivre
            loc_oPg.txt_4c_GetCmkpc.Enabled    = loc_lLivre
            loc_oPg.txt_4c_GetPftioc.Enabled   = loc_lLivre
            loc_oPg.chk_4c_PlanCus.Enabled     = loc_lLivre
            loc_oPg.txt_4c_Pesom.Enabled        = loc_lLivre
            loc_oPg.cmd_4c_PesoM.Enabled        = loc_lLivre
            loc_oPg.txt_4c_CotaCalcP.Enabled   = loc_lLivre
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar libera" + CHR(231) + CHR(227) + "o custo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkLiberaVendaClick - Habilita/desabilita campos de venda
    *--------------------------------------------------------------------------
    PROCEDURE ChkLiberaVendaClick()
        LOCAL loc_oPg, loc_lLivre
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_lLivre = (loc_oPg.chk_4c_LiberaVenda.Value = 1) AND ;
                         INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oPg.txt_4c_Margem.Enabled      = loc_lLivre
            loc_oPg.txt_4c_GetStatus.Enabled   = loc_lLivre
            loc_oPg.txt_4c_MarkupA.Enabled     = loc_lLivre
            loc_oPg.chk_4c_PVenda.Enabled      = loc_lLivre
            loc_oPg.chk_4c_PlanVen.Enabled     = loc_lLivre
            loc_oPg.txt_4c_Getftio.Enabled     = loc_lLivre
            loc_oPg.txt_4c_Pvideal.Enabled     = loc_lLivre
            loc_oPg.txt_4c_Moeda.Enabled        = loc_lLivre
            loc_oPg.txt_4c_GetPftio.Enabled    = loc_lLivre
            loc_oPg.txt_4c_GetMftio.Enabled    = loc_lLivre
            loc_oPg.txt_4c_FIdeals.Enabled     = loc_lLivre
            loc_oPg.txt_4c_Moepv.Enabled        = loc_lLivre
            loc_oPg.txt_4c_Moev.Enabled         = loc_lLivre
            loc_oPg.txt_4c_Fvenda.Enabled       = loc_lLivre
            loc_oPg.txt_4c_Pven.Enabled         = loc_lLivre
            loc_oPg.txt_4c_FAtuals.Enabled      = loc_lLivre
            loc_oPg.txt_4c_GetEncarg.Enabled    = loc_lLivre
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar libera" + CHR(231) + CHR(227) + "o venda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdInserirCompoClick - Adiciona nova linha na composicao
    *--------------------------------------------------------------------------
    PROCEDURE CmdInserirCompoClick()
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF USED("cursor_4c_Compo")
                SELECT cursor_4c_Compo
                APPEND BLANK
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir componente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirCompoClick - Remove linha da composicao
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirCompoClick()
        LOCAL loc_lConfirma
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
                loc_lConfirma = MsgConfirma("Excluir componente selecionado?")
                IF loc_lConfirma
                    SELECT cursor_4c_Compo
                    DELETE
                    IF !EOF()
                        SKIP
                        SKIP -1
                    ENDIF
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir componente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCalcFornecClick - Recalcula precos de custo via fornecedor
    *--------------------------------------------------------------------------
    PROCEDURE CmdCalcFornecClick()
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CalcFornec()
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao calcular por fornecedor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAtualizarCompoClick - Atualiza composicao (recalcula totais/grupos)
    *--------------------------------------------------------------------------
    PROCEDURE CmdAtualizarCompoClick()
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.AtualizarComposicao()
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Grupo.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAtualizarPesosClick - Atualiza pesos medios dos componentes
    *--------------------------------------------------------------------------
    PROCEDURE CmdAtualizarPesosClick()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.AtualizarPesos()
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar pesos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdInserirSubCpClick - Adiciona linha no grid de sub-componentes
    *--------------------------------------------------------------------------
    PROCEDURE CmdInserirSubCpClick()
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo") AND ;
               !EMPTY(cursor_4c_Compo.mats)
                IF USED("cursor_4c_SubCp")
                    SELECT cursor_4c_SubCp
                    APPEND BLANK
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
                ENDIF
            ELSE
                MsgAviso("Selecione um componente antes de adicionar sub-componente.")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir sub-componente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirSubCpClick - Remove linha do grid de sub-componentes
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirSubCpClick()
        LOCAL loc_lConfirma
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
                loc_lConfirma = MsgConfirma("Excluir sub-componente selecionado?")
                IF loc_lConfirma
                    SELECT cursor_4c_SubCp
                    DELETE
                    IF !EOF()
                        SKIP
                        SKIP -1
                    ENDIF
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir sub-componente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCalcValsClick - Calcular valores de preco/custo/venda
    *--------------------------------------------------------------------------
    PROCEDURE CmdCalcValsClick()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CalcVals()
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao calcular valores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdPesoMClick - Atualizar peso medio do produto
    *--------------------------------------------------------------------------
    PROCEDURE CmdPesoMClick()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.AtualizarPesoMedio()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar peso m" + CHR(233) + "dio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkPlanCusClick - Plano de custo
    *--------------------------------------------------------------------------
    PROCEDURE ChkPlanCusClick()
        *-- chkPlanCus.Valid: If Value=1, Do Form SigOpPcu With ThisForm,'C'
        *-- Na migracao: exibe mensagem de funcionalidade em desenvolvimento
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.chk_4c_PlanCus.Value = 0
        CATCH TO loc_oErro
            *-- silencioso
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkPVendaClick - Usar preco de venda atual no calculo
    *--------------------------------------------------------------------------
    PROCEDURE ChkPVendaClick()
        *-- chkPVenda.Click: recalcular
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CalcPreco()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao calcular pre" + CHR(231) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkPlanVenClick - Plano de venda
    *--------------------------------------------------------------------------
    PROCEDURE ChkPlanVenClick()
        *-- chkPlanVen.Valid: If Value=1, Do Form SigOpPcu With ThisForm,'V'
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.chk_4c_PlanVen.Value = 0
        CATCH TO loc_oErro
            *-- silencioso
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Moeda lookups F4 para todos os campos de moeda da aba Composicao
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupMoedaCompo("txt_4c_Moec")
        ENDIF
    ENDPROC

    PROCEDURE TxtMoecLostFocus()
        THIS.ValidarMoedaCompo("txt_4c_Moec")
    ENDPROC

    PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupMoedaCompo("txt_4c_Moepc")
        ENDIF
    ENDPROC

    PROCEDURE TxtMoepcLostFocus()
        THIS.ValidarMoedaCompo("txt_4c_Moepc")
        THIS.CalcPrecoCompo()
    ENDPROC

    PROCEDURE TxtMoecusfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupMoedaCompo("txt_4c_Moecusf")
        ENDIF
    ENDPROC

    PROCEDURE TxtMoecusfLostFocus()
        THIS.ValidarMoedaCompo("txt_4c_Moecusf")
        THIS.CalcPrecoCompo()
    ENDPROC

    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupMoedaCompo("txt_4c_Moeda")
        ENDIF
    ENDPROC

    PROCEDURE TxtMoedaLostFocus()
        THIS.ValidarMoedaCompo("txt_4c_Moeda")
        THIS.CalcPrecoCompo()
    ENDPROC

    PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupMoedaCompo("txt_4c_Moepv")
        ENDIF
    ENDPROC

    PROCEDURE TxtMoepvLostFocus()
        THIS.ValidarMoedaCompo("txt_4c_Moepv")
    ENDPROC

    PROCEDURE TxtMoevKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupMoedaCompo("txt_4c_Moev")
        ENDIF
    ENDPROC

    PROCEDURE TxtMoevLostFocus()
        THIS.ValidarMoedaCompo("txt_4c_Moev")
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoedaCompo - Abre FormBuscaAuxiliar para SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoedaCompo(par_cCampo)
        LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_oCtrl
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_oCtrl  = EVALUATE("loc_oPg." + par_cCampo)
            loc_cAtual = ALLTRIM(loc_oCtrl.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cAtual, ;
                "Buscar Moeda")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
                    loc_oBusca.mAddColuna("DMoes", "", "Moeda")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoedaCompo - Valida codigo de moeda via SQLEXEC
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoedaCompo(par_cCampo)
        LOCAL loc_oPg, loc_oCtrl, loc_cMoe, loc_nRet
        TRY
            IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                RETURN
            ENDIF
            loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_oCtrl = EVALUATE("loc_oPg." + par_cCampo)
            loc_cMoe  = ALLTRIM(loc_oCtrl.Value)
            IF EMPTY(loc_cMoe)
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoe), ;
                "cursor_4c_TmpMoe")
            IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpMoe") < 1
                MsgAviso("Moeda '" + loc_cMoe + "' n" + CHR(227) + "o encontrada!")
                loc_oCtrl.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpMoe")
                USE IN cursor_4c_TmpMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar moeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcPrecoCompo - Chama calculo de preco pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE CalcPrecoCompo()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CalcPreco()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao calcular pre" + CHR(231) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtPcusLostFocus - Recalcular ao sair do preco de custo
    *--------------------------------------------------------------------------
    PROCEDURE TxtPcusLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtFcustoLostFocus - Recalcular ao sair do fator de custo
    *--------------------------------------------------------------------------
    PROCEDURE TxtFcustoLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCustofLostFocus - Recalcular ao sair do custo total
    *--------------------------------------------------------------------------
    PROCEDURE TxtCustofLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetCmkpcKeyPress / LostFocus - MKP custo (F4 = lookup SigPrFti)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetCmkpcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupFtioCusto()
        ENDIF
    ENDPROC

    PROCEDURE TxtGetCmkpcLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    PROCEDURE AbrirLookupFtioCusto()
        LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_nRet
        TRY
            IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                RETURN
            ENDIF
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cAtual = ALLTRIM(loc_oPg.txt_4c_GetCmkpc.Value)
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT Cods, Descs, Moedas, Valors, TpFtios FROM SigPrFti WHERE Tipos = 1", ;
                "cursor_4c_ListaFtioCusto")
            IF loc_nRet > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigPrFti", "cursor_4c_BuscaFtioCusto", "Cods", loc_cAtual, ;
                    "Fator de Custo")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Moedas", "", "Moeda")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioCusto")
                        loc_oPg.txt_4c_GetCmkpc.Value = ALLTRIM(cursor_4c_BuscaFtioCusto.Cods)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaFtioCusto")
                    USE IN cursor_4c_BuscaFtioCusto
                ENDIF
            ENDIF
            IF USED("cursor_4c_ListaFtioCusto")
                USE IN cursor_4c_ListaFtioCusto
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar fator de custo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetPftiocKeyPress / LostFocus - Fator adicional custo
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetPftiocKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupFtioCusto()
        ENDIF
    ENDPROC

    PROCEDURE TxtGetPftiocLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtPesomLostFocus - Recalcular ao sair do peso medio
    *--------------------------------------------------------------------------
    PROCEDURE TxtPesomLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCotaCalcPLostFocus - Recalcular ao sair da cotacao
    *--------------------------------------------------------------------------
    PROCEDURE TxtCotaCalcPLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetftioKeyPress / LostFocus - MKP Fator venda (F4 = lookup SigPrFti)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetftioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupFtioVenda()
        ENDIF
    ENDPROC

    PROCEDURE TxtGetftioLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    PROCEDURE AbrirLookupFtioVenda()
        LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_nRet
        TRY
            IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                RETURN
            ENDIF
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Getftio.Value)
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT Cods, Descs FROM SigPrFti", ;
                "cursor_4c_ListaFtioVenda")
            IF loc_nRet > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigPrFti", "cursor_4c_BuscaFtioVenda", "Cods", loc_cAtual, ;
                    "Fator de Venda")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioVenda")
                        loc_oPg.txt_4c_Getftio.Value = ALLTRIM(cursor_4c_BuscaFtioVenda.Cods)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaFtioVenda")
                    USE IN cursor_4c_BuscaFtioVenda
                ENDIF
            ENDIF
            IF USED("cursor_4c_ListaFtioVenda")
                USE IN cursor_4c_ListaFtioVenda
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar fator de venda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMargemLostFocus - Recalcular ao sair da margem
    *--------------------------------------------------------------------------
    PROCEDURE TxtMargemLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtPvidealLostFocus - Recalcular ao sair do preco ideal
    *--------------------------------------------------------------------------
    PROCEDURE TxtPvidealLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetStatusKeyPress / LostFocus - Status do produto (F4 = lookup SigCdPst)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetStatusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupStatusCompo()
        ENDIF
    ENDPROC

    PROCEDURE TxtGetStatusLostFocus()
        LOCAL loc_oPg, loc_cSts, loc_nRet
        TRY
            IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                RETURN
            ENDIF
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cSts = ALLTRIM(loc_oPg.txt_4c_GetStatus.Value)
            IF EMPTY(loc_cSts)
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT Cods FROM SigCdPst WHERE Cods = " + EscaparSQL(loc_cSts), ;
                "cursor_4c_TmpSts")
            IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpSts") < 1
                MsgAviso("Status '" + loc_cSts + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_GetStatus.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpSts")
                USE IN cursor_4c_TmpSts
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar status")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupStatusCompo()
        LOCAL loc_oPg, loc_oBusca, loc_cAtual
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cAtual = ALLTRIM(loc_oPg.txt_4c_GetStatus.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPst", "cursor_4c_BuscaSts", "Cods", loc_cAtual, ;
                "Buscar Status")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSts")
                    loc_oPg.txt_4c_GetStatus.Value = ALLTRIM(cursor_4c_BuscaSts.Cods)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaSts")
                USE IN cursor_4c_BuscaSts
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar status")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMarkupALostFocus - Recalcular ao sair do markup aplicado
    *--------------------------------------------------------------------------
    PROCEDURE TxtMarkupALostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtFvendaLostFocus - Recalcular ao sair do fator de venda
    *--------------------------------------------------------------------------
    PROCEDURE TxtFvendaLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtPvenLostFocus - Recalcular ao sair do preco de venda
    *--------------------------------------------------------------------------
    PROCEDURE TxtPvenLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetMftioLostFocus - Recalcular ao sair do fator moeda
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetMftioLostFocus()
        THIS.CalcPrecoCompo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetEncargLostFocus - Validar valor financeiro (encargos)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetEncargLostFocus()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF loc_oPg.txt_4c_GetEncarg.Value < 0
                MsgAviso("Valor inv" + CHR(225) + "lido!")
                loc_oPg.txt_4c_GetEncarg.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar encargo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMatPKeyPress / LostFocus - Material Principal (F4 = lookup SigCdPro)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMatPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupMatP()
        ENDIF
    ENDPROC

    PROCEDURE TxtMatPLostFocus()
        LOCAL loc_oPg, loc_cMatP, loc_nRet
        TRY
            IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                RETURN
            ENDIF
            loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cMatP = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
            IF EMPTY(loc_cMatP)
                loc_oPg.txt_4c_Desc.Value = ""
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cMatP), ;
                "cursor_4c_TmpMatP")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpMatP") > 0
                loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_TmpMatP.dpros)
            ELSE
                MsgAviso("Produto '" + loc_cMatP + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_MatP.Value = ""
                loc_oPg.txt_4c_Desc.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpMatP")
                USE IN cursor_4c_TmpMatP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar material principal")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupMatP()
        LOCAL loc_oPg, loc_oBusca, loc_cAtual
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cAtual = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaMatP", "cpros", loc_cAtual, ;
                "Buscar Material Principal")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatP")
                    loc_oPg.txt_4c_MatP.Value  = ALLTRIM(cursor_4c_BuscaMatP.cpros)
                    loc_oPg.txt_4c_Desc.Value  = ALLTRIM(cursor_4c_BuscaMatP.dpros)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMatP")
                USE IN cursor_4c_BuscaMatP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar material principal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid usando filtros da UI
    * Legado: fCarregaGrade() leia cntFiltros.getCgru/optFilSituas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cFiltro, loc_oPagina
        LOCAL loc_cCgru, loc_nSitI, loc_nSitF, loc_oGrid
        loc_lResultado = .F.

        *-- Guard: pular se validando UI (sem conexao SQL)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Capturar filtros da UI (com guard de existencia)
            loc_cCgru = ""
            loc_nSitI = 1
            loc_nSitF = 2

            IF VARTYPE(loc_oPagina.cnt_4c_Filtros) = "O"
                loc_cCgru = ALLTRIM(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value)

                *-- optFilSituas: 1=Todos, 2=Ativos(situas=1), 3=Inativos(situas=2)
                loc_nSitI = IIF(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas.Value = 3, 2, 1)
                loc_nSitF = IIF(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas.Value = 2, 1, 2)
            ENDIF

            *-- Construir WHERE clause
            loc_cFiltro = "situas BETWEEN " + TRANSFORM(loc_nSitI) + " AND " + TRANSFORM(loc_nSitF)
            IF !EMPTY(loc_cCgru)
                loc_cFiltro = loc_cFiltro + " AND cgrus = " + EscaparSQL(loc_cCgru)
            ENDIF

            *-- Buscar dados via BO (ZAP+APPEND preserva estrutura do cursor/grid)
            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)

                *-- Redefinir headers APOS cada Buscar() (VFP9 pode resetar)
                IF VARTYPE(loc_oPagina.grd_4c_Lista) = "O"
                    loc_oGrid = loc_oPagina.grd_4c_Lista
                    loc_oGrid.Column1.Header1.Caption = "Produto"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Grupo"
                    loc_oGrid.Column4.Header1.Caption = "Subgrp."
                    loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
                    loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
                    loc_oGrid.Column7.Header1.Caption = "I"
                    loc_oGrid.Refresh()
                ENDIF

                *-- Atualizar contagem
                IF VARTYPE(loc_oPagina.lbl_4c_Contagem) = "O"
                    loc_oPagina.lbl_4c_Contagem.Caption = "Produtos Selecionados : " + ;
                        TRANSFORM(RECCOUNT("cursor_4c_Dados"))
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre paginas do PageFrame principal
    * Page1=Lista, Page2=Dados
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)

        IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
            RETURN
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        *-- Ao voltar para Page1, recarregar lista
        IF par_nPagina = 1
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCgruKeyPress - F4 abre lookup de grupos de produto
    * BINDEVENT requer PUBLIC + LPARAMETERS declarados
    *--------------------------------------------------------------------------
    PROCEDURE TxtCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCgruLostFocus - Valida codigo do grupo ao sair do campo
    *--------------------------------------------------------------------------
    PROCEDURE TxtCgruLostFocus()
        LOCAL loc_oPagina, loc_cCgru, loc_nRet
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCgru   = ALLTRIM(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value)

        IF EMPTY(loc_cCgru)
            loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
            THIS.CarregarLista()
            RETURN
        ENDIF

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
                    "cursor_4c_TmpGrupo")

                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
                    loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_TmpGrupo.dgrus)
                ELSE
                    MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
                    loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
                    loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
                ENDIF

                IF USED("cursor_4c_TmpGrupo")
                    USE IN cursor_4c_TmpGrupo
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao validar grupo")
            ENDTRY
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Abre FormBuscaAuxiliar para SigCdGrp
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrupo", "cgrus", "", ;
                "Buscar Grupo de Produto")

            loc_oBusca.mAddColuna("cgrus", "", "Grupo")
            loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGrupo")
                    loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
                    loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)
                    THIS.CarregarLista()
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptSituasChange - Recarrega lista ao mudar filtro de situacao
    *--------------------------------------------------------------------------
    PROCEDURE OptSituasChange()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis apenas controles nomeados
    * Evita tornar visiveis containers flutuantes (Visible=.F. por design)
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)

        LOCAL loc_i, loc_oCtrl, loc_cNome, loc_lPrefixoValido

        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl          = par_oContainer.Controls(loc_i)
            loc_cNome          = loc_oCtrl.Name
            loc_lPrefixoValido = INLIST(LEFT(loc_cNome, 4), "cnt_", "txt_", "lbl_", "cmd_", "chk_", "cmb_", "grd_", "pgf_")

            IF loc_lPrefixoValido
                *-- Nao forcar Visible=.T. em containers ocultos por design
                IF INLIST(LEFT(loc_cNome, 4), "cnt_", "pgf_") AND !loc_oCtrl.Visible
                    *-- Container oculto por design - pular
                ELSE
                    loc_oCtrl.Visible = .T.
                    IF loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao padrao ao grid de lista
    *--------------------------------------------------------------------------
    PROCEDURE FormatarGridLista(par_oGrid)

        IF VARTYPE(par_oGrid) # "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName           = "Verdana"
            .FontSize           = 8
            .GridLines          = 3
            .GridLineWidth      = 1
            .GridLineColor      = RGB(238, 238, 238)
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .AllowRowSizing     = .F.
            .ReadOnly           = .T.
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(90, 90, 90)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo produto
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao incluir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN .F.
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN .F.
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir produto selecionado
    * Legado: verifica uso em outros registros antes de excluir
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN .F.
        ENDIF

        loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
        loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto:" + CHR(13) + loc_cCodigo + " - " + loc_cDescricao + "?")
            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao excluir produto")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre busca auxiliar de produtos
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")

            loc_oBusca.mAddColuna("cpros", "", "Produto")
            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("cgrus", "", "Grupo")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    LOCAL loc_cCodigo
                    loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        THIS.BOParaForm()
                        THIS.this_cModoAtual = "VISUALIZAR"
                        THIS.HabilitarCampos(.F.)
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar produto
    * Valida campos obrigatorios, transfere Form->BO e chama Salvar()
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg, loc_cCpro, loc_cDpro
        loc_lResultado = .F.

        *-- Validacoes FORA do TRY (VFP9: nunca RETURN dentro de TRY/CATCH)
        IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
            RETURN .F.
        ENDIF
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCpro = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
        loc_cDpro = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)

        IF EMPTY(loc_cCpro)
            MsgAviso("C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Cpro.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_cDpro)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o do produto obrigat" + CHR(243) + "ria!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Dpro.SetFocus()
            RETURN .F.
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Produto salvo com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(1)  && AlternarPagina(1) ja chama CarregarLista()
                loc_lResultado = .T.
            ENDIF
            *-- Erros de validacao: exibidos por ValidarDados() via MsgAviso (form permanece em Dados)
            *-- Erros de BD: exibidos por Inserir/Atualizar via MsgErro (form permanece em Dados)

        CATCH TO loc_oErro
            MsgErro("Erro ao salvar produto:" + CHR(13) + "Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar operacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do Form para o BO (campos pgDados Fase 5)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        WITH THIS.this_oBusinessObject
            .this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
            .this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)
            .this_nSituas   = loc_oPg.obj_4c_Opc_situacao.Value
            .this_cCproeqs  = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
            .this_cDpro2s   = ALLTRIM(loc_oPg.txt_4c_DPro2s.Value)
            .this_nCbars    = ALLTRIM(loc_oPg.txt_4c_Cbar.Value)
            .this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
            .this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Merc.Value)
            .this_cIdecpros = ALLTRIM(loc_oPg.txt_4c_IdeCPros.Value)
            .this_nEan13    = ALLTRIM(loc_oPg.txt_4c_EAN13.Value)
            .this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
            .this_cConjunts = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)
            .this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
            .this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Col.Value)
            .this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
            .this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Refs.Value)
            *-- Fase 6: campos adicionais
            .this_cCodfinp    = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
            .this_cCodacbs    = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
            .this_cCclass     = ALLTRIM(loc_oPg.txt_4c_Class.Value)
            .this_cLocals     = ALLTRIM(loc_oPg.txt_4c_Local.Value)
            .this_nPesobs     = ALLTRIM(loc_oPg.txt_4c_PesoBs.Value)
            .this_nPesoms     = ALLTRIM(loc_oPg.txt_4c_Pmedio.Value)
            .this_cCunis      = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
            .this_cCunips     = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
            .this_cCodident   = ALLTRIM(loc_oPg.txt_4c_CodIdent.Value)
            .this_nTents      = ALLTRIM(loc_oPg.txt_4c_TEnts.Value)
            .this_lConsigs    = (loc_oPg.chk_4c_Consig.Value = 1)
            .this_lFabrproprs = (loc_oPg.chk_4c_FabrProprs.Value = 1)
            .this_lEncoms     = (loc_oPg.chk_4c_Encoms.Value = 1)
            .this_nTamps      = ALLTRIM(loc_oPg.txt_4c_Tamps.Value)
            .this_nTamhs      = ALLTRIM(loc_oPg.txt_4c_Tamhs.Value)
            .this_nTamls      = ALLTRIM(loc_oPg.txt_4c_Tamls.Value)
            .this_nVolumes    = ALLTRIM(loc_oPg.txt_4c_Volumes.Value)
            .this_cDsccompras = loc_oPg.edt_4c_DscCompras.Value
            .this_cDpro3s     = loc_oPg.edt_4c_DPro3s.Value
            .this_cObscompras = loc_oPg.edt_4c_ObsCompras.Value
            .this_nAltura     = ALLTRIM(loc_oPg.txt_4c_Altura.Value)
            .this_nLargura    = ALLTRIM(loc_oPg.txt_4c_Largura.Value)
            .this_nDiametro   = ALLTRIM(loc_oPg.txt_4c_Diametro.Value)
            .this_nEspessura  = ALLTRIM(loc_oPg.txt_4c_Espessura.Value)
            .this_nCompriment = ALLTRIM(loc_oPg.txt_4c_Compriment.Value)
            .this_nQtped      = ALLTRIM(loc_oPg.txt_4c_QtPed.Value)
            .this_nDiasgar    = ALLTRIM(loc_oPg.txt_4c_DiasGar.Value)
            .this_lChkgarvit  = (loc_oPg.chk_4c_GarVit.Value = 1)
        ENDWITH

        *-- Ler campos da aba Fases Producao (PgDadosFaseP - Page4 pgf_4c_Dados)
        THIS.LerCamposFaseP()

        *-- Ler campos da aba Dados Fiscais (pgDadosFiscais - Page3 pgf_4c_Dados)
        THIS.LerCamposFiscais()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para o Form (campos pgDados Fase 5)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        WITH THIS.this_oBusinessObject
            loc_oPg.txt_4c_Cpro.Value              = ALLTRIM(.this_cCpros)
            loc_oPg.txt_4c_Dpro.Value              = ALLTRIM(.this_cDpros)
            loc_oPg.obj_4c_Opc_situacao.Value      = IIF(.this_nSituas = 2, 2, 1)
            loc_oPg.txt_4c_CProEq.Value            = ALLTRIM(.this_cCproeqs)
            loc_oPg.txt_4c_DPro2s.Value            = ALLTRIM(.this_cDpro2s)
            *-- cbars e ean13 sao numericos: converter para string de exibicao
            loc_oPg.txt_4c_Cbar.Value              = IIF(.this_nCbars = 0, "", LTRIM(STR(.this_nCbars, 14, 0)))
            loc_oPg.txt_4c_CgruP.Value             = ALLTRIM(.this_cCgrus)
            loc_oPg.txt_4c_DgruP.Value             = ""
            loc_oPg.txt_4c_Merc.Value              = ALLTRIM(.this_cMercs)
            loc_oPg.txt_4c_IdeCPros.Value          = ALLTRIM(.this_cIdecpros)
            loc_oPg.txt_4c_EAN13.Value             = IIF(.this_nEan13 = 0, "", LTRIM(STR(.this_nEan13, 13, 0)))
            loc_oPg.txt_4c_CSGru.Value             = ALLTRIM(.this_cSgrus)
            loc_oPg.txt_4c_DsGru.Value             = ""
            loc_oPg.txt_4c_Conjunto.Value          = ALLTRIM(.this_cConjunts)
            loc_oPg.txt_4c_Lin.Value               = ALLTRIM(.this_cLinhas)
            loc_oPg.txt_4c_DLin.Value              = ""
            loc_oPg.txt_4c_Col.Value               = ALLTRIM(.this_cColecoes)
            loc_oPg.txt_4c_DCol.Value              = ""
            loc_oPg.txt_4c_Ifor.Value              = ALLTRIM(.this_cIfors)
            loc_oPg.txt_4c_Dfor.Value              = ""
            loc_oPg.txt_4c_Refs.Value              = ALLTRIM(.this_cReffs)
            *-- Fase 6: campos adicionais
            loc_oPg.txt_4c_CodFinP.Value   = ALLTRIM(.this_cCodfinp)
            loc_oPg.txt_4c_DFinP.Value     = ""
            loc_oPg.txt_4c_CodAcb.Value    = ALLTRIM(.this_cCodacbs)
            loc_oPg.txt_4c_DAcb.Value      = ""
            loc_oPg.txt_4c_Class.Value     = ALLTRIM(.this_cCclass)
            loc_oPg.txt_4c_DClass.Value    = ""
            loc_oPg.txt_4c_Local.Value     = ALLTRIM(.this_cLocals)
            loc_oPg.txt_4c_PesoBs.Value    = IIF(.this_nPesobs = 0, "", LTRIM(STR(.this_nPesobs, 10, 3)))
            loc_oPg.txt_4c_Pmedio.Value    = IIF(.this_nPesoms = 0, "", LTRIM(STR(.this_nPesoms, 11, 3)))
            loc_oPg.txt_4c_Estoques.Value  = ""
            loc_oPg.txt_4c_QtdEsts.Value   = ""
            *-- Custo/Venda/Fator (display only - readonly)
            loc_oPg.txt_4c_Ctotal.Value    = IIF(.this_nCustofs = 0, "", LTRIM(STR(.this_nCustofs, 14, 5)))
            loc_oPg.txt_4c_Mctotal.Value   = ALLTRIM(.this_cMoecusfs)
            loc_oPg.txt_4c_Pvenda.Value    = IIF(.this_nPvens = 0, "", LTRIM(STR(.this_nPvens, 14, 5)))
            loc_oPg.txt_4c_Mpvenda.Value   = ALLTRIM(.this_cMoevs)
            loc_oPg.txt_4c_Fvenda.Value    = IIF(.this_nFvendas = 0, "", LTRIM(STR(.this_nFvendas, 9, 3)))
            loc_oPg.txt_4c_Mfvenda.Value   = ALLTRIM(.this_cMoepvs)
            *-- Auditoria (display only - readonly)
            loc_oPg.txt_4c_DtIncs.Value    = IIF(EMPTY(.this_dDtincs), "", DTOC(TTOD(.this_dDtincs)))
            loc_oPg.txt_4c_DataAlts.Value  = IIF(EMPTY(.this_dDtalts), "", DTOC(TTOD(.this_dDtalts)))
            loc_oPg.txt_4c_Usuario.Value   = ALLTRIM(.this_cUsuincs)
            loc_oPg.txt_4c_UsuaAlts.Value  = ALLTRIM(.this_cUsuaalts)
            *-- Ultima compra (display only - readonly)
            loc_oPg.txt_4c_Dtucp.Value      = IIF(EMPTY(.this_dUltcomps), "", DTOC(TTOD(.this_dUltcomps)))
            loc_oPg.txt_4c_Vucp.Value       = IIF(.this_nVultcomps = 0, "", LTRIM(STR(.this_nVultcomps, 11, 2)))
            loc_oPg.txt_4c_Mucp.Value       = ALLTRIM(.this_cMultcomps)
            loc_oPg.txt_4c_QtdUltComp.Value = IIF(.this_nQtdultcomp = 0, "", LTRIM(STR(.this_nQtdultcomp, 12, 0)))
            *-- Unidades
            loc_oPg.txt_4c_Cuni.Value      = ALLTRIM(.this_cCunis)
            loc_oPg.txt_4c_DUni.Value      = ""
            loc_oPg.txt_4c_Cunip.Value     = ALLTRIM(.this_cCunips)
            loc_oPg.txt_4c_DUnip.Value     = ""
            *-- Outros campos
            loc_oPg.txt_4c_CodIdent.Value  = ALLTRIM(.this_cCodident)
            loc_oPg.txt_4c_TEnts.Value     = IIF(.this_nTents = 0, "", LTRIM(STR(.this_nTents, 3, 0)))
            loc_oPg.chk_4c_Consig.Value    = IIF(.this_lConsigs, 1, 0)
            loc_oPg.chk_4c_FabrProprs.Value = IIF(.this_lFabrproprs, 1, 0)
            loc_oPg.chk_4c_Encoms.Value    = IIF(.this_lEncoms, 1, 0)
            loc_oPg.txt_4c_Tamps.Value     = IIF(.this_nTamps = 0, "", LTRIM(STR(.this_nTamps, 6, 2)))
            loc_oPg.txt_4c_Tamhs.Value     = IIF(.this_nTamhs = 0, "", LTRIM(STR(.this_nTamhs, 6, 2)))
            loc_oPg.txt_4c_Tamls.Value     = IIF(.this_nTamls = 0, "", LTRIM(STR(.this_nTamls, 6, 2)))
            loc_oPg.txt_4c_Volumes.Value   = IIF(.this_nVolumes = 0, "", LTRIM(STR(.this_nVolumes, 3, 0)))
            *-- Memos
            loc_oPg.edt_4c_DscCompras.Value = .this_cDsccompras
            loc_oPg.edt_4c_DPro3s.Value    = .this_cDpro3s
            loc_oPg.edt_4c_ObsCompras.Value = .this_cObscompras
            *-- Dimensoes fisicas
            loc_oPg.txt_4c_Altura.Value    = IIF(.this_nAltura = 0, "", LTRIM(STR(.this_nAltura, 8, 4)))
            loc_oPg.txt_4c_Largura.Value   = IIF(.this_nLargura = 0, "", LTRIM(STR(.this_nLargura, 8, 4)))
            loc_oPg.txt_4c_Diametro.Value  = IIF(.this_nDiametro = 0, "", LTRIM(STR(.this_nDiametro, 8, 4)))
            loc_oPg.txt_4c_Espessura.Value = IIF(.this_nEspessura = 0, "", LTRIM(STR(.this_nEspessura, 8, 4)))
            loc_oPg.txt_4c_Compriment.Value = IIF(.this_nCompriment = 0, "", LTRIM(STR(.this_nCompriment, 8, 4)))
            *-- Qt.Pedido / Garantia
            loc_oPg.txt_4c_QtPed.Value     = IIF(.this_nQtped = 0, "", LTRIM(STR(.this_nQtped, 12, 3)))
            loc_oPg.txt_4c_DiasGar.Value   = IIF(.this_nDiasgar = 0, "", LTRIM(STR(.this_nDiasgar, 4, 0)))
            loc_oPg.chk_4c_GarVit.Value    = IIF(.this_lChkgarvit, 1, 0)
        ENDWITH

        *-- Preencher descricoes dos campos de lookup (campos readonly)
        IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            THIS.PreencherDescricoesPgDados()
            THIS.PreencherDescricoesPgDadosP2()
        ENDIF

        *-- Preencher campos da aba Fases Producao (PgDadosFaseP - Page4 pgf_4c_Dados)
        THIS.PreencherCamposFaseP()

        *-- Preencher campos da aba Dados Fiscais (pgDadosFiscais - Page3 pgf_4c_Dados)
        THIS.PreencherCamposFiscais()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario (pgDados Fase 5)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF VARTYPE(loc_oPg.txt_4c_Cpro) # "O"
            RETURN
        ENDIF

        loc_oPg.txt_4c_Cpro.Value              = ""
        loc_oPg.txt_4c_Dpro.Value              = ""
        loc_oPg.obj_4c_Opc_situacao.Value      = 1
        loc_oPg.txt_4c_CProEq.Value            = ""
        loc_oPg.txt_4c_DPro2s.Value            = ""
        loc_oPg.txt_4c_Cbar.Value              = ""
        loc_oPg.txt_4c_CgruP.Value             = ""
        loc_oPg.txt_4c_DgruP.Value             = ""
        loc_oPg.txt_4c_Merc.Value              = ""
        loc_oPg.txt_4c_IdeCPros.Value          = ""
        loc_oPg.txt_4c_EAN13.Value             = ""
        loc_oPg.txt_4c_CSGru.Value             = ""
        loc_oPg.txt_4c_DsGru.Value             = ""
        loc_oPg.txt_4c_Conjunto.Value          = ""
        loc_oPg.txt_4c_Lin.Value               = ""
        loc_oPg.txt_4c_DLin.Value              = ""
        loc_oPg.txt_4c_Col.Value               = ""
        loc_oPg.txt_4c_DCol.Value              = ""
        loc_oPg.txt_4c_Ifor.Value              = ""
        loc_oPg.txt_4c_Dfor.Value              = ""
        loc_oPg.txt_4c_Refs.Value              = ""

        *-- Fase 6
        IF VARTYPE(loc_oPg.txt_4c_CodFinP) # "O"
            RETURN
        ENDIF
        loc_oPg.txt_4c_CodFinP.Value   = ""
        loc_oPg.txt_4c_DFinP.Value     = ""
        loc_oPg.txt_4c_CodAcb.Value    = ""
        loc_oPg.txt_4c_DAcb.Value      = ""
        loc_oPg.txt_4c_Class.Value     = ""
        loc_oPg.txt_4c_DClass.Value    = ""
        loc_oPg.txt_4c_Local.Value     = ""
        loc_oPg.txt_4c_PesoBs.Value    = ""
        loc_oPg.txt_4c_Pmedio.Value    = ""
        loc_oPg.txt_4c_Estoques.Value  = ""
        loc_oPg.txt_4c_QtdEsts.Value   = ""
        loc_oPg.txt_4c_Ctotal.Value    = ""
        loc_oPg.txt_4c_Mctotal.Value   = ""
        loc_oPg.txt_4c_Pvenda.Value    = ""
        loc_oPg.txt_4c_Mpvenda.Value   = ""
        loc_oPg.txt_4c_Fvenda.Value    = ""
        loc_oPg.txt_4c_Mfvenda.Value   = ""
        loc_oPg.txt_4c_DtIncs.Value    = ""
        loc_oPg.txt_4c_DataAlts.Value  = ""
        loc_oPg.txt_4c_Usuario.Value   = ""
        loc_oPg.txt_4c_UsuaAlts.Value  = ""
        loc_oPg.txt_4c_Dtucp.Value     = ""
        loc_oPg.txt_4c_Vucp.Value      = ""
        loc_oPg.txt_4c_Mucp.Value      = ""
        loc_oPg.txt_4c_QtdUltComp.Value = ""
        loc_oPg.txt_4c_Cuni.Value      = ""
        loc_oPg.txt_4c_DUni.Value      = ""
        loc_oPg.txt_4c_Cunip.Value     = ""
        loc_oPg.txt_4c_DUnip.Value     = ""
        loc_oPg.txt_4c_CodIdent.Value  = ""
        loc_oPg.txt_4c_TEnts.Value     = ""
        loc_oPg.chk_4c_Consig.Value    = 0
        loc_oPg.chk_4c_FabrProprs.Value = 0
        loc_oPg.chk_4c_Encoms.Value    = 0
        loc_oPg.txt_4c_Tamps.Value     = ""
        loc_oPg.txt_4c_Tamhs.Value     = ""
        loc_oPg.txt_4c_Tamls.Value     = ""
        loc_oPg.txt_4c_Volumes.Value   = ""
        loc_oPg.edt_4c_DscCompras.Value = ""
        loc_oPg.edt_4c_DPro3s.Value    = ""
        loc_oPg.edt_4c_ObsCompras.Value = ""
        loc_oPg.txt_4c_Altura.Value    = ""
        loc_oPg.txt_4c_Largura.Value   = ""
        loc_oPg.txt_4c_Diametro.Value  = ""
        loc_oPg.txt_4c_Espessura.Value = ""
        loc_oPg.txt_4c_Compriment.Value = ""
        loc_oPg.txt_4c_QtPed.Value     = ""
        loc_oPg.txt_4c_DiasGar.Value   = ""
        loc_oPg.chk_4c_GarVit.Value    = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo (Fase 5)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF VARTYPE(loc_oPg.txt_4c_Cpro) # "O"
            RETURN
        ENDIF

        *-- Codigo do produto: habilitado apenas em INCLUIR (PK nao pode mudar)
        loc_oPg.txt_4c_Cpro.Enabled           = IIF(THIS.this_cModoAtual = "INCLUIR", par_lHabilitar, .F.)
        loc_oPg.txt_4c_Dpro.Enabled           = par_lHabilitar
        loc_oPg.obj_4c_Opc_situacao.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_CProEq.Enabled         = par_lHabilitar
        loc_oPg.txt_4c_DPro2s.Enabled         = par_lHabilitar
        loc_oPg.txt_4c_Cbar.Enabled           = par_lHabilitar
        loc_oPg.txt_4c_CgruP.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_Merc.Enabled           = par_lHabilitar
        loc_oPg.txt_4c_IdeCPros.Enabled       = par_lHabilitar
        loc_oPg.txt_4c_EAN13.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_CSGru.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_Conjunto.Enabled       = par_lHabilitar
        loc_oPg.txt_4c_Lin.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_Col.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_Ifor.Enabled           = par_lHabilitar
        loc_oPg.txt_4c_Refs.Enabled           = par_lHabilitar

        *-- Fase 6 - campos editaveis
        IF VARTYPE(loc_oPg.txt_4c_CodFinP) # "O"
            RETURN
        ENDIF
        loc_oPg.txt_4c_CodFinP.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_CodAcb.Enabled     = par_lHabilitar
        loc_oPg.txt_4c_Class.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_Local.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_PesoBs.Enabled     = par_lHabilitar
        loc_oPg.txt_4c_Pmedio.Enabled     = par_lHabilitar
        loc_oPg.txt_4c_Cuni.Enabled       = par_lHabilitar
        loc_oPg.txt_4c_Cunip.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_CodIdent.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_TEnts.Enabled      = par_lHabilitar
        loc_oPg.chk_4c_Consig.Enabled     = par_lHabilitar
        loc_oPg.chk_4c_FabrProprs.Enabled = par_lHabilitar
        loc_oPg.chk_4c_Encoms.Enabled     = par_lHabilitar
        loc_oPg.txt_4c_Tamps.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_Tamhs.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_Tamls.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_Volumes.Enabled    = par_lHabilitar
        loc_oPg.edt_4c_DscCompras.Enabled = par_lHabilitar
        loc_oPg.edt_4c_DPro3s.Enabled     = par_lHabilitar
        loc_oPg.edt_4c_ObsCompras.Enabled = par_lHabilitar
        loc_oPg.txt_4c_Altura.Enabled     = par_lHabilitar
        loc_oPg.txt_4c_Largura.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Diametro.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_Espessura.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_Compriment.Enabled = par_lHabilitar
        loc_oPg.txt_4c_QtPed.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_DiasGar.Enabled    = par_lHabilitar
        loc_oPg.chk_4c_GarVit.Enabled     = par_lHabilitar
    ENDPROC

    *==========================================================================
    * FASE 5 - Configuracao da Aba Dados (pgDados = Page1 de pgf_4c_Dados)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPgDados - Configura campos da aba Dados (primeiros 50%)
    * Legado: pgDados controles T:130-T:298 (sem compensacao adicional)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Linha 1 (T:130-134): Produto / Descricao / Situacao
        *-- Label2: "Produto :" (T:134 L:58 W:53 FontBold)
        loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
        WITH loc_oPg.lbl_4c_LblProduto
            .Caption   = "Produto :"
            .Top       = 134
            .Left      = 58
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCpro -> txt_4c_Cpro (T:130 L:113 W:108 H:23) - PK do produto
        loc_oPg.AddObject("txt_4c_Cpro", "TextBox")
        WITH loc_oPg.txt_4c_Cpro
            .Top           = 130
            .Left          = 113
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 14
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- getDpro -> txt_4c_Dpro (T:130 L:222 W:290 H:23) - descricao
        loc_oPg.AddObject("txt_4c_Dpro", "TextBox")
        WITH loc_oPg.txt_4c_Dpro
            .Top           = 130
            .Left          = 222
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 65
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- opc_situacao -> obj_4c_Opc_situacao (T:130 L:735 W:142 H:25)
        *-- Value=1 Ativo, Value=2 Inativo (situas numeric no banco)
        loc_oPg.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH loc_oPg.obj_4c_Opc_situacao
            .Top         = 130
            .Left        = 735
            .Width       = 142
            .Height      = 25
            .ButtonCount = 2
            .Value       = 1
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_Opc_situacao
            .Buttons(1).Caption   = "Ativo"
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 5
            .Buttons(1).Height    = 15
            .Buttons(1).FontName  = "Tahoma"
            .Buttons(1).FontSize  = 8
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).BackStyle = 0
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).Themes    = .F.

            .Buttons(2).Caption   = "Inativo - Ap" + CHR(243) + "s :"
            .Buttons(2).Left      = 50
            .Buttons(2).Top       = 5
            .Buttons(2).Height    = 15
            .Buttons(2).FontName  = "Tahoma"
            .Buttons(2).FontSize  = 8
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).BackStyle = 0
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).Themes    = .F.
        ENDWITH

        *-- Linha 2 (T:133-158): Equivalente / Descritivo / Barra
        *-- Say2: "Equivalente :" (T:137 L:560 W:65)
        loc_oPg.AddObject("lbl_4c_LblEquivalente", "Label")
        WITH loc_oPg.lbl_4c_LblEquivalente
            .Caption   = "Equivalente :"
            .Top       = 137
            .Left      = 560
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_CProEq -> txt_4c_CProEq (T:133 L:626 W:108 H:21)
        loc_oPg.AddObject("txt_4c_CProEq", "TextBox")
        WITH loc_oPg.txt_4c_CProEq
            .Top           = 133
            .Left          = 626
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 14
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CProEq, "KeyPress",  THIS, "TxtCProEqKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CProEq, "LostFocus", THIS, "TxtCProEqLostFocus")

        *-- Say10: "Descritivo :" (T:158 L:55 W:56)
        loc_oPg.AddObject("lbl_4c_LblDPro2", "Label")
        WITH loc_oPg.lbl_4c_LblDPro2
            .Caption   = "Descritivo :"
            .Top       = 158
            .Left      = 55
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getDPro2s -> txt_4c_DPro2s (T:154 L:113 W:399 H:23) - 2a descricao
        loc_oPg.AddObject("txt_4c_DPro2s", "TextBox")
        WITH loc_oPg.txt_4c_DPro2s
            .Top           = 154
            .Left          = 113
            .Width         = 399
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 45
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say15: "Barra :" (T:157 L:590 W:35)
        loc_oPg.AddObject("lbl_4c_LblBarra", "Label")
        WITH loc_oPg.lbl_4c_LblBarra
            .Caption   = "Barra :"
            .Top       = 157
            .Left      = 590
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCbar -> txt_4c_Cbar (T:155 L:626 W:108 H:21) - cbars numeric(14,0)
        loc_oPg.AddObject("txt_4c_Cbar", "TextBox")
        WITH loc_oPg.txt_4c_Cbar
            .Top           = 155
            .Left          = 626
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 14
            .InputMask     = "99999999999999"
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        *-- Linha 3 (T:177-182): Grupo / Mercadoria / Identificador / EAN13
        *-- Say8: "Grupo :" (T:182 L:73 W:38)
        loc_oPg.AddObject("lbl_4c_LblGrupoP", "Label")
        WITH loc_oPg.lbl_4c_LblGrupoP
            .Caption   = "Grupo :"
            .Top       = 18
            .Left      = 21
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCgru -> txt_4c_CgruP (T:178 L:113 W:31 H:23) - codigo do grupo
        loc_oPg.AddObject("txt_4c_CgruP", "TextBox")
        WITH loc_oPg.txt_4c_CgruP
            .Top           = 178
            .Left          = 113
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CgruP, "KeyPress",  THIS, "TxtCgruPKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CgruP, "LostFocus", THIS, "TxtCgruPLostFocus")

        *-- getDgru -> txt_4c_DgruP (T:178 L:145 W:171 H:23) - desc grupo (readonly)
        loc_oPg.AddObject("txt_4c_DgruP", "TextBox")
        WITH loc_oPg.txt_4c_DgruP
            .Top           = 178
            .Left          = 145
            .Width         = 171
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- getMerc -> txt_4c_Merc (T:178 L:318 W:31 H:23) - mercadoria
        loc_oPg.AddObject("txt_4c_Merc", "TextBox")
        WITH loc_oPg.txt_4c_Merc
            .Top           = 178
            .Left          = 318
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .BackColor     = RGB(231, 242, 254)
            .Visible       = .T.
        ENDWITH

        *-- Say23: "Identificador :" (T:182 L:408 W:70)
        loc_oPg.AddObject("lbl_4c_LblIdeCPros", "Label")
        WITH loc_oPg.lbl_4c_LblIdeCPros
            .Caption   = "Identificador :"
            .Top       = 182
            .Left      = 408
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getIdeCPros -> txt_4c_IdeCPros (T:178 L:481 W:31 H:23)
        loc_oPg.AddObject("txt_4c_IdeCPros", "TextBox")
        WITH loc_oPg.txt_4c_IdeCPros
            .Top           = 178
            .Left          = 481
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say1: "EAN/GTIN :" (T:181 L:568 W:57)
        loc_oPg.AddObject("lbl_4c_LblEAN13", "Label")
        WITH loc_oPg.lbl_4c_LblEAN13
            .Caption   = "EAN/GTIN :"
            .Top       = 181
            .Left      = 568
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getEAN13 -> txt_4c_EAN13 (T:177 L:626 W:108 H:21) - ean13 numeric(13,0)
        loc_oPg.AddObject("txt_4c_EAN13", "TextBox")
        WITH loc_oPg.txt_4c_EAN13
            .Top           = 177
            .Left          = 626
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 13
            .InputMask     = "9999999999999"
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        *-- Linha 4 (T:202-206): SubGrupo / Conjunto
        *-- Say9: "Subgrupo :" (T:206 L:56 W:55)
        loc_oPg.AddObject("lbl_4c_LblSubGrupo", "Label")
        WITH loc_oPg.lbl_4c_LblSubGrupo
            .Caption   = "Subgrupo :"
            .Top       = 206
            .Left      = 56
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetCSGru -> txt_4c_CSGru (T:202 L:113 W:52 H:23) - codigo subgrupo
        loc_oPg.AddObject("txt_4c_CSGru", "TextBox")
        WITH loc_oPg.txt_4c_CSGru
            .Top           = 202
            .Left          = 113
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CSGru, "KeyPress",  THIS, "TxtCSGruKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CSGru, "LostFocus", THIS, "TxtCSGruLostFocus")

        *-- GetDsGru -> txt_4c_DsGru (T:202 L:166 W:150 H:23) - desc subgrupo (readonly)
        loc_oPg.AddObject("txt_4c_DsGru", "TextBox")
        WITH loc_oPg.txt_4c_DsGru
            .Top           = 202
            .Left          = 166
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say37: "Conjunto :" (T:206 L:408 W:53)
        loc_oPg.AddObject("lbl_4c_LblConjunto", "Label")
        WITH loc_oPg.lbl_4c_LblConjunto
            .Caption   = "Conjunto :"
            .Top       = 206
            .Left      = 408
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getConjunto -> txt_4c_Conjunto (T:202 L:460 W:52 H:23)
        loc_oPg.AddObject("txt_4c_Conjunto", "TextBox")
        WITH loc_oPg.txt_4c_Conjunto
            .Top           = 202
            .Left          = 460
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Conjunto, "KeyPress",  THIS, "TxtConjuntoKeyPress")

        *-- Linha 5 (T:226-230): Linha
        *-- Say16: "Linha :" (T:230 L:77 W:34)
        loc_oPg.AddObject("lbl_4c_LblLinha", "Label")
        WITH loc_oPg.lbl_4c_LblLinha
            .Caption   = "Linha :"
            .Top       = 230
            .Left      = 77
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetLin -> txt_4c_Lin (T:226 L:113 W:80 H:23) - codigo de linha
        loc_oPg.AddObject("txt_4c_Lin", "TextBox")
        WITH loc_oPg.txt_4c_Lin
            .Top           = 226
            .Left          = 113
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Lin, "KeyPress",  THIS, "TxtLinKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Lin, "LostFocus", THIS, "TxtLinLostFocus")

        *-- GetDLin -> txt_4c_DLin (T:226 L:194 W:318 H:23) - desc linha (readonly)
        loc_oPg.AddObject("txt_4c_DLin", "TextBox")
        WITH loc_oPg.txt_4c_DLin
            .Top           = 226
            .Left          = 194
            .Width         = 318
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Linha 6 (T:250-253): Grupo de Venda (Colecoes)
        *-- Say17: "Grupo de Venda :" (T:253 L:25 W:86)
        loc_oPg.AddObject("lbl_4c_LblGVenda", "Label")
        WITH loc_oPg.lbl_4c_LblGVenda
            .Caption   = "Grupo de Venda :"
            .Top       = 253
            .Left      = 25
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetCol -> txt_4c_Col (T:250 L:113 W:80 H:23) - colecoes (grupo venda)
        loc_oPg.AddObject("txt_4c_Col", "TextBox")
        WITH loc_oPg.txt_4c_Col
            .Top           = 250
            .Left          = 113
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Col, "KeyPress",  THIS, "TxtColKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Col, "LostFocus", THIS, "TxtColLostFocus")

        *-- GetDCol -> txt_4c_DCol (T:250 L:194 W:318 H:23) - desc grupo venda (readonly)
        loc_oPg.AddObject("txt_4c_DCol", "TextBox")
        WITH loc_oPg.txt_4c_DCol
            .Top           = 250
            .Left          = 194
            .Width         = 318
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Linha 7 (T:274-278): Fornecedor
        *-- Say11: "Fornecedor :" (T:278 L:47 W:64)
        loc_oPg.AddObject("lbl_4c_LblFornecedor", "Label")
        WITH loc_oPg.lbl_4c_LblFornecedor
            .Caption   = "Fornecedor :"
            .Top       = 278
            .Left      = 47
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getIfor -> txt_4c_Ifor (T:274 L:113 W:80 H:23) - codigo fornecedor
        loc_oPg.AddObject("txt_4c_Ifor", "TextBox")
        WITH loc_oPg.txt_4c_Ifor
            .Top           = 274
            .Left          = 113
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Ifor, "KeyPress",  THIS, "TxtIforKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Ifor, "LostFocus", THIS, "TxtIforLostFocus")

        *-- getDfor -> txt_4c_Dfor (T:274 L:194 W:318 H:23) - desc fornecedor (readonly)
        loc_oPg.AddObject("txt_4c_Dfor", "TextBox")
        WITH loc_oPg.txt_4c_Dfor
            .Top           = 274
            .Left          = 194
            .Width         = 318
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Linha 8 (T:298-301): Ref. Fornecedor
        *-- Say12: "Ref. Fornecedor :" (T:301 L:23 W:88)
        loc_oPg.AddObject("lbl_4c_LblRefs", "Label")
        WITH loc_oPg.lbl_4c_LblRefs
            .Caption   = "Ref. Fornecedor :"
            .Top       = 301
            .Left      = 23
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getRefs -> txt_4c_Refs (T:298 L:113 W:152 H:23) - referencia fornecedor
        loc_oPg.AddObject("txt_4c_Refs", "TextBox")
        WITH loc_oPg.txt_4c_Refs
            .Top           = 298
            .Left          = 113
            .Width         = 152
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 40
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Fase 6: demais campos da aba Dados
        THIS.ConfigurarPgDadosP2()
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherDescricoesPgDados - Busca descricoes dos campos lookup (readonly)
    * Chamado por BOParaForm apos preencher codigos
    *--------------------------------------------------------------------------
    PROCEDURE PreencherDescricoesPgDados()
        LOCAL loc_oPg, loc_cCod, loc_nRet
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            *-- Descricao do Grupo (cgrus -> SigCdGrp.dgrus)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDgru")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpDgru") > 0
                    loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpDgru.dgrus)
                ENDIF
                IF USED("cursor_4c_TmpDgru")
                    USE IN cursor_4c_TmpDgru
                ENDIF
            ENDIF

            *-- Descricao do SubGrupo (sgrus -> SigCdPsg.descricaos, filtrado por cgrus)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cCod) + ;
                    " AND cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CgruP.Value)), ;
                    "cursor_4c_TmpSGru")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
                    loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
                ENDIF
                IF USED("cursor_4c_TmpSGru")
                    USE IN cursor_4c_TmpSGru
                ENDIF
            ENDIF

            *-- Descricao da Linha (linhas -> SigCdLin.descs)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpLin")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
                    loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
                ENDIF
                IF USED("cursor_4c_TmpLin")
                    USE IN cursor_4c_TmpLin
                ENDIF
            ENDIF

            *-- Descricao do Grupo de Venda (colecoes -> SIGCDCOL.descs)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Col.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpCol")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
                    loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
                ENDIF
                IF USED("cursor_4c_TmpCol")
                    USE IN cursor_4c_TmpCol
                ENDIF
            ENDIF

            *-- Descricao do Fornecedor (ifors -> SigCdCli.rclis)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpIfor")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
                    loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
                ENDIF
                IF USED("cursor_4c_TmpIfor")
                    USE IN cursor_4c_TmpIfor
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 5)
    * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
    *==========================================================================

    *--------------------------------------------------------------------------
    * TxtCgruP - F4 abre lookup de grupos; LostFocus valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TxtCgruPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupGrupoP2()
        ENDIF
    ENDPROC

    PROCEDURE TxtCgruPLostFocus()
        LOCAL loc_oPg, loc_cCgru, loc_nRet
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)

        IF EMPTY(loc_cCgru)
            loc_oPg.txt_4c_DgruP.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
                "cursor_4c_TmpGruP")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGruP") > 0
                loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpGruP.dgrus)
                *-- Limpar subgrupo ao trocar grupo
                loc_oPg.txt_4c_CSGru.Value = ""
                loc_oPg.txt_4c_DsGru.Value = ""
            ELSE
                MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_CgruP.Value = ""
                loc_oPg.txt_4c_DgruP.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpGruP")
                USE IN cursor_4c_TmpGruP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar grupo")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupGrupoP2()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGruP", "cgrus", loc_cAtual, ;
                "Buscar Grupo de Produto")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGruP")
                        loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
                        loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
                        loc_oPg.txt_4c_CSGru.Value = ""
                        loc_oPg.txt_4c_DsGru.Value = ""
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cgrus", "", "Grupo")
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruP")
                        loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
                        loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
                        loc_oPg.txt_4c_CSGru.Value = ""
                        loc_oPg.txt_4c_DsGru.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaGruP")
                USE IN cursor_4c_BuscaGruP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCSGru - F4 abre lookup de subgrupos filtrados por cgrus; LostFocus valida
    *--------------------------------------------------------------------------
    PROCEDURE TxtCSGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupSubGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TxtCSGruLostFocus()
        LOCAL loc_oPg, loc_cSGru, loc_cCgru, loc_nRet
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cSGru = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
        loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)

        IF EMPTY(loc_cSGru)
            loc_oPg.txt_4c_DsGru.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cSGru) + ;
                IIF(EMPTY(loc_cCgru), "", " AND cgrus = " + EscaparSQL(loc_cCgru)), ;
                "cursor_4c_TmpSGru")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
                loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
            ELSE
                MsgAviso("Subgrupo '" + loc_cSGru + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_CSGru.Value = ""
                loc_oPg.txt_4c_DsGru.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpSGru")
                USE IN cursor_4c_TmpSGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupSubGrupo()
        LOCAL loc_oBusca, loc_oPg, loc_cCgru, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", "cursor_4c_BuscaSGru", "codigos", loc_cAtual, ;
                "Buscar Subgrupo", .F., .T., ;
                IIF(EMPTY(loc_cCgru), "", "cgrus = " + EscaparSQL(loc_cCgru)))
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaSGru")
                        loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
                        loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
                        loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
                        loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaSGru")
                USE IN cursor_4c_BuscaSGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLin - F4 abre lookup de linhas; LostFocus valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupLinha()
        ENDIF
    ENDPROC

    PROCEDURE TxtLinLostFocus()
        LOCAL loc_oPg, loc_cLin, loc_nRet
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cLin = ALLTRIM(loc_oPg.txt_4c_Lin.Value)

        IF EMPTY(loc_cLin)
            loc_oPg.txt_4c_DLin.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLin), ;
                "cursor_4c_TmpLin")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
                loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
            ELSE
                MsgAviso("Linha '" + loc_cLin + "' n" + CHR(227) + "o encontrada!")
                loc_oPg.txt_4c_Lin.Value  = ""
                loc_oPg.txt_4c_DLin.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpLin")
                USE IN cursor_4c_TmpLin
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar linha")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupLinha()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Lin.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_BuscaLin", "linhas", loc_cAtual, ;
                "Buscar Linha")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaLin")
                        loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
                        loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("linhas", "", "Linha")
                    loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
                        loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
                        loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaLin")
                USE IN cursor_4c_BuscaLin
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar linha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCol - F4 abre lookup de grupos de venda (SIGCDCOL); LostFocus valida
    *--------------------------------------------------------------------------
    PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupGVenda()
        ENDIF
    ENDPROC

    PROCEDURE TxtColLostFocus()
        LOCAL loc_oPg, loc_cCol, loc_nRet
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCol = ALLTRIM(loc_oPg.txt_4c_Col.Value)

        IF EMPTY(loc_cCol)
            loc_oPg.txt_4c_DCol.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCol), ;
                "cursor_4c_TmpCol")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
                loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
            ELSE
                MsgAviso("Grupo de Venda '" + loc_cCol + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_Col.Value  = ""
                loc_oPg.txt_4c_DCol.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpCol")
                USE IN cursor_4c_TmpCol
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupGVenda()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Col.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDCOL", "cursor_4c_BuscaCol", "colecoes", loc_cAtual, ;
                "Buscar Grupo de Venda")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaCol")
                        loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
                        loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
                        loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
                        loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo de venda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtIfor - F4 abre lookup de fornecedores (SigCdCli); LostFocus valida
    *--------------------------------------------------------------------------
    PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupFornecedor()
        ENDIF
    ENDPROC

    PROCEDURE TxtIforLostFocus()
        LOCAL loc_oPg, loc_cIfor, loc_nRet
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cIfor = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)

        IF EMPTY(loc_cIfor)
            loc_oPg.txt_4c_Dfor.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cIfor), ;
                "cursor_4c_TmpIfor")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
                loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
            ELSE
                MsgAviso("Fornecedor '" + loc_cIfor + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_Ifor.Value = ""
                loc_oPg.txt_4c_Dfor.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpIfor")
                USE IN cursor_4c_TmpIfor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupFornecedor()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaIfor", "iclis", loc_cAtual, ;
                "Buscar Fornecedor")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaIfor")
                        loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
                        loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome/Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
                        loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
                        loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaIfor")
                USE IN cursor_4c_BuscaIfor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCProEq - F4 abre lookup de produto equivalente; LostFocus valida
    *--------------------------------------------------------------------------
    PROCEDURE TxtCProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupProdEq()
        ENDIF
    ENDPROC

    PROCEDURE TxtCProEqLostFocus()
        LOCAL loc_oPg, loc_cCpro, loc_nRet
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCpro = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)

        IF EMPTY(loc_cCpro)
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpro), ;
                "cursor_4c_TmpProEq")
            IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpProEq") = 0
                MsgAviso("Produto equivalente '" + loc_cCpro + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_CProEq.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpProEq")
                USE IN cursor_4c_TmpProEq
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar produto equivalente")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupProdEq()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProEq", "cpros", loc_cAtual, ;
                "Buscar Produto Equivalente")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaProEq")
                        loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "Produto")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProEq")
                        loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaProEq")
                USE IN cursor_4c_BuscaProEq
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto equivalente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtConjunto - F4 abre lookup de conjuntos (valores distintos de SigCdPro)
    *--------------------------------------------------------------------------
    PROCEDURE TxtConjuntoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupConjunto()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupConjunto()
        LOCAL loc_oBusca, loc_oPg, loc_nRet
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            *-- Busca conjuntos distintos ja cadastrados em SigCdPro
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT DISTINCT conjunts FROM SigCdPro WHERE LTRIM(RTRIM(conjunts)) <> '' ORDER BY conjunts", ;
                "cursor_4c_BuscaCnj")

            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaCnj") > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
                    loc_oBusca.this_cTitulo        = "Buscar Conjunto"
                    loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
                        loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaCnj")
                USE IN cursor_4c_BuscaCnj
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conjunto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FASE 6 - Configuracao da Aba Dados (pgDados - campos restantes)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPgDadosP2 - Configura campos restantes da aba Dados
    * Cobre: Qt.Pedido, Garantia, Dimensoes fisicas, Ultima Compra,
    *        Modelo, Acabamento, Classif., Local, Custos, Unidades,
    *        Auditoria, CodIdent, Checkboxes, Memos, Dimensoes embalagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgDadosP2()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *----------------------------------------------------------------------
        *-- CheckBox fwoption1: "Peso Variavel" (T:172 L:879 W:90 H:15)
        *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados - prodvars
        *----------------------------------------------------------------------
        loc_oPg.AddObject("chk_4c_Fwoption1", "CheckBox")
        WITH loc_oPg.chk_4c_Fwoption1
            .Caption   = "Peso Vari" + CHR(225) + "vel"
            .Top       = 172
            .Left      = 879
            .Width     = 90
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Qt. Pedido (T:221 L:626) + Garantia (T:224 L:880)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblQtPed", "Label")
        WITH loc_oPg.lbl_4c_LblQtPed
            .Caption   = "Qt. Pedido :"
            .Top       = 224
            .Left      = 541
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_QtPed", "TextBox")
        WITH loc_oPg.txt_4c_QtPed
            .Top           = 221
            .Left          = 626
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblGarantia", "Label")
        WITH loc_oPg.lbl_4c_LblGarantia
            .Caption   = "Gar.(dias):"
            .Top       = 227
            .Left      = 820
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DiasGar", "TextBox")
        WITH loc_oPg.txt_4c_DiasGar
            .Top           = 224
            .Left          = 880
            .Width         = 34
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 4
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_GarVit", "CheckBox")
        WITH loc_oPg.chk_4c_GarVit
            .Top       = 228
            .Left      = 943
            .Width     = 60
            .Height    = 17
            .Caption   = "Vital" + CHR(237) + "cia"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Dimensoes fisicas (L:923): Altura/Largura/Diametro/Espessura/Comprimento
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblAltura", "Label")
        WITH loc_oPg.lbl_4c_LblAltura
            .Caption   = "Altura :"
            .Top       = 474
            .Left      = 749
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Altura", "TextBox")
        WITH loc_oPg.txt_4c_Altura
            .Top           = 247
            .Left          = 923
            .Width         = 48
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_MMAltura", "Label")
        WITH loc_oPg.lbl_4c_MMAltura
            .Caption   = "MM"
            .Top       = 250
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblLargura", "Label")
        WITH loc_oPg.lbl_4c_LblLargura
            .Caption   = "Largura :"
            .Top       = 272
            .Left      = 857
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Largura", "TextBox")
        WITH loc_oPg.txt_4c_Largura
            .Top           = 269
            .Left          = 923
            .Width         = 48
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_MMLargura", "Label")
        WITH loc_oPg.lbl_4c_MMLargura
            .Caption   = "MM"
            .Top       = 272
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say49: "Diametro :" (T:293 L:867 W:52)
        loc_oPg.AddObject("lbl_4c_LblDiametro", "Label")
        WITH loc_oPg.lbl_4c_LblDiametro
            .Caption   = "Di" + CHR(226) + "metro :"
            .Top       = 293
            .Left      = 867
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Diametro", "TextBox")
        WITH loc_oPg.txt_4c_Diametro
            .Top           = 291
            .Left          = 923
            .Width         = 48
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_MMDiametro", "Label")
        WITH loc_oPg.lbl_4c_MMDiametro
            .Caption   = "MM"
            .Top       = 294
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say50: "Espessura :" (T:316 L:861 W:58)
        loc_oPg.AddObject("lbl_4c_LblEspessura", "Label")
        WITH loc_oPg.lbl_4c_LblEspessura
            .Caption   = "Espessura :"
            .Top       = 316
            .Left      = 861
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Espessura", "TextBox")
        WITH loc_oPg.txt_4c_Espessura
            .Top           = 313
            .Left          = 923
            .Width         = 48
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_MMEspessura", "Label")
        WITH loc_oPg.lbl_4c_MMEspessura
            .Caption   = "MM"
            .Top       = 317
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say51: "Comprimento :" (T:339 L:847 W:72)
        loc_oPg.AddObject("lbl_4c_LblCompriment", "Label")
        WITH loc_oPg.lbl_4c_LblCompriment
            .Caption   = "Comprimento :"
            .Top       = 339
            .Left      = 847
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Compriment", "TextBox")
        WITH loc_oPg.txt_4c_Compriment
            .Top           = 335
            .Left          = 923
            .Width         = 48
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_CMCompriment", "Label")
        WITH loc_oPg.lbl_4c_CMCompriment
            .Caption   = "CM"
            .Top       = 340
            .Left      = 976
            .Width     = 17
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Ultima Compra (T:309-331) - Say19: "Ult.Compra :" (T:313 L:562)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblUltCompra", "Label")
        WITH loc_oPg.lbl_4c_LblUltCompra
            .Caption   = CHR(218) + "lt.Compra :"
            .Top       = 313
            .Left      = 562
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_Dtucp -> txt_4c_Dtucp (T:309 L:626 W:79 H:21) - readonly
        loc_oPg.AddObject("txt_4c_Dtucp", "TextBox")
        WITH loc_oPg.txt_4c_Dtucp
            .Top           = 309
            .Left          = 626
            .Width         = 79
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- Get_vucp -> txt_4c_Vucp (T:309 L:706 W:106 H:21) - readonly
        loc_oPg.AddObject("txt_4c_Vucp", "TextBox")
        WITH loc_oPg.txt_4c_Vucp
            .Top           = 309
            .Left          = 706
            .Width         = 106
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- Get_mucp -> txt_4c_Mucp (T:309 L:813 W:33 H:21) - readonly
        loc_oPg.AddObject("txt_4c_Mucp", "TextBox")
        WITH loc_oPg.txt_4c_Mucp
            .Top           = 309
            .Left          = 813
            .Width         = 33
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- Say45: "Qtde Ult.Compra :" (T:335 L:535 W:90)
        loc_oPg.AddObject("lbl_4c_LblQtdUltC", "Label")
        WITH loc_oPg.lbl_4c_LblQtdUltC
            .Caption   = "Qtde " + CHR(218) + "lt.Compra :"
            .Top       = 335
            .Left      = 535
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_qtdultcomp -> txt_4c_QtdUltComp (T:331 L:626 W:79 H:21) - readonly
        loc_oPg.AddObject("txt_4c_QtdUltComp", "TextBox")
        WITH loc_oPg.txt_4c_QtdUltComp
            .Top           = 331
            .Left          = 626
            .Width         = 79
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Modelo (T:322) - lblModelo: "Modelo :" (T:326 L:7 W:104)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblModelo", "Label")
        WITH loc_oPg.lbl_4c_LblModelo
            .Caption   = "Modelo :"
            .Top       = 326
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCodFinP -> txt_4c_CodFinP (T:322 L:113 W:31 H:23) - codfinp char(3)
        loc_oPg.AddObject("txt_4c_CodFinP", "TextBox")
        WITH loc_oPg.txt_4c_CodFinP
            .Top           = 322
            .Left          = 113
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- getDesFinP -> txt_4c_DFinP (T:322 L:145 W:150 H:23) - desc modelo (readonly)
        loc_oPg.AddObject("txt_4c_DFinP", "TextBox")
        WITH loc_oPg.txt_4c_DFinP
            .Top           = 322
            .Left          = 145
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodFinP, "KeyPress",  THIS, "TxtCodFinPKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CodFinP, "LostFocus", THIS, "TxtCodFinPLostFocus")

        *-- Say35: "Peso Bruto :" (T:326 L:336 W:61)
        loc_oPg.AddObject("lbl_4c_LblPesoBs", "Label")
        WITH loc_oPg.lbl_4c_LblPesoBs
            .Caption   = "Peso Bruto :"
            .Top       = 326
            .Left      = 336
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getPesoBs -> txt_4c_PesoBs (T:322 L:401 W:111 H:23) - pesobs numeric(7,3)
        loc_oPg.AddObject("txt_4c_PesoBs", "TextBox")
        WITH loc_oPg.txt_4c_PesoBs
            .Top           = 322
            .Left          = 401
            .Width         = 111
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Acabamento (T:346) - lblAcabamento: "Acabamento :" (T:350 L:7)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
        WITH loc_oPg.lbl_4c_LblAcabamento
            .Caption   = "Acabamento :"
            .Top       = 350
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_codacb -> txt_4c_CodAcb (T:346 L:113 W:31 H:23) - codacbs char(3)
        loc_oPg.AddObject("txt_4c_CodAcb", "TextBox")
        WITH loc_oPg.txt_4c_CodAcb
            .Top           = 346
            .Left          = 113
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- get_Dacb -> txt_4c_DAcb (T:346 L:145 W:150 H:23) - desc acabamento (readonly)
        loc_oPg.AddObject("txt_4c_DAcb", "TextBox")
        WITH loc_oPg.txt_4c_DAcb
            .Top           = 346
            .Left          = 145
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodAcb, "KeyPress",  THIS, "TxtCodAcbKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "TxtCodAcbLostFocus")

        *-- Say34: "Peso Liquido :" (T:350 L:329 W:68)
        loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
        WITH loc_oPg.lbl_4c_LblPmedio
            .Caption   = "Peso L" + CHR(237) + "quido :"
            .Top       = 350
            .Left      = 329
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getPmedio -> txt_4c_Pmedio (T:346 L:401 W:111 H:23) - pesoms numeric(8,3)
        loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
        WITH loc_oPg.txt_4c_Pmedio
            .Top           = 346
            .Left          = 401
            .Width         = 111
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Estoque (T:353) - Say28: "Estoque :" (T:357 L:577 W:48)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
        WITH loc_oPg.lbl_4c_LblEstoque
            .Caption   = "Estoque :"
            .Top       = 357
            .Left      = 577
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getEstoques -> txt_4c_Estoques (T:353 L:626 W:79 H:21) - display only
        loc_oPg.AddObject("txt_4c_Estoques", "TextBox")
        WITH loc_oPg.txt_4c_Estoques
            .Top           = 353
            .Left          = 626
            .Width         = 79
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- getQtdEsts -> txt_4c_QtdEsts (T:353 L:706 W:79 H:21) - display only
        loc_oPg.AddObject("txt_4c_QtdEsts", "TextBox")
        WITH loc_oPg.txt_4c_QtdEsts
            .Top           = 353
            .Left          = 706
            .Width         = 79
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Classificacao e Local (T:370) - lblClassificacao (T:374 L:7)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblClass", "Label")
        WITH loc_oPg.lbl_4c_LblClass
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Top       = 374
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Class -> txt_4c_Class (T:370 L:113 W:31 H:23) - cclass char(3)
        loc_oPg.AddObject("txt_4c_Class", "TextBox")
        WITH loc_oPg.txt_4c_Class
            .Top           = 370
            .Left          = 113
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Get_DClass -> txt_4c_DClass (T:370 L:145 W:150 H:23) - desc class (readonly)
        loc_oPg.AddObject("txt_4c_DClass", "TextBox")
        WITH loc_oPg.txt_4c_DClass
            .Top           = 370
            .Left          = 145
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Class, "KeyPress",  THIS, "TxtClassKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Class, "LostFocus", THIS, "TxtClassLostFocus")

        *-- Say5: "Local :" (T:374 L:364 W:33)
        loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
        WITH loc_oPg.lbl_4c_LblLocal
            .Caption   = "Local :"
            .Top       = 374
            .Left      = 364
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Local -> txt_4c_Local (T:370 L:401 W:111 H:23) - locals char(10)
        loc_oPg.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPg.txt_4c_Local
            .Top           = 370
            .Left          = 401
            .Width         = 111
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Local, "KeyPress",  THIS, "TxtLocalKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Local, "LostFocus", THIS, "TxtLocalLostFocus")

        *----------------------------------------------------------------------
        *-- Custo (T:375) - Say3: "Valor de Custo :" (T:379 L:546 W:79)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblCusto", "Label")
        WITH loc_oPg.lbl_4c_LblCusto
            .Caption   = "Valor de Custo :"
            .Top       = 379
            .Left      = 546
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCtotal -> txt_4c_Ctotal (T:375 L:626 W:127 H:21) - custofs (display)
        loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
        WITH loc_oPg.txt_4c_Ctotal
            .Top           = 375
            .Left          = 626
            .Width         = 127
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .MaxLength     = 14
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- getMctotal -> txt_4c_Mctotal (T:375 L:754 W:31 H:21) - moecusfs (display)
        loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
        WITH loc_oPg.txt_4c_Mctotal
            .Top           = 375
            .Left          = 754
            .Width         = 31
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Auditoria - cabecalho (T:365-384)
        *-- Say20: "Data / Usuario" (T:365 L:833) header
        *-- Say24: "Inclusao" (T:384 L:833) / Say25: "Alteracao" (T:384 L:914)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblAuditoria", "Label")
        WITH loc_oPg.lbl_4c_LblAuditoria
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 365
            .Left      = 833
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblInclusao", "Label")
        WITH loc_oPg.lbl_4c_LblInclusao
            .Caption   = "Inclus" + CHR(227) + "o"
            .Top       = 384
            .Left      = 833
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblAlteracao", "Label")
        WITH loc_oPg.lbl_4c_LblAlteracao
            .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
            .Top       = 384
            .Left      = 914
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Unidades (T:394) - Say14: "Unidades (1) :" (T:398 L:41 W:70)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblUnidades", "Label")
        WITH loc_oPg.lbl_4c_LblUnidades
            .Caption   = "Unidades (1) :"
            .Top       = 398
            .Left      = 41
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Cuni -> txt_4c_Cuni (T:394 L:113 W:31 H:23) - cunis char(3)
        loc_oPg.AddObject("txt_4c_Cuni", "TextBox")
        WITH loc_oPg.txt_4c_Cuni
            .Top           = 394
            .Left          = 113
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cuni, "KeyPress",  THIS, "TxtCuniKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Cuni, "LostFocus", THIS, "TxtCuniLostFocus")

        *-- Get_Duni -> txt_4c_DUni (T:394 L:145 W:150 H:23) - desc unid1 (readonly)
        loc_oPg.AddObject("txt_4c_DUni", "TextBox")
        WITH loc_oPg.txt_4c_DUni
            .Top           = 394
            .Left          = 145
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say18: "(2) :" (T:398 L:301 W:23)
        loc_oPg.AddObject("lbl_4c_LblUnid2", "Label")
        WITH loc_oPg.lbl_4c_LblUnid2
            .Caption   = "(2) :"
            .Top       = 398
            .Left      = 301
            .Width     = 23
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_cunip -> txt_4c_Cunip (T:394 L:330 W:31 H:23) - cunips char(3)
        loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
        WITH loc_oPg.txt_4c_Cunip
            .Top           = 394
            .Left          = 330
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cunip, "KeyPress",  THIS, "TxtCunipKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Cunip, "LostFocus", THIS, "TxtCunipLostFocus")

        *-- get_dunip -> txt_4c_DUnip (T:394 L:362 W:150 H:23) - desc unid2 (readonly)
        loc_oPg.AddObject("txt_4c_DUnip", "TextBox")
        WITH loc_oPg.txt_4c_DUnip
            .Top           = 394
            .Left          = 362
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Preco Venda + Auditoria linha 1 (T:397)
        *-- Say4: "Valor de Venda :" (T:400 L:505 W:120)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
        WITH loc_oPg.lbl_4c_LblPvenda
            .Caption   = "Valor de Venda :"
            .Top       = 400
            .Left      = 505
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getPvenda -> txt_4c_Pvenda (T:397 L:626 W:127 H:21) - pvens (display)
        loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
        WITH loc_oPg.txt_4c_Pvenda
            .Top           = 397
            .Left          = 626
            .Width         = 127
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .MaxLength     = 14
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- getMpvenda -> txt_4c_Mpvenda (T:397 L:754 W:31 H:21) - moevs (display)
        loc_oPg.AddObject("txt_4c_Mpvenda", "TextBox")
        WITH loc_oPg.txt_4c_Mpvenda
            .Top           = 397
            .Left          = 754
            .Width         = 31
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- Get_DtIncs -> txt_4c_DtIncs (T:397 L:833 W:79 H:21) - dtincs (display)
        loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPg.txt_4c_DtIncs
            .Top           = 397
            .Left          = 833
            .Width         = 79
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- getDataAlts -> txt_4c_DataAlts (T:397 L:914 W:79 H:21) - dtalts (display)
        loc_oPg.AddObject("txt_4c_DataAlts", "TextBox")
        WITH loc_oPg.txt_4c_DataAlts
            .Top           = 397
            .Left          = 914
            .Width         = 79
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CodIdent + Fator Venda + Auditoria linha 2 (T:418-419)
        *-- Say38: "Cod. Identidade :" (T:422 L:24 W:87)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblCodIdent", "Label")
        WITH loc_oPg.lbl_4c_LblCodIdent
            .Caption   = "Cod. Identidade :"
            .Top       = 422
            .Left      = 24
            .Width     = 87
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetCodIdent -> txt_4c_CodIdent (T:418 L:113 W:182 H:23) - codident char(20)
        loc_oPg.AddObject("txt_4c_CodIdent", "TextBox")
        WITH loc_oPg.txt_4c_CodIdent
            .Top           = 418
            .Left          = 113
            .Width         = 182
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say6: "Fator de Venda :" (T:422 L:539 W:86)
        loc_oPg.AddObject("lbl_4c_LblFvenda", "Label")
        WITH loc_oPg.lbl_4c_LblFvenda
            .Caption   = "Fator de Venda :"
            .Top       = 422
            .Left      = 539
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getFvenda -> txt_4c_Fvenda (T:419 L:626 W:127 H:21) - fvendas (display)
        loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
        WITH loc_oPg.txt_4c_Fvenda
            .Top           = 419
            .Left          = 626
            .Width         = 127
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .MaxLength     = 9
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- getMfvenda -> txt_4c_Mfvenda (T:419 L:754 W:31 H:21) - moepvs (display)
        loc_oPg.AddObject("txt_4c_Mfvenda", "TextBox")
        WITH loc_oPg.txt_4c_Mfvenda
            .Top           = 419
            .Left          = 754
            .Width         = 31
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- Get_Usuario -> txt_4c_Usuario (T:419 L:833 W:79 H:21) - usuincs (display)
        loc_oPg.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPg.txt_4c_Usuario
            .Top           = 419
            .Left          = 833
            .Width         = 79
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *-- getUsuaAlts -> txt_4c_UsuaAlts (T:419 L:914 W:79 H:21) - usuaalts (display)
        loc_oPg.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH loc_oPg.txt_4c_UsuaAlts
            .Top           = 419
            .Left          = 914
            .Width         = 79
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Value         = ""
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(224, 235, 235)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Entrega + Situacao/Checkboxes (T:447-451)
        *-- Label9: "Entrega :" (T:451 L:884) / Label10: "Dias" (T:451 L:967)
        *-- Say39: "Situacao :" (T:451 L:548 W:50)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblSituacao", "Label")
        WITH loc_oPg.lbl_4c_LblSituacao
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 451
            .Left      = 548
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblEntrega", "Label")
        WITH loc_oPg.lbl_4c_LblEntrega
            .Caption   = "Entrega :"
            .Top       = 451
            .Left      = 884
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getTEnts -> txt_4c_TEnts (T:447 L:934 W:31 H:22) - tents numeric(3,0)
        loc_oPg.AddObject("txt_4c_TEnts", "TextBox")
        WITH loc_oPg.txt_4c_TEnts
            .Top           = 447
            .Left          = 934
            .Width         = 31
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDiasEntr", "Label")
        WITH loc_oPg.lbl_4c_LblDiasEntr
            .Caption   = "Dias"
            .Top       = 451
            .Left      = 967
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_Consig -> chk_4c_Consig (T:451 L:601) - consigs numeric(1,0)
        loc_oPg.AddObject("chk_4c_Consig", "CheckBox")
        WITH loc_oPg.chk_4c_Consig
            .Top       = 451
            .Left      = 601
            .Width     = 75
            .Height    = 17
            .Caption   = "Consigna"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- chkFabrProprs -> chk_4c_FabrProprs (T:451 L:681) - fabrproprs numeric(1,0)
        loc_oPg.AddObject("chk_4c_FabrProprs", "CheckBox")
        WITH loc_oPg.chk_4c_FabrProprs
            .Top       = 451
            .Left      = 681
            .Width     = 90
            .Height    = 17
            .Caption   = "Fabr. Pr" + CHR(243) + "pria"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- chkEncoms -> chk_4c_Encoms (T:451 L:781) - encoms numeric(1,0)
        loc_oPg.AddObject("chk_4c_Encoms", "CheckBox")
        WITH loc_oPg.chk_4c_Encoms
            .Top       = 451
            .Left      = 781
            .Width     = 80
            .Height    = 17
            .Caption   = "Encomenda"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Memo: Descricao de Compra (T:448)
        *-- Say31: "Descricao de : Compra ." (T:448 L:23 H:28)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblDscCompra", "Label")
        WITH loc_oPg.lbl_4c_LblDscCompra
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o de : Compra ."
            .Top       = 448
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getdsccompras -> edt_4c_DscCompras (T:448 L:113 W:400 H:58)
        loc_oPg.AddObject("edt_4c_DscCompras", "EditBox")
        WITH loc_oPg.edt_4c_DscCompras
            .Top           = 448
            .Left          = 113
            .Width         = 400
            .Height        = 58
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Dimensoes embalagem (T:470) - Say27: "Dimensao :" (T:474 L:543)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblDimensao", "Label")
        WITH loc_oPg.lbl_4c_LblDimensao
            .Caption   = "Dimens" + CHR(227) + "o :"
            .Top       = 474
            .Left      = 543
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fwget6 -> txt_4c_Tamps (T:470 L:601 W:58 H:23) - tamps (Profundidade)
        loc_oPg.AddObject("lbl_4c_LblTamps", "Label")
        WITH loc_oPg.lbl_4c_LblTamps
            .Caption   = "P"
            .Top       = 474
            .Left      = 661
            .Width     = 20
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Tamps", "TextBox")
        WITH loc_oPg.txt_4c_Tamps
            .Top           = 470
            .Left          = 601
            .Width         = 58
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- fwget5 -> txt_4c_Tamhs (T:470 L:688 W:58 H:23) - tamhs (Altura emb)
        loc_oPg.AddObject("lbl_4c_LblTamhs", "Label")
        WITH loc_oPg.lbl_4c_LblTamhs
            .Caption   = "A"
            .Top       = 474
            .Left      = 749
            .Width     = 20
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Tamhs", "TextBox")
        WITH loc_oPg.txt_4c_Tamhs
            .Top           = 470
            .Left          = 688
            .Width         = 58
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- fwget4 -> txt_4c_Tamls (T:470 L:776 W:58 H:23) - tamls (Comprimento emb)
        loc_oPg.AddObject("lbl_4c_LblTamls", "Label")
        WITH loc_oPg.lbl_4c_LblTamls
            .Caption   = "C"
            .Top       = 474
            .Left      = 836
            .Width     = 17
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Tamls", "TextBox")
        WITH loc_oPg.txt_4c_Tamls
            .Top           = 470
            .Left          = 776
            .Width         = 58
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say26: "Volumes :" (T:474 L:883 W:48)
        loc_oPg.AddObject("lbl_4c_LblVolumes", "Label")
        WITH loc_oPg.lbl_4c_LblVolumes
            .Caption   = "Volumes :"
            .Top       = 474
            .Left      = 883
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fwget3 -> txt_4c_Volumes (T:470 L:934 W:31 H:23) - volumes numeric(3,0)
        loc_oPg.AddObject("txt_4c_Volumes", "TextBox")
        WITH loc_oPg.txt_4c_Volumes
            .Top           = 470
            .Left          = 934
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Memo: Descricao Completa (T:507)
        *-- Say33: "Descricao : Completa ." (T:507 L:23 H:28)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblDPro3s", "Label")
        WITH loc_oPg.lbl_4c_LblDPro3s
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : Completa ."
            .Top       = 507
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getDPro3s -> edt_4c_DPro3s (T:507 L:113 W:400 H:58)
        loc_oPg.AddObject("edt_4c_DPro3s", "EditBox")
        WITH loc_oPg.edt_4c_DPro3s
            .Top           = 507
            .Left          = 113
            .Width         = 400
            .Height        = 58
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Memo: Observacao da Compra (T:566)
        *-- Say32: "Observacao : da Compra ." (T:566 L:23 H:28)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblObsCompra", "Label")
        WITH loc_oPg.lbl_4c_LblObsCompra
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o : da Compra ."
            .Top       = 566
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getObsCompras -> edt_4c_ObsCompras (T:566 L:113 W:400 H:58)
        loc_oPg.AddObject("edt_4c_ObsCompras", "EditBox")
        WITH loc_oPg.edt_4c_ObsCompras
            .Top           = 566
            .Left          = 113
            .Width         = 400
            .Height        = 58
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherDescricoesPgDadosP2 - Busca descricoes de unidades (readonly)
    *--------------------------------------------------------------------------
    PROCEDURE PreencherDescricoesPgDadosP2()
        LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF
        IF VARTYPE(loc_oPg.txt_4c_Cuni) # "O"
            RETURN
        ENDIF

        TRY
            *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpUni")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
                    loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
                ENDIF
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
            ENDIF

            *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpUnip")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
                    loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
                ENDIF
                IF USED("cursor_4c_TmpUnip")
                    USE IN cursor_4c_TmpUnip
                ENDIF
            ENDIF

            *-- Descricao Modelo (codfinp -> SigCdFip.descs)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpFinP")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
                    loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
                ENDIF
                IF USED("cursor_4c_TmpFinP")
                    USE IN cursor_4c_TmpFinP
                ENDIF
            ENDIF

            *-- Descricao Acabamento (codacbs -> SigCdAca.descrs)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpAcb")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
                    loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
                ENDIF
                IF USED("cursor_4c_TmpAcb")
                    USE IN cursor_4c_TmpAcb
                ENDIF
            ENDIF

            *-- Descricao Classificacao (cclass -> SigCdCls.descs, filtrado por cgrus)
            loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
            loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
                    IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
                    "cursor_4c_TmpClass")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
                    loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
                ENDIF
                IF USED("cursor_4c_TmpClass")
                    USE IN cursor_4c_TmpClass
                ENDIF
            ENDIF

            *-- Descricao Local (locals -> SigPrLcl.descricaos)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpLocal")
                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLocal") > 0
                    *-- Local nao tem campo descricao visivel separado, apenas atualiza silenciosamente
                    *-- O campo txt_4c_Local ja exibe o codigo (10 chars)
                ENDIF
                IF USED("cursor_4c_TmpLocal")
                    USE IN cursor_4c_TmpLocal
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es P2")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 6)
    * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
    *==========================================================================

    *--------------------------------------------------------------------------
    * TxtCuni - F4 abre lookup de unidades; LostFocus valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupUnidade1()
        ENDIF
    ENDPROC

    PROCEDURE TxtCuniLostFocus()
        LOCAL loc_oPg, loc_cCuni, loc_nRet
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCuni = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)

        IF EMPTY(loc_cCuni)
            loc_oPg.txt_4c_DUni.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
                "cursor_4c_TmpCuni")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
                loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
            ELSE
                MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
                loc_oPg.txt_4c_Cuni.Value = ""
                loc_oPg.txt_4c_DUni.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpCuni")
                USE IN cursor_4c_TmpCuni
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar unidade")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupUnidade1()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUni", "cunis", loc_cAtual, ;
                "Buscar Unidade")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaUni")
                        loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
                        loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
                        loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
                        loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaUni")
                USE IN cursor_4c_BuscaUni
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCunip - F4 abre lookup de unidades 2; LostFocus valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupUnidade2()
        ENDIF
    ENDPROC

    PROCEDURE TxtCunipLostFocus()
        LOCAL loc_oPg, loc_cCunip, loc_nRet
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCunip = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)

        IF EMPTY(loc_cCunip)
            loc_oPg.txt_4c_DUnip.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
                "cursor_4c_TmpCunip")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
                loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
            ELSE
                MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
                loc_oPg.txt_4c_Cunip.Value = ""
                loc_oPg.txt_4c_DUnip.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpCunip")
                USE IN cursor_4c_TmpCunip
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupUnidade2()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUnip", "cunis", loc_cAtual, ;
                "Buscar Unidade 2")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaUnip")
                        loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
                        loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnip")
                        loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
                        loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaUnip")
                USE IN cursor_4c_BuscaUnip
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar unidade 2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodFinP - F4 abre lookup de modelos (SigCdFip); LostFocus valida
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupModelo()
        ENDIF
    ENDPROC

    PROCEDURE TxtCodFinPLostFocus()
        LOCAL loc_oPg, loc_cCod, loc_nRet
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)

        IF EMPTY(loc_cCod)
            loc_oPg.txt_4c_DFinP.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_TmpFinP")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
                loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
            ELSE
                MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_CodFinP.Value = ""
                loc_oPg.txt_4c_DFinP.Value   = ""
            ENDIF
            IF USED("cursor_4c_TmpFinP")
                USE IN cursor_4c_TmpFinP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar modelo")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupModelo()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdFip", "cursor_4c_BuscaFinP", "cods", loc_cAtual, ;
                "Buscar Modelo")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaFinP")
                        loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
                        loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
                        loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
                        loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaFinP")
                USE IN cursor_4c_BuscaFinP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar modelo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodAcb - F4 abre lookup de acabamentos (SigCdAca); LostFocus valida
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupAcabamento()
        ENDIF
    ENDPROC

    PROCEDURE TxtCodAcbLostFocus()
        LOCAL loc_oPg, loc_cCod, loc_nRet
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)

        IF EMPTY(loc_cCod)
            loc_oPg.txt_4c_DAcb.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_TmpAcb")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
                loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
            ELSE
                MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_CodAcb.Value = ""
                loc_oPg.txt_4c_DAcb.Value   = ""
            ENDIF
            IF USED("cursor_4c_TmpAcb")
                USE IN cursor_4c_TmpAcb
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupAcabamento()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdAca", "cursor_4c_BuscaAcb", "cods", loc_cAtual, ;
                "Buscar Acabamento")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaAcb")
                        loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
                        loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
                        loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
                        loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaAcb")
                USE IN cursor_4c_BuscaAcb
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtClass - F4 abre lookup de classificacoes (SigCdCls); LostFocus valida
    * SigCdCls: filtrado por cgrus do grupo de produto corrente
    *--------------------------------------------------------------------------
    PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupClassificacao()
        ENDIF
    ENDPROC

    PROCEDURE TxtClassLostFocus()
        LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
        loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)

        IF EMPTY(loc_cCod)
            loc_oPg.txt_4c_DClass.Value = ""
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
                IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
                "cursor_4c_TmpClass")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
                loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
            ELSE
                MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
                loc_oPg.txt_4c_Class.Value  = ""
                loc_oPg.txt_4c_DClass.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpClass")
                USE IN cursor_4c_TmpClass
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupClassificacao()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual, loc_cCgru
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Class.Value)
        loc_cCgru  = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
                "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
                IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaClass")
                        loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
                        loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
                        loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
                        loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaClass")
                USE IN cursor_4c_BuscaClass
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLocal - F4 abre lookup de locais (SigPrLcl); LostFocus valida
    *--------------------------------------------------------------------------
    PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 && F4
            THIS.AbrirLookupLocal()
        ENDIF
    ENDPROC

    PROCEDURE TxtLocalLostFocus()
        LOCAL loc_oPg, loc_cCod, loc_nRet
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)

        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_TmpLocal")
            IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
                MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
                loc_oPg.txt_4c_Local.Value = ""
            ENDIF
            IF USED("cursor_4c_TmpLocal")
                USE IN cursor_4c_TmpLocal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar local")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirLookupLocal()
        LOCAL loc_oBusca, loc_oPg, loc_cAtual
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Local.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cAtual, ;
                "Buscar Local")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaLocal")
                        loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "Local")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
                        loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar local")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FASE 11 - Aba Consulta de Componentes (PgDadosConsP - Page5 do pgf_4c_Dados)
    * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
    * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
    * Controles: GrdCons(9 cols), Getqtcpnt, Say7, chkFund, Say1, grDTEMP(2 cols)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgDadosConsP()
        LOCAL loc_oPg, loc_oGrd

        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5

        *----------------------------------------------------------------------
        *-- Cursor placeholder para GrdCons (SigPrCpo + SigCdPrf + SigCdCat)
        *-- Campos: mats(comp), qtds(qtde), unicompos(uni), Grupos(fase code),
        *--         Descrs(fase desc), Ordems(ord), consumo, Cods(cat), dcats(cat desc)
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_GrdCons")
            SET NULL ON
            CREATE CURSOR cursor_4c_GrdCons (;
                mats      C(14), ;
                qtds      N(12,4), ;
                unicompos C(5), ;
                Grupos    C(3), ;
                Descrs    C(65), ;
                Ordems    N(5,0), ;
                consumo   N(12,4), ;
                Cods      C(5), ;
                dcats     C(65), ;
                Dopes     C(5))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_GrDTEMP")
            SET NULL ON
            CREATE CURSOR cursor_4c_GrDTEMP (;
                agrup C(30), ;
                tempo N(12,4))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
        *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
        *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
        loc_oGrd = loc_oPg.grd_4c_GrdCons

        WITH loc_oGrd
            .Top              = 155
            .Left             = 6
            .Width            = 987
            .Height           = 362
            .FontName         = "Tahoma"
            .FontSize         = 8
            .ColumnCount      = 9
            .GridLines        = 3
            .GridLineWidth    = 1
            .GridLineColor    = RGB(238, 238, 238)
            .RecordMark       = .F.
            .DeleteMark       = .F.
            .AllowRowSizing   = .F.
            .ReadOnly         = .F.
            .BackColor        = RGB(255, 255, 255)
            .ForeColor        = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle   = 2
            .RowHeight        = 16
            .ScrollBars       = 2
            .Themes           = .F.
            .Visible          = .T.
        ENDWITH

        *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
        loc_oPg.grd_4c_GrdCons.RecordSource = "cursor_4c_GrdCons"

        *-- Configurar colunas APOS RecordSource
        WITH loc_oPg.grd_4c_GrdCons
            *-- Col1: Componente (mats C14) W:140 - readonly
            .Column1.Header1.Caption = "Componente"
            .Column1.Width           = 140
            .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
            .Column1.Alignment       = 0
            .Column1.ReadOnly        = .T.

            *-- Col2: Qtde. (qtds N) W:70 - readonly
            .Column2.Header1.Caption = "Qtde."
            .Column2.Width           = 70
            .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
            .Column2.Alignment       = 1
            .Column2.ReadOnly        = .T.

            *-- Col3: Uni (unicompos C5) W:40 - readonly
            .Column3.Header1.Caption = "Uni"
            .Column3.Width           = 40
            .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
            .Column3.Alignment       = 0
            .Column3.ReadOnly        = .T.

            *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
            .Column4.Header1.Caption = "Fase"
            .Column4.Width           = 45
            .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
            .Column4.Alignment       = 0
            .Column4.ReadOnly        = .F.

            *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
            .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column5.Width           = 250
            .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
            .Column5.Alignment       = 0
            .Column5.ReadOnly        = .F.

            *-- Col6: Ord. (Ordems N) W:40 - readonly
            .Column6.Header1.Caption = "Ord."
            .Column6.Width           = 40
            .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
            .Column6.Alignment       = 1
            .Column6.ReadOnly        = .T.

            *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
            .Column7.Header1.Caption = "Consumo"
            .Column7.Width           = 80
            .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
            .Column7.Alignment       = 1
            .Column7.ReadOnly        = .F.

            *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
            .Column8.Header1.Caption = "Cat."
            .Column8.Width           = 45
            .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
            .Column8.Alignment       = 0
            .Column8.ReadOnly        = .F.

            *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
            .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column9.Width           = 277
            .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
            .Column9.Alignment       = 0
            .Column9.ReadOnly        = .F.
        ENDWITH

        *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
        BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
        BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
        BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
        BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")

        *----------------------------------------------------------------------
        *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg.lbl_4c_Label7
            .Caption   = "Qtde Componentes : "
            .Top       = 523
            .Left      = 25
            .Width     = 105
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- TextBox Getqtcpnt (T:519 L:131 W:31 H:23)
        *-- Legado When: Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
        *-- Habilitado somente em modo edicao (via HabilitarCampos/DesabilitarCampos)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
        WITH loc_oPg.txt_4c_Qtcpnt
            .Top           = 519
            .Left          = 131
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CheckBox chkFund (T:544 L:10 W:182 H:15)
        *-- Caption: "Nao Checar Cadastro de Fundicao"
        *-- Habilitado somente em modo edicao
        *----------------------------------------------------------------------
        loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
        WITH loc_oPg.chk_4c_ChkFund
            .Caption   = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
            .Top       = 544
            .Left      = 10
            .Width     = 182
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .BackStyle = 0
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Label "Tempo Producao por Agrupamento :" (Say1: T:521 L:642 W:176 H:15)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
            .Top       = 521
            .Left      = 642
            .Width     = 176
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grid grDTEMP (T:519 L:821 W:172 H:107) - Tempo por Agrupamento (2 cols)
        *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.grDTEMP
        *-- Cols: Agrupamento, Tempo %  (ambas read-only)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")

        WITH loc_oPg.grd_4c_GrDTEMP
            .Top              = 519
            .Left             = 821
            .Width            = 172
            .Height           = 107
            .FontName         = "Tahoma"
            .FontSize         = 8
            .ColumnCount      = 2
            .GridLines        = 3
            .GridLineWidth    = 1
            .GridLineColor    = RGB(238, 238, 238)
            .RecordMark       = .F.
            .DeleteMark       = .F.
            .AllowRowSizing   = .F.
            .ReadOnly         = .T.
            .BackColor        = RGB(255, 255, 255)
            .ForeColor        = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle   = 2
            .RowHeight        = 16
            .ScrollBars       = 2
            .Themes           = .F.
            .Visible          = .T.
        ENDWITH

        *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
        loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"

        *-- Configurar colunas do grDTEMP APOS RecordSource
        WITH loc_oPg.grd_4c_GrDTEMP
            *-- Col1: Agrupamento (agrup C30) W:100 - readonly
            .Column1.Header1.Caption = "Agrupamento"
            .Column1.Width           = 100
            .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
            .Column1.Alignment       = 0
            .Column1.ReadOnly        = .T.

            *-- Col2: Tempo % (tempo N) W:72 - readonly
            .Column2.Header1.Caption = "Tempo %"
            .Column2.Width           = 72
            .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
            .Column2.Alignment       = 1
            .Column2.ReadOnly        = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
    * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
    *--------------------------------------------------------------------------
    PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
            ENDIF
        CATCH TO loc_oErro
            *-- silencioso: refresh de navegacao nao deve bloquear
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdConsCol4KeyPress - F4 abre lookup de Fase (SigCdPrf) para coluna Grupos
    * Legado: Column4.Text1.Valid = fwBuscaInt on crSigCdPrf index GrpOrdem
    *--------------------------------------------------------------------------
    PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cAtual, loc_oPg
        IF par_nKeyCode = 115  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            TRY
                loc_cAtual = ""
                IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
                    loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPrf", "cursor_4c_BuscaPrf", "Grupos", loc_cAtual, ;
                    "Buscar Fase")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
                        IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
                            SELECT cursor_4c_GrdCons
                            REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
                            REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaPrf")
                    USE IN cursor_4c_BuscaPrf
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao buscar fase")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdConsCol5KeyPress - F4 abre lookup de Descricao de Fase (SigCdPrf)
    * Legado: Column5.Text1.Valid = fwBuscaInt on crSigCdPrf by Descrs
    *         Apos selecao: Replace Grupos, Ordems, Dopes in crSigPrCpo
    * Habilitado somente quando Column4 (Grupos) estiver vazio
    *--------------------------------------------------------------------------
    PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cAtual, loc_cGrupos
        IF par_nKeyCode = 115  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            *-- Column5 so editavel quando Column4 (Grupos) esta vazio
            loc_cGrupos = ""
            IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
                loc_cGrupos = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
            ENDIF
            IF !EMPTY(loc_cGrupos)
                RETURN
            ENDIF
            TRY
                loc_cAtual = ""
                IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
                    loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Descrs, ""))
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPrf", "cursor_4c_BuscaPrf2", "Descrs", loc_cAtual, ;
                    "Buscar Descri" + CHR(231) + CHR(227) + "o de Fase")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Ordems", "", "Ord.")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
                        IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
                            SELECT cursor_4c_GrdCons
                            REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
                            REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
                            IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
                                REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
                            ENDIF
                            IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
                                REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaPrf2")
                    USE IN cursor_4c_BuscaPrf2
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao buscar descri" + CHR(231) + CHR(227) + "o de fase")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdConsCol8KeyPress - F4 abre lookup de Categoria (SigCdCat) para coluna Cods
    * Legado: Column8.Text1.Valid = fwBuscaExt on SigCdCat by Cods
    *         Apos selecao: Column8 = Cods; Column9 (dcats) = Descs
    *--------------------------------------------------------------------------
    PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cAtual
        IF par_nKeyCode = 115  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            TRY
                loc_cAtual = ""
                IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
                    loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Cods, ""))
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCat", "cursor_4c_BuscaCat", "Cods", loc_cAtual, ;
                    "Buscar Categoria")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
                        IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
                            SELECT cursor_4c_GrdCons
                            REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
                            REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaCat")
                    USE IN cursor_4c_BuscaCat
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 10 - Aba Custo (pgCusto - Page6 do pgf_4c_Dados)
    * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
    * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
    * Controles: cmbTipos, grdCompo(12 cols), cmdgCompo(2 btn),
    *            Say16/Get_Desc, Say2/getDGruCompos, Say3, Shape2, GradeGRUPO2(3 cols)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgCusto()
        LOCAL loc_oPg, loc_oGrd

        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6

        *----------------------------------------------------------------------
        *-- Cursors cursor_4c_Compo e cursor_4c_Grupo sao compartilhados
        *-- com pgComposicao (criados em ConfigurarPgpgComposicao).
        *-- Nao recriar - usar os ja existentes.
        *----------------------------------------------------------------------

        *----------------------------------------------------------------------
        *-- Tipo: lbl_4c_Label1 + cbo_4c_CmbTipos
        *-- Say1: "Tipo :" T:159 L:112 W:29
        *-- cmbTipos: T:154 L:143 W:187 H:23
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Caption   = "Tipo :"
            .Top       = 159
            .Left      = 112
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
        WITH loc_oPg.cbo_4c_CmbTipos
            .Top           = 154
            .Left          = 143
            .Width         = 187
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 0
            .Value         = ""
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")

        *----------------------------------------------------------------------
        *-- Grid grdCompo (12 colunas) - Composicao de custo
        *-- T:178 L:34 W:813 H:230 - usa cursor_4c_Compo (compartilhado)
        *-- Colunas: Item, Descricao, Un, Valor, Qtd, Total, Moe,
        *--          Observacao, Etiq, Consumo, Qtd, Un
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
        WITH loc_oPg.grd_4c_CustoCompo
            .Top               = 178
            .Left              = 34
            .Width             = 813
            .Height            = 230
            .ColumnCount       = 12
            .FontName          = "Verdana"
            .FontSize          = 8
            .GridLines         = 3
            .GridLineWidth     = 1
            .GridLineColor     = RGB(238, 238, 238)
            .RecordMark        = .F.
            .DeleteMark        = .F.
            .AllowRowSizing    = .F.
            .ReadOnly          = .F.
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .RowHeight         = 16
            .ScrollBars        = 2
            .Visible           = .T.
        ENDWITH

        *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
        loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"

        *-- Configurar colunas APOS RecordSource
        WITH loc_oPg.grd_4c_CustoCompo
            *-- Col1: Item/Material (C14) W:80
            .Column1.Header1.Caption   = "Item"
            .Column1.Width             = 80
            .Column1.ControlSource     = "cursor_4c_Compo.mats"
            .Column1.Alignment         = 0

            *-- Col2: Descricao (C65) W:185
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width             = 185
            .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
            .Column2.Alignment         = 0

            *-- Col3: Un (C5) W:35 - readonly (When=.F.)
            .Column3.Header1.Caption   = "Un"
            .Column3.Width             = 35
            .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
            .Column3.ReadOnly          = .T.

            *-- Col4: Valor (N12,4) W:65
            .Column4.Header1.Caption   = "Valor"
            .Column4.Width             = 65
            .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
            .Column4.Alignment         = 1

            *-- Col5: Qtd (N12,4) W:55
            .Column5.Header1.Caption   = "Qtd"
            .Column5.Width             = 55
            .Column5.ControlSource     = "cursor_4c_Compo.qtds"
            .Column5.Alignment         = 1

            *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
            .Column6.Header1.Caption   = "Total"
            .Column6.Width             = 65
            .Column6.ControlSource     = "cursor_4c_Compo.totals"
            .Column6.Alignment         = 1
            .Column6.ReadOnly          = .T.

            *-- Col7: Moe/Moeda (C5) W:35
            .Column7.Header1.Caption   = "Moe"
            .Column7.Width             = 35
            .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"

            *-- Col8: Observacao (C40) W:95
            .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Column8.Width             = 95
            .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
            .Column8.Alignment         = 0

            *-- Col9: Etiq (C1) W:30
            .Column9.Header1.Caption   = "Etiq"
            .Column9.Width             = 30
            .Column9.ControlSource     = "cursor_4c_Compo.etiq"

            *-- Col10: Consumo (N12,4) W:65
            .Column10.Header1.Caption  = "Consumo"
            .Column10.Width            = 65
            .Column10.ControlSource    = "cursor_4c_Compo.consumo"
            .Column10.Alignment        = 1

            *-- Col11: Qtd cons (N12,4) W:55
            .Column11.Header1.Caption  = "Qtd"
            .Column11.Width            = 55
            .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
            .Column11.Alignment        = 1

            *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
            .Column12.Header1.Caption  = "Un"
            .Column12.Width            = 30
            .Column12.ControlSource    = "cursor_4c_Compo.uni2"
            .Column12.ReadOnly         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")

        *----------------------------------------------------------------------
        *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
        *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
        WITH loc_oPg.cnt_4c_BotoesCusto
            .Top         = 240
            .Left        = 851
            .Width       = 50
            .Height      = 90
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao 1: Inserir componente de custo
        loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto
            .Caption       = "+"
            .Top           = 0
            .Left          = 0
            .Width         = 50
            .Height        = 45
            .FontName      = "Tahoma"
            .FontSize      = 10
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 128, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto, "Click", THIS, "CmdInserirCustoClick")

        *-- Botao 2: Excluir componente de custo
        loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_ExcluirCusto", "CommandButton")
        WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto
            .Caption       = "-"
            .Top           = 45
            .Left          = 0
            .Width         = 50
            .Height        = 45
            .FontName      = "Tahoma"
            .FontSize      = 10
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(192, 0, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto, "Click", THIS, "CmdExcluirCustoClick")

        *----------------------------------------------------------------------
        *-- Linha Descricao / Grupo (abaixo do grid e botoes)
        *-- Say16: "Descricao :" T:415 L:52 W:55
        *-- Get_Desc: T:412 L:116 W:304 H:21 - readonly (When=.F.)
        *-- Say2: "Grupo :" T:415 L:479 W:38
        *-- getDGruCompos: T:412 L:522 W:304 H:21 - readonly (When=.F.)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPg.lbl_4c_Label16
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 415
            .Left      = 52
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CustoDesc", "TextBox")
        WITH loc_oPg.txt_4c_CustoDesc
            .Top           = 412
            .Left          = 116
            .Width         = 304
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 65
            .Value         = ""
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Caption   = "Grupo :"
            .Top       = 134
            .Left      = 58
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DGruCompos", "TextBox")
        WITH loc_oPg.txt_4c_DGruCompos
            .Top           = 412
            .Left          = 522
            .Width         = 304
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 65
            .Value         = ""
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Resumo por Grupo: Say3 + Shape2 + GradeGRUPO2
        *-- Say3: "Resumo por Grupo" T:445 L:35 W:107
        *-- Shape2: T:460 L:35 W:158 H:2
        *-- GradeGRUPO2: T:468 L:35 W:195 H:141 - 3 colunas (Grp, Total, Moe)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Caption   = "Resumo por Grupo"
            .Top       = 445
            .Left      = 35
            .Width     = 107
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPg.shp_4c_Shape2
            .Top         = 460
            .Left        = 35
            .Width       = 158
            .Height      = 2
            .FillStyle   = 0
            .BackStyle   = 1
            .FillColor   = RGB(128, 128, 128)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- GradeGRUPO2: grd_4c_GrupoCusto (3 cols) - usa cursor_4c_Grupo (compartilhado)
        loc_oPg.AddObject("grd_4c_GrupoCusto", "Grid")
        WITH loc_oPg.grd_4c_GrupoCusto
            .Top               = 468
            .Left              = 35
            .Width             = 195
            .Height            = 141
            .ColumnCount       = 3
            .FontName          = "Verdana"
            .FontSize          = 8
            .GridLines         = 3
            .GridLineWidth     = 1
            .GridLineColor     = RGB(238, 238, 238)
            .RecordMark        = .F.
            .DeleteMark        = .F.
            .AllowRowSizing    = .F.
            .ReadOnly          = .T.
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .RowHeight         = 16
            .ScrollBars        = 2
            .Visible           = .T.
        ENDWITH

        *-- RecordSource FORA do WITH
        loc_oPg.grd_4c_GrupoCusto.RecordSource = "cursor_4c_Grupo"

        *-- Configurar colunas APOS RecordSource
        WITH loc_oPg.grd_4c_GrupoCusto
            *-- Col1: Grupo (C3) W:40 - readonly
            .Column1.Header1.Caption   = "Grp"
            .Column1.Width             = 40
            .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
            .Column1.ReadOnly          = .T.

            *-- Col2: Total (N12,4) W:100 - readonly
            .Column2.Header1.Caption   = "Total"
            .Column2.Width             = 100
            .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
            .Column2.Alignment         = 1
            .Column2.ReadOnly          = .T.

            *-- Col3: Moeda (C5) W:50 - readonly
            .Column3.Header1.Caption   = "Moe"
            .Column3.Width             = 50
            .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
            .Column3.ReadOnly          = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
    *--------------------------------------------------------------------------
    PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_nRet
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
            IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
                loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
                *-- Buscar descricao do grupo
                IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
                        EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
                        "cursor_4c_TmpGrpCusto")
                    IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
                        loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
                    ELSE
                        loc_oPg.txt_4c_DGruCompos.Value = ""
                    ENDIF
                    IF USED("cursor_4c_TmpGrpCusto")
                        USE IN cursor_4c_TmpGrpCusto
                    ENDIF
                ELSE
                    loc_oPg.txt_4c_DGruCompos.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- silencioso: refresh de display nao deve bloquear navegacao
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CboTiposCustoInteractiveChange - Filtra composicao pelo tipo selecionado
    *--------------------------------------------------------------------------
    PROCEDURE CboTiposCustoInteractiveChange()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
            IF USED("cursor_4c_Compo")
                GO TOP IN cursor_4c_Compo
                loc_oPg.grd_4c_CustoCompo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao filtrar por tipo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdInserirCustoClick - Insere nova linha de custo no grdCompo (pgCusto)
    *--------------------------------------------------------------------------
    PROCEDURE CmdInserirCustoClick()
        LOCAL loc_oPg, loc_cTipo
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
            loc_cTipo = ""
            IF VARTYPE(loc_oPg.cbo_4c_CmbTipos) = "O"
                loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
            ENDIF
            IF USED("cursor_4c_Compo")
                SELECT cursor_4c_Compo
                GO TOP IN cursor_4c_Compo
                LOCATE FOR EMPTY(mats)
                IF EOF("cursor_4c_Compo")
                    INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
                ENDIF
                loc_oPg.grd_4c_CustoCompo.Refresh()
                IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
                    loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirCustoClick()
        LOCAL loc_oPg
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF USED("cursor_4c_Compo")
                SELECT cursor_4c_Compo
                IF !EOF("cursor_4c_Compo")
                    DELETE
                    IF !EOF("cursor_4c_Compo")
                        SKIP
                        SKIP -1
                    ENDIF
                    GO BOTTOM IN cursor_4c_Compo
                ENDIF
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
                loc_oPg.grd_4c_CustoCompo.SetFocus()
                loc_oPg.grd_4c_CustoCompo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
    * LISTA/VISUALIZAR: Salvar desabilitado; INCLUIR/ALTERAR: Salvar habilitado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        loc_lEditando = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")

        IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
            IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar) = "O"
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEditando
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 12 - Aba Fases de Producao (PgDadosFaseP - Page4 do pgf_4c_Dados)
    * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
    * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
    * Controles: 2 grids (GradFase 5col + grdMatrizes 3col), 8 textboxes,
    *            2 checkboxes, 1 editbox, labels, shapes, images, 8 commandbuttons
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
        LOCAL loc_oPg, loc_oGrd
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4

        *----------------------------------------------------------------------
        *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
        *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_GradFase")
            SET NULL ON
            CREATE CURSOR cursor_4c_GradFase (;
                Ordems   N(5,0), ;
                Grupos   C(10), ;
                Descrs   C(65), ;
                UniPrdts C(10), ;
                MatPrdts C(15), ;
                Obs      M, ;
                FigProcs M)
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
        *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_SigPrMtz")
            SET NULL ON
            CREATE CURSOR cursor_4c_SigPrMtz (;
                CMats C(14), ;
                DLocs C(40), ;
                Qtds  N(3,0))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
        *----------------------------------------------------------------------
        loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
        WITH loc_oPg.shp_4c_ShpFig
            .Top         = 152
            .Left        = 231
            .Width       = 244
            .Height      = 148
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(192, 192, 192)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Image: ImgFigJpg (T:153 L:232 W:241 H:146) - imagem da fase de producao
        *-- Legado: GradFase.AfterRowColChange carrega de crSigCdPrf.FigProcs
        *----------------------------------------------------------------------
        loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
        WITH loc_oPg.img_4c_ImgFigJpg
            .Top     = 153
            .Left    = 232
            .Width   = 241
            .Height  = 146
            .Picture = ""
            .Stretch = 2
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")

        *----------------------------------------------------------------------
        *-- Grid GradFase (T:152 L:527 W:420 H:312) - 5 colunas fases de producao
        *-- Legado: SIGCDPRO.PgDadosFaseP.GradFase (fwgrade)
        *-- Cols: Ordem | Fase | Utilizacao | Uni. Produtiva | Material
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_GradFase", "Grid")
        loc_oGrd = loc_oPg.grd_4c_GradFase

        WITH loc_oGrd
            .Top                = 152
            .Left               = 527
            .Width              = 420
            .Height             = 312
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ColumnCount        = 5
            .GridLines          = 3
            .GridLineWidth      = 1
            .GridLineColor      = RGB(238, 238, 238)
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .AllowRowSizing     = .F.
            .ReadOnly           = .F.
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
        loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"

        *-- Configurar colunas APOS RecordSource
        WITH loc_oPg.grd_4c_GradFase
            *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
            .Column1.Header1.Caption = "Ordem"
            .Column1.Width           = 50
            .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
            .Column1.Alignment       = 1
            .Column1.ReadOnly        = .T.

            *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
            .Column2.Header1.Caption = "Fase"
            .Column2.Width           = 80
            .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
            .Column2.Alignment       = 0
            .Column2.ReadOnly        = .F.

            *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
            .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
            .Column3.Width           = 130
            .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
            .Column3.Alignment       = 0
            .Column3.ReadOnly        = .T.

            *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
            .Column4.Header1.Caption = "Uni. Produtiva"
            .Column4.Width           = 80
            .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
            .Column4.Alignment       = 0
            .Column4.ReadOnly        = .F.

            *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
            .Column5.Header1.Caption = "Material"
            .Column5.Width           = 80
            .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
            .Column5.Alignment       = 0
            .Column5.ReadOnly        = .F.
        ENDWITH

        *-- BINDEVENT: GradFase
        BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
        BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
        BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
        BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
        BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
        BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")

        *----------------------------------------------------------------------
        *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
        *-- Legado: inserir.Click - insere nova linha com resequenciamento
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
        WITH loc_oPg.cmd_4c_IncluirFase
            .Caption       = "+"
            .Top           = 152
            .Left          = 950
            .Width         = 38
            .Height        = 38
            .FontName      = "Tahoma"
            .FontSize      = 10
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 128, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_IncluirFase, "Click", THIS, "CmdIncluirFaseClick")

        *----------------------------------------------------------------------
        *-- Botao Excluir Fase (excluir: T:192 L:950 W:38 H:38)
        *-- Legado: excluir.Click - exclui linha corrente e resequencia
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
        WITH loc_oPg.cmd_4c_ExcluirFase
            .Caption       = "-"
            .Top           = 192
            .Left          = 950
            .Width         = 38
            .Height        = 38
            .FontName      = "Tahoma"
            .FontSize      = 10
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(192, 0, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "CmdExcluirFaseClick")

        *----------------------------------------------------------------------
        *-- Botao Alternativa (Alternativa: T:232 L:950 W:38 H:38)
        *-- Legado: Alternativa.Click - copia linha corrente como alternativa
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_AlternativaFase", "CommandButton")
        WITH loc_oPg.cmd_4c_AlternativaFase
            .Caption       = "A"
            .Top           = 232
            .Left          = 950
            .Width         = 38
            .Height        = 38
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_AlternativaFase, "Click", THIS, "CmdAlternativaFaseClick")

        *----------------------------------------------------------------------
        *-- Botao Ficha Tecnica (CmdFicha: T:152 L:482 W:38 H:38)
        *-- Legado: CmdFicha.Click - gera ficha tecnica com REPORT FORM
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdFicha
            .Caption       = "F"
            .Top           = 152
            .Left          = 482
            .Width         = 38
            .Height        = 38
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")

        *----------------------------------------------------------------------
        *-- Botao Selecionar Imagem (cmdgFigura: T:192 L:482 W:40 H:40)
        *-- Legado: cmdgFigura.Click - abre seletor GetPict JPG/BMP
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdgFigura
            .Caption       = "I"
            .Top           = 192
            .Left          = 482
            .Width         = 40
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")

        *----------------------------------------------------------------------
        *-- Botao Capturar Webcam (cmdgFigCam: T:232 L:482 W:40 H:40)
        *-- Legado: cmdgFigCam.Click - captura imagem via SigImage form
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdgFigCam
            .Caption       = "C"
            .Top           = 232
            .Left          = 482
            .Width         = 40
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")

        *----------------------------------------------------------------------
        *-- Label Say1: "Descricao :" (T:474 L:527 W:67 H:17)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_Label1FP", "Label")
        WITH loc_oPg.lbl_4c_Label1FP
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 474
            .Left      = 527
            .Width     = 67
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- TextBox Get_Desc (T:471 L:595 W:395 H:23) - descricao da fase
        *-- Readonly - preenchido pelo GradFaseAfterRowColChange (campo Descrs)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPg.txt_4c_Desc
            .Top           = 471
            .Left          = 595
            .Width         = 395
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- EditBox Get_Obs (T:497 L:527 W:463 H:122) - observacoes da fase
        *-- Readonly - preenchido pelo GradFaseAfterRowColChange (campo Obs de SigCdPrf)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("obj_4c_Get_Obs", "EditBox")
        WITH loc_oPg.obj_4c_Get_Obs
            .Top           = 497
            .Left          = 527
            .Width         = 463
            .Height        = 122
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .ScrollBars    = 2
            .SpecialEffect = 0
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Secao esquerda: campos do produto (qmin, garras, pesos, cor, tam, acab)
        *----------------------------------------------------------------------

        *-- Label Say13: "Qtd. Min. Producao :" (T:156 L:33 W:102 H:15)
        loc_oPg.AddObject("lbl_4c_Label13FP", "Label")
        WITH loc_oPg.lbl_4c_Label13FP
            .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
            .Top       = 32
            .Left      = 72
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getQmin: qtd minima producao (T:152 L:137 W:80 H:23)
        *-- Legado: qmins de SigCdPro
        loc_oPg.AddObject("txt_4c_Qmin", "TextBox")
        WITH loc_oPg.txt_4c_Qmin
            .Top           = 152
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Say5: "Garra :" (T:181 L:99 W:36 H:15)
        loc_oPg.AddObject("lbl_4c_Label5FP", "Label")
        WITH loc_oPg.lbl_4c_Label5FP
            .Caption   = "Garra :"
            .Top       = 181
            .Left      = 99
            .Width     = 36
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCodGarras: codigo de garra (T:177 L:137 W:80 H:23)
        *-- Legado: codgarras de SigCdPro (readonly - somente exibicao)
        loc_oPg.AddObject("txt_4c_CodGarras", "TextBox")
        WITH loc_oPg.txt_4c_CodGarras
            .Top           = 177
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(240, 240, 240)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Say4: "Conquilha :" (T:206 L:79 W:56 H:15)
        loc_oPg.AddObject("lbl_4c_Label4FP", "Label")
        WITH loc_oPg.lbl_4c_Label4FP
            .Caption   = "Conquilha :"
            .Top       = 206
            .Left      = 79
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getConquilha (T:202 L:137 W:80 H:23)
        *-- Legado: conquilhas de SigCdPro - LostFocus lookup SigCdCnq
        loc_oPg.AddObject("txt_4c_Conquilha", "TextBox")
        WITH loc_oPg.txt_4c_Conquilha
            .Top           = 202
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "TxtConquilhaLostFocus")

        *-- Label Say9: "Peso Brilhante :" (T:231 L:58 W:77 H:15)
        loc_oPg.AddObject("lbl_4c_Label9FP", "Label")
        WITH loc_oPg.lbl_4c_Label9FP
            .Caption   = "Peso Brilhante :"
            .Top       = 451
            .Left      = 884
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getPesoBris (T:227 L:137 W:80 H:23)
        *-- Legado: pesobris de SigCdPro
        loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
        WITH loc_oPg.txt_4c_PesoBris
            .Top           = 227
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Say10: "Peso Metal :" (T:256 L:74 W:61 H:15)
        loc_oPg.AddObject("lbl_4c_Label10FP", "Label")
        WITH loc_oPg.lbl_4c_Label10FP
            .Caption   = "Peso Metal :"
            .Top       = 451
            .Left      = 967
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getPesoMetal (T:252 L:137 W:80 H:23)
        *-- Legado: pesometal de SigCdPro
        loc_oPg.AddObject("txt_4c_PesoMetal", "TextBox")
        WITH loc_oPg.txt_4c_PesoMetal
            .Top           = 252
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Say8: "Peso Pedra :" (T:281 L:72 W:63 H:15)
        loc_oPg.AddObject("lbl_4c_Label8FP", "Label")
        WITH loc_oPg.lbl_4c_Label8FP
            .Caption   = "Peso Pedra :"
            .Top       = 5
            .Left      = 8
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getPesoPdrs (T:277 L:137 W:80 H:23)
        *-- Legado: pesopdrs de SigCdPro
        loc_oPg.AddObject("txt_4c_PesoPdrs", "TextBox")
        WITH loc_oPg.txt_4c_PesoPdrs
            .Top           = 277
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Say7: "Cor Padrao :" (T:306 L:72 W:63 H:15)
        loc_oPg.AddObject("lbl_4c_Label7FP", "Label")
        WITH loc_oPg.lbl_4c_Label7FP
            .Caption   = "Cor Padr" + CHR(227) + "o :"
            .Top       = 306
            .Left      = 72
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCor: cor padrao (T:302 L:137 W:38 H:23)
        *-- Legado: codcors de SigCdPro - LostFocus lookup SigCdCor
        loc_oPg.AddObject("txt_4c_Cor", "TextBox")
        WITH loc_oPg.txt_4c_Cor
            .Top           = 302
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "TxtCorLostFocus")

        *-- CheckBox opc_CravCera: "Cravacao em Cera" (T:306 L:180 W:120 H:15)
        *-- Legado: cravcers de SigCdPro (numeric 1,0 com semantica booleana)
        loc_oPg.AddObject("chk_4c_Opc_CravCera", "CheckBox")
        WITH loc_oPg.chk_4c_Opc_CravCera
            .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
            .Top       = 306
            .Left      = 180
            .Width     = 120
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Say2: "Tamanho Padrao :" (T:331 L:45 W:90 H:15)
        loc_oPg.AddObject("lbl_4c_Label2FP", "Label")
        WITH loc_oPg.lbl_4c_Label2FP
            .Caption   = "Tamanho Padr" + CHR(227) + "o :"
            .Top       = 331
            .Left      = 45
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getTam: tamanho padrao (T:327 L:137 W:38 H:23)
        *-- Legado: codtams de SigCdPro - LostFocus lookup SigCdTam
        loc_oPg.AddObject("txt_4c_Tam", "TextBox")
        WITH loc_oPg.txt_4c_Tam
            .Top           = 327
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "TxtTamLostFocus")

        *-- Label lblAcabamento: "Acabamento :" (T:356 L:16 W:119 H:15)
        loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
        WITH loc_oPg.lbl_4c_LblAcabamento
            .Caption   = "Acabamento :"
            .Top       = 356
            .Left      = 16
            .Width     = 119
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_codacb: codigo acabamento (T:352 L:137 W:38 H:23)
        *-- Legado: codacbs de SigCdPro - LostFocus lookup SigCdAca
        loc_oPg.AddObject("txt_4c__codacb", "TextBox")
        WITH loc_oPg.txt_4c__codacb
            .Top           = 352
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__codacb, "LostFocus", THIS, "TxtCodacbLostFocus")

        *-- TextBox get_Dacb: descricao acabamento (T:352 L:177 W:207 H:23)
        *-- Legado: When=.F. (readonly sempre) - preenchido pelo lookup de get_codacb
        loc_oPg.AddObject("txt_4c__Dacb", "TextBox")
        WITH loc_oPg.txt_4c__Dacb
            .Top           = 352
            .Left          = 177
            .Width         = 207
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(240, 240, 240)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Secao inferior esquerda: grdMatrizes + botoes + imagem borracha
        *----------------------------------------------------------------------

        *-- Grid grdMatrizes (T:380 L:7 W:246 H:240) - 3 colunas: Matriz|Local|Qtde
        *-- Legado: grdMatrizes com crSigPrMtz (matrizes do produto)
        loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
        loc_oGrd = loc_oPg.grd_4c_Matrizes

        WITH loc_oGrd
            .Top                = 380
            .Left               = 7
            .Width              = 246
            .Height             = 240
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ColumnCount        = 3
            .GridLines          = 3
            .GridLineWidth      = 1
            .GridLineColor      = RGB(238, 238, 238)
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .AllowRowSizing     = .F.
            .ReadOnly           = .F.
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(90, 90, 90)
            .HighlightBackColor = RGB(220, 230, 242)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2
            .Themes             = .F.
            .Visible            = .T.
        ENDWITH

        *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
        loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_SigPrMtz"

        *-- Configurar colunas APOS RecordSource
        WITH loc_oPg.grd_4c_Matrizes
            *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
            .Column1.Header1.Caption = "Matriz"
            .Column1.Width           = 70
            .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
            .Column1.Alignment       = 0
            .Column1.ReadOnly        = .F.

            *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
            .Column2.Header1.Caption = "Local"
            .Column2.Width           = 120
            .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
            .Column2.Alignment       = 0
            .Column2.ReadOnly        = .T.

            *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
            .Column3.Header1.Caption = "Qtde"
            .Column3.Width           = 56
            .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
            .Column3.Alignment       = 1
            .Column3.ReadOnly        = .F.
        ENDWITH

        *-- BINDEVENT: grdMatrizes
        BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
        BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")

        *----------------------------------------------------------------------
        *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
        *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnInsereMtx
            .Caption       = "+"
            .Top           = 380
            .Left          = 258
            .Width         = 38
            .Height        = 38
            .FontName      = "Tahoma"
            .FontSize      = 10
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 128, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")

        *----------------------------------------------------------------------
        *-- Botao Excluir Matriz (btnExcluiMtz: T:420 L:258 W:38 H:38)
        *-- Legado: btnExcluiMtz.Click - exclui linha de crSigPrMtz
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnExcluiMtz
            .Caption       = "-"
            .Top           = 420
            .Left          = 258
            .Width         = 38
            .Height        = 38
            .FontName      = "Tahoma"
            .FontSize      = 10
            .FontBold      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(192, 0, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")

        *----------------------------------------------------------------------
        *-- Shape: shpBorracha (T:464 L:258 W:236 H:156) - borda imagem borracha
        *----------------------------------------------------------------------
        loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
        WITH loc_oPg.shp_4c_ShpBorracha
            .Top         = 464
            .Left        = 258
            .Width       = 236
            .Height      = 156
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(192, 192, 192)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Image: ImgBorracha (T:465 L:260 W:232 H:154) - imagem borracha da matriz
        *-- Legado: GrdMatrizes.AfterRowColChange carrega SigCdPro da matriz corrente
        *----------------------------------------------------------------------
        loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
        WITH loc_oPg.img_4c_ImgBorracha
            .Top     = 465
            .Left    = 260
            .Width   = 232
            .Height  = 154
            .Picture = ""
            .Stretch = 2
            .Visible = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherCamposFaseP - Popula controles da aba FaseP a partir do BO
    * Chamado por BOParaForm apos carregar dados de SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencherCamposFaseP()
        LOCAL loc_oPg, loc_oPg1
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF VARTYPE(loc_oPg) # "O"
                RETURN
            ENDIF
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            WITH THIS.this_oBusinessObject
                IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
                    loc_oPg.txt_4c_Qmin.Value = IIF(.this_nQmins = 0, 0, .this_nQmins)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_CodGarras) = "O"
                    loc_oPg.txt_4c_CodGarras.Value = ALLTRIM(.this_cCodgarras)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
                    loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(.this_cConquilhas)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
                    loc_oPg.txt_4c_PesoBris.Value = .this_nPesobris
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
                    loc_oPg.txt_4c_PesoMetal.Value = .this_nPesometal
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
                    loc_oPg.txt_4c_PesoPdrs.Value = .this_nPesopdrs
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
                    loc_oPg.txt_4c_Cor.Value = ALLTRIM(.this_cCodcors)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
                    loc_oPg.txt_4c_Tam.Value = ALLTRIM(.this_cCodtams)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
                    loc_oPg.txt_4c__codacb.Value = ALLTRIM(.this_cCodacbs)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c__Dacb) = "O"
                    loc_oPg.txt_4c__Dacb.Value = ""
                ENDIF
                IF VARTYPE(loc_oPg.chk_4c_Opc_CravCera) = "O"
                    loc_oPg.chk_4c_Opc_CravCera.Value = IIF(.this_lCravcers, 1, 0)
                ENDIF
                IF VARTYPE(loc_oPg1) = "O" AND VARTYPE(loc_oPg1.chk_4c_Fwoption1) = "O"
                    loc_oPg1.chk_4c_Fwoption1.Value = IIF(.this_nProdvars = 1, 1, 0)
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preencher campos de Fases")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LerCamposFaseP - Le controles da aba FaseP e transfere para o BO
    * Chamado por FormParaBO antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LerCamposFaseP()
        LOCAL loc_oPg, loc_oPg1
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF VARTYPE(loc_oPg) # "O"
                RETURN
            ENDIF
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            WITH THIS.this_oBusinessObject
                IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
                    .this_nQmins = loc_oPg.txt_4c_Qmin.Value
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
                    .this_cConquilhas = ALLTRIM(loc_oPg.txt_4c_Conquilha.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
                    .this_nPesobris = loc_oPg.txt_4c_PesoBris.Value
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
                    .this_nPesometal = loc_oPg.txt_4c_PesoMetal.Value
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
                    .this_nPesopdrs = loc_oPg.txt_4c_PesoPdrs.Value
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
                    .this_cCodcors = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
                    .this_cCodtams = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
                    .this_cCodacbs = ALLTRIM(loc_oPg.txt_4c__codacb.Value)
                ENDIF
                IF VARTYPE(loc_oPg.chk_4c_Opc_CravCera) = "O"
                    .this_lCravcers = (loc_oPg.chk_4c_Opc_CravCera.Value = 1)
                ENDIF
                IF VARTYPE(loc_oPg1) = "O" AND VARTYPE(loc_oPg1.chk_4c_Fwoption1) = "O"
                    .this_nProdvars = IIF(loc_oPg1.chk_4c_Fwoption1.Value = 1, 1, 0)
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao ler campos de Fases")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradFaseAfterRowColChange - Atualiza imagem e descricao ao navegar GradFase
    * Legado: GradFase.AfterRowColChange (Procedure) - carrega FigProcs, Get_Desc, Get_Obs
    *--------------------------------------------------------------------------
    PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_lcArquivo
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF VARTYPE(loc_oPg) # "O"
                RETURN
            ENDIF

            *-- Atualizar descricao da fase (campo Descrs do cursor)
            IF VARTYPE(loc_oPg.txt_4c_Desc) = "O"
                loc_oPg.txt_4c_Desc.Value = ""
                IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                    loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
                ENDIF
            ENDIF

            *-- Atualizar observacoes da fase (campo Obs de crSigCdPrf se disponivel)
            IF VARTYPE(loc_oPg.obj_4c_Get_Obs) = "O"
                loc_oPg.obj_4c_Get_Obs.Value = ""
                IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                    IF TYPE("cursor_4c_GradFase.Obs") # "U"
                        loc_oPg.obj_4c_Get_Obs.Value = NVL(cursor_4c_GradFase.Obs, "")
                    ENDIF
                ENDIF
            ENDIF

            *-- Atualizar imagem da fase (campo FigProcs de crSigCdPrf se disponivel)
            IF VARTYPE(loc_oPg.img_4c_ImgFigJpg) = "O"
                CLEAR RESOURCES
                loc_oPg.img_4c_ImgFigJpg.Picture = ""
                loc_oPg.img_4c_ImgFigJpg.Visible = .F.
                IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                    IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
                        IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
                            loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                            IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
                                loc_oPg.img_4c_ImgFigJpg.Picture  = loc_lcArquivo
                                loc_oPg.img_4c_ImgFigJpg.Visible  = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            loc_oPg.grd_4c_GradFase.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar aba Fases")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradFaseCol1GotFocus - Salva valor atual de Ordem antes de editar
    * Legado: GradFase.Column1.Text1.GotFocus = "ThisForm.AntOrd = This.Value"
    *--------------------------------------------------------------------------
    PROCEDURE GradFaseCol1GotFocus()
        TRY
            IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                THIS.this_nAntOrdFase = cursor_4c_GradFase.Ordems
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao registrar ordem anterior")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradFaseCol1LostFocus - Resequencia fases se ordem foi alterada
    * Legado: GradFase.Column1.Text1.LostFocus - reordena SCAN por Ordem2
    *--------------------------------------------------------------------------
    PROCEDURE GradFaseCol1LostFocus()
        LOCAL loc_lResultado, loc_nPonteiro, loc_nNovaOrdem, loc_nOrdem2
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_nNovaOrdem = cursor_4c_GradFase.Ordems
                IF loc_nNovaOrdem <= 0 OR loc_nNovaOrdem = THIS.this_nAntOrdFase
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                *-- Calcular Ordem2 para resequenciamento
                loc_nPonteiro = RECNO("cursor_4c_GradFase")
                SELECT cursor_4c_GradFase
                SCAN
                    IF RECNO() # loc_nPonteiro
                        REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
                    ENDIF
                ENDSCAN
                GO loc_nPonteiro IN cursor_4c_GradFase
                SELECT cursor_4c_GradFase
                *-- Reordenar por Ordems para refletir nova sequencia
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
    * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
    *         Apos selecao: preenche Grupos e Descrs no cursor
    *--------------------------------------------------------------------------
    PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cAtual
        IF par_nKeyCode = 115  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            TRY
                loc_cAtual = ""
                IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                    loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cAtual, ;
                    "Buscar Fase de Produ" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                        IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                            SELECT cursor_4c_GradFase
                            REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
                            REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaGcr")
                    USE IN cursor_4c_BuscaGcr
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao buscar fase")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
    * Legado: Column4.Text1.Valid = fwBuscaInt on SigCdUpd filtered by Grupos
    *         Apos selecao: preenche UniPrdts no cursor
    *--------------------------------------------------------------------------
    PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cAtual, loc_cGrupos, loc_cSQL, loc_nRet
        IF par_nKeyCode = 115  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            TRY
                loc_cAtual  = ""
                loc_cGrupos = ""
                IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                    loc_cAtual  = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
                    loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
                ENDIF
                *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
                IF !EMPTY(loc_cGrupos)
                    loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
                ELSE
                    loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
                ENDIF
                IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
                        "Buscar Uni. Produtiva")
                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
                            loc_oBusca.Show()
                        ENDIF
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
                            IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                                SELECT cursor_4c_GradFase
                                REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
                            ENDIF
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                    IF USED("cursor_4c_BuscaUpd2")
                        USE IN cursor_4c_BuscaUpd2
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaUpd")
                    USE IN cursor_4c_BuscaUpd
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao buscar Uni. Produtiva")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt) para coluna MatPrdts
    * Legado: Column5.Text1.Valid = fwBuscaExt on SigOpOpt by Cods
    *         Apos selecao: preenche MatPrdts no cursor
    *--------------------------------------------------------------------------
    PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cAtual
        IF par_nKeyCode = 115  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            TRY
                loc_cAtual = ""
                IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                    loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigOpOpt", "cursor_4c_BuscaOpt", "Cods", loc_cAtual, ;
                    "Buscar Tipo de Material")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
                        IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                            SELECT cursor_4c_GradFase
                            REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaOpt")
                    USE IN cursor_4c_BuscaOpt
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao buscar material")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdMatrizesAfterRowColChange - Carrega imagem da borracha da matriz selecionada
    * Legado: grdMatrizes.Procedure(AfterRowColChange) - query SigCdPro e mostra FigJpgs
    *--------------------------------------------------------------------------
    PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_lcArquivo, loc_cSQL, loc_nRet
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF VARTYPE(loc_oPg) # "O"
                RETURN
            ENDIF

            *-- Limpar imagem anterior
            CLEAR RESOURCES
            loc_oPg.img_4c_ImgBorracha.Picture = ""
            loc_oPg.img_4c_ImgBorracha.Visible = .F.

            *-- Carregar imagem da borracha do produto-matriz corrente
            IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
                IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
                    loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
                    IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
                        GO TOP IN cursor_4c_LocalImgPro
                        IF !EOF("cursor_4c_LocalImgPro")
                            IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
                                IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
                                    loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
                                    IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
                                        loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
                                        loc_oPg.img_4c_ImgBorracha.Visible = .T.
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                        USE IN cursor_4c_LocalImgPro
                    ENDIF
                ENDIF
            ENDIF

            loc_oPg.grd_4c_Matrizes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar imagem da matriz")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdMatrizesCol1KeyPress - F4 abre lookup de Matrizes (cursor crMatrizes)
    * Legado: grdMatrizes.Column1.Text1.Valid = fwBuscaInt on crMatrizes by CPros
    *         Apos selecao: preenche CMats e DLocs no cursor_4c_SigPrMtz
    *--------------------------------------------------------------------------
    PROCEDURE GrdMatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cAtual
        IF par_nKeyCode = 115  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            TRY
                loc_cAtual = ""
                IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
                    loc_cAtual = ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, ""))
                ENDIF
                *-- Busca na tabela SigCdPro (produtos que sao matrizes)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BuscaMatriz", "CPros", loc_cAtual, ;
                    "Buscar Matriz")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CPros",  "", "Matriz")
                        loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Locals", "", "Local")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
                        IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
                            SELECT cursor_4c_SigPrMtz
                            REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
                            IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
                                REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaMatriz")
                    USE IN cursor_4c_BuscaMatriz
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao buscar matriz")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdIncluirFaseClick - Insere nova linha de fase em cursor_4c_GradFase
    * Legado: inserir.Click - calcula proximo Ordems e insere com resequenciamento
    *--------------------------------------------------------------------------
    PROCEDURE CmdIncluirFaseClick()
        LOCAL loc_oPg, loc_nOrdem
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF !USED("cursor_4c_GradFase")
                RETURN
            ENDIF
            *-- Calcular proximo numero de ordem
            loc_nOrdem = 0
            IF !EOF("cursor_4c_GradFase")
                SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
                IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
                    loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
                ENDIF
                IF USED("cursor_4c_TmpOrd")
                    USE IN cursor_4c_TmpOrd
                ENDIF
            ENDIF
            loc_nOrdem = loc_nOrdem + 1
            *-- Inserir nova linha
            INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
                VALUES (loc_nOrdem, "", "", "", "")
            *-- Posicionar no novo registro e focar grid
            GO BOTTOM IN cursor_4c_GradFase
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
                    loc_oPg.grd_4c_GradFase.Refresh()
                    loc_oPg.grd_4c_GradFase.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao incluir fase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
    * Legado: excluir.Click - DELETE e resequencia Ordems
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirFaseClick()
        LOCAL loc_oPg, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                IF !MsgConfirma("Excluir fase selecionada?")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                SELECT cursor_4c_GradFase
                DELETE
                IF !EOF("cursor_4c_GradFase")
                    SKIP
                ENDIF
                IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
                    GO BOTTOM IN cursor_4c_GradFase
                ENDIF
                *-- Resequenciar Ordems
                LOCAL loc_nSeq
                loc_nSeq = 1
                GO TOP IN cursor_4c_GradFase
                SCAN FOR !DELETED()
                    REPLACE Ordems WITH loc_nSeq
                    loc_nSeq = loc_nSeq + 1
                ENDSCAN
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                    IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
                        loc_oPg.grd_4c_GradFase.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir fase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAlternativaFaseClick - Copia linha corrente como alternativa
    * Legado: Alternativa.Click - duplica linha com mesmo Grupos mas nova Ordems
    *--------------------------------------------------------------------------
    PROCEDURE CmdAlternativaFaseClick()
        LOCAL loc_oPg, loc_lResultado, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat
        LOCAL loc_nOrdem
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                IF EMPTY(ALLTRIM(NVL(cursor_4c_GradFase.Grupos, "")))
                    MsgAviso("Selecione uma fase para criar alternativa.")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
                loc_cDescrs = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
                loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
                loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
                *-- Calcular proxima ordem
                SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
                loc_nOrdem = 1
                IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
                    loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
                ENDIF
                IF USED("cursor_4c_TmpAlt")
                    USE IN cursor_4c_TmpAlt
                ENDIF
                *-- Inserir copia como alternativa
                INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
                    VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
                GO BOTTOM IN cursor_4c_GradFase
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                    IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
                        loc_oPg.grd_4c_GradFase.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdFichaClick - Gera ficha tecnica do produto (REPORT FORM)
    * Legado: CmdFicha.Click - cria CsCabecalho cursor e REPORT FORM TP_FasePro
    *--------------------------------------------------------------------------
    PROCEDURE CmdFichaClick()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cNmEmp
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
                    MsgAviso("Produto n" + CHR(227) + "o selecionado.")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                *-- Nome da empresa ja disponivel em go_4c_Sistema.cEmpresa
                loc_cNmEmp = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
                *-- Preparar cursor de cabecalho para o relatorio
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                CREATE CURSOR CsCabecalho (;
                    _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
                    _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
                    _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
                    _nPeso N(9,2))
                WITH THIS.this_oBusinessObject
                    INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
                        VALUES (loc_cNmEmp, ;
                                "Ficha T" + CHR(233) + "cnica de Produto", ;
                                ALLTRIM(.this_cCpros), ;
                                ALLTRIM(.this_cDpros), ;
                                ALLTRIM(.this_cCgrus), ;
                                .this_nPesobs)
                ENDWITH
                *-- Verificar e executar relatorio
                LOCAL loc_cRepPath
                loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
                IF FILE(loc_cRepPath)
                    REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
                ELSE
                    MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
                ENDIF
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar ficha t" + CHR(233) + "cnica")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgFiguraClick - Seleciona imagem JPG/BMP para a fase corrente
    * Legado: cmdgFigura.Click - GETPICT e armazena em crSigCdPrf.FigProcs
    *--------------------------------------------------------------------------
    PROCEDURE CmdgFiguraClick()
        LOCAL loc_lResultado, loc_cFigura, loc_cArquivo
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                *-- Abrir seletor de arquivo de imagem
                loc_cFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
                    "Nome do Arquivo:", "Selecionar"))
                IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
                    *-- Armazenar imagem binaria no campo memo FigProcs
                    IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
                        SELECT cursor_4c_GradFase
                        REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
                    ENDIF
                    *-- Atualizar exibicao da imagem
                    THIS.GradFaseAfterRowColChange(0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
    * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
    *--------------------------------------------------------------------------
    PROCEDURE CmdgFigCamClick()
        LOCAL loc_lResultado, loc_cFigura
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_cFigura = ""
                *-- Acionar captura de webcam via form legado SigImage
                IF FILE(gc_4c_CaminhoBase + "SigImage.scx")
                    DO FORM (gc_4c_CaminhoBase + "SigImage") TO loc_cFigura
                ELSE
                    MsgAviso("Captura de imagem (SigImage) n" + CHR(227) + "o dispon" + CHR(237) + "vel.")
                    loc_lResultado = .F.
                ENDIF
                IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
                    IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
                        SELECT cursor_4c_GradFase
                        REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
                    ENDIF
                    THIS.GradFaseAfterRowColChange(0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
    * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick()
        LOCAL loc_lcArquivo
        TRY
            IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
                IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
                    IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
                        loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_zoom.jpg"
                        IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
                            IF FILE(loc_lcArquivo)
                                DO FORM SigOpZom WITH loc_lcArquivo, .F.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
    * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
    *--------------------------------------------------------------------------
    PROCEDURE BtnInsereMtxClick()
        LOCAL loc_oPg, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_SigPrMtz")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                *-- Verificar se ja existe linha vazia (evitar duplicatas)
                GO TOP IN cursor_4c_SigPrMtz
                LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
                IF !EOF("cursor_4c_SigPrMtz")
                    *-- Ja existe linha vazia - apenas focar
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
                GO BOTTOM IN cursor_4c_SigPrMtz
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
                    loc_oPg.grd_4c_Matrizes.Refresh()
                    loc_oPg.grd_4c_Matrizes.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
    * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluiMtzClick()
        LOCAL loc_oPg, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                SELECT cursor_4c_SigPrMtz
                DELETE
                *-- Se cursor ficou vazio, reinsere linha placeholder
                GO TOP IN cursor_4c_SigPrMtz
                LOCATE FOR !DELETED()
                IF EOF("cursor_4c_SigPrMtz")
                    INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
                ENDIF
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
                    loc_oPg.grd_4c_Matrizes.Refresh()
                    loc_oPg.grd_4c_Matrizes.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodacbLostFocus - Valida e busca acabamento (SigCdAca) ao sair do campo
    * Legado: get_codacb.Valid = fwBuscaExt on SigCdAca by Cods
    *         Apos selecao: preenche txt_4c__Dacb e atualiza BO
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodacbLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c__codacb.Value, ""))
                IF EMPTY(loc_cCod)
                    loc_oPg.txt_4c__Dacb.Value = ""
                    THIS.this_oBusinessObject.this_cCodacbs = ""
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdAca", "cursor_4c_BuscaAca", "Cods", loc_cCod, ;
                    "Buscar Acabamento")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAca")
                        loc_oPg.txt_4c__codacb.Value = ALLTRIM(NVL(cursor_4c_BuscaAca.Cods, ""))
                        loc_oPg.txt_4c__Dacb.Value   = ALLTRIM(NVL(cursor_4c_BuscaAca.Descrs, ""))
                        THIS.this_oBusinessObject.this_cCodacbs = loc_oPg.txt_4c__codacb.Value
                    ELSE
                        loc_oPg.txt_4c__codacb.Value = ""
                        loc_oPg.txt_4c__Dacb.Value   = ""
                        THIS.this_oBusinessObject.this_cCodacbs = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaAca")
                    USE IN cursor_4c_BuscaAca
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTamLostFocus - Valida e busca tamanho (SigCdTam) ao sair do campo
    * Legado: getTam.Valid = fwBuscaExt on SigCdTam by Cods
    *--------------------------------------------------------------------------
    PROCEDURE TxtTamLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaTam
            loc_cGuardaTam = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Tam.Value, ""))
            IF loc_cGuardaTam = THIS.this_cUltimoTxtTamLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtTamLostFocusValidado = loc_cGuardaTam
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Tam.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cCodtams = ""
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdTam", "cursor_4c_BuscaTam", "Cods", loc_cCod, ;
                    "Buscar Tamanho Padr" + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                        loc_oPg.txt_4c_Tam.Value = ALLTRIM(NVL(cursor_4c_BuscaTam.Cods, ""))
                        THIS.this_oBusinessObject.this_cCodtams = loc_oPg.txt_4c_Tam.Value
                    ELSE
                        loc_oPg.txt_4c_Tam.Value = ""
                        THIS.this_oBusinessObject.this_cCodtams = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaTam")
                    USE IN cursor_4c_BuscaTam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar tamanho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCorLostFocus - Valida e busca cor padrao (SigCdCor) ao sair do campo
    * Legado: getCor.Valid = fwBuscaExt on SigCdCor by Cods
    *--------------------------------------------------------------------------
    PROCEDURE TxtCorLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaCor
            loc_cGuardaCor = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Cor.Value, ""))
            IF loc_cGuardaCor = THIS.this_cUltimoTxtCorLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtCorLostFocusValidado = loc_cGuardaCor
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Cor.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cCodcors = ""
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cCod, ;
                    "Buscar Cor Padr" + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
                        loc_oPg.txt_4c_Cor.Value = ALLTRIM(NVL(cursor_4c_BuscaCor.cods, ""))
                        THIS.this_oBusinessObject.this_cCodcors = loc_oPg.txt_4c_Cor.Value
                    ELSE
                        loc_oPg.txt_4c_Cor.Value = ""
                        THIS.this_oBusinessObject.this_cCodcors = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaCor")
                    USE IN cursor_4c_BuscaCor
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar cor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
    * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
    *--------------------------------------------------------------------------
    PROCEDURE TxtConquilhaLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaCnq
            loc_cGuardaCnq = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Conquilha.Value, ""))
            IF loc_cGuardaCnq = THIS.this_cUltimoTxtConquilhaLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtConquilhaLostFocusValidado = loc_cGuardaCnq
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Conquilha.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cConquilhas = ""
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                *-- Buscar conquilhas disponiveis em SigCdCnq
                loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
                IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
                    SELECT cursor_4c_ListaCnq
                    LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
                    IF !EOF("cursor_4c_ListaCnq")
                        *-- Encontrado direto
                        loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
                        THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
                    ELSE
                        *-- Nao encontrado - abrir lookup
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
                            "Buscar Conquilha")
                        IF VARTYPE(loc_oBusca) = "O"
                            IF !loc_oBusca.this_lAchouRegistro
                                loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
                                loc_oBusca.Show()
                            ENDIF
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnq")
                                loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(NVL(cursor_4c_BuscaCnq.conquilhas, ""))
                                THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
                            ELSE
                                loc_oPg.txt_4c_Conquilha.Value = ""
                                THIS.this_oBusinessObject.this_cConquilhas = ""
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                        IF USED("cursor_4c_BuscaCnq")
                            USE IN cursor_4c_BuscaCnq
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_ListaCnq
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar conquilha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FASE 13 - Aba Dados Fiscais (pgDadosFiscais - Page3 do pgf_4c_Dados)
    * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais
    * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
    * Controles: 16 textboxes, 11 labels, 1 editbox, 1 combobox, 1 grid(3col), 1 button
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgDadosFiscais()
        LOCAL loc_oPg, loc_oGrd
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

        *----------------------------------------------------------------------
        *-- Cursor placeholder cursor_4c_Cmv (SigCdCmv - Valor Grama)
        *-- Campos: Datas, ValCuss, Moedas (readonly grid)
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_Cmv")
            SET NULL ON
            CREATE CURSOR cursor_4c_Cmv (;
                Datas   D, ;
                ValCuss N(12,3), ;
                Moedas  C(3))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
        WITH loc_oPg.lbl_4c_LblGruCus
            .Caption   = "Grupo C.C. :"
            .Top       = 165
            .Left      = 138
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")
        WITH loc_oPg.lbl_4c_LblContaCus
            .Caption   = "Conta C.C. :"
            .Top       = 189
            .Left      = 138
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say1: "Classificacao Fiscal :" (T:216 L:102 W:99)
        loc_oPg.AddObject("lbl_4c_LblClfiscal", "Label")
        WITH loc_oPg.lbl_4c_LblClfiscal
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
            .Top       = 216
            .Left      = 102
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say2: "Origem da Mercadoria :" (T:241 L:87 W:114)
        loc_oPg.AddObject("lbl_4c_LblOrigmerc", "Label")
        WITH loc_oPg.lbl_4c_LblOrigmerc
            .Caption   = "Origem da Mercadoria :"
            .Top       = 241
            .Left      = 87
            .Width     = 114
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say3: "Situacao Tributaria ICMS :" (T:266 L:74 W:127)
        loc_oPg.AddObject("lbl_4c_LblSittricm", "Label")
        WITH loc_oPg.lbl_4c_LblSittricm
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
            .Top       = 266
            .Left      = 74
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say6: "Codigo de Servicos para ICMS :" (T:291 L:48 W:153)
        loc_oPg.AddObject("lbl_4c_LblCodServs", "Label")
        WITH loc_oPg.lbl_4c_LblCodServs
            .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
            .Top       = 291
            .Left      = 48
            .Width     = 153
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say8: "Aliquota ICMS :" (T:291 L:250 W:76)
        loc_oPg.AddObject("lbl_4c_LblIcms", "Label")
        WITH loc_oPg.lbl_4c_LblIcms
            .Caption   = "Al" + CHR(237) + "quota ICMS :"
            .Top       = 291
            .Left      = 250
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say4: "Tipo de Tributacao :" (T:291 L:395 W:98)
        loc_oPg.AddObject("lbl_4c_LblTpTrib", "Label")
        WITH loc_oPg.lbl_4c_LblTpTrib
            .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
            .Top       = 291
            .Left      = 395
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say41: "IAT :" (T:290 L:558 W:26)
        loc_oPg.AddObject("lbl_4c_LblIat", "Label")
        WITH loc_oPg.lbl_4c_LblIat
            .Caption   = "IAT :"
            .Top       = 290
            .Left      = 558
            .Width     = 26
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say42: "[A]rredondamento [T]runcamento" (T:290 L:609 W:165)
        loc_oPg.AddObject("lbl_4c_LblIatDesc", "Label")
        WITH loc_oPg.lbl_4c_LblIatDesc
            .Caption   = "[A]rredondamento [T]runcamento"
            .Top       = 290
            .Left      = 609
            .Width     = 165
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say5: "Situacao Tributaria IPI :" (T:316 L:85 W:116)
        loc_oPg.AddObject("lbl_4c_LblIpi", "Label")
        WITH loc_oPg.lbl_4c_LblIpi
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
            .Top       = 316
            .Left      = 85
            .Width     = 116
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say_AliqIPI: "Aliquota de IPI :" (T:316 L:327 W:80)
        loc_oPg.AddObject("lbl_4c_LblAliqIPI", "Label")
        WITH loc_oPg.lbl_4c_LblAliqIPI
            .Caption   = "Al" + CHR(237) + "quota de IPI :"
            .Top       = 316
            .Left      = 327
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say13: "Excecao da TIPI :" (T:316 L:495 W:87)
        loc_oPg.AddObject("lbl_4c_LblExtipi", "Label")
        WITH loc_oPg.lbl_4c_LblExtipi
            .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
            .Top       = 316
            .Left      = 495
            .Width     = 87
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say18: "Descricao Fiscal :" (T:341 L:117 W:84)
        loc_oPg.AddObject("lbl_4c_LblDescfis", "Label")
        WITH loc_oPg.lbl_4c_LblDescfis
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
            .Top       = 341
            .Left      = 117
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say12: "Descricao ECF :" (T:433 L:124 W:77)
        loc_oPg.AddObject("lbl_4c_LblDescEcf", "Label")
        WITH loc_oPg.lbl_4c_LblDescEcf
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
            .Top       = 433
            .Left      = 124
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say11: "Metal :" (T:433 L:494 W:35)
        loc_oPg.AddObject("lbl_4c_LblMetal", "Label")
        WITH loc_oPg.lbl_4c_LblMetal
            .Caption   = "Metal :"
            .Top       = 433
            .Left      = 494
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say7: "Valor Estimado :" (T:458 L:122 W:79)
        loc_oPg.AddObject("lbl_4c_LblValor", "Label")
        WITH loc_oPg.lbl_4c_LblValor
            .Caption   = "Valor Estimado :"
            .Top       = 458
            .Left      = 122
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say15: "Teor :" (T:458 L:498 W:31)
        loc_oPg.AddObject("lbl_4c_LblTeor", "Label")
        WITH loc_oPg.lbl_4c_LblTeor
            .Caption   = "Teor :"
            .Top       = 458
            .Left      = 498
            .Width     = 31
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say10: "IPPT/CST :" (T:483 L:147 W:54)
        loc_oPg.AddObject("lbl_4c_LblIpptCST", "Label")
        WITH loc_oPg.lbl_4c_LblIpptCST
            .Caption   = "IPPT/CST :"
            .Top       = 483
            .Left      = 147
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say9: "Valor do Grama Produzido" (T:320 L:756 W:125)
        loc_oPg.AddObject("lbl_4c_LblGramPro", "Label")
        WITH loc_oPg.lbl_4c_LblGramPro
            .Caption   = "Valor do Grama Produzido"
            .Top       = 320
            .Left      = 756
            .Width     = 125
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- TextBoxes da area de Contabilidade (top area)
        *----------------------------------------------------------------------
        *-- get_gruccus: Grupo de Custo (T:161 L:206 W:80 H:23)
        loc_oPg.AddObject("txt_4c_Gruccus", "TextBox")
        WITH loc_oPg.txt_4c_Gruccus
            .Top           = 161
            .Left          = 206
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Gruccus, "LostFocus", THIS, "TxtGruccusFiscLostFocus")

        *-- get_dgruccus: Descricao Grupo CC (T:161 L:288 W:318 H:23) readonly
        loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
        WITH loc_oPg.txt_4c_Dgruccus
            .Top           = 161
            .Left          = 288
            .Width         = 318
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- get_contaccus: Conta de Custo (T:186 L:206 W:80 H:23)
        loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
        WITH loc_oPg.txt_4c_Contaccus
            .Top           = 186
            .Left          = 206
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Contaccus, "LostFocus", THIS, "TxtContaccusFiscLostFocus")

        *-- get_dcontaccus: Descricao Conta CC (T:186 L:288 W:318 H:23) readonly
        loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
        WITH loc_oPg.txt_4c_Dcontaccus
            .Top           = 186
            .Left          = 288
            .Width         = 318
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- TextBoxes da area Fiscal Principal
        *----------------------------------------------------------------------
        *-- getClfiscal: Classificacao Fiscal (T:211 L:206 W:94 H:23)
        loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
        WITH loc_oPg.txt_4c_Clfiscal
            .Top           = 211
            .Left          = 206
            .Width         = 94
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Clfiscal, "LostFocus", THIS, "TxtClfiscalFiscLostFocus")

        *-- getDclfiscal: Descricao Classif. Fiscal (T:211 L:303 W:303 H:23) readonly
        loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
        WITH loc_oPg.txt_4c_Dclfiscal
            .Top           = 211
            .Left          = 303
            .Width         = 303
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "TxtDclfiscalFiscLostFocus")

        *-- getOrigmerc: Origem Mercadoria (T:236 L:206 W:17 H:23)
        loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
        WITH loc_oPg.txt_4c_Origmerc
            .Top           = 236
            .Left          = 206
            .Width         = 17
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Origmerc, "LostFocus", THIS, "TxtOrigmercFiscLostFocus")

        *-- getDorigmerc: Descricao Origem (T:236 L:226 W:380 H:23)
        *-- Visivel apenas quando Origmerc vazio (readonly com busca reversa)
        loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
        WITH loc_oPg.txt_4c_Dorigmerc
            .Top           = 236
            .Left          = 226
            .Width         = 380
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- getSittricm: Situacao Tributaria ICMS (T:261 L:206 W:31 H:23)
        loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
        WITH loc_oPg.txt_4c_Sittricm
            .Top           = 261
            .Left          = 206
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Sittricm, "LostFocus", THIS, "TxtSittricmFiscLostFocus")

        *-- getDsittricm: Descricao Sit. Trib. ICMS (T:261 L:240 W:366 H:23) readonly
        loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
        WITH loc_oPg.txt_4c_Dsittricm
            .Top           = 261
            .Left          = 240
            .Width         = 366
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Get_CodServs: Cod. Servicos ICMS (T:286 L:206 W:38 H:23)
        loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
        WITH loc_oPg.txt_4c_CodServs
            .Top           = 286
            .Left          = 206
            .Width         = 38
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodServs, "LostFocus", THIS, "TxtCodServsFiscLostFocus")

        *-- getIcms: Aliquota ICMS (T:286 L:342 W:45 H:23)
        loc_oPg.AddObject("txt_4c_Icms", "TextBox")
        WITH loc_oPg.txt_4c_Icms
            .Top           = 286
            .Left          = 342
            .Width         = 45
            .Height        = 23
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Get_TpTrib: Tipo Tributacao (T:286 L:513 W:38 H:23)
        loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
        WITH loc_oPg.txt_4c_TpTrib
            .Top           = 286
            .Left          = 513
            .Width         = 38
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_TpTrib, "LostFocus", THIS, "TxtTpTribFiscLostFocus")

        *-- getiat: IAT - Arredondamento/Truncamento (T:286 L:589 W:17 H:23) MaxLength=1
        loc_oPg.AddObject("txt_4c_Iat", "TextBox")
        WITH loc_oPg.txt_4c_Iat
            .Top           = 286
            .Left          = 589
            .Width         = 17
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .MaxLength     = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "TxtIatFiscLostFocus")

        *----------------------------------------------------------------------
        *-- ComboBox cmbIpi: Tipo IPI (T:311 L:206 W:108 H:25)
        *-- Items: '' | Tributado | Isento | Outros
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmb_4c_Ipi", "ComboBox")
        WITH loc_oPg.cmb_4c_Ipi
            .Top           = 311
            .Left          = 206
            .Width         = 108
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Style         = 2
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        loc_oPg.cmb_4c_Ipi.Clear()
        loc_oPg.cmb_4c_Ipi.AddItem(PADR("", 10))
        loc_oPg.cmb_4c_Ipi.AddItem("Tributado")
        loc_oPg.cmb_4c_Ipi.AddItem("Isento   ")
        loc_oPg.cmb_4c_Ipi.AddItem("Outros   ")

        *-- Get_AliqIPI: Aliquota IPI (T:311 L:425 W:45 H:25)
        loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
        WITH loc_oPg.txt_4c_AliqIPI
            .Top           = 311
            .Left          = 425
            .Width         = 45
            .Height        = 25
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- getextipi: Excecao TIPI (T:311 L:601 W:35 H:25)
        loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
        WITH loc_oPg.txt_4c_Extipi
            .Top           = 311
            .Left          = 601
            .Width         = 35
            .Height        = 25
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- btnDescFis: Gerar Descricao Fiscal (T:359 L:162 W:32 H:32)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_DescFis", "CommandButton")
        WITH loc_oPg.cmd_4c_DescFis
            .Top             = 359
            .Left            = 162
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.bmp"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_DescFis, "Click", THIS, "CmdDescFisClick")

        *----------------------------------------------------------------------
        *-- EditBox mgetdescfi: Descricao Fiscal (T:338 L:206 W:509 H:89)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("obj_4c_Descfis", "EditBox")
        WITH loc_oPg.obj_4c_Descfis
            .Top           = 338
            .Left          = 206
            .Width         = 509
            .Height        = 89
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- TextBoxes area ECF / Metal / Teor / Valor
        *----------------------------------------------------------------------
        *-- getDescEcfs: Descricao ECF (T:429 L:206 W:213 H:23)
        loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
        WITH loc_oPg.txt_4c_DescEcfs
            .Top           = 429
            .Left          = 206
            .Width         = 213
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .MaxLength     = 29
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Get_metal: Metal (T:429 L:537 W:24 H:23)
        loc_oPg.AddObject("txt_4c_Metal", "TextBox")
        WITH loc_oPg.txt_4c_Metal
            .Top           = 429
            .Left          = 537
            .Width         = 24
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Metal, "LostFocus", THIS, "TxtMetalFiscLostFocus")

        *-- Get_DesMetal: Descricao Metal (T:429 L:564 W:150 H:23) readonly
        loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
        WITH loc_oPg.txt_4c_DesMetal
            .Top           = 429
            .Left          = 564
            .Width         = 150
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- getValor: Valor Estimado (T:454 L:206 W:108 H:23) numeric
        loc_oPg.AddObject("txt_4c_ValorEstim", "TextBox")
        WITH loc_oPg.txt_4c_ValorEstim
            .Top           = 454
            .Left          = 206
            .Width         = 108
            .Height        = 23
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- GetMvalor: Moeda do Valor (T:454 L:317 W:31 H:23) - lookup SigCdMoe
        loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
        WITH loc_oPg.txt_4c_Mvalor
            .Top           = 454
            .Left          = 317
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Mvalor, "LostFocus", THIS, "TxtMvalorFiscLostFocus")

        *-- Get_teor: Teor (T:454 L:537 W:24 H:23)
        loc_oPg.AddObject("txt_4c_Teor", "TextBox")
        WITH loc_oPg.txt_4c_Teor
            .Top           = 454
            .Left          = 537
            .Width         = 24
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Teor, "LostFocus", THIS, "TxtTeorFiscLostFocus")

        *-- Get_DesTeor: Descricao Teor (T:454 L:564 W:150 H:23) readonly
        loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
        WITH loc_oPg.txt_4c_DesTeor
            .Top           = 454
            .Left          = 564
            .Width         = 150
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- getIPPTCST: IPPT/CST (T:479 L:206 W:108 H:23) readonly (When=.f.)
        loc_oPg.AddObject("txt_4c_IpptCST", "TextBox")
        WITH loc_oPg.txt_4c_IpptCST
            .Top           = 479
            .Left          = 206
            .Width         = 108
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grid grdCmv: Valor do Grama Produzido (T:338 L:754 W:223 H:141)
        *-- Colunas: Periodo | Valor Custo GR | Moe (readonly)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_Cmv", "Grid")
        WITH loc_oPg.grd_4c_Cmv
            .Top         = 338
            .Left        = 754
            .Width       = 223
            .Height      = 141
            .ColumnCount = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RowHeight   = 17
            .DeleteMark  = .F.
            .RecordMark  = .T.
            .ReadOnly    = .T.
            .ScrollBars  = 3
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
        loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
        WITH loc_oPg.grd_4c_Cmv
            .Column1.ControlSource    = "cursor_4c_Cmv.Datas"
            .Column1.Header1.Caption  = "Per" + CHR(237) + "odo"
            .Column1.Header1.FontName = "Tahoma"
            .Column1.Header1.FontSize = 8
            .Column1.Width            = 59
            .Column1.Movable          = .F.
            .Column1.Resizable        = .F.
            .Column1.ReadOnly         = .T.
            .Column2.ControlSource    = "cursor_4c_Cmv.ValCuss"
            .Column2.Header1.Caption  = "Valor Custo GR"
            .Column2.Header1.FontName = "Tahoma"
            .Column2.Header1.FontSize = 8
            .Column2.Width            = 100
            .Column2.Movable          = .F.
            .Column2.Resizable        = .F.
            .Column2.ReadOnly         = .T.
            .Column3.ControlSource    = "cursor_4c_Cmv.Moedas"
            .Column3.Header1.Caption  = "Moe"
            .Column3.Header1.FontName = "Tahoma"
            .Column3.Header1.FontSize = 8
            .Column3.Width            = 31
            .Column3.Movable          = .F.
            .Column3.Resizable        = .F.
            .Column3.ReadOnly         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
    * Chamado por BOParaForm apos carregar dados de SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencherCamposFiscais()
        LOCAL loc_oPg, loc_cIpiVal
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF VARTYPE(loc_oPg) # "O"
                RETURN
            ENDIF
            WITH THIS.this_oBusinessObject
                IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
                    loc_oPg.txt_4c_Gruccus.Value = ALLTRIM(.this_cGruccus)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
                    loc_oPg.txt_4c_Contaccus.Value = ALLTRIM(.this_cContaccus)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
                    loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(.this_cClfiscals)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
                    loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(.this_cOrigmercs)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
                    loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(.this_cSittricms)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
                    loc_oPg.txt_4c_CodServs.Value = ALLTRIM(.this_cCodservs)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
                    loc_oPg.txt_4c_Icms.Value = .this_nIcms
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
                    loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(.this_cTptribs)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
                    loc_oPg.txt_4c_Iat.Value = ALLTRIM(.this_cIats)
                ENDIF
                *-- cmbIpi: converte this_cIpis (T/I/O/'') para texto do combo
                IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
                    DO CASE
                    CASE UPPER(ALLTRIM(.this_cIpis)) = "T"
                        loc_cIpiVal = "Tributado"
                    CASE UPPER(ALLTRIM(.this_cIpis)) = "I"
                        loc_cIpiVal = "Isento   "
                    CASE UPPER(ALLTRIM(.this_cIpis)) = "O"
                        loc_cIpiVal = "Outros   "
                    OTHERWISE
                        loc_cIpiVal = PADR("", 10)
                    ENDCASE
                    loc_oPg.cmb_4c_Ipi.Value = loc_cIpiVal
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_AliqIPI) = "O"
                    loc_oPg.txt_4c_AliqIPI.Value = .this_nAliqipis
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Extipi) = "O"
                    loc_oPg.txt_4c_Extipi.Value = ALLTRIM(.this_cExtipi)
                ENDIF
                IF VARTYPE(loc_oPg.obj_4c_Descfis) = "O"
                    loc_oPg.obj_4c_Descfis.Value = ALLTRIM(.this_cDescfis)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_DescEcfs) = "O"
                    loc_oPg.txt_4c_DescEcfs.Value = ALLTRIM(.this_cDescecfs)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Metal) = "O"
                    loc_oPg.txt_4c_Metal.Value = ALLTRIM(.this_cMetals)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_ValorEstim) = "O"
                    loc_oPg.txt_4c_ValorEstim.Value = .this_nValors
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Mvalor) = "O"
                    loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(.this_cMoedas)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Teor) = "O"
                    loc_oPg.txt_4c_Teor.Value = ALLTRIM(.this_cTeors)
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preencher campos Fiscais")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LerCamposFiscais - Le controles de pgDadosFiscais e transfere para o BO
    * Chamado por FormParaBO antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LerCamposFiscais()
        LOCAL loc_oPg, loc_cIpiTxt
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF VARTYPE(loc_oPg) # "O"
                RETURN
            ENDIF
            WITH THIS.this_oBusinessObject
                IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
                    .this_cGruccus = ALLTRIM(loc_oPg.txt_4c_Gruccus.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
                    .this_cContaccus = ALLTRIM(loc_oPg.txt_4c_Contaccus.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
                    .this_cClfiscals = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
                    .this_cOrigmercs = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
                    .this_cSittricms = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
                    .this_cCodservs = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
                    .this_nIcms = loc_oPg.txt_4c_Icms.Value
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
                    .this_cTptribs = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
                    .this_cIats = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
                ENDIF
                *-- cmbIpi: converte texto para char(1)
                IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
                    loc_cIpiTxt = UPPER(LEFT(ALLTRIM(loc_oPg.cmb_4c_Ipi.Value), 1))
                    IF INLIST(loc_cIpiTxt, "T", "I", "O")
                        .this_cIpis = loc_cIpiTxt
                    ELSE
                        .this_cIpis = ""
                    ENDIF
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_AliqIPI) = "O"
                    .this_nAliqipis = loc_oPg.txt_4c_AliqIPI.Value
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Extipi) = "O"
                    .this_cExtipi = ALLTRIM(loc_oPg.txt_4c_Extipi.Value)
                ENDIF
                IF VARTYPE(loc_oPg.obj_4c_Descfis) = "O"
                    .this_cDescfis = loc_oPg.obj_4c_Descfis.Value
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_DescEcfs) = "O"
                    .this_cDescecfs = ALLTRIM(loc_oPg.txt_4c_DescEcfs.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Metal) = "O"
                    .this_cMetals = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_ValorEstim) = "O"
                    .this_nValors = loc_oPg.txt_4c_ValorEstim.Value
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Mvalor) = "O"
                    .this_cMoedas = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Teor) = "O"
                    .this_cTeors = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao ler campos Fiscais")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtClfiscalFiscLostFocus - Lookup SigCdClf por Codigos
    *--------------------------------------------------------------------------
    PROCEDURE TxtClfiscalFiscLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaClf
            loc_cGuardaClf = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Clfiscal.Value, ""))
            IF loc_cGuardaClf = THIS.this_cUltimoTxtClfiscalLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtClfiscalLostFocusValidado = loc_cGuardaClf
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cClfiscals = ""
                    IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
                        loc_oPg.txt_4c_Dclfiscal.Value = ""
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdClf", "cursor_4c_BuscaClf", "Codigos", loc_cCod, ;
                    "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
                        loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Codigos, ""))
                        IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
                            loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Descricaos, ""))
                        ENDIF
                        THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
                    ELSE
                        loc_oPg.txt_4c_Clfiscal.Value = ""
                        IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
                            loc_oPg.txt_4c_Dclfiscal.Value = ""
                        ENDIF
                        THIS.this_oBusinessObject.this_cClfiscals = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaClf")
                    USE IN cursor_4c_BuscaClf
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDclfiscalFiscLostFocus - Busca reversa SigCdClf por Descricaos
    * Ativado quando getClfiscal esta vazio
    *--------------------------------------------------------------------------
    PROCEDURE TxtDclfiscalFiscLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cDesc, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaDClf
            loc_cGuardaDClf = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Dclfiscal.Value, ""))
            IF loc_cGuardaDClf = THIS.this_cUltimoTxtDclfiscalLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtDclfiscalLostFocusValidado = loc_cGuardaDClf
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                *-- Apenas ativo quando codigo vazio
                IF NOT EMPTY(ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, "")))
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_cDesc = ALLTRIM(NVL(loc_oPg.txt_4c_Dclfiscal.Value, ""))
                IF EMPTY(loc_cDesc)
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdClf", "cursor_4c_BuscaClfR", "Descricaos", loc_cDesc, ;
                    "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfR")
                        loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(NVL(cursor_4c_BuscaClfR.Codigos, ""))
                        loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClfR.Descricaos, ""))
                        THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaClfR")
                    USE IN cursor_4c_BuscaClfR
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOrigmercFiscLostFocus - Lookup SigCdOrg por Codigos (origem mercadoria)
    *--------------------------------------------------------------------------
    PROCEDURE TxtOrigmercFiscLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaOrg
            loc_cGuardaOrg = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Origmerc.Value, ""))
            IF loc_cGuardaOrg = THIS.this_cUltimoTxtOrigmercLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtOrigmercLostFocusValidado = loc_cGuardaOrg
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Origmerc.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cOrigmercs = ""
                    IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
                        loc_oPg.txt_4c_Dorigmerc.Value = ""
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", loc_cCod, ;
                    "Buscar Origem da Mercadoria")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
                        loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Codigos, ""))
                        IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
                            loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Descricaos, ""))
                        ENDIF
                        THIS.this_oBusinessObject.this_cOrigmercs = loc_oPg.txt_4c_Origmerc.Value
                    ELSE
                        loc_oPg.txt_4c_Origmerc.Value = ""
                        IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
                            loc_oPg.txt_4c_Dorigmerc.Value = ""
                        ENDIF
                        THIS.this_oBusinessObject.this_cOrigmercs = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaOrg")
                    USE IN cursor_4c_BuscaOrg
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar origem da mercadoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSittricmFiscLostFocus - Lookup SigCdIcm por Codigos (sit. trib. ICMS)
    *--------------------------------------------------------------------------
    PROCEDURE TxtSittricmFiscLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaIcm
            loc_cGuardaIcm = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Sittricm.Value, ""))
            IF loc_cGuardaIcm = THIS.this_cUltimoTxtSittricmLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtSittricmLostFocusValidado = loc_cGuardaIcm
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Sittricm.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cSittricms = ""
                    IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
                        loc_oPg.txt_4c_Dsittricm.Value = ""
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", loc_cCod, ;
                    "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
                        loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Codigos, ""))
                        IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
                            loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Descricaos, ""))
                        ENDIF
                        THIS.this_oBusinessObject.this_cSittricms = loc_oPg.txt_4c_Sittricm.Value
                    ELSE
                        loc_oPg.txt_4c_Sittricm.Value = ""
                        IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
                            loc_oPg.txt_4c_Dsittricm.Value = ""
                        ENDIF
                        THIS.this_oBusinessObject.this_cSittricms = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaIcm")
                    USE IN cursor_4c_BuscaIcm
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodServsFiscLostFocus - Armazena codigo de servicos no BO
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodServsFiscLostFocus()
        LOCAL loc_oPg
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
                    THIS.this_oBusinessObject.this_cCodservs = ALLTRIM(NVL(loc_oPg.txt_4c_CodServs.Value, ""))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar c" + CHR(243) + "digo de servi" + CHR(231) + "os")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTpTribFiscLostFocus - Lookup SigPrTri por Tipos (tipo tributacao)
    *--------------------------------------------------------------------------
    PROCEDURE TxtTpTribFiscLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaTri
            loc_cGuardaTri = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_TpTrib.Value, ""))
            IF loc_cGuardaTri = THIS.this_cUltimoTxtTpTribLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtTpTribLostFocusValidado = loc_cGuardaTri
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_TpTrib.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cTptribs = ""
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigPrTri", "cursor_4c_BuscaTri", "Tipos", loc_cCod, ;
                    "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Tipos", "", "Tipo")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
                        loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(NVL(cursor_4c_BuscaTri.Tipos, ""))
                        THIS.this_oBusinessObject.this_cTptribs = loc_oPg.txt_4c_TpTrib.Value
                    ELSE
                        loc_oPg.txt_4c_TpTrib.Value = ""
                        THIS.this_oBusinessObject.this_cTptribs = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaTri")
                    USE IN cursor_4c_BuscaTri
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar tipo de tributa" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtIatFiscLostFocus - Valida IAT: apenas 'A', 'T' ou vazio
    *--------------------------------------------------------------------------
    PROCEDURE TxtIatFiscLostFocus()
        LOCAL loc_oPg, loc_cVal
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
                    loc_cVal = UPPER(ALLTRIM(NVL(loc_oPg.txt_4c_Iat.Value, "")))
                    IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
                        MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                            "Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
                        loc_oPg.txt_4c_Iat.Value = ""
                        THIS.this_oBusinessObject.this_cIats = ""
                    ELSE
                        THIS.this_oBusinessObject.this_cIats = loc_cVal
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar IAT")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMvalorFiscLostFocus - Lookup SigCdMoe por CMoes (moeda do valor)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMvalorFiscLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaMoe
            loc_cGuardaMoe = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Mvalor.Value, ""))
            IF loc_cGuardaMoe = THIS.this_cUltimoTxtMvalorLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtMvalorLostFocusValidado = loc_cGuardaMoe
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Mvalor.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cMoedas = ""
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaMoeFisc", "cmoes", loc_cCod, ;
                    "Buscar Moeda")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("dmoes", "", "Moeda")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeFisc")
                        loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(NVL(cursor_4c_BuscaMoeFisc.cmoes, ""))
                        THIS.this_oBusinessObject.this_cMoedas = loc_oPg.txt_4c_Mvalor.Value
                    ELSE
                        loc_oPg.txt_4c_Mvalor.Value = ""
                        THIS.this_oBusinessObject.this_cMoedas = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaMoeFisc")
                    USE IN cursor_4c_BuscaMoeFisc
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMetalFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos='M'
    *--------------------------------------------------------------------------
    PROCEDURE TxtMetalFiscLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaMtl
            loc_cGuardaMtl = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Metal.Value, ""))
            IF loc_cGuardaMtl = THIS.this_cUltimoTxtMetalLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtMetalLostFocusValidado = loc_cGuardaMtl
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Metal.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cMetals = ""
                    IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
                        loc_oPg.txt_4c_DesMetal.Value = ""
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                *-- Carregar lista de metais (Tipos='M') para lookup
                loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
                IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
                    *-- Verificar se codigo existe diretamente
                    SELECT cursor_4c_BuscaMtlM
                    LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
                    IF !EOF("cursor_4c_BuscaMtlM")
                        IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
                            loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
                        ENDIF
                        THIS.this_oBusinessObject.this_cMetals = loc_cCod
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
                            "Buscar Metal")
                        IF VARTYPE(loc_oBusca) = "O"
                            IF !loc_oBusca.this_lAchouRegistro
                                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
                                loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                                loc_oBusca.Show()
                            ENDIF
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtlSel")
                                loc_oPg.txt_4c_Metal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Codigos, ""))
                                IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
                                    loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Descs, ""))
                                ENDIF
                                THIS.this_oBusinessObject.this_cMetals = loc_oPg.txt_4c_Metal.Value
                            ELSE
                                loc_oPg.txt_4c_Metal.Value = ""
                                IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
                                    loc_oPg.txt_4c_DesMetal.Value = ""
                                ENDIF
                                THIS.this_oBusinessObject.this_cMetals = ""
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                        IF USED("cursor_4c_BuscaMtlSel")
                            USE IN cursor_4c_BuscaMtlSel
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_BuscaMtlM
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar metal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTeorFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos<>'M'
    *--------------------------------------------------------------------------
    PROCEDURE TxtTeorFiscLostFocus()
        LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        *-- Guard: evita reabrir lookup se valor nao mudou
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_cGuardaTeor
            loc_cGuardaTeor = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Teor.Value, ""))
            IF loc_cGuardaTeor = THIS.this_cUltimoTxtTeorLostFocusValidado
                RETURN
            ENDIF
            THIS.this_cUltimoTxtTeorLostFocusValidado = loc_cGuardaTeor
        ENDIF
        loc_lResultado = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Teor.Value, ""))
                IF EMPTY(loc_cCod)
                    THIS.this_oBusinessObject.this_cTeors = ""
                    IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
                        loc_oPg.txt_4c_DesTeor.Value = ""
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
                IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
                    SELECT cursor_4c_BuscaMtlT
                    LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
                    IF !EOF("cursor_4c_BuscaMtlT")
                        IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
                            loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
                        ENDIF
                        THIS.this_oBusinessObject.this_cTeors = loc_cCod
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
                            "Buscar Teor")
                        IF VARTYPE(loc_oBusca) = "O"
                            IF !loc_oBusca.this_lAchouRegistro
                                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
                                loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                                loc_oBusca.Show()
                            ENDIF
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTeorSel")
                                loc_oPg.txt_4c_Teor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Codigos, ""))
                                IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
                                    loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Descs, ""))
                                ENDIF
                                THIS.this_oBusinessObject.this_cTeors = loc_oPg.txt_4c_Teor.Value
                            ELSE
                                loc_oPg.txt_4c_Teor.Value = ""
                                IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
                                    loc_oPg.txt_4c_DesTeor.Value = ""
                                ENDIF
                                THIS.this_oBusinessObject.this_cTeors = ""
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                        IF USED("cursor_4c_BuscaTeorSel")
                            USE IN cursor_4c_BuscaTeorSel
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_BuscaMtlT
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar teor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGruccusFiscLostFocus - Armazena grupo de custo no BO
    *--------------------------------------------------------------------------
    PROCEDURE TxtGruccusFiscLostFocus()
        LOCAL loc_oPg
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
                    THIS.this_oBusinessObject.this_cGruccus = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar grupo de custo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaccusFiscLostFocus - Armazena conta de custo no BO
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaccusFiscLostFocus()
        LOCAL loc_oPg
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
                    THIS.this_oBusinessObject.this_cContaccus = ALLTRIM(NVL(loc_oPg.txt_4c_Contaccus.Value, ""))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar conta de custo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdDescFisClick - Gerar Descricao Fiscal automatica
    * Legado: fGerDescFis(0, crSigCdPro.CPros, ThisForm.poDataMgr)
    *--------------------------------------------------------------------------
    PROCEDURE CmdDescFisClick()
        LOCAL loc_oPg, loc_cCpro
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                RETURN
            ENDIF
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCpro = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
            IF EMPTY(loc_cCpro)
                MsgAviso("Informe o c" + CHR(243) + "digo do produto antes de gerar a descri" + ;
                    CHR(231) + CHR(227) + "o fiscal.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            *-- Gerar descricao fiscal a partir dos campos fiscais
            *-- Legado usa fGerDescFis() - funcao de framework nao disponivel
            *-- Implementacao simplificada: combina classificacao + origem + ICMS
            LOCAL loc_cDescFis
            loc_cDescFis = ""
            IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
                loc_cDescFis = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
            ENDIF
            IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O" AND !EMPTY(loc_oPg.txt_4c_Dclfiscal.Value)
                IF !EMPTY(loc_cDescFis)
                    loc_cDescFis = loc_cDescFis + " - "
                ENDIF
                loc_cDescFis = loc_cDescFis + ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
            ENDIF
            IF !EMPTY(loc_cDescFis)
                IF VARTYPE(loc_oPg.obj_4c_Descfis) = "O"
                    loc_oPg.obj_4c_Descfis.Value = loc_cDescFis
                    THIS.this_oBusinessObject.this_cDescfis = loc_cDescFis
                ENDIF
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FASE 14 - Aba Designer (pgDesigner - Page7 do pgf_4c_Dados)
    * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
    * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
    * Controles: 2 grids (4col + 1col), 1 editbox, 1 label, 3 buttons, 1 image, 1 shape
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgDesigner()
        LOCAL loc_oPg, loc_oGrd
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7

        *----------------------------------------------------------------------
        *-- Cursor placeholder cursor_4c_SigPrTar (SigPrTar - Tarefas Designer)
        *-- Campos: DtInis, DtFims, Usuars, Tarefas, ObsTars
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_SigPrTar")
            SET NULL ON
            CREATE CURSOR cursor_4c_SigPrTar (;
                DtInis  D NULL, ;
                DtFims  D NULL, ;
                Usuars  C(10), ;
                Tarefas C(10), ;
                ObsTars M)
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
        *-- Campos: Arquivos
        *----------------------------------------------------------------------
        IF !USED("cursor_4c_SigPrArq")
            SET NULL ON
            CREATE CURSOR cursor_4c_SigPrArq (;
                Arquivos C(200))
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
        WITH loc_oPg.shp_4c_ArqFundo
            .Top         = 415
            .Left        = 584
            .Width       = 407
            .Height      = 202
            .BackColor   = RGB(230, 230, 230)
            .BorderColor = RGB(180, 180, 180)
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Say31: "Observacao da Tarefa" (T:144 L:583 W:126 H:15)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("lbl_4c_ObsTarLabel", "Label")
        WITH loc_oPg.lbl_4c_ObsTarLabel
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
            .Top       = 144
            .Left      = 583
            .Width     = 126
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- grdDesigner: Grade de Tarefas (T:160 L:10 W:495 H:238) 4 colunas
        *-- Colunas: Data Inicio | Data Conclusao | Usuario | Tarefa
        *-- Cols 1-3 readonly, Col4 editavel (quando usuario e dono e tarefa nao finalizada)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_Designer", "Grid")
        WITH loc_oPg.grd_4c_Designer
            .Top         = 160
            .Left        = 10
            .Width       = 495
            .Height      = 238
            .ColumnCount = 4
            .FontName    = "Tahoma"
            .FontSize    = 8
            .DeleteMark  = .F.
            .ScrollBars  = 2
            .Themes      = .F.
            .Visible     = .T.
            .RecordMark   = .F.
        ENDWITH
        loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_SigPrTar"
        WITH loc_oPg.grd_4c_Designer
            .Column1.ControlSource     = "cursor_4c_SigPrTar.DtInis"
            .Column1.Header1.Caption   = "Data de In" + CHR(237) + "cio"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Width             = 140
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .T.
            .Column1.Alignment         = 2
            .Column2.ControlSource     = "cursor_4c_SigPrTar.DtFims"
            .Column2.Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Width             = 140
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.Alignment         = 2
            .Column3.ControlSource     = "cursor_4c_SigPrTar.Usuars"
            .Column3.Header1.Caption   = "Usu" + CHR(225) + "rio"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Width             = 90
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column4.ControlSource     = "cursor_4c_SigPrTar.Tarefas"
            .Column4.Header1.Caption   = "Tarefa"
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Width             = 90
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .F.
        ENDWITH
        BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")

        *----------------------------------------------------------------------
        *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
        *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
        WITH loc_oPg.obj_4c_ObsTarefas
            .Top              = 160
            .Left             = 584
            .Width            = 407
            .Height           = 238
            .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
            .FontName         = "Tahoma"
            .FontSize         = 8
            .SpecialEffect    = 1
            .ForeColor        = RGB(36, 84, 155)
            .Enabled          = .T.
            .Visible          = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
        WITH loc_oPg.cmd_4c_IniTarefa
            .Top             = 168
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .ToolTipText     = "Iniciar Nova Tarefa"
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")

        *----------------------------------------------------------------------
        *-- btnFimTarefa: Encerrar Tarefa (T:203 L:509 W:42 H:42)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
        WITH loc_oPg.cmd_4c_FimTarefa
            .Top             = 203
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_datas_26.bmp"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .ToolTipText     = "Encerrar Tarefa"
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")

        *----------------------------------------------------------------------
        *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
        *----------------------------------------------------------------------
        loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
        WITH loc_oPg.grd_4c_Arquivos
            .Top         = 415
            .Left        = 10
            .Width       = 495
            .Height      = 202
            .ColumnCount = 1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .DeleteMark  = .F.
            .ScrollBars  = 2
            .ReadOnly    = .T.
            .Themes      = .F.
            .Visible     = .T.
            .RecordMark   = .F.
        ENDWITH
        loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
        WITH loc_oPg.grd_4c_Arquivos
            .Column1.ControlSource     = "cursor_4c_SigPrArq.Arquivos"
            .Column1.Header1.Caption   = "Arquivos Para Designer"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Width             = 464
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .T.
        ENDWITH
        BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")

        *----------------------------------------------------------------------
        *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_InsArqs
            .Top             = 416
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .ToolTipText     = "Inserir Arquivo"
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")

        *----------------------------------------------------------------------
        *-- btnOpnArqs: Abrir Arquivo (T:500 L:509 W:42 H:42)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_OpnArqs
            .Top             = 500
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.bmp"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .ToolTipText     = "Abrir Arquivo"
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")

        *----------------------------------------------------------------------
        *-- btnExcArqs: Excluir Arquivo (T:458 L:509 W:42 H:42)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_ExcArqs
            .Top             = 458
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.bmp"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .ToolTipText     = "Excluir Arquivo"
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")

        *----------------------------------------------------------------------
        *-- imgArqJpg: Imagem do arquivo (T:417 L:586 W:403 H:198)
        *----------------------------------------------------------------------
        loc_oPg.AddObject("img_4c_ArqJpg", "Image")
        WITH loc_oPg.img_4c_ArqJpg
            .Top         = 417
            .Left        = 586
            .Width       = 403
            .Height      = 198
            .Stretch     = 1
            .Visible     = .F.
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
        ENDWITH
        BINDEVENT(loc_oPg.img_4c_ArqJpg, "Click", THIS, "ImgArqJpgClick")

        *----------------------------------------------------------------------
        *-- Bindings When / Valid / LostFocus para Column4 (campo Tarefa)
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
        BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
        BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")

        *----------------------------------------------------------------------
        *-- Binding When para EditBox Obs da Tarefa
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")

        *----------------------------------------------------------------------
        *-- Bindings When para botoes de tarefa
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
        BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")

        *----------------------------------------------------------------------
        *-- Binding When para Column1 do grdArquivos
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")

        *----------------------------------------------------------------------
        *-- Bindings When para botoes de arquivo
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
        BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
        BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
    * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
                    *-- Sincronizar editbox com observacao da tarefa selecionada
                    IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
                        loc_oPg.obj_4c_ObsTarefas.Value = NVL(cursor_4c_SigPrTar.ObsTars, "")
                    ELSE
                        loc_oPg.obj_4c_ObsTarefas.Value = ""
                    ENDIF
                    loc_oPg.obj_4c_ObsTarefas.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar observa" + CHR(231) + CHR(227) + "o da tarefa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdArquivosAfterRowColChange - Mostra imagem do arquivo selecionado
    * Legado: grdArquivos.Procedure (AfterRowColChange) ? mostra imagem JPG/BMP
    *--------------------------------------------------------------------------
    PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_cArq, loc_cExt
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            IF VARTYPE(loc_oPg.img_4c_ArqJpg) # "O"
                RETURN
            ENDIF
            CLEAR RESOURCES
            loc_oPg.img_4c_ArqJpg.Picture = ""
            loc_oPg.img_4c_ArqJpg.Visible = .F.
            IF USED("cursor_4c_SigPrArq") AND !EOF("cursor_4c_SigPrArq")
                loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
                IF !EMPTY(loc_cArq) AND AT(".", loc_cArq) > 0
                    loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
                    IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
                        loc_oPg.img_4c_ArqJpg.Picture  = loc_cArq
                        loc_oPg.img_4c_ArqJpg.Visible  = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao exibir imagem do arquivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIniTarefaClick - Inicia nova tarefa para o usuario logado
    * Legado: btnIniTarefa.Click - verifica tarefa nao encerrada, insere novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIniTarefaClick()
        LOCAL loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_SigPrTar")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                *-- Verificar se existe tarefa nao encerrada para este usuario
                SELECT cursor_4c_SigPrTar
                LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
                    AND EMPTY(NVL(DtFims, {}))
                IF !EOF("cursor_4c_SigPrTar")
                    MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
                        CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                *-- Verificar se existe tarefa sem codigo informado
                SELECT cursor_4c_SigPrTar
                LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
                    AND EMPTY(Tarefas)
                IF !EOF("cursor_4c_SigPrTar")
                    MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                *-- Inserir nova tarefa com data/hora de inicio
                SELECT cursor_4c_SigPrTar
                APPEND BLANK
                REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
                REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
                REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
                REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFimTarefaClick - Encerra tarefa do usuario logado
    * Legado: btnFimTarefa.Click - valida usuario e data, replace DtFims
    *--------------------------------------------------------------------------
    PROCEDURE BtnFimTarefaClick()
        LOCAL loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_SigPrTar") OR EOF("cursor_4c_SigPrTar")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) # ALLTRIM(gc_4c_UsuarioLogado)
                    MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                IF !EMPTY(cursor_4c_SigPrTar.DtFims)
                    MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                SELECT cursor_4c_SigPrTar
                REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
    * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
    *--------------------------------------------------------------------------
    PROCEDURE BtnInsArqsClick()
        LOCAL loc_cArq, loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
            IF EMPTY(loc_cArq)
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado AND USED("cursor_4c_SigPrArq")
                SELECT cursor_4c_SigPrArq
                APPEND BLANK
                REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
    * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
    *--------------------------------------------------------------------------
    PROCEDURE BtnOpnArqsClick()
        LOCAL loc_cArq, loc_oApp, loc_lResultado
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
                IF EMPTY(loc_cArq)
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                IF !FILE(loc_cArq)
                    MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                loc_oApp = CREATEOBJECT("Shell.Application")
                IF VARTYPE(loc_oApp) = "O"
                    loc_oApp.Open(loc_cArq)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir arquivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
    * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcArqsClick()
        LOCAL loc_lResultado
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                SELECT cursor_4c_SigPrArq
                DELETE
                IF !EOF("cursor_4c_SigPrArq")
                    SKIP
                    SKIP -1
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
                ENDIF
                *-- Limpar imagem ao excluir arquivo
                LOCAL loc_oPg
                loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
                    CLEAR RESOURCES
                    loc_oPg.img_4c_ArqJpg.Picture = ""
                    loc_oPg.img_4c_ArqJpg.Visible = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgArqJpgClick - Abre imagem em modo zoom (form SigOpZom)
    * Legado: imgArqJpg.Click - Do Form SigOpZom With lcArq, "Arquivo : " + lcArq
    *--------------------------------------------------------------------------
    PROCEDURE ImgArqJpgClick()
        LOCAL loc_cArq, loc_cExt, loc_lResultado
        loc_lResultado = .T.
        TRY
            IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
                loc_lResultado = .F.
            ENDIF
            IF loc_lResultado
                loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
                IF EMPTY(loc_cArq) OR !FILE(loc_cArq)
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                IF AT(".", loc_cArq) > 0
                    loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
                    IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
                        *-- Tentar abrir zoom form se disponivel
                        IF PEMSTATUS("FormSigOpZom", "NAME", 5) OR FILE(gc_4c_CaminhoForms + "SigOpZom.prg")
                            DO FORM (gc_4c_CaminhoForms + "SigOpZom") WITH loc_cArq, "Arquivo : " + loc_cArq
                        ELSE
                            *-- Fallback: abrir com aplicativo padrao do SO
                            LOCAL loc_oApp
                            loc_oApp = CREATEOBJECT("Shell.Application")
                            IF VARTYPE(loc_oApp) = "O"
                                loc_oApp.Open(loc_cArq)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir imagem em zoom")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerCol4When - Permite edicao somente para usuario dono da tarefa nao finalizada
    * Legado: grdDesigner.Column4.Text1.When
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerCol4When()
        LOCAL loc_lResult
        loc_lResult = .F.
        TRY
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
                    IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
                        AND EMPTY(cursor_4c_SigPrTar.DtFims)
                        loc_lResult = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de edi" + CHR(231) + CHR(227) + "o")
        ENDTRY
        RETURN loc_lResult
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerCol4Valid - Valida codigo de tarefa, abre lookup se nao encontrado
    * Legado: grdDesigner.Column4.Text1.Valid - fwBuscaInt crTarefas CodCads/DesCads
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerCol4Valid()
        LOCAL loc_lResult, loc_cCodigo, loc_oBusca, loc_oPg
        loc_lResult = .T.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
                loc_lResultado = .T.
            ENDIF
            loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            loc_cCodigo = ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, ""))
            IF !EMPTY(loc_cCodigo)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "sigcdtar", "cursor_4c_BuscaTar", "codcads", loc_cCodigo, ;
                    "Buscar Tarefa")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "d.")
                        loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
                        loc_oPg.grd_4c_Designer.Column4.Text1.Value = ALLTRIM(NVL(cursor_4c_BuscaTar.codcads, ""))
                    ELSE
                        loc_oPg.grd_4c_Designer.Column4.Text1.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaTar")
                    USE IN cursor_4c_BuscaTar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar tarefa")
        ENDTRY
        RETURN loc_lResult
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerCol4LostFocus - Ao sair com Enter de tarefa nao vazia, foca ObsTarefas
    * Legado: grdDesigner.Column4.Text1.LostFocus
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerCol4LostFocus()
        LOCAL loc_oPg
        TRY
            IF LASTKEY() = 13
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                    IF VARTYPE(loc_oPg.grd_4c_Designer.Column4.Text1) = "O"
                        IF !EMPTY(ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, "")))
                            IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
                                loc_oPg.obj_4c_ObsTarefas.SetFocus()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao mover foco para observa" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObsTarefasWhen - Permite edicao somente em INCLUIR/ALTERAR
    * Legado: getObsTarefas.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
    *--------------------------------------------------------------------------
    PROCEDURE ObsTarefasWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIniTarefaWhen - Habilita botao Iniciar Tarefa somente em INCLUIR/ALTERAR
    * Legado: btnIniTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
    *--------------------------------------------------------------------------
    PROCEDURE BtnIniTarefaWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFimTarefaWhen - Habilita botao Encerrar Tarefa somente em INCLUIR/ALTERAR
    * Legado: btnFimTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
    *--------------------------------------------------------------------------
    PROCEDURE BtnFimTarefaWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdArquivosCol1When - Permite foco em Column1 somente em INCLUIR/ALTERAR
    * Legado: grdArquivos.Column1.Text1.When
    *--------------------------------------------------------------------------
    PROCEDURE GrdArquivosCol1When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInsArqsWhen - Habilita botao Inserir Arquivo somente em INCLUIR/ALTERAR
    * Legado: btnInsArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
    *--------------------------------------------------------------------------
    PROCEDURE BtnInsArqsWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOpnArqsWhen - Habilita botao Abrir Arquivo sempre
    * Legado: btnOpnArqs.When - Return .t.
    *--------------------------------------------------------------------------
    PROCEDURE BtnOpnArqsWhen()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcArqsWhen - Habilita botao Excluir Arquivo somente em INCLUIR/ALTERAR
    * Legado: btnExcArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcArqsWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberar recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos
* Tabela principal: SigCdPro | PK: cpros
* Fase 1/8 - Declaracao de propriedades e Init()
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *--------------------------------------------------------------------------
    *-- Campos Character (this_c*)
    *--------------------------------------------------------------------------
    this_cCpros             = ""   && cpros              char(14)  PK
    this_cDpros             = ""   && dpros              char(65)
    this_cDpro2s            = ""   && dpro2s             char(45)
    this_cMatprincs         = ""   && matprincs          char(14)
    this_cCgrus             = ""   && cgrus              char(3)
    this_cSgrus             = ""   && sgrus              char(6)
    this_cClfiscals         = ""   && clfiscals          char(10)
    this_cColecoes          = ""   && colecoes           char(10)
    this_cCunis             = ""   && cunis              char(3)
    this_cCunips            = ""   && cunips             char(3)
    this_cCvens             = ""   && cvens              char(10)
    this_cIfors             = ""   && ifors              char(10)
    this_cLinhas            = ""   && linhas             char(10)
    this_cLocals            = ""   && locals             char(10)
    this_cMoecs             = ""   && moecs              char(3)
    this_cMoecusfs          = ""   && moecusfs           char(3)
    this_cMoedas            = ""   && moedas             char(3)
    this_cMoepcs            = ""   && moepcs             char(3)
    this_cMoepvs            = ""   && moepvs             char(3)
    this_cMoevs             = ""   && moevs              char(3)
    this_cNotas             = ""   && notas              char(6)
    this_cObspeds           = ""   && obspeds            char(30)
    this_cObspes            = ""   && obspes             char(30)
    this_cOrigmercs         = ""   && origmercs          char(1)
    this_cReffs             = ""   && reffs              char(40)
    this_cSittricms         = ""   && sittricms          char(3)
    this_cTipos             = ""   && tipos              char(1)
    this_cMetals            = ""   && metals             char(2)
    this_cTeors             = ""   && teors              char(2)
    this_cCftios            = ""   && cftios             char(2)
    this_cCodservs          = ""   && codservs           char(4)
    this_cMftios            = ""   && mftios             char(3)
    this_cCodcors           = ""   && codcors            char(4)
    this_cCodtams           = ""   && codtams            char(4)
    this_cCompos            = ""   && compos             char(30)
    this_cMercs             = ""   && mercs              char(3)
    this_cTptribs           = ""   && tptribs            char(4)
    this_cIpis              = ""   && ipis               char(1)
    this_cCodacbs           = ""   && codacbs            char(3)
    this_cObsetqs           = ""   && obsetqs            char(10)
    this_cMultcomps         = ""   && multcomps          char(3)
    this_cCclass            = ""   && cclass             char(3)
    this_cNivelqs           = ""   && nivelqs            char(10)
    this_cCftiocs           = ""   && cftiocs            char(2)
    this_cUsuincs           = ""   && usuincs            char(10)
    this_cIdecpros          = ""   && idecpros           char(3)
    this_cCodfinp           = ""   && codfinp            char(3)
    this_cCodmatp           = ""   && codmatp            char(3)
    this_cStatus            = ""   && status             char(3)
    this_cCodgarras         = ""   && codgarras          char(10)
    this_cDescecfs          = ""   && descecfs           char(29)
    this_cExtipi            = ""   && extipi             char(3)
    this_cIats              = ""   && iats               char(1)
    this_cConquilhas        = ""   && conquilhas         char(10)
    this_cContaccus         = ""   && contaccus          char(10)
    this_cGruccus           = ""   && gruccus            char(10)
    this_cCodident          = ""   && codident           char(20) NULL
    this_cConjunts          = ""   && conjunts           char(6)
    this_cRefracao          = ""   && refracao           char(16)
    this_cRefracaodp        = ""   && refracaodp         char(16)
    this_cCategoria         = ""   && categoria          char(6)
    this_cCodctgsite        = ""   && codctgsite         char(2)
    this_cCoddptsite        = ""   && coddptsite         char(2)
    this_cObsmkt            = ""   && obsmkt             char(100)
    this_cSkuvtex           = ""   && skuvtex            char(50)
    this_cUsuaalts          = ""   && usuaalts           char(20)
    this_cLancamento        = ""   && lancamento         char(30)
    this_cOrigemlac         = ""   && origemlac          char(40)
    this_cCodmacro          = ""   && codmacro           char(6)
    this_cPropriedades      = ""   && propriedades       char(40)
    this_cUnidade1          = ""   && unidade1           char(15)
    this_cResultado1        = ""   && resultado1         char(15)
    this_cValorminimo       = ""   && valorminimo        char(15)
    this_cValormaximo       = ""   && valormaximo        char(15)
    this_cMetodoreferencia1 = ""   && metodoreferencia1  char(15)
    this_cCproeqs           = ""   && cproeqs            char(14)

    *-- Campos Memo/Text (this_c* - tratados como string)
    this_cDescfis           = ""   && descfis            text NULL
    this_cFigjpgs           = ""   && figjpgs            text NULL
    this_cFigtecs           = ""   && figtecs            text NULL
    this_cDsccompras        = ""   && dsccompras         text NULL
    this_cObscompras        = ""   && obscompras         text NULL
    this_cDpro3s            = ""   && dpro3s             text NULL
    this_cFigjpgs64         = ""   && figjpgs64          text NULL
    this_cMtiposervs        = ""   && mtiposervs         text NULL
    this_cObsinsp           = ""   && obsinsp            text NULL

    *--------------------------------------------------------------------------
    *-- Campos Numeric (this_n*)
    *--------------------------------------------------------------------------
    this_nCbars             = 0    && cbars              numeric(14,0)
    this_nComis             = 0    && comis              numeric(5,2)
    this_nCustofs           = 0    && custofs            numeric(11,3)
    this_nFcustos           = 0    && fcustos            numeric(11,5)
    this_nFvendas           = 0    && fvendas            numeric(7,3)
    this_nIcms              = 0    && icms               numeric(5,2)
    this_nMargems           = 0    && margems            numeric(9,6)
    this_nPcuss             = 0    && pcuss              numeric(11,5)
    this_nPesoms            = 0    && pesoms             numeric(8,3)
    this_nPvens             = 0    && pvens              numeric(11,5)
    this_nPvideals          = 0    && pvideals           numeric(11,5)
    this_nQmins             = 0    && qmins              numeric(9,3)
    this_nValors            = 0    && valors             numeric(11,2)
    this_nSituas            = 0    && situas             numeric(1,0)
    this_nPftios            = 0    && pftios             numeric(11,3)
    this_nPftiocs           = 0    && pftiocs            numeric(11,3)
    this_nMontadescs        = 0    && montadescs         numeric(1,0)
    this_nDigimaxs          = 0    && digimaxs           numeric(2,0)
    this_nOrdcompos         = 0    && ordcompos          numeric(2,0)
    this_nEan13             = 0    && ean13              numeric(13,0)
    this_nQtdcpnts          = 0    && qtdcpnts           numeric(3,0)
    this_nCasas             = 0    && casas              numeric(2,0)
    this_nPesobs            = 0    && pesobs             numeric(7,3)
    this_nTamhs             = 0    && tamhs              numeric(5,2)
    this_nTamls             = 0    && tamls              numeric(5,2)
    this_nTamps             = 0    && tamps              numeric(5,2)
    this_nVolumes           = 0    && volumes            numeric(3,0)
    this_nVultcomps         = 0    && vultcomps          numeric(11,2)
    this_nMarkupa           = 0    && markupa            numeric(11,3)
    this_nTinsts            = 0    && tinsts             numeric(3,0)
    this_nDiasinas          = 0    && diasinas           numeric(5,0)
    this_nQtminfabs         = 0    && qtminfabs          numeric(9,3)
    this_nTents             = 0    && tents              numeric(3,0)
    this_nLtminsv           = 0    && ltminsv            numeric(9,3)
    this_nAliqipis          = 0    && aliqipis           numeric(5,2)
    this_nEncargos          = 0    && encargos           numeric(7,4)
    this_nIdpro             = 0    && idpro              numeric(10,0)
    this_nNidentfixa        = 0    && nidentfixa         numeric(1,0)
    this_nPesobris          = 0    && pesobris           numeric(9,3)
    this_nPesometal         = 0    && pesometal          numeric(9,3)
    this_nPesopdrs          = 0    && pesopdrs           numeric(9,3)
    this_nFatuals           = 0    && fatuals            numeric(11,5)
    this_nFideals           = 0    && fideals            numeric(11,5)
    this_nProdvars          = 0    && prodvars           numeric(1,0)
    this_nPmins             = 0    && pmins              numeric(7,3)
    this_nCotacalcp         = 0    && cotacalcp          numeric(11,6)
    this_nQtdultcomp        = 0    && qtdultcomp         numeric(12,0)
    this_nDiasgar           = 0    && diasgar            numeric(4,0) NULL
    this_nAltura            = 0    && altura             numeric(7,4)
    this_nLargura           = 0    && largura            numeric(7,4)
    this_nDiametro          = 0    && diametro           numeric(7,4)
    this_nEspessura         = 0    && espessura          numeric(7,4)
    this_nCompriment        = 0    && compriment         numeric(7,4)
    this_nMohs              = 0    && mohs               numeric(3,0)
    this_nAtivosite         = 0    && ativosite          numeric(1,0)
    this_nCustocp           = 0    && custocp            numeric(11,5)
    this_nForalinha         = 0    && foralinha          numeric(1,0)
    this_nMostruario        = 0    && mostruario         numeric(1,0)
    this_nPrecode           = 0    && precode            numeric(11,5)
    this_nProdNovo          = 0    && prodnovo           numeric(1,0)
    this_nProdoff           = 0    && prodoff            numeric(1,0)
    this_nSegfem            = 0    && segfem             numeric(1,0)
    this_nSeginf            = 0    && seginf             numeric(1,0)
    this_nSegkids           = 0    && segkids            numeric(1,0)
    this_nSegmasc           = 0    && segmasc            numeric(1,0)
    this_nSeguni            = 0    && seguni             numeric(1,0)
    this_nSemconsulta       = 0    && semconsulta        numeric(1,0)
    this_nVarpesoms         = 0    && varpesoms          numeric(5,2)
    this_nBestseller        = 0    && bestseller         numeric(1,0)
    this_nObrtamser         = 0    && obrtamser          numeric(1,0)
    this_nPrototipo         = 0    && prototipo          numeric(1,0)
    this_nReposauto         = 0    && reposauto          numeric(1,0)
    this_nProcfigjpgs       = 0    && procfigjpgs        numeric(1,0)
    this_nQtped             = 0    && qtped              numeric(9,3)

    *--------------------------------------------------------------------------
    *-- Campos Logical/BIT - tipos BIT nativos do SQL Server (this_l*)
    *--------------------------------------------------------------------------
    this_lFlagctabs         = .F.  && flagctabs          bit
    this_lTcomps            = .F.  && tcomps             bit
    this_lTransps           = .F.  && transps            bit
    this_lImpetiqs          = .F.  && impetiqs           bit
    this_lChkfunds          = .F.  && chkfunds           bit

    *-- Campos Logical - numeric(1,0) com semantica booleana
    this_lVarias            = .F.  && varias             numeric(1,0)
    this_lConsigs           = .F.  && consigs            numeric(1,0)
    this_lFabrproprs        = .F.  && fabrproprs         numeric(1,0)
    this_lEncoms            = .F.  && encoms             numeric(1,0)
    this_lChkgarvit         = .F.  && chkgarvit          numeric(1,0)
    this_lCravcers          = .F.  && cravcers           numeric(1,0)
    this_lProdwebs          = .F.  && prodwebs           numeric(1,0)

    *--------------------------------------------------------------------------
    *-- Campos DateTime (this_d*)
    *--------------------------------------------------------------------------
    this_dDtcomps           = {}   && dtcomps            datetime NULL
    this_dDatas             = {}   && datas              datetime NULL
    this_dDatatrans         = {}   && datatrans          datetime NULL
    this_dDtfilms           = {}   && dtfilms            datetime NULL
    this_dDtincs            = {}   && dtincs             datetime NULL
    this_dUltcomps          = {}   && ultcomps           datetime NULL
    this_dDtsituas          = {}   && dtsituas           datetime NULL
    this_dDtlacto           = {}   && dtlacto            datetime NULL
    this_dDtalts            = {}   && dtalts             datetime NULL
    this_dFimdtlacto        = {}   && fimdtlacto         datetime NULL

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCpros
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
    *==========================================================================
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCpros))
            MsgAviso("C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDpros))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o do produto obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Campos Character
                THIS.this_cCpros             = TratarNulo(cpros,             "")
                THIS.this_cDpros             = TratarNulo(dpros,             "")
                THIS.this_cDpro2s            = TratarNulo(dpro2s,            "")
                THIS.this_cMatprincs         = TratarNulo(matprincs,         "")
                THIS.this_cCgrus             = TratarNulo(cgrus,             "")
                THIS.this_cSgrus             = TratarNulo(sgrus,             "")
                THIS.this_cClfiscals         = TratarNulo(clfiscals,         "")
                THIS.this_cColecoes          = TratarNulo(colecoes,          "")
                THIS.this_cCunis             = TratarNulo(cunis,             "")
                THIS.this_cCunips            = TratarNulo(cunips,            "")
                THIS.this_cCvens             = TratarNulo(cvens,             "")
                THIS.this_cIfors             = TratarNulo(ifors,             "")
                THIS.this_cLinhas            = TratarNulo(linhas,            "")
                THIS.this_cLocals            = TratarNulo(locals,            "")
                THIS.this_cMoecs             = TratarNulo(moecs,             "")
                THIS.this_cMoecusfs          = TratarNulo(moecusfs,          "")
                THIS.this_cMoedas            = TratarNulo(moedas,            "")
                THIS.this_cMoepcs            = TratarNulo(moepcs,            "")
                THIS.this_cMoepvs            = TratarNulo(moepvs,            "")
                THIS.this_cMoevs             = TratarNulo(moevs,             "")
                THIS.this_cNotas             = TratarNulo(notas,             "")
                THIS.this_cObspeds           = TratarNulo(obspeds,           "")
                THIS.this_cObspes            = TratarNulo(obspes,            "")
                THIS.this_cOrigmercs         = TratarNulo(origmercs,         "")
                THIS.this_cReffs             = TratarNulo(reffs,             "")
                THIS.this_cSittricms         = TratarNulo(sittricms,         "")
                THIS.this_cTipos             = TratarNulo(tipos,             "")
                THIS.this_cMetals            = TratarNulo(metals,            "")
                THIS.this_cTeors             = TratarNulo(teors,             "")
                THIS.this_cCftios            = TratarNulo(cftios,            "")
                THIS.this_cCodservs          = TratarNulo(codservs,          "")
                THIS.this_cMftios            = TratarNulo(mftios,            "")
                THIS.this_cCodcors           = TratarNulo(codcors,           "")
                THIS.this_cCodtams           = TratarNulo(codtams,           "")
                THIS.this_cCompos            = TratarNulo(compos,            "")
                THIS.this_cMercs             = TratarNulo(mercs,             "")
                THIS.this_cTptribs           = TratarNulo(tptribs,           "")
                THIS.this_cIpis              = TratarNulo(ipis,              "")
                THIS.this_cCodacbs           = TratarNulo(codacbs,           "")
                THIS.this_cObsetqs           = TratarNulo(obsetqs,           "")
                THIS.this_cMultcomps         = TratarNulo(multcomps,         "")
                THIS.this_cCclass            = TratarNulo(cclass,            "")
                THIS.this_cNivelqs           = TratarNulo(nivelqs,           "")
                THIS.this_cCftiocs           = TratarNulo(cftiocs,           "")
                THIS.this_cUsuincs           = TratarNulo(usuincs,           "")
                THIS.this_cIdecpros          = TratarNulo(idecpros,          "")
                THIS.this_cCodfinp           = TratarNulo(codfinp,           "")
                THIS.this_cCodmatp           = TratarNulo(codmatp,           "")
                THIS.this_cStatus            = TratarNulo(status,            "")
                THIS.this_cCodgarras         = TratarNulo(codgarras,         "")
                THIS.this_cDescecfs          = TratarNulo(descecfs,          "")
                THIS.this_cExtipi            = TratarNulo(extipi,            "")
                THIS.this_cIats              = TratarNulo(iats,              "")
                THIS.this_cConquilhas        = TratarNulo(conquilhas,        "")
                THIS.this_cContaccus         = TratarNulo(contaccus,         "")
                THIS.this_cGruccus           = TratarNulo(gruccus,           "")
                THIS.this_cCodident          = TratarNulo(codident,          "")
                THIS.this_cConjunts          = TratarNulo(conjunts,          "")
                THIS.this_cRefracao          = TratarNulo(refracao,          "")
                THIS.this_cRefracaodp        = TratarNulo(refracaodp,        "")
                THIS.this_cCategoria         = TratarNulo(categoria,         "")
                THIS.this_cCodctgsite        = TratarNulo(codctgsite,        "")
                THIS.this_cCoddptsite        = TratarNulo(coddptsite,        "")
                THIS.this_cObsmkt            = TratarNulo(obsmkt,            "")
                THIS.this_cSkuvtex           = TratarNulo(skuvtex,           "")
                THIS.this_cUsuaalts          = TratarNulo(usuaalts,          "")
                THIS.this_cLancamento        = TratarNulo(lancamento,        "")
                THIS.this_cOrigemlac         = TratarNulo(origemlac,         "")
                THIS.this_cCodmacro          = TratarNulo(codmacro,          "")
                THIS.this_cPropriedades      = TratarNulo(propriedades,      "")
                THIS.this_cUnidade1          = TratarNulo(unidade1,          "")
                THIS.this_cResultado1        = TratarNulo(resultado1,        "")
                THIS.this_cValorminimo       = TratarNulo(valorminimo,       "")
                THIS.this_cValormaximo       = TratarNulo(valormaximo,       "")
                THIS.this_cMetodoreferencia1 = TratarNulo(metodoreferencia1, "")
                THIS.this_cCproeqs           = TratarNulo(cproeqs,           "")

                *-- Campos Memo/Text
                THIS.this_cDescfis    = TratarNulo(descfis,    "")
                THIS.this_cFigjpgs    = TratarNulo(figjpgs,    "")
                THIS.this_cFigtecs    = TratarNulo(figtecs,    "")
                THIS.this_cDsccompras = TratarNulo(dsccompras, "")
                THIS.this_cObscompras = TratarNulo(obscompras, "")
                THIS.this_cDpro3s     = TratarNulo(dpro3s,     "")
                THIS.this_cFigjpgs64  = TratarNulo(figjpgs64,  "")
                THIS.this_cMtiposervs = TratarNulo(mtiposervs, "")
                THIS.this_cObsinsp    = TratarNulo(obsinsp,    "")

                *-- Campos Numeric
                THIS.this_nCbars       = TratarNulo(cbars,       0)
                THIS.this_nComis       = TratarNulo(comis,       0)
                THIS.this_nCustofs     = TratarNulo(custofs,     0)
                THIS.this_nFcustos     = TratarNulo(fcustos,     0)
                THIS.this_nFvendas     = TratarNulo(fvendas,     0)
                THIS.this_nIcms        = TratarNulo(icms,        0)
                THIS.this_nMargems     = TratarNulo(margems,     0)
                THIS.this_nPcuss       = TratarNulo(pcuss,       0)
                THIS.this_nPesoms      = TratarNulo(pesoms,      0)
                THIS.this_nPvens       = TratarNulo(pvens,       0)
                THIS.this_nPvideals    = TratarNulo(pvideals,    0)
                THIS.this_nQmins       = TratarNulo(qmins,       0)
                THIS.this_nValors      = TratarNulo(valors,      0)
                THIS.this_nSituas      = TratarNulo(situas,      0)
                THIS.this_nPftios      = TratarNulo(pftios,      0)
                THIS.this_nPftiocs     = TratarNulo(pftiocs,     0)
                THIS.this_nMontadescs  = TratarNulo(montadescs,  0)
                THIS.this_nDigimaxs    = TratarNulo(digimaxs,    0)
                THIS.this_nOrdcompos   = TratarNulo(ordcompos,   0)
                THIS.this_nEan13       = TratarNulo(ean13,       0)
                THIS.this_nQtdcpnts    = TratarNulo(qtdcpnts,    0)
                THIS.this_nCasas       = TratarNulo(casas,       0)
                THIS.this_nPesobs      = TratarNulo(pesobs,      0)
                THIS.this_nTamhs       = TratarNulo(tamhs,       0)
                THIS.this_nTamls       = TratarNulo(tamls,       0)
                THIS.this_nTamps       = TratarNulo(tamps,       0)
                THIS.this_nVolumes     = TratarNulo(volumes,     0)
                THIS.this_nVultcomps   = TratarNulo(vultcomps,   0)
                THIS.this_nMarkupa     = TratarNulo(markupa,     0)
                THIS.this_nTinsts      = TratarNulo(tinsts,      0)
                THIS.this_nDiasinas    = TratarNulo(diasinas,    0)
                THIS.this_nQtminfabs   = TratarNulo(qtminfabs,   0)
                THIS.this_nTents       = TratarNulo(tents,       0)
                THIS.this_nLtminsv     = TratarNulo(ltminsv,     0)
                THIS.this_nAliqipis    = TratarNulo(aliqipis,    0)
                THIS.this_nEncargos    = TratarNulo(encargos,    0)
                THIS.this_nIdpro       = TratarNulo(idpro,       0)
                THIS.this_nNidentfixa  = TratarNulo(nidentfixa,  0)
                THIS.this_nPesobris    = TratarNulo(pesobris,    0)
                THIS.this_nPesometal   = TratarNulo(pesometal,   0)
                THIS.this_nPesopdrs    = TratarNulo(pesopdrs,    0)
                THIS.this_nFatuals     = TratarNulo(fatuals,     0)
                THIS.this_nFideals     = TratarNulo(fideals,     0)
                THIS.this_nProdvars    = TratarNulo(prodvars,    0)
                THIS.this_nPmins       = TratarNulo(pmins,       0)
                THIS.this_nCotacalcp   = TratarNulo(cotacalcp,   0)
                THIS.this_nQtdultcomp  = TratarNulo(qtdultcomp,  0)
                THIS.this_nDiasgar     = TratarNulo(diasgar,     0)
                THIS.this_nAltura      = TratarNulo(altura,      0)
                THIS.this_nLargura     = TratarNulo(largura,     0)
                THIS.this_nDiametro    = TratarNulo(diametro,    0)
                THIS.this_nEspessura   = TratarNulo(espessura,   0)
                THIS.this_nCompriment  = TratarNulo(compriment,  0)
                THIS.this_nMohs        = TratarNulo(mohs,        0)
                THIS.this_nAtivosite   = TratarNulo(ativosite,   0)
                THIS.this_nCustocp     = TratarNulo(custoccp,    0)
                THIS.this_nForalinha   = TratarNulo(foralinha,   0)
                THIS.this_nMostruario  = TratarNulo(mostruario,  0)
                THIS.this_nPrecode     = TratarNulo(precode,     0)
                THIS.this_nProdNovo    = TratarNulo(prodnovo,    0)
                THIS.this_nProdoff     = TratarNulo(prodoff,     0)
                THIS.this_nSegfem      = TratarNulo(segfem,      0)
                THIS.this_nSeginf      = TratarNulo(seginf,      0)
                THIS.this_nSegkids     = TratarNulo(segkids,     0)
                THIS.this_nSegmasc     = TratarNulo(segmasc,     0)
                THIS.this_nSeguni      = TratarNulo(seguni,      0)
                THIS.this_nSemconsulta = TratarNulo(semconsulta, 0)
                THIS.this_nVarpesoms   = TratarNulo(varpesoms,   0)
                THIS.this_nBestseller  = TratarNulo(bestseller,  0)
                THIS.this_nObrtamser   = TratarNulo(obrtamser,   0)
                THIS.this_nPrototipo   = TratarNulo(prototipo,   0)
                THIS.this_nReposauto   = TratarNulo(reposauto,   0)
                THIS.this_nProcfigjpgs = TratarNulo(procfigjpgs, 0)
                THIS.this_nQtped       = TratarNulo(qtped,       0)

                *-- Campos BIT nativos SQL Server (bit -> logical)
                THIS.this_lFlagctabs = (NVL(flagctabs, 0) = 1)
                THIS.this_lTcomps    = (NVL(tcomps,    0) = 1)
                THIS.this_lTransps   = (NVL(transps,   0) = 1)
                THIS.this_lImpetiqs  = (NVL(impetiqs,  0) = 1)
                THIS.this_lChkfunds  = (NVL(chkfunds,  0) = 1)

                *-- Campos numeric(1,0) com semantica booleana
                THIS.this_lVarias      = (NVL(varias,      0) = 1)
                THIS.this_lConsigs     = (NVL(consigs,     0) = 1)
                THIS.this_lFabrproprs  = (NVL(fabrproprs,  0) = 1)
                THIS.this_lEncoms      = (NVL(encoms,      0) = 1)
                THIS.this_lChkgarvit   = (NVL(chkgarvit,   0) = 1)
                THIS.this_lCravcers    = (NVL(cravcers,    0) = 1)
                THIS.this_lProdwebs    = (NVL(prodwebs,    0) = 1)

                *-- Campos DateTime (converte T->D para usar FormatarDataSQL)
                THIS.this_dDtcomps   = IIF(VARTYPE(dtcomps)   = "T", TTOD(dtcomps),   TratarNulo(dtcomps,   {}))
                THIS.this_dDatas     = IIF(VARTYPE(datas)     = "T", TTOD(datas),     TratarNulo(datas,     {}))
                THIS.this_dDatatrans = IIF(VARTYPE(datatrans) = "T", TTOD(datatrans), TratarNulo(datatrans, {}))
                THIS.this_dDtfilms   = IIF(VARTYPE(dtfilms)   = "T", TTOD(dtfilms),   TratarNulo(dtfilms,   {}))
                THIS.this_dDtincs    = IIF(VARTYPE(dtincs)    = "T", TTOD(dtincs),    TratarNulo(dtincs,    {}))
                THIS.this_dUltcomps  = IIF(VARTYPE(ultcomps)  = "T", TTOD(ultcomps),  TratarNulo(ultcomps,  {}))
                THIS.this_dDtsituas  = IIF(VARTYPE(dtsituas)  = "T", TTOD(dtsituas),  TratarNulo(dtsituas,  {}))
                THIS.this_dDtlacto   = IIF(VARTYPE(dtlacto)   = "T", TTOD(dtlacto),   TratarNulo(dtlacto,   {}))
                THIS.this_dDtalts    = IIF(VARTYPE(dtalts)    = "T", TTOD(dtalts),    TratarNulo(dtalts,    {}))
                THIS.this_dFimdtlacto= IIF(VARTYPE(fimdtlacto)= "T", TTOD(fimdtlacto),TratarNulo(fimdtlacto,{}))

                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_lSucesso, loc_nResultado
        LOCAL loc_cCols, loc_cVals, loc_cSQL
        loc_lSucesso = .F.

        TRY
            *-- Colunas (ordem identica aos valores abaixo)
            loc_cCols = "cpros,dpros,dpro2s,matprincs,cgrus,sgrus," + ;
                        "clfiscals,colecoes,cunis,cunips,cvens,ifors," + ;
                        "linhas,locals,moecs,moecusfs,moedas,moepcs," + ;
                        "moepvs,moevs,notas,obspeds,obspes,origmercs," + ;
                        "reffs,sittricms,tipos,metals,teors,cftios," + ;
                        "codservs,mftios,codcors,codtams,compos,mercs," + ;
                        "tptribs,ipis,codacbs,obsetqs,multcomps,cclass," + ;
                        "nivelqs,cftiocs,usuincs,idecpros,codfinp,codmatp," + ;
                        "status,codgarras,descecfs,extipi,iats,conquilhas," + ;
                        "contaccus,gruccus,codident,conjunts,refracao,refracaodp," + ;
                        "categoria,codctgsite,coddptsite,skuvtex,usuaalts," + ;
                        "lancamento,origemlac,codmacro,propriedades," + ;
                        "unidade1,resultado1,valorminimo,valormaximo,metodoreferencia1," + ;
                        "cproeqs," + ;
                        "descfis,figjpgs,figtecs,dsccompras,obscompras," + ;
                        "dpro3s,figjpgs64,mtiposervs,obsinsp," + ;
                        "cbars,comis,custofs,fcustos,fvendas,icms,margems," + ;
                        "pcuss,pesoms,pvens,pvideals,qmins,valors,situas," + ;
                        "pftios,pftiocs,montadescs,digimaxs,ordcompos,ean13," + ;
                        "qtdcpnts,casas,pesobs,tamhs,tamls,tamps,volumes," + ;
                        "vultcomps,markupa,tinsts,diasinas,qtminfabs,tents," + ;
                        "ltminsv,aliqipis,encargos,idpro,nidentfixa," + ;
                        "pesobris,pesometal,pesopdrs,fatuals,fideals," + ;
                        "prodvars,pmins,cotacalcp,qtdultcomp,diasgar," + ;
                        "altura,largura,diametro,espessura,compriment,mohs," + ;
                        "ativosite,custocp,foralinha,mostruario,precode," + ;
                        "prodnovo,prodoff,segfem,seginf,segkids,segmasc,seguni," + ;
                        "semconsulta,varpesoms,bestseller,obrtamser,prototipo," + ;
                        "reposauto,procfigjpgs,qtped," + ;
                        "flagctabs,tcomps,transps,impetiqs,chkfunds," + ;
                        "varias,consigs,fabrproprs,encoms,chkgarvit,cravcers,prodwebs," + ;
                        "dtcomps,datas,datatrans,dtfilms,dtincs,ultcomps," + ;
                        "dtsituas,dtlacto,dtalts,fimdtlacto"

            *-- Valores char
            loc_cVals = EscaparSQL(ALLTRIM(THIS.this_cCpros))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cDpros))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cDpro2s))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMatprincs))         + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCgrus))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cSgrus))             + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cClfiscals))         + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cColecoes))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCunis))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCunips))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCvens))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cIfors))             + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cLinhas))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cLocals))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMoecs))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMoecusfs))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMoedas))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMoepcs))            + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMoepvs))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMoevs))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cNotas))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cObspeds))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cObspes))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cOrigmercs))         + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cReffs))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cSittricms))         + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cTipos))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMetals))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cTeors))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCftios))            + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodservs))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMftios))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodcors))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodtams))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCompos))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMercs))             + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cTptribs))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cIpis))              + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodacbs))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cObsetqs))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMultcomps))         + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCclass))            + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cNivelqs))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCftiocs))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cUsuincs))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cIdecpros))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodfinp))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodmatp))           + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cStatus))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodgarras))         + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cDescecfs))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cExtipi))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cIats))              + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cConquilhas))        + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContaccus))         + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGruccus))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodident))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cConjunts))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cRefracao))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cRefracaodp))        + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCategoria))         + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodctgsite))        + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCoddptsite))        + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cSkuvtex))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cUsuaalts))          + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cLancamento))        + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cOrigemlac))         + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodmacro))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cPropriedades))      + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cUnidade1))          + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cResultado1))        + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cValorminimo))       + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cValormaximo))       + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMetodoreferencia1)) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCproeqs))           + ","

            *-- Valores memo/text
            loc_cVals = loc_cVals + ;
                        EscaparSQL(THIS.this_cDescfis)                    + "," + ;
                        EscaparSQL(THIS.this_cFigjpgs)                    + "," + ;
                        EscaparSQL(THIS.this_cFigtecs)                    + "," + ;
                        EscaparSQL(THIS.this_cDsccompras)                 + "," + ;
                        EscaparSQL(THIS.this_cObscompras)                 + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(THIS.this_cDpro3s)                     + "," + ;
                        EscaparSQL(THIS.this_cFigjpgs64)                  + "," + ;
                        EscaparSQL(THIS.this_cMtiposervs)                 + "," + ;
                        EscaparSQL(THIS.this_cObsinsp)                    + ","

            *-- Valores numeric
            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nCbars,      0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nComis,      2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nCustofs,    3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nFcustos,    5)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nFvendas,    3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nIcms,       2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nMargems,    6)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nPcuss,      5)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPesoms,     3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPvens,      5)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPvideals,   5)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nQmins,      3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nValors,     2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nSituas,     0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nPftios,     3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPftiocs,    3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nMontadescs, 0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nDigimaxs,   0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nOrdcompos,  0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nEan13,      0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nQtdcpnts,   0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nCasas,      0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPesobs,     3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nTamhs,      2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nTamls,      2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nTamps,      2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nVolumes,    0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nVultcomps,  2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nMarkupa,    3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nTinsts,     0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nDiasinas,   0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nQtminfabs,  3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nTents,      0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nLtminsv,    3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nAliqipis,   2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nEncargos,   4)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nIdpro,      0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nNidentfixa, 0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nPesobris,   3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPesometal,  3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPesopdrs,   3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nFatuals,    5)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nFideals,    5)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nProdvars,   0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPmins,      3)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nCotacalcp,  6)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nQtdultcomp, 0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nDiasgar,    0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nAltura,     4)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nLargura,    4)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nDiametro,   4)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nEspessura,  4)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nCompriment, 4)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nMohs,       0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nAtivosite,  0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nCustocp,    5)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nForalinha,  0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nMostruario, 0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPrecode,    5)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nProdNovo,   0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nProdoff,    0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nSegfem,     0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nSeginf,     0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nSegkids,    0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nSegmasc,    0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nSeguni,     0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nSemconsulta,0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nVarpesoms,  2)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nBestseller, 0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nObrtamser,  0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nPrototipo,  0)       + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nReposauto,  0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nProcfigjpgs,0)       + "," + ;
                        FormatarNumeroSQL(THIS.this_nQtped,      3)       + ","

            *-- Valores BIT nativos (0/1)
            loc_cVals = loc_cVals + ;
                        IIF(THIS.this_lFlagctabs, "1", "0")               + "," + ;
                        IIF(THIS.this_lTcomps,    "1", "0")               + "," + ;
                        IIF(THIS.this_lTransps,   "1", "0")               + "," + ;
                        IIF(THIS.this_lImpetiqs,  "1", "0")               + "," + ;
                        IIF(THIS.this_lChkfunds,  "1", "0")               + ","

            *-- Valores numeric(1,0) booleanos
            loc_cVals = loc_cVals + ;
                        IIF(THIS.this_lVarias,     "1", "0")              + "," + ;
                        IIF(THIS.this_lConsigs,    "1", "0")              + "," + ;
                        IIF(THIS.this_lFabrproprs, "1", "0")              + "," + ;
                        IIF(THIS.this_lEncoms,     "1", "0")              + "," + ;
                        IIF(THIS.this_lChkgarvit,  "1", "0")              + "," + ;
                        IIF(THIS.this_lCravcers,   "1", "0")              + "," + ;
                        IIF(THIS.this_lProdwebs,   "1", "0")              + ","

            *-- Valores DateTime (NULL se vazio)
            loc_cVals = loc_cVals + ;
                        FormatarDataSQL(THIS.this_dDtcomps)               + "," + ;
                        FormatarDataSQL(THIS.this_dDatas)                 + "," + ;
                        FormatarDataSQL(THIS.this_dDatatrans)             + "," + ;
                        FormatarDataSQL(THIS.this_dDtfilms)               + "," + ;
                        FormatarDataSQL(THIS.this_dDtincs)                + "," + ;
                        FormatarDataSQL(THIS.this_dUltcomps)              + ","

            loc_cVals = loc_cVals + ;
                        FormatarDataSQL(THIS.this_dDtsituas)              + "," + ;
                        FormatarDataSQL(THIS.this_dDtlacto)               + "," + ;
                        FormatarDataSQL(THIS.this_dDtalts)                + "," + ;
                        FormatarDataSQL(THIS.this_dFimdtlacto)

            loc_cSQL = "INSERT INTO SigCdPro (" + ;
                       "cpros,dpros,dpro2s,matprincs,cgrus,sgrus," + ;
                       "clfiscals,colecoes,cunis,cunips,cvens,ifors," + ;
                       "linhas,locals,moecs,moecusfs,moedas,moepcs," + ;
                       "moepvs,moevs,notas,obspeds,obspes,origmercs," + ;
                       "reffs,sittricms,tipos,metals,teors,cftios," + ;
                       "codservs,mftios,codcors,codtams,compos,mercs," + ;
                       "tptribs,ipis,codacbs,obsetqs,multcomps,cclass," + ;
                       "nivelqs,cftiocs,usuincs,idecpros,codfinp,codmatp," + ;
                       "status,codgarras,descecfs,extipi,iats,conquilhas," + ;
                       "contaccus,gruccus,codident,conjunts,refracao,refracaodp," + ;
                       "categoria,codctgsite,coddptsite,skuvtex,usuaalts," + ;
                       "lancamento,origemlac,codmacro,propriedades," + ;
                       "unidade1,resultado1,valorminimo,valormaximo,metodoreferencia1," + ;
                       "cproeqs," + ;
                       "descfis,figjpgs,figtecs,dsccompras,obscompras," + ;
                       "dpro3s,figjpgs64,mtiposervs,obsinsp," + ;
                       "cbars,comis,custofs,fcustos,fvendas,icms,margems," + ;
                       "pcuss,pesoms,pvens,pvideals,qmins,valors,situas," + ;
                       "pftios,pftiocs,montadescs,digimaxs,ordcompos,ean13," + ;
                       "qtdcpnts,casas,pesobs,tamhs,tamls,tamps,volumes," + ;
                       "vultcomps,markupa,tinsts,diasinas,qtminfabs,tents," + ;
                       "ltminsv,aliqipis,encargos,idpro,nidentfixa," + ;
                       "pesobris,pesometal,pesopdrs,fatuals,fideals," + ;
                       "prodvars,pmins,cotacalcp,qtdultcomp,diasgar," + ;
                       "altura,largura,diametro,espessura,compriment,mohs," + ;
                       "ativosite,custocp,foralinha,mostruario,precode," + ;
                       "prodnovo,prodoff,segfem,seginf,segkids,segmasc,seguni," + ;
                       "semconsulta,varpesoms,bestseller,obrtamser,prototipo," + ;
                       "reposauto,procfigjpgs,qtped," + ;
                       "flagctabs,tcomps,transps,impetiqs,chkfunds," + ;
                       "varias,consigs,fabrproprs,encoms,chkgarvit,cravcers,prodwebs," + ;
                       "dtcomps,datas,datatrans,dtfilms,dtincs,ultcomps," + ;
                       "dtsituas,dtlacto,dtalts,fimdtlacto" + ;
                       ") VALUES (" + loc_cVals + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                THIS.SalvarFases(ALLTRIM(THIS.this_cCpros))
                THIS.SalvarMatrizes(ALLTRIM(THIS.this_cCpros))
                THIS.SalvarTarefasDesigner(ALLTRIM(THIS.this_cCpros))
                THIS.SalvarArquivosDesigner(ALLTRIM(THIS.this_cCpros))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao inserir produto:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.Inserir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPro SET"
            loc_cSQL = loc_cSQL + " dpros          = " + EscaparSQL(ALLTRIM(THIS.this_cDpros))             + ","
            loc_cSQL = loc_cSQL + " dpro2s         = " + EscaparSQL(ALLTRIM(THIS.this_cDpro2s))            + ","
            loc_cSQL = loc_cSQL + " matprincs      = " + EscaparSQL(ALLTRIM(THIS.this_cMatprincs))         + ","
            loc_cSQL = loc_cSQL + " cgrus          = " + EscaparSQL(ALLTRIM(THIS.this_cCgrus))             + ","
            loc_cSQL = loc_cSQL + " sgrus          = " + EscaparSQL(ALLTRIM(THIS.this_cSgrus))             + ","
            loc_cSQL = loc_cSQL + " clfiscals      = " + EscaparSQL(ALLTRIM(THIS.this_cClfiscals))         + ","
            loc_cSQL = loc_cSQL + " colecoes       = " + EscaparSQL(ALLTRIM(THIS.this_cColecoes))          + ","
            loc_cSQL = loc_cSQL + " cunis          = " + EscaparSQL(ALLTRIM(THIS.this_cCunis))             + ","
            loc_cSQL = loc_cSQL + " cunips         = " + EscaparSQL(ALLTRIM(THIS.this_cCunips))            + ","
            loc_cSQL = loc_cSQL + " cvens          = " + EscaparSQL(ALLTRIM(THIS.this_cCvens))             + ","
            loc_cSQL = loc_cSQL + " ifors          = " + EscaparSQL(ALLTRIM(THIS.this_cIfors))             + ","
            loc_cSQL = loc_cSQL + " linhas         = " + EscaparSQL(ALLTRIM(THIS.this_cLinhas))            + ","
            loc_cSQL = loc_cSQL + " locals         = " + EscaparSQL(ALLTRIM(THIS.this_cLocals))            + ","
            loc_cSQL = loc_cSQL + " moecs          = " + EscaparSQL(ALLTRIM(THIS.this_cMoecs))             + ","
            loc_cSQL = loc_cSQL + " moecusfs       = " + EscaparSQL(ALLTRIM(THIS.this_cMoecusfs))          + ","
            loc_cSQL = loc_cSQL + " moedas         = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas))            + ","
            loc_cSQL = loc_cSQL + " moepcs         = " + EscaparSQL(ALLTRIM(THIS.this_cMoepcs))            + ","
            loc_cSQL = loc_cSQL + " moepvs         = " + EscaparSQL(ALLTRIM(THIS.this_cMoepvs))            + ","
            loc_cSQL = loc_cSQL + " moevs          = " + EscaparSQL(ALLTRIM(THIS.this_cMoevs))             + ","
            loc_cSQL = loc_cSQL + " notas          = " + EscaparSQL(ALLTRIM(THIS.this_cNotas))             + ","
            loc_cSQL = loc_cSQL + " obspeds        = " + EscaparSQL(ALLTRIM(THIS.this_cObspeds))           + ","
            loc_cSQL = loc_cSQL + " obspes         = " + EscaparSQL(ALLTRIM(THIS.this_cObspes))            + ","
            loc_cSQL = loc_cSQL + " origmercs      = " + EscaparSQL(ALLTRIM(THIS.this_cOrigmercs))         + ","
            loc_cSQL = loc_cSQL + " reffs          = " + EscaparSQL(ALLTRIM(THIS.this_cReffs))             + ","
            loc_cSQL = loc_cSQL + " sittricms      = " + EscaparSQL(ALLTRIM(THIS.this_cSittricms))         + ","
            loc_cSQL = loc_cSQL + " tipos          = " + EscaparSQL(ALLTRIM(THIS.this_cTipos))             + ","
            loc_cSQL = loc_cSQL + " metals         = " + EscaparSQL(ALLTRIM(THIS.this_cMetals))            + ","
            loc_cSQL = loc_cSQL + " teors          = " + EscaparSQL(ALLTRIM(THIS.this_cTeors))             + ","
            loc_cSQL = loc_cSQL + " cftios         = " + EscaparSQL(ALLTRIM(THIS.this_cCftios))            + ","
            loc_cSQL = loc_cSQL + " codservs       = " + EscaparSQL(ALLTRIM(THIS.this_cCodservs))          + ","
            loc_cSQL = loc_cSQL + " mftios         = " + EscaparSQL(ALLTRIM(THIS.this_cMftios))            + ","
            loc_cSQL = loc_cSQL + " codcors        = " + EscaparSQL(ALLTRIM(THIS.this_cCodcors))           + ","
            loc_cSQL = loc_cSQL + " codtams        = " + EscaparSQL(ALLTRIM(THIS.this_cCodtams))           + ","
            loc_cSQL = loc_cSQL + " compos         = " + EscaparSQL(ALLTRIM(THIS.this_cCompos))            + ","
            loc_cSQL = loc_cSQL + " mercs          = " + EscaparSQL(ALLTRIM(THIS.this_cMercs))             + ","
            loc_cSQL = loc_cSQL + " tptribs        = " + EscaparSQL(ALLTRIM(THIS.this_cTptribs))           + ","
            loc_cSQL = loc_cSQL + " ipis           = " + EscaparSQL(ALLTRIM(THIS.this_cIpis))              + ","
            loc_cSQL = loc_cSQL + " codacbs        = " + EscaparSQL(ALLTRIM(THIS.this_cCodacbs))           + ","
            loc_cSQL = loc_cSQL + " obsetqs        = " + EscaparSQL(ALLTRIM(THIS.this_cObsetqs))           + ","
            loc_cSQL = loc_cSQL + " multcomps      = " + EscaparSQL(ALLTRIM(THIS.this_cMultcomps))         + ","
            loc_cSQL = loc_cSQL + " cclass         = " + EscaparSQL(ALLTRIM(THIS.this_cCclass))            + ","
            loc_cSQL = loc_cSQL + " nivelqs        = " + EscaparSQL(ALLTRIM(THIS.this_cNivelqs))           + ","
            loc_cSQL = loc_cSQL + " cftiocs        = " + EscaparSQL(ALLTRIM(THIS.this_cCftiocs))           + ","
            loc_cSQL = loc_cSQL + " usuincs        = " + EscaparSQL(ALLTRIM(THIS.this_cUsuincs))           + ","
            loc_cSQL = loc_cSQL + " idecpros       = " + EscaparSQL(ALLTRIM(THIS.this_cIdecpros))          + ","
            loc_cSQL = loc_cSQL + " codfinp        = " + EscaparSQL(ALLTRIM(THIS.this_cCodfinp))           + ","
            loc_cSQL = loc_cSQL + " codmatp        = " + EscaparSQL(ALLTRIM(THIS.this_cCodmatp))           + ","
            loc_cSQL = loc_cSQL + " status         = " + EscaparSQL(ALLTRIM(THIS.this_cStatus))            + ","
            loc_cSQL = loc_cSQL + " codgarras      = " + EscaparSQL(ALLTRIM(THIS.this_cCodgarras))         + ","
            loc_cSQL = loc_cSQL + " descecfs       = " + EscaparSQL(ALLTRIM(THIS.this_cDescecfs))          + ","
            loc_cSQL = loc_cSQL + " extipi         = " + EscaparSQL(ALLTRIM(THIS.this_cExtipi))            + ","
            loc_cSQL = loc_cSQL + " iats           = " + EscaparSQL(ALLTRIM(THIS.this_cIats))              + ","
            loc_cSQL = loc_cSQL + " conquilhas     = " + EscaparSQL(ALLTRIM(THIS.this_cConquilhas))        + ","
            loc_cSQL = loc_cSQL + " contaccus      = " + EscaparSQL(ALLTRIM(THIS.this_cContaccus))         + ","
            loc_cSQL = loc_cSQL + " gruccus        = " + EscaparSQL(ALLTRIM(THIS.this_cGruccus))           + ","
            loc_cSQL = loc_cSQL + " codident       = " + EscaparSQL(ALLTRIM(THIS.this_cCodident))          + ","
            loc_cSQL = loc_cSQL + " conjunts       = " + EscaparSQL(ALLTRIM(THIS.this_cConjunts))          + ","
            loc_cSQL = loc_cSQL + " refracao       = " + EscaparSQL(ALLTRIM(THIS.this_cRefracao))          + ","
            loc_cSQL = loc_cSQL + " refracaodp     = " + EscaparSQL(ALLTRIM(THIS.this_cRefracaodp))        + ","
            loc_cSQL = loc_cSQL + " categoria      = " + EscaparSQL(ALLTRIM(THIS.this_cCategoria))         + ","
            loc_cSQL = loc_cSQL + " codctgsite     = " + EscaparSQL(ALLTRIM(THIS.this_cCodctgsite))        + ","
            loc_cSQL = loc_cSQL + " coddptsite     = " + EscaparSQL(ALLTRIM(THIS.this_cCoddptsite))        + ","
            loc_cSQL = loc_cSQL + " skuvtex        = " + EscaparSQL(ALLTRIM(THIS.this_cSkuvtex))           + ","
            loc_cSQL = loc_cSQL + " usuaalts       = " + EscaparSQL(ALLTRIM(THIS.this_cUsuaalts))          + ","
            loc_cSQL = loc_cSQL + " lancamento     = " + EscaparSQL(ALLTRIM(THIS.this_cLancamento))        + ","
            loc_cSQL = loc_cSQL + " origemlac      = " + EscaparSQL(ALLTRIM(THIS.this_cOrigemlac))         + ","
            loc_cSQL = loc_cSQL + " codmacro       = " + EscaparSQL(ALLTRIM(THIS.this_cCodmacro))          + ","
            loc_cSQL = loc_cSQL + " propriedades   = " + EscaparSQL(ALLTRIM(THIS.this_cPropriedades))      + ","
            loc_cSQL = loc_cSQL + " unidade1       = " + EscaparSQL(ALLTRIM(THIS.this_cUnidade1))          + ","
            loc_cSQL = loc_cSQL + " resultado1     = " + EscaparSQL(ALLTRIM(THIS.this_cResultado1))        + ","
            loc_cSQL = loc_cSQL + " valorminimo    = " + EscaparSQL(ALLTRIM(THIS.this_cValorminimo))       + ","
            loc_cSQL = loc_cSQL + " valormaximo    = " + EscaparSQL(ALLTRIM(THIS.this_cValormaximo))       + ","
            loc_cSQL = loc_cSQL + " metodoreferencia1 = " + EscaparSQL(ALLTRIM(THIS.this_cMetodoreferencia1)) + ","
            loc_cSQL = loc_cSQL + " cproeqs        = " + EscaparSQL(ALLTRIM(THIS.this_cCproeqs))           + ","

            *-- Memo/Text
            loc_cSQL = loc_cSQL + " descfis        = " + EscaparSQL(THIS.this_cDescfis)                    + ","
            loc_cSQL = loc_cSQL + " figjpgs        = " + EscaparSQL(THIS.this_cFigjpgs)                    + ","
            loc_cSQL = loc_cSQL + " figtecs        = " + EscaparSQL(THIS.this_cFigtecs)                    + ","
            loc_cSQL = loc_cSQL + " dsccompras     = " + EscaparSQL(THIS.this_cDsccompras)                 + ","
            loc_cSQL = loc_cSQL + " obscompras     = " + EscaparSQL(THIS.this_cObscompras)                 + ","
            loc_cSQL = loc_cSQL + " dpro3s         = " + EscaparSQL(THIS.this_cDpro3s)                     + ","
            loc_cSQL = loc_cSQL + " figjpgs64      = " + EscaparSQL(THIS.this_cFigjpgs64)                  + ","
            loc_cSQL = loc_cSQL + " mtiposervs     = " + EscaparSQL(THIS.this_cMtiposervs)                 + ","
            loc_cSQL = loc_cSQL + " obsinsp        = " + EscaparSQL(THIS.this_cObsinsp)                    + ","

            *-- Numeric
            loc_cSQL = loc_cSQL + " cbars          = " + FormatarNumeroSQL(THIS.this_nCbars,      0)       + ","
            loc_cSQL = loc_cSQL + " comis          = " + FormatarNumeroSQL(THIS.this_nComis,      2)       + ","
            loc_cSQL = loc_cSQL + " custofs        = " + FormatarNumeroSQL(THIS.this_nCustofs,    3)       + ","
            loc_cSQL = loc_cSQL + " fcustos        = " + FormatarNumeroSQL(THIS.this_nFcustos,    5)       + ","
            loc_cSQL = loc_cSQL + " fvendas        = " + FormatarNumeroSQL(THIS.this_nFvendas,    3)       + ","
            loc_cSQL = loc_cSQL + " icms           = " + FormatarNumeroSQL(THIS.this_nIcms,       2)       + ","
            loc_cSQL = loc_cSQL + " margems        = " + FormatarNumeroSQL(THIS.this_nMargems,    6)       + ","
            loc_cSQL = loc_cSQL + " pcuss          = " + FormatarNumeroSQL(THIS.this_nPcuss,      5)       + ","
            loc_cSQL = loc_cSQL + " pesoms         = " + FormatarNumeroSQL(THIS.this_nPesoms,     3)       + ","
            loc_cSQL = loc_cSQL + " pvens          = " + FormatarNumeroSQL(THIS.this_nPvens,      5)       + ","
            loc_cSQL = loc_cSQL + " pvideals       = " + FormatarNumeroSQL(THIS.this_nPvideals,   5)       + ","
            loc_cSQL = loc_cSQL + " qmins          = " + FormatarNumeroSQL(THIS.this_nQmins,      3)       + ","
            loc_cSQL = loc_cSQL + " valors         = " + FormatarNumeroSQL(THIS.this_nValors,     2)       + ","
            loc_cSQL = loc_cSQL + " situas         = " + FormatarNumeroSQL(THIS.this_nSituas,     0)       + ","
            loc_cSQL = loc_cSQL + " pftios         = " + FormatarNumeroSQL(THIS.this_nPftios,     3)       + ","
            loc_cSQL = loc_cSQL + " pftiocs        = " + FormatarNumeroSQL(THIS.this_nPftiocs,    3)       + ","
            loc_cSQL = loc_cSQL + " montadescs     = " + FormatarNumeroSQL(THIS.this_nMontadescs, 0)       + ","
            loc_cSQL = loc_cSQL + " digimaxs       = " + FormatarNumeroSQL(THIS.this_nDigimaxs,   0)       + ","
            loc_cSQL = loc_cSQL + " ordcompos      = " + FormatarNumeroSQL(THIS.this_nOrdcompos,  0)       + ","
            loc_cSQL = loc_cSQL + " ean13          = " + FormatarNumeroSQL(THIS.this_nEan13,      0)       + ","
            loc_cSQL = loc_cSQL + " qtdcpnts       = " + FormatarNumeroSQL(THIS.this_nQtdcpnts,   0)       + ","
            loc_cSQL = loc_cSQL + " casas          = " + FormatarNumeroSQL(THIS.this_nCasas,      0)       + ","
            loc_cSQL = loc_cSQL + " pesobs         = " + FormatarNumeroSQL(THIS.this_nPesobs,     3)       + ","
            loc_cSQL = loc_cSQL + " tamhs          = " + FormatarNumeroSQL(THIS.this_nTamhs,      2)       + ","
            loc_cSQL = loc_cSQL + " tamls          = " + FormatarNumeroSQL(THIS.this_nTamls,      2)       + ","
            loc_cSQL = loc_cSQL + " tamps          = " + FormatarNumeroSQL(THIS.this_nTamps,      2)       + ","
            loc_cSQL = loc_cSQL + " volumes        = " + FormatarNumeroSQL(THIS.this_nVolumes,    0)       + ","
            loc_cSQL = loc_cSQL + " vultcomps      = " + FormatarNumeroSQL(THIS.this_nVultcomps,  2)       + ","
            loc_cSQL = loc_cSQL + " markupa        = " + FormatarNumeroSQL(THIS.this_nMarkupa,    3)       + ","
            loc_cSQL = loc_cSQL + " tinsts         = " + FormatarNumeroSQL(THIS.this_nTinsts,     0)       + ","
            loc_cSQL = loc_cSQL + " diasinas       = " + FormatarNumeroSQL(THIS.this_nDiasinas,   0)       + ","
            loc_cSQL = loc_cSQL + " qtminfabs      = " + FormatarNumeroSQL(THIS.this_nQtminfabs,  3)       + ","
            loc_cSQL = loc_cSQL + " tents          = " + FormatarNumeroSQL(THIS.this_nTents,      0)       + ","
            loc_cSQL = loc_cSQL + " ltminsv        = " + FormatarNumeroSQL(THIS.this_nLtminsv,    3)       + ","
            loc_cSQL = loc_cSQL + " aliqipis       = " + FormatarNumeroSQL(THIS.this_nAliqipis,   2)       + ","
            loc_cSQL = loc_cSQL + " encargos       = " + FormatarNumeroSQL(THIS.this_nEncargos,   4)       + ","
            loc_cSQL = loc_cSQL + " idpro          = " + FormatarNumeroSQL(THIS.this_nIdpro,      0)       + ","
            loc_cSQL = loc_cSQL + " nidentfixa     = " + FormatarNumeroSQL(THIS.this_nNidentfixa, 0)       + ","
            loc_cSQL = loc_cSQL + " pesobris       = " + FormatarNumeroSQL(THIS.this_nPesobris,   3)       + ","
            loc_cSQL = loc_cSQL + " pesometal      = " + FormatarNumeroSQL(THIS.this_nPesometal,  3)       + ","
            loc_cSQL = loc_cSQL + " pesopdrs       = " + FormatarNumeroSQL(THIS.this_nPesopdrs,   3)       + ","
            loc_cSQL = loc_cSQL + " fatuals        = " + FormatarNumeroSQL(THIS.this_nFatuals,    5)       + ","
            loc_cSQL = loc_cSQL + " fideals        = " + FormatarNumeroSQL(THIS.this_nFideals,    5)       + ","
            loc_cSQL = loc_cSQL + " prodvars       = " + FormatarNumeroSQL(THIS.this_nProdvars,   0)       + ","
            loc_cSQL = loc_cSQL + " pmins          = " + FormatarNumeroSQL(THIS.this_nPmins,      3)       + ","
            loc_cSQL = loc_cSQL + " cotacalcp      = " + FormatarNumeroSQL(THIS.this_nCotacalcp,  6)       + ","
            loc_cSQL = loc_cSQL + " qtdultcomp     = " + FormatarNumeroSQL(THIS.this_nQtdultcomp, 0)       + ","
            loc_cSQL = loc_cSQL + " diasgar        = " + FormatarNumeroSQL(THIS.this_nDiasgar,    0)       + ","
            loc_cSQL = loc_cSQL + " altura         = " + FormatarNumeroSQL(THIS.this_nAltura,     4)       + ","
            loc_cSQL = loc_cSQL + " largura        = " + FormatarNumeroSQL(THIS.this_nLargura,    4)       + ","
            loc_cSQL = loc_cSQL + " diametro       = " + FormatarNumeroSQL(THIS.this_nDiametro,   4)       + ","
            loc_cSQL = loc_cSQL + " espessura      = " + FormatarNumeroSQL(THIS.this_nEspessura,  4)       + ","
            loc_cSQL = loc_cSQL + " compriment     = " + FormatarNumeroSQL(THIS.this_nCompriment, 4)       + ","
            loc_cSQL = loc_cSQL + " mohs           = " + FormatarNumeroSQL(THIS.this_nMohs,       0)       + ","
            loc_cSQL = loc_cSQL + " ativosite      = " + FormatarNumeroSQL(THIS.this_nAtivosite,  0)       + ","
            loc_cSQL = loc_cSQL + " custocp        = " + FormatarNumeroSQL(THIS.this_nCustocp,    5)       + ","
            loc_cSQL = loc_cSQL + " foralinha      = " + FormatarNumeroSQL(THIS.this_nForalinha,  0)       + ","
            loc_cSQL = loc_cSQL + " mostruario     = " + FormatarNumeroSQL(THIS.this_nMostruario, 0)       + ","
            loc_cSQL = loc_cSQL + " precode        = " + FormatarNumeroSQL(THIS.this_nPrecode,    5)       + ","
            loc_cSQL = loc_cSQL + " prodnovo       = " + FormatarNumeroSQL(THIS.this_nProdNovo,   0)       + ","
            loc_cSQL = loc_cSQL + " prodoff        = " + FormatarNumeroSQL(THIS.this_nProdoff,    0)       + ","
            loc_cSQL = loc_cSQL + " segfem         = " + FormatarNumeroSQL(THIS.this_nSegfem,     0)       + ","
            loc_cSQL = loc_cSQL + " seginf         = " + FormatarNumeroSQL(THIS.this_nSeginf,     0)       + ","
            loc_cSQL = loc_cSQL + " segkids        = " + FormatarNumeroSQL(THIS.this_nSegkids,    0)       + ","
            loc_cSQL = loc_cSQL + " segmasc        = " + FormatarNumeroSQL(THIS.this_nSegmasc,    0)       + ","
            loc_cSQL = loc_cSQL + " seguni         = " + FormatarNumeroSQL(THIS.this_nSeguni,     0)       + ","
            loc_cSQL = loc_cSQL + " semconsulta    = " + FormatarNumeroSQL(THIS.this_nSemconsulta,0)       + ","
            loc_cSQL = loc_cSQL + " varpesoms      = " + FormatarNumeroSQL(THIS.this_nVarpesoms,  2)       + ","
            loc_cSQL = loc_cSQL + " bestseller     = " + FormatarNumeroSQL(THIS.this_nBestseller, 0)       + ","
            loc_cSQL = loc_cSQL + " obrtamser      = " + FormatarNumeroSQL(THIS.this_nObrtamser,  0)       + ","
            loc_cSQL = loc_cSQL + " prototipo      = " + FormatarNumeroSQL(THIS.this_nPrototipo,  0)       + ","
            loc_cSQL = loc_cSQL + " reposauto      = " + FormatarNumeroSQL(THIS.this_nReposauto,  0)       + ","
            loc_cSQL = loc_cSQL + " procfigjpgs    = " + FormatarNumeroSQL(THIS.this_nProcfigjpgs,0)       + ","
            loc_cSQL = loc_cSQL + " qtped          = " + FormatarNumeroSQL(THIS.this_nQtped,      3)       + ","

            *-- BIT nativos
            loc_cSQL = loc_cSQL + " flagctabs      = " + IIF(THIS.this_lFlagctabs, "1", "0")               + ","
            loc_cSQL = loc_cSQL + " tcomps         = " + IIF(THIS.this_lTcomps,    "1", "0")               + ","
            loc_cSQL = loc_cSQL + " transps        = " + IIF(THIS.this_lTransps,   "1", "0")               + ","
            loc_cSQL = loc_cSQL + " impetiqs       = " + IIF(THIS.this_lImpetiqs,  "1", "0")               + ","
            loc_cSQL = loc_cSQL + " chkfunds       = " + IIF(THIS.this_lChkfunds,  "1", "0")               + ","

            *-- Numeric(1,0) booleanos
            loc_cSQL = loc_cSQL + " varias         = " + IIF(THIS.this_lVarias,     "1", "0")              + ","
            loc_cSQL = loc_cSQL + " consigs        = " + IIF(THIS.this_lConsigs,    "1", "0")              + ","
            loc_cSQL = loc_cSQL + " fabrproprs     = " + IIF(THIS.this_lFabrproprs, "1", "0")              + ","
            loc_cSQL = loc_cSQL + " encoms         = " + IIF(THIS.this_lEncoms,     "1", "0")              + ","
            loc_cSQL = loc_cSQL + " chkgarvit      = " + IIF(THIS.this_lChkgarvit,  "1", "0")              + ","
            loc_cSQL = loc_cSQL + " cravcers       = " + IIF(THIS.this_lCravcers,   "1", "0")              + ","
            loc_cSQL = loc_cSQL + " prodwebs       = " + IIF(THIS.this_lProdwebs,   "1", "0")              + ","

            *-- DateTime
            loc_cSQL = loc_cSQL + " dtcomps        = " + FormatarDataSQL(THIS.this_dDtcomps)               + ","
            loc_cSQL = loc_cSQL + " datas          = " + FormatarDataSQL(THIS.this_dDatas)                 + ","
            loc_cSQL = loc_cSQL + " datatrans      = " + FormatarDataSQL(THIS.this_dDatatrans)             + ","
            loc_cSQL = loc_cSQL + " dtfilms        = " + FormatarDataSQL(THIS.this_dDtfilms)               + ","
            loc_cSQL = loc_cSQL + " dtincs         = " + FormatarDataSQL(THIS.this_dDtincs)                + ","
            loc_cSQL = loc_cSQL + " ultcomps       = " + FormatarDataSQL(THIS.this_dUltcomps)              + ","
            loc_cSQL = loc_cSQL + " dtsituas       = " + FormatarDataSQL(THIS.this_dDtsituas)              + ","
            loc_cSQL = loc_cSQL + " dtlacto        = " + FormatarDataSQL(THIS.this_dDtlacto)               + ","
            loc_cSQL = loc_cSQL + " dtalts         = " + FormatarDataSQL(THIS.this_dDtalts)                + ","
            loc_cSQL = loc_cSQL + " fimdtlacto     = " + FormatarDataSQL(THIS.this_dFimdtlacto)

            loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                THIS.SalvarFases(ALLTRIM(THIS.this_cCpros))
                THIS.SalvarMatrizes(ALLTRIM(THIS.this_cCpros))
                THIS.SalvarTarefasDesigner(ALLTRIM(THIS.this_cCpros))
                THIS.SalvarArquivosDesigner(ALLTRIM(THIS.this_cCpros))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao atualizar produto:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.Atualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPro WHERE cpros = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao excluir produto:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.ExecutarExclusao")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca lista de produtos para o grid da tela
    * par_cFiltro: clausula WHERE opcional (sem o WHERE)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
        loc_lSucesso = .F.

        TRY
            *-- Sem conexao: cria cursor vazio para nao bloquear o grid
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (;
                        cpros    C(14), dpros  C(65), cgrus C(3), ;
                        sgrus    C(6),  reffs  C(40), ;
                        usuaalts C(20), situas N(1,0))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cpros, dpros, cgrus, sgrus, reffs, usuaalts, situas" + ;
                           " FROM SigCdPro"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY dpros"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = CapturarErroSQL()
                        MsgErro("Erro ao buscar produtos:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = CapturarErroSQL()
                        MsgErro("Erro ao buscar produtos:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo pelo cpros (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCdPro WHERE cpros = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    IF loc_lSucesso
                        THIS.CarregarFases(ALLTRIM(par_cCodigo))
                        THIS.CarregarMatrizes(ALLTRIM(par_cCodigo))
                        THIS.CarregarTarefasDesigner(ALLTRIM(par_cCodigo))
                        THIS.CarregarArquivosDesigner(ALLTRIM(par_cCodigo))
                        THIS.CarregarCmv(ALLTRIM(par_cCodigo))
                    ENDIF
                ELSE
                    MsgAviso("Produto n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar produto:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarFases - Carrega SigCdPrf (fases de producao) para cursor_4c_GradFase
    * Chamado por CarregarPorCodigo apos sucesso
    *==========================================================================
    PROCEDURE CarregarFases(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL
        TRY
            loc_cSQL = "SELECT a.Ordems, a.Grupos, ISNULL(b.Descrs,'') AS Descrs, " + ;
                       "a.UniPrdts, a.MatPrdts, a.Obs, a.FigProcs " + ;
                       "FROM SigCdPrf a " + ;
                       "LEFT JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                       "WHERE a.Produtos = " + EscaparSQL(par_cCpros) + ;
                       " ORDER BY a.Ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GradFaseTmp")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_GradFase")
                    SELECT cursor_4c_GradFase
                    ZAP
                    APPEND FROM DBF("cursor_4c_GradFaseTmp")
                ENDIF
                IF USED("cursor_4c_GradFaseTmp")
                    USE IN cursor_4c_GradFaseTmp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar fases:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.CarregarFases")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.CarregarFases")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarMatrizes - Carrega SigPrMtz (matrizes do produto) para cursor_4c_SigPrMtz
    *==========================================================================
    PROCEDURE CarregarMatrizes(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL
        TRY
            loc_cSQL = "SELECT a.CMats, ISNULL(b.Locals,'') AS DLocs, a.Qtds " + ;
                       "FROM SigPrMtz a " + ;
                       "LEFT JOIN SigCdPro b ON a.CMats = b.CPros " + ;
                       "WHERE a.CPros = " + EscaparSQL(par_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrMtzTmp")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_SigPrMtz")
                    SELECT cursor_4c_SigPrMtz
                    ZAP
                    APPEND FROM DBF("cursor_4c_SigPrMtzTmp")
                ENDIF
                IF USED("cursor_4c_SigPrMtzTmp")
                    USE IN cursor_4c_SigPrMtzTmp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar matrizes:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.CarregarMatrizes")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.CarregarMatrizes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarTarefasDesigner - Carrega SigPrTar para cursor_4c_SigPrTar
    *==========================================================================
    PROCEDURE CarregarTarefasDesigner(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL
        TRY
            loc_cSQL = "SELECT DtInis, DtFims, Usuars, Tarefas, ObsTars " + ;
                       "FROM SigPrTar " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCpros) + ;
                       " ORDER BY DtInis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrTarTmp")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_SigPrTar")
                    SELECT cursor_4c_SigPrTar
                    ZAP
                    APPEND FROM DBF("cursor_4c_SigPrTarTmp")
                ENDIF
                IF USED("cursor_4c_SigPrTarTmp")
                    USE IN cursor_4c_SigPrTarTmp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar tarefas:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.CarregarTarefasDesigner")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.CarregarTarefasDesigner")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarArquivosDesigner - Carrega SigPrArq para cursor_4c_SigPrArq
    *==========================================================================
    PROCEDURE CarregarArquivosDesigner(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL
        TRY
            loc_cSQL = "SELECT Arquivos FROM SigPrArq " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrArqTmp")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_SigPrArq")
                    SELECT cursor_4c_SigPrArq
                    ZAP
                    APPEND FROM DBF("cursor_4c_SigPrArqTmp")
                ENDIF
                IF USED("cursor_4c_SigPrArqTmp")
                    USE IN cursor_4c_SigPrArqTmp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar arquivos:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.CarregarArquivosDesigner")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.CarregarArquivosDesigner")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarCmv - Carrega SigCdCmv (historico CMV) para cursor_4c_Cmv
    *==========================================================================
    PROCEDURE CarregarCmv(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL
        TRY
            loc_cSQL = "SELECT CAST(Datas AS DATE) AS Datas, ValCuss, Moedas " + ;
                       "FROM SigCdCmv " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCpros) + ;
                       " ORDER BY Datas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTmp")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Cmv")
                    SELECT cursor_4c_Cmv
                    ZAP
                    APPEND FROM DBF("cursor_4c_CmvTmp")
                ENDIF
                IF USED("cursor_4c_CmvTmp")
                    USE IN cursor_4c_CmvTmp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar CMV:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.CarregarCmv")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.CarregarCmv")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarFases - DELETE + INSERT SigCdPrf a partir de cursor_4c_GradFase
    * Chamado por Inserir/Atualizar
    *==========================================================================
    PROTECTED PROCEDURE SalvarFases(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL, loc_lOk
        loc_lOk = .T.
        TRY
            IF !USED("cursor_4c_GradFase")
                RETURN
            ENDIF

            *-- Limpa registros existentes
            loc_cSQL = "DELETE FROM SigCdPrf WHERE Produtos = " + EscaparSQL(par_cCpros)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao limpar fases:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.SalvarFases")
                RETURN
            ENDIF

            *-- Reinsere cada linha do cursor
            SELECT cursor_4c_GradFase
            GO TOP IN cursor_4c_GradFase
            DO WHILE !EOF("cursor_4c_GradFase")
                loc_cSQL = "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, UniPrdts, MatPrdts) VALUES (" + ;
                           EscaparSQL(par_cCpros)                                   + "," + ;
                           FormatarNumeroSQL(cursor_4c_GradFase.Ordems)             + "," + ;
                           EscaparSQL(ALLTRIM(NVL(cursor_4c_GradFase.Grupos, "")))  + "," + ;
                           EscaparSQL(ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts,""))) + "," + ;
                           EscaparSQL(ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts,""))) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao salvar fase:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.SalvarFases")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                SKIP IN cursor_4c_GradFase
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.SalvarFases")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarMatrizes - DELETE + INSERT SigPrMtz a partir de cursor_4c_SigPrMtz
    *==========================================================================
    PROTECTED PROCEDURE SalvarMatrizes(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL
        TRY
            IF !USED("cursor_4c_SigPrMtz")
                RETURN
            ENDIF

            loc_cSQL = "DELETE FROM SigPrMtz WHERE CPros = " + EscaparSQL(par_cCpros)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao limpar matrizes:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.SalvarMatrizes")
                RETURN
            ENDIF

            SELECT cursor_4c_SigPrMtz
            GO TOP IN cursor_4c_SigPrMtz
            DO WHILE !EOF("cursor_4c_SigPrMtz")
                IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
                    loc_cSQL = "INSERT INTO SigPrMtz (CPros, CMats, Qtds) VALUES (" + ;
                               EscaparSQL(par_cCpros)                                    + "," + ;
                               EscaparSQL(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))   + "," + ;
                               FormatarNumeroSQL(NVL(cursor_4c_SigPrMtz.Qtds, 0))       + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = CapturarErroSQL()
                        MsgErro("Erro ao salvar matriz:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.SalvarMatrizes")
                        EXIT
                    ENDIF
                ENDIF
                SKIP IN cursor_4c_SigPrMtz
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.SalvarMatrizes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarTarefasDesigner - DELETE + INSERT SigPrTar a partir de cursor_4c_SigPrTar
    *==========================================================================
    PROTECTED PROCEDURE SalvarTarefasDesigner(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL
        TRY
            IF !USED("cursor_4c_SigPrTar")
                RETURN
            ENDIF

            loc_cSQL = "DELETE FROM SigPrTar WHERE CPros = " + EscaparSQL(par_cCpros)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao limpar tarefas:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.SalvarTarefasDesigner")
                RETURN
            ENDIF

            SELECT cursor_4c_SigPrTar
            GO TOP IN cursor_4c_SigPrTar
            DO WHILE !EOF("cursor_4c_SigPrTar")
                loc_cSQL = "INSERT INTO SigPrTar (CPros, DtInis, DtFims, Usuars, Tarefas, ObsTars) VALUES (" + ;
                           EscaparSQL(par_cCpros)                                        + "," + ;
                           FormatarDataSQL(cursor_4c_SigPrTar.DtInis)                    + "," + ;
                           FormatarDataSQL(cursor_4c_SigPrTar.DtFims)                    + "," + ;
                           EscaparSQL(ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")))       + "," + ;
                           EscaparSQL(ALLTRIM(NVL(cursor_4c_SigPrTar.Tarefas, "")))      + "," + ;
                           EscaparSQL(ALLTRIM(NVL(cursor_4c_SigPrTar.ObsTars, "")))      + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao salvar tarefa:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.SalvarTarefasDesigner")
                    EXIT
                ENDIF
                SKIP IN cursor_4c_SigPrTar
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.SalvarTarefasDesigner")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarArquivosDesigner - DELETE + INSERT SigPrArq a partir de cursor_4c_SigPrArq
    *==========================================================================
    PROTECTED PROCEDURE SalvarArquivosDesigner(par_cCpros)
        LOCAL loc_nResultado, loc_cSQL
        TRY
            IF !USED("cursor_4c_SigPrArq")
                RETURN
            ENDIF

            loc_cSQL = "DELETE FROM SigPrArq WHERE CPros = " + EscaparSQL(par_cCpros)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao limpar arquivos:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.SalvarArquivosDesigner")
                RETURN
            ENDIF

            SELECT cursor_4c_SigPrArq
            GO TOP IN cursor_4c_SigPrArq
            DO WHILE !EOF("cursor_4c_SigPrArq")
                IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
                    loc_cSQL = "INSERT INTO SigPrArq (CPros, Arquivos) VALUES (" + ;
                               EscaparSQL(par_cCpros)                                         + "," + ;
                               EscaparSQL(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))      + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = CapturarErroSQL()
                        MsgErro("Erro ao salvar arquivo:" + CHR(13) + THIS.this_cMensagemErro, "ProdutoBO.SalvarArquivosDesigner")
                        EXIT
                    ENDIF
                ENDIF
                SKIP IN cursor_4c_SigPrArq
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProdutoBO.SalvarArquivosDesigner")
        ENDTRY
    ENDPROC

ENDDEFINE

