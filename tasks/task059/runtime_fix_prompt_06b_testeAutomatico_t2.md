# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': BtnCancelarClick nao retornou para Page1 (ActivePage=2) | Detalhes: BtnIncluirClick navegou para Page2

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/17/26 03:58:23 PM] Erro ao Carregar Moedas: Connection handle is invalid.
[05/17/26 03:58:23 PM] Erro ao Carregar Moedas: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-17 15:56:08] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-17 15:56:08] [INFO] Config FPW: (nao fornecido)
[2026-05-17 15:56:08] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 15:56:08] [INFO] Timeout: 300 segundos
[2026-05-17 15:56:08] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1eewb3qi.prg
[2026-05-17 15:56:08] [INFO] Conteudo do wrapper:
[2026-05-17 15:56:08] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrecog', 'C:\4c\tasks\task059', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecog', 'C:\4c\tasks\task059', 'REPORT'
QUIT

[2026-05-17 15:56:08] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1eewb3qi.prg
[2026-05-17 15:56:08] [INFO] VFP output esperado em: C:\4c\tasks\task059\vfp_output.txt
[2026-05-17 15:56:08] [INFO] Executando Visual FoxPro 9...
[2026-05-17 15:56:08] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1eewb3qi.prg
[2026-05-17 15:56:08] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1eewb3qi.prg
[2026-05-17 15:56:08] [INFO] Timeout configurado: 300 segundos
[2026-05-17 15:56:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-17 15:56:11] [INFO] VFP9 finalizado em 2.825101 segundos
[2026-05-17 15:56:11] [INFO] Exit Code: 
[2026-05-17 15:56:11] [INFO] 
[2026-05-17 15:56:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-17 15:56:11] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1eewb3qi.prg
[2026-05-17 15:56:11] [INFO] 
[2026-05-17 15:56:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-17 15:56:11] [INFO] * Auto-generated wrapper for parameters
[2026-05-17 15:56:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 15:56:11] [INFO] * Parameters: 'Formsigrecog', 'C:\4c\tasks\task059', 'REPORT'
[2026-05-17 15:56:11] [INFO] 
[2026-05-17 15:56:11] [INFO] * Anti-dialog protections for unattended execution
[2026-05-17 15:56:11] [INFO] SET SAFETY OFF
[2026-05-17 15:56:11] [INFO] SET RESOURCE OFF
[2026-05-17 15:56:11] [INFO] SET TALK OFF
[2026-05-17 15:56:11] [INFO] SET NOTIFY OFF
[2026-05-17 15:56:11] [INFO] SYS(2335, 0)
[2026-05-17 15:56:11] [INFO] 
[2026-05-17 15:56:11] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecog', 'C:\4c\tasks\task059', 'REPORT'
[2026-05-17 15:56:11] [INFO] QUIT
[2026-05-17 15:56:11] [INFO] 
[2026-05-17 15:56:11] [INFO] === Fim do Wrapper.prg ===
[2026-05-17 15:56:11] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-05-17 15:58:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-17 15:58:19] [INFO] Config FPW: (nao fornecido)
[2026-05-17 15:58:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 15:58:19] [INFO] Timeout: 300 segundos
[2026-05-17 15:58:19] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_q3ncl03r.prg
[2026-05-17 15:58:19] [INFO] Conteudo do wrapper:
[2026-05-17 15:58:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrecog', 'C:\4c\tasks\task059', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecog', 'C:\4c\tasks\task059', 'REPORT'
QUIT

[2026-05-17 15:58:19] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_q3ncl03r.prg
[2026-05-17 15:58:19] [INFO] VFP output esperado em: C:\4c\tasks\task059\vfp_output.txt
[2026-05-17 15:58:19] [INFO] Executando Visual FoxPro 9...
[2026-05-17 15:58:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_q3ncl03r.prg
[2026-05-17 15:58:19] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_q3ncl03r.prg
[2026-05-17 15:58:19] [INFO] Timeout configurado: 300 segundos
[2026-05-17 15:58:23] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-17 15:58:23] [INFO] VFP9 finalizado em 3.8226078 segundos
[2026-05-17 15:58:23] [INFO] Exit Code: 
[2026-05-17 15:58:23] [INFO] 
[2026-05-17 15:58:23] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-17 15:58:23] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_q3ncl03r.prg
[2026-05-17 15:58:23] [INFO] 
[2026-05-17 15:58:23] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-17 15:58:23] [INFO] * Auto-generated wrapper for parameters
[2026-05-17 15:58:23] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 15:58:23] [INFO] * Parameters: 'Formsigrecog', 'C:\4c\tasks\task059', 'REPORT'
[2026-05-17 15:58:23] [INFO] 
[2026-05-17 15:58:23] [INFO] * Anti-dialog protections for unattended execution
[2026-05-17 15:58:23] [INFO] SET SAFETY OFF
[2026-05-17 15:58:23] [INFO] SET RESOURCE OFF
[2026-05-17 15:58:23] [INFO] SET TALK OFF
[2026-05-17 15:58:23] [INFO] SET NOTIFY OFF
[2026-05-17 15:58:23] [INFO] SYS(2335, 0)
[2026-05-17 15:58:23] [INFO] 
[2026-05-17 15:58:23] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecog', 'C:\4c\tasks\task059', 'REPORT'
[2026-05-17 15:58:23] [INFO] QUIT
[2026-05-17 15:58:23] [INFO] 
[2026-05-17 15:58:23] [INFO] === Fim do Wrapper.prg ===
[2026-05-17 15:58:23] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrecog",
  "timestamp": "20260517155823",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "FormParaRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo FormParaRelatorio encontrado"
    },
    {
      "nome": "BotoesRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Visualizar=SIM Imprimir=SIM"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": false,
      "erro": "BtnCancelarClick nao retornou para Page1 (ActivePage=2)",
      "detalhes": "BtnIncluirClick navegou para Page2"
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecog.prg):
*==============================================================================
* FORMSIGRECOG.PRG
* Relatorio de Comissao por Grupo de Produto
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECOG.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo   (data inicial / data final)
*   - Empresa   (codigo + razao social - SigCdEmp.Cemps / Razas)
*   - Vendedor  (codigo + nome - SigCdCli)
*   - Moeda     (codigo + descricao - SigCdMoe.Cmoes / Dmoes)
*
* Acoes: Visualizar (preview) / Imprimir (com dialogo) / Documento (direto)
*==============================================================================

DEFINE CLASS Formsigrecog AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption e Picture (fundo claro do framework)
    *   2. Instancia sigrecogBO (BO ja inicializa filtros default em Init())
    *   3. Monta cabecalho escuro com titulo
    *   4. Cria CommandGroup cmg_4c_Botoes (4 botoes: Visualiza/Imprime/Doc/Sair)
    *   5. Cria PageFrame com 1 pagina (Filtros) - controles internos sao
    *      adicionados nas fases seguintes da migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                           "o por Grupo de Produto"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instancia BO do relatorio (Init() do BO ja seta filtros default)
            THIS.this_oRelatorio = CREATEOBJECT("sigrecogBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecogBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.this_oRelatorio.CarregarMoedas()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaFiltros()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.LimparCampos()
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   BackColor=RGB(100,100,100) cinza medio do framework (NAO quase preto).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                             "o por Grupo de Produto"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                             "o por Grupo de Produto"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup btnReport (framework.vcx frmrelatorio)
    *   Original: btnReport CommandGroup com ButtonCount=4
    *   Geometria: Top=0, Left=529, Width=273, Height=80 (cabe em form 800px)
    *   Botoes: Visualiza(5), Imprime(71), Documento(137), Sair(203) - W=65 H=70
    *   PicturePosition=13 (icon-acima do texto). Bindings dos Click sao
    *   adicionados em fase posterior (eventos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Documento"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar Documento do Relat" + CHR(243) + "rio"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina de filtros
    *   Posicionado abaixo do cabecalho (85px). O form legado era FLAT,
    *   mas no novo padrao os filtros sao agrupados em uma Page com fundo
    *   claro do framework (fundo_cad_1003.jpg). Controles de filtro sao
    *   adicionados em ConfigurarPaginaLista() nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Page2.Caption   = "Resultado"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa referencia ao BO (Custom NAO tem .Release(), usar .NULL.)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos campos de filtro (Page1)
    *   Adiciona: Periodo (dt_inicial + dt_final) e Empresa (codigo + descricao)
    *   Compensacao de Top: original - 85 (PageFrame.Top = 85)
    *   BINDEVENTs dos campos desta metade tambem sao registrados aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oPag.lbl_4c_Lbl_periodo
            .Top       = 133
            .Left      = 206
            .Width     = 45
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH loc_oPag.txt_4c__dt_inicial
            .Top      = 44
            .Left     = 255
            .Width    = 80
            .Height   = 25
            .Value    = {}
            .FontName = "Courier New"
            .FontSize = 9
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oPag.lbl_4c_Lbl_periodo_a
            .Top       = 136
            .Left      = 338
            .Width     = 8
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__dt_final", "TextBox")
        WITH loc_oPag.txt_4c__dt_final
            .Top      = 44
            .Left     = 349
            .Width    = 80
            .Height   = 25
            .Value    = {}
            .FontName = "Courier New"
            .FontSize = 9
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oPag.lbl_4c_Lbl_empresa
            .Top       = 160
            .Left      = 201
            .Width     = 50
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__empresa", "TextBox")
        WITH loc_oPag.txt_4c__empresa
            .Top       = 71
            .Left      = 255
            .Width     = 31
            .Height    = 25
            .Value     = ""
            .MaxLength = 3
            .Format    = "K"
            .FontName  = "Courier New"
            .FontSize  = 9
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__empresa_desc", "TextBox")
        WITH loc_oPag.txt_4c__empresa_desc
            .Top       = 71
            .Left      = 288
            .Width     = 290
            .Height    = 25
            .Value     = ""
            .MaxLength = 40
            .Format    = "!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPag.txt_4c__dt_inicial,   "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPag.txt_4c__dt_final,     "KeyPress", THIS, "TeclaDataFinal")
        BINDEVENT(loc_oPag.txt_4c__empresa,      "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPag.txt_4c__empresa_desc, "KeyPress", THIS, "TeclaEmpresaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Segunda metade dos campos de filtro (Page1)
    *   Adiciona: Vendedor (codigo + descricao) e Moeda (codigo + descricao)
    *   Pre-requisito: ConfigurarPaginaDados() ja foi chamado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.AddObject("lbl_4c_Lbl_vendedor", "Label")
        WITH loc_oPag.lbl_4c_Lbl_vendedor
            .Top       = 187
            .Left      = 196
            .Width     = 55
            .AutoSize  = .T.
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__vendedor", "TextBox")
        WITH loc_oPag.txt_4c__vendedor
            .Top       = 98
            .Left      = 255
            .Width     = 80
            .Height    = 25
            .Value     = ""
            .MaxLength = 10
            .Format    = "!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__vendedor_desc", "TextBox")
        WITH loc_oPag.txt_4c__vendedor_desc
            .Top       = 98
            .Left      = 337
            .Width     = 290
            .Height    = 25
            .Value     = ""
            .MaxLength = 40
            .Format    = "!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .Top       = 214
            .Left      = 210
            .Width     = 41
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Cmoeda", "TextBox")
        WITH loc_oPag.txt_4c_Cmoeda
            .Top       = 125
            .Left      = 255
            .Width     = 31
            .Height    = 25
            .Value     = ""
            .MaxLength = 3
            .Format    = "K!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Dmoeda", "TextBox")
        WITH loc_oPag.txt_4c_Dmoeda
            .Top       = 125
            .Left      = 288
            .Width     = 115
            .Height    = 25
            .Value     = ""
            .MaxLength = 15
            .Format    = "K!"
            .FontName  = "Courier New"
            .FontSize  = 9
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPag.txt_4c__vendedor,      "KeyPress", THIS, "TeclaVendedor")
        BINDEVENT(loc_oPag.txt_4c__vendedor_desc, "KeyPress", THIS, "TeclaVendedorDesc")
        BINDEVENT(loc_oPag.txt_4c_Cmoeda,         "KeyPress", THIS, "TeclaMoeda")
        BINDEVENT(loc_oPag.txt_4c_Dmoeda,         "KeyPress", THIS, "TeclaMoedaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para pagina indicada do PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos campos de filtro para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial    = loc_oPag.txt_4c__dt_inicial.Value
            .this_dDtFinal      = loc_oPag.txt_4c__dt_final.Value
            .this_cEmpresa      = ALLTRIM(loc_oPag.txt_4c__empresa.Value)
            .this_cRazaEmpresa  = ALLTRIM(loc_oPag.txt_4c__empresa_desc.Value)
            .this_cVendedor     = ALLTRIM(loc_oPag.txt_4c__vendedor.Value)
            .this_cNomeVendedor = ALLTRIM(loc_oPag.txt_4c__vendedor_desc.Value)
            .this_cCmoeda       = ALLTRIM(loc_oPag.txt_4c_Cmoeda.Value)
            .this_cDmoeda       = ALLTRIM(loc_oPag.txt_4c_Dmoeda.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias canonico de FormParaRelatorio (CRUD-style contract)
    *   Copia TODOS os campos de filtro do form para o BO de relatorio.
    *   Form REPORT nao tem CRUD; mantido para uniformidade com forms CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial    = loc_oPag.txt_4c__dt_inicial.Value
            .this_dDtFinal      = loc_oPag.txt_4c__dt_final.Value
            .this_cEmpresa      = ALLTRIM(loc_oPag.txt_4c__empresa.Value)
            .this_cRazaEmpresa  = ALLTRIM(loc_oPag.txt_4c__empresa_desc.Value)
            .this_cVendedor     = ALLTRIM(loc_oPag.txt_4c__vendedor.Value)
            .this_cNomeVendedor = ALLTRIM(loc_oPag.txt_4c__vendedor_desc.Value)
            .this_cCmoeda       = ALLTRIM(loc_oPag.txt_4c_Cmoeda.Value)
            .this_cDmoeda       = ALLTRIM(loc_oPag.txt_4c_Dmoeda.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c__dt_inicial.Value    = DATE()
        loc_oPag.txt_4c__dt_final.Value      = DATE()
        loc_oPag.txt_4c__empresa.Value       = ""
        loc_oPag.txt_4c__empresa_desc.Value  = ""
        loc_oPag.txt_4c__vendedor.Value      = ""
        loc_oPag.txt_4c__vendedor_desc.Value = ""
        loc_oPag.txt_4c_Cmoeda.Value         = ""
        loc_oPag.txt_4c_Dmoeda.Value         = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera preview em video
    * Handler BINDEVENT: cmg_4c_Botoes.Buttons(1).Click
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    * Handler BINDEVENT: cmg_4c_Botoes.Buttons(2).Click
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Gera exportacao do relatorio
    * Handler BINDEVENT: cmg_4c_Botoes.Buttons(3).Click
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.GerarExcel()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * Handler BINDEVENT: cmg_4c_Botoes.Buttons(4).Click (Cancel = .T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Form REPORT nao possui CRUD; acao equivalente eh gerar
    *   o relatorio em video (Visualizar). Mantido para compatibilidade com o
    *   contrato de eventos principais de formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(2)
        IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao Gerar Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Form REPORT nao possui CRUD; acao equivalente eh enviar
    *   o relatorio para a impressora. Mantido para compatibilidade com o
    *   contrato de eventos principais de formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Form REPORT nao possui CRUD; acao equivalente eh limpar
    *   os campos de filtro (reset para valores padrao). Mantido para
    *   compatibilidade com o contrato de eventos principais de formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja limpar os filtros do relat" + CHR(243) + "rio?", ;
                       "Limpar Filtros")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShift)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresa - F4=busca direta / ENTER ou TAB=valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresaDesc - F4=busca por nome / ENTER ou TAB=valida descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedor - F4=busca direta / ENTER ou TAB=valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedor(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVendedor()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedorDesc - F4=busca por nome / ENTER ou TAB=valida nome
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedorDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVendedor()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarVendedorDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoeda - F4=busca direta / ENTER ou TAB=valida codigo de moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoedaDesc - F4=busca por descricao / ENTER ou TAB=valida desc moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoedaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Busca empresa por codigo em SigCdEmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpresa()
        LOCAL loc_cCod, loc_cSQL, loc_nResult, loc_oPag, loc_oErro, loc_lEncontrado
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c__empresa.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c__empresa_desc.Value = ""
            RETURN
        ENDIF
        loc_lEncontrado = .F.
        TRY
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp " + ;
                       "WHERE cemps = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpVal
                IF !EOF()
                    loc_oPag.txt_4c__empresa_desc.Value = ALLTRIM(razas)
                    loc_lEncontrado = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
            IF !loc_lEncontrado
                MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
                loc_oPag.txt_4c__empresa.Value      = ""
                loc_oPag.txt_4c__empresa_desc.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Empresa")
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaDesc - Desc preenchida sem codigo: abre busca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpresaDesc()
        LOCAL loc_cDesc, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c__empresa_desc.Value)
        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c__empresa.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - FormBuscaAuxiliar para SigCdEmp (cemps / razas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oForm, loc_oPag, loc_cValor, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__empresa.Value)
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", loc_cValor, ;
                "Busca de Empresa")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("razas", "", "Empresa")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_oPag.txt_4c__empresa.Value      = ALLTRIM(cemps)
                    loc_oPag.txt_4c__empresa_desc.Value = ALLTRIM(razas)
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Empresa")
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedor - Busca vendedor por codigo em SigCdCli
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarVendedor()
        LOCAL loc_cCod, loc_cSQL, loc_nResult, loc_oPag, loc_oErro, loc_lEncontrado
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c__vendedor.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c__vendedor_desc.Value = ""
            RETURN
        ENDIF
        loc_lEncontrado = .F.
        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli " + ;
                       "WHERE iclis = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenVal")
            IF loc_nResult > 0
                SELECT cursor_4c_VenVal
                IF !EOF()
                    loc_oPag.txt_4c__vendedor_desc.Value = ALLTRIM(rclis)
                    loc_lEncontrado = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_VenVal")
                USE IN cursor_4c_VenVal
            ENDIF
            IF !loc_lEncontrado
                MsgAviso("Vendedor n" + CHR(227) + "o encontrado.", "Vendedor")
                loc_oPag.txt_4c__vendedor.Value      = ""
                loc_oPag.txt_4c__vendedor_desc.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Vendedor")
            IF USED("cursor_4c_VenVal")
                USE IN cursor_4c_VenVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedorDesc - Nome preenchido sem codigo: abre busca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarVendedorDesc()
        LOCAL loc_cDesc, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c__vendedor_desc.Value)
        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c__vendedor.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaVendedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVendedor - FormBuscaAuxiliar para SigCdCli (iclis / rclis)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaVendedor()
        LOCAL loc_oForm, loc_oPag, loc_cValor, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__vendedor.Value)
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaVen", "iclis", loc_cValor, ;
                "Busca de Vendedor")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("rclis", "", "Vendedor")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaVen")
                    SELECT cursor_4c_BuscaVen
                    loc_oPag.txt_4c__vendedor.Value      = ALLTRIM(iclis)
                    loc_oPag.txt_4c__vendedor_desc.Value = ALLTRIM(rclis)
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_BuscaVen")
                USE IN cursor_4c_BuscaVen
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Vendedor")
            IF USED("cursor_4c_BuscaVen")
                USE IN cursor_4c_BuscaVen
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeda - Valida codigo moeda via cursor_4c_Moedas (pre-carregado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMoeda()
        LOCAL loc_cCod, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c_Cmoeda.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c_Dmoeda.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_Moedas")
            SELECT cursor_4c_Moedas
            LOCATE FOR ALLTRIM(cmoes) = loc_cCod
            IF FOUND()
                loc_oPag.txt_4c_Cmoeda.Value = ALLTRIM(cmoes)
                loc_oPag.txt_4c_Dmoeda.Value = ALLTRIM(dmoes)
            ELSE
                THIS.AbrirBuscaMoeda()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoedaDesc - Valida descricao moeda via cursor_4c_Moedas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMoedaDesc()
        LOCAL loc_cDesc, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c_Dmoeda.Value)
        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c_Cmoeda.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_Moedas")
            SELECT cursor_4c_Moedas
            LOCATE FOR ALLTRIM(dmoes) = loc_cDesc
            IF FOUND()
                loc_oPag.txt_4c_Cmoeda.Value = ALLTRIM(cmoes)
                loc_oPag.txt_4c_Dmoeda.Value = ALLTRIM(dmoes)
            ELSE
                THIS.AbrirBuscaMoeda()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - FormBuscaAuxiliar para SigCdMoe (cmoes / dmoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oForm, loc_oPag, loc_cValor, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Cmoeda.Value)
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cValor, ;
                "Busca de Moeda")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_oPag.txt_4c_Cmoeda.Value = ALLTRIM(cmoes)
                    loc_oPag.txt_4c_Dmoeda.Value = ALLTRIM(dmoes)
                ENDIF
                loc_oForm.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Moeda")
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Acao "Buscar" no relatorio: equivale a Visualizar
    *   Form de relatorio nao tem grade de lista; "buscar" = gerar preview.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Acao "Salvar" no relatorio: equivale a Imprimir
    *   Form de relatorio nao persiste dados; "salvar" = enviar para impressora.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa os filtros e recarrega moedas
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.this_oRelatorio.CarregarMoedas()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia propriedades do BO para os campos de filtro do form
    *   Inverso de FormParaRelatorio(). Util quando o BO ja tem valores
    *   pre-configurados (ex: empresa logada, data de hoje).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            loc_oPag.txt_4c__dt_inicial.Value    = IIF(EMPTY(.this_dDtInicial),    DATE(), .this_dDtInicial)
            loc_oPag.txt_4c__dt_final.Value      = IIF(EMPTY(.this_dDtFinal),      DATE(), .this_dDtFinal)
            loc_oPag.txt_4c__empresa.Value       = ALLTRIM(.this_cEmpresa)
            loc_oPag.txt_4c__empresa_desc.Value  = ALLTRIM(.this_cRazaEmpresa)
            loc_oPag.txt_4c__vendedor.Value      = ALLTRIM(.this_cVendedor)
            loc_oPag.txt_4c__vendedor_desc.Value = ALLTRIM(.this_cNomeVendedor)
            loc_oPag.txt_4c_Cmoeda.Value         = ALLTRIM(.this_cCmoeda)
            loc_oPag.txt_4c_Dmoeda.Value         = ALLTRIM(.this_cDmoeda)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de filtro
    *   par_lHabilitar = .T. habilita todos, .F. desabilita todos.
    *   Form de relatorio normalmente mant?m todos habilitados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c__dt_inicial.ReadOnly    = !par_lHabilitar
        loc_oPag.txt_4c__dt_final.ReadOnly      = !par_lHabilitar
        loc_oPag.txt_4c__empresa.ReadOnly       = !par_lHabilitar
        loc_oPag.txt_4c__empresa_desc.ReadOnly  = !par_lHabilitar
        loc_oPag.txt_4c__vendedor.ReadOnly      = !par_lHabilitar
        loc_oPag.txt_4c__vendedor_desc.ReadOnly = !par_lHabilitar
        loc_oPag.txt_4c_Cmoeda.ReadOnly         = !par_lHabilitar
        loc_oPag.txt_4c_Dmoeda.ReadOnly         = !par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega cursor de moedas para uso nos lookups
    *   Form de relatorio nao tem grade de lista; "carregar lista" = recarregar
    *   dados de referencia (moedas) que alimentam o campo de filtro Moeda.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_lSucesso = THIS.this_oRelatorio.CarregarMoedas()
            IF !loc_lSucesso
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                         "Erro ao Carregar Moedas")
            ENDIF
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Garante que todos os 4 botoes do CommandGroup
    *   estejam habilitados. Form de relatorio nao tem modos CRUD; os botoes
    *   Visualizar/Imprimir/Documento/Encerrar ficam sempre ativos.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecogBO.prg):
*==============================================================================
* SIGRECOGBO.PRG
* Business Object - Relatorio de Comissao por Grupo de Produto
*
* Herda de RelatorioBase
* Formulario original: SIGRECOG.SCX (frmrelatorio)
* Tabelas principais: SigMvCab, SigMvItn, SigCdOpe, SigCdEmp, SigCdCli, SigCmGri, SigCdPro
*==============================================================================

DEFINE CLASS sigrecogBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial      = {}
    this_dDtFinal        = {}

    *-- Filtro de empresa
    this_cEmpresa        = ""
    this_cRazaEmpresa    = ""

    *-- Filtro de vendedor
    this_cVendedor       = ""
    this_cNomeVendedor   = ""

    *-- Filtro de moeda (codigo e descricao)
    this_cCmoeda         = ""
    this_cDmoeda         = ""

    *-- Metadados do relatorio
    this_cCaminhoFRX     = ""
    this_cTitulo         = ""
    this_cCursorDados    = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - Configura o BO com caminho FRX, titulo e valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        LOCAL loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela      = "SigMvCab"
            THIS.this_cCampoChave  = "empdopnums"
            THIS.this_cCaminhoFRX  = gc_4c_CaminhoReports + "SigReCog.frx"
            THIS.this_cTitulo      = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o por Grupo de Produto"

            THIS.this_dDtInicial    = DATE()
            THIS.this_dDtFinal      = DATE()
            THIS.this_cEmpresa      = ""
            THIS.this_cRazaEmpresa  = ""
            THIS.this_cVendedor     = ""
            THIS.this_cNomeVendedor = ""
            THIS.this_cCmoeda       = ""
            THIS.this_cDmoeda       = ""

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria para a execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_cEmpresa), "TODAS", ALLTRIM(THIS.this_cEmpresa))
        loc_cChave = loc_cChave + "/" + DTOC(THIS.this_dDtInicial) + ;
                     "/" + DTOC(THIS.this_dDtFinal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, " + ;
                       "Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("SigReCog") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            *-- Auditoria nunca bloqueia operacao principal
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGRECOG.SCX original
    * Gera cursores: cabecalho, sumitens (intermediario), cursor_4c_MvItn, tempo
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_cEmpresa, loc_cVendedor, loc_cCmoeda
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cWEmpresa, loc_cWVendedor
        LOCAL loc_cCgrus, loc_nComiss, loc_cDopes, loc_cVends
        LOCAL loc_dDatasItn, loc_cEmps, loc_cRazas, loc_cNVens
        LOCAL loc_nTotas, loc_nValos, loc_cMoedas, loc_cEmpDopNums
        LOCAL loc_nTotItes, loc_nFator, loc_nTots, loc_nCot1, loc_nCot2
        LOCAL loc_cChaveGrupo

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.

                loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
                loc_cVendedor = ALLTRIM(THIS.this_cVendedor)
                loc_cCmoeda   = PADR(ALLTRIM(THIS.this_cCmoeda), 3)

                *-- 1. Busca nome da empresa no cabecalho
                loc_cNomeEmpresa = ""
                IF !EMPTY(loc_cEmpresa)
                    loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                               "WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crCogEmp") > 0 AND ;
                       !EOF("crCogEmp")
                        SELECT crCogEmp
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    IF USED("crCogEmp")
                        USE IN crCogEmp
                    ENDIF
                ENDIF

                loc_cTitulo  = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                               "o de Vendedor por Grupo de Produto"
                loc_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                               DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                               DTOC(THIS.this_dDtFinal)

                *-- 2. Cria cursor de cabecalho do relatorio
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                CREATE CURSOR cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), pPeriodo C(80))
                INSERT INTO cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo)

                *-- 3. Executa query sumitens: soma totas por empdopnums no periodo
                IF USED("sumitens")
                    USE IN sumitens
                ENDIF
                loc_cSQL = "SELECT a.empdopnums, a.datas, " + ;
                           "SUM(b.totas) AS totites " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigMvItn b ON b.empdopnums = a.empdopnums " + ;
                           "WHERE a.datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                           " AND a.datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                           " GROUP BY a.empdopnums, a.datas " + ;
                           " ORDER BY a.empdopnums, a.datas"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "sumitens")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (sumitens)"
                    EXIT
                ENDIF
                SELECT sumitens
                INDEX ON empdopnums TAG empdopnums

                *-- 4. Executa query principal: join com comissoes por grupo de produto
                loc_cWEmpresa  = IIF(EMPTY(loc_cEmpresa), "", " AND a.emps = " + EscaparSQL(loc_cEmpresa))
                loc_cWVendedor = IIF(EMPTY(loc_cVendedor), "", " AND a.vends = " + EscaparSQL(loc_cVendedor))

                IF USED("cursor_4c_MvItn")
                    USE IN cursor_4c_MvItn
                ENDIF

                loc_cSQL = "SELECT d.empdopnums AS empdopnums, " + ;
                           "d.totas AS totas, " + ;
                           "d.moedas AS moedas, " + ;
                           "a.dopes AS dopes, " + ;
                           "a.vends AS vends, " + ;
                           "a.datas AS datas, " + ;
                           "a.emps AS emps, " + ;
                           "a.valos AS valos, " + ;
                           "g.cgrus AS cgrus, " + ;
                           "g.comiss AS comiss, " + ;
                           "e.razas AS razas, " + ;
                           "f.rclis AS nvens " + ;
                           "FROM SigMvItn d " + ;
                           "INNER JOIN SigMvCab a ON d.empdopnums = a.empdopnums " + ;
                           "INNER JOIN SigCdOpe b ON a.dopes = b.dopes " + ;
                           "INNER JOIN SigCdEmp e ON e.cemps = a.emps " + ;
                           "INNER JOIN SigCdCli f ON f.iclis = a.vends " + ;
                           "INNER JOIN SigCdPro h ON d.cpros = h.cpros " + ;
                           "INNER JOIN SigCmGri g ON g.cgrus = h.cgrus " + ;
                           "WHERE a.datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                           " AND a.datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                           " AND b.results = 1 " + ;
                           " AND b.ccomis = 1 " + ;
                           loc_cWEmpresa + ;
                           loc_cWVendedor
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvItn")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_MvItn)"
                    EXIT
                ENDIF

                *-- 5. Cria cursor Tempo: agrupa por cgrus/comiss/dopes/vends/datas/emps
                *--    aplicando conversao de moeda via BuscarCotacao
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                CREATE CURSOR tempo (Cgrus C(3), Comiss N(8,2), Dopes C(20), ;
                                     Vends C(10), Datas D, Emps C(3), ;
                                     Razas C(40), NVens C(50), Tots N(11,2))
                INDEX ON PADR(Cgrus,3) + STR(Comiss,8,2) + PADR(Dopes,20) + ;
                         PADR(Vends,10) + DTOS(Datas) + PADR(Emps,3) TAG grpchave

                SELECT cursor_4c_MvItn
                GO TOP
                SCAN
                    loc_cCgrus      = ALLTRIM(cursor_4c_MvItn.Cgrus)
                    loc_nComiss     = NVL(cursor_4c_MvItn.Comiss, 0)
                    loc_cDopes      = ALLTRIM(cursor_4c_MvItn.Dopes)
                    loc_cVends      = ALLTRIM(cursor_4c_MvItn.Vends)
                    loc_dDatasItn   = CTOD(DTOC(cursor_4c_MvItn.Datas))
                    loc_cEmps       = ALLTRIM(cursor_4c_MvItn.Emps)
                    loc_cRazas      = ALLTRIM(cursor_4c_MvItn.Razas)
                    loc_cNVens      = ALLTRIM(cursor_4c_MvItn.NVens)
                    loc_nTotas      = NVL(cursor_4c_MvItn.Totas, 0)
                    loc_nValos      = NVL(cursor_4c_MvItn.Valos, 0)
                    loc_cMoedas     = PADR(ALLTRIM(NVL(cursor_4c_MvItn.Moedas, "")), 3)
                    loc_cEmpDopNums = ALLTRIM(cursor_4c_MvItn.EmpDopNums)

                    *-- Busca total de itens do documento em sumitens
                    loc_nTotItes = 0
                    SELECT sumitens
                    IF SEEK(PADR(loc_cEmpDopNums, 29), "sumitens", "empdopnums")
                        loc_nTotItes = NVL(sumitens.totites, 0)
                    ENDIF
                    SELECT cursor_4c_MvItn

                    *-- Calcula fator de conversao de moeda
                    IF EMPTY(ALLTRIM(loc_cMoedas)) OR loc_cMoedas = loc_cCmoeda
                        loc_nFator = 1
                    ELSE
                        loc_nCot1  = THIS.BuscarCotacao(ALLTRIM(loc_cMoedas), loc_dDatasItn)
                        loc_nCot2  = IIF(EMPTY(ALLTRIM(loc_cCmoeda)), 1, ;
                                         THIS.BuscarCotacao(ALLTRIM(loc_cCmoeda), loc_dDatasItn))
                        loc_nFator = IIF(loc_nCot2 > 0, loc_nCot1 / loc_nCot2, loc_nCot1)
                    ENDIF

                    *-- Calcula valor de comissao proporcional do item
                    loc_nTots = ROUND(IIF(loc_nTotItes > 0, ;
                                         loc_nTotas / loc_nTotItes, 0) * ;
                                      loc_nValos * loc_nFator, 2)

                    *-- Chave de grupo para SEEK no cursor Tempo
                    loc_cChaveGrupo = PADR(loc_cCgrus, 3) + STR(loc_nComiss, 8, 2) + ;
                                      PADR(loc_cDopes, 20) + PADR(loc_cVends, 10) + ;
                                      DTOS(loc_dDatasItn) + PADR(loc_cEmps, 3)

                    SELECT tempo
                    IF SEEK(loc_cChaveGrupo, "tempo", "grpchave")
                        REPLACE Tots WITH tempo.Tots + loc_nTots IN tempo
                    ELSE
                        INSERT INTO tempo (Cgrus, Comiss, Dopes, Vends, Datas, ;
                                           Emps, Razas, NVens, Tots) ;
                            VALUES (loc_cCgrus, loc_nComiss, loc_cDopes, loc_cVends, ;
                                    loc_dDatasItn, loc_cEmps, ;
                                    loc_cRazas, loc_cNVens, loc_nTots)
                    ENDIF

                    SELECT cursor_4c_MvItn
                ENDSCAN

                *-- Ordena Tempo para o relatorio (Emps, Vends, Cgrus)
                SELECT tempo
                INDEX ON PADR(Emps,3) + PADR(Vends,10) + PADR(Cgrus,3) TAG relchave
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Preparar Dados do Relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Comissao por Grupo de
    * Produto nao ha parametros persistidos: as datas iniciam em DATE() e os
    * demais filtros ficam vazios para selecao via lookup. Mantido por
    * contrato (validador da pipeline e RelatorioBase).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Comissao por Grupo de Produto eh apenas leitura: consulta SigMvCab,
    * SigMvItn, SigCmGri e gera preview/impressao via REPORT FORM. Retorna
    * .F. para satisfazer o contrato de BO e sinalizar que a operacao nao
    * se aplica a este BO.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Comiss" + CHR(227) + "o por Grupo de Produto (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Ver observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Comiss" + CHR(227) + "o por Grupo de Produto (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores criados por PrepararDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED("cabecalho")
            USE IN cabecalho
        ENDIF
        IF USED("sumitens")
            USE IN sumitens
        ENDIF
        IF USED("tempo")
            USE IN tempo
        ENDIF
        IF USED("cursor_4c_MvItn")
            USE IN cursor_4c_MvItn
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (exporta para impressora)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMoedas - Carrega SigCdMoe em cursor para uso nos lookups do form
    * Retorna .T. se sucesso, cursor disponivel como "cursor_4c_Moedas"
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMoedas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Moedas")
                USE IN cursor_4c_Moedas
            ENDIF
            loc_cSQL = "SELECT cmoes, dmoes, cotas, datatrans, fmults, " + ;
                       "nordrels, disfpres, valadics, grumoes, moeqs, " + ;
                       "qtdeqs, submoes " + ;
                       "FROM SigCdMoe " + ;
                       "ORDER BY cmoes, dmoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moedas")
            IF loc_nResult > 0
                SELECT cursor_4c_Moedas
                INDEX ON cmoes TAG cmoes
                INDEX ON dmoes TAG dmoes
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar moedas"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Carregar Moedas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca taxa de cambio da moeda para a data informada
    * Substitui fBuscarCotacao() do sistema legado
    * Tabela: SigCdCot (cmoes, datas, horas, valos)
    * Retorna 1.0 se moeda nao encontrada (fallback seguro)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda, loc_cFiltroData

        loc_nTaxa  = 1.0
        loc_cMoeda = ALLTRIM(par_cMoeda)

        IF EMPTY(loc_cMoeda) OR loc_cMoeda = "R"
            RETURN loc_nTaxa
        ENDIF

        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            loc_cFiltroData = "datas <= GETDATE()"
        ELSE
            loc_cFiltroData = "datas <= DATEADD(day, 1, " + FormatarDataSQL(par_dData) + ")"
        ENDIF

        loc_cSQL = "SELECT cmoes, valos FROM SigCdCot " + ;
                   "WHERE " + loc_cFiltroData + ;
                   " ORDER BY cmoes, datas DESC, horas DESC"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CogCot")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CogCot")
            SELECT cursor_4c_CogCot
            LOCATE FOR ALLTRIM(cmoes) = loc_cMoeda
            IF FOUND() AND NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CogCot")
            USE IN cursor_4c_CogCot
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

