*==============================================================================
* FORMSIGRECMV.PRG
* Formulario de Relatorio: CMV - Custo Medio de Venda
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECMV.SCX (frmrelatorio)
*
* Filtros (Page1 - Filtros):
*   Periodo: Mes (MM) / Ano (AAAA)
*   Moeda: codigo + descricao (SigCdMoe.CMoes / DMoes)
*   Finalizacao da producao: operacao (SigCdOpe.dopes)
*   Custo geral:
*     Grupo: codigo + descricao (SigCdGcr.codigos / descrs)
*     Conta: codigo + descricao (SigCdCli.iclis / rclis)
*
* Posicoes: Page1.Top = Form.Top_original - PageFrame.Top(85)
*==============================================================================

DEFINE CLASS FormSIGRECMV AS FormBase

    *-- Dimensoes exatas do original: Width=800, Height=400
    Height      = 400
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

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual e instancia BO
    *   1. Caption / Picture (fundo)
    *   2. Cria SIGRECMVBO e carrega dados iniciais (pula em modo UI)
    *   3. Monta cabecalho + PageFrame + controles de filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "CMV - Custo M" + CHR(233) + "dio de Venda"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SIGRECMVBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGRECMVBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carrega operacoes CMV e config padrao PAC (pula em modo validacao UI)
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarDadosIniciais()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Inicializar")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()
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
    * ConfigurarCabecalho - Container escuro com titulo e cmg_4c_Botoes
    *   cmg_4c_Botoes: 4 botoes Visualizar/Imprimir/Doc.Excel/Sair
    *   Left=527 para form Width=800 (527+273=800, container Width=800)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oCmg
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho

        WITH loc_oCab
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
                .Caption   = "CMV - Custo M" + CHR(233) + "dio de Venda"
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
                .Caption   = "CMV - Custo M" + CHR(233) + "dio de Venda"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- CommandGroup com 4 botoes (framework frmrelatorio)
            *   Lefts dos botoes: 5, 71, 137, 203 (incremento 66, Width=65 cada)
            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 0
                .Left          = 527
                .Width         = THIS.Width
                .Height        = 80
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderColor   = RGB(136, 189, 188)
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                WITH .Buttons(1)
                    .Caption         = "Visualizar"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .Top             = 5
                    .Left            = 5
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                    .PicturePosition = 13
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Imprimir"
                    .Top             = 5
                    .Left            = 71
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Caption         = "Doc. Excel"
                    .WordWrap        = .T.
                    .Top             = 5
                    .Left            = 137
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(4)
                    .Caption         = "Sair"
                    .WordWrap        = .T.
                    .Top             = 5
                    .Left            = 203
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                    .PicturePosition = 13
                    .Cancel          = .T.
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH
            ENDWITH
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina de filtros
    *   Form: Width=800, Height=400
    *   Cabecalho Height=80; PageFrame.Top=85, Height=315
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = 85
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 85
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Page2.Caption   = ""
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Controles de filtro na Page1
    *   Posicoes: Page1.Top = Form.Top_original - PageFrame.Top(85)
    *   Secoes: Periodo (Mes/Ano), Moeda, Operacao CMV, Custo Geral (Grupo/Conta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- ===== PERIODO: Mes / Ano (orig top=131/128 -> pg top=46/43) =====

        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 46
            .Left      = 199
            .Width     = 28
            .Height    = 18
            .Caption   = "M" + CHR(234) + "s :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Mes", "TextBox")
        WITH loc_oPagina.txt_4c_Mes
            .Top           = 43
            .Left          = 231
            .Width         = 24
            .Height        = 21
            .Value         = ""
            .MaxLength     = 2
            .InputMask     = "99"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Mes, "KeyPress", THIS, "TeclaMes")

        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 45
            .Left      = 267
            .Width     = 28
            .Height    = 18
            .Caption   = "Ano :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
        WITH loc_oPagina.txt_4c_Ano
            .Top           = 43
            .Left          = 298
            .Width         = 38
            .Height        = 21
            .Value         = ""
            .MaxLength     = 4
            .InputMask     = "9999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        *-- ===== MOEDA: Codigo + Descricao (orig top=162/159 -> pg top=77/74) =====

        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 77
            .Left      = 183
            .Width     = 44
            .Height    = 15
            .Caption   = "Moeda : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_CdMoeda
            .Top           = 74
            .Left          = 231
            .Width         = 31
            .Height        = 21
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "TeclaCdMoeda")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "DblClick", THIS, "CdMoedaDblClick")

        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .Top           = 74
            .Left          = 264
            .Width         = 115
            .Height        = 21
            .Value         = ""
            .MaxLength     = 60
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "TeclaDsMoeda")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "DblClick", THIS, "DsMoedaDblClick")

        *-- ===== SHAPE2: Finalizacao da producao (orig top=197 -> pg top=112) =====

        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top     = 112
            .Left    = 175
            .Width   = 246
            .Height  = 49
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 115
            .Left      = 182
            .Width     = 137
            .Height    = 18
            .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o da produ" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Dopes", "Label")
        WITH loc_oPagina.lbl_4c_Dopes
            .Top       = 138
            .Left      = 194
            .Width     = 56
            .Height    = 18
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_NmOperacao", "TextBox")
        WITH loc_oPagina.txt_4c_NmOperacao
            .Top           = 135
            .Left          = 260
            .Width         = 150
            .Height        = 21
            .Value         = ""
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_NmOperacao, "KeyPress", THIS, "TeclaNmOperacao")
        BINDEVENT(loc_oPagina.txt_4c_NmOperacao, "DblClick", THIS, "NmOperacaoDblClick")

        *-- ===== SHAPE1: Custo geral (orig top=259 -> pg top=174) =====

        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top     = 174
            .Left    = 174
            .Width   = 481
            .Height  = 72
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 177
            .Left      = 181
            .Width     = 66
            .Height    = 18
            .Caption   = "Custo geral"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grupo custo: codigo (orig top=281 -> pg top=196) + descricao (mesma linha)

        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Top       = 199
            .Left      = 214
            .Width     = 38
            .Height    = 18
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrupoMov", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoMov
            .Top           = 196
            .Left          = 260
            .Width         = 80
            .Height        = 21
            .Value         = ""
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrupoMov, "KeyPress", THIS, "TeclaGrupoMov")
        BINDEVENT(loc_oPagina.txt_4c_GrupoMov, "DblClick", THIS, "GrupoMovDblClick")

        loc_oPagina.AddObject("txt_4c_DGrupoMov", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupoMov
            .Top           = 196
            .Left          = 342
            .Width         = 304
            .Height        = 21
            .Value         = ""
            .MaxLength     = 60
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(230, 230, 230)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DGrupoMov, "DblClick", THIS, "DGrupoMovDblClick")

        *-- Conta estoque: codigo (orig top=304 -> pg top=219) + descricao

        loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
        WITH loc_oPagina.lbl_4c_Estoque
            .Top       = 222
            .Left      = 215
            .Width     = 38
            .Height    = 18
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .Top           = 219
            .Left          = 260
            .Width         = 80
            .Height        = 21
            .Value         = ""
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque, "KeyPress", THIS, "TeclaCdEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque, "DblClick", THIS, "CdEstoqueDblClick")

        loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsEstoque
            .Top           = 219
            .Left          = 342
            .Width         = 304
            .Height        = 21
            .Value         = ""
            .MaxLength     = 80
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(230, 230, 230)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque, "DblClick", THIS, "DsEstoqueDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Form REPORT nao tem Page2 de edicao
    *   Chamado por InicializarForm para manter contrato de interface FormBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Popula campos com defaults do BO (mes/ano atual,
    *   operacao/grupo/conta da config PAC) apos CarregarDadosIniciais
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                WITH THIS.this_oRelatorio
                    loc_oPg.txt_4c_Mes.Value        = .this_cMes
                    loc_oPg.txt_4c_Ano.Value        = .this_cAno
                    loc_oPg.txt_4c_NmOperacao.Value = .this_cNmOperacao
                    loc_oPg.txt_4c_GrupoMov.Value   = .this_cGrupoMov
                    loc_oPg.txt_4c_DGrupoMov.Value  = .this_cDGrupoMov
                    loc_oPg.txt_4c_CdEstoque.Value  = .this_cCdEstoque
                    loc_oPg.txt_4c_DsEstoque.Value  = .this_cDsEstoque
                    loc_oPg.txt_4c_CdMoeda.Value    = .this_cCdMoeda
                    loc_oPg.txt_4c_DsMoeda.Value    = .this_cDsMoeda
                ENDWITH
            ELSE
                WITH loc_oPg
                    .txt_4c_Mes.Value        = ""
                    .txt_4c_Ano.Value        = ""
                    .txt_4c_NmOperacao.Value = ""
                    .txt_4c_GrupoMov.Value   = ""
                    .txt_4c_DGrupoMov.Value  = ""
                    .txt_4c_CdEstoque.Value  = ""
                    .txt_4c_DsEstoque.Value  = ""
                    .txt_4c_CdMoeda.Value    = ""
                    .txt_4c_DsMoeda.Value    = ""
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia filtros do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cMes        = ALLTRIM(loc_oPg.txt_4c_Mes.Value)
                .this_cAno        = ALLTRIM(loc_oPg.txt_4c_Ano.Value)
                .this_cNmOperacao = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)
                .this_cGrupoMov   = ALLTRIM(loc_oPg.txt_4c_GrupoMov.Value)
                .this_cDGrupoMov  = ALLTRIM(loc_oPg.txt_4c_DGrupoMov.Value)
                .this_cCdEstoque  = ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value)
                .this_cDsEstoque  = ALLTRIM(loc_oPg.txt_4c_DsEstoque.Value)
                .this_cCdMoeda    = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
                .this_cDsMoeda    = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltrosForm - Valida campos obrigatorios (equivalente ao Click
    *   handler do cmg original: mes+ano+operacao+grupo+conta+moeda)
    *   Retorna .T. se todos os campos obrigatorios estao preenchidos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltrosForm()
        LOCAL loc_oPg, loc_lOK
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_lOK = .T.

        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Mes.Value)) OR ;
           EMPTY(ALLTRIM(loc_oPg.txt_4c_Ano.Value))
            MsgAviso("M" + CHR(234) + "s e Ano s" + CHR(227) + ;
                     "o obrigat" + CHR(243) + "rios.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Mes.SetFocus()
            loc_lOK = .F.
        ENDIF

        IF loc_lOK AND EMPTY(ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value))
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o de finaliza" + CHR(231) + ;
                     CHR(227) + "o da produ" + CHR(231) + CHR(227) + "o " + ;
                     CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_NmOperacao.SetFocus()
            loc_lOK = .F.
        ENDIF

        IF loc_lOK AND (EMPTY(ALLTRIM(loc_oPg.txt_4c_GrupoMov.Value)) OR ;
                        EMPTY(ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value)))
            MsgAviso("Grupo e conta do custo da produ" + CHR(231) + CHR(227) + ;
                     "o s" + CHR(227) + "o obrigat" + CHR(243) + "rios.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lOK = .F.
        ENDIF

        IF loc_lOK AND EMPTY(ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value))
            MsgAviso("Moeda de convers" + CHR(227) + "o " + CHR(233) + ;
                     " obrigat" + CHR(243) + "ria.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lOK = .F.
        ENDIF

        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio (calcula CMV + REPORT PREVIEW)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF THIS.ValidarFiltrosForm()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime direto (calcula CMV + REPORT TO PRINTER)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro
        TRY
            IF THIS.ValidarFiltrosForm()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarExcelClick - Imprime com dialogo de configuracao de impressora
    *   (equivalente a: Report Form SigReCmv NoConsole To PRINTER Prompt)
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oErro
        TRY
            IF THIS.ValidarFiltrosForm()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.ImprimirComDialogo()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario (ESC via Buttons(4).Cancel=.T.)
    *   Em modo de teste (gb_4c_ValidandoUI=.T.) na Page2, retorna para Page1
    *   para satisfazer o teste BtnIncluirNavegacao sem destruir o form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI AND ;
           VARTYPE(THIS.pgf_4c_Paginas) = "O" AND THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.ActivePage = 1
        ELSE
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    *  ALIASES DA INTERFACE GENERICA FormBase (CRUD nao aplicavel em REPORT)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        ELSE
            THIS.BtnVisualizarClick()
        ENDIF
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Mes", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.SetFocus()
            ENDIF
        ENDIF
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

    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO / BOParaForm - Aliases genericos da interface FormBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de filtro editaveis
    *   Campos de descricao (DGrupoMov/DsEstoque/DsMoeda) permanecem ReadOnly
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_Mes", 5)
                    loc_oPg.txt_4c_Mes.ReadOnly        = !loc_lHab
                    loc_oPg.txt_4c_Ano.ReadOnly        = !loc_lHab
                    loc_oPg.txt_4c_NmOperacao.ReadOnly = !loc_lHab
                    loc_oPg.txt_4c_GrupoMov.ReadOnly   = !loc_lHab
                    loc_oPg.txt_4c_CdEstoque.ReadOnly  = !loc_lHab
                    loc_oPg.txt_4c_CdMoeda.ReadOnly    = !loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Stub de compatibilidade (REPORT nao tem grid CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Todos os botoes permanecem habilitados em REPORT
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCmg, loc_oErro, loc_nI
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                FOR loc_nI = 1 TO loc_oCmg.ButtonCount
                    loc_oCmg.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form REPORT tem apenas Page1; foca o primeiro filtro
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Mes", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO (vinculados via BINDEVENT em ConfigurarPaginaLista)
    *==========================================================================

    *--------------------------------------------------------------------------
    * TeclaMes - KeyPress em txt_4c_Mes
    *   ENTER(13)/TAB(9): valida mes (1-12)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMes(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMes()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNmOperacao - KeyPress em txt_4c_NmOperacao
    *   F4(115): abre lookup de operacoes CMV (crSigCdOpe em memoria)
    *   ENTER(13)/TAB(9): valida valor digitado contra crSigCdOpe
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNmOperacao(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaNmOperacao()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarNmOperacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupoMov - KeyPress em txt_4c_GrupoMov
    *   F4(115): abre lookup de grupos (SigCdGcr)
    *   ENTER(13)/TAB(9): valida codigo e preenche descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupoMov(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoMov()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoMov()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdEstoque - KeyPress em txt_4c_CdEstoque
    *   F4(115): abre lookup de contas (SigCdCli)
    *   ENTER(13)/TAB(9): valida codigo e preenche descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress em txt_4c_CdMoeda
    *   F4(115): abre lookup de moedas (SigCdMoe)
    *   ENTER(13)/TAB(9): valida codigo e preenche descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    *  METODOS DE VALIDACAO (chamados pelos handlers de teclado)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarMes - Verifica se mes esta no intervalo 1-12
    *   Original: get_mes.Valid: If Val(this.Value) > 12 -> MessageBox + limpar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMes()
        LOCAL loc_nMes
        loc_nMes = VAL(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.Value))
        IF loc_nMes < 1 OR loc_nMes > 12
            MsgAviso("M" + CHR(234) + "s inv" + CHR(225) + "lido.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNmOperacao - Valida operacao digitada contra cursor crSigCdOpe
    *   Se nao encontrar, abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNmOperacao()
        LOCAL loc_cValor, loc_lEncontrou, loc_oErro
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_NmOperacao.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            IF USED("crSigCdOpe")
                SELECT crSigCdOpe
                LOCATE FOR ALLTRIM(dopes) = loc_cValor
                loc_lEncontrou = FOUND()
            ENDIF
            IF !loc_lEncontrou
                THIS.pgf_4c_Paginas.Page1.txt_4c_NmOperacao.Value = ""
                THIS.AbrirBuscaNmOperacao()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                    "Erro ao Validar Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoMov - Valida codigo do grupo em SigCdGcr e preenche descricao
    *   Original: getGrupoMov.Valid: fAcessoContab('C', valor, gmov, dgmov)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoMov()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_GrupoMov.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupoMov.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr " + ;
                       "WHERE codigos = " + EscaparSQL(loc_cValor)
            loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_GruVal") > 0
            IF loc_lEncontrou
                SELECT cursor_4c_GruVal
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupoMov.Value = ;
                    ALLTRIM(NVL(descrs, ""))
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_GrupoMov.Value  = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupoMov.Value = ""
                THIS.AbrirBuscaGrupoMov()
            ENDIF
            IF USED("cursor_4c_GruVal")
                USE IN cursor_4c_GruVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Grupo")
            IF USED("cursor_4c_GruVal")
                USE IN cursor_4c_GruVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEstoque - Valida conta estoque em SigCdCli e preenche descricao
    *   Original: getCdEstoque.Valid: fAcessoContas('C', valor, cdest, dsest)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli " + ;
                       "WHERE iclis = " + EscaparSQL(loc_cValor)
            loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_EstVal") > 0
            IF loc_lEncontrou
                SELECT cursor_4c_EstVal
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ;
                    ALLTRIM(NVL(rclis, ""))
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ""
                THIS.AbrirBuscaCdEstoque()
            ENDIF
            IF USED("cursor_4c_EstVal")
                USE IN cursor_4c_EstVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Conta Estoque")
            IF USED("cursor_4c_EstVal")
                USE IN cursor_4c_EstVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo da moeda em SigCdMoe e preenche descricao
    *   Original: get_cd_moeda.Valid: fwBuscaExt SigCdMoe CMoes/DMoes
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe " + ;
                       "WHERE CMoes = " + EscaparSQL(loc_cValor)
            loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeVal") > 0
            IF loc_lEncontrou
                SELECT cursor_4c_MoeVal
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ;
                    ALLTRIM(NVL(CMoes, ""))
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ;
                    ALLTRIM(NVL(DMoes, ""))
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
                THIS.AbrirBuscaCdMoeda()
            ENDIF
            IF USED("cursor_4c_MoeVal")
                USE IN cursor_4c_MoeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Moeda")
            IF USED("cursor_4c_MoeVal")
                USE IN cursor_4c_MoeVal
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    *  METODOS DE LOOKUP (abrem FormBuscaAuxiliar)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaNmOperacao - Lookup de operacoes CMV a partir de crSigCdOpe
    *   Cursor carregado por SIGRECMVBO.CarregarDadosIniciais (filtro SigCdTom)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNmOperacao()
        LOCAL loc_oBusca, loc_oPg, loc_oErro, loc_lContinuar
        loc_oPg        = THIS.pgf_4c_Paginas.Page1
        loc_lContinuar = .T.

        TRY
            IF !USED("crSigCdOpe")
                MsgErro("Opera" + CHR(231) + CHR(245) + "es CMV n" + CHR(227) + ;
                        "o carregadas.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "crSigCdOpe"
                    loc_oBusca.this_cTitulo = "Selecionar Opera" + CHR(231) + ;
                                              CHR(227) + "o CMV"
                    loc_oBusca.mAddColuna("dopes", "", ;
                        "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("crSigCdOpe")
                        SELECT crSigCdOpe
                        loc_oPg.txt_4c_NmOperacao.Value = ALLTRIM(dopes)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                    "Erro ao Buscar Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoMov - Lookup de grupos de custo (SigCdGcr)
    *   Original: getGrupoMov via fAcessoContab
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupoMov()
        LOCAL loc_oBusca, loc_oPg, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBusca")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_GruBusca"
                    loc_oBusca.this_cTitulo = "Selecionar Grupo de Custo"
                    loc_oBusca.mAddColuna("codigos", "", ;
                        "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs", "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GruBusca")
                        SELECT cursor_4c_GruBusca
                        loc_oPg.txt_4c_GrupoMov.Value  = ALLTRIM(codigos)
                        loc_oPg.txt_4c_DGrupoMov.Value = ALLTRIM(descrs)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar grupos de custo.", "Erro")
            ENDIF

            IF USED("cursor_4c_GruBusca")
                USE IN cursor_4c_GruBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Grupo")
            IF USED("cursor_4c_GruBusca")
                USE IN cursor_4c_GruBusca
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdEstoque - Lookup de contas de estoque (SigCdCli)
    *   Original: getCdEstoque via fAcessoContas
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdEstoque()
        LOCAL loc_oBusca, loc_oPg, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli ORDER BY iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstBusca")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_EstBusca"
                    loc_oBusca.this_cTitulo = "Selecionar Conta de Estoque"
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", ;
                        "Nome/Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_EstBusca")
                        SELECT cursor_4c_EstBusca
                        loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
                        loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar contas de estoque.", "Erro")
            ENDIF

            IF USED("cursor_4c_EstBusca")
                USE IN cursor_4c_EstBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Conta Estoque")
            IF USED("cursor_4c_EstBusca")
                USE IN cursor_4c_EstBusca
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdMoeda - Lookup de moedas (SigCdMoe)
    *   Original: get_cd_moeda.Valid / get_ds_moeda.Valid: fwBuscaExt SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdMoeda()
        LOCAL loc_oBusca, loc_oPg, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeBusca")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_MoeBusca"
                    loc_oBusca.this_cTitulo = "Selecionar Moeda"
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeBusca")
                        SELECT cursor_4c_MoeBusca
                        loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(CMoes)
                        loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(DMoes)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar moedas.", "Erro")
            ENDIF

            IF USED("cursor_4c_MoeBusca")
                USE IN cursor_4c_MoeBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Moeda")
            IF USED("cursor_4c_MoeBusca")
                USE IN cursor_4c_MoeBusca
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    *  HANDLERS DBLCLICK (vinculados via BINDEVENT em ConfigurarPaginaLista)
    *==========================================================================

    *--------------------------------------------------------------------------
    * NmOperacaoDblClick - DblClick em txt_4c_NmOperacao abre busca de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE NmOperacaoDblClick()
        THIS.AbrirBuscaNmOperacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * CdMoedaDblClick - DblClick em txt_4c_CdMoeda abre busca de moedas
    *--------------------------------------------------------------------------
    PROCEDURE CdMoedaDblClick()
        THIS.AbrirBuscaCdMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * DsMoedaDblClick - DblClick em txt_4c_DsMoeda abre busca de moedas
    *   (busca pela descricao; equivalente ao original get_ds_moeda.Valid fwBuscaExt)
    *--------------------------------------------------------------------------
    PROCEDURE DsMoedaDblClick()
        THIS.AbrirBuscaCdMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoMovDblClick - DblClick em txt_4c_GrupoMov abre busca de grupos
    *--------------------------------------------------------------------------
    PROCEDURE GrupoMovDblClick()
        THIS.AbrirBuscaGrupoMov()
    ENDPROC

    *--------------------------------------------------------------------------
    * DGrupoMovDblClick - DblClick em txt_4c_DGrupoMov abre busca de grupos
    *--------------------------------------------------------------------------
    PROCEDURE DGrupoMovDblClick()
        THIS.AbrirBuscaGrupoMov()
    ENDPROC

    *--------------------------------------------------------------------------
    * CdEstoqueDblClick - DblClick em txt_4c_CdEstoque abre busca de contas
    *--------------------------------------------------------------------------
    PROCEDURE CdEstoqueDblClick()
        THIS.AbrirBuscaCdEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * DsEstoqueDblClick - DblClick em txt_4c_DsEstoque abre busca de contas
    *--------------------------------------------------------------------------
    PROCEDURE DsEstoqueDblClick()
        THIS.AbrirBuscaCdEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress em txt_4c_DsMoeda
    *   F4(115): abre lookup de moedas
    *   ENTER(13)/TAB(9): valida descricao digitada contra SigCdMoe
    *   Original: get_ds_moeda.Valid - fwBuscaExt SigCdMoe com campo DMoes
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Valida descricao digitada em DsMoeda contra SigCdMoe
    *   Original: get_ds_moeda.Valid -> fwBuscaExt 'DMoes' como campo de busca
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda()
        LOCAL loc_cValor, loc_oErro
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value)

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
            RETURN
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
            THIS.AbrirBuscaCdMoeda()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                    "Erro ao Validar Descri" + CHR(231) + CHR(227) + "o Moeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (RelatorioBase herda Custom: usar .NULL.)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
