*-------------------------------------------------------------------------------
* FormSigPdMp4.prg - Formulario Operacional: Desagregar Componentes Agregados
* Herda de FormBase
* OPERACIONAL: Dialog de desagregacao de componentes de producao
* Aberto pelo form pai passando referencia via parametro pForm
*-------------------------------------------------------------------------------

DEFINE CLASS FormSigPdMp4 AS FormBase

    *-- Propriedades visuais (do SCX original)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    Movable      = .F.
    ClipControls = .F.
    BorderStyle  = 2
    Caption      = "Desagregar Componentes Agregados"
    Name         = "FormSigPdMp4"

    *-- Propriedades customizadas (RESERVED3 do SCX original)
    this_oParentForm     = .NULL.
    this_cEscolha        = ""
    this_nRecnoAnt       = 0

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Objeto balanca para pesagem via porta serial (hardware)
    this_oBalanca        = .NULL.

    *--------------------------------------------------------------------------
    * Init - Captura form pai antes de DODEFAULT (FormBase.Init -> InicializarForm)
    * par_oParentForm: referencia ao form que abriu este dialog
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm)
        IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
            THIS.this_oParentForm = par_oParentForm
            THIS.this_cEscolha    = par_oParentForm.pcEscolha
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Troca datasession, cria BO, popula TmpDistrib, layout
    * Chamado automaticamente por FormBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Compartilha datasession do form pai para acessar xNensi etc.
            IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
                SET DATASESSION TO THIS.this_oParentForm.DataSessionId
            ENDIF

            *-- Instancia BO
            THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp4BO")

            *-- Inicializa objeto da balanca (leitura de peso por porta serial)
            THIS.ConfigurarBalanca()

            *-- Imagem de fundo do form (new_background.jpg do framework)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Registra posicao atual no cursor de producao antes de desagregar
            IF USED("xNensi")
                THIS.this_nRecnoAnt = RECNO("xNensi")
            ENDIF

            *-- Cria TmpDistrib a partir do cursor xNensi (logica do Init original)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.InicializarTmpDistrib("xNensi")
            ENDIF

            *-- Bloqueia tela durante construcao do layout
            THIS.LockScreen = .T.

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarContainerOperacao()
            THIS.ConfigurarPaginaDados()
            THIS.ConfigurarContainerIndicador()
            THIS.ConfigurarPaginaLista()

            THIS.LockScreen = .F.

            *-- Atualiza caption (igual ao Init original)
            THIS.Caption = "Desagregar Componentes "
            IF PEMSTATUS(THIS.cnt_4c_Sombra.lbl_4c_Sombra, "Caption", 5)
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Sombra.lbl_4c_Titulo, "Caption", 5)
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
            ENDIF

            *-- Desabilita form pai enquanto este dialog esta aberto
            IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar form")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Form OPERACIONAL nao usa PageFrame.
    * Mantem a assinatura padrao do pipeline (validacao da Fase 3 exige este metodo)
    * e ajusta propriedades essenciais do form (dimensoes, fundo, caption).
    * Layout real fica em ConfigurarCabecalho/ConfigurarContainer*.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AutoCenter = .T.
        THIS.Width      = 1000
        THIS.Height     = 600
        IF TYPE("gc_4c_CaminhoIcones") = "C"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
        THIS.Caption = "Desagregar Componentes Agregados"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cntSombra com labels de sombra e titulo
    * Original: cntSombra (Top=0, Left=0, Width=1100, Height=80, BackColor=100,100,100)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top        = 0
            .Left       = 0
            .Width      = 1100
            .Height     = 80
            .BorderWidth = 0
            .BackStyle  = 1
            .BackColor  = RGB(100, 100, 100)
            .Visible    = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = "Desagregar Componentes "
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width
                .ForeColor  = RGB(0, 0, 0)
                .Visible    = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = "Desagregar Componentes "
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerOperacao - Container de exibicao da operacao (somente leitura)
    * Original: Operacao (Top=104, Left=12, Width=378, Height=40, BackStyle=0)
    * TextBoxes e label adicionados na Fase 5
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        THIS.AddObject("cnt_4c_Operacao", "Container")
        WITH THIS.cnt_4c_Operacao
            .Top        = 104
            .Left       = 12
            .Width      = 378
            .Height     = 40
            .BackStyle  = 0
            .BorderWidth = 0
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerIndicador - Container com label "Desagrega Parcialmente"
    * Original: Container1 (Top=126, Left=667, Width=324, Height=22,
    *           BackColor=245,251,136, SpecialEffect=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerIndicador()
        THIS.AddObject("cnt_4c_Indicador", "Container")
        WITH THIS.cnt_4c_Indicador
            .Top           = 126
            .Left          = 667
            .Width         = 324
            .Height        = 22
            .SpecialEffect = 2
            .BackStyle     = 1
            .BackColor     = RGB(245, 251, 136)
            .BorderColor   = RGB(219, 219, 219)
            .Visible       = .T.

            .AddObject("lbl_4c_DesagregaParcial", "Label")
            WITH .lbl_4c_DesagregaParcial
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Desagrega Parcialmente"
                .Height    = 15
                .Left      = 92
                .Top       = 4
                .Width     = 118
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha TmpDistrib, reabilita form pai, limpa referencias
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpDistrib")
            USE IN TmpDistrib
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.this_oBalanca   = .NULL.
        THIS.this_oParentForm = .NULL.

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Orquestra grid, rodape e botao OK do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrade()
        THIS.ConfigurarRodape()
        THIS.ConfigurarBotaoOk()

        *-- BINDEVENTs (apenas metodos PUBLIC)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
            BINDEVENT(THIS.grd_4c_Dados.Column7.Text1,  "KeyPress", THIS, "Col7ValidarQtd")
            BINDEVENT(THIS.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "Col10ValidarPeso")
            BINDEVENT(THIS.grd_4c_Dados.Column11.Text1, "KeyPress", THIS, "Col11ValidarPesoFabr")
            BINDEVENT(THIS.grd_4c_Dados.Column11.Text1, "GotFocus", THIS, "Col11GotFocus")
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Ok) = "O"
            BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
        ENDIF

        THIS.CarregarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form OPERACIONAL sem PageFrame (sem alternancia)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Cria grd_4c_Dados com 11 colunas conforme original
    * Grade: Top=147, Left=9, Width=982, Height=417, ColumnCount=11
    * Ordem visual (ColumnOrder):
    *   1=Col8(Marca/chk), 2=Col1(Nops), 3=Col2(CMats), 4=Col5(Qtds),
    *   5=Col4(CUnis), 6=Col9(Pesos), 7=Col6(cUnips), 8=Col3(Pesofs),
    *   9=Col7(Qtd2s-edit), 10=Col10(Peso2s-edit), 11=Col11(Pesof2s-edit)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrade

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrade = THIS.grd_4c_Dados

        WITH loc_oGrade
            .Top              = 147
            .Left             = 9
            .Width            = 982
            .Height           = 417
            .ColumnCount      = 11
            .RecordMark       = .F.
            .DeleteMark       = .F.
            .GridLineColor    = RGB(238, 238, 238)
            .FontName         = "Verdana"
            .FontSize         = 8
            .HighlightStyle   = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .RowHeight        = 16
            .ScrollBars       = 2
            .Visible          = .T.
        ENDWITH

        *-- Column1: Industrializacao (ColumnOrder=2, ReadOnly, Courier New, formato numerico)
        WITH loc_oGrade.Column1
            .ColumnOrder = 2
            .Width       = 110
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .Format      = "L"
            .InputMask   = "9999999999"
            .Header1.Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.FontName    = "Courier New"
            .Text1.BorderStyle = 0
            .Text1.Format      = "L"
            .Text1.InputMask   = "9999999999"
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2: Componente (ColumnOrder=3, ReadOnly)
        WITH loc_oGrade.Column2
            .ColumnOrder = 3
            .Width       = 140
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .FontSize    = 8
            .Header1.Caption   = "Componente"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.FontSize    = 8
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3: Peso Fabr original (ColumnOrder=8, ReadOnly)
        WITH loc_oGrade.Column3
            .ColumnOrder = 8
            .Width       = 100
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Header1.Caption   = "Peso Fabr"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column4: Unid. principal (ColumnOrder=5, ReadOnly)
        WITH loc_oGrade.Column4
            .ColumnOrder = 5
            .Width       = 40
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Header1.Caption   = "Unid."
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5: Qtde original (ColumnOrder=4, ReadOnly)
        WITH loc_oGrade.Column5
            .ColumnOrder = 4
            .Width       = 100
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Header1.Caption   = "Qtde"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6: Unid. secundaria (ColumnOrder=7, ReadOnly)
        WITH loc_oGrade.Column6
            .ColumnOrder = 7
            .Width       = 40
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Header1.Caption   = "Unid."
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7: Qtde desagregada (ColumnOrder=9, EDITAVEL, fundo amarelo)
        WITH loc_oGrade.Column7
            .ColumnOrder = 9
            .Width       = 100
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
            .BackColor   = RGB(245, 251, 136)
            .Header1.Caption   = "Qtde"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.BackColor = RGB(245, 251, 136)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .F.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(245, 251, 136)
        ENDWITH

        *-- Column8: CheckBox Marca (ColumnOrder=1, EDITAVEL)
        *-- ORDEM OBRIGATORIA: Sparse -> Header -> AddObject(Check1) -> Check1.Config -> CurrentControl
        WITH loc_oGrade.Column8
            .ColumnOrder = 1
            .Width       = 20
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
            .Sparse      = .F.
            .Header1.Caption   = ""
            .Header1.FontName  = "Verdana"
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.BackColor = RGB(36, 84, 155)
        ENDWITH
        loc_oGrade.Column8.AddObject("Check1", "CheckBox")
        loc_oGrade.Column8.Check1.Caption = ""
        loc_oGrade.Column8.Check1.Value   = 0
        loc_oGrade.Column8.CurrentControl = "Check1"

        *-- Column9: Peso original (ColumnOrder=6, ReadOnly)
        WITH loc_oGrade.Column9
            .ColumnOrder = 6
            .Width       = 100
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Header1.Caption   = "Peso"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column10: Peso desagregado (EDITAVEL, fundo amarelo)
        WITH loc_oGrade.Column10
            .Width       = 100
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
            .BackColor   = RGB(245, 251, 136)
            .Header1.Caption   = "Peso"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.BackColor = RGB(245, 251, 136)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .F.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(245, 251, 136)
        ENDWITH

        *-- Column11: Peso Fabr desagregado (EDITAVEL, fundo amarelo)
        WITH loc_oGrade.Column11
            .Width       = 100
            .Resizable   = .F.
            .ReadOnly    = .F.
            .BackColor   = RGB(245, 251, 136)
            .Header1.Caption   = "Peso Fabr"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Header1.BackColor = RGB(245, 251, 136)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .F.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(245, 251, 136)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Vincula grd_4c_Dados ao cursor TmpDistrib
    * ColumnCount ANTES de RecordSource; headers REDEFINIDOS apos ControlSource
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_oGrade, loc_cTitulo

        IF !USED("TmpDistrib") OR VARTYPE(THIS.grd_4c_Dados) != "O"
            RETURN
        ENDIF

        loc_oGrade = THIS.grd_4c_Dados

        SELECT TmpDistrib
        GO TOP

        loc_oGrade.ColumnCount  = 11
        loc_oGrade.RecordSource = "TmpDistrib"

        WITH loc_oGrade
            *-- ControlSources (Column8/CheckBox: APOS CurrentControl ja setado em ConfigurarGrade)
            .Column8.ControlSource  = "TmpDistrib.Marca"
            .Column1.ControlSource  = "TmpDistrib.Nops"
            .Column2.ControlSource  = "TmpDistrib.CMats"
            .Column5.ControlSource  = "TmpDistrib.Qtds"
            .Column4.ControlSource  = "TmpDistrib.CUnis"
            .Column9.ControlSource  = "TmpDistrib.Pesos"
            .Column6.ControlSource  = "TmpDistrib.cUnips"
            .Column3.ControlSource  = "TmpDistrib.Pesofs"
            .Column7.ControlSource  = "TmpDistrib.Qtd2s"
            .Column10.ControlSource = "TmpDistrib.Peso2s"
            .Column11.ControlSource = "TmpDistrib.Pesof2s"

            *-- Caption dinamico da Column1 (vem do form pai quando disponivel)
            loc_cTitulo = "Industrializa" + CHR(231) + CHR(227) + "o"
            IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
                IF PEMSTATUS(THIS.this_oParentForm, "Titulo", 5)
                    loc_cTitulo = ALLTRIM(THIS.this_oParentForm.Titulo)
                ENDIF
            ENDIF
            .Column1.Header1.Caption = loc_cTitulo

            *-- Redefine cabecalhos obrigatorios apos RecordSource/ControlSource
            .Column2.Header1.Caption  = "Componente"
            .Column3.Header1.Caption  = "Peso Fabr"
            .Column4.Header1.Caption  = "Unid."
            .Column5.Header1.Caption  = "Qtde"
            .Column6.Header1.Caption  = "Unid."
            .Column7.Header1.Caption  = "Qtde"
            .Column8.Header1.Caption  = ""
            .Column9.Header1.Caption  = "Peso"
            .Column10.Header1.Caption = "Peso"
            .Column11.Header1.Caption = "Peso Fabr"

            .Refresh()
        ENDWITH

        *-- Preenche campos do rodape com dados do primeiro registro
        IF RECCOUNT("TmpDistrib") > 0
            SELECT TmpDistrib
            IF VARTYPE(THIS.txt_4c_Descr) = "O"
                THIS.txt_4c_Descr.ControlSource = "TmpDistrib.CDescs"
                THIS.txt_4c_Descr.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Cor) = "O"
                THIS.txt_4c_Cor.Value = ALLTRIM(NVL(TmpDistrib.CodCors, ""))
                THIS.txt_4c_Cor.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Tam) = "O"
                THIS.txt_4c_Tam.Value = ALLTRIM(NVL(TmpDistrib.CodTams, ""))
                THIS.txt_4c_Tam.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarRodape - Labels e TextBoxes do rodape: Descricao, Cor, Tamanho
    * Corresponde ao Say2/Get_descr/Label3/get_Cor/Label1/get_Tam do original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarRodape()
        *-- Say2: "Descricao :" Top=573, Left=27
        THIS.AddObject("lbl_4c_Descricao", "Label")
        WITH THIS.lbl_4c_Descricao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 27
            .Top       = 573
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_descr: exibicao descricao do componente, Top=569, Left=84, Width=335
        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Left      = 84
            .Top       = 569
            .Width     = 335
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Label3: "Cor :" Top=573, Left=435
        THIS.AddObject("lbl_4c_RotCor", "Label")
        WITH THIS.lbl_4c_RotCor
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Cor :"
            .Left      = 435
            .Top       = 573
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- get_Cor: exibicao codigo de cor, Top=569, Left=463, Width=31
        THIS.AddObject("txt_4c_Cor", "TextBox")
        WITH THIS.txt_4c_Cor
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Left      = 463
            .Top       = 569
            .Width     = 31
            .Height    = 23
            .Margin    = 0
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Label1: "Tamanho :" Top=573, Left=523
        THIS.AddObject("lbl_4c_RotTam", "Label")
        WITH THIS.lbl_4c_RotTam
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Tamanho :"
            .Left      = 523
            .Top       = 573
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- get_Tam: exibicao codigo de tamanho, Top=569, Left=578, Width=31
        THIS.AddObject("txt_4c_Tam", "TextBox")
        WITH THIS.txt_4c_Tam
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Left      = 578
            .Top       = 569
            .Width     = 31
            .Height    = 23
            .Margin    = 0
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoOk - Botao OK (equivalente ao cmd ok do original)
    * Original: Top=3, Left=925, Cancel=.T., Caption="\<OK"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoOk()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "\<OK"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Atualiza rodape e controla editabilidade das colunas
    * par_nColIndex: indice da coluna que recebeu foco (parametro obrigatorio)
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_lMarca, loc_nGrOdns, loc_nPesoBals
        LOCAL loc_cUniPs, loc_cUnipPads, loc_nFators, loc_cCEstos, loc_lCol11Edit

        IF !USED("TmpDistrib") OR RECCOUNT("TmpDistrib") = 0
            RETURN
        ENDIF

        SELECT TmpDistrib

        *-- Atualiza campos de exibicao do rodape
        IF VARTYPE(THIS.txt_4c_Cor) = "O"
            THIS.txt_4c_Cor.Value = ALLTRIM(NVL(TmpDistrib.CodCors, ""))
            THIS.txt_4c_Cor.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Tam) = "O"
            THIS.txt_4c_Tam.Value = ALLTRIM(NVL(TmpDistrib.CodTams, ""))
            THIS.txt_4c_Tam.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF

        *-- Le flags operacionais do form pai (cursores da datasession compartilhada)
        loc_lMarca    = NVL(TmpDistrib.Marca, .F.)
        loc_cUniPs    = ALLTRIM(NVL(TmpDistrib.cUniPs, ""))
        loc_nGrOdns   = 0
        loc_nPesoBals = 0
        loc_cUnipPads = ""

        IF USED("CrSigCdOpd")
            loc_nGrOdns   = NVL(CrSigCdOpd.GrOdns,  0)
            loc_nPesoBals = NVL(CrSigCdOpd.PesoBals, 0)
        ENDIF
        IF USED("CrSigCdPam")
            loc_cUnipPads = ALLTRIM(NVL(CrSigCdPam.cUnipPads, ""))
        ENDIF

        *-- Busca Fators e CEstos da unidade principal (para Col7 e Col10/11)
        loc_nFators = 0
        loc_cCEstos = ""
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(ALLTRIM(NVL(TmpDistrib.CUnis, "")))
            THIS.this_oBusinessObject.BuscarUnidade(ALLTRIM(NVL(TmpDistrib.CUnis, "")), ;
                                                     "Fators, CEstos", "cursor_4c_LocalUniARC")
            IF USED("cursor_4c_LocalUniARC") AND RECCOUNT("cursor_4c_LocalUniARC") > 0
                SELECT cursor_4c_LocalUniARC
                loc_nFators = NVL(Fators, 0)
                loc_cCEstos = ALLTRIM(NVL(CEstos, ""))
            ENDIF
        ENDIF

        *-- Editabilidade Column7 (Qtd2s): Fators!=0 E PesoBals!=1 E GrOdns!=1 E Marca
        THIS.grd_4c_Dados.Column7.ReadOnly = !(loc_nFators <> 0 AND ;
                                                loc_nPesoBals <> 1 AND ;
                                                loc_nGrOdns <> 1 AND ;
                                                loc_lMarca)

        *-- Editabilidade Column10 (Peso2s): cEstos='3' E cUniPs nao vazio E Marca
        THIS.grd_4c_Dados.Column10.ReadOnly = !(loc_cCEstos = "3" AND ;
                                                 !EMPTY(loc_cUniPs) AND ;
                                                 loc_lMarca)

        *-- Editabilidade Column11 (Pesof2s): nao (GrOdns=1 OU nao Marca) E
        *--   nao (cUnipPads definido E cUniPs=cUnipPads) E PesoBals!=1 (sem balanca)
        loc_lCol11Edit = .T.
        IF loc_nGrOdns = 1 OR !loc_lMarca
            loc_lCol11Edit = .F.
        ENDIF
        IF loc_lCol11Edit AND !EMPTY(loc_cUnipPads) AND loc_cUniPs = loc_cUnipPads
            loc_lCol11Edit = .F.
        ENDIF
        IF loc_lCol11Edit
            loc_lCol11Edit = (loc_nPesoBals <> 1)
        ENDIF
        THIS.grd_4c_Dados.Column11.ReadOnly = !loc_lCol11Edit

        SELECT TmpDistrib
    ENDPROC

    *--------------------------------------------------------------------------
    * Col7ValidarQtd - Valida Qtd2s ao pressionar ENTER ou TAB na Column7
    * par_nKeyCode, par_nShiftAltCtrl: parametros obrigatorios do KeyPress
    *--------------------------------------------------------------------------
    PROCEDURE Col7ValidarQtd(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nNovaQtd, loc_nLibrPqs

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF
        IF !USED("TmpDistrib") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        SELECT TmpDistrib
        loc_nNovaQtd = NVL(THIS.grd_4c_Dados.Column7.Text1.Value, 0)
        loc_nLibrPqs = 0
        IF USED("CrSigCdOpd")
            loc_nLibrPqs = NVL(CrSigCdOpd.LibrPqs, 0)
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarQtdeDesagregada(loc_nNovaQtd, loc_nLibrPqs)
            THIS.grd_4c_Dados.Column7.Text1.Value = NVL(TmpDistrib.Qtds, 0)
            NODEFAULT
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * Col10ValidarPeso - Valida Peso2s ao pressionar ENTER ou TAB na Column10
    * par_nKeyCode, par_nShiftAltCtrl: parametros obrigatorios do KeyPress
    *--------------------------------------------------------------------------
    PROCEDURE Col10ValidarPeso(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nNovoPeso, loc_nLibrPqs

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF
        IF !USED("TmpDistrib") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        SELECT TmpDistrib
        loc_nNovoPeso = NVL(THIS.grd_4c_Dados.Column10.Text1.Value, 0)
        loc_nLibrPqs  = 0
        IF USED("CrSigCdOpd")
            loc_nLibrPqs = NVL(CrSigCdOpd.LibrPqs, 0)
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarPesoDesagregado(loc_nNovoPeso, loc_nLibrPqs)
            THIS.grd_4c_Dados.Column10.Text1.Value = NVL(TmpDistrib.Pesos, 0)
            NODEFAULT
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * Col11ValidarPesoFabr - Valida Pesof2s ao pressionar ENTER ou TAB na Column11
    * par_nKeyCode, par_nShiftAltCtrl: parametros obrigatorios do KeyPress
    *--------------------------------------------------------------------------
    PROCEDURE Col11ValidarPesoFabr(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nNovoPesoF, loc_nLibrPqs, loc_nPesoBals

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF
        IF !USED("TmpDistrib") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        SELECT TmpDistrib
        loc_nNovoPesoF = NVL(THIS.grd_4c_Dados.Column11.Text1.Value, 0)
        loc_nLibrPqs   = 0
        loc_nPesoBals  = 0
        IF USED("CrSigCdOpd")
            loc_nLibrPqs  = NVL(CrSigCdOpd.LibrPqs,  0)
            loc_nPesoBals = NVL(CrSigCdOpd.PesoBals,  0)
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarPesoFabrDesagregado(loc_nNovoPesoF, loc_nLibrPqs, loc_nPesoBals)
            THIS.grd_4c_Dados.Column11.Text1.Value = NVL(TmpDistrib.Pesofs, 0)
            NODEFAULT
        ELSE
            IF loc_nPesoBals = 1
                KEYBOARD "{DNARROW}"
            ENDIF
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos campos principais (Fase 5)
    * Para este form OPERACIONAL: popula cnt_4c_Operacao e adiciona Shape1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCamposOperacao()
        THIS.ConfigurarShapeDecorativo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposOperacao - Adiciona label + 3 TextBoxes ReadOnly ao cnt_4c_Operacao
    * Exibe numero, empresa e descricao da operacao do form pai (somente leitura)
    * Original: Say1 (label) + GetEmpresa + GetOperacao + GetCodigo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposOperacao()
        LOCAL loc_oContainer
        IF VARTYPE(THIS.cnt_4c_Operacao) != "O"
            RETURN
        ENDIF
        loc_oContainer = THIS.cnt_4c_Operacao

        *-- Say1: "Movimentacao :" Left=17, Top=12
        loc_oContainer.AddObject("lbl_4c_Movimentacao", "Label")
        WITH loc_oContainer.lbl_4c_Movimentacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Left      = 17
            .Top       = 12
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetEmpresa: empresa da operacao, Left=97, Top=8, Width=36 (ReadOnly)
        loc_oContainer.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oContainer.txt_4c_Empresa
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Left              = 97
            .Top               = 8
            .Width             = 36
            .Height            = 23
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .ReadOnly          = .T.
            .Value             = ""
            IF USED("tmpnens")
                .ControlSource = "tmpnens.emps"
            ENDIF
            .Visible           = .T.
            .MaxLength   = 3
        ENDWITH

        *-- GetOperacao: descricao da operacao, Left=135, Top=8, Width=156 (ReadOnly)
        loc_oContainer.AddObject("txt_4c_Operacao", "TextBox")
        WITH loc_oContainer.txt_4c_Operacao
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Left              = 135
            .Top               = 8
            .Width             = 156
            .Height            = 23
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .ReadOnly          = .T.
            .Value             = ""
            IF USED("tmpnens")
                .ControlSource = "tmpnens.dopps"
            ENDIF
            .Visible           = .T.
        ENDWITH

        *-- GetCodigo: numero da operacao (formato numerico), Left=293, Top=8, Width=81 (ReadOnly)
        loc_oContainer.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oContainer.txt_4c_Codigo
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "L"
            .InputMask         = "9999999999"
            .Left              = 293
            .Top               = 8
            .Width             = 81
            .Height            = 23
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .ReadOnly          = .T.
            .Value             = 0
            IF USED("tmpnens")
                .ControlSource = "tmpnens.numps"
            ENDIF
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShapeDecorativo - Shape decorativo no canto superior direito
    * Original: Shape1 (Top=10, Left=897, Width=90, Height=110, BackStyle=0, BorderStyle=0)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShapeDecorativo()
        THIS.AddObject("shp_4c_Decorativo", "Shape")
        WITH THIS.shp_4c_Decorativo
            .Top         = 10
            .Left        = 897
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOkClick - Aplica desagregacao no cursor xNensi e fecha o dialog
    * Logica equivalente ao ok.Click do original (SIGPDMP4)
    *--------------------------------------------------------------------------
    PROCEDURE BtnOkClick()
        LOCAL loc_lSucesso

        loc_lSucesso = .T.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("xNensi")
            THIS.this_oBusinessObject.this_cAliasFonte = "xNensi"
            loc_lSucesso = THIS.this_oBusinessObject.SalvarDesagregacao("xNensi")
        ENDIF

        *-- Restaura ordem no cursor de producao
        IF USED("xNensi")
            SELECT xNensi
            SET ORDER TO Editar
        ENDIF

        *-- Reabilita form pai (Destroy tambem reabilita, mas feito aqui para garantir)
        IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBalanca - Cria e configura o objeto de balanca serial
    * Parametros lidos do cursor crSigCdPam (configuracao global do sistema)
    * Falha graciosamente se a classe fwbalanca nao estiver disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBalanca()
        LOCAL loc_oErro

        THIS.this_oBalanca = .NULL.

        IF !USED("CrSigCdPam")
            RETURN
        ENDIF

        TRY
            THIS.this_oBalanca = CREATEOBJECT("fwbalanca")

            IF VARTYPE(THIS.this_oBalanca) = "O" AND !ISNULL(THIS.this_oBalanca)
                WITH THIS.this_oBalanca
                    .Porta        = NVL(CrSigCdPam.BalPortas, 0)
                    .Velocidade   = NVL(CrSigCdPam.BalVelocs, 0)
                    .TipoParidade = NVL(CrSigCdPam.BalTppars, 0)
                    .Bits         = NVL(CrSigCdPam.BalBits,   0)
                    .Paridade     = NVL(CrSigCdPam.BalParids,  0)
                    IF NVL(CrSigCdPam.BalPortas, 0) = 0
                        .Leitura = "T"
                    ENDIF
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            THIS.this_oBalanca = .NULL.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Marca todos os registros do TmpDistrib para desagregacao
    * Form OPERACIONAL: equivale a "incluir todos no processo de desagregacao"
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF !USED("TmpDistrib") OR RECCOUNT("TmpDistrib") = 0
            RETURN
        ENDIF

        SELECT TmpDistrib
        SCAN
            REPLACE Marca WITH .T.
        ENDSCAN
        GO TOP

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        *-- Atualiza editabilidade de colunas conforme registro corrente
        THIS.GradeAfterRowColChange(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Inverte o flag Marca do registro corrente
    * Form OPERACIONAL: alterar estado do registro selecionado no grid
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED("TmpDistrib") OR RECCOUNT("TmpDistrib") = 0
            RETURN
        ENDIF

        SELECT TmpDistrib
        REPLACE Marca WITH !NVL(TmpDistrib.Marca, .F.)

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        THIS.GradeAfterRowColChange(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Refresh do grid e do rodape (visualizar registro corrente)
    * Form OPERACIONAL: atualiza exibicao dos dados sem alterar estado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !USED("TmpDistrib") OR RECCOUNT("TmpDistrib") = 0
            RETURN
        ENDIF

        SELECT TmpDistrib

        IF VARTYPE(THIS.txt_4c_Cor) = "O"
            THIS.txt_4c_Cor.Value = ALLTRIM(NVL(TmpDistrib.CodCors, ""))
            THIS.txt_4c_Cor.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Tam) = "O"
            THIS.txt_4c_Tam.Value = ALLTRIM(NVL(TmpDistrib.CodTams, ""))
            THIS.txt_4c_Tam.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Desmarca todos os registros (excluir do processo)
    * Form OPERACIONAL: cancela a desagregacao zerando Marca e quantidades
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("TmpDistrib") OR RECCOUNT("TmpDistrib") = 0
            RETURN
        ENDIF

        SELECT TmpDistrib
        SCAN
            REPLACE Marca   WITH .F., ;
                    Qtd2s   WITH 0, ;
                    Peso2s  WITH 0, ;
                    Pesof2s WITH 0
        ENDSCAN
        GO TOP

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        THIS.GradeAfterRowColChange(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
    * par_oContainer: container raiz a percorrer
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual padrao ao grid
    * par_oGrid: referencia ao objeto Grid a formatar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Col11GotFocus - Ativa balanca ao entrar na Column11 (Pesof2s) quando
    * PesoBals=1 (controle de peso por balanca serial).
    * Equivalente ao Column11.Text1.When do legado que chamava Balanca.Ativa()
    * e calculava Qtd2s/Peso2s derivados do peso lido pelo hardware.
    *--------------------------------------------------------------------------
    PROCEDURE Col11GotFocus()
        LOCAL loc_nPesoBals, loc_nFators, loc_cQtEqualPs, loc_cCEstos
        LOCAL loc_nFators2, loc_cQtEqualPs2
        LOCAL loc_nValorPeso, loc_nDivisor

        IF THIS.grd_4c_Dados.Column11.ReadOnly
            RETURN
        ENDIF
        IF VARTYPE(THIS.this_oBalanca) != "O" OR ISNULL(THIS.this_oBalanca)
            RETURN
        ENDIF
        IF !USED("CrSigCdOpd") OR !USED("TmpDistrib")
            RETURN
        ENDIF

        loc_nPesoBals = NVL(CrSigCdOpd.PesoBals, 0)
        IF loc_nPesoBals <> 1
            RETURN
        ENDIF

        SELECT TmpDistrib

        THIS.this_oBalanca.Ativa(THIS.grd_4c_Dados.Column11.Text1)

        loc_nValorPeso = NVL(THIS.grd_4c_Dados.Column11.Text1.Value, 0)
        IF loc_nValorPeso <> 0 AND LASTKEY() <> 27 AND !THIS.this_oBalanca.TempoEsgotado
            THIS.Col11ValidarPesoFabr(13, 0)
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.BuscarUnidade(;
                ALLTRIM(NVL(TmpDistrib.CUnis,  "")), "Fators, QtEqualPs, CEstos", "LocalUni")
            THIS.this_oBusinessObject.BuscarUnidade(;
                ALLTRIM(NVL(TmpDistrib.cUniPs, "")), "Fators, QtEqualPs, CEstos", "LocalUni2")

            IF USED("LocalUni") AND RECCOUNT("LocalUni") > 0
                SELECT LocalUni
                loc_nFators    = NVL(Fators, 0)
                loc_cQtEqualPs = TratarNulo(QtEqualPs, "C")
                loc_cCEstos    = TratarNulo(CEstos, "C")

                SELECT TmpDistrib
                loc_nDivisor = loc_nValorPeso

                IF (loc_nFators <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs)) = "S"
                    IF loc_nFators <> 0
                        REPLACE Qtd2s WITH loc_nDivisor / IIF(EMPTY(loc_nFators), 1, loc_nFators)
                    ENDIF
                ELSE
                    IF USED("LocalUni2") AND RECCOUNT("LocalUni2") > 0
                        SELECT LocalUni2
                        loc_nFators2    = NVL(Fators, 0)
                        loc_cQtEqualPs2 = TratarNulo(QtEqualPs, "C")

                        SELECT TmpDistrib
                        IF ALLTRIM(loc_cCEstos) = "3" AND ;
                           !EMPTY(ALLTRIM(TmpDistrib.cUniPs)) AND ;
                           ((loc_nFators2 <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs2)) = "S")
                            IF loc_nFators2 <> 0
                                REPLACE Peso2s WITH loc_nDivisor / IIF(EMPTY(loc_nFators2), 1, loc_nFators2)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            SELECT TmpDistrib
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        KEYBOARD "{DNARROW}"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza o grid a partir do cursor TmpDistrib
    * Em forms OPERACIONAIS equivale a recarregar a grade de dados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.CarregarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega TmpDistrib a partir do cursor xNensi
    * Util quando o usuario deseja reiniciar o processo de desagregacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        IF !USED("xNensi")
            MsgAviso("Cursor de produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.InicializarTmpDistrib("xNensi")
        ENDIF

        THIS.CarregarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o dialog sem aplicar desagregacao
    * Equivale a pressionar ESC / cancelar a operacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        IF USED("xNensi")
            SELECT xNensi
            SET ORDER TO Editar
            IF THIS.this_nRecnoAnt > 0 AND RECCOUNT("xNensi") >= THIS.this_nRecnoAnt
                GO THIS.this_nRecnoAnt IN xNensi
            ENDIF
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Aplica desagregacao (equivalente ao BtnOkClick)
    * Alias adicional para o padrao do pipeline multi-fase
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnOkClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela marcacoes e fecha o dialog sem salvar
    * Limpa todos os flags Marca e quantidades antes de fechar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere estado do form para o Business Object
    * Passa alias do cursor fonte e a escolha corrente (pcEscolha do pai)
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cAliasFonte = "xNensi"
        THIS.this_oBusinessObject.this_cEscolha    = THIS.this_cEscolha
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza controles do form com dados do Business Object
    * Recarrega o grid e o rodape a partir do cursor TmpDistrib
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF !USED("TmpDistrib")
            RETURN
        ENDIF

        SELECT TmpDistrib
        IF RECCOUNT("TmpDistrib") > 0
            GO TOP
        ENDIF

        IF VARTYPE(THIS.txt_4c_Cor) = "O"
            THIS.txt_4c_Cor.Value = ALLTRIM(NVL(TmpDistrib.CodCors, ""))
            THIS.txt_4c_Cor.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Tam) = "O"
            THIS.txt_4c_Tam.Value = ALLTRIM(NVL(TmpDistrib.CodTams, ""))
            THIS.txt_4c_Tam.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Form OPERACIONAL: colunas editaveis controladas por
    * GradeAfterRowColChange conforme regras de negocio do legado.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Enabled = par_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Ok) = "O"
            THIS.cmd_4c_Ok.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera todas as marcacoes e quantidades desagregadas
    * Reinicia TmpDistrib para o estado inicial (nenhum item selecionado)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF !USED("TmpDistrib")
            RETURN
        ENDIF

        SELECT TmpDistrib
        SCAN
            REPLACE Marca   WITH .F., ;
                    Qtd2s   WITH 0,   ;
                    Peso2s  WITH 0,   ;
                    Pesof2s WITH 0
        ENDSCAN
        GO TOP

        *-- Limpa campos de exibicao do rodape
        IF VARTYPE(THIS.txt_4c_Cor) = "O"
            THIS.txt_4c_Cor.Value = ""
            THIS.txt_4c_Cor.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Tam) = "O"
            THIS.txt_4c_Tam.Value = ""
            THIS.txt_4c_Tam.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Form OPERACIONAL sem sistema de modos CRUD.
    * Garante que o botao OK permanece habilitado (unico modo: operacional).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmd_4c_Ok) = "O"
            THIS.cmd_4c_Ok.Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE
