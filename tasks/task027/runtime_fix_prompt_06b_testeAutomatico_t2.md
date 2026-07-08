# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/16/26 01:33:52 AM] SIGREAEGBO.Init: Connection handle is invalid.
[05/16/26 01:33:52 AM] Erro: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-16 01:32:42] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 01:32:42] [INFO] Config FPW: (nao fornecido)
[2026-05-16 01:32:42] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 01:32:42] [INFO] Timeout: 300 segundos
[2026-05-16 01:32:42] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_fgluzqqa.prg
[2026-05-16 01:32:42] [INFO] Conteudo do wrapper:
[2026-05-16 01:32:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGREAEG', 'C:\4c\tasks\task027', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREAEG', 'C:\4c\tasks\task027', 'REPORT'
QUIT

[2026-05-16 01:32:42] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_fgluzqqa.prg
[2026-05-16 01:32:42] [INFO] VFP output esperado em: C:\4c\tasks\task027\vfp_output.txt
[2026-05-16 01:32:42] [INFO] Executando Visual FoxPro 9...
[2026-05-16 01:32:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_fgluzqqa.prg
[2026-05-16 01:32:42] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_fgluzqqa.prg
[2026-05-16 01:32:42] [INFO] Timeout configurado: 300 segundos
[2026-05-16 01:32:43] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 01:32:43] [INFO] VFP9 finalizado em 1.3889627 segundos
[2026-05-16 01:32:43] [INFO] Exit Code: 
[2026-05-16 01:32:43] [INFO] 
[2026-05-16 01:32:43] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 01:32:43] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_fgluzqqa.prg
[2026-05-16 01:32:43] [INFO] 
[2026-05-16 01:32:43] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 01:32:43] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 01:32:43] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 01:32:43] [INFO] * Parameters: 'FormSIGREAEG', 'C:\4c\tasks\task027', 'REPORT'
[2026-05-16 01:32:43] [INFO] 
[2026-05-16 01:32:43] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 01:32:43] [INFO] SET SAFETY OFF
[2026-05-16 01:32:43] [INFO] SET RESOURCE OFF
[2026-05-16 01:32:43] [INFO] SET TALK OFF
[2026-05-16 01:32:43] [INFO] SET NOTIFY OFF
[2026-05-16 01:32:43] [INFO] SYS(2335, 0)
[2026-05-16 01:32:43] [INFO] 
[2026-05-16 01:32:43] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREAEG', 'C:\4c\tasks\task027', 'REPORT'
[2026-05-16 01:32:43] [INFO] QUIT
[2026-05-16 01:32:43] [INFO] 
[2026-05-16 01:32:43] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 01:32:43] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-05-16 01:33:50] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 01:33:50] [INFO] Config FPW: (nao fornecido)
[2026-05-16 01:33:50] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 01:33:50] [INFO] Timeout: 300 segundos
[2026-05-16 01:33:50] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_n1d0jfqs.prg
[2026-05-16 01:33:50] [INFO] Conteudo do wrapper:
[2026-05-16 01:33:50] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGREAEG', 'C:\4c\tasks\task027', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREAEG', 'C:\4c\tasks\task027', 'REPORT'
QUIT

[2026-05-16 01:33:50] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_n1d0jfqs.prg
[2026-05-16 01:33:50] [INFO] VFP output esperado em: C:\4c\tasks\task027\vfp_output.txt
[2026-05-16 01:33:50] [INFO] Executando Visual FoxPro 9...
[2026-05-16 01:33:50] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_n1d0jfqs.prg
[2026-05-16 01:33:50] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_n1d0jfqs.prg
[2026-05-16 01:33:50] [INFO] Timeout configurado: 300 segundos
[2026-05-16 01:33:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 01:33:52] [INFO] VFP9 finalizado em 2.0660863 segundos
[2026-05-16 01:33:52] [INFO] Exit Code: 
[2026-05-16 01:33:52] [INFO] 
[2026-05-16 01:33:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 01:33:52] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_n1d0jfqs.prg
[2026-05-16 01:33:52] [INFO] 
[2026-05-16 01:33:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 01:33:52] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 01:33:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 01:33:52] [INFO] * Parameters: 'FormSIGREAEG', 'C:\4c\tasks\task027', 'REPORT'
[2026-05-16 01:33:52] [INFO] 
[2026-05-16 01:33:52] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 01:33:52] [INFO] SET SAFETY OFF
[2026-05-16 01:33:52] [INFO] SET RESOURCE OFF
[2026-05-16 01:33:52] [INFO] SET TALK OFF
[2026-05-16 01:33:52] [INFO] SET NOTIFY OFF
[2026-05-16 01:33:52] [INFO] SYS(2335, 0)
[2026-05-16 01:33:52] [INFO] 
[2026-05-16 01:33:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREAEG', 'C:\4c\tasks\task027', 'REPORT'
[2026-05-16 01:33:52] [INFO] QUIT
[2026-05-16 01:33:52] [INFO] 
[2026-05-16 01:33:52] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 01:33:52] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGREAEG",
  "timestamp": "20260516013352",
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAEG.prg):
*==============================================================================
* FORMSIGREAEG.PRG
* Relatorio: Analise de Estoque por Grande Grupo
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAEG.SCX (frmrelatorio)
*
* Filtros (PageFrame 1 pagina - controles em Page1):
*   - Empresa       (codigo + descricao - SigCdEmp)
*   - Grande Grupo  (codigo + descricao - SigCdGpr)
*   - Grupo Estoque (codigo + descricao - SigCdGcr)
*   - Conta Estoque (codigo + descricao - SigCdCli)
*   - Periodo       (data inicial / data final)
*
* Relatorios FRX: SigReAe1.frx (principal), SigReAe2.frx (divergencias)
*==============================================================================

DEFINE CLASS FormSIGREAEG AS FormBase

    *-- Dimensoes e aparencia (original Width=800, Height=300; novo: +150 para header/PageFrame)
    Height      = 450
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
    *   1. Define Caption / Picture (fundo do form)
    *   2. Cria SIGREAEGBO e inicializa cursores de referencia
    *   3. Monta cabecalho escuro + botoes do relatorio
    *   4. Monta PageFrame com controles de filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "An" + CHR(225) + "lise de Estoque por Grande Grupo"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREAEGBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREAEGBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente ao cntSombra do frmrelatorio)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com 2 paginas (padrao do sistema - Page1=Filtros, Page2=Dados)
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- ConfigurarPaginaLista: sem grid de selecao neste relatorio
                THIS.ConfigurarPaginaLista()

                *-- Campos de filtro: Empresa, Grande Grupo, Grupo/Conta Estoque, Periodo
                THIS.ConfigurarPaginaDados()

                *-- Pre-preencher campos com valores iniciais do BO
                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGREAEG:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do relatorio
    *   Equivalente ao cntSombra/lblSombra/lblTitulo do framework frmrelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .T.
            .Caption   = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .T.
            .Caption   = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do original (btnReport): Left=487, Width=313, Height=80
    *   Botoes de 75px de largura: Left=5/81/157/233, Height=70, Top=5
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
        ENDWITH

        *-- Botao 1: Visualizar
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Botao 2: Imprimir
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Botao 3: Excel
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Excel"
            .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- Botao 4: Encerrar (Cancel=.T. para ESC fechar)
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Cancel          = .T.
        ENDWITH

        *-- BINDEVENTs: ButtonsClick -> handlers de acao do relatorio
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas (padrao do sistema)
    *   Filtros direto em Page1; Page2 como pagina de dados padrao
    *   Posicionamento: logo abaixo do cabecalho (85px) ate o fim do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
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

        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Carrega cursores de referencia em memoria
    *   Form de relatorio nao tem grid CRUD; esta fase carrega os cursores que
    *   o original carregava no Init via poDataMgr.SqlExecute:
    *     CrSigCdEmp (cemps/razas/ativas) -> indexado por cemps para SEEK em ValidarEmpresa
    *     CrSigCdGrp (cgrus/mercs/cestoqs) -> referencia de grupos de estoque
    *   Se a carga falhar, as validacoes fazem fallback para SQLEXEC direto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nResult
        TRY
            *-- Cursor de empresas: usado por ValidarEmpresa() via SEEK(cemps)
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, ativas FROM SigCdEmp ORDER BY cemps", ;
                "cursor_4c_SigCdEmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigCdEmp
                INDEX ON cemps TAG cemps ADDITIVE
                GO TOP
            ELSE
                MsgAviso("Falha ao carregar empresas." + CHR(13) + ;
                    "Valida" + CHR(231) + CHR(227) + "o de empresa usar" + ;
                    CHR(225) + " consulta direta.", "Aviso")
            ENDIF

            *-- Cursor de grupos de estoque: referencia carregada no Init original
            IF USED("cursor_4c_SigCdGrp")
                USE IN cursor_4c_SigCdGrp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cgrus, mercs, cestoqs FROM SigCdGrp ORDER BY cgrus", ;
                "cursor_4c_SigCdGrp")
            IF loc_nResult < 1
                MsgAviso("Falha ao carregar grupos de estoque." + CHR(13) + ;
                    "Valida" + CHR(231) + CHR(227) + "o usar" + CHR(225) + ;
                    " consulta direta.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Todos os campos de filtro do relatorio em Page1
    *   Ajuste de Top: Top_Page1 = Top_original - 85 (PageFrame inicia em Top=85)
    *   Empresa (top=120->35), GGrupo (top=145->60), GrEstoque (top=172->87),
    *   Estoque (top=199->114), Periodo (top=226->141)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- EMPRESA (original Say5 top=123->38, getEmpresa top=120->35, getDesEmpresa top=120->35)
        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 38
            .Left      = 224
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Top       = 35
            .Left      = 279
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DesEmpresa
            .Top       = 35
            .Left      = 312
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GRANDE GRUPO (original lbl_codigo top=150->65, get_cd_ggrupo top=145->60, get_ds_ggrupo top=145->60)
        loc_oPagina.AddObject("lbl_4c_GGrupo", "Label")
        WITH loc_oPagina.lbl_4c_GGrupo
            .Top       = 65
            .Left      = 198
            .AutoSize  = .T.
            .Caption   = "Grande Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdGGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_CdGGrupo
            .Top       = 60
            .Left      = 279
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsGGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsGGrupo
            .Top       = 60
            .Left      = 312
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GRUPO DE ESTOQUE (original Say2 top=177->92, get_Cd_GrEstoque top=172->87, get_Ds_GrEstoque top=172->87)
        loc_oPagina.AddObject("lbl_4c_GrEstoque", "Label")
        WITH loc_oPagina.lbl_4c_GrEstoque
            .Top       = 92
            .Left      = 179
            .AutoSize  = .T.
            .Caption   = "Grupo de Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdGrEstoque
            .Top       = 87
            .Left      = 279
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsGrEstoque
            .Top       = 87
            .Left      = 361
            .Width     = 290
            .Height    = 23
            .MaxLength = 20
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- CONTA DE ESTOQUE (original lbl_estoque top=204->119, get_cd_estoque top=199->114, get_ds_estoque top=199->114)
        loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
        WITH loc_oPagina.lbl_4c_Estoque
            .Top       = 119
            .Left      = 179
            .AutoSize  = .T.
            .Caption   = "Conta de Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .Top       = 114
            .Left      = 279
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsEstoque
            .Top       = 114
            .Left      = 361
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- PERIODO (original lbl_periodo top=231->146, get_dt_inicial top=226->141, get_dt_final top=226->141)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 146
            .Left      = 229
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top       = 141
            .Left      = 279
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Separador "a" entre datas (original lbl_periodo_a top=231->146, left=364)
        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 146
            .Left      = 364
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top       = 141
            .Left      = 376
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs: DblClick e KeyPress para todos os campos de filtro
        BINDEVENT(loc_oPagina.txt_4c_Empresa,     "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_Empresa,     "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DesEmpresa,  "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DesEmpresa,  "KeyPress", THIS, "TeclaDesEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_CdGGrupo,   "DblClick", THIS, "AbrirBuscaGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_CdGGrupo,   "KeyPress", THIS, "TeclaCdGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DsGGrupo,   "DblClick", THIS, "AbrirBuscaGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DsGGrupo,   "KeyPress", THIS, "TeclaDsGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,   "KeyPress", THIS, "TeclaCdEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,   "KeyPress", THIS, "TeclaDsEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DtInicial,   "KeyPress", THIS, "TeclaDtInicial")
        BINDEVENT(loc_oPagina.txt_4c_DtFinal,     "KeyPress", THIS, "TeclaDtFinal")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padrao do BO
    *   Datas preenchidas com DATE() (conforme Init() do BO); demais em branco
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.txt_4c_Empresa.Value     = ""
            loc_oPagina.txt_4c_DesEmpresa.Value  = ""
            loc_oPagina.txt_4c_CdGGrupo.Value    = ""
            loc_oPagina.txt_4c_DsGGrupo.Value    = ""
            loc_oPagina.txt_4c_CdGrEstoque.Value = ""
            loc_oPagina.txt_4c_DsGrEstoque.Value = ""
            loc_oPagina.txt_4c_CdEstoque.Value   = ""
            loc_oPagina.txt_4c_DsEstoque.Value   = ""

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPagina.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
                loc_oPagina.txt_4c_DtFinal.Value   = THIS.this_oRelatorio.this_dDtFinal
            ELSE
                loc_oPagina.txt_4c_DtInicial.Value = DATE()
                loc_oPagina.txt_4c_DtFinal.Value   = DATE()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para pagina solicitada no PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Empresa
    *==========================================================================

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Grande Grupo
    *==========================================================================

    PROCEDURE TeclaCdGGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaGGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Grupo de Estoque
    *==========================================================================

    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaGrEstoque()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Conta de Estoque
    *==========================================================================

    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEstoque()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO - Datas (sem acao especial alem de tipagem normal)
    *==========================================================================

    PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShiftAltCtrl)
        *-- Sem acao especial para teclas em campo de data
    ENDPROC

    PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShiftAltCtrl)
        *-- Sem acao especial para teclas em campo de data
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Empresa
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Valida codigo de empresa usando cursor_4c_SigCdEmp (em memoria)
    *   Equivale ao fAcessoEmpresa(Usuar,'C',...) do original
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_cCodigo, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DesEmpresa.Value = ""
                RETURN
            ENDIF
            IF USED("cursor_4c_SigCdEmp") AND ;
               SEEK(loc_cCodigo, "cursor_4c_SigCdEmp", "cemps")
                loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_SigCdEmp.cemps)
                loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_SigCdEmp.razas)
            ELSE
                MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
                loc_oPagina.txt_4c_Empresa.Value    = ""
                loc_oPagina.txt_4c_DesEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Lookup de empresa via SigCdEmp (cemps/razas)
    *   Equivale ao fAcessoEmpresa(Usuar,'D',...) do original (busca por descricao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreaEmpBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", loc_cCursor, "cemps", loc_cValor, ;
                "Selecionar Empresa", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cemps)
                    loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Grande Grupo (SigCdGpr)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCdGGrupo - Valida codigo de Grande Grupo via SigCdGpr (codigos/descs)
    *   Equivale ao fwBuscaExt com 'C' (codigo) do original get_cd_ggrupo.Valid
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsGGrupo.Value = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGpr WHERE codigos = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGGrpVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaGGrpVal")
                SELECT cursor_4c_SigreaGGrpVal
                loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(cursor_4c_SigreaGGrpVal.codigos)
                loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(cursor_4c_SigreaGGrpVal.descs)
            ELSE
                MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado.", "Grande Grupo")
                loc_oPagina.txt_4c_CdGGrupo.Value = ""
                loc_oPagina.txt_4c_DsGGrupo.Value = ""
                THIS.AbrirBuscaGGrupo()
            ENDIF
            IF USED("cursor_4c_SigreaGGrpVal")
                USE IN cursor_4c_SigreaGGrpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGGrupo - Lookup de Grande Grupo via SigCdGpr (codigos/descs)
    *   Equivale ao fwBuscaExt('SigCdGpr','TmpGGrupo','codigos',...) do original
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreaGGrpBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grande Grupo", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Grupo de Estoque (SigCdGcr)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCdGrEstoque - Valida codigo de Grupo de Estoque via SigCdGcr (codigos/descs)
    *   Equivale ao fAcessoContab(Usuar,'C',...) do original get_Cd_GrEstoque.Valid
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsGrEstoque.Value = ""
                loc_oPagina.txt_4c_CdEstoque.Value   = ""
                loc_oPagina.txt_4c_DsEstoque.Value   = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGcrVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaGcrVal")
                SELECT cursor_4c_SigreaGcrVal
                loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigreaGcrVal.codigos)
                loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigreaGcrVal.descs)
            ELSE
                MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
                         "Grupo de Estoque")
                loc_oPagina.txt_4c_CdGrEstoque.Value = ""
                loc_oPagina.txt_4c_DsGrEstoque.Value = ""
                THIS.AbrirBuscaGrEstoque()
            ENDIF
            IF USED("cursor_4c_SigreaGcrVal")
                USE IN cursor_4c_SigreaGcrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrEstoque - Lookup de Grupo de Estoque via SigCdGcr (codigos/descs)
    *   Equivale ao fAcessoContab(Usuar,'D',...) do original get_Ds_GrEstoque.Valid
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreaGcrBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grupo de Estoque", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(descs)
                    *-- Limpar conta de estoque ao trocar grupo (comportamento do original)
                    loc_oPagina.txt_4c_CdEstoque.Value = ""
                    loc_oPagina.txt_4c_DsEstoque.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO + LOOKUP - Conta de Estoque (SigCdCli)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCdEstoque - Valida codigo de Conta de Estoque via SigCdCli (iclis/rclis)
    *   Equivale ao fAcessoContas(Usuar,grupo,'C',...) do original get_cd_estoque.Valid
    *   Se houver GrEstoque selecionado, filtra SigCdCli pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cCodigo, loc_cGrupo, loc_cSQL, loc_nResult, loc_oPagina, loc_cFiltro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsEstoque.Value = ""
                RETURN
            ENDIF
            loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF
            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                       EscaparSQL(loc_cCodigo) + loc_cFiltro
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaCliVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaCliVal")
                SELECT cursor_4c_SigreaCliVal
                loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigreaCliVal.iclis)
                loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigreaCliVal.rclis)
            ELSE
                MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
                         "Conta de Estoque")
                loc_oPagina.txt_4c_CdEstoque.Value = ""
                loc_oPagina.txt_4c_DsEstoque.Value = ""
                THIS.AbrirBuscaEstoque()
            ENDIF
            IF USED("cursor_4c_SigreaCliVal")
                USE IN cursor_4c_SigreaCliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEstoque - Lookup de Conta de Estoque via SigCdCli (iclis/rclis)
    *   Equivale ao fAcessoContas(Usuar,grupo,'D',...) do original get_ds_estoque.Valid
    *   Se houver GrEstoque selecionado, filtra SigCdCli pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor, loc_cGrupo, loc_cFiltro
        loc_cCursor = "cursor_4c_SigreaCliBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Selecionar Conta de Estoque", loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
                    loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  TRANSFERENCIA DE DADOS - Form -> BO
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles do form para o BO
    *   Equivale ao inicio do PROCEDURE processamento do legado (leitura dos campos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cEmpresa      = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
                .this_cDesEmpresa   = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
                .this_cCdGGrupo     = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
                .this_cDsGGrupo     = ALLTRIM(loc_oPagina.txt_4c_DsGGrupo.Value)
                .this_cCdGrEstoque  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
                .this_cDsGrEstoque  = ALLTRIM(loc_oPagina.txt_4c_DsGrEstoque.Value)
                .this_cCdEstoque    = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
                .this_cDsEstoque    = ALLTRIM(loc_oPagina.txt_4c_DsEstoque.Value)
                .this_dDtInicial    = loc_oPagina.txt_4c_DtInicial.Value
                .this_dDtFinal      = loc_oPagina.txt_4c_DtFinal.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  VALIDACAO DOS CAMPOS ANTES DE GERAR O RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCampos - Valida campos obrigatorios antes de gerar o relatorio
    *   Equivale ao bloco de validacao do btnReport.Click do original:
    *   1. GrEstoque valido em SigCdGcr (se informado)
    *   2. Estoque valido em SigCdCli (se informado)
    *   3. GGrupo valido em SigCdGpr (se informado)
    *   4. Data inicial nao vazia
    *   5. Data final nao vazia
    *   6. Data final >= data inicial
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCampos()
        LOCAL loc_lResultado, loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResult
        loc_lResultado = .T.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Valida Grupo de Estoque (se informado)
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            IF !EMPTY(loc_cCodigo)
                loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGcr WHERE codigos = " + ;
                              EscaparSQL(loc_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGcrChk")
                IF loc_nResult < 1 OR EOF("cursor_4c_SigreaGcrChk")
                    MsgErro("Grupo de Estoque Inv" + CHR(225) + "lido.", "")
                    IF USED("cursor_4c_SigreaGcrChk")
                        USE IN cursor_4c_SigreaGcrChk
                    ENDIF
                    loc_oPagina.txt_4c_CdGrEstoque.SetFocus()
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_SigreaGcrChk")
                    USE IN cursor_4c_SigreaGcrChk
                ENDIF
            ENDIF

            *-- Valida Conta de Estoque (se informado)
            IF loc_lResultado
                loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
                IF !EMPTY(loc_cCodigo)
                    loc_cSQL    = "SELECT TOP 1 iclis FROM SigCdCli WHERE iclis = " + ;
                                  EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaCliChk")
                    IF loc_nResult < 1 OR EOF("cursor_4c_SigreaCliChk")
                        MsgErro("Conta de Estoque Inv" + CHR(225) + "lida.", "")
                        IF USED("cursor_4c_SigreaCliChk")
                            USE IN cursor_4c_SigreaCliChk
                        ENDIF
                        loc_oPagina.txt_4c_CdEstoque.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                    IF USED("cursor_4c_SigreaCliChk")
                        USE IN cursor_4c_SigreaCliChk
                    ENDIF
                ENDIF
            ENDIF

            *-- Valida Grande Grupo (se informado)
            IF loc_lResultado
                loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
                IF !EMPTY(loc_cCodigo)
                    loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGpr WHERE codigos = " + ;
                                  EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGGrpChk")
                    IF loc_nResult < 1 OR EOF("cursor_4c_SigreaGGrpChk")
                        MsgErro("Grande Grupo Inv" + CHR(225) + "lido.", "")
                        IF USED("cursor_4c_SigreaGGrpChk")
                            USE IN cursor_4c_SigreaGGrpChk
                        ENDIF
                        loc_oPagina.txt_4c_CdGGrupo.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                    IF USED("cursor_4c_SigreaGGrpChk")
                        USE IN cursor_4c_SigreaGGrpChk
                    ENDIF
                ENDIF
            ENDIF

            *-- Valida data inicial
            IF loc_lResultado AND EMPTY(loc_oPagina.txt_4c_DtInicial.Value)
                MsgErro("Data inicial inv" + CHR(225) + "lida !", "")
                loc_oPagina.txt_4c_DtInicial.SetFocus()
                loc_lResultado = .F.
            ENDIF

            *-- Valida data final
            IF loc_lResultado AND EMPTY(loc_oPagina.txt_4c_DtFinal.Value)
                MsgErro("Data final inv" + CHR(225) + "lida !", "")
                loc_oPagina.txt_4c_DtFinal.SetFocus()
                loc_lResultado = .F.
            ENDIF

            *-- Valida consistencia das datas
            IF loc_lResultado AND ;
               loc_oPagina.txt_4c_DtFinal.Value < loc_oPagina.txt_4c_DtInicial.Value
                MsgErro("Data inicial maior que data final !", "")
                loc_oPagina.txt_4c_DtInicial.SetFocus()
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    *  ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre preview do relatorio na tela
    *   Equivale ao btnReport.Visualiza.Click do legado (PROCEDURE visualizacao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *   Equivale ao btnReport.Imprime.Click do legado (PROCEDURE impressao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exportacao para Excel (funcionalidade DocExcel do legado)
    *   Prepara dados e exporta CsRelatorio para XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ;
                        "Relat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !USED("CsRelatorio") OR RECCOUNT("CsRelatorio") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", "Excel")
                RETURN
            ENDIF
            SELECT CsRelatorio
            loc_cArquivo = PUTFILE("Salvar como...", "RelAnaliseEstoque", "xls")
            IF EMPTY(loc_cArquivo)
                RETURN
            ENDIF
            COPY TO (loc_cArquivo) TYPE XL5
            MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *   Equivale ao btnReport.Sair (Cancel=.T. no framework, ESC tambem fecha)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *  STUBS DE COMPATIBILIDADE COM O FRAMEWORK (FormBase)
    *   Metodos CRUD que FormBase pode chamar; form REPORT nao usa CRUD.
    *==========================================================================

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    PROCEDURE FormParaBO()
        RETURN
    ENDPROC

    PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *==========================================================================
    *  CICLO DE VIDA DO FORM
    *==========================================================================

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relatorio e recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_SigCdGrp")
            USE IN cursor_4c_SigCdGrp
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREAEGBO.prg):
*==============================================================================
* SIGREAEGBO.PRG
* BO do Relatorio: Analise de Estoque por Grande Grupo
*
* Herda de: RelatorioBase
* Origem: SIGREAEG.SCX (frmrelatorio)
* Relatorios FRX: SigReAe1.frx (principal), SigReAe2.frx (divergencias)
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Grupo de Estoque / conta (codigo + descricao)
*   - Grande Grupo (codigo + descricao via SigCdGpr)
*   - Periodo (data inicial e data final)
*
* Cursores de referencia carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas)
*   cursor_4c_SigCdGrp  - grupos de estoque (cgrus, mercs, cestoqs)
*
* Validacoes antes de processar (implementadas no Form - BtnClick):
*   - Grupo de Estoque: SigCdGcr.codigos
*   - Conta de Estoque: SigCdCli.iclis
*   - Grande Grupo: SigCdGpr.codigos
*   - Data inicial e final nao podem estar em branco
*   - Data final >= data inicial
*==============================================================================

DEFINE CLASS SIGREAEGBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""
    this_cCdGGrupo      = ""
    this_cDsGGrupo      = ""
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega cursores de referencia
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
            loc_lSucesso = .T.

            *-- Carregar empresas (usadas em Processamento e Processa)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, ativas FROM SigCdEmp", ;
                "cursor_4c_SigCdEmp")
            IF loc_nResult >= 1
                SELECT cursor_4c_SigCdEmp
                INDEX ON cemps TAG cemps
                GO TOP
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar cadastro de empresas"
            ENDIF

            *-- Carregar grupos de estoque (usados em Processa via SEEK)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cgrus, mercs, cestoqs FROM SigCdGrp", ;
                "cursor_4c_SigCdGrp")
            IF loc_nResult >= 1
                SELECT cursor_4c_SigCdGrp
                INDEX ON cgrus TAG cgrus
                GO TOP
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar grupos de estoque"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREAEGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_SigCdGrp")
            USE IN cursor_4c_SigCdGrp
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Coordena o processamento completo dos dados do relatorio
    * Equivalente ao procedimento "processamento" do formulario original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrupo
        LOCAL loc_dDtInicial, loc_dDtFinal
        LOCAL loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2, loc_cPeriodo
        LOCAL loc_cCodEmpAtual, loc_lInicio, loc_lProcessa

        loc_lSucesso   = .F.
        loc_cEmpresa   = ALLTRIM(THIS.this_cEmpresa)
        loc_cGrupo     = ALLTRIM(THIS.this_cCdGrEstoque)
        loc_cEstoque   = ALLTRIM(THIS.this_cCdEstoque)
        loc_cGGrupo    = ALLTRIM(THIS.this_cCdGGrupo)
        loc_dDtInicial = THIS.this_dDtInicial
        loc_dDtFinal   = THIS.this_dDtFinal

        TRY
            *-- Montar cabecalho do relatorio
            loc_cTitulo1 = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
            loc_cTitulo2 = "Grupo: " + ;
                IIF(EMPTY(loc_cGrupo), "Todos", ;
                    ALLTRIM(loc_cGrupo) + " - " + ALLTRIM(THIS.this_cDsGrEstoque)) + ;
                " / Estoque: " + ;
                IIF(EMPTY(loc_cEstoque), "Todos", ;
                    ALLTRIM(loc_cEstoque) + " - " + ALLTRIM(THIS.this_cDsEstoque)) + ;
                " / Grande Grupo: " + ;
                IIF(EMPTY(loc_cGGrupo), "Todos", ALLTRIM(loc_cGGrupo))

            loc_cCodEmpAtual = go_4c_Sistema.cCodEmpresa
            IF SEEK(loc_cCodEmpAtual, "cursor_4c_SigCdEmp", "cemps")
                loc_cNomeEmpresa = ALLTRIM(loc_cCodEmpAtual) + " - " + ALLTRIM(cursor_4c_SigCdEmp.razas)
            ELSE
                loc_cNomeEmpresa = ALLTRIM(loc_cCodEmpAtual)
            ENDIF
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(loc_dDtFinal)

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (nomeempresa c(80), titulo1 c(80), titulo2 c(150), periodo c(80))
            INSERT INTO CsCabecalho (nomeempresa, titulo1, titulo2, periodo) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2, loc_cPeriodo)

            *-- Processar por empresa(s)
            IF EMPTY(loc_cEmpresa)
                loc_lInicio = .T.
                WAIT WINDOW "Verificando as empresas..." NOWAIT
                SELECT cursor_4c_SigCdEmp
                GO TOP
                SCAN
                    IF cursor_4c_SigCdEmp.ativas = 1
                        IF !THIS.ProcessarEmpresa(cursor_4c_SigCdEmp.cemps, ;
                                loc_cGrupo, loc_cEstoque, loc_cGGrupo)
                            THIS.this_cMensagemErro = "Erro ao processar empresa " + ;
                                ALLTRIM(cursor_4c_SigCdEmp.cemps)
                            loc_lSucesso = .F.
                        ENDIF
                        IF loc_lInicio
                            SELECT * FROM CsRel INTO CURSOR CsRelatorio READWRITE
                            SELECT * FROM CsDif INTO CURSOR CsDiferenca READWRITE
                            loc_lInicio = .F.
                        ELSE
                            SELECT CsRel
                            SCAN
                                SCATTER MEMVAR MEMO
                                INSERT INTO CsRelatorio FROM MEMVAR
                            ENDSCAN
                            SELECT CsDif
                            SCAN
                                SCATTER MEMVAR MEMO
                                INSERT INTO CsDiferenca FROM MEMVAR
                            ENDSCAN
                        ENDIF
                    ENDIF
                ENDSCAN
                WAIT CLEAR
            ELSE
                loc_lProcessa = THIS.ProcessarEmpresa(loc_cEmpresa, loc_cGrupo, ;
                                                      loc_cEstoque, loc_cGGrupo)
                IF !loc_lProcessa
                    loc_lSucesso = .F.
                ENDIF
                WAIT WINDOW "Aguarde a emiss" + CHR(227) + "o do relat" + CHR(243) + "rio..." NOWAIT
                SELECT * FROM CsRel INTO CURSOR CsRelatorio READWRITE
                SELECT * FROM CsDif INTO CURSOR CsDiferenca READWRITE
                WAIT CLEAR
            ENDIF

            SELECT CsDiferenca
            INDEX ON emps + dopes + STR(numes) TAG EmpDopNums
            GO TOP

            SELECT CsRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEmpresa - Executa o processamento completo de uma empresa
    * Equivalente ao procedimento "processa" do formulario original
    * par_cEmpEst  - Codigo da empresa (3 chars)
    * par_cGruEst  - Codigo do grupo de estoque (pode ser vazio)
    * par_cEstEst  - Codigo da conta de estoque (pode ser vazio)
    * par_cGGrupo  - Codigo do grande grupo (pode ser vazio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEmpresa(par_cEmpEst, par_cGruEst, par_cEstEst, par_cGGrupo)
        LOCAL loc_lSucesso
        LOCAL loc_cEmpEst, loc_cGruEst, loc_cEstEst, loc_cGGrupo
        LOCAL loc_dDtInicial, loc_dDtFinal, loc_dDtAnt
        LOCAL loc_tDtIni, loc_tDtFin, loc_tDtAnt
        LOCAL loc_cFiltro, loc_cQuery, loc_nResult
        LOCAL loc_cEGEs, loc_cEDNs, loc_cDopps
        LOCAL loc_cEmpIni, loc_cEmpFin, loc_cGruIni, loc_cGruFin, loc_cEstIni, loc_cEstFin
        LOCAL loc_nSQtds, loc_lnSldIni, loc_lnSldFin, loc_lFirst
        LOCAL loc_llOrigem, loc_llDestino, loc_cOpers, loc_cGGrpLocal

        loc_lSucesso = .F.
        TRY
            loc_cEmpEst    = PADR(ALLTRIM(par_cEmpEst), 3)
            loc_cGruEst    = PADR(ALLTRIM(par_cGruEst), 10)
            loc_cEstEst    = PADR(ALLTRIM(par_cEstEst), 10)
            loc_cGGrupo    = PADR(ALLTRIM(par_cGGrupo), 3)
            loc_dDtInicial = THIS.this_dDtInicial
            loc_dDtFinal   = THIS.this_dDtFinal
            loc_dDtAnt     = loc_dDtInicial - 1
            loc_tDtIni     = CTOT(DTOC(loc_dDtInicial) + " 00:00:00")
            loc_tDtFin     = CTOT(DTOC(loc_dDtFinal) + " 23:59:59")
            loc_tDtAnt     = CTOT(DTOC(loc_dDtAnt) + " 23:59:59")

            *-- Limpar cursores de trabalho anteriores
            IF USED("CrSigMvHst")
                USE IN CrSigMvHst
            ENDIF
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            IF USED("CsMov")
                USE IN CsMov
            ENDIF
            IF USED("CsPrd")
                USE IN CsPrd
            ENDIF
            IF USED("CsRel")
                USE IN CsRel
            ENDIF
            IF USED("TmpEstoque")
                USE IN TmpEstoque
            ENDIF

            *-- Criar cursores de trabalho
            CREATE CURSOR CrSigMvHst (Emps c(3), Grupos c(10), Estos c(10), Dopes c(20), ;
                Numes n(6,0), CPros c(14), Datas t NULL, Qtds n(12,3), ;
                Opers c(1), SQtds n(12,3), EmpGruEsts c(23), CIdChaves c(20))

            CREATE CURSOR TmpEst (CIdChaves c(20), Emps c(3), Grupos c(10), Estos c(10), ;
                CPros c(14), SalIni n(16,3), SalAtu n(16,3), GGrupo c(3))

            CREATE CURSOR CsMov (emps c(3), ggrupo c(3), dopes c(20), numes n(6,0), ;
                opers c(1), cpros c(14), qtds n(12,3), Pesos n(9,3))

            CREATE CURSOR CsPrd (emps c(3), ggrupo c(3), dopes c(20), numes n(6,0), ;
                opers c(1), qtds n(12,3))

            CREATE CURSOR CsRel (emps c(3), ggrupo c(3), dopes c(20), sldini n(12,3), ;
                entmov n(12,3), saimov n(12,3), salmov n(12,3), ;
                enthis n(12,3), saihis n(12,3), salhis n(12,3), ;
                sldfin n(12,3), difs n(12,3), PesoEs n(12,3), PesoSs n(12,3))

            *-- Montar lista de combinacoes Emps+Grupos+Estos a processar
            IF !EMPTY(ALLTRIM(loc_cGruEst)) AND !EMPTY(ALLTRIM(loc_cEstEst))
                CREATE CURSOR TmpEstoque (Emps c(3), Grupos c(10), Estos c(10))
                INSERT INTO TmpEstoque (Emps, Grupos, Estos) ;
                    VALUES (loc_cEmpEst, loc_cGruEst, loc_cEstEst)
            ELSE
                loc_cQuery = "SELECT Emps, Grupos, Estos FROM SigMvEst " + ;
                             "WHERE Emps = '" + ALLTRIM(loc_cEmpEst) + "'" + ;
                             IIF(!EMPTY(ALLTRIM(loc_cGruEst)), ;
                                 " AND Grupos = '" + ALLTRIM(loc_cGruEst) + "'", "") + ;
                             IIF(!EMPTY(ALLTRIM(loc_cEstEst)), ;
                                 " AND Estos = '" + ALLTRIM(loc_cEstEst) + "'", "") + ;
                             " GROUP BY Emps, Grupos, Estos ORDER BY Emps, Grupos, Estos"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpEstoque")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (TmpEstoque)"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
            SELECT TmpEstoque
            INDEX ON Emps + Grupos + Estos TAG EmpGruEsts
            GO TOP

            *-- Montar filtro SQL para selecao de produtos por estoque
            IF !EMPTY(ALLTRIM(loc_cEmpEst)) AND !EMPTY(ALLTRIM(loc_cGruEst)) AND !EMPTY(ALLTRIM(loc_cEstEst))
                loc_cFiltro = "a.empgruests = '" + loc_cEmpEst + loc_cGruEst + loc_cEstEst + "'"
            ELSE
                loc_cEmpIni = IIF(!EMPTY(ALLTRIM(loc_cEmpEst)), loc_cEmpEst, SPACE(3))
                loc_cEmpFin = IIF(!EMPTY(ALLTRIM(loc_cEmpEst)), loc_cEmpEst, REPLICATE(CHR(254), 3))
                loc_cGruIni = IIF(!EMPTY(ALLTRIM(loc_cGruEst)), loc_cGruEst, SPACE(10))
                loc_cGruFin = IIF(!EMPTY(ALLTRIM(loc_cGruEst)), loc_cGruEst, REPLICATE(CHR(254), 10))
                loc_cEstIni = IIF(!EMPTY(ALLTRIM(loc_cEstEst)), loc_cEstEst, SPACE(10))
                loc_cEstFin = IIF(!EMPTY(ALLTRIM(loc_cEstEst)), loc_cEstEst, REPLICATE(CHR(254), 10))
                loc_cFiltro = "a.empgruests BETWEEN '" + ;
                              loc_cEmpIni + loc_cGruIni + loc_cEstIni + ;
                              "' AND '" + ;
                              loc_cEmpFin + loc_cGruFin + loc_cEstFin + "'"
            ENDIF

            *-- Selecionar produtos dos estoques (join SigMvEst + SigCdPro + SigCdGrp)
            WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT
            loc_cQuery = "SELECT a.cIdChaves, a.Emps, a.Grupos, a.Estos, a.Cpros, " + ;
                         "c.Mercs AS GGrupo " + ;
                         "FROM SigMvEst a, SigCdPro b, SigCdGrp c " + ;
                         "WHERE " + loc_cFiltro + ;
                         " AND b.Cpros = a.Cpros AND c.Cgrus = b.Cgrus " + ;
                         IIF(EMPTY(ALLTRIM(loc_cGGrupo)), "", ;
                             "AND c.Mercs = '" + ALLTRIM(loc_cGGrupo) + "' ") + ;
                         "GROUP BY a.cIdChaves, a.Emps, a.Grupos, a.Estos, a.Cpros, c.Mercs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpSigMvEst")
            IF loc_nResult < 1
                MsgAviso("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (TmpSigMvEst)")
                loc_lSucesso = .F.
            ENDIF

            SELECT TmpEst
            ZAP IN TmpEst
            SELECT TmpSigMvEst
            GO TOP
            SCAN
                SCATTER MEMVAR
                m.SalIni = 0
                m.SalAtu = 0
                INSERT INTO TmpEst FROM MEMVAR
            ENDSCAN
            IF USED("TmpSigMvEst")
                USE IN TmpSigMvEst
            ENDIF
            WAIT CLEAR

            *-- Preparar TmpEst para busca de saldos
            SELECT TmpEst
            INDEX ON Emps + Grupos + Estos + CPros + GGrupo TAG EmpProGG
            GO TOP

            *-- Carregar historico ate a data final para cada estoque
            WAIT WINDOW "Selecionando Hist" + CHR(243) + "ricos..." NOWAIT
            SELECT TmpEstoque
            GO TOP
            SCAN
                loc_cEGEs = PADR(TmpEstoque.Emps, 3) + PADR(TmpEstoque.Grupos, 10) + ;
                            PADR(TmpEstoque.Estos, 10)
                loc_cQuery = "SELECT Emps, Grupos, Estos, CPros, Dopes, Numes, Datas, Qtds, " + ;
                             "Opers, SQtds, EmpGruEsts, CIdChaves " + ;
                             "FROM SigMvHst " + ;
                             "WHERE EmpGruEsts = " + EscaparSQL(loc_cEGEs) + " AND Datas <= ?loc_tDtFin " + ;
                             "ORDER BY Emps, Grupos, Estos, CPros, CIdChaves"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "CsHis")
                IF loc_nResult < 1
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsHis
                GO TOP
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO CrSigMvHst FROM MEMVAR
                ENDSCAN
                IF USED("CsHis")
                    USE IN CsHis
                ENDIF
                SELECT TmpEstoque
            ENDSCAN
            WAIT CLEAR

            SELECT CrSigMvHst
            INDEX ON EmpGruEsts TAG EmpGruEsts
            INDEX ON CPros TAG CPros
            INDEX ON EmpGruEsts + CPros + CIdChaves TAG EmpEstPro
            GO TOP

            *-- Calcular saldo anterior (antes da data inicial) por produto
            WAIT WINDOW "Verificando Saldo Anterior..." NOWAIT
            SELECT TmpEst
            GO TOP
            SCAN
                loc_nSQtds = 0
                loc_cEGEs  = TmpEst.Emps + TmpEst.Grupos + TmpEst.Estos
                IF USED("CrTmpHis")
                    USE IN CrTmpHis
                ENDIF
                SELECT TOP 1 Emps, Grupos, Estos, CPros, Datas, SQtds ;
                FROM CrSigMvHst ;
                WHERE EmpGruEsts = loc_cEGEs AND CPros = TmpEst.CPros AND Datas <= loc_tDtAnt ;
                ORDER BY CIdChaves DESC ;
                INTO CURSOR CrTmpHis READWRITE
                SELECT CrTmpHis
                GO TOP
                IF !EOF()
                    loc_nSQtds = CrTmpHis.SQtds
                ENDIF
                REPLACE SalIni WITH loc_nSQtds IN TmpEst
                SELECT TmpEst
            ENDSCAN
            WAIT CLEAR

            *-- Saldo inicial agregado por grande grupo
            SELECT Emps, GGrupo, MAX(Grupos) AS Grupos, MAX(Estos) AS Estos, SUM(SalIni) AS Saldo ;
            FROM TmpEst ;
            GROUP BY Emps, GGrupo ;
            INTO CURSOR csSaldoIni READWRITE
            SELECT csSaldoIni
            INDEX ON GGrupo TAG GGrupo
            GO TOP

            *-- Calcular saldo atual (no final do periodo) por produto
            WAIT WINDOW "Verificando Saldo Atual..." NOWAIT
            SELECT TmpEst
            GO TOP
            SCAN
                loc_nSQtds = 0
                loc_cEGEs  = TmpEst.Emps + TmpEst.Grupos + TmpEst.Estos
                IF USED("CrTmpHis")
                    USE IN CrTmpHis
                ENDIF
                SELECT TOP 1 Emps, Grupos, Estos, CPros, Datas, SQtds ;
                FROM CrSigMvHst ;
                WHERE EmpGruEsts = loc_cEGEs AND CPros = TmpEst.CPros AND Datas <= loc_tDtFin ;
                ORDER BY CIdChaves DESC ;
                INTO CURSOR CrTmpHis READWRITE
                SELECT CrTmpHis
                GO TOP
                IF !EOF()
                    loc_nSQtds = CrTmpHis.SQtds
                ENDIF
                SELECT TmpEst
                REPLACE TmpEst.salatu WITH loc_nSQtds
            ENDSCAN
            WAIT CLEAR

            *-- Saldo final agregado por grande grupo
            SELECT Emps, GGrupo, MAX(Grupos) AS Grupos, MAX(Estos) AS Estos, SUM(SalAtu) AS Saldo ;
            FROM TmpEst ;
            GROUP BY Emps, GGrupo ;
            INTO CURSOR csSaldoFin READWRITE
            SELECT csSaldoFin
            INDEX ON GGrupo TAG GGrupo
            GO TOP

            IF USED("CrTmpHis")
                USE IN CrTmpHis
            ENDIF

            *-- Selecionar movimentos do historico no periodo
            WAIT WINDOW "Aguarde! Analisando Estoque no Per" + CHR(237) + "odo..." NOWAIT
            SELECT Emps, Grupos, Estos, Dopes, Numes, CPros, Qtds, Opers, '   ' AS ggrupo ;
            FROM CrSigMvHst ;
            WHERE Datas BETWEEN loc_tDtIni AND loc_tDtFin ;
            ORDER BY Emps, Grupos, Estos, Dopes, Numes, CPros, Qtds, Opers ;
            INTO CURSOR TmpHis READWRITE
            WAIT CLEAR

            *-- Enriquecer TmpHis com GGrupo via SigCdPro + cursor_4c_SigCdGrp
            WAIT WINDOW "Verificando Grandes Grupos..." NOWAIT
            SELECT TmpHis
            GO TOP
            SCAN
                loc_cGGrpLocal = ''
                IF USED("TmpPro")
                    USE IN TmpPro
                ENDIF
                loc_cQuery = "SELECT cpros, cgrus FROM SigCdPro " + ;
                             "WHERE cpros = " + EscaparSQL(ALLTRIM(TmpHis.cpros))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpPro")
                IF loc_nResult >= 1
                    SELECT TmpPro
                    GO TOP
                    IF !EOF()
                        IF SEEK(TmpPro.cgrus, "cursor_4c_SigCdGrp", "cgrus")
                            loc_cGGrpLocal = cursor_4c_SigCdGrp.mercs
                        ENDIF
                    ENDIF
                ENDIF
                REPLACE GGrupo WITH loc_cGGrpLocal IN TmpHis
                SELECT TmpHis
            ENDSCAN
            IF USED("TmpPro")
                USE IN TmpPro
            ENDIF
            WAIT CLEAR

            *-- Agregar historico detalhado por Emps+GGrupo+Dopes+Numes
            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds, 0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds, 0)) AS Saidas ;
            FROM TmpHis ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csHistorico READWRITE

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds, 0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds, 0)) AS Saidas ;
            FROM TmpHis ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csHist READWRITE

            *-- Totais historicos por Emps+GGrupo+Dopes
            SELECT Emps, GGrupo, Dopes, SUM(Entradas) AS Entradas, SUM(Saidas) AS Saidas ;
            FROM csHist ;
            GROUP BY Emps, GGrupo, Dopes ;
            ORDER BY Emps, GGrupo, Dopes ;
            INTO CURSOR csTotHis READWRITE

            *-- Processar movimentos das contas de estoque no periodo
            WAIT WINDOW "Selecionando Movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT
            SELECT TmpEstoque
            GO TOP
            SCAN
                IF USED("TprMvCab")
                    USE IN TprMvCab
                ENDIF

                *-- Movimentos onde o estoque e origem
                loc_cQuery = "SELECT a.cidchaves, a.empdopnums, a.grupoos, a.grupods, " + ;
                             "a.contaos, a.contads, " + ;
                             "o.opers, o.origems, o.destinos, o.estorigs, o.estdests " + ;
                             "FROM SigMvCab a, SigCdOpe o " + ;
                             "WHERE a.emps = '" + ALLTRIM(TmpEstoque.Emps) + "' " + ;
                             "AND a.grupoos = '" + ALLTRIM(TmpEstoque.Grupos) + "' " + ;
                             "AND a.contaos = '" + ALLTRIM(TmpEstoque.Estos) + "' " + ;
                             "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                             "AND o.dopes = a.dopes AND o.estoqs = 1 " + ;
                             "ORDER BY a.cidchaves, a.empdopnums, o.opers, " + ;
                             "o.origems, o.destinos, o.estorigs, o.estdests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpMvO")
                IF loc_nResult < 1
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpMvO
                GO TOP

                *-- Movimentos onde o estoque e destino (nao transferencias)
                loc_cQuery = "SELECT a.cidchaves, a.empdopnums, a.grupoos, a.grupods, " + ;
                             "a.contaos, a.contads, " + ;
                             "o.opers, o.origems, o.destinos, o.estorigs, o.estdests " + ;
                             "FROM SigMvCab a, SigCdOpe o " + ;
                             "WHERE a.emps = '" + ALLTRIM(TmpEstoque.Emps) + "' " + ;
                             "AND a.grupods = '" + ALLTRIM(TmpEstoque.Grupos) + "' " + ;
                             "AND a.contads = '" + ALLTRIM(TmpEstoque.Estos) + "' " + ;
                             "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                             "AND o.dopes = a.dopes AND o.estoqs = 1 AND o.transs <> 1 " + ;
                             "ORDER BY a.cidchaves, a.empdopnums, o.opers, " + ;
                             "o.origems, o.destinos, o.estorigs, o.estdests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpMvD")
                IF loc_nResult < 1
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpMvD
                GO TOP

                *-- Transferencias onde o estoque e destino
                loc_cQuery = "SELECT a.cidchaves, a.empds, a.emps, a.dopes, a.numes, " + ;
                             "a.grupoos, a.grupods, a.contaos, a.contads, " + ;
                             "o.opers, o.origems, o.destinos, o.estorigs, o.estdests " + ;
                             "FROM SigMvCab a, SigCdOpe o " + ;
                             "WHERE a.empds = '" + ALLTRIM(TmpEstoque.Emps) + "' " + ;
                             "AND a.grupods = '" + ALLTRIM(TmpEstoque.Grupos) + "' " + ;
                             "AND a.contads = '" + ALLTRIM(TmpEstoque.Estos) + "' " + ;
                             "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                             "AND o.dopes = a.dopes AND o.estoqs = 1 AND o.transs = 1 " + ;
                             "ORDER BY a.cidchaves, a.empds, a.emps, a.dopes, a.numes, " + ;
                             "o.opers, o.origems, o.destinos, o.estorigs, o.estdests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTrf")
                IF loc_nResult < 1
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpTrf
                GO TOP

                *-- Unir origem + destino + transferencias em cursor de cabecalhos
                SELECT empdopnums, grupoos, grupods, contaos, contads, ;
                       opers, origems, destinos, estorigs, estdests ;
                FROM TmpMvO ;
                UNION ALL ;
                SELECT empdopnums, grupoos, grupods, contaos, contads, ;
                       opers, origems, destinos, estorigs, estdests ;
                FROM TmpMvD ;
                UNION ALL ;
                SELECT emps + dopes + STR(numes, 6) AS empdopnums, ;
                       grupoos, grupods, contaos, contads, ;
                       opers, origems, destinos, estorigs, estdests ;
                FROM TmpTrf ;
                INTO CURSOR CsEest READWRITE

                *-- Agrupar por documento (remover duplicatas por empdopnums)
                SELECT empdopnums, ;
                       MAX(grupoos) AS grupoos, MAX(grupods) AS grupods, ;
                       MAX(contaos) AS contaos, MAX(contads) AS contads, ;
                       MAX(opers) AS opers, MAX(origems) AS origems, ;
                       MAX(destinos) AS destinos, MAX(estorigs) AS estorigs, ;
                       MAX(estdests) AS estdests ;
                FROM CsEest ;
                GROUP BY empdopnums ;
                INTO CURSOR TprMvCab READWRITE

                *-- Processar cada documento para classificar movimentos E/S no estoque
                SELECT TprMvCab
                GO TOP
                SCAN
                    loc_cEDNs     = TprMvCab.empdopnums
                    loc_llOrigem  = .F.
                    loc_llDestino = .F.

                    *-- Determinar se documento envolve o estoque atual como origem ou destino
                    IF TprMvCab.estorigs = 4 OR TprMvCab.opers = 3
                        IF TprMvCab.origems = 1 AND ;
                           TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                           TprMvCab.contaos = TmpEstoque.Estos
                            loc_llOrigem = .T.
                        ELSE
                            IF TprMvCab.destinos = 1 AND ;
                               TprMvCab.grupods = TmpEstoque.Grupos AND ;
                               TprMvCab.contads = TmpEstoque.Estos
                                loc_llDestino = .T.
                            ENDIF
                        ENDIF
                    ELSE
                        IF TprMvCab.origems = 1 AND ;
                           TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                           TprMvCab.contaos = TmpEstoque.Estos
                            IF INLIST(TprMvCab.estorigs, 1, 2)
                                loc_llOrigem = .T.
                            ENDIF
                        ENDIF
                        IF TprMvCab.destinos = 1 AND ;
                           TprMvCab.grupods = TmpEstoque.Grupos AND ;
                           TprMvCab.contads = TmpEstoque.Estos
                            IF INLIST(TprMvCab.estdests, 1, 2)
                                loc_llDestino = .T.
                            ENDIF
                        ENDIF
                    ENDIF

                    IF !loc_llOrigem AND !loc_llDestino
                        LOOP
                    ENDIF

                    *-- Buscar itens do documento
                    IF USED("crLclMvItn")
                        USE IN crLclMvItn
                    ENDIF
                    loc_cQuery = "SELECT a.cidchaves, a.emps, a.dopes, a.numes, a.cpros, " + ;
                                 "a.opers, a.qtds, a.qtds * a.pesos AS Pesos, p.cgrus " + ;
                                 "FROM SigMvItn a, SigCdPro p " + ;
                                 "WHERE a.empdopnums = '" + ALLTRIM(loc_cEDNs) + "' " + ;
                                 "AND p.cpros = a.cpros " + ;
                                 "GROUP BY a.cidchaves, a.emps, a.dopes, a.numes, " + ;
                                 "a.cpros, a.opers, a.qtds, a.pesos, p.cgrus"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crLclMvItn")
                    IF loc_nResult < 1
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT crLclMvItn
                    GO TOP
                    SCAN
                        *-- Verificar se produto pertence a categoria de estoque (cestoqs=1)
                        IF !SEEK(crLclMvItn.cgrus, "cursor_4c_SigCdGrp", "cgrus")
                            LOOP
                        ENDIF
                        IF cursor_4c_SigCdGrp.cestoqs <> 1
                            LOOP
                        ENDIF
                        m.GGrupo   = cursor_4c_SigCdGrp.mercs
                        loc_cOpers = ' '

                        *-- Determinar E/S por tipo de operacao (estorigs=4 = especial)
                        IF TprMvCab.estorigs = 4
                            loc_llOrigem  = .F.
                            loc_llDestino = .F.
                            IF crLclMvItn.opers = 'S' AND ;
                               TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                               TprMvCab.contaos = TmpEstoque.Estos
                                loc_llOrigem = .T.
                                loc_cOpers   = 'S'
                            ELSE
                                IF crLclMvItn.opers = 'E' AND ;
                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                   TprMvCab.contads = TmpEstoque.Estos
                                    loc_llDestino = .T.
                                    loc_cOpers    = 'E'
                                ENDIF
                            ENDIF
                        ELSE
                            IF TprMvCab.opers = 3
                                *-- Transferencia: origens e destinos cruzados por empresa
                                IF TprMvCab.origems = 1
                                    IF SUBSTR(TprMvCab.empdopnums, 1, 3) = loc_cEmpEst
                                        IF crLclMvItn.opers = 'S' AND ;
                                           TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                                           TprMvCab.contaos = TmpEstoque.Estos
                                            loc_llOrigem = .T.
                                            loc_cOpers   = 'S'
                                        ELSE
                                            IF crLclMvItn.opers = 'E' AND ;
                                               TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                                               TprMvCab.contaos = TmpEstoque.Estos
                                                loc_llDestino = .T.
                                                loc_cOpers    = 'E'
                                            ELSE
                                                IF crLclMvItn.opers = 'S' AND ;
                                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                   TprMvCab.contads = TmpEstoque.Estos
                                                    loc_llOrigem = .T.
                                                    loc_cOpers   = 'S'
                                                ELSE
                                                    IF crLclMvItn.opers = 'E' AND ;
                                                       TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                       TprMvCab.contads = TmpEstoque.Estos
                                                        loc_llDestino = .T.
                                                        loc_cOpers    = 'E'
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ELSE
                                        IF crLclMvItn.opers = 'S' AND ;
                                           TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                                           TprMvCab.contaos = TmpEstoque.Estos
                                            loc_llDestino = .T.
                                            loc_cOpers    = 'E'
                                        ELSE
                                            IF crLclMvItn.opers = 'E' AND ;
                                               TprMvCab.grupoos = TmpEstoque.Grupos AND ;
                                               TprMvCab.contaos = TmpEstoque.Estos
                                                loc_llOrigem = .T.
                                                loc_cOpers   = 'S'
                                            ELSE
                                                IF crLclMvItn.opers = 'S' AND ;
                                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                   TprMvCab.contads = TmpEstoque.Estos
                                                    loc_llDestino = .T.
                                                    loc_cOpers    = 'E'
                                                ELSE
                                                    IF crLclMvItn.opers = 'E' AND ;
                                                       TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                       TprMvCab.contads = TmpEstoque.Estos
                                                        loc_llOrigem = .T.
                                                        loc_cOpers   = 'S'
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ELSE
                                    IF TprMvCab.destinos = 1
                                        IF SUBSTR(TprMvCab.empdopnums, 1, 3) = loc_cEmpEst
                                            IF crLclMvItn.opers = 'S' AND ;
                                               TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                               TprMvCab.contads = TmpEstoque.Estos
                                                loc_llOrigem = .T.
                                                loc_cOpers   = 'S'
                                            ELSE
                                                IF crLclMvItn.opers = 'E' AND ;
                                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                   TprMvCab.contads = TmpEstoque.Estos
                                                    loc_llDestino = .T.
                                                    loc_cOpers    = 'E'
                                                ENDIF
                                            ENDIF
                                        ELSE
                                            IF crLclMvItn.opers = 'S' AND ;
                                               TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                               TprMvCab.contads = TmpEstoque.Estos
                                                loc_llDestino = .T.
                                                loc_cOpers    = 'E'
                                            ELSE
                                                IF crLclMvItn.opers = 'E' AND ;
                                                   TprMvCab.grupods = TmpEstoque.Grupos AND ;
                                                   TprMvCab.contads = TmpEstoque.Estos
                                                    loc_llOrigem = .T.
                                                    loc_cOpers   = 'S'
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ELSE
                                *-- Operacao normal: estorigs/estdests definem E/S
                                IF loc_llOrigem AND TprMvCab.estorigs = 1
                                    loc_cOpers = 'E'
                                ELSE
                                    IF loc_llOrigem AND TprMvCab.estorigs = 2
                                        loc_cOpers = 'S'
                                    ELSE
                                        IF loc_llDestino AND TprMvCab.estdests = 1
                                            loc_cOpers = 'E'
                                        ELSE
                                            IF loc_llDestino AND TprMvCab.estdests = 2
                                                loc_cOpers = 'S'
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF

                        IF loc_llOrigem OR loc_llDestino
                            SELECT crLclMvItn
                            SCATTER MEMVAR
                            m.emps  = loc_cEmpEst
                            m.opers = loc_cOpers
                            INSERT INTO CsMov FROM MEMVAR
                        ENDIF
                        SELECT crLclMvItn
                    ENDSCAN
                    SELECT TprMvCab
                ENDSCAN
                SELECT TmpEstoque
            ENDSCAN
            WAIT CLEAR

            SELECT CsMov
            GO TOP

            *-- Agregar movimentos de estoque por Emps+GGrupo+Dopes+Numes
            WAIT WINDOW "Aguarde! Analisando Movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds,  0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds,  0)) AS Saidas, ;
                   SUM(IIF(Opers = 'E', Pesos, 0)) AS PesoEs, ;
                   SUM(IIF(Opers = 'S', Pesos, 0)) AS PesoSs ;
            FROM CsMov ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            ORDER BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csMovimento READWRITE

            SELECT csMovimento
            GO TOP

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds,  0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds,  0)) AS Saidas, ;
                   SUM(IIF(Opers = 'E', Pesos, 0)) AS PesoEs, ;
                   SUM(IIF(Opers = 'S', Pesos, 0)) AS PesoSs ;
            FROM CsMov ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            ORDER BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csMovs READWRITE

            SELECT csMovs
            GO TOP

            SELECT Emps, GGrupo, Dopes, ;
                   SUM(Entradas) AS Entradas, SUM(Saidas) AS Saidas, ;
                   SUM(PesoEs) AS PesoEs, SUM(PesoSs) AS PesoSs ;
            FROM csMovs ;
            GROUP BY Emps, GGrupo, Dopes ;
            ORDER BY Emps, GGrupo, Dopes ;
            INTO CURSOR csTotMov READWRITE

            SELECT csTotMov
            GO TOP
            WAIT CLEAR

            *-- Selecionar producao - entradas (ENCERRAMENTO DIRETO)
            WAIT WINDOW "Aguarde! Selecionando Produ" + CHR(231) + CHR(227) + "o (Entradas)..." NOWAIT
            loc_cDopps = PADR('ENCERRAMENTO DIRETO', 20)
            IF USED("TmpPdE")
                USE IN TmpPdE
            ENDIF
            loc_cQuery = "SELECT a.emps, a.dopps AS dopes, a.numps AS numes, " + ;
                         "b.codpds AS cpros, b.qtds, 'E' AS opers, c.cgrus " + ;
                         "FROM SigCdNec a, SigPdMvf b, SigCdPro c " + ;
                         "WHERE a.emps = '" + ALLTRIM(loc_cEmpEst) + "' " + ;
                         "AND a.dopps = '" + loc_cDopps + "' " + ;
                         "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                         "AND b.emps = a.emps AND b.dopps = a.dopps AND b.numps = a.numps " + ;
                         "AND c.cpros = b.codpds " + ;
                         "ORDER BY a.emps, a.dopps, a.numps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpPdE")
            IF loc_nResult < 1
                MsgAviso("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Selecionar producao - entradas (ENCERRAMENTO)
            loc_cDopps = PADR('ENCERRAMENTO', 20)
            IF USED("TmpPdE2")
                USE IN TmpPdE2
            ENDIF
            loc_cQuery = "SELECT a.emps, a.dopps AS dopes, a.numps AS numes, " + ;
                         "b.codpds AS cpros, b.qtds, 'E' AS opers, c.cgrus " + ;
                         "FROM SigCdNec a, SigPdMvf b, SigCdPro c " + ;
                         "WHERE a.emps = '" + ALLTRIM(loc_cEmpEst) + "' " + ;
                         "AND a.dopps = '" + loc_cDopps + "' " + ;
                         "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                         "AND b.emps = a.emps AND b.dopps = a.dopps AND b.numps = a.numps " + ;
                         "AND c.cpros = b.codpds " + ;
                         "ORDER BY a.emps, a.dopps, a.numps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpPdE2")
            IF loc_nResult < 1
                MsgAviso("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Adicionar entradas de producao ao CsPrd
            SELECT TmpPdE
            GO TOP
            SCAN
                SCATTER MEMVAR
                m.ggrupo = IIF(SEEK(TmpPdE.cgrus, "cursor_4c_SigCdGrp", "cgrus"), ;
                               cursor_4c_SigCdGrp.mercs, '')
                INSERT INTO CsPrd FROM MEMVAR
            ENDSCAN

            SELECT TmpPdE2
            GO TOP
            SCAN
                SCATTER MEMVAR
                m.ggrupo = IIF(SEEK(TmpPdE2.cgrus, "cursor_4c_SigCdGrp", "cgrus"), ;
                               cursor_4c_SigCdGrp.mercs, '')
                INSERT INTO CsPrd FROM MEMVAR
            ENDSCAN
            WAIT CLEAR

            *-- Selecionar producao - saidas (ENCERRAMENTO DIRETO = materia prima consumida)
            WAIT WINDOW "Aguarde! Selecionando Produ" + CHR(231) + CHR(227) + "o (Sa" + ;
                        CHR(237) + "das)..." NOWAIT
            loc_cDopps = PADR('ENCERRAMENTO DIRETO', 20)
            IF USED("TmpEnc")
                USE IN TmpEnc
            ENDIF
            loc_cQuery = "SELECT a.emps, a.dopps AS dopes, a.numps AS numes, " + ;
                         "b.cmats AS cpros, b.qtds, 'S' AS opers, c.cgrus " + ;
                         "FROM SigCdNec a, SigCdNei b, SigCdPro c " + ;
                         "WHERE a.emps = '" + ALLTRIM(loc_cEmpEst) + "' " + ;
                         "AND a.dopps = '" + loc_cDopps + "' " + ;
                         "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                         "AND b.emps = a.emps AND b.dopps = a.dopps AND b.numps = a.numps " + ;
                         "AND c.cpros = b.cmats " + ;
                         "ORDER BY a.emps, a.dopps, a.numps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpEnc")
            IF loc_nResult < 1
                MsgAviso("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Selecionar producao - entradas por fundicao
            loc_cDopps = PADR('FUNDI' + CHR(199) + CHR(195) + 'O', 20)
            IF USED("TmpFun")
                USE IN TmpFun
            ENDIF
            loc_cQuery = "SELECT a.emps, a.dopps AS dopes, a.numps AS numes, " + ;
                         "b.cmats AS cpros, b.qtds, 'E' AS opers, c.cgrus " + ;
                         "FROM SigCdNec a, SigCdNei b, SigCdPro c " + ;
                         "WHERE a.emps = '" + ALLTRIM(loc_cEmpEst) + "' " + ;
                         "AND a.dopps = '" + loc_cDopps + "' " + ;
                         "AND a.datas BETWEEN ?loc_tDtIni AND ?loc_tDtFin " + ;
                         "AND b.emps = a.emps AND b.dopps = a.dopps AND b.numps = a.numps " + ;
                         "AND c.cpros = b.cmats " + ;
                         "ORDER BY a.emps, a.dopps, a.numps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpFun")
            IF loc_nResult < 1
                MsgAviso("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Unir saidas de encerramento e fundicao
            SELECT emps, dopes, numes, cpros, qtds, opers, cgrus FROM TmpEnc ;
            UNION ALL ;
            SELECT emps, dopes, numes, cpros, qtds, opers, cgrus FROM TmpFun ;
            INTO CURSOR TmpPdS READWRITE

            *-- Adicionar saidas ao CsPrd (apenas produtos de categoria estoque)
            SELECT TmpPdS
            GO TOP
            SCAN
                IF SEEK(TmpPdS.cgrus, "cursor_4c_SigCdGrp", "cgrus")
                    IF cursor_4c_SigCdGrp.cestoqs <> 1
                        LOOP
                    ENDIF
                    SCATTER MEMVAR
                    m.ggrupo = cursor_4c_SigCdGrp.mercs
                    INSERT INTO CsPrd FROM MEMVAR
                ENDIF
            ENDSCAN
            WAIT CLEAR

            *-- Agregar producao por Emps+GGrupo+Dopes+Numes
            WAIT WINDOW "Aguarde! Analisando Produ" + CHR(231) + CHR(227) + "o..." NOWAIT

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds, 0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds, 0)) AS Saidas ;
            FROM CsPrd ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            ORDER BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR csProducao READWRITE

            SELECT Emps, GGrupo, Dopes, Numes, ;
                   SUM(IIF(Opers = 'E', Qtds, 0)) AS Entradas, ;
                   SUM(IIF(Opers = 'S', Qtds, 0)) AS Saidas ;
            FROM CsPrd ;
            WHERE !EMPTY(GGrupo) ;
            GROUP BY Emps, GGrupo, Dopes, Numes ;
            ORDER BY Emps, GGrupo, Dopes, Numes ;
            INTO CURSOR CsPrds READWRITE

            SELECT Emps, GGrupo, Dopes, SUM(Entradas) AS Entradas, SUM(Saidas) AS Saidas ;
            FROM CsPrds ;
            GROUP BY Emps, GGrupo, Dopes ;
            ORDER BY Emps, GGrupo, Dopes ;
            INTO CURSOR csTotPrd READWRITE
            WAIT CLEAR

            *-- Combinar movimentos + producao + historico para calculo de saldos
            SELECT emps, ggrupo, dopes, entradas AS entmov, saidas AS saimov, ;
                   0 AS enthis, 0 AS saihis, PesoEs, PesoSs ;
            FROM csTotMov ;
            UNION ALL ;
            SELECT emps, ggrupo, dopes, entradas AS entmov, saidas AS saimov, ;
                   0 AS enthis, 0 AS saihis, 0 AS PesoEs, 0 AS PesoSs ;
            FROM csTotPrd ;
            UNION ALL ;
            SELECT emps, ggrupo, dopes, 0 AS entmov, 0 AS saimov, ;
                   entradas AS enthis, saidas AS saihis, 0 AS PesoEs, 0 AS PesoSs ;
            FROM csTotHis ;
            INTO CURSOR TmpMovHis READWRITE

            SELECT Emps, GGrupo, Dopes, ;
                   SUM(EntMov) AS EntMov, SUM(SaiMov) AS SaiMov, ;
                   SUM(EntHis) AS EntHis, SUM(SaiHis) AS SaiHis, ;
                   SUM(PesoEs) AS PesoEs, SUM(PesoSs) AS PesoSs ;
            FROM TmpMovHis ;
            GROUP BY Emps, GGrupo, Dopes ;
            INTO CURSOR CsMovHis READWRITE

            SELECT CsMovHis
            INDEX ON GGrupo TAG GGrupo
            GO TOP

            *-- Preencher CsRel: saldos acumulados por GGrupo + Dopes
            SELECT csSaldoIni
            GO TOP
            SCAN
                loc_lFirst   = .T.
                m.sldini     = 0
                m.entmov     = 0
                m.saimov     = 0
                m.enthis     = 0
                m.saihis     = 0
                m.salmov     = 0
                m.salhis     = 0
                m.sldfin     = 0
                m.difs       = 0
                m.PesoEs     = 0
                m.PesoSs     = 0

                =SEEK(csSaldoIni.GGrupo, "csSaldoFin", "ggrupo")
                m.emps       = csSaldoIni.emps
                m.ggrupo     = csSaldoIni.ggrupo
                loc_lnSldIni = csSaldoIni.saldo
                loc_lnSldFin = csSaldoFin.saldo
                m.salmov     = loc_lnSldIni
                m.salhis     = loc_lnSldIni

                SELECT CsMovHis
                GO TOP
                IF SEEK(csSaldoIni.ggrupo, "CsMovHis", "ggrupo")
                    DO WHILE !EOF() AND CsMovHis.ggrupo = csSaldoIni.ggrupo
                        m.dopes  = CsMovHis.dopes
                        m.entmov = CsMovHis.entmov
                        m.saimov = CsMovHis.saimov
                        m.enthis = CsMovHis.enthis
                        m.saihis = CsMovHis.saihis
                        m.PesoEs = CsMovHis.PesoEs
                        m.PesoSs = CsMovHis.PesoSs
                        m.sldini = 0
                        m.salmov = m.salmov + (m.entmov - m.saimov)
                        m.salhis = m.salhis + (m.enthis - m.saihis)
                        m.sldfin = 0
                        IF loc_lFirst
                            m.sldini   = loc_lnSldIni
                            loc_lFirst = .F.
                        ENDIF
                        INSERT INTO CsRel FROM MEMVAR
                        SELECT CsMovHis
                        SKIP
                    ENDDO
                    SELECT CsRel
                    REPLACE CsRel.sldfin WITH loc_lnSldFin, ;
                            CsRel.difs   WITH CsRel.salmov - loc_lnSldFin
                ENDIF
                SELECT csSaldoIni
            ENDSCAN

            *-- Construir cursor de movimentos+producao detalhado
            SELECT emps, ggrupo, dopes, numes, Entradas, Saidas, PesoEs, PesoSs ;
            FROM csMovimento ;
            UNION ALL ;
            SELECT emps, ggrupo, dopes, numes, Entradas, Saidas, ;
                   0 AS PesoEs, 0 AS PesoSs ;
            FROM csProducao ;
            INTO CURSOR CsMovPrd READWRITE

            SELECT Emps, Dopes, Numes, GGrupo, ;
                   SUM(Entradas) AS Entradas, SUM(Saidas) AS Saidas, ;
                   SUM(PesoEs) AS PesoEs, SUM(PesoSs) AS PesoSs ;
            FROM CsMovPrd ;
            GROUP BY Emps, Dopes, Numes, GGrupo ;
            INTO CURSOR CsMoviProd READWRITE

            *-- Construir cursor de divergencias (comparacao movimentos vs historico)
            SELECT a.emps, a.dopes, a.numes, a.GGrupo, ;
                   a.entradas AS entmov, a.saidas AS saimov, ;
                   b.entradas AS enthis, b.saidas AS saihis, ;
                   a.PesoEs, a.PesoSs ;
            FROM CsMoviProd a, csHistorico b ;
            WHERE a.emps + a.dopes + STR(a.numes, 6) + a.GGrupo = ;
                  b.emps + b.dopes + STR(b.numes, 6) + b.GGrupo ;
            AND (a.entradas <> b.entradas OR a.saidas <> b.saidas) ;
            UNION ALL ;
            SELECT a.emps, a.dopes, a.numes, a.GGrupo, ;
                   a.entradas AS entmov, a.saidas AS saimov, ;
                   0 AS enthis, 0 AS saihis, ;
                   0 AS PesoEs, 0 AS PesoSs ;
            FROM CsMoviProd a ;
            WHERE a.emps + a.dopes + STR(a.numes, 6) + a.GGrupo NOT IN ;
                  (SELECT b.emps + b.dopes + STR(b.numes, 6) + b.GGrupo ;
                   FROM csHistorico b) ;
            UNION ALL ;
            SELECT a.emps, a.dopes, a.numes, a.GGrupo, ;
                   0 AS entmov, 0 AS saimov, ;
                   a.entradas AS enthis, a.saidas AS saihis, ;
                   0 AS PesoEs, 0 AS PesoSs ;
            FROM csHistorico a ;
            WHERE a.emps + a.dopes + STR(a.numes, 6) + a.GGrupo NOT IN ;
                  (SELECT b.emps + b.dopes + STR(b.numes, 6) + b.GGrupo ;
                   FROM CsMoviProd b) ;
            INTO CURSOR CsDif READWRITE

            SELECT CsDif
            GO TOP

            SELECT CsRel
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "ProcessarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + "SigReAe1") PREVIEW NOCONSOLE
            IF USED("CsDiferenca")
                SELECT CsDiferenca
                GO TOP
                IF !EOF()
                    IF MsgConfirma("Deseja Visualizar o Relat" + CHR(243) + "rio de " + ;
                                   "Diverg" + CHR(234) + "ncias ?")
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAe2") PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + "SigReAe1") TO PRINTER PROMPT NOCONSOLE
            IF USED("CsDiferenca")
                SELECT CsDiferenca
                GO TOP
                IF !EOF()
                    IF MsgConfirma("Deseja Imprimir o Relat" + CHR(243) + "rio de " + ;
                                   "Diverg" + CHR(234) + "ncias ?")
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAe2") TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ENDIF
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Retorna identificador composto dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "EMP=" + ALLTRIM(THIS.this_cEmpresa) + ;
               ";GRE=" + ALLTRIM(THIS.this_cCdGrEstoque) + ;
               ";EST=" + ALLTRIM(THIS.this_cCdEstoque) + ;
               ";GGP=" + ALLTRIM(THIS.this_cCdGGrupo) + ;
               ";DTI=" + DTOC(THIS.this_dDtInicial) + ;
               ";DTF=" + DTOC(THIS.this_dDtFinal)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao
    * par_cAliasCursor: cursor com colunas no formato preset
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + ;
                                          CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SCATTER MEMVAR

            IF TYPE("m.cEmpresa") = "C"
                THIS.this_cEmpresa = ALLTRIM(m.cEmpresa)
            ENDIF
            IF TYPE("m.cDesEmpresa") = "C"
                THIS.this_cDesEmpresa = ALLTRIM(m.cDesEmpresa)
            ENDIF
            IF TYPE("m.cCdGrEstoque") = "C"
                THIS.this_cCdGrEstoque = ALLTRIM(m.cCdGrEstoque)
            ENDIF
            IF TYPE("m.cDsGrEstoque") = "C"
                THIS.this_cDsGrEstoque = ALLTRIM(m.cDsGrEstoque)
            ENDIF
            IF TYPE("m.cCdEstoque") = "C"
                THIS.this_cCdEstoque = ALLTRIM(m.cCdEstoque)
            ENDIF
            IF TYPE("m.cDsEstoque") = "C"
                THIS.this_cDsEstoque = ALLTRIM(m.cDsEstoque)
            ENDIF
            IF TYPE("m.cCdGGrupo") = "C"
                THIS.this_cCdGGrupo = ALLTRIM(m.cCdGGrupo)
            ENDIF
            IF TYPE("m.cDsGGrupo") = "C"
                THIS.this_cDsGGrupo = ALLTRIM(m.cDsGGrupo)
            ENDIF
            IF TYPE("m.dDtInicial") = "D"
                THIS.this_dDtInicial = m.dDtInicial
            ENDIF
            IF TYPE("m.dDtFinal") = "D"
                THIS.this_dDtFinal = m.dDtFinal
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          "obrigat" + CHR(243) + "rio para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Data final deve ser maior ou igual " + ;
                                          CHR(224) + " data inicial"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          "obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Data final deve ser maior ou igual " + ;
                                          CHR(224) + " data inicial"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReAeg") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

