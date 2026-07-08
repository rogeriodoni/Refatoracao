# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/15/26 11:12:52 AM] Atenção: Informe o código da operação.
[05/15/26 11:12:52 AM] Erro Detalhado: RETURN/RETRY statement not allowed in TRY/CATCH.Linha: 658Procedure: btnvisualizarclick


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-15 11:12:50] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-15 11:12:50] [INFO] Config FPW: (nao fornecido)
[2026-05-15 11:12:50] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-15 11:12:50] [INFO] Timeout: 300 segundos
[2026-05-15 11:12:50] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_htch0pvp.prg
[2026-05-15 11:12:50] [INFO] Conteudo do wrapper:
[2026-05-15 11:12:50] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrevto', 'C:\4c\tasks\task024', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrevto', 'C:\4c\tasks\task024', 'REPORT'
QUIT

[2026-05-15 11:12:50] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_htch0pvp.prg
[2026-05-15 11:12:50] [INFO] VFP output esperado em: C:\4c\tasks\task024\vfp_output.txt
[2026-05-15 11:12:50] [INFO] Executando Visual FoxPro 9...
[2026-05-15 11:12:50] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_htch0pvp.prg
[2026-05-15 11:12:50] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_htch0pvp.prg
[2026-05-15 11:12:50] [INFO] Timeout configurado: 300 segundos
[2026-05-15 11:12:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-15 11:12:52] [INFO] VFP9 finalizado em 2.2167826 segundos
[2026-05-15 11:12:52] [INFO] Exit Code: 
[2026-05-15 11:12:52] [INFO] 
[2026-05-15 11:12:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-15 11:12:52] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_htch0pvp.prg
[2026-05-15 11:12:52] [INFO] 
[2026-05-15 11:12:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-15 11:12:52] [INFO] * Auto-generated wrapper for parameters
[2026-05-15 11:12:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-15 11:12:52] [INFO] * Parameters: 'Formsigrevto', 'C:\4c\tasks\task024', 'REPORT'
[2026-05-15 11:12:52] [INFO] 
[2026-05-15 11:12:52] [INFO] * Anti-dialog protections for unattended execution
[2026-05-15 11:12:52] [INFO] SET SAFETY OFF
[2026-05-15 11:12:52] [INFO] SET RESOURCE OFF
[2026-05-15 11:12:52] [INFO] SET TALK OFF
[2026-05-15 11:12:52] [INFO] SET NOTIFY OFF
[2026-05-15 11:12:52] [INFO] SYS(2335, 0)
[2026-05-15 11:12:52] [INFO] 
[2026-05-15 11:12:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrevto', 'C:\4c\tasks\task024', 'REPORT'
[2026-05-15 11:12:52] [INFO] QUIT
[2026-05-15 11:12:52] [INFO] 
[2026-05-15 11:12:52] [INFO] === Fim do Wrapper.prg ===
[2026-05-15 11:12:52] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrevto",
  "timestamp": "20260515111252",
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
      "erro": "BtnIncluirClick nao navegou para Page2 (ActivePage=1)",
      "detalhes": ""
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrevto.prg):
*==============================================================================
* FORMSIGREVTO.PRG
* Relatorio Total Por Operacao
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREVTO.SCX (frmrelatorio)
*
* Filtros:
*   - Operacao  (codigo - SigCdOpe.Dopes)
*   - Periodo   (data inicial / data final)
*   - Moeda     (codigo + descricao - SigCdMoe.CMoes / DMoes)
*   - Empresa   (codigo + descricao - SigCdEmp.Cemps / Razas, opcional)
*
* Acoes: Visualizar (preview) / Imprimir (com dialogo) / Documento (direto)
*==============================================================================

DEFINE CLASS Formsigrevto AS FormBase

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
    * InicializarForm - Cria estrutura completa do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrevtoBO e carrega filtros iniciais (pula em modo UI)
    *   3. Monta cabecalho escuro + botoes + PageFrame com campos de filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                           CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrevtoBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrevtoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar filtros padrao (moeda do sistema, datas = hoje).
            *   Pulado em modo de validacao de UI (sem conexao SQL).
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.InicializarFiltros()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Documento,  "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Sair,       "Click", THIS, "BtnSairClick")

                *-- Valores iniciais dos campos de filtro
                THIS.LimparCampos()

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
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
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                             CHR(231) + CHR(227) + "o"
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
                .Caption   = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                             CHR(231) + CHR(227) + "o"
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
    * ConfigurarBotoes - Container de botoes do relatorio (btnReport legado)
    *   Original: btnReport.Left=530, 4 botoes (Visualiza, Imprime, DocExcel, Sair)
    *   Acoes: Visualizar (preview) / Imprimir (prompt) / Documento (direto) / Sair
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 0
            .Left        = 542
            .Width       = 325
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Visualizar
            .Top             = 4
            .Left            = 4
            .Width           = 67
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 1
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Imprimir
            .Top             = 4
            .Left            = 79
            .Width           = 67
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 1
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Documento", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Documento
            .Top             = 4
            .Left            = 154
            .Width           = 67
            .Height          = 70
            .Caption         = "Documento"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 1
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Sair
            .Top             = 4
            .Left            = 229
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .PicturePosition = 1
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina de filtros
    *   Posicionado abaixo do cabecalho (85px). O form legado era FLAT,
    *   mas no novo padrao os filtros sao agrupados em um PageFrame.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1

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

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Filtros principais da Page1 (Operacao + Periodo)
    *   Posicoes convertidas de coordenadas do form legado (subtraindo 85px
    *   do offset do PageFrame): ex. get_dopes.Top=129 -> Page1.Top=44.
    *
    *   Controles: Operacao (get_dopes), Periodo (dt_inicial/dt_final).
    *   BINDEVENTs: KeyPress (F4=lookup, ENTER/TAB=validar) + DblClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Operacao :"
        loc_oPg.AddObject("lbl_4c_LblOperacao", "Label")
        WITH loc_oPg.lbl_4c_LblOperacao
            .Top       = 49
            .Left      = 208
            .Width     = 56
            .Height    = 15
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da operacao (get_dopes: MaxLength=20, Format="K!")
        loc_oPg.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPg.txt_4c_Dopes
            .Top           = 44
            .Left          = 267
            .Width         = 150
            .Height        = 23
            .Value         = ""
            .MaxLength     = 20
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .Alignment     = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Periodo :"
        loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg.lbl_4c_LblPeriodo
            .Top       = 74
            .Left      = 219
            .Width     = 45
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (get_dt_inicial: MaxLength=10, Format="K")
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top         = 69
            .Left        = 267
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Separador "a" entre datas (preposicao portuguesa: CHR(224) = a-grave = a com acento grave)
        loc_oPg.AddObject("lbl_4c_A", "Label")
        WITH loc_oPg.lbl_4c_A
            .Top       = 74
            .Left      = 350
            .Width     = 10
            .Height    = 15
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final (get_dt_final: MaxLength=10, Format="K")
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top         = 69
            .Left        = 361
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .Format      = "D"
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Handlers de teclado para filtros principais (Operacao + Datas)
        BINDEVENT(loc_oPg.txt_4c_Dopes,     "KeyPress", THIS, "TeclaOperacao")
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_Dopes,     "DblClick", THIS, "AbrirBuscaOperacao")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Filtros secundarios da Page1 (Moeda + Empresa)
    *   Controles de lookup com par codigo+descricao. Cada par tem When
    *   logic herdada do legado: descricao fica ReadOnly quando codigo
    *   esta preenchido (busca direta) e editavel quando codigo vazio
    *   (busca reversa por nome).
    *
    *   Controles: Moeda (cod+desc - SigCdMoe), Empresa (cod+desc - SigCdEmp).
    *   BINDEVENTs: KeyPress (F4=lookup, ENTER/TAB=validar) + DblClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Moeda :"
        loc_oPg.AddObject("lbl_4c_LblMoeda", "Label")
        WITH loc_oPg.lbl_4c_LblMoeda
            .Top       = 99
            .Left      = 223
            .Width     = 40
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da moeda (get_moeda: MaxLength=3, Format="!")
        loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg.txt_4c_Moeda
            .Top           = 94
            .Left          = 267
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .Alignment     = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Descricao da moeda (get_moeda_desc: MaxLength=15, Format="!")
        *   ReadOnly quando codigo da moeda esta preenchido (When original)
        loc_oPg.AddObject("txt_4c_MoedaDesc", "TextBox")
        WITH loc_oPg.txt_4c_MoedaDesc
            .Top           = 94
            .Left          = 300
            .Width         = 115
            .Height        = 23
            .Value         = ""
            .MaxLength     = 15
            .Format        = "!"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .Alignment     = 0
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Empresa :"
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Top       = 122
            .Left      = 214
            .Width     = 50
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da empresa (getEmpresa: MaxLength=3)
        loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPg.txt_4c_Empresa
            .Top         = 119
            .Left        = 267
            .Width       = 31
            .Height      = 23
            .Value       = ""
            .MaxLength   = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descricao da empresa (getDesEmpresa: Width=290)
        *   ReadOnly quando codigo da empresa esta preenchido (When original)
        loc_oPg.AddObject("txt_4c_DesEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DesEmpresa
            .Top         = 119
            .Left        = 300
            .Width       = 290
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Handlers de teclado para filtros secundarios (Moeda + Empresa)
        BINDEVENT(loc_oPg.txt_4c_Moeda,      "KeyPress", THIS, "TeclaMoeda")
        BINDEVENT(loc_oPg.txt_4c_MoedaDesc,  "KeyPress", THIS, "TeclaMoedaDesc")
        BINDEVENT(loc_oPg.txt_4c_Empresa,    "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DesEmpresa, "KeyPress", THIS, "TeclaDesEmpresa")

        *-- DblClick tambem abre lookup (equivalente ao F4)
        BINDEVENT(loc_oPg.txt_4c_Moeda,      "DblClick", THIS, "AbrirBuscaMoeda")
        BINDEVENT(loc_oPg.txt_4c_MoedaDesc,  "DblClick", THIS, "AbrirBuscaMoedaDesc")
        BINDEVENT(loc_oPg.txt_4c_Empresa,    "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DesEmpresa, "DblClick", THIS, "AbrirBuscaDesEmpresa")

        *-- Estado inicial dos campos de descricao (ReadOnly/editable)
        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao.
    *   Operacao=branco, Datas=hoje, Moeda=padrao do BO, Empresa=branca.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Dopes.Value      = ""
            loc_oPg.txt_4c_DtInicial.Value  = DATE()
            loc_oPg.txt_4c_DtFinal.Value    = DATE()
            loc_oPg.txt_4c_Moeda.Value      = ""
            loc_oPg.txt_4c_MoedaDesc.Value  = ""
            loc_oPg.txt_4c_Empresa.Value    = ""
            loc_oPg.txt_4c_DesEmpresa.Value = ""

            *-- Preenche moeda padrao carregada em InicializarFiltros()
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF !EMPTY(THIS.this_oRelatorio.this_cMoeda)
                    loc_oPg.txt_4c_Moeda.Value = THIS.this_oRelatorio.this_cMoeda
                ENDIF
                IF !EMPTY(THIS.this_oRelatorio.this_cMoedaDesc)
                    loc_oPg.txt_4c_MoedaDesc.Value = THIS.this_oRelatorio.this_cMoedaDesc
                ENDIF
            ENDIF

            THIS.AtualizarEstadoMoedaDesc()
            THIS.AtualizarEstadoDesEmpresa()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO.
    *   Equivalente ao bloco 'processamento' do form legado SIGREVTO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cDopes      = ALLTRIM(loc_oPg.txt_4c_Dopes.Value)
            .this_dDtInicial  = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal    = loc_oPg.txt_4c_DtFinal.Value
            .this_cMoeda      = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
            .this_cMoedaDesc  = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
            .this_cEmpresa    = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            .this_cDesEmpresa = ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Verifica data final >= data inicial.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c_DtInicial.Value
        loc_dFim = loc_oPg.txt_4c_DtFinal.Value
        IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
            MsgAviso("Data Final Menor Que a Inicial!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica preenchimento dos campos obrigatorios.
    *   Operacao e Moeda sao obrigatorios; Periodo e Empresa sao opcionais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Dopes.Value))
            MsgAviso("Informe o c" + CHR(243) + "digo da opera" + CHR(231) + ;
                CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Dopes.SetFocus()
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Moeda.Value))
            MsgAviso("Informe o c" + CHR(243) + "digo da moeda.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Moeda.SetFocus()
            RETURN .F.
        ENDIF
        IF !THIS.ValidarPeriodo()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *   Equivalente ao PROCEDURE visualizacao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFrxPath
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cFrxPath = gc_4c_CaminhoReports + "SigReVto.frx"
            REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de selecao de impressora
    *   Equivalente ao PROCEDURE impressao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrxPath
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cFrxPath = gc_4c_CaminhoReports + "SigReVto.frx"
            REPORT FORM (loc_cFrxPath) TO PRINTER PROMPT NOCONSOLE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Envia relatorio direto para impressora sem dialogo
    *   Equivalente ao PROCEDURE documento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_cFrxPath
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cFrxPath = gc_4c_CaminhoReports + "SigReVto.frx"
            REPORT FORM (loc_cFrxPath) TO PRINTER NOCONSOLE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Aliases para compatibilidade com pipeline que espera metodos CRUD.
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Dopes", 5)
                loc_oPg.txt_4c_Dopes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaOperacao(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacao()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperacao()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaDesc()
        ENDIF
    ENDPROC

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDesEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDesEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoMoedaDesc - Simula getDesEmpresa.When do legado.
    *   get_moeda_desc.When: Return Empty(ThisForm.get_moeda.Value)
    *   Campo de descricao so e editavel quando codigo da moeda esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoMoedaDesc()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_MoedaDesc.ReadOnly = ;
                !EMPTY(ALLTRIM(loc_oPg.txt_4c_Moeda.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoDesEmpresa - Simula getDesEmpresa.When do legado.
    *   getDesEmpresa.When: Return Empty(ThisForm.getEmpresa.Value)
    *   Campo de descricao so e editavel quando codigo da empresa esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoDesEmpresa()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DesEmpresa.ReadOnly = ;
                !EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUP - OPERACAO (SigCdOpe.Dopes)
    * Equivalente ao get_dopes.Valid: fAcessoMovmto do legado
    *==========================================================================

    PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dopes.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        loc_oPg.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarOperacao()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dopes.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_OpeVal
            IF EOF()
                loc_oPg.txt_4c_Dopes.Value = ""
                THIS.AbrirBuscaOperacao()
            ENDIF
        ELSE
            loc_oPg.txt_4c_Dopes.Value = ""
            THIS.AbrirBuscaOperacao()
        ENDIF
        IF USED("cursor_4c_OpeVal")
            USE IN cursor_4c_OpeVal
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pelo codigo (SigCdMoe.CMoes)
    * Equivalente ao get_moeda.Valid: fwbuscaext -> SigCdMoe / CMoes
    *==========================================================================

    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoeda()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_MoedaDesc.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeVal
            IF !EOF()
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(DMoes)
            ELSE
                loc_oPg.txt_4c_MoedaDesc.Value = ""
                THIS.AbrirBuscaMoeda()
            ENDIF
        ELSE
            loc_oPg.txt_4c_MoedaDesc.Value = ""
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF USED("cursor_4c_MoeVal")
            USE IN cursor_4c_MoeVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pela descricao (SigCdMoe.DMoes)
    * Equivalente ao get_moeda_desc.Valid: fwbuscaext -> SigCdMoe / DMoes
    *==========================================================================

    PROCEDURE AbrirBuscaMoedaDesc()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeD")
                        loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoeD")
            USE IN cursor_4c_BuscaMoeD
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Moeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + ;
                   EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeDescVal
            IF !EOF()
                loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(CMoes)
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(DMoes)
            ELSE
                THIS.AbrirBuscaMoedaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF USED("cursor_4c_MoeDescVal")
            USE IN cursor_4c_MoeDescVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pelo codigo (SigCdEmp.Cemps)
    * Equivalente ao getEmpresa.Valid: fAcessoEmpresa('C', ...) do legado
    *==========================================================================

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DesEmpresa.Value = ""
            THIS.AtualizarEstadoDesEmpresa()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(Razas)
            ELSE
                loc_oPg.txt_4c_DesEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DesEmpresa.Value = ""
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pela descricao (SigCdEmp.Razas)
    * Equivalente ao getDesEmpresa.Valid: fAcessoEmpresa('D', ...) do legado
    *==========================================================================

    PROCEDURE AbrirBuscaDesEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
                        loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                        loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpD")
            USE IN cursor_4c_BuscaEmpD
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarDesEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Empresa.Value = ""
            THIS.AtualizarEstadoDesEmpresa()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
                   EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpDescVal
            IF !EOF()
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(Cemps)
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.AbrirBuscaDesEmpresa()
            ENDIF
        ELSE
            THIS.AbrirBuscaDesEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpDescVal")
            USE IN cursor_4c_EmpDescVal
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *==========================================================================
    * METODOS PADRAO FormBase (sem aplicacao em relatorios)
    *==========================================================================

    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Dopes", 5)
                loc_oPg.txt_4c_Dopes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_Dopes.Value      = .this_cDopes
                loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
                loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
                loc_oPg.txt_4c_Moeda.Value      = .this_cMoeda
                loc_oPg.txt_4c_MoedaDesc.Value  = .this_cMoedaDesc
                loc_oPg.txt_4c_Empresa.Value    = .this_cEmpresa
                loc_oPg.txt_4c_DesEmpresa.Value = .this_cDesEmpresa
            ENDWITH
            THIS.AtualizarEstadoMoedaDesc()
            THIS.AtualizarEstadoDesEmpresa()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            IF PCOUNT() = 0
                loc_lHab = .T.
            ELSE
                loc_lHab = par_lHabilitar
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Dopes.Enabled     = loc_lHab
            loc_oPg.txt_4c_DtInicial.Enabled = loc_lHab
            loc_oPg.txt_4c_DtFinal.Enabled   = loc_lHab
            loc_oPg.txt_4c_Moeda.Enabled     = loc_lHab
            loc_oPg.txt_4c_Empresa.Enabled   = loc_lHab
            IF loc_lHab
                THIS.AtualizarEstadoMoedaDesc()
                THIS.AtualizarEstadoDesEmpresa()
            ELSE
                loc_oPg.txt_4c_MoedaDesc.Enabled  = .F.
                loc_oPg.txt_4c_DesEmpresa.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cnt_4c_Botoes) = "O"
                THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
                THIS.cnt_4c_Botoes.cmd_4c_Imprimir.Enabled   = .T.
                THIS.cnt_4c_Botoes.cmd_4c_Documento.Enabled  = .T.
                THIS.cnt_4c_Botoes.cmd_4c_Sair.Enabled       = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nDestino, loc_oPgf, loc_oPg
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) != "O"
                RETURN
            ENDIF
            IF PCOUNT() = 0 OR VARTYPE(par_nPagina) != "N"
                loc_nDestino = 1
            ELSE
                loc_nDestino = INT(par_nPagina)
            ENDIF
            IF loc_nDestino < 1
                loc_nDestino = 1
            ENDIF
            IF loc_nDestino > loc_oPgf.PageCount
                loc_nDestino = loc_oPgf.PageCount
            ENDIF
            loc_oPgf.ActivePage = loc_nDestino
            loc_oPg = loc_oPgf.Pages(loc_nDestino)
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Dopes", 5)
                loc_oPg.txt_4c_Dopes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrevtoBO.prg):
*==============================================================================
* SIGREVTOBO.PRG
* Business Object para Relatorio Total Por Operacao (SIGREVTO)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvPar (sem moeda de operacao)
*                     SigMvCab (com moeda de operacao via SigCdOpe.CMoes)
*
* Filtros:
*   - Operacao  (codigo da operacao - campo Dopes de SigMvPar/SigMvCab)
*   - Periodo   (data inicial / data final)
*   - Moeda     (codigo + descricao - CMoes/DMoes de SigCdMoe)
*   - Empresa   (codigo + descricao - Cemps/Razas de SigCdEmp, opcional)
*==============================================================================

DEFINE CLASS sigrevtoBO AS RelatorioBase

    *-- Filtro: operacao (get_dopes do legado - Dopes C(20))
    this_cDopes         = ""

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: moeda (get_moeda/get_moeda_desc do legado)
    this_cMoeda         = ""
    this_cMoedaDesc     = ""

    *-- Filtro: empresa (getEmpresa/getDesEmpresa do legado, opcional)
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""

    *-- Dados derivados - preenchidos em InicializarFiltros() e PrepararDados()
    this_cMoedaOpe      = ""   && CMoes de SigCdOpe para a operacao (vazio = usa SigMvPar)
    this_cNomeEmpresa   = ""   && Razas de SigCdEmp para cabecalho

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "cursor_4c_Relatorio"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de totais por operacao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega valores padrao de moeda e define datas
    * Chamado pelo Form em InicializarForm() apos instanciar o BO
    * Equivalente ao SELECT MoedaPs FROM SigCdPam no Init() legado
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Datas padrao = hoje
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()

            *-- Busca moeda padrao em SigCdPam
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_cSQL = "SELECT MoedaPs FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult > 0
                SELECT cursor_4c_Pam
                GO TOP
                IF !EOF()
                    THIS.this_cMoeda = ALLTRIM(MoedaPs)
                ENDIF
                USE IN cursor_4c_Pam
            ENDIF

            *-- Busca descricao da moeda padrao
            IF !EMPTY(THIS.this_cMoeda)
                IF USED("cursor_4c_MoePad")
                    USE IN cursor_4c_MoePad
                ENDIF
                loc_cSQL = "SELECT DMoes FROM SigCdMoe WHERE CMoes = " + ;
                           EscaparSQL(THIS.this_cMoeda)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePad")
                IF loc_nResult > 0
                    SELECT cursor_4c_MoePad
                    GO TOP
                    IF !EOF()
                        THIS.this_cMoedaDesc = ALLTRIM(DMoes)
                    ENDIF
                    USE IN cursor_4c_MoePad
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor_4c_Relatorio + CsCabecalho
    * Equivalente ao PROCEDURE processamento do legado SIGREVTO
    *
    * Logica dual:
    *   Branch A (EMPTY CMoes): usa SigMvPar + converte MoeFpgs -> this_cMoeda
    *   Branch B (!EMPTY CMoes): usa SigMvCab + converte CMoes da ope -> this_cMoeda
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_cDopes, loc_cMoeda, loc_cEmpresa, loc_cMoeOpe
        LOCAL loc_cDtIni, loc_cDtFin, loc_cWEmp
        LOCAL loc_cRazas, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            loc_cDopes   = PADR(ALLTRIM(THIS.this_cDopes), 20)
            loc_cMoeda   = ALLTRIM(THIS.this_cMoeda)
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            loc_cMoeOpe  = ""

            *-- Validacao obrigatoria
            IF EMPTY(ALLTRIM(loc_cDopes))
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                    "o obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(loc_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo obrigat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            *-- Formata datas para SQL DATETIME (coluna datas = DATETIME no banco)
            loc_cDtIni = "'" + PADL(YEAR(THIS.this_dDtInicial),4,"0")  + "-" + ;
                               PADL(MONTH(THIS.this_dDtInicial),2,"0") + "-" + ;
                               PADL(DAY(THIS.this_dDtInicial),2,"0")   + " 00:00:00'"
            loc_cDtFin = "'" + PADL(YEAR(THIS.this_dDtFinal),4,"0")    + "-" + ;
                               PADL(MONTH(THIS.this_dDtFinal),2,"0")   + "-" + ;
                               PADL(DAY(THIS.this_dDtFinal),2,"0")     + " 23:59:59'"

            *-- 1. Nome da empresa para o cabecalho do relatorio
            loc_cRazas = ""
            IF USED("cursor_4c_EmpCab")
                USE IN cursor_4c_EmpCab
            ENDIF
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCab")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpCab
                GO TOP
                IF !EOF()
                    loc_cRazas = ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_EmpCab
            ENDIF

            *-- 2. Textos do cabecalho
            loc_cTitulo = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                          CHR(231) + CHR(227) + "o - " + ;
                          PROPER(ALLTRIM(loc_cDopes)) + ;
                          IIF(EMPTY(loc_cEmpresa), "", ;
                              " - Empresa : " + loc_cEmpresa)
            loc_cPeriodo = "Per" + CHR(237) + "odo de " + ;
                           DTOC(THIS.this_dDtInicial) + " " + ;
                           CHR(224) + " " + DTOC(THIS.this_dDtFinal)

            *-- 3. Cria cursor de cabecalho para uso no FRX
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ;
                (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                             VALUES (loc_cRazas,  loc_cTitulo, loc_cPeriodo)

            *-- 4. Busca moeda da operacao em SigCdOpe (CMoes)
            IF USED("cursor_4c_Ope")
                USE IN cursor_4c_Ope
            ENDIF
            loc_cSQL = "SELECT CMoes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(loc_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
            IF loc_nResult > 0
                SELECT cursor_4c_Ope
                GO TOP
                IF !EOF()
                    loc_cMoeOpe = ALLTRIM(CMoes)
                ENDIF
                USE IN cursor_4c_Ope
            ENDIF
            THIS.this_cMoedaOpe = loc_cMoeOpe

            *-- 5. WHERE de empresa (opcional - filtra por empresa especifica)
            loc_cWEmp = IIF(EMPTY(loc_cEmpresa), "", ;
                            "Emps = " + EscaparSQL(loc_cEmpresa) + " AND ")

            *-- 6. Fecha cursor de resultado anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(loc_cMoeOpe)
                *-- Branch A: SigMvPar (operacao sem moeda de referencia definida)
                *-- Converte MoeFpgs -> this_cMoeda via fBuscarCotacao
                IF USED("crSigMvPar")
                    USE IN crSigMvPar
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, MoeFpgs, Valos " + ;
                           "FROM SigMvPar " + ;
                           "WHERE Datas BETWEEN " + loc_cDtIni + ;
                           " AND " + loc_cDtFin + ;
                           " AND " + loc_cWEmp + ;
                           "Dopes = " + EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvPar")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar dados de SigMvPar"
                    loc_lSucesso = .F.
                ENDIF

                SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
                       loc_cMoeda AS cMoeda, ;
                       0 AS mValVars, 0 AS mValDevs, ;
                       SUM(IIF(loc_cMoeda = MoeFpgs, Valos, ;
                           Valos * fBuscarCotacao(MoeFpgs, Datas, gnConnHandle) / ;
                                  fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValos ;
                  FROM crSigMvPar ;
                  GROUP BY crSigMvPar.Emps, crSigMvPar.Dopes, loc_cMoeda, 4, 5 ;
                  ORDER BY crSigMvPar.Emps, crSigMvPar.Dopes ;
                  INTO CURSOR cursor_4c_Relatorio READWRITE

                IF USED("crSigMvPar")
                    USE IN crSigMvPar
                ENDIF
            ELSE
                *-- Branch B: SigMvCab (operacao com moeda de referencia)
                *-- Converte CMoes da operacao -> this_cMoeda via fBuscarCotacao
                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, ValVars, ValDevs, Valos " + ;
                           "FROM SigMvCab " + ;
                           "WHERE Datas BETWEEN " + loc_cDtIni + ;
                           " AND " + loc_cDtFin + ;
                           " AND " + loc_cWEmp + ;
                           "Dopes = " + EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvCab")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar dados de SigMvCab"
                    loc_lSucesso = .F.
                ENDIF

                SELECT crSigMvCab.Emps, crSigMvCab.Dopes, ;
                       loc_cMoeda AS cMoeda, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, ValVars, ;
                           ValVars * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValVars, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, ValDevs, ;
                           ValDevs * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValDevs, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, Valos, ;
                           Valos   * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValos ;
                  FROM crSigMvCab ;
                  GROUP BY crSigMvCab.Emps, crSigMvCab.Dopes, loc_cMoeda ;
                  ORDER BY crSigMvCab.Emps, crSigMvCab.Dopes ;
                  INTO CURSOR cursor_4c_Relatorio READWRITE

                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF
            ENDIF

            *-- Posiciona no inicio do cursor de resultado
            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Executa PrepararDados e exibe relatorio em preview
    * Equivalente ao PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
                loc_lSucesso = .F.
            ENDIF
            loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                               gc_4c_CaminhoReports, "") + "SigReVto"
            REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Executa PrepararDados e envia para impressora (com prompt)
    * Equivalente ao PROCEDURE impressao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
                loc_lSucesso = .F.
            ENDIF
            loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                               gc_4c_CaminhoReports, "") + "SigReVto"
            REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Executa PrepararDados e imprime direto sem prompt
    * Equivalente ao PROCEDURE documento do legado
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_cRelPath, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
                loc_lSucesso = .F.
            ENDIF
            loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                               gc_4c_CaminhoReports, "") + "SigReVto"
            REPORT FORM &loc_cRelPath TO PRINTER NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Documento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * BOs de Relatorio populam dados via PrepararDados() -> cursor_4c_Relatorio,
    * nao precisam carregar registro individual do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao inserem registros no banco.
    * Operacao real e executada por Visualizar()/Imprimir()/Documento().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao atualizam registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO APLICAVEL a Relatorios
    * Relatorios sao somente-leitura.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao geram registros de auditoria
    * Override do RelatorioBase para deixar explicito.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_MoePad")
            USE IN cursor_4c_MoePad
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("crSigMvPar")
            USE IN crSigMvPar
        ENDIF
        IF USED("crSigMvCab")
            USE IN crSigMvCab
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

