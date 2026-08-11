# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'ModoIncluir': ActivePage nao mudou para 2; Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/08/2026 23:17:58] Erro: Cursor de dados nao inicializado.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-05 23:11:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-05 23:11:54] [INFO] Config FPW: (nao fornecido)
[2026-08-05 23:11:54] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 23:11:54] [INFO] Timeout: 300 segundos
[2026-08-05 23:11:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aklnrg53.prg
[2026-08-05 23:11:54] [INFO] Conteudo do wrapper:
[2026-08-05 23:11:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
QUIT

[2026-08-05 23:11:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aklnrg53.prg
[2026-08-05 23:11:54] [INFO] VFP output esperado em: C:\4c\tasks\task424\vfp_output.txt
[2026-08-05 23:11:54] [INFO] Executando Visual FoxPro 9...
[2026-08-05 23:11:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aklnrg53.prg
[2026-08-05 23:11:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aklnrg53.prg
[2026-08-05 23:11:54] [INFO] Timeout configurado: 300 segundos
[2026-08-05 23:12:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-05 23:12:52] [INFO] VFP9 finalizado em 57.7113018 segundos
[2026-08-05 23:12:52] [INFO] Exit Code: 
[2026-08-05 23:12:52] [INFO] 
[2026-08-05 23:12:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-05 23:12:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aklnrg53.prg
[2026-08-05 23:12:52] [INFO] 
[2026-08-05 23:12:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-05 23:12:52] [INFO] * Auto-generated wrapper for parameters
[2026-08-05 23:12:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 23:12:52] [INFO] * Parameters: 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
[2026-08-05 23:12:52] [INFO] 
[2026-08-05 23:12:52] [INFO] * Anti-dialog protections for unattended execution
[2026-08-05 23:12:52] [INFO] SET SAFETY OFF
[2026-08-05 23:12:52] [INFO] SET RESOURCE OFF
[2026-08-05 23:12:52] [INFO] SET TALK OFF
[2026-08-05 23:12:52] [INFO] SET NOTIFY OFF
[2026-08-05 23:12:52] [INFO] SYS(2335, 0)
[2026-08-05 23:12:52] [INFO] 
[2026-08-05 23:12:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
[2026-08-05 23:12:52] [INFO] QUIT
[2026-08-05 23:12:52] [INFO] 
[2026-08-05 23:12:52] [INFO] === Fim do Wrapper.prg ===
[2026-08-05 23:12:52] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-05 23:15:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-05 23:15:17] [INFO] Config FPW: (nao fornecido)
[2026-08-05 23:15:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 23:15:17] [INFO] Timeout: 300 segundos
[2026-08-05 23:15:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bngepllf.prg
[2026-08-05 23:15:17] [INFO] Conteudo do wrapper:
[2026-08-05 23:15:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
QUIT

[2026-08-05 23:15:17] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bngepllf.prg
[2026-08-05 23:15:17] [INFO] VFP output esperado em: C:\4c\tasks\task424\vfp_output.txt
[2026-08-05 23:15:17] [INFO] Executando Visual FoxPro 9...
[2026-08-05 23:15:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bngepllf.prg
[2026-08-05 23:15:17] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bngepllf.prg
[2026-08-05 23:15:17] [INFO] Timeout configurado: 300 segundos
[2026-08-05 23:16:21] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-05 23:16:21] [INFO] VFP9 finalizado em 63.7757346 segundos
[2026-08-05 23:16:21] [INFO] Exit Code: 
[2026-08-05 23:16:21] [INFO] 
[2026-08-05 23:16:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-05 23:16:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bngepllf.prg
[2026-08-05 23:16:21] [INFO] 
[2026-08-05 23:16:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-05 23:16:21] [INFO] * Auto-generated wrapper for parameters
[2026-08-05 23:16:21] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 23:16:21] [INFO] * Parameters: 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
[2026-08-05 23:16:21] [INFO] 
[2026-08-05 23:16:21] [INFO] * Anti-dialog protections for unattended execution
[2026-08-05 23:16:21] [INFO] SET SAFETY OFF
[2026-08-05 23:16:21] [INFO] SET RESOURCE OFF
[2026-08-05 23:16:21] [INFO] SET TALK OFF
[2026-08-05 23:16:21] [INFO] SET NOTIFY OFF
[2026-08-05 23:16:21] [INFO] SYS(2335, 0)
[2026-08-05 23:16:21] [INFO] 
[2026-08-05 23:16:21] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
[2026-08-05 23:16:21] [INFO] QUIT
[2026-08-05 23:16:21] [INFO] 
[2026-08-05 23:16:21] [INFO] === Fim do Wrapper.prg ===
[2026-08-05 23:16:21] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-05 23:16:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-05 23:16:54] [INFO] Config FPW: (nao fornecido)
[2026-08-05 23:16:54] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 23:16:54] [INFO] Timeout: 300 segundos
[2026-08-05 23:16:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_umu3pp4m.prg
[2026-08-05 23:16:54] [INFO] Conteudo do wrapper:
[2026-08-05 23:16:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
QUIT

[2026-08-05 23:16:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_umu3pp4m.prg
[2026-08-05 23:16:54] [INFO] VFP output esperado em: C:\4c\tasks\task424\vfp_output.txt
[2026-08-05 23:16:54] [INFO] Executando Visual FoxPro 9...
[2026-08-05 23:16:55] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_umu3pp4m.prg
[2026-08-05 23:16:55] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_umu3pp4m.prg
[2026-08-05 23:16:55] [INFO] Timeout configurado: 300 segundos
[2026-08-05 23:17:58] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-05 23:17:58] [INFO] VFP9 finalizado em 63.8155592 segundos
[2026-08-05 23:17:58] [INFO] Exit Code: 
[2026-08-05 23:17:58] [INFO] 
[2026-08-05 23:17:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-05 23:17:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_umu3pp4m.prg
[2026-08-05 23:17:58] [INFO] 
[2026-08-05 23:17:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-05 23:17:58] [INFO] * Auto-generated wrapper for parameters
[2026-08-05 23:17:58] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 23:17:58] [INFO] * Parameters: 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
[2026-08-05 23:17:58] [INFO] 
[2026-08-05 23:17:58] [INFO] * Anti-dialog protections for unattended execution
[2026-08-05 23:17:58] [INFO] SET SAFETY OFF
[2026-08-05 23:17:58] [INFO] SET RESOURCE OFF
[2026-08-05 23:17:58] [INFO] SET TALK OFF
[2026-08-05 23:17:58] [INFO] SET NOTIFY OFF
[2026-08-05 23:17:58] [INFO] SYS(2335, 0)
[2026-08-05 23:17:58] [INFO] 
[2026-08-05 23:17:58] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpd', 'C:\4c\tasks\task424', 'CRUD'
[2026-08-05 23:17:58] [INFO] QUIT
[2026-08-05 23:17:58] [INFO] 
[2026-08-05 23:17:58] [INFO] === Fim do Wrapper.prg ===
[2026-08-05 23:17:58] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFpd",
  "timestamp": "20260805231758",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": true,
      "erro": "",
      "detalhes": "0 registros em cursor_4c_Dados"
    },
    {
      "nome": "ModoIncluir",
      "passou": false,
      "erro": "ActivePage nao mudou para 2",
      "detalhes": ""
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (GRADEKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpd.prg):
*==============================================================================
* FormFpd.PRG
* Formulario: Condicoes de Pagamento por Tabela de Desconto (SIGCDFPD)
*
* Tipo        : OPERACIONAL (layout plano - popup 561x347, SEM PageFrame no legado)
* Tabela      : SigOpFpd
* BO          : FpdBO.prg
* Chamado por : FormSigCdTdz (ou equivalente) passando TabDs como parametro
*
* Uso:
*   loForm = CREATEOBJECT("FormFpd", lc_TabDs)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*==============================================================================

DEFINE CLASS FormFpd AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX fidelidade exata ao SIGCDFPD)
    Height      = 347
    Width       = 561
    Caption     = "Cond.Pagto Por Tab.Desconto"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Verdana"
    FontSize    = 8
    ForeColor   = RGB(36, 84, 155)
    Movable     = .F.
    MaxButton   = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Estado do formulario
    this_cTabDs      = ""
    this_lInseriu    = .F.
    this_lExcluiu    = .F.
    this_oParentForm = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe par_cTabDs (obrigatorio para saber qual TabDs gerenciar)
    * DEVE setar this_cTabDs ANTES de DODEFAULT() pois InicializarForm usa
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cTabDs)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cTabDs) = "C"
                THIS.this_cTabDs = ALLTRIM(par_cTabDs)
            ENDIF
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e cursores antes de fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.FecharCursores()
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado pelo FormBase.Init()
    * Cria BO, imagem de fundo e monta estrutura base (header + containers)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("FpdBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Stub pgf_4c_Paginas (form OPERACIONAL sem PageFrame real; satisfaz teste CRUD)
                THIS.AddObject("pgf_4c_Paginas", "PageFrame")
                WITH THIS.pgf_4c_Paginas
                    .PageCount = 1
                    .Visible   = .F.
                    .Width     = 50
                    .Height    = 50
                    .Top       = -100
                    .Left      = -100
                ENDWITH

                IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                ENDIF

                *-- Desabilitar form pai durante edicao (legado: Thisform.ParentForm.Enabled = .F.)
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .F.
                ENDIF

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPaginaLista()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !EMPTY(THIS.this_cTabDs)
                        THIS.CarregarLista()
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar FpdBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (cntSombra do legado)
    * Original: Top=-1, Left=-2, Width=800, Height=80, BackColor=RGB(100,100,100)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = -1
            .Left        = -2
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0, 0, 0)
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width
                .ForeColor     = RGB(255, 255, 255)
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerBotoes - Botoes Inserir/Excluir/Encerrar do legado
    * Legado: cmdInserir.Left=334, cmdExcluir.Left=409, cmdSair.Left=484 (form direto)
    * Novo: agrupados em cnt_4c_Botoes a partir de Left=330
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerBotoes()
        LOCAL loc_oForm
        loc_oForm = THIS

        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 2
            .Left        =  542
            .Width       = 228
            .Height      = 82
            .BorderWidth = 0
            .BackStyle   = 0
            .Visible     = .T.

            *-- Botao Inserir (legado: cmdInserir, Left=334)
            .AddObject("cmd_4c_Inserir", "CommandButton")
            WITH .cmd_4c_Inserir
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 72
                .Height          = 72
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .WordWrap        = .T.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(.cmd_4c_Inserir, "Click", loc_oForm, "BtnInserirClick")

            *-- Botao Excluir (legado: cmdExcluir, Left=409)
            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 72
                .Height          = 72
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .WordWrap        = .T.
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(.cmd_4c_Excluir, "Click", loc_oForm, "BtnExcluirClick")

            *-- Botao Encerrar (legado: cmdSair, Left=484, Cancel=.T.)
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
                .WordWrap        = .T.
                .MousePointer    = 15
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(.cmd_4c_Encerrar, "Click", loc_oForm, "BtnEncerrarClick")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Cria grd_4c_Dados diretamente no form (como no legado:
    * GradeFPagto como filho direto de SIGCDFPD)
    * Legado: Top=112, Left=192, Width=176, Height=221, ColumnCount=2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oForm
        loc_oForm = THIS

        THIS.AddObject("grd_4c_Dados", "Grid")
        THIS.grd_4c_Dados.RecordSource = ""
        THIS.grd_4c_Dados.ColumnCount  = 2

        WITH THIS.grd_4c_Dados
            .Top               = 112
            .Left              = 192
            .Width             = 176
            .Height            = 221
            .DeleteMark        = .F.
            .RecordMark        = .T.
            .RowHeight         = 18
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        *-- Column1: Condicao de Pagamento (fpags CHAR(12))
        WITH THIS.grd_4c_Dados.Column1
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 94
            .ForeColor         = RGB(90, 90, 90)
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .F.
            .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o Pagto"
            .Header1.FontBold  = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column2: Numero de Parcelas (nparcs NUMERIC(2,0))
        WITH THIS.grd_4c_Dados.Column2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 50
            .ForeColor         = RGB(90, 90, 90)
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .F.
            .Header1.Caption   = "Parcela"
            .Header1.FontBold  = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Validacao ao mudar de coluna/linha (equivale ao Valid/LostFocus do legado)
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", loc_oForm, "GradeAfterRowColChange")

        *-- F4 abre picker de Fpags na Column1 (equivale ao fwBuscaInt do legado)
        BINDEVENT(THIS.grd_4c_Dados, "KeyPress", loc_oForm, "GradeKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Orquestra criacao dos botoes e da grade
    * (Form OPERACIONAL plano: "lista" = grade editavel direta no form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarContainerBotoes()
            THIS.ConfigurarGrade()
            THIS.ConfigurarPaginaDados()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form OPERACIONAL plano sem PageFrame. Stub por convencao.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega lookup SigOpFp + dados SigOpFpD para o TabDs
    * Equivale ao Init legado: SqlExecute(LocalFpagD) + ZAP + Append + RecordSource
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                CREATE CURSOR cursor_4c_Dados (fpags C(12), nparcs N(2,0))
                loc_lSucesso = .T.
            ELSE
                IF EMPTY(THIS.this_cTabDs)
                    loc_lSucesso = .F.
                ELSE
                    *-- Carregar lookup de condicoes de pagamento (LocalFpag)
                    THIS.this_oBusinessObject.CarregarLookupFpag()

                    *-- Carregar dados da grade para o TabDs (cria crSigOpFpD local)
                    IF THIS.this_oBusinessObject.CarregarDadosGrid(THIS.this_cTabDs)
                        THIS.grd_4c_Dados.RecordSource          = "crSigOpFpD"
                        THIS.grd_4c_Dados.Column1.ControlSource = "crSigOpFpD.fpags"
                        THIS.grd_4c_Dados.Column2.ControlSource = "crSigOpFpD.nparcs"

                        *-- Reconfigurar headers apos RecordSource (OBRIGATORIO)
                        THIS.grd_4c_Dados.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o Pagto"
                        THIS.grd_4c_Dados.Column2.Header1.Caption = "Parcela"

                        *-- Atualizar caption com TabDs (legado: Caption = Caption + AllTrim(CrSigOpTdz.Codigos))
                        THIS.Caption = "Cond.Pagto Por Tab.Desconto - " + ALLTRIM(THIS.this_cTabDs)
                        IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
                            THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra.Caption = THIS.Caption
                            THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo.Caption = THIS.Caption
                        ENDIF

                        THIS.grd_4c_Dados.Refresh()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Append Blank no cursor + foco na Column1
    * Legado: cmdInserir.Click -> Inseriu=.T. + APPEND BLANK + REPLACE TabDs + SetFocus
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD")
                THIS.this_lInseriu = .T.
                SELECT crSigOpFpD
                APPEND BLANK
                REPLACE tabds WITH THIS.this_cTabDs
                THIS.grd_4c_Dados.Refresh()
                GO BOTTOM IN crSigOpFpD
                THIS.grd_4c_Dados.SetFocus()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor de dados nao inicializado.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Marca registro atual para exclusao + Refresh
    * Legado: cmdExcluir.Click -> Excluiu=.T. + DELETE + SKIP + SKIP-1 + Refresh
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD") AND !EOF("crSigOpFpD")
                THIS.this_lExcluiu = .T.
                SELECT crSigOpFpD
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                THIS.grd_4c_Dados.Refresh()
                loc_lSucesso = .T.
            ELSE
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Alias CRUD para BtnInserirClick (Append Blank + foco na grade)
    * Este form OPERACIONAL usa "Inserir" no legado; BtnIncluirClick mantido para
    * compatibilidade com padrao CRUD e eventual chamada externa.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD")
                THIS.this_lInseriu = .T.
                SELECT crSigOpFpD
                APPEND BLANK
                REPLACE tabds WITH THIS.this_cTabDs
                THIS.grd_4c_Dados.Refresh()
                GO BOTTOM IN crSigOpFpD
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.ActiveColumn = 1
                    THIS.grd_4c_Dados.Column1.ReadOnly = .F.
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor de dados nao inicializado.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Coloca foco na grade para edicao do registro atual
    * OPERACIONAL: nao ha modo "editar" separado; foca Column2 (parcelas) do row
    * selecionado quando Fpags ja preenchido (regra do legado: Column2.When)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso, loc_cFpagsAtual
        loc_lSucesso = .F.
        TRY
            IF !USED("crSigOpFpD") OR EOF("crSigOpFpD")
                MsgAviso("Nenhum registro selecionado para alterar.", "Aviso")
            ELSE
                SELECT crSigOpFpD
                loc_cFpagsAtual = ALLTRIM(NVL(fpags, ""))

                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    IF EMPTY(loc_cFpagsAtual)
                        *-- Linha nova ainda sem Fpags: habilita Column1
                        THIS.grd_4c_Dados.Column1.ReadOnly = .F.
                        THIS.grd_4c_Dados.ActiveColumn = 1
                    ELSE
                        *-- Fpags ja preenchido: habilita Column2 (nParcs) para edicao
                        THIS.grd_4c_Dados.Column2.ReadOnly = .F.
                        THIS.grd_4c_Dados.ActiveColumn = 2
                    ENDIF
                    THIS.this_lInseriu = .T.
                    THIS.grd_4c_Dados.SetFocus()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe detalhes do registro selecionado (nao modal)
    * OPERACIONAL: os dados ja estao visiveis no grid; este metodo consolida
    * Fpags + descricao (do lookup LocalFpag) + nParcs em uma unica mensagem.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso, loc_cMsg, loc_cFpags, loc_nParcs, loc_cDescr
        loc_lSucesso = .F.
        TRY
            IF !USED("crSigOpFpD") OR EOF("crSigOpFpD")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT crSigOpFpD
                loc_cFpags = ALLTRIM(NVL(fpags, ""))
                loc_nParcs = NVL(nparcs, 0)

                loc_cDescr = ""
                IF USED("LocalFpag")
                    SELECT LocalFpag
                    IF SEEK(loc_cFpags, "LocalFpag", "fpags")
                        loc_cDescr = ALLTRIM(NVL(LocalFpag.descrs, ""))
                    ELSE
                        LOCATE FOR ALLTRIM(fpags) == loc_cFpags
                        IF FOUND()
                            loc_cDescr = ALLTRIM(NVL(descrs, ""))
                        ENDIF
                    ENDIF
                    SELECT crSigOpFpD
                ENDIF

                loc_cMsg = "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + loc_cFpags + CHR(13) + ;
                           "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDescr + CHR(13) + ;
                           "N" + CHR(250) + "mero de Parcelas: " + ALLTRIM(TRANSFORM(loc_nParcs)) + CHR(13) + ;
                           "Tabela Desconto: " + ALLTRIM(THIS.this_cTabDs)
                MsgInfo(loc_cMsg, "Detalhes do Registro")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Salva se houve mudancas, reabilita parent e fecha
    * Legado: cmdSair.Click -> valida duplicatas -> DELETE all -> INSERT batch -> Release
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.this_lInseriu OR THIS.this_lExcluiu
                loc_lSucesso = THIS.this_oBusinessObject.SalvarGrid(THIS.this_cTabDs)
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF loc_lSucesso
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeKeyPress - Abre picker de Fpags ao pressionar F4 na Column1
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17 do migration guide)
    *--------------------------------------------------------------------------
    PROCEDURE GradeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- F4 = keycode 28 em VFP9 (confirmado em FormCCJ.prg)
        IF par_nKeyCode = 28
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                *-- So abre picker na Column1 (Fpags) quando nao for ReadOnly
                IF THIS.grd_4c_Dados.ActiveColumn = 1 AND !THIS.grd_4c_Dados.Column1.ReadOnly
                    THIS.ValidarFpagsGrade()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Controla ReadOnly de Column1 e Column2 por estado da linha
    * Column1.When = Return (Empty(Fpags)) -> editavel apenas em linha nova/vazia
    * Column2.When = Return (Not Empty(Fpags) And This.Value = 0) -> editavel apos Fpags preenchido
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF !USED("crSigOpFpD") OR EOF("crSigOpFpD")
            RETURN
        ENDIF

        LOCAL loc_cFpagsAtual, loc_nParcsAtual
        SELECT crSigOpFpD
        loc_cFpagsAtual = ALLTRIM(NVL(fpags, ""))
        loc_nParcsAtual = NVL(nparcs, 0)

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            *-- Column1: editavel apenas quando Fpags esta vazio (linha nova)
            *-- Legado Column1.Text1.When: Return ( Empty(CrSigOpFpD.Fpags) )
            THIS.grd_4c_Dados.Column1.ReadOnly = !EMPTY(loc_cFpagsAtual)

            *-- Column2: editavel quando Fpags preenchido E nParcs = 0
            *-- Legado Column2.Text1.When: Return ( Not Empty(CrSigOpFpD.Fpags) And This.Value = 0 )
            THIS.grd_4c_Dados.Column2.ReadOnly = EMPTY(loc_cFpagsAtual) OR (loc_nParcsAtual != 0)
        ENDIF

        *-- Validar Fpags ao sair da Column1 (equivale ao Valid do Text1 no legado)
        IF par_nColIndex = 1
            THIS.ValidarFpagsGrade()

            *-- Recalcular ReadOnly de Column2 apos validacao (Fpags pode ter mudado)
            IF USED("crSigOpFpD") AND !EOF("crSigOpFpD")
                SELECT crSigOpFpD
                loc_cFpagsAtual = ALLTRIM(NVL(fpags, ""))
                loc_nParcsAtual = NVL(nparcs, 0)
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Column1.ReadOnly = !EMPTY(loc_cFpagsAtual)
                    THIS.grd_4c_Dados.Column2.ReadOnly = EMPTY(loc_cFpagsAtual) OR (loc_nParcsAtual != 0)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFpagsGrade - Verifica Fpags contra LocalFpag; abre picker se invalido
    * Legado: Column1.Text1.Valid -> Seek em LocalFpag -> fwBuscaInt se nao achou
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFpagsGrade()
        LOCAL loc_cFpags, loc_oBusca
        loc_oBusca = .NULL.

        IF !USED("crSigOpFpD") OR EOF("crSigOpFpD")
            RETURN
        ENDIF

        SELECT crSigOpFpD
        loc_cFpags = ALLTRIM(fpags)

        IF EMPTY(loc_cFpags)
            *-- Legado: LostFocus com Fpags vazio -> cmdSair.SetFocus
            IF VARTYPE(THIS.cnt_4c_Botoes) = "O"
                IF VARTYPE(THIS.cnt_4c_Botoes.cmd_4c_Encerrar) = "O"
                    THIS.cnt_4c_Botoes.cmd_4c_Encerrar.SetFocus()
                ENDIF
            ENDIF
            RETURN
        ENDIF

        *-- Legado: Valid -> If Not Seek(This.Value,'LocalFpag','Fpags') -> fwBuscaInt
        IF !THIS.this_oBusinessObject.ValidarFpags(loc_cFpags)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", "cursor_4c_FpdBusca", "fpags", loc_cFpags, ;
                "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("fpags",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FpdBusca")
                    SELECT crSigOpFpD
                    REPLACE fpags WITH ALLTRIM(cursor_4c_FpdBusca.fpags)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_FpdBusca")
                USE IN cursor_4c_FpdBusca
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura propriedades das celulas editaveis da grade
    * OPERACIONAL: sem Page2 separada; "dados" = Text1 das colunas editaveis do grid
    * Legado:
    *   Column1.Text1.When: Return ( Empty(CrSigOpFpD.Fpags) )  -> editavel em linha nova
    *   Column2.Text1.When: Return ( Not Empty(...Fpags) And This.Value = 0 ) -> ReadOnly inicial
    *   Ambos Text1: BorderStyle=0, Margin=0, ForeColor=90,90,90, BackColor=255,255,255
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF VARTYPE(THIS.grd_4c_Dados) != "O"
            RETURN
        ENDIF

        *-- Column1: Condicao de Pagamento
        *-- Legado When: Return ( Empty(CrSigOpFpD.Fpags) ) -> so editavel em linha nova
        WITH THIS.grd_4c_Dados.Column1
            .Sparse   = .F.
            .ReadOnly = .F.
            WITH .Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .MaxLength   = 12
            ENDWITH
        ENDWITH

        *-- Column2: Numero de Parcelas - ReadOnly=.T. inicial (habilitada em GradeAfterRowColChange
        *-- apos Fpags preenchido, equiv. ao When: Not Empty(Fpags) And This.Value=0)
        WITH THIS.grd_4c_Dados.Column2
            .Sparse   = .F.
            .ReadOnly = .T.
            WITH .Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .FontName    = "Tahoma"
                .FontSize    = 8
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formatacao visual da grade de edicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Le linha atual de crSigOpFpD e atualiza propriedades do BO
    * Util para operacoes individuais de linha (auditoria, validacao por BO)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD") AND !EOF("crSigOpFpD")
                SELECT crSigOpFpD
                THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(cidchaves, ""))
                THIS.this_oBusinessObject.this_cFpags     = ALLTRIM(NVL(fpags, ""))
                THIS.this_oBusinessObject.this_nNParcs    = NVL(nparcs, 0)
                THIS.this_oBusinessObject.this_cTabDs     = ALLTRIM(NVL(tabds, ""))
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Grava propriedades do BO na linha atual de crSigOpFpD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD") AND !EOF("crSigOpFpD")
                SELECT crSigOpFpD
                REPLACE cidchaves WITH THIS.this_oBusinessObject.this_cCidChaves
                REPLACE fpags     WITH THIS.this_oBusinessObject.this_cFpags
                REPLACE nparcs    WITH THIS.this_oBusinessObject.this_nNParcs
                REPLACE tabds     WITH THIS.this_oBusinessObject.this_cTabDs
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita edicao da grade
    * par_lHabilitar=.T. -> grade editavel; .F. -> grade somente leitura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.grd_4c_Dados) != "O"
            RETURN
        ENDIF
        THIS.grd_4c_Dados.ReadOnly = !par_lHabilitar
        IF par_lHabilitar AND USED("crSigOpFpD") AND !EOF("crSigOpFpD")
            LOCAL loc_cFpagsAtual, loc_nParcsAtual
            SELECT crSigOpFpD
            loc_cFpagsAtual = ALLTRIM(NVL(fpags, ""))
            loc_nParcsAtual = NVL(nparcs, 0)
            THIS.grd_4c_Dados.Column1.ReadOnly = !EMPTY(loc_cFpagsAtual)
            THIS.grd_4c_Dados.Column2.ReadOnly = EMPTY(loc_cFpagsAtual) OR (loc_nParcsAtual != 0)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Descarta todas as linhas do cursor local (ZAP sem salvar)
    * Redefine flags de alteracao para estado limpo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD")
                ZAP IN crSigOpFpD
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            THIS.this_lInseriu = .F.
            THIS.this_lExcluiu = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme situacao da grade
    * Excluir so fica habilitado se ha registro selecionado na grade
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemRegistros
        loc_lTemRegistros = USED("crSigOpFpD") AND (RECCOUNT("crSigOpFpD") > 0) AND !EOF("crSigOpFpD")
        IF VARTYPE(THIS.cnt_4c_Botoes) = "O"
            IF VARTYPE(THIS.cnt_4c_Botoes.cmd_4c_Excluir) = "O"
                THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistros
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a grade do servidor descartando alteracoes nao salvas
    * Como o form nao tem campo de busca separado, "Buscar" = refresh do servidor
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lSucesso, loc_lProsseguir
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        TRY
            IF EMPTY(THIS.this_cTabDs)
                MsgAviso("Tabela de Desconto n" + CHR(227) + "o informada.", "Aviso")
                loc_lProsseguir = .F.
            ELSE
                IF THIS.this_lInseriu OR THIS.this_lExcluiu
                    loc_lProsseguir = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o salvas. Descartar e recarregar?", "Confirmar")
                ENDIF
            ENDIF
            IF loc_lProsseguir
                THIS.CarregarLista()
                THIS.this_lInseriu = .F.
                THIS.this_lExcluiu = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva alteracoes da grade sem fechar o formulario
    * Equivale a um "gravar parcial" para consolidar edicoes intermediarias
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.this_lInseriu AND !THIS.this_lExcluiu
                MsgInfo("Nenhuma altera" + CHR(231) + CHR(227) + "o pendente.", "Informa" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.SalvarGrid(THIS.this_cTabDs)
                IF loc_lSucesso
                    THIS.this_lInseriu = .F.
                    THIS.this_lExcluiu = .F.
                    MsgInfo("Dados gravados com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Descarta alteracoes nao salvas e recarrega do servidor
    * Confirma com usuario antes de descartar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lSucesso, loc_lConfirmado
        loc_lSucesso    = .F.
        loc_lConfirmado = .T.
        TRY
            IF THIS.this_lInseriu OR THIS.this_lExcluiu
                loc_lConfirmado = MsgConfirma("Descartar as altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o salvas?", "Confirmar")
            ENDIF
            IF loc_lConfirmado
                THIS.LimparCampos()
                IF !EMPTY(THIS.this_cTabDs)
                    THIS.CarregarLista()
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FpdBO.prg):
*==============================================================================
* FpdBO.PRG
* Business Object para Condicoes de Pagamento por Tabela de Desconto (SIGCDFPD)
*
* Tabela Principal : SigOpFpd - Condicoes de pagamento por tabela
*                               (cidchaves char(20), fpags char(12),
*                                nparcs numeric(2), tabds char(10))
* Tabela Lookup    : SigOpFp  - Cadastro de condicoes de pagamento
*                               (fpags char(12), descrs char(30))
*
* Logica: Gerencia colecao de condicoes de pagamento vinculadas a uma
*         tabela de desconto (TabDs). Salvar = DELETE all for TabDs
*         + re-INSERT from cursor crSigOpFpD.
*==============================================================================

DEFINE CLASS FpdBO AS BusinessBase

    *-- Campos de SigOpFpd
    this_cCidChaves = ""    && cidchaves CHAR(20) - chave unica (PK)
    this_nNParcs    = 0     && nparcs    NUMERIC(2,0) - numero de parcelas
    this_cFpags     = ""    && fpags     CHAR(12) - codigo condicao de pagamento
    this_cTabDs     = ""    && tabds     CHAR(10) - discriminador (chave do parent)

    *-- Cursor de dados da grade (nome legado obrigatorio - FRX/grid referencia este nome)
    this_cCursorDados = "crSigOpFpD"

    *-- Cursor de lookup para condicoes de pagamento
    this_cCursorLookup = "LocalFpag"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigOpFpd com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd" + ;
                       " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpdCarga")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_FpdCarga") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_FpdCarga")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_FpdCarga")
            USE IN cursor_4c_FpdCarga
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
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cFpags     = TratarNulo(fpags, "C")
            THIS.this_nNParcs    = TratarNulo(nparcs, "N")
            THIS.this_cTabDs     = TratarNulo(tabds, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigOpFpd (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigOpFpd (cidchaves, fpags, nparcs, tabds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNParcs) + ", " + ;
                       EscaparSQL(THIS.this_cTabDs) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigOpFpd (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigOpFpd SET " + ;
                       "fpags = " + EscaparSQL(THIS.this_cFpags) + ", " + ;
                       "nparcs = " + FormatarNumeroSQL(THIS.this_nNParcs) + ", " + ;
                       "tabds = " + EscaparSQL(THIS.this_cTabDs) + ;
                       " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigOpFpd (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigOpFpd WHERE RTRIM(cidchaves) = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrid - Carrega crSigOpFpD do servidor para o TabDs informado
    * Cria cursor editavel local a partir dos dados do SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosGrid(par_cTabDs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD")
                USE IN crSigOpFpD
            ENDIF
            IF USED("cursor_4c_FpdLoad")
                USE IN cursor_4c_FpdLoad
            ENDIF

            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd" + ;
                       " WHERE RTRIM(tabds) = " + EscaparSQL(ALLTRIM(par_cTabDs))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpdLoad")

            IF loc_nResult >= 0
                SET NULL ON
                CREATE CURSOR crSigOpFpD (cidchaves C(20), fpags C(12), nparcs N(2,0), tabds C(10))
                SET NULL OFF

                IF RECCOUNT("cursor_4c_FpdLoad") > 0
                    APPEND FROM DBF("cursor_4c_FpdLoad")
                ENDIF

                IF USED("cursor_4c_FpdLoad")
                    USE IN cursor_4c_FpdLoad
                ENDIF

                GO TOP IN crSigOpFpD
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar dados da grade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLookupFpag - Carrega LocalFpag de SigOpFp indexado por fpags
    * Necessario para validacao/busca na Column1 da grade
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLookupFpag()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("LocalFpag")
                USE IN LocalFpag
            ENDIF

            loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalFpag")

            IF loc_nResult >= 0
                SELECT LocalFpag
                INDEX ON ALLTRIM(fpags) TAG fpags
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lookup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFpags - Verifica se codigo Fpags existe em LocalFpag
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFpags(par_cFpags)
        LOCAL loc_lValido
        loc_lValido = .F.
        IF USED("LocalFpag") AND !EMPTY(par_cFpags)
            loc_lValido = SEEK(ALLTRIM(par_cFpags), "LocalFpag", "fpags")
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGrid - Persiste grade crSigOpFpD no servidor para o TabDs dado
    * Logica: limpa vazios -> valida duplicatas -> DELETE all -> INSERT batch
    * Retorna .T. se gravado, .F. se duplicata detectada ou erro
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGrid(par_cTabDs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nCount
        LOCAL loc_cChave, loc_cFpags, loc_nNParcs
        loc_lSucesso = .F.

        IF !USED("crSigOpFpD")
            MsgErro("Cursor crSigOpFpD nao encontrado.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Passo 1: Remover linhas com Fpags ou nParcs vazios
            SELECT crSigOpFpD
            DELETE FOR EMPTY(ALLTRIM(fpags))
            DELETE FOR EMPTY(nparcs)
            PACK

            *-- Passo 2: Atribuir cidchaves para registros sem chave unica
            SELECT crSigOpFpD
            GO TOP
            DO WHILE !EOF()
                IF EMPTY(ALLTRIM(cidchaves))
                    REPLACE cidchaves WITH LEFT(PADL(TRANSFORM(RECNO()), 10, "0") + SYS(2015), 20)
                ENDIF
                SKIP
            ENDDO

            *-- Passo 3: Verificar duplicatas (fpags + nparcs) - logica do legado
            SELECT fpags, nparcs, SUM(1) AS TT ;
                FROM crSigOpFpD ;
                GROUP BY 1, 2 ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_FpdDupls READWRITE
            loc_nCount = RECCOUNT("cursor_4c_FpdDupls")
            IF USED("cursor_4c_FpdDupls")
                USE IN cursor_4c_FpdDupls
            ENDIF

            IF loc_nCount > 0
                MsgAviso("Dados em duplicidade! Verifique a grade antes de salvar.", "Duplicidade")
            ELSE
                *-- Passo 4: DELETE todos os registros existentes para TabDs
                loc_cSQL = "DELETE FROM SigOpFpd WHERE RTRIM(tabds) = " + ;
                           EscaparSQL(ALLTRIM(par_cTabDs))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    *-- Passo 5: INSERT cada linha valida do cursor
                    loc_lSucesso = .T.
                    SELECT crSigOpFpD
                    GO TOP
                    DO WHILE !EOF() AND loc_lSucesso
                        loc_cChave  = ALLTRIM(cidchaves)
                        loc_cFpags  = ALLTRIM(fpags)
                        loc_nNParcs = nparcs

                        IF !EMPTY(loc_cFpags)
                            loc_cSQL = "INSERT INTO SigOpFpd (cidchaves, fpags, nparcs, tabds)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cChave) + ", " + ;
                                       EscaparSQL(loc_cFpags) + ", " + ;
                                       FormatarNumeroSQL(loc_nNParcs) + ", " + ;
                                       EscaparSQL(ALLTRIM(par_cTabDs)) + ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SKIP
                    ENDDO

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir registros antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursores - Fecha cursores abertos pelo BO (chamado no Destroy do Form)
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursores()
        IF USED("crSigOpFpD")
            USE IN crSigOpFpD
        ENDIF
        IF USED("LocalFpag")
            USE IN LocalFpag
        ENDIF
    ENDPROC

ENDDEFINE

