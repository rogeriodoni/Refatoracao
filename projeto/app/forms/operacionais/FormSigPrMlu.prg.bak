*==============================================================================
* FORMSIGPRMLU.PRG - Formulario Operacional: Unificacao de Mala Direta
* Tipo: OPERACIONAL (flat popup modal 1000x600, sem PageFrame)
* Migrado de SIGPRMLU.SCX
*
* Pilares:
*   UX   -> header cinza, grid 6 colunas, checkbox selecao, processar/encerrar
*   BD   -> cursor_4c_Itn (SigMlItn via SigPrMluBO.BuscarMalas)
*   CODE -> arquitetura em camadas (FormBase / SigPrMluBO)
*==============================================================================

DEFINE CLASS FormSigPrMlu AS FormBase

    Width        = 1000
    Height       = 600
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1
    DataSession  = 2

    *-- Ordem de ordenacao atual da grade (2=Codigos, 3=Descs, 4=UsuIns, 5=DatIns)
    this_nOrdemGrade = 2

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"

            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrMluBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrMluBO", "Erro")
            ELSE
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCntNova()
                THIS.ConfigurarGrade()
                THIS.ConfigurarBtnGrade()
                THIS.ConfigurarBINDEVENTs()
                THIS.TornarControlesVisiveis()

                THIS.this_oBusinessObject.BuscarMalas()
                THIS.MontarGrade()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = 1000
            .Height        = 40
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize      = .F.
            .Top           = 17
            .Left          = 10
            .Width         = 1000
            .Height        = 46
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(255, 255, 255)
            .Caption       = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        LOCAL loc_oCnt
        *-- Botao Processar (standalone com icone 60px, Themes=.T. + DisabledPicture obrigatorios)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 5
            .Left            = 828
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "\<Processar"
            .ToolTipText     = "[Alt+P] Processar Unifica" + CHR(231) + CHR(227) + "o"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
        ENDWITH

        *-- Container canonico Encerrar (Left=917, Width=90, Height=85)
        THIS.AddObject("cnt_4c_Saida", "Container")
        loc_oCnt = THIS.cnt_4c_Saida
        WITH loc_oCnt
            .Top         = -2
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BorderWidth = 0
            .BackStyle   = 0
        ENDWITH
        loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Encerrar
            .Top         = 5
            .Left        = 5
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel      = .T.
            .Caption     = "Encerrar"
            .ToolTipText = "[Esc] Encerrar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntNova
    *-- Container com campo "Nome da Unificacao" (cntNova do legado)
    *==========================================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Nova", "Container")
        loc_oCnt = THIS.cnt_4c_Nova
        WITH loc_oCnt
            .Top         = 92
            .Left        = 15
            .Width       = 800
            .Height      = 42
            .BackStyle   = 0
            .BorderWidth = 0
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Nome", "Label")
        WITH loc_oCnt.lbl_4c_Nome
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = " \<Nome da Unifica" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 20
            .Top       = 13
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oCnt.AddObject("txt_4c_GetNova", "TextBox")
        WITH loc_oCnt.txt_4c_GetNova
            .FontName          = "Courier New"
            .FontSize          = 9
            .Format            = "K"
            .Height            = 25
            .Left              = 155
            .MaxLength         = 20
            .TabIndex          = 1
            .Top               = 8
            .Width             = 220
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Value             = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
    *-- Grid grd_4c_Selecoes: 6 colunas (Check, Codigo, Descricao, Usuario,
    *-- Dt.Entrada, N.Registros) ? espelho do grdSelecoes do legado
    *==========================================================================
        THIS.AddObject("grd_4c_Selecoes", "Grid")
        WITH THIS.grd_4c_Selecoes
            .Top                = 140
            .Left               = 15
            .Width              = 870
            .Height             = 420
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .RowHeight          = 16
            .HeaderHeight       = 16
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .ReadOnly           = .F.
            .ScrollBars         = 2
            .FontName           = "Tahoma"
            .FontSize           = 8
            .GridLineColor      = RGB(238, 238, 238)
            .ColumnCount        = 6

            *-- Column1: CheckBox de selecao (SelImp)
            WITH .Column1
                .ColumnOrder   = 1
                .Width         = 20
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .F.
                WITH .Header1
                    .Caption   = ""
                    .Alignment = 2
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                .AddObject("ctlCheck1", "CheckBox")
                WITH .ctlCheck1
                    .Caption   = ""
                    .Alignment = 0
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Value     = 0
                ENDWITH
                .CurrentControl = "ctlCheck1"
                .Sparse         = .F.
            ENDWITH

            *-- Column2: Codigo (Codigos)
            WITH .Column2
                .ColumnOrder   = 2
                .Width         = 90
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                WITH .Header1
                    .Caption   = "C" + CHR(243) + "digo"
                    .Alignment = 2
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .FontName    = "Courier New"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column3: Descricao (Descs)
            WITH .Column3
                .ColumnOrder   = 3
                .Width         = 380
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                WITH .Header1
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .Alignment = 2
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column4: Usuario (UsuIns)
            WITH .Column4
                .ColumnOrder   = 4
                .Width         = 130
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                WITH .Header1
                    .Caption   = "Usu" + CHR(225) + "rio"
                    .Alignment = 2
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .FontName    = "Courier New"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column5: Data Entrada (DatIns)
            WITH .Column5
                .ColumnOrder   = 5
                .Width         = 120
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                WITH .Header1
                    .Caption   = "Dt.Entrada"
                    .Alignment = 2
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column6: N.Registros (NRegis)
            WITH .Column6
                .ColumnOrder   = 6
                .Width         = 110
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                WITH .Header1
                    .Caption   = "N.Registros"
                    .Alignment = 2
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBtnGrade
    *-- Botoes Selecionar/Desmarcar tudo (cmdBtnGrade do legado)
    *-- Posicionados abaixo e a direita da grade
    *==========================================================================
        *-- Botao Selecionar Tudo
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 265
            .Left        = 892
            .Height      = 40
            .Width       = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Selecionar Tudo"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
        ENDWITH

        *-- Botao Desmarcar Tudo
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 310
            .Left        = 892
            .Height      = 40
            .Width       = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Desmarcar Tudo"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
    *==========================================================================
        *-- Botoes principais
        BINDEVENT(THIS.cmd_4c_Processar,              "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botoes de selecao de grade
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelecionarTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "BtnDesmarcarTudoClick")

        *-- Cliques nos cabecalhos para ordenacao
        BINDEVENT(THIS.grd_4c_Selecoes.Column2.Header1, "Click", THIS, "Col2HeaderClick")
        BINDEVENT(THIS.grd_4c_Selecoes.Column3.Header1, "Click", THIS, "Col3HeaderClick")
        BINDEVENT(THIS.grd_4c_Selecoes.Column4.Header1, "Click", THIS, "Col4HeaderClick")
        BINDEVENT(THIS.grd_4c_Selecoes.Column5.Header1, "Click", THIS, "Col5HeaderClick")

        *-- CheckBox de selecao individual: MouseDown + KeyPress
        BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "MouseDown", THIS, "GrdChkMouseDown")
        BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "KeyPress",  THIS, "GrdChkKeyPress")
        BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "Click",     THIS, "GrdChkClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE MontarGrade
    *-- Vincula o cursor_4c_Itn ao grid apos BuscarMalas()
    *==========================================================================
        LOCAL loc_oGrd, loc_oErro
        loc_oGrd = .NULL.
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
                loc_oGrd = THIS.grd_4c_Selecoes
                loc_oGrd.RecordSource = ""
            ENDIF

            IF USED("cursor_4c_Itn")
                THIS.OrdenarGrade(THIS.this_nOrdemGrade)

                loc_oGrd.ColumnCount = 6
                loc_oGrd.RecordSource = "cursor_4c_Itn"

                WITH loc_oGrd
                    .Column1.ControlSource = "cursor_4c_Itn.SelImp"
                    .Column2.ControlSource = "cursor_4c_Itn.Codigos"
                    .Column3.ControlSource = "cursor_4c_Itn.Descs"
                    .Column4.ControlSource = "cursor_4c_Itn.Usuins"
                    .Column5.ControlSource = "cursor_4c_Itn.Datins"
                    .Column6.ControlSource = "cursor_4c_Itn.Nregis"
                ENDWITH

                GO TOP IN cursor_4c_Itn
            ENDIF

            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro MontarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE OrdenarGrade
    *-- Ordena cursor_4c_Itn pela coluna especificada e destaca header
    *-- par_nColuna: 2=Codigos 3=Descs 4=UsuIns 5=DatIns
    *==========================================================================
        LPARAMETERS par_nColuna
        LOCAL loc_cTag, loc_nRec, loc_i
        loc_cTag = ""

        IF VARTYPE(par_nColuna) = "N"
            THIS.this_nOrdemGrade = par_nColuna
        ENDIF

        DO CASE
            CASE THIS.this_nOrdemGrade = 2
                loc_cTag = "Codigos"
            CASE THIS.this_nOrdemGrade = 3
                loc_cTag = "Descs"
            CASE THIS.this_nOrdemGrade = 4
                loc_cTag = "Usuins"
            CASE THIS.this_nOrdemGrade = 5
                loc_cTag = "Datins"
        ENDCASE

        IF USED("cursor_4c_Itn") AND !EMPTY(loc_cTag)
            loc_nRec = RECNO("cursor_4c_Itn")
            SET ORDER TO TAG (loc_cTag) IN cursor_4c_Itn
            IF RECCOUNT("cursor_4c_Itn") > 0
                GO loc_nRec IN cursor_4c_Itn
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            FOR loc_i = 1 TO THIS.grd_4c_Selecoes.ColumnCount
                THIS.grd_4c_Selecoes.Columns(loc_i).Header1.BackColor = ;
                    IIF(THIS.this_nOrdemGrade = loc_i, RGB(220, 255, 220), RGB(192, 192, 192))
            ENDFOR
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    PROTECTED PROCEDURE TornarSubControlesVisiveis
        LPARAMETERS par_oContainer
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Compatibilidade de pipeline ? OPERACIONAL flat (sem PageFrame/CRUD)
    *
    * Este form nao segue o padrao Page1=Lista/Page2=Dados.
    * Grid e botoes sao criados diretamente via:
    *   ConfigurarGrade()    ? grd_4c_Selecoes (6 colunas, checkbox SelImp)
    *   ConfigurarBotoes()   ? cmd_4c_Processar + cnt_4c_Saida/cmd_4c_Encerrar
    *   ConfigurarBtnGrade() ? cmd_4c_SelTudo + cmd_4c_Apaga
    * Todos chamados em InicializarForm().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- OPERACIONAL: sem PageFrame; controles criados diretamente em InicializarForm
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- OPERACIONAL: grid ja configurado por ConfigurarGrade() em InicializarForm()
        *-- Refrescar grade caso chamado pelo pipeline apos carga inicial
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5) AND USED("cursor_4c_Itn")
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- OPERACIONAL: sem pagina de dados separada; grade gerenciada por ConfigurarGrade()
        RETURN .T.
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        *-- OPERACIONAL: nao ha troca de pagina; apenas refresca a grade
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF USED("cursor_4c_Itn")
            USE IN cursor_4c_Itn
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Handlers de eventos - PUBLIC (obrigatorio para BINDEVENT)
    *==========================================================================

    PROCEDURE BtnProcessarClick()
        LOCAL loc_cNome, loc_lOk, loc_nSelecionadas, loc_oErro
        loc_lOk = .F.
        loc_cNome = ""

        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = .F.
        ENDIF

        TRY
            IF !USED("cursor_4c_Itn")
                MsgAviso("Nenhuma mala direta carregada.", "Processar")
            ELSE
                *-- GO TOP + refresh antes de verificar selecao (comportamento original)
                GO TOP IN cursor_4c_Itn
                IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
                    THIS.grd_4c_Selecoes.Refresh()
                ENDIF

                *-- Verificar se ha malas com registros selecionadas
                SELECT COUNT(*) AS nSel FROM cursor_4c_Itn ;
                    WHERE SelImp = 1 INTO CURSOR cursor_4c_TmpSel
                loc_nSelecionadas = 0
                IF USED("cursor_4c_TmpSel")
                    loc_nSelecionadas = NVL(cursor_4c_TmpSel.nSel, 0)
                    USE IN cursor_4c_TmpSel
                ENDIF

                IF loc_nSelecionadas < 1
                    MsgAviso("Nenhuma Mala Direta com registros foi selecionada para unifica" + ;
                             CHR(231) + CHR(227) + "o.", "Processar")
                    IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
                        THIS.grd_4c_Selecoes.SetFocus()
                    ENDIF
                ELSE
                    IF loc_nSelecionadas = 1
                    MsgAviso("Apenas uma Mala Direta com registros foi selecionada." + CHR(13) + ;
                             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel unificar apenas uma." + CHR(13) + ;
                             "Selecione ao menos duas Malas Diretas.", "Processar")
                    IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
                        THIS.grd_4c_Selecoes.SetFocus()
                    ENDIF
                ELSE
                    IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
                        loc_cNome = ALLTRIM(THIS.cnt_4c_Nova.txt_4c_GetNova.Value)
                    ENDIF

                    IF EMPTY(loc_cNome)
                        MsgAviso("Nome da Unifica" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido." + CHR(13) + ;
                                 "Este " + CHR(233) + " o nome que ser" + CHR(225) + " utilizado na unifica" + ;
                                 CHR(231) + CHR(227) + "o gerada.", "Processar")
                        IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
                            THIS.cnt_4c_Nova.txt_4c_GetNova.SetFocus()
                        ENDIF
                    ELSE
                        IF MsgConfirma("Confirma a Unifica" + CHR(231) + CHR(227) + "o das Malas Diretas?")
                            loc_lOk = THIS.this_oBusinessObject.ProcessarUnificacao(loc_cNome)
                            IF loc_lOk
                                THIS.MontarGrade()
                                IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
                                    THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ""
                                ENDIF
                                IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
                                    THIS.grd_4c_Selecoes.SetFocus()
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
        ENDTRY

        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = .T.
        ENDIF
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSelecionarTudoClick()
        IF USED("cursor_4c_Itn")
            REPLACE ALL SelImp WITH 1 IN cursor_4c_Itn
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarTudoClick()
        IF USED("cursor_4c_Itn")
            REPLACE ALL SelImp WITH 0 IN cursor_4c_Itn
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE Col2HeaderClick()
        THIS.OrdenarGrade(2)
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE Col3HeaderClick()
        THIS.OrdenarGrade(3)
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE Col4HeaderClick()
        THIS.OrdenarGrade(4)
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE Col5HeaderClick()
        THIS.OrdenarGrade(5)
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    *-- MouseDown: toggle SelImp do registro corrente (equivale ao CheckBox original)
    PROCEDURE GrdChkMouseDown
        LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
        LOCAL loc_nSel
        IF USED("cursor_4c_Itn")
            loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
            SELECT cursor_4c_Itn
            REPLACE SelImp WITH loc_nSel
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
        NODEFAULT
    ENDPROC

    *-- KeyPress: toggle SelImp com Enter (13) ou Space (32)
    PROCEDURE GrdChkKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nSel
        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("cursor_4c_Itn")
                loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
                SELECT cursor_4c_Itn
                REPLACE SelImp WITH loc_nSel
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
                THIS.grd_4c_Selecoes.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *-- Click: absorver para nao disparar duplo-toggle com MouseDown
    PROCEDURE GrdChkClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * Contratos de pipeline ? nao aplicaveis a este form OPERACIONAL
    * (nao ha Page1=Lista/Page2=Dados nem botoes CRUD; acao principal = BtnProcessarClick)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        RETURN .F.
    ENDPROC

    PROCEDURE BtnAlterarClick()
        RETURN .F.
    ENDPROC

    PROCEDURE BtnExcluirClick()
        RETURN .F.
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * CarregarLista - recarrega grade do servidor (contrato de pipeline)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.BuscarMalas()
            IF loc_lSucesso
                THIS.MontarGrade()
            ENDIF
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - mapeia campo "Nome da Unificacao" para o BO
    * (unico campo editavel pelo usuario neste form OPERACIONAL)
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
                THIS.this_oBusinessObject.this_cDescs = ;
                    ALLTRIM(THIS.cnt_4c_Nova.txt_4c_GetNova.Value)
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - popula campo "Nome da Unificacao" a partir do BO
    *==========================================================================
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
                THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ;
                    THIS.this_oBusinessObject.this_cDescs
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - habilita/desabilita controles editaveis
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
            THIS.cnt_4c_Nova.txt_4c_GetNova.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - limpa campo nome e desmarca todas as selecoes da grade
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
            THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ""
        ENDIF
        IF USED("cursor_4c_Itn")
            REPLACE ALL SelImp WITH 0 IN cursor_4c_Itn
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
            THIS.grd_4c_Selecoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - sem modo CRUD neste form OPERACIONAL
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        *-- OPERACIONAL: habilita Processar somente se BO inicializado
        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = (VARTYPE(THIS.this_oBusinessObject) = "O")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - recarrega a lista de malas diretas do servidor
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - nao aplicavel (salvar ocorre via BtnProcessarClick)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - limpa selecoes e campo nome
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

ENDDEFINE
