# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-21 23:49:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 23:49:19] [INFO] Config FPW: (nao fornecido)
[2026-07-21 23:49:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 23:49:19] [INFO] Timeout: 300 segundos
[2026-07-21 23:49:19] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_m4qsnitl.prg
[2026-07-21 23:49:19] [INFO] Conteudo do wrapper:
[2026-07-21 23:49:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormBch', 'C:\4c\tasks\task350', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
QUIT

[2026-07-21 23:49:19] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_m4qsnitl.prg
[2026-07-21 23:49:19] [INFO] VFP output esperado em: C:\4c\tasks\task350\vfp_output.txt
[2026-07-21 23:49:19] [INFO] Executando Visual FoxPro 9...
[2026-07-21 23:49:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_m4qsnitl.prg
[2026-07-21 23:49:19] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_m4qsnitl.prg
[2026-07-21 23:49:19] [INFO] Timeout configurado: 300 segundos
[2026-07-21 23:49:54] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 23:49:54] [INFO] VFP9 finalizado em 35.1319975 segundos
[2026-07-21 23:49:54] [INFO] Exit Code: 
[2026-07-21 23:49:54] [INFO] 
[2026-07-21 23:49:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 23:49:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_m4qsnitl.prg
[2026-07-21 23:49:54] [INFO] 
[2026-07-21 23:49:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 23:49:54] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 23:49:54] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 23:49:54] [INFO] * Parameters: 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
[2026-07-21 23:49:54] [INFO] 
[2026-07-21 23:49:54] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 23:49:54] [INFO] SET SAFETY OFF
[2026-07-21 23:49:54] [INFO] SET RESOURCE OFF
[2026-07-21 23:49:54] [INFO] SET TALK OFF
[2026-07-21 23:49:54] [INFO] SET NOTIFY OFF
[2026-07-21 23:49:54] [INFO] SYS(2335, 0)
[2026-07-21 23:49:54] [INFO] 
[2026-07-21 23:49:54] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
[2026-07-21 23:49:54] [INFO] QUIT
[2026-07-21 23:49:54] [INFO] 
[2026-07-21 23:49:54] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 23:49:54] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-21 23:51:32] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 23:51:32] [INFO] Config FPW: (nao fornecido)
[2026-07-21 23:51:32] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 23:51:32] [INFO] Timeout: 300 segundos
[2026-07-21 23:51:32] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3wvxs2m0.prg
[2026-07-21 23:51:32] [INFO] Conteudo do wrapper:
[2026-07-21 23:51:32] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormBch', 'C:\4c\tasks\task350', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
QUIT

[2026-07-21 23:51:32] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3wvxs2m0.prg
[2026-07-21 23:51:32] [INFO] VFP output esperado em: C:\4c\tasks\task350\vfp_output.txt
[2026-07-21 23:51:32] [INFO] Executando Visual FoxPro 9...
[2026-07-21 23:51:32] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3wvxs2m0.prg
[2026-07-21 23:51:32] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3wvxs2m0.prg
[2026-07-21 23:51:32] [INFO] Timeout configurado: 300 segundos
[2026-07-21 23:52:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 23:52:12] [INFO] VFP9 finalizado em 39.9787484 segundos
[2026-07-21 23:52:12] [INFO] Exit Code: 
[2026-07-21 23:52:12] [INFO] 
[2026-07-21 23:52:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 23:52:12] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3wvxs2m0.prg
[2026-07-21 23:52:12] [INFO] 
[2026-07-21 23:52:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 23:52:12] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 23:52:12] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 23:52:12] [INFO] * Parameters: 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
[2026-07-21 23:52:12] [INFO] 
[2026-07-21 23:52:12] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 23:52:12] [INFO] SET SAFETY OFF
[2026-07-21 23:52:12] [INFO] SET RESOURCE OFF
[2026-07-21 23:52:12] [INFO] SET TALK OFF
[2026-07-21 23:52:12] [INFO] SET NOTIFY OFF
[2026-07-21 23:52:12] [INFO] SYS(2335, 0)
[2026-07-21 23:52:12] [INFO] 
[2026-07-21 23:52:12] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
[2026-07-21 23:52:12] [INFO] QUIT
[2026-07-21 23:52:12] [INFO] 
[2026-07-21 23:52:12] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 23:52:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-21 23:53:18] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 23:53:18] [INFO] Config FPW: (nao fornecido)
[2026-07-21 23:53:18] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 23:53:18] [INFO] Timeout: 300 segundos
[2026-07-21 23:53:18] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wl0ypueq.prg
[2026-07-21 23:53:18] [INFO] Conteudo do wrapper:
[2026-07-21 23:53:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormBch', 'C:\4c\tasks\task350', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
QUIT

[2026-07-21 23:53:18] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wl0ypueq.prg
[2026-07-21 23:53:18] [INFO] VFP output esperado em: C:\4c\tasks\task350\vfp_output.txt
[2026-07-21 23:53:18] [INFO] Executando Visual FoxPro 9...
[2026-07-21 23:53:18] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wl0ypueq.prg
[2026-07-21 23:53:18] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wl0ypueq.prg
[2026-07-21 23:53:18] [INFO] Timeout configurado: 300 segundos
[2026-07-21 23:53:58] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 23:53:58] [INFO] VFP9 finalizado em 40.0234804 segundos
[2026-07-21 23:53:58] [INFO] Exit Code: 
[2026-07-21 23:53:58] [INFO] 
[2026-07-21 23:53:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 23:53:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wl0ypueq.prg
[2026-07-21 23:53:58] [INFO] 
[2026-07-21 23:53:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 23:53:58] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 23:53:58] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 23:53:58] [INFO] * Parameters: 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
[2026-07-21 23:53:58] [INFO] 
[2026-07-21 23:53:58] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 23:53:58] [INFO] SET SAFETY OFF
[2026-07-21 23:53:58] [INFO] SET RESOURCE OFF
[2026-07-21 23:53:58] [INFO] SET TALK OFF
[2026-07-21 23:53:58] [INFO] SET NOTIFY OFF
[2026-07-21 23:53:58] [INFO] SYS(2335, 0)
[2026-07-21 23:53:58] [INFO] 
[2026-07-21 23:53:58] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBch', 'C:\4c\tasks\task350', 'CRUD'
[2026-07-21 23:53:58] [INFO] QUIT
[2026-07-21 23:53:58] [INFO] 
[2026-07-21 23:53:58] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 23:53:58] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormBch",
  "timestamp": "20260721235358",
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg):
*==============================================================================
* FormBch.prg - Fase 8/8: Completo - Page2, Page3 Leitura e metodos de apoio
* Formulario de Balan" + CHR(231) + "o de Cheques (SIGCDBCH)
*
* Tabela principal: SigCdBch
* Tabelas auxiliares: SigCqBal, SigCqHis
* Tipo: CRUD (frmcadastro) com 3 paginas (Lista, Dados, Leitura)
* BO: BchBO
*==============================================================================

DEFINE CLASS FormBch AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Balan" + CHR(231) + "o de Cheques"
    DataSession = 2
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado do form
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Controle de acesso (fChecaAcesso nao portado - default permite tudo)
    this_lAcLeitura = .T.
    this_lAcEncerra = .T.

    *-- Estado do leitor de cheques serial
    this_lLeitor        = .F.
    this_lIniciaLeitura = .F.
    this_cLeituraSerial = ""
    this_cTipoLeitora   = ""

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    * DataSession=2: FormBase.Init define SET DATE BRITISH + SET CENTURY ON
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura basica do form
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("BchBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar BchBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 3 paginas (Lista, Dados, Leitura)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 3
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page3.Caption   = "Leitura"
            .Page3.BackColor = RGB(100, 100, 100)
            .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarPaginaLeitura()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + Leitura/Fecha + grid
    * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 40
            .Top       = 15
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 46
            .Top       = 18
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Left=544, Top=29, Width=385)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida canonico (Left=917, Width=90, Top=29)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botao Leitura (original: top=83+29=112, left=31, width=120, height=40)
        *-- Abre pagina de leitura de cheques para o balanco selecionado
        loc_oPg1.AddObject("cmd_4c_Leitura", "CommandButton")
        WITH loc_oPg1.cmd_4c_Leitura
            .Top           = 112
            .Left          = 31
            .Width         = 120
            .Height        = 40
            .Caption       = "Leitura"
            .FontName      = "Tahoma"
            .FontBold      = .F.
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.cmd_4c_Leitura, "Click", THIS, "BtnLeituraClick")

        *-- Botao Fecha/Encerrar Balanco (original: top=83+29=112, left=152, width=120, height=40)
        loc_oPg1.AddObject("cmd_4c_Fecha", "CommandButton")
        WITH loc_oPg1.cmd_4c_Fecha
            .Top           = 112
            .Left          = 152
            .Width         = 120
            .Height        = 40
            .Caption       = "Encerrar"
            .FontName      = "Tahoma"
            .FontBold      = .F.
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.cmd_4c_Fecha, "Click", THIS, "BtnFechaClick")

        *-- Grid da lista: top=129+29=158, left=33, width=941, height=461
        loc_oPg1.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Dados
        loc_oGrid.ColumnCount = 6
        WITH loc_oGrid
            .Top                = 158
            .Left               = 33
            .Width              = 941
            .Height             = 461
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

        WITH loc_oGrid.Column1
            .Width = 60
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oGrid.Column2
            .Width = 90
            .Header1.Caption = "In" + CHR(237) + "cio"
        ENDWITH
        WITH loc_oGrid.Column3
            .Width = 90
            .Header1.Caption = "T" + CHR(233) + "rmino"
        ENDWITH
        WITH loc_oGrid.Column4
            .Width = 120
            .Header1.Caption = "Tipo"
        ENDWITH
        WITH loc_oGrid.Column5
            .Width = 80
            .Header1.Caption = "Grupo"
        ENDWITH
        WITH loc_oGrid.Column6
            .Width = 80
            .Header1.Caption = "Conta"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: container salva + todos os campos de edicao
    * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
    * Lookups/Valid handlers implementados na Fase 6
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container Salva (Confirmar/Cancelar) - Left=842
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- === Codigo (PK - readonly, top=172+29 original=143) ===
        loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPg2.lbl_4c_Codigo
            .Top       = 176
            .Left      = 283
            .Width     = 40
            .Height    = 18
            .Caption   = "C" + CHR(243) + "digo"
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Top      = 172
            .Left     = 327
            .Width    = 60
            .Height   = 24
            .ReadOnly = .T.
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- === Tipo (ComboBox tipos 1-4, top=199 original=170) ===
        loc_oPg2.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPg2.lbl_4c_Tipo
            .Top       = 203
            .Left      = 296
            .Width     = 28
            .Height    = 18
            .Caption   = "Tipo"
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- BoundColumn=0 -> Value = ListIndex (1-4) = tipos diretamente
        loc_oPg2.AddObject("cbo_4c_Operacao", "ComboBox")
        WITH loc_oPg2.cbo_4c_Operacao
            .Top           = 199
            .Left          = 327
            .Width         = 130
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "1a. Entrada,Pendentes,Devolvidos,Todos"
            .Style         = 2
            .Value         = "1a. Entrada"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- === Operacao (char 15, lookup SigCdOpe, top=226 original=197) ===
        loc_oPg2.AddObject("lbl_4c_Oper", "Label")
        WITH loc_oPg2.lbl_4c_Oper
            .Top       = 230
            .Left      = 269
            .Width     = 55
            .Height    = 18
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Oper", "TextBox")
        WITH loc_oPg2.txt_4c_Oper
            .Top       = 226
            .Left      = 327
            .Width     = 130
            .Height    = 24
            .MaxLength = 15
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- === Data Inicial (top=253 original=224) ===
        loc_oPg2.AddObject("lbl_4c_DataIni", "Label")
        WITH loc_oPg2.lbl_4c_DataIni
            .Top       = 257
            .Left      = 291
            .Width     = 34
            .Height    = 18
            .Caption   = "In" + CHR(237) + "cio"
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- InputMask @D usa SET DATE BRITISH (DD/MM/YYYY) definido em FormBase.Init
        loc_oPg2.AddObject("txt_4c_DataInicial", "TextBox")
        WITH loc_oPg2.txt_4c_DataInicial
            .Top       = 253
            .Left      = 327
            .Width     = 80
            .Height    = 24
            .Value     = {}
            .InputMask = "@D"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- === Data Final (top=280 original=251) ===
        loc_oPg2.AddObject("lbl_4c_DataFim", "Label")
        WITH loc_oPg2.lbl_4c_DataFim
            .Top       = 284
            .Left      = 278
            .Width     = 46
            .Height    = 18
            .Caption   = "T" + CHR(233) + "rmino"
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DataFinal", "TextBox")
        WITH loc_oPg2.txt_4c_DataFinal
            .Top       = 280
            .Left      = 327
            .Width     = 80
            .Height    = 24
            .Value     = {}
            .InputMask = "@D"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- === Grupo (char 10, lookup contab, top=307 original=278) ===
        loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPg2.lbl_4c_Grupo
            .Top       = 311
            .Left      = 287
            .Width     = 36
            .Height    = 18
            .Caption   = "Grupo"
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg2.txt_4c_Grupo
            .Top       = 307
            .Left      = 327
            .Width     = 80
            .Height    = 24
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Descricao do Grupo (editavel para busca reversa por descricao em modo INCLUIR)
        loc_oPg2.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg2.txt_4c_DGrupo
            .Top      = 307
            .Left     = 409
            .Width    = 320
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- === Conta (char 10, lookup contas, top=334 original=305) ===
        loc_oPg2.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg2.lbl_4c_Conta
            .Top       = 338
            .Left      = 287
            .Width     = 36
            .Height    = 18
            .Caption   = "Conta"
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg2.txt_4c_Conta
            .Top       = 334
            .Left      = 327
            .Width     = 80
            .Height    = 24
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Descricao da Conta (editavel para busca reversa por nome em modo INCLUIR)
        loc_oPg2.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPg2.txt_4c_DConta
            .Top      = 334
            .Left     = 409
            .Width    = 320
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Valid handlers para campos de lookup (Fase 6)
        BINDEVENT(loc_oPg2.txt_4c_Oper,   "KeyPress", THIS, "ValidOper")
        BINDEVENT(loc_oPg2.txt_4c_Grupo,  "KeyPress", THIS, "ValidGrupo")
        BINDEVENT(loc_oPg2.txt_4c_DGrupo, "KeyPress", THIS, "ValidDGrupo")
        BINDEVENT(loc_oPg2.txt_4c_Conta,  "KeyPress", THIS, "ValidConta")
        BINDEVENT(loc_oPg2.txt_4c_DConta, "KeyPress", THIS, "ValidDConta")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLeitura - Page3: leitura de cheques
    * Shapes, campos readonly do balanco, tipo leitura, entrada manual,
    * grade de historico (cursor_4c_Historico) e botoes de acao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLeitura()
        LOCAL loc_oPg3, loc_oGrid

        loc_oPg3 = THIS.pgf_4c_Paginas.Page3

        *-- Criar cursor vazio ANTES de setar RecordSource/ControlSource nos grids
        IF !USED("cursor_4c_Historico")
            SET NULL ON
            CREATE CURSOR cursor_4c_Historico ;
                (cidchaves C(20), codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
                 ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
                 valors N(14,2), vencs D)
            SET NULL OFF
        ENDIF

        *======================================================
        * 1. Shapes decorativos
        *======================================================
        *-- Shape1: fundo area botoes topo (top=36 = legado 7 + 29 PageFrame)
        loc_oPg3.AddObject("shp_4c_BotoesBg", "Shape")
        WITH loc_oPg3.shp_4c_BotoesBg
            .Top           = 36
            .Left          = 537
            .Width         = 251
            .Height        = 110
            .SpecialEffect = 1
            .BackColor     = RGB(236, 233, 216)
            .BorderColor   = RGB(160, 160, 160)
            .Visible       = .T.
        ENDWITH

        *-- Shape2: fundo dados do balanco corrente
        loc_oPg3.AddObject("shp_4c_DadosBal", "Shape")
        WITH loc_oPg3.shp_4c_DadosBal
            .Top           = 193
            .Left          = 167
            .Width         = 509
            .Height        = 154
            .SpecialEffect = 1
            .BackColor     = RGB(236, 233, 216)
            .BorderColor   = RGB(160, 160, 160)
            .Visible       = .T.
        ENDWITH

        *-- Shape4: fundo area tipo de leitura
        loc_oPg3.AddObject("shp_4c_TipoLeitBg", "Shape")
        WITH loc_oPg3.shp_4c_TipoLeitBg
            .Top           = 193
            .Left          = 674
            .Width         = 158
            .Height        = 154
            .SpecialEffect = 1
            .BackColor     = RGB(236, 233, 216)
            .BorderColor   = RGB(160, 160, 160)
            .Visible       = .T.
        ENDWITH

        *======================================================
        * 2. Labels de cabecalho para area dados balanco
        *======================================================
        loc_oPg3.AddObject("lbl_4c_CabDados", "Label")
        WITH loc_oPg3.lbl_4c_CabDados
            .Top       = 196
            .Left      = 175
            .Width     = 490
            .Height    = 16
            .Caption   = "C" + CHR(243) + "d.    Opera" + CHR(231) + CHR(227) + "o          Oper.Aberta          Dt.Inicial    Dt.Final"
            .FontName  = "Arial"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 128)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("lbl_4c_CabDados2", "Label")
        WITH loc_oPg3.lbl_4c_CabDados2
            .Top       = 246
            .Left      = 175
            .Width     = 490
            .Height    = 16
            .Caption   = "Grupo                   Descri" + CHR(231) + CHR(227) + "o do Grupo"
            .FontName  = "Arial"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 128)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("lbl_4c_CabDados3", "Label")
        WITH loc_oPg3.lbl_4c_CabDados3
            .Top       = 296
            .Left      = 175
            .Width     = 490
            .Height    = 16
            .Caption   = "Conta                   Descri" + CHR(231) + CHR(227) + "o da Conta"
            .FontName  = "Arial"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 128)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================
        * 3. Campos readonly de exibicao do balanco corrente
        *======================================================
        loc_oPg3.AddObject("txt_4c_CodDisp", "TextBox")
        WITH loc_oPg3.txt_4c_CodDisp
            .Top         = 213
            .Left        = 175
            .Width       = 60
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_OperDisp", "TextBox")
        WITH loc_oPg3.txt_4c_OperDisp
            .Top         = 213
            .Left        = 246
            .Width       = 100
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_OperAbDisp", "TextBox")
        WITH loc_oPg3.txt_4c_OperAbDisp
            .Top         = 213
            .Left        = 356
            .Width       = 130
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_DataIniDisp", "TextBox")
        WITH loc_oPg3.txt_4c_DataIniDisp
            .Top         = 213
            .Left        = 497
            .Width       = 80
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_DataFimDisp", "TextBox")
        WITH loc_oPg3.txt_4c_DataFimDisp
            .Top         = 213
            .Left        = 587
            .Width       = 80
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_GrupoDisp", "TextBox")
        WITH loc_oPg3.txt_4c_GrupoDisp
            .Top         = 263
            .Left        = 175
            .Width       = 80
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_DGrupoDisp", "TextBox")
        WITH loc_oPg3.txt_4c_DGrupoDisp
            .Top         = 263
            .Left        = 256
            .Width       = 160
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_ContaDisp", "TextBox")
        WITH loc_oPg3.txt_4c_ContaDisp
            .Top         = 313
            .Left        = 175
            .Width       = 80
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_DContaDisp", "TextBox")
        WITH loc_oPg3.txt_4c_DContaDisp
            .Top         = 313
            .Left        = 256
            .Width       = 240
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        *======================================================
        * 4. Tipo de Leitura (opt_4c_TipoLeitura)
        *    Button1=Teclado (manual), Button2=Porta (serial - desabilitado)
        *======================================================
        loc_oPg3.AddObject("opt_4c_TipoLeitura", "OptionGroup")
        loc_oPg3.opt_4c_TipoLeitura.Top         = 199
        loc_oPg3.opt_4c_TipoLeitura.Left        = 709
        loc_oPg3.opt_4c_TipoLeitura.Width       = 78
        loc_oPg3.opt_4c_TipoLeitura.Height      = 41
        loc_oPg3.opt_4c_TipoLeitura.ButtonCount = 2
        loc_oPg3.opt_4c_TipoLeitura.Value       = 1
        loc_oPg3.opt_4c_TipoLeitura.BackStyle   = 0
        loc_oPg3.opt_4c_TipoLeitura.BorderStyle = 0
        loc_oPg3.opt_4c_TipoLeitura.Visible     = .T.
        WITH loc_oPg3.opt_4c_TipoLeitura
            WITH .Buttons(1)
                .Top     = 3
                .Left    = 3
                .Width   = 70
                .Height  = 17
                .Caption = "Teclado"
            ENDWITH
            WITH .Buttons(2)
                .Top     = 22
                .Left    = 3
                .Width   = 70
                .Height  = 17
                .Caption = "Porta"
                .Enabled = .F.
            ENDWITH
        ENDWITH

        *-- Shape3: destaque info modo teclado
        loc_oPg3.AddObject("shp_4c_LeitorInfo", "Shape")
        WITH loc_oPg3.shp_4c_LeitorInfo
            .Top           = 245
            .Left          = 705
            .Width         = 95
            .Height        = 36
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 200)
            .BorderColor   = RGB(160, 160, 160)
            .Visible       = .T.
        ENDWITH

        loc_oPg3.AddObject("lbl_4c_ModoLeitura", "Label")
        WITH loc_oPg3.lbl_4c_ModoLeitura
            .Top       = 250
            .Left      = 710
            .Width     = 85
            .Height    = 28
            .Caption   = "Leitura" + CHR(13) + "pelo Teclado"
            .FontName  = "Arial"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 128)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- ShpComm: area porta serial (hardware nao portado - apenas visual)
        loc_oPg3.AddObject("shp_4c_PortaComm", "Shape")
        WITH loc_oPg3.shp_4c_PortaComm
            .Top           = 285
            .Left          = 684
            .Width         = 138
            .Height        = 55
            .SpecialEffect = 1
            .BackColor     = RGB(200, 200, 200)
            .BorderColor   = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        *-- Comm_Ini / Comm_Fim: invisiveis (serial port nao portado)
        loc_oPg3.AddObject("img_4c_CommIni", "Image")
        WITH loc_oPg3.img_4c_CommIni
            .Top     = 290
            .Left    = 689
            .Width   = 60
            .Height  = 45
            .Visible = .F.
        ENDWITH

        loc_oPg3.AddObject("img_4c_CommFim", "Image")
        WITH loc_oPg3.img_4c_CommFim
            .Top     = 290
            .Left    = 753
            .Width   = 60
            .Height  = 45
            .Visible = .F.
        ENDWITH

        *======================================================
        * 5. Area de entrada manual de cheques (ShpLeitura)
        *======================================================
        loc_oPg3.AddObject("shp_4c_EntradaManual", "Shape")
        WITH loc_oPg3.shp_4c_EntradaManual
            .Top           = 345
            .Left          = 167
            .Width         = 192
            .Height        = 192
            .SpecialEffect = 1
            .BackColor     = RGB(236, 233, 216)
            .BorderColor   = RGB(160, 160, 160)
            .Visible       = .T.
        ENDWITH

        *-- Say13: titulo da area de entrada
        loc_oPg3.AddObject("lbl_4c_Cheque", "Label")
        WITH loc_oPg3.lbl_4c_Cheque
            .Top       = 351
            .Left      = 175
            .Width     = 170
            .Height    = 16
            .Caption   = "Informa" + CHR(231) + CHR(227) + "o do Cheque"
            .FontName  = "Arial"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 128)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Banco
        loc_oPg3.AddObject("lbl_4c_LBco", "Label")
        WITH loc_oPg3.lbl_4c_LBco
            .Top       = 376
            .Left      = 175
            .Width     = 75
            .Height    = 16
            .Caption   = "Banco:"
            .FontName  = "Arial"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Bco", "TextBox")
        WITH loc_oPg3.txt_4c_Bco
            .Top         = 373
            .Left        = 253
            .Width       = 35
            .Height      = 22
            .MaxLength   = 10
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        *-- Agencia
        loc_oPg3.AddObject("lbl_4c_LAge", "Label")
        WITH loc_oPg3.lbl_4c_LAge
            .Top       = 402
            .Left      = 175
            .Width     = 75
            .Height    = 16
            .Caption   = "Ag" + CHR(234) + "ncia:"
            .FontName  = "Arial"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Age", "TextBox")
        WITH loc_oPg3.txt_4c_Age
            .Top         = 399
            .Left        = 253
            .Width       = 45
            .Height      = 22
            .MaxLength   = 10
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        *-- Conta
        loc_oPg3.AddObject("lbl_4c_LContaLei", "Label")
        WITH loc_oPg3.lbl_4c_LContaLei
            .Top       = 428
            .Left      = 175
            .Width     = 75
            .Height    = 16
            .Caption   = "Conta:"
            .FontName  = "Arial"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_ContaLei", "TextBox")
        WITH loc_oPg3.txt_4c_ContaLei
            .Top         = 425
            .Left        = 253
            .Width       = 80
            .Height      = 22
            .MaxLength   = 10
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        *-- Numero do cheque (LostFocus dispara validacao e insercao)
        loc_oPg3.AddObject("lbl_4c_LNum", "Label")
        WITH loc_oPg3.lbl_4c_LNum
            .Top       = 454
            .Left      = 175
            .Width     = 75
            .Height    = 16
            .Caption   = "N" + CHR(250) + "mero:"
            .FontName  = "Arial"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Num", "TextBox")
        WITH loc_oPg3.txt_4c_Num
            .Top         = 451
            .Left        = 253
            .Width       = 50
            .Height      = 22
            .MaxLength   = 10
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg3.txt_4c_Num, "KeyPress", THIS, "NumGetLostFocus")

        *-- Valor (readonly - preenchido pela validacao)
        loc_oPg3.AddObject("lbl_4c_LValor", "Label")
        WITH loc_oPg3.lbl_4c_LValor
            .Top       = 480
            .Left      = 175
            .Width     = 75
            .Height    = 16
            .Caption   = "Valor:"
            .FontName  = "Arial"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPg3.txt_4c_Valor
            .Top         = 477
            .Left        = 253
            .Width       = 70
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        *-- Vencimento (readonly - preenchido pela validacao)
        loc_oPg3.AddObject("lbl_4c_LVecto", "Label")
        WITH loc_oPg3.lbl_4c_LVecto
            .Top       = 506
            .Left      = 175
            .Width     = 75
            .Height    = 16
            .Caption   = "Vencto:"
            .FontName  = "Arial"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Vecto", "TextBox")
        WITH loc_oPg3.txt_4c_Vecto
            .Top         = 503
            .Left        = 253
            .Width       = 70
            .Height      = 22
            .ReadOnly    = .T.
            .BackColor   = RGB(220, 220, 220)
            .BorderStyle = 1
            .FontName    = "Arial"
            .FontSize    = 9
            .Visible     = .T.
        ENDWITH

        *======================================================
        * 6. Grade de historico de leitura (GradeLeitura)
        *    cursor_4c_Historico: bancos, agencias, ncontas, ncheques, vencs, valors
        *======================================================
        loc_oPg3.AddObject("grd_4c_Leitura", "GridBase")
        loc_oGrid = loc_oPg3.grd_4c_Leitura
        WITH loc_oGrid
            .Top           = 345
            .Left          = 357
            .Width         = 475
            .Height        = 192
            .ReadOnly      = .T.
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .GridLines     = 2
            .GridLineWidth = 1
            .GridLineColor = RGB(192, 192, 192)
            .HeaderHeight  = 20
            .RowHeight     = 20
            .ScrollBars    = 3
            .Visible       = .T.
        ENDWITH
        loc_oGrid.ColumnCount  = 6
        loc_oGrid.RecordSource = "cursor_4c_Historico"

        *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
        loc_oGrid.Column1.ControlSource = "cursor_4c_Historico.bancos"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Historico.agencias"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Historico.ncontas"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Historico.ncheques"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Historico.vencs"
        loc_oGrid.Column6.ControlSource = "cursor_4c_Historico.valors"

        WITH loc_oGrid.Column1
            .Width         = 55
            .ReadOnly      = .T.
            .Resizable     = .T.
        ENDWITH
        loc_oGrid.Column1.Header1.Caption = "Banco"

        WITH loc_oGrid.Column2
            .Width         = 55
            .ReadOnly      = .T.
            .Resizable     = .T.
        ENDWITH
        loc_oGrid.Column2.Header1.Caption = "Ag" + CHR(234) + "ncia"

        WITH loc_oGrid.Column3
            .Width         = 70
            .ReadOnly      = .T.
            .Resizable     = .T.
        ENDWITH
        loc_oGrid.Column3.Header1.Caption = "N" + CHR(186) + " Conta"

        WITH loc_oGrid.Column4
            .Width         = 70
            .ReadOnly      = .T.
            .Resizable     = .T.
        ENDWITH
        loc_oGrid.Column4.Header1.Caption = "N" + CHR(186) + " Cheque"

        WITH loc_oGrid.Column5
            .Width         = 75
            .ReadOnly      = .T.
            .Resizable     = .T.
        ENDWITH
        loc_oGrid.Column5.Header1.Caption = "Vencimento"

        WITH loc_oGrid.Column6
            .Width         = 80
            .ReadOnly      = .T.
            .Resizable     = .T.
        ENDWITH
        loc_oGrid.Column6.Header1.Caption = "Valor"

        *======================================================
        * 7. Botoes de acao da leitura (posicionados diretamente em Page3)
        *    Left absoluto: Excluir=773, Gravar=848, Encerrar=923
        *======================================================
        loc_oPg3.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPg3.cmd_4c_Excluir
            .Top             = 31
            .Left            = 773
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg3.cmd_4c_Excluir, "Click", THIS, "BtnExcluirHistoricoClick")

        loc_oPg3.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPg3.cmd_4c_Confirmar
            .Top             = 31
            .Left            = 848
            .Width           = 75
            .Height          = 75
            .Caption         = "Gravar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg3.cmd_4c_Confirmar, "Click", THIS, "BtnGravarLeituraClick")

        loc_oPg3.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPg3.cmd_4c_Cancelar
            .Top             = 31
            .Left            = 923
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg3.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarLeituraClick")

        *======================================================
        * 8. Grade de historico de leitura (grd_4c_Leitura)
        *    Banco, Agencia, No Conta, No Cheque, Vencimento, Valor
        *======================================================
        loc_oPg3.AddObject("grd_4c_leitura2", "Grid")
        loc_oGrid = loc_oPg3.grd_4c_leitura2
        loc_oGrid.ColumnCount = 6
        WITH loc_oGrid
            .Top                = 532
            .Left               = 30
            .Width              = 770
            .Height             = 120
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

        WITH loc_oGrid.Column1
            .Width           = 80
            .ControlSource   = "cursor_4c_Historico.bancos"
            .Header1.Caption = "Banco"
        ENDWITH
        WITH loc_oGrid.Column2
            .Width           = 80
            .ControlSource   = "cursor_4c_Historico.agencias"
            .Header1.Caption = "Ag" + CHR(234) + "ncia"
        ENDWITH
        WITH loc_oGrid.Column3
            .Width           = 90
            .ControlSource   = "cursor_4c_Historico.ncontas"
            .Header1.Caption = "N" + CHR(186) + " Conta"
        ENDWITH
        WITH loc_oGrid.Column4
            .Width           = 90
            .ControlSource   = "cursor_4c_Historico.ncheques"
            .Header1.Caption = "N" + CHR(186) + " Cheque"
        ENDWITH
        WITH loc_oGrid.Column5
            .Width           = 80
            .ControlSource   = "cursor_4c_Historico.vencs"
            .Header1.Caption = "Vencimento"
        ENDWITH
        WITH loc_oGrid.Column6
            .Width           = 80
            .ControlSource   = "cursor_4c_Historico.valors"
            .Header1.Caption = "Valor"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg3)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros de SigCdBch no grid da Page1
    *--------------------------------------------------------------------------
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
                    IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                        loc_oGrid.ColumnCount = 6
                        loc_oGrid.RecordSource = "cursor_4c_Dados"

                        *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datainis"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.datafims"
                        loc_oGrid.Column4.ControlSource = ;
                            "IIF(cursor_4c_Dados.tipos=1,'1a.Entrada'," + ;
                            "IIF(cursor_4c_Dados.tipos=2,'Pendentes'," + ;
                            "IIF(cursor_4c_Dados.tipos=3,'Devolvidos','Todos')))"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"

                        *-- Reconfigurar headers (RecordSource reseta captions)
                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
                        loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
                        loc_oGrid.Column4.Header1.Caption = "Tipo"
                        loc_oGrid.Column5.Header1.Caption = "Grupo"
                        loc_oGrid.Column6.Header1.Caption = "Conta"

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre as 3 paginas do PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 3
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            DO CASE
            CASE par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            CASE par_nPagina = 2
                *-- modo definido pelo chamador (INCLUIR/ALTERAR/VISUALIZAR)
            CASE par_nPagina = 3
                THIS.this_cModoAtual = "LEITURA"
                THIS.CarregarLeitura()
            ENDCASE

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.AlternarPagina")
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
    * BtnIncluirClick - Inicia inclusao de novo balanco
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza balanco selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Edita balanco selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados

        IF cursor_4c_Dados.encerras
            MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                     "vel alterar balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
            RETURN
        ENDIF

        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui balanco selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados

        IF cursor_4c_Dados.encerras
            MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                     "vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
                        "Confirmar")
            RETURN
        ENDIF

        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca registros de SigCdBch por FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_nCodigo, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdBch", "cursor_4c_BuscaBch", "codigos", "", ;
                "Balan" + CHR(231) + "o de Cheques")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos",   "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("datainis",  "", "In" + CHR(237) + "cio")
                loc_oBusca.mAddColuna("datafims",  "", "T" + CHR(233) + "rmino")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBch")
                    SELECT cursor_4c_BuscaBch
                    IF !EOF("cursor_4c_BuscaBch")
                        loc_nCodigo = cursor_4c_BuscaBch.codigos
                        THIS.this_oBusinessObject.Buscar( ;
                            "codigos = " + FormatarNumeroSQL(loc_nCodigo))
                        IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ELSE
                    THIS.CarregarLista()
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaBch")
            USE IN cursor_4c_BuscaBch
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva registro (cmd_4c_Confirmar em Page2)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes fora do TRY para que RETURN funcione
        IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
            IF EMPTY(loc_oPg2.txt_4c_DataInicial.Value)
                MsgAviso("Data Inicial obrigat" + CHR(243) + "ria!", "")
                RETURN
            ENDIF
        ENDIF

        IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
            IF EMPTY(loc_oPg2.txt_4c_DataFinal.Value)
                MsgAviso("Data Final obrigat" + CHR(243) + "ria!", "")
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "")
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
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnLeituraClick - Abre pagina de leitura para o balanco selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnLeituraClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um balan" + CHR(231) + "o na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados

        IF cursor_4c_Dados.encerras
            MsgAviso("Invent" + CHR(225) + "rio J" + CHR(225) + " Encerrado !!!", "")
            RETURN
        ENDIF

        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            THIS.this_cModoAtual = "LEITURA"
            THIS.AlternarPagina(3)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFechaClick - Encerra o balanco selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnFechaClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um balan" + CHR(231) + "o na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados

        IF cursor_4c_Dados.encerras
            MsgAviso("Balan" + CHR(231) + "o J" + CHR(225) + " Encerrado !!!", "")
            RETURN
        ENDIF

        IF !MsgConfirma("Este Balan" + CHR(231) + "o ser" + CHR(225) + " finalizado, n" + ;
                        CHR(227) + "o podendo ser efetuada mais nenhuma leitura..." + CHR(13) + ;
                        "Deseja encerrar o Balan" + CHR(231) + "o ???", ;
                        "ATEN" + CHR(199) + CHR(195) + "O")
            RETURN
        ENDIF

        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            IF THIS.this_oBusinessObject.EncerrarBalanco()
                MsgInfo("Balan" + CHR(231) + "o encerrado com sucesso!", "")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGravarLeituraClick - Grava leitura: atualiza SigCqBal e marca balanco Grvs=1
    *--------------------------------------------------------------------------
    PROCEDURE BtnGravarLeituraClick()
        LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_lContinuar
        LOCAL loc_cCidChaveBal, loc_cBcoH, loc_cAgeH, loc_cCntH, loc_cChqH, loc_nTipH

        IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
            MsgAviso("Nenhum cheque na lista para gravar.", "")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a grava" + CHR(231) + CHR(227) + "o da leitura?", "")
            RETURN
        ENDIF

        TRY
            loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
            loc_lContinuar = .T.

            *-- Carrega SigCqBal para obter cidchaves (padrao original: cursor local)
            SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves, bancos, agencias, ncontas, ncheques FROM SigCqBal" + ;
                " WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
                "cursor_4c_BalCid")

            SELECT cursor_4c_Historico
            GO TOP

            DO WHILE !EOF("cursor_4c_Historico") AND loc_lContinuar
                loc_cBcoH = ALLTRIM(cursor_4c_Historico.bancos)
                loc_cAgeH = ALLTRIM(cursor_4c_Historico.agencias)
                loc_cCntH = ALLTRIM(cursor_4c_Historico.ncontas)
                loc_cChqH = ALLTRIM(cursor_4c_Historico.ncheques)
                loc_nTipH = cursor_4c_Historico.tipos

                loc_cCidChaveBal = ""
                IF USED("cursor_4c_BalCid")
                    SELECT cursor_4c_BalCid
                    LOCATE FOR ALLTRIM(bancos) = loc_cBcoH AND ALLTRIM(agencias) = loc_cAgeH ;
                        AND ALLTRIM(ncontas) = loc_cCntH AND ALLTRIM(ncheques) = loc_cChqH
                    IF FOUND()
                        loc_cCidChaveBal = ALLTRIM(cidchaves)
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cCidChaveBal)
                    IF loc_nTipH = 2
                        loc_cSQL = "UPDATE SigCqBal SET ReLidos = 1" + ;
                                   " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
                    ELSE
                        loc_cSQL = "UPDATE SigCqBal SET Lidos = 1" + ;
                                   " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao atualizar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF

                SELECT cursor_4c_Historico
                IF loc_lContinuar
                    SKIP
                ENDIF
            ENDDO

            IF USED("cursor_4c_BalCid")
                USE IN cursor_4c_BalCid
            ENDIF

            IF loc_lContinuar AND THIS.this_oBusinessObject.MarcarGravado()
                MsgInfo("Leitura gravada com sucesso!", "")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.BtnGravarLeituraClick")
            IF USED("cursor_4c_BalCid")
                USE IN cursor_4c_BalCid
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirHistoricoClick - Remove cheque do historico e reseta SigCqBal
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirHistoricoClick()
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_nCodigos, loc_cBancos, loc_cAgencias, loc_cNContas, loc_cNCheques, loc_nTipos
        LOCAL loc_cCidChaveHis, loc_cCidChaveBal

        IF !USED("cursor_4c_Historico") OR EOF("cursor_4c_Historico") OR ;
           RECCOUNT("cursor_4c_Historico") = 0
            MsgAviso("Nenhum cheque selecionado.", "")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Historico
            loc_nCodigos     = cursor_4c_Historico.codigos
            loc_cCidChaveHis = ALLTRIM(cursor_4c_Historico.cidchaves)
            loc_cBancos      = ALLTRIM(cursor_4c_Historico.bancos)
            loc_cAgencias    = ALLTRIM(cursor_4c_Historico.agencias)
            loc_cNContas     = ALLTRIM(cursor_4c_Historico.ncontas)
            loc_cNCheques    = ALLTRIM(cursor_4c_Historico.ncheques)
            loc_nTipos       = cursor_4c_Historico.tipos

            loc_cSQL = "DELETE FROM SigCqHis WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveHis)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Localiza cidchaves em SigCqBal para resetar flag (padrao original: cursor local)
                loc_cCidChaveBal = ""
                SQLEXEC(gnConnHandle, ;
                    "SELECT cidchaves, bancos, agencias, ncontas, ncheques FROM SigCqBal" + ;
                    " WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
                    "cursor_4c_BalCid")
                IF USED("cursor_4c_BalCid")
                    SELECT cursor_4c_BalCid
                    LOCATE FOR ALLTRIM(bancos) = loc_cBancos AND ALLTRIM(agencias) = loc_cAgencias ;
                        AND ALLTRIM(ncontas) = loc_cNContas AND ALLTRIM(ncheques) = loc_cNCheques
                    IF FOUND()
                        loc_cCidChaveBal = ALLTRIM(cidchaves)
                    ENDIF
                    USE IN cursor_4c_BalCid
                ENDIF

                IF !EMPTY(loc_cCidChaveBal)
                    IF loc_nTipos = 2
                        loc_cSQL = "UPDATE SigCqBal SET ReLidos = 0" + ;
                                   " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
                    ELSE
                        loc_cSQL = "UPDATE SigCqBal SET Lidos = 0" + ;
                                   " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao resetar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF

                THIS.CarregarGradeLeitura(loc_nCodigos)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.BtnExcluirHistoricoClick")
            IF USED("cursor_4c_BalCid")
                USE IN cursor_4c_BalCid
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarLeituraClick - Cancela leitura e retorna para lista (Page3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarLeituraClick()
        IF MsgConfirma("Deseja Cancelar ???", "")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de edicao em Page2
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = (par_lHabilitar = .T.) AND (THIS.this_cModoAtual != "VISUALIZAR")

        IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
            loc_oPg2.txt_4c_Codigo.Enabled = (THIS.this_cModoAtual = "INCLUIR") AND par_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
            loc_oPg2.cbo_4c_Operacao.Enabled = loc_lEdicao
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
            loc_oPg2.txt_4c_Oper.Enabled = loc_lEdicao
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
            loc_oPg2.txt_4c_DataInicial.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
            loc_oPg2.txt_4c_DataFinal.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
            loc_oPg2.txt_4c_Grupo.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
            loc_oPg2.txt_4c_Conta.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
            IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos de edicao em Page2
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
            loc_oPg2.txt_4c_Codigo.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
            loc_oPg2.cbo_4c_Operacao.ListIndex = 1
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
            loc_oPg2.txt_4c_Oper.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
            loc_oPg2.txt_4c_DataInicial.Value = {}
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
            loc_oPg2.txt_4c_DataFinal.Value = {}
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
            loc_oPg2.txt_4c_Grupo.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
            loc_oPg2.txt_4c_DGrupo.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
            loc_oPg2.txt_4c_Conta.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
            loc_oPg2.txt_4c_DConta.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_lEdicao, loc_oPg2, loc_lLista
        loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_lLista  = (THIS.this_cModoAtual = "LISTA")
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oBotoes) = "O"
            IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"
                loc_oBotoes.cmd_4c_Incluir.Enabled = .T.
            ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O"
                loc_oBotoes.cmd_4c_Visualizar.Enabled = .T.
            ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"
                loc_oBotoes.cmd_4c_Alterar.Enabled = .T.
            ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
                loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
            ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"
                loc_oBotoes.cmd_4c_Buscar.Enabled = .T.
            ENDIF
        ENDIF

        IF VARTYPE(loc_oPg2) = "O" AND VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
            IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible = loc_lEdicao
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados dos campos do Form para o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
                .this_nCodigos   = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
                .this_nTipos     = loc_oPg2.cbo_4c_Operacao.ListIndex
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
                .this_cOperacaos = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
                .this_dDataInis  = loc_oPg2.txt_4c_DataInicial.Value
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
                .this_dDataFims  = loc_oPg2.txt_4c_DataFinal.Value
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
                .this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
                .this_cContas    = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para os campos do Form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
                loc_oPg2.txt_4c_Codigo.Value      = TRANSFORM(.this_nCodigos)
            ENDIF
            IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
                loc_oPg2.cbo_4c_Operacao.ListIndex = .this_nTipos
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
                loc_oPg2.txt_4c_Oper.Value        = ALLTRIM(.this_cOperacaos)
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
                loc_oPg2.txt_4c_DataInicial.Value = .this_dDataInis
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
                loc_oPg2.txt_4c_DataFinal.Value   = .this_dDataFims
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
                loc_oPg2.txt_4c_Grupo.Value       = ALLTRIM(.this_cGrupos)
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
                loc_oPg2.txt_4c_Conta.Value       = ALLTRIM(.this_cContas)
            ENDIF
            loc_cGrupo = ALLTRIM(.this_cGrupos)
            loc_cConta = ALLTRIM(.this_cContas)
        ENDWITH

        *-- Buscar descricoes de Grupo e Conta para exibicao
        TRY
            IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
                IF !EMPTY(loc_cGrupo)
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
                        "cursor_4c_DescGcr")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
                        SELECT cursor_4c_DescGcr
                        loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
                    ELSE
                        loc_oPg2.txt_4c_DGrupo.Value = ""
                    ENDIF
                    IF USED("cursor_4c_DescGcr")
                        USE IN cursor_4c_DescGcr
                    ENDIF
                ELSE
                    loc_oPg2.txt_4c_DGrupo.Value = ""
                ENDIF
            ENDIF

            IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
                IF !EMPTY(loc_cConta)
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta), ;
                        "cursor_4c_DescCli")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescCli") > 0
                        SELECT cursor_4c_DescCli
                        loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_DescCli.razaos)
                    ELSE
                        loc_oPg2.txt_4c_DConta.Value = ""
                    ENDIF
                    IF USED("cursor_4c_DescCli")
                        USE IN cursor_4c_DescCli
                    ENDIF
                ELSE
                    loc_oPg2.txt_4c_DConta.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.BOParaForm")
            IF USED("cursor_4c_DescGcr")
                USE IN cursor_4c_DescGcr
            ENDIF
            IF USED("cursor_4c_DescCli")
                USE IN cursor_4c_DescCli
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidOper - Valid handler: lookup SigCdOpt por operacaos (code = char 15)
    *--------------------------------------------------------------------------
    PROCEDURE ValidOper(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.txt_4c_Oper) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
            RETURN .T.
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)

        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ChkOpt")

            IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkOpt") = 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdOpt", "cursor_4c_BuscaOpt", "operacaos", loc_cCodigo, ;
                    "Opera" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("operacaos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
                        SELECT cursor_4c_BuscaOpt
                        loc_oPg2.txt_4c_Oper.Value = IIF(!EOF("cursor_4c_BuscaOpt"), ;
                            ALLTRIM(cursor_4c_BuscaOpt.operacaos), "")
                    ELSE
                        loc_oPg2.txt_4c_Oper.Value = ""
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChkOpt")
                USE IN cursor_4c_ChkOpt
            ENDIF
            IF USED("cursor_4c_BuscaOpt")
                USE IN cursor_4c_BuscaOpt
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.ValidOper")
            IF USED("cursor_4c_ChkOpt")
                USE IN cursor_4c_ChkOpt
            ENDIF
            IF USED("cursor_4c_BuscaOpt")
                USE IN cursor_4c_BuscaOpt
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidGrupo - Valid handler: lookup SigCdGcr por codigos, preenche DGrupo
    *--------------------------------------------------------------------------
    PROCEDURE ValidGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.txt_4c_Grupo) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
            RETURN .T.
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

        IF EMPTY(loc_cCodigo)
            IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
                loc_oPg2.txt_4c_DGrupo.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ChkGcr")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
                SELECT cursor_4c_ChkGcr
                IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
                    loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
                ENDIF
            ELSE
                IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
                    loc_oPg2.txt_4c_DGrupo.Value = ""
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                        SELECT cursor_4c_BuscaGcr
                        IF !EOF("cursor_4c_BuscaGcr")
                            loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                            IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
                                loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                            ENDIF
                        ELSE
                            loc_oPg2.txt_4c_Grupo.Value = ""
                        ENDIF
                    ELSE
                        loc_oPg2.txt_4c_Grupo.Value = ""
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChkGcr")
                USE IN cursor_4c_ChkGcr
            ENDIF
            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.ValidGrupo")
            IF USED("cursor_4c_ChkGcr")
                USE IN cursor_4c_ChkGcr
            ENDIF
            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidDGrupo - Valid handler: busca reversa SigCdGcr por descrs
    * Ativo apenas quando txt_4c_Grupo estiver vazio em modo INCLUIR
    *--------------------------------------------------------------------------
    PROCEDURE ValidDGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.txt_4c_DGrupo) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
            RETURN .T.
        ENDIF

        *-- Somente busca reversa quando Grupo estiver vazio
        IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O" AND !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
            RETURN .T.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value))
            RETURN .T.
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", "Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    IF !EOF("cursor_4c_BuscaGcr")
                        IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
                            loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                        ENDIF
                        loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                    ELSE
                        loc_oPg2.txt_4c_DGrupo.Value = ""
                    ENDIF
                ELSE
                    loc_oPg2.txt_4c_DGrupo.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.ValidDGrupo")
            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidConta - Valid handler: lookup SIGCDCLI por iclis, preenche DConta
    *--------------------------------------------------------------------------
    PROCEDURE ValidConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.txt_4c_Conta) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
            RETURN .T.
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

        IF EMPTY(loc_cCodigo)
            IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
                loc_oPg2.txt_4c_DConta.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT iclis, razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ChkCli")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
                SELECT cursor_4c_ChkCli
                IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
                    loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ChkCli.razaos)
                ENDIF
            ELSE
                IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
                    loc_oPg2.txt_4c_DConta.Value = ""
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", loc_cCodigo, "Conta")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("razaos", "", "Nome")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                        SELECT cursor_4c_BuscaCli
                        IF !EOF("cursor_4c_BuscaCli")
                            loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                            IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
                                loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
                            ENDIF
                        ELSE
                            loc_oPg2.txt_4c_Conta.Value = ""
                        ENDIF
                    ELSE
                        loc_oPg2.txt_4c_Conta.Value = ""
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChkCli")
                USE IN cursor_4c_ChkCli
            ENDIF
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.ValidConta")
            IF USED("cursor_4c_ChkCli")
                USE IN cursor_4c_ChkCli
            ENDIF
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidDConta - Valid handler: busca reversa SIGCDCLI por razaos
    * Ativo apenas quando txt_4c_Conta estiver vazio em modo INCLUIR
    *--------------------------------------------------------------------------
    PROCEDURE ValidDConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.txt_4c_DConta) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
            RETURN .T.
        ENDIF

        *-- Somente busca reversa quando Conta estiver vazia
        IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O" AND !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
            RETURN .T.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DConta.Value))
            RETURN .T.
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", "", "Conta")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razaos", "", "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    SELECT cursor_4c_BuscaCli
                    IF !EOF("cursor_4c_BuscaCli")
                        IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
                            loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
                        ENDIF
                        loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
                    ELSE
                        loc_oPg2.txt_4c_DConta.Value = ""
                    ENDIF
                ELSE
                    loc_oPg2.txt_4c_DConta.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.ValidDConta")
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles do container visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    IF !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
                        loc_oControl.Visible = .T.
                    ENDIF
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLeitura - Popula Page3 quando entra no modo LEITURA
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarLeitura()
        LOCAL loc_nCodigos
        loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
        THIS.PopularCamposLeitura()
        THIS.CarregarGradeLeitura(loc_nCodigos)
        THIS.LimparCamposLeitura()
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCamposLeitura - Preenche campos readonly da Page3 com dados do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PopularCamposLeitura()
        LOCAL loc_oPg3, loc_oBO, loc_cGrupo, loc_cConta, loc_cOperacaos, loc_nResultado
        loc_oPg3 = THIS.pgf_4c_Paginas.Page3
        loc_oBO  = THIS.this_oBusinessObject

        WITH loc_oBO
            IF VARTYPE(loc_oPg3.txt_4c_CodDisp) = "O"
                loc_oPg3.txt_4c_CodDisp.Value    = TRANSFORM(.this_nCodigos)
            ENDIF
            IF VARTYPE(loc_oPg3.txt_4c_OperDisp) = "O"
                loc_oPg3.txt_4c_OperDisp.Value   = ALLTRIM(.this_cOperacaos)
            ENDIF
            IF VARTYPE(loc_oPg3.txt_4c_DataIniDisp) = "O"
                loc_oPg3.txt_4c_DataIniDisp.Value = .this_dDataInis
            ENDIF
            IF VARTYPE(loc_oPg3.txt_4c_DataFimDisp) = "O"
                loc_oPg3.txt_4c_DataFimDisp.Value = .this_dDataFims
            ENDIF
            IF VARTYPE(loc_oPg3.txt_4c_GrupoDisp) = "O"
                loc_oPg3.txt_4c_GrupoDisp.Value  = ALLTRIM(.this_cGrupos)
            ENDIF
            IF VARTYPE(loc_oPg3.txt_4c_ContaDisp) = "O"
                loc_oPg3.txt_4c_ContaDisp.Value  = ALLTRIM(.this_cContas)
            ENDIF
            loc_cGrupo     = ALLTRIM(.this_cGrupos)
            loc_cConta     = ALLTRIM(.this_cContas)
            loc_cOperacaos = ALLTRIM(.this_cOperacaos)
        ENDWITH

        TRY
            IF !EMPTY(loc_cGrupo) AND VARTYPE(loc_oPg3.txt_4c_DGrupoDisp) = "O"
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
                    "cursor_4c_DescGcr")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
                    SELECT cursor_4c_DescGcr
                    loc_oPg3.txt_4c_DGrupoDisp.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
                ELSE
                    loc_oPg3.txt_4c_DGrupoDisp.Value = ""
                ENDIF
                IF USED("cursor_4c_DescGcr")
                    USE IN cursor_4c_DescGcr
                ENDIF
            ENDIF

            IF !EMPTY(loc_cConta) AND VARTYPE(loc_oPg3.txt_4c_DContaDisp) = "O"
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta), ;
                    "cursor_4c_DescCli")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescCli") > 0
                    SELECT cursor_4c_DescCli
                    loc_oPg3.txt_4c_DContaDisp.Value = ALLTRIM(cursor_4c_DescCli.razaos)
                ELSE
                    loc_oPg3.txt_4c_DContaDisp.Value = ""
                ENDIF
                IF USED("cursor_4c_DescCli")
                    USE IN cursor_4c_DescCli
                ENDIF
            ENDIF

            IF !EMPTY(loc_cOperacaos) AND VARTYPE(loc_oPg3.txt_4c_OperAbDisp) = "O"
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT descrs FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cOperacaos), ;
                    "cursor_4c_DescOpt")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescOpt") > 0
                    SELECT cursor_4c_DescOpt
                    loc_oPg3.txt_4c_OperAbDisp.Value = ALLTRIM(cursor_4c_DescOpt.descrs)
                ELSE
                    loc_oPg3.txt_4c_OperAbDisp.Value = ""
                ENDIF
                IF USED("cursor_4c_DescOpt")
                    USE IN cursor_4c_DescOpt
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.PopularCamposLeitura")
            IF USED("cursor_4c_DescGcr")
                USE IN cursor_4c_DescGcr
            ENDIF
            IF USED("cursor_4c_DescCli")
                USE IN cursor_4c_DescCli
            ENDIF
            IF USED("cursor_4c_DescOpt")
                USE IN cursor_4c_DescOpt
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeLeitura - Carrega SigCqHis em cursor_4c_Historico
    * Usa padrao Problem #34: placeholder CREATE CURSOR + ZAP + APPEND FROM
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGradeLeitura(par_nCodigos)
        LOCAL loc_cSQL, loc_nResultado

        TRY
            IF !USED("cursor_4c_Historico")
                SET NULL ON
                CREATE CURSOR cursor_4c_Historico ;
                    (cidchaves C(20), codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
                     ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
                     valors N(14,2), vencs D)
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT cidchaves, codigos, bancos, agencias, ncontas, ncheques, tipos, datas," + ;
                       " usuarios, valors, vencs" + ;
                       " FROM SigCqHis WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
                       " ORDER BY datas, ncheques"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Historico
                ZAP
                IF RECCOUNT("cursor_4c_HistoricoTemp") > 0
                    APPEND FROM DBF("cursor_4c_HistoricoTemp")
                ENDIF
                IF USED("cursor_4c_HistoricoTemp")
                    USE IN cursor_4c_HistoricoTemp
                ENDIF
                IF VARTYPE(THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura) = "O"
                    LOCAL loc_oGridLei
                    loc_oGridLei = THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura
                    loc_oGridLei.ColumnCount = 6
                    loc_oGridLei.RecordSource = "cursor_4c_Historico"
                    loc_oGridLei.Column1.ControlSource = "cursor_4c_Historico.bancos"
                    loc_oGridLei.Column1.Header1.Caption = "Banco"
                    loc_oGridLei.Column2.ControlSource = "cursor_4c_Historico.agencias"
                    loc_oGridLei.Column2.Header1.Caption = "Ag" + CHR(234) + "ncia"
                    loc_oGridLei.Column3.ControlSource = "cursor_4c_Historico.ncontas"
                    loc_oGridLei.Column3.Header1.Caption = "N" + CHR(186) + " Conta"
                    loc_oGridLei.Column4.ControlSource = "cursor_4c_Historico.ncheques"
                    loc_oGridLei.Column4.Header1.Caption = "N" + CHR(186) + " Cheque"
                    loc_oGridLei.Column5.ControlSource = "cursor_4c_Historico.vencs"
                    loc_oGridLei.Column5.Header1.Caption = "Vencimento"
                    loc_oGridLei.Column6.ControlSource = "cursor_4c_Historico.valors"
                    loc_oGridLei.Column6.Header1.Caption = "Valor"
                    loc_oGridLei.Refresh()
                ENDIF
            ELSE
                MsgErro("Erro ao carregar hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.CarregarGradeLeitura")
            IF USED("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCamposLeitura - Limpa campos de entrada manual da Page3
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCamposLeitura()
        LOCAL loc_oPg3
        loc_oPg3 = THIS.pgf_4c_Paginas.Page3

        IF VARTYPE(loc_oPg3.txt_4c_Bco) = "O"
            loc_oPg3.txt_4c_Bco.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg3.txt_4c_Age) = "O"
            loc_oPg3.txt_4c_Age.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg3.txt_4c_ContaLei) = "O"
            loc_oPg3.txt_4c_ContaLei.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg3.txt_4c_Num) = "O"
            loc_oPg3.txt_4c_Num.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
            loc_oPg3.txt_4c_Valor.Value = 0
        ENDIF
        IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
            loc_oPg3.txt_4c_Vecto.Value = {}
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * NumGetLostFocus - Valida cheque em SigCqBal e insere em SigCqHis
    *--------------------------------------------------------------------------
    PROCEDURE NumGetLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg3, loc_cBco, loc_cAge, loc_cConta, loc_cNum
        LOCAL loc_nCodigos, loc_nTipos, loc_cSQL, loc_nResultado
        LOCAL loc_nValor, loc_dVecto, loc_lContinuar, loc_cCidChaveHis
        loc_oPg3 = THIS.pgf_4c_Paginas.Page3

        IF VARTYPE(loc_oPg3.txt_4c_Bco) != "O" OR ;
           VARTYPE(loc_oPg3.txt_4c_Age) != "O" OR ;
           VARTYPE(loc_oPg3.txt_4c_ContaLei) != "O" OR ;
           VARTYPE(loc_oPg3.txt_4c_Num) != "O"
            RETURN
        ENDIF

        loc_cBco   = ALLTRIM(loc_oPg3.txt_4c_Bco.Value)
        loc_cAge   = ALLTRIM(loc_oPg3.txt_4c_Age.Value)
        loc_cConta = ALLTRIM(loc_oPg3.txt_4c_ContaLei.Value)
        loc_cNum   = ALLTRIM(loc_oPg3.txt_4c_Num.Value)

        IF EMPTY(loc_cNum) OR EMPTY(loc_cBco) OR EMPTY(loc_cAge) OR EMPTY(loc_cConta)
            RETURN
        ENDIF

        TRY
            loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
            loc_lContinuar = .T.
            IF VARTYPE(loc_oPg3.opt_4c_TipoLeitura) = "O"
                loc_nTipos = loc_oPg3.opt_4c_TipoLeitura.Value
            ELSE
                loc_nTipos = 1
            ENDIF

            *-- Carrega SigCqBal para verificar cheque (padrao original: cursor local)
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves, bancos, agencias, ncontas, ncheques, valors, vencs" + ;
                " FROM SigCqBal WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
                "cursor_4c_BalDisp")

            *-- Verificar se cheque existe no balanco (LOCATE em cursor local)
            IF loc_nResultado >= 0 AND USED("cursor_4c_BalDisp")
                SELECT cursor_4c_BalDisp
                LOCATE FOR ALLTRIM(bancos) = loc_cBco AND ALLTRIM(agencias) = loc_cAge ;
                    AND ALLTRIM(ncontas) = loc_cConta AND ALLTRIM(ncheques) = loc_cNum
                IF FOUND()
                    loc_nValor = TratarNulo(valors, "N")
                    loc_dVecto = TratarNulo(vencs,  "D")
                ELSE
                    MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
                    loc_lContinuar = .F.
                ENDIF
                USE IN cursor_4c_BalDisp
            ELSE
                MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Verificar duplicidade no historico (LOCATE em cursor local)
                IF USED("cursor_4c_Historico")
                    SELECT cursor_4c_Historico
                    LOCATE FOR ALLTRIM(bancos) = loc_cBco AND ALLTRIM(agencias) = loc_cAge ;
                        AND ALLTRIM(ncontas) = loc_cConta AND ALLTRIM(ncheques) = loc_cNum
                    IF FOUND()
                        MsgAviso("Cheque j" + CHR(225) + " consta no hist" + CHR(243) + "rico!", "")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Gerar cidchaves para SigCqHis
                loc_cCidChaveHis = ""
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", ;
                    "cursor_4c_Uuid")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                    SELECT cursor_4c_Uuid
                    loc_cCidChaveHis = ALLTRIM(cursor_4c_Uuid.novo_uuid)
                ENDIF
                IF USED("cursor_4c_Uuid")
                    USE IN cursor_4c_Uuid
                ENDIF

                *-- Inserir no historico de leitura
                loc_cSQL = "INSERT INTO SigCqHis" + ;
                           " (cidchaves, codigos, bancos, agencias, ncontas, ncheques, tipos, datas, usuarios, valors, vencs)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cCidChaveHis) + "," + ;
                           FormatarNumeroSQL(loc_nCodigos) + "," + ;
                           EscaparSQL(LEFT(loc_cBco,   10)) + "," + ;
                           EscaparSQL(LEFT(loc_cAge,   10)) + "," + ;
                           EscaparSQL(LEFT(loc_cConta, 10)) + "," + ;
                           EscaparSQL(LEFT(loc_cNum,   10)) + "," + ;
                           FormatarNumeroSQL(loc_nTipos) + "," + ;
                           "GETDATE()," + ;
                           EscaparSQL(LEFT(gc_4c_UsuarioLogado, 15)) + "," + ;
                           FormatarNumeroSQL(loc_nValor) + "," + ;
                           FormatarDataSQL(loc_dVecto) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
                        loc_oPg3.txt_4c_Valor.Value = loc_nValor
                    ENDIF
                    IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
                        loc_oPg3.txt_4c_Vecto.Value = loc_dVecto
                    ENDIF
                    THIS.CarregarGradeLeitura(loc_nCodigos)
                    THIS.LimparCamposLeitura()
                ELSE
                    MsgErro("Erro ao inserir no hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.NumGetLostFocus")
            IF USED("cursor_4c_BalDisp")
                USE IN cursor_4c_BalDisp
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata Grid da lista apos carregar dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Historico")
                USE IN cursor_4c_Historico
            ENDIF
            IF USED("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp
            ENDIF
            IF USED("Balanco")
                USE IN Balanco
            ENDIF
            IF USED("Historico")
                USE IN Historico
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBch.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\BchBO.prg):
*====================================================================
* BchBO.prg
*
* Business Object para Balanco de Cheques
* Tabela: SigCdBch
* PK: Codigos (numeric 6,0)
*
* Colunas (schema.sql):
*   operacaos  char(15)      NOT NULL
*   codigos    numeric(6,0)  NOT NULL  <- PK
*   datafims   datetime      NULL
*   datainis   datetime      NULL
*   encerras   bit           NOT NULL
*   tipos      numeric(1,0)  NOT NULL
*   grupos     char(10)      NOT NULL
*   contas     char(10)      NOT NULL
*   grvs       bit           NOT NULL
*====================================================================

DEFINE CLASS BchBO AS BusinessBase

	*-- Propriedades da tabela SigCdBch
	this_nCodigos  = 0
	this_cOperacaos = ""
	this_dDataInis = {}
	this_dDataFims = {}
	this_lEncerras = .F.
	this_nTipos    = 0
	this_cGrupos   = ""
	this_cContas   = ""
	this_lGrvs     = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdBch"
			THIS.this_cCampoChave = "Codigos"
			loc_lResultado = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Busca registros de SigCdBch
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
				loc_cWhere = " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch" + loc_cWhere + " ORDER BY codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros de Balan" + CHR(231) + "o de Cheques: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir de cursor
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_nCodigos   = TratarNulo(codigos,   "N")
				THIS.this_cOperacaos = TratarNulo(operacaos, "C")
				THIS.this_dDataInis  = TratarNulo(datainis,  "D")
				THIS.this_dDataFims  = TratarNulo(datafims,  "D")
				THIS.this_nTipos     = TratarNulo(tipos,     "N")
				THIS.this_cGrupos    = TratarNulo(grupos,    "C")
				THIS.this_cContas    = TratarNulo(contas,    "C")
				THIS.this_lEncerras  = ConverterParaLogico(encerras)
				THIS.this_lGrvs      = ConverterParaLogico(grvs)
				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nNovoCodigo
		loc_lResultado = .F.

		TRY
			*-- Gerar novo codigo (PK)
			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT ISNULL(MAX(codigos),0)+1 AS proximo FROM SigCdBch", ;
				"cursor_4c_ProxCod")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nNovoCodigo = proximo
			ELSE
				loc_nNovoCodigo = 1
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF

			THIS.this_nCodigos = loc_nNovoCodigo

			loc_cSQL = "INSERT INTO SigCdBch" + ;
					   " (codigos, operacaos, datainis, datafims, tipos," + ;
					   "  grupos, contas, encerras, grvs)" + ;
					   " VALUES (" + ;
					   FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   IIF(THIS.this_lGrvs, "1", "0") + ;
					   ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET" + ;
					   " operacaos = " + EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   " datainis  = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   " datafims  = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   " tipos     = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   " grupos    = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   " contas    = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   " encerras  = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   " grvs      = " + IIF(THIS.this_lGrvs, "1", "0") + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdBch
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
					"vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			THIS.RegistrarAuditoria("DELETE")

			loc_cSQL = "DELETE FROM SigCdBch WHERE codigos = " + ;
					   FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* EncerrarBalanco - Encerra o balanco de cheques (DataFims + Encerras=.T.)
	*====================================================================
	PROCEDURE EncerrarBalanco()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("Balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "UPDATE SigCdBch SET datafims = GETDATE(), encerras = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lEncerras = .T.
				THIS.this_dDataFims = DATE()
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao encerrar balan" + CHR(231) + "o: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* MarcarGravado - Define Grvs=1 em SigCdBch apos gravar leitura
	*====================================================================
	PROCEDURE MarcarGravado()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET grvs = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lGrvs = .T.
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao marcar gravado: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

