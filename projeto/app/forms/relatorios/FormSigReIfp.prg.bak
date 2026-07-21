*==============================================================================
* FORMSIGREIFP.PRG
* Relatorio de Falhas / Perdas
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIFP.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo        (data inicial / data final)
*   - NivImprs       (tipo de relatorio 1-7 via Spinner)
*   - TpMat          (tipo de material - SigOpOpt WHERE Situas=3) [Nivel 7]
*   - Ifor/Dfor      (recuperadora codigo/descricao - SigCdCli)   [Nivel 7]
*   - CdGrupo/DsGrupo (setor codigo/descricao - SigCdGcr)        [Nivel 7]
*
* FRXs: SigReIfA (niv=1), SigReIfB (niv=2), SigReIfC (niv=3,4),
*        SigReIfD (niv=5), SigReIfE (niv=6), SigReIfF (niv=7)
*
* Objetos (mapeamento.json):
*   shp_4c_Shp_materia_prima, lbl_4c_Label1, lbl_4c_Lbl_periodo,
*   txt_4c_DsGrupo, txt_4c_CdGrupo, txt_4c__dt_inicial, lbl_4c_Lbl_periodo_a,
*   txt_4c__dt_final, lbl_4c_Label2, lbl_4c_Label3, txt_4c__ifor,
*   txt_4c__tpmat, txt_4c__dfor, obj_4c_NivImprs, lbl_4c_Label4
*==============================================================================

DEFINE CLASS FormSigReIfp AS FormBase

    *-- Dimensoes exatas do original (Width=647, Height=254)
    Height      = 254
    Width       = 647
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
    * InicializarForm - Cria estrutura do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria SigReIfpBO (pula em modo UI sem conexao SQL)
    *   3. Monta cabecalho escuro + botoes + PageFrame com filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Falhas / Perdas"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Em modo de validacao UI, nao criar BO (SigReIfpBO.Init() faz SQLEXEC)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("SigReIfpBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar SigReIfpBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.ZOrder(1)

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
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
                .Caption   = "Relat" + CHR(243) + "rio de Falhas / Perdas"
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
                .Caption   = "Relat" + CHR(243) + "rio de Falhas / Perdas"
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
    * ConfigurarBotoes - CommandGroup de 4 botoes do relatorio
    *   Original: btnReport.Left=340, Width=310, 4 botoes (V/I/D/S)
    *   Novo: cmg_4c_Botoes.Left=340, Width=273, botoes Width=65
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 340
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
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   Form original eh flat; no novo padrao os filtros ficam em Page1
    *   do PageFrame para consistencia com os demais forms de relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top    = 0
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height
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
    * ConfigurarPaginaLista - Configura Page1 com os controles de filtro
    *   Em forms REPORT (frmrelatorio) a unica pagina exibida ao usuario eh
    *   a pagina de filtros - mantemos o nome "Lista" por compatibilidade
    *   com o pipeline multi-fase, mas a semantica para relatorios eh
    *   "pagina principal de parametros". Delegamos para ConfigurarPaginaFiltros
    *   que contem a implementacao real (Shape decorativo + 15 controles).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Posiciona o PageFrame na pagina solicitada
    *   Em forms REPORT existe apenas Page1 (filtros). Qualquer valor diferente
    *   de 1 eh normalizado para 1, garantindo que callers genericos do pipeline
    *   (que assumem CRUD com Page1/Page2) nao quebrem o relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
                AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount, ;
                par_nPagina, 1)
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            THIS.pgf_4c_Paginas.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Adiciona todos os controles de filtro em Page1
    *   Posicoes: originais do SCX (relativas ao form); PageFrame.Top=0
    *   Campos de nivel 7 (TpMat, Ifor/Dfor, CdGrupo/DsGrupo) ficam dentro da
    *   borda decorativa shp_4c_Shp_materia_prima (top=96, h=139).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Borda decorativa ao redor dos campos de nivel 7
        *   Original: top=96, left=86, w=461, h=139
        loc_oPg.AddObject("shp_4c_Shp_materia_prima", "Shape")
        WITH loc_oPg.shp_4c_Shp_materia_prima
            .Top         = 96
            .Left        = 86
            .Width       = 461
            .Height      = 139
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Label "Periodo :" (original: top=104, left=147)
        loc_oPg.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oPg.lbl_4c_Lbl_periodo
            .AutoSize  = .T.
            .Top       = 104
            .Left      = 147
            .Width     = 45
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (original: top=101, left=199)
        loc_oPg.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH loc_oPg.txt_4c__dt_inicial
            .Top         = 101
            .Left        = 199
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Separador "a" entre datas (original: top=104, left=284)
        loc_oPg.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oPg.lbl_4c_Lbl_periodo_a
            .AutoSize  = .T.
            .Top       = 104
            .Left      = 284
            .Width     = 8
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final (original: top=101, left=295)
        loc_oPg.AddObject("txt_4c__dt_final", "TextBox")
        WITH loc_oPg.txt_4c__dt_final
            .Top         = 101
            .Left        = 295
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Tipo de Relatorio:" (original: top=132, left=105)
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Top       = 132
            .Left      = 105
            .Caption   = "Tipo de Relat" + CHR(243) + "rio:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Spinner NivImprs (original: top=127, left=199)
        *   Range 0-7 conforme original (KeyboardLowValue=0, KeyboardHighValue=7)
        loc_oPg.AddObject("obj_4c_NivImprs", "Spinner")
        WITH loc_oPg.obj_4c_NivImprs
            .Top                = 127
            .Left               = 199
            .Width              = 33
            .Height             = 25
            .Value              = 1
            .SpinnerHighValue   = 7.00
            .SpinnerLowValue    = 0.00
            .KeyboardHighValue  = 7
            .KeyboardLowValue   = 0
            .InputMask          = "9"
            .Format             = "K"
            .FontName           = "Courier New"
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(90, 90, 90)
            .Visible            = .T.
        ENDWITH

        *-- Label "Tipo de Material :" (original: top=157, left=107)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .AutoSize  = .T.
            .Top       = 157
            .Left      = 107
            .Width     = 85
            .Height    = 15
            .Caption   = "Tipo de Material :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Tipo de material (original: top=154, left=199) [Nivel 7]
        loc_oPg.AddObject("txt_4c__tpmat", "TextBox")
        WITH loc_oPg.txt_4c__tpmat
            .Top         = 154
            .Left        = 199
            .Width       = 115
            .Height      = 23
            .Value       = ""
            .MaxLength   = 15
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label "Recuperadora :" (original: top=181, left=115)
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 181
            .Left      = 115
            .Width     = 87
            .Height    = 17
            .Caption   = "Recuperadora :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo recuperadora (original: top=179, left=199) [Nivel 7]
        loc_oPg.AddObject("txt_4c__ifor", "TextBox")
        WITH loc_oPg.txt_4c__ifor
            .Top         = 179
            .Left        = 199
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Descricao recuperadora (original: top=179, left=281) [Nivel 7]
        *   Editavel apenas quando nivel=7 E ifor esta vazio (busca por nome)
        loc_oPg.AddObject("txt_4c__dfor", "TextBox")
        WITH loc_oPg.txt_4c__dfor
            .Top         = 179
            .Left        = 281
            .Width       = 233
            .Height      = 23
            .Value       = ""
            .MaxLength   = 40
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label "Grupo :" (original: top=208, left=154)
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .AutoSize  = .T.
            .Top       = 208
            .Left      = 154
            .Width     = 38
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo do setor (original: top=204, left=199) [Nivel 7]
        loc_oPg.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH loc_oPg.txt_4c_CdGrupo
            .Top         = 204
            .Left        = 199
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .MaxLength   = 10
            .Format      = "K"
            .FontName    = "Courier New"
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Descricao do setor (original: top=204, left=281) [sempre ReadOnly]
        loc_oPg.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oPg.txt_4c_DsGrupo
            .Top         = 204
            .Left        = 281
            .Width       = 233
            .Height      = 25
            .Value       = ""
            .MaxLength   = 20
            .Format      = "K"
            .FontName    = "Courier New"
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Vincular eventos
        BINDEVENT(loc_oPg.txt_4c__dt_inicial, "KeyPress", THIS, "TeclaDtInicial")
        BINDEVENT(loc_oPg.obj_4c_NivImprs,   "InteractiveChange", THIS, "NivImprsChange")
        BINDEVENT(loc_oPg.txt_4c__tpmat,      "KeyPress", THIS, "TeclaTpMat")
        BINDEVENT(loc_oPg.txt_4c__tpmat,      "DblClick", THIS, "AbrirBuscaTpMat")
        BINDEVENT(loc_oPg.txt_4c__ifor,       "KeyPress", THIS, "TeclaIfor")
        BINDEVENT(loc_oPg.txt_4c__ifor,       "DblClick", THIS, "AbrirBuscaCdIfor")
        BINDEVENT(loc_oPg.txt_4c__dfor,       "KeyPress", THIS, "TeclaDfor")
        BINDEVENT(loc_oPg.txt_4c__dfor,       "DblClick", THIS, "AbrirBuscaDfor")
        BINDEVENT(loc_oPg.txt_4c_CdGrupo,     "KeyPress", THIS, "TeclaCdGrupo")
        BINDEVENT(loc_oPg.txt_4c_CdGrupo,     "DblClick", THIS, "AbrirBuscaCdGrupo")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCamposNivel - Habilita/desabilita campos conforme NivImprs
    *   Original: When events de getCdGrupo/get_tpmat/get_ifor = (NivImprs=7)
    *             When de getDsGrupo = Return .F. (sempre ReadOnly)
    *             When de get_dfor = Empty(get_ifor) And (NivImprs=7)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCamposNivel()
        LOCAL loc_oPg, loc_nNiv, loc_lNivel7
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_nNiv   = loc_oPg.obj_4c_NivImprs.Value
            loc_lNivel7 = (loc_nNiv = 7)

            loc_oPg.txt_4c__tpmat.ReadOnly  = !loc_lNivel7
            loc_oPg.txt_4c__ifor.ReadOnly   = !loc_lNivel7
            loc_oPg.txt_4c_CdGrupo.ReadOnly = !loc_lNivel7
            loc_oPg.txt_4c_DsGrupo.ReadOnly = .T.

            *-- Dfor: editavel apenas quando nivel=7 E ifor vazio (busca por nome)
            loc_oPg.txt_4c__dfor.ReadOnly = !(loc_lNivel7 AND EMPTY(ALLTRIM(loc_oPg.txt_4c__ifor.Value)))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c__dt_inicial.Value = DATE()
            loc_oPg.txt_4c__dt_final.Value   = DATE()
            loc_oPg.obj_4c_NivImprs.Value    = 1
            loc_oPg.txt_4c__tpmat.Value      = ""
            loc_oPg.txt_4c__ifor.Value       = ""
            loc_oPg.txt_4c__dfor.Value       = ""
            loc_oPg.txt_4c_CdGrupo.Value     = ""
            loc_oPg.txt_4c_DsGrupo.Value     = ""
            THIS.AtualizarCamposNivel()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial = loc_oPg.txt_4c__dt_inicial.Value
            .this_dDtFinal   = loc_oPg.txt_4c__dt_final.Value
            .this_nNivImprs  = loc_oPg.obj_4c_NivImprs.Value
            .this_cTpMat     = ALLTRIM(loc_oPg.txt_4c__tpmat.Value)
            .this_cIfor      = ALLTRIM(loc_oPg.txt_4c__ifor.Value)
            .this_cDfor      = ALLTRIM(loc_oPg.txt_4c__dfor.Value)
            .this_cCdGrupo   = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
            .this_cDsGrupo   = ALLTRIM(loc_oPg.txt_4c_DsGrupo.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Verifica datas validas antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c__dt_inicial.Value
        loc_dFim = loc_oPg.txt_4c__dt_final.Value
        IF EMPTY(loc_dIni) OR EMPTY(loc_dFim)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF loc_dIni > loc_dFim
            MsgAviso("Data Final menor que a Inicial!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c__dt_final.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOTOES DE RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
                RETURN
            ENDIF
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
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
    * BtnImprimirClick - Imprime relatorio na impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
                RETURN
            ENDIF
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
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
    * BtnExcelClick - Exporta cursor TmpRelat para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cCursor, loc_cArquivo
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
                RETURN
            ENDIF
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
                RETURN
            ENDIF
            loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                RETURN
            ENDIF
            loc_cArquivo = PUTFILE("Salvar como...", "SigReIfp", "XLS")
            IF !EMPTY(loc_cArquivo)
                SELECT (loc_cCursor)
                COPY TO (loc_cArquivo) TYPE XLS
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE CRUD (mapeamento semantico de botoes para form REPORT)
    *   Mapeamento:
    *     - BtnIncluirClick  -> Visualizar (acao primaria do relatorio)
    *     - BtnAlterarClick  -> LimparCampos (reset dos filtros para edicao)
    *     - BtnExcluirClick  -> LimparCampos (limpa filtros = "remove" selecao)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT delega para Visualizar (gerar relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT delega para LimparCampos (alterar filtros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.LimparCampos()
        TRY
            THIS.pgf_4c_Paginas.Page1.txt_4c__dt_inicial.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT delega para LimparCampos (excluir/limpar filtros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * METODOS DE COMPATIBILIDADE CRUD (FASE 8)
    *   Forms REPORT nao tem CRUD, mas o pipeline pode chamar estes metodos.
    *   Mapeamento semantico: Buscar=Visualizar, Encerrar=Sair, Salvar=Imprimir,
    *   Cancelar=LimparCampos, FormParaBO=FormParaRelatorio, os demais sao no-op.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT equivale a Visualizar (gerar relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias de BtnSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT equivale a Imprimir (salvar = imprimir)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT equivale a LimparCampos (cancelar = reset)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        TRY
            THIS.pgf_4c_Paginas.Page1.txt_4c__dt_inicial.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Em REPORT delega para FormParaRelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Em REPORT o fluxo e Form->BO (FormParaRelatorio), sem retorno
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em REPORT atualiza habilitacao conforme nivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT nao ha lista/grid; retorna .T. sem operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT os botoes sao fixos (Visualizar/Imprimir/Excel/Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (BINDEVENT KeyPress)
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    *-- Data inicial: ao sair (ENTER/TAB), ajusta data final se menor que inicial
    PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c__dt_inicial.Value
            loc_dFim = loc_oPg.txt_4c__dt_final.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c__dt_final.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    *-- Spinner NivImprs: InteractiveChange atualiza habilitacao dos campos
    PROCEDURE NivImprsChange()
        THIS.AtualizarCamposNivel()
    ENDPROC

    *-- Tipo de material: F4=lookup, ENTER/TAB=validar
    PROCEDURE TeclaTpMat(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaTpMat()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarTpMat()
        ENDIF
    ENDPROC

    *-- Codigo da recuperadora: F4=lookup, ENTER/TAB=validar
    PROCEDURE TeclaIfor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdIfor()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdIfor()
        ENDIF
    ENDPROC

    *-- Descricao da recuperadora: F4=lookup por nome, ENTER/TAB=validar
    PROCEDURE TeclaDfor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDfor()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDfor()
        ENDIF
    ENDPROC

    *-- Codigo do setor: F4=lookup, ENTER/TAB=validar
    PROCEDURE TeclaCdGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACOES DE CAMPOS
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarTpMat - Valida tipo de material contra SigOpOpt WHERE Situas=3
    *   Original: get_tpmat.Valid faz SQLEXEC no SigOpOpt e usa fwBuscaSel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarTpMat()
        LOCAL loc_cValor, loc_cSQL, loc_nRes, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__tpmat.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        IF USED("cursor_4c_TpMatVal")
            USE IN cursor_4c_TpMatVal
        ENDIF
        loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt"
        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpMatVal")
        IF loc_nRes > 0
            SELECT cursor_4c_TpMatVal
            INDEX ON Cods TAG Cods
            IF SEEK(loc_cValor)
                loc_oPg.txt_4c__tpmat.Value = ALLTRIM(cursor_4c_TpMatVal.Cods)
            ELSE
                THIS.AbrirBuscaTpMat()
            ENDIF
            USE IN cursor_4c_TpMatVal
        ELSE
            IF USED("cursor_4c_TpMatVal")
                USE IN cursor_4c_TpMatVal
            ENDIF
            THIS.AbrirBuscaTpMat()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdIfor - Valida codigo da recuperadora contra SigCdCli
    *   Original: get_ifor.Valid chama fAcessoContas('C', ...)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdIfor()
        LOCAL loc_cValor, loc_cSQL, loc_nRes, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ifor.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__dfor.Value = ""
            THIS.AtualizarCamposNivel()
            RETURN
        ENDIF
        IF USED("TmpCli")
            SELECT TmpCli
            SET ORDER TO Iclis
            IF SEEK(loc_cValor)
                loc_oPg.txt_4c__ifor.Value = ALLTRIM(TmpCli.Iclis)
                loc_oPg.txt_4c__dfor.Value = ALLTRIM(TmpCli.Rclis)
            ELSE
                THIS.AbrirBuscaCdIfor()
            ENDIF
        ELSE
            THIS.AbrirBuscaCdIfor()
        ENDIF
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDfor - Valida descricao da recuperadora contra SigCdCli
    *   Original: get_dfor.Valid chama fAcessoContas('D', ...)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDfor()
        LOCAL loc_cValor, loc_cSQL, loc_nRes, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__dfor.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__ifor.Value = ""
            THIS.AtualizarCamposNivel()
            RETURN
        ENDIF
        LOCAL loc_cPrefixo, loc_nPrefixLen, loc_cMatchIclis, loc_cMatchRclis, loc_nMatches
        loc_cPrefixo    = UPPER(loc_cValor)
        loc_nPrefixLen  = LEN(loc_cPrefixo)
        loc_nMatches    = 0
        loc_cMatchIclis = ""
        loc_cMatchRclis = ""
        IF USED("TmpCli")
            SELECT TmpCli
            SET ORDER TO
            SCAN
                IF UPPER(LEFT(ALLTRIM(TmpCli.Rclis), loc_nPrefixLen)) = loc_cPrefixo
                    loc_nMatches    = loc_nMatches + 1
                    loc_cMatchIclis = TmpCli.Iclis
                    loc_cMatchRclis = TmpCli.Rclis
                ENDIF
            ENDSCAN
            IF loc_nMatches = 1
                loc_oPg.txt_4c__dfor.Value = ALLTRIM(loc_cMatchRclis)
                loc_oPg.txt_4c__ifor.Value = ALLTRIM(loc_cMatchIclis)
            ELSE
                THIS.AbrirBuscaDfor()
            ENDIF
        ELSE
            THIS.AbrirBuscaDfor()
        ENDIF
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrupo - Valida codigo do setor contra TmpGccr (cursor em memoria)
    *   Original: getCdGrupo.Valid usa SEEK no TmpGccr e fwBuscaSel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdGrupo()
        LOCAL loc_cValor, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsGrupo.Value = ""
            RETURN
        ENDIF
        IF USED("TmpGccr")
            SELECT TmpGccr
            SET ORDER TO Grupos
            IF SEEK(loc_cValor)
                loc_oPg.txt_4c_CdGrupo.Value = ALLTRIM(TmpGccr.Codigos)
                loc_oPg.txt_4c_DsGrupo.Value = ALLTRIM(TmpGccr.Descrs)
                RETURN
            ENDIF
        ENDIF
        THIS.AbrirBuscaCdGrupo()
    ENDPROC

    *==========================================================================
    * LOOKUPS (FormBuscaAuxiliar)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaTpMat - Lookup de tipo de material em SigOpOpt WHERE Situas=3
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaTpMat()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__tpmat.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpOpt", "cursor_4c_BuscaTpMat", "Cods", loc_cValor, ;
            "Tipo de Material", .F., .F., "Situas = 3")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpMat")
                loc_oPg.txt_4c__tpmat.Value = ALLTRIM(cursor_4c_BuscaTpMat.Cods)
            ENDIF
            IF USED("cursor_4c_BuscaTpMat")
                USE IN cursor_4c_BuscaTpMat
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdIfor - Lookup de recuperadora pelo codigo (Iclis) em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdIfor()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ifor.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaFor", "Iclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Recuperadora")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFor")
                loc_oPg.txt_4c__ifor.Value = ALLTRIM(cursor_4c_BuscaFor.Iclis)
                loc_oPg.txt_4c__dfor.Value = ALLTRIM(cursor_4c_BuscaFor.Rclis)
            ENDIF
            IF USED("cursor_4c_BuscaFor")
                USE IN cursor_4c_BuscaFor
            ENDIF
            loc_oBusca.Release()
        ENDIF
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDfor - Lookup de recuperadora pelo nome (Rclis) em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDfor()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__dfor.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaDfor", "Rclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Recuperadora (Nome)")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDfor")
                loc_oPg.txt_4c__dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.Rclis)
                loc_oPg.txt_4c__ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.Iclis)
            ENDIF
            IF USED("cursor_4c_BuscaDfor")
                USE IN cursor_4c_BuscaDfor
            ENDIF
            loc_oBusca.Release()
        ENDIF
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdGrupo - Lookup de setor em SigCdGcr WHERE BalFalPers=1
    *   Original: getCdGrupo.Valid usa TmpGccr (cursor ja carregado pelo BO)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdGrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Setor", .F., .F., "BalFalPers = 1")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                loc_oPg.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                loc_oPg.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
            ENDIF
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Complementa configuracao dos controles de filtro:
    *   1. BINDEVENT txt_4c__dt_final.KeyPress (ausente em ConfigurarPaginaFiltros)
    *   2. DblClick na descricao do grupo (campo ReadOnly -> abre lookup)
    *   3. ToolTipText em todos os controles de filtro
    *
    *   Para forms REPORT, "PaginaDados" corresponde a complementacao da pagina
    *   unica de filtros - nao existe Page2 (sem CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            *-- BINDEVENT ausente em ConfigurarPaginaFiltros: valida dt_final ao sair
            BINDEVENT(loc_oPg.txt_4c__dt_final, "KeyPress", THIS, "TeclaDtFinal")

            *-- DblClick na descricao do setor (ReadOnly) tambem abre lookup
            BINDEVENT(loc_oPg.txt_4c_DsGrupo, "DblClick", THIS, "AbrirBuscaCdGrupo")

            *-- ToolTipText para orientacao do usuario em todos os filtros
            loc_oPg.txt_4c__dt_inicial.ToolTipText = "Data inicial do per" + CHR(237) + "odo"
            loc_oPg.txt_4c__dt_final.ToolTipText   = "Data final do per" + CHR(237) + "odo"
            loc_oPg.obj_4c_NivImprs.ToolTipText    = "Tipo de relat" + CHR(243) + ;
                "rio (1 a 7): 1=Resumo, 2=Detalhe, 3-4=Consolidado, " + ;
                "5=Grupo, 6=Acumulado, 7=Individual"
            loc_oPg.txt_4c__tpmat.ToolTipText      = "[F4] Selecionar tipo de material - " + ;
                "apenas N" + CHR(237) + "vel 7"
            loc_oPg.txt_4c__ifor.ToolTipText       = "[F4] C" + CHR(243) + "digo da recuperadora - " + ;
                "apenas N" + CHR(237) + "vel 7"
            loc_oPg.txt_4c__dfor.ToolTipText       = "[F4] Nome da recuperadora - " + ;
                "apenas N" + CHR(237) + "vel 7 (preenchido ao informar o c" + CHR(243) + "digo)"
            loc_oPg.txt_4c_CdGrupo.ToolTipText     = "[F4] C" + CHR(243) + "digo do setor - " + ;
                "apenas N" + CHR(237) + "vel 7"
            loc_oPg.txt_4c_DsGrupo.ToolTipText     = "[DblClick] Selecionar setor - " + ;
                "preenchido automaticamente ao informar o c" + CHR(243) + "digo"
            loc_oPg.lbl_4c_Label4.ToolTipText      = "Selecione o n" + CHR(237) + "vel de detalhe do relat" + CHR(243) + "rio"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- Data final: ao sair (ENTER/TAB), valida que nao e menor que a inicial
    PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c__dt_inicial.Value
            loc_dFim = loc_oPg.txt_4c__dt_final.Value
            IF !EMPTY(loc_dFim) AND !EMPTY(loc_dIni) AND loc_dFim < loc_dIni
                MsgAviso("Data Final n" + CHR(227) + "o pode ser menor que a Data Inicial!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c__dt_final.Value = loc_dIni
                loc_oPg.txt_4c__dt_final.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o BO (Custom nao tem Release - usar .NULL.)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
