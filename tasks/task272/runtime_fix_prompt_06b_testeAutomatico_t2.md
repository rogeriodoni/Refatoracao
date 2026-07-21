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
[2026-07-15 13:07:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 13:07:46] [INFO] Config FPW: (nao fornecido)
[2026-07-15 13:07:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 13:07:46] [INFO] Timeout: 300 segundos
[2026-07-15 13:07:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ypdkbvk.prg
[2026-07-15 13:07:46] [INFO] Conteudo do wrapper:
[2026-07-15 13:07:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrCtc', 'C:\4c\tasks\task272', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCtc', 'C:\4c\tasks\task272', 'CRUD'
QUIT

[2026-07-15 13:07:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ypdkbvk.prg
[2026-07-15 13:07:46] [INFO] VFP output esperado em: C:\4c\tasks\task272\vfp_output.txt
[2026-07-15 13:07:46] [INFO] Executando Visual FoxPro 9...
[2026-07-15 13:07:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ypdkbvk.prg
[2026-07-15 13:07:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ypdkbvk.prg
[2026-07-15 13:07:46] [INFO] Timeout configurado: 300 segundos
[2026-07-15 13:08:06] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 13:08:06] [INFO] VFP9 finalizado em 20.0108933 segundos
[2026-07-15 13:08:06] [INFO] Exit Code: 
[2026-07-15 13:08:06] [INFO] 
[2026-07-15 13:08:06] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 13:08:06] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2ypdkbvk.prg
[2026-07-15 13:08:06] [INFO] 
[2026-07-15 13:08:06] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 13:08:06] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 13:08:06] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 13:08:06] [INFO] * Parameters: 'FormSigPrCtc', 'C:\4c\tasks\task272', 'CRUD'
[2026-07-15 13:08:06] [INFO] 
[2026-07-15 13:08:06] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 13:08:06] [INFO] SET SAFETY OFF
[2026-07-15 13:08:06] [INFO] SET RESOURCE OFF
[2026-07-15 13:08:06] [INFO] SET TALK OFF
[2026-07-15 13:08:06] [INFO] SET NOTIFY OFF
[2026-07-15 13:08:06] [INFO] SYS(2335, 0)
[2026-07-15 13:08:06] [INFO] 
[2026-07-15 13:08:06] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCtc', 'C:\4c\tasks\task272', 'CRUD'
[2026-07-15 13:08:06] [INFO] QUIT
[2026-07-15 13:08:06] [INFO] 
[2026-07-15 13:08:06] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 13:08:06] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 13:12:14] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 13:12:14] [INFO] Config FPW: (nao fornecido)
[2026-07-15 13:12:14] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 13:12:14] [INFO] Timeout: 300 segundos
[2026-07-15 13:12:14] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q5fmsxta.prg
[2026-07-15 13:12:14] [INFO] Conteudo do wrapper:
[2026-07-15 13:12:14] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrCtc', 'C:\4c\tasks\task272', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCtc', 'C:\4c\tasks\task272', 'CRUD'
QUIT

[2026-07-15 13:12:14] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q5fmsxta.prg
[2026-07-15 13:12:14] [INFO] VFP output esperado em: C:\4c\tasks\task272\vfp_output.txt
[2026-07-15 13:12:14] [INFO] Executando Visual FoxPro 9...
[2026-07-15 13:12:14] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q5fmsxta.prg
[2026-07-15 13:12:14] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q5fmsxta.prg
[2026-07-15 13:12:14] [INFO] Timeout configurado: 300 segundos
[2026-07-15 13:12:38] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 13:12:38] [INFO] VFP9 finalizado em 23.4486249 segundos
[2026-07-15 13:12:38] [INFO] Exit Code: 
[2026-07-15 13:12:38] [INFO] 
[2026-07-15 13:12:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 13:12:38] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q5fmsxta.prg
[2026-07-15 13:12:38] [INFO] 
[2026-07-15 13:12:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 13:12:38] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 13:12:38] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 13:12:38] [INFO] * Parameters: 'FormSigPrCtc', 'C:\4c\tasks\task272', 'CRUD'
[2026-07-15 13:12:38] [INFO] 
[2026-07-15 13:12:38] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 13:12:38] [INFO] SET SAFETY OFF
[2026-07-15 13:12:38] [INFO] SET RESOURCE OFF
[2026-07-15 13:12:38] [INFO] SET TALK OFF
[2026-07-15 13:12:38] [INFO] SET NOTIFY OFF
[2026-07-15 13:12:38] [INFO] SYS(2335, 0)
[2026-07-15 13:12:38] [INFO] 
[2026-07-15 13:12:38] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCtc', 'C:\4c\tasks\task272', 'CRUD'
[2026-07-15 13:12:38] [INFO] QUIT
[2026-07-15 13:12:38] [INFO] 
[2026-07-15 13:12:38] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 13:12:38] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrCtc",
  "timestamp": "20260715131238",
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (CMOESLOOKUPKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtc.prg):
*==============================================================================
* FormSigPrCtc.prg - Formulario de Cotacoes por Operacoes
* Origem legada: SIGPRCTC.SCX (dialogo modal chamado por SIGPRCPR/SIGPRCIC)
* Migrado como CRUD-style com PageFrame (Page1=Lista, Page2=Dados)
* Herda de: FormBase
* Fase 7/8: Form completo - estrutura, grid, campos, lookups e eventos CRUD
*==============================================================================

DEFINE CLASS FormSigPrCtc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cota" + CHR(231) + CHR(245) + "es por Opera" + CHR(231) + CHR(245) + "es"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)
    DataSession = 2
    KeyPreview  = .T.

    *-- Propriedades internas do form
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"     && LISTA / INCLUIR / ALTERAR / VISUALIZAR
    this_cMensagemErro   = ""

    *-- Parametros recebidos do form pai (fluxo modal legado)
    this_oParentForm     = .NULL.
    this_cEmpDopNums     = ""          && pcEmps + pcDopes + STR(pnNumes,6)
    this_cEscolha        = ""          && permissoes: INSERIR / ALTERAR / EXCLUIR
    this_lHouveInsercao  = .F.
    this_lHouveExclusao  = .F.

    *--------------------------------------------------------------------------
    * Init - Apenas delega para FormBase (que chama InicializarForm)
    * Parametros opcionais para chamada modal a partir de outros forms:
    *   par_oParentForm : referencia ao form chamador (sera desabilitado)
    *   par_cEscolha    : permissoes de INSERIR/ALTERAR/EXCLUIR
    *   par_cEmps       : codigo da empresa
    *   par_cDopes      : codigo da operacao (tipo)
    *   par_nNumes      : numero da operacao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_cEscolha, par_cEmps, par_cDopes, par_nNumes

        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
                par_oParentForm.Enabled = .F.
            ENDIF

            IF VARTYPE(par_cEscolha) = "C"
                THIS.this_cEscolha = ALLTRIM(par_cEscolha)
            ENDIF

            IF VARTYPE(par_cEmps) = "C" AND VARTYPE(par_cDopes) = "C" AND VARTYPE(par_nNumes) = "N"
                THIS.this_cEmpDopNums = ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)
                THIS.Caption = "Cota" + CHR(231) + CHR(245) + "es " + ;
                               ALLTRIM(PROPER(THIS.this_cEmpDopNums))
            ENDIF

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtc.Init:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e monta estrutura visual completa
    * Chamado por FormBase.Init() via DODEFAULT()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtcBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrCtcBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ControlarBotoesPorEscolha()

                *-- Carrega dados na grade (requer this_cEmpDopNums setado em Init)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                *-- Propaga Caption para labels do cabecalho (fase 4 cria os labels)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                SET DATE TO BRITISH
                SET CENTURY ON

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 631
            .Tabs      = .F.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria containers vazios da Page1 (Lista)
    * cnt_4c_Cabecalho: barra cinza superior com titulo
    * cnt_4c_Botoes   : container de botoes CRUD (populado na Fase 4)
    * cnt_4c_Saida    : container flutuante do botao Encerrar
    * Grid e botoes CRUD sao adicionados na Fase 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container do cabecalho (cntSombra: Top=2+29, W=THIS.Width, H=80)
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
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0+29)
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

        *-- Container de saida canonico (cnt_4c_Saida)
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

        *-- Botao Encerrar no container cnt_4c_Saida (canonico)
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

        *-- Botoes CRUD em cnt_4c_Botoes
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

        *-- Grid grd_4c_Dados (GradeSubN legado: Top=110, Left=85, Width=379 em form 550px)
        *-- Adaptado para form 1000px: Top=117 (+29 compensacao PageFrame), Left=12, Width=890
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        loc_oGrid.Top                = 117
        loc_oGrid.Left               = 12
        loc_oGrid.Width              = 890
        loc_oGrid.Height             = 498
        loc_oGrid.ColumnCount        = 3
        loc_oGrid.GridLines          = 3
        loc_oGrid.FontName           = "Verdana"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(90, 90, 90)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.Visible            = .T.

        WITH loc_oGrid.Column1
            .Width           = 100
            .Header1.Caption = "Moeda"
        ENDWITH

        WITH loc_oGrid.Column2
            .Width           = 550
            .ReadOnly        = .T.
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        WITH loc_oGrid.Column3
            .Width           = 200
            .ReadOnly        = .T.
            .Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
        ENDWITH

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria containers vazios da Page2 (Dados)
    * cnt_4c_Cabecalho: barra cinza superior com titulo
    * cnt_4c_BotoesAcao: container de botoes Confirmar/Cancelar (Fase 4)
    * TextBoxes/grid de detalhe sao adicionados nas Fases 5-6
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container do cabecalho da Page2 (mesmo layout da Page1)
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
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes de acao (Confirmar/Cancelar)
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

        *-- Primeiros 50% dos campos: Moeda (cmoes) e Descricao (Descrs)

        *-- Campo Moeda
        loc_oPagina.AddObject("lbl_4c_LblMoeda", "Label")
        WITH loc_oPagina.lbl_4c_LblMoeda
            .AutoSize  = .F.
            .Caption   = "Moeda :"
            .Top       = 133
            .Left      = 40
            .Width     = 100
            .Height    = 17
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cmoes", "TextBox")
        WITH loc_oPagina.txt_4c_Cmoes
            .Value     = ""
            .Top       = 130
            .Left      = 150
            .Width     = 120
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- Campo Descricao (read-only, preenchido automaticamente pelo lookup de moeda)
        loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
        WITH loc_oPagina.lbl_4c_LblDescrs
            .AutoSize  = .F.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 168
            .Left      = 40
            .Width     = 100
            .Height    = 17
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value     = ""
            .Top       = 165
            .Left      = 150
            .Width     = 400
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Campo Cotacao (valos - numerico 11,6 - equivalente Column3 do grid original)
        loc_oPagina.AddObject("lbl_4c_LblValos", "Label")
        WITH loc_oPagina.lbl_4c_LblValos
            .AutoSize  = .F.
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .Top       = 203
            .Left      = 40
            .Width     = 100
            .Height    = 17
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valos", "TextBox")
        WITH loc_oPagina.txt_4c_Valos
            .Value     = 0
            .Top       = 200
            .Left      = 150
            .Width     = 200
            .Height    = 23
            .InputMask = "99999.9999999"
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT: lookup de moeda em txt_4c_Cmoes (F4, DblClick, LostFocus)
        BINDEVENT(loc_oPagina.txt_4c_Cmoes, "KeyPress",  THIS, "CmoesLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Cmoes, "DblClick",  THIS, "CmoesLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Cmoes, "KeyPress", THIS, "CmoesLostFocus")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos, cursores locais e re-habilita o form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
            IF USED("cursor_4c_Totais")
                USE IN cursor_4c_Totais
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
                THIS.this_oParentForm = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Destroy:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
                        TRANSFORM(par_nPagina), "Erro")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega cursor local e configura grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF EMPTY(THIS.this_cEmpDopNums)
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.CarregarParaEdicao(THIS.this_cEmpDopNums)
                loc_lResultado = .T.
                ENDIF
                ENDIF
            ENDIF

            IF loc_lResultado AND USED("cursor_4c_Dados")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 3

                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.cmoes"
                    .Column1.Width           = 100
                    .Column1.Header1.Caption = "Moeda"

                    .Column2.ControlSource   = "cursor_4c_Dados.Descrs"
                    .Column2.Width           = 550
                    .Column2.ReadOnly        = .T.
                    .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    .Column3.ControlSource   = "cursor_4c_Dados.valos"
                    .Column3.Width           = 200
                    .Column3.ReadOnly        = .T.
                    .Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                THIS.AjustarBotoesPorModo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * FormatarGridLista - Formata visual do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * Handlers dos botoes CRUD (PUBLIC para BINDEVENT funcionar)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Insere nova linha vazia no cursor local
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_oBusinessObject.InserirLinhaLocal(THIS.this_cEmpDopNums)
                SELECT cursor_4c_Dados
                GO BOTTOM
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.LimparCampos()
                THIS.HabilitarCampos(.T.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnIncluirClick")
        ENDTRY

        IF loc_lSucesso
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Navega para Page2 exibindo dados da linha selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
           !DELETED("cursor_4c_Dados")
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Nenhum registro selecionado para visualizar.", "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Posiciona foco no grid para edicao inline
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
           !DELETED("cursor_4c_Dados")
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Nenhum registro selecionado para alterar.", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui linha corrente do cursor local
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado para excluir.", "Excluir")
            ELSE
                IF MsgConfirma("Deseja excluir a cota" + CHR(231) + CHR(227) + ;
                               "o selecionada?", ;
                               "Confirmar Exclus" + CHR(227) + "o")
                IF THIS.this_oBusinessObject.ExcluirLinhaLocal()
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre picker de moeda e posiciona no grid
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCmoes
        loc_cCmoes = ""

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdMoe", "cursor_4c_BuscaMoeda", ;
                            "cmoes", "", "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_cCmoes = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnBuscarClick")
        ENDTRY

        IF !EMPTY(loc_cCmoes) AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(UPPER(cmoes)) == UPPER(loc_cCmoes) AND !DELETED()
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Valida, salva cotacoes e fecha o formulario
    * Equivalente ao cmdSair.Click do legado (SIGPRCTC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lPodeSair, loc_lHouveAlteracao
        loc_lPodeSair       = .F.
        loc_lHouveAlteracao = THIS.this_oBusinessObject.this_lHouveInsercao OR ;
                              THIS.this_oBusinessObject.this_lHouveExclusao

        TRY
            IF loc_lHouveAlteracao
                IF THIS.this_oBusinessObject.SalvarCotacoes(THIS.this_cEmpDopNums)
                    THIS.this_lHouveInsercao = THIS.this_oBusinessObject.this_lHouveInsercao
                    THIS.this_lHouveExclusao = THIS.this_oBusinessObject.this_lHouveExclusao
                    loc_lPodeSair = .T.
                ENDIF
            ELSE
                loc_lPodeSair = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnEncerrarClick")
        ENDTRY

        IF loc_lPodeSair
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Valida moeda ao sair da Coluna 1
    * par_nColIndex: coluna ANTERIOR (ativa antes da mudanca de coluna)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_cCmoes
        loc_cCmoes = ""

        TRY
            IF par_nColIndex = 1 AND USED("cursor_4c_Dados") AND ;
               !EOF("cursor_4c_Dados") AND !DELETED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCmoes = ALLTRIM(cmoes)
                IF EMPTY(loc_cCmoes)
                    REPLACE Descrs WITH SPACE(15)
                ELSE
                    THIS.AbrirBuscaMoeda(loc_cCmoes)
                ENDIF
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Valida codigo ou abre picker para selecao de moeda
    * Equivalente ao Valid do Column1.Text1 do legado (fwbuscaext -> SigCdMoe)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cValor)
        LOCAL loc_oBusca, loc_cCmoes, loc_cDescrs
        loc_cCmoes  = ""
        loc_cDescrs = ""

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdMoe", "cursor_4c_BuscaMoeda", ;
                            "cmoes", ALLTRIM(par_cValor), "Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaMoeda")
                        SELECT cursor_4c_BuscaMoeda
                        loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                        loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                        SELECT cursor_4c_BuscaMoeda
                        loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                        loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaMoeda")
        ENDTRY

        IF !EMPTY(loc_cCmoes) AND USED("cursor_4c_Dados") AND ;
           !EOF("cursor_4c_Dados") AND !DELETED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            REPLACE cmoes  WITH PADR(loc_cCmoes,  3)
            REPLACE Descrs WITH PADR(loc_cDescrs, 15)
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Persiste campos da Page2 no cursor local e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cCmoes, loc_nValos, loc_oPg2
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes = ""
        loc_nValos = 0

        *-- Em modo visualizar, apenas volta para lista (botao vira "Fechar")
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
            loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
            loc_nValos = loc_oPg2.txt_4c_Valos.Value
        ENDIF

        IF EMPTY(loc_cCmoes)
            MsgAviso("C" + CHR(243) + "digo da moeda obrigat" + CHR(243) + "rio.", "Salvar")
        ELSE
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
               !DELETED("cursor_4c_Dados")
            THIS.FormParaBO()
            THIS.this_oBusinessObject.this_lHouveInsercao = .T.
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista sem salvar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega linha corrente do cursor local nos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cCmoes, loc_cDescrs, loc_nValos
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes  = ""
        loc_cDescrs = ""
        loc_nValos  = 0

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
               !DELETED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCmoes  = ALLTRIM(NVL(cmoes,  ""))
                loc_cDescrs = ALLTRIM(NVL(Descrs, ""))
                loc_nValos  = NVL(valos, 0)
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_oPg2.txt_4c_Cmoes.Value = loc_cCmoes
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                loc_oPg2.txt_4c_Descrs.Value = loc_cDescrs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
                loc_oPg2.txt_4c_Valos.Value = loc_nValos
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere campos editados da Page2 de volta para cursor local
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_cCmoes, loc_nValos
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes = ""
        loc_nValos = 0

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
                loc_nValos = loc_oPg2.txt_4c_Valos.Value
            ENDIF

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
               !DELETED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                REPLACE cmoes WITH PADR(loc_cCmoes, 3), valos WITH loc_nValos
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmoesLookupKeyPress - Handler de KeyPress do txt_4c_Cmoes (Page2)
    * Abre picker de moeda ao pressionar F4 (keycode 28)
    *--------------------------------------------------------------------------
    PROCEDURE CmoesLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirBuscaMoedaPage2()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmoesLookupDblClick - Handler de DblClick do txt_4c_Cmoes (Page2)
    *--------------------------------------------------------------------------
    PROCEDURE CmoesLookupDblClick()
        THIS.AbrirBuscaMoedaPage2()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmoesLostFocus - Handler de LostFocus do txt_4c_Cmoes (Page2)
    * Valida o codigo digitado e atualiza descricao; se vazio, limpa descricao
    *--------------------------------------------------------------------------
    PROCEDURE CmoesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCmoes
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
            ENDIF

            IF EMPTY(loc_cCmoes)
                IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                    loc_oPg2.txt_4c_Descrs.Value = ""
                ENDIF
            ELSE
                THIS.AbrirBuscaMoedaPage2()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CmoesLostFocus:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoedaPage2 - Valida/busca moeda e preenche campos na Page2
    * Equivalente ao Valid de GradeSubN.Column1.Text1 do SIGPRCTC original
    * adaptado para uso em Page2 (fora do grid)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoedaPage2()
        LOCAL loc_oPg2, loc_cCmoes, loc_oBusca, loc_cDescrs, loc_lExecutar
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_cCmoes    = ""
        loc_cDescrs   = ""
        loc_lExecutar = .F.

        IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
            loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
        ENDIF

        IF !EMPTY(loc_cCmoes)
            loc_lExecutar = .T.
        ENDIF

        IF loc_lExecutar
            TRY
                IF USED("cursor_4c_BuscaMoeda")
                    USE IN cursor_4c_BuscaMoeda
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                "SigCdMoe", "cursor_4c_BuscaMoeda", ;
                                "cmoes", loc_cCmoes, "Moeda")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                        IF USED("cursor_4c_BuscaMoeda")
                            SELECT cursor_4c_BuscaMoeda
                            loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                            loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                            SELECT cursor_4c_BuscaMoeda
                            loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                            loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                        ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro em AbrirBuscaMoedaPage2:" + CHR(13) + loc_oErro.Message + ;
                        " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
            ENDTRY

            IF !EMPTY(loc_cCmoes) AND PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_oPg2.txt_4c_Cmoes.Value = loc_cCmoes
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                loc_oPg2.txt_4c_Descrs.Value = loc_cDescrs
            ENDIF

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_oPg2.txt_4c_Cmoes.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                loc_oPg2.txt_4c_Descrs.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
                loc_oPg2.txt_4c_Valos.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    * par_lHabilitar: .T. = editar (INCLUIR/ALTERAR), .F. = somente leitura (VISUALIZAR)
    * Em VISUALIZAR: muda botao Confirmar para "Fechar" com icone de saida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
                loc_oPg2.txt_4c_Cmoes.Enabled   = par_lHabilitar
                loc_oPg2.txt_4c_Cmoes.BackColor = IIF(par_lHabilitar, ;
                                                       RGB(255,255,255), RGB(240,240,240))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
                loc_oPg2.txt_4c_Valos.Enabled   = par_lHabilitar
                loc_oPg2.txt_4c_Valos.BackColor = IIF(par_lHabilitar, ;
                                                       RGB(255,255,255), RGB(240,240,240))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    IF par_lHabilitar
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Confirmar"
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Picture = ;
                            gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    ELSE
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Fechar"
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Picture = ;
                            gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme estado do cursor
    * Chamado apos CarregarLista() para refletir se ha registros selecionaveis
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lTemRegistro, loc_lPodeInserir, loc_lPodeExcluir
        loc_oPg1         = THIS.pgf_4c_Paginas.Page1
        loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
                           RECCOUNT("cursor_4c_Dados") > 0
        loc_lPodeInserir = .T.
        loc_lPodeExcluir = .T.

        TRY
            IF !EMPTY(THIS.this_cEscolha)
                loc_lPodeInserir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
                loc_lPodeExcluir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
            ENDIF

            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = loc_lPodeInserir
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro AND loc_lPodeExcluir
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ControlarBotoesPorEscolha - Exibe/oculta Incluir e Excluir conforme pcEscolha
    * Equivalente ao mCtrlBotoes + fChecaAcesso do SIGPRCTC original:
    * Se pcEscolha = 'INSERIR' ou 'ALTERAR': mostra Incluir e Excluir
    * Se pcEscolha = 'EXCLUIR' ou outro: oculta ambos
    * Se pcEscolha = '' (nao fornecido): mostra ambos (modo standalone)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ControlarBotoesPorEscolha()
        LOCAL loc_oPg1, loc_lPodeInserir, loc_lPodeExcluir
        loc_oPg1         = THIS.pgf_4c_Paginas.Page1
        loc_lPodeInserir = .T.
        loc_lPodeExcluir = .T.

        TRY
            IF !EMPTY(THIS.this_cEscolha)
                loc_lPodeInserir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), ;
                                          "INSERIR", "ALTERAR")
                loc_lPodeExcluir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), ;
                                          "INSERIR", "ALTERAR")
            ENDIF

            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Visible = loc_lPodeInserir
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = loc_lPodeInserir
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Visible = loc_lPodeExcluir
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lPodeExcluir
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ControlarBotoesPorEscolha:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCtcBO.prg):
*==============================================================================
* SigPrCtcBO.prg - Business Object para Cotacoes por Operacoes
* Herda de BusinessBase
* Tabela principal: sigprctc
* PK: pkchaves (char 20)
* Fase 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS SigPrCtcBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificador composto da operacao (pcEmps + pcDopes + STR(pnNumes,6))
    * Chave de agrupamento de todas as cotacoes da operacao
    *--------------------------------------------------------------------------
    this_cEmpDopNums = ""    && empdopnums char(29) - chave da operacao

    *--------------------------------------------------------------------------
    * Campos da linha corrente de sigprctc
    *--------------------------------------------------------------------------
    this_cCmoes      = ""    && cmoes    char(3)       - codigo da moeda (FK SigCdMoe)
    this_nValos      = 0     && valos    numeric(11,6) - cotacao da moeda
    this_cPkChaves   = ""    && pkchaves char(20)      - chave primaria (PK)
    this_dDtalts     = {}    && dtalts   datetime NULL - data/hora alteracao
    this_cUsuars     = ""    && usuars   char(10)      - usuario que gravou

    *--------------------------------------------------------------------------
    * Campo auxiliar vindo do JOIN com SigCdMoe (nao persistido em sigprctc)
    *--------------------------------------------------------------------------
    this_cDescrs     = ""    && dmoes char(15) - descricao da moeda (SigCdMoe.dmoes)

    *--------------------------------------------------------------------------
    * Controle interno de estado da colecao
    *--------------------------------------------------------------------------
    this_lHouveInsercao  = .F.  && .T. se alguma linha foi inserida na sessao
    this_lHouveExclusao  = .F.  && .T. se alguma linha foi removida na sessao

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "sigprctc"
            THIS.this_cCampoChave = "pkchaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCtcBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (auditoria)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades de uma linha do cursor
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCmoes      = TratarNulo(cmoes,      "C")
                THIS.this_nValos      = TratarNulo(valos,      "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParaEdicao - Carrega cotacoes da operacao em cursor VFP local
    * par_cEmpDopNums: chave da operacao (emps+dopes+numes, 29 chars)
    * Cria cursor_4c_Dados para edicao em memoria
    *==========================================================================
    PROCEDURE CarregarParaEdicao(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ;
                (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
            SET NULL OFF

            loc_cSQL = "SELECT a.empdopnums, a.cmoes, a.valos, a.pkchaves," + ;
                       " ISNULL(b.dmoes,'') AS Descrs" + ;
                       " FROM sigprctc a" + ;
                       " LEFT JOIN SigCdMoe b ON b.cmoes = a.cmoes" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpDopNums))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtMoeTemp")

            IF loc_nResult > 0 AND USED("cursor_4c_CtMoeTemp") AND RECCOUNT("cursor_4c_CtMoeTemp") > 0
                SELECT cursor_4c_Dados
                APPEND FROM DBF("cursor_4c_CtMoeTemp")
            ENDIF

            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SELECT cursor_4c_Dados
            GO TOP

            THIS.this_lHouveInsercao = .F.
            THIS.this_lHouveExclusao = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarParaEdicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaLocal - Insere nova linha em branco no cursor local
    * par_cEmpDopNums: chave da operacao para preencher o campo de agrupamento
    *==========================================================================
    PROCEDURE InserirLinhaLocal(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                SELECT cursor_4c_Dados
                LOCATE FOR EMPTY(cmoes) AND !DELETED()
                IF EOF()
                    loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(RECCOUNT("cursor_4c_Dados") + 1), 10, "0"), 20)
                    INSERT INTO cursor_4c_Dados (empdopnums, cmoes, valos, pkchaves, Descrs) ;
                        VALUES (ALLTRIM(par_cEmpDopNums), SPACE(3), 0, loc_cPkChave, SPACE(15))
                    GO BOTTOM
                ELSE
                    GO RECNO()
                ENDIF
                THIS.this_lHouveInsercao = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro InserirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaLocal - Remove linha corrente do cursor local (marca deleted)
    *==========================================================================
    PROCEDURE ExcluirLinhaLocal()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                THIS.this_lHouveExclusao = .T.
                loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica se ha moedas duplicadas no cursor local
    * Retorna .T. se valido (sem duplicatas), .F. se ha moedas repetidas
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lValido, loc_cMoesDup
        loc_lValido  = .F.
        loc_cMoesDup = ""

        TRY
            IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF USED("cursor_4c_Totais")
                    USE IN cursor_4c_Totais
                ENDIF

                SELECT cmoes, SUM(1) AS tt FROM cursor_4c_Dados ;
                    WHERE !DELETED() AND !EMPTY(ALLTRIM(cmoes)) ;
                    GROUP BY cmoes ;
                    INTO CURSOR cursor_4c_Totais

                IF USED("cursor_4c_Totais")
                    SELECT cursor_4c_Totais
                    SCAN
                        IF tt > 1
                            IF !EMPTY(loc_cMoesDup)
                                loc_cMoesDup = loc_cMoesDup + ", "
                            ENDIF
                            loc_cMoesDup = loc_cMoesDup + ALLTRIM(cmoes)
                        ENDIF
                    ENDSCAN
                    USE IN cursor_4c_Totais
                ENDIF

                IF !EMPTY(loc_cMoesDup)
                    MsgErro("Moeda(s) digitada(s) em duplicidade: " + loc_cMoesDup, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarDuplicidade")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BuscarMoeda - Busca moeda por codigo em SigCdMoe
    * par_cCodigo: codigo da moeda (cmoes)
    * Popula cursor_4c_BuscaMoeda; retorna .T. se encontrou codigo exato
    *==========================================================================
    PROCEDURE BuscarMoeda(par_cCodigo)
        LOCAL loc_lEncontrou, loc_cSQL, loc_nResult
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes AS Descrs FROM SigCdMoe" + ;
                       " WHERE cmoes LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%") + ;
                       " ORDER BY cmoes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaMoeda") AND RECCOUNT("cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                GO TOP
                IF RECCOUNT("cursor_4c_BuscaMoeda") = 1 AND ;
                   UPPER(ALLTRIM(cursor_4c_BuscaMoeda.cmoes)) == UPPER(ALLTRIM(par_cCodigo))
                    THIS.this_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    THIS.this_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.Descrs)
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BuscarMoeda")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *==========================================================================
    * AtualizarDescricaoMoeda - Atualiza campo Descrs na linha corrente do cursor local
    *==========================================================================
    PROCEDURE AtualizarDescricaoMoeda(par_cDescrs)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                REPLACE Descrs WITH PADR(ALLTRIM(par_cDescrs), 15)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AtualizarDescricaoMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarCotacoes - Persiste cotacoes no SQL Server (DELETE all + INSERT validas)
    * par_cEmpDopNums: chave da operacao
    * Logica: deleta todos da operacao, re-insere linhas validas do cursor local
    *==========================================================================
    PROCEDURE SalvarCotacoes(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_nLinha, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDuplicidade()
                *-- mensagem ja exibida por ValidarDuplicidade
            ELSE
                IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                *-- Passo 1: Remove todos os registros da operacao no SQL Server
                loc_cSQL = "DELETE FROM sigprctc WHERE empdopnums = " + ;
                           EscaparSQL(ALLTRIM(par_cEmpDopNums))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir cota" + CHR(231) + CHR(245) + "es anteriores:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Passo 2: Re-insere todas as linhas validas do cursor local
                    SELECT cursor_4c_Dados
                    GO TOP
                    loc_lSucesso = .T.
                    loc_nLinha   = 0

                    SCAN WHILE loc_lSucesso
                        IF DELETED()
                            LOOP
                        ENDIF
                        IF EMPTY(ALLTRIM(cmoes))
                            LOOP
                        ENDIF

                        loc_nLinha   = loc_nLinha + 1
                        loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(loc_nLinha), 10, "0"), 20)

                        loc_cSQL = "INSERT INTO sigprctc (empdopnums, cmoes, valos, pkchaves, dtalts, usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cEmpDopNums)) + "," + ;
                                   EscaparSQL(ALLTRIM(cmoes)) + "," + ;
                                   FormatarNumeroSQL(valos) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "GETDATE()," + ;
                                   EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ;
                                   ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o da moeda " + ;
                                    ALLTRIM(cmoes) + ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("SALVAR_COTACOES")
                    ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SalvarCotacoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

