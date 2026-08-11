*==============================================================================
* Formsigprdis.prg - Formulario OPERACIONAL: Distribui" + CHR(231) + CHR(227) + "o de Produtos
* Equivalente ao SIGPRDIS.SCX do legado
* Tipo: OPERACIONAL - lista de lotes (Page1) + processamento (Page2 inner 3-pages)
* Herda de FormBase
*==============================================================================
DEFINE CLASS Formsigprdis AS FormBase

    Width       = 1000
    Height      = 600
    Caption     = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
    ShowWindow  = 1
    WindowType  = 1
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    DataSession = 2

    this_oBusinessObject           = .NULL.
    this_cEscolha                  = ""
    this_cCodigos                  = ""
    this_cUltimoCGrupoValidado     = ""
    this_cUltimoDGrupoValidado     = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_aCursores[8], loc_i
        loc_aCursores[1] = "cursor_4c_Dados"
        loc_aCursores[2] = "cursor_4c_Estoques"
        loc_aCursores[3] = "cursor_4c_Disponivel"
        loc_aCursores[4] = "cursor_4c_Distribui"
        loc_aCursores[5] = "cursor_4c_CabOpera"
        loc_aCursores[6] = "cursor_4c_ItensOper"
        loc_aCursores[7] = "cursor_4c_LotePrDis"
        loc_aCursores[8] = "cursor_4c_Produto"
        FOR loc_i = 1 TO 8
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT loc_i
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("sigprdisBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar sigprdisBO.", "Erro InicializarForm")
            ELSE
                *-- Placeholders para ControlSource em DataSession=2
                *-- Fechados/substituidos pelos metodos do BO antes de cada SQLEXEC
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (Codigos C(20), Datas T)
                SELECT 0 AS nMarca, SPACE(36) AS cidchaves, SPACE(4) AS emps, ;
                    SPACE(10) AS grupos, SPACE(15) AS contas ;
                    INTO CURSOR cursor_4c_Estoques READWRITE
                SELECT SPACE(14) AS cpros, SPACE(65) AS dpros, SPACE(4) AS codcors, ;
                    SPACE(4) AS codtams, 0.00 AS QtdEstoque, 0.00 AS QtdSaida, 0.00 AS QtdSaldo ;
                    INTO CURSOR cursor_4c_Disponivel READWRITE
                CREATE CURSOR cursor_4c_Distribui (emps C(4), grupos C(10), contas C(15), QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
                SELECT SPACE(4) AS emps, SPACE(20) AS dopes, SPACE(10) AS numes, ;
                    DATETIME() AS datas, SPACE(10) AS grupos, SPACE(40) AS empdopnums, ;
                    SPACE(3) AS empds, SPACE(10) AS contaos, SPACE(10) AS grupods, ;
                    SPACE(10) AS contads ;
                    INTO CURSOR cursor_4c_CabOpera READWRITE
                SELECT SPACE(14) AS cpros, SPACE(65) AS dpros, SPACE(4) AS codcors, ;
                    SPACE(4) AS codtams, 0.00 AS qtds, SPACE(10) AS locals ;
                    INTO CURSOR cursor_4c_ItensOper READWRITE
                SET NULL OFF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarSaida()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Page1 BINDEVENTs
                LOCAL loc_oPg1 AS Object
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1
                BINDEVENT(loc_oPg1.txt_4c_DtInicial, "LostFocus",     THIS, "TxtDtInicialValid")
                BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "LostFocus",     THIS, "TxtDtFinalValid")
                BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "KeyPress", THIS, "TxtDtFinalLostFocus")
                BINDEVENT(loc_oPg1.cmd_4c_Novo,       "Click",    THIS, "BtnNovoClick")
                BINDEVENT(loc_oPg1.cmd_4c_Abrir,      "Click",    THIS, "BtnAbrirClick")
                BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

                *-- Page2 BINDEVENTs
                LOCAL loc_oPg2 AS Object
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2
                BINDEVENT(loc_oPg2.cmd_4c_VoltarLista, "Click", THIS, "BtnVoltarListaClick")

                *-- Inner pageframe sub-page BINDEVENTs
                LOCAL loc_oPf1 AS Object
                loc_oPf1 = loc_oPg2.pgf_4c_Pageframe1

                *-- SubPage1 (Estoques)
                LOCAL loc_oSub1 AS Object
                loc_oSub1 = loc_oPf1.Page1
                BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(1), "Click", THIS, "BtnMarcarClick")
                BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(2), "Click", THIS, "BtnDesmarcarClick")
                BINDEVENT(loc_oSub1.cmd_4c_Processar,                  "Click", THIS, "BtnProcessarPage1Click")
                BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "MouseUp",  THIS, "ChkMarcaMouseUp")
                BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")

                *-- SubPage2 (Distribuicao)
                LOCAL loc_oSub2 AS Object
                loc_oSub2 = loc_oPf1.Page2
                BINDEVENT(loc_oSub2.cmd_4c_VoltarEst,      "Click",              THIS, "BtnVoltarEstClick")
                BINDEVENT(loc_oSub2.cmd_4c_Salvar,         "Click",              THIS, "BtnSalvarClick")
                BINDEVENT(loc_oSub2.cmd_4c_Filtrar,        "Click",              THIS, "BtnFiltrarClick")
                BINDEVENT(loc_oSub2.img_4c_FigJpg,         "Click",              THIS, "ImgFotoClick")
                BINDEVENT(loc_oSub2.txt_4c_CodGrupo,       "KeyPress",             THIS, "TxtCGrupoValid")
                BINDEVENT(loc_oSub2.txt_4c_DsGrupo,        "KeyPress",             THIS, "TxtDGrupoValid")
                BINDEVENT(loc_oSub2.txt_4c_CodSgrupo,      "KeyPress",             THIS, "TxtCodSgrupoValid")
                BINDEVENT(loc_oSub2.txt_4c_DsSgrupo,       "KeyPress",             THIS, "TxtDsSgrupoValid")
                BINDEVENT(loc_oSub2.txt_4c_ProdutoInicial, "LostFocus",              THIS, "TxtProdutoInicialValid")
                BINDEVENT(loc_oSub2.grd_4c_Disponivel,     "AfterRowColChange",  THIS, "GrdDisponivelAfterRowColChange")
                BINDEVENT(loc_oSub2.grd_4c_Distribui.Column3.Text1, "KeyPress", THIS, "GrdDistribuiQtdLostFocus")
                BINDEVENT(loc_oSub2.grd_4c_Distribui.Column4.Text1, "Valid",     THIS, "GrdDistribuiLocalValid")
                BINDEVENT(loc_oSub2.grd_4c_Distribui.Column4.Text1, "KeyPress",  THIS, "TxtLocalKeyPress")

                *-- SubPage3 (Operacoes)
                LOCAL loc_oSub3 AS Object
                loc_oSub3 = loc_oPf1.Page3
                BINDEVENT(loc_oSub3.cmdg_4c_ProcOper.Buttons(1), "Click",             THIS, "BtnProcOperClick")
                BINDEVENT(loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas, "AfterRowColChange", THIS, "GrdCabOperasAfterRowColChange")

                THIS.TornarControlesVisiveis(THIS)

                *-- Disable pages 2 and 3 until estoques processed
                loc_oPf1.Page2.Enabled = .F.
                loc_oPf1.Page3.Enabled = .F.

                *-- Initial date range = today
                THIS.this_oBusinessObject.this_dDataInicial = DATE()
                THIS.this_oBusinessObject.this_dDataFinal   = DATE()
                loc_oPg1.txt_4c_DtInicial.Value = DATE()
                loc_oPg1.txt_4c_DtFinal.Value   = DATE()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                    loc_oPg1.grd_4c_Grade.SetFocus()
                ELSE
                    loc_oPg1.cmd_4c_Novo.SetFocus()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprdis")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), ;
                    "LBL_4C_LBLTITF", "LBL_4C_LBLTITT", "LBL_4C_LABEL3")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 45
            .BorderWidth= 0
            .BackStyle  = 1
            .BackColor  = RGB(90,90,90)
            .Visible     = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
            .Top       = 12
            .Left      = 12
            .Width     = THIS.Width
            .Height    = 30
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(0,0,0)
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
            .Top       = 10
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 30
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255,255,255)
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.Picture    = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Left      = 0
            .Top       = 45
            .Width     = THIS.Width
            .Height    = THIS.Height - 45
            .PageCount = 2
            .Tabs      = .F.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSaida()
    *==========================================================================
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Name        = "cnt_4c_Saida"
            .Left        = 917
            .Top         = 45
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
            .ZOrder(0)
        ENDWITH
        THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
            .Name     = "cmd_4c_Encerrar"
            .Left     = 5
            .Top      = 5
            .Width    = 75
            .Height   = 75
            .Caption  = "Encerrar"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPg1 AS Object
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_oPg1.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg1.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 35
            .Top       = 89
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg1.txt_4c_DtInicial
            .Left     = 103
            .Top      = 105
            .Width    = 90
            .Height   = 22
            .Value    = DATE()
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oPg1.lbl_4c_Sep
            .Caption   = CHR(224)
            .Left      = 195
            .Top       = 109
            .Width     = 12
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg1.txt_4c_DtFinal
            .Left     = 206
            .Top      = 105
            .Width    = 90
            .Height   = 22
            .Value    = DATE()
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg1.AddObject("cmd_4c_Novo", "CommandButton")
        WITH loc_oPg1.cmd_4c_Novo
            .Caption  = "Nova Distribui" + CHR(231) + CHR(227) + "o"
            .Left     = 315
            .Top      = 102
            .Width    = 140
            .Height   = 28
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg1.AddObject("cmd_4c_Abrir", "CommandButton")
        WITH loc_oPg1.cmd_4c_Abrir
            .Caption  = "Abrir Selecionado"
            .Left     = 465
            .Top      = 102
            .Width    = 130
            .Height   = 28
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_TituloLista", "Label")
        WITH loc_oPg1.lbl_4c_TituloLista
            .Caption   = "Lotes de Distribui" + CHR(231) + CHR(227) + "o"
            .Left      = 35
            .Top       = 140
            .Width     = 200
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
        ENDWITH

        loc_oPg1.AddObject("grd_4c_Grade", "Grid")
        WITH loc_oPg1.grd_4c_Grade
            .Left              = 24
            .Top               = 157
            .Width             = 870
            .Height            = 340
            .RecordSource      = ""
            .RecordSourceType  = 1
            .ColumnCount       = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLines         = 1
            .ReadOnly          = .T.
            .Themes            = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
        ENDWITH
        WITH loc_oPg1.grd_4c_Grade.Column1
            .ControlSource   = "cursor_4c_Dados.Codigos"
            .Width           = 140
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oPg1.grd_4c_Grade.Column2
            .ControlSource   = "cursor_4c_Dados.Datas"
            .Width           = 700
            .Header1.Caption = "Data"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPg2 AS Object
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.AddObject("cmd_4c_VoltarLista", "CommandButton")
        WITH loc_oPg2.cmd_4c_VoltarLista
            .Caption  = CHR(171) + " Lista"
            .Left     = 5
            .Top      = 5
            .Width    = 80
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Lote", "Label")
        WITH loc_oPg2.lbl_4c_Lote
            .Caption   = "Lote:"
            .Left      = 96
            .Top       = 10
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPg2.AddObject("txt_4c_LoteCodigo", "TextBox")
        WITH loc_oPg2.txt_4c_LoteCodigo
            .Left      = 132
            .Top       = 7
            .Width     = 180
            .Height    = 22
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Modo", "Label")
        WITH loc_oPg2.lbl_4c_Modo
            .Caption   = ""
            .Left      = 320
            .Top       = 10
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0,0,180)
        ENDWITH

        *-- Inner pageframe (3 sub-pages: Estoques, Distribuicao, Operacoes)
        loc_oPg2.AddObject("pgf_4c_Pageframe1", "PageFrame")
        WITH loc_oPg2.pgf_4c_Pageframe1
            .Left      = 0
            .Top       = 35
            .Width     = 910
            .Height    = 515
            .PageCount = 3
            .Tabs      = .T.
            .Page1.Caption = "1 - Estoques"
            .Page2.Caption = "2 - Distribui" + CHR(231) + CHR(227) + "o"
            .Page3.Caption = "3 - Opera" + CHR(231) + CHR(245) + "es"
        ENDWITH

        THIS.ConfigurarSubPaginaEstoques()
        THIS.ConfigurarSubPaginaDistribuicao()
        THIS.ConfigurarSubPaginaOperacoes()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaEstoques()
    *==========================================================================
        LOCAL loc_oSub AS Object
        loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1

        loc_oSub.AddObject("lbl_4c_TituloEst", "Label")
        WITH loc_oSub.lbl_4c_TituloEst
            .Caption   = "Estoques para distribuir"
            .Left      = 338
            .Top       = 189
            .Width     = 200
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
        ENDWITH

        loc_oSub.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oSub.cmd_4c_Processar
            .Caption  = "Processar >>"
            .Left     = 730
            .Top      = 10
            .Width    = 120
            .Height   = 28
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oSub.AddObject("cmdg_4c_MarcaDesmarca", "CommandGroup")
        WITH loc_oSub.cmdg_4c_MarcaDesmarca
            .Left        = 617
            .Top         = 351
            .Width       = 160
            .Height      = 50
            .ButtonCount = 2
        ENDWITH
        WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(1)
            .Caption = "Marcar Todos"
            .Left    = 5
            .Top     = 5
            .Width   = 72
            .Height  = 40
        ENDWITH
        WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(2)
            .Caption = "Desmarcar"
            .Left    = 82
            .Top     = 5
            .Width   = 72
            .Height  = 40
        ENDWITH

        loc_oSub.AddObject("grd_4c_Estoques", "Grid")
        WITH loc_oSub.grd_4c_Estoques
            .Left             = 335
            .Top              = 207
            .Width            = 280
            .Height           = 244
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 4
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.grd_4c_Estoques.Column1
            .ControlSource   = "cursor_4c_Estoques.nMarca"
            .Width           = 30
            .Sparse          = .F.
            .Header1.Caption = ""
        ENDWITH
        loc_oSub.grd_4c_Estoques.Column1.AddObject("chk_4c_Marca", "CheckBox")
        WITH loc_oSub.grd_4c_Estoques.Column1.chk_4c_Marca
            .Caption = ""
            .Width   = 24
            .Height  = 17
        ENDWITH
        loc_oSub.grd_4c_Estoques.Column1.CurrentControl = "chk_4c_Marca"
        WITH loc_oSub.grd_4c_Estoques.Column2
            .ControlSource   = "cursor_4c_Estoques.emps"
            .Width           = 55
            .ReadOnly        = .T.
            .Header1.Caption = "Empresa"
        ENDWITH
        WITH loc_oSub.grd_4c_Estoques.Column3
            .ControlSource   = "cursor_4c_Estoques.grupos"
            .Width           = 90
            .ReadOnly        = .T.
            .Header1.Caption = "Grupo"
        ENDWITH
        WITH loc_oSub.grd_4c_Estoques.Column4
            .ControlSource   = "cursor_4c_Estoques.contas"
            .Width           = 90
            .ReadOnly        = .T.
            .Header1.Caption = "Conta"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaDistribuicao()
    *==========================================================================
        LOCAL loc_oSub AS Object
        loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2

        loc_oSub.AddObject("cmd_4c_VoltarEst", "CommandButton")
        WITH loc_oSub.cmd_4c_VoltarEst
            .Caption  = CHR(171) + " Estoques"
            .Left     = 5
            .Top      = 5
            .Width    = 90
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oSub.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oSub.cmd_4c_Salvar
            .Caption  = "Salvar"
            .Left     = 730
            .Top      = 5
            .Width    = 80
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Product image area
        loc_oSub.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oSub.shp_4c_Shape5
            .Left      = 4
            .Top       = 35
            .Width     = 163
            .Height    = 93
            .BackStyle = 1
            .BackColor = RGB(200,200,200)
        ENDWITH

        loc_oSub.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oSub.img_4c_FigJpg
            .Left    = 7
            .Top     = 36
            .Width   = 159
            .Height  = 89
            .Stretch = 1
        ENDWITH

        *-- Group filter
        loc_oSub.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oSub.lbl_4c_LblGrupo
            .Caption   = "Grupo :"
            .Left      = 174
            .Top       = 59
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oSub.AddObject("txt_4c_CodGrupo", "TextBox")
        WITH loc_oSub.txt_4c_CodGrupo
            .Left     = 175
            .Top      = 74
            .Width    = 35
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oSub.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oSub.txt_4c_DsGrupo
            .Left     = 211
            .Top      = 74
            .Width    = 208
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oSub.AddObject("cmd_4c_Filtrar", "CommandButton")
        WITH loc_oSub.cmd_4c_Filtrar
            .Caption  = "Filtrar"
            .Left     = 424
            .Top      = 73
            .Width    = 60
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Product search
        loc_oSub.AddObject("lbl_4c_LblProduto", "Label")
        WITH loc_oSub.lbl_4c_LblProduto
            .Caption   = "Procurar"
            .Left      = 4
            .Top       = 100
            .Width     = 50
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oSub.AddObject("txt_4c_ProdutoInicial", "TextBox")
        WITH loc_oSub.txt_4c_ProdutoInicial
            .Left     = 2
            .Top      = 116
            .Width    = 108
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Disponivel grid
        loc_oSub.AddObject("grd_4c_Disponivel", "Grid")
        WITH loc_oSub.grd_4c_Disponivel
            .Left             = 1
            .Top              = 141
            .Width            = 663
            .Height           = 327
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 7
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .ReadOnly         = .T.
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column1
            .ControlSource   = "cursor_4c_Disponivel.cpros"
            .Width           = 90
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column2
            .ControlSource   = "cursor_4c_Disponivel.dpros"
            .Width           = 140
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column3
            .ControlSource   = "cursor_4c_Disponivel.codcors"
            .Width           = 55
            .Header1.Caption = "Cor"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column4
            .ControlSource   = "cursor_4c_Disponivel.codtams"
            .Width           = 55
            .Header1.Caption = "Tam"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column5
            .ControlSource   = "cursor_4c_Disponivel.QtdEstoque"
            .Width           = 80
            .Header1.Caption = "Estoque"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column6
            .ControlSource   = "cursor_4c_Disponivel.QtdSaida"
            .Width           = 80
            .Header1.Caption = "Distribuido"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column7
            .ControlSource   = "cursor_4c_Disponivel.QtdSaldo"
            .Width           = 80
            .Header1.Caption = "Saldo"
        ENDWITH

        *-- Distribui grid (Column3=QtdDistr editable, Column4=locals editable)
        loc_oSub.AddObject("grd_4c_Distribui", "Grid")
        WITH loc_oSub.grd_4c_Distribui
            .Left             = 664
            .Top              = 141
            .Width            = 234
            .Height           = 327
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 4
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.grd_4c_Distribui.Column1
            .ControlSource   = "cursor_4c_Distribui.emps"
            .Width           = 50
            .ReadOnly        = .T.
            .Header1.Caption = "Empresa"
        ENDWITH
        WITH loc_oSub.grd_4c_Distribui.Column2
            .ControlSource   = "cursor_4c_Distribui.QtdSaldo"
            .Width           = 55
            .ReadOnly        = .T.
            .Header1.Caption = "Saldo"
        ENDWITH
        WITH loc_oSub.grd_4c_Distribui.Column3
            .ControlSource   = "cursor_4c_Distribui.QtdDistr"
            .Width           = 65
            .Header1.Caption = "Quantidade"
        ENDWITH
        WITH loc_oSub.grd_4c_Distribui.Column4
            .ControlSource   = "cursor_4c_Distribui.locals"
            .Width           = 55
            .Header1.Caption = "Local"
        ENDWITH

        *-- Product info panel (read-only) - bottom of page
        loc_oSub.AddObject("lbl_4c_LblGrupoP", "Label")
        WITH loc_oSub.lbl_4c_LblGrupoP
            .Caption   = "Grupo :"
            .Left      = 67
            .Top       = 474
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH loc_oSub.txt_4c_CdGrupo
            .Left      = 116
            .Top       = 470
            .Width     = 65
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsGrupoP", "TextBox")
        WITH loc_oSub.txt_4c_DsGrupoP
            .Left      = 182
            .Top       = 470
            .Width     = 270
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 470 right side: Linha
        loc_oSub.AddObject("lbl_4c_LblLinha", "Label")
        WITH loc_oSub.lbl_4c_LblLinha
            .Caption   = "Linha :"
            .Left      = 549
            .Top       = 473
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CdLinha", "TextBox")
        WITH loc_oSub.txt_4c_CdLinha
            .Left      = 593
            .Top       = 470
            .Width     = 80
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsLinha", "TextBox")
        WITH loc_oSub.txt_4c_DsLinha
            .Left      = 674
            .Top       = 470
            .Width     = 220
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 492 left side: Subgrupo (produto)
        loc_oSub.AddObject("lbl_4c_LblSgrupoP", "Label")
        WITH loc_oSub.lbl_4c_LblSgrupoP
            .Caption   = "Subgrupo :"
            .Left      = 50
            .Top       = 497
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CdSgrupoP", "TextBox")
        WITH loc_oSub.txt_4c_CdSgrupoP
            .Left      = 116
            .Top       = 492
            .Width     = 65
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsSgrupoP", "TextBox")
        WITH loc_oSub.txt_4c_DsSgrupoP
            .Left      = 182
            .Top       = 492
            .Width     = 270
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 492 right side: Fornecedor
        loc_oSub.AddObject("lbl_4c_LblForn", "Label")
        WITH loc_oSub.lbl_4c_LblForn
            .Caption   = "Fornecedor :"
            .Left      = 519
            .Top       = 496
            .Width     = 72
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CdFornecedor", "TextBox")
        WITH loc_oSub.txt_4c_CdFornecedor
            .Left      = 593
            .Top       = 492
            .Width     = 80
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsFornecedor", "TextBox")
        WITH loc_oSub.txt_4c_DsFornecedor
            .Left      = 674
            .Top       = 492
            .Width     = 220
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 514: Modelo (left) + Ref Fornecedor (right)
        loc_oSub.AddObject("lbl_4c_LblModelo", "Label")
        WITH loc_oSub.lbl_4c_LblModelo
            .Caption   = "Modelo :"
            .Left      = 62
            .Top       = 517
            .Width     = 50
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CodFinP", "TextBox")
        WITH loc_oSub.txt_4c_CodFinP
            .Left      = 116
            .Top       = 514
            .Width     = 65
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DesFinP", "TextBox")
        WITH loc_oSub.txt_4c_DesFinP
            .Left      = 182
            .Top       = 514
            .Width     = 270
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("lbl_4c_LblRefForn", "Label")
        WITH loc_oSub.lbl_4c_LblRefForn
            .Caption   = "Ref. Fornecedor :"
            .Left      = 495
            .Top       = 517
            .Width     = 92
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_RefFornecedor", "TextBox")
        WITH loc_oSub.txt_4c_RefFornecedor
            .Left      = 593
            .Top       = 514
            .Width     = 190
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 537: Grupo de Venda (left) + PrecoVenda/Peso (right)
        loc_oSub.AddObject("lbl_4c_LblGrpVenda", "Label")
        WITH loc_oSub.lbl_4c_LblGrpVenda
            .Caption   = "Grupo de Venda :"
            .Left      = 19
            .Top       = 540
            .Width     = 92
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_GrpVenda", "TextBox")
        WITH loc_oSub.txt_4c_GrpVenda
            .Left      = 116
            .Top       = 537
            .Width     = 80
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_GrDvenda", "TextBox")
        WITH loc_oSub.txt_4c_GrDvenda
            .Left      = 197
            .Top       = 537
            .Width     = 255
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("lbl_4c_LblPrVenda", "Label")
        WITH loc_oSub.lbl_4c_LblPrVenda
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .Left      = 538
            .Top       = 540
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_PrVenda", "TextBox")
        WITH loc_oSub.txt_4c_PrVenda
            .Left      = 593
            .Top       = 536
            .Width     = 108
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_MoedaPrVenda", "TextBox")
        WITH loc_oSub.txt_4c_MoedaPrVenda
            .Left      = 703
            .Top       = 536
            .Width     = 31
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("lbl_4c_LblPeso", "Label")
        WITH loc_oSub.lbl_4c_LblPeso
            .Caption   = "Peso :"
            .Left      = 740
            .Top       = 540
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_PesoMedio", "TextBox")
        WITH loc_oSub.txt_4c_PesoMedio
            .Left      = 781
            .Top       = 537
            .Width     = 75
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Filter row 2: Subgrupo filter
        loc_oSub.AddObject("lbl_4c_LblSgrupoF", "Label")
        WITH loc_oSub.lbl_4c_LblSgrupoF
            .Caption   = "Subgrupo :"
            .Left      = 174
            .Top       = 100
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CodSgrupo", "TextBox")
        WITH loc_oSub.txt_4c_CodSgrupo
            .Left     = 175
            .Top      = 115
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsSgrupo", "TextBox")
        WITH loc_oSub.txt_4c_DsSgrupo
            .Left     = 228
            .Top      = 115
            .Width    = 236
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaOperacoes()
    *==========================================================================
        LOCAL loc_oSub AS Object
        loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3

        *-- Obs container
        loc_oSub.AddObject("cnt_4c_Operacao", "Container")
        WITH loc_oSub.cnt_4c_Operacao
            .Left        = 3
            .Top         = 13
            .Width       = 564
            .Height      = 165
            .BackColor   = RGB(240,240,240)
            .BorderWidth = 1
            .BackStyle   = 1
            .Visible     = .T.
        ENDWITH
        loc_oSub.cnt_4c_Operacao.AddObject("lbl_4c__Obs", "Label")
        WITH loc_oSub.cnt_4c_Operacao.lbl_4c__Obs
            .Caption   = "Obs. :"
            .Left      = 12
            .Top       = 10
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.cnt_4c_Operacao.AddObject("txt_4c_CodObs", "TextBox")
        WITH loc_oSub.cnt_4c_Operacao.txt_4c_CodObs
            .Left     = 52
            .Top      = 10
            .Width    = 27
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        loc_oSub.cnt_4c_Operacao.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oSub.cnt_4c_Operacao.obj_4c_GetObs
            .Left     = 83
            .Top      = 10
            .Width    = 407
            .Height   = 112
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Process commandgroup (1 button: Processar Distribuicao)
        loc_oSub.AddObject("cmdg_4c_ProcOper", "CommandGroup")
        WITH loc_oSub.cmdg_4c_ProcOper
            .Left        = 733
            .Top         = 11
            .Width       = 120
            .Height      = 122
            .ButtonCount = 1
        ENDWITH
        WITH loc_oSub.cmdg_4c_ProcOper.Buttons(1)
            .Caption = "Processar Distribui" + CHR(231) + CHR(227) + "o"
            .Left    = 5
            .Top     = 5
            .Width   = 106
            .Height  = 110
            .Picture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
        ENDWITH

        *-- Operations pageframe (Movimentacoes + Itens)
        loc_oSub.AddObject("pgf_4c_Operacoes", "PageFrame")
        WITH loc_oSub.pgf_4c_Operacoes
            .Left      = 1
            .Top       = 191
            .Width     = 997
            .Height    = 377
            .PageCount = 2
            .Tabs      = .T.
            .Page1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
            .Page2.Caption = "Itens"
        ENDWITH

        *-- grdCabOperas: 8 columns matching legacy (emps/dopes/numes/empds/grupos/contaos/grupods/contads)
        loc_oSub.pgf_4c_Operacoes.Page1.AddObject("grd_4c_CabOperas", "Grid")
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
            .Left             = 9
            .Top              = 6
            .Width            = 975
            .Height           = 339
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 8
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .ReadOnly         = .T.
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1
            .ControlSource   = "cursor_4c_CabOpera.emps"
            .Width           = 45
            .Header1.Caption = "Emp O"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2
            .ControlSource   = "cursor_4c_CabOpera.dopes"
            .Width           = 250
            .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3
            .ControlSource   = "cursor_4c_CabOpera.numes"
            .Width           = 80
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4
            .ControlSource   = "cursor_4c_CabOpera.empds"
            .Width           = 45
            .Header1.Caption = "Emp D"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5
            .ControlSource   = "cursor_4c_CabOpera.grupos"
            .Width           = 80
            .Header1.Caption = "Grupo Orig"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6
            .ControlSource   = "cursor_4c_CabOpera.contaos"
            .Width           = 80
            .Header1.Caption = "Conta Orig"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column7
            .ControlSource   = "cursor_4c_CabOpera.grupods"
            .Width           = 80
            .Header1.Caption = "Grupo Dest"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column8
            .ControlSource   = "cursor_4c_CabOpera.contads"
            .Width           = 80
            .Header1.Caption = "Conta Dest"
        ENDWITH

        *-- grdItnOperas: 6 columns (cpros/dpros/codcors/codtams/qtds/locals)
        loc_oSub.pgf_4c_Operacoes.Page2.AddObject("grd_4c_ItnOperas", "Grid")
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
            .Left             = 9
            .Top              = 5
            .Width            = 975
            .Height           = 340
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 6
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .ReadOnly         = .T.
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1
            .ControlSource   = "cursor_4c_ItensOper.cpros"
            .Width           = 106
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2
            .ControlSource   = "cursor_4c_ItensOper.dpros"
            .Width           = 382
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3
            .ControlSource   = "cursor_4c_ItensOper.codcors"
            .Width           = 60
            .Header1.Caption = "Cor"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4
            .ControlSource   = "cursor_4c_ItensOper.codtams"
            .Width           = 60
            .Header1.Caption = "Tam"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5
            .ControlSource   = "cursor_4c_ItensOper.qtds"
            .Width           = 150
            .Header1.Caption = "Quantidade"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column6
            .ControlSource   = "cursor_4c_ItensOper.locals"
            .Width           = 150
            .Header1.Caption = "Local"
        ENDWITH
    ENDPROC

    *==========================================================================
    * METODOS DE NEGOCIO
    *==========================================================================

    PROCEDURE CarregarLista()
    *==========================================================================
        THIS.this_oBusinessObject.this_dDataInicial = ;
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value
        THIS.this_oBusinessObject.this_dDataFinal = ;
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value
        THIS.this_oBusinessObject.Buscar("")
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = ""
        IF USED("cursor_4c_Dados")
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 2
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.Codigos"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.Datas"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.Header1.Caption = "Data"
        ENDIF
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
    ENDPROC

    PROCEDURE AbrirNovoBatch()
    *==========================================================================
        THIS.this_cEscolha = "INSERIR"
        THIS.this_cCodigos = ALLTRIM(TRANSFORM(fGerUniqueKey("SIGPRDIS"), "@L 9999999999"))
        THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = THIS.this_cCodigos
        THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "NOVO"

        IF THIS.this_oBusinessObject.BuscarEstoques()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
    ENDPROC

    PROCEDURE AbrirBatchExistente(par_cCodigos)
    *==========================================================================
        THIS.this_cEscolha = "ALTERAR"
        THIS.this_cCodigos = par_cCodigos
        THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = par_cCodigos
        THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "EDITAR"

        THIS.this_oBusinessObject.InicializarLote(par_cCodigos)

        IF THIS.this_oBusinessObject.BuscarEstoques()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF

        *-- Pre-marcar estoques do lote
        IF USED("cursor_4c_Estoques") AND USED("cursor_4c_LotePrDis")
            LOCAL loc_cEmpEst AS String
            SELECT cursor_4c_Estoques
            GO TOP
            DO WHILE !EOF("cursor_4c_Estoques")
                loc_cEmpEst = ALLTRIM(cursor_4c_Estoques.emps)
                SELECT cursor_4c_LotePrDis
                LOCATE FOR ALLTRIM(empds) = loc_cEmpEst
                IF FOUND()
                    REPLACE nMarca WITH 1 IN cursor_4c_Estoques
                ENDIF
                SELECT cursor_4c_Estoques
                SKIP
            ENDDO
            GO TOP IN cursor_4c_Estoques
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF

        *-- Carregar operacoes existentes
        IF THIS.this_oBusinessObject.BuscarOperacoes(par_cCodigos)
            LOCAL loc_oGrdCab AS Object
            loc_oGrdCab = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
            loc_oGrdCab.RecordSource = ""
            loc_oGrdCab.ColumnCount  = 8
            loc_oGrdCab.RecordSource = "cursor_4c_CabOpera"
            loc_oGrdCab.Column1.ControlSource   = "cursor_4c_CabOpera.emps"
            loc_oGrdCab.Column1.Header1.Caption = "Emp O"
            loc_oGrdCab.Column2.ControlSource   = "cursor_4c_CabOpera.dopes"
            loc_oGrdCab.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
            loc_oGrdCab.Column3.ControlSource   = "cursor_4c_CabOpera.numes"
            loc_oGrdCab.Column3.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrdCab.Column4.ControlSource   = "cursor_4c_CabOpera.empds"
            loc_oGrdCab.Column4.Header1.Caption = "Emp D"
            loc_oGrdCab.Column5.ControlSource   = "cursor_4c_CabOpera.grupos"
            loc_oGrdCab.Column5.Header1.Caption = "Grupo Orig"
            loc_oGrdCab.Column6.ControlSource   = "cursor_4c_CabOpera.contaos"
            loc_oGrdCab.Column6.Header1.Caption = "Conta Orig"
            loc_oGrdCab.Column7.ControlSource   = "cursor_4c_CabOpera.grupods"
            loc_oGrdCab.Column7.Header1.Caption = "Grupo Dest"
            loc_oGrdCab.Column8.ControlSource   = "cursor_4c_CabOpera.contads"
            loc_oGrdCab.Column8.Header1.Caption = "Conta Dest"
            loc_oGrdCab.Refresh()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .T.
        ENDIF

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        IF par_nPagina = 1
            THIS.CarregarLista()
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
            ELSE
                THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
            ENDIF
        ENDIF
        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS
    *==========================================================================

    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    PROCEDURE BtnNovoClick()
    *==========================================================================
        THIS.AbrirNovoBatch()
    ENDPROC

    PROCEDURE BtnAbrirClick()
    *==========================================================================
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 ;
                AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCAL loc_cCodigos AS String
            loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
            IF !EMPTY(loc_cCodigos)
                THIS.AbrirBatchExistente(loc_cCodigos)
            ENDIF
        ELSE
            MsgAviso("Selecione um lote na lista.", "Aviso")
        ENDIF
    ENDPROC

    PROCEDURE TxtDtInicialValid()
    *==========================================================================
        LOCAL loc_oDtI AS Object, loc_oDtF AS Object
        loc_oDtI = THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial
        loc_oDtF = THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal
        IF loc_oDtI.Value > loc_oDtF.Value
            loc_oDtF.Value = loc_oDtI.Value
        ENDIF
    ENDPROC

    PROCEDURE TxtDtFinalValid()
    *==========================================================================
        LOCAL loc_oDtI AS Object, loc_oDtF AS Object
        loc_oDtI = THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial
        loc_oDtF = THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal
        IF loc_oDtF.Value < loc_oDtI.Value
            loc_oDtI.Value = loc_oDtF.Value
        ENDIF
    ENDPROC

    PROCEDURE TxtDtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        THIS.CarregarLista()
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
    ENDPROC

    PROCEDURE BtnVoltarListaClick()
    *==========================================================================
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.CarregarLista()
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE BtnVoltarEstClick()
    *==========================================================================
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 1
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
    ENDPROC

    PROCEDURE BtnMarcarClick()
    *==========================================================================
        IF USED("cursor_4c_Estoques")
            SELECT cursor_4c_Estoques
            REPLACE ALL nMarca WITH 1
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarClick()
    *==========================================================================
        IF USED("cursor_4c_Estoques")
            SELECT cursor_4c_Estoques
            REPLACE ALL nMarca WITH 0
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
    *==========================================================================
        NODEFAULT
        IF USED("cursor_4c_Estoques")
            SELECT cursor_4c_Estoques
            REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF INLIST(par_nKeyCode, 13, 32)
            NODEFAULT
            IF USED("cursor_4c_Estoques")
                SELECT cursor_4c_Estoques
                REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnProcessarPage1Click()
    *==========================================================================
        IF THIS.this_oBusinessObject.PrepararCursoresDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
            LOCAL loc_oSub2 AS Object
            loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
            loc_oSub2.grd_4c_Disponivel.RecordSource = ""
            IF USED("cursor_4c_Disponivel")
                loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
                loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
                loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
                loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
                loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
                loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
                loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
                loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
                loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
                loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
                loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
                loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
                loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
                loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
            ENDIF
            loc_oSub2.grd_4c_Disponivel.Refresh()
            loc_oSub2.grd_4c_Distribui.RecordSource = ""
            IF USED("cursor_4c_Distribui")
                loc_oSub2.grd_4c_Distribui.ColumnCount = 4
                loc_oSub2.grd_4c_Distribui.RecordSource = "cursor_4c_Distribui"
                loc_oSub2.grd_4c_Distribui.Column1.ControlSource = "cursor_4c_Distribui.emps"
                loc_oSub2.grd_4c_Distribui.Column1.Header1.Caption = "Empresa"
                loc_oSub2.grd_4c_Distribui.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
                loc_oSub2.grd_4c_Distribui.Column2.Header1.Caption = "Saldo"
                loc_oSub2.grd_4c_Distribui.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
                loc_oSub2.grd_4c_Distribui.Column3.Header1.Caption = "Quantidade"
                loc_oSub2.grd_4c_Distribui.Column4.ControlSource = "cursor_4c_Distribui.locals"
                loc_oSub2.grd_4c_Distribui.Column4.Header1.Caption = "Local"
            ENDIF
            loc_oSub2.grd_4c_Distribui.Refresh()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .T.
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 2
            loc_oSub2.grd_4c_Disponivel.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
    *==========================================================================
        IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel")
            LOCAL loc_cCpros AS String
            SELECT cursor_4c_Disponivel
            loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
            IF !EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.BuscarProduto(loc_cCpros)
                LOCAL loc_oSub2 AS Object, loc_cCGru AS String, loc_cSGru AS String
                LOCAL loc_nRes AS Number, loc_oErro
                loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
                SELECT cursor_4c_Produto
                loc_cCGru = TratarNulo(cgrus,  "C")
                loc_cSGru = TratarNulo(sgrus,  "C")
                loc_oSub2.txt_4c_CdGrupo.Value       = loc_cCGru
                loc_oSub2.txt_4c_DsGrupoP.Value      = TratarNulo(dgrus,       "C")
                loc_oSub2.txt_4c_CdLinha.Value        = TratarNulo(linhas,      "C")
                loc_oSub2.txt_4c_DsLinha.Value        = TratarNulo(desclin,     "C")
                loc_oSub2.txt_4c_CdSgrupoP.Value      = loc_cSGru
                loc_oSub2.txt_4c_CdFornecedor.Value   = TratarNulo(ifors,       "C")
                loc_oSub2.txt_4c_DsFornecedor.Value   = TratarNulo(rclis,       "C")
                loc_oSub2.txt_4c_CodFinP.Value        = TratarNulo(codfinp,     "C")
                loc_oSub2.txt_4c_DesFinP.Value        = TratarNulo(descfeitio,  "C")
                loc_oSub2.txt_4c_RefFornecedor.Value  = TratarNulo(reffs,       "C")
                loc_oSub2.txt_4c_GrpVenda.Value       = TratarNulo(colecoes,    "C")
                loc_oSub2.txt_4c_GrDvenda.Value       = ""
                loc_oSub2.txt_4c_PrVenda.Value        = TratarNulo(pvens,       "N")
                loc_oSub2.txt_4c_MoedaPrVenda.Value   = TratarNulo(moevs,       "C")
                loc_oSub2.txt_4c_PesoMedio.Value      = TratarNulo(pesoms,      "N")

                *-- Subgrupo description from SigCdPsg (separate query like original)
                IF !EMPTY(loc_cSGru)
                    TRY
                        IF USED("cursor_4c_TmpSgru")
                            USE IN cursor_4c_TmpSgru
                        ENDIF
                        loc_nRes = SQLEXEC(gnConnHandle, ;
                            "SELECT s.descricaos FROM SigCdPsg s" + ;
                            " WHERE s.cgrus = " + EscaparSQL(loc_cCGru) + ;
                            " AND s.codigos = " + EscaparSQL(loc_cSGru), ;
                            "cursor_4c_TmpSgru")
                        IF loc_nRes > 0 AND USED("cursor_4c_TmpSgru") AND RECCOUNT("cursor_4c_TmpSgru") > 0
                            SELECT cursor_4c_TmpSgru
                            loc_oSub2.txt_4c_DsSgrupoP.Value = TratarNulo(descricaos, "C")
                        ELSE
                            loc_oSub2.txt_4c_DsSgrupoP.Value = ""
                        ENDIF
                        IF USED("cursor_4c_TmpSgru")
                            USE IN cursor_4c_TmpSgru
                        ENDIF
                    CATCH TO loc_oErro
                        MsgErro(loc_oErro.Message, "Erro lookup subgrupo")
                    ENDTRY
                ELSE
                    loc_oSub2.txt_4c_DsSgrupoP.Value = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE GrdDistribuiQtdLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF USED("cursor_4c_Disponivel") AND USED("cursor_4c_Distribui") ;
                AND !EOF("cursor_4c_Disponivel")
            LOCAL loc_cCpros AS String, loc_cCodCors AS String, loc_cCodTams AS String
            SELECT cursor_4c_Disponivel
            loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
            loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
            loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)
            THIS.this_oBusinessObject.CalcularSaldo(loc_cCpros, loc_cCodCors, loc_cCodTams)
            LOCAL loc_oSub2 AS Object
            loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
            loc_oSub2.grd_4c_Disponivel.Refresh()
            loc_oSub2.grd_4c_Distribui.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE GrdDistribuiLocalValid()
    *==========================================================================
        LOCAL loc_cLocal AS String, loc_nRes AS Number, loc_oLookup AS Object
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cLocal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2 ;
                .grd_4c_Distribui.Column4.Text1.Value)
            IF !EMPTY(loc_cLocal)
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos LIKE " + ;
                    EscaparSQL(loc_cLocal + "%") + " ORDER BY Codigos", ;
                    "cursor_4c_Locais", "Codigos", loc_cLocal, ;
                    "Localiza" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.AddColuna("Codigos",    "", "Localiza" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.AddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                    IF USED("cursor_4c_Locais") AND RECCOUNT("cursor_4c_Locais") > 0
                        IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
                            REPLACE cursor_4c_Distribui.locals WITH ALLTRIM(cursor_4c_Locais.Codigos)
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Locais")
                        USE IN cursor_4c_Locais
                    ENDIF
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Lookup Local")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        DO CASE
            CASE par_nKeyCode = 9
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Column1.SetFocus()
                NODEFAULT
            CASE par_nKeyCode = 115
                THIS.GrdDistribuiLocalValid()
                NODEFAULT
        ENDCASE
    ENDPROC

    PROCEDURE TxtProdutoInicialValid()
    *==========================================================================
        LOCAL loc_cCpros AS String, loc_nRec AS Number
        loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.txt_4c_ProdutoInicial.Value)
        IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Disponivel")
            SELECT cursor_4c_Disponivel
            loc_nRec = RECNO()
            GO TOP
            LOCATE FOR ALLTRIM(cpros) >= loc_cCpros
            IF EOF()
                GO loc_nRec
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE TxtCodSgrupoValid(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cCodigo AS String, loc_nRes AS Number, loc_oLookup AS Object, loc_oErro
        LOCAL loc_oSub2 AS Object
        loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        DO CASE
            CASE par_nKeyCode = 13 OR par_nKeyCode = 115
                NODEFAULT
            CASE par_nKeyCode = 9
                NODEFAULT
            OTHERWISE
                RETURN
        ENDCASE
        loc_cCodigo = ALLTRIM(loc_oSub2.txt_4c_CodSgrupo.Value)
        IF EMPTY(loc_cCodigo)
            loc_oSub2.txt_4c_DsSgrupo.Value = ""
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_SgruBusca")
                USE IN cursor_4c_SgruBusca
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos LIKE " + ;
                EscaparSQL(loc_cCodigo + "%") + " ORDER BY codigos", ;
                "cursor_4c_SgruBusca")
            IF loc_nRes > 0 AND USED("cursor_4c_SgruBusca") AND RECCOUNT("cursor_4c_SgruBusca") > 0
                IF RECCOUNT("cursor_4c_SgruBusca") = 1
                    SELECT cursor_4c_SgruBusca
                    loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBusca.codigos)
                    loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBusca.descricaos)
                ELSE
                    loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                        "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos LIKE " + ;
                        EscaparSQL(loc_cCodigo + "%") + " ORDER BY codigos", ;
                        "cursor_4c_SgruBuscaD", "codigos", loc_cCodigo, "Subgrupos")
                    IF VARTYPE(loc_oLookup) = "O"
                        loc_oLookup.AddColuna("codigos",    "XXXXXXXXXX", "C" + CHR(243) + "digo")
                        loc_oLookup.AddColuna("descricaos", "",            "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.Show()
                        IF USED("cursor_4c_SgruBuscaD") AND RECCOUNT("cursor_4c_SgruBuscaD") > 0
                            SELECT cursor_4c_SgruBuscaD
                            loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBuscaD.codigos)
                            loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBuscaD.descricaos)
                        ENDIF
                        IF USED("cursor_4c_SgruBuscaD")
                            USE IN cursor_4c_SgruBuscaD
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                loc_oSub2.txt_4c_CodSgrupo.Value = ""
                loc_oSub2.txt_4c_DsSgrupo.Value  = ""
            ENDIF
            IF USED("cursor_4c_SgruBusca")
                USE IN cursor_4c_SgruBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro lookup Subgrupo C" + CHR(243) + "digo")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDsSgrupoValid(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cDesc AS String, loc_oLookup AS Object, loc_oErro
        LOCAL loc_oSub2 AS Object
        loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        DO CASE
            CASE par_nKeyCode = 13 OR par_nKeyCode = 115
                NODEFAULT
            CASE par_nKeyCode = 9
                NODEFAULT
            OTHERWISE
                RETURN
        ENDCASE
        loc_cDesc = ALLTRIM(loc_oSub2.txt_4c_DsSgrupo.Value)
        IF EMPTY(loc_cDesc)
            loc_oSub2.txt_4c_CodSgrupo.Value = ""
            RETURN
        ENDIF
        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SELECT descricaos, codigos FROM SigCdPsg ORDER BY descricaos", ;
                "cursor_4c_SgruBuscaDesc", "descricaos", loc_cDesc, "Subgrupos")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.AddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.AddColuna("codigos",    "", "C" + CHR(243) + "digo")
                loc_oLookup.Show()
                IF USED("cursor_4c_SgruBuscaDesc") AND RECCOUNT("cursor_4c_SgruBuscaDesc") > 0
                    SELECT cursor_4c_SgruBuscaDesc
                    loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBuscaDesc.codigos)
                    loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBuscaDesc.descricaos)
                ELSE
                    loc_oSub2.txt_4c_CodSgrupo.Value = ""
                    loc_oSub2.txt_4c_DsSgrupo.Value  = ""
                ENDIF
                IF USED("cursor_4c_SgruBuscaDesc")
                    USE IN cursor_4c_SgruBuscaDesc
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro lookup Subgrupo Descri" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    PROCEDURE TxtCGrupoValid(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cCodigo AS String, loc_nRes AS Number, loc_oLookup AS Object, loc_oErro
        LOCAL loc_oSub2 AS Object
        loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        loc_cCodigo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
        IF loc_cCodigo == THIS.this_cUltimoCGrupoValidado
            RETURN
        ENDIF
        IF EMPTY(loc_cCodigo)
            loc_oSub2.txt_4c_DsGrupo.Value     = ""
            THIS.this_cUltimoCGrupoValidado     = ""
        ELSE
            TRY
                IF USED("cursor_4c_GrpBusca")
                    USE IN cursor_4c_GrpBusca
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
                    EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", "cursor_4c_GrpBusca")
                IF loc_nRes > 0 AND USED("cursor_4c_GrpBusca") AND RECCOUNT("cursor_4c_GrpBusca") > 0
                    IF RECCOUNT("cursor_4c_GrpBusca") = 1
                        SELECT cursor_4c_GrpBusca
                        loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBusca.CGrus)
                        loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBusca.DGrus)
                        THIS.this_cUltimoCGrupoValidado = ALLTRIM(cursor_4c_GrpBusca.CGrus)
                    ELSE
                        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                            "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
                            EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", ;
                            "cursor_4c_GrpBuscaD", "CGrus", loc_cCodigo, "Grupos")
                        IF VARTYPE(loc_oLookup) = "O"
                            loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
                            loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oLookup.Show()
                            IF USED("cursor_4c_GrpBuscaD") AND RECCOUNT("cursor_4c_GrpBuscaD") > 0
                                SELECT cursor_4c_GrpBuscaD
                                loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
                                loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaD.DGrus)
                                THIS.this_cUltimoCGrupoValidado = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
                            ENDIF
                            IF USED("cursor_4c_GrpBuscaD")
                                USE IN cursor_4c_GrpBuscaD
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    loc_oSub2.txt_4c_CodGrupo.Value = ""
                    loc_oSub2.txt_4c_DsGrupo.Value  = ""
                    THIS.this_cUltimoCGrupoValidado  = ""
                ENDIF
                IF USED("cursor_4c_GrpBusca")
                    USE IN cursor_4c_GrpBusca
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro lookup Grupo C" + CHR(243) + "digo")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE TxtDGrupoValid(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cDesc AS String, loc_oLookup AS Object, loc_oErro
        LOCAL loc_oSub2 AS Object
        loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        loc_cDesc  = ALLTRIM(loc_oSub2.txt_4c_DsGrupo.Value)
        IF loc_cDesc == THIS.this_cUltimoDGrupoValidado
            RETURN
        ENDIF
        IF EMPTY(loc_cDesc)
            loc_oSub2.txt_4c_CodGrupo.Value    = ""
            THIS.this_cUltimoDGrupoValidado     = ""
        ELSE
            TRY
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SELECT DGrus, CGrus FROM SigCdGrp ORDER BY DGrus", ;
                    "cursor_4c_GrpBuscaDesc", "DGrus", loc_cDesc, "Grupos")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oLookup.Show()
                    IF USED("cursor_4c_GrpBuscaDesc") AND RECCOUNT("cursor_4c_GrpBuscaDesc") > 0
                        SELECT cursor_4c_GrpBuscaDesc
                        loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaDesc.CGrus)
                        loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
                        THIS.this_cUltimoDGrupoValidado = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
                    ELSE
                        loc_oSub2.txt_4c_CodGrupo.Value = ""
                        loc_oSub2.txt_4c_DsGrupo.Value  = ""
                        THIS.this_cUltimoDGrupoValidado = ""
                    ENDIF
                    IF USED("cursor_4c_GrpBuscaDesc")
                        USE IN cursor_4c_GrpBuscaDesc
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro lookup Grupo Descri" + CHR(231) + CHR(227) + "o")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE BtnFiltrarClick()
    *==========================================================================
        LOCAL loc_oSub2 AS Object, loc_cCGrupo AS String, loc_nRes AS Number, loc_oErro
        loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        loc_cCGrupo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
        IF !USED("cursor_4c_Disponivel")
            RETURN
        ENDIF
        IF EMPTY(loc_cCGrupo)
            loc_oSub2.grd_4c_Disponivel.RecordSource = ""
            loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
            loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
            loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
            loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
            loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
            loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
            loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
            loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
            loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
            loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
            loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
            loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
            loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
            loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
            loc_oSub2.grd_4c_Disponivel.Refresh()
        ELSE
            TRY
                IF USED("cursor_4c_DispFiltro")
                    USE IN cursor_4c_DispFiltro
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT DISTINCT a.cpros," + ;
                    "  ISNULL(p.dpros,'') AS dpros," + ;
                    "  a.codcors, a.codtams," + ;
                    "  SUM(a.qtdos) AS QtdEstoque," + ;
                    "  SUM(a.qtds) AS QtdSaida," + ;
                    "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
                    " FROM SigPrDis a" + ;
                    " INNER JOIN SigCdPro p ON p.cpros = a.cpros" + ;
                    " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                    "   AND p.cgrus = " + EscaparSQL(loc_cCGrupo) + ;
                    " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
                    " ORDER BY a.cpros, a.codcors, a.codtams", "cursor_4c_DispFiltro")
                IF loc_nRes > 0
                    loc_oSub2.grd_4c_Disponivel.RecordSource = ""
                    loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
                    loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_DispFiltro"
                    loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_DispFiltro.cpros"
                    loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_DispFiltro.dpros"
                    loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_DispFiltro.codcors"
                    loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
                    loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_DispFiltro.codtams"
                    loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
                    loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_DispFiltro.QtdEstoque"
                    loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
                    loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_DispFiltro.QtdSaida"
                    loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
                    loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_DispFiltro.QtdSaldo"
                    loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
                    loc_oSub2.grd_4c_Disponivel.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro Filtrar")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE ImgFotoClick()
    *==========================================================================
        LOCAL loc_nRes AS Number, loc_cArquivo AS String, loc_oErro
        IF !USED("cursor_4c_Disponivel") OR EOF("cursor_4c_Disponivel")
            RETURN
        ENDIF
        TRY
            SELECT cursor_4c_Disponivel
            LOCAL loc_cCpros AS String
            loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
            IF !EMPTY(loc_cCpros)
                IF USED("cursor_4c_TmpFoto")
                    USE IN cursor_4c_TmpFoto
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros), ;
                    "cursor_4c_TmpFoto")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpFoto") > 0
                    SELECT cursor_4c_TmpFoto
                    IF !EMPTY(cursor_4c_TmpFoto.FigJpgs) AND !ISNULL(cursor_4c_TmpFoto.FigJpgs)
                        LOCAL loc_cBase64 AS String, loc_cBin AS String
                        loc_cBase64 = STRTRAN(STRTRAN(STRTRAN( ;
                            cursor_4c_TmpFoto.FigJpgs, ;
                            "data:image/png;base64,",  ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,",  "")
                        loc_cBin     = STRCONV(loc_cBase64, 14)
                        loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                        STRTOFILE(loc_cBin, loc_cArquivo)
                        IF FILE(loc_cArquivo)
                            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.img_4c_FigJpg.Picture = ;
                                loc_cArquivo
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TmpFoto")
                    USE IN cursor_4c_TmpFoto
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar foto do produto")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
    *==========================================================================
        IF THIS.this_oBusinessObject.ProcessarDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
            MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso.", "Sucesso")
            THIS.this_cEscolha = "ALTERAR"
            THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption = "EDITAR"
            *-- Switch to operacoes page
            IF THIS.this_oBusinessObject.BuscarOperacoes(THIS.this_cCodigos)
                LOCAL loc_oSub3 AS Object
                loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
                LOCAL loc_oGrdCab2 AS Object
                loc_oGrdCab2 = loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
                loc_oGrdCab2.RecordSource = ""
                IF USED("cursor_4c_CabOpera")
                    loc_oGrdCab2.ColumnCount  = 8
                    loc_oGrdCab2.RecordSource = "cursor_4c_CabOpera"
                    loc_oGrdCab2.Column1.ControlSource   = "cursor_4c_CabOpera.emps"
                    loc_oGrdCab2.Column1.Header1.Caption = "Emp O"
                    loc_oGrdCab2.Column2.ControlSource   = "cursor_4c_CabOpera.dopes"
                    loc_oGrdCab2.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                    loc_oGrdCab2.Column3.ControlSource   = "cursor_4c_CabOpera.numes"
                    loc_oGrdCab2.Column3.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrdCab2.Column4.ControlSource   = "cursor_4c_CabOpera.empds"
                    loc_oGrdCab2.Column4.Header1.Caption = "Emp D"
                    loc_oGrdCab2.Column5.ControlSource   = "cursor_4c_CabOpera.grupos"
                    loc_oGrdCab2.Column5.Header1.Caption = "Grupo Orig"
                    loc_oGrdCab2.Column6.ControlSource   = "cursor_4c_CabOpera.contaos"
                    loc_oGrdCab2.Column6.Header1.Caption = "Conta Orig"
                    loc_oGrdCab2.Column7.ControlSource   = "cursor_4c_CabOpera.grupods"
                    loc_oGrdCab2.Column7.Header1.Caption = "Grupo Dest"
                    loc_oGrdCab2.Column8.ControlSource   = "cursor_4c_CabOpera.contads"
                    loc_oGrdCab2.Column8.Header1.Caption = "Conta Dest"
                ENDIF
                loc_oGrdCab2.Refresh()
                loc_oSub3.Enabled = .T.
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 3
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnProcOperClick()
    *==========================================================================
        LOCAL loc_oSub3 AS Object, loc_cCodObs AS String, loc_cObs AS String
        loc_oSub3   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
        loc_cCodObs = ALLTRIM(loc_oSub3.cnt_4c_Operacao.txt_4c_CodObs.Value)
        loc_cObs    = ALLTRIM(loc_oSub3.cnt_4c_Operacao.obj_4c_GetObs.Value)
        MsgAviso("Processamento de opera" + CHR(231) + CHR(245) + "es n" + ;
                 CHR(227) + "o implementado nesta vers" + CHR(227) + "o." + CHR(13) + ;
                 "O lote j" + CHR(225) + " foi salvo em SigPrDis.", "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE GrdCabOperasAfterRowColChange(par_nColIndex)
    *==========================================================================
        IF USED("cursor_4c_CabOpera") AND !EOF("cursor_4c_CabOpera")
            SELECT cursor_4c_CabOpera
            LOCAL loc_cEmpDopNums AS String
            loc_cEmpDopNums = ALLTRIM(cursor_4c_CabOpera.empdopnums)
            IF !EMPTY(loc_cEmpDopNums) AND THIS.this_oBusinessObject.BuscarItensOperacao(loc_cEmpDopNums)
                LOCAL loc_oSub3 AS Object
                loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
                LOCAL loc_oGrdItn AS Object
                loc_oGrdItn = loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
                loc_oGrdItn.RecordSource = ""
                IF USED("cursor_4c_ItensOper")
                    loc_oGrdItn.ColumnCount  = 6
                    loc_oGrdItn.RecordSource = "cursor_4c_ItensOper"
                    loc_oGrdItn.Column1.ControlSource   = "cursor_4c_ItensOper.cpros"
                    loc_oGrdItn.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrdItn.Column2.ControlSource   = "cursor_4c_ItensOper.dpros"
                    loc_oGrdItn.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrdItn.Column3.ControlSource   = "cursor_4c_ItensOper.codcors"
                    loc_oGrdItn.Column3.Header1.Caption = "Cor"
                    loc_oGrdItn.Column4.ControlSource   = "cursor_4c_ItensOper.codtams"
                    loc_oGrdItn.Column4.Header1.Caption = "Tam"
                    loc_oGrdItn.Column5.ControlSource   = "cursor_4c_ItensOper.qtds"
                    loc_oGrdItn.Column5.Header1.Caption = "Quantidade"
                    loc_oGrdItn.Column6.ControlSource   = "cursor_4c_ItensOper.locals"
                    loc_oGrdItn.Column6.Header1.Caption = "Local"
                ENDIF
                loc_oGrdItn.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere filtros de data do form para o BO
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg1 AS Object
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        THIS.this_oBusinessObject.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
        THIS.this_oBusinessObject.this_dDataFinal   = loc_oPg1.txt_4c_DtFinal.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO de volta para o form
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg1 AS Object
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(THIS.this_oBusinessObject.this_dDataInicial) = "D" ;
                AND !EMPTY(THIS.this_oBusinessObject.this_dDataInicial)
            loc_oPg1.txt_4c_DtInicial.Value = THIS.this_oBusinessObject.this_dDataInicial
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject.this_dDataFinal) = "D" ;
                AND !EMPTY(THIS.this_oBusinessObject.this_dDataFinal)
            loc_oPg1.txt_4c_DtFinal.Value = THIS.this_oBusinessObject.this_dDataFinal
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Atualiza lista com filtros de data atuais do form
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.FormParaBO()
        THIS.CarregarLista()
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao em Page2 e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Cancelar e voltar para a lista de lotes?", ;
                "Cancelar Opera" + CHR(231) + CHR(227) + "o")
            THIS.this_cEscolha = ""
            THIS.this_cCodigos = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = ""
            THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.CarregarLista()
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
            ELSE
                THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos de filtro de data (Page1)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1 AS Object
        IF VARTYPE(par_lHabilitar) != "L"
            par_lHabilitar = .T.
        ENDIF
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg1.txt_4c_DtInicial.Enabled = par_lHabilitar
        loc_oPg1.txt_4c_DtFinal.Enabled   = par_lHabilitar
        loc_oPg1.cmd_4c_Novo.Enabled       = par_lHabilitar
        loc_oPg1.cmd_4c_Abrir.Enabled      = par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta filtros de data para hoje e recarrega lista
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_dHoje AS Date
        loc_dHoje = DATE()
        THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value = loc_dHoje
        THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value   = loc_dHoje
        THIS.this_oBusinessObject.this_dDataInicial = loc_dHoje
        THIS.this_oBusinessObject.this_dDataFinal   = loc_dHoje
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo ativo
    * Modo "LISTA": todos os botoes da Page1 habilitados
    * Modo "DADOS": botoes da Page1 desabilitados enquanto edita lote
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lEmLista AS Logical
        IF VARTYPE(par_cModo) != "C"
            par_cModo = "LISTA"
        ENDIF
        loc_lEmLista = (UPPER(ALLTRIM(par_cModo)) = "LISTA")
        THIS.HabilitarCampos(loc_lEmLista)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        THIS.AbrirNovoBatch()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        LOCAL loc_cCodigos AS String
        loc_cCodigos = ""
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF
        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF
        THIS.AbrirBatchExistente(loc_cCodigos)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        LOCAL loc_cCodigos AS String
        loc_cCodigos = ""
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF
        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF
        THIS.AbrirBatchExistente(loc_cCodigos)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_cCodigos AS String, loc_lResultado AS Logical, loc_nRes AS Number, loc_oErro AS Object
        loc_lResultado = .F.
        loc_cCodigos = ""
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF
        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF
        IF !MsgConfirma("Confirmar exclus" + CHR(227) + "o do lote " + loc_cCodigos + "?", "Excluir Lote")
            RETURN
        ENDIF
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, "DELETE FROM SigPrDis WHERE Codigos = " + EscaparSQL(loc_cCodigos))
            IF loc_nRes >= 0
                loc_lResultado = .T.
                MsgInfo("Lote exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir lote: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir")
        ENDTRY
    ENDPROC

ENDDEFINE
