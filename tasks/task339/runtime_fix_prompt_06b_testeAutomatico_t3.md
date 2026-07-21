# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigprtrf
Erro: No PARAMETER statement is found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-19 00:06:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-19 00:06:56] [INFO] Config FPW: (nao fornecido)
[2026-07-19 00:06:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-19 00:06:56] [INFO] Timeout: 300 segundos
[2026-07-19 00:06:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwnzcgvw.prg
[2026-07-19 00:06:56] [INFO] Conteudo do wrapper:
[2026-07-19 00:06:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
QUIT

[2026-07-19 00:06:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwnzcgvw.prg
[2026-07-19 00:06:56] [INFO] VFP output esperado em: C:\4c\tasks\task339\vfp_output.txt
[2026-07-19 00:06:56] [INFO] Executando Visual FoxPro 9...
[2026-07-19 00:06:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwnzcgvw.prg
[2026-07-19 00:06:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwnzcgvw.prg
[2026-07-19 00:06:56] [INFO] Timeout configurado: 300 segundos
[2026-07-19 00:07:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-19 00:07:28] [INFO] VFP9 finalizado em 31.6736306 segundos
[2026-07-19 00:07:28] [INFO] Exit Code: 
[2026-07-19 00:07:28] [INFO] 
[2026-07-19 00:07:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-19 00:07:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwnzcgvw.prg
[2026-07-19 00:07:28] [INFO] 
[2026-07-19 00:07:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-19 00:07:28] [INFO] * Auto-generated wrapper for parameters
[2026-07-19 00:07:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-19 00:07:28] [INFO] * Parameters: 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
[2026-07-19 00:07:28] [INFO] 
[2026-07-19 00:07:28] [INFO] * Anti-dialog protections for unattended execution
[2026-07-19 00:07:28] [INFO] SET SAFETY OFF
[2026-07-19 00:07:28] [INFO] SET RESOURCE OFF
[2026-07-19 00:07:28] [INFO] SET TALK OFF
[2026-07-19 00:07:28] [INFO] SET NOTIFY OFF
[2026-07-19 00:07:28] [INFO] SYS(2335, 0)
[2026-07-19 00:07:28] [INFO] 
[2026-07-19 00:07:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
[2026-07-19 00:07:28] [INFO] QUIT
[2026-07-19 00:07:28] [INFO] 
[2026-07-19 00:07:28] [INFO] === Fim do Wrapper.prg ===
[2026-07-19 00:07:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-19 00:08:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-19 00:08:12] [INFO] Config FPW: (nao fornecido)
[2026-07-19 00:08:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-19 00:08:12] [INFO] Timeout: 300 segundos
[2026-07-19 00:08:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t4vuc5bw.prg
[2026-07-19 00:08:12] [INFO] Conteudo do wrapper:
[2026-07-19 00:08:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
QUIT

[2026-07-19 00:08:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t4vuc5bw.prg
[2026-07-19 00:08:12] [INFO] VFP output esperado em: C:\4c\tasks\task339\vfp_output.txt
[2026-07-19 00:08:12] [INFO] Executando Visual FoxPro 9...
[2026-07-19 00:08:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t4vuc5bw.prg
[2026-07-19 00:08:12] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t4vuc5bw.prg
[2026-07-19 00:08:12] [INFO] Timeout configurado: 300 segundos
[2026-07-19 00:08:48] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-19 00:08:48] [INFO] VFP9 finalizado em 35.6294059 segundos
[2026-07-19 00:08:48] [INFO] Exit Code: 
[2026-07-19 00:08:48] [INFO] 
[2026-07-19 00:08:48] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-19 00:08:48] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t4vuc5bw.prg
[2026-07-19 00:08:48] [INFO] 
[2026-07-19 00:08:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-19 00:08:48] [INFO] * Auto-generated wrapper for parameters
[2026-07-19 00:08:48] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-19 00:08:48] [INFO] * Parameters: 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
[2026-07-19 00:08:48] [INFO] 
[2026-07-19 00:08:48] [INFO] * Anti-dialog protections for unattended execution
[2026-07-19 00:08:48] [INFO] SET SAFETY OFF
[2026-07-19 00:08:48] [INFO] SET RESOURCE OFF
[2026-07-19 00:08:48] [INFO] SET TALK OFF
[2026-07-19 00:08:48] [INFO] SET NOTIFY OFF
[2026-07-19 00:08:48] [INFO] SYS(2335, 0)
[2026-07-19 00:08:48] [INFO] 
[2026-07-19 00:08:48] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
[2026-07-19 00:08:48] [INFO] QUIT
[2026-07-19 00:08:48] [INFO] 
[2026-07-19 00:08:48] [INFO] === Fim do Wrapper.prg ===
[2026-07-19 00:08:48] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-19 00:09:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-19 00:09:19] [INFO] Config FPW: (nao fornecido)
[2026-07-19 00:09:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-19 00:09:19] [INFO] Timeout: 300 segundos
[2026-07-19 00:09:19] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saadrldd.prg
[2026-07-19 00:09:19] [INFO] Conteudo do wrapper:
[2026-07-19 00:09:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
QUIT

[2026-07-19 00:09:19] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saadrldd.prg
[2026-07-19 00:09:19] [INFO] VFP output esperado em: C:\4c\tasks\task339\vfp_output.txt
[2026-07-19 00:09:19] [INFO] Executando Visual FoxPro 9...
[2026-07-19 00:09:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saadrldd.prg
[2026-07-19 00:09:19] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saadrldd.prg
[2026-07-19 00:09:19] [INFO] Timeout configurado: 300 segundos
[2026-07-19 00:09:54] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-19 00:09:54] [INFO] VFP9 finalizado em 35.6449656 segundos
[2026-07-19 00:09:54] [INFO] Exit Code: 
[2026-07-19 00:09:54] [INFO] 
[2026-07-19 00:09:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-19 00:09:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saadrldd.prg
[2026-07-19 00:09:54] [INFO] 
[2026-07-19 00:09:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-19 00:09:54] [INFO] * Auto-generated wrapper for parameters
[2026-07-19 00:09:54] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-19 00:09:54] [INFO] * Parameters: 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
[2026-07-19 00:09:54] [INFO] 
[2026-07-19 00:09:54] [INFO] * Anti-dialog protections for unattended execution
[2026-07-19 00:09:54] [INFO] SET SAFETY OFF
[2026-07-19 00:09:54] [INFO] SET RESOURCE OFF
[2026-07-19 00:09:54] [INFO] SET TALK OFF
[2026-07-19 00:09:54] [INFO] SET NOTIFY OFF
[2026-07-19 00:09:54] [INFO] SYS(2335, 0)
[2026-07-19 00:09:54] [INFO] 
[2026-07-19 00:09:54] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRTRF', 'C:\4c\tasks\task339', 'OPERACIONAL'
[2026-07-19 00:09:54] [INFO] QUIT
[2026-07-19 00:09:54] [INFO] 
[2026-07-19 00:09:54] [INFO] === Fim do Wrapper.prg ===
[2026-07-19 00:09:54] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRTRF",
  "timestamp": "20260719000954",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTRF.prg):
*==============================================================================
* FormSIGPRTRF.prg - Formulario Operacional: Relacao de Produtos
* Herda de: FormBase
* Tipo: OPERACIONAL flat (sem PageFrame)
* BO: SIGPRTRFBO
* Funcao: dialogo de selecao de produtos para transmissao ECF
* Retorno: this_cRetorno ("Ok" = confirmado, " " = cancelado)
*==============================================================================

DEFINE CLASS FormSIGPRTRF AS FormBase

    *-- Dimensoes e aparencia (identicas ao SCX original SIGPRTRF)
    this_cMensagemErro = ""
    Width        = 436
    Height       = 450
    AutoCenter   = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    WindowType   = 1
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    DataSession  = 2

    *-- Retorno do dialogo (" " = cancelado, "Ok" = confirmado)
    this_cRetorno   = " "

    *-- Codigo anterior para deteccao de mudanca (equivalente a AntCPro)
    this_cAntCPro   = ""

    *-- Tempo de espera ECF em segundos (carregado de SigCdPac.ClockEcfs)
    this_nClockEcfs = 0

    *==========================================================================
    * Init - Cria BO e inicializa form via FormBase
    *==========================================================================
    PROCEDURE Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRTRFBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRTRFBO.", ;
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

        THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Produtos"

        TRY
            *-- Criar cursor de produtos (RecordSource do grid - adicionado na Fase 4)
            SET NULL ON
            IF USED("CrProduto")
                TABLEREVERT(.T., "CrProduto")
                USE IN CrProduto
            ENDIF
            CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
            SET NULL OFF

            *-- Linha em branco inicial para entrada imediata
            SELECT CrProduto
            APPEND BLANK

            *-- Carregar tempo de espera ECF de SigCdPac
            THIS.this_oBusinessObject.CarregarConfiguracao()
            THIS.this_nClockEcfs = THIS.this_oBusinessObject.this_nClockEcfs

            *-- Montar layout do form
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarReferencia()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.ConfigurarMensagem()
            THIS.ConfigurarBotoes()
            THIS.TornarControlesVisiveis()

            *-- Focar na primeira celula do grid apos montagem
            IF VARTYPE(THIS.cnt_4c_Referencia.grd_4c_Dados) = "O"
                THIS.cnt_4c_Referencia.grd_4c_Dados.Column1.Text1.SetFocus()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSIGPRTRF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form flat sem PageFrame; compatibilidade com pipeline
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Form flat: sem PageFrame, cor de fundo neutra
        THIS.BackColor = RGB(240, 240, 240)
    ENDPROC

    *==========================================================================
    * ConfigurarReferencia - Container principal com label identificador
    * Grid (grd_4c_Dados) sera adicionado na Fase 4
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarReferencia()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Referencia", "Container")
        loc_oCnt = THIS.cnt_4c_Referencia
        WITH loc_oCnt
            .Top         = 1
            .Left        = 2
            .Width       = 433
            .Height      = 392
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(128, 128, 128)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Ident", "Label")
        WITH loc_oCnt.lbl_4c_Ident
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontSize    = 11
            .FontName    = "Tahoma"
            .Alignment   = 2
            .BackStyle   = 0
            .Caption     = "Informe os Produtos"
            .Height      = 20
            .Left        = 8
            .Top         = 57
            .Width       = 200
            .ForeColor   = RGB(0, 0, 255)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarMensagem - Container de progresso ECF (fica Visible=.F. ate Ok)
    * 13 textboxes coloridos animados simulam barra de progresso (padrao legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMensagem()
        LOCAL loc_oCnt, loc_nI, loc_nLeft, loc_cNome

        THIS.AddObject("cnt_4c_Mensagem", "Container")
        loc_oCnt = THIS.cnt_4c_Mensagem
        WITH loc_oCnt
            .Top          = 395
            .Left         = 3
            .Width        = 302
            .Height       = 55
            .SpecialEffect = 0
            .BackStyle    = 1
            .BackColor    = RGB(240, 240, 240)
            .Visible      = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Mensagem1", "Label")
        WITH loc_oCnt.lbl_4c_Mensagem1
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontSize    = 14
            .FontName    = "Tahoma"
            .Caption     = "Aguarde. Verificando Dados!!!"
            .Height      = 25
            .Left        = 16
            .Top         = 2
            .Width       = 277
            .ForeColor   = RGB(255, 0, 0)
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- 13 textboxes para animacao de progresso (Left: 55, 71, 87...247, incremento 16)
        FOR loc_nI = 1 TO 13
            loc_cNome  = "txt_4c_Botao" + TRANSFORM(loc_nI)
            loc_nLeft  = 55 + (loc_nI - 1) * 16
            loc_oCnt.AddObject(loc_cNome, "TextBox")
            WITH loc_oCnt.&loc_cNome.
                .BorderStyle = 0
                .Height      = 11
                .Left        = loc_nLeft
                .Top         = 34
                .Width       = 13
                .BackColor   = RGB(255, 0, 0)
                .ReadOnly    = .T.
                .Visible     = .T.
            ENDWITH
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Form flat sem Page2; compatibilidade com pipeline
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form flat sem Page2: elementos criados em ConfigurarBotoes
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Shape decorativo + botoes Ok e Cancelar
    * Shape1 original: Top=396 Left=311 Width=121 Height=52 SpecialEffect=0
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Shape decorativo de fundo (identico ao Shape1 do SCX original)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 396
            .Left          = 311
            .Width         = 121
            .Height        = 52
            .SpecialEffect = 0
            .BackStyle     = 0
            .FillStyle     = 1
            .BorderColor   = RGB(128, 128, 128)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 399
            .Left            = 314
            .Width           = 58
            .Height          = 47
            .FontBold        = .T.
            .FontName        = "Tahoma"
            .FontSize        = 7
            .Caption         = "\<Ok"
            .ForeColor       = RGB(0, 128, 0)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "A_SAVE1.BMP"
            .DisabledPicture = gc_4c_CaminhoIcones + "A_SAVE1.BMP"
            .PicturePosition = 13
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 399
            .Left            = 372
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontName        = "Tahoma"
            .FontSize        = 7
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "CANCELAR.BMP"
            .DisabledPicture = gc_4c_CaminhoIcones + "CANCELAR.BMP"
            .PicturePosition = 13
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Ok,       "Click", THIS, "CmdOkClick")
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "CmdCancelarClick")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis
    * cnt_4c_Mensagem permanece Visible=.F. mas seus filhos ficam visiveis
    * cnt_4c_Referencia gerenciado por ConfigurarReferencia; filhos tornados visiveis
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_MENSAGEM", "CNT_4C_REFERENCIA")
                    *-- Containers gerenciados: torna filhos visiveis sem alterar Visible do container
                    THIS.TornarSubControlesVisiveis(loc_oControl)
                    *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF
                loc_oControl.Visible = .T.
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                loc_oControl.Visible = .T.
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Unload - Retorna valor do dialogo ao chamador (padrao DO FORM xxx TO var)
    *==========================================================================
    PROCEDURE Unload()
        RETURN THIS.this_cRetorno
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar o form
    * Cursors em DataSession=2 sao limpos automaticamente pelo VFP9
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Adiciona grid de produtos ao cnt_4c_Referencia
    * Equivalente a sigprtrf.Cnt_Referencia.Grade do SCX original
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCnt, loc_oGrd

        loc_oCnt = THIS.cnt_4c_Referencia
        loc_oCnt.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = loc_oCnt.grd_4c_Dados

        WITH loc_oGrd
            .Top                = 78
            .Left               = 3
            .Width              = 429
            .Height             = 309
            .ColumnCount        = 2
            .ScrollBars         = 2
            .FontName           = "Arial"
            .FontSize           = 8
            .ReadOnly           = .F.
            .RowHeight          = 17
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .GridLineColor      = RGB(200, 200, 200)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
        ENDWITH

        *-- Coluna 1: Codigo do Produto
        WITH loc_oGrd.Column1
            .Width      = 108
            .FontName   = "Courier New"
            .FontSize   = 8
            .Movable    = .F.
            .Resizable  = .F.
            .ReadOnly   = .F.
            .Sparse     = .F.
            .Format     = "K!"
        ENDWITH
        WITH loc_oGrd.Column1.Header1
            .Caption   = "C" + CHR(243) + "d. Produto"
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrd.Column1.Text1
            .InputMask   = "!!!!!!!!!!"
            .FontName    = "Courier New"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 0
            .Margin      = 0
        ENDWITH

        *-- Coluna 2: Descricao do Produto (somente leitura)
        WITH loc_oGrd.Column2
            .Width      = 290
            .FontName   = "Courier New"
            .FontSize   = 8
            .Movable    = .F.
            .Resizable  = .F.
            .ReadOnly   = .T.
            .Sparse     = .F.
        ENDWITH
        WITH loc_oGrd.Column2.Header1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrd.Column2.Text1
            .FontName    = "Courier New"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 0
            .Margin      = 0
        ENDWITH

        *-- Vincular RecordSource e ControlSources
        loc_oGrd.RecordSource          = "CrProduto"
        loc_oGrd.Column1.ControlSource = "CrProduto.Cpros"
        loc_oGrd.Column2.ControlSource = "CrProduto.Dpros"

        *-- Redefinir cabecalhos apos RecordSource (VFP9 os reseta)
        loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
        loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"

        *-- Vincular eventos de teclado e foco da Column1.Text1
        BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus", THIS, "TxtCodProdGotFocus")
        BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "TxtCodProdKeyPress")
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form flat sem PageFrame; mantido para compatibilidade
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        *-- Form flat sem PageFrame: nao ha paginas a alternar
        RETURN
    ENDPROC

    *==========================================================================
    * TxtCodProdGotFocus - Salva valor antes da edicao (equivalente ao When do SCX)
    *==========================================================================
    PROCEDURE TxtCodProdGotFocus()
        THIS.this_cAntCPro = ALLTRIM(THIS.cnt_4c_Referencia.grd_4c_Dados.Column1.Text1.Value)
    ENDPROC

    *==========================================================================
    * TxtCodProdKeyPress - Lookup de produto em SigCdPro por Enter/Tab/F4
    * Implementa logica do Valid (fwBuscaExt) e LostFocus (navegacao) do SCX
    *==========================================================================
    PROCEDURE TxtCodProdKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        LOCAL loc_oGrd, loc_oTxt, loc_cCodigo, loc_cDpros
        LOCAL loc_cSQL, loc_oBusca, loc_lAchou, loc_nRecno
        loc_oGrd    = THIS.cnt_4c_Referencia.grd_4c_Dados
        loc_oTxt    = loc_oGrd.Column1.Text1
        loc_cCodigo = ALLTRIM(loc_oTxt.Value)
        loc_cDpros  = ""
        loc_lAchou  = .F.
        loc_nRecno  = 0

        *-- Codigo vazio: focar Ok se Enter, nao fazer mais nada
        IF EMPTY(loc_cCodigo)
            IF par_nKeyCode = 13
                THIS.cmd_4c_Ok.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- Codigo nao mudou e nao e F4: apenas navegar se Enter
        IF loc_cCodigo = THIS.this_cAntCPro AND par_nKeyCode != 115
            IF par_nKeyCode = 13
                SELECT CrProduto
                loc_nRecno = RECNO()
                LOCATE FOR EMPTY(Cpros)
                IF EOF()
                    APPEND BLANK
                ENDIF
                LOCATE FOR RECNO() = loc_nRecno
                KEYBOARD '{DNARROW}'
            ENDIF
            RETURN
        ENDIF

        *-- Busca exata no SQL Server
        loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
                   "WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCodigo)
        IF USED("cursor_4c_ProLkp")
            USE IN cursor_4c_ProLkp
        ENDIF
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProLkp") > 0
            IF NOT EOF("cursor_4c_ProLkp")
                SELECT cursor_4c_ProLkp
                loc_cCodigo = ALLTRIM(cpros)
                loc_cDpros  = ALLTRIM(dpros)
                loc_lAchou  = .T.
            ENDIF
            IF USED("cursor_4c_ProLkp")
                USE IN cursor_4c_ProLkp
            ENDIF
        ELSE
            IF USED("cursor_4c_ProLkp")
                USE IN cursor_4c_ProLkp
            ENDIF
        ENDIF

        *-- Nao encontrado: abrir picker FormBuscaAuxiliar
        IF NOT loc_lAchou
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_ProBusca", "cpros", ;
                ALLTRIM(loc_oTxt.Value), "Produtos", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
                    SELECT cursor_4c_ProBusca
                    loc_cCodigo = ALLTRIM(cpros)
                    loc_cDpros  = ALLTRIM(dpros)
                    loc_lAchou  = .T.
                ENDIF
                IF USED("cursor_4c_ProBusca")
                    USE IN cursor_4c_ProBusca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        ENDIF

        *-- Preencher campos no grid e navegar para proxima linha (se Enter)
        IF loc_lAchou
            loc_oTxt.Value = loc_cCodigo
            SELECT CrProduto
            REPLACE dpros WITH loc_cDpros
            loc_oGrd.Column2.Text1.Value = loc_cDpros
            loc_oGrd.Refresh()
            IF par_nKeyCode = 13
                loc_nRecno = RECNO()
                LOCATE FOR EMPTY(Cpros)
                IF EOF()
                    APPEND BLANK
                ENDIF
                LOCATE FOR RECNO() = loc_nRecno
                KEYBOARD '{DNARROW}'
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdOkClick - Confirma lista e aguarda ECF (animacao de barras coloridas)
    * Equivalente ao altera.Click do SCX original
    *==========================================================================
    PROCEDURE CmdOkClick()
        LOCAL loc_nCount, loc_ldDataI, loc_nW, loc_nX, loc_nTempo
        LOCAL loc_nBot, loc_cMacro

        SELECT CrProduto
        COUNT TO loc_nCount FOR NOT EMPTY(Cpros)
        IF loc_nCount = 0
            MsgAviso("Nenhum Produto Informado!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.cnt_4c_Mensagem.Visible = .T.
        loc_ldDataI = DATETIME()
        loc_nW      = THIS.this_nClockEcfs / 3
        loc_nX      = 13

        DO WHILE DATETIME() - loc_ldDataI < THIS.this_nClockEcfs
            loc_nTempo = DATETIME() - loc_ldDataI
            IF loc_nX >= 13
                loc_nX = 1
            ELSE
                loc_nX = loc_nX + 1
            ENDIF
            IF loc_nTempo > loc_nW
                IF loc_nTempo < loc_nW * 2
                    FOR loc_nBot = 1 TO 13
                        loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
                                     ALLTRIM(STR(loc_nBot, 2))
                        &loc_cMacro..BackColor = 65535
                    ENDFOR
                ELSE
                    FOR loc_nBot = 1 TO 13
                        loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
                                     ALLTRIM(STR(loc_nBot, 2))
                        &loc_cMacro..BackColor = 4227072
                    ENDFOR
                ENDIF
            ELSE
                FOR loc_nBot = 1 TO 13
                    loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
                                 ALLTRIM(STR(loc_nBot, 2))
                    &loc_cMacro..BackColor = 255
                ENDFOR
            ENDIF

            FOR loc_nBot = 1 TO 13
                loc_cMacro = 'THIS.cnt_4c_Mensagem.txt_4c_Botao' + ;
                             ALLTRIM(STR(loc_nBot, 2))
                &loc_cMacro..Visible = loc_nBot <= loc_nX
            ENDFOR
        ENDDO

        THIS.this_cRetorno = "Ok"
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CmdCancelarClick - Cancela dialogo sem transmitir produtos
    * Equivalente ao sair.Click do SCX original
    *==========================================================================
    PROCEDURE CmdCancelarClick()
        THIS.this_cRetorno = " "
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Adiciona nova linha em branco ao cursor de produtos
    * Anexa a CrProduto e move o foco para a coluna de codigo do grid
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oGrd, loc_nRecno

        IF NOT USED("CrProduto")
            SET NULL ON
            CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
            SET NULL OFF
        ENDIF

        SELECT CrProduto
        LOCATE FOR EMPTY(Cpros)
        IF EOF()
            APPEND BLANK
        ENDIF
        loc_nRecno = RECNO()

        loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            loc_oGrd.Refresh()
            loc_oGrd.SetFocus()
            loc_oGrd.ActivateCell(loc_nRecno, 1)
            loc_oGrd.Column1.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Habilita edicao da linha corrente do grid de produtos
    * Move foco para a coluna Codigo do Produto na linha selecionada
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrd

        IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
            MsgAviso("Nenhum produto informado para alterar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            loc_oGrd.Column1.ReadOnly = .F.
            loc_oGrd.Refresh()
            loc_oGrd.SetFocus()
            loc_oGrd.Column1.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Coloca o grid em modo somente-leitura para consulta
    * Refresh do grid com colunas em readonly (visualizacao pura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrd

        IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
            MsgAviso("Nenhum produto informado para visualizar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            loc_oGrd.Column1.ReadOnly = .T.
            loc_oGrd.Column2.ReadOnly = .T.
            SELECT CrProduto
            GO TOP
            loc_oGrd.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove linha corrente do cursor de produtos
    * Confirma com MsgConfirma antes de DELETE + PACK
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oGrd, loc_cCodigo, loc_lConfirma

        IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
            MsgAviso("Nenhum produto informado para excluir.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT CrProduto
        IF EMPTY(Cpros)
            MsgAviso("Selecione uma linha com produto v" + CHR(225) + "lido.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cCodigo   = ALLTRIM(Cpros)
        loc_lConfirma = MsgConfirma("Excluir o produto " + loc_cCodigo + " da rela" + ;
                                    CHR(231) + CHR(227) + "o?", ;
                                    "Confirma" + CHR(231) + CHR(227) + "o")
        IF NOT loc_lConfirma
            RETURN
        ENDIF

        SELECT CrProduto
        DELETE
        PACK
        IF RECCOUNT("CrProduto") = 0
            APPEND BLANK
        ENDIF
        GO TOP

        loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            loc_oGrd.Refresh()
            loc_oGrd.SetFocus()
            loc_oGrd.Column1.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre lookup de produto para a linha corrente do grid
    * Equivalente a pressionar F4 na coluna Codigo do Produto
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oGrd, loc_oTxt, loc_cCodigo, loc_cDpros, loc_oBusca

        IF NOT USED("CrProduto")
            MsgAviso("Nenhum produto informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_oGrd    = THIS.cnt_4c_Referencia.grd_4c_Dados
        loc_oTxt    = loc_oGrd.Column1.Text1
        loc_cCodigo = ALLTRIM(loc_oTxt.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_ProBusca", "cpros", ;
            loc_cCodigo, "Produtos", .T., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
                SELECT cursor_4c_ProBusca
                loc_cCodigo = ALLTRIM(cpros)
                loc_cDpros  = ALLTRIM(dpros)
                loc_oTxt.Value = loc_cCodigo
                SELECT CrProduto
                REPLACE dpros WITH loc_cDpros
                loc_oGrd.Column2.Text1.Value = loc_cDpros
                loc_oGrd.Refresh()
            ENDIF
            IF USED("cursor_4c_ProBusca")
                USE IN cursor_4c_ProBusca
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Cancela o dialogo sem transmitir produtos
    * Alias de CmdCancelarClick para compatibilidade com o pipeline
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma a lista de produtos (alias de CmdOkClick)
    * Compatibilidade com o pipeline de migracao
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdOkClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao corrente e restaura linha anterior
    * Em dialogo sem modo edicao separado: equivale a cancelar selecao
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oGrd

        SELECT CrProduto
        IF NOT EMPTY(THIS.this_cAntCPro)
            REPLACE Cpros WITH THIS.this_cAntCPro
        ENDIF
        THIS.this_cAntCPro = ""

        loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            loc_oGrd.Refresh()
            loc_oGrd.SetFocus()
            loc_oGrd.Column1.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere a lista de produtos do cursor CrProduto para o BO
    * O BO guarda a lista para processamento posterior (transmissao ECF)
    *==========================================================================
    PROCEDURE FormParaBO()
        IF NOT USED("CrProduto")
            RETURN
        ENDIF
        THIS.this_oBusinessObject.CarregarProdutosDeCursor("CrProduto")
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega lista de produtos do BO no cursor CrProduto
    * Usado quando o dialogo reabre com uma lista pre-existente
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oGrd

        IF NOT USED("CrProduto")
            SET NULL ON
            CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
            SET NULL OFF
        ENDIF

        SELECT CrProduto
        ZAP

        THIS.this_oBusinessObject.PopularCursorProdutos("CrProduto")

        IF RECCOUNT("CrProduto") = 0
            SELECT CrProduto
            APPEND BLANK
        ENDIF

        GO TOP

        loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            loc_oGrd.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita edicao do grid de produtos
    * par_lHabilitar: .T. = edicao livre; .F. = somente visualizacao
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oGrd

        loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
        IF VARTYPE(loc_oGrd) != "O"
            RETURN
        ENDIF

        IF VARTYPE(par_lHabilitar) != "L"
            par_lHabilitar = .T.
        ENDIF

        loc_oGrd.Column1.ReadOnly = !par_lHabilitar
        loc_oGrd.Refresh()
    ENDPROC

    *==========================================================================
    * LimparCampos - Esvazia a lista de produtos e redefine linha inicial
    * Equivale ao estado inicial do dialogo
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oGrd

        IF USED("CrProduto")
            SELECT CrProduto
            ZAP
            APPEND BLANK
        ENDIF

        THIS.this_cAntCPro = ""

        loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O"
            loc_oGrd.Refresh()
            loc_oGrd.SetFocus()
            loc_oGrd.Column1.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Atualiza o grid com o conteudo corrente de CrProduto
    * Redefine RecordSource e cabecalhos (VFP9 os reseta apos RecordSource)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrd, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF NOT USED("CrProduto")
                SET NULL ON
                CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
                SET NULL OFF
                SELECT CrProduto
                APPEND BLANK
            ENDIF

            loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.ColumnCount          = 2
                loc_oGrd.RecordSource         = "CrProduto"
                loc_oGrd.Column1.ControlSource = "CrProduto.Cpros"
                loc_oGrd.Column2.ControlSource = "CrProduto.Dpros"
                loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
                loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
                loc_oGrd.Refresh()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | LN: " + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao carregar lista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Sem modo separado neste dialogo; sem botoes CRUD
    * Mantido para compatibilidade com o pipeline
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmd_4c_Ok) = "O"
            THIS.cmd_4c_Ok.Enabled = .T.
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Cancelar) = "O"
            THIS.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRTRFBO.prg):
*==============================================================================
* SIGPRTRFBO.prg - Business Object para Relacao de Produtos (SIGPRTRF)
* Formulario OPERACIONAL - dialogo de selecao de produtos
* Tabela principal: SigCdPro (lookup de produtos)
* Tabela auxiliar:  SigCdPac (ClockEcfs - tempo de espera ECF)
*==============================================================================

DEFINE CLASS SIGPRTRFBO AS BusinessBase

    *-- Tabela e chave primaria
    this_cTabela     = "SigCdPro"
    this_cCampoChave = "cpros"

    *-- Configuracao de temporizacao (SigCdPac.ClockEcfs)
    this_nClockEcfs  = 0

    *-- Estado do dialogo
    this_cRetorno    = " "
    this_cAntCPro    = ""

    *-- Produto corrente (cpros char(14), dpros char(40))
    this_cCpros      = ""
    this_cDpros      = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarConfiguracao - carrega ClockEcfs de SigCdPac
    *==========================================================================
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.
        loc_cSQL     = "SELECT ClockEcfs FROM SigCdPac"

        TRY
            IF USED("cursor_4c_Pac")
                TABLEREVERT(.T., "cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    THIS.this_nClockEcfs = NVL(ClockEcfs, 0)
                ELSE
                    THIS.this_nClockEcfs = 0
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_nClockEcfs = 0
                loc_lSucesso         = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_nClockEcfs = 0
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarProduto - busca produtos por codigo/descricao em SigCdPro
    * par_cCodigo        - valor digitado para busca (LIKE prefix)
    * par_cCursorDestino - cursor de destino (default: cursor_4c_Prods)
    * Retorna .T. se SQLEXEC bem-sucedido
    *==========================================================================
    PROCEDURE BuscarProduto(par_cCodigo, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCursor

        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_Prods", par_cCursorDestino)
        loc_cSQL     = "SELECT cpros, dpros FROM SigCdPro" + ;
                       " WHERE cpros LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%") + ;
                       " ORDER BY cpros"

        TRY
            IF USED(loc_cCursor)
                TABLEREVERT(.T., loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarProduto - valida se codigo exato existe em SigCdPro
    * Popula this_cCpros e this_cDpros com dados do produto encontrado
    * Retorna .T. se encontrado, .F. caso contrario
    *==========================================================================
    PROCEDURE ValidarProduto(par_cCodigo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso     = .F.
        THIS.this_cCpros = ""
        THIS.this_cDpros = ""

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro" + ;
                   " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCodigo))

        TRY
            IF USED("cursor_4c_ProdVal")
                TABLEREVERT(.T., "cursor_4c_ProdVal")
                USE IN cursor_4c_ProdVal
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal") > 0
                IF USED("cursor_4c_ProdVal") AND !EOF("cursor_4c_ProdVal")
                    SELECT cursor_4c_ProdVal
                    THIS.this_cCpros = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cDpros = ALLTRIM(NVL(dpros, ""))
                    loc_lSucesso     = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros = TratarNulo(cpros, "C")
            THIS.this_cDpros = TratarNulo(dpros, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna chave primaria do produto corrente
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDPROC

    *==========================================================================
    * ValidarDados - valida dados antes de confirmar selecao
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + ;
                                      CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

ENDDEFINE

