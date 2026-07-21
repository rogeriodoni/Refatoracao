*==============================================================================
* FORMSIGPRGL2.PRG - Formulario Operacional: Operacoes Selecionadas
* Tipo: OPERACIONAL (flat popup modal 800x600, sem PageFrame)
* Migrado de SIGPRGL2.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (800x600 popup modal, TitleBar=0)
*   BD   -> TmpCabec/TmpItens (cursores VFP da datasession do pai) + SQL Server via BO
*   CODE -> arquitetura em camadas (FormBase / SigPrGl2BO)
*
* CHAMADA (a partir de form operacional pai):
*   loForm = CREATEOBJECT("FormSigPrGl2", loFormPai, loFormPai.DataSessionId,
*                          lReservaAuto, oConexao, nGerEmphPdr, lAutom, nNumeroOp)
*   loForm.Show()
*
* PARAMETROS:
*   par_oFormPai    - form pai (objeto) para re-habilitar ao encerrar
*   par_nData       - DataSessionId do form pai (compartilhamento de TmpCabec/TmpItens)
*   par_lReserva    - .T. se reserva automatica ativa
*   par_oConexao    - conexao SQL Server (Framework connection object - poDataMgr)
*   par_nEmphPdr    - empresa padrao do gerente
*   par_lAutomatico - .T. se processamento automatico
*   par_nNumeroDaOp - numero da OP a gerar (0 = novo)
*==============================================================================

DEFINE CLASS FormSigPrGl2 AS FormBase

    *-- Dimensoes originais do popup operacional (NAO escalonar para 1000)
    Height       = 600
    Width        = 800
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1
    DataSession  = 2

    *-- Referencia ao form pai (para re-habilitar ao encerrar)
    poFormPai     = .NULL.
    *-- Parametros de contexto recebidos na abertura
    plReserva     = .F.
    pnEmphPdr     = 0
    plAutomatico  = .F.
    pnNumeroDaOp  = 0
    *-- Conexao temporaria: armazenada em Init, consumida em InicializarForm
    poConexaoTemp = .NULL.

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_oFormPai, par_nData, par_lReserva, par_oConexao, ;
                    par_nEmphPdr, par_lAutomatico, par_nNumeroDaOp

        *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
        *-- tenha acesso a conexao, ao form pai e demais contextos
        IF VARTYPE(par_oFormPai) = "O"
            THIS.poFormPai = par_oFormPai
        ENDIF

        *-- Compartilhar datasession com form pai: TmpCabec/TmpItens vivem la
        IF VARTYPE(par_nData) = "N" AND par_nData > 0
            THIS.DataSessionId = par_nData
        ELSE
            IF VARTYPE(par_oFormPai) = "O"
            THIS.DataSessionId = par_oFormPai.DataSessionId
            ENDIF
        ENDIF

        THIS.plReserva     = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
        THIS.pnEmphPdr     = IIF(VARTYPE(par_nEmphPdr)    = "N", par_nEmphPdr,    0)
        THIS.plAutomatico  = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
        THIS.pnNumeroDaOp  = IIF(VARTYPE(par_nNumeroDaOp) = "N", par_nNumeroDaOp, 0)

        IF VARTYPE(par_oConexao) = "O"
            THIS.poConexaoTemp = par_oConexao
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oConexao

        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGl2BO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGl2BO", "Erro SigPrGl2")
                loc_lSucesso = .F.
            ENDIF

            *-- Configurar contexto do BO com todos os parametros recebidos
            loc_oConexao = THIS.poConexaoTemp
            THIS.this_oBusinessObject.ConfigurarContexto( ;
                THIS.poFormPai, ;
                loc_oConexao, ;
                loc_oConexao, ;
                THIS.plReserva, ;
                THIS.pnEmphPdr, ;
                THIS.plAutomatico, ;
                THIS.pnNumeroDaOp, ;
                "" ;
            )
            THIS.poConexaoTemp = .NULL.

            *-- Configurar imagem de fundo e shape decorativo do topo
            THIS.ConfigurarPageFrame()

            *-- Configurar cabecalho cinza (cntSombra do legado)
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Configurar grade de operacoes e botoes de acao
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarBotoes()

            *-- Configurar controles de detalhe (ObsOperacao, Cliente, GradeItens, ObsItens)
            THIS.ConfigurarPaginaDados()

            THIS.AlternarPagina(.T.)

            *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigPrGl2: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        LOCAL loc_cImgFundo

        *-- Form OPERACIONAL flat (sem PageFrame) - configura picture de fundo
        *-- Mesma imagem do legado: new_background.jpg
        loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Shape3 do legado: elemento decorativo no canto superior direito
        *-- Top=7, Left=732, Width=60, Height=29, BackStyle=0, BorderStyle=0
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 7
            .Left        = 732
            .Height      = 29
            .Width       = 60
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_nW

        loc_nW = THIS.Width

        *-- Container cabecalho cinza (cntSombra do legado)
        *-- Top=0, Left=0, Width=800, Height=80, BackColor=RGB(100,100,100)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            *-- Label sombra: ForeColor preto, efeito de profundidade
            *-- Top=18, Left=10, Width=769, Height=40, FontSize=18
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Width     = loc_nW - 31
                .Height    = 40
                .Top       = 18
                .Left      = 10
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH

            *-- Label titulo: branco sobre fundo cinza
            *-- Top=17, Left=10, Width=769, Height=46, FontSize=18
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Width     = loc_nW - 31
                .Height    = 46
                .Top       = 17
                .Left      = 10
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH
        ENDWITH
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LPARAMETERS par_oContainer
        LOCAL loc_oContainer, loc_i, loc_oControl

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *==========================================================================
        *-- Grade de selecao de operacoes (GradeOperacao) + botoes SelTudo/Apaga
        LOCAL loc_oErro

        TRY
            THIS.ConfigurarGradeOperacao()
            THIS.ConfigurarBotoesSelecao()

            IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                BINDEVENT(THIS.grd_4c_GradeOperacao, "AfterRowColChange", ;
                          THIS, "GrdOperacaoAfterRowColChange")
                BINDEVENT(THIS.grd_4c_GradeOperacao.Column2.Header1, "Click", ;
                          THIS, "HeaderMovimentacaoClick")
                BINDEVENT(THIS.grd_4c_GradeOperacao.Column5.Header1, "Click", ;
                          THIS, "HeaderEntregaClick")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaLista: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeOperacao
    *==========================================================================
        *-- GradeOperacao: Top=155, Left=5, Width=789, Height=156, 10 colunas
        *-- Column1 = CheckBox (Flag), Columns 2-10 = campos de TmpCabec
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_GradeOperacao", "Grid")
            WITH THIS.grd_4c_GradeOperacao
                .Top               = 155
                .Left              = 5
                .Width             = 789
                .Height            = 156
                .ColumnCount       = 10
                .FontName          = "Verdana"
                .FontSize          = 8
                .ForeColor         = RGB(90, 90, 90)
                .BackColor         = RGB(255, 255, 255)
                .GridLineColor     = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle    = 2
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 17
                .ScrollBars        = 2
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .ReadOnly          = .T.
                .Themes            = .F.

                IF USED("TmpCabec")
                    .RecordSource = "TmpCabec"
                ENDIF

                *-- Column1: CheckBox de selecao (Flag) - Width=17
                WITH .Column1
                    .Width     = 17
                    .Movable   = .F.
                    .Resizable = .F.
                    .AddObject("Check1", "CheckBox")
                    WITH .Check1
                        .Caption   = ""
                        .Value     = 0
                        .Themes    = .F.
                        .BackStyle = 0
                    ENDWITH
                    .CurrentControl = "Check1"
                    .Sparse         = .F.
                    .ReadOnly       = .F.
                    .ControlSource  = "TmpCabec.Flag"
                    .Header1.Caption   = ""
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column2: Dopes (Movimentacao) - Width=156, header verde = ord padrao
                WITH .Column2
                    .Width     = 156
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    IF USED("TmpCabec")
                        .ControlSource = "TmpCabec.Dopes"
                    ENDIF
                    .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                    .Header1.BackColor = RGB(220, 255, 220)
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column3: Numes (Numero) - Width=70
                WITH .Column3
                    .Width     = 70
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    IF USED("TmpCabec")
                        .ControlSource = "TmpCabec.Numes"
                    ENDIF
                    .Header1.Caption   = "N" + CHR(250) + "mero"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column4: Datas (Emissao) - Width=70
                WITH .Column4
                    .Width     = 70
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    IF USED("TmpCabec")
                        .ControlSource = "TmpCabec.Datas"
                    ENDIF
                    .Header1.Caption   = "Emiss" + CHR(227) + "o"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column5: Entregas - Width=70, IIF para data nula
                WITH .Column5
                    .Width     = 70
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    IF USED("TmpCabec")
                        .ControlSource = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
                    ENDIF
                    .Header1.Caption   = "Entrega"
                    .Header1.BackColor = RGB(192, 192, 192)
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column6: Peso - Width=90, InputMask numerico
                WITH .Column6
                    .Width     = 90
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .InputMask = "999,999.99"
                    IF USED("TmpCabec")
                        .ControlSource = "TmpCabec.Peso"
                    ENDIF
                    .Header1.Caption   = "Peso"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column7: Contav (Responsavel) - Width=90
                WITH .Column7
                    .Width     = 90
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    IF USED("TmpCabec")
                        .ControlSource = "TmpCabec.Contav"
                    ENDIF
                    .Header1.Caption   = "Respons" + CHR(225) + "vel"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column8: Conta (codigo do cliente) - Width=90
                *-- ORIGINAL: Column8 = TmpCabec.Conta (NAO DConta!)
                WITH .Column8
                    .Width     = 90
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    IF USED("TmpCabec")
                        .ControlSource = "TmpCabec.Conta"
                    ENDIF
                    .Header1.Caption   = "Cliente"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column9: Obs indicator (*) - Width=44, FontBold, FontSize=12
                WITH .Column9
                    .Width     = 44
                    .FontBold  = .T.
                    .FontSize  = 12
                    .Alignment = 2
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    IF USED("TmpCabec")
                        .ControlSource = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
                    ENDIF
                    .Header1.Caption   = "Obs"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column10: Notas (Doc.) - Width=52
                WITH .Column10
                    .Width     = 52
                    .Movable   = .F.
                    .Resizable = .F.
                    IF USED("TmpCabec")
                        .ControlSource = "TmpCabec.Notas"
                    ENDIF
                    .Header1.Caption   = "Doc."
                    .Header1.Alignment = 2
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarGradeOperacao: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *==========================================================================
        *-- Controles de detalhe: ObsOperacao, Cliente, GradeItens, ObsItens
        LOCAL loc_oErro

        TRY
            *-- ObsOperacao: observacao da operacao corrente (TmpCabec.Obs)
            *-- Top=82, Left=5, Width=602, Height=70 (entre header e GradeOperacao)
            THIS.AddObject("edt_4c_ObsOperacao", "EditBox")
            WITH THIS.edt_4c_ObsOperacao
                .Top         = 82
                .Left        = 5
                .Width       = 602
                .Height      = 70
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .ReadOnly    = .T.
                .ScrollBars  = 2
                .BorderStyle = 1
                IF USED("TmpCabec")
                    .ControlSource = "TmpCabec.Obs"
                ENDIF
            ENDWITH

            *-- Label "Cliente :" (Label6 do legado)
            *-- Top=317, Left=5, Width=42, Height=15, AutoSize=.T.
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .Top       = 317
                .Left      = 5
                .Width     = 42
                .Height    = 15
                .AutoSize  = .T.
                .Caption   = "Cliente :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH

            *-- getCliente: nome do cliente da operacao corrente (TmpCabec.DConta)
            *-- fwget no legado = display-only (When retorna .F.)
            *-- Top=313, Left=59, Width=345, Height=23, SpecialEffect=1
            THIS.AddObject("txt_4c_Cliente", "TextBox")
            WITH THIS.txt_4c_Cliente
                .Top           = 313
                .Left          = 59
                .Width         = 345
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .ReadOnly      = .T.
                .SpecialEffect = 1
                IF USED("TmpCabec")
                    .ControlSource = "TmpCabec.DConta"
                ENDIF
            ENDWITH

            *-- Grade de itens da operacao corrente (GradeItens do legado)
            THIS.ConfigurarGradeItens()

            *-- Label "Observacao do Item : " (Txt_ObsItens do legado)
            *-- Top=532, Left=5, Width=146, Height=15, FontBold=.T., FontName=Verdana
            THIS.AddObject("lbl_4c_TxtObsItens", "Label")
            WITH THIS.lbl_4c_TxtObsItens
                .Top       = 532
                .Left      = 5
                .Width     = 146
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
            ENDWITH

            *-- ObsItens: observacao do item corrente (TmpItens.Obs)
            *-- Top=548, Left=5, Width=737, Height=47
            THIS.AddObject("edt_4c_ObsItens", "EditBox")
            WITH THIS.edt_4c_ObsItens
                .Top         = 548
                .Left        = 5
                .Width       = 737
                .Height      = 47
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .ReadOnly    = .T.
                .ScrollBars  = 2
                .BorderStyle = 1
                IF USED("TmpItens")
                    .ControlSource = "TmpItens.Obs"
                ENDIF
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeItens
    *==========================================================================
        *-- GradeItens: Top=339, Left=5, Width=737, Height=191, 8 colunas
        *-- Exibe itens (TmpItens) filtrados pela operacao corrente de TmpCabec
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_GradeItens", "Grid")
            WITH THIS.grd_4c_GradeItens
                .Top               = 339
                .Left              = 5
                .Width             = 737
                .Height            = 191
                .ColumnCount       = 8
                .FontName          = "Verdana"
                .FontSize          = 8
                .ForeColor         = RGB(90, 90, 90)
                .BackColor         = RGB(255, 255, 255)
                .GridLineColor     = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle    = 2
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 17
                .ScrollBars        = 2
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .ReadOnly          = .T.
                .Themes            = .F.

                IF USED("TmpItens")
                    .RecordSource = "TmpItens"
                ENDIF

                *-- Column1: Cpros (Produto) - Width=120, ColumnOrder=1
                WITH .Column1
                    .Width     = 120
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    IF USED("TmpItens")
                        .ControlSource = "TmpItens.Cpros"
                    ENDIF
                    .Header1.Caption   = "Produto"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column2: Qtds (Quantidade) - Width=90, ColumnOrder=5
                WITH .Column2
                    .Width       = 90
                    .ColumnOrder = 5
                    .Movable     = .F.
                    .Resizable   = .F.
                    .ReadOnly    = .T.
                    IF USED("TmpItens")
                        .ControlSource = "TmpItens.Qtds"
                    ENDIF
                    .Header1.Caption   = "Quantidade"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column3: Saldo (Saldo) - Width=118, ColumnOrder=6
                WITH .Column3
                    .Width       = 118
                    .ColumnOrder = 6
                    .Movable     = .F.
                    .Resizable   = .F.
                    .ReadOnly    = .T.
                    IF USED("TmpItens")
                        .ControlSource = "TmpItens.Saldo"
                    ENDIF
                    .Header1.Caption   = "Saldo"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column4: Peso (Peso) - Width=100, ColumnOrder=7
                WITH .Column4
                    .Width       = 100
                    .ColumnOrder = 7
                    .Movable     = .F.
                    .Resizable   = .F.
                    .ReadOnly    = .T.
                    IF USED("TmpItens")
                        .ControlSource = "TmpItens.Peso"
                    ENDIF
                    .Header1.Caption   = "Peso"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column5: Obs indicator (*) - Width=44, FontBold, ColumnOrder=8
                WITH .Column5
                    .Width       = 44
                    .ColumnOrder = 8
                    .FontBold    = .T.
                    .FontSize    = 12
                    .Alignment   = 2
                    .Movable     = .F.
                    .Resizable   = .F.
                    .ReadOnly    = .T.
                    IF USED("TmpItens")
                        .ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
                    ENDIF
                    .Header1.Caption   = "Obs"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column6: CodCors (Cor) - Width=38, ColumnOrder=3
                WITH .Column6
                    .Width       = 38
                    .ColumnOrder = 3
                    .Movable     = .F.
                    .Resizable   = .F.
                    .ReadOnly    = .T.
                    IF USED("TmpItens")
                        .ControlSource = "TmpItens.CodCors"
                    ENDIF
                    .Header1.Caption   = "Cor"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column7: CodTams (Tam) - Width=38, ColumnOrder=4
                WITH .Column7
                    .Width       = 38
                    .ColumnOrder = 4
                    .Movable     = .F.
                    .Resizable   = .F.
                    .ReadOnly    = .T.
                    IF USED("TmpItens")
                        .ControlSource = "TmpItens.CodTams"
                    ENDIF
                    .Header1.Caption   = "Tam"
                    .Header1.Alignment = 2
                    .Header1.FontName  = "Verdana"
                    .Header1.FontSize  = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH

                *-- Column8: Reffs (Ref. Fornecedor) - Width=150, ColumnOrder=2
                WITH .Column8
                    .Width       = 150
                    .ColumnOrder = 2
                    .Movable     = .F.
                    .Resizable   = .F.
                    .ReadOnly    = .T.
                    IF USED("TmpItens")
                        .ControlSource = "TmpItens.Reffs"
                    ENDIF
                    .Header1.Caption   = "Ref. Fornecedor"
                    .Header1.Alignment = 2
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.grd_4c_GradeItens, "AfterRowColChange", ;
                      THIS, "GrdItensAfterRowColChange")

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarGradeItens: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesSelecao
    *==========================================================================
        *-- cmd_4c_SelTudo (Top=400) e cmd_4c_Apaga (Top=358) ao lado de GradeItens
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cmd_4c_Apaga
                .Top             = 358
                .Left            = 748
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .ToolTipText     = "Desmarcar Todos"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .FontName        = "Tahoma"
                .FontSize        = 8
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")

            THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH THIS.cmd_4c_SelTudo
                .Top             = 400
                .Left            = 748
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .ToolTipText     = "Selecionar Todos"
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .FontName        = "Tahoma"
                .FontSize        = 8
            ENDWITH
            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarBotoesSelecao: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        *-- cmd_4c_Processar (Left=648, Top=3) e cmd_4c_Cancelar (Left=723, Top=3)
        *-- Equivalentes aos botoes Processar/Encerrar do legado SIGPRGL2
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Processar", "CommandButton")
            WITH THIS.cmd_4c_Processar
                .Top             = 3
                .Left            = 648
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Processar"
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")

            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top             = 3
                .Left            = 723
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "CmdCancelarClick")

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarBotoes: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina
    *==========================================================================
        *-- Aplica ordenacao atual em TmpCabec e atualiza BackColor dos headers
        *-- par_lTipo=.T. = atualizar visual dos headers alem de ordenar
        LPARAMETERS par_lTipo
        LOCAL loc_nRGB2, loc_nRGB5, loc_oErro

        TRY
            THIS.this_oBusinessObject.OrdenarGrade()

            IF VARTYPE(par_lTipo) = "L" AND par_lTipo
                loc_nRGB2 = RGB(192, 192, 192)
                loc_nRGB5 = RGB(192, 192, 192)

                DO CASE
                    CASE UPPER(THIS.this_oBusinessObject.this_cOrdConta) = "EMPDOPNUM"
                        loc_nRGB2 = RGB(220, 255, 220)
                    CASE UPPER(THIS.this_oBusinessObject.this_cOrdConta) = "ENTREGA"
                        loc_nRGB5 = RGB(220, 255, 220)
                ENDCASE

                IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                    WITH THIS.grd_4c_GradeOperacao
                        .Column2.Header1.BackColor = loc_nRGB2
                        .Column5.Header1.BackColor = loc_nRGB5
                        .Refresh()
                    ENDWITH
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE GrdOperacaoAfterRowColChange
    *==========================================================================
        *-- Filtra TmpItens para linha corrente de TmpCabec e atualiza controles
        LPARAMETERS par_nColIndex
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.SincronizarItens()

            IF VARTYPE(THIS.txt_4c_Cliente) = "O"
                THIS.txt_4c_Cliente.Refresh()
            ENDIF
            IF VARTYPE(THIS.edt_4c_ObsOperacao) = "O"
                THIS.edt_4c_ObsOperacao.Refresh()
            ENDIF
            IF VARTYPE(THIS.grd_4c_GradeItens) = "O"
                THIS.grd_4c_GradeItens.Refresh()
            ENDIF
            IF VARTYPE(THIS.edt_4c_ObsItens) = "O"
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em GrdOperacaoAfterRowColChange: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE HeaderMovimentacaoClick
    *==========================================================================
        *-- Ordena TmpCabec por EmpDopNum e atualiza BackColor dos headers
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.DefinirOrdemMovimentacao()
                IF USED("TmpCabec")
                    GO TOP IN TmpCabec
                ENDIF
                IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                    WITH THIS.grd_4c_GradeOperacao
                        .Column2.Header1.BackColor = RGB(220, 255, 220)
                        .Column5.Header1.BackColor = RGB(192, 192, 192)
                        .Refresh()
                    ENDWITH
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em HeaderMovimentacaoClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE HeaderEntregaClick
    *==========================================================================
        *-- Ordena TmpCabec por Entrega e atualiza BackColor dos headers
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.DefinirOrdemEntrega()
                IF USED("TmpCabec")
                    GO TOP IN TmpCabec
                ENDIF
                IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                    WITH THIS.grd_4c_GradeOperacao
                        .Column2.Header1.BackColor = RGB(192, 192, 192)
                        .Column5.Header1.BackColor = RGB(220, 255, 220)
                        .Refresh()
                    ENDWITH
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em HeaderEntregaClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdProcessarClick
    *==========================================================================
        *-- Processa operacoes selecionadas (Flag=.T.) via BO e fecha o form
        LOCAL loc_oErro, loc_lProsseguir

        loc_lProsseguir = .T.

        TRY
            IF !USED("TmpCabec") OR RECCOUNT("TmpCabec") = 0
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o dispon" + ;
                         CHR(237) + "vel para processar.", "Aviso")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.ProcessarOperacoes()
                    THIS.Release()
                ELSE
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao processar opera" + CHR(231) + CHR(245) + "es: " + ;
                    loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdCancelarClick
    *==========================================================================
        *-- Re-habilita form pai e fecha este form (sem processar)
        LOCAL loc_oErro

        TRY
            THIS.Release()

        CATCH TO loc_oErro
            MsgErro("Erro em CmdCancelarClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdSelTudoClick
    *==========================================================================
        *-- Marca Flag=.T. em todos os registros de TmpCabec e atualiza grid
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.SelecionarTodos()
            IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                THIS.grd_4c_GradeOperacao.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CmdSelTudoClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdApagaClick
    *==========================================================================
        *-- Marca Flag=.F. em todos os registros de TmpCabec e atualiza grid
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.DesmarcarTodos()
            IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                THIS.grd_4c_GradeOperacao.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CmdApagaClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE GrdItensAfterRowColChange
    *==========================================================================
        *-- Atualiza ObsItens ao navegar na grade de itens
        LPARAMETERS par_nColIndex
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.edt_4c_ObsItens) = "O"
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em GrdItensAfterRowColChange: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE Activate
    *==========================================================================
        *-- Legado SIGPRGL2.Activate: mOrdemConta(.T.) + GradeOperacao.Refresh
        *-- Re-aplica ordenacao e atualiza visual dos headers ao form ganhar foco
        LOCAL loc_oErro

        TRY
            THIS.AlternarPagina(.T.)
            IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                THIS.grd_4c_GradeOperacao.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Activate: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick
    *==========================================================================
        *-- OPERACIONAL: "Incluir na selecao" = marcar todas operacoes (Flag=.T.)
        *-- Delegado a CmdSelTudoClick, que replica logica do legado SelTudo.Click:
        *--   Replace all Flag With .t. In TmpCabec + GradeOperacao.Refresh
        LOCAL loc_oErro

        TRY
            THIS.CmdSelTudoClick()

        CATCH TO loc_oErro
            MsgErro("Erro em BtnIncluirClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick
    *==========================================================================
        *-- OPERACIONAL: "Alterar" = alternar ordenacao da grade entre
        *-- EmpDopNum (Movimentacao) e Entrega, replicando o toggle do legado
        *-- Headers Click. Aplica ordem oposta a atual + atualiza BackColors.
        LOCAL loc_oErro, loc_cOrdemAtual

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            loc_cOrdemAtual = UPPER(NVL(THIS.this_oBusinessObject.this_cOrdConta, ""))

            DO CASE
                CASE loc_cOrdemAtual = "EMPDOPNUM"
                    THIS.HeaderEntregaClick()
                CASE loc_cOrdemAtual = "ENTREGA"
                    THIS.HeaderMovimentacaoClick()
                OTHERWISE
                    THIS.HeaderMovimentacaoClick()
            ENDCASE

        CATCH TO loc_oErro
            MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick
    *==========================================================================
        *-- OPERACIONAL: "Visualizar" = re-sincronizar visualizacao completa.
        *-- Re-aplica ordenacao (AlternarPagina) + re-sincroniza itens da
        *-- operacao corrente (SincronizarItens) + refresh de todos os controles
        *-- de detalhe (Cliente/ObsOperacao/GradeItens/ObsItens).
        LOCAL loc_oErro

        TRY
            THIS.AlternarPagina(.T.)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.SincronizarItens()
            ENDIF

            IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                THIS.grd_4c_GradeOperacao.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Cliente) = "O"
                THIS.txt_4c_Cliente.Refresh()
            ENDIF
            IF VARTYPE(THIS.edt_4c_ObsOperacao) = "O"
                THIS.edt_4c_ObsOperacao.Refresh()
            ENDIF
            IF VARTYPE(THIS.grd_4c_GradeItens) = "O"
                THIS.grd_4c_GradeItens.Refresh()
            ENDIF
            IF VARTYPE(THIS.edt_4c_ObsItens) = "O"
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick
    *==========================================================================
        *-- OPERACIONAL: "Excluir da selecao" = desmarcar todas as operacoes
        *-- (Flag=.F.). Delegado a CmdApagaClick, que replica logica do legado
        *-- apaga.Click: Replace all Flag With .f. In TmpCabec + Refresh.
        LOCAL loc_oErro

        TRY
            THIS.CmdApagaClick()

        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista
    *==========================================================================
        *-- Re-aplica ordenacao e atualiza grid de operacoes
        *-- Equivalente ao ciclo Activate do legado: mOrdemConta(.T.) + Refresh
        LOCAL loc_oErro, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.AlternarPagina(.T.)
            IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                THIS.grd_4c_GradeOperacao.Refresh()
            ENDIF
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
    *==========================================================================
        *-- Form OPERACIONAL nao tem modos CRUD (INCLUIR/ALTERAR/VISUALIZAR)
        *-- Botoes Processar/Encerrar/SelTudo/Apaga permanecem sempre habilitados
        *-- Exceto se o cursor TmpCabec estiver vazio: desabilitar Processar
        LOCAL loc_lTemRegistros

        IF USED("TmpCabec")
            loc_lTemRegistros = RECCOUNT("TmpCabec") > 0
        ELSE
            loc_lTemRegistros = .F.
        ENDIF

        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = loc_lTemRegistros
        ENDIF
        IF VARTYPE(THIS.cmd_4c_SelTudo) = "O"
            THIS.cmd_4c_SelTudo.Enabled = loc_lTemRegistros
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Apaga) = "O"
            THIS.cmd_4c_Apaga.Enabled = loc_lTemRegistros
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
    *==========================================================================
        *-- Form OPERACIONAL: campos do form mapeiam estado de selecao/contexto
        *-- O cursor TmpCabec e gerenciado diretamente pelo BO via datasession
        *-- Esta procedure sincroniza o registro corrente do cursor com o BO
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !USED("TmpCabec") OR RECCOUNT("TmpCabec") = 0
                loc_lSucesso = .F.
            ENDIF

            SELECT TmpCabec
            THIS.this_oBusinessObject.this_lFlag    = TmpCabec.Flag
            THIS.this_oBusinessObject.this_cEmps    = NVL(TmpCabec.Emps,  "")
            THIS.this_oBusinessObject.this_cDopes   = ALLTRIM(NVL(TmpCabec.Dopes, ""))
            THIS.this_oBusinessObject.this_nNumes   = NVL(TmpCabec.Numes, 0)
            THIS.this_oBusinessObject.this_dDatas   = NVL(TmpCabec.Datas, {})
            THIS.this_oBusinessObject.this_dEntregas = NVL(TmpCabec.Entregas, {})
            THIS.this_oBusinessObject.this_nPeso    = NVL(TmpCabec.Peso,  0)
            THIS.this_oBusinessObject.this_cContav  = ALLTRIM(NVL(TmpCabec.Contav, ""))
            THIS.this_oBusinessObject.this_cConta   = ALLTRIM(NVL(TmpCabec.Conta,  ""))
            THIS.this_oBusinessObject.this_cDConta  = ALLTRIM(NVL(TmpCabec.DConta, ""))
            THIS.this_oBusinessObject.this_cObs     = ALLTRIM(NVL(TmpCabec.Obs,    ""))
            THIS.this_oBusinessObject.this_cNotas   = ALLTRIM(NVL(TmpCabec.Notas,  ""))
            THIS.this_oBusinessObject.this_cJobs    = ALLTRIM(NVL(TmpCabec.Jobs,   ""))

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
    *==========================================================================
        *-- Form OPERACIONAL: atualiza display dos controles de detalhe
        *-- com base no estado atual do cursor TmpCabec/TmpItens
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.txt_4c_Cliente) = "O"
                THIS.txt_4c_Cliente.Refresh()
            ENDIF
            IF VARTYPE(THIS.edt_4c_ObsOperacao) = "O"
                THIS.edt_4c_ObsOperacao.Refresh()
            ENDIF
            IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                THIS.grd_4c_GradeOperacao.Refresh()
            ENDIF
            IF VARTYPE(THIS.grd_4c_GradeItens) = "O"
                THIS.grd_4c_GradeItens.Refresh()
            ENDIF
            IF VARTYPE(THIS.edt_4c_ObsItens) = "O"
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos
    *==========================================================================
        *-- Form OPERACIONAL: grids sao sempre ReadOnly (display-only)
        *-- Apenas o CheckBox da Column1 de grd_4c_GradeOperacao aceita edicao
        *-- Nao ha controles de edicao direta (campos de texto editaveis)
        LPARAMETERS par_lHabilitar
        LOCAL loc_lHabilitar, loc_oErro

        IF VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ELSE
            loc_lHabilitar = .T.
        ENDIF

        TRY
            *-- Column1 do grid de operacoes (CheckBox Flag): editavel quando habilitado
            IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
                THIS.grd_4c_GradeOperacao.Column1.ReadOnly = !loc_lHabilitar
            ENDIF
            *-- Botoes de acao
            IF VARTYPE(THIS.cmd_4c_Processar) = "O"
                THIS.cmd_4c_Processar.Enabled = loc_lHabilitar
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
    *==========================================================================
        *-- Form OPERACIONAL: "limpar" = desmarcar todas as operacoes (Flag=.F.)
        *-- e posicionar grid no primeiro registro
        LOCAL loc_oErro

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .F. IN TmpCabec
                GO TOP IN TmpCabec
            ENDIF
            IF USED("TmpItens")
                SELECT TmpItens
                SET KEY TO
                GO TOP
            ENDIF
            THIS.BOParaForm()

        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick
    *==========================================================================
        *-- OPERACIONAL: "Buscar" = re-carregar/sincronizar visualizacao
        *-- Aplica ordenacao atual e atualiza todos os controles de detalhe
        LOCAL loc_oErro

        TRY
            THIS.CarregarLista()
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.SincronizarItens()
            ENDIF
            THIS.BOParaForm()

        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick
    *==========================================================================
        *-- Encerrar form sem processar (mesmo que CmdCancelarClick/Cancelar.Click)
        LOCAL loc_oErro

        TRY
            THIS.CmdCancelarClick()

        CATCH TO loc_oErro
            MsgErro("Erro em BtnEncerrarClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick
    *==========================================================================
        *-- OPERACIONAL: "Salvar" = Processar operacoes selecionadas
        *-- Delega a CmdProcessarClick (Processar.Click do legado)
        LOCAL loc_oErro

        TRY
            THIS.CmdProcessarClick()

        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick
    *==========================================================================
        *-- Cancelar/encerrar form sem processar
        LOCAL loc_oErro

        TRY
            THIS.CmdCancelarClick()

        CATCH TO loc_oErro
            MsgErro("Erro em BtnCancelarClick: " + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        *-- Re-habilitar form pai ao fechar
        IF VARTYPE(THIS.poFormPai) = "O"
            THIS.poFormPai.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.poFormPai     = .NULL.
        THIS.poConexaoTemp = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
