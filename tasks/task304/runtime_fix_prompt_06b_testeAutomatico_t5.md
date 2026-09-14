# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 5/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigprimp
Erro: Property FORECOLOR is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-17 11:28:31] [INFO] Config FPW: (nao fornecido)
[2026-07-17 11:28:31] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 11:28:31] [INFO] Timeout: 300 segundos
[2026-07-17 11:28:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tsihq1i1.prg
[2026-07-17 11:28:31] [INFO] Conteudo do wrapper:
[2026-07-17 11:28:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
QUIT

[2026-07-17 11:28:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tsihq1i1.prg
[2026-07-17 11:28:31] [INFO] VFP output esperado em: C:\4c\tasks\task304\vfp_output.txt
[2026-07-17 11:28:31] [INFO] Executando Visual FoxPro 9...
[2026-07-17 11:28:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tsihq1i1.prg
[2026-07-17 11:28:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tsihq1i1.prg
[2026-07-17 11:28:31] [INFO] Timeout configurado: 300 segundos
[2026-07-17 11:29:19] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-17 11:29:19] [INFO] VFP9 finalizado em 47.6815413 segundos
[2026-07-17 11:29:19] [INFO] Exit Code: 
[2026-07-17 11:29:19] [INFO] 
[2026-07-17 11:29:19] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-17 11:29:19] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tsihq1i1.prg
[2026-07-17 11:29:19] [INFO] 
[2026-07-17 11:29:19] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-17 11:29:19] [INFO] * Auto-generated wrapper for parameters
[2026-07-17 11:29:19] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 11:29:19] [INFO] * Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
[2026-07-17 11:29:19] [INFO] 
[2026-07-17 11:29:19] [INFO] * Anti-dialog protections for unattended execution
[2026-07-17 11:29:19] [INFO] SET SAFETY OFF
[2026-07-17 11:29:19] [INFO] SET RESOURCE OFF
[2026-07-17 11:29:19] [INFO] SET TALK OFF
[2026-07-17 11:29:19] [INFO] SET NOTIFY OFF
[2026-07-17 11:29:19] [INFO] SYS(2335, 0)
[2026-07-17 11:29:19] [INFO] 
[2026-07-17 11:29:19] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
[2026-07-17 11:29:19] [INFO] QUIT
[2026-07-17 11:29:19] [INFO] 
[2026-07-17 11:29:19] [INFO] === Fim do Wrapper.prg ===
[2026-07-17 11:29:19] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-17 11:58:05] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-17 11:58:05] [INFO] Config FPW: (nao fornecido)
[2026-07-17 11:58:05] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 11:58:05] [INFO] Timeout: 300 segundos
[2026-07-17 11:58:05] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ak0sax4f.prg
[2026-07-17 11:58:05] [INFO] Conteudo do wrapper:
[2026-07-17 11:58:05] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
QUIT

[2026-07-17 11:58:05] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ak0sax4f.prg
[2026-07-17 11:58:05] [INFO] VFP output esperado em: C:\4c\tasks\task304\vfp_output.txt
[2026-07-17 11:58:05] [INFO] Executando Visual FoxPro 9...
[2026-07-17 11:58:05] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ak0sax4f.prg
[2026-07-17 11:58:05] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ak0sax4f.prg
[2026-07-17 11:58:05] [INFO] Timeout configurado: 300 segundos
[2026-07-17 11:58:35] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-17 11:58:35] [INFO] VFP9 finalizado em 30.9181746 segundos
[2026-07-17 11:58:35] [INFO] Exit Code: 
[2026-07-17 11:58:35] [INFO] 
[2026-07-17 11:58:35] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-17 11:58:35] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ak0sax4f.prg
[2026-07-17 11:58:35] [INFO] 
[2026-07-17 11:58:35] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-17 11:58:35] [INFO] * Auto-generated wrapper for parameters
[2026-07-17 11:58:35] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 11:58:35] [INFO] * Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
[2026-07-17 11:58:35] [INFO] 
[2026-07-17 11:58:35] [INFO] * Anti-dialog protections for unattended execution
[2026-07-17 11:58:35] [INFO] SET SAFETY OFF
[2026-07-17 11:58:35] [INFO] SET RESOURCE OFF
[2026-07-17 11:58:35] [INFO] SET TALK OFF
[2026-07-17 11:58:35] [INFO] SET NOTIFY OFF
[2026-07-17 11:58:35] [INFO] SYS(2335, 0)
[2026-07-17 11:58:35] [INFO] 
[2026-07-17 11:58:35] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
[2026-07-17 11:58:35] [INFO] QUIT
[2026-07-17 11:58:35] [INFO] 
[2026-07-17 11:58:35] [INFO] === Fim do Wrapper.prg ===
[2026-07-17 11:58:35] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-17 12:25:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-17 12:25:12] [INFO] Config FPW: (nao fornecido)
[2026-07-17 12:25:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 12:25:12] [INFO] Timeout: 300 segundos
[2026-07-17 12:25:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wmejd5so.prg
[2026-07-17 12:25:12] [INFO] Conteudo do wrapper:
[2026-07-17 12:25:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
QUIT

[2026-07-17 12:25:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wmejd5so.prg
[2026-07-17 12:25:12] [INFO] VFP output esperado em: C:\4c\tasks\task304\vfp_output.txt
[2026-07-17 12:25:12] [INFO] Executando Visual FoxPro 9...
[2026-07-17 12:25:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wmejd5so.prg
[2026-07-17 12:25:12] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wmejd5so.prg
[2026-07-17 12:25:12] [INFO] Timeout configurado: 300 segundos
[2026-07-17 12:25:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-17 12:25:40] [INFO] VFP9 finalizado em 28.1059903 segundos
[2026-07-17 12:25:40] [INFO] Exit Code: 
[2026-07-17 12:25:40] [INFO] 
[2026-07-17 12:25:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-17 12:25:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wmejd5so.prg
[2026-07-17 12:25:40] [INFO] 
[2026-07-17 12:25:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-17 12:25:40] [INFO] * Auto-generated wrapper for parameters
[2026-07-17 12:25:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 12:25:40] [INFO] * Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
[2026-07-17 12:25:40] [INFO] 
[2026-07-17 12:25:40] [INFO] * Anti-dialog protections for unattended execution
[2026-07-17 12:25:40] [INFO] SET SAFETY OFF
[2026-07-17 12:25:40] [INFO] SET RESOURCE OFF
[2026-07-17 12:25:40] [INFO] SET TALK OFF
[2026-07-17 12:25:40] [INFO] SET NOTIFY OFF
[2026-07-17 12:25:40] [INFO] SYS(2335, 0)
[2026-07-17 12:25:40] [INFO] 
[2026-07-17 12:25:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
[2026-07-17 12:25:40] [INFO] QUIT
[2026-07-17 12:25:40] [INFO] 
[2026-07-17 12:25:40] [INFO] === Fim do Wrapper.prg ===
[2026-07-17 12:25:40] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-17 12:26:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-17 12:26:56] [INFO] Config FPW: (nao fornecido)
[2026-07-17 12:26:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 12:26:56] [INFO] Timeout: 300 segundos
[2026-07-17 12:26:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5a4pnmfg.prg
[2026-07-17 12:26:56] [INFO] Conteudo do wrapper:
[2026-07-17 12:26:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
QUIT

[2026-07-17 12:26:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5a4pnmfg.prg
[2026-07-17 12:26:56] [INFO] VFP output esperado em: C:\4c\tasks\task304\vfp_output.txt
[2026-07-17 12:26:56] [INFO] Executando Visual FoxPro 9...
[2026-07-17 12:26:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5a4pnmfg.prg
[2026-07-17 12:26:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5a4pnmfg.prg
[2026-07-17 12:26:56] [INFO] Timeout configurado: 300 segundos
[2026-07-17 12:27:25] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-17 12:27:25] [INFO] VFP9 finalizado em 28.9486562 segundos
[2026-07-17 12:27:25] [INFO] Exit Code: 
[2026-07-17 12:27:25] [INFO] 
[2026-07-17 12:27:25] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-17 12:27:25] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5a4pnmfg.prg
[2026-07-17 12:27:25] [INFO] 
[2026-07-17 12:27:25] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-17 12:27:25] [INFO] * Auto-generated wrapper for parameters
[2026-07-17 12:27:25] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 12:27:25] [INFO] * Parameters: 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
[2026-07-17 12:27:25] [INFO] 
[2026-07-17 12:27:25] [INFO] * Anti-dialog protections for unattended execution
[2026-07-17 12:27:25] [INFO] SET SAFETY OFF
[2026-07-17 12:27:25] [INFO] SET RESOURCE OFF
[2026-07-17 12:27:25] [INFO] SET TALK OFF
[2026-07-17 12:27:25] [INFO] SET NOTIFY OFF
[2026-07-17 12:27:25] [INFO] SYS(2335, 0)
[2026-07-17 12:27:25] [INFO] 
[2026-07-17 12:27:25] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIMP', 'C:\4c\tasks\task304', 'OPERACIONAL'
[2026-07-17 12:27:25] [INFO] QUIT
[2026-07-17 12:27:25] [INFO] 
[2026-07-17 12:27:25] [INFO] === Fim do Wrapper.prg ===
[2026-07-17 12:27:25] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRIMP",
  "timestamp": "20260717122725",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg):
*==============================================================================
* FormSIGPRIMP.prg - Formulario Operacional de Importacao de Movimentacao de Estoque
* Herda de: FormBase
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* BO: SIGPRIMPBO
*==============================================================================
DEFINE CLASS FormSIGPRIMP AS FormBase

    *-- Dimensoes e aparencia (identicas ao SCX original SIGPRIMP)
    Width        = 1000
    Height       = 330
    AutoCenter   = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    WindowType   = 1
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    DataSession  = 2

    *-- Controle interno de erro
    this_cMensagemErro = ""

    *==========================================================================
    * Init - Cria BO e inicializa form via FormBase
    *==========================================================================
    PROCEDURE Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIMPBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRIMPBO.", ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura controles e carrega dados iniciais
    *==========================================================================
    PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de dados"

        TRY
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarCampos()
            THIS.TornarControlesVisiveis()
            THIS.CarregarArquivos()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, "Erro ao inicializar form")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Define imagem de fundo do form
    * OPERACIONAL flat: sem PageFrame; metodo existe por compatibilidade com pipeline
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (equivalente ao cntSombra)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption, loc_oCnt, loc_oLbl, loc_nFormWidth
        loc_cCaption  = "Importa" + CHR(231) + CHR(227) + "o de dados"
        loc_nFormWidth = THIS.Width

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        loc_oLbl = loc_oCnt.lbl_4c_LblSombra
        WITH loc_oLbl
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = loc_cCaption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = loc_nFormWidth
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        loc_oLbl = loc_oCnt.lbl_4c_LblTitulo
        WITH loc_oLbl
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(255, 255, 255)
            .Caption       = loc_cCaption
            .Height        = 46
            .Left          = 10
            .Top           = 17
            .Width         = loc_nFormWidth
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes de acao posicionados no topo do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Movimentacao de Estoque (btnMovEst: Left=700, PicturePosition=7)
        THIS.AddObject("cmd_4c_BtnMovEst", "CommandButton")
        WITH THIS.cmd_4c_BtnMovEst
            .Top             = 3
            .Left            = 700
            .Width           = 75
            .Height          = 75
            .Caption         = "Moviment. de Estoque"
            .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Botao Visualizar (oculto: legado ocultava no Init: Visible=.F.)
        THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH THIS.cmd_4c_Visualizar
            .Top             = 3
            .Left            = 775
            .Width           = 75
            .Height          = 75
            .Caption         = "V" + CHR(237) + "deo"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Botao Imprimir (oculto: legado ocultava no Init: Visible=.F.)
        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Impressora"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Botao Encerrar (Cancela do legado: Left=925, Cancel=.T.)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnMovEst,  "Click", THIS, "BtnMovEstClick")
        BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnCancelaClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Label, TextBox de arquivo e ListBox de arquivos TXT
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Label "Arquivos Importacao :" (Say4 do legado)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Arquivos Importa" + CHR(231) + CHR(227) + "o :"
            .Height    = 17
            .Left      = 310
            .Top       = 111
            .Width     = 130
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Get_Arquivo: somente leitura (When=.F. no legado)
        THIS.AddObject("txt_4c_Arquivo", "TextBox")
        WITH THIS.txt_4c_Arquivo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Height        = 21
            .Left          = 440
            .Top           = 108
            .Width         = 250
            .ReadOnly      = .T.
            .TabStop       = .F.
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(90, 90, 90)
        ENDWITH

        *-- ListBox Arquivos: exibe TXT do diretorio de importacao
        THIS.AddObject("obj_4c_Arquivos", "ListBox")
        WITH THIS.obj_4c_Arquivos
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 169
            .Left          = 402
            .Top           = 130
            .Width         = 288
            .RowSourceType = 0
            .RowSource     = ""
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Sorted        = .T.
            .MultiSelect   = .F.
        ENDWITH

        BINDEVENT(THIS.obj_4c_Arquivos, "InteractiveChange", THIS, "ArquivosInteractiveChange")
    ENDPROC

    *==========================================================================
    * CarregarArquivos - Carrega parametros do SigCdPam e lista arquivos TXT
    *==========================================================================
    PROCEDURE CarregarArquivos()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarParametros()
                *-- Pre-preencher textbox com diretorio de importacao (comportamento do Init legado)
                IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
                    THIS.txt_4c_Arquivo.Value = ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
                ENDIF

                IF THIS.this_oBusinessObject.BuscarArquivos()
                    *-- Vincular listbox ao cursor de arquivos
                    IF USED("cursor_4c_Arquivos") AND PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
                        WITH THIS.obj_4c_Arquivos
                            .RowSourceType = 6
                            .RowSource     = "cursor_4c_Arquivos.cArquivo"
                            .Refresh()
                        ENDWITH
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarArquivos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ArquivosInteractiveChange - Exibe arquivo selecionado no textbox
    *==========================================================================
    PROCEDURE ArquivosInteractiveChange()
        IF VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
            THIS.txt_4c_Arquivo.Value = ;
                ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + ;
                ALLTRIM(THIS.obj_4c_Arquivos.Value)
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMovEstClick - Processa todos os arquivos TXT do diretorio de importacao
    * Para cada arquivo: chama ProcessarArquivo() no BO; se sucesso, move para OK\
    * Equivalente ao btnMovEst.Click do legado
    *==========================================================================
    PROCEDURE BtnMovEstClick()
        LOCAL loc_cDirImports, loc_cDirOk, loc_cArquivo, loc_cArquivoFull
        LOCAL loc_nProcessados, loc_nErros, loc_oErro

        *-- Verificar disponibilidade de arquivos
        THIS.this_oBusinessObject.BuscarArquivos()

        IF !USED("cursor_4c_Arquivos") OR RECCOUNT("cursor_4c_Arquivos") = 0
            MsgAviso("Nenhum arquivo para importar.", "Aviso")
            RETURN
        ENDIF

        loc_nProcessados = 0
        loc_nErros       = 0
        loc_cDirImports  = ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports))
        loc_cDirOk       = loc_cDirImports + "OK\"

        TRY
            *-- Garantir existencia do subdiretorio OK\
            IF !DIRECTORY(loc_cDirOk)
                MKDIR (loc_cDirOk)
            ENDIF

            *-- Desabilitar botoes durante processamento
            THIS.cmd_4c_BtnMovEst.Enabled = .F.
            THIS.cmd_4c_Cancela.Enabled   = .F.
            THIS.Refresh()

            SELECT cursor_4c_Arquivos
            GO TOP
            SCAN
                loc_cArquivo     = ALLTRIM(cursor_4c_Arquivos.cArquivo)
                loc_cArquivoFull = loc_cDirImports + loc_cArquivo

                *-- Atualizar display do arquivo em processamento
                IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
                    THIS.txt_4c_Arquivo.Value = loc_cArquivoFull
                    THIS.txt_4c_Arquivo.Refresh()
                ENDIF

                *-- Processar via BO
                IF THIS.this_oBusinessObject.ProcessarArquivo(loc_cArquivoFull)
                    loc_nProcessados = loc_nProcessados + 1
                    *-- Mover arquivo processado para OK\
                    IF FILE(loc_cArquivoFull)
                        SET SAFETY OFF
                        COPY FILE (loc_cArquivoFull) TO (loc_cDirOk + loc_cArquivo)
                        IF FILE(loc_cDirOk + loc_cArquivo)
                            DELETE FILE (loc_cArquivoFull)
                        ENDIF
                        SET SAFETY ON
                    ENDIF
                ELSE
                    loc_nErros = loc_nErros + 1
                ENDIF

                SELECT cursor_4c_Arquivos
            ENDSCAN

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnMovEstClick")
        ENDTRY

        *-- Reabilitar botoes
        IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
            THIS.cmd_4c_BtnMovEst.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
            THIS.cmd_4c_Cancela.Enabled = .T.
        ENDIF

        *-- Limpar display e recarregar lista apos processamento
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
            THIS.txt_4c_Arquivo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
        ENDIF
        THIS.CarregarArquivos()
        THIS.Refresh()

        *-- Exibir resultado geral se mais de um arquivo foi processado
        IF loc_nProcessados + loc_nErros > 1
            MsgInfo("Processamento conclu" + CHR(237) + "do. " + ;
                    "Sucesso: " + TRANSFORM(loc_nProcessados) + ;
                    " | Erros: " + TRANSFORM(loc_nErros), ;
                    "Importa" + CHR(231) + CHR(227) + "o de Dados")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre o arquivo TXT selecionado no Bloco de Notas
    * Botao permanece oculto (legado: Visualizar.Visible = .F. no Init)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cArquivo, loc_cCmd, loc_oErro
        loc_cArquivo = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        IF EMPTY(loc_cArquivo)
            MsgAviso("Selecione um arquivo na lista antes de visualizar.", ;
                     "Visualizar arquivo")
            RETURN
        ENDIF
        IF !FILE(loc_cArquivo)
            MsgAviso("Arquivo '" + loc_cArquivo + "' n" + CHR(227) + "o encontrado.", ;
                     "Visualizar arquivo")
            RETURN
        ENDIF
        TRY
            loc_cCmd = "notepad.exe " + CHR(34) + loc_cArquivo + CHR(34)
            RUN /N &loc_cCmd.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao abrir arquivo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Processa importacao (equivalente a Processar('I') do legado)
    * Botao permanece oculto (legado: Imprimir.Visible = .F. no Init)
    * O legado chamava ThisForm.Processar('I') que executava a mesma logica de
    * importacao que btnMovEst.Click
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        THIS.BtnMovEstClick()
    ENDPROC

    *==========================================================================
    * BtnCancelaClick - Fecha o formulario (equivalente a Cancela.Click do legado)
    *==========================================================================
    PROCEDURE BtnCancelaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Adaptacao para form OPERACIONAL de importacao
    * No contexto de importacao de dados, "Incluir" corresponde a processar
    * os arquivos disponiveis no diretorio (mesma acao do btnMovEst do legado)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Deseja processar os arquivos de importa" + ;
                                    CHR(231) + CHR(227) + "o dispon" + CHR(237) + "veis?", ;
                                    "Importa" + CHR(231) + CHR(227) + "o de Dados")
        IF loc_lConfirma
            THIS.BtnMovEstClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Adaptacao para form OPERACIONAL de importacao
    * No contexto de importacao de dados, "Alterar" corresponde a recarregar a
    * lista de arquivos disponiveis (equivalente a atualizar o cursor Arquivos)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nRegistros
        THIS.CarregarArquivos()
        loc_nRegistros = IIF(USED("cursor_4c_Arquivos"), ;
                             RECCOUNT("cursor_4c_Arquivos"), 0)
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            THIS.obj_4c_Arquivos.Refresh()
        ENDIF
        MsgInfo("Lista atualizada. Arquivos dispon" + CHR(237) + "veis: " + ;
                TRANSFORM(loc_nRegistros), ;
                "Importa" + CHR(231) + CHR(227) + "o de Dados")
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Adaptacao para form OPERACIONAL de importacao
    * No contexto de importacao de dados, "Excluir" corresponde a remover
    * fisicamente o arquivo TXT selecionado do diretorio de importacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cArquivo, loc_cValor, loc_lConfirma, loc_oErro
        IF !PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            RETURN
        ENDIF
        loc_cValor = ""
        IF VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
            loc_cValor = ALLTRIM(THIS.obj_4c_Arquivos.Value)
        ENDIF
        IF EMPTY(loc_cValor)
            MsgAviso("Selecione um arquivo na lista antes de excluir.", ;
                     "Excluir arquivo")
            RETURN
        ENDIF
        loc_cArquivo = ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + ;
                       loc_cValor
        IF !FILE(loc_cArquivo)
            MsgAviso("Arquivo '" + loc_cValor + "' n" + CHR(227) + "o encontrado.", ;
                     "Excluir arquivo")
            RETURN
        ENDIF
        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do arquivo '" + ;
                                    loc_cValor + "'?", ;
                                    "Excluir arquivo")
        IF !loc_lConfirma
            RETURN
        ENDIF
        TRY
            SET SAFETY OFF
            DELETE FILE (loc_cArquivo)
            SET SAFETY ON
            IF FILE(loc_cArquivo)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o arquivo.", ;
                        "Excluir arquivo")
            ELSE
                MsgInfo("Arquivo exclu" + CHR(237) + "do com sucesso.", ;
                        "Excluir arquivo")
                THIS.txt_4c_Arquivo.Value = ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
                THIS.CarregarArquivos()
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao excluir arquivo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do form visiveis
    * cmd_4c_Visualizar e cmd_4c_Imprimir ficam ocultos (legado: Visible=.F. no Init)
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_oObjeto, loc_nJ, loc_oFilho
        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oObjeto = THIS.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) != "O"
                LOOP
            ENDIF
            *-- Manter ocultos: Visualizar e Imprimir (legado: Visible=.F.) e
            *-- cnt_4c_Sombra (form usa Picture de fundo; container nao exibido)
            IF INLIST(loc_oObjeto.Name, "cmd_4c_Visualizar", "cmd_4c_Imprimir", "cnt_4c_Sombra")
                *-- Tornar sub-controles visiveis mesmo com pai oculto
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    FOR loc_nJ = 1 TO loc_oObjeto.ControlCount
                        loc_oFilho = loc_oObjeto.Controls(loc_nJ)
                        IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
                            loc_oFilho.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
               loc_oObjeto.ControlCount > 0
                FOR loc_nJ = 1 TO loc_oObjeto.ControlCount
                    loc_oFilho = loc_oObjeto.Controls(loc_nJ)
                    IF VARTYPE(loc_oFilho) = "O" AND ;
                       PEMSTATUS(loc_oFilho, "Visible", 5)
                        loc_oFilho.Visible = .T.
                    ENDIF
                ENDFOR
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista / ConfigurarPaginaDados / AlternarPagina
    * Stubs de compatibilidade com pipeline multi-fase (OPERACIONAL sem paginas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Atualiza lista de arquivos TXT do diretorio de importacao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Para form OPERACIONAL de importacao, salvar = processar
    * Confirmacao exigida antes de disparar o processamento
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Deseja processar os arquivos de importa" + ;
                                    CHR(231) + CHR(227) + "o dispon" + CHR(237) + "veis?", ;
                                    "Importa" + CHR(231) + CHR(227) + "o de Dados")
        IF loc_lConfirma
            THIS.BtnMovEstClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela/fecha o formulario
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Atualiza propriedades do BO com os dados selecionados no form
    * Para form OPERACIONAL, atualiza o arquivo selecionado na listbox
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_cArqSel
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5) AND ;
           VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
            loc_cArqSel = ALLTRIM(THIS.obj_4c_Arquivos.Value)
            IF !EMPTY(loc_cArqSel)
                THIS.this_oBusinessObject.this_cArquivoAtual = ;
                    ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + loc_cArqSel
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega dados do BO nos controles do form
    * Para form OPERACIONAL, exibe o diretorio de importacao no textbox
    *==========================================================================
    PROCEDURE BOParaForm()
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
            THIS.txt_4c_Arquivo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles interativos
    * par_lHabilitar: .T. para habilitar, .F. para desabilitar
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
            THIS.cmd_4c_BtnMovEst.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            THIS.obj_4c_Arquivos.Enabled  = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta controles do form para estado inicial
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
            THIS.txt_4c_Arquivo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            THIS.obj_4c_Arquivos.Value = ""
            THIS.obj_4c_Arquivos.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega cursor de arquivos TXT e vincula ao listbox
    * Retorna numero de arquivos encontrados
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_nRegistros
        loc_nRegistros = 0
        THIS.CarregarArquivos()
        IF USED("cursor_4c_Arquivos") AND PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            WITH THIS.obj_4c_Arquivos
                .RowSourceType = 6
                .RowSource     = "cursor_4c_Arquivos.cArquivo"
                .Refresh()
            ENDWITH
            loc_nRegistros = RECCOUNT("cursor_4c_Arquivos")
        ENDIF
        RETURN loc_nRegistros
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme estado atual
    * BtnMovEst fica habilitado somente se houver arquivos na lista
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemArquivos
        loc_lTemArquivos = USED("cursor_4c_Arquivos") AND ;
                           RECCOUNT("cursor_4c_Arquivos") > 0
        IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
            THIS.cmd_4c_BtnMovEst.Enabled = loc_lTemArquivos
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            THIS.obj_4c_Arquivos.Enabled  = .T.
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
            THIS.cmd_4c_Cancela.Enabled   = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Arquivos")
            USE IN cursor_4c_Arquivos
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRIMPBO.prg):
*==============================================================================
* SIGPRIMPBO.prg - Business Object para Importacao de Movimentacao de Estoque
* Herda de: BusinessBase
* Tabela principal: SigMvCab (cabecalho da movimentacao)
*==============================================================================
DEFINE CLASS SIGPRIMPBO AS BusinessBase

    *-- Configuracao (SigCdPam)
    this_cDirImports    = ""   && Diretorio de importacao dos arquivos TXT
    this_cMoedaPs       = ""   && Moeda padrao do sistema
    this_cMascNums      = ""   && Mascara de numeracao

    *-- Controle de processamento
    this_cArquivoAtual  = ""   && Caminho completo do arquivo TXT em processamento
    this_lResultadoOk   = .F.  && Resultado do ultimo processamento
    this_cMensagemErro  = ""   && Mensagem de erro do ultimo processamento

    *============================================================================
    PROCEDURE Init()
    *============================================================================
        THIS.this_cTabela       = "SigMvCab"
        THIS.this_cCampoChave   = "CidChaves"
        RETURN DODEFAULT()
    ENDPROC

    *============================================================================
    PROCEDURE ObterChavePrimaria()
    *============================================================================
        RETURN THIS.this_cArquivoAtual
    ENDPROC

    *============================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *  Nao aplicavel para este BO operacional
    *============================================================================
        RETURN .F.
    ENDPROC

    *============================================================================
    PROCEDURE CarregarParametros()
    *  Carrega parametros de SigCdPam: DirImports, MoedaPs, MascNums
    *============================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT MoedaPs, MascNums, DirImports FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamImp") > 0
                IF !EOF("cursor_4c_PamImp")
                    SELECT cursor_4c_PamImp
                    THIS.this_cMoedaPs    = ALLTRIM(NVL(MoedaPs, ""))
                    THIS.this_cMascNums   = ALLTRIM(NVL(MascNums, ""))
                    THIS.this_cDirImports = ALLTRIM(NVL(DirImports, ""))
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Par" + CHR(226) + "metros do sistema (SigCdPam) n" + ;
                            CHR(227) + "o encontrados.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao consultar SigCdPam.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarParametros")
        ENDTRY
        IF USED("cursor_4c_PamImp")
            USE IN cursor_4c_PamImp
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *============================================================================
    PROCEDURE BuscarArquivos()
    *  Lista arquivos TXT em DirImports e popula cursor_4c_Arquivos
    *============================================================================
        LOCAL loc_lSucesso, loc_nArq, loc_nI, loc_cArq, loc_oErro
        LOCAL loc_aArqs(1,5)
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cDirImports)
                MsgAviso("Diret" + CHR(243) + "rio de importa" + CHR(231) + CHR(227) + ;
                         "o n" + CHR(227) + "o configurado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Arquivos")
                USE IN cursor_4c_Arquivos
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Arquivos (cArquivo C(254) NULL)
            SET NULL OFF
            loc_nArq = ADIR(loc_aArqs, ALLTRIM(THIS.this_cDirImports) + "*.TXT")
            IF loc_nArq > 0
                FOR loc_nI = 1 TO loc_nArq
                    loc_cArq = ALLTRIM(loc_aArqs(loc_nI, 1))
                    INSERT INTO cursor_4c_Arquivos (cArquivo) VALUES (m.loc_cArq)
                ENDFOR
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BuscarArquivos")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *============================================================================
    PROCEDURE ProcessarArquivo(par_cArquivo)
    *  Processa um arquivo TXT pipe-delimitado de movimentacao de estoque.
    *  Insere registros em SigMvCab, SigMvItn, SigMvIts e SigMvMov.
    *  Retorna .T. se importado com sucesso, .F. caso contrario.
    *============================================================================
        LOCAL loc_lSucesso, loc_lOk, loc_cMsg, loc_oErro
        loc_lSucesso = .F.
        loc_lOk      = .T.
        loc_cMsg     = ""
        THIS.this_cArquivoAtual = par_cArquivo
        THIS.this_lResultadoOk  = .F.
        THIS.this_cMensagemErro = ""

        TRY
            *-- Validar caminho sem espacos
            IF AT(" ", par_cArquivo) > 0
                MsgAviso("Arquivo '" + par_cArquivo + "' Inv" + CHR(225) + "lido! " + ;
                         "O caminho n" + CHR(227) + "o pode conter espa" + CHR(231) + "os.", ;
                         "Sele" + CHR(231) + CHR(227) + "o de Arquivo")
                THIS.this_cMensagemErro = "Caminho com espa" + CHR(231) + "os"
                loc_lSucesso = .F.
            ENDIF

            *-- Criar cursor que recebe o arquivo TXT (57 campos pipe-delimitados)
            SET NULL ON
            CREATE CURSOR crImpMvCab (;
                TPREGS C(5), EMPS C(3), DOPES C(20), OPERS C(1), CITENS C(4), ;
                CODBARRAS C(14), CPROS C(14), DPROS C(40), OBS C(250), MOEDAS C(3), ;
                MOEVS C(3), MOEVALS N(15,6), QTDS N(15,3), CUNIS C(3), PESOS N(15,3), ;
                CUNIPS C(3), FATORS N(15,3), UNITS N(15,6), TOTAS N(15,2), VALDESCS N(15,2), ;
                VALBASES N(15,2), SITRIBS C(2), TPIPIS C(1), BCIPIS N(15,2), ;
                BASEIPI2S N(15,2), BASEIPI3S N(15,2), ALIQS N(15,2), VALIPIS N(15,2), ;
                SITTRICMS C(3), BASEICMS N(15,2), BASEICM2S N(15,2), BASEICM3S N(15,2), ;
                ALIQICMS N(15,2), ICMS N(15,2), CFOPS C(10), BCICMSS N(15,2), ;
                ICMSS N(15,2), ALIQPIS N(15,2), VPIS N(15,2), ALIQCOFS N(15,2), ;
                VCOFINS N(15,2), ISS N(15,2), IRRF N(15,2), INSS N(15,2), CSSL N(15,2), ;
                ALIQIIS N(15,2), TAXAIIS N(15,2), NADIS N(3), NIADIS N(3), CODFABS C(60), ;
                ORIGMERCS C(1), GRUORIGS C(10), CONORIGS C(10), GRUDESTS C(10), ;
                CONDESTS C(10), DATAS D, VENDS C(10), CODCORS C(4), CODTAMS C(4), OBSES C(250))
            SET NULL OFF

            *-- Importar linhas do arquivo delimitadas por '|'
            SELECT crImpMvCab
            LOCAL loc_cArqMacro
            loc_cArqMacro = par_cArquivo
            APPEND FROM &loc_cArqMacro. DELIMITED WITH CHARACTER 124
            GO TOP

            *-- Validar formato do arquivo
            IF EOF("crImpMvCab") OR crImpMvCab.TPREGS # "MVITN"
                MsgAviso("Arquivo '" + par_cArquivo + "' inv" + CHR(225) + ;
                         "lido para importa" + CHR(231) + CHR(227) + "o.", ;
                         "Importa" + CHR(231) + CHR(227) + "o cancelada")
                IF USED("crImpMvCab")
                    USE IN crImpMvCab
                ENDIF
                THIS.this_cMensagemErro = "Formato inv" + CHR(225) + "lido"
                loc_lSucesso = .F.
            ENDIF

            *-- Capturar dados de cabecalho da primeira linha
            LOCAL loc_cDopes, loc_cEmps, loc_dDatasArq, loc_cSQL
            loc_cDopes    = ALLTRIM(crImpMvCab.DOPES)
            loc_cEmps     = ALLTRIM(crImpMvCab.EMPS)
            loc_dDatasArq = crImpMvCab.DATAS

            *-- Validar operacao em SigCdOpe
            loc_cSQL = "SELECT Dopes, NDopes, Numeras, vCompensas, GrVends, Cmoes " + ;
                       "FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeImp") < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao consultar SigCdOpe.", "Erro")
                loc_lOk = .F.
            ENDIF
            IF loc_lOk AND EOF("cursor_4c_OpeImp")
                loc_cMsg = "Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o configurada no sistema."
                loc_lOk  = .F.
            ENDIF

            LOCAL loc_nNumeras, loc_nVComp, loc_cGrVends, loc_cCmoes
            loc_nNumeras = 0
            loc_nVComp   = 0
            loc_cGrVends = ""
            loc_cCmoes   = ""
            IF loc_lOk
                SELECT cursor_4c_OpeImp
                loc_nNumeras = NVL(Numeras, 0)
                loc_nVComp   = NVL(vCompensas, 0)
                loc_cGrVends = ALLTRIM(NVL(GrVends, ""))
                loc_cCmoes   = ALLTRIM(NVL(Cmoes, ""))
            ENDIF
            IF USED("cursor_4c_OpeImp")
                USE IN cursor_4c_OpeImp
            ENDIF

            *-- Validar empresa
            IF loc_lOk
                loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao consultar SigCdEmp.", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_EmpImp")
                    loc_cMsg = "Empresa n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_EmpImp")
                    USE IN cursor_4c_EmpImp
                ENDIF
            ENDIF

            *-- Validar conta de origem
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONORIGS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - origem).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de origem n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Validar conta de destino
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONDESTS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - destino).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de destino n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Validar vendedor
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.VENDS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - vendedor).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de vendedor n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Processar importacao quando todas as validacoes passarem
            IF loc_lOk
                *-- Cursor de totais por moeda (para SigMvMov)
                CREATE CURSOR TmpTotal (;
                    Moeds C(3), Valtots N(12,2), Valitens N(12,2), Valdifs N(12,2), ;
                    PorcDifs N(12,4), Tipos C(1), Coefs N(6,3), Teors N(6,3), ;
                    Qtdes N(10,3), Mobras N(10,2), nSinals N(3), MoeVals N(12,5))
                INDEX ON Moeds TAG Moeds

                *-- Gerar numero da movimentacao
                LOCAL loc_nInicio, loc_cIniLet, loc_cEDN, loc_cCidChavesCab, loc_lNew
                loc_lNew    = .T.
                loc_nInicio = 0

                IF loc_nNumeras = 5
                    DO WHILE loc_nInicio = 0
                        TRY
                            loc_nInicio = fKeyGen()
                        CATCH
                            loc_nInicio = INT(RAND(0) * 999990) + 1
                        ENDTRY
                        loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvCab " + ;
                                   "WHERE EmpDopNums = " + ;
                                   EscaparSQL(loc_cEmps + loc_cDopes + STR(loc_nInicio, 6))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") > 0
                            IF !EOF("cursor_4c_ChkReg") AND NVL(cursor_4c_ChkReg.nExiste, 0) > 0
                                loc_nInicio = 0
                            ENDIF
                            IF USED("cursor_4c_ChkReg")
                                USE IN cursor_4c_ChkReg
                            ENDIF
                        ENDIF
                    ENDDO
                    loc_lNew = .F.
                ENDIF

                IF loc_lNew AND loc_nNumeras # 2
                    loc_nInicio = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
                ENDIF

                loc_cIniLet      = ALLTRIM(fGerMascara(loc_nInicio))
                loc_cEDN         = loc_cEmps + loc_cDopes + STR(loc_nInicio, 6)
                loc_cCidChavesCab = fUniqueIds()

                *-- Buscar cotacao da moeda da operacao
                LOCAL loc_nCotMov, loc_cMoeOpe
                loc_cMoeOpe = loc_cCmoes
                loc_nCotMov = 0

                IF !EMPTY(loc_cMoeOpe)
                    loc_nCotMov = fBuscarCotacao(loc_cMoeOpe, loc_dDatasArq)
                    IF !SEEK(PADR(loc_cMoeOpe, 3), "TmpTotal", "Moeds")
                        LOCAL loc_cMoeTmp, loc_nCotTmp
                        loc_cMoeTmp = loc_cMoeOpe
                        loc_nCotTmp = loc_nCotMov
                        INSERT INTO TmpTotal (Moeds, MoeVals) VALUES (m.loc_cMoeTmp, m.loc_nCotTmp)
                    ENDIF
                ENDIF

                *-- Iniciar transacao SQL Server
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                *-- INSERT SigMvCab (cabecalho da movimentacao)
                SELECT crImpMvCab
                loc_cSQL = "INSERT INTO SigMvCab (" + ;
                           "Emps, Dopes, Numes, Usuars, Datars, Datas, Transps, Mascnum, " + ;
                           "Tabds, LPrecos, CidChaves, EmpDopNums, Dgopes, vCompensas, " + ;
                           "GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends, " + ;
                           "GrResps, Resps, Obses, DataTrans, Valos, ValInis) VALUES ("
                loc_cSQL = loc_cSQL + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           EscaparSQL(loc_cDopes) + ", " + ;
                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                           "GETDATE(), " + ;
                           IIF(!EMPTY(loc_dDatasArq), FormatarDataSQL(loc_dDatasArq), "NULL") + ", " + ;
                           "0, " + ;
                           EscaparSQL(LEFT(loc_cIniLet, 10)) + ", " + ;
                           "'', '', " + ;
                           EscaparSQL(loc_cCidChavesCab) + ", " + ;
                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                           "'', " + ;
                           FormatarNumeroSQL(loc_nVComp, 2) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.GRUORIGS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONORIGS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.GRUDESTS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONDESTS)) + ", " + ;
                           EscaparSQL(LEFT(loc_cGrVends, 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.VENDS), 10)) + ", " + ;
                           EscaparSQL(LEFT(loc_cGrVends, 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.VENDS), 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OBSES), 250)) + ", " + ;
                           "GETDATE(), 0, 0)"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir cabe" + CHR(231) + "alho da movimenta" + ;
                            CHR(231) + CHR(227) + "o.", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lOk = .F.
                ENDIF

                *-- Iterar sobre cada linha/item do arquivo
                IF loc_lOk
                    LOCAL loc_nValtot, loc_nCotItn, loc_nUnits, loc_nTotas, loc_cMoedaItn
                    loc_nValtot = 0

                    SELECT crImpMvCab
                    SCAN
                        *-- Validar produto
                        loc_cSQL = "SELECT Dpros FROM SigCdPro WHERE Cpros = " + ;
                                   EscaparSQL(ALLTRIM(crImpMvCab.CPROS))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProImp") < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (SigCdPro).", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            IF USED("cursor_4c_ProImp")
                                USE IN cursor_4c_ProImp
                            ENDIF
                            EXIT
                        ENDIF
                        IF EOF("cursor_4c_ProImp")
                            loc_cMsg = "Produto " + ALLTRIM(crImpMvCab.CPROS) + ;
                                       " n" + CHR(227) + "o cadastrado."
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            IF USED("cursor_4c_ProImp")
                                USE IN cursor_4c_ProImp
                            ENDIF
                            EXIT
                        ENDIF
                        IF USED("cursor_4c_ProImp")
                            USE IN cursor_4c_ProImp
                        ENDIF

                        SELECT crImpMvCab

                        *-- Calcular cotacao e converter moeda do item
                        loc_cMoedaItn = ALLTRIM(NVL(crImpMvCab.MOEDAS, ""))
                        loc_nUnits    = NVL(crImpMvCab.UNITS, 0)
                        loc_nTotas    = NVL(crImpMvCab.TOTAS, 0)

                        IF !EMPTY(loc_cMoedaItn)
                            loc_nCotItn = IIF(NVL(crImpMvCab.MOEVALS, 0) # 0, ;
                                              NVL(crImpMvCab.MOEVALS, 0), ;
                                              fBuscarCotacao(loc_cMoedaItn, crImpMvCab.DATAS))
                            IF !SEEK(PADR(loc_cMoedaItn, 3), "TmpTotal", "Moeds")
                                LOCAL loc_cMoedaItm, loc_nCotItm
                                loc_cMoedaItm = loc_cMoedaItn
                                loc_nCotItm   = NVL(crImpMvCab.MOEVALS, 0)
                                INSERT INTO TmpTotal (Moeds, MoeVals) ;
                                    VALUES (m.loc_cMoedaItm, m.loc_nCotItm)
                                SELECT crImpMvCab
                            ENDIF
                        ELSE
                            loc_nCotItn = 0
                        ENDIF

                        IF !EMPTY(loc_cMoeOpe) AND loc_cMoeOpe # loc_cMoedaItn AND loc_nCotMov # 0
                            loc_nUnits    = loc_nUnits * loc_nCotItn / loc_nCotMov
                            loc_nTotas    = loc_nTotas * loc_nCotItn / loc_nCotMov
                            loc_cMoedaItn = loc_cMoeOpe
                        ENDIF

                        LOCAL loc_cCidChavesItn
                        loc_cCidChavesItn = fUniqueIds()

                        *-- INSERT SigMvItn (itens da movimentacao)
                        loc_cSQL = "INSERT INTO SigMvItn (" + ;
                                   "Emps, Dopes, Numes, EmpDopNums, Citens, CodBarras, " + ;
                                   "Cpros, Dpros, Obs, Moedas, Moevs, Moevals, Qtds, " + ;
                                   "Cunis, Pesos, Cunips, Fators, Units, Unit2s, Univals, " + ;
                                   "Totas, Valdescs, Valbases, Sitribs, Tpipis, Bcipis, " + ;
                                   "Baseipi2s, Baseipi3s, Aliqs, Valipis, Sittricms, " + ;
                                   "Baseicms, Baseicm2s, Baseicm3s, Aliqicms, Icms, Cfops, " + ;
                                   "Bcicmss, Icmss, Aliqpis, Vpis, Aliqcofs, Vcofins, " + ;
                                   "Iss, Irrf, Inss, Cssl, Aliqiis, Taxaiis, Nadis, Niadis, " + ;
                                   "Codfabs, Origmercs, CidChaves, Opers, " + ;
                                   "Datatrans, Dtalts) VALUES ("

                        loc_cSQL = loc_cSQL + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(loc_cDopes) + ", " + ;
                                   FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                   FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CITENS)), 0) + ", " + ;
                                   FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CODBARRAS)), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CPROS), 14)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.DPROS), 40)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OBS), 250)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMoedaItn, 3)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.MOEVS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.MOEVALS, 0), 6) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.QTDS, 0), 3) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CUNIS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.PESOS, 0), 3) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CUNIPS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.FATORS, 0), 3) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nTotas, 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALDESCS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALBASES, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.SITRIBS), 2)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.TPIPIS), 1)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BCIPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEIPI2S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEIPI3S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALIPIS, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.SITTRICMS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICMS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICM2S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICM3S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQICMS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ICMS, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CFOPS), 10)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BCICMSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ICMSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQCOFS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VCOFINS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ISS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.IRRF, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.INSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.CSSL, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQIIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.TAXAIIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.NADIS, 0), 0) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.NIADIS, 0), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODFABS), 60)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.ORIGMERCS), 1)) + ", " + ;
                                   EscaparSQL(loc_cCidChavesItn) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OPERS), 1)) + ", " + ;
                                   "GETDATE(), GETDATE())"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao inserir item da movimenta" + ;
                                    CHR(231) + CHR(227) + "o.", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            EXIT
                        ENDIF

                        *-- Validar e inserir grade cor/tamanho (SigMvIts) se informado
                        IF loc_lOk AND ;
                           (!EMPTY(ALLTRIM(crImpMvCab.CODCORS)) OR !EMPTY(ALLTRIM(crImpMvCab.CODTAMS)))

                            IF !EMPTY(ALLTRIM(crImpMvCab.CODCORS))
                                loc_cSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + ;
                                           EscaparSQL(ALLTRIM(crImpMvCab.CODCORS))
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorImp") < 1
                                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCor).", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF loc_lOk AND EOF("cursor_4c_CorImp")
                                    loc_cMsg = "Cor " + ALLTRIM(crImpMvCab.CODCORS) + ;
                                               " n" + CHR(227) + "o cadastrada."
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF USED("cursor_4c_CorImp")
                                    USE IN cursor_4c_CorImp
                                ENDIF
                                SELECT crImpMvCab
                            ENDIF

                            IF loc_lOk AND !EMPTY(ALLTRIM(crImpMvCab.CODTAMS))
                                loc_cSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + ;
                                           EscaparSQL(ALLTRIM(crImpMvCab.CODTAMS))
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TamImp") < 1
                                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdTam).", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF loc_lOk AND EOF("cursor_4c_TamImp")
                                    loc_cMsg = "Tamanho " + ALLTRIM(crImpMvCab.CODTAMS) + ;
                                               " n" + CHR(227) + "o cadastrado."
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF USED("cursor_4c_TamImp")
                                    USE IN cursor_4c_TamImp
                                ENDIF
                                SELECT crImpMvCab
                            ENDIF

                            IF loc_lOk
                                LOCAL loc_cCidChavesIts
                                loc_cCidChavesIts = fUniqueIds()

                                loc_cSQL = "INSERT INTO SigMvIts (" + ;
                                           "Citens, Emps, Dopes, Numes, Cpros, " + ;
                                           "CodEmbs, CodTams, CodCors, " + ;
                                           "Qtds, Aqtds, Qtdembs, Aqtdembs, " + ;
                                           "Qtbaixas, Prembs, CodembEnts, Qtdents, " + ;
                                           "CodBarras, Pesos, Qtbxprods, Qtprods, " + ;
                                           "Datatrans, Locals, Ntrans, Qtreservas, " + ;
                                           "CidChaves, EmpDopNums, ChkSubn, Compris, Dtalts) VALUES (" + ;
                                           FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CITENS)), 0) + ", " + ;
                                           EscaparSQL(loc_cEmps) + ", " + ;
                                           EscaparSQL(loc_cDopes) + ", " + ;
                                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CPROS), 14)) + ", " + ;
                                           "'', " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODTAMS), 4)) + ", " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODCORS), 4)) + ", " + ;
                                           FormatarNumeroSQL(NVL(crImpMvCab.QTDS, 0), 3) + ", " + ;
                                           "0, 1, 1, 0, 0, '', 0, " + ;
                                           FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CODBARRAS)), 0) + ", " + ;
                                           FormatarNumeroSQL(NVL(crImpMvCab.PESOS, 0), 3) + ", " + ;
                                           "0, 0, GETDATE(), " + ;
                                           "'', 0, 0, " + ;
                                           EscaparSQL(loc_cCidChavesIts) + ", " + ;
                                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                           "0, 0, GETDATE())"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    MsgErro("Falha ao inserir grade da movimenta" + ;
                                            CHR(231) + CHR(227) + "o.", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Acumular total (loc_nTotas ja esta convertido para moeda da operacao)
                        IF loc_lOk
                            loc_nValtot = loc_nValtot + loc_nTotas
                        ELSE
                            EXIT
                        ENDIF

                        SELECT crImpMvCab
                    ENDSCAN

                    *-- Atualizar total no cabecalho
                    IF loc_lOk
                        loc_cSQL = "UPDATE SigMvCab SET " + ;
                                   "Valos = " + FormatarNumeroSQL(loc_nValtot, 2) + ;
                                   ", ValInis = " + FormatarNumeroSQL(loc_nValtot, 2) + ;
                                   " WHERE EmpDopNums = " + EscaparSQL(LEFT(loc_cEDN, 29))
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao atualizar total do cabe" + CHR(231) + "alho.", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                        ENDIF
                    ENDIF

                    *-- Inserir registros por moeda em SigMvMov
                    IF loc_lOk
                        SELECT TmpTotal
                        SCAN
                            IF !EMPTY(ALLTRIM(TmpTotal.Moeds)) AND TmpTotal.MoeVals # 0
                                LOCAL loc_cCidChavesMov
                                loc_cCidChavesMov = fUniqueIds()

                                loc_cSQL = "INSERT INTO SigMvMov (" + ;
                                           "NSinals, Emps, Dopes, Numes, Moeds, " + ;
                                           "ValTots, ValItens, ValDifs, PorcDifs, Tipos, " + ;
                                           "Datatrans, Ntrans, Locals, Coefs, Mobras, " + ;
                                           "Qtdes, Teors, CidChaves, Dtalts, " + ;
                                           "EmpDopNums, Moevals) VALUES (" + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.nSinals, 0), 0) + ", " + ;
                                           EscaparSQL(loc_cEmps) + ", " + ;
                                           EscaparSQL(loc_cDopes) + ", " + ;
                                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                           EscaparSQL(ALLTRIM(TmpTotal.Moeds)) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valtots, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valitens, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valdifs, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.PorcDifs, 0), 4) + ", " + ;
                                           EscaparSQL(ALLTRIM(TmpTotal.Tipos)) + ", " + ;
                                           "NULL, 0, '', " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Coefs, 0), 3) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Mobras, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Qtdes, 0), 3) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Teors, 0), 3) + ", " + ;
                                           EscaparSQL(loc_cCidChavesMov) + ", " + ;
                                           IIF(!EMPTY(loc_dDatasArq), FormatarDataSQL(loc_dDatasArq), "NULL") + ", " + ;
                                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                           FormatarNumeroSQL(TmpTotal.MoeVals, 5) + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    MsgErro("Falha ao inserir movimenta" + ;
                                            CHR(231) + CHR(227) + "o de moeda.", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                    EXIT
                                ENDIF
                            ENDIF
                            SELECT TmpTotal
                        ENDSCAN
                    ENDIF
                ENDIF

                *-- Finalizar transacao
                IF loc_lOk
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.this_lResultadoOk  = .T.
                    THIS.this_cMensagemErro = ""
                    MsgInfo("Arquivo '" + par_cArquivo + "' importado com sucesso!", ;
                            "Importa" + CHR(231) + CHR(227) + "o conclu" + CHR(237) + "da")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = loc_cMsg
                    IF !EMPTY(loc_cMsg)
                        MsgAviso(par_cArquivo + " - " + loc_cMsg, ;
                                 "Importa" + CHR(231) + CHR(227) + "o cancelada")
                    ENDIF
                ENDIF

            ELSE
                THIS.this_cMensagemErro = loc_cMsg
                IF !EMPTY(loc_cMsg)
                    MsgAviso(par_cArquivo + " - " + loc_cMsg, ;
                             "Importa" + CHR(231) + CHR(227) + "o cancelada")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ProcessarArquivo")
            THIS.this_cMensagemErro = loc_oErro.Message
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDTRY

        *-- Limpar cursores temporarios
        IF USED("crImpMvCab")
            USE IN crImpMvCab
        ENDIF
        IF USED("TmpTotal")
            USE IN TmpTotal
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

