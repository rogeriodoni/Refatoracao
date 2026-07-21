*==============================================================================
* FORMSIGREANI.PRG
* Relatorio de Aniversariantes - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREANI.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo: txt_4c_DtInicial (get_dt_inicial) e txt_4c_DtFinal (get_dt_final)
*     Somente dia/mes sao considerados - ano e ignorado no processamento do BO
*
* Posicoes originais (relativas ao form Width=800, Height=300):
*   lbl_periodo   : Top=172, Left=333, Caption="Periodo :"
*   get_dt_inicial: Top=168, Left=384, Width=45, InputMask="99/99"
*   lbl_a (a-grave): Top=172, Left=433
*   get_dt_final  : Top=168, Left=444, Width=45, InputMask="99/99"
*
* PageFrame.Top=85 -> posicoes em Page1 = posicao_original - 85
*==============================================================================

DEFINE CLASS Formsigreani AS FormBase

    *-- Dimensoes exatas do original: Width=800, Height=300
    Height      = 300
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

    *-- BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

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
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Aniversariantes"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreaniBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreaniBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
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
    *   Width = THIS.Width para cobrir toda a faixa superior (sem faixa clara).
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
                .Caption   = "Relat" + CHR(243) + "rio de Aniversariantes"
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
                .Caption   = "Relat" + CHR(243) + "rio de Aniversariantes"
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
    *   Geometria EXATA do framework frmrelatorio (regras criticas):
    *     Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *     Lefts dos botoes: 5 / 71 / 137 / 203 (incrementos de 66)
    *   btnReport.Left=526 no original -> arredondado para 529.
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

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
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
                .Left            = 71
                .Width           = 65
                .Height          = 70
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
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
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
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
                .Cancel          = .T.
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
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Form: Width=800, Height=300
    *   Cabecalho: Height=80
    *   PageFrame: Top=85, Height=300-85=215
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

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
    * ConfigurarPaginaLista - Filtros de periodo (unica pagina do relatorio)
    *   Posicoes em Page1 = posicao_original - PageFrame.Top(85):
    *   lbl_periodo   (Top=172) -> Page1.Top = 87, Left=333
    *   txt_4c_DtInicial (Top=168) -> Page1.Top = 83, Left=384, Width=45
    *   lbl_4c_LblA   (Top=172) -> Page1.Top = 87, Left=433
    *   txt_4c_DtFinal   (Top=168) -> Page1.Top = 83, Left=444, Width=45
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Periodo :" (lbl_periodo: Left=333, Top=172)
        loc_oPg.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg.lbl_4c_Periodo
            .Top       = 87
            .Left      = 333
            .AutoSize  = .T.
            .Caption   = "Periodo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data Inicial (get_dt_inicial: Left=384, Top=168, Width=45, InputMask="99/99")
        *   Value=DATE() (inicializado em LimparCampos) - somente DD/MM e usado
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 83
            .Left          = 384
            .Width         = 45
            .Height        = 23
            .Value         = {}
            .Format        = "K9"
            .InputMask     = "99/99"
            .MaxLength     = 5
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label separador "a grave" (lbl_a: Left=433, Top=172) - preposicao "a"
        loc_oPg.AddObject("lbl_4c_LblA", "Label")
        WITH loc_oPg.lbl_4c_LblA
            .Top       = 87
            .Left      = 433
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data Final (get_dt_final: Left=444, Top=168, Width=45, InputMask="99/99")
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 83
            .Left          = 444
            .Width         = 45
            .Height        = 23
            .Value         = {}
            .Format        = "K9"
            .InputMask     = "99/99"
            .MaxLength     = 5
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- KeyPress: ESC(27) restaura data inicial/final para hoje
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,   "KeyPress", THIS, "TeclaDataFinal")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao utilizado em form REPORT de periodo simples
    *   Mantido para compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros de data para a data de hoje
    *   Original: thisform.get_dt_inicial.value = date() / thisform.get_dt_final.value = date()
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value = DATE()
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value   = DATE()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia datas dos controles para propriedades do BO
    *   BO usa DAY() e MONTH() para extrair dia/mes - ano e irrelevante
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal   = loc_oPg.txt_4c_DtFinal.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica se ambas as datas do periodo foram preenchidas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_lValido
        loc_lValido = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(loc_oPg.txt_4c_DtInicial.Value)
                MsgInfo("Informe a data inicial do per" + CHR(237) + "odo.", ;
                    "Filtro Obrigat" + CHR(243) + "rio")
            ELSE
                IF EMPTY(loc_oPg.txt_4c_DtFinal.Value)
                    MsgInfo("Informe a data final do per" + CHR(237) + "odo.", ;
                        "Filtro Obrigat" + CHR(243) + "rio")
                ELSE
                    loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
    * ESC(27) restaura data para hoje; demais teclas passam pelo VFP normalmente
    *==========================================================================

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value = DATE()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value = DATE()
        ENDIF
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                    ENDIF
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                    ENDIF
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF PEMSTATUS(THIS.this_oRelatorio, "ExportarExcel", 5)
                    IF !THIS.this_oRelatorio.ExportarExcel()
                        IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                        ENDIF
                    ELSE
                        THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
                    ENDIF
                ELSE
                    MsgInfo("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
                        "o implementada para este relat" + CHR(243) + "rio.", ;
                        "Recurso n" + CHR(227) + "o dispon" + CHR(237) + "vel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT (aliases para compatibilidade com pipeline)
    *==========================================================================

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.pgf_4c_Paginas.Page1) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_DtInicial", 5)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                IF !EMPTY(.this_dDtInicial)
                    loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
                ENDIF
                IF !EMPTY(.this_dDtFinal)
                    loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_DtInicial", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
