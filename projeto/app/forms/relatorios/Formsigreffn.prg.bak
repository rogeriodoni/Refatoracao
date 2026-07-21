*==============================================================================
* FORMSIGREFFN.PRG
* Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFFN.SCX (frmrelatorio)
*
* Filtros:
*   - Per" + CHR(237) + "odo (data inicial / data final)
*   - Moeda de refer" + CHR(234) + "ncia (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
*   - Cota" + CHR(231) + CHR(227) + "o (num" + CHR(233) + "rico - auto do BO via BuscarCotacaoAtual)
*   - Moeda de lan" + CHR(231) + "amento (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
*   - Totaliza Contas (CheckBox)
*   - Conciliado (CheckBox)
*   - Op" + CHR(231) + CHR(227) + "o NF (Sim/N" + CHR(227) + "o/Ambos)
*   - Fluxo / Tipo Impress" + CHR(227) + "o (Di" + CHR(225) + "rio/Semanal/Quinzenal/Mensal)
*   - Listar Atrasos (Sim/N" + CHR(227) + "o)
*   - Considerar Atrasos (Sim/N" + CHR(227) + "o)
*   - Previsto (Sim/N" + CHR(227) + "o/Ambos)
*   - Situa" + CHR(231) + CHR(227) + "o (Baixados/Em Aberto/Todos)
*   - Saldo (Anterior/Na Data)
*   - Empresas selecion" + CHR(225) + "veis (Grid cEmp com CheckBox)
*   - Disponibilidades selecion" + CHR(225) + "veis (Grid cDisp com CheckBox)
*   - Opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos selecion" + CHR(225) + "veis (Grid crSigOpOpe com CheckBox)
*==============================================================================

DEFINE CLASS Formsigreffn AS FormBase

    Height      = 580
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

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigreffnBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigreffnBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF

                IF loc_lContinuar
                    IF !THIS.this_oRelatorio.InicializarCursoresAuxiliares()
                        MsgAviso(THIS.this_oRelatorio.ObterMensagemErro() + CHR(13) + ;
                            "Alguns grids poder" + CHR(227) + "o aparecer vazios.", "Aviso")
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.AlternarPagina(1)

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()

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
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo
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
                .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"
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
                .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"
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
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es do relat" + CHR(243) + "rio
    *   Original: btnReport.Left=530, Top=0
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
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina (Filtros)
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
    * ConfigurarPaginaLista - Grids selecion" + CHR(225) + "veis e bot" + CHR(245) + "es Marcar/Desmarcar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oPag.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            THIS.ConfigurarGridEmpresas(loc_oPag)
            THIS.ConfigurarGridDisponibilidades(loc_oPag)
            THIS.ConfigurarGridOperacoes(loc_oPag)
            THIS.ConfigurarPaginaDados(loc_oPag)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a p" + CHR(225) + "gina indicada do PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro
        TRY
            IF VARTYPE(par_nPagina) != "N"
                loc_nPagina = 1
            ELSE
                loc_nPagina = par_nPagina
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                IF loc_nPagina < 1
                    loc_nPagina = 1
                ENDIF
                IF loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                    loc_nPagina = THIS.pgf_4c_Paginas.PageCount
                ENDIF
                THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridEmpresas - Grid de sele" + CHR(231) + CHR(227) + "o de empresas (Grid1 no legado)
    *   Original: top=186, left=307, width=357, height=185
    *   Page1: top=101 (186-85), left=307
    *   Cursor: cEmp (ImpEmps LOGICAL, Cemps, Razas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridEmpresas(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label " Empresas " (original top=168, left=309)
            par_oPag.AddObject("lbl_4c_LblEmpresas", "Label")
            WITH par_oPag.lbl_4c_LblEmpresas
                .Top        = 83
                .Left       = 309
                .Width      = 63
                .Height     = 15
                .Caption    = " Empresas "
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackStyle  = 0
                .Visible    = .T.
            ENDWITH

            *-- Grid de empresas (original: top=186, left=307, width=357, height=185)
            par_oPag.AddObject("grd_4c_Empresas", "Grid")
            loc_oGrd = par_oPag.grd_4c_Empresas
            loc_oGrd.ColumnCount = 3
            IF USED("cEmp")
                loc_oGrd.RecordSource = "cEmp"
            ENDIF
            WITH loc_oGrd
                .Top                = 101
                .Left               = 307
                .Width              = 357
                .Height             = 185
                .FontName           = "Tahoma"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .HeaderHeight       = 0
                .ScrollBars         = 2
                .RowHeight          = 16

                .Column1.Width = 15
                .Column2.Width = 30
                .Column3.Width = 289

                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column1.Sparse           = .F.
                .Column2.ReadOnly         = .T.
                .Column2.Movable          = .F.
                .Column2.Resizable        = .F.
                .Column3.ReadOnly         = .T.
                .Column3.Movable          = .F.
                .Column3.Resizable        = .F.

                .Column1.ControlSource = "cEmp.ImpEmps"
                .Column2.ControlSource = "cEmp.Cemps"
                .Column3.ControlSource = "cEmp.Razas"

                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = ""
                .Column3.Header1.Caption = ""

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Empresas (original: top=239, left=669)
            par_oPag.AddObject("cmd_4c_MarcarEmp", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarEmp
                .Top           = 239
                .Left          = 669
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Empresas"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarEmp, "Click", THIS, "BtnMarcarEmpClick")

            *-- Botao Desmarcar Empresas (original: top=279, left=669)
            par_oPag.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarEmp
                .Top           = 279
                .Left          = 669
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Empresas"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarEmp, "Click", THIS, "BtnDesmarcarEmpClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridDisponibilidades - Grid de sele" + CHR(231) + CHR(227) + "o de disponibilidades
    *   Original: top=428, left=74, width=196, height=111
    *   Page1: top=343 (428-85), left=74
    *   Cursor: cDisp (ImpDisps LOGICAL, Grupos, Contas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridDisponibilidades(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label " Disponibilidades " (original top=412, left=76)
            par_oPag.AddObject("lbl_4c_LblDisps", "Label")
            WITH par_oPag.lbl_4c_LblDisps
                .Top        = 327
                .Left       = 76
                .Width      = 99
                .Height     = 15
                .Caption    = " Disponibilidades "
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackStyle  = 0
                .Visible    = .T.
            ENDWITH

            *-- Grid de disponibilidades (original: top=428, left=74, width=196, height=111)
            par_oPag.AddObject("grd_4c_Disps", "Grid")
            loc_oGrd = par_oPag.grd_4c_Disps
            loc_oGrd.ColumnCount = 3
            IF USED("cDisp")
                loc_oGrd.RecordSource = "cDisp"
            ENDIF
            WITH loc_oGrd
                .Top                = 343
                .Left               = 74
                .Width              = 196
                .Height             = 111
                .FontName           = "Tahoma"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .HeaderHeight       = 0
                .ScrollBars         = 2
                .RowHeight          = 16

                .Column1.Width = 15
                .Column2.Width = 79
                .Column3.Width = 79

                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column1.Sparse           = .F.
                .Column2.ReadOnly         = .T.
                .Column2.Movable          = .F.
                .Column2.Resizable        = .F.
                .Column3.ReadOnly         = .T.
                .Column3.Movable          = .F.
                .Column3.Resizable        = .F.

                .Column1.ControlSource = "cDisp.ImpDisps"
                .Column2.ControlSource = "cDisp.Grupos"
                .Column3.ControlSource = "cDisp.Contas"

                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = ""
                .Column3.Header1.Caption = ""

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Disponibilidades (original: top=448, left=275)
            par_oPag.AddObject("cmd_4c_MarcarDisp", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarDisp
                .Top           = 446
                .Left          = 275
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Disponibilidades"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarDisp, "Click", THIS, "BtnMarcarDispClick")

            *-- Botao Desmarcar Disponibilidades (original: top=489, left=275)
            par_oPag.AddObject("cmd_4c_DesmarcarDisp", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarDisp
                .Top           = 448
                .Left          = 275
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Disponibilidades"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarDisp, "Click", THIS, "BtnDesmarcarDispClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridOperacoes - Grid de sele" + CHR(231) + CHR(227) + "o de opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos
    *   Original: top=428, left=380, width=257, height=111 (2 colunas)
    *   Page1: top=343 (428-85), left=380
    *   Cursor: crSigOpOpe (SeleOp LOGICAL, Dopes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label " Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos " (original top=410, left=381)
            par_oPag.AddObject("lbl_4c_LblOper", "Label")
            WITH par_oPag.lbl_4c_LblOper
                .Top        = 325
                .Left       = 381
                .Width      = 126
                .Height     = 15
                .Caption    = " Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos "
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackStyle  = 0
                .Visible    = .T.
            ENDWITH

            *-- Grid de operacoes (original: top=428, left=380, width=257, height=111 - 2 colunas)
            par_oPag.AddObject("grd_4c_Oper", "Grid")
            loc_oGrd = par_oPag.grd_4c_Oper
            loc_oGrd.ColumnCount = 2
            IF USED("crSigOpOpe")
                loc_oGrd.RecordSource = "crSigOpOpe"
            ENDIF
            WITH loc_oGrd
                .Top                = 343
                .Left               = 380
                .Width              = 257
                .Height             = 111
                .FontName           = "Tahoma"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .HeaderHeight       = 0
                .ScrollBars         = 2
                .RowHeight          = 16

                .Column1.Width = 15
                .Column2.Width = 220

                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column1.Sparse           = .F.
                .Column2.ReadOnly         = .T.
                .Column2.Movable          = .F.
                .Column2.Resizable        = .F.
                .Column2.BackColor        = RGB(255, 255, 255)

                .Column1.ControlSource = "crSigOpOpe.SeleOp"
                .Column2.ControlSource = "crSigOpOpe.Dopes"

                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = ""

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Operacoes (original: top=446, left=642)
            par_oPag.AddObject("cmd_4c_MarcarOpe", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarOpe
                .Top           = 446
                .Left          = 642
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarOpe, "Click", THIS, "BtnMarcarOpeClick")

            *-- Botao Desmarcar Operacoes (original: top=487, left=642)
            par_oPag.AddObject("cmd_4c_DesmarcarOpe", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarOpe
                .Top           = 446
                .Left          = 642
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarOpe, "Click", THIS, "BtnDesmarcarOpeClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Controles de filtro do SIGREFFN
    *   Posicoes: SCX Top - PageFrame.Top(85) = top na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPag)
        LOCAL loc_oErro
        TRY
            *== SECAO PERIODO (original: lbl top=178, get_dt top=175) =========

            par_oPag.AddObject("lbl_4c_Periodo", "Label")
            WITH par_oPag.lbl_4c_Periodo
                .Top       = 93
                .Left      = 64
                .Width     = 45
                .Height    = 15
                .Caption   = "Per" + CHR(237) + "odo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
            WITH par_oPag.txt_4c__dt_inicial
                .Top      = 90
                .Left     = 112
                .Width    = 80
                .Height   = 23
                .Value    = {}
                .Format   = "K"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            par_oPag.AddObject("lbl_4c_PeriodoA", "Label")
            WITH par_oPag.lbl_4c_PeriodoA
                .Top       = 94
                .Left      = 195
                .Width     = 8
                .Height    = 15
                .Caption   = CHR(224)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c__dt_final", "TextBox")
            WITH par_oPag.txt_4c__dt_final
                .Top      = 90
                .Left     = 206
                .Width    = 80
                .Height   = 23
                .Value    = {}
                .Format   = "K"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *== SECAO MOEDA DE REFERENCIA (original: lbl top=202, get_cd top=199) =

            par_oPag.AddObject("lbl_4c_Moeda", "Label")
            WITH par_oPag.lbl_4c_Moeda
                .Top       = 117
                .Left      = 68
                .Width     = 41
                .Height    = 15
                .Caption   = "Moeda :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
            WITH par_oPag.txt_4c__cd_moeda
                .Top           = 114
                .Left          = 112
                .Width         = 31
                .Height        = 23
                .Value         = ""
                .MaxLength     = 3
                .Format        = "K"
                .FontName      = "Courier New"
                .FontSize      = 9
                .ForeColor     = RGB(0, 0, 0)
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Alignment     = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
            BINDEVENT(par_oPag.txt_4c__cd_moeda, "DblClick", THIS, "TeclaCdMoedaDblClick")

            par_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
            WITH par_oPag.txt_4c__ds_moeda
                .Top       = 114
                .Left      = 145
                .Width     = 115
                .Height    = 23
                .Value     = ""
                .MaxLength = 15
                .Format    = "K"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")
            BINDEVENT(par_oPag.txt_4c__ds_moeda, "DblClick", THIS, "TeclaDsMoedaDblClick")

            *== SECAO COTACAO (original: lbl top=226, get top=223) =============

            par_oPag.AddObject("lbl_4c_Cotacao", "Label")
            WITH par_oPag.lbl_4c_Cotacao
                .Top       = 141
                .Left      = 60
                .Width     = 49
                .Height    = 15
                .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c_cotacao", "TextBox")
            WITH par_oPag.txt_4c_cotacao
                .Top           = 138
                .Left          = 112
                .Width         = 80
                .Height        = 23
                .Value         = 0
                .InputMask     = "999,999.99"
                .Alignment     = 1
                .Format        = "K"
                .FontName      = "Tahoma"
                .FontSize      = 9
                .ForeColor     = RGB(0, 0, 0)
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *== SECAO MOEDA DE LANCAMENTO (original: lbl top=250, get top=247) =

            par_oPag.AddObject("lbl_4c_MoeLanc", "Label")
            WITH par_oPag.lbl_4c_MoeLanc
                .Top       = 165
                .Left      = 62
                .Width     = 47
                .Height    = 15
                .Caption   = "Moe Lan" + CHR(231)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c_cd_moedl", "TextBox")
            WITH par_oPag.txt_4c_cd_moedl
                .Top           = 162
                .Left          = 112
                .Width         = 31
                .Height        = 23
                .Value         = ""
                .MaxLength     = 3
                .Format        = "K"
                .FontName      = "Courier New"
                .FontSize      = 9
                .ForeColor     = RGB(0, 0, 0)
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Alignment     = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c_cd_moedl, "KeyPress", THIS, "TeclaCdMoedl")
            BINDEVENT(par_oPag.txt_4c_cd_moedl, "DblClick", THIS, "TeclaCdMoedlDblClick")

            par_oPag.AddObject("txt_4c_ds_moedl", "TextBox")
            WITH par_oPag.txt_4c_ds_moedl
                .Top       = 162
                .Left      = 145
                .Width     = 115
                .Height    = 23
                .Value     = ""
                .MaxLength = 15
                .Format    = "K"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c_ds_moedl, "KeyPress", THIS, "TeclaDsMoedl")
            BINDEVENT(par_oPag.txt_4c_ds_moedl, "DblClick", THIS, "TeclaDsMoedlDblClick")

            *== CHECKBOXES (original: Check1 top=271, Conc top=271) ===========

            par_oPag.AddObject("chk_4c_TotalizaContas", "CheckBox")
            WITH par_oPag.chk_4c_TotalizaContas
                .Top       = 186
                .Left      = 64
                .Width     = 92
                .Height    = 15
                .Caption   = "Totaliza Contas"
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("chk_4c_Conciliado", "CheckBox")
            WITH par_oPag.chk_4c_Conciliado
                .Top       = 271
                .Left      = 183
                .Width     = 66
                .Height    = 15
                .Caption   = "Conciliado"
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *== SECAO OPCAO NF (original: Say1 top=290, Opt_Opcao top=285) ====

            par_oPag.AddObject("lbl_4c_Opcao", "Label")
            WITH par_oPag.lbl_4c_Opcao
                .Top       = 205
                .Left      = 64
                .Width     = 40
                .Height    = 15
                .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_opcao", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_opcao
                .Top           = 285
                .Left          = 105
                .Width         = 177
                .Height        = 25
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 3
            ENDWITH
            WITH par_oPag.obj_4c_Opt_opcao.Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_opcao.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 62
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_opcao.Buttons(3)
                .Caption   = "Ambos"
                .WordWrap        = .T.
                .Top       = 5
                .Left      = 117
                .Width     = 50
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH

            *== SECAO FLUXO / TIPO IMPRESSAO (original: Say4 top=308, opt_tipo top=307) =

            par_oPag.AddObject("lbl_4c_Fluxo", "Label")
            WITH par_oPag.lbl_4c_Fluxo
                .Top       = 223
                .Left      = 70
                .Width     = 35
                .Height    = 15
                .Caption   = "Fluxo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_tipo", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_tipo
                .Top           = 307
                .Left          = 105
                .Width         = 166
                .Height        = 35
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 1
            ENDWITH
            WITH par_oPag.obj_4c_Opt_tipo.Buttons(1)
                .Caption   = "Di" + CHR(225) + "rio"
                .Top       = 1
                .Left      = 5
                .Width     = 45
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_tipo.Buttons(2)
                .Caption   = "Semanal"
                .Top       = 1
                .Left      = 88
                .Width     = 58
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_tipo.Buttons(3)
                .Caption   = "Quinzenal"
                .WordWrap        = .T.
                .Top       = 17
                .Left      = 5
                .Width     = 75
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH par_oPag.obj_4c_Opt_tipo.Buttons(4)
                .Caption   = "Mensal"
                .WordWrap        = .T.
                .Top       = 18
                .Left      = 88
                .Width     = 61
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *== SECAO LISTAR ATRASOS (original: Say7 top=342, opt_Lista_Atra top=337) =

            par_oPag.AddObject("lbl_4c_ListaAtra", "Label")
            WITH par_oPag.lbl_4c_ListaAtra
                .Top       = 257
                .Left      = 85
                .Width     = 75
                .Height    = 15
                .Caption   = "Listar Atrasos :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_lista_atra", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_lista_atra
                .Top           = 337
                .Left          = 174
                .Width         = 109
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 1
            ENDWITH
            WITH par_oPag.obj_4c_Opt_lista_atra.Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_lista_atra.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 62
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            BINDEVENT(par_oPag.obj_4c_Opt_lista_atra, "InteractiveChange", THIS, "OptListaAtraChange")

            *== SECAO CONSIDERAR ATRASOS (original: Say5 top=362, Opt_Consid top=357) =

            par_oPag.AddObject("lbl_4c_ConsidAtra", "Label")
            WITH par_oPag.lbl_4c_ConsidAtra
                .Top       = 277
                .Left      = 54
                .Width     = 101
                .Height    = 15
                .Caption   = "Considerar Atrasos :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_consid_atra", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_consid_atra
                .Top           = 357
                .Left          = 174
                .Width         = 109
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 2
            ENDWITH
            WITH par_oPag.obj_4c_Opt_consid_atra.Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_consid_atra.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 62
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH

            *== SECAO PREVISTO (original: Say8 top=380, OptPrev top=376) =======

            par_oPag.AddObject("lbl_4c_Previsto", "Label")
            WITH par_oPag.lbl_4c_Previsto
                .Top       = 295
                .Left      = 60
                .Width     = 48
                .Height    = 15
                .Caption   = "Previsto :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_prev", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_prev
                .Top           = 291
                .Left          = 112
                .Width         = 172
                .Height        = 27
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 3
            ENDWITH
            WITH par_oPag.obj_4c_Opt_prev.Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 57
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH par_oPag.obj_4c_Opt_prev.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 56
                .Width     = 49
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH par_oPag.obj_4c_Opt_prev.Buttons(3)
                .Caption   = "Ambos"
                .WordWrap        = .T.
                .Top       = 5
                .Left      = 107
                .Width     = 55
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *== SECAO SITUACAO (RIGHT - original: Say6 top=379, left=309, opt_situa top=374) =

            par_oPag.AddObject("lbl_4c_Situa", "Label")
            WITH par_oPag.lbl_4c_Situa
                .Top       = 294
                .Left      = 309
                .Width     = 50
                .Height    = 15
                .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_situa", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_situa
                .Top           = 374
                .Left          = 361
                .Width         = 225
                .Height        = 27
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 2
            ENDWITH
            WITH par_oPag.obj_4c_Opt_situa.Buttons(1)
                .Caption   = "Baixados"
                .Top       = 5
                .Left      = 5
                .Width     = 61
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_situa.Buttons(2)
                .Caption   = "Pendentes"
                .Top       = 5
                .Left      = 78
                .Width     = 67
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_situa.Buttons(3)
                .Caption   = "Todos"
                .WordWrap        = .T.
                .Top       = 5
                .Left      = 162
                .Width     = 53
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *== SECAO SALDO (original: Say3 top=539, OptSaldo top=534) =========

            par_oPag.AddObject("lbl_4c_Saldo", "Label")
            WITH par_oPag.lbl_4c_Saldo
                .Top       = 454
                .Left      = 81
                .Width     = 35
                .Height    = 15
                .Caption   = "Saldo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_saldo", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_saldo
                .Top           = 449
                .Left          = 122
                .Width         = 142
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 1
            ENDWITH
            WITH par_oPag.obj_4c_Opt_saldo.Buttons(1)
                .Caption   = "Anterior"
                .Top       = 5
                .Left      = 5
                .Width     = 57
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_saldo.Buttons(2)
                .Caption   = "Na Data"
                .Top       = 5
                .Left      = 75
                .Width     = 57
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padr" + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPag.txt_4c__dt_inicial.Value  = THIS.this_oRelatorio.this_dDtInicial
                loc_oPag.txt_4c__dt_final.Value    = THIS.this_oRelatorio.this_dDtFinal
                loc_oPag.txt_4c__cd_moeda.Value    = THIS.this_oRelatorio.this_cCdMoeda
                loc_oPag.txt_4c__ds_moeda.Value    = THIS.this_oRelatorio.this_cDsMoeda
                loc_oPag.txt_4c_cotacao.Value      = THIS.this_oRelatorio.this_nVlCotacao
            ELSE
                loc_oPag.txt_4c__dt_inicial.Value  = DATE()
                loc_oPag.txt_4c__dt_final.Value    = DATE()
                loc_oPag.txt_4c__cd_moeda.Value    = ""
                loc_oPag.txt_4c__ds_moeda.Value    = ""
                loc_oPag.txt_4c_cotacao.Value      = 0
            ENDIF

            loc_oPag.txt_4c__ds_moeda.ReadOnly          = .F.
            loc_oPag.txt_4c_cd_moedl.Value              = ""
            loc_oPag.txt_4c_ds_moedl.Value              = ""
            loc_oPag.txt_4c_ds_moedl.ReadOnly           = .F.
            loc_oPag.chk_4c_TotalizaContas.Value        = 0
            loc_oPag.chk_4c_Conciliado.Value            = 0
            loc_oPag.obj_4c_Opt_opcao.Value             = 3
            loc_oPag.obj_4c_Opt_tipo.Value              = 1
            loc_oPag.obj_4c_Opt_lista_atra.Value        = 1
            loc_oPag.obj_4c_Opt_consid_atra.Value       = 2
            loc_oPag.obj_4c_Opt_consid_atra.Enabled     = .T.
            loc_oPag.obj_4c_Opt_prev.Value              = 3
            loc_oPag.obj_4c_Opt_situa.Value             = 2
            loc_oPag.obj_4c_Opt_saldo.Value             = 1

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            WITH THIS.this_oRelatorio
                .this_dDtInicial      = loc_oPag.txt_4c__dt_inicial.Value
                .this_dDtFinal        = loc_oPag.txt_4c__dt_final.Value
                .this_cCdMoeda        = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
                .this_cDsMoeda        = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
                .this_nVlCotacao      = loc_oPag.txt_4c_cotacao.Value
                .this_cCdMoedl        = ALLTRIM(loc_oPag.txt_4c_cd_moedl.Value)
                .this_cDsMoedl        = ALLTRIM(loc_oPag.txt_4c_ds_moedl.Value)
                .this_nTotalizaContas = loc_oPag.chk_4c_TotalizaContas.Value
                .this_nConciliado     = loc_oPag.chk_4c_Conciliado.Value
                .this_nOpcao          = loc_oPag.obj_4c_Opt_opcao.Value
                .this_nTipoImp        = loc_oPag.obj_4c_Opt_tipo.Value
                .this_nListaAtra      = loc_oPag.obj_4c_Opt_lista_atra.Value
                .this_nConsidAtra     = loc_oPag.obj_4c_Opt_consid_atra.Value
                .this_nPrev           = loc_oPag.obj_4c_Opt_prev.Value
                .this_nSitua          = loc_oPag.obj_4c_Opt_situa.Value
                .this_nSaldo          = loc_oPag.obj_4c_Opt_saldo.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relat" + CHR(243) + "rio em tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados para Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.GerarDocumentoExcel()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Gerar Excel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - N" + CHR(227) + "o aplic" + CHR(225) + "vel em formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        MsgInfo("Este " + CHR(233) + " um formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
                "Configure os filtros e use Visualizar ou Imprimir.", ;
                "Relat" + CHR(243) + "rio Fluxo Financeiro")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - N" + CHR(227) + "o aplic" + CHR(225) + "vel em formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        MsgInfo("Este " + CHR(233) + " um formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
                "Os par" + CHR(226) + "metros podem ser editados diretamente nos campos.", ;
                "Relat" + CHR(243) + "rio Fluxo Financeiro")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Limpa filtros
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Limpar todos os filtros e restaurar valores padr" + CHR(227) + "o?", ;
                       "Limpar Filtros")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarEmpClick - Marca todas as empresas para impress" + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarEmpClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarEmpresas()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Empresas.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarEmpClick - Desmarca todas as empresas
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarEmpClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarEmpresas()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Empresas.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarDispClick - Marca todas as disponibilidades
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarDispClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarDisponibilidades()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Disps.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarDispClick - Desmarca todas as disponibilidades
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarDispClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarDisponibilidades()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Disps.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarOpeClick - Marca todas as opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarOpeClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarOperacoes()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Oper.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarOpeClick - Desmarca todas as opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarOpeClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarOperacoes()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Oper.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress: F4/Enter/Tab valida codigo de moeda referencia
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarCdMoeda(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress: F4/Enter/Tab lookup reverso por descri" + CHR(231) + CHR(227) + "o moeda ref
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarDsMoeda(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoedl - KeyPress: F4/Enter/Tab valida codigo de moeda lan" + CHR(231) + "amento
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoedl(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarCdMoedl(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoedl - KeyPress: F4/Enter/Tab lookup reverso por descri" + CHR(231) + CHR(227) + "o moe lanc
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoedl(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarDsMoedl(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoedaDblClick - DblClick em txt_4c__cd_moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoedaDblClick()
        THIS.ValidarCdMoeda(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoedaDblClick - DblClick em txt_4c__ds_moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoedaDblClick()
        THIS.ValidarDsMoeda(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoedlDblClick - DblClick em txt_4c_cd_moedl
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoedlDblClick()
        THIS.ValidarCdMoedl(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoedlDblClick - DblClick em txt_4c_ds_moedl
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoedlDblClick()
        THIS.ValidarDsMoedl(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo de moeda referencia (SigCdMoe)
    *   Preenche descri" + CHR(231) + CHR(227) + "o e atualiza cota" + CHR(231) + CHR(227) + "o quando codigo encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda(par_oPag)
        LOCAL loc_cCodigo, loc_oForm, loc_oErro
        TRY
            loc_cCodigo = ALLTRIM(par_oPag.txt_4c__cd_moeda.Value)
            IF EMPTY(loc_cCodigo)
                par_oPag.txt_4c__cd_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.ReadOnly = .F.
                par_oPag.txt_4c_cotacao.Value      = 0
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cCodigo, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                        par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
                        *-- Atualiza cotacao automaticamente
                        IF VARTYPE(THIS.this_oRelatorio) = "O"
                            par_oPag.txt_4c_cotacao.Value = ;
                                THIS.this_oRelatorio.BuscarCotacaoAtual( ;
                                    ALLTRIM(cursor_4c_BuscaMoe.CMoes))
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c__cd_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.ReadOnly = .F.
                par_oPag.txt_4c_cotacao.Value      = 0
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoeda")
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Lookup reverso por descri" + CHR(231) + CHR(227) + "o de moeda referencia
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda(par_oPag)
        LOCAL loc_cDesc, loc_oForm, loc_oErro
        TRY
            loc_cDesc = ALLTRIM(par_oPag.txt_4c__ds_moeda.Value)
            IF EMPTY(loc_cDesc)
                par_oPag.txt_4c__cd_moeda.Value = ""
                par_oPag.txt_4c__ds_moeda.Value = ""
                par_oPag.txt_4c_cotacao.Value   = 0
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cDesc, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeD")
                    SELECT cursor_4c_BuscaMoeD
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
                        par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
                        IF VARTYPE(THIS.this_oRelatorio) = "O"
                            par_oPag.txt_4c_cotacao.Value = ;
                                THIS.this_oRelatorio.BuscarCotacaoAtual( ;
                                    ALLTRIM(cursor_4c_BuscaMoeD.CMoes))
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c__cd_moeda.Value = ""
                par_oPag.txt_4c__ds_moeda.Value = ""
                par_oPag.txt_4c_cotacao.Value   = 0
            ENDIF
            IF USED("cursor_4c_BuscaMoeD")
                USE IN cursor_4c_BuscaMoeD
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDsMoeda")
            IF USED("cursor_4c_BuscaMoeD")
                USE IN cursor_4c_BuscaMoeD
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoedl - Valida codigo de moeda de lan" + CHR(231) + "amento (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoedl(par_oPag)
        LOCAL loc_cCodigo, loc_oForm, loc_oErro
        TRY
            loc_cCodigo = ALLTRIM(par_oPag.txt_4c_cd_moedl.Value)
            IF EMPTY(loc_cCodigo)
                par_oPag.txt_4c_cd_moedl.Value    = ""
                par_oPag.txt_4c_ds_moedl.Value    = ""
                par_oPag.txt_4c_ds_moedl.ReadOnly = .F.
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeL", "CMoes", loc_cCodigo, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda Lan" + CHR(231) + "amento")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeL")
                    SELECT cursor_4c_BuscaMoeL
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c_cd_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeL.CMoes)
                        par_oPag.txt_4c_ds_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeL.DMoes)
                        par_oPag.txt_4c_ds_moedl.ReadOnly = .T.
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c_cd_moedl.Value    = ""
                par_oPag.txt_4c_ds_moedl.Value    = ""
                par_oPag.txt_4c_ds_moedl.ReadOnly = .F.
            ENDIF
            IF USED("cursor_4c_BuscaMoeL")
                USE IN cursor_4c_BuscaMoeL
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoedl")
            IF USED("cursor_4c_BuscaMoeL")
                USE IN cursor_4c_BuscaMoeL
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoedl - Lookup reverso por descri" + CHR(231) + CHR(227) + "o de moeda lan" + CHR(231) + "amento
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoedl(par_oPag)
        LOCAL loc_cDesc, loc_oForm, loc_oErro
        TRY
            loc_cDesc = ALLTRIM(par_oPag.txt_4c_ds_moedl.Value)
            IF EMPTY(loc_cDesc)
                par_oPag.txt_4c_cd_moedl.Value = ""
                par_oPag.txt_4c_ds_moedl.Value = ""
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeLD", "DMoes", loc_cDesc, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda Lan" + CHR(231) + "amento")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeLD")
                    SELECT cursor_4c_BuscaMoeLD
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c_cd_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeLD.CMoes)
                        par_oPag.txt_4c_ds_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeLD.DMoes)
                        par_oPag.txt_4c_ds_moedl.ReadOnly = .T.
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c_cd_moedl.Value = ""
                par_oPag.txt_4c_ds_moedl.Value = ""
            ENDIF
            IF USED("cursor_4c_BuscaMoeLD")
                USE IN cursor_4c_BuscaMoeLD
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDsMoedl")
            IF USED("cursor_4c_BuscaMoeLD")
                USE IN cursor_4c_BuscaMoeLD
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptListaAtraChange - Habilita/desabilita ConsidAtra conforme ListaAtra
    *   Quando "Listar Atrasos = N" + CHR(227) + "o" (Value=2): desabilita ConsidAtra
    *--------------------------------------------------------------------------
    PROCEDURE OptListaAtraChange()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF loc_oPag.obj_4c_Opt_lista_atra.Value = 2
                loc_oPag.obj_4c_Opt_consid_atra.Value   = 2
                loc_oPag.obj_4c_Opt_consid_atra.Enabled = .F.
            ELSE
                loc_oPag.obj_4c_Opt_consid_atra.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OptListaAtraChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Alias: visualiza relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Imprime relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa filtros
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Limpar todos os filtros e restaurar valores padr" + CHR(227) + "o?", ;
                       "Limpar Filtros")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio para conformidade com API
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO de volta para os campos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPag.txt_4c__dt_inicial.Value        = .this_dDtInicial
                loc_oPag.txt_4c__dt_final.Value          = .this_dDtFinal
                loc_oPag.txt_4c__cd_moeda.Value          = .this_cCdMoeda
                loc_oPag.txt_4c__ds_moeda.Value          = .this_cDsMoeda
                loc_oPag.txt_4c_cotacao.Value            = .this_nVlCotacao
                loc_oPag.txt_4c_cd_moedl.Value           = .this_cCdMoedl
                loc_oPag.txt_4c_ds_moedl.Value           = .this_cDsMoedl
                loc_oPag.chk_4c_TotalizaContas.Value     = .this_nTotalizaContas
                loc_oPag.chk_4c_Conciliado.Value         = .this_nConciliado
                loc_oPag.obj_4c_Opt_opcao.Value          = .this_nOpcao
                loc_oPag.obj_4c_Opt_tipo.Value           = .this_nTipoImp
                loc_oPag.obj_4c_Opt_lista_atra.Value     = .this_nListaAtra
                loc_oPag.obj_4c_Opt_consid_atra.Value    = .this_nConsidAtra
                loc_oPag.obj_4c_Opt_prev.Value           = .this_nPrev
                loc_oPag.obj_4c_Opt_situa.Value          = .this_nSitua
                loc_oPag.obj_4c_Opt_saldo.Value          = .this_nSaldo
            ENDWITH
            loc_oPag.txt_4c__ds_moeda.ReadOnly      = !EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value))
            loc_oPag.txt_4c_ds_moedl.ReadOnly       = !EMPTY(ALLTRIM(loc_oPag.txt_4c_cd_moedl.Value))
            loc_oPag.obj_4c_Opt_consid_atra.Enabled = (loc_oPag.obj_4c_Opt_lista_atra.Value = 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita todos os campos de filtro para edicao
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oPag.txt_4c__dt_inicial.ReadOnly     = .F.
            loc_oPag.txt_4c__dt_final.ReadOnly       = .F.
            loc_oPag.txt_4c__cd_moeda.ReadOnly       = .F.
            loc_oPag.txt_4c_cotacao.ReadOnly         = .F.
            loc_oPag.txt_4c_cd_moedl.ReadOnly        = .F.
            loc_oPag.chk_4c_TotalizaContas.Enabled   = .T.
            loc_oPag.chk_4c_Conciliado.Enabled       = .T.
            loc_oPag.obj_4c_Opt_opcao.Enabled        = .T.
            loc_oPag.obj_4c_Opt_tipo.Enabled         = .T.
            loc_oPag.obj_4c_Opt_lista_atra.Enabled   = .T.
            loc_oPag.obj_4c_Opt_consid_atra.Enabled  = (loc_oPag.obj_4c_Opt_lista_atra.Value = 1)
            loc_oPag.obj_4c_Opt_prev.Enabled         = .T.
            loc_oPag.obj_4c_Opt_situa.Enabled        = .T.
            loc_oPag.obj_4c_Opt_saldo.Enabled        = .T.
            loc_oPag.txt_4c__ds_moeda.ReadOnly = !EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value))
            loc_oPag.txt_4c_ds_moedl.ReadOnly  = !EMPTY(ALLTRIM(loc_oPag.txt_4c_cd_moedl.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza grids de sele" + CHR(231) + CHR(227) + "o (Empresas/Disps/Opera" + CHR(231) + CHR(245) + "es)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oPag, loc_oErro, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPag = THIS.pgf_4c_Paginas.Page1
                IF VARTYPE(loc_oPag.grd_4c_Empresas) = "O" AND USED("cEmp")
                    loc_oPag.grd_4c_Empresas.RecordSource = "cEmp"
                    loc_oPag.grd_4c_Empresas.Refresh()
                ENDIF
                IF VARTYPE(loc_oPag.grd_4c_Disps) = "O" AND USED("cDisp")
                    loc_oPag.grd_4c_Disps.RecordSource = "cDisp"
                    loc_oPag.grd_4c_Disps.Refresh()
                ENDIF
                IF VARTYPE(loc_oPag.grd_4c_Oper) = "O" AND USED("crSigOpOpe")
                    loc_oPag.grd_4c_Oper.RecordSource = "crSigOpOpe"
                    loc_oPag.grd_4c_Oper.Refresh()
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita bot" + CHR(245) + "es do relat" + CHR(243) + "rio (sem modos CRUD)
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
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
