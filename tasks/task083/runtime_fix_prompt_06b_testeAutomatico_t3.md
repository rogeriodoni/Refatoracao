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
Form: Formsigredtv
Erro: Error with Column1 - CurrentControl : Expression evaluated to an illegal value.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-04 11:06:37] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 11:06:37] [INFO] Config FPW: (nao fornecido)
[2026-06-04 11:06:37] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 11:06:37] [INFO] Timeout: 300 segundos
[2026-06-04 11:06:37] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fq3fwjam.prg
[2026-06-04 11:06:37] [INFO] Conteudo do wrapper:
[2026-06-04 11:06:37] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
QUIT

[2026-06-04 11:06:37] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fq3fwjam.prg
[2026-06-04 11:06:37] [INFO] VFP output esperado em: C:\4c\tasks\task083\vfp_output.txt
[2026-06-04 11:06:37] [INFO] Executando Visual FoxPro 9...
[2026-06-04 11:06:37] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fq3fwjam.prg
[2026-06-04 11:06:37] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fq3fwjam.prg
[2026-06-04 11:06:37] [INFO] Timeout configurado: 300 segundos
[2026-06-04 11:11:37] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 18092)...
[2026-06-04 11:11:39] [INFO] VFP9 finalizado em 302.070381 segundos
[2026-06-04 11:11:39] [INFO] Exit Code: 4
[2026-06-04 11:11:40] [INFO] 
[2026-06-04 11:11:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 11:11:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fq3fwjam.prg
[2026-06-04 11:11:40] [INFO] 
[2026-06-04 11:11:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 11:11:40] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 11:11:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 11:11:40] [INFO] * Parameters: 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
[2026-06-04 11:11:40] [INFO] 
[2026-06-04 11:11:40] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 11:11:40] [INFO] SET SAFETY OFF
[2026-06-04 11:11:40] [INFO] SET RESOURCE OFF
[2026-06-04 11:11:40] [INFO] SET TALK OFF
[2026-06-04 11:11:40] [INFO] SET NOTIFY OFF
[2026-06-04 11:11:40] [INFO] SYS(2335, 0)
[2026-06-04 11:11:40] [INFO] 
[2026-06-04 11:11:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
[2026-06-04 11:11:40] [INFO] QUIT
[2026-06-04 11:11:40] [INFO] 
[2026-06-04 11:11:40] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 11:11:40] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-06-04 11:12:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 11:12:56] [INFO] Config FPW: (nao fornecido)
[2026-06-04 11:12:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 11:12:56] [INFO] Timeout: 300 segundos
[2026-06-04 11:12:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_plgguual.prg
[2026-06-04 11:12:56] [INFO] Conteudo do wrapper:
[2026-06-04 11:12:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
QUIT

[2026-06-04 11:12:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_plgguual.prg
[2026-06-04 11:12:56] [INFO] VFP output esperado em: C:\4c\tasks\task083\vfp_output.txt
[2026-06-04 11:12:56] [INFO] Executando Visual FoxPro 9...
[2026-06-04 11:12:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_plgguual.prg
[2026-06-04 11:12:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_plgguual.prg
[2026-06-04 11:12:56] [INFO] Timeout configurado: 300 segundos
[2026-06-04 11:17:56] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 13332)...
[2026-06-04 11:17:58] [INFO] VFP9 finalizado em 302.0471312 segundos
[2026-06-04 11:17:58] [INFO] Exit Code: 4
[2026-06-04 11:17:58] [INFO] 
[2026-06-04 11:17:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 11:17:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_plgguual.prg
[2026-06-04 11:17:58] [INFO] 
[2026-06-04 11:17:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 11:17:58] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 11:17:58] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 11:17:58] [INFO] * Parameters: 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
[2026-06-04 11:17:58] [INFO] 
[2026-06-04 11:17:58] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 11:17:58] [INFO] SET SAFETY OFF
[2026-06-04 11:17:58] [INFO] SET RESOURCE OFF
[2026-06-04 11:17:58] [INFO] SET TALK OFF
[2026-06-04 11:17:58] [INFO] SET NOTIFY OFF
[2026-06-04 11:17:58] [INFO] SYS(2335, 0)
[2026-06-04 11:17:58] [INFO] 
[2026-06-04 11:17:58] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
[2026-06-04 11:17:58] [INFO] QUIT
[2026-06-04 11:17:58] [INFO] 
[2026-06-04 11:17:58] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 11:17:58] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-06-04 11:19:51] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 11:19:51] [INFO] Config FPW: (nao fornecido)
[2026-06-04 11:19:51] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 11:19:51] [INFO] Timeout: 300 segundos
[2026-06-04 11:19:51] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_udk2xhd1.prg
[2026-06-04 11:19:51] [INFO] Conteudo do wrapper:
[2026-06-04 11:19:51] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
QUIT

[2026-06-04 11:19:51] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_udk2xhd1.prg
[2026-06-04 11:19:51] [INFO] VFP output esperado em: C:\4c\tasks\task083\vfp_output.txt
[2026-06-04 11:19:51] [INFO] Executando Visual FoxPro 9...
[2026-06-04 11:19:51] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_udk2xhd1.prg
[2026-06-04 11:19:51] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_udk2xhd1.prg
[2026-06-04 11:19:51] [INFO] Timeout configurado: 300 segundos
[2026-06-04 11:19:57] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-04 11:19:57] [INFO] VFP9 finalizado em 6.3972264 segundos
[2026-06-04 11:19:57] [INFO] Exit Code: 
[2026-06-04 11:19:57] [INFO] 
[2026-06-04 11:19:57] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 11:19:57] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_udk2xhd1.prg
[2026-06-04 11:19:57] [INFO] 
[2026-06-04 11:19:57] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 11:19:57] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 11:19:57] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 11:19:57] [INFO] * Parameters: 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
[2026-06-04 11:19:57] [INFO] 
[2026-06-04 11:19:57] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 11:19:57] [INFO] SET SAFETY OFF
[2026-06-04 11:19:57] [INFO] SET RESOURCE OFF
[2026-06-04 11:19:57] [INFO] SET TALK OFF
[2026-06-04 11:19:57] [INFO] SET NOTIFY OFF
[2026-06-04 11:19:57] [INFO] SYS(2335, 0)
[2026-06-04 11:19:57] [INFO] 
[2026-06-04 11:19:57] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigredtv', 'C:\4c\tasks\task083', 'REPORT'
[2026-06-04 11:19:57] [INFO] QUIT
[2026-06-04 11:19:57] [INFO] 
[2026-06-04 11:19:57] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 11:19:57] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigredtv",
  "timestamp": "20260604111957",
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredtv.prg):
*==============================================================================
* FORMSIGREDTV.PRG
* Formulario de Relatorio - Demonstrativo de Conta Corrente (SigReDtv)
*
* Migrado de: SIGREDTV.SCX (frmrelatorio)
* Layout   : FLAT - controles direto no form, sem PageFrame
* Herda de : FormBase
* Tipos    : 1=Demonstrativo (SigReDtvP)  2=Mapa de Contas (SigReDtvM)
*==============================================================================

DEFINE CLASS Formsigredtv AS FormBase

    *-- Tipo de relatorio: 1=Demonstrativo, 2=Mapa de Contas
    this_nTipo         = 1

    *-- BO de relatorio
    this_oRelatorio    = .NULL.

    *-- Mensagem de erro interna
    this_cMensagemErro = ""

    *-- Propriedades visuais
    DataSession  = 2
    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Demonstrativo"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    WindowType   = 1
    BackColor    = RGB(192, 192, 192)
    ShowWindow   = 1

    *--------------------------------------------------------------------------
    * Init - Define tipo antes de DODEFAULT() acionar InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nTipo)
        IF TYPE("par_nTipo") = "N"
            THIS.this_nTipo = IIF(par_nTipo = 2, 2, 1)
        ELSE
            THIS.this_nTipo = 1
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                    MsgErro("Erro de conex" + CHR(227) + "o com banco de dados.", "Erro")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            IF loc_lSucesso
                THIS.this_oRelatorio = CREATEOBJECT("sigredtvBO")
                THIS.this_oRelatorio.ConfigurarTipo(THIS.this_nTipo)
                THIS.Caption = THIS.this_oRelatorio.ObterCaptionForm()

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()

                THIS.this_oRelatorio.InicializarDados()

                THIS.ConfigurarGridEmpresas()
                THIS.this_oRelatorio.DisponibilizarOrcamentos()
                THIS.ConfigurarGridOrcamentos()

                THIS.ConfigurarBINDEVENTs()

                THIS.AtualizarEstadoMoedaDesc()
                THIS.AtualizarEstadoComparativo()
                THIS.AtualizarEstadoOrcamentos()

                THIS.Visible = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- REPORT forms nao usam PageFrame lista/dados (stubs no-op para FormBase)
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 25
            .Left      = 20
            .AutoSize  = .T.
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Visualizar / Imprimir / Documento / Encerrar
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

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Documento"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        THIS.cmg_4c_Botoes.Buttons(4).Cancel = .T.
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Todos os campos de filtro (layout FLAT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        *-- === DEMONSTRATIVO Top=120/123 ===
        THIS.AddObject("lbl_4c_LblDemonstrativo", "Label")
        WITH THIS.lbl_4c_LblDemonstrativo
            .Top       = 123
            .Left      = 121
            .AutoSize  = .T.
            .Caption   = "Demonstrativo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Demons", "TextBox")
        WITH THIS.txt_4c_Demons
            .Top           = 120
            .Left          = 204
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === PERIODO Top=145/148 ===
        THIS.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH THIS.lbl_4c_LblPeriodo
            .Top       = 148
            .Left      = 155
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Top           = 145
            .Left          = 204
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LblPeriodoA", "Label")
        WITH THIS.lbl_4c_LblPeriodoA
            .Top       = 148
            .Left      = 288
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Top           = 145
            .Left          = 300
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- === TIPO DE DATAS (5 opcoes) Top=138 ===
        THIS.AddObject("obj_4c_OptTpDatas", "OptionGroup")
        WITH THIS.obj_4c_OptTpDatas
            .ButtonCount = 5
            .Top         = 138
            .Left        = 381
            .Width       = 176
            .Height      = 59
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Option1.Caption   = "Emiss" + CHR(227) + "o"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 56
            .Option1.Height    = 15
            .Option2.Caption   = "Lan" + CHR(231) + "amento"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 95
            .Option2.Width     = 76
            .Option2.Height    = 15
            .Option3.Caption   = "Vencimento"
            .Option3.FontName  = "Tahoma"
            .Option3.FontSize  = 8
            .Option3.BackStyle = 0
            .Option3.ForeColor = RGB(90, 90, 90)
            .Option3.Top       = 22
            .Option3.Left      = 5
            .Option3.Width     = 73
            .Option3.Height    = 15
            .Option4.Caption   = "Baixa"
            .Option4.FontName  = "Tahoma"
            .Option4.FontSize  = 8
            .Option4.BackStyle = 0
            .Option4.ForeColor = RGB(90, 90, 90)
            .Option4.Top       = 22
            .Option4.Left      = 95
            .Option4.Width     = 44
            .Option4.Height    = 15
            .Option5.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
            .Option5.FontName  = "Tahoma"
            .Option5.FontSize  = 8
            .Option5.BackStyle = 0
            .Option5.ForeColor = RGB(90, 90, 90)
            .Option5.Top       = 39
            .Option5.Left      = 5
            .Option5.Width     = 82
            .Option5.Height    = 15
            .Visible           = .T.
        ENDWITH

        *-- === MOEDA Top=170/173 ===
        THIS.AddObject("lbl_4c_LblMoeda", "Label")
        WITH THIS.lbl_4c_LblMoeda
            .Top       = 173
            .Left      = 159
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CodMoeda", "TextBox")
        WITH THIS.txt_4c_CodMoeda
            .Top           = 170
            .Left          = 204
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 3
            .Alignment     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DesMoeda", "TextBox")
        WITH THIS.txt_4c_DesMoeda
            .Top           = 170
            .Left          = 237
            .Width         = 142
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 15
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === COTACAO Top=196/200 ===
        THIS.AddObject("lbl_4c_LblCotacao", "Label")
        WITH THIS.lbl_4c_LblCotacao
            .Top       = 200
            .Left      = 151
            .AutoSize  = .T.
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptCotacao", "OptionGroup")
        WITH THIS.obj_4c_OptCotacao
            .ButtonCount = 2
            .Top         = 196
            .Left        = 198
            .Width       = 210
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Option1.Caption   = "\<Fechamento"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 89
            .Option1.Height    = 17
            .Option2.Caption   = "\<Movimenta" + CHR(231) + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 98
            .Option2.Height    = 17
            .Visible           = .T.
        ENDWITH

        *-- === COMPARATIVO Top=218/223 ===
        THIS.AddObject("lbl_4c_LblComparativo", "Label")
        WITH THIS.lbl_4c_LblComparativo
            .Top       = 223
            .Left      = 130
            .AutoSize  = .T.
            .Caption   = "Comparativo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptCompara", "OptionGroup")
        WITH THIS.obj_4c_OptCompara
            .ButtonCount = 3
            .Top         = 218
            .Left        = 198
            .Width       = 317
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Option1.Caption   = "N" + CHR(227) + "o"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 53
            .Option1.Height    = 17
            .Option2.Caption   = "M" + CHR(234) + "s Anterior"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 90
            .Option2.Height    = 17
            .Option3.Caption   = "Ano Anterior"
            .Option3.FontName  = "Tahoma"
            .Option3.FontSize  = 8
            .Option3.BackStyle = 0
            .Option3.ForeColor = RGB(90, 90, 90)
            .Option3.Top       = 5
            .Option3.Left      = 217
            .Option3.Width     = 79
            .Option3.Height    = 15
            .Visible           = .T.
        ENDWITH

        *-- Campos de periodo comparativo (inicialmente ocultos, somente leitura)
        THIS.AddObject("txt_4c_Comp1", "TextBox")
        WITH THIS.txt_4c_Comp1
            .Top           = 219
            .Left          = 517
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Value         = DATE()
            .Visible       = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_LblCompA", "Label")
        WITH THIS.lbl_4c_LblCompA
            .Top       = 223
            .Left      = 601
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("txt_4c_Comp2", "TextBox")
        WITH THIS.txt_4c_Comp2
            .Top           = 219
            .Left          = 613
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Value         = DATE()
            .Visible       = .F.
        ENDWITH

        *-- === NOTA FISCAL / SINTETICO Top=238/243 ===
        THIS.AddObject("lbl_4c_LblTipo", "Label")
        WITH THIS.lbl_4c_LblTipo
            .Top       = 243
            .Left      = 165
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptSnt", "OptionGroup")
        WITH THIS.obj_4c_OptSnt
            .ButtonCount = 3
            .Top         = 238
            .Left        = 198
            .Width       = 274
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Option1.Caption   = "Sim"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 53
            .Option1.Height    = 17
            .Option2.Caption   = "N" + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 53
            .Option2.Height    = 17
            .Option3.Caption   = "Todos"
            .Option3.FontName  = "Tahoma"
            .Option3.FontSize  = 8
            .Option3.BackStyle = 0
            .Option3.ForeColor = RGB(90, 90, 90)
            .Option3.Top       = 5
            .Option3.Left      = 216
            .Option3.Width     = 53
            .Option3.Height    = 17
            .Visible           = .T.
        ENDWITH

        *-- === CONTRAPARTIDA Top=259/263 ===
        THIS.AddObject("lbl_4c_LblContrapartida", "Label")
        WITH THIS.lbl_4c_LblContrapartida
            .Top       = 263
            .Left      = 124
            .AutoSize  = .T.
            .Caption   = "Contrapartida :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptContras", "OptionGroup")
        WITH THIS.obj_4c_OptContras
            .ButtonCount = 2
            .Top         = 259
            .Left        = 198
            .Width       = 210
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Option1.Caption   = "Ocultar"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 89
            .Option1.Height    = 17
            .Option2.Caption   = "Desmembrar"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 98
            .Option2.Height    = 17
            .Visible           = .T.
        ENDWITH

        *-- === EMPRESAS Top=287 ===
        THIS.AddObject("lbl_4c_LblEmpresas", "Label")
        WITH THIS.lbl_4c_LblEmpresas
            .Top       = 287
            .Left      = 145
            .AutoSize  = .T.
            .Caption   = "Empresas :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox "marcar tudo" flutuante sobre header Column1 do grid
        THIS.AddObject("chk_4c_MarcaEmp", "CheckBox")
        WITH THIS.chk_4c_MarcaEmp
            .Top       = 288
            .Left      = 206
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 1
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de empresas (sem RecordSource ainda - configurado apos InicializarDados)
        THIS.AddObject("grd_4c_Emps", "Grid")
        WITH THIS.grd_4c_Emps
            .Top               = 287
            .Left              = 205
            .Width             = 279
            .Height            = 123
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH
        WITH THIS.grd_4c_Emps.Column1
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .Sparse    = .F.
        ENDWITH
        THIS.grd_4c_Emps.Column1.AddObject("Check1", "CheckBox")
        WITH THIS.grd_4c_Emps.Column1.Check1
            .Caption  = ""
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH
        THIS.grd_4c_Emps.Column1.CurrentControl = "Check1"
        THIS.grd_4c_Emps.Column1.Header1.Caption   = ""
        THIS.grd_4c_Emps.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Emps.Column2
            .Width     = 27
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Emps.Column2.Header1.Caption    = "Emp."
        THIS.grd_4c_Emps.Column2.Header1.Alignment  = 2
        THIS.grd_4c_Emps.Column2.Header1.ForeColor  = RGB(90, 90, 90)
        WITH THIS.grd_4c_Emps.Column3
            .Width     = 215
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Emps.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        THIS.grd_4c_Emps.Column3.Header1.Alignment = 2
        THIS.grd_4c_Emps.Column3.Header1.ForeColor = RGB(90, 90, 90)

        *-- === ORCAMENTOS Top=415/416 ===
        THIS.AddObject("lbl_4c_LblOrcamentos", "Label")
        WITH THIS.lbl_4c_LblOrcamentos
            .Top       = 415
            .Left      = 133
            .AutoSize  = .T.
            .Caption   = "Or" + CHR(231) + "amentos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox "marcar tudo" flutuante sobre header Column1 do grid de orcamentos
        THIS.AddObject("chk_4c_MarcaOrcs", "CheckBox")
        WITH THIS.chk_4c_MarcaOrcs
            .Top       = 417
            .Left      = 206
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de orcamentos (sem RecordSource ainda - configurado apos DisponibilizarOrcamentos)
        THIS.AddObject("grd_4c_Orcs", "Grid")
        WITH THIS.grd_4c_Orcs
            .Top               = 416
            .Left              = 205
            .Width             = 438
            .Height            = 122
            .ColumnCount       = 5
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH
        WITH THIS.grd_4c_Orcs.Column1
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .Sparse    = .F.
        ENDWITH
        THIS.grd_4c_Orcs.Column1.AddObject("check12", "CheckBox")
        WITH THIS.grd_4c_Orcs.Column1.check12
            .Caption  = ""
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column1.CurrentControl = "Check1"
        THIS.grd_4c_Orcs.Column1.Header1.Caption   = ""
        THIS.grd_4c_Orcs.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Orcs.Column2
            .Width     = 300
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        THIS.grd_4c_Orcs.Column2.Header1.Alignment = 2
        THIS.grd_4c_Orcs.Column2.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Orcs.Column3
            .Width     = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column3.Header1.Caption   = "M" + CHR(234) + "s"
        THIS.grd_4c_Orcs.Column3.Header1.Alignment = 2
        THIS.grd_4c_Orcs.Column3.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Orcs.Column4
            .Width     = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column4.Header1.Caption   = "Ano"
        THIS.grd_4c_Orcs.Column4.Header1.Alignment = 2
        THIS.grd_4c_Orcs.Column4.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Orcs.Column5
            .Width     = 32
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column5.Header1.Caption   = "Moeda"
        THIS.grd_4c_Orcs.Column5.Header1.Alignment = 2
        THIS.grd_4c_Orcs.Column5.Header1.ForeColor = RGB(90, 90, 90)

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridEmpresas - Vincula RecordSource apos csSigCdEmp disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridEmpresas()
        IF NOT USED("csSigCdEmp")
            RETURN
        ENDIF
        THIS.grd_4c_Emps.RecordSource = "csSigCdEmp"
        WITH THIS.grd_4c_Emps
            .Column1.ControlSource = "csSigCdEmp.Imps"
            .Column2.ControlSource = "csSigCdEmp.CEmps"
            .Column3.ControlSource = "csSigCdEmp.Razas"
        ENDWITH
        THIS.grd_4c_Emps.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridOrcamentos - Vincula RecordSource apos crSigCdMrp disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridOrcamentos()
        IF NOT USED("crSigCdMrp")
            RETURN
        ENDIF
        THIS.grd_4c_Orcs.RecordSource = "crSigCdMrp"
        WITH THIS.grd_4c_Orcs
            .Column1.ControlSource = "crSigCdMrp.Imps"
            .Column2.ControlSource = "crSigCdMrp.cTitulo"
            .Column3.ControlSource = "crSigCdMrp.cMes"
            .Column4.ControlSource = "crSigCdMrp.cAno"
            .Column5.ControlSource = "crSigCdMrp.Moeda"
        ENDWITH
        THIS.grd_4c_Orcs.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - Vincula eventos a metodos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        *-- Campos de data
        BINDEVENT(THIS.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
        BINDEVENT(THIS.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")

        *-- Moeda
        BINDEVENT(THIS.txt_4c_CodMoeda, "KeyPress", THIS, "TeclaLookupMoedaCod")
        BINDEVENT(THIS.txt_4c_DesMoeda, "KeyPress", THIS, "TeclaLookupMoedaDesc")
        BINDEVENT(THIS.txt_4c_CodMoeda, "DblClick", THIS, "AbrirBuscaMoedaCod")
        BINDEVENT(THIS.txt_4c_DesMoeda, "DblClick", THIS, "AbrirBuscaMoedaDesc")

        *-- Demonstrativo
        BINDEVENT(THIS.txt_4c_Demons, "KeyPress", THIS, "TeclaLookupDemonstrativo")
        BINDEVENT(THIS.txt_4c_Demons, "DblClick", THIS, "AbrirBuscaDemonstrativo")

        *-- Comparativo OptionGroup
        BINDEVENT(THIS.obj_4c_OptCompara, "InteractiveChange", THIS, "OptComparaChange")

        *-- Checkboxes de selecionar tudo
        BINDEVENT(THIS.chk_4c_MarcaEmp,  "Click", THIS, "MarcaEmpClick")
        BINDEVENT(THIS.chk_4c_MarcaOrcs, "Click", THIS, "MarcaOrcsClick")

        *-- Grid Empresas - checkbox Column1
        BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "KeyPress",  THIS, "EmpCheckKeyPress")
        BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "MouseUp",   THIS, "EmpCheckMouseUp")
        BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "MouseDown", THIS, "EmpCheckMouseDown")
        BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "Click",     THIS, "EmpCheckClick")

        *-- Grid Orcamentos - checkbox Column1
        BINDEVENT(THIS.grd_4c_Orcs.Column1.Check1, "KeyPress",  THIS, "OrcCheckKeyPress")
        BINDEVENT(THIS.grd_4c_Orcs.Column1.Check1, "MouseUp",   THIS, "OrcCheckMouseUp")
        BINDEVENT(THIS.grd_4c_Orcs.Column1.Check1, "MouseDown", THIS, "OrcCheckMouseDown")
        BINDEVENT(THIS.grd_4c_Orcs.Column1.Check1, "Click",     THIS, "OrcCheckClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        THIS.this_oRelatorio.this_dDtInicial     = THIS.txt_4c_DtInicial.Value
        THIS.this_oRelatorio.this_dDtFinal       = THIS.txt_4c_DtFinal.Value
        THIS.this_oRelatorio.this_cCodMoeda      = ALLTRIM(THIS.txt_4c_CodMoeda.Value)
        THIS.this_oRelatorio.this_cDesMoeda      = ALLTRIM(THIS.txt_4c_DesMoeda.Value)
        THIS.this_oRelatorio.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demons.Value)
        THIS.this_oRelatorio.this_nTipoDatas     = THIS.obj_4c_OptTpDatas.Value
        THIS.this_oRelatorio.this_nCotacao       = THIS.obj_4c_OptCotacao.Value
        THIS.this_oRelatorio.this_nComparativo   = THIS.obj_4c_OptCompara.Value
        THIS.this_oRelatorio.this_dCompInicial   = THIS.txt_4c_Comp1.Value
        THIS.this_oRelatorio.this_dCompFinal     = THIS.txt_4c_Comp2.Value
        THIS.this_oRelatorio.this_nSnt           = THIS.obj_4c_OptSnt.Value
        THIS.this_oRelatorio.this_nContrapartida = THIS.obj_4c_OptContras.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.txt_4c_DtInicial.Value)
            MsgAviso("Data inicial " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Filtro")
            THIS.txt_4c_DtInicial.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.txt_4c_DtFinal.Value)
            MsgAviso("Data final " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Filtro")
            THIS.txt_4c_DtFinal.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.txt_4c_CodMoeda.Value)) AND ;
                           EMPTY(ALLTRIM(THIS.txt_4c_DesMoeda.Value))
            MsgAviso("Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Filtro")
            THIS.txt_4c_CodMoeda.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.txt_4c_Demons.Value))
            MsgAviso("Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Filtro")
            THIS.txt_4c_Demons.SetFocus()
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BOTOES - Eventos principais do form de relat" + CHR(243) + "rio
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera preview do relatorio na tela
    * Equivalente ao "PROCEDURE visualizacao" do sistema legado (linha 21)
    * Logica do legado:
    *   IF Previsao        -> Report Form SigReDt1 Preview NoConsole
    *   ELSEIF Comparativo -> Report Form SigReDt2 Preview NoConsole
    *   ELSEIF ContraPartida -> Report Form SigReDt3 Preview NoConsole
    *   ELSE               -> Report Form SigReDt4 Preview NoConsole
    * A selecao do FRX e feita internamente pelo BO via ObterNomeFRX()
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lOk, loc_lSeguir
        loc_lSeguir = .T.
        loc_lOk     = .F.

        TRY
            *-- 1. Valida filtros obrigatorios (datas, moeda, demonstrativo)
            IF !THIS.ValidarFiltros()
                loc_lSeguir = .F.
            ENDIF

            IF loc_lSeguir
                *-- 2. Limpa cursores residuais de execucoes anteriores
                THIS.LimparCursoresRelatorio()

                *-- 3. Transfere filtros do form para o BO
                THIS.FormParaRelatorio()

                *-- 4. Aciona o BO para preparar dados + REPORT FORM PREVIEW
                loc_lOk = THIS.this_oRelatorio.Visualizar()

                IF !loc_lOk AND !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao visualizar relat" + CHR(243) + "rio")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao gerar preview:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure + CHR(13) + ;
                    loc_oErro.Message, ;
                    "BtnVisualizarClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    * Equivalente ao "PROCEDURE impressao" do sistema legado (linha 21)
    * Logica do legado:
    *   IF Previsao        -> Report Form SigReDt1 To Printer Prompt NoConsole
    *   ELSEIF Comparativo -> Report Form SigReDt2 To Printer Prompt NoConsole
    *   ELSEIF ContraPartida -> Report Form SigReDt3 To Printer Prompt NoConsole
    *   ELSE               -> Report Form SigReDt4 To Printer Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro, loc_lOk, loc_lSeguir
        loc_lSeguir = .T.
        loc_lOk     = .F.

        TRY
            *-- 1. Valida filtros obrigatorios
            IF !THIS.ValidarFiltros()
                loc_lSeguir = .F.
            ENDIF

            *-- 2. Confirma impressao com o usuario
            IF loc_lSeguir
                IF !MsgConfirma("Deseja imprimir o relat" + CHR(243) + "rio agora?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o de Impress" + CHR(227) + "o")
                    loc_lSeguir = .F.
                ENDIF
            ENDIF

            IF loc_lSeguir
                *-- 3. Limpa cursores residuais
                THIS.LimparCursoresRelatorio()

                *-- 4. Transfere filtros do form para o BO
                THIS.FormParaRelatorio()

                *-- 5. Aciona o BO para preparar dados + REPORT FORM TO PRINTER PROMPT
                loc_lOk = THIS.this_oRelatorio.Imprimir()

                IF !loc_lOk AND !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao imprimir relat" + CHR(243) + "rio")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao imprimir:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure + CHR(13) + ;
                    loc_oErro.Message, ;
                    "BtnImprimirClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Imprime sem dialogo (direto na impressora padrao)
    * Equivalente ao "PROCEDURE documento" do sistema legado (linha 19)
    * Usado para gerar documento direto, sem prompt de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_oErro, loc_lOk, loc_lSeguir
        loc_lSeguir = .T.
        loc_lOk     = .F.

        TRY
            *-- 1. Valida filtros obrigatorios
            IF !THIS.ValidarFiltros()
                loc_lSeguir = .F.
            ENDIF

            *-- 2. Confirma geracao do documento
            IF loc_lSeguir
                IF !MsgConfirma("Gerar documento e enviar para impressora padr" + CHR(227) + "o?", ;
                                "Gerar Documento")
                    loc_lSeguir = .F.
                ENDIF
            ENDIF

            IF loc_lSeguir
                *-- 3. Limpa cursores residuais
                THIS.LimparCursoresRelatorio()

                *-- 4. Transfere filtros do form para o BO
                THIS.FormParaRelatorio()

                *-- 5. Aciona o BO para preparar dados + REPORT FORM TO PRINTER NOCONSOLE
                loc_lOk = THIS.this_oRelatorio.ImprimirDocumento()

                IF loc_lOk
                    MsgInfo("Documento enviado para a impressora.", "Gerar Documento")
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                                "Erro ao gerar documento")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao gerar documento:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure + CHR(13) + ;
                    loc_oErro.Message, ;
                    "BtnDocumentoClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario de relatorio
    * Libera cursores e o BO antes de release
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_oErro

        TRY
            THIS.LimparCursoresRelatorio()
        CATCH TO loc_oErro
            *-- ignorar erros na limpeza, prosseguir com release
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresRelatorio - Fecha cursores temporarios usados pelo BO
    * Evita "Alias already in use" em execucoes consecutivas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursoresRelatorio()
        LOCAL ARRAY loc_aCursores[8]
        LOCAL loc_nI

        loc_aCursores[1] = "cursor_4c_RelDados"
        loc_aCursores[2] = "cursor_4c_RelComp"
        loc_aCursores[3] = "cursor_4c_RelTmp"
        loc_aCursores[4] = "cursor_4c_RelMov"
        loc_aCursores[5] = "cursor_4c_RelCtas"
        loc_aCursores[6] = "cursor_4c_RelOrcs"
        loc_aCursores[7] = "crTmpMccr"
        loc_aCursores[8] = "Tempo"

        FOR loc_nI = 1 TO ALEN(loc_aCursores, 1)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA por codigo (SigCdMoe.CMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_CodMoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_CodMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                THIS.txt_4c_DesMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        THIS.txt_4c_CodMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        THIS.txt_4c_DesMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
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

    PROTECTED PROCEDURE ValidarMoedaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_CodMoeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_DesMoeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeVal
            IF !EOF()
                THIS.txt_4c_DesMoeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.txt_4c_DesMoeda.Value = ""
                THIS.AbrirBuscaMoedaCod()
            ENDIF
        ELSE
            THIS.txt_4c_DesMoeda.Value = ""
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF USED("cursor_4c_MoeVal")
            USE IN cursor_4c_MoeVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA por descricao (SigCdMoe.DMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c_DesMoeda.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaDesc()
        IF THIS.txt_4c_DesMoeda.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_DesMoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_CodMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                THIS.txt_4c_DesMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeD")
                        THIS.txt_4c_CodMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        THIS.txt_4c_DesMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
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
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_DesMoeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_CodMoeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeDescVal
            IF !EOF()
                THIS.txt_4c_CodMoeda.Value = ALLTRIM(CMoes)
                THIS.txt_4c_DesMoeda.Value = ALLTRIM(DMoes)
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
    * LOOKUP - DEMONSTRATIVO (SigCdMrr.Balancos)
    *==========================================================================

    PROCEDURE TeclaLookupDemonstrativo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDemonstrativo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDemonstrativo()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDemonstrativo()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor  = ALLTRIM(THIS.txt_4c_Demons.Value)
        loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMrr", "cursor_4c_BuscaDem", "Balancos", loc_cValor, ;
            "Demonstrativos", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_Demons.Value = ALLTRIM(cursor_4c_BuscaDem.Balancos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Balancos", "", "Demonstrativo")
                    loc_oBusca.mAddColuna("Titulos",  "", "T" + CHR(237) + "tulo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDem")
                        THIS.txt_4c_Demons.Value = ALLTRIM(cursor_4c_BuscaDem.Balancos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaDem")
            USE IN cursor_4c_BuscaDem
        ENDIF
        THIS.txt_4c_Demons.Refresh()
    ENDPROC

    PROTECTED PROCEDURE ValidarDemonstrativo()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor  = ALLTRIM(THIS.txt_4c_Demons.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Balancos FROM SigCdMrr WHERE Balancos = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DemVal")
        IF loc_nResult > 0
            SELECT cursor_4c_DemVal
            IF !EOF()
                THIS.txt_4c_Demons.Value = ALLTRIM(Balancos)
            ELSE
                THIS.AbrirBuscaDemonstrativo()
            ENDIF
        ELSE
            THIS.AbrirBuscaDemonstrativo()
        ENDIF
        IF USED("cursor_4c_DemVal")
            USE IN cursor_4c_DemVal
        ENDIF
        THIS.txt_4c_Demons.Refresh()
    ENDPROC

    *==========================================================================
    * CAMPOS DE DATA
    *==========================================================================

    PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF !EMPTY(THIS.txt_4c_DtInicial.Value) AND !EMPTY(THIS.txt_4c_DtFinal.Value)
                IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
                    THIS.txt_4c_DtFinal.Value = THIS.txt_4c_DtInicial.Value
                    THIS.txt_4c_DtFinal.Refresh()
                ENDIF
            ENDIF
            THIS.OptComparaChange()
        ENDIF
    ENDPROC

    PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.OptComparaChange()
        ENDIF
    ENDPROC

    *==========================================================================
    * COMPARATIVO - Auto-calculo de datas e visibilidade
    *==========================================================================

    PROCEDURE OptComparaChange()
        LOCAL loc_nVal, loc_lAtivo, loc_lnMeses, loc_ldIni, loc_ldFim, loc_leExpr
        loc_nVal   = THIS.obj_4c_OptCompara.Value
        loc_lAtivo = (loc_nVal > 1)

        THIS.grd_4c_Orcs.Enabled       = !loc_lAtivo
        THIS.chk_4c_MarcaOrcs.Enabled  = !loc_lAtivo
        THIS.txt_4c_Comp1.Visible      = loc_lAtivo
        THIS.txt_4c_Comp2.Visible      = loc_lAtivo
        THIS.lbl_4c_LblCompA.Visible   = loc_lAtivo

        IF loc_lAtivo
            DO CASE
                CASE loc_nVal = 2
                    loc_lnMeses = -1
                CASE loc_nVal = 3
                    loc_lnMeses = -12
                OTHERWISE
                    loc_lnMeses = 0
            ENDCASE

            loc_ldIni = THIS.txt_4c_DtInicial.Value
            loc_ldFim = THIS.txt_4c_DtFinal.Value

            IF !EMPTY(loc_ldIni)
                loc_leExpr = loc_ldIni
                IF BETWEEN(DAY(loc_leExpr), 28, 31) AND DAY(loc_leExpr + 1) = 1
                    loc_leExpr = GOMONTH(loc_leExpr, loc_lnMeses)
                    loc_leExpr = GOMONTH(CTOD("01" + SUBSTR(DTOC(loc_leExpr), 3)), 1) - 1
                ELSE
                    loc_leExpr = GOMONTH(loc_leExpr, loc_lnMeses)
                ENDIF
                THIS.txt_4c_Comp1.Value = loc_leExpr
            ENDIF

            IF !EMPTY(loc_ldFim)
                loc_leExpr = loc_ldFim
                IF BETWEEN(DAY(loc_leExpr), 28, 31) AND DAY(loc_leExpr + 1) = 1
                    loc_leExpr = GOMONTH(loc_leExpr, loc_lnMeses)
                    loc_leExpr = GOMONTH(CTOD("01" + SUBSTR(DTOC(loc_leExpr), 3)), 1) - 1
                ELSE
                    loc_leExpr = GOMONTH(loc_leExpr, loc_lnMeses)
                ENDIF
                THIS.txt_4c_Comp2.Value = loc_leExpr
            ENDIF
        ENDIF

        THIS.txt_4c_Comp1.Refresh()
        THIS.txt_4c_Comp2.Refresh()
    ENDPROC

    *==========================================================================
    * CHECKBOXES "MARCAR TUDO"
    *==========================================================================

    PROCEDURE MarcaEmpClick()
        IF THIS.chk_4c_MarcaEmp.Value = 1
            REPLACE ALL Imps WITH 1 IN csSigCdEmp
        ELSE
            REPLACE ALL Imps WITH 0 IN csSigCdEmp
        ENDIF
        THIS.grd_4c_Emps.Refresh()
        THIS.this_oRelatorio.DisponibilizarOrcamentos()
        THIS.ConfigurarGridOrcamentos()
        THIS.grd_4c_Orcs.Refresh()
    ENDPROC

    PROCEDURE MarcaOrcsClick()
        IF THIS.chk_4c_MarcaOrcs.Value = 1
            REPLACE ALL Imps WITH 1 IN crSigCdMrp
        ELSE
            REPLACE ALL Imps WITH 0 IN crSigCdMrp
        ENDIF
        THIS.grd_4c_Orcs.Refresh()
    ENDPROC

    *==========================================================================
    * GRID EMPRESAS - checkbox Column1
    *==========================================================================

    PROCEDURE EmpCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            REPLACE csSigCdEmp.Imps WITH IIF(csSigCdEmp.Imps = 0, 1, 0)
            THIS.grd_4c_Emps.Refresh()
            THIS.this_oRelatorio.DisponibilizarOrcamentos()
            THIS.ConfigurarGridOrcamentos()
            THIS.grd_4c_Orcs.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE EmpCheckMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.EmpCheckKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GRID ORCAMENTOS - checkbox Column1
    *==========================================================================

    PROCEDURE OrcCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            REPLACE crSigCdMrp.Imps WITH IIF(crSigCdMrp.Imps = 0, 1, 0)
            THIS.grd_4c_Orcs.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE OrcCheckMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.OrcCheckKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE OrcCheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE OrcCheckClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ESTADO DOS CONTROLES
    *==========================================================================

    PROTECTED PROCEDURE AtualizarEstadoMoedaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c_CodMoeda.Value))
            THIS.txt_4c_DesMoeda.ReadOnly  = .F.
            THIS.txt_4c_DesMoeda.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c_DesMoeda.ReadOnly  = .T.
            THIS.txt_4c_DesMoeda.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoComparativo()
        THIS.OptComparaChange()
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoOrcamentos()
        LOCAL loc_lMostrar
        loc_lMostrar = (THIS.this_nTipo = 1)
        THIS.lbl_4c_LblOrcamentos.Visible = loc_lMostrar
        THIS.chk_4c_MarcaOrcs.Visible     = loc_lMostrar
        THIS.grd_4c_Orcs.Visible          = loc_lMostrar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os campos de filtro para valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.txt_4c_Demons.Value      = ""
        THIS.txt_4c_DtInicial.Value   = DATE()
        THIS.txt_4c_DtFinal.Value     = DATE()
        THIS.txt_4c_CodMoeda.Value    = ""
        THIS.txt_4c_DesMoeda.Value    = ""
        THIS.obj_4c_OptTpDatas.Value  = 2
        THIS.obj_4c_OptCotacao.Value  = 2
        THIS.obj_4c_OptCompara.Value  = 1
        THIS.obj_4c_OptSnt.Value      = 3
        THIS.obj_4c_OptContras.Value  = 1
        THIS.txt_4c_Comp1.Visible     = .F.
        THIS.txt_4c_Comp2.Visible     = .F.
        THIS.lbl_4c_LblCompA.Visible  = .F.
        THIS.AtualizarEstadoMoedaDesc()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE COM CONTRATO FORMBASE/CRUD
    * Este form e REPORT (frmrelatorio - layout FLAT), nao CRUD. Os metodos
    * abaixo expoem nomes do contrato CRUD delegando para os equivalentes
    * REPORT, garantindo paridade funcional e integracao com FormBase.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Equivalente CRUD; delega para FormParaRelatorio
    * No contexto REPORT, "salvar no BO" significa transferir filtros do form
    * para as propriedades this_ do BO antes de PrepararDados().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Equivalente CRUD; carrega estado do BO para o form
    * No contexto REPORT, restaura nos controles os valores das propriedades
    * this_ do BO (uteil para reabrir form preservando filtros do BO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oRelatorio
            THIS.txt_4c_DtInicial.Value     = .this_dDtInicial
            THIS.txt_4c_DtFinal.Value       = .this_dDtFinal
            THIS.txt_4c_CodMoeda.Value      = .this_cCodMoeda
            THIS.txt_4c_DesMoeda.Value      = .this_cDesMoeda
            THIS.txt_4c_Demons.Value        = .this_cDemonstrativo
            THIS.obj_4c_OptTpDatas.Value    = IIF(BETWEEN(.this_nTipoDatas, 1, 5), .this_nTipoDatas, 2)
            THIS.obj_4c_OptCotacao.Value    = IIF(BETWEEN(.this_nCotacao, 1, 2), .this_nCotacao, 2)
            THIS.obj_4c_OptCompara.Value    = IIF(BETWEEN(.this_nComparativo, 1, 3), .this_nComparativo, 1)
            THIS.txt_4c_Comp1.Value         = .this_dCompInicial
            THIS.txt_4c_Comp2.Value         = .this_dCompFinal
            THIS.obj_4c_OptSnt.Value        = IIF(BETWEEN(.this_nSnt, 1, 3), .this_nSnt, 3)
            THIS.obj_4c_OptContras.Value    = IIF(BETWEEN(.this_nContrapartida, 1, 2), .this_nContrapartida, 1)
        ENDWITH

        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoComparativo()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Equivalente CRUD; reconstroi grids de empresas/orcamentos
    * No contexto REPORT, "lista" sao os grids de selecao multipla (empresas
    * marcadas para impressao + orcamentos disponiveis para o tipo Demonstrativo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        THIS.this_oRelatorio.InicializarDados()
        THIS.ConfigurarGridEmpresas()
        THIS.this_oRelatorio.DisponibilizarOrcamentos()
        THIS.ConfigurarGridOrcamentos()
        THIS.grd_4c_Emps.Refresh()
        THIS.grd_4c_Orcs.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Equivalente CRUD; delega para BtnImprimirClick
    * No contexto REPORT, a acao "principal" do form e gerar o relatorio.
    * Imprimir e a operacao definitiva (analoga a Salvar de um cadastro).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Equivalente CRUD; delega para BtnSairClick
    * No contexto REPORT, cancelar = fechar o form de filtros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigredtvBO.prg):
*==============================================================================
* SIGREDTVBO.PRG
* Business Object para Demonstrativo de Conta Corrente (SigReDtv)
*
* Herda de RelatorioBase
* Tipos de relatorio:
*   Tipo 1 = Demonstrativo (SigReDtvP)
*   Tipo 2 = Mapa de Contas (SigReDtvM)
*
* FRXs utilizados:
*   SigReDt1 = Demonstrativo com Prevish+o/Orcamento
*   SigReDt2 = Demonstrativo Comparativo
*   SigReDt3 = Demonstrativo com Contrapartida
*   SigReDt4 = Demonstrativo Normal
*==============================================================================

DEFINE CLASS sigredtvBO AS RelatorioBase

    *-- Identificacao do tipo de relatorio (1=Demonstrativo, 2=Mapa de Contas)
    this_nTipo           = 1

    *-- Filtros de periodo
    this_dDtInicial      = {}
    this_dDtFinal        = {}

    *-- Filtro de moeda
    this_cCodMoeda       = ""
    this_cDesMoeda       = ""

    *-- Filtro de demonstrativo (Balancos)
    this_cDemonstrativo  = ""

    *-- Opcoes de tipo de data
    *   1=Emiss+ao  2=Lan+camento  3=Vencimento  4=Baixa  5=Configura+c+ao
    this_nTipoDatas      = 2

    *-- Filtro nota/sintetico
    *   1=Com NF  2=Sem NF  3=Todos
    this_nSnt            = 3

    *-- Tipo de cotacao para conversao de moeda
    *   1=Fechamento  2=Movimenta+c+ao
    this_nCotacao        = 2

    *-- Modo contrapartida
    *   1=Ocultar  2=Desmembrar
    this_nContrapartida  = 1

    *-- Modo comparativo
    *   1=N+ao  2=M+es Anterior  3=Ano Anterior
    this_nComparativo    = 1

    *-- Periodo comparativo (getComp1 / getComp2)
    this_dCompInicial    = {}
    this_dCompFinal      = {}

    *-- Flags de estado calculados em PrepararDados()
    this_lPrevisao       = .F.
    this_lComparativo    = .F.
    this_lContraPartida  = .F.

    *-- Cabecalho do relatorio (montado em PrepararDados)
    this_cTitulo         = ""
    this_cEmpresa        = ""

    *-- Filtro de empresas selecionadas para SQL IN (ex: "('001','002')")
    this_cFiltroEmpresas = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Relatorio nao tem tabela CRUD
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            *-- Valores padrao dos filtros (espelham os defaults do formulario original)
            THIS.this_dDtInicial     = DATE()
            THIS.this_dDtFinal       = DATE()
            THIS.this_cCodMoeda      = ""
            THIS.this_cDesMoeda      = ""
            THIS.this_cDemonstrativo = ""
            THIS.this_nTipoDatas     = 2
            THIS.this_nSnt           = 3
            THIS.this_nCotacao       = 2
            THIS.this_nContrapartida = 1
            THIS.this_nComparativo   = 1
            THIS.this_dCompInicial   = {}
            THIS.this_dCompFinal     = {}
            THIS.this_lPrevisao      = .F.
            THIS.this_lComparativo   = .F.
            THIS.this_lContraPartida = .F.
            THIS.this_cTitulo        = ""
            THIS.this_cEmpresa       = ""
            THIS.this_cFiltroEmpresas = ""
            THIS.this_nTipo          = 1

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTipo - Define tipo do relatorio (1=Demonstrativo, 2=Mapa)
    * Chamado pelo Form antes de InicializarDados
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarTipo(par_nTipo)
        THIS.this_nTipo = IIF(par_nTipo = 2, 2, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCaptionForm - Retorna caption do form conforme tipo
    *--------------------------------------------------------------------------
    PROCEDURE ObterCaptionForm()
        IF THIS.this_nTipo = 2
            RETURN "Mapa de Contas"
        ENDIF
        RETURN "Demonstrativo"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Sem chave primaria para relatorios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDateTimeFim - Formata data final com hora 23:59:59 para SQL
    * Equivalente a fDtoSQL(date, '23:59:59') do sistema legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarDateTimeFim(par_dData)
        LOCAL loc_cData
        loc_cData = FormatarDataSQL(par_dData)
        IF loc_cData = "NULL"
            RETURN "NULL"
        ENDIF
        RETURN LEFT(loc_cData, LEN(loc_cData) - 1) + " 23:59:59'"
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNomeFRX - Retorna caminho do FRX conforme modo do relatorio
    * SigReDt1 = Previsao/Orcamento
    * SigReDt2 = Comparativo
    * SigReDt3 = Contrapartida
    * SigReDt4 = Normal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterNomeFRX()
        LOCAL loc_cArq
        IF THIS.this_lPrevisao
            loc_cArq = "SigReDt1.frx"
        ELSE
            IF THIS.this_lComparativo
                loc_cArq = "SigReDt2.frx"
            ELSE
                IF THIS.this_lContraPartida
                    loc_cArq = "SigReDt3.frx"
                ELSE
                    loc_cArq = "SigReDt4.frx"
                ENDIF
            ENDIF
        ENDIF
        RETURN ADDBS(gc_4c_CaminhoReports) + loc_cArq
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("crSigCdCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT crSigCdCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = crSigCdCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(crSigCdCot.CMoes) = loc_cMoeda AND ;
                   TTOD(crSigCdCot.Datas) <= par_dData
                    loc_nCotacao = crSigCdCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursores de referencia usados no relatorio
    * Chamado pelo Form.InicializarForm() apos criar o BO
    * Equivalente ao PROCEDURE Init do sistema legado (parte de carga de dados)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cQuery, loc_nResult
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            *-- Cotacoes de moeda
            WAIT WINDOW "Aguarde!!! Carregando Cota" + CHR(231) + CHR(245) + "es..." NOWAIT
            loc_cQuery = "SELECT CMoes, Datas, Valos FROM SigCdCot"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData

            *-- Moedas
            WAIT WINDOW "Aguarde!!! Carregando Moedas..." NOWAIT
            loc_cQuery = "SELECT CMoes, Cotas FROM SigCdMoe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMoe
            INDEX ON CMoes TAG CMoes

            *-- Grupos de conta corrente
            WAIT WINDOW "Aguarde!!! Carregando Grupos..." NOWAIT
            loc_cQuery = "SELECT Codigos, Classes FROM SigCdGcr"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdGcr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdGcr"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdGcr
            INDEX ON Codigos TAG Codigos

            *-- Configuracoes dos Mapas/Demonstrativos
            WAIT WINDOW "Aguarde!!! Carregando Configura" + CHR(231) + CHR(245) + "es dos Mapas..." NOWAIT
            loc_cQuery = "SELECT * FROM SigCdMrr"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMrr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdMrr"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMrr
            INDEX ON Balancos TAG Balancos

            *-- Itens de configuracao do mapa
            loc_cQuery = "SELECT Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, " + ;
                         "Analiticos, Balancos, TpRegs, Titulos, CPartidas, SubTot100s " + ;
                         "FROM SigCdMri " + ;
                         "ORDER BY Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, " + ;
                         "Analiticos, Balancos, TpRegs, Titulos, CPartidas"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMri")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdMri"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMri
            INDEX ON Balancos + STR(Ordems, 3)            TAG Balancos
            INDEX ON Balancos + Grupos + STR(Ordems, 3)   TAG Grupos
            INDEX ON Balancos + DescGrps + STR(Ordems, 3) TAG DescGrps
            INDEX ON Classes + STR(Ordems, 3)             TAG Classes

            *-- Classes
            loc_cQuery = "SELECT Classes, Descrs, Nivels FROM SigCdCss"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdCss")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdCss"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCss
            INDEX ON Classes TAG Classes

            *-- Conta de pagamento/recebimento (para tratamento de contrapartidas)
            loc_cQuery = "SELECT GrupoPags, ContaPags, GrupoRecs, ContaRecs FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN crSigCdPam

            *-- Orcamentos/Previsoes (cabecalho)
            WAIT WINDOW "Aguarde !!! Carregando previs" + CHR(245) + "es..." NOWAIT
            loc_cQuery = "SELECT 0 AS Imps, cMes, cAno, cTitulo, Moeda " + ;
                         "FROM SigCdMrp GROUP BY cMes, cAno, cTitulo, Moeda"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMrp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdMrp"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.InicializarDados")
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMrp
            INDEX ON cTitulo TAG cTitulo

            *-- Empresas
            IF !THIS.CarregarEmpresas()
                loc_lSucesso = .F.
            ENDIF

            *-- Orcamentos disponiveis para empresa selecionada
            THIS.DisponibilizarOrcamentos()

            WAIT CLEAR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.InicializarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega cursor csSigCdEmp com lista de empresas
    * O Form liga grd_4c_Emps.RecordSource = 'csSigCdEmp'
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas()
        LOCAL loc_lSucesso, loc_oErro, loc_cQuery, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cQuery = "SELECT a.cemps, a.razas, 1 AS Imps " + ;
                         "FROM SigCdEmp a ORDER BY a.cemps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "csSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.CarregarEmpresas")
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.CarregarEmpresas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DisponibilizarOrcamentos - Atualiza crSigCdMrp para empresa selecionada
    * Chamado quando o usuario altera selecao de empresa no grid
    * Equivalente ao PROCEDURE disponib_orcs do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE DisponibilizarOrcamentos()
        LOCAL loc_lSucesso, loc_oErro, loc_cQuery, loc_nResult, loc_cEmpSel
        loc_lSucesso = .F.
        TRY
            IF !USED("csSigCdEmp")
                loc_lSucesso = .F.
            ENDIF

            *-- Verifica quantas empresas estao marcadas
            SELECT cEmps FROM csSigCdEmp WHERE Imps = 1 INTO CURSOR crQtdEmp READWRITE
            IF USED("crQtdEmp") AND RECCOUNT("crQtdEmp") = 1
                GO TOP IN crQtdEmp
                loc_cEmpSel = ALLTRIM(crQtdEmp.cEmps)
                loc_cQuery = "SELECT 0 AS Imps, cEmps, cMes, cAno, cTitulo, Moeda " + ;
                             "FROM SigCdMrp WHERE cEmps = " + EscaparSQL(loc_cEmpSel) + ;
                             " GROUP BY cEmps, cMes, cAno, cTitulo, Moeda"
            ELSE
                *-- Multiplas ou nenhuma empresa: nao exibe orcamentos
                loc_cQuery = "SELECT 0 AS Imps, cEmps, cMes, cAno, cTitulo, Moeda " + ;
                             "FROM SigCdMrp WHERE cEmps = '' " + ;
                             "GROUP BY cEmps, cMes, cAno, cTitulo, Moeda"
            ENDIF

            IF USED("crQtdEmp")
                USE IN crQtdEmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMrp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar orcamentos (SigCdMrp)"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.DisponibilizarOrcamentos")
                loc_lSucesso = .F.
            ENDIF

            SELECT crSigCdMrp
            INDEX ON cTitulo TAG cTitulo
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.DisponibilizarOrcamentos")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor dbRelatorio para o REPORT FORM
    * Equivalente ao PROCEDURE processamento do sistema legado
    * Requer: csSigCdEmp, crSigCdMrp, crSigCdCot, crSigCdGcr, crSigCdMri,
    *         crSigCdCss, crSigCdMrr, crSigCdPam carregados por InicializarDados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cMoe, loc_nSnt, loc_cDtIni, loc_cDtFim, loc_nTpDat
        LOCAL loc_cEpr, loc_cDpr, loc_cDmr, loc_nOpc, loc_llPep
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cEmpresa
        LOCAL loc_cPrevisao, loc_cOrcamento, loc_cMoedaOrc, loc_cOrcs
        LOCAL loc_cQuery, loc_nResult
        LOCAL loc_lnCot1, loc_lnCot2, loc_lnValors
        LOCAL loc_nDecimals, loc_cFixed, loc_cEscape
        LOCAL loc_lnNsegi, loc_lcCol
        LOCAL loc_lnRec1, loc_lnValor, loc_lnOperacao, loc_lndRecno
        LOCAL loc_lbFirst, loc_lnTotPrevisao, loc_lnVlrPrev
        LOCAL loc_lnTotOrcado, loc_lnTotReal, loc_lnTotOrcAux, loc_lnTotRealAux
        LOCAL loc_lnRecTroca, loc_lnPercFirstO, loc_lnPercFirstR, loc_lnOrdAux
        LOCAL loc_cConta, loc_lcEmps
        LOCAL loc_lnI, loc_cAlias
        PRIVATE pDtI, pDtF, pDcI, pDcF

        loc_lSucesso = .F.
        TRY
            *-- Filtros do formulario mapeados para variaveis locais
            loc_cMoe   = ALLTRIM(THIS.this_cCodMoeda)
            loc_nSnt   = THIS.this_nSnt
            loc_nTpDat = THIS.this_nTipoDatas
            loc_cDmr   = ALLTRIM(THIS.this_cDemonstrativo)
            loc_nOpc   = THIS.this_nComparativo

            *-- Datas para uso nos parametros SQL (?pDtI / ?pDtF binding)
            pDtI = THIS.this_dDtInicial
            pDtF = THIS.this_dDtFinal
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFim = THIS.FormatarDateTimeFim(THIS.this_dDtFinal)

            THIS.this_lPrevisao    = .F.
            THIS.this_lComparativo = .F.

            GO TOP IN csSigCdEmp

            *-- Monta lista de empresas selecionadas (IN clause para SQL)
            SELECT cEmps, Razas FROM csSigCdEmp WHERE Imps = 1 INTO CURSOR crAux READWRITE
            GO TOP IN crAux

            IF RECCOUNT("crAux") = 1
                *-- Uma empresa
                loc_cEpr = "('" + ALLTRIM(crAux.cEmps) + "')"
                loc_cDpr = ALLTRIM(crAux.cEmps) + " - " + ALLTRIM(crAux.Razas)
            ELSE
                IF RECCOUNT("crAux") = RECCOUNT("csSigCdEmp")
                    *-- Todas as empresas
                    loc_cEpr = ""
                    loc_cDpr = "Todas Empresas"
                ELSE
                    *-- Varias empresas
                    loc_cEpr = "("
                    loc_cDpr = "Empresas : "
                    SELECT crAux
                    SCAN
                        IF LEN(loc_cEpr) <> 1
                            loc_cEpr = loc_cEpr + ","
                        ENDIF
                        loc_cEpr = loc_cEpr + "'" + ALLTRIM(crAux.cEmps) + "'"
                        IF LEN(loc_cDpr) <> 11
                            loc_cDpr = loc_cDpr + ", "
                        ENDIF
                        loc_cDpr = loc_cDpr + ALLTRIM(crAux.cEmps)
                    ENDSCAN
                    loc_cEpr = loc_cEpr + ")"
                ENDIF
            ENDIF
            IF USED("crAux")
                USE IN crAux
            ENDIF

            *-- Salva filtro de empresas para uso pelo PrepararComparativo
            THIS.this_cFiltroEmpresas = loc_cEpr

            *-- Verifica se demonstrativo existe
            SELECT crSigCdMrr
            SET ORDER TO Balancos
            IF !SEEK(loc_cDmr, "crSigCdMrr", "Balancos")
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o encontrado: " + loc_cDmr
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                loc_lSucesso = .F.
            ENDIF
            loc_llPep = (crSigCdMrr.Mapas = 2)
            loc_lcCol = IIF(loc_nOpc = 2, "Mov M" + CHR(234) + "s Anterior", "Mov Ano Anterior")

            *-- Modo comparativo
            IF loc_nOpc > 1
                pDcI = THIS.this_dCompInicial
                pDcF = THIS.this_dCompFinal
                THIS.PrepararComparativo(loc_cEpr, loc_cMoe, ;
                    FormatarDataSQL(THIS.this_dCompInicial), ;
                    THIS.FormatarDateTimeFim(THIS.this_dCompFinal), ;
                    loc_llPep, loc_cDmr)
                THIS.this_lComparativo = .T.
            ENDIF

            *-- Nome da empresa (empresa logada)
            loc_cQuery = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                         EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdEmp")
            IF loc_nResult > 0 AND !EOF("crSigCdEmp")
                loc_cNomeEmpresa = ALLTRIM(crSigCdEmp.Razas)
                IF USED("crSigCdEmp")
                    USE IN crSigCdEmp
                ENDIF
            ELSE
                loc_cNomeEmpresa = ""
                IF USED("crSigCdEmp")
                    USE IN crSigCdEmp
                ENDIF
            ENDIF

            *-- Titulo e empresa do relatorio
            SELECT crSigCdMrr
            SET ORDER TO Balancos
            SEEK loc_cDmr
            loc_cTitulo  = ALLTRIM(crSigCdMrr.Titulos) + " de " + ;
                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                           DTOC(THIS.this_dDtFinal) + " em " + ALLTRIM(THIS.this_cDesMoeda)
            loc_cEmpresa = loc_cDpr

            *-- Verifica orcamentos selecionados
            SELECT crSigCdMrp
            LOCATE

            SELECT cTitulo FROM crSigCdMrp WHERE Imps = 1 INTO CURSOR crAux READWRITE
            loc_cPrevisao  = IIF(RECCOUNT("crAux") > 0, "S", "N")
            loc_cOrcamento = "Or" + CHR(231) + "amento : " + ;
                             IIF(RECCOUNT("crAux") = 1, ALLTRIM(crAux.cTitulo), "Acumulados")
            loc_cMoedaOrc  = ""

            IF loc_cPrevisao = "S"
                THIS.this_lPrevisao = .T.
                *-- Monta lista de chaves de orcamentos selecionados
                loc_cOrcs = ""
                SELECT crSigCdMrp
                GO TOP IN crSigCdMrp
                SCAN
                    IF crSigCdMrp.Imps = 1
                        loc_cMoedaOrc = crSigCdMrp.Moeda
                        IF !EMPTY(loc_cOrcs)
                            loc_cOrcs = loc_cOrcs + ","
                        ENDIF
                        loc_cOrcs = loc_cOrcs + CHR(39) + ;
                            PADR(ALLTRIM(crSigCdMrp.cEmps), 3) + ;
                            ALLTRIM(crSigCdMrp.cMes) + ;
                            ALLTRIM(crSigCdMrp.cAno) + ;
                            PADR(ALLTRIM(crSigCdMrp.cTitulo), 40) + ;
                            PADR(ALLTRIM(crSigCdMrp.Moeda), 3) + CHR(39)
                    ENDIF
                ENDSCAN
                loc_cOrcs = "(" + loc_cOrcs + ")"

                *-- Carrega previsoes consolidadas por grupo/conta
                loc_cQuery = "SELECT cGrupos, iClis, Sum(nValors) AS nValors " + ;
                             "FROM SigCdMrp " + ;
                             "WHERE cEmps+cMes+cAno+cTitulo+Moeda IN " + loc_cOrcs + ;
                             " GROUP BY cGrupos, iClis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crPrevisao")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar previs" + CHR(227) + "o (crPrevisao)"
                    MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                    loc_lSucesso = .F.
                ENDIF
                SELECT crPrevisao
                INDEX ON cGrupos TAG PrevGrp
                INDEX ON iClis   TAG PrevCta
            ENDIF

            IF USED("crAux")
                USE IN crAux
            ENDIF

            *-- Cabecalho do relatorio
            THIS.this_cTitulo  = loc_cTitulo
            THIS.this_cEmpresa = loc_cNomeEmpresa

            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                Empresa C(80), Previsao C(1), Orcamento C(80), ;
                Comparativo C(20), Faixas L)
            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Empresa, ;
                Previsao, Orcamento, Comparativo, Faixas) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cEmpresa, ;
                        loc_cPrevisao, loc_cOrcamento, loc_lcCol, ;
                        THIS.this_nContrapartida = 1)

            *-- Configuracoes de SET
            loc_cEscape   = SET("Escape")
            loc_nDecimals = SET("Decimals")
            loc_cFixed    = SET("Fixed")
            SET ESCAPE OFF
            SET DECIMALS TO 2
            SET FIXED ON

            IF USED("crSigMvCcr")
                USE IN crSigMvCcr
            ENDIF

            *-- ======================== SQL PRINCIPAL ========================
            *-- Busca movimentos de conta corrente com joins aos mapas/configs
            WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es de Conta Corrente..." NOWAIT

            loc_cQuery = "SELECT DISTINCT a.Grupos, a.Contas, " + ;
                IIF(loc_nTpDat = 1, "a.DtEmis ", ;
                IIF(loc_nTpDat = 2, "a.Datas ", ;
                IIF(loc_nTpDat = 3, "a.Vencs ", ;
                IIF(loc_nTpDat = 4, ;
                    "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end ", ;
                    "Case When c.TpDatas = 1 Then a.DtEmis Else Case When c.TpDatas = 2 " + ;
                    "Then a.Datas Else Case When c.TpDatas in (0,3) Then a.Vencs " + ;
                    "Else case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end " + ;
                    "End End End ")))) + ;
                "AS Datas, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
                "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.ContEms, a.cIdChaves, " + ;
                "case when Not e.Acertos Is Null then e.Acertos " + ;
                "else round((g.Acertos*((a.Valors/g.valos)*100)/100),2) end As Acertos, " + ;
                "case when e.Cotacaos Is Null then g.Cotacaos else e.Cotacaos end As CotAcertos, " + ;
                "c.TpDatas, a.EmpCcs " + ;
                "FROM SigMvCcr a " + ;
                "INNER JOIN SigCdMri c ON a.Grupos = c.Grupos " + ;
                "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                "INNER JOIN SigCdCss d ON b.Classes = d.Classes " + ;
                "LEFT JOIN SigCdPit e ON a.nOpers = e.nOpers AND a.Emps = e.EmpOs " + ;
                "LEFT JOIN SigCdPgr f ON e.Empdopnums = f.Empdopnums " + ;
                "LEFT JOIN SigCdPit g ON a.vOpers = (g.EmpOs + convert(varchar(9),g.nOpers)) " + ;
                "LEFT JOIN SigCdPgr h ON g.Empdopnums = h.Empdopnums " + ;
                "WHERE c.Balancos = " + EscaparSQL(loc_cDmr) + " AND " + ;
                IIF(loc_nTpDat = 1, "a.DtEmis BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " ", ;
                IIF(loc_nTpDat = 2, "a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " ", ;
                IIF(loc_nTpDat = 3, "a.Vencs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " ", ;
                IIF(loc_nTpDat = 4, ;
                    "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end " + ;
                    "BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " ", ;
                    "(Case When c.TpDatas = 1 And a.DtEmis BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas = 2 And a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas in (0,3) And a.Vencs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas = 4 And (f.datarcs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                    " Or h.datarcs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ") Then 1 Else 0 End End End End) = 1 ")))) + ;
                IIF(EMPTY(loc_cEpr), "", ;
                    "AND (Case When a.EmpCcs <> '' And a.EmpCcs IN " + loc_cEpr + " Then 1 Else " + ;
                    "Case When a.EmpCcs = '' And a.Emps IN " + loc_cEpr + " Then 1 Else 0 End End) = 1 ") + ;
                IIF(loc_nSnt = 3, "", ;
                    IIF(loc_nSnt = 1, "AND Not a.NFs = '          ' ", "AND a.NFs = '          ' ")) + ;
                "ORDER BY a.Grupos, a.Contas, 3, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
                "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.cIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpBal1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao selecionar movimentos (TmpBal1)"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                loc_lSucesso = .F.
            ENDIF
            WAIT CLEAR

            *-- Seleciona registros distintos de TmpBal1 ? cBal2
            SELECT DISTINCT Grupos, Contas, NVL(Datas, CTOT(SPACE(08))) AS Datas, ;
                Valors, Svalors, Moedas, Smoedas, Cotacaos, Scotacaos, Opers, ;
                IIF(!EMPTY(EmpCcs), EmpCcs, Emps) AS Emps, ;
                Scontas, ContEms, cIdChaves, TpDatas ;
              FROM TmpBal1 ;
              INTO CURSOR cBal2 READWRITE

            IF !USED("cBal2") OR RECCOUNT("cBal2") = 0
                *-- Sem dados
                SELECT cBal2
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            *-- =================== PROCESSA cBal2 ===================
            *-- Monta cursor anal?tico (Ps='5') com contas individuais
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
                VAL(STR(a.Valors * IIF(a.Opers == "D", 1, -1), 16, 2)) * d.Fators / 100 AS Valors, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, a.Scontas, a.ContEms, ;
                d.cpartidas, a.cIdChaves, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
                SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms ;
              FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBalCP READWRITE

            *-- Conversao de moeda em cBal2
            loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, THIS.this_dDtFinal)
            loc_lnValors = 0

            SELECT cBal2
            SCAN
                SCATTER MEMVAR FIELDS Valors, Moedas
                IF loc_nTpDat = 4 OR (loc_nTpDat = 5 AND INLIST(cBal2.TpDatas, 4))
                    loc_lnValors = 0
                    m.Acertos    = 0
                    SELECT TmpBal1
                    SCAN FOR cIdChaves = cBal2.cIdChaves
                        IF Datas <> cBal2.Datas
                            LOOP
                        ENDIF
                        m.Acertos = NVL(TmpBal1.Acertos, 0)
                        IF !cBal2.Moedas = loc_cMoe
                            IF THIS.this_nCotacao = 1
                                loc_lnCot1 = THIS.CarregarCambio(cBal2.Moedas, THIS.this_dDtFinal)
                            ELSE
                                loc_lnCot1 = IIF(NVL(TmpBal1.CotAcertos, 0) <> 0, TmpBal1.CotAcertos, THIS.CarregarCambio(cBal2.Moedas, TTOD(cBal2.Datas)))
                                loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, TTOD(cBal2.Datas))
                            ENDIF
                            m.Acertos = (NVL(TmpBal1.Acertos, 0) * loc_lnCot1 / loc_lnCot2)
                            m.Moedas  = loc_cMoe
                        ENDIF
                        loc_lnValors = loc_lnValors + m.Acertos
                    ENDSCAN
                ELSE
                    IF !cBal2.Moedas = loc_cMoe
                        IF THIS.this_nCotacao = 1
                            loc_lnCot1 = THIS.CarregarCambio(cBal2.Moedas, THIS.this_dDtFinal)
                        ELSE
                            loc_lnCot1 = IIF(cBal2.Cotacaos <> 0, cBal2.Cotacaos, THIS.CarregarCambio(cBal2.Moedas, TTOD(cBal2.Datas)))
                            loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, TTOD(cBal2.Datas))
                        ENDIF
                        IF cBal2.Smoedas = loc_cMoe AND THIS.this_nCotacao = 2
                            m.Valors = cBal2.Svalors
                        ELSE
                            m.Valors = (cBal2.Valors * loc_lnCot1 / loc_lnCot2)
                        ENDIF
                    ENDIF
                ENDIF

                SELECT cBal2
                m.Moedas = loc_cMoe
                GATHER MEMVAR FIELDS Valors, Moedas

                SELECT cBalCP
                GO TOP IN cBalCP
                LOCATE FOR cIdChaves = cBal2.cIdChaves
                IF !EOF("cBalCP")
                    SELECT cBalCP
                    GATHER MEMVAR FIELDS Valors, Moedas
                ENDIF
            ENDSCAN

            *-- Cursor de grupos (Ps='3') - resumo por classe
            SELECT d.Ordems, d.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                d.Grupos, d.DescGrps AS Ds_grupos, SPACE(10) AS Contas, ;
                SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "3" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
                d.cpartidas, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
                SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms, SPACE(10) AS ContEms ;
              FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == loc_cDmr AND d.TpRegs == 3 AND ;
                   LEFT(b.Classes, LEN(ALLTRIM(d.Classes))) = ALLTRIM(d.Classes) AND ;
                   b.Codigos == a.Grupos AND e.Classes == d.Classes ;
             GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBal4

            *-- Cursor de contas (Ps='5') - contas individuais por grupo
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(loc_llPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
                d.cpartidas, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp, ;
                SPACE(50) AS Ds_SContas, SPACE(50) AS Ds_ContEms, SPACE(10) AS ContEms ;
              FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBal3

            *-- Cursor de contrapartidas (Ps='7') - detalhe por conta/scontas
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, a.Scontas, ;
                SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, a.Emps ;
              FROM cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == loc_cDmr AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             GROUP BY 1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20 ;
             ORDER BY 1, 2, 4, 6, 7 ;
              INTO CURSOR ContPart

            *-- Une cBal3 + cBal4 no cursor principal do relatorio
            SELECT a.* FROM cBal3 a ;
             UNION ;
            SELECT b.* FROM cBal4 b ;
              INTO CURSOR dbRelatorio READWRITE

            WAIT CLEAR

            *-- Busca descricao de cada conta em SigCdCli
            WAIT WINDOW "Aguarde!!! Analisando Registros..." NOWAIT
            SELECT dbRelatorio
            GO TOP
            SCAN
                loc_cConta = IIF(dbRelatorio.Ps = "7", dbRelatorio.sContas, dbRelatorio.Contas)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta), ;
                    "TmpCli")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o de conta (TmpCli)"
                    MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpCli
                GO TOP
                IF !EOF()
                    REPLACE Ds_Contas WITH TmpCli.RClis IN dbRelatorio
                ENDIF
                SELECT dbRelatorio
            ENDSCAN
            WAIT CLEAR

            IF !USED("dbRelatorio") OR RECCOUNT("dbRelatorio") = 0
                SELECT cBal2
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            *-- Indexa dbRelatorio para processamento posterior
            SELECT dbRelatorio
            INDEX ON Ordems                                              TAG Ordems
            INDEX ON Grupos                                              TAG Grupos
            INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
            INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
            INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
            INDEX ON STR(Ordems, 3) + Ps + Grupos + Contas + SContas    TAG dRecno

            *-- Insere grupos/classes sem transacoes (de crSigCdMri)
            SELECT crSigCdMri
            SET ORDER TO "" IN crSigCdMri
            SCAN
                IF crSigCdMri.Balancos = loc_cDmr AND ;
                   (!SEEK(crSigCdMri.Grupos, "dbRelatorio", "Grupos") OR crSigCdMri.TpRegs = 2)
                    SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
                    SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
                    INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
                        Ps, cOrdBals, Fators, DescClasse, Titulos) ;
                        VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;
                            crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
                            0, loc_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;
                            IIF(crSigCdMri.TpRegs = 1, "5", "6"), ;
                            SPACE(10), crSigCdMri.Fators, crSigCdCss.Descrs, crSigCdMri.Titulos)
                ENDIF
            ENDSCAN

            SELECT crSigCdMri
            SET ORDER TO "" IN crSigCdMri
            GO TOP

            *-- Monta totais de grupos (Ps='4') para grupos analiticos
            SELECT dbRelatorio
            SET ORDER TO "" IN dbRelatorio
            GO TOP IN dbRelatorio
            DO WHILE !EOF("dbRelatorio")
                IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 1
                    SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse
                    m.lnRec1    = RECNO("dbRelatorio")
                    m.Contas    = dbRelatorio.Grupos
                    m.Ds_contas = dbRelatorio.Ds_grupos
                    m.Valor     = 0
                    m.lnValor   = dbRelatorio.Valor
                    m.Ps        = "4"
                    m.Fators    = dbRelatorio.Fators
                    m.DescClasse = dbRelatorio.DescClasse
                    m.Titulos   = dbRelatorio.Titulos
                    IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
                             "dbRelatorio", "Classes")
                        INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                            Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
                            Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
                            VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
                                m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
                                loc_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
                                m.Ps, m.cOrdBals, m.Fators, m.DescClasse)
                    ENDIF
                    m.Valor = (dbRelatorio.Valor + m.lnValor)
                    GATHER MEMVAR FIELDS Valor
                    GO m.lnRec1 IN dbRelatorio
                ENDIF
                SKIP IN dbRelatorio
            ENDDO

            *-- Processa contrapartidas (Ps='5' analitico com cpartidas=1)
            SELECT dbRelatorio
            SET ORDER TO Ordems IN dbRelatorio
            GO TOP
            DO WHILE !EOF("dbRelatorio")
                IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 1 AND ;
                   dbRelatorio.Cpartidas = 1 AND EMPTY(dbRelatorio.Scontas)
                    THIS.this_lContraPartida = .T.
                    SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse, Contas
                    m.lnRec1 = RECNO("dbRelatorio")
                    SELECT ContPart
                    SCAN FOR Grupos + Contas = m.Grupos + m.Contas
                        m.sContas    = ContPart.sContas
                        m.Ds_contas  = ContPart.Ds_Contas
                        m.Valor      = ContPart.Valor
                        m.lnValor    = ContPart.Valor
                        m.Ps         = "5"
                        m.Fators     = ContPart.Fators
                        m.DescClasse = ContPart.DescClasse
                        m.Titulos    = ContPart.Titulos
                        INSERT INTO dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                            Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
                            Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse, sContas, Valor) ;
                            VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
                                m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
                                loc_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
                                m.Ps, m.cOrdBals, m.Fators, m.DescClasse, m.sContas, m.Valor)
                    ENDSCAN
                    SELECT dbRelatorio
                    GO m.lnRec1 IN dbRelatorio
                ENDIF
                SKIP IN dbRelatorio
            ENDDO

            *-- Calcula dRecno para ordenacao final
            SELECT dbRelatorio
            =SEEK("", "dbRelatorio", "Classes")

            SELECT dbRelatorio
            SCAN
                SELECT crSigCdMri
                IF !EMPTY(dbRelatorio.Grupos)
                    IF dbRelatorio.Grupos <> "SubTotal"
                        SET ORDER TO Grupos
                        SEEK loc_cDmr + dbRelatorio.Grupos
                    ELSE
                        SET ORDER TO DescGrps
                        SEEK loc_cDmr + dbRelatorio.Ds_Grupos
                    ENDIF
                ELSE
                    SET ORDER TO Classes
                    SEEK loc_cDmr + dbRelatorio.Classes
                ENDIF
                SELECT dbRelatorio
                IF Ps = "4"
                    loc_lndRecno = (RECNO("crSigCdMri") * 10)
                ELSE
                    loc_lndRecno = (RECNO("crSigCdMri") * 10) + 1
                ENDIF
                REPLACE dRecno WITH loc_lndRecno
            ENDSCAN

            *-- Calcula total geral
            SELECT dbRelatorio
            SET ORDER TO dRecno
            m.Valor = 0
            SCAN
                IF !EMPTY(Scontas)
                    LOOP
                ENDIF
                IF dbRelatorio.Ps = "6"
                    GATHER MEMVAR FIELDS Valor
                ENDIF
                m.Valor = (m.Valor + IIF(!INLIST(dbRelatorio.Ps, "4", "6"), ;
                    (dbRelatorio.Valor * IIF(dbRelatorio.Operacaos = "-", -1, 1)), 0))
            ENDSCAN

            *-- =================== CALCULOS DE PREVISAO ===================
            IF loc_cPrevisao = "S"
                loc_lnTotPrevisao = 0
                loc_lnVlrPrev     = 0
                loc_lnCot2 = THIS.CarregarCambio(loc_cMoe, THIS.this_dDtFinal)
                loc_lnCot1 = THIS.CarregarCambio(loc_cMoedaOrc, THIS.this_dDtFinal)

                SELECT dbRelatorio
                GO TOP
                SCAN
                    IF dbRelatorio.Ps = "5" AND !EMPTY(dbRelatorio.Contas)
                        IF SEEK(dbRelatorio.Contas, "crPrevisao", "PrevCta")
                            loc_lnVlrPrev = crPrevisao.nValors * (loc_lnCot1 / loc_lnCot2)
                            REPLACE Previsao WITH loc_lnVlrPrev IN dbRelatorio
                            loc_lnTotPrevisao = loc_lnTotPrevisao + loc_lnVlrPrev
                        ENDIF
                    ENDIF
                    IF (dbRelatorio.Ps = "4" OR (dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 2)) AND ;
                       !EMPTY(dbRelatorio.Grupos)
                        IF SEEK(dbRelatorio.Grupos, "crPrevisao", "PrevGrp")
                            loc_lnVlrPrev = crPrevisao.nValors * (loc_lnCot1 / loc_lnCot2)
                            REPLACE Previsao WITH loc_lnVlrPrev IN dbRelatorio
                            loc_lnTotPrevisao = loc_lnTotPrevisao + loc_lnVlrPrev
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT dbRelatorio
                SET ORDER TO dRecno
                GO TOP

                *-- Inserir contas sem realizado
                SELECT iClis, nValors FROM crPrevisao ;
                    WHERE iClis NOT IN (SELECT Contas FROM dbRelatorio) ;
                    INTO CURSOR crAdicionar READWRITE
                SELECT crAdicionar
                GO TOP
                SCAN
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Grupos, rClis FROM SigCdCli WHERE iClis = " + EscaparSQL(crAdicionar.iClis), ;
                        "crGrupoCta")
                    IF loc_nResult > 0
                        SELECT cGrupos FROM dbRelatorio WHERE Grupos = crGrupoCta.Grupos ;
                            INTO CURSOR crAux READWRITE
                        SELECT crAux
                        IF !EOF("crAux")
                            SELECT dbRelatorio
                            GO TOP
                            LOCATE FOR Grupos = crGrupoCta.Grupos
                            IF !EOF()
                                SCATTER MEMVAR MEMO
                                m.Contas    = crAdicionar.iClis
                                m.Ds_Contas = crGrupoCta.rClis
                                m.Valor     = 0
                                m.Ps        = "5"
                                m.dRecno    = m.dRecno + 1
                                m.Previsao  = crAdicionar.nValors
                                m.PercPrev  = 0
                                m.PercGrp   = 0
                                INSERT INTO dbRelatorio FROM MEMVAR
                            ENDIF
                        ENDIF
                        IF USED("crAux")
                            USE IN crAux
                        ENDIF
                        IF USED("crGrupoCta")
                            USE IN crGrupoCta
                        ENDIF
                    ENDIF
                ENDSCAN
                IF USED("crAdicionar")
                    USE IN crAdicionar
                ENDIF

                *-- Totais dos grupos apos insercao
                SELECT Ordems, Grupos, Ds_Grupos FROM dbRelatorio WHERE Ps = "6" ;
                    INTO CURSOR crAux READWRITE
                SELECT crAux
                SCAN
                    SELECT NVL(SUM(Previsao), 0) AS TotPrev FROM dbRelatorio ;
                        WHERE Ordems < crAux.Ordems AND Ps <> "6" ;
                        INTO CURSOR crTot READWRITE
                    SELECT crTot
                    IF crTot.TotPrev <> 0
                        UPDATE dbRelatorio SET Previsao = crTot.TotPrev ;
                            WHERE Ps = "6" AND Grupos = crAux.Grupos AND ;
                            Ds_Grupos = crAux.Ds_Grupos
                    ENDIF
                    IF USED("crTot")
                        USE IN crTot
                    ENDIF
                ENDSCAN
                IF USED("crAux")
                    USE IN crAux
                ENDIF

                *-- Subtotal 100% e calculos de percentuais
                loc_lnTotOrcado   = -1
                loc_lnTotReal     = -1
                loc_lnRecTroca    = 0
                loc_lnPercFirstO  = 0
                loc_lnPercFirstR  = 0
                loc_lbFirst       = .T.

                SELECT dbRelatorio
                GO TOP
                SCAN
                    IF dbRelatorio.Ps = "6"
                        SELECT crSigCdMri
                        SET ORDER TO Grupos
                        SEEK loc_cDmr + dbRelatorio.Grupos + STR(dbRelatorio.Ordems, 3)
                        IF PEMSTATUS(crSigCdMri, "SubTot100s", 5) AND crSigCdMri.SubTot100s = 1
                            loc_lnTotOrcado = dbRelatorio.Previsao
                            loc_lnTotReal   = dbRelatorio.Valor
                            loc_lnRecTroca  = RECNO("dbRelatorio")
                            REPLACE PercPrev WITH 100, PercGrp WITH 100 IN dbRelatorio
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN

                loc_lnTotOrcAux  = loc_lnTotOrcado
                loc_lnTotRealAux = loc_lnTotReal

                SELECT dbRelatorio
                GO TOP
                SCAN
                    IF RECNO("dbRelatorio") = loc_lnRecTroca
                        loc_lnTotOrcado = loc_lnTotOrcAux
                        loc_lnTotReal   = loc_lnTotRealAux
                        GO TOP IN dbRelatorio
                        REPLACE PercPrev WITH loc_lnPercFirstO, ;
                                PercGrp  WITH loc_lnPercFirstR IN dbRelatorio
                        GO loc_lnRecTroca IN dbRelatorio
                    ENDIF

                    IF dbRelatorio.Ps = "3"
                        loc_cQuery = "SELECT Sum(a.nValors) AS TotPrev FROM SigCdMrp a " + ;
                            "INNER JOIN SigCdCli b ON b.iClis = a.iClis " + ;
                            "INNER JOIN SigCdGcr c ON c.Codigos = b.Grupos " + ;
                            "WHERE c.Classes = " + EscaparSQL(dbRelatorio.Classes) + ;
                            " AND a.cEmps+a.cMes+a.cAno+a.cTitulo+a.Moeda IN " + loc_cOrcs + ;
                            " UNION ALL " + ;
                            "SELECT Sum(a.nValors) AS TotPrev FROM SigCdMrp a " + ;
                            "INNER JOIN SigCdGcr g ON g.Codigos = a.cGrupos " + ;
                            "WHERE g.Classes = " + EscaparSQL(dbRelatorio.Classes) + ;
                            " AND a.cEmps+a.cMes+a.cAno+a.cTitulo+a.Moeda IN " + loc_cOrcs
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpPrev")
                        IF loc_nResult > 0
                            SELECT SUM(NVL(TotPrev, 0)) AS TotPrev FROM crTmpPrev ;
                                INTO CURSOR crTotPrev READWRITE
                            REPLACE Previsao WITH crTotPrev.TotPrev IN dbRelatorio
                            IF USED("crTotPrev")
                                USE IN crTotPrev
                            ENDIF
                        ENDIF
                        IF USED("crTmpPrev")
                            USE IN crTmpPrev
                        ENDIF
                    ENDIF

                    IF dbRelatorio.Ps = "4"
                        SELECT NVL(SUM(a.Previsao), 0) AS TotPrev FROM dbRelatorio a ;
                            WHERE a.Ordems = dbRelatorio.Ordems AND ;
                                  a.Classes = dbRelatorio.Classes AND ;
                                  a.Grupos = dbRelatorio.Grupos AND ;
                                  a.Ps = "5" ;
                            INTO CURSOR crTotPrev READWRITE
                        SELECT crTotPrev
                        IF crTotPrev.TotPrev <> 0
                            REPLACE Previsao WITH Previsao + crTotPrev.TotPrev IN dbRelatorio
                        ENDIF
                        IF USED("crTotPrev")
                            USE IN crTotPrev
                        ENDIF
                    ENDIF

                    IF dbRelatorio.Ps = "5" AND dbRelatorio.Analiticos = 2
                        SELECT NVL(SUM(a.Previsao), 0) AS TotPrev, ;
                               SUM(a.Valor) AS TotReal FROM dbRelatorio a ;
                            WHERE a.Ordems = dbRelatorio.Ordems AND ;
                                  a.Classes = dbRelatorio.Classes AND ;
                                  a.Grupos = dbRelatorio.Grupos AND ;
                                  a.Ps = "5" ;
                            INTO CURSOR crTotPrev READWRITE
                        REPLACE PercGrp  WITH IIF(loc_lnTotReal <> 0, ;
                                    ROUND((ABS(crTotPrev.TotReal)/ABS(loc_lnTotReal))*100,2),0), ;
                                PercPrev WITH IIF(loc_lnTotOrcado <> 0, ;
                                    ROUND((ABS(crTotPrev.TotPrev)/ABS(loc_lnTotOrcado))*100,2),0) ;
                            IN dbRelatorio
                        IF USED("crTotPrev")
                            USE IN crTotPrev
                        ENDIF
                    ELSE
                        REPLACE PercGrp  WITH IIF(loc_lnTotReal <> 0, ;
                                    ROUND((ABS(Valor)/ABS(loc_lnTotReal))*100,2),0), ;
                                PercPrev WITH IIF(loc_lnTotOrcado <> 0, ;
                                    ROUND((ABS(Previsao)/ABS(loc_lnTotOrcado))*100,2),0) ;
                            IN dbRelatorio
                    ENDIF

                    IF dbRelatorio.Ps = "5"
                        loc_lnPercFirstO = loc_lnPercFirstO + dbRelatorio.PercPrev
                        loc_lnPercFirstR = loc_lnPercFirstR + dbRelatorio.PercGrp
                    ENDIF

                    IF loc_lbFirst
                        loc_lnTotOrcado = dbRelatorio.Previsao
                        loc_lnTotReal   = dbRelatorio.Valor
                        loc_lbFirst     = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Atualiza percentuais maximos
            IF USED("dbRelatorio")
                UPDATE dbRelatorio SET PercPrev = MIN(PercPrev, 999.99) WHERE PercPrev <> 0
                UPDATE dbRelatorio SET PercGrp  = MIN(PercGrp, 999.99)  WHERE PercGrp <> 0
                GO TOP
            ENDIF

            *-- Relatorio por empresa: cria cursor Tempo agrupado
            IF loc_llPep AND USED("dbRelatorio")
                SELECT Emps AS Empresas, PROPER(Titulos) AS Titulos, ;
                       SUM(Valor) AS Valores ;
                  FROM dbRelatorio ;
                 WHERE Ps <> "4" ;
                 GROUP BY 1, 2 ;
                  INTO CURSOR Tempo
                SELECT Tempo
                IF RECCOUNT("Tempo") < 1
                    SELECT dbRelatorio
                    GO TOP
                ENDIF
            ELSE
                IF EMPTY(loc_cEpr) AND USED("dbRelatorio")
                    UPDATE dbRelatorio SET Emps = ""
                ENDIF
            ENDIF

            *-- =================== MODO COMPARATIVO ===================
            IF THIS.this_lComparativo
                SELECT * FROM dbRelatorio INTO CURSOR crTmp READWRITE
                IF USED("dbRelatorio")
                    USE IN dbRelatorio
                ENDIF
                SELECT a.*, a.Valor AS VlrComp, 000.00 AS VarComp ;
                  FROM crTmp a ;
                  INTO CURSOR dbRelatorio READWRITE
                IF USED("crTmp")
                    USE IN crTmp
                ENDIF

                SELECT dbRelatorio
                INDEX ON Ordems                                              TAG Ordems
                INDEX ON Grupos                                              TAG Grupos
                INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
                INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
                INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
                INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno
                SET ORDER TO dRecno

                SELECT dbCompara
                INDEX ON Classes + Grupos + ds_Grupos + Contas TAG skGroup

                SELECT dbRelatorio
                GO TOP IN dbRelatorio
                SCAN
                    IF SEEK(dbRelatorio.Classes+dbRelatorio.Grupos+ ;
                            dbRelatorio.ds_Grupos+dbRelatorio.Contas, ;
                            "dbCompara", "skGroup") AND dbCompara.Valor <> 0
                        REPLACE VlrComp WITH dbCompara.Valor IN dbRelatorio
                        REPLACE VarComp WITH ROUND(((Valor/VlrComp)-1)*100, 2) IN dbRelatorio
                    ELSE
                        REPLACE VlrComp WITH 0, VarComp WITH 0 IN dbRelatorio
                    ENDIF
                    IF dbRelatorio.VarComp = 0
                        IF dbRelatorio.Valor = 0 AND dbRelatorio.VlrComp > 0
                            REPLACE VarComp WITH -100 IN dbRelatorio
                        ELSE
                            IF dbRelatorio.Valor > 0 AND dbRelatorio.VlrComp = 0
                                REPLACE VarComp WITH 100 IN dbRelatorio
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN

                *-- Adiciona registros do comparativo que nao existem no atual
                SELECT * FROM dbCompara ;
                    WHERE Classes+Grupos+ds_Grupos+Contas NOT IN ;
                    (SELECT Classes+Grupos+ds_Grupos+Contas FROM dbRelatorio) ;
                    INTO CURSOR crAdiciona READWRITE
                SELECT crAdiciona
                SCAN
                    SCATTER MEMVAR MEMO
                    m.VlrComp = m.Valor
                    m.Valor   = 0
                    m.VarComp = 0
                    INSERT INTO dbRelatorio FROM MEMVAR
                ENDSCAN
                IF USED("crAdiciona")
                    USE IN crAdiciona
                ENDIF

                *-- Recalcula dRecno para novos registros
                SELECT dbRelatorio
                =SEEK("", "dbRelatorio", "Classes")
                SELECT dbRelatorio
                SCAN
                    SELECT crSigCdMri
                    IF !EMPTY(dbRelatorio.Grupos)
                        IF dbRelatorio.Grupos <> "SubTotal"
                            SET ORDER TO Grupos
                            SEEK loc_cDmr + dbRelatorio.Grupos
                        ELSE
                            SET ORDER TO DescGrps
                            SEEK loc_cDmr + dbRelatorio.Ds_Grupos
                        ENDIF
                    ELSE
                        SET ORDER TO Classes
                        SEEK loc_cDmr + dbRelatorio.Classes
                    ENDIF
                    SELECT dbRelatorio
                    IF Ps = "4"
                        loc_lndRecno = (RECNO("crSigCdMri") * 10)
                    ELSE
                        loc_lndRecno = (RECNO("crSigCdMri") * 10) + 1
                    ENDIF
                    REPLACE dRecno WITH loc_lndRecno
                ENDSCAN
                SELECT dbRelatorio
                SET ORDER TO dRecno
            ENDIF

            *-- Normaliza empresa no dbRelatorio
            loc_lcEmps = ""
            LOCAL loc_llEmps
            loc_llEmps = .F.
            SELECT csSigCdEmp
            SCAN
                IF Imps = 1
                    IF !loc_llEmps
                        loc_lcEmps = csSigCdEmp.cEmps
                        loc_llEmps = .T.
                    ELSE
                        loc_lcEmps = ""
                    ENDIF
                ENDIF
            ENDSCAN
            SELECT dbRelatorio
            REPLACE ALL Emps WITH loc_lcEmps FOR EMPTY(Emps)
            GO TOP

            *-- =================== CONTRAPARTIDA EXPANDIDA ===================
            IF THIS.this_nContrapartida = 2
                SELECT * FROM dbRelatorio WHERE 0 = 1 INTO CURSOR TmpRelat1 READWRITE
                SELECT dbRelatorio
                SCAN
                    SCATTER MEMVAR MEMO
                    SELECT cBalCP
                    SCAN FOR (cBalCP.Grupos = dbRelatorio.Grupos) AND ;
                              (cBalCP.Contas = dbRelatorio.Contas)
                        m.Valor   = cBalCP.Valors
                        m.Scontas = cBalCP.SContas
                        m.ContEms = cBalCP.ContEms
                        INSERT INTO TmpRelat1 FROM MEMVAR
                    ENDSCAN
                ENDSCAN

                SELECT TmpRelat1
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO dbRelatorio FROM MEMVAR
                    IF !EMPTY(dbRelatorio.SContas)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(dbRelatorio.SContas), "TmpCli")
                        IF loc_nResult > 0
                            SELECT TmpCli
                            GO TOP
                            IF !EOF()
                                REPLACE Ds_SContas WITH TmpCli.RClis IN dbRelatorio
                            ENDIF
                        ENDIF
                    ENDIF
                    IF !EMPTY(dbRelatorio.ContEms)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(dbRelatorio.ContEms), "TmpCli")
                        IF loc_nResult > 0
                            SELECT TmpCli
                            GO TOP
                            IF !EOF()
                                REPLACE ds_ContEms WITH TmpCli.RClis IN dbRelatorio
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Trata contas transit?rias de contrapartida (crSigCdPam)
            SELECT dbRelatorio
            SCAN
                IF INLIST(dbRelatorio.SContas, ;
                          ALLTRIM(crSigCdPam.ContaPags), ;
                          ALLTRIM(crSigCdPam.ContaRecs))
                    REPLACE SContas WITH Contas IN dbRelatorio
                ENDIF
            ENDSCAN

            *-- Busca descricao de SContas
            SELECT dbRelatorio
            SCAN
                IF !EMPTY(dbRelatorio.SContas)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(dbRelatorio.SContas), "TmpCli")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o de scontas"
                        MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararDados")
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT TmpCli
                    GO TOP IN TmpCli
                    IF !EOF("TmpCli")
                        REPLACE Ds_SContas WITH TmpCli.RClis IN dbRelatorio
                    ENDIF
                ENDIF
            ENDSCAN

            SELECT dbRelatorio
            GO TOP

            *-- Restaura configuracoes de SET
            SET ESCAPE &loc_cEscape.
            SET DECIMALS TO m.loc_nDecimals
            SET FIXED &loc_cFixed.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararComparativo - Monta cursor dbCompara para modo comparativo
    * Equivalente ao PROCEDURE proccomp do sistema legado
    * par_cEpr    = Empresas IN clause ex: "('001','002')"
    * par_cMoe    = Codigo da moeda
    * par_cDtIni  = Data inicial formatada para SQL
    * par_cDtFim  = Data final formatada para SQL (com 23:59:59)
    * par_lPep    = Relatorio por empresa (.T./.F.)
    * par_cDem    = Codigo do demonstrativo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararComparativo(par_cEpr, par_cMoe, par_cDtIni, par_cDtFim, par_lPep, par_cDem)
        LOCAL loc_lSucesso, loc_oErro, loc_cQuery, loc_nResult, loc_nTpDat
        LOCAL loc_lnCot1, loc_lnCot2, loc_cGroup, loc_lnRec1, loc_lnValor
        LOCAL loc_lnOperacao, loc_lndRecno, loc_lcClaAnt
        PRIVATE pDcI, pDcF

        loc_lSucesso = .F.
        TRY
            IF USED("crTmpMccr")
                USE IN crTmpMccr
            ENDIF

            WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es do Comparativo..." NOWAIT

            loc_nTpDat = THIS.this_nTipoDatas
            pDcI = THIS.this_dCompInicial
            pDcF = THIS.this_dCompFinal

            *-- SQL para movimentos do periodo comparativo
            loc_cQuery = "SELECT a.Grupos, a.Contas, " + ;
                IIF(loc_nTpDat = 1, "a.DtEmis ", ;
                IIF(loc_nTpDat = 2, "a.Datas ", ;
                IIF(loc_nTpDat = 3, "a.Vencs ", ;
                IIF(loc_nTpDat = 4, ;
                    "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end ", ;
                    "Case When c.TpDatas = 1 Then a.DtEmis Else Case When c.TpDatas = 2 " + ;
                    "Then a.Datas Else Case When c.TpDatas in (0,3) Then a.Vencs " + ;
                    "Else case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end " + ;
                    "End End End ")))) + ;
                "AS Datas, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
                "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.ContEms, a.cIdChaves, " + ;
                "e.Acertos, e.Cotacaos AS CotAcertos, c.TpDatas, a.EmpCcs " + ;
                "FROM SigMvCcr a " + ;
                "INNER JOIN SigCdMri c ON a.Grupos = c.Grupos " + ;
                "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                "LEFT JOIN SigCdPit e ON a.nOpers = e.nOpers AND a.Emps = e.EmpOs " + ;
                "LEFT JOIN SigCdPgr f ON e.Empdopnums = f.Empdopnums " + ;
                "INNER JOIN SigCdCss d ON b.Classes = d.Classes " + ;
                "WHERE c.Balancos = " + EscaparSQL(par_cDem) + " AND " + ;
                IIF(loc_nTpDat = 1, "a.DtEmis BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;
                IIF(loc_nTpDat = 2, "a.Datas BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;
                IIF(loc_nTpDat = 3, "a.Vencs BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;
                IIF(loc_nTpDat = 4, ;
                    "case when f.Datarcs Is Null then h.Datarcs else f.Datarcs end " + ;
                    "BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " ", ;
                    "(Case When c.TpDatas = 1 And a.DtEmis BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas = 2 And a.Datas BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas in (0,3) And a.Vencs BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " Then 1 Else " + ;
                    "Case When c.TpDatas = 4 And f.datarcs BETWEEN " + par_cDtIni + " AND " + par_cDtFim + " Then 1 Else 0 " + ;
                    "End End End End) = 1 ")))) + ;
                IIF(EMPTY(par_cEpr), "", ;
                    "AND (Case When a.EmpCcs <> '' And a.EmpCcs IN " + par_cEpr + " Then 1 Else " + ;
                    "Case When a.EmpCcs = '' And a.Emps IN " + par_cEpr + " Then 1 Else 0 End End) = 1 ") + ;
                IIF(THIS.this_nSnt = 3, "", ;
                    IIF(THIS.this_nSnt = 1, "AND Not a.NFs = '          ' ", "AND a.NFs = '          ' ")) + ;
                "ORDER BY a.Grupos, a.Contas, 3, a.Valors, a.Svalors, a.Moedas, a.Smoedas, " + ;
                "a.Cotacaos, a.Scotacaos, a.Opers, a.Emps, a.Scontas, a.cIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpBalC")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao selecionar comparativo (TmpBalC)"
                MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararComparativo")
                loc_lSucesso = .F.
            ENDIF
            WAIT CLEAR

            *-- Distincts de TmpBalC ? cBalC
            SELECT DISTINCT Grupos, Contas, NVL(Datas, CTOT(SPACE(08))) AS Datas, ;
                Valors, Svalors, Moedas, Smoedas, Cotacaos, Scotacaos, Opers, ;
                IIF(!EMPTY(EmpCcs), EmpCcs, Emps) AS Emps, ;
                Scontas, ContEms, cIdChaves, TpDatas ;
              FROM TmpBalC ;
              INTO CURSOR cBalC READWRITE

            IF !USED("cBalC") OR RECCOUNT("cBalC") = 0
                SELECT cBalC
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            *-- Conversao de moeda em cBalC
            loc_lnCot2 = THIS.CarregarCambio(par_cMoe, THIS.this_dCompFinal)

            SELECT cBalC
            SCAN
                SCATTER MEMVAR FIELDS Valors, Moedas
                IF loc_nTpDat = 4 OR (loc_nTpDat = 5 AND INLIST(cBalC.TpDatas, 4))
                    m.Valors  = 0
                    m.Acertos = 0
                    SELECT TmpBalC
                    SCAN FOR cIdChaves = cBalC.cIdChaves
                        m.Acertos = TmpBalC.Acertos
                        IF !cBalC.Moedas = par_cMoe
                            IF THIS.this_nCotacao = 1
                                loc_lnCot1 = THIS.CarregarCambio(cBalC.Moedas, THIS.this_dCompFinal)
                            ELSE
                                loc_lnCot1 = IIF(TmpBalC.CotAcertos <> 0, TmpBalC.CotAcertos, THIS.CarregarCambio(cBalC.Moedas, TTOD(cBalC.Datas)))
                                loc_lnCot2 = THIS.CarregarCambio(par_cMoe, TTOD(cBalC.Datas))
                            ENDIF
                            m.Acertos = (TmpBalC.Acertos * loc_lnCot1 / loc_lnCot2)
                            m.Moedas  = par_cMoe
                        ENDIF
                        m.Valors = m.Valors + m.Acertos
                    ENDSCAN
                ELSE
                    IF !cBalC.Moedas = par_cMoe
                        IF THIS.this_nCotacao = 1
                            loc_lnCot1 = THIS.CarregarCambio(cBalC.Moedas, THIS.this_dCompFinal)
                        ELSE
                            loc_lnCot1 = IIF(cBalC.Moedas <> cBalC.SMoedas, cBalC.Cotacaos, THIS.CarregarCambio(cBalC.Moedas, TTOD(cBalC.Datas)))
                            loc_lnCot2 = THIS.CarregarCambio(par_cMoe, TTOD(cBalC.Datas))
                        ENDIF
                        IF cBalC.Smoedas = par_cMoe AND THIS.this_nCotacao = 2
                            m.Valors = cBalC.Svalors
                        ELSE
                            m.Valors = (cBalC.Valors * loc_lnCot1 / loc_lnCot2)
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cBalC
                m.Moedas = par_cMoe
                GATHER MEMVAR FIELDS Valors, Moedas
            ENDSCAN

            loc_cGroup = IIF(par_lPep, "19, 2", "2")

            *-- Cursor de grupos (Ps='3') do comparativo
            SELECT d.Ordems, d.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                d.Grupos, d.DescGrps AS Ds_grupos, SPACE(10) AS Contas, ;
                SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "3" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(par_lPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
                d.cpartidas, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp ;
              FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == par_cDem AND d.TpRegs == 3 AND ;
                   LEFT(b.Classes, LEN(ALLTRIM(d.Classes))) = ALLTRIM(d.Classes) AND ;
                   b.Codigos == a.Grupos AND e.Classes == d.Classes ;
             GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBal4C

            *-- Cursor de contas (Ps='5') do comparativo
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "5" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, IIF(par_lPep, a.Emps, "   ") AS Emps, SPACE(10) AS Scontas, ;
                d.cpartidas, 0000000000000.00 AS Previsao, ;
                0000.00 AS PercPrev, 0000.00 AS PercGrp ;
              FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == par_cDem AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             GROUP BY 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21 ;
             ORDER BY 1, 2, 4, 6 ;
              INTO CURSOR cBal3C

            *-- Cursor de contrapartida do comparativo
            SELECT d.Ordems, b.Classes AS Classes, e.Descrs AS Desctpgcs, ;
                a.Grupos, d.DescGrps AS Ds_grupos, a.Contas, a.Scontas, ;
                SPACE(50) AS Ds_contas, ;
                VAL(STR(SUM(a.Valors * IIF(a.Opers == "D", 1, -1)), 16, 2)) * d.Fators / 100 AS Valor, ;
                a.Moedas, d.Operacaos, d.Analiticos, e.Nivels, e.Descrs AS DescClasse, ;
                "7" AS Ps, SPACE(10) AS cOrdBals, d.fators, 0000000000 AS dRecno, ;
                d.Titulos, a.Emps ;
              FROM cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
             WHERE d.Balancos == par_cDem AND d.Grupos == a.Grupos AND ;
                   !d.TpRegs == 2 AND !d.TpRegs == 3 AND ;
                   b.Codigos == a.Grupos AND e.Classes == b.Classes ;
             GROUP BY 1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20 ;
             ORDER BY 1, 2, 4, 6, 7 ;
              INTO CURSOR ContPartC

            *-- Une cBal3C + cBal4C ? dbCompara
            SELECT a.* FROM cBal3C a ;
             UNION ;
            SELECT b.* FROM cBal4C b ;
              INTO CURSOR dbCompara READWRITE

            IF !USED("dbCompara") OR RECCOUNT("dbCompara") = 0
                SELECT cBalC
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            *-- Busca descricao de contas em SigCdCli
            WAIT WINDOW "Aguarde!!! Analisando Registros do Comparativo..." NOWAIT
            SELECT dbCompara
            GO TOP
            SCAN
                loc_cQuery = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                             EscaparSQL(IIF(dbCompara.Ps = "7", dbCompara.sContas, dbCompara.Contas))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpCli")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao buscar descri" + CHR(231) + CHR(227) + "o (TmpCli) no comparativo"
                    MsgErro(THIS.this_cMensagemErro, "sigredtvBO.PrepararComparativo")
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpCli
                GO TOP
                IF !EOF()
                    REPLACE Ds_Contas WITH TmpCli.RClis IN dbCompara
                ENDIF
                SELECT dbCompara
            ENDSCAN
            WAIT CLEAR

            *-- Indexa dbCompara
            SELECT dbCompara
            INDEX ON Ordems                                              TAG Ordems
            INDEX ON Grupos                                              TAG Grupos
            INDEX ON cOrdBals + STR(Ordems, 3)                          TAG cOrdBals
            INDEX ON PADR(ALLTRIM(Classes),10,"0")+Grupos+Ps+Contas+sContas TAG Classes
            INDEX ON STR(Ordems,3)+PADR(ALLTRIM(Classes),10,"0")+cOrdBals+Grupos+Ps+Contas+SContas TAG Classes2
            INDEX ON STR(Ordems,3)+Ps+Grupos+Contas+SContas             TAG dRecno

            *-- Insere grupos/classes sem transacoes
            loc_lcClaAnt = SPACE(10)
            SELECT crSigCdMri
            SET ORDER TO "" IN crSigCdMri
            SCAN
                IF crSigCdMri.Balancos = par_cDem AND ;
                   (!SEEK(crSigCdMri.Grupos, "dbCompara", "Grupos") OR crSigCdMri.TpRegs = 2)
                    SEEK crSigCdMri.Grupos  ORDER TAG Codigos IN crSigCdGcr
                    SEEK crSigCdMri.Classes ORDER TAG Classes IN crSigCdCss
                    INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Contas, Ds_contas, Valor, Moedas, Operacaos, Analiticos, Nivels, ;
                        Ps, cOrdBals, Fators, DescClasse, Titulos) ;
                        VALUES (crSigCdMri.Ordems, PADR(crSigCdMri.Classes, 10), crSigCdCss.Descrs, ;
                            crSigCdMri.Grupos, crSigCdMri.DescGrps, SPACE(10), SPACE(40), ;
                            0, par_cMoe, crSigCdMri.Operacaos, 2, crSigCdCss.Nivels, ;
                            IIF(crSigCdMri.TpRegs = 1, "5", "6"), ;
                            SPACE(10), crSigCdMri.Fators, crSigCdCss.Descrs, crSigCdMri.Titulos)
                ENDIF
                SEEK crSigCdMri.Grupos + IIF(crSigCdMri.TpRegs = 1, "", CHR(255)) ORDER TAG Codigos IN crSigCdGcr
                loc_lcClaAnt = crSigCdGcr.Classes
            ENDSCAN

            SELECT crSigCdMri
            SET ORDER TO "" IN crSigCdMri
            GO TOP

            *-- Monta totais de grupos (Ps='4') no dbCompara
            SELECT dbCompara
            SET ORDER TO "" IN dbCompara
            GO TOP IN dbCompara
            m.Valor = 0
            DO WHILE !EOF("dbCompara")
                IF dbCompara.Ps = "5" AND dbCompara.Analiticos = 1
                    SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse
                    loc_lnRec1   = RECNO("dbCompara")
                    m.Contas     = dbCompara.Grupos
                    m.Ds_contas  = dbCompara.Ds_grupos
                    m.Valor      = 0
                    m.lnValor    = dbCompara.Valor
                    m.Ps         = "4"
                    m.Fators     = dbCompara.Fators
                    m.DescClasse = dbCompara.DescClasse
                    m.Titulos    = dbCompara.Titulos
                    IF !SEEK(PADR(ALLTRIM(m.Classes),10,"0")+PADR(m.Grupos,10)+m.Ps+PADR(m.Contas,10), ;
                             "dbCompara", "Classes")
                        INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                            Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
                            Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse) ;
                            VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
                                m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
                                par_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
                                m.Ps, m.cOrdBals, m.Fators, m.DescClasse)
                    ENDIF
                    m.Valor = (dbCompara.Valor + m.lnValor)
                    GATHER MEMVAR FIELDS Valor
                    GO loc_lnRec1 IN dbCompara
                ENDIF
                SKIP IN dbCompara
            ENDDO

            *-- Processa contrapartidas do dbCompara
            SELECT dbCompara
            SET ORDER TO Ordems IN dbCompara
            GO TOP
            DO WHILE !EOF("dbCompara")
                IF dbCompara.Ps = "5" AND dbCompara.Analiticos = 1 AND ;
                   dbCompara.Cpartidas = 1 AND EMPTY(dbCompara.Scontas)
                    SCATTER MEMVAR FIELDS Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                        Moedas, Operacaos, Analiticos, Nivels, cOrdBals, DescClasse, Contas
                    loc_lnRec1 = RECNO("dbCompara")
                    SELECT ContPartC
                    SCAN FOR Grupos + Contas = m.Grupos + m.Contas
                        m.sContas    = ContPartC.sContas
                        m.Ds_contas  = ContPartC.Ds_Contas
                        m.Valor      = ContPartC.Valor
                        m.lnValor    = ContPartC.Valor
                        m.Ps         = "5"
                        m.Fators     = ContPartC.Fators
                        m.DescClasse = ContPartC.DescClasse
                        m.Titulos    = ContPartC.Titulos
                        INSERT INTO dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, ;
                            Titulos, Contas, Ds_contas, Valor, Moedas, Operacaos, ;
                            Analiticos, Nivels, Ps, cOrdBals, Fators, DescClasse, sContas, Valor) ;
                            VALUES (m.Ordems, m.Classes, m.Desctpgcs, m.Grupos, m.Ds_grupos, ;
                                m.Titulos, m.Contas, m.Ds_contas, m.Valor, ;
                                par_cMoe, m.Operacaos, m.Analiticos, m.Nivels, ;
                                m.Ps, m.cOrdBals, m.Fators, m.DescClasse, m.sContas, m.Valor)
                    ENDSCAN
                    SELECT dbCompara
                    GO loc_lnRec1 IN dbCompara
                ENDIF
                SKIP IN dbCompara
            ENDDO

            *-- Calcula dRecno do dbCompara
            SELECT dbCompara
            =SEEK("", "dbCompara", "Classes")
            SELECT dbCompara
            SCAN
                SELECT crSigCdMri
                IF !EMPTY(dbCompara.Grupos)
                    IF dbCompara.Grupos <> "SubTotal"
                        SET ORDER TO Grupos
                        SEEK par_cDem + dbCompara.Grupos
                    ELSE
                        SET ORDER TO DescGrps
                        SEEK par_cDem + dbCompara.Ds_Grupos
                    ENDIF
                ELSE
                    SET ORDER TO Classes
                    SEEK par_cDem + dbCompara.Classes
                ENDIF
                SELECT dbCompara
                IF Ps = "4"
                    loc_lndDecno = (RECNO("crSigCdMri") * 10)
                ELSE
                    loc_lndDecno = (RECNO("crSigCdMri") * 10) + 1
                ENDIF
                REPLACE dRecno WITH loc_lndDecno
            ENDSCAN

            *-- Calcula totais do dbCompara
            SELECT dbCompara
            SET ORDER TO dRecno
            m.Valor = 0
            SCAN
                IF !EMPTY(Scontas)
                    LOOP
                ENDIF
                IF dbCompara.Ps = "6"
                    GATHER MEMVAR FIELDS Valor
                ENDIF
                m.Valor = (m.Valor + IIF(!INLIST(dbCompara.Ps, "4", "6"), ;
                    (dbCompara.Valor * IIF(dbCompara.Operacaos = "-", -1, 1)), 0))
            ENDSCAN

            SELECT dbCompara
            SET ORDER TO dRecno
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.PrepararComparativo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio na tela (PREVIEW)
    * Equivalente ao PROCEDURE visualizacao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Demonstrativo")
            ELSE
                IF USED("Tempo") AND THIS.this_lComparativo
                    *-- Relatorio por empresa em modo comparativo
                ELSE
                    loc_cFRX = THIS.ObterNomeFRX()
                    REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora (PROMPT)
    * Equivalente ao PROCEDURE impressao do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Demonstrativo")
            ELSE
                loc_cFRX = THIS.ObterNomeFRX()
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDocumento - Imprime sem dialogo (direto na impressora padrao)
    * Equivalente ao PROCEDURE documento do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDocumento()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar os dados do relat" + CHR(243) + "rio.", ;
                    "Demonstrativo")
            ELSE
                loc_cFRX = THIS.ObterNomeFRX()
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredtvBO.ImprimirDocumento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Compatibilidade com contrato de BOs de relatorio
    * Para relatorios, os filtros sao preenchidos via atribuicoes diretas
    * chamadas pelo Form.FormParaRelatorio()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF TYPE(par_cAliasCursor + ".DtInicial") = "D"
                THIS.this_dDtInicial = NVL(EVALUATE(par_cAliasCursor + ".DtInicial"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".DtFinal") = "D"
                THIS.this_dDtFinal = NVL(EVALUATE(par_cAliasCursor + ".DtFinal"), DATE())
            ENDIF
            IF TYPE(par_cAliasCursor + ".CodMoeda") = "C"
                THIS.this_cCodMoeda = NVL(EVALUATE(par_cAliasCursor + ".CodMoeda"), "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Demonstrativo") = "C"
                THIS.this_cDemonstrativo = NVL(EVALUATE(par_cAliasCursor + ".Demonstrativo"), "")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oDataAccess = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE

