*==============================================================================
* FORMSIGOPCHR.PRG
* Relatorio de Relacao de Cheques - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGOPCHR.SCX (frmrelatorio)
*
* Filtros (legado: Get_Oper/GetDataI/GetDataF/GetTipo/getGrupo/getConta/ImpNConta):
*   - Operacao        : txt_4c_Oper
*   - Periodo         : txt_4c_DataI / txt_4c_DataF
*   - Tipo            : obj_4c_GetTipo (Geral/Nao Liquidado)
*   - Grupo           : txt_4c_Grupo + txt_4c_DGrupo
*   - Conta           : txt_4c_Conta + txt_4c_DConta
*   - Imprime Nome Conta : chk_4c_ImpNConta
*==============================================================================

DEFINE CLASS FormSIGOPCHR AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=250)
    Height      = 250
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

    *-- Guarda de reentrancia dos lookups (regra #37/#47): o picker eh MODAL
    *-- e tira o foco do campo, o que redispara o proprio LostFocus.
    this_lEmLookup     = .F.

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Cheques"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGOPCHRBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGOPCHRBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Repoe os defaults do Init legado e aplica os dois When do
                *-- SCX (getDGrupo/getDConta so editaveis com o codigo vazio).
                THIS.LimparCampos()
                THIS.AjustarBotoesPorModo()

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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura total do form (Width) para cobrir toda a faixa superior.
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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Cheques"
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
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Cheques"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do SCX legado (btnReport): Top=-2, Left=495,
    *   Width=310, Height=85, ButtonCount=4, botoes 75x75 (Left=5/80/155/230)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 495
            .Width         = 310
            .Height        = 85
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
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

            *-- Eventos principais dos botoes de relatorio (Fase 7/8)
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Posicionado abaixo do cabecalho (Top=85) ate o fim do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
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
    * ConfigurarPaginaLista - Adiciona os campos de filtro na Page1 (Filtros)
    *
    * Forms REPORT (frmrelatorio) tem layout FLAT com 1 unica Page. Posicoes
    * ajustadas relativas ao PageFrame.Top=85 (Top_original - 85):
    *   Operacao  : Top=109->24 (label) / Top=106->21 (campo)
    *   Periodo   : Top=133->48 (label) / Top=131->46 (campos) / Top=135->50 (separador)
    *   Grupo     : Top=158->73 (label) / Top=156->71 (campos)
    *   Conta     : Top=183->98 (label) / Top=181->96 (campos)
    *   Tipo      : Top=208->123 (label) / Top=204->119 (OptionGroup)
    *   ImpNConta : Top=209->124
    *
    * Lookups (LostFocus/SQL) de Oper/Grupo/DGrupo/Conta/DConta sao
    * registrados no final deste metodo (Fase 6/8) e implementados em
    * ValidarOper/ValidarGrupo/ValidarDGrupo/ValidarConta/ValidarDConta
    * (abaixo de ConfigurarPaginaLista).
    *
    * NOTA (Fase 5/8 - Campos Principais Parte 1): este form eh REPORT
    * (frmrelatorio), cujo layout e FLAT - uma unica Page ("Filtros"), sem
    * Page1(Lista)/Page2(Dados) como nos forms CRUD. Os 15 objetos de
    * mapeamento.json (excetuando Dataenvironment e o Form raiz) JA estao
    * 100% implementados abaixo desde a fase anterior: Say1/Say3/Say4/Say5/
    * Say2/lbl_estoque -> os 6 labels; Get_Oper/GetDataI/GetDataF/getConta/
    * getDConta/getGrupo/getDGrupo -> os 7 TextBox; GetTipo -> obj_4c_GetTipo;
    * ImpNConta -> chk_4c_ImpNConta. MaxLength de cada TextBox conferido
    * contra docs/schema.sql (SigCdOpt.Operacaos=15, SigCdGcr.Codigos=10,
    * SigCdGcr.Descrs=40, SigCdCli.Iclis=10, SigCdCli.Rclis=50) - todos
    * batem. Nao ha ConfigurarPaginaDados() nem Page2 a criar: inventar um
    * violaria o layout FLAT do tipo REPORT (ver CLAUDE.md tabela "Form
    * Types"). Nao ha container cnt_4c_BotoesAcao (Salvar/Cancelar) a criar
    * tambem: os botoes deste REPORT ja sao o cmg_4c_Botoes (Visualizar/
    * Imprimir/Email/Encerrar) criado em ConfigurarBotoes (fase anterior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Operacao :"
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 24
            .Left      = 185
            .Width     = 56
            .Height    = 15
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Operacao (SigCdOpt.Operacaos, MaxLength=15)
        loc_oPg.AddObject("txt_4c_Oper", "TextBox")
        WITH loc_oPg.txt_4c_Oper
            .Top         = 21
            .Left        = 243
            .Width       = 115
            .Height      = 23
            .MaxLength   = 15
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Periodo :"
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 48
            .Left      = 196
            .Width     = 45
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Data Inicial
        loc_oPg.AddObject("txt_4c_DataI", "TextBox")
        WITH loc_oPg.txt_4c_DataI
            .Top         = 46
            .Left        = 243
            .Width       = 80
            .Height      = 23
            .Value       = DATE() - 30
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label separador entre as datas
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Top       = 50
            .Left      = 327
            .Width     = 8
            .Height    = 15
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Data Final
        loc_oPg.AddObject("txt_4c_DataF", "TextBox")
        WITH loc_oPg.txt_4c_DataF
            .Top         = 46
            .Left        = 338
            .Width       = 80
            .Height      = 23
            .Value       = DATE()
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Grupo :"
        loc_oPg.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg.lbl_4c_Label5
            .Top       = 73
            .Left      = 203
            .Width     = 38
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Grupo (SigCdGcr.Codigos, MaxLength=10)
        loc_oPg.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg.txt_4c_Grupo
            .Top         = 71
            .Left        = 243
            .Width       = 80
            .Height      = 23
            .MaxLength   = 10
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descricao do Grupo (SigCdGcr.Descrs, MaxLength=40)
        loc_oPg.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg.txt_4c_DGrupo
            .Top         = 71
            .Left        = 325
            .Width       = 150
            .Height      = 23
            .MaxLength   = 40
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Conta :"
        loc_oPg.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oPg.lbl_4c_Lbl_estoque
            .Top       = 98
            .Left      = 203
            .Width     = 38
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da Conta (SigCdCli.IClis, MaxLength=10)
        loc_oPg.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg.txt_4c_Conta
            .Top         = 96
            .Left        = 243
            .Width       = 80
            .Height      = 23
            .MaxLength   = 10
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descricao da Conta (SigCdCli.RClis, MaxLength=50)
        loc_oPg.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPg.txt_4c_DConta
            .Top         = 96
            .Left        = 325
            .Width       = 290
            .Height      = 23
            .MaxLength   = 50
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Tipo :"
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Top       = 123
            .Left      = 212
            .Width     = 29
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Tipo (OptionGroup Geral/Nao Liquidado - ControlSource numerico 1/2)
        loc_oPg.AddObject("obj_4c_GetTipo", "OptionGroup")
        loc_oPg.obj_4c_GetTipo.ButtonCount = 2
        WITH loc_oPg.obj_4c_GetTipo
            .Top         = 119
            .Left        = 238
            .Width       = 144
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Geral"
                .Top       = 5
                .Left      = 5
                .Width     = 61
                .Height    = 17
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Pendente"
                .Top       = 5
                .Left      = 62
                .Width     = 77
                .Height    = 17
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Imprime Nome da Conta
        loc_oPg.AddObject("chk_4c_ImpNConta", "CheckBox")
        WITH loc_oPg.chk_4c_ImpNConta
            .Top       = 124
            .Left      = 399
            .Width     = 133
            .Height    = 15
            .Caption   = "Imprime Nome da Conta"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Lookups (regra #47): LostFocus, NUNCA KeyPress sem testar tecla -
        *-- o legado valida no Valid do campo (equivalente a sair do campo).
        BINDEVENT(loc_oPg.txt_4c_Oper,   "LostFocus", THIS, "ValidarOper")
        BINDEVENT(loc_oPg.txt_4c_Grupo,  "LostFocus", THIS, "ValidarGrupo")
        BINDEVENT(loc_oPg.txt_4c_DGrupo, "LostFocus", THIS, "ValidarDGrupo")
        BINDEVENT(loc_oPg.txt_4c_Conta,  "LostFocus", THIS, "ValidarConta")
        BINDEVENT(loc_oPg.txt_4c_DConta, "LostFocus", THIS, "ValidarDConta")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOper - LostFocus: valida Operacao (SigCdOpt.Operacaos)
    *   Legado (Get_Oper.Valid): SEEK exato contra crSigCdOpt; nao achando,
    *   abre fwBuscaSel com colunas Operacaos/Descrs. Nao ha campo de
    *   descricao na tela para este filtro - so o codigo.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOper()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarOperExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarOperExec()
        LOCAL loc_oPg, loc_cVal, loc_oLookup, loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_Oper.Value)

            IF EMPTY(loc_cVal)
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdOpt", "cursor_4c_OperPick", ;
                    "Operacaos", loc_cVal, "Opera" + CHR(231) + CHR(245) + "es")

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        *-- Colunas do picker (legado fwBuscaSel: Operacaos/Descrs).
                        loc_oLookup.mAddColuna("Operacaos", "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.Show()
                    ENDIF

                    *-- Regra #37: atribuir SO sob a guarda this_lSelecionou. Sem
                    *-- picker selecionado, o codigo digitado permanece (regra #50).
                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_OperPick")
                        SELECT cursor_4c_OperPick
                        loc_oPg.txt_4c_Oper.Value = ALLTRIM(cursor_4c_OperPick.Operacaos)
                    ENDIF

                    IF USED("cursor_4c_OperPick")
                        USE IN cursor_4c_OperPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarOper")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - LostFocus: lookup de grupo contabil (SigCdGcr)
    *   Legado (getGrupo.Valid): fAcessoContab(Usuar,'C',This.Value,getGrupo,
    *   getDGrupo). Campo vazio so limpa a descricao - NUNCA o codigo digitado
    *   (regra #50).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoExec()
        THIS.this_lEmLookup = .F.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarGrupoExec()
        LOCAL loc_oPg, loc_cVal, loc_oLookup, loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)

            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_DGrupo.Value = ""
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdGcr", "cursor_4c_GrupoPick", ;
                    "codigos", loc_cVal, "Grupo")

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoPick")
                        SELECT cursor_4c_GrupoPick
                        loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GrupoPick.codigos)
                        loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GrupoPick.descrs)
                    ELSE
                        *-- Legado (fAcessoContab): sem selecao, limpa a descricao
                        loc_oPg.txt_4c_DGrupo.Value = ""
                    ENDIF

                    IF USED("cursor_4c_GrupoPick")
                        USE IN cursor_4c_GrupoPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrupo - LostFocus: busca reversa de grupo contabil por descricao
    *   Legado (getDGrupo.When): o campo so eh editavel quando getGrupo esta
    *   vazio. getDGrupo.Valid: fAcessoContab(Usuar,'D',...).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDGrupoExec()
        THIS.this_lEmLookup = .F.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarDGrupoExec()
        LOCAL loc_oPg, loc_cVal, loc_oLookup, loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            *-- Legado: busca reversa so quando o codigo do grupo esta vazio
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cVal = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
                IF EMPTY(loc_cVal)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdGcr", "cursor_4c_DGrupoPick", ;
                    "descrs", loc_cVal, "Grupo")

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_DGrupoPick")
                        SELECT cursor_4c_DGrupoPick
                        loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_DGrupoPick.codigos)
                        loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DGrupoPick.descrs)
                    ELSE
                        loc_oPg.txt_4c_DGrupo.Value = ""
                    ENDIF

                    IF USED("cursor_4c_DGrupoPick")
                        USE IN cursor_4c_DGrupoPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarDGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - LostFocus: lookup de conta/cliente (SigCdCli), filtrado
    *   pelo grupo contabil quando preenchido.
    *   Legado (getConta.Valid): fAcessoContas(Usuar,Grupo,'C',This.Value,...).
    *   Substituicao canonica (fAcessoContas NAO deve ser chamada diretamente
    *   como handler de UX - auto-carrega o 1o match por LIKE): SELECT exato
    *   via FormBuscaAuxiliar + picker filtrado por grupos, como Formche.
    *   ResolverConta.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarContaExec()
        THIS.this_lEmLookup = .F.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarContaExec()
        LOCAL loc_oPg, loc_cVal, loc_cGrupo, loc_cFiltro, loc_oLookup, loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_Conta.Value)

            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_DConta.Value = ""
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cGrupo  = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
                loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))

                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdCli", "cursor_4c_ContaPick", ;
                    "Iclis", loc_cVal, "Conta", .F., .F., loc_cFiltro)

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("Rclis", "", "Nome")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_ContaPick")
                        SELECT cursor_4c_ContaPick
                        loc_oPg.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ContaPick.Iclis)
                        loc_oPg.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ContaPick.Rclis)
                    ELSE
                        loc_oPg.txt_4c_DConta.Value = ""
                    ENDIF

                    IF USED("cursor_4c_ContaPick")
                        USE IN cursor_4c_ContaPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDConta - LostFocus: busca reversa de conta por nome (SigCdCli),
    *   filtrada pelo grupo contabil quando preenchido.
    *   Legado (getDConta.When): so editavel quando getConta esta vazio.
    *   getDConta.Valid: fAcessoContas(Usuar,Grupo,'D',...).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDContaExec()
        THIS.this_lEmLookup = .F.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarDContaExec()
        LOCAL loc_oPg, loc_cVal, loc_cGrupo, loc_cFiltro, loc_oLookup, loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            *-- Legado: busca reversa so quando o codigo da conta esta vazio
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value))
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cVal = ALLTRIM(loc_oPg.txt_4c_DConta.Value)
                IF EMPTY(loc_cVal)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cGrupo  = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
                loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))

                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdCli", "cursor_4c_DContaPick", ;
                    "Rclis", loc_cVal, "Conta", .F., .F., loc_cFiltro)

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("Rclis", "", "Nome")
                        loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_DContaPick")
                        SELECT cursor_4c_DContaPick
                        loc_oPg.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_DContaPick.Iclis)
                        loc_oPg.txt_4c_DConta.Value = ALLTRIM(cursor_4c_DContaPick.Rclis)
                    ELSE
                        loc_oPg.txt_4c_DConta.Value = ""
                    ENDIF

                    IF USED("cursor_4c_DContaPick")
                        USE IN cursor_4c_DContaPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarDConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia os filtros da tela para as propriedades do BO
    *   Mapeamento 1:1 com SIGOPCHRBO:
    *     txt_4c_Oper      -> this_cOperacao
    *     txt_4c_DataI     -> this_dDataInicial
    *     txt_4c_DataF     -> this_dDataFinal
    *     obj_4c_GetTipo   -> this_nTipo       (OptionGroup: 1=Geral, 2=Nao Liquidado)
    *     txt_4c_Grupo     -> this_cGrupo
    *     txt_4c_DGrupo    -> this_cDescGrupo
    *     txt_4c_Conta     -> this_cConta
    *     txt_4c_DConta    -> this_cDescConta
    *     chk_4c_ImpNConta -> this_lImpNConta (regra #187: comparar = 1,
    *                         NUNCA atribuir o numerico do CheckBox direto
    *                         a property logica)
    *--------------------------------------------------------------------------
    PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_cOperacao    = ALLTRIM(loc_oPg.txt_4c_Oper.Value)
            .this_dDataInicial = loc_oPg.txt_4c_DataI.Value
            .this_dDataFinal   = loc_oPg.txt_4c_DataF.Value
            .this_nTipo        = loc_oPg.obj_4c_GetTipo.Value
            .this_cGrupo       = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
            .this_cDescGrupo   = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
            .this_cConta       = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
            .this_cDescConta   = ALLTRIM(loc_oPg.txt_4c_DConta.Value)
            .this_lImpNConta   = (loc_oPg.chk_4c_ImpNConta.Value = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Botao 1 (Visualizar): exibe o relatorio em preview
    *   na tela. Visualizar() do BO ja chama PrepararDados() internamente
    *   (que valida os filtros via ValidarParametros) e ja exibe
    *   MsgErro/MsgAviso em toda falha - o handler NAO deve exibir mensagem
    *   de novo, senao duplica o dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Botao 2 (Imprimir): envia o relatorio para a
    *   impressora com dialogo de selecao. Imprimir() do BO ja valida e
    *   exibe mensagens.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Botao 3 ("Arquivos Email"): exporta o relatorio para
    *   arquivo .xls. GerarExcel() do BO ja valida e exibe mensagens.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.GerarExcel()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Botao 4 (Encerrar): fecha o formulario
    *   ([Esc] tambem fecha via .Cancel = .T. no Buttons(4))
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina no PageFrame (contrato do pipeline)
    *
    *   Forms REPORT (frmrelatorio) possuem APENAS 1 pagina (Filtros), ao
    *   contrario dos forms CRUD que alternam entre Page1 (Lista) e Page2
    *   (Dados). Este metodo garante que a unica pagina existente permaneca
    *   ativa e devolve o foco para o primeiro campo de filtro, mantendo
    *   compatibilidade com o contrato esperado pelo pipeline de migracao.
    *
    *   par_nPagina - Indice da pagina (1 = Filtros). Valores invalidos sao
    *                 normalizados para 1, pois o form so tem 1 Page.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oPg, loc_oErro
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_Oper", 5)
                loc_oPg.txt_4c_Oper.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * METODOS COMPLEMENTARES - FASE 8
    * Contratos exigidos pelo pipeline de migracao para forms de qualquer tipo.
    * Em form REPORT (frmrelatorio) nao existe Page de Dados, nem registro em
    * edicao, nem grade de listagem: cada contrato abaixo eh mapeado para o
    * equivalente REAL desta tela (filtros + toolbar de 4 botoes), sem inventar
    * botao ou campo que o legado SIGOPCHR.SCX nao tem.
    *
    * ESCOPO (regra #3 e #51): FormParaBO, BOParaForm e LimparCampos sao
    * declarados PROTECTED na FormBase (formbase.prg:276-285) e redeclarar sem
    * modificador NAO alarga o escopo - continuariam protegidos, so que sem
    * dizer. Marcados PROTECTED aqui para o codigo nao mentir: sao hooks
    * INTERNOS, chamados pelo proprio form. Ja CarregarLista, HabilitarCampos,
    * AjustarBotoesPorModo e BtnCancelarClick NAO existem na FormBase e ficam
    * PUBLIC de proposito - o harness TesteAutomatico.prg os chama de FORA da
    * classe, e PEMSTATUS(oForm, "X", 5) devolveria .T. mesmo protegidos,
    * fazendo a chamada real falhar so em runtime.
    *==========================================================================

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura TODOS os filtros para os valores padrao
    *
    *   Transcrito do Init legado (SIGOPCHR.Init):
    *       ThisForm.get_Oper.Value = ''
    *       ThisForm.GetDataI.Value = Date() - 30
    *       ThisForm.GetDataF.Value = Date()
    *       ThisForm.getTipo.Value  = 1
    *       ThisForm.getGrupo.Value = Iif(Type('pGru') = 'C', pGru, '')
    *       ThisForm.getConta.Value = Iif(Type('pCon') = 'C', pCon, '')
    *   Aberto pelo menu nao ha pGru/pCon, logo Grupo/Conta nascem vazios.
    *   ImpNConta nao eh tocado no Init legado - o SCX nao declara Value,
    *   portanto o default eh 0 (desmarcado).
    *
    *   Os mesmos valores aparecem no AddObject de ConfigurarPaginaLista, e
    *   isso NAO eh duplicacao a eliminar: o .Value de nascimento eh o que
    *   define o TIPO do TextBox no VFP9 (DATE nos dois campos de periodo,
    *   Character nos demais) e tem de estar no proprio bloco WITH. Este
    *   metodo eh o caminho de REPOSICAO (Cancelar e reabertura da tela);
    *   InicializarForm o chama ao final para que os dois caminhos saiam do
    *   mesmo lugar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            loc_oPg.txt_4c_Oper.Value      = ""
            loc_oPg.txt_4c_DataI.Value     = DATE() - 30
            loc_oPg.txt_4c_DataF.Value     = DATE()
            loc_oPg.obj_4c_GetTipo.Value   = 1
            loc_oPg.txt_4c_Grupo.Value     = ""
            loc_oPg.txt_4c_DGrupo.Value    = ""
            loc_oPg.txt_4c_Conta.Value     = ""
            loc_oPg.txt_4c_DConta.Value    = ""
            loc_oPg.chk_4c_ImpNConta.Value = 0

            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Reproduz os eventos When do legado
    *
    *   O SCX tem DOIS e SOMENTE DOIS When, ambos nos campos de DESCRICAO:
    *       getDGrupo.When -> Return(IsEmpty(ThisForm.getGrupo.Value))
    *       getDConta.When -> Return(IsEmpty(ThisForm.getConta.Value))
    *   Isto eh: a descricao so aceita digitacao enquanto o CODIGO
    *   correspondente esta vazio (eh o caminho da busca reversa).
    *
    *   Os campos de CODIGO (getGrupo/getConta) e o de Operacao NAO tem When
    *   no legado - ficam SEMPRE editaveis. Espelhar a restricao neles tambem
    *   seria inventar regra que o legado nao tem (viola o PILAR 1).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_DGrupo", 5)
                loc_oPg.txt_4c_DGrupo.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_DConta", 5)
                loc_oPg.txt_4c_DConta.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.AtualizarEstadoCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os controles de filtro
    *   Em CRUD: liga/desliga os campos conforme INCLUIR/ALTERAR/VISUALIZAR.
    *   Em REPORT: nao ha modo de edicao; o metodo aplica o estado BASE em
    *   todos os filtros e, quando habilita, devolve o refinamento dos When
    *   do legado para AtualizarEstadoCampos (fonte unica da regra).
    *
    *   par_lHabilitar = .T. -> ReadOnly = .F. em todos (default)
    *   par_lHabilitar = .F. -> ReadOnly = .T. em todos
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_Oper", 5)
                    loc_oPg.txt_4c_Oper.ReadOnly   = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DataI", 5)
                    loc_oPg.txt_4c_DataI.ReadOnly  = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DataF", 5)
                    loc_oPg.txt_4c_DataF.ReadOnly  = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Grupo", 5)
                    loc_oPg.txt_4c_Grupo.ReadOnly  = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DGrupo", 5)
                    loc_oPg.txt_4c_DGrupo.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Conta", 5)
                    loc_oPg.txt_4c_Conta.ReadOnly  = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DConta", 5)
                    loc_oPg.txt_4c_DConta.ReadOnly = !loc_lHab
                ENDIF
                *-- OptionGroup e CheckBox nao tem ReadOnly: usar Enabled
                IF PEMSTATUS(loc_oPg, "obj_4c_GetTipo", 5)
                    loc_oPg.obj_4c_GetTipo.Enabled = loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_ImpNConta", 5)
                    loc_oPg.chk_4c_ImpNConta.Enabled = loc_lHab
                ENDIF
            ENDIF

            IF loc_lHab
                THIS.AtualizarEstadoCampos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Contrato de recarga da lista de registros
    *   Em CRUD: executa a query e popula o grid da Page1 com os registros.
    *   Em REPORT: o legado SIGOPCHR.SCX nao tem Grid nem cursor de listagem -
    *   a Page unica so hospeda os campos de filtro, e o resultado da tela eh
    *   o proprio relatorio (SigOpChr.frx), montado por PrepararDados no BO.
    *   Devolve .T. porque nao ha lista a carregar - nao ha falha possivel.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Contrato de transferencia Form -> objeto de negocio
    *   Em REPORT o "BO" eh o BO de RELATORIO (SIGOPCHRBO, herda RelatorioBase)
    *   e a transferencia dos filtros ja esta implementada em
    *   FormParaRelatorio. Delega para ela, mantendo FONTE UNICA do mapeamento
    *   (duplicar as atribuicoes faria os dois caminhos divergirem no primeiro
    *   campo novo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Contrato de transferencia objeto de negocio -> Form
    *   Em CRUD: preenche os controles com os dados do registro carregado.
    *   Em REPORT nao existe "registro carregado": o que o BO guarda sao os
    *   FILTROS. Este metodo repoe nos controles os filtros que estao nas
    *   properties do BO - util para restaurar a tela ao estado usado na
    *   ultima geracao do relatorio.
    *   Inverso EXATO de FormParaRelatorio, campo a campo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_lContinuar, loc_nTipo, loc_nImp, loc_oErro
        loc_lContinuar = .T.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                WITH THIS.this_oRelatorio
                    loc_oPg.txt_4c_Oper.Value   = TratarNulo(.this_cOperacao, "")
                    loc_oPg.txt_4c_Grupo.Value  = TratarNulo(.this_cGrupo, "")
                    loc_oPg.txt_4c_DGrupo.Value = TratarNulo(.this_cDescGrupo, "")
                    loc_oPg.txt_4c_Conta.Value  = TratarNulo(.this_cConta, "")
                    loc_oPg.txt_4c_DConta.Value = TratarNulo(.this_cDescConta, "")

                    *-- regra #16: ConverterParaData normaliza DATE/DATETIME/
                    *-- CHAR. TTOD() aqui estouraria erro 11, porque as
                    *-- properties nascem DATE ({} no DEFINE CLASS).
                    loc_oPg.txt_4c_DataI.Value = ConverterParaData(.this_dDataInicial)
                    loc_oPg.txt_4c_DataF.Value = ConverterParaData(.this_dDataFinal)

                    *-- OptionGroup eh 1-based (1=Geral, 2=Nao Liquidado): nunca
                    *-- atribuir 0, que deixaria os dois botoes desmarcados.
                    loc_nTipo = IIF(VARTYPE(.this_nTipo) = "N", .this_nTipo, 1)
                    loc_nTipo = IIF(BETWEEN(loc_nTipo, 1, 2), loc_nTipo, 1)
                    loc_oPg.obj_4c_GetTipo.Value = loc_nTipo

                    *-- CheckBox.Value eh NUMERICO; a property do BO eh LOGICA.
                    *-- Conversao explicita, tolerando a property chegar
                    *-- numerica (coluna bit do SQL Server muda de tipo
                    *-- conforme o driver).
                    DO CASE
                        CASE VARTYPE(.this_lImpNConta) = "L"
                            loc_nImp = IIF(.this_lImpNConta, 1, 0)
                        CASE VARTYPE(.this_lImpNConta) = "N"
                            loc_nImp = IIF(.this_lImpNConta = 1, 1, 0)
                        OTHERWISE
                            loc_nImp = 0
                    ENDCASE
                    loc_oPg.chk_4c_ImpNConta.Value = loc_nImp
                ENDWITH

                THIS.AtualizarEstadoCampos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Contrato "Buscar/Consultar"
    *   Em CRUD: abre a consulta de um registro existente.
    *   Em REPORT: equivale a "buscar os dados com os filtros atuais", que
    *   nesta tela eh exatamente o preview em video (botao 1 do legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Contrato "Salvar/Confirmar"
    *   Em CRUD: grava o registro em edicao.
    *   Em REPORT nao ha registro a gravar: a acao de CONFIRMAR os filtros eh
    *   produzir a saida em papel, que no legado eh o btnReport.Imprime
    *   (Report Form SigOpChr To PRINTER Prompt NoConsole).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Contrato "Cancelar"
    *   Em CRUD: descarta a edicao e volta para a Page de Lista.
    *   Em REPORT: descarta os FILTROS digitados e devolve a tela ao estado
    *   inicial (os defaults do Init legado), permitindo recomecar a selecao
    *   sem fechar o formulario. NAO fecha a tela - quem fecha eh o Encerrar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg, loc_oErro
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_Oper", 5)
                IF !loc_oPg.txt_4c_Oper.ReadOnly
                    loc_oPg.txt_4c_Oper.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Contrato de ajuste dos botoes conforme o modo
    *   Em CRUD: liga/desliga os botoes conforme LISTA/INCLUIR/ALTERAR/
    *   VISUALIZAR.
    *   Em REPORT nao existe modo: os 4 botoes do CommandGroup herdado do
    *   frmrelatorio (Visualizar / Imprimir / Arquivos Email / Encerrar) ficam
    *   SEMPRE habilitados, como no legado. O metodo reafirma esse estado.
    *   PUBLIC de proposito: o harness TesteAutomatico.prg o chama de fora da
    *   classe (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPCHR.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
