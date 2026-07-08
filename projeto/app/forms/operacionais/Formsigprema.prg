*==============================================================================
* Formsigprema.prg - Form Operacional: Processamento e Geracao de Email
* Herda de: FormBase
* BO: sigpremaBO.prg
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* Fases: 8/8 - COMPLETO: todos os metodos FormBase implementados
*==============================================================================

DEFINE CLASS Formsigprema AS FormBase
	ShowWindow = 1
	WindowType = 1

    *-- Parametros recebidos no Init
    this_cDopes      = ""    && EmpDopNums do movimento (vazio = todos do dia)
    this_lAutomatico = .F.   && Modo automatico: processa e envia sem interacao

    *-- Propriedades auxiliares de processamento
    this_cArqEmail   = ""    && Caminho do PDF gerado para anexar no email
    this_cPcEscolha  = ""    && Tipo de documento escolhido (B=boleto, N=NF, etc.)
    this_cLcEmp      = ""    && Codigo de empresa extraido de prDopes
    this_oPdf        = .NULL. && Objeto PDFCreator COM (liberado apos uso)

    *-- Referencia ao BO
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cDopes, par_lAutomatico)
    *--------------------------------------------------------------------------
        THIS.this_cDopes      = IIF(TYPE("par_cDopes") = "C", par_cDopes, "")
        THIS.this_lAutomatico = IIF(TYPE("par_lAutomatico") = "L", par_lAutomatico, .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura do formulario (chamado por FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Instancia o BO
            THIS.this_oBusinessObject = CREATEOBJECT("sigpremaBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Propriedades visuais do form
                THIS.Width        = 1000
                THIS.Height       = 600
                THIS.AutoCenter   = .T.
                THIS.BorderStyle  = 2
                THIS.TitleBar     = 0
                THIS.ControlBox   = .F.
                THIS.Caption      = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
                THIS.FontName     = "Tahoma"
                THIS.FontSize     = 8
                THIS.WindowType   = 1
                THIS.ShowTips     = .T.

                IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                ENDIF

                *-- Cursor placeholder com estrutura identica ao cursor_4c_Local do BO
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (;
                    Checks     N(1)    NULL,;
                    grupos     C(10)   NULL,;
                    Contas     C(10)   NULL,;
                    Rclis      C(30)   NULL,;
                    emails     C(50)   NULL,;
                    mensagems  M,;
                    EmpDopNums C(29)   NULL,;
                    prioridade C(15)   NULL;
                )
                SET NULL OFF
                INDEX ON Contas  TAG Contas
                INDEX ON Rclis   TAG Rclis
                INDEX ON emails  TAG Emails

                *-- Cria estrutura visual (form OPERACIONAL usa layout flat, sem PageFrame real)
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                THIS.CarregarDados()

                *-- Modo automatico: email ja foi enviado, impede exibicao do form
                IF THIS.this_lAutomatico
                    loc_lSucesso = .F.
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar sigpremaBO.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao inicializar form")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra layout do form OPERACIONAL (flat)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarSaida()
        THIS.ConfigurarShape1()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form OPERACIONAL nao alterna paginas
    * Metodo existe por compatibilidade com FormBase (chamado por CancelarClick etc)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura area de exibicao/edicao dos dados
    * Form OPERACIONAL: nao ha "Page Dados" separada; area de dados eh o grid.
    * Este metodo finaliza a area de dados:
    *   1. Aplica sort visual inicial (coluna Nome/Rclis destacada em teal)
    *   2. Normaliza BackColor dos demais headers em cinza claro
    *   3. Ajusta alinhamento do header do checkbox
    *   4. Garante que o grid comece com valores default consistentes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oGrid

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF
        loc_oGrid = THIS.grd_4c_Dados

        *-- Sort inicial: Nome (Column3) marcado com cor de destaque teal
        *-- Espelha comportamento do Header.Click original (RGB 64,128,128)
        loc_oGrid.Column1.Header1.BackColor = RGB(192, 192, 192)
        loc_oGrid.Column2.Header1.BackColor = RGB(192, 192, 192)
        loc_oGrid.Column3.Header1.BackColor = RGB(64, 128, 128)
        loc_oGrid.Column4.Header1.BackColor = RGB(192, 192, 192)
        loc_oGrid.Column5.Header1.BackColor = RGB(192, 192, 192)

        *-- Alinhamento do header do checkbox (centralizado)
        loc_oGrid.Column1.Header1.Alignment = 2

        *-- Modo somente-leitura no grid inteiro exceto checkbox
        loc_oGrid.Column2.ReadOnly = .T.
        loc_oGrid.Column3.ReadOnly = .T.
        loc_oGrid.Column5.ReadOnly = .T.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria grid principal e botoes auxiliares
    * Layout original:
    *   grade: Top=126, Left=3, Width=993, Height=469, ColumnCount=5
    *   Column5(ordem 1) = CheckBox, Width=17
    *   Column1(ordem 2) = Conta,    Width=80
    *   Column2(ordem 3) = Nome,     Width=290
    *   Column3(ordem 4) = Email,    Width=290
    *   Column4(ordem 5) = Mensagem, Width=290
    *   SelTudo: Top=84, Left=4,  W=40, H=40, Picture=geral_marcar_26.jpg
    *   apaga:   Top=84, Left=43, W=40, H=40, Picture=cadastro_excluir_26.jpg
    *   btnEmail:Top=3,  Left=850,W=75, H=75, Picture=geral_envelope_60.jpg
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oGrid, loc_oCol

        *-- Grid principal
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top              = 126
            .Left             = 3
            .Width            = 993
            .Height           = 469
            .ColumnCount      = 5
            .FontName         = "Verdana"
            .FontSize         = 8
            .RecordMark       = .F.
            .DeleteMark       = .F.
            .RowHeight        = 18
            .GridLines        = 1
            .GridLineColor    = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle   = 2
            .ScrollBars       = 2
            .RecordSource     = "cursor_4c_Dados"
            .Visible          = .T.

            *-- Coluna 1: CheckBox (selecao)
            WITH .Column1
                .Width         = 17
                .ColumnOrder   = 1
                .ReadOnly      = .F.
                .Sparse        = .F.
                .FontName      = "Verdana"
                .FontSize      = 8
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption   = ""
                    .Value     = 0
                    .Visible   = .T.
                ENDWITH
                .CurrentControl  = "Check1"
                .ControlSource   = "cursor_4c_Dados.Checks"
                .Header1.Caption = ""
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
            ENDWITH

            *-- Coluna 2: Conta
            WITH .Column2
                .Width         = 80
                .ColumnOrder   = 2
                .ReadOnly      = .T.
                .FontName      = "Verdana"
                .FontSize      = 8
                .ControlSource = "cursor_4c_Dados.Contas"
                WITH .Text1
                    .FontName    = "Verdana"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .Visible     = .T.
                ENDWITH
                .CurrentControl  = "Text1"
                .Header1.Caption  = "Conta"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 3: Nome
            WITH .Column3
                .Width         = 290
                .ColumnOrder   = 3
                .ReadOnly      = .T.
                .FontName      = "Verdana"
                .FontSize      = 8
                .ControlSource = "cursor_4c_Dados.Rclis"
                WITH .Text1
                    .FontName    = "Verdana"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .Visible     = .T.
                ENDWITH
                .CurrentControl  = "Text1"
                .Header1.Caption  = "Nome"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 4: Email
            WITH .Column4
                .Width         = 290
                .ColumnOrder   = 4
                .ReadOnly      = .F.
                .FontName      = "Verdana"
                .FontSize      = 8
                .ControlSource = "cursor_4c_Dados.emails"
                WITH .Text1
                    .FontName    = "Verdana"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .F.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .Visible     = .T.
                ENDWITH
                .CurrentControl  = "Text1"
                .Header1.Caption  = "Email"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 5: Movimentacao de Estoque (EmpDopNums - identico ao original)
            WITH .Column5
                .Width         = 290
                .ColumnOrder   = 5
                .ReadOnly      = .T.
                .Sparse        = .F.
                .FontName      = "Verdana"
                .FontSize      = 8
                .ControlSource = "cursor_4c_Dados.EmpDopNums"
                .AddObject("Edit1", "EditBox")
                WITH .Edit1
                    .FontName      = "Verdana"
                    .FontSize      = 8
                    .BorderStyle   = 0
                    .ReadOnly      = .T.
                    .SpecialEffect = 1
                    .Visible       = .T.
                ENDWITH
                .CurrentControl  = "Edit1"
                .Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH
        ENDWITH

        *-- Re-definir ControlSource apos RecordSource (evita auto-bind por posicao de campo)
        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Checks"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Contas"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Rclis"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emails"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"

        *-- Handlers de Click nos headers para ordenacao (ordem original do legado)
        BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GrdHeader2Click")
        BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdHeader3Click")
        BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GrdHeader4Click")

        *-- Handler de InteractiveChange no CheckBox para atualizar cursor
        BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", THIS, "ChkSelChange")

        *-- Botao SelTudo (Marcar Todos)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top          = 84
            .Left         = 4
            .Height       = 40
            .Width        = 40
            .FontName     = "Verdana"
            .FontSize     = 8
            .WordWrap     = .T.
            .Caption      = ""
            .ToolTipText  = "Marcar Todos"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .TabStop      = .F.
            .Visible      = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")

        *-- Botao apaga (Desmarcar Todos)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top          = 84
            .Left         = 43
            .Height       = 40
            .Width        = 40
            .FontName     = "Verdana"
            .FontSize     = 8
            .WordWrap     = .T.
            .Caption      = ""
            .ToolTipText  = "Desmarcar Todos"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .TabStop      = .F.
            .Visible      = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")

        *-- Botao Enviar Email
        THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
        WITH THIS.cmd_4c_BtnEmail
            .Top          = 3
            .Left         = 850
            .Height       = 75
            .Width        = 75
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Caption      = "Enviar Email"
            .ToolTipText  = "Enviar Email"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .Picture      = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
            .Visible      = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnEmail, "Click", THIS, "CmdBtnEmailClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdHeader2Click - Ordena grid pela coluna Conta
    *--------------------------------------------------------------------------
    PROCEDURE GrdHeader2Click()
        SELECT cursor_4c_Dados
        SET ORDER TO TAG Contas
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdHeader3Click - Ordena grid pela coluna Nome
    *--------------------------------------------------------------------------
    PROCEDURE GrdHeader3Click()
        SELECT cursor_4c_Dados
        SET ORDER TO TAG Rclis
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdHeader4Click - Ordena grid pela coluna Email
    *--------------------------------------------------------------------------
    PROCEDURE GrdHeader4Click()
        SELECT cursor_4c_Dados
        SET ORDER TO TAG Emails
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkSelChange - Atualiza campo Checks no cursor quando CheckBox muda
    *--------------------------------------------------------------------------
    PROCEDURE ChkSelChange()
        LOCAL loc_oChk
        loc_oChk = THIS.grd_4c_Dados.Column1.Check1
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - Marca todos os registros
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL Checks WITH 1
            GO TOP
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApagaClick - Desmarca todos os registros
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL Checks WITH 0
            GO TOP
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria container de cabecalho superior
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top      = 18
                .Left     = 10
                .Width    = THIS.Width
                .Height   = 40
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 18
                .FontBold = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top         = 17
                .Left        = 10
                .Width       = THIS.Width
                .Height      = 46
                .AutoSize    = .F.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .FontBold    = .T.
                .BackStyle   = 0
                .ForeColor   = RGB(255, 255, 255)
                .WordWrap    = .T.
                .Alignment   = 0
                .Caption     = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape1 - Cria elemento decorativo ao redor do botao Email
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape1()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top          = 7
            .Left         = 804
            .Height       = 110
            .Width        = 90
            .BackStyle    = 0
            .BorderStyle  = 0
            .BorderWidth  = 1
            .SpecialEffect = 1
            .BorderColor  = RGB(136, 189, 188)
            .Visible      = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSaida - Cria CommandGroup com botao Encerrar (canonico original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSaida()
        THIS.AddObject("cmg_4c_Saida", "CommandGroup")
        WITH THIS.cmg_4c_Saida
            .Top           = -2
            .Left          = 920
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 5
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .Caption     = "Encerrar"
                .ToolTipText = "[Esc] Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Cancel      = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Saida, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega movimentos do dia (ou EmpDopNums especifico) via BO
    * Popula cursor_4c_Dados para o grid e trata modo automatico
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ENDIF

            loc_lResultado = THIS.this_oBusinessObject.CarregarListaEmail(THIS.this_cDopes)

            IF loc_lResultado AND USED("cursor_4c_Local")
                *-- Migra dados para cursor do grid (ZAP+APPEND preserva estrutura de colunas)
                SELECT cursor_4c_Dados
                ZAP
                APPEND FROM DBF("cursor_4c_Local")
                IF USED("cursor_4c_Local")
                    USE IN cursor_4c_Local
                ENDIF

                *-- Ordena por Nome (comportamento padrao do original)
                SELECT cursor_4c_Dados
                SET ORDER TO TAG Rclis

                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF

            *-- Modo automatico: envia email imediatamente sem interacao
            IF THIS.this_lAutomatico
                THIS.CmdBtnEmailClick()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao carregar dados para email")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdBtnEmailClick - Envia email para registros marcados (Checks=1)
    * Logica original: btnEmail.Click
    *--------------------------------------------------------------------------
    PROCEDURE CmdBtnEmailClick()
        LOCAL loc_lSucesso, loc_lOk, loc_oErro
        LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto
        LOCAL loc_cTxtMensagem, loc_cArqAnexo
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cEdn
        LOCAL loc_cFrom, loc_cServer, loc_cSenha, loc_nPorta
        LOCAL loc_cSQL

        loc_lOk              = .T.
        loc_cReceptor        = ""
        loc_cReceptorCopia   = ""
        loc_cAssunto         = ""
        loc_cTxtMensagem     = ""
        loc_cArqAnexo        = ""

        *-- Seleciona apenas registros marcados
        IF USED("cursor_4c_Local2")
            USE IN cursor_4c_Local2
        ENDIF
        SELECT * FROM cursor_4c_Dados WHERE Checks = 1 INTO CURSOR cursor_4c_Local2 READWRITE

        IF !USED("cursor_4c_Local2") OR RECCOUNT("cursor_4c_Local2") < 1
            MsgAviso("Nenhum registro marcado para envio de email.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Local2
        GO TOP
        SCAN
            IF EMPTY(cursor_4c_Local2.emails)
                LOOP
            ENDIF

            SELECT cursor_4c_Local2
            loc_cEmps   = SUBSTR(cursor_4c_Local2.EmpDopNums, 1, 3)
            loc_cDopes  = ALLTRIM(SUBSTR(cursor_4c_Local2.EmpDopNums, 4, 20))
            loc_nNumes  = VAL(SUBSTR(cursor_4c_Local2.EmpDopNums, 24, 6))
            loc_cEdn    = ALLTRIM(cursor_4c_Local2.EmpDopNums)

            IF RECNO("cursor_4c_Local2") = 1
                loc_cReceptor      = ALLTRIM(cursor_4c_Local2.emails)
                loc_cTxtMensagem   = ""
                loc_cAssunto       = ""
            ELSE
                IF !EMPTY(ALLTRIM(cursor_4c_Local2.emails))
                    loc_cReceptorCopia = loc_cReceptorCopia + ;
                        IIF(EMPTY(loc_cReceptorCopia), "", ",") + ;
                        ALLTRIM(cursor_4c_Local2.emails)
                ENDIF
            ENDIF

            *-- Remove PDF anterior se existir
            IF FILE(ADDBS(SYS(2023)) + "FORTYUSPDF.PDF")
                DELETE FILE ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
            ENDIF

            *-- Gera impressao/PDF do documento
            loc_lOk = THIS.ImprimirDocumento(loc_cEdn)

            IF loc_lOk
                loc_cArqAnexo = THIS.this_cArqEmail
            ENDIF

            *-- Busca dados de email da empresa
            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, PadPortas " + ;
                       "FROM SigCdEmp WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF USED("cursor_4c_EmpMail")
                USE IN cursor_4c_EmpMail
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpMail") < 1
                MsgErro("Falha ao buscar dados de email da empresa.", "Erro")
                loc_lOk = .F.
            ELSE
                SELECT cursor_4c_EmpMail
                GO TOP
                IF !EOF("cursor_4c_EmpMail")
                    loc_cFrom   = LOWER(ALLTRIM(NVL(cursor_4c_EmpMail.PadEmails, "")))
                    loc_cServer = LOWER(ALLTRIM(NVL(cursor_4c_EmpMail.PadServs, "")))
                    loc_cSenha  = ALLTRIM(NVL(cursor_4c_EmpMail.PadSenhas, ""))
                    loc_nPorta  = NVL(cursor_4c_EmpMail.PadPortas, 0)
                ELSE
                    MsgErro("Empresa n" + CHR(227) + "o encontrada no cadastro.", "Erro")
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR
                loc_lOk = THIS.EnviarEmail(;
                    loc_cFrom, ;
                    loc_cReceptor, ;
                    loc_cReceptorCopia, ;
                    loc_cAssunto, ;
                    loc_cTxtMensagem, ;
                    loc_cArqAnexo, ;
                    loc_cServer, ;
                    loc_nPorta, ;
                    loc_cFrom, ;
                    loc_cSenha;
                )
            ENDIF

            IF loc_lOk
                THIS.GravarLog(loc_cEdn)
            ENDIF

            SELECT cursor_4c_Local2
        ENDSCAN

        WAIT CLEAR

        IF USED("cursor_4c_EmpMail")
            USE IN cursor_4c_EmpMail
        ENDIF
        IF USED("cursor_4c_Local2")
            USE IN cursor_4c_Local2
        ENDIF

        IF loc_lOk
            WAIT WINDOW "Email enviado com sucesso!" TIMEOUT 2
            THIS.Release()
        ENDIF

        IF THIS.this_lAutomatico
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDocumento - Gera PDF do documento para o movimento
    * Adaptado de: SIGPREMA.impdocto
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDocumento(par_cEdn)
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cSQL, loc_cDopes, loc_cEmps
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Busca cabecalho do movimento
            loc_cSQL = "SELECT Emps, Dopes, Numes, ValDevs, EmpDnCrds, Contads " + ;
                       "FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(ALLTRIM(par_cEdn))
            IF USED("cursor_4c_MvCab")
                TABLEREVERT(.T., "cursor_4c_MvCab")
                USE IN cursor_4c_MvCab
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab") < 1
                MsgErro("Erro ao buscar movimento " + ALLTRIM(par_cEdn), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_MvCab
                GO TOP
                IF EOF("cursor_4c_MvCab")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Busca operacao
            IF loc_lContinuar
                loc_cDopes = ALLTRIM(cursor_4c_MvCab.Dopes)
                loc_cSQL   = "SELECT Dopes, Docus, nOpCrs FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
                IF USED("cursor_4c_Ope")
                    USE IN cursor_4c_Ope
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope") < 1
                    MsgErro("Erro ao buscar opera" + CHR(231) + CHR(227) + "o " + loc_cDopes, "Erro")
                    loc_lContinuar = .F.
                ELSE
                    SELECT cursor_4c_Ope
                    GO TOP
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Busca configuracao da operacao (datacenter - inclui GerOpes)
                loc_cSQL = "SELECT Dopes, QtdDocs, GerOpes FROM SigOpCdc WHERE Dopes = " + EscaparSQL(loc_cDopes)
                IF USED("cursor_4c_OpCdc")
                    USE IN cursor_4c_OpCdc
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdc")
                SELECT cursor_4c_OpCdc
                GO TOP

                *-- Busca configuracao de Job e inventario (SigOpCdi - lbltxidCs e chkInvs)
                loc_cSQL = "SELECT Dopes, lbltxidCs, chkInvs FROM SigOpCdi WHERE Dopes = " + EscaparSQL(loc_cDopes)
                IF USED("cursor_4c_OpCdi")
                    USE IN cursor_4c_OpCdi
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdi")
                SELECT cursor_4c_OpCdi
                GO TOP

                *-- Busca configuracao adicional (SigOpCdd - ConfigGers para impressao de Job)
                loc_cSQL = "SELECT Dopes, ConfigGers FROM SigOpCdd WHERE Dopes = " + EscaparSQL(loc_cDopes)
                IF USED("cursor_4c_OpCdd")
                    USE IN cursor_4c_OpCdd
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdd")
                SELECT cursor_4c_OpCdd
                GO TOP

                *-- Define caminho do PDF gerado
                THIS.this_cArqEmail  = ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
                THIS.this_cPcEscolha = ""

                *-- Impressao de boleto/NF (docus 0,1,5)
                IF !EOF("cursor_4c_Ope") AND INLIST(cursor_4c_Ope.Docus, 0, 1, 5)
                    loc_cEmps  = ALLTRIM(cursor_4c_MvCab.Emps)
                    loc_cDopes = ALLTRIM(cursor_4c_MvCab.Dopes)
                    DO FORM SigPrIdc WITH ;
                        loc_cEmps, loc_cDopes, cursor_4c_MvCab.Numes, ;
                        cursor_4c_MvCab.ValDevs, cursor_4c_OpCdc.QtdDocs, ;
                        .F., .T., .F., .F., .F., .F., THIS, .T.
                    loc_lSucesso = FILE(THIS.this_cArqEmail)
                ENDIF

                *-- Impressao de NF fiscal (docus 3,4,6,7,8,9)
                IF !EOF("cursor_4c_Ope") AND INLIST(cursor_4c_Ope.Docus, 3, 4, 6, 7, 8, 9)
                    DO FORM SigReIfx WITH ;
                        ALLTRIM(cursor_4c_MvCab.Emps), ;
                        ALLTRIM(cursor_4c_MvCab.Dopes), ;
                        cursor_4c_MvCab.Numes, .F., .T.
                    loc_lSucesso = .T.
                ENDIF

                *-- Verifica impressao de Job (lbltxidCs de SigOpCdi / ConfigGers de SigOpCdd)
                IF !EOF("cursor_4c_OpCdi")
                    IF INLIST(INT(VAL(SUBSTR(cursor_4c_OpCdi.lbltxidCs, 25, 1))), 1, 3)
                        IF !EOF("cursor_4c_OpCdd")
                            IF INT(VAL(SUBSTR(cursor_4c_OpCdd.ConfigGers, 157, 1))) = 1
                                DO FORM SigReJob WITH THIS
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- Estorno: operacao gerou documento vinculado (nOpCrs nao vazio)
                IF !EOF("cursor_4c_Ope") AND !EMPTY(cursor_4c_Ope.nOpCrs)
                    LOCAL loc_cSQLEst, loc_cEmpEst, loc_cDopEst, loc_nNumEst
                    loc_cSQLEst = "SELECT Emps, Dopes, Numes, ValDevs " + ;
                                  "FROM SigMvCab WHERE EmpDnCrds = " + EscaparSQL(ALLTRIM(par_cEdn))
                    IF USED("cursor_4c_MvCabEst")
                        USE IN cursor_4c_MvCabEst
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQLEst, "cursor_4c_MvCabEst") > 0
                        SELECT cursor_4c_MvCabEst
                        GO TOP
                        IF !EOF("cursor_4c_MvCabEst")
                            loc_cEmpEst = ALLTRIM(cursor_4c_MvCabEst.Emps)
                            loc_cDopEst = ALLTRIM(cursor_4c_MvCabEst.Dopes)
                            loc_nNumEst = cursor_4c_MvCabEst.Numes
                            IF USED("cursor_4c_OpeEst")
                                USE IN cursor_4c_OpeEst
                            ENDIF
                            loc_cSQL = "SELECT Dopes, Docus FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopEst)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeEst") > 0
                                SELECT cursor_4c_OpeEst
                                GO TOP
                                IF !EOF("cursor_4c_OpeEst")
                                    IF INLIST(cursor_4c_OpeEst.Docus, 1, 5)
                                        IF USED("cursor_4c_OpCdcEst")
                                            USE IN cursor_4c_OpCdcEst
                                        ENDIF
                                        loc_cSQL = "SELECT Dopes, QtdDocs FROM SigOpCdc WHERE Dopes = " + EscaparSQL(loc_cDopEst)
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdcEst") > 0
                                            SELECT cursor_4c_OpCdcEst
                                            GO TOP
                                            IF !EOF("cursor_4c_OpCdcEst")
                                                DO FORM SigPrIdc WITH ;
                                                    loc_cEmpEst, loc_cDopEst, loc_nNumEst, ;
                                                    cursor_4c_MvCabEst.ValDevs, cursor_4c_OpCdcEst.QtdDocs, ;
                                                    .F., .F., .F., .F., .F., .F., THIS, .T.
                                            ENDIF
                                        ENDIF
                                        IF USED("cursor_4c_OpCdcEst")
                                            USE IN cursor_4c_OpCdcEst
                                        ENDIF
                                    ENDIF
                                    IF INLIST(cursor_4c_OpeEst.Docus, 3, 6, 7, 8, 9)
                                        DO FORM SigReIfx WITH loc_cEmpEst, loc_cDopEst, loc_nNumEst, .F., .T.
                                    ENDIF
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_OpeEst")
                                USE IN cursor_4c_OpeEst
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MvCabEst")
                        USE IN cursor_4c_MvCabEst
                    ENDIF
                ENDIF

                *-- GerOpes = 2: impressao de multiplas movimentacoes geradas
                IF !EOF("cursor_4c_OpCdc") AND NVL(cursor_4c_OpCdc.GerOpes, 0) = 2
                    DO FORM SigOpIgm WITH THIS, ;
                        ALLTRIM(cursor_4c_MvCab.Emps), ;
                        ALLTRIM(cursor_4c_MvCab.Dopes), ;
                        cursor_4c_MvCab.Numes, .T.
                ENDIF

                *-- chkInvs = 1: impressao de inventario
                IF !EOF("cursor_4c_OpCdi") AND NVL(cursor_4c_OpCdi.chkInvs, 0) = 1
                    DO FORM SigReIiv WITH ;
                        ALLTRIM(cursor_4c_MvCab.Emps), ;
                        ALLTRIM(cursor_4c_MvCab.Dopes), ;
                        cursor_4c_MvCab.Numes
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ImprimirDocumento")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Envia email via CDO.Message
    * Adaptado de: SIGPREMA.memail
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cFrom, par_cTo, par_cCC, par_cAssunto, par_cCorpo, ;
                         par_cAnexo, par_cSmtpServer, par_nSmtpPort, ;
                         par_cSendUser, par_cSendPass)
        LOCAL loc_oEmail, loc_lOk, loc_lEnvioOk, loc_oErro
        loc_lOk      = .F.
        loc_lEnvioOk = .T.

        TRY
            loc_oEmail = CREATEOBJECT("CDO.Message")
            IF VARTYPE(loc_oEmail) != "O"
                MsgAviso("Problemas ao instanciar CDO.Message para envio de email.", "Aviso")
                loc_lEnvioOk = .F.
            ENDIF

            IF loc_lEnvioOk
                WITH loc_oEmail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")              = 2
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")             = LOWER(ALLTRIM(par_cSmtpServer))
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout")  = 10
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")         = IIF(par_nSmtpPort = 0, 25, par_nSmtpPort)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")       = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")           = LOWER(ALLTRIM(par_cSendUser))
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")           = par_cSendPass
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")             = IIF(par_nSmtpPort = 465, 1, 0)
                    .Update()
                ENDWITH

                WITH loc_oEmail
                    .To        = LOWER(ALLTRIM(par_cTo))
                    .Cc        = LOWER(NVL(par_cCC, ""))
                    .From      = LOWER(ALLTRIM(par_cFrom))
                    .Subject   = ALLTRIM(par_cAssunto)
                    .TextBody  = ALLTRIM(par_cCorpo)

                    IF !ISNULL(par_cAnexo) AND !EMPTY(ALLTRIM(par_cAnexo))
                        IF FILE(ALLTRIM(par_cAnexo))
                            .AddAttachment(ALLTRIM(par_cAnexo))
                        ELSE
                            loc_lEnvioOk = .F.
                            MsgAviso("Arquivo anexo n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                                     ALLTRIM(par_cAnexo), "Aviso")
                        ENDIF
                    ENDIF

                    IF loc_lEnvioOk
                        LOCAL loc_oErroEnvio
                        TRY
                            .Send()
                            loc_lOk = .T.
                        CATCH TO loc_oErroEnvio
                            WAIT WINDOW "Dados do e-mail inv" + CHR(225) + "lidos." TIMEOUT 5
                            loc_lOk = .F.
                        ENDTRY
                    ENDIF
                ENDWITH
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro EnviarEmail")
            loc_lOk = .F.
        ENDTRY

        loc_oEmail = .NULL.
        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarLog - Registra envio no log do sistema (sigoplog)
    * Adaptado de: fGravarLog('T', SIGPREMA, '', EmpDopNums)
    *--------------------------------------------------------------------------
    PROCEDURE GravarLog(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpLog (Progs, Transacaos, Datars, Horas) " + ;
                       "VALUES (" + EscaparSQL("SIGPREMA") + ", " + ;
                       EscaparSQL(ALLTRIM(par_cEmpDopNums)) + ", " + ;
                       FormatarDataSQL(DATE()) + ", " + ;
                       EscaparSQL(TIME()) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha no log nao impede o fluxo principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
    * FormBase declara este metodo; retorna .F. para indicar nao-suporte
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Form OPERACIONAL nao tem fluxo de alteracao CRUD
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Form OPERACIONAL nao tem fluxo de visualizacao CRUD
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Form OPERACIONAL nao tem fluxo de exclusao CRUD
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Local")
            USE IN cursor_4c_Local
        ENDIF
        IF USED("cursor_4c_Local2")
            USE IN cursor_4c_Local2
        ENDIF
        IF USED("cursor_4c_MvCab")
            USE IN cursor_4c_MvCab
        ENDIF
        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF
        IF USED("cursor_4c_OpCdc")
            USE IN cursor_4c_OpCdc
        ENDIF
        IF USED("cursor_4c_OpCdi")
            USE IN cursor_4c_OpCdi
        ENDIF
        IF USED("cursor_4c_OpCdd")
            USE IN cursor_4c_OpCdd
        ENDIF
        IF USED("cursor_4c_MvCabEst")
            USE IN cursor_4c_MvCabEst
        ENDIF
        IF USED("cursor_4c_OpeEst")
            USE IN cursor_4c_OpeEst
        ENDIF
        IF USED("cursor_4c_OpCdcEst")
            USE IN cursor_4c_OpCdcEst
        ENDIF
        IF USED("cursor_4c_EmpMail")
            USE IN cursor_4c_EmpMail
        ENDIF
        THIS.this_oPdf             = .NULL.
        THIS.this_oBusinessObject  = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Form OPERACIONAL: sem busca CRUD
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario (compatibilidade FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Form OPERACIONAL: sem salvamento CRUD
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Form OPERACIONAL: sem cancelamento CRUD
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Form OPERACIONAL: sem mapeamento campo->propriedade BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Form OPERACIONAL: sem mapeamento propriedade BO->campo
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Form OPERACIONAL: sem controle de habilitacao por modo CRUD
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera cursor de dados e atualiza grid
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            ZAP
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Delega para CarregarDados (padrao operacional)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD para ajustar
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

ENDDEFINE
