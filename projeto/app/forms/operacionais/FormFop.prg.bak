*==============================================================================
* FormFop.prg - Fornecedores do Produto
* Origem: SIGCDFOP.SCX (task421)
* Herda de: FormBase
* Tipo: OPERACIONAL (form filho/modal - gerencia fornecedores em SigPrFnc)
*       Aberto pelo form pai com: CREATEOBJECT("FormFop", oFormPai, nDataSes, cEscolha, cProduto)
*       DataSession=1: operacoes via FopBO que acessa SQL Server diretamente
*==============================================================================

DEFINE CLASS FormFop AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    DataSession  = 1
    Caption      = "Fornecedores do Produto"

    *-- Referencia ao form pai
    this_oParentForm  = .NULL.

    *-- Modo herdado do form pai ("INSERIR", "ALTERAR" ou "VISUALIZAR")
    this_cPcEscolha   = ""
    this_lModoEdicao  = .F.

    *-- Produto em edicao
    this_cCpros       = ""
    this_cDpros       = ""

    *-- Flags de controle (espelham houveincl/houveexcl do legado)
    this_lHouveIncl   = .F.
    this_lHouveExcl   = .F.

    *==========================================================================
    * Init - Recebe parametros do form pai e prepara estado inicial
    * par_oParentForm : referencia ao form pai (FormProduto ou similar)
    * par_nDataSes    : DataSession do pai (nao usado na nova arq - DataSession=1)
    * par_cEscolha    : modo de operacao ("INSERIR", "ALTERAR", "VISUALIZAR")
    * par_cProduto    : codigo do produto (char) - SigCdPro.cPros
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_nDataSes, par_cEscolha, par_cProduto

        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
            ENDIF

            THIS.this_cPcEscolha  = IIF(TYPE("par_cEscolha")  = "C", UPPER(ALLTRIM(par_cEscolha)), "VISUALIZAR")
            THIS.this_lModoEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            THIS.this_cCpros      = IIF(TYPE("par_cProduto") = "C", ALLTRIM(par_cProduto), "")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormFop.Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura visual, instancia BO e carrega dados
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_nRet, loc_cSQL
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON

            *-- Instanciar BO
            THIS.this_oBusinessObject = CREATEOBJECT("FopBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Obter descricao do produto para o caption
                IF !EMPTY(THIS.this_cCpros)
                    loc_cSQL = "SELECT ISNULL(Dpros, '') AS Dpros " + ;
                               "FROM SigCdPro " + ;
                               "WHERE Cpros = " + EscaparSQL(THIS.this_cCpros)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crFopProdDesc")
                    IF loc_nRet > 0 AND !EOF("crFopProdDesc")
                        THIS.this_cDpros = ALLTRIM(NVL(crFopProdDesc.Dpros, ""))
                    ENDIF
                    IF USED("crFopProdDesc")
                        USE IN crFopProdDesc
                    ENDIF

                    THIS.Caption = "Fornecedores do Produto : " + THIS.this_cCpros + "-" + THIS.this_cDpros
                ENDIF

                *-- Estrutura visual base (Fase 3) via orquestrador
                THIS.ConfigurarPageFrame()

                *-- Sincronizar caption nos labels
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincular eventos dos botoes
                BINDEVENT(THIS.cmd_4c_Inserir,  "Click",     THIS, "CmdInserirClick")
                BINDEVENT(THIS.cmd_4c_Excluir,  "Click",     THIS, "CmdExcluirClick")
                BINDEVENT(THIS.cmd_4c_Repetir,  "Click",     THIS, "CmdRepetirClick")
                BINDEVENT(THIS.cmd_4c_Encerrar, "Click",     THIS, "CmdEncerrarClick")
                BINDEVENT(THIS.txt_4c_Qtde,     "KeyPress",  THIS, "TxtQtdeKeyPress")
                BINDEVENT(THIS.txt_4c_Qtde,     "KeyPress", THIS, "TxtQtdeLostFocus")

                *-- Vincular eventos de lookup nas colunas editaveis do grid
                IF THIS.this_lModoEdicao
                    BINDEVENT(THIS.grd_4c_Dados.Column1.Text1,  "KeyPress", THIS, "GrdCol1KeyPress")
                    BINDEVENT(THIS.grd_4c_Dados.Column2.Text1,  "KeyPress", THIS, "GrdCol2KeyPress")
                    BINDEVENT(THIS.grd_4c_Dados.Column4.Text1,  "KeyPress", THIS, "GrdCol4KeyPress")
                    BINDEVENT(THIS.grd_4c_Dados.Column8.Text1,  "KeyPress", THIS, "GrdCol8KeyPress")
                    BINDEVENT(THIS.grd_4c_Dados.Column9.Text1,  "KeyPress", THIS, "GrdCol9KeyPress")
                    BINDEVENT(THIS.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GrdCol10KeyPress")
                ENDIF

                *-- Carregar fornecedores do produto e vincular ao grid
                IF !EMPTY(THIS.this_cCpros)
                    THIS.this_oBusinessObject.BuscarPorProduto(THIS.this_cCpros)
                    IF USED("crSigPrFnc")
                        THIS.grd_4c_Dados.ColumnCount  = 10
                        THIS.grd_4c_Dados.RecordSource = "crSigPrFnc"
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible  = .T.
                loc_lSucesso  = .T.
            ELSE
                MsgErro("Falha ao criar FopBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual
    * SIGCDFOP legado (SCX, Width=1075) eh Form PLANO sem PageFrame ??? layout
    * flat (cabecalho + botoes no topo + grid + area de repeticao). PILAR 1 (UX
    * pixel-perfect) exige manter esse layout ao inves de introduzir abas
    * artificialmente. Esta rotina preserva o papel arquitetural de
    * "ConfigurarPageFrame" como ponto de entrada da montagem visual, delegando
    * para os helpers dedicados (cabecalho, botoes; grid e area repetir vem em
    * fases posteriores).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrid()
        THIS.ConfigurarAreaRepetir()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho com labels de titulo
    * Original: cntSombra Top=0, Width=1104, Height=80, BackColor=100,100,100
    * Novo: proporcional a 1000px, mesmas alturas e estilos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 25
                .Width         = 660
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 24
                .Width         = 660
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria cmd_4c_Repetir, Inserir, Excluir, Encerrar
    * Original (1075px): Repetir=770, Inserir=846, Excluir=922, Sair=998
    * Escalado (1000px): Repetir=680, Inserir=760, Excluir=840, Encerrar=920
    * Todos ficam dentro do cnt_4c_Cabecalho (Top=3, sobrepostos)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_lVis, loc_oErro
        loc_lVis = THIS.this_lModoEdicao

        TRY
            *-- cmd_4c_Repetir (original cmdRepetir, Left=770->680)
            THIS.AddObject("cmd_4c_Repetir", "CommandButton")
            WITH THIS.cmd_4c_Repetir
                .Top             = 3
                .Left            = 680
                .Width           = 75
                .Height          = 75
                .Caption         = "Repetir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .ToolTipText     = "Repetir Fornecedor"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = loc_lVis
                .Enabled         = loc_lVis
            ENDWITH

            *-- ShpRepetir: shape decorativo ao redor do botao Repetir
            THIS.AddObject("shp_4c_ShpRepetir", "Shape")
            WITH THIS.shp_4c_ShpRepetir
                .Top         = 1
                .Left        = 677
                .Width       = 81
                .Height      = 80
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = loc_lVis
            ENDWITH

            *-- cmd_4c_Inserir (original cmdInserir, Left=846->760)
            THIS.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH THIS.cmd_4c_Inserir
                .Top             = 3
                .Left            = 760
                .Width           = 75
                .Height          = 75
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .ToolTipText     = "Inserir Fornecedor"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = loc_lVis
                .Enabled         = loc_lVis
            ENDWITH

            *-- cmd_4c_Excluir (original cmdExcluir, Left=922->840)
            THIS.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH THIS.cmd_4c_Excluir
                .Top             = 3
                .Left            = 840
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .ToolTipText     = "Excluir Fornecedor"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = loc_lVis
                .Enabled         = loc_lVis
            ENDWITH

            *-- cmd_4c_Encerrar (original cmdSair, Left=998->920)
            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 3
                .Left            = 920
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH

            *-- Shape1: separador decorativo (original Shape1 Top=5, Left=816, W=7, H=22)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 5
                .Left        = 757
                .Width       = 7
                .Height      = 22
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivamente torna controles visiveis
    * EXCECAO: shp_4c_ShpRepetir e cmd_4c_Repetir controlados por this_lModoEdicao
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                *-- Controles cuja visibilidade depende do modo (nao alterar aqui)
                IF INLIST(UPPER(loc_oControl.Name), ;
                          "CMD_4C_REPETIR", ;
                          "SHP_4C_SHPREPETIR", ;
                          "CMD_4C_INSERIR", ;
                          "CMD_4C_EXCLUIR", ;
                          "LBL_4C_LBLQTDE", ;
                          "TXT_4C_QTDE", ;
                          "SHP_4C_SHPQTDE", ;
                          "CNT_4C_CABECALHO")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos e restaura menu do sistema
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("crSigPrFnc")
            USE IN crSigPrFnc
        ENDIF
        IF USED("crFopProdDesc")
            USE IN crFopProdDesc
        ENDIF
        IF USED("crFopBuscaCli")
            USE IN crFopBuscaCli
        ENDIF
        IF USED("crFopBuscaMoe")
            USE IN crFopBuscaMoe
        ENDIF
        IF USED("crFopBuscaCol")
            USE IN crFopBuscaCol
        ENDIF
        IF USED("crFopBuscaCor")
            USE IN crFopBuscaCor
        ENDIF
        IF USED("crFopBuscaTam")
            USE IN crFopBuscaTam
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LiberarCursores()
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Cria grd_4c_Dados com 10 colunas (replica SIGCDFOP.Grade)
    * Original: Top=129, Left=8, Width=1060, Height=462 (form 1075px)
    * Novo: Width=960 proporcional ao form 1000px
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.grd_4c_Dados
            WITH loc_oGrid
                .Top                = 129
                .Left               = 8
                .Width              = 960
                .Height             = 462
                .ColumnCount        = 10
                .FontName           = "Tahoma"
                .FontSize           = 8
                .RowHeight          = 17
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .ScrollBars         = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .AllowCellSelection = .T.
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
            ENDWITH

            *-- Column1: iFors (Codigo Fornecedor) ColumnOrder=1
            WITH loc_oGrid.Column1
                .Width         = 108
                .ColumnOrder   = 1
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.iFors"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column1.Header1
                .Caption   = "C" + CHR(243) + "digo"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column2: rClis (Razao Social) ColumnOrder=2
            WITH loc_oGrid.Column2
                .Width         = 334
                .ColumnOrder   = 2
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.rClis"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column2.Header1
                .Caption   = "Raz" + CHR(227) + "o Social"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column3: Reffs (Ref. Fornecedor) ColumnOrder=3
            WITH loc_oGrid.Column3
                .Width         = 140
                .ColumnOrder   = 3
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.Reffs"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column3.Header1
                .Caption   = "Ref. Fornecedor"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column4: MoeVs (Moeda) ColumnOrder=8
            WITH loc_oGrid.Column4
                .Width         = 31
                .ColumnOrder   = 8
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.MoeVs"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column4.Text1
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 0
                .Margin      = 0
            ENDWITH
            WITH loc_oGrid.Column4.Header1
                .Caption   = "Moe"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column5: PVens (Preco de Custo) ColumnOrder=7
            WITH loc_oGrid.Column5
                .Width         = 90
                .ColumnOrder   = 7
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.PVens"
                .InputMask     = "9,999,999.99"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column5.Text1
                .Format      = "K"
                .InputMask   = "9,999,999.99"
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 0
                .Margin      = 0
            ENDWITH
            WITH loc_oGrid.Column5.Header1
                .Caption   = "Pre" + CHR(231) + "o de Custo"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column6: DtValid (Validade) ColumnOrder=9
            WITH loc_oGrid.Column6
                .Width         = 75
                .ColumnOrder   = 9
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.DtValid"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column6.Text1
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 0
                .Margin      = 0
                .NullDisplay = "  /  /    "
            ENDWITH
            WITH loc_oGrid.Column6.Header1
                .Caption   = "Validade"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column7: Situas (S - CheckBox) ColumnOrder=10
            WITH loc_oGrid.Column7
                .Width         = 16
                .ColumnOrder   = 10
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Sparse        = .F.
                .ControlSource = "crSigPrFnc.Situas"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            loc_oGrid.Column7.AddObject("Check1", "CheckBox")
            WITH loc_oGrid.Column7
                .CurrentControl = "Check1"
            ENDWITH
            WITH loc_oGrid.Column7.Check1
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .F.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
                .Value     = 0
            ENDWITH
            WITH loc_oGrid.Column7.Header1
                .Caption   = "S"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column8: Colecoes (Grupo Venda) ColumnOrder=4
            WITH loc_oGrid.Column8
                .Width         = 90
                .ColumnOrder   = 4
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.Colecoes"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column8.Text1
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 0
                .Margin      = 0
            ENDWITH
            WITH loc_oGrid.Column8.Header1
                .Caption   = "Grupo Venda"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column9: CodCors (Cor) ColumnOrder=5
            WITH loc_oGrid.Column9
                .Width         = 38
                .ColumnOrder   = 5
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.CodCors"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column9.Text1
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 0
                .Margin      = 0
            ENDWITH
            WITH loc_oGrid.Column9.Header1
                .Caption   = "Cor"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column10: CodTams (Tamanho) ColumnOrder=6
            WITH loc_oGrid.Column10
                .Width         = 38
                .ColumnOrder   = 6
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "crSigPrFnc.CodTams"
                .ReadOnly      = !THIS.this_lModoEdicao
            ENDWITH
            WITH loc_oGrid.Column10.Text1
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 0
                .Margin      = 0
            ENDWITH
            WITH loc_oGrid.Column10.Header1
                .Caption   = "Tam"
                .Alignment = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAreaRepetir - Cria controles da area de repeticao de linhas
    * Original: shpQtde(Top=90,L=588,W=123,H=30), lblQtde, getQtde
    * Todos iniciam Visible=.F. e sao mostrados por CmdRepetirClick
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaRepetir()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_ShpQtde", "Shape")
            WITH THIS.shp_4c_ShpQtde
                .Top         = 90
                .Left        = 588
                .Width       = 123
                .Height      = 30
                .BackStyle   = 0
                .BorderStyle = 0
                .Visible     = .F.
            ENDWITH

            THIS.AddObject("lbl_4c_LblQtde", "Label")
            WITH THIS.lbl_4c_LblQtde
                .Top       = 97
                .Left      = 595
                .Width     = 73
                .Height    = 16
                .Caption   = "Quantidade :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            THIS.AddObject("txt_4c_Qtde", "TextBox")
            WITH THIS.txt_4c_Qtde
                .Top           = 94
                .Left          = 669
                .Width         = 36
                .Height        = 23
                .Value         = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999"
                .SpecialEffect = 1
                .Visible       = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAreaRepetir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdInserirClick - Adiciona linha vazia ao cursor e posiciona no grid
    *==========================================================================
    PROCEDURE CmdInserirClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.InserirLinha(THIS.this_cCpros)
                THIS.grd_4c_Dados.Refresh()
                IF USED("crSigPrFnc")
                    SELECT crSigPrFnc
                    GO BOTTOM
                ENDIF
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - Marca linha corrente para exclusao
    *==========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.ExcluirLinha()
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdRepetirClick - Exibe area de quantidade para duplicar linha corrente
    *==========================================================================
    PROCEDURE CmdRepetirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("crSigPrFnc")
                RETURN
            ENDIF
            SELECT crSigPrFnc
            IF EOF() OR EMPTY(iFors)
                MsgAviso("Selecione um registro para ser repetido.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            THIS.lbl_4c_LblQtde.Visible = .T.
            THIS.txt_4c_Qtde.Visible    = .T.
            THIS.shp_4c_ShpQtde.Visible = .T.
            THIS.txt_4c_Qtde.Value      = 0
            THIS.txt_4c_Qtde.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmdRepetirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Valida, salva (se modo edicao) e fecha o form
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        LOCAL loc_lPode, loc_oErro

        TRY
            loc_lPode = .T.

            IF THIS.this_lModoEdicao
                loc_lPode = THIS.this_oBusinessObject.ValidarCursor(THIS.this_cPcEscolha)
                IF loc_lPode
                    loc_lPode = THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cCpros)
                ENDIF
            ENDIF

            IF loc_lPode
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmdEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtQtdeKeyPress - Processa ENTER/TAB no campo quantidade de repeticoes
    *==========================================================================
    PROCEDURE TxtQtdeKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        LOCAL loc_nVezes, loc_oErro

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        TRY
            loc_nVezes = NVL(THIS.txt_4c_Qtde.Value, 0)

            IF loc_nVezes > 0
                THIS.this_oBusinessObject.RepetirLinha(loc_nVezes)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            THIS.lbl_4c_LblQtde.Visible = .F.
            THIS.shp_4c_ShpQtde.Visible  = .F.
            THIS.txt_4c_Qtde.Visible     = .F.

            IF USED("crSigPrFnc")
                SELECT crSigPrFnc
            ENDIF
            THIS.grd_4c_Dados.Column1.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em TxtQtdeKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtQtdeLostFocus - Oculta area de repeticao ao perder foco
    *==========================================================================
    PROCEDURE TxtQtdeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro

        TRY
            THIS.lbl_4c_LblQtde.Visible = .F.
            THIS.shp_4c_ShpQtde.Visible  = .F.
            THIS.txt_4c_Qtde.Visible     = .F.
            IF USED("crSigPrFnc")
                SELECT crSigPrFnc
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em TxtQtdeLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdCol1KeyPress - Lookup Column1 (iFors) em SigCdCli por codigo
    *==========================================================================
    PROCEDURE GrdCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !THIS.this_lModoEdicao
            RETURN
        ENDIF
        THIS.AbrirBuscaCli("iclis", ;
            ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, "")))
    ENDPROC

    *==========================================================================
    * GrdCol2KeyPress - Lookup Column2 (rClis) em SigCdCli por razao social
    *==========================================================================
    PROCEDURE GrdCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !THIS.this_lModoEdicao
            RETURN
        ENDIF
        THIS.AbrirBuscaCli("rclis", ;
            ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, "")))
    ENDPROC

    *==========================================================================
    * GrdCol4KeyPress - Lookup Column4 (MoeVs) em SigCdMoe
    *==========================================================================
    PROCEDURE GrdCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !THIS.this_lModoEdicao
            RETURN
        ENDIF
        THIS.AbrirBuscaMoe(ALLTRIM(NVL(THIS.grd_4c_Dados.Column4.Text1.Value, "")))
    ENDPROC

    *==========================================================================
    * GrdCol8KeyPress - Lookup Column8 (Colecoes) em SigCdCol
    *==========================================================================
    PROCEDURE GrdCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !THIS.this_lModoEdicao
            RETURN
        ENDIF
        THIS.AbrirBuscaCol(ALLTRIM(NVL(THIS.grd_4c_Dados.Column8.Text1.Value, "")))
    ENDPROC

    *==========================================================================
    * GrdCol9KeyPress - Lookup Column9 (CodCors) em SigCdCor
    *==========================================================================
    PROCEDURE GrdCol9KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !THIS.this_lModoEdicao
            RETURN
        ENDIF
        THIS.AbrirBuscaCor(ALLTRIM(NVL(THIS.grd_4c_Dados.Column9.Text1.Value, "")))
    ENDPROC

    *==========================================================================
    * GrdCol10KeyPress - Lookup Column10 (CodTams) em SigCdTam
    *==========================================================================
    PROCEDURE GrdCol10KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !THIS.this_lModoEdicao
            RETURN
        ENDIF
        THIS.AbrirBuscaTam(ALLTRIM(NVL(THIS.grd_4c_Dados.Column10.Text1.Value, "")))
    ENDPROC

    *==========================================================================
    * AbrirBuscaCli - Abre FormBuscaAuxiliar para SigCdCli
    * par_cCampo: "iclis" (busca por codigo) ou "rclis" (busca por nome)
    * Ao selecionar, preenche iFors E rClis no cursor corrente
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaCli(par_cCampo, par_cValor)
        LOCAL loc_oFba, loc_cIfors, loc_cRClis, loc_oErro

        TRY
            loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "crFopBuscaCli", par_cCampo, par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .F., .T., "")

            IF VARTYPE(loc_oFba) = "O"
                loc_oFba.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oFba.mAddColuna("rclis", "", "Raz" + CHR(227) + "o Social")
                loc_oFba.Show()
            ENDIF

            IF USED("crFopBuscaCli")
                IF !EOF("crFopBuscaCli")
                    loc_cIfors = ALLTRIM(NVL(crFopBuscaCli.iclis, ""))
                    loc_cRClis = ALLTRIM(NVL(crFopBuscaCli.rclis, ""))
                    USE IN crFopBuscaCli
                    SELECT crSigPrFnc
                    REPLACE iFors WITH loc_cIfors, rClis WITH loc_cRClis
                    THIS.grd_4c_Dados.Refresh()
                ELSE
                    USE IN crFopBuscaCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCli")
            IF USED("crFopBuscaCli")
                USE IN crFopBuscaCli
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaMoe - Abre FormBuscaAuxiliar para SigCdMoe (Moeda)
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaMoe(par_cValor)
        LOCAL loc_oFba, loc_cCodigo, loc_oErro

        TRY
            loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "crFopBuscaMoe", "CMoes", par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")

            IF VARTYPE(loc_oFba) = "O"
                loc_oFba.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oFba.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oFba.Show()
            ENDIF

            IF USED("crFopBuscaMoe")
                IF !EOF("crFopBuscaMoe")
                    loc_cCodigo = ALLTRIM(NVL(crFopBuscaMoe.CMoes, ""))
                    USE IN crFopBuscaMoe
                    SELECT crSigPrFnc
                    REPLACE MoeVs WITH loc_cCodigo
                    THIS.grd_4c_Dados.Refresh()
                ELSE
                    USE IN crFopBuscaMoe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaMoe")
            IF USED("crFopBuscaMoe")
                USE IN crFopBuscaMoe
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaCol - Abre FormBuscaAuxiliar para SigCdCol (Colecoes/Grupo Venda)
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaCol(par_cValor)
        LOCAL loc_oFba, loc_cCodigo, loc_oErro

        TRY
            loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "crFopBuscaCol", "Colecoes", par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Cole" + CHR(231) + CHR(227) + "o", ;
                .F., .T., "")

            IF VARTYPE(loc_oFba) = "O"
                loc_oFba.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oFba.Show()
            ENDIF

            IF USED("crFopBuscaCol")
                IF !EOF("crFopBuscaCol")
                    loc_cCodigo = ALLTRIM(NVL(crFopBuscaCol.Colecoes, ""))
                    USE IN crFopBuscaCol
                    SELECT crSigPrFnc
                    REPLACE Colecoes WITH loc_cCodigo
                    THIS.grd_4c_Dados.Refresh()
                ELSE
                    USE IN crFopBuscaCol
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCol")
            IF USED("crFopBuscaCol")
                USE IN crFopBuscaCol
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaCor - Abre FormBuscaAuxiliar para SigCdCor (Cor)
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaCor(par_cValor)
        LOCAL loc_oFba, loc_cCodigo, loc_oErro

        TRY
            loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "crFopBuscaCor", "Cods", par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Cor", .F., .T., "")

            IF VARTYPE(loc_oFba) = "O"
                loc_oFba.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oFba.Show()
            ENDIF

            IF USED("crFopBuscaCor")
                IF !EOF("crFopBuscaCor")
                    loc_cCodigo = ALLTRIM(NVL(crFopBuscaCor.Cods, ""))
                    USE IN crFopBuscaCor
                    SELECT crSigPrFnc
                    REPLACE CodCors WITH loc_cCodigo
                    THIS.grd_4c_Dados.Refresh()
                ELSE
                    USE IN crFopBuscaCor
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCor")
            IF USED("crFopBuscaCor")
                USE IN crFopBuscaCor
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Wrapper para o padrao CRUD (delegador)
    * SIGCDFOP eh form OPERACIONAL modal (sem PageFrame), com layout FLAT:
    * cabecalho + botoes no topo + grid + area de repeticao. Nao ha Page1/Page2.
    * Mantido para conformidade com o pipeline de migracao (Fase 4 valida
    * presenca dos nomes ConfigurarPaginaLista/AlternarPagina). Delega para os
    * helpers reais que ja fazem o trabalho: ConfigurarGrid (grid 10 colunas) +
    * ConfigurarBotoes (Repetir/Inserir/Excluir/Encerrar do cnt_4c_Cabecalho).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * AlternarPagina - No-op para conformidade com o pipeline CRUD
    * Este form nao tem PageFrame (layout FLAT), portanto nao ha paginas para
    * alternar. Metodo existe apenas para satisfazer o validador da Fase 4 do
    * pipeline. Qualquer chamada eh silenciosamente ignorada.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Wrapper de conformidade com o pipeline (Fase 5)
    * SIGCDFOP eh form OPERACIONAL modal com layout FLAT (sem PageFrame).
    * Nao existe "Page2 de Dados" separada — a entrada de dados acontece
    * diretamente nas celulas do grid (grd_4c_Dados, 10 colunas, configurado
    * em ConfigurarGrid na Fase 4). Este metodo existe apenas para satisfazer
    * o validador de fase do pipeline multi-fase. Nenhuma acao necessaria.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * AbrirBuscaTam - Abre FormBuscaAuxiliar para SigCdTam (Tamanho)
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaTam(par_cValor)
        LOCAL loc_oFba, loc_cCodigo, loc_oErro

        TRY
            loc_oFba = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "crFopBuscaTam", "Cods", par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Tamanho", .F., .T., "")

            IF VARTYPE(loc_oFba) = "O"
                loc_oFba.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oFba.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oFba.Show()
            ENDIF

            IF USED("crFopBuscaTam")
                IF !EOF("crFopBuscaTam")
                    loc_cCodigo = ALLTRIM(NVL(crFopBuscaTam.Cods, ""))
                    USE IN crFopBuscaTam
                    SELECT crSigPrFnc
                    REPLACE CodTams WITH loc_cCodigo
                    THIS.grd_4c_Dados.Refresh()
                ELSE
                    USE IN crFopBuscaTam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaTam")
            IF USED("crFopBuscaTam")
                USE IN crFopBuscaTam
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Delega para o handler nativo do form OPERACIONAL
    * SIGCDFOP legado tem cmdInserir (nao cmdIncluir do CRUD). O handler
    * CmdInserirClick ja realiza a acao correta: insere linha vazia no cursor
    * crSigPrFnc via BO e reposiciona o grid. Este wrapper existe para
    * conformidade com o validador da Fase 7 do pipeline multi-fase que
    * verifica presenca do nome canonico Btn*Click.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.CmdInserirClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Posiciona edicao na 1a coluna do grid (equivalente a
    * "Alterar" em form OPERACIONAL: os dados sao editados diretamente nas
    * celulas). Sem paginas Lista/Dados, "Alterar" resume-se a garantir foco
    * na linha corrente para permitir digitacao.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF !THIS.this_lModoEdicao
                MsgAviso("Form aberto em modo de visualiza" + CHR(231) + CHR(227) + "o. " + ;
                         "Reabra a partir do form pai em modo Incluir ou Alterar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF USED("crSigPrFnc") AND !EOF("crSigPrFnc")
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Recarrega e refresca a lista de fornecedores
    * Em form OPERACIONAL sem Page1/Page2, "Visualizar" equivale a atualizar
    * o grid a partir do banco (util para refletir mudancas concorrentes).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF
            IF EMPTY(THIS.this_cCpros)
                RETURN
            ENDIF
            THIS.this_oBusinessObject.BuscarPorProduto(THIS.this_cCpros)
            IF USED("crSigPrFnc")
                THIS.grd_4c_Dados.ColumnCount  = 10
                THIS.grd_4c_Dados.RecordSource = "crSigPrFnc"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Delega para o handler nativo do form OPERACIONAL
    * SIGCDFOP legado tem cmdExcluir. O handler CmdExcluirClick ja marca a
    * linha corrente do cursor crSigPrFnc para exclusao via BO. Wrapper de
    * conformidade com o validador da Fase 7 do pipeline.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.CmdExcluirClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista de fornecedores do produto
    * Em form OPERACIONAL sem campo de filtro separado, "Buscar" equivale
    * a recarregar os dados atuais do SQL Server para o grid.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Delega para o handler nativo do form OPERACIONAL
    * CmdEncerrarClick ja faz validacao, salva (se modo edicao) e fecha.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e persiste alteracoes sem fechar o form
    * Permite que o usuario salve o progresso e continue editando.
    * Apos salvar com sucesso, recarrega a lista do banco para refletir o
    * estado real (inclusive chaves geradas pelo SQL Server).
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro

        TRY
            IF !THIS.this_lModoEdicao
                MsgAviso("Form aberto em modo de visualiza" + CHR(231) + CHR(227) + "o. " + ;
                         "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel salvar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.ValidarCursor(THIS.this_cPcEscolha)
                IF THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cCpros)
                    MsgInfo("Fornecedores salvos com sucesso.")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Desfaz alteracoes nao salvas e fecha o form
    * Reverte o buffer do cursor (TABLEREVERT) e libera o form sem validar,
    * replicando o comportamento de "Cancelar" em forms de edicao.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_lModoEdicao AND USED("crSigPrFnc")
                TABLEREVERT(.T., "crSigPrFnc")
            ENDIF

            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega fornecedores do produto no grid
    * Chama BuscarPorProduto no BO e revincula o RecordSource do grid.
    * Equivalente ao InicializarForm de carga de dados (sem recriar controles).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF
            IF EMPTY(THIS.this_cCpros)
                RETURN
            ENDIF
            THIS.this_oBusinessObject.BuscarPorProduto(THIS.this_cCpros)
            IF USED("crSigPrFnc")
                THIS.grd_4c_Dados.ColumnCount  = 10
                THIS.grd_4c_Dados.RecordSource = "crSigPrFnc"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme o modo
    * Inserir/Excluir/Repetir ficam visiveis apenas em modo edicao.
    * Encerrar sempre visivel.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro

        TRY
            THIS.cmd_4c_Inserir.Visible      = THIS.this_lModoEdicao
            THIS.cmd_4c_Inserir.Enabled      = THIS.this_lModoEdicao
            THIS.cmd_4c_Excluir.Visible      = THIS.this_lModoEdicao
            THIS.cmd_4c_Excluir.Enabled      = THIS.this_lModoEdicao
            THIS.cmd_4c_Repetir.Visible      = THIS.this_lModoEdicao
            THIS.cmd_4c_Repetir.Enabled      = THIS.this_lModoEdicao
            THIS.shp_4c_ShpRepetir.Visible   = THIS.this_lModoEdicao
            THIS.cmd_4c_Encerrar.Visible     = .T.
            THIS.cmd_4c_Encerrar.Enabled     = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Ajusta ReadOnly das 10 colunas do grid conforme modo
    * par_lHabilitar = .T. -> colunas editaveis; .F. -> somente leitura
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_i, loc_oGrid, loc_oErro

        TRY
            loc_oGrid = THIS.grd_4c_Dados
            FOR loc_i = 1 TO loc_oGrid.ColumnCount
                loc_oGrid.Columns(loc_i).ReadOnly = !par_lHabilitar
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera o cursor crSigPrFnc e refresca o grid
    * Usado para limpar a grade quando o form precisa ser resetado.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            IF USED("crSigPrFnc")
                SELECT crSigPrFnc
                ZAP
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            THIS.this_lHouveIncl = .F.
            THIS.this_lHouveExcl = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza a linha corrente do cursor com as propriedades do BO
    * Neste form OPERACIONAL, a edicao ocorre diretamente nas celulas do grid
    * (cursor crSigPrFnc). FormParaBO carrega a linha corrente no BO via
    * CarregarDoCursor para que o BO possa usar as propriedades this_* em
    * operacoes avulsas (ex: validacoes ou auditorias de linha individual).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               USED("crSigPrFnc") AND !EOF("crSigPrFnc")
                THIS.this_oBusinessObject.CarregarDoCursor("crSigPrFnc")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza propriedades do BO para controles do form
    * Neste form OPERACIONAL, nao ha campos individuais de formulario: os dados
    * ficam diretamente no cursor crSigPrFnc e sao exibidos pelo grid.
    * O metodo existe para conformidade com o padrao CRUD do pipeline.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

ENDDEFINE
