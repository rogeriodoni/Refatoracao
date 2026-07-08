# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'FormParaRelatorio': Metodo FormParaRelatorio nao encontrado

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-06 13:10:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-06 13:10:23] [INFO] Config FPW: (nao fornecido)
[2026-06-06 13:10:23] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-06 13:10:23] [INFO] Timeout: 300 segundos
[2026-06-06 13:10:23] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2letekzv.prg
[2026-06-06 13:10:23] [INFO] Conteudo do wrapper:
[2026-06-06 13:10:23] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigReInf', 'C:\4c\tasks\task124', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReInf', 'C:\4c\tasks\task124', 'REPORT'
QUIT

[2026-06-06 13:10:23] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2letekzv.prg
[2026-06-06 13:10:23] [INFO] VFP output esperado em: C:\4c\tasks\task124\vfp_output.txt
[2026-06-06 13:10:23] [INFO] Executando Visual FoxPro 9...
[2026-06-06 13:10:23] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2letekzv.prg
[2026-06-06 13:10:23] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2letekzv.prg
[2026-06-06 13:10:23] [INFO] Timeout configurado: 300 segundos
[2026-06-06 13:10:32] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-06 13:10:32] [INFO] VFP9 finalizado em 9.6554847 segundos
[2026-06-06 13:10:32] [INFO] Exit Code: 
[2026-06-06 13:10:32] [INFO] 
[2026-06-06 13:10:32] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-06 13:10:32] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2letekzv.prg
[2026-06-06 13:10:32] [INFO] 
[2026-06-06 13:10:32] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-06 13:10:32] [INFO] * Auto-generated wrapper for parameters
[2026-06-06 13:10:32] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-06 13:10:32] [INFO] * Parameters: 'FormSigReInf', 'C:\4c\tasks\task124', 'REPORT'
[2026-06-06 13:10:32] [INFO] 
[2026-06-06 13:10:32] [INFO] * Anti-dialog protections for unattended execution
[2026-06-06 13:10:32] [INFO] SET SAFETY OFF
[2026-06-06 13:10:32] [INFO] SET RESOURCE OFF
[2026-06-06 13:10:32] [INFO] SET TALK OFF
[2026-06-06 13:10:32] [INFO] SET NOTIFY OFF
[2026-06-06 13:10:32] [INFO] SYS(2335, 0)
[2026-06-06 13:10:32] [INFO] 
[2026-06-06 13:10:32] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReInf', 'C:\4c\tasks\task124', 'REPORT'
[2026-06-06 13:10:32] [INFO] QUIT
[2026-06-06 13:10:32] [INFO] 
[2026-06-06 13:10:32] [INFO] === Fim do Wrapper.prg ===
[2026-06-06 13:10:32] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigReInf",
  "timestamp": "20260606131032",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "FormParaRelatorio",
      "passou": false,
      "erro": "Metodo FormParaRelatorio nao encontrado",
      "detalhes": ""
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
      "passou": true,
      "erro": "",
      "detalhes": "Form REPORT com BtnIncluirClick sem navegacao por PageFrame (OK)"
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReInf.prg):
*==============================================================================
* FORMSIGREINF.PRG
* Impress" + CHR(227) + "o de Nota Fiscal
* Tipo: RELATORIO OPERACIONAL (recebe par" + CHR(226) + "metros via Init, sem filtros)
* Migrado de: SigReInf.SCX (frmrelatorio)
*
* Par" + CHR(226) + "metros Init: par_cEmps, par_cDopes, par_nNumes, par_cSerie
* Layout FLAT: sem PageFrame (form h=130, apenas cabe" + CHR(231) + "alho + bot" + CHR(245) + "es)
* Bot" + CHR(245) + "es: Visualizar, Imprimir, Excel(desabilitado), Encerrar
* Ao Imprimir: BO.Imprimir() -> libera form (mesmo comportamento do original)
* Ao Visualizar: BO.Visualizar() -> form permanece aberto
* DocExcel: sempre desabilitado (lacexcel=.F. no original)
*==============================================================================

DEFINE CLASS FormSigReInf AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=130)
    Height      = 130
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio e estado de erro
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Par" + CHR(226) + "metros recebidos no Init (armazenados antes de InicializarForm ser chamado)
    this_cEmps  = ""
    this_cDopes = ""
    this_nNumes = 0
    this_cSerie = ""

    *--------------------------------------------------------------------------
    * Init - Salva par" + CHR(226) + "metros e delega para FormBase.Init()
    *   FormBase.Init() chama THIS.InicializarForm() automaticamente.
    *   Par" + CHR(226) + "metros devem ser salvos ANTES do DODEFAULT() pois InicializarForm()
    *   j" + CHR(225) + " os usa para configurar o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cSerie)
        THIS.this_cEmps  = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0
        THIS.this_cSerie = ""

        IF PCOUNT() >= 1 AND VARTYPE(par_cEmps) = "C"
            THIS.this_cEmps = par_cEmps
        ENDIF
        IF PCOUNT() >= 2 AND VARTYPE(par_cDopes) = "C"
            THIS.this_cDopes = par_cDopes
        ENDIF
        IF PCOUNT() >= 3 AND VARTYPE(par_nNumes) = "N"
            THIS.this_nNumes = par_nNumes
        ENDIF
        IF PCOUNT() >= 4 AND VARTYPE(par_cSerie) = "C"
            THIS.this_cSerie = par_cSerie
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura do form: BO + cabe" + CHR(231) + "alho + bot" + CHR(245) + "es
    *   Layout FLAT (sem PageFrame): apenas cnt_4c_Cabecalho + cmg_4c_Botoes.
    *   Ap" + CHR(243) + "s criar visual, vincula eventos e ajusta estados dos bot" + CHR(245) + "es.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de Nota Fiscal"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Criar BO
            THIS.this_oRelatorio = CREATEOBJECT("SigReInfBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReInfBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Transfere par" + CHR(226) + "metros do form para o BO
                THIS.this_oRelatorio.this_cEmps  = THIS.this_cEmps
                THIS.this_oRelatorio.this_cDopes = THIS.this_cDopes
                THIS.this_oRelatorio.this_nNumes = THIS.this_nNumes
                THIS.this_oRelatorio.this_cSerie = THIS.this_cSerie

                *-- Carrega configura" + CHR(231) + CHR(245) + "es (SigCdPam -> habilita bot" + CHR(245) + "es)
                *   Pula se estiver em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.this_oRelatorio.CarregarConfiguracoes()
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Estrutura visual: cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es de relat" + CHR(243) + "rio
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()

                *-- Atualiza captions dos labels do cabe" + CHR(231) + "alho
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincula eventos dos bot" + CHR(245) + "es (BINDEVENT s" + CHR(243) + " em m" + CHR(233) + "todos PUBLIC)
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Aplica estado dos bot" + CHR(245) + "es conforme flags carregadas do BO
                THIS.AjustarBotoesPorModo()

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
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do form
    *   Equivalente ao cntSombra do frmrelatorio legado (Top=0, full-width).
    *   Largura = Width do form para cobrir toda a faixa superior.
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

            *-- Sombra (deslocada 2px para efeito de profundidade no texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Nota Fiscal"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- T" + CHR(237) + "tulo branco (sobre a sombra preta)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Nota Fiscal"
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
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es de relat" + CHR(243) + "rio
    *   Equivalente ao btnReport do frmrelatorio legado.
    *   Posicionado no lado direito, sobrepondo o cabe" + CHR(231) + "alho (Background).
    *   Bot" + CHR(227) + "o(3) DocExcel: sempre desabilitado (lacexcel=.F. no original).
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

            *-- Bot" + CHR(227) + "o 1: Visualizar (preview na tela)
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
                .ToolTipText     = "Visualizar Nota Fiscal"
                .Themes          = .F.
                .Enabled         = .F.
                .Visible         = .T.
            ENDWITH

            *-- Bot" + CHR(227) + "o 2: Imprimir (impressora - fecha form ap" + CHR(243) + "s imprimir)
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
                .ToolTipText     = "Imprimir Nota Fiscal"
                .Themes          = .F.
                .Enabled         = .F.
                .Visible         = .T.
            ENDWITH

            *-- Bot" + CHR(227) + "o 3: DocExcel - sempre desabilitado (lacexcel=.F. no original)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Enabled         = .F.
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Bot" + CHR(227) + "o 4: Encerrar (ESC fecha o form)
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
    * AjustarBotoesPorModo - Habilita bot" + CHR(245) + "es conforme flags do BO
    *   Visualizar: somente se BO.this_lVisualizarHabilitado (SigCdPam == 999)
    *   Imprimir:   somente se BO.this_lImprimirHabilitado (sempre .T. no BO)
    *   Excel:      sempre desabilitado (lacexcel=.F. no original)
    *   Encerrar:   sempre habilitado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lVisualizar, loc_lImprimir
        TRY
            loc_lVisualizar = .F.
            loc_lImprimir   = .F.

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_lVisualizar = THIS.this_oRelatorio.this_lVisualizarHabilitado
                loc_lImprimir   = THIS.this_oRelatorio.this_lImprimirHabilitado
            ENDIF

            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lVisualizar
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lImprimir
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview da NF na tela
    *   Equivalente ao procedure 'visualizacao' do original (modo "V").
    *   Form permanece aberto ap" + CHR(243) + "s visualizar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lExecutar
        loc_lExecutar = VARTYPE(THIS.this_oRelatorio) = "O"
        TRY
            IF loc_lExecutar
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Impressao direta da NF; fecha o form ap" + CHR(243) + "s imprimir
    *   Equivalente ao procedure 'impressao' do original (modo "I" + Release).
    *   THIS.Release() chamado FORA do TRY (regra VFP9: sem RETURN em TRY)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lOk
        loc_lOk = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_lOk = THIS.this_oRelatorio.Imprimir()
                IF !loc_lOk
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF loc_lOk
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * M" + CHR(233) + "TODOS DE COMPATIBILIDADE COM O PIPELINE FORMBASE
    * Este form n" + CHR(227) + "o usa opera" + CHR(231) + CHR(245) + "es CRUD nem filtros; m" + CHR(233) + "todos abaixo
    * existem para satisfazer contratos do FormBase sem quebrar inicializa" + CHR(231) + CHR(227) + "o.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Stub de compatibilidade (REPORT layout FLAT)
    *   Este form herda de FormBase mas usa layout FLAT (h=130px) sem PageFrame.
    *   A inicializa" + CHR(231) + CHR(227) + "o visual eh feita por ConfigurarCabecalho() + ConfigurarBotoes().
    *   M" + CHR(233) + "todo existe apenas para satisfazer o contrato do pipeline de migra" + CHR(231) + CHR(227) + "o.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Stub de compatibilidade (REPORT sem p" + CHR(225) + "gina lista)
    *   Forms REPORT usam layout FLAT; n" + CHR(227) + "o h" + CHR(225) + " Page1 de lista nem Grid CRUD.
    *   M" + CHR(233) + "todo existe para satisfazer contrato do pipeline de migra" + CHR(231) + CHR(227) + "o.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Stub de compatibilidade (REPORT layout FLAT)
    *   SigReInf eh form operacional FLAT (h=130px): sem Page2, sem campos de
    *   entrada. Todos os dados chegam via Init (par_cEmps/par_cDopes/etc.).
    *   Stub existe para satisfazer contrato do pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    PROCEDURE LimparCampos()
        RETURN
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
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

    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera refer" + CHR(234) + "ncia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReInfBO.prg):
*==============================================================================
* SIGREINFBO.PRG
* Business Object para Impressao de Nota Fiscal (SigReInf)
* Herda de RelatorioBase
*
* Tabela principal: SigMvNfi
* Forma de uso: Recebe parametros de NF (empresa, operacao, numero, serie)
*               e delega impressao/visualizacao para SigPrNfs
*==============================================================================

DEFINE CLASS SigReInfBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigMvNfi"
    this_cCampoChave    = "Nfis"

    *-- Parametros da Nota Fiscal (recebidos via Init)
    this_cEmps          = ""
    this_cDopes         = ""
    this_nNumes         = 0
    this_cSerie         = ""

    *-- Controle de habilitacao de botoes
    this_lVisualizarHabilitado = .F.
    this_lImprimirHabilitado   = .F.

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega configuracoes de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta e executa SQL para obter NFs a imprimir
    * Retorna .T. se dados foram preparados com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_llFalse, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        loc_llFalse  = .F.

        TRY
            loc_cSQL = "Select c.Nfis, c.EmpdopNums From SigMvNfi c, SigCdOpe a " + ;
                       "Where c.emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " And c.series = " + EscaparSQL(THIS.this_cSerie) + ;
                       " And c.Impress = 0 and c.cancelas = 0" + ;
                       " And c.dopes = a.dopes" + ;
                       " and a.nfiscals in (1,2) and a.tiponfs <> 4 and a.agrupas = 1" + ;
                       " Union all " + ;
                       "Select c.Nfis, c.EmpDopNums From SigMvNfi c, SigCdOpe a, SigCdSer b " + ;
                       "Where c.emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " And c.series = " + EscaparSQL(THIS.this_cSerie) + ;
                       " And c.Impress = 0 And c.cancelas = 0" + ;
                       " and c.series = b.cods" + ;
                       " And c.dopes = a.dopes" + ;
                       " and a.nfiscals in (1,2) and a.tiponfs = 4 and b.impnfs = 1"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFiscal")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o ao buscar dados da NF"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Verifica SigCdPam e habilita botoes conforme regras
    * Equivalente ao Init() original que consultava SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT nnfftlns, nnfftcls FROM SigCdPam", ;
                "cursor_4c_Pam")

            IF loc_nResult > 0
                SELECT cursor_4c_Pam
                IF !EOF()
                    IF nnfftlns = 999 OR nnfftcls = 999
                        THIS.this_lVisualizarHabilitado = .T.
                    ENDIF
                ENDIF
                USE IN cursor_4c_Pam
            ENDIF

            THIS.this_lImprimirHabilitado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Executa preview da NF na tela
    * Equivalente ao metodo 'visualizacao' do form original (modo "V")
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            DO SigPrNfs WITH gnConnHandle, "V", THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Executa impressao direta da NF
    * Equivalente ao metodo 'impressao' do form original (modo "I")
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            DO SigPrNfs WITH gnConnHandle, "I", THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de identificacao da NF
    * Formato: emps + dopes + numes (mesmo padrao do lcEdn no original)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override: relatorios nao escrevem dados, sem auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

