*==============================================================================*
* FormSigPrGlp.prg - Formulario Operacional: Previa da Globalizacao
*==============================================================================*
* Tipo: OPERACIONAL (layout customizado com containers e multiplos grids)
* Migrado de SIGPRGLP.SCX
*
* Pilares:
*   UX   -> layout e comportamento identicos ao legado (1000x600)
*   BD   -> cursores TmpFinal/TmpSaldo/TmpSaldG compartilhados via datasession pai
*   CODE -> arquitetura em camadas (FormBase / SigPrGlpBO)
*
* CHAMADA:
*   loForm = CREATEOBJECT("FormSigPrGlp", loFormPai, dData, lReserva, nEmphPdr, lAutom, nNumeroOp)
*   loForm.Show()
*==============================================================================*

DEFINE CLASS FormSigPrGlp AS FormBase

    *-- Dimensoes identicas ao legado
    Height       = 600
    Width        = 1000
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    DataSession  = 2
    WindowState  = 0
    KeyPreview   = .T.
    ShowTips     = .T.

    *-- Referencia ao form pai (datasession compartilhada)
    poFormPai        = .NULL.
    *-- Flags operacionais
    this_lReserva    = .F.
    this_lAutomatico = .F.
    this_nNumeroDaOp = 0
    this_nEmphPdr    = 0
    this_dData       = {}
    *-- Controle de edicao na coluna Produzir
    this_nOldValue   = 0

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_loFormPai, par_dData, par_lReservaAuto, par_nEmphPdr, par_lAutom, par_nNumeroOp

        IF VARTYPE(par_loFormPai) = "O"
            THIS.poFormPai     = par_loFormPai
            THIS.DataSessionId = par_loFormPai.DataSessionId
        ENDIF

        THIS.this_lReserva    = IIF(VARTYPE(par_lReservaAuto)="L", par_lReservaAuto, .F.)
        THIS.this_nEmphPdr    = IIF(VARTYPE(par_nEmphPdr)="N",    par_nEmphPdr,    0)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)="L",      par_lAutom,      .F.)
        THIS.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroOp)="N",   par_nNumeroOp,   0)
        THIS.this_dData       = IIF(VARTYPE(par_dData)="D",       par_dData,       DATE())

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_nSal, loc_nEst, loc_nPrz
        loc_lSucesso = .F.
        loc_nSal     = 0
        loc_nEst     = 0
        loc_nPrz     = 0

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGlpBO", "Erro")
            ELSE
                WITH THIS.this_oBusinessObject
                    .this_lReserva    = THIS.this_lReserva
                    .this_lAutomatico = THIS.this_lAutomatico
                    .this_nNumeroDaOp = THIS.this_nNumeroDaOp
                    .this_nEmphPdr    = THIS.this_nEmphPdr
                    .this_dData       = THIS.this_dData
                    IF USED("CrSigCdPac")
                        SELECT CrSigCdPac
                        .this_cSigKey = TratarNulo(CrSigCdPac.sigKeys, "C")
                    ENDIF
                ENDWITH

                IF THIS.this_lReserva
                    THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
                ELSE
                    THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
                ENDIF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.this_oBusinessObject.InicializarConexaoTemp()
                THIS.this_oBusinessObject.CarregarParametros()
                THIS.this_oBusinessObject.CarregarComposicao()
                THIS.this_oBusinessObject.InicializarTmpSaldU()

                IF USED("SelPedra")
                    SELECT SelPedra
                    IF RECCOUNT() = 0
                        APPEND BLANK
                    ENDIF
                ENDIF

                THIS.ConfigurarLayout()
                THIS.CarregarDados()
                THIS.TornarControlesVisiveis()

                *-- Estado inicial do botao Pedras
                THIS.cmd_4c_Pedras.Enabled = .F.
                IF USED("crSigCdPam")
                    SELECT crSigCdPam
                    IF !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
                       !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
                       !THIS.this_lReserva
                        THIS.cmd_4c_Pedras.Enabled = .T.
                    ENDIF
                ENDIF

                IF USED("TmpFinal")
                    SELECT TmpFinal
                    SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                    GO TOP
                    THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                    THIS.txt_4c_Tot_Est.Value = loc_nEst
                    THIS.txt_4c_Tot_Prz.Value = loc_nPrz
                ENDIF

                THIS.Refresh
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigPrGlp: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
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
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = " "
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = " "
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLayout
    *==========================================================================
        LOCAL loc_cImgProcessar, loc_cImgCancelar, loc_cImgRelatorio
        LOCAL loc_cImgDisp, loc_cImgLinhas, loc_cImgPedras, loc_cImgEstoque

        loc_cImgProcessar  = gc_4c_CaminhoIcones + "geral_executar_60.jpg"
        loc_cImgCancelar   = gc_4c_CaminhoIcones + "cadastro_encerrar_60.jpg"
        loc_cImgRelatorio  = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
        loc_cImgDisp       = gc_4c_CaminhoIcones + "geral_pesquisar_60.jpg"
        loc_cImgLinhas     = gc_4c_CaminhoIcones + "geral_lista_60.jpg"
        loc_cImgPedras     = gc_4c_CaminhoIcones + "geral_adicionar_60.jpg"
        loc_cImgEstoque    = gc_4c_CaminhoIcones + "geral_estoque_60.jpg"

        *-- Botao Disponiveis (622,3,75,75)
        THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
        WITH THIS.cmd_4c_Disponivel
            .Top         = 3
            .Left        = 622
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Dispon" + CHR(237) + "veis"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgDisp)
                .Picture         = loc_cImgDisp
                .DisabledPicture = loc_cImgDisp
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Disponivel, "Click", THIS, "BtnDisponiveiClick")

        *-- Botao Total/Linhas (697,3,75,75)
        THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
        WITH THIS.cmd_4c_TotLinha
            .Top         = 3
            .Left        = 697
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Total/Linhas"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgLinhas)
                .Picture         = loc_cImgLinhas
                .DisabledPicture = loc_cImgLinhas
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")

        *-- Botao Pedras/Requisicoes (472,3,75,75)
        THIS.AddObject("cmd_4c_Pedras", "CommandButton")
        WITH THIS.cmd_4c_Pedras
            .Top         = 3
            .Left        = 472
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Requisi" + CHR(231) + CHR(245) + "es"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgPedras)
                .Picture         = loc_cImgPedras
                .DisabledPicture = loc_cImgPedras
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")

        *-- Botao SelEstoque (547,3,75,75)
        THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
        WITH THIS.cmd_4c_SelEstoque
            .Top         = 3
            .Left        = 547
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Estoques"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Enabled     = .F.
            IF FILE(loc_cImgEstoque)
                .Picture         = loc_cImgEstoque
                .DisabledPicture = loc_cImgEstoque
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")

        *-- Botao Relatorio (772,3,75,75)
        THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
        WITH THIS.cmd_4c_BtnRelatorio
            .Top         = 3
            .Left        = 772
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Relat" + CHR(243) + "rio"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgRelatorio)
                .Picture         = loc_cImgRelatorio
                .DisabledPicture = loc_cImgRelatorio
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")

        *-- Botao Processar (847,3,75,75)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top         = 3
            .Left        = 847
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Processar"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgProcessar)
                .Picture         = loc_cImgProcessar
                .DisabledPicture = loc_cImgProcessar
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Sair/Cancelar (922,3,75,75)
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top         = 3
            .Left        = 922
            .Width       = 75
            .Height      = 75
            .Caption     = "Encerrar"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            IF FILE(loc_cImgCancelar)
                .Picture         = loc_cImgCancelar
                .DisabledPicture = loc_cImgCancelar
            ENDIF
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Grid principal GradeItens (Top=125, Left=11, Width=708, Height=224, 9 colunas)
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top              = 125
            .Left             = 11
            .Width            = 708
            .Height           = 224
            .ColumnCount      = 9
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .RowHeight         = 16
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .FontSize          = 8
            *-- Col1: Produto
            WITH .Column1
                .Width          = 80
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Produto"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col2: Cor
            WITH .Column2
                .Width          = 40
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Cor"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col3: Movimentacao (Dopes)
            WITH .Column3
                .Width          = 80
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col4: Codigo (Numes)
            WITH .Column4
                .Width          = 55
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "C" + CHR(243) + "digo"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col5: Quantidade (Saldo)
            WITH .Column5
                .Width          = 70
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Quantidade"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col6: Produzir (editavel)
            WITH .Column6
                .Width          = 70
                .ReadOnly       = .F.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Produzir"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.FontBold = .T.
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
                .Text1.FontBold    = .T.
                .Text1.BorderStyle = 0
                .Text1.Alignment   = 3
            ENDWITH
            *-- Col7: Estoque
            WITH .Column7
                .Width          = 70
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Estoque"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col8: Obs
            WITH .Column8
                .Width          = 30
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Obs"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
            *-- Col9: Tam
            WITH .Column9
                .Width          = 30
                .ReadOnly       = .T.
                .Movable        = .F.
                .Resizable      = .F.
                .Header1.Caption = "Tam"
                .Header1.FontName = "Verdana"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "When",      THIS, "GrdCol6TextWhen")
        BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "Valid",     THIS, "GrdCol6TextValid")
        BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "KeyPress", THIS, "GrdCol6TextLostFocus")
        *-- Redirecionar foco das colunas somente-leitura para Column6 (editavel)
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "GrdColXGotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus", THIS, "GrdColXGotFocus")

        *-- Totais abaixo do grid (349,417-662)
        THIS.AddObject("txt_4c_Tot_Qtd", "TextBox")
        WITH THIS.txt_4c_Tot_Qtd
            .Top          = 349
            .Left         = 417
            .Width        = 80
            .Height       = 23
            .ReadOnly     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .SpecialEffect = 1
            .Value        = 0
        ENDWITH

        THIS.AddObject("txt_4c_Tot_Est", "TextBox")
        WITH THIS.txt_4c_Tot_Est
            .Top          = 349
            .Left         = 498
            .Width        = 81
            .Height       = 23
            .ReadOnly     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .SpecialEffect = 1
            .Value        = 0
        ENDWITH

        THIS.AddObject("txt_4c_Tot_Prz", "TextBox")
        WITH THIS.txt_4c_Tot_Prz
            .Top          = 349
            .Left         = 580
            .Width        = 82
            .Height       = 23
            .ReadOnly     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .SpecialEffect = 1
            .Value        = 0
        ENDWITH

        *-- Label para observacao (726,369)
        THIS.AddObject("lbl_4c_Txt_ObsItens", "Label")
        WITH THIS.lbl_4c_Txt_ObsItens
            .Top       = 369
            .Left      = 726
            .Width     = 134
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
        ENDWITH

        *-- EditBox observacoes (732,361,266,205)
        THIS.AddObject("obj_4c_ObsItens", "EditBox")
        WITH THIS.obj_4c_ObsItens
            .Top       = 361
            .Left      = 732
            .Width     = 266
            .Height    = 205
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Imagem produto (726,125,266,204)
        THIS.AddObject("img_4c_ImgFigJpg", "Image")
        WITH THIS.img_4c_ImgFigJpg
            .Top     = 125
            .Left    = 726
            .Width   = 266
            .Height  = 204
            .Visible = .F.
        ENDWITH

        *-- Container3: saldo/estoque (sempre visivel, Top=373, Left=12, Width=708, Height=205)
        THIS.AddObject("cnt_4c_Container3", "Container")
        WITH THIS.cnt_4c_Container3
            .Top           = 373
            .Left          = 12
            .Width         = 708
            .Height        = 205
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .BorderWidth   = 1
            .Visible       = .T.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 5
                .Left      = 6
                .Width     = 118
                .Height    = 16
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top              = 24
                .Left             = 6
                .Width            = 444
                .Height           = 148
                .ColumnCount      = 6
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ScrollBars        = 2
                .RowHeight         = 16
                .GridLineColor     = RGB(238, 238, 238)
                .FontSize          = 8
                WITH .Column1
                    .Width = 70
                    .ReadOnly = .T.
                    .Header1.Caption = "Grupo"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 70
                    .ReadOnly = .T.
                    .Header1.Caption = "Conta"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 60
                    .ReadOnly = .T.
                    .Header1.Caption = "Atual"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 60
                    .ReadOnly = .T.
                    .Header1.Caption = "Utilizado"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column5
                    .Width = 60
                    .ReadOnly = .T.
                    .Header1.Caption = "Dispon" + CHR(237) + "vel"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column6
                    .Width = 50
                    .ReadOnly = .T.
                    .Header1.Caption = "Emp"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            .AddObject("txt_4c__dgrupo", "TextBox")
            WITH .txt_4c__dgrupo
                .Top          = 106
                .Left         = 454
                .Width        = 247
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
            ENDWITH

            .AddObject("txt_4c__dconta", "TextBox")
            WITH .txt_4c__dconta
                .Top          = 147
                .Left         = 454
                .Width        = 247
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
            ENDWITH

            .AddObject("txt_4c_Tot_Qtd", "TextBox")
            WITH .txt_4c_Tot_Qtd
                .Top          = 173
                .Left         = 188
                .Width        = 80
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
                .Value        = 0
            ENDWITH

            .AddObject("txt_4c_Tot_Est", "TextBox")
            WITH .txt_4c_Tot_Est
                .Top          = 173
                .Left         = 269
                .Width        = 80
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
                .Value        = 0
            ENDWITH

            .AddObject("txt_4c_Tot_Prz", "TextBox")
            WITH .txt_4c_Tot_Prz
                .Top          = 173
                .Left         = 350
                .Width        = 80
                .Height       = 23
                .ReadOnly     = .T.
                .SpecialEffect = 1
                .FontSize     = 8
                .Value        = 0
            ENDWITH

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top = 90
                .Left = 454
                .Width = 36
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .Caption = "Grupo"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("lbl_4c_Label3", "Label")
            WITH .lbl_4c_Label3
                .Top = 131
                .Left = 454
                .Width = 35
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .Caption = "Conta"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container3.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt3GradeAfterRowColChange")

        *-- Container1: totais por linha (Visible=.F., sobreposicao)
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top           = 125
            .Left          = 12
            .Width         = 708
            .Height        = 465
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .SpecialEffect = 0
            .Visible       = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top = 10
                .Left = 259
                .Width = 170
                .Height = 18
                .AutoSize = .F.
                .BackStyle = 0
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 10
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Pe" + CHR(231) + "as a produzir por linha"
            ENDWITH

            .AddObject("cmd_4c_CancelaLin", "CommandButton")
            WITH .cmd_4c_CancelaLin
                .Top = 3
                .Left = 620
                .Width = 75
                .Height = 75
                .Caption = "OK"
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top = 32
                .Left = 174
                .Width = 359
                .Height = 420
                .ColumnCount = 4
                .AllowHeaderSizing = .F.
                .AllowRowSizing = .F.
                .DeleteMark = .F.
                .RecordMark = .F.
                .ScrollBars = 2
                .RowHeight = 16
                .FontSize = 8
                WITH .Column1
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Linha"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Quantidade"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Estoque"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Produzir"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLin1Click")

        *-- Container2: disponivel por produto/cor/tam (Visible=.F.)
        THIS.AddObject("cnt_4c_Container2", "Container")
        WITH THIS.cnt_4c_Container2
            .Top = 125
            .Left = 12
            .Width = 708
            .Height = 465
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .SpecialEffect = 0
            .Visible = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top = 10
                .Left = 284
                .Width = 123
                .Height = 18
                .AutoSize = .F.
                .BackStyle = 0
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 10
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Estoque Dispon" + CHR(237) + "vel"
            ENDWITH

            .AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH .cmd_4c_CancelaDisp
                .Top = 3
                .Left = 620
                .Width = 75
                .Height = 75
                .Caption = "Sair"
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top = 32
                .Left = 169
                .Width = 370
                .Height = 388
                .ColumnCount = 5
                .AllowHeaderSizing = .F.
                .AllowRowSizing = .F.
                .DeleteMark = .F.
                .RecordMark = .F.
                .ScrollBars = 2
                .RowHeight = 16
                .FontSize = 8
                WITH .Column1
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Produto"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 38
                    .ReadOnly = .T.
                    .Header1.Caption = "Cor"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 24
                    .ReadOnly = .T.
                    .Header1.Caption = "Tam"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 75
                    .ReadOnly = .T.
                    .Header1.Caption = "Disponivel"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column5
                    .Width = 75
                    .ReadOnly = .F.
                    .Header1.Caption = "Utilizar"
                    .Header1.FontName = "Verdana"
                    .Header1.FontBold = .T.
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                    .Text1.FontBold = .T.
                    .Text1.BorderStyle = 0
                    .Text1.Alignment = 3
                    .Text1.Value = 0
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt2Col5TextValid")

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top = 432
                .Left = 168
                .Width = 84
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Qtde " + CHR(224) + " Produzir :"
            ENDWITH

            .AddObject("lbl_4c_Label3", "Label")
            WITH .lbl_4c_Label3
                .Top = 431
                .Left = 365
                .Width = 109
                .Height = 17
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Qtde " + CHR(224) + " Utilizar :"
            ENDWITH

            .AddObject("txt_4c_Qt_pedida", "TextBox")
            WITH .txt_4c_Qt_pedida
                .Top = 428
                .Left = 268
                .Width = 80
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
                .Value = 0
            ENDWITH

            .AddObject("txt_4c_Qt_Selec", "TextBox")
            WITH .txt_4c_Qt_Selec
                .Top = 428
                .Left = 458
                .Width = 80
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
                .Value = 0
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp2Click")
        *-- Redirecionar foco das colunas somente-leitura para Column5 (QtdDisp editavel)
        BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
        BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
        BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
        BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")

        *-- Container4: pedras/requisicoes adicionais (Visible=.F.)
        THIS.AddObject("cnt_4c_Container4", "Container")
        WITH THIS.cnt_4c_Container4
            .Top = 125
            .Left = 12
            .Width = 708
            .Height = 465
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .SpecialEffect = 0
            .Visible = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top = 8
                .Left = 229
                .Width = 249
                .Height = 18
                .AutoSize = .F.
                .BackStyle = 0
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 10
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
            ENDWITH

            .AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH .cmd_4c_CancelaDisp
                .Top = 3
                .Left = 620
                .Width = 75
                .Height = 75
                .Caption = "Sair"
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top = 32
                .Left = 9
                .Width = 605
                .Height = 420
                .ColumnCount = 5
                .AllowHeaderSizing = .F.
                .AllowRowSizing = .F.
                .DeleteMark = .F.
                .RecordMark = .F.
                .ScrollBars = 3
                .RowHeight = 16
                .FontSize = 8
                WITH .Column1
                    .Width = 80
                    .ReadOnly = .F.
                    .Header1.Caption = "Produto"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 200
                    .ReadOnly = .T.
                    .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 40
                    .ReadOnly = .T.
                    .Header1.Caption = "Uni"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 80
                    .ReadOnly = .F.
                    .Header1.Caption = "Qtde"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column5
                    .Width = 80
                    .ReadOnly = .F.
                    .Header1.Caption = "Produto"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp4Click")
        BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1, "Valid", THIS, "Cnt4Col1TextValid")
        BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column4.Text1, "When",  THIS, "Cnt4Col4TextWhen")
        BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "When",  THIS, "Cnt4Col5TextWhen")
        BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt4Col5TextValid")

        *-- Container5: selecao de estoque por grupo/conta (Visible=.F.)
        THIS.AddObject("cnt_4c_Container5", "Container")
        WITH THIS.cnt_4c_Container5
            .Top = 125
            .Left = 12
            .Width = 708
            .Height = 465
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .SpecialEffect = 0
            .Visible = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top = 10
                .Left = 284
                .Width = 123
                .Height = 18
                .AutoSize = .F.
                .BackStyle = 0
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 10
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Estoque Dispon" + CHR(237) + "vel"
            ENDWITH

            .AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH .cmd_4c_CancelaDisp
                .Top = 3
                .Left = 620
                .Width = 75
                .Height = 75
                .Caption = "OK"
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top = 32
                .Left = 141
                .Width = 425
                .Height = 372
                .ColumnCount = 5
                .AllowHeaderSizing = .F.
                .AllowRowSizing = .F.
                .DeleteMark = .F.
                .RecordMark = .F.
                .ScrollBars = 2
                .RowHeight = 16
                .FontSize = 8
                WITH .Column1
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Grupo"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column2
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Conta"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column3
                    .Width = 80
                    .ReadOnly = .T.
                    .Header1.Caption = "Prioridade"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column4
                    .Width = 75
                    .ReadOnly = .T.
                    .Header1.Caption = "Dispon" + CHR(237) + "vel"
                    .Header1.FontName = "Verdana"
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Column5
                    .Width = 75
                    .ReadOnly = .F.
                    .Header1.Caption = "Utilizar"
                    .Header1.FontName = "Verdana"
                    .Header1.FontBold = .T.
                    .Header1.FontSize = 8
                    .Header1.ForeColor = RGB(36, 84, 155)
                    .Text1.FontBold = .T.
                    .Text1.BorderStyle = 0
                    .Text1.Alignment = 3
                    .Text1.Value = 0
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt5Col5TextValid")
            BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt5GradeAfterRowColChange")

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top = 413
                .Left = 428
                .Width = 48
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Produzir :"
            ENDWITH

            .AddObject("lbl_4c_Label3", "Label")
            WITH .lbl_4c_Label3
                .Top = 438
                .Left = 435
                .Width = 41
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Utilizar :"
            ENDWITH

            .AddObject("lbl_4c_Label4", "Label")
            WITH .lbl_4c_Label4
                .Top = 413
                .Left = 93
                .Width = 38
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Grupo :"
            ENDWITH

            .AddObject("lbl_4c_Label5", "Label")
            WITH .lbl_4c_Label5
                .Top = 438
                .Left = 93
                .Width = 38
                .Height = 15
                .AutoSize = .F.
                .BackStyle = 0
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption = "Conta :"
            ENDWITH

            .AddObject("txt_4c__dgrupo", "TextBox")
            WITH .txt_4c__dgrupo
                .Top = 409
                .Left = 141
                .Width = 277
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
            ENDWITH

            .AddObject("txt_4c__dconta", "TextBox")
            WITH .txt_4c__dconta
                .Top = 434
                .Left = 141
                .Width = 277
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
            ENDWITH

            .AddObject("txt_4c_Qt_pedida", "TextBox")
            WITH .txt_4c_Qt_pedida
                .Top = 409
                .Left = 486
                .Width = 80
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
                .Value = 0
            ENDWITH

            .AddObject("txt_4c_Qt_Selec", "TextBox")
            WITH .txt_4c_Qt_Selec
                .Top = 434
                .Left = 486
                .Width = 80
                .Height = 23
                .ReadOnly = .T.
                .SpecialEffect = 1
                .FontSize = 8
                .Value = 0
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp5Click")

        *-- Shape2: delineamento visual da area de data/info no topo (9,9,279,51)
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 9
            .Left        = 9
            .Width       = 279
            .Height      = 51
            .BackStyle   = 0
            .BorderColor = RGB(255, 255, 255)
            .BorderWidth = 2
            .SpecialEffect = 0
        ENDWITH

        *-- Shape3: delineamento visual da area de numero/referencia (820,10,116,38)
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 10
            .Left        = 820
            .Width       = 116
            .Height      = 38
            .BackStyle   = 0
            .BorderColor = RGB(255, 255, 255)
            .BorderWidth = 2
            .SpecialEffect = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Restaura a visao principal do form
    *
    * OPERACIONAL: nao ha PageFrame com Page1/Page2 como em CRUD. A "pagina
    * lista" aqui eh o conjunto: grid principal (grd_4c_Dados / TmpFinal) +
    * totais + Container3 (saldo por grupo/conta, sempre visivel). Os overlays
    * (Container1/2/4/5) sao escondidos e as acoes principais reabilitadas.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        LOCAL loc_lPodeAcao

        *-- Ocultar overlays flutuantes
        IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            THIS.cnt_4c_Container1.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
            THIS.cnt_4c_Container2.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Container4", 5)
            THIS.cnt_4c_Container4.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Container5", 5)
            THIS.cnt_4c_Container5.Visible = .F.
        ENDIF

        *-- Grid principal e Container3 (saldo) sempre acessiveis
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Enabled = .T.
            THIS.grd_4c_Dados.ZOrder
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Container3", 5)
            THIS.cnt_4c_Container3.Enabled = .T.
        ENDIF

        *-- Reabilitar botoes de acao principal
        THIS.cmd_4c_Processar.Enabled  = .T.
        THIS.cmd_4c_Cancelar.Enabled   = .T.
        THIS.cmd_4c_TotLinha.Enabled   = .T.
        THIS.cmd_4c_Disponivel.Enabled = .T.
        THIS.cmd_4c_BtnRelatorio.Enabled = .T.

        *-- Botao Pedras/SelEstoque respeitam regra de negocio
        loc_lPodeAcao = .F.
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
                            !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
                            !THIS.this_lReserva
        ENDIF
        THIS.cmd_4c_Pedras.Enabled     = loc_lPodeAcao
        THIS.cmd_4c_SelEstoque.Enabled = loc_lPodeAcao

        *-- Focar grid principal na coluna editavel Produzir
        IF THIS.grd_4c_Dados.Enabled
            THIS.grd_4c_Dados.Refresh
            THIS.grd_4c_Dados.Column6.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura a area de detalhes do item corrente
    *
    * OPERACIONAL: nao ha PageFrame com Page2, mas o form tem uma "area de
    * dados" logica composta por Container3 (saldo por grupo/conta do produto
    * selecionado) + EditBox de observacao + totais Qtd/Est/Prz. Este metodo
    * atualiza os bindings e valores exibidos para o registro corrente do grid
    * principal (TmpFinal). E chamado apos mudanca de linha no grid principal.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        LOCAL loc_nSaldo, loc_nEstoque, loc_nProduzir

        loc_nSaldo    = 0
        loc_nEstoque  = 0
        loc_nProduzir = 0

        *-- Requer TmpFinal e TmpSaldG carregados
        IF !USED("TmpFinal") OR !USED("TmpSaldG")
            RETURN
        ENDIF

        *-- Reposicionar TmpSaldG conforme item corrente do grid principal
        SELECT TmpSaldG
        SET ORDER TO Cpros
        SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
        GO TOP

        *-- Vincular Container3 grid ao cursor de saldo detalhado
        THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
        WITH THIS.cnt_4c_Container3.grd_4c_Dados
            .Column1.ControlSource = "TmpSaldG.Grupos"
            .Column2.ControlSource = "TmpSaldG.Estos"
            .Column3.ControlSource = "TmpSaldG.Saldo"
            .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
            .Column5.ControlSource = "TmpSaldG.Disps"
            .Column6.ControlSource = "TmpSaldG.Emps"
            .SetAll("ReadOnly", .T.)
            .Refresh
        ENDWITH

        *-- Descricoes grupo/conta (buscadas via CursorQuery no AfterRowColChange)
        IF USED("TmpGrupo")
            THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = TratarNulo(TmpGrupo.Descrs, "C")
        ENDIF
        IF USED("TmpConta")
            THIS.cnt_4c_Container3.txt_4c__dconta.Value = TratarNulo(TmpConta.RClis, "C")
        ENDIF

        *-- Totais do item corrente (Saldo/Estoque/Produzir do TmpSaldo)
        IF USED("TmpSaldo") AND SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
            loc_nSaldo    = NVL(TmpSaldo.Saldo, 0)
            loc_nEstoque  = NVL(TmpSaldo.Saldo, 0) - NVL(TmpSaldo.Disps, 0)
            loc_nProduzir = NVL(TmpSaldo.Disps, 0)
        ENDIF
        THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = loc_nSaldo
        THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = loc_nEstoque
        THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = loc_nProduzir

        *-- Rebind da EditBox de observacao ao item corrente
        THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
        THIS.obj_4c_ObsItens.Refresh

        *-- Rotulo dinamico da observacao
        THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
                                            ALLTRIM(TratarNulo(TmpFinal.Cpros, "C"))
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre a visao principal e os overlays
    *
    * Parametros: par_nPagina
    *   0 -> visao principal (grid + Container3) - via ConfigurarPaginaLista()
    *   1 -> Container1 (Totais por Linha) - equivalente a BtnTotLinhaClick
    *   2 -> Container2 (Disponibilidade)  - equivalente a BtnDisponiveiClick
    *   3 -> Container3 permanece ativo (saldo por grupo/conta) - restaura lista
    *   4 -> Container4 (Requisicoes)      - equivalente a BtnPedrasClick
    *   5 -> Container5 (Selecao Estoque)  - equivalente a BtnSelEstoqueClick
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag
        loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)

        DO CASE
            CASE loc_nPag = 1
                THIS.BtnTotLinhaClick()
            CASE loc_nPag = 2
                THIS.BtnDisponiveiClick()
            CASE loc_nPag = 4
                THIS.BtnPedrasClick()
            CASE loc_nPag = 5
                THIS.BtnSelEstoqueClick()
            OTHERWISE
                *-- Pagina 0 ou 3: restaurar visao principal
                THIS.ConfigurarPaginaLista()
        ENDCASE
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDados
    *==========================================================================
        LOCAL loc_lReadOnly

        *-- Grid principal: vincular ao TmpFinal
        IF USED("TmpFinal")
            THIS.grd_4c_Dados.RecordSource = "TmpFinal"
            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = "TmpFinal.Cpros"
                .Column2.ControlSource = "TmpFinal.CodCors"
                .Column3.ControlSource = "TmpFinal.Dopes"
                .Column4.ControlSource = "TmpFinal.Numes"
                .Column5.ControlSource = "TmpFinal.Saldo"
                .Column6.ControlSource = "TmpFinal.Produzir"
                .Column7.ControlSource = "TmpFinal.Estoque"
                .Column8.ControlSource = "IIF(EMPTY(TmpFinal.Obsps), ' ', '*')"
                .Column9.ControlSource = "TmpFinal.CodTams"
            ENDWITH

            *-- Se nao ha operacao de transferencia, grid fica somente leitura
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                IF EMPTY(crSigCdPam.TransfRes)
                    THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
                ENDIF
            ENDIF
        ENDIF

        *-- Container3: Grid saldo por grupo/conta (TmpSaldG)
        IF USED("TmpSaldG") AND USED("TmpFinal")
            SELECT TmpSaldG
            SET ORDER TO Cpros
            GO TOP
            IF !EOF("TmpFinal")
                SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
            ENDIF
            GO TOP

            THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
            WITH THIS.cnt_4c_Container3.grd_4c_Dados
                .Column1.ControlSource = "TmpSaldG.Grupos"
                .Column2.ControlSource = "TmpSaldG.Estos"
                .Column3.ControlSource = "TmpSaldG.Saldo"
                .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
                .Column5.ControlSource = "TmpSaldG.Disps"
                .Column6.ControlSource = "TmpSaldG.Emps"
                .SetAll("ReadOnly", .T.)
            ENDWITH
        ENDIF

        *-- ObsItens: vincula ao campo de observacao do item corrente
        IF USED("TmpFinal")
            THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LOCAL loc_nI, loc_oCtrl
        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_nI)
            *-- Overlays ocultos (Visible=.F.): processar sub-controles mas manter container oculto
            IF INLIST(UPPER(loc_oCtrl.Name), ;
                      "CNT_4C_CONTAINER1", ;
                      "CNT_4C_CONTAINER2", ;
                      "CNT_4C_CONTAINER4", ;
                      "CNT_4C_CONTAINER5", ;
                      "IMG_4C_IMGFIGJPG")
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
                LOOP
            ENDIF
            *-- Containers permanentemente visiveis: garantir Visible=.T. e processar filhos
            IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CABECALHO", "CNT_4C_CONTAINER3")
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oCtrl
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LiberarConexaoTemp()
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS DOS BOTOES PRINCIPAIS
    *==========================================================================

    PROCEDURE BtnDisponiveiClick
        LOCAL loc_cCpro, loc_cCor

        TRY
            IF USED("TmpFinal")
                loc_cCpro = TmpFinal.Cpros
                loc_cCor  = TmpFinal.CodCors

                IF USED("TmpDisp")
                    THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = ""
                    USE IN TmpDisp
                ENDIF

                SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
                  FROM TmpSaldo ;
                 WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
                 ORDER BY Cpros, CodCors, CodTams ;
                  INTO CURSOR TmpDisp READWRITE

                THIS.grd_4c_Dados.Enabled = .F.

                IF _Tally = 0
                    MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
                    THIS.BtnCancelaDisp2Click()
                ELSE
                    THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = "TmpDisp"
                    WITH THIS.cnt_4c_Container2.grd_4c_Dados
                        .Column1.ControlSource = "TmpDisp.Cpros"
                        .Column2.ControlSource = "TmpDisp.CodCors"
                        .Column3.ControlSource = "TmpDisp.CodTams"
                        .Column4.ControlSource = "TmpDisp.Disps"
                        .Column5.ControlSource = "TmpDisp.Utilizar"
                    ENDWITH

                    WITH THIS.cnt_4c_Container2
                        .txt_4c_Qt_pedida.Value = TmpFinal.Saldo
                        .txt_4c_Qt_Selec.Value  = 0
                        .Visible     = .T.
                    ENDWITH

                    THIS.cmd_4c_Processar.Enabled  = .F.
                    THIS.cmd_4c_Cancelar.Enabled   = .F.
                    THIS.cmd_4c_TotLinha.Enabled   = .F.
                    THIS.cmd_4c_Pedras.Enabled     = .F.
                    THIS.cmd_4c_Disponivel.Enabled = .F.
                    THIS.cnt_4c_Container3.Enabled = .F.
                    THIS.cnt_4c_Container2.Visible = .T.
                    THIS.cnt_4c_Container2.ZOrder
                    THIS.cnt_4c_Container2.grd_4c_Dados.Refresh
                    THIS.cnt_4c_Container2.grd_4c_Dados.Column5.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnTotLinhaClick
        TRY
            IF USED("TmpLinha")
                THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = ""
                USE IN TmpLinha
            ENDIF

            SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
              FROM TmpFinal ;
             GROUP BY 1 ;
             UNION ALL ;
            SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
              FROM TmpFinal ;
             GROUP BY 1 ;
              INTO CURSOR TmpLinha ;
             ORDER BY 2, 1

            THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = "TmpLinha"
            WITH THIS.cnt_4c_Container1.grd_4c_Dados
                .Column1.ControlSource = "TmpLinha.Linhas"
                .Column2.ControlSource = "TmpLinha.Saldo"
                .Column3.ControlSource = "TmpLinha.Estoque"
                .Column4.ControlSource = "TmpLinha.Produzir"
                .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
                .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
            ENDWITH

            THIS.cmd_4c_Processar.Enabled  = .F.
            THIS.cmd_4c_Cancelar.Enabled   = .F.
            THIS.cmd_4c_TotLinha.Enabled   = .F.
            THIS.cmd_4c_Pedras.Enabled     = .F.
            THIS.cmd_4c_Disponivel.Enabled = .F.
            THIS.grd_4c_Dados.Enabled      = .F.
            THIS.cnt_4c_Container3.Enabled = .F.
            THIS.cnt_4c_Container1.Visible = .T.
            THIS.cnt_4c_Container1.ZOrder
            THIS.cnt_4c_Container1.grd_4c_Dados.Refresh
            THIS.cnt_4c_Container1.grd_4c_Dados.Column1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnPedrasClick
        TRY
            IF USED("SelPedra")
                THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = ""
            ENDIF

            THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = "SelPedra"
            WITH THIS.cnt_4c_Container4.grd_4c_Dados
                .Column1.ControlSource = "SelPedra.Cpros"
                .Column2.ControlSource = "SelPedra.Dpros"
                .Column3.ControlSource = "SelPedra.Cunis"
                .Column4.ControlSource = "SelPedra.Qtds"
                .Column5.ControlSource = "SelPedra.Cpro2s"
            ENDWITH

            THIS.cmd_4c_Processar.Enabled  = .F.
            THIS.cmd_4c_Cancelar.Enabled   = .F.
            THIS.cmd_4c_TotLinha.Enabled   = .F.
            THIS.cmd_4c_Pedras.Enabled     = .F.
            THIS.cmd_4c_Disponivel.Enabled = .F.
            THIS.grd_4c_Dados.Enabled      = .F.
            THIS.cnt_4c_Container3.Enabled = .F.
            THIS.cnt_4c_Container4.Visible = .T.
            THIS.cnt_4c_Container4.ZOrder
            THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
            THIS.cnt_4c_Container4.grd_4c_Dados.Column1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSelEstoqueClick
        LOCAL loc_cCpro, loc_cCor, loc_cTam

        TRY
            IF USED("TmpFinal")
                loc_cCpro = TmpFinal.Cpros
                loc_cCor  = TmpFinal.CodCors
                loc_cTam  = TmpFinal.CodTams

                IF USED("TmpDisp")
                    THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = ""
                    USE IN TmpDisp
                ENDIF

                SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
                       000000000.000 AS Utilizar ;
                  FROM TmpSaldG ;
                 WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam AND Disps > 0 ;
                  INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
                SELECT 0
                USE DBF("Resultado") ALIAS TmpDisp AGAIN
                USE IN Resultado

                THIS.grd_4c_Dados.Enabled = .F.

                IF _Tally = 0
                    MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
                    THIS.BtnCancelaDisp5Click()
                ELSE
                    THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = "TmpDisp"
                    WITH THIS.cnt_4c_Container5.grd_4c_Dados
                        .Column1.ControlSource = "TmpDisp.Grupos"
                        .Column2.ControlSource = "TmpDisp.Estos"
                        .Column3.ControlSource = "TmpDisp.Priors"
                        .Column4.ControlSource = "TmpDisp.Disps"
                        .Column5.ControlSource = "TmpDisp.Utilizar"
                    ENDWITH

                    WITH THIS.cnt_4c_Container5
                        .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
                                                 ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
                                                 "/" + ALLTRIM(loc_cTam) + ")"
                        .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
                        .txt_4c_Qt_Selec.Value  = 0
                        .Visible     = .T.
                    ENDWITH

                    THIS.cmd_4c_Processar.Enabled  = .F.
                    THIS.cmd_4c_Cancelar.Enabled   = .F.
                    THIS.cmd_4c_TotLinha.Enabled   = .F.
                    THIS.cmd_4c_Disponivel.Enabled = .F.
                    THIS.cmd_4c_SelEstoque.Enabled = .F.
                    THIS.cmd_4c_Pedras.Enabled     = .F.
                    THIS.cnt_4c_Container3.Enabled = .F.
                    THIS.cnt_4c_Container5.Visible = .T.
                    THIS.cnt_4c_Container5.ZOrder
                    THIS.cnt_4c_Container5.grd_4c_Dados.Refresh
                    THIS.cnt_4c_Container5.grd_4c_Dados.Column5.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick
        TRY
            IF VARTYPE(THIS.poFormPai) = "O"
                THIS.poFormPai.Enabled = .T.
            ENDIF
            THIS.Release
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnProcessarClick
        LOCAL loc_dPrevisao, loc_dGeracao, loc_lSucesso

        loc_dPrevisao = DATE()
        loc_dGeracao  = THIS.this_dData
        loc_lSucesso  = .F.

        TRY
            *-- Tentar obter datas do formulario pai/av?
            IF VARTYPE(THIS.poFormPai) = "O"
                TRY
                    IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
                        loc_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
                        loc_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
                    ENDIF
                CATCH
                ENDTRY
            ENDIF

            WITH THIS.this_oBusinessObject
                .this_lReserva    = THIS.this_lReserva
                .this_lAutomatico = THIS.this_lAutomatico
                .this_nNumeroDaOp = THIS.this_nNumeroDaOp
                .this_dPrevisao   = loc_dPrevisao
                .this_dGeracao    = loc_dGeracao
            ENDWITH

            loc_lSucesso = THIS.this_oBusinessObject.Processar(loc_dPrevisao, loc_dGeracao)

            IF loc_lSucesso
                MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso!", "Informa" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(THIS.poFormPai) = "O"
                    THIS.poFormPai.Enabled = .T.
                ENDIF
                THIS.Release
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnRelatorioClick
        TRY
            IF THIS.this_oBusinessObject.GerarRelatorio()
                THIS.ExecutarReportForm("SigPrGlp", "PRINTER_PROMPT", "crImpressao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS DOS CONTAINERS OVERLAY
    *==========================================================================

    PROCEDURE BtnCancelaLin1Click
        WITH THIS
            .cmd_4c_Processar.Enabled  = .T.
            .cmd_4c_Cancelar.Enabled   = .T.
            .cmd_4c_Pedras.Enabled     = .T.
            .cmd_4c_TotLinha.Enabled   = .T.
            .cmd_4c_Disponivel.Enabled = .T.
            .cnt_4c_Container1.Visible = .F.
            .cnt_4c_Container3.Enabled = .T.
            .grd_4c_Dados.Enabled      = .T.
            .grd_4c_Dados.ZOrder
            .grd_4c_Dados.Refresh
            .grd_4c_Dados.Column6.SetFocus
        ENDWITH
    ENDPROC

    PROCEDURE BtnCancelaDisp2Click
        LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("TmpDisp") AND USED("TmpFinal")
                SELECT TmpDisp
                SUM Utilizar TO loc_nQtdUtil

                IF loc_nQtdUtil > 0
                    SELECT TmpDisp
                    SCAN
                        IF Utilizar = 0
                            LOOP
                        ENDIF
                        loc_nQtUtil = Utilizar
                        =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
                        SELECT TmpFinal
                        REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
                        REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir

                        SELECT TmpSaldo
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil

                        IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                        ENDIF
                        REPLACE KeySelm WITH .T. IN TmpSaldU

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil

                        SELECT TmpDisp
                    ENDSCAN
                    =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        WITH THIS
            .cmd_4c_Processar.Enabled  = .T.
            .cmd_4c_Cancelar.Enabled   = .T.
            .cmd_4c_TotLinha.Enabled   = .T.
            .cmd_4c_SelEstoque.Enabled = .T.
            .cmd_4c_Pedras.Enabled     = .T.
            .cmd_4c_Disponivel.Enabled = .T.
            .cnt_4c_Container3.Enabled = .T.
            .cnt_4c_Container2.Visible = .F.
            .grd_4c_Dados.Enabled      = .T.
            .grd_4c_Dados.ZOrder
            .grd_4c_Dados.Refresh
            .grd_4c_Dados.Column6.SetFocus
        ENDWITH
    ENDPROC

    PROCEDURE BtnCancelaDisp4Click
        WITH THIS
            .cmd_4c_Processar.Enabled  = .T.
            .cmd_4c_Cancelar.Enabled   = .T.
            .cmd_4c_TotLinha.Enabled   = .T.
            .cmd_4c_Pedras.Enabled     = .T.
            .cmd_4c_Disponivel.Enabled = .T.
            .cnt_4c_Container3.Enabled = .T.
            .cnt_4c_Container4.Visible = .F.
            .grd_4c_Dados.Enabled      = .T.
            .grd_4c_Dados.ZOrder
            .grd_4c_Dados.Refresh
            .grd_4c_Dados.Column6.SetFocus
        ENDWITH
    ENDPROC

    PROCEDURE BtnCancelaDisp5Click
        LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa

        TRY
            IF USED("TmpDisp") AND USED("TmpFinal")
                SELECT TmpDisp
                SUM Utilizar TO loc_nQtdUtil

                IF loc_nQtdUtil > 0
                    SELECT TmpDisp
                    SCAN
                        IF Utilizar = 0
                            LOOP
                        ENDIF
                        loc_nQtUtil = Utilizar
                        =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")

                        SELECT TmpFinal
                        REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
                        REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir

                        SELECT TmpSaldo
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil

                        IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                        ENDIF
                        REPLACE KeySelm WITH .T. IN TmpSaldU

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
                        REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil

                        SELECT TmpDisp
                    ENDSCAN
                    =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        WITH THIS
            .cmd_4c_Processar.Enabled  = .T.
            .cmd_4c_Cancelar.Enabled   = .T.
            .cmd_4c_TotLinha.Enabled   = .T.
            .cmd_4c_Disponivel.Enabled = .T.
            .cmd_4c_SelEstoque.Enabled = .T.
            .cmd_4c_Pedras.Enabled     = .T.
            .cnt_4c_Container3.Enabled = .T.
            .cnt_4c_Container5.Visible = .F.
            .grd_4c_Dados.Enabled      = .T.
            .grd_4c_Dados.ZOrder
            .grd_4c_Dados.Refresh
            .grd_4c_Dados.Column6.SetFocus
        ENDWITH
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS DO GRID PRINCIPAL (GradeItens)
    *==========================================================================

    PROCEDURE GradeItensAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cSQL, loc_lcArquivo, loc_lcFoto, loc_nSal, loc_nEst, loc_nPrz

        TRY
            IF !USED("TmpFinal") OR EOF("TmpFinal")
                RETURN
            ENDIF

            THIS.obj_4c_ObsItens.Refresh
            THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)

            =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")

            SELECT TmpSaldG
            SET ORDER TO Cpros
            SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
            GO TOP

            WITH THIS.cnt_4c_Container3
                IF USED("TmpSaldo") AND !EOF("TmpSaldo")
                    .txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
                    .txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
                    .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
                ENDIF

                .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
                    IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
                    IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")

                .grd_4c_Dados.Refresh
                .Visible     = .T.
            ENDWITH

            *-- Foto do produto
            loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE CPros = '" + ;
                       ALLTRIM(TmpFinal.CPros) + "'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpProFig") > 0
                CLEAR RESOURCES
                THIS.img_4c_ImgFigJpg.Picture = ""
                THIS.img_4c_ImgFigJpg.Visible = .F.

                IF !EMPTY(xTmpProFig.FigJpgs) AND !ISNULL(xTmpProFig.FigJpgs)
                    loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(xTmpProFig.FigJpgs, ;
                                     "data:image/png;base64,", ""), ;
                                     "data:image/jpeg;base64,", ""), ;
                                     "data:image/jpg;base64,", ""), 14)
                    loc_lcArquivo = SYS(2023) + "\TempGlb.jpg"
                    IF STRTOFILE(loc_lcFoto, loc_lcArquivo) > 0
                        THIS.img_4c_ImgFigJpg.Picture = loc_lcArquivo
                        THIS.img_4c_ImgFigJpg.Visible = .T.
                    ENDIF
                ENDIF
                IF USED("xTmpProFig")
                    USE IN xTmpProFig
                ENDIF
            ENDIF

            SELECT TmpFinal
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE GrdCol6TextWhen
        LOCAL loc_lPermite
        loc_lPermite = .T.

        TRY
            IF USED("TmpFinal")
                THIS.this_nOldValue = THIS.grd_4c_Dados.Column6.Text1.Value

                IF THIS.this_lReserva AND TmpFinal.Estoque = 0
                    loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdPro WHERE CPros = '" + ;
                               ALLTRIM(TmpFinal.CPros) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempPro") > 0
                        loc_cSQL = "SELECT TOP 1 TipoEstos FROM SigCdGrp WHERE CGrus = '" + ;
                                   ALLTRIM(xTempPro.CGrus) + "'"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
                            IF INLIST(xTempGru.TipoEstos, 3, 4)
                                THIS.cmd_4c_Disponivel.Enabled = .T.
                            ENDIF
                            IF USED("xTempGru")
                                USE IN xTempGru
                            ENDIF
                        ENDIF
                        IF USED("xTempPro")
                            USE IN xTempPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPermite
    ENDPROC

    PROCEDURE GrdCol6TextValid
        LOCAL loc_lValido, loc_nNewValue, loc_nOld, loc_xBaixa

        loc_lValido  = .T.
        loc_nNewValue = THIS.grd_4c_Dados.Column6.Text1.Value
        loc_nOld      = THIS.this_nOldValue

        TRY
            IF !USED("TmpFinal") OR !USED("TmpSaldo")
                loc_lResultado = .T.
            ENDIF

            IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
            ENDIF

            IF loc_nNewValue <> loc_nOld AND TmpSaldU.KeySelm
                IF MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + ;
                               CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", "")
                    *-- Continue
                ELSE
                    THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_lValido
                DO CASE
                    CASE loc_nNewValue = loc_nOld
                        *-- nada a fazer
                    CASE loc_nNewValue < 0
                        MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
                        THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
                    CASE loc_nNewValue > TmpFinal.Saldo
                        MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da Opera" + CHR(231) + CHR(227) + "o!!!", "")
                        THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo - TmpFinal.Estoque
                    CASE !SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") AND ;
                         TmpFinal.Produzir <> TmpFinal.Saldo
                        MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
                        THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo
                    OTHERWISE
                        IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_nNewValue
                            REPLACE TmpSaldo.Disps   WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
                            REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNewValue IN TmpFinal
                            REPLACE KeySelm WITH .F. IN TmpSaldU

                            SELECT TmpSaldo
                            loc_xBaixa = Saldo - Disps
                            SELECT TmpSaldG
                            SET ORDER TO Cpros
                            =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                            REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
                            =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                            SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND m.loc_xBaixa > 0
                                IF TmpSaldG.Disps >= m.loc_xBaixa
                                    REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_xBaixa
                                    m.loc_xBaixa = 0
                                ELSE
                                    m.loc_xBaixa = m.loc_xBaixa - TmpSaldG.Disps
                                    REPLACE TmpSaldG.Disps WITH 0
                                ENDIF
                            ENDSCAN
                        ELSE
                            MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
                            THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
                        ENDIF
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    PROCEDURE GrdCol6TextLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz

        TRY
            IF USED("TmpFinal")
                SELECT TmpFinal
                loc_nRecno = RECNO()
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO loc_nRecno
                THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                THIS.txt_4c_Tot_Est.Value = loc_nEst
                THIS.txt_4c_Tot_Prz.Value = loc_nPrz
                THIS.txt_4c_Tot_Qtd.Refresh
                THIS.txt_4c_Tot_Est.Refresh
                THIS.txt_4c_Tot_Prz.Refresh
                THIS.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DOS GRIDS DE CONTAINERS OVERLAY
    *==========================================================================

    PROCEDURE Cnt5GradeAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cSQL

        *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
    ENDPROC

    PROCEDURE Cnt5Col5TextValid
        LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno

        loc_lValido = .T.

        TRY
            loc_nVal = THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value

            IF loc_nVal > TmpDisp.Disps
                MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Disponivel...", "")
                THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
                THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
                loc_lValido = .F.
            ELSE
                IF loc_nVal < 0
                    MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", "")
                    THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
                    THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
                    loc_lValido = .F.
                ELSE
                    loc_nRecno = RECNO("TmpDisp")
                    SUM TmpDisp.Utilizar TO loc_nQtdUtil
                    GO loc_nRecno IN TmpDisp
                    IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo - TmpFinal.Estoque
                        MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "")
                        THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
                        THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
                        loc_lValido = .F.
                    ELSE
                        THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Value = loc_nQtdUtil
                        THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Refresh
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    PROCEDURE Cnt2Col5TextValid
        LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno

        loc_lValido = .T.

        TRY
            loc_nVal = THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value

            IF loc_nVal > TmpDisp.Disps
                MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Disponivel!!!", "")
                THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
                THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
                loc_lValido = .F.
            ELSE
                loc_nRecno = RECNO("TmpDisp")
                SUM TmpDisp.Utilizar TO loc_nQtdUtil
                GO loc_nRecno IN TmpDisp
                IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo
                    MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Pedida!!!", "")
                    THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
                    THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
                    loc_lValido = .F.
                ELSE
                    THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Value = loc_nQtdUtil
                    THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Refresh
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    PROCEDURE Cnt4Col1TextValid
        LOCAL loc_lValido, loc_cVal, loc_cSQL

        loc_lValido = .T.

        TRY
            loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
            IF !EMPTY(loc_cVal)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = '" + ;
                           EscaparSQL(loc_cVal)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaRemota") > 0 AND RECCOUNT("crListaRemota") > 0
                    THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
                    REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
                            SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
                ELSE
                    *-- Abrir picker (FormBuscaAuxiliar)
                    DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crListaRemota", "CPros", ;
                                             loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", 1000, ;
                                             "CPros", "DPros"
                    IF USED("crListaRemota") AND RECCOUNT("crListaRemota") > 0
                        THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
                        REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
                                SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
                    ENDIF
                ENDIF
                IF USED("crListaRemota")
                    USE IN crListaRemota
                ENDIF
                THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    PROCEDURE GrdColXGotFocus
    *==========================================================================
        IF VARTYPE(THIS.grd_4c_Dados) = "O" AND VARTYPE(THIS.grd_4c_Dados.Column6) = "O"
            THIS.grd_4c_Dados.Column6.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Cnt2GrdColXGotFocus
    *==========================================================================
        LOCAL loc_oGrd
        loc_oGrd = THIS.cnt_4c_Container2.grd_4c_Dados
        IF VARTYPE(loc_oGrd) = "O" AND VARTYPE(loc_oGrd.Column5) = "O"
            loc_oGrd.Column5.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Cnt4Col4TextWhen
    *==========================================================================
        RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
    ENDPROC

    *==========================================================================
    PROCEDURE Cnt4Col5TextWhen
    *==========================================================================
        RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
    ENDPROC

    *==========================================================================
    PROCEDURE Cnt4Col5TextValid
    *==========================================================================
        LOCAL loc_lValido, loc_cVal, loc_cSQL, loc_oBusca
        loc_lValido = .T.

        TRY
            loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value)
            IF !EMPTY(loc_cVal)
                loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
                           EscaparSQL(loc_cVal)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaPro2") > 0 AND RECCOUNT("crListaPro2") > 0
                    THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
                    REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
                ELSE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                                             "crListaPro2", "CPros", loc_cVal, ;
                                             "Produto Substituto")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("crListaPro2") AND RECCOUNT("crListaPro2") > 0
                            THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
                            REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
                        ELSE
                            THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = ""
                            REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
                        ENDIF
                        loc_oBusca = .NULL.
                    ENDIF
                ENDIF
                IF USED("crListaPro2")
                    USE IN crListaPro2
                ENDIF
            ELSE
                REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
            ENDIF
            THIS.cnt_4c_Container4.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Cnt3GradeAfterRowColChange - Atualiza descricoes de grupo/conta ao mudar
    * de linha no grid de saldo (Container3.grd_4c_Dados / TmpSaldG)
    *==========================================================================
    PROCEDURE Cnt3GradeAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cSQL

        *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - Helper canonico REPORT FORM com guard FILE()
    * e isolamento SET POINT/SEPARATOR/REPORTBEHAVIOR 80
    * par_cRelatorioBase : nome base do FRX (sem path, sem extensao)
    * par_cModo          : "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    * par_cCursorDados   : alias do cursor de dados (opcional - verifica se vazio)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cArqFrx, loc_cOldPoint, loc_cOldSep, loc_oErro

        par_cRelatorioBase = STRTRAN(UPPER(par_cRelatorioBase), ".FRX", "")
        loc_cArqFrx = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF !FILE(loc_cArqFrx)
            MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                    loc_cArqFrx, "Relat" + CHR(243) + "rio")
            RETURN
        ENDIF

        IF !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum dado para exibir.")
                RETURN
            ENDIF
        ENDIF

        loc_cOldPoint = SET("POINT")
        loc_cOldSep   = SET("SEPARATOR")

        TRY
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80
            DO CASE
                CASE par_cModo = "PREVIEW"
                    REPORT FORM (loc_cArqFrx) PREVIEW
                CASE par_cModo = "PRINTER_PROMPT"
                    REPORT FORM (loc_cArqFrx) TO PRINTER PROMPT
                CASE par_cModo = "PRINTER"
                    REPORT FORM (loc_cArqFrx) TO PRINTER
                OTHERWISE
                    REPORT FORM (loc_cArqFrx) PREVIEW
            ENDCASE
        CATCH TO loc_oErro
            MsgErro("Erro relat" + CHR(243) + "rio: " + loc_oErro.Message, "Relat" + CHR(243) + "rio")
        ENDTRY

        SET POINT TO (loc_cOldPoint)
        SET SEPARATOR TO (loc_cOldSep)
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS (CRUD-nomeados) - Form OPERACIONAL "Previa da Globalizacao"
    * Este form nao possui botoes CRUD literais (Incluir/Alterar/Visualizar/Excluir),
    * mas os handlers sao expostos como aliases das acoes operacionais equivalentes
    * para uso por integradores externos (menus, chamadas automatizadas, testes).
    *==========================================================================

    PROCEDURE BtnIncluirClick
        *-- INCLUIR (novo processamento): executa Processar (fluxo principal)
        TRY
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick
        *-- ALTERAR (recalcular totais da grade principal a partir de TmpFinal)
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro

        TRY
            IF USED("TmpFinal")
                SELECT TmpFinal
                loc_nRecno = RECNO()
                loc_nSal = 0
                loc_nEst = 0
                loc_nPrz = 0
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                IF loc_nRecno <= RECCOUNT("TmpFinal") AND loc_nRecno > 0
                    GO loc_nRecno IN TmpFinal
                ENDIF

                IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
                    THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                    THIS.txt_4c_Tot_Qtd.Refresh()
                ENDIF
                IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
                    THIS.txt_4c_Tot_Est.Value = loc_nEst
                    THIS.txt_4c_Tot_Est.Refresh()
                ENDIF
                IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
                    THIS.txt_4c_Tot_Prz.Value = loc_nPrz
                    THIS.txt_4c_Tot_Prz.Refresh()
                ENDIF
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnVisualizarClick
        *-- VISUALIZAR: emite o relatorio da previa (equivalente ao btnRelatorio)
        TRY
            THIS.BtnRelatorioClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick
        *-- EXCLUIR (cancelar processamento em andamento): rollback + release
        TRY
            IF MsgConfirma("Cancelar o processamento atual?", "Confirma" + CHR(231) + CHR(227) + "o")
                THIS.BtnCancelarClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Rebusca / reexibe os dados atuais
    * Para form OPERACIONAL sem filtros editaveis pelo usuario, "Buscar"
    * equivale a atualizar os totais e o binding do grid principal a partir
    * dos cursores TmpFinal/TmpSaldo/TmpSaldG ja carregados pelo form pai.
    *==========================================================================
    PROCEDURE BtnBuscarClick
        TRY
            THIS.CarregarDados()
            IF USED("TmpFinal")
                LOCAL loc_nSal, loc_nEst, loc_nPrz
                loc_nSal = 0
                loc_nEst = 0
                loc_nPrz = 0
                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO TOP
                THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                THIS.txt_4c_Tot_Est.Value = loc_nEst
                THIS.txt_4c_Tot_Prz.Value = loc_nPrz
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra / fecha o form sem processar
    * Equivalente ao botao Sair/Cancelar do legado.
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        TRY
            IF VARTYPE(THIS.poFormPai) = "O"
                THIS.poFormPai.Enabled = .T.
            ENDIF
            THIS.Release
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva / confirma o processamento
    * Para form OPERACIONAL "Previa da Globalizacao", salvar equivale a
    * executar o processamento completo (botao Processar do legado).
    *==========================================================================
    PROCEDURE BtnSalvarClick
        TRY
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Alias canonico para CarregarDados (compatibilidade FormBase)
    * Forms CRUD chamam CarregarLista; em OPERACIONAL delega para CarregarDados.
    *==========================================================================
    PROCEDURE CarregarLista
        TRY
            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do form para o BO
    * Em form OPERACIONAL as propriedades relevantes sao flags de contexto
    * (lReserva, lAutomatico, nNumeroDaOp) e datas obtidas do form pai.
    *==========================================================================
    PROCEDURE FormParaBO
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF
            WITH THIS.this_oBusinessObject
                .this_lReserva    = THIS.this_lReserva
                .this_lAutomatico = THIS.this_lAutomatico
                .this_nNumeroDaOp = THIS.this_nNumeroDaOp
                .this_nEmphPdr    = THIS.this_nEmphPdr
                .this_dData       = THIS.this_dData

                *-- Datas de previsao/geracao obtidas do form avo (se existir)
                IF VARTYPE(THIS.poFormPai) = "O"
                    TRY
                        IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
                            .this_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
                            .this_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
                        ENDIF
                    CATCH
                    ENDTRY
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza o form com dados/estado do BO
    * Em form OPERACIONAL rebinda grids e atualiza totais a partir dos
    * cursores calculados pelo BO (TmpFinal/TmpSaldo/TmpSaldG).
    *==========================================================================
    PROCEDURE BOParaForm
        LOCAL loc_nSal, loc_nEst, loc_nPrz
        loc_nSal = 0
        loc_nEst = 0
        loc_nPrz = 0

        TRY
            THIS.CarregarDados()

            IF USED("TmpFinal")
                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO TOP
                THIS.txt_4c_Tot_Qtd.Value = loc_nSal
                THIS.txt_4c_Tot_Est.Value = loc_nEst
                THIS.txt_4c_Tot_Prz.Value = loc_nPrz
            ENDIF

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            IF VARTYPE(THIS.cnt_4c_Container3) = "O"
                THIS.cnt_4c_Container3.Refresh()
            ENDIF
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles conforme contexto
    * par_lHabilitar : .T. = habilitar controles editaveis, .F. = somente leitura
    * Para form OPERACIONAL o unico campo editavel pelo usuario e a coluna
    * Produzir (Column6) do grid principal.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        TRY
            *-- Coluna Produzir do grid principal
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                IF loc_lHab
                    *-- Permitir edicao apenas se nao ha operacao TransfRes bloqueando
                    IF USED("crSigCdPam")
                        SELECT crSigCdPam
                        IF EMPTY(crSigCdPam.TransfRes)
                            THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
                        ELSE
                            THIS.grd_4c_Dados.Column6.ReadOnly = .F.
                        ENDIF
                    ELSE
                        THIS.grd_4c_Dados.Column6.ReadOnly = .F.
                    ENDIF
                ELSE
                    THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
                ENDIF
            ENDIF

            *-- Botoes de acao
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera totais do form sem liberar cursores do form pai
    * Em form OPERACIONAL os cursores pertencem ao form pai; este metodo
    * apenas zera a exibicao de totais e limpa os overlays.
    *==========================================================================
    PROCEDURE LimparCampos
        TRY
            *-- Zerar totalizadores
            IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
                THIS.txt_4c_Tot_Qtd.Value = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
                THIS.txt_4c_Tot_Est.Value = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
                THIS.txt_4c_Tot_Prz.Value = 0
            ENDIF

            *-- Zerar totalizadores do Container3 (saldo por grupo/conta)
            IF VARTYPE(THIS.cnt_4c_Container3) = "O"
                THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = 0
                THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = 0
                THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = 0
                THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = ""
                THIS.cnt_4c_Container3.txt_4c__dconta.Value = ""
            ENDIF

            *-- Limpar label de observacao
            IF VARTYPE(THIS.lbl_4c_Txt_ObsItens) = "O"
                THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
            ENDIF

            *-- Ocultar overlays flutuantes
            THIS.ConfigurarPaginaLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme contexto atual
    * Em form OPERACIONAL o "modo" eh determinado pelo estado dos cursores:
    *   - Sem TmpFinal    -> apenas Cancelar disponivel
    *   - Com TmpFinal    -> todos os botoes operacionais disponiveis
    *   - Overlay ativo   -> botoes principais desabilitados (gerenciado pelos
    *                        handlers Btn*Click individuais)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
        LOCAL loc_lTemDados, loc_lPodeAcao
        loc_lTemDados = .F.
        loc_lPodeAcao = .F.

        TRY
            *-- Verificar se ha dados carregados
            IF USED("TmpFinal")
                loc_lTemDados = RECCOUNT("TmpFinal") > 0
            ENDIF

            *-- Verificar se operacao de pedras/selecao de estoque esta disponivel
            IF loc_lTemDados AND USED("crSigCdPam")
                SELECT crSigCdPam
                loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND ;
                                !EMPTY(crSigCdPam.DopReqcs) AND ;
                                !EMPTY(crSigCdPam.DopPedcs) AND ;
                                !EMPTY(crSigCdPam.DopComps) AND ;
                                !THIS.this_lReserva
            ENDIF

            *-- Aplicar estado aos botoes
            THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
            THIS.cmd_4c_Cancelar.Enabled     = .T.
            THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
            THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
            THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
            THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
            THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
