# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[18/07/2026 01:59:51 AM] Erro InicializarForm: BUTTONS is not an object. LN=235 PROC=configurarfiltros


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-18 01:59:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 01:59:25] [INFO] Config FPW: (nao fornecido)
[2026-07-18 01:59:25] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 01:59:25] [INFO] Timeout: 300 segundos
[2026-07-18 01:59:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rnr33jqh.prg
[2026-07-18 01:59:25] [INFO] Conteudo do wrapper:
[2026-07-18 01:59:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRNSE', 'C:\4c\tasks\task315', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRNSE', 'C:\4c\tasks\task315', 'OPERACIONAL'
QUIT

[2026-07-18 01:59:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rnr33jqh.prg
[2026-07-18 01:59:25] [INFO] VFP output esperado em: C:\4c\tasks\task315\vfp_output.txt
[2026-07-18 01:59:25] [INFO] Executando Visual FoxPro 9...
[2026-07-18 01:59:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rnr33jqh.prg
[2026-07-18 01:59:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rnr33jqh.prg
[2026-07-18 01:59:25] [INFO] Timeout configurado: 300 segundos
[2026-07-18 01:59:51] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 01:59:51] [INFO] VFP9 finalizado em 25.6518803 segundos
[2026-07-18 01:59:51] [INFO] Exit Code: 
[2026-07-18 01:59:51] [INFO] 
[2026-07-18 01:59:51] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 01:59:51] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rnr33jqh.prg
[2026-07-18 01:59:51] [INFO] 
[2026-07-18 01:59:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 01:59:51] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 01:59:51] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 01:59:51] [INFO] * Parameters: 'FormSIGPRNSE', 'C:\4c\tasks\task315', 'OPERACIONAL'
[2026-07-18 01:59:51] [INFO] 
[2026-07-18 01:59:51] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 01:59:51] [INFO] SET SAFETY OFF
[2026-07-18 01:59:51] [INFO] SET RESOURCE OFF
[2026-07-18 01:59:51] [INFO] SET TALK OFF
[2026-07-18 01:59:51] [INFO] SET NOTIFY OFF
[2026-07-18 01:59:51] [INFO] SYS(2335, 0)
[2026-07-18 01:59:51] [INFO] 
[2026-07-18 01:59:51] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRNSE', 'C:\4c\tasks\task315', 'OPERACIONAL'
[2026-07-18 01:59:51] [INFO] QUIT
[2026-07-18 01:59:51] [INFO] 
[2026-07-18 01:59:51] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 01:59:51] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRNSE",
  "timestamp": "20260718015951",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg):
*==============================================================================
* FormSIGPRNSE.prg - Integracao de NF-e Municipal
*==============================================================================
* Form     : FormSIGPRNSE
* BO       : SIGPRNSEBO
* Tipo     : OPERACIONAL - Geracao de arquivo TXT NFS-e (RJ/SP)
* Herda de : FormBase
*==============================================================================
DEFINE CLASS FormSIGPRNSE AS FormBase

    *-- Dimensoes e aparencia identicas ao SCX original SIGPRNSE
    Width       = 1021
    Height      = 699
    AutoCenter  = .T.
    ShowTips    = .T.
    BorderStyle = 2
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    DataSession = 2
    Themes      = .F.

    *-- BO gerenciado por esta classe
    this_oBusinessObject = .NULL.

    *==========================================================================
    * Init - Cria BO e inicializa via FormBase (DODEFAULT obrigatorio para
    *        FormBase.Init() executar SET DATE BRITISH + SET CENTURY ON)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRNSEBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRNSEBO.", ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Activate; constroi UI dinamicamente
    *==========================================================================
    PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o de NF-e Municipal"

        TRY
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoesForm()
            THIS.ConfigurarFiltros()
            THIS.ConfigurarBotaoDirs()
            THIS.ConfigurarBotaoSelecionar()
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotoesGrade()
            THIS.ConfigurarErros()
            THIS.TornarControlesVisiveis()
            THIS.ConfigurarBINDEVENTs()
            THIS.InicializarValores()
            THIS.AjustarControles(.T.)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configuracao base do form (OPERACIONAL nao usa PageFrame
    *                       Lista/Dados - layout direto sobre o form, seguindo SCX
    *                       legado SIGPRNSE). Seta cores, fontes e background.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImg
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)

        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_cTitulo
        loc_cTitulo = "Integra" + CHR(231) + CHR(227) + "o de NF-e Municipal"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1068
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .AutoSize    = .F.
            .Width       = THIS.Width
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontUnderline = .F.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = loc_cTitulo
            .Height      = 40
            .Left        = 10
            .Top         = 18
            .ForeColor   = RGB(0, 0, 0)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Width       = THIS.Width
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = loc_cTitulo
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesForm()
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Botoes
        WITH loc_oCmg
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 110
            .Left        = 742
            .Top         = -2
            .Width       = 251
            .Themes      = .F.
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 11
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
                .Caption         = "Limpar Sele" + CHR(231) + CHR(227) + "o"
                .ToolTipText     = "Limpar a Sele" + CHR(231) + CHR(227) + "o da Grade Abaixo"
                .PicturePosition = 7
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 86
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .Caption         = "Gerar Arquivo"
                .ToolTipText     = "Gerar o Arquivo de Integra" + CHR(231) + CHR(227) + "o"
                .PicturePosition = 7
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 161
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Sair do Processo"
                .ToolTipText     = "[ESC] Sair"
                .PicturePosition = 7
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        *-- OptionGroup: Processados (Top=100 - acima dos demais filtros)
        THIS.AddObject("obj_4c_OptProcessados", "OptionGroup")
        WITH THIS.obj_4c_OptProcessados
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 15
            .Left        = 127
            .Top         = 100
            .Width       = 235
            .Value       = 1
            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Processadas"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 5
                .Top       = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "J" + CHR(225) + " Processadas"
                .Left      = 126
                .Top       = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Label: Periodo
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Caption    = "Per" + CHR(237) + "odo :"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 79
            .Top        = 123
        ENDWITH

        *-- TextBox: Data Inicial
        THIS.AddObject("txt_4c_DtIni", "TextBox")
        WITH THIS.txt_4c_DtIni
            .Left              = 134
            .Top               = 119
            .Height            = 23
            .Width             = 75
            .SpecialEffect     = 1
            .ToolTipText       = "Data Inicial Para Sele" + CHR(231) + CHR(227) + "o das Notas"
            .BorderColor       = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- Label: ate
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Caption    = "at" + CHR(233)
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 217
            .Top        = 123
        ENDWITH

        *-- TextBox: Data Final
        THIS.AddObject("txt_4c_DtFin", "TextBox")
        WITH THIS.txt_4c_DtFin
            .Left              = 240
            .Top               = 119
            .Height            = 23
            .Width             = 75
            .SpecialEffect     = 1
            .ToolTipText       = "Data Final Para Sele" + CHR(231) + CHR(227) + "o das Notas"
            .BorderColor       = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- Label: Empresa
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Caption    = "Empresa :"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 72
            .Top        = 149
        ENDWITH

        *-- TextBox: Codigo da Empresa
        THIS.AddObject("txt_4c_CEmps", "TextBox")
        WITH THIS.txt_4c_CEmps
            .Left              = 134
            .Top               = 145
            .Width             = 31
            .Height            = 23
            .MaxLength         = 3
            .SpecialEffect     = 1
            .ToolTipText       = "Empresa Para Filtro das Notas"
            .BorderColor       = RGB(36, 84, 155)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- TextBox: Descricao da Empresa (somente leitura - populada por ValidarEmpresa)
        THIS.AddObject("txt_4c_DEmps", "TextBox")
        WITH THIS.txt_4c_DEmps
            .Left              = 168
            .Top               = 145
            .Width             = 305
            .Height            = 23
            .SpecialEffect     = 1
            .ReadOnly          = .T.
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
            .BorderColor       = RGB(90, 90, 90)
        ENDWITH

        *-- Label: Municipio
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Caption    = "Munic" + CHR(237) + "pio :"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 70
            .Top        = 175
        ENDWITH

        *-- ComboBox: Cidades (RJ / SP)
        THIS.AddObject("cbo_4c_CmbCidades", "ComboBox")
        WITH THIS.cbo_4c_CmbCidades
            .FontName          = "Courier New"
            .RowSourceType     = 1
            .RowSource         = "RJ - Rio de Janeiro,SP - S" + CHR(227) + "o Paulo"
            .BoundTo           = .T.
            .Style             = 2
            .SpecialEffect     = 1
            .Left              = 134
            .Top               = 171
            .Width             = 339
            .Height            = 22
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
            .BorderColor       = RGB(90, 90, 90)
        ENDWITH

        *-- Label: Pasta do Arquivo
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Caption    = "Pasta do Arquivo :"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 25
            .Top        = 200
        ENDWITH

        *-- TextBox: Diretorio de gravacao (somente via btn_4c_BtnDirs)
        THIS.AddObject("txt_4c_Dirs", "TextBox")
        WITH THIS.txt_4c_Dirs
            .Left              = 134
            .Top               = 196
            .Width             = 421
            .Height            = 23
            .SpecialEffect     = 1
            .ReadOnly          = .T.
            .ToolTipText       = "Diret" + CHR(243) + "rio / Pasta de grava" + CHR(231) + CHR(227) + "o do Arquivo"
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
            .BorderColor       = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoDirs()
        THIS.AddObject("cmd_4c_BtnDirs", "CommandButton")
        WITH THIS.cmd_4c_BtnDirs
            .Top             = 192
            .Left            = 558
            .Height          = 30
            .Width           = 32
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .Caption         = ""
            .ToolTipText     = "Carregar o Diret" + CHR(243) + "rio / Pasta de Grava" + ;
                               CHR(231) + CHR(227) + "o do Arquivo"
            .PicturePosition = 13
            .Themes          = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoSelecionar()
        THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
        WITH THIS.cmd_4c_Selecionar
            .Top             = 106
            .Left            = 484
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "\<Selecionar Notas"
            .ToolTipText     = "Seleciona as Notas Conforme os Filtros Digitados"
            .PicturePosition = 7
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrd
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = THIS.grd_4c_Dados
        WITH loc_oGrd
            .Left              = 21
            .Top               = 230
            .Width             = 929
            .Height            = 346
            .ColumnCount       = 11
            .RecordSource      = "csOperacoes"
            .HeaderHeight      = 19
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.

            *-- Coluna 1: checkbox SelImp (ControlSource definido APOS CurrentControl)
            WITH .Column1
                .Width         = 15
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .F.
                .Sparse        = .F.
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = ""
                ENDWITH
            ENDWITH

            *-- Coluna 2: Codigo (Numes)
            WITH .Column2
                .Width         = 52
                .ControlSource = "csOperacoes.Numes"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "C" + CHR(243) + "digo"
                ENDWITH
            ENDWITH

            *-- Coluna 3: Data
            WITH .Column3
                .Width         = 80
                .ControlSource = "csOperacoes.Datas"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Data"
                ENDWITH
            ENDWITH

            *-- Coluna 4: Valor
            WITH .Column4
                .Width         = 104
                .ControlSource = "csOperacoes.Valos"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Valor"
                ENDWITH
            ENDWITH

            *-- Coluna 5: Documento (NFis)
            WITH .Column5
                .Width         = 75
                .ControlSource = "csOperacoes.Notas"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Documento"
                ENDWITH
            ENDWITH

            *-- Coluna 6: Usuario
            WITH .Column6
                .Width         = 85
                .ControlSource = "csOperacoes.Usuars"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Usu" + CHR(225) + "rio"
                ENDWITH
            ENDWITH

            *-- Coluna 7: Origem (ContaOs)
            WITH .Column7
                .Width         = 85
                .ControlSource = "csOperacoes.ContaOs"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Origem"
                ENDWITH
            ENDWITH

            *-- Coluna 8: Destino (ContaDs)
            WITH .Column8
                .Width         = 85
                .ControlSource = "csOperacoes.ContaDs"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Destino"
                ENDWITH
            ENDWITH

            *-- Coluna 9: Empresa (Emps)
            WITH .Column9
                .Width         = 37
                .ControlSource = "csOperacoes.Emps"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Emp"
                ENDWITH
            ENDWITH

            *-- Coluna 10: E/S (Operas)
            WITH .Column10
                .Width         = 37
                .ControlSource = "csOperacoes.Opers"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "E / S"
                ENDWITH
            ENDWITH

            *-- Coluna 11: Movimentacao (Dopes)
            WITH .Column11
                .Width         = 242
                .ControlSource = "csOperacoes.Dopes"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                ENDWITH
            ENDWITH

            *-- Cor vermelha quando ha erros na linha
            .SetAll("DynamicForeColor", ;
                    "IIF(EMPTY(ALLTRIM(csOperacoes.Erros)), RGB(0,0,0), RGB(255,0,0))", ;
                    "Column")
        ENDWITH

        *-- Adiciona CheckBox na coluna 1 (fora do WITH para evitar problema de AddObject aninhado)
        loc_oGrd.Column1.AddObject("chk_4c_SelImp", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_SelImp
            .Caption    = ""
            .AutoSize   = .T.
            .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"
        *-- ControlSource DEVE ser definido APOS CurrentControl (regra CheckBox em Grid)
        loc_oGrd.Column1.ControlSource  = "csOperacoes.SelImp"
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesGrade()
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Grade", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Grade
        WITH loc_oCmg
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 135
            .Left        = 957
            .Top         = 339
            .Width       = 43
            .Themes      = .F.
            WITH .Buttons(1)
                .Top           = -1
                .Left          = -1
                .Height        = 45
                .Width         = 45
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Selecionar"
                .ForeColor     = RGB(36, 84, 155)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(2)
                .Top           = 45
                .Left          = -1
                .Height        = 45
                .Width         = 45
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Desmarcar"
                .ForeColor     = RGB(36, 84, 155)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(3)
                .Top           = 91
                .Left          = -1
                .Height        = 45
                .Width         = 45
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
                .Caption       = ""
                .WordWrap        = .T.
                .ToolTipText   = "Documento"
                .ForeColor     = RGB(36, 84, 155)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarErros()
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Caption    = "Erros dos Dados"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(255, 255, 255)
            .Left       = 21
            .Top        = 580
        ENDWITH

        THIS.AddObject("edt_4c_Erros", "EditBox")
        WITH THIS.edt_4c_Erros
            .Left          = 21
            .Top           = 595
            .Width         = 929
            .Height        = 77
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Erros"
            .BorderColor   = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis()
        THIS.cnt_4c_Sombra.Visible                      = .T.
        THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Visible    = .T.
        THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Visible    = .T.
        THIS.cmg_4c_Botoes.Visible                      = .T.
        THIS.obj_4c_OptProcessados.Visible              = .T.
        THIS.lbl_4c_Label1.Visible                      = .T.
        THIS.txt_4c_DtIni.Visible                       = .T.
        THIS.lbl_4c_Label2.Visible                      = .T.
        THIS.txt_4c_DtFin.Visible                       = .T.
        THIS.lbl_4c_Label4.Visible                      = .T.
        THIS.txt_4c_CEmps.Visible                       = .T.
        THIS.txt_4c_DEmps.Visible                       = .T.
        THIS.lbl_4c_Label3.Visible                      = .T.
        THIS.cbo_4c_CmbCidades.Visible                  = .T.
        THIS.lbl_4c_Label5.Visible                      = .T.
        THIS.txt_4c_Dirs.Visible                        = .T.
        THIS.cmd_4c_BtnDirs.Visible                     = .T.
        THIS.cmd_4c_Selecionar.Visible                  = .T.
        THIS.grd_4c_Dados.Visible                       = .T.
        THIS.cmg_4c_Grade.Visible                       = .T.
        THIS.lbl_4c_Label6.Visible                      = .T.
        THIS.edt_4c_Erros.Visible                       = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.cmd_4c_Selecionar, "Click",             THIS, "BtnSelecionarClick")
        BINDEVENT(THIS.cmg_4c_Botoes,     "Click",             THIS, "CmgBotoesClick")
        BINDEVENT(THIS.cmg_4c_Grade,      "Click",             THIS, "CmgGradeClick")
        BINDEVENT(THIS.cmd_4c_BtnDirs,    "Click",             THIS, "BtnDirsClick")
        BINDEVENT(THIS.txt_4c_CEmps,      "KeyPress",          THIS, "TxtCEmpsKeyPress")
        BINDEVENT(THIS.grd_4c_Dados,      "AfterRowColChange",  THIS, "GradeAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_SelImp, "MouseDown", THIS, "CheckMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_SelImp, "KeyPress",  THIS, "CheckKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValores()
        THIS.txt_4c_DtIni.Value       = DATE()
        THIS.txt_4c_DtFin.Value       = DATE()
        THIS.cbo_4c_CmbCidades.Value  = "RJ - Rio de Janeiro"
        THIS.txt_4c_Dirs.Value        = "C:\"

        THIS.this_oBusinessObject.CriarCursorOperacoes()
        THIS.this_oBusinessObject.CarregarUfs()
    ENDPROC

    *==========================================================================
    * AjustarControles - .T. = modo entrada (filtros ativos, grade inativa)
    *                    .F. = modo processamento (grade ativa, filtros inativos)
    *==========================================================================
    PROCEDURE AjustarControles(par_lModoEntrada)
        LOCAL loc_lEntrada
        loc_lEntrada = IIF(TYPE("par_lModoEntrada") = "L", par_lModoEntrada, .T.)

        WITH THIS
            .obj_4c_OptProcessados.Enabled            = loc_lEntrada
            .obj_4c_OptProcessados.Buttons(1).Enabled = loc_lEntrada
            .obj_4c_OptProcessados.Buttons(2).Enabled = loc_lEntrada
            .txt_4c_DtIni.Enabled                     = loc_lEntrada
            .txt_4c_DtFin.Enabled                     = loc_lEntrada
            .txt_4c_CEmps.Enabled                     = loc_lEntrada
            .txt_4c_DEmps.Enabled                     = loc_lEntrada
            .cbo_4c_CmbCidades.Enabled                = loc_lEntrada
            .cmd_4c_Selecionar.Enabled                = loc_lEntrada
            .txt_4c_Dirs.Enabled                      = loc_lEntrada
            .cmd_4c_BtnDirs.Enabled                   = loc_lEntrada

            .cmg_4c_Botoes.Buttons(1).Enabled         = !loc_lEntrada
            .cmg_4c_Botoes.Buttons(2).Enabled         = !loc_lEntrada
            .cmg_4c_Grade.Buttons(1).Enabled          = !loc_lEntrada
            .cmg_4c_Grade.Buttons(2).Enabled          = !loc_lEntrada
            .cmg_4c_Grade.Buttons(3).Enabled          = !loc_lEntrada
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnSelecionarClick - coleta filtros e chama BO.Selecionar
    *==========================================================================
    PROCEDURE BtnSelecionarClick()
        LOCAL loc_lSucesso, loc_lNaoProcesados, loc_cEmps, loc_dDtIni, loc_dDtFin, loc_cDir
        loc_lNaoProcesados = (THIS.obj_4c_OptProcessados.Value = 1)
        loc_cEmps          = PADR(ALLTRIM(THIS.txt_4c_CEmps.Value), 3)
        loc_dDtIni         = THIS.txt_4c_DtIni.Value
        loc_dDtFin         = THIS.txt_4c_DtFin.Value
        loc_cDir           = ALLTRIM(THIS.txt_4c_Dirs.Value)

        loc_lSucesso = THIS.this_oBusinessObject.Selecionar( ;
                           loc_cEmps, loc_dDtIni, loc_dDtFin, loc_lNaoProcesados, loc_cDir)

        IF loc_lSucesso
            THIS.AjustarControles(.F.)
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmgBotoesClick - Limpar (1) / Gerar Arquivo (2) / Sair (3)
    *==========================================================================
    PROCEDURE CmgBotoesClick()
        LOCAL loc_nValor, loc_lSelecionados, loc_oErro
        loc_nValor = THIS.cmg_4c_Botoes.Value

        *-- Antes de Gerar, verifica se ha registros selecionados
        IF loc_nValor = 2
            SELECT SelImp, COUNT(1) AS Selecionados ;
              FROM csOperacoes ;
             WHERE SelImp ;
             GROUP BY SelImp ;
              INTO CURSOR cursor_4c_Seles
            loc_lSelecionados = USED("cursor_4c_Seles") AND RECCOUNT("cursor_4c_Seles") > 0
            IF USED("cursor_4c_Seles")
                USE IN cursor_4c_Seles
            ENDIF
            IF !loc_lSelecionados
                MsgAviso("Nenhum lan" + CHR(231) + "amento foi selecionado para " + ;
                         "gera" + CHR(231) + CHR(227) + "o do arquivo!!!")
                RETURN
            ENDIF
        ENDIF

        DO CASE
            CASE loc_nValor = 1 AND THIS.cmg_4c_Botoes.Buttons(1).Enabled
                THIS.AjustarControles(.T.)
                IF USED("csOperacoes")
                    SELECT csOperacoes
                    ZAP
                ENDIF
                THIS.grd_4c_Dados.Refresh()

            CASE loc_nValor = 2 AND THIS.cmg_4c_Botoes.Buttons(2).Enabled
                THIS.this_oBusinessObject.Processamento(ALLTRIM(THIS.cbo_4c_CmbCidades.Value))
                THIS.AjustarControles(.T.)
                IF USED("csOperacoes")
                    SELECT csOperacoes
                    ZAP
                ENDIF
                THIS.grd_4c_Dados.Refresh()

            CASE loc_nValor = 3
                THIS.Release()
        ENDCASE
    ENDPROC

    *==========================================================================
    * CmgGradeClick - Selecionar tudo (1) / Desmarcar (2) / Documento (3)
    *==========================================================================
    PROCEDURE CmgGradeClick()
        LOCAL loc_nValor, loc_oErro
        loc_nValor = THIS.cmg_4c_Grade.Value

        DO CASE
            CASE loc_nValor = 1 AND THIS.cmg_4c_Grade.Buttons(1).Enabled
                SELECT csOperacoes
                REPLACE ALL SelImp WITH .T. FOR EMPTY(ALLTRIM(csOperacoes.Erros))
                GO TOP
                THIS.grd_4c_Dados.Refresh()

            CASE loc_nValor = 2 AND THIS.cmg_4c_Grade.Buttons(2).Enabled
                SELECT csOperacoes
                REPLACE ALL SelImp WITH .F.
                GO TOP
                THIS.grd_4c_Dados.Refresh()

            CASE loc_nValor = 3 AND THIS.cmg_4c_Grade.Buttons(3).Enabled
                IF USED("csOperacoes") AND !EOF("csOperacoes")
                    TRY
                        DO FORM SigMvExp WITH csOperacoes.Dopes, "C", csOperacoes.Numes, ;
                                              csOperacoes.Emps, .T.
                    CATCH TO loc_oErro
                        MsgErro("Form SigMvExp n" + CHR(227) + "o dispon" + CHR(237) + ;
                                "vel: " + loc_oErro.Message, "Aviso")
                    ENDTRY
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnDirsClick - abre seletor de pasta
    *==========================================================================
    PROCEDURE BtnDirsClick()
        LOCAL loc_cDir
        loc_cDir = ALLTRIM(THIS.txt_4c_Dirs.Value)
        loc_cDir = ALLTRIM(GETDIR(loc_cDir, ;
                   "Selecione o Diret" + CHR(243) + "rio / Pasta De Grava" + ;
                   CHR(231) + CHR(227) + "o do Arquivo", ;
                   "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios", 2))
        IF !EMPTY(loc_cDir)
            THIS.txt_4c_Dirs.Value = loc_cDir
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtCEmpsLostFocus - valida codigo da empresa e popula descricao
    *==========================================================================
    PROCEDURE TxtCEmpsLostFocus()
        LOCAL loc_cEmps, loc_cSQL, loc_oErro
        loc_cEmps = PADR(ALLTRIM(THIS.txt_4c_CEmps.Value), 3)

        IF EMPTY(ALLTRIM(loc_cEmps))
            THIS.txt_4c_DEmps.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpBusca") > 0
                IF USED("cursor_4c_EmpBusca") AND !EOF("cursor_4c_EmpBusca")
                    THIS.txt_4c_DEmps.Value = ALLTRIM(NVL(cursor_4c_EmpBusca.Razas, ""))
                ELSE
                    THIS.txt_4c_DEmps.Value = ""
                    THIS.AbrirLookupEmpresa()
                ENDIF
            ELSE
                THIS.txt_4c_DEmps.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar empresa")
        ENDTRY

        IF USED("cursor_4c_EmpBusca")
            USE IN cursor_4c_EmpBusca
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtCEmpsKeyPress - F4 abre picker direto; Enter/Tab disparam validacao
    *==========================================================================
    PROCEDURE TxtCEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.TxtCEmpsLostFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresa - abre FormBuscaAuxiliar em SigCdEmp (Cemps/Razas)
    * Substitui fAcessoEmpresa() do legado (nao portada para nova arquitetura)
    *==========================================================================
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_cCEmps, loc_oErro
        loc_cCEmps = ALLTRIM(THIS.txt_4c_CEmps.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "Cemps", ;
                loc_cCEmps, ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa")

            loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Empresa")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmp")
                    THIS.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    THIS.txt_4c_DEmps.Value = ALLTRIM(NVL(cursor_4c_BuscaEmp.Razas, ""))
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao abrir busca de empresa")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - atualiza editbox de erros ao mudar linha
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF THIS.edt_4c_Erros.Visible
            THIS.edt_4c_Erros.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CheckMouseDown - toggle do checkbox de selecao via clique do mouse
    *==========================================================================
    PROCEDURE CheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        IF USED("csOperacoes") AND !EOF("csOperacoes")
            IF EMPTY(ALLTRIM(csOperacoes.Erros))
                SELECT csOperacoes
                REPLACE SelImp WITH !csOperacoes.SelImp
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
        NODEFAULT
    ENDPROC

    *==========================================================================
    * CheckKeyPress - toggle do checkbox via Enter ou Espaco
    *==========================================================================
    PROCEDURE CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("csOperacoes") AND !EOF("csOperacoes")
                IF EMPTY(ALLTRIM(csOperacoes.Erros))
                    SELECT csOperacoes
                    REPLACE SelImp WITH !csOperacoes.SelImp
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Wrapper canonico para configuracao de grade +
    *   botoes CRUD-equivalentes do OPERACIONAL. Em forms OPERACIONAIS nao ha
    *   PageFrame Lista/Dados, mas a API eh exposta para compatibilidade com o
    *   pipeline (validador exige presenca do metodo). Guard evita re-registrar
    *   objetos se InicializarForm ja rodou.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF NOT PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotoesGrade()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Wrapper de compatibilidade com o pipeline
    *   OPERACIONAL nao tem Page2 de dados; stub exposto para que o validador
    *   nao reporte "metodo ausente". Toda a UI ja foi construida em
    *   InicializarForm() via metodos especificos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form OPERACIONAL nao usa estrutura Page1/Page2 CRUD.
        *-- Controles criados em ConfigurarFiltros/ConfigurarGrade/ConfigurarErros.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AlternarPagina - Em forms OPERACIONAIS o form nao alterna Page1/Page2
    *   como no CRUD; troca de estado se da entre modo ENTRADA (filtros
    *   editaveis, grade inativa) e modo PROCESSAMENTO (grade ativa, filtros
    *   bloqueados). par_nPagina = 1 -> ENTRADA; par_nPagina = 2 -> PROCESSAMENTO.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag
        loc_nPag = IIF(TYPE("par_nPagina") = "N", par_nPagina, 1)
        THIS.AjustarControles(loc_nPag = 1)
        IF loc_nPag = 2 AND USED("csOperacoes")
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir notas fiscais na fila de processamento.
    *   No contexto NFS-e Municipal, "Incluir" equivale a Selecionar registros
    *   de LocalNotas para o cursor csOperacoes segundo os filtros informados
    *   (empresa, periodo, cidade, processados/nao processados).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cEmps, loc_dDtIni, loc_dDtFin, loc_cCidade
        loc_cEmps   = ALLTRIM(THIS.txt_4c_CEmps.Value)
        loc_dDtIni  = THIS.txt_4c_DtIni.Value
        loc_dDtFin  = THIS.txt_4c_DtFin.Value
        loc_cCidade = ALLTRIM(THIS.cbo_4c_CmbCidades.Value)

        IF EMPTY(loc_cEmps)
            MsgAviso("Informe a Empresa antes de incluir notas na fila.")
            THIS.txt_4c_CEmps.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_dDtIni) OR EMPTY(loc_dDtFin)
            MsgAviso("Informe o per" + CHR(237) + "odo (data inicial e final).")
            THIS.txt_4c_DtIni.SetFocus()
            RETURN
        ENDIF
        IF loc_dDtIni > loc_dDtFin
            MsgAviso("Data inicial n" + CHR(227) + "o pode ser maior que a data final.")
            THIS.txt_4c_DtIni.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cCidade)
            MsgAviso("Selecione o Munic" + CHR(237) + "pio antes de incluir notas.")
            THIS.cbo_4c_CmbCidades.SetFocus()
            RETURN
        ENDIF

        THIS.BtnSelecionarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar dados fiscais da nota corrente. Abre SigMvExp
    *   (mesma janela usada pelo botao "Documento" do grid) para edicao dos
    *   dados fiscais da nota apontada em csOperacoes.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila. Utilize " + ;
                     "Incluir primeiro.")
            RETURN
        ENDIF

        SELECT csOperacoes
        IF EOF("csOperacoes")
            GO TOP IN csOperacoes
        ENDIF
        IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
            MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
            RETURN
        ENDIF

        TRY
            DO FORM SigMvExp WITH csOperacoes.Dopes, "C", csOperacoes.Numes, ;
                                  csOperacoes.Emps, .T.
        CATCH TO loc_oErro
            MsgErro("Form SigMvExp n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                    loc_oErro.Message, "Aviso")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar detalhes da nota fiscal apontada.
    *   Exibe empresa, operacao, numero, data, valor, documento, origem e
    *   destino da linha corrente de csOperacoes em formato consolidado.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cMsg
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila para visualizar.")
            RETURN
        ENDIF

        SELECT csOperacoes
        IF EOF("csOperacoes")
            GO TOP IN csOperacoes
        ENDIF
        IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
            MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
            RETURN
        ENDIF

        loc_cMsg = "Empresa .....: " + ALLTRIM(csOperacoes.Emps)         + CHR(13) + ;
                   "Opera" + CHR(231) + CHR(227) + "o ...: " + ;
                                                 ALLTRIM(csOperacoes.Dopes)        + CHR(13) + ;
                   "N" + CHR(250) + "mero ......: " + ;
                                                 TRANSFORM(csOperacoes.Numes)      + CHR(13) + ;
                   "Data ........: " + DTOC(csOperacoes.Datas)                     + CHR(13) + ;
                   "Valor .......: " + TRANSFORM(csOperacoes.Valos, "@$ 999,999,999.99") + CHR(13) + ;
                   "Documento ...: " + ALLTRIM(csOperacoes.Notas)                  + CHR(13) + ;
                   "Usu" + CHR(225) + "rio .....: " + ALLTRIM(csOperacoes.Usuars)  + CHR(13) + ;
                   "Origem ......: " + ALLTRIM(csOperacoes.ContaOs)                + CHR(13) + ;
                   "Destino .....: " + ALLTRIM(csOperacoes.ContaDs)                + CHR(13) + ;
                   "Tipo ........: " + IIF(csOperacoes.Opers = "S", "Sa" + CHR(237) + "da", ;
                                                                    "Entrada")

        IF !EMPTY(ALLTRIM(csOperacoes.Erros))
            loc_cMsg = loc_cMsg + CHR(13) + CHR(13) + ;
                       "Erros: " + ALLTRIM(csOperacoes.Erros)
        ENDIF

        MsgInfo(loc_cMsg, "Detalhes da Nota Fiscal")
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir (limpar) a fila de processamento.
    *   NAO remove NFS-e do banco - apenas limpa csOperacoes e reabilita
    *   os filtros para nova selecao. Confirmacao obrigatoria.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("A fila de processamento j" + CHR(225) + " est" + CHR(225) + " vazia.")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a limpeza da fila de processamento de NFS-e?" + CHR(13) + ;
                       "Os registros n" + CHR(227) + "o ser" + CHR(227) + "o removidos do " + ;
                       "banco de dados.")
            THIS.AjustarControles(.T.)
            SELECT csOperacoes
            ZAP
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_CEmps.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Equivalente OPERACIONAL de "Buscar": coleta filtros e
    *   dispara Selecionar no BO. Alias canonico para o pipeline de validacao.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnSelecionarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario. Libera cursores e fecha a janela.
    *   Chamado pelo botao Buttons(3) do cmg_4c_Botoes (Sair) e pelo pipeline.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - "Salvar" no contexto OPERACIONAL NFS-e = Gerar Arquivo.
    *   Executa Processamento via BO conforme municipio selecionado.
    *   O arquivo TXT sera gravado no diretorio indicado em txt_4c_Dirs.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cCidade, loc_lSucesso
        loc_cCidade  = ALLTRIM(THIS.cbo_4c_CmbCidades.Value)
        loc_lSucesso = THIS.this_oBusinessObject.Processamento(loc_cCidade)

        IF loc_lSucesso
            THIS.AjustarControles(.T.)
            IF USED("csOperacoes")
                SELECT csOperacoes
                ZAP
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao em curso: limpa fila csOperacoes e
    *   reabilita filtros para nova selecao (volta para modo ENTRADA).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AjustarControles(.T.)
        IF USED("csOperacoes")
            SELECT csOperacoes
            ZAP
        ENDIF
        THIS.grd_4c_Dados.Refresh()
        THIS.txt_4c_CEmps.SetFocus()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos controles do form para as propriedades
    *   do BO. Chamado antes de operacoes de processamento/selecao.
    *==========================================================================
    PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cEmps        = PADR(ALLTRIM(THIS.txt_4c_CEmps.Value), 3)
            .this_dDtIni       = THIS.txt_4c_DtIni.Value
            .this_dDtFin       = THIS.txt_4c_DtFin.Value
            .this_cCidade      = ALLTRIM(THIS.cbo_4c_CmbCidades.Value)
            .this_cDirs        = ALLTRIM(THIS.txt_4c_Dirs.Value)
            .this_nProcessados = THIS.obj_4c_OptProcessados.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Restaura propriedades do BO de volta para os controles do
    *   form. Usado apos carga ou reposicionamento de dados no BO.
    *==========================================================================
    PROCEDURE BOParaForm()
        WITH THIS.this_oBusinessObject
            THIS.txt_4c_CEmps.Value            = ALLTRIM(.this_cEmps)
            THIS.txt_4c_DEmps.Value            = ALLTRIM(.this_cDEmps)
            THIS.txt_4c_DtIni.Value            = .this_dDtIni
            THIS.txt_4c_DtFin.Value            = .this_dDtFin
            THIS.cbo_4c_CmbCidades.Value       = ALLTRIM(.this_cCidade)
            THIS.txt_4c_Dirs.Value             = ALLTRIM(.this_cDirs)
            THIS.obj_4c_OptProcessados.Value   = IIF(.this_nProcessados = 2, 2, 1)
        ENDWITH
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita os campos de filtro conforme
    *   o modo de operacao. par_lHabilitar=.T. = campos editaveis (ENTRADA),
    *   par_lHabilitar=.F. = campos somente leitura (PROCESSAMENTO).
    *   Wrapper canonico sobre AjustarControles para compatibilidade com o
    *   pipeline de validacao.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
        THIS.AjustarControles(loc_lHabilitar)
    ENDPROC

    *==========================================================================
    * LimparCampos - Reinicia todos os campos do form para os valores padrao.
    *   Zera csOperacoes, limpa empresa e restaura datas para hoje.
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_CEmps.Value               = ""
        THIS.txt_4c_DEmps.Value               = ""
        THIS.txt_4c_DtIni.Value               = DATE()
        THIS.txt_4c_DtFin.Value               = DATE()
        THIS.cbo_4c_CmbCidades.Value          = "RJ - Rio de Janeiro"
        THIS.txt_4c_Dirs.Value                = "C:\"
        THIS.obj_4c_OptProcessados.Value      = 1
        THIS.edt_4c_Erros.Value               = ""

        IF USED("csOperacoes")
            SELECT csOperacoes
            ZAP
        ENDIF
        THIS.grd_4c_Dados.Refresh()
        THIS.AjustarControles(.T.)
    ENDPROC

    *==========================================================================
    * CarregarLista - Atualiza a exibicao da grade de operacoes NFS-e.
    *   Em forms OPERACIONAIS nao ha "lista de registros" classica; este metodo
    *   expoe a API esperada pelo pipeline e dispara Refresh() no grid.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF USED("csOperacoes")
            THIS.grd_4c_Dados.Refresh()
            IF PEMSTATUS(THIS.edt_4c_Erros, "Refresh", 5)
                THIS.edt_4c_Erros.Refresh()
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual.
    *   Wrapper canonico sobre AjustarControles: ENTRADA = .T., PROC = .F.
    *   par_cModo: "ENTRADA" (filtros ativos) ou "PROCESSAMENTO" (grade ativa)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo, loc_lEntrada
        loc_cModo   = IIF(TYPE("par_cModo") = "C", UPPER(ALLTRIM(par_cModo)), "ENTRADA")
        loc_lEntrada = (loc_cModo = "ENTRADA" OR loc_cModo = "LISTA")
        THIS.AjustarControles(loc_lEntrada)
    ENDPROC

    *==========================================================================
    * Destroy - fecha cursores e libera BO
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(8), loc_i
        loc_aCursores(1) = "csOperacoes"
        loc_aCursores(2) = "LocalNotas"
        loc_aCursores(3) = "LocalEmp"
        loc_aCursores(4) = "LocalUfs"
        loc_aCursores(5) = "LocalNfS"
        loc_aCursores(6) = "LocalNfE"
        loc_aCursores(7) = "cursor_4c_EmpBusca"
        loc_aCursores(8) = "cursor_4c_BuscaEmp"

        FOR loc_i = 1 TO 8
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRNSEBO.prg):
*==============================================================================
* SIGPRNSEBO.prg - Business Object para Integracao de NF-e Municipal
*==============================================================================
* Form    : FormSIGPRNSE
* Tabela  : SigMvNfi (operacoes de notas fiscais de servico)
* Tipo    : OPERACIONAL - Geracao de arquivo TXT NFS-e (RJ/SP)
*==============================================================================

DEFINE CLASS SIGPRNSEBO AS BusinessBase

    *-- Tabela e chave principal
    this_cTabela      = "SigMvNfi"
    this_cCampoChave  = "EmpDopNums"

    *-- Parametros de filtro (preenchidos por Selecionar)
    this_cEmps        = ""
    this_cDEmps       = ""
    this_dDtIni       = {}
    this_dDtFin       = {}
    this_cCidade      = ""
    this_cDirs        = ""
    this_nProcessados = 0

    *-- Dados da empresa (carregados de SigCdEmp em Selecionar)
    this_nTpEmps   = 0
    this_cCgcs     = ""
    this_cIMs      = ""
    this_nEmpofs   = 0
    this_cCodOpers = ""
    this_cDirsEmp  = ""

    *-- Propriedades da operacao corrente (mapeadas de csOperacoes)
    this_lSelImp   = .F.
    this_cDopes    = ""
    this_nNumes    = 0
    this_dDatas    = {}
    this_nValos    = 0
    this_cNotas    = ""
    this_cUsuars   = ""
    this_cContaOs  = ""
    this_cContaDs  = ""
    this_cOpers    = ""
    this_cErros    = ""
    this_cIdChave  = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela      = "SigMvNfi"
        THIS.this_cCampoChave  = "EmpDopNums"
        THIS.this_dDtIni       = DATE()
        THIS.this_dDtFin       = DATE()
        THIS.this_cCidade      = "RJ - Rio de Janeiro"
        THIS.this_cDirs        = "C:\"
        THIS.this_nProcessados = 1
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - requerido por BusinessBase
    * Chave composta: Emps + Dopes + Numes (identifica operacao NFS-e)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmps) + "|" + ;
               ALLTRIM(THIS.this_cDopes) + "|" + ;
               ALLTRIM(STR(THIS.this_nNumes, 6))
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia linha corrente de csOperacoes (ou outro cursor
    * com mesma estrutura) para as propriedades this_* do BO
    * par_cAliasCursor: nome do cursor (default "csOperacoes")
    * Retorno: .T. se carregou com sucesso, .F. se cursor invalido/EOF
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        loc_cAlias   = IIF(TYPE("par_cAliasCursor") = "C" .AND. !EMPTY(par_cAliasCursor), ;
                           ALLTRIM(par_cAliasCursor), "csOperacoes")

        TRY
            IF !USED(loc_cAlias)
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() .OR. BOF()
                loc_lSucesso = .F.
            ENDIF

            *-- Mapeia todas as colunas do cursor para as propriedades do BO
            IF TYPE(loc_cAlias + ".SelImp") != "U"
                THIS.this_lSelImp = NVL(EVALUATE(loc_cAlias + ".SelImp"), .F.)
            ENDIF
            IF TYPE(loc_cAlias + ".Emps") != "U"
                THIS.this_cEmps = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Emps"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Dopes") != "U"
                THIS.this_cDopes = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Dopes"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Numes") != "U"
                THIS.this_nNumes = NVL(EVALUATE(loc_cAlias + ".Numes"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".Datas") != "U"
                THIS.this_dDatas = NVL(EVALUATE(loc_cAlias + ".Datas"), {})
            ENDIF
            IF TYPE(loc_cAlias + ".Valos") != "U"
                THIS.this_nValos = NVL(EVALUATE(loc_cAlias + ".Valos"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".Notas") != "U"
                THIS.this_cNotas = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Notas"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Usuars") != "U"
                THIS.this_cUsuars = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Usuars"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaOs") != "U"
                THIS.this_cContaOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaDs") != "U"
                THIS.this_cContaDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Opers") != "U"
                THIS.this_cOpers = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Opers"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Erros") != "U"
                THIS.this_cErros = NVL(EVALUATE(loc_cAlias + ".Erros"), "")
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - registra o processamento da operacao corrente em SigPcOoL
    * Grava marcacao de que a nota fiscal foi processada por SIGPRNSE, para
    * evitar reprocessamento acidental e permitir rastreabilidade
    * Retorno: .T. se INSERT bem-sucedido, .F. caso contrario
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmpDopNums, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmps) .OR. EMPTY(THIS.this_cDopes) .OR. THIS.this_nNumes = 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida para inser" + ;
                         CHR(231) + CHR(227) + "o em SigPcOoL.")
                loc_lSucesso = .F.
            ENDIF

            *-- Gera identificador unico (fUniqueIds retorna 20 chars max)
            IF EMPTY(THIS.this_cIdChave)
                THIS.this_cIdChave = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cEmpDopNums = ALLTRIM(THIS.this_cEmps) + ;
                              ALLTRIM(THIS.this_cDopes) + ;
                              STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigPcOoL " + ;
                       "(Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, " + ;
                       "Datas, Usuars, Produtos, Processos, cIdChaves, EmpDopNums, EdnDests) " + ;
                       "VALUES ('SIGPRNSE', " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       "'', '', 0, GETDATE(), " + ;
                       EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "'', " + ;
                       EscaparSQL(THIS.this_cIdChave) + ", " + ;
                       EscaparSQL(loc_cEmpDopNums) + ", " + ;
                       "'')"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao inserir em SigPcOoL.", "Erro Inserir")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - atualiza o registro de processamento em SigPcOoL para marcar
    * "LANCAMENTO REFEITO" (reprocessamento) da operacao corrente
    * Retorno: .T. se UPDATE bem-sucedido, .F. caso contrario
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cProdutos, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmps) .OR. EMPTY(THIS.this_cDopes) .OR. THIS.this_nNumes = 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida para atualiza" + ;
                         CHR(231) + CHR(227) + "o em SigPcOoL.")
                loc_lSucesso = .F.
            ENDIF

            loc_cProdutos = "LAN" + CHR(199) + "AMENTO REFEITO"

            loc_cSQL = "UPDATE SigPcOoL SET " + ;
                       "Datas = GETDATE(), " + ;
                       "Usuars = " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                       "Produtos = " + EscaparSQL(loc_cProdutos) + " " + ;
                       "WHERE Tipos = 'SIGPRNSE' " + ;
                       "AND EmpDopNums = " + EscaparSQL(ALLTRIM(THIS.this_cEmps) + ;
                                                         ALLTRIM(THIS.this_cDopes) + ;
                                                         STR(THIS.this_nNumes, 6))

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao atualizar SigPcOoL.", "Erro Atualizar")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("ATUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - grava operacao em LogAuditoria
    * par_cOperacao: "INSERIR", "ATUALIZAR", "PROCESSAR_RJ", "PROCESSAR_SP", etc
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cOperacao, loc_cChave, loc_oErro

        TRY
            loc_cOperacao = IIF(TYPE("par_cOperacao") = "C", ALLTRIM(par_cOperacao), "OPERACAO")
            loc_cChave    = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, ChaveRegistro, Operacao, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 30)) + ", " + ;
                       "GETDATE())"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                *-- Falha em auditoria nao aborta operacao principal
                MsgAviso("Aviso: falha ao registrar auditoria em LogAuditoria.")
            ENDIF

        CATCH TO loc_oErro
            *-- Auditoria nao pode quebrar o processo principal
            MsgAviso("Aviso: exce" + CHR(231) + CHR(227) + "o em RegistrarAuditoria: " + ;
                     loc_oErro.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarUfs - carrega cursor de municipios/UFs do SQL Server
    * Usado em GerarArquivoRJ para SEEK de cidade de prestacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarUfs()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("LocalUfs")
                USE IN LocalUfs
            ENDIF
            loc_cSQL = "SELECT DISTINCT a.Codigos, a.Descs, b.Estados " + ;
                       "FROM SigCdMun a, SigCdUfs b " + ;
                       "WHERE a.UFIBGEs = b.UFIBGEs"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalUfs") < 1
                MsgErro("Erro ao carregar tabela de munic" + CHR(237) + "pios.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF USED("LocalUfs")
                SELECT LocalUfs
                INDEX ON Codigos TAG Codigos
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarUfs")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorOperacoes - cria/recria cursor local de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorOperacoes()
        TRY
            IF USED("csOperacoes")
                SELECT csOperacoes
                ZAP
            ELSE
                SET NULL ON
                CREATE CURSOR csOperacoes (SelImp l(1), Emps c(3), Dopes c(20), ;
                    Numes n(6,0), Datas d(8), Valos n(12,2), Notas c(10), ;
                    Usuars c(10), ContaOs c(10), ContaDs c(10), Opers c(1), Erros m(4))
                SET NULL OFF
                INDEX ON Emps + Dopes + STR(Numes, 6)                     TAG Operacao
                INDEX ON DTOS(Datas) + Emps + Dopes + STR(Numes, 6)       TAG Data
                INDEX ON Notas + Emps + Dopes + STR(Numes, 6)             TAG Nota
                INDEX ON ContaOs + Emps + Dopes + STR(Numes, 6)           TAG Origem
                INDEX ON ContaDs + Emps + Dopes + STR(Numes, 6)           TAG Destino
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CriarCursor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Selecionar - seleciona notas fiscais conforme filtros e popula csOperacoes
    * par_cEmps          : empresa (char 3)
    * par_dDtIni         : data inicial
    * par_dDtFin         : data final
    * par_lNaoProcesados : .T. = nao processadas, .F. = ja processadas
    * par_cDir           : diretorio de gravacao do arquivo
    * Retorno: .T. se OK, .F. se erro/validacao falhou
    *--------------------------------------------------------------------------
    PROCEDURE Selecionar(par_cEmps, par_dDtIni, par_dDtFin, par_lNaoProcesados, par_cDir)
        LOCAL loc_lSucesso, loc_cSQL, loc_cDtFim, loc_cNotIn, loc_cProdutos, ;
              loc_cErr, loc_lNaoProcesados, loc_cEmps, loc_dDtIni, loc_dDtFin, ;
              loc_cDir, loc_cIdChave, loc_dEmis, loc_oErro

        loc_lSucesso       = .F.
        loc_lNaoProcesados = IIF(TYPE("par_lNaoProcesados") = "L", par_lNaoProcesados, .T.)
        loc_cEmps          = PADR(ALLTRIM(IIF(TYPE("par_cEmps") = "C", par_cEmps, "")), 3)
        loc_dDtIni         = IIF(TYPE("par_dDtIni") = "D", par_dDtIni, DATE())
        loc_dDtFin         = IIF(TYPE("par_dDtFin") = "D", par_dDtFin, DATE())
        loc_cDir           = IIF(TYPE("par_cDir") = "C", par_cDir, "C:\")

        *-- Confirmacao para reprocessar notas ja processadas
        IF !loc_lNaoProcesados
            IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Notas Fiscais J" + ;
                            CHR(225) + " Processadas Anteriormente?" + CHR(13) + ;
                            "Este Processo Poder" + CHR(225) + " Sobrepor Registros no Arquivo Gerado e Pode" + ;
                            CHR(13) + "Causar Duplicidade ou Mesmo Cancelamento das Notas Anteriores!!!")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Validacoes
        IF EMPTY(loc_dDtIni)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!")
            RETURN .F.
        ENDIF
        IF EMPTY(loc_dDtFin)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!")
            RETURN .F.
        ENDIF
        IF loc_dDtFin < loc_dDtIni
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
            RETURN .F.
        ENDIF
        IF EMPTY(loc_cEmps)
            MsgAviso("Empresa Inv" + CHR(225) + "lida!!!")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(loc_cDir)) .OR. !DIRECTORY(loc_cDir)
            MsgAviso("Pasta do Arquivo Inv" + CHR(225) + "lida!!!")
            RETURN .F.
        ENDIF

        TRY
            *-- Monta data final com horario 23:59:59
            loc_cDtFim = "'" + PADL(TRANSFORM(YEAR(loc_dDtFin)), 4, "0") + "-" + ;
                         PADL(TRANSFORM(MONTH(loc_dDtFin)), 2, "0") + "-" + ;
                         PADL(TRANSFORM(DAY(loc_dDtFin)), 2, "0") + " 23:59:59'"

            *-- Carrega dados da empresa
            IF USED("LocalEmp")
                USE IN LocalEmp
            ENDIF
            loc_cSQL = "SELECT TpEmps, Cgcs, IMs, Empofs, CodOpers, Dirs " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(loc_cEmps)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalEmp") < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao carregar empresa.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Salva dados da empresa nas propriedades do BO
            IF USED("LocalEmp") .AND. !EOF("LocalEmp")
                SELECT LocalEmp
                THIS.this_nTpEmps   = NVL(LocalEmp.TpEmps, 0)
                THIS.this_cCgcs     = NVL(LocalEmp.Cgcs, "")
                THIS.this_cIMs      = NVL(LocalEmp.IMs, "")
                THIS.this_nEmpofs   = NVL(LocalEmp.Empofs, 0)
                THIS.this_cCodOpers = NVL(LocalEmp.CodOpers, "")
                THIS.this_cDirsEmp  = NVL(LocalEmp.Dirs, "")
            ENDIF

            *-- Monta flag NOT IN para filtro de ja processados
            loc_cNotIn = IIF(loc_lNaoProcesados, " NOT", "")

            *-- Carrega notas fiscais de servico
            IF USED("LocalNotas")
                USE IN LocalNotas
            ENDIF
            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Operas, a.Nfis, a.Series, " + ;
                       "a.Emis, b.Obses, a.Cancelas, a.TotProds, a.VCofins, a.TpTribSers, " + ;
                       "a.PrestServs, a.CodBenefs, a.CodSrvFis, a.VDeducoes, a.VDscConds, " + ;
                       "a.VDscIConds, a.OutRetens, a.ISSRetidos, a.TipoNFs, a.VCsll, " + ;
                       "a.VInss, a.VIrf, a.VPis, a.VTotIss, b.Usuars, b.ContaOs, b.ContaDs, " + ;
                       "c.TpClis, c.Cpfs, c.InscMuns, c.Rgs, c.Razaos, c.RClis, c.Endes, " + ;
                       "c.Nums, c.Compls, c.Bairs, c.Cidas, c.Estas, c.Ceps, c.Tel1s, " + ;
                       "c.eMails, c.OptSimples " + ;
                       "FROM SigMvNfi a, SigMvCab b, SigCdCli c, SigCdSer d " + ;
                       "WHERE a.Emis BETWEEN " + FormatarDataSQL(loc_dDtIni) + ;
                       " AND " + loc_cDtFim + " " + ;
                       "AND a.Emps = " + EscaparSQL(loc_cEmps) + " " + ;
                       "AND a.EmpDopNums = b.EmpDopNums " + ;
                       "AND b.ContaDs = c.IClis " + ;
                       "AND LEFT(a.Series, 3) = d.Cods " + ;
                       "AND d.TpServicos IN (1, 3) " + ;
                       "AND a.EmpDopNums" + loc_cNotIn + ;
                       " IN (SELECT o.EmpDopNums FROM SigPcOoL o WHERE o.Tipos = 'SIGPRNSE')"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalNotas") < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao carregar notas.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verifica se encontrou dados
            SELECT LocalNotas
            GO TOP IN LocalNotas
            IF EOF("LocalNotas")
                MsgInfo("N" + CHR(227) + "o Foram Encontrados Dados Com os Filtros Informados!!!")
            ELSE
                *-- Recria cursor de operacoes
                THIS.CriarCursorOperacoes()

                *-- Processa cada nota: valida + insere em csOperacoes + registra em SigPcOoL
                SELECT LocalNotas
                SCAN
                loc_cErr = ""

                IF EMPTY(ALLTRIM(LocalNotas.Razaos)) .AND. EMPTY(ALLTRIM(LocalNotas.RClis))
                    loc_cErr = loc_cErr + "O Nome e a Raz" + CHR(227) + "o Social da Conta " + CHR(34) + ;
                               ALLTRIM(LocalNotas.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Series))
                    loc_cErr = loc_cErr + "A S" + CHR(233) + "rie da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.NFis))
                    loc_cErr = loc_cErr + "O N" + CHR(250) + "mero da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Ceps))
                    loc_cErr = loc_cErr + "O CEP da Conta " + CHR(34) + ALLTRIM(LocalNotas.ContaOs) + ;
                               CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Endes))
                    loc_cErr = loc_cErr + "O Endere" + CHR(231) + "o da Conta " + CHR(34) + ALLTRIM(LocalNotas.ContaOs) + ;
                               CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Bairs))
                    loc_cErr = loc_cErr + "O Bairro da Conta " + CHR(34) + ALLTRIM(LocalNotas.ContaOs) + ;
                               CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Cidas))
                    loc_cErr = loc_cErr + "A Cidade da Conta " + CHR(34) + ALLTRIM(LocalNotas.ContaOs) + ;
                               CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Estas))
                    loc_cErr = loc_cErr + "A UF da Conta " + CHR(34) + ALLTRIM(LocalNotas.ContaOs) + ;
                               CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF ISNULL(LocalNotas.Emis) .OR. EMPTY(LocalNotas.Emis)
                    loc_cErr = loc_cErr + "A Data de Emiss" + CHR(227) + "o da Nota Est" + CHR(225) + ;
                               " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(STRTRAN(NVL(LocalNotas.CodSrvFis, ""), ".", "")))
                    loc_cErr = loc_cErr + "O C" + CHR(243) + "digo do Servi" + CHR(231) + "o Municipal da Nota Est" + ;
                               CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(NVL(LocalNotas.TotProds, 0))
                    loc_cErr = loc_cErr + "O Valor dos Servi" + CHR(231) + "os da Nota Est" + CHR(225) + ;
                               " Zerado;" + CHR(13)
                ENDIF

                *-- Converte data de emissao
                IF ISNULL(LocalNotas.Emis)
                    loc_dEmis = {}
                ELSE
                    loc_dEmis = TTOD(LocalNotas.Emis)
                ENDIF

                *-- Insere no cursor local csOperacoes
                INSERT INTO csOperacoes (SelImp, Emps, Dopes, Numes, Datas, Valos, ;
                                        Notas, Usuars, ContaOs, ContaDs, Opers, Erros) ;
                    VALUES (EMPTY(loc_cErr), ;
                            NVL(LocalNotas.Emps, ""), ;
                            NVL(LocalNotas.Dopes, ""), ;
                            NVL(LocalNotas.Numes, 0), ;
                            loc_dEmis, ;
                            NVL(LocalNotas.TotProds, 0), ;
                            NVL(LocalNotas.NFis, ""), ;
                            NVL(LocalNotas.Usuars, ""), ;
                            NVL(LocalNotas.ContaOs, ""), ;
                            NVL(LocalNotas.ContaDs, ""), ;
                            NVL(LocalNotas.Operas, ""), ;
                            loc_cErr)

                *-- Registra processamento no SQL Server (SigPcOoL)
                loc_cProdutos = IIF(loc_lNaoProcesados, "", ;
                                    "LAN" + CHR(199) + "AMENTO REFEITO")
                loc_cIdChave  = LEFT(fUniqueIds(), 20)

                loc_cSQL = "INSERT INTO SigPcOoL " + ;
                           "(Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, " + ;
                           "Datas, Usuars, Produtos, Processos, cIdChaves, EmpDopNums, EdnDests) " + ;
                           "VALUES ('SIGPRNSE', " + ;
                           EscaparSQL(ALLTRIM(NVL(LocalNotas.Emps, ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(LocalNotas.Dopes, ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(LocalNotas.Numes, 0), 0) + ", " + ;
                           "'', '', 0, GETDATE(), " + ;
                           EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                           EscaparSQL(loc_cProdutos) + ", " + ;
                           "'', " + ;
                           EscaparSQL(loc_cIdChave) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(LocalNotas.Emps, "")) + ;
                                      ALLTRIM(NVL(LocalNotas.Dopes, "")) + ;
                                      STR(NVL(LocalNotas.Numes, 0), 6)) + ", " + ;
                           "'')"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao registrar em SigPcOoL.", "Erro")
                    *-- Continua processando as demais notas
                ENDIF

                SELECT LocalNotas
                ENDSCAN

                *-- Armazena parametros nas propriedades do BO para uso em Processamento
                THIS.this_cEmps   = loc_cEmps
                THIS.this_dDtIni  = loc_dDtIni
                THIS.this_dDtFin  = loc_dDtFin
                THIS.this_cDirs   = loc_cDir

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Selecionar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoRJ - gera arquivo TXT NFS-e para o municipio do Rio de Janeiro
    * Versao 3.1 - Prefeitura Municipal da Cidade do Rio de Janeiro
    * Retorno: .T. se arquivo gerado com sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoRJ()
        LOCAL loc_lSucesso, loc_cArq, loc_cDir, loc_lcArq, loc_lcStr, loc_lcFim, ;
              loc_lcTip, loc_lcCpf, loc_lcIms, loc_lcDtI, loc_lcDtF, ;
              loc_lnR20, loc_lnR40, loc_lnTsr, loc_lnTdd, loc_lnTdc, loc_lnTdi, ;
              loc_lcSer, loc_lcNot, loc_lcEmi, loc_lcSts, ;
              loc_lcTpT, loc_lcCpW, loc_lcImT, loc_lcIeT, loc_lcNmT, ;
              loc_lcEdT, loc_lcTeT, loc_lcNeT, loc_lcCeT, loc_lcBaT, ;
              loc_lcCdT, loc_lcUfT, loc_lcCcT, loc_lcT1T, loc_lcEmT, ;
              loc_lcTts, loc_lcCps, loc_lcUps, loc_lcRet, loc_lcOSN, loc_lcInC, ;
              loc_lcCsF, loc_lcCdB, loc_lcCsM, loc_lnAlq, loc_lcAlq, ;
              loc_lcVal, loc_lcVde, loc_lcVds, loc_lcVdi, loc_lcCof, loc_lcCsl, ;
              loc_lcIns, loc_lcIrf, loc_lcPis, loc_lcOut, loc_lcIss, loc_lcRtd, ;
              loc_lcObs, loc_lcNdt, loc_lcTsr, loc_lcTdd, loc_lcTdc, loc_lcTdi, ;
              loc_lcTpn, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Carregando notas de saida (csOperacoes selecionadas)
            SELECT a.* ;
              FROM LocalNotas a, csOperacoes b ;
             WHERE a.Operas = "S" AND ;
                   a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                   b.SelImp ;
              INTO CURSOR LocalNfS READWRITE

            *-- Carregando notas de entrada
            SELECT a.* ;
              FROM LocalNotas a, csOperacoes b ;
             WHERE a.Operas = "E" AND ;
                   a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                   b.SelImp ;
              INTO CURSOR LocalNfE READWRITE

            *-- Totalizadores para o registro 90
            loc_lnR20 = 0
            loc_lnR40 = 0
            loc_lnTsr = 0
            loc_lnTdd = 0
            loc_lnTdc = 0
            loc_lnTdi = 0

            loc_lcFim = CHR(13) + CHR(10)

            loc_lcTip = IIF(THIS.this_nTpEmps = 1, "1", "2")
            loc_lcCpf = PADL(CHRTRAN(THIS.this_cCgcs, ".-/ ", ""), 14, "0")
            loc_lcIms = PADL(CHRTRAN(THIS.this_cIMs,  ".-/ ", ""), 15, "0")
            loc_lcDtI = DTOS(THIS.this_dDtIni)
            loc_lcDtF = DTOS(THIS.this_dDtFin)

            loc_cDir  = ALLTRIM(THIS.this_cDirs)
            loc_lcArq = loc_cDir + ALLTRIM(loc_lcIms) + "_" + ;
                        LEFT(CHRTRAN(TTOC(DATETIME()), "/: ", "--_"), 16) + ".TXT"

            =STRTOFILE("", loc_lcArq, .F.)

            IF !FILE(loc_lcArq)
                MsgErro("O Arquivo " + CHR(34) + loc_lcArq + CHR(34) + " N" + CHR(227) + "o Pode Ser Criado!!!" + ;
                        CHR(13) + "Verifique Suas Permiss" + CHR(245) + "es de Cria" + CHR(231) + ;
                        CHR(227) + "o e Tente Novamente!!!", "Erro na Cria" + CHR(231) + CHR(227) + "o do Arquivo")
                loc_lSucesso = .F.
            ENDIF

            *-- Registro Tipo 10 - Cabecalho
            loc_lcStr = "10" + ;
                        "003" + ;
                        loc_lcTip + ;
                        loc_lcCpf + ;
                        loc_lcIms + ;
                        loc_lcDtI + ;
                        loc_lcDtF + ;
                        loc_lcFim
            =STRTOFILE(loc_lcStr, loc_lcArq, .T.)

            *-- Processando notas de saida (Registro Tipo 20)
            SELECT LocalNfS
            SCAN
                loc_lcSer = PADR(ALLTRIM(LocalNfS.Series), 5)
                loc_lcNot = PADL(ALLTRIM(LocalNfS.NFis), 15, "0")
                loc_lcEmi = DTOS(LocalNfS.Emis)
                loc_lcSts = IIF(LocalNfS.Cancelas, "2", "1")

                loc_lcTpT = PADL(NVL(LocalNfS.TpClis, "0"), 1, "0")
                loc_lcTpT = IIF(loc_lcTpT = "0", "3", loc_lcTpT)
                loc_lcCpW = PADL(CHRTRAN(NVL(LocalNfS.Cpfs, ""), ".-/ ", ""), 14, "0")
                IF loc_lcCpW = "00000000000000"
                    loc_lcTpT = "3"
                ENDIF
                loc_lcImT = PADL(CHRTRAN(NVL(LocalNfS.InscMuns, ""), ".-/ ", ""), 15, "0")
                loc_lcIeT = PADL(CHRTRAN(NVL(LocalNfS.Rgs, ""),      ".-/ ", ""), 15, "0")
                loc_lcNmT = ALLTRIM(NVL(LocalNfS.Razaos, ""))
                loc_lcNmT = PADR(IIF(EMPTY(loc_lcNmT), ALLTRIM(NVL(LocalNfS.RClis, "")), loc_lcNmT), 115)
                loc_lcEdT = PADR(ALLTRIM(NVL(LocalNfS.Endes, "")), 125)
                loc_lcTeT = ALLTRIM(LEFT(loc_lcEdT, AT(" ", loc_lcEdT)))
                loc_lcTeT = PADR(IIF(EMPTY(loc_lcTeT), "RUA", loc_lcTeT), 3)
                loc_lcNeT = PADR(ALLTRIM(NVL(LocalNfS.Nums, "")), 10)
                loc_lcCeT = PADR(ALLTRIM(NVL(LocalNfS.Compls, "")), 60)
                loc_lcBaT = PADR(ALLTRIM(NVL(LocalNfS.Bairs, "")), 72)
                loc_lcCdT = PADR(ALLTRIM(NVL(LocalNfS.Cidas, "")), 50)
                loc_lcUfT = PADR(ALLTRIM(NVL(LocalNfS.Estas, "")), 2)
                loc_lcCcT = PADL(CHRTRAN(NVL(LocalNfS.Ceps, ""), "-", ""), 8, "0")
                loc_lcT1T = PADR(CHRTRAN(NVL(LocalNfS.Tel1s, ""), ".-", ""), 11)
                loc_lcEmT = PADR(ALLTRIM(NVL(LocalNfS.eMails, "")), 80)

                loc_lcTts = PADL(TRANSFORM(NVL(LocalNfS.TpTribSers, 0)), 2, "0")
                loc_lcCps = loc_lcCdT
                loc_lcUps = loc_lcUfT
                IF USED("LocalUfs") .AND. SEEK(NVL(LocalNfS.PrestServs, ""), "LocalUfs", "Codigos")
                    loc_lcCps = PADR(UPPER(ALLTRIM(NVL(LocalUfs.Descs, ""))), 50)
                    loc_lcUps = PADR(UPPER(ALLTRIM(NVL(LocalUfs.Estados, ""))), 2)
                ENDIF

                loc_lcRet = PADL(TRANSFORM(NVL(THIS.this_nEmpofs, 0)), 2, "0")
                loc_lcOSN = IIF(NVL(LocalNfS.OptSimples, "") = "S", "1", "0")
                loc_lcInC = IIF(INLIST(loc_lcTts, "03", "04"), "1", "0")
                loc_lcCsF = PADR(NVL(THIS.this_cCodOpers, ""), 4)
                loc_lcCdB = PADL(ALLTRIM(NVL(LocalNfS.CodBenefs, "")), 3, "0")
                loc_lcCsM = PADR(STRTRAN(NVL(LocalNfS.CodSrvFis, ""), ".", ""), 6)

                *-- Valores
                loc_lnAlq = IIF(NVL(LocalNfS.TotProds, 0) = 0, 0, ;
                                (NVL(LocalNfS.VTotIss, 0) / NVL(LocalNfS.TotProds, 1)) * 100)
                loc_lcAlq = PADL(CHRTRAN(STR(loc_lnAlq, 9, 2), ". ", ""), 5, "0")
                loc_lcVal = PADL(CHRTRAN(STR(NVL(LocalNfS.TotProds, 0),   20, 2), ". ", ""), 15, "0")
                loc_lcVde = PADL(CHRTRAN(STR(NVL(LocalNfS.VDeducoes, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcVds = PADL(CHRTRAN(STR(NVL(LocalNfS.VDscConds, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcVdi = PADL(CHRTRAN(STR(NVL(LocalNfS.VDscIConds, 0), 20, 2), ". ", ""), 15, "0")
                loc_lcCof = PADL(CHRTRAN(STR(NVL(LocalNfS.VCofins, 0),    20, 2), ". ", ""), 15, "0")
                loc_lcCsl = PADL(CHRTRAN(STR(NVL(LocalNfS.VCsll, 0),      20, 2), ". ", ""), 15, "0")
                loc_lcIns = PADL(CHRTRAN(STR(NVL(LocalNfS.VInss, 0),      20, 2), ". ", ""), 15, "0")
                loc_lcIrf = PADL(CHRTRAN(STR(NVL(LocalNfS.VIrf, 0),       20, 2), ". ", ""), 15, "0")
                loc_lcPis = PADL(CHRTRAN(STR(NVL(LocalNfS.VPis, 0),       20, 2), ". ", ""), 15, "0")
                loc_lcOut = PADL(CHRTRAN(STR(NVL(LocalNfS.OutRetens, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcIss = PADL(CHRTRAN(STR(NVL(LocalNfS.VTotIss, 0),    20, 2), ". ", ""), 15, "0")
                loc_lcRtd = IIF(NVL(LocalNfS.ISSRetidos, 0) = 1, "1", "0")
                loc_lcObs = ALLTRIM(STRTRAN(STRTRAN(NVL(LocalNfS.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_lcObs = IIF(EMPTY(loc_lcObs), "Servi" + CHR(231) + "os Prestados", loc_lcObs)

                *-- Acumula totalizadores
                loc_lnTsr = loc_lnTsr + NVL(LocalNfS.TotProds, 0)
                loc_lnTdd = loc_lnTdd + NVL(LocalNfS.VDeducoes, 0)
                loc_lnTdc = loc_lnTdc + NVL(LocalNfS.VDscConds, 0)
                loc_lnTdi = loc_lnTdi + NVL(LocalNfS.VDscIConds, 0)

                *-- Registro Tipo 20 - Detalhe saida
                loc_lcStr = "20" + ;
                            "0" + ;
                            loc_lcSer + ;
                            loc_lcNot + ;
                            loc_lcEmi + ;
                            loc_lcSts + ;
                            loc_lcTpT + ;
                            loc_lcCpW + ;
                            loc_lcImT + ;
                            loc_lcIeT + ;
                            loc_lcNmT + ;
                            loc_lcTeT + ;
                            loc_lcEdT + ;
                            loc_lcNeT + ;
                            loc_lcCeT + ;
                            loc_lcBaT + ;
                            loc_lcCdT + ;
                            loc_lcUfT + ;
                            loc_lcCcT + ;
                            loc_lcT1T + ;
                            loc_lcEmT + ;
                            loc_lcTts + ;
                            loc_lcCps + ;
                            loc_lcUps + ;
                            loc_lcRet + ;
                            loc_lcOSN + ;
                            loc_lcInC + ;
                            loc_lcCsF + ;
                            SPACE(11) + ;
                            loc_lcCdB + ;
                            loc_lcCsM + ;
                            loc_lcAlq + ;
                            loc_lcVal + ;
                            loc_lcVde + ;
                            loc_lcVds + ;
                            loc_lcVdi + ;
                            loc_lcCof + ;
                            loc_lcCsl + ;
                            loc_lcIns + ;
                            loc_lcIrf + ;
                            loc_lcPis + ;
                            loc_lcOut + ;
                            loc_lcIss + ;
                            loc_lcRtd + ;
                            loc_lcEmi + ;
                            SPACE(15) + ;
                            SPACE(15) + ;
                            SPACE(05) + ;
                            PADL("", 15, "0") + ;
                            SPACE(30) + ;
                            loc_lcObs + ;
                            loc_lcFim

                loc_lnR20 = loc_lnR20 + 1
                =STRTOFILE(loc_lcStr, loc_lcArq, .T.)
            ENDSCAN

            *-- Processando notas de entrada (Registro Tipo 40)
            SELECT LocalNfE
            SCAN
                loc_lcTpn = PADL(ALLTRIM(TRANSFORM(NVL(LocalNfE.TipoNFs, 0))), 2, "0")
                loc_lcSer = PADR(ALLTRIM(NVL(LocalNfE.Series, "")), 5)
                loc_lcNot = PADL(ALLTRIM(NVL(LocalNfE.NFis, "")), 15, "0")
                loc_lcEmi = DTOS(LocalNfE.Emis)
                loc_lcSts = IIF(LocalNfE.Cancelas, "2", "1")

                loc_lcTpT = PADL(NVL(LocalNfE.TpClis, "0"), 1, "0")
                loc_lcTpT = IIF(loc_lcTpT = "0", "3", loc_lcTpT)
                loc_lcCpW = PADL(CHRTRAN(NVL(LocalNfE.Cpfs, ""), ".-/ ", ""), 14, "0")
                IF loc_lcCpW = "00000000000000"
                    loc_lcTpT = "3"
                ENDIF
                loc_lcImT = PADL(CHRTRAN(NVL(LocalNfE.InscMuns, ""), ".-/ ", ""), 15, "0")
                loc_lcIeT = PADL(CHRTRAN(NVL(LocalNfE.Rgs, ""),      ".-/ ", ""), 15, "0")
                loc_lcNmT = ALLTRIM(NVL(LocalNfE.Razaos, ""))
                loc_lcNmT = PADR(IIF(EMPTY(loc_lcNmT), ALLTRIM(NVL(LocalNfE.RClis, "")), loc_lcNmT), 115)
                loc_lcEdT = PADR(ALLTRIM(NVL(LocalNfE.Endes, "")), 125)
                loc_lcTeT = ALLTRIM(LEFT(loc_lcEdT, AT(" ", loc_lcEdT)))
                loc_lcTeT = PADR(IIF(EMPTY(loc_lcTeT), "RUA", loc_lcTeT), 3)
                loc_lcNeT = PADR(ALLTRIM(NVL(LocalNfE.Nums, "")), 10)
                loc_lcCeT = PADR(ALLTRIM(NVL(LocalNfE.Compls, "")), 60)
                loc_lcBaT = PADR(ALLTRIM(NVL(LocalNfE.Bairs, "")), 72)
                loc_lcCdT = PADR(ALLTRIM(NVL(LocalNfE.Cidas, "")), 50)
                loc_lcUfT = PADR(ALLTRIM(NVL(LocalNfE.Estas, "")), 2)
                loc_lcCcT = PADL(CHRTRAN(NVL(LocalNfE.Ceps, ""), "-", ""), 8, "0")
                loc_lcT1T = PADR(CHRTRAN(NVL(LocalNfE.Tel1s, ""), ".-", ""), 11)
                loc_lcEmT = PADR(ALLTRIM(NVL(LocalNfE.eMails, "")), 80)

                loc_lcTts = PADL(TRANSFORM(NVL(LocalNfE.TpTribSers, 0)), 2, "0")
                loc_lcOSN = IIF(NVL(LocalNfE.OptSimples, "") = "S", "1", "0")
                loc_lcCsF = PADR(NVL(THIS.this_cCodOpers, ""), 4)
                loc_lcCdB = PADL(ALLTRIM(NVL(LocalNfE.CodBenefs, "")), 3, "0")
                loc_lcCsM = PADR(STRTRAN(NVL(LocalNfE.CodSrvFis, ""), ".", ""), 6)

                *-- Valores
                loc_lnAlq = IIF(NVL(LocalNfE.TotProds, 0) = 0, 0, ;
                                (NVL(LocalNfE.VTotIss, 0) / NVL(LocalNfE.TotProds, 1)) * 100)
                loc_lcAlq = PADL(CHRTRAN(STR(loc_lnAlq, 9, 2), ". ", ""), 5, "0")
                loc_lcVal = PADL(CHRTRAN(STR(NVL(LocalNfE.TotProds, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcVde = PADL(CHRTRAN(STR(NVL(LocalNfE.VDeducoes, 0), 20, 2), ". ", ""), 15, "0")
                loc_lcIss = PADL(CHRTRAN(STR(NVL(LocalNfE.VTotIss, 0),   20, 2), ". ", ""), 15, "0")
                loc_lcRtd = IIF(NVL(LocalNfE.ISSRetidos, 0) = 1, "1", "0")
                loc_lcObs = ALLTRIM(STRTRAN(STRTRAN(NVL(LocalNfE.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_lcObs = IIF(EMPTY(loc_lcObs), "Servi" + CHR(231) + "os Prestados", loc_lcObs)

                *-- Acumula totalizadores
                loc_lnTsr = loc_lnTsr + NVL(LocalNfE.TotProds, 0)
                loc_lnTdd = loc_lnTdd + NVL(LocalNfE.VDeducoes, 0)

                *-- Registro Tipo 40 - Declaracao notas convencionais recebidas
                loc_lcStr = "40" + ;
                            loc_lcTpn + ;
                            loc_lcSer + ;
                            loc_lcNot + ;
                            loc_lcEmi + ;
                            loc_lcSts + ;
                            loc_lcTpT + ;
                            loc_lcCpW + ;
                            loc_lcImT + ;
                            loc_lcIeT + ;
                            loc_lcNmT + ;
                            loc_lcTeT + ;
                            loc_lcEdT + ;
                            loc_lcNeT + ;
                            loc_lcCeT + ;
                            loc_lcBaT + ;
                            loc_lcCdT + ;
                            loc_lcUfT + ;
                            loc_lcCcT + ;
                            loc_lcT1T + ;
                            loc_lcEmT + ;
                            loc_lcTts + ;
                            SPACE(54) + ;
                            loc_lcOSN + ;
                            loc_lcCsF + ;
                            SPACE(11) + ;
                            loc_lcCdB + ;
                            loc_lcCsM + ;
                            loc_lcAlq + ;
                            loc_lcVal + ;
                            loc_lcVde + ;
                            SPACE(30) + ;
                            loc_lcIss + ;
                            loc_lcRtd + ;
                            loc_lcEmi + ;
                            SPACE(15) + ;
                            SPACE(15) + ;
                            loc_lcObs + ;
                            loc_lcFim

                loc_lnR40 = loc_lnR40 + 1
                =STRTOFILE(loc_lcStr, loc_lcArq, .T.)
            ENDSCAN

            *-- Registro Tipo 90 - Rodape
            loc_lcNdt = PADL(CHRTRAN(STR(loc_lnR20 + loc_lnR40, 20, 0), ". ", ""), 8, "0")
            loc_lcTsr = PADL(CHRTRAN(STR(loc_lnTsr, 20, 2), ". ", ""), 15, "0")
            loc_lcTdd = PADL(CHRTRAN(STR(loc_lnTdd, 20, 2), ". ", ""), 15, "0")
            loc_lcTdc = PADL(CHRTRAN(STR(loc_lnTdc, 20, 2), ". ", ""), 15, "0")
            loc_lcTdi = PADL(CHRTRAN(STR(loc_lnTdi, 20, 2), ". ", ""), 15, "0")

            loc_lcStr = "90" + ;
                        loc_lcNdt + ;
                        loc_lcTsr + ;
                        loc_lcTdd + ;
                        loc_lcTdc + ;
                        loc_lcTdi + ;
                        loc_lcFim
            =STRTOFILE(loc_lcStr, loc_lcArq, .T.)

            MsgInfo("O Arquivo " + CHR(34) + loc_lcArq + CHR(34) + " Foi Gerado!" + CHR(13) + ;
                    "Notas de Sa" + CHR(237) + "da: " + ALLTRIM(STR(loc_lnR20, 10)) + CHR(13) + ;
                    "Notas de Entrada: " + ALLTRIM(STR(loc_lnR40, 10)))

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GerarArquivoRJ")
        ENDTRY

        IF USED("LocalNfS")
            USE IN LocalNfS
        ENDIF
        IF USED("LocalNfE")
            USE IN LocalNfE
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoSP - gera arquivo TXT NFS-e para o municipio de Sao Paulo
    * Versao 3.4 - Prefeitura Municipal da Cidade de Sao Paulo
    * Retorno: .T. se arquivo gerado com sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoSP()
        LOCAL loc_lSucesso, loc_cDir, loc_lcArq, loc_lcStr, loc_lcFim, ;
              loc_lcTip, loc_lcCpf, loc_lcIms, loc_lcDtI, loc_lcDtF, ;
              loc_lnRg2, loc_lnTsr, loc_lnTdd, ;
              loc_lcSer, loc_lcNot, loc_lcEmi, loc_lcTts, ;
              loc_lcTpT, loc_lcCpW, loc_lcImT, loc_lcIeT, loc_lcNmT, ;
              loc_lcEdT, loc_lcTeT, loc_lcNeT, loc_lcCeT, loc_lcBaT, ;
              loc_lcCdT, loc_lcUfT, loc_lcCcT, loc_lcEmT, ;
              loc_lcVal, loc_lcVde, loc_lcCsM, loc_lcMps, ;
              loc_lnAlq, loc_lcAlq, loc_lcRtd, ;
              loc_lcPis, loc_lcCof, loc_lcIns, loc_lcIrf, loc_lcCsl, ;
              loc_lcIss, loc_lcObs, ;
              loc_lcNdt, loc_lcTsr, loc_lcTdd, ;
              loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Carregando notas de saida
            SELECT a.* ;
              FROM LocalNotas a, csOperacoes b ;
             WHERE a.Operas = "S" AND ;
                   a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                   b.SelImp ;
              INTO CURSOR LocalNfS READWRITE

            *-- Totalizadores para registro 9
            loc_lnRg2 = 0
            loc_lnTsr = 0
            loc_lnTdd = 0

            loc_lcFim = CHR(13) + CHR(10)

            loc_lcTip = IIF(THIS.this_nTpEmps = 1, "1", "2")
            loc_lcCpf = PADL(CHRTRAN(THIS.this_cCgcs, ".-/ ", ""), 14, "0")
            loc_lcIms = PADL(CHRTRAN(THIS.this_cIMs,  ".-/ ", ""),  8, "0")
            loc_lcDtI = DTOS(THIS.this_dDtIni)
            loc_lcDtF = DTOS(THIS.this_dDtFin)

            loc_cDir  = ALLTRIM(THIS.this_cDirs)
            loc_lcArq = loc_cDir + ALLTRIM(loc_lcIms) + "_" + ;
                        LEFT(CHRTRAN(TTOC(DATETIME()), "/: ", "--_"), 16) + ".TXT"

            =STRTOFILE("", loc_lcArq, .F.)

            IF !FILE(loc_lcArq)
                MsgErro("O Arquivo " + CHR(34) + loc_lcArq + CHR(34) + " N" + CHR(227) + "o Pode Ser Criado!!!" + ;
                        CHR(13) + "Verifique Suas Permiss" + CHR(245) + "es de Cria" + CHR(231) + ;
                        CHR(227) + "o e Tente Novamente!!!", "Erro na Cria" + CHR(231) + CHR(227) + "o do Arquivo")
                loc_lSucesso = .F.
            ENDIF

            *-- Registro Tipo 1 - Cabecalho SP
            loc_lcStr = "1" + ;
                        "002" + ;
                        loc_lcIms + ;
                        loc_lcDtI + ;
                        loc_lcDtF + ;
                        loc_lcFim
            =STRTOFILE(loc_lcStr, loc_lcArq, .T.)

            *-- Processando notas de saida (Registro Tipo 6)
            SELECT LocalNfS
            SCAN
                loc_lcTpT = PADL(NVL(LocalNfS.TpClis, "0"), 1, "0")
                loc_lcTpT = IIF(loc_lcTpT = "0", "3", loc_lcTpT)
                loc_lcCpW = PADL(CHRTRAN(NVL(LocalNfS.Cpfs, ""), ".-/ ", ""), 14, "0")
                IF loc_lcCpW = "00000000000000"
                    loc_lcTpT = "3"
                ENDIF
                loc_lcImT = PADL(CHRTRAN(NVL(LocalNfS.InscMuns, ""), ".-/ ", ""), 8, "0")
                loc_lcIeT = PADL(CHRTRAN(NVL(LocalNfS.Rgs, ""),      ".-/ ", ""), 12, "0")
                loc_lcNmT = ALLTRIM(NVL(LocalNfS.Razaos, ""))
                loc_lcNmT = PADR(IIF(EMPTY(loc_lcNmT), ALLTRIM(NVL(LocalNfS.RClis, "")), loc_lcNmT), 75)
                loc_lcEdT = PADR(ALLTRIM(NVL(LocalNfS.Endes, "")), 50)
                loc_lcTeT = ALLTRIM(LEFT(loc_lcEdT, AT(" ", loc_lcEdT)))
                loc_lcTeT = PADR(IIF(EMPTY(loc_lcTeT), "RUA", loc_lcTeT), 3)
                loc_lcNeT = PADR(ALLTRIM(NVL(LocalNfS.Nums, "")), 10)
                loc_lcCeT = PADR(ALLTRIM(NVL(LocalNfS.Compls, "")), 30)
                loc_lcBaT = PADR(ALLTRIM(NVL(LocalNfS.Bairs, "")), 30)
                loc_lcCdT = PADR(ALLTRIM(NVL(LocalNfS.Cidas, "")), 50)
                loc_lcUfT = PADR(ALLTRIM(NVL(LocalNfS.Estas, "")), 2)
                loc_lcCcT = PADL(CHRTRAN(NVL(LocalNfS.Ceps, ""), "-", ""), 8, "0")
                loc_lcEmT = PADR(ALLTRIM(NVL(LocalNfS.eMails, "")), 75)

                loc_lcSer = PADR(ALLTRIM(NVL(LocalNfS.Series, "")), 5)
                loc_lcNot = PADL(ALLTRIM(NVL(LocalNfS.NFis, "")), 12, "0")
                loc_lcEmi = DTOS(LocalNfS.Emis)

                DO CASE
                    CASE NVL(LocalNfS.TpTribSers, 0) = 1
                        loc_lcTts = "T"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 2
                        loc_lcTts = "I"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 3
                        loc_lcTts = "F"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 4
                        loc_lcTts = "C"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 5
                        loc_lcTts = "E"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 6
                        loc_lcTts = "J"
                    OTHERWISE
                        loc_lcTts = "T"
                ENDCASE

                loc_lcVal = PADL(CHRTRAN(STR(NVL(LocalNfS.TotProds, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcVde = PADL(CHRTRAN(STR(NVL(LocalNfS.VDeducoes, 0), 20, 2), ". ", ""), 15, "0")
                loc_lcCsM = PADR(STRTRAN(NVL(LocalNfS.CodSrvFis, ""), ".", ""), 5)
                loc_lcMps = PADL(ALLTRIM(NVL(LocalNfS.PrestServs, "")), 7, "0")

                loc_lnAlq = IIF(NVL(LocalNfS.TotProds, 0) = 0, 0, ;
                                (NVL(LocalNfS.VTotIss, 0) / NVL(LocalNfS.TotProds, 1)) * 100)
                loc_lcAlq = PADL(CHRTRAN(STR(loc_lnAlq, 9, 2), ". ", ""), 4, "0")
                loc_lcRtd = PADR(IIF(NVL(LocalNfS.ISSRetidos, 0) = 1, "2", "1"), 1)
                loc_lcPis = PADL(CHRTRAN(STR(NVL(LocalNfS.VPis, 0),     20, 2), ". ", ""), 15, "0")
                loc_lcCof = PADL(CHRTRAN(STR(NVL(LocalNfS.VCofins, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcIns = PADL(CHRTRAN(STR(NVL(LocalNfS.VInss, 0),    20, 2), ". ", ""), 15, "0")
                loc_lcIrf = PADL(CHRTRAN(STR(NVL(LocalNfS.VIrf, 0),     20, 2), ". ", ""), 15, "0")
                loc_lcCsl = PADL(CHRTRAN(STR(NVL(LocalNfS.VCsll, 0),    20, 2), ". ", ""), 15, "0")

                loc_lcObs = ALLTRIM(STRTRAN(STRTRAN(NVL(LocalNfS.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_lcObs = IIF(EMPTY(loc_lcObs), "Servi" + CHR(231) + "os Prestados", loc_lcObs)

                *-- Acumula totalizadores
                loc_lnTsr = loc_lnTsr + NVL(LocalNfS.TotProds, 0)
                loc_lnTdd = loc_lnTdd + NVL(LocalNfS.VDeducoes, 0)

                *-- Registro Tipo 6 - Detalhe saida SP
                loc_lcStr = "6" + ;
                            "RPS  " + ;
                            loc_lcSer + ;
                            loc_lcNot + ;
                            loc_lcEmi + ;
                            loc_lcTts + ;
                            loc_lcVal + ;
                            loc_lcVde + ;
                            loc_lcCsM + ;
                            loc_lcAlq + ;
                            loc_lcRtd + ;
                            loc_lcTpT + ;
                            loc_lcCpW + ;
                            loc_lcImT + ;
                            loc_lcIeT + ;
                            loc_lcNmT + ;
                            loc_lcTeT + ;
                            loc_lcEdT + ;
                            loc_lcNeT + ;
                            loc_lcCeT + ;
                            loc_lcBaT + ;
                            loc_lcCdT + ;
                            loc_lcUfT + ;
                            loc_lcCcT + ;
                            loc_lcEmT + ;
                            loc_lcPis + ;
                            loc_lcCof + ;
                            loc_lcIns + ;
                            loc_lcIrf + ;
                            loc_lcCsl + ;
                            PADL("0", 15, "0") + ;
                            PADL("0", 5,  "0") + ;
                            SPACE(10) + ;
                            PADL("0", 12, "0") + ;
                            PADL("0", 12, "0") + ;
                            loc_lcMps + ;
                            SPACE(200) + ;
                            loc_lcObs + ;
                            loc_lcFim

                loc_lnRg2 = loc_lnRg2 + 1
                =STRTOFILE(loc_lcStr, loc_lcArq, .T.)
            ENDSCAN

            *-- Registro Tipo 9 - Rodape SP
            loc_lcNdt = PADL(CHRTRAN(STR(loc_lnRg2, 20, 0), ". ", ""), 7, "0")
            loc_lcTsr = PADL(CHRTRAN(STR(loc_lnTsr, 20, 2), ". ", ""), 15, "0")
            loc_lcTdd = PADL(CHRTRAN(STR(loc_lnTdd, 20, 2), ". ", ""), 15, "0")

            loc_lcStr = "9" + ;
                        loc_lcNdt + ;
                        loc_lcTsr + ;
                        loc_lcTdd + ;
                        loc_lcFim
            =STRTOFILE(loc_lcStr, loc_lcArq, .T.)

            MsgInfo("O Arquivo " + CHR(34) + loc_lcArq + CHR(34) + " Foi Gerado!" + CHR(13) + ;
                    "Notas de Sa" + CHR(237) + "da: " + ALLTRIM(STR(loc_lnRg2, 10)))

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GerarArquivoSP")
        ENDTRY

        IF USED("LocalNfS")
            USE IN LocalNfS
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - coordena a geracao do arquivo NFS-e conforme municipio
    * par_cCidade: "RJ - Rio de Janeiro" ou "SP - Sao Paulo"
    * Retorno: .T. se arquivo gerado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Processamento(par_cCidade)
        LOCAL loc_lSucesso, loc_cCidade, loc_oErro
        loc_lSucesso = .F.
        loc_cCidade  = ALLTRIM(IIF(TYPE("par_cCidade") = "C", par_cCidade, THIS.this_cCidade))

        TRY
            DO CASE
                CASE loc_cCidade = "RJ - Rio de Janeiro"
                    loc_lSucesso = THIS.GerarArquivoRJ()

                CASE loc_cCidade = "SP - S" + CHR(227) + "o Paulo"
                    loc_lSucesso = THIS.GerarArquivoSP()

                OTHERWISE
                    MsgAviso("Munic" + CHR(237) + "pio n" + CHR(227) + "o suportado: " + loc_cCidade)
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Processamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

