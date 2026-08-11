*==============================================================================
* FormSIGPRCPR.prg - Formulario Operacional: Conferencia e Reserva de Producao
* Tipo: OPERACIONAL (flat - popup modal, chamado por form pai)
* Migrado de SIGPRCPR.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (800x400 - popup modal)
*   BD   -> SIGPRCPRBO (TmpBaixa local, SigOpEtq, SigMvCab, SigMvItn, etc.)
*   CODE -> arquitetura em camadas (FormBase / SIGPRCPRBO)
*
* CHAMADA (por form pai, ex: FormSIGPRCIC):
*   loForm = CREATEOBJECT("FormSIGPRCPR", loFormPai)
*   loForm.Show()
*==============================================================================

DEFINE CLASS FormSIGPRCPR AS FormBase

    Height       = 400
    Width        = 800
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"

    *-- Referencia ao form pai (recebe TmpEnc e DataSessionId)
    this_oParent         = .NULL.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LPARAMETERS par_oParent

        IF VARTYPE(par_oParent) = "O"
            THIS.this_oParent  = par_oParent
            THIS.DataSessionId = par_oParent.DataSessionId
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        LOCAL loc_cImgFundo
        loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
        THIS.ScrollBars = 0
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCPRBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGPRCPRBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarPaginaDados()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarPaginaLista()
            THIS.TornarControlesVisiveis()
            THIS.ConfigurarBINDEVENTs()
            THIS.InicializarValores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_nW, loc_cCaption
        loc_nW      = THIS.Width
        loc_cCaption = THIS.Caption

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .Width         = loc_nW
                .Height        = 40
                .Top           = 18
                .Left          = 10
                .Caption       = loc_cCaption
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontBold      = .T.
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize   = .F.
                .Width      = loc_nW
                .Height     = 46
                .Top        = 17
                .Left       = 10
                .Caption    = loc_cCaption
                .FontName   = "Tahoma"
                .FontSize   = 18
                .FontBold   = .T.
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .ForeColor  = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura os campos principais do form OPERACIONAL
    * (form flat sem PageFrame, portanto sem Page2 literal; os campos abaixo
    * correspondem semanticamente aa "pagina de dados" do padrao CRUD).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Label "Data :"
        THIS.AddObject("lbl_4c_Data", "Label")
        WITH THIS.lbl_4c_Data
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Data : "
            .Height    = 15
            .Left      = 133
            .Top       = 110
            .Width     = 35
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox data (ReadOnly, exibe data da operacao do form pai)
        THIS.AddObject("txt_4c_Data", "TextBox")
        WITH THIS.txt_4c_Data
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = DATE()
            .Height            = 23
            .Left              = 170
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .Top               = 107
            .Width             = 80
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Codigo de barra :" (oculto ate TmpBaixa ter dados)
        THIS.AddObject("lbl_4c_Leitura", "Label")
        WITH THIS.lbl_4c_Leitura
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "C" + CHR(243) + "digo de barra :"
            .Height    = 15
            .Left      = 133
            .Top       = 359
            .Width     = 86
            .Visible   = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox leitura codigo de barras (oculto ate TmpBaixa ter dados)
        THIS.AddObject("txt_4c_Leitura", "TextBox")
        WITH THIS.txt_4c_Leitura
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Height      = 23
            .InputMask   = "99999999999999"
            .Left        = 221
            .Top         = 355
            .Width       = 108
            .Visible     = .F.
            .BorderColor = RGB(100, 100, 100)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *==========================================================================
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        *-- Botao "Conf. Auto" (Left=575) - oculto ate TmpBaixa ter dados
        THIS.AddObject("cmd_4c_ConferirAuto", "CommandButton")
        WITH THIS.cmd_4c_ConferirAuto
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "Conf. Auto"
            .Picture         = loc_cIcones + "geral_servicos_60.jpg"
            .Themes          = .T.
            .DisabledPicture = loc_cIcones + "geral_servicos_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .WordWrap        = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .F.
        ENDWITH

        *-- Botao "Ok" confirmar conferencia (Left=650) - oculto ate TmpBaixa ter dados
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "Ok"
            .Picture         = loc_cIcones + "cadastro_salvar_60.jpg"
            .Themes          = .T.
            .DisabledPicture = loc_cIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .WordWrap        = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .F.
        ENDWITH

        *-- Botao "Encerrar" (Left=725) - sempre visivel
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .WordWrap        = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Constroi a area de listagem (grade + leitura)
    * Em form OPERACIONAL flat (sem PageFrame), a "pagina lista" eh a regiao
    * central com a grade de etiquetas + o textbox de leitura de codigo de barra.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrade()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        THIS.AddObject("grd_4c_Dados", "Grid")
        THIS.grd_4c_Dados.ColumnCount = 5
        WITH THIS.grd_4c_Dados
            .Top               = 140
            .Left              = 133
            .Width             = 534
            .Height            = 207
            .FontSize          = 8
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .RowHeight         = 17
            .ScrollBars        = 2
            .Panel             = 1
            .Visible           = .F.

            WITH .Column1
                .Width            = 108
                .Movable          = .F.
                .Resizable        = .F.
                .ReadOnly         = .T.
                .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "C" + CHR(243) + "d. Barra"
                ENDWITH
            ENDWITH

            WITH .Column2
                .Width            = 108
                .Movable          = .F.
                .Resizable        = .F.
                .ReadOnly         = .T.
                .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Produto"
                ENDWITH
            ENDWITH

            WITH .Column3
                .Width            = 154
                .Movable          = .F.
                .Resizable        = .F.
                .ReadOnly         = .T.
                .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                ENDWITH
            ENDWITH

            WITH .Column4
                .Width            = 61
                .Movable          = .F.
                .Resizable        = .F.
                .ReadOnly         = .T.
                .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "N" + CHR(250) + "mero"
                ENDWITH
            ENDWITH

            WITH .Column5
                .Width            = 75
                .Movable          = .F.
                .Resizable        = .F.
                .ReadOnly         = .T.
                .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Qtde."
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
    *==========================================================================
        BINDEVENT(THIS.cmd_4c_ConferirAuto, "Click", THIS, "CmdConferirAutoClick")
        BINDEVENT(THIS.cmd_4c_Ok,           "Click", THIS, "CmdOkClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,     "Click", THIS, "CmdEncerrarClick")
        BINDEVENT(THIS.txt_4c_Leitura, "KeyPress", THIS, "TxtLeituraKeyPress")
        BINDEVENT(THIS, "Activate", THIS, "FormActivate")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarValores()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Data da operacao herdada do form pai
            IF VARTYPE(THIS.this_oParent) = "O"
                IF PEMSTATUS(THIS.this_oParent, "txt_4c_Data", 5)
                    THIS.txt_4c_Data.Value = THIS.this_oParent.txt_4c_Data.Value
                ELSE
                    IF PEMSTATUS(THIS.this_oParent, "Get_Data", 5)
                    THIS.txt_4c_Data.Value = THIS.this_oParent.Get_Data.Value
                    ENDIF
                ENDIF
            ENDIF

            *-- Criar cursor TmpBaixa vazio (sempre - independe de ValidandoUI)
            THIS.this_oBusinessObject.InicializarCursores()

            *-- Carregar dados apenas fora de modo ValidarUIFidelity (requer SQL + TmpEnc do pai)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                *-- Carregar SigKey de SigCdPac (usado em ConfirmarConferencia)
                THIS.this_oBusinessObject.CarregarSigKey()

                *-- Carregar etiquetas do cursor TmpEnc do form pai para TmpBaixa
                THIS.this_oBusinessObject.CarregarBars("TmpEnc")
            ENDIF

            *-- Vincular grade ao TmpBaixa (vazio ou populado)
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.ColumnCount = 5
                THIS.grd_4c_Dados.RecordSource = "TmpBaixa"
                WITH THIS.grd_4c_Dados
                    .Column1.ControlSource = "TmpBaixa.CodBarra"
                    .Column2.ControlSource = "TmpBaixa.CPros"
                    .Column3.ControlSource = "TmpBaixa.Dopes"
                    .Column4.ControlSource = "TmpBaixa.Numes"
                    .Column5.ControlSource = "TmpBaixa.QtdeLido"
                    .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
                    .Column2.Header1.Caption = "Produto"
                    .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    .Column4.Header1.Caption = "N" + CHR(250) + "mero"
                    .Column5.Header1.Caption = "Qtde."
                    .Refresh()
                ENDWITH
            ENDIF

            *-- Alternar para modo com/sem dados conforme TmpBaixa
            IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
                THIS.AlternarPagina(2)
            ELSE
                THIS.AlternarPagina(1)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarValores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna o estado visual do form OPERACIONAL
    *   par_nModo = 1 : SEM dados (TmpBaixa vazio ou nao carregado)
    *                  - Grade oculta, leitura oculta, botoes Ok/ConfAuto ocultos
    *                  - Apenas cabecalho, campo Data e botao Encerrar visiveis
    *   par_nModo = 2 : COM dados (TmpBaixa populado com etiquetas)
    *                  - Grade visivel, leitura visivel, botoes Ok/ConfAuto visiveis
    *                  - Foco automatico no textbox de leitura
    *==========================================================================
    PROCEDURE AlternarPagina(par_nModo)
        LOCAL loc_lTemDados
        loc_lTemDados = (par_nModo = 2)

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Visible = loc_lTemDados
        ENDIF
        IF VARTYPE(THIS.lbl_4c_Leitura) = "O"
            THIS.lbl_4c_Leitura.Visible = loc_lTemDados
        ENDIF
        IF VARTYPE(THIS.txt_4c_Leitura) = "O"
            THIS.txt_4c_Leitura.Visible = loc_lTemDados
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Ok) = "O"
            THIS.cmd_4c_Ok.Visible = loc_lTemDados
        ENDIF
        IF VARTYPE(THIS.cmd_4c_ConferirAuto) = "O"
            THIS.cmd_4c_ConferirAuto.Visible = loc_lTemDados
        ENDIF

        IF loc_lTemDados AND VARTYPE(THIS.txt_4c_Leitura) = "O"
            THIS.txt_4c_Leitura.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
    *==========================================================================
        LPARAMETERS par_oContainer
        LOCAL loc_oContainer, loc_i, loc_oControl, loc_nP, loc_cNome

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Name", 5)
                    loc_cNome = UPPER(ALLTRIM(loc_oControl.Name))
                ELSE
                    loc_cNome = ""
                ENDIF

                *-- Controles que iniciam ocultos, controlados por AlternarPagina() ou gerenciados internamente
                IF INLIST(loc_cNome, "GRD_4C_DADOS", "TXT_4C_LEITURA", "LBL_4C_LEITURA", ;
                                     "CMD_4C_OK", "CMD_4C_CONFERIRAUTO", "CNT_4C_CABECALHO")
                    *-- Preserva estado do controle, mas recursa para tornar sub-controles visiveis
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF UPPER(ALLTRIM(loc_oControl.BaseClass)) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
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
    PROCEDURE FormActivate()
    *==========================================================================
        IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
            THIS.txt_4c_Leitura.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE TxtLeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        LOCAL loc_nCodBarra, loc_oErro
        TRY
            IF !EMPTY(THIS.txt_4c_Leitura.Value) AND THIS.txt_4c_Leitura.Value <> 0
                loc_nCodBarra = THIS.txt_4c_Leitura.Value
                THIS.this_oBusinessObject.MarcarLeitura(loc_nCodBarra)
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    SELECT TmpBaixa
                    SET ORDER TO CodBarra
                    SEEK loc_nCodBarra
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                THIS.txt_4c_Leitura.Value = 0
            ELSE
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            par_nKeyCode = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Leitura")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdConferirAutoClick()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            THIS.this_oBusinessObject.ConferirAutomatico()
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Conferir Auto")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdOkClick()
    *==========================================================================
        LOCAL loc_lOk
        IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?")
            IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
                THIS.txt_4c_Leitura.SetFocus()
            ENDIF
            RETURN
        ENDIF

        loc_lOk = THIS.this_oBusinessObject.ConfirmarConferencia()
        IF loc_lOk
            IF VARTYPE(THIS.this_oParent) = "O"
                THIS.this_oParent.Enabled = .T.
            ENDIF
            THIS.Release()
        ELSE
            IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
                THIS.txt_4c_Leitura.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdEncerrarClick()
    *==========================================================================
        IF VARTYPE(THIS.this_oParent) = "O"
            THIS.this_oParent.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia nova leitura de etiqueta (foco no leitor de barras)
    * Mapeamento semantico: em form OPERACIONAL, "incluir" = adicionar leitura
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
                MsgAviso("N" + CHR(227) + "o existem etiquetas para confer" + CHR(234) + "ncia.", "Aviso")
                RETURN
            ENDIF

            IF VARTYPE(THIS.txt_4c_Leitura) = "O"
                THIS.txt_4c_Leitura.Visible = .T.
                THIS.txt_4c_Leitura.Enabled = .T.
                THIS.txt_4c_Leitura.Value   = 0
                THIS.txt_4c_Leitura.SetFocus()
            ENDIF

            IF VARTYPE(THIS.lbl_4c_Leitura) = "O"
                THIS.lbl_4c_Leitura.Visible = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Marca todas as etiquetas como lidas (conferencia automatica)
    * Mapeamento semantico: em form OPERACIONAL, "alterar" = marcar todas as leituras
    * Delega a logica real para ConferirAutomatico() do BO (mesma que CmdConferirAuto)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
                MsgAviso("N" + CHR(227) + "o existem etiquetas para confer" + CHR(234) + "ncia.", "Aviso")
                RETURN
            ENDIF

            IF !MsgConfirma("Marcar TODAS as etiquetas como lidas?")
                RETURN
            ENDIF

            THIS.this_oBusinessObject.ConferirAutomatico()
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Recarrega etiquetas do form pai e atualiza a grade
    * Mapeamento semantico: em form OPERACIONAL, "visualizar" = recarregar/refresh
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oParent) = "O"
                THIS.this_oBusinessObject.CarregarBars("TmpEnc")
            ENDIF

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
                THIS.AlternarPagina(2)
            ELSE
                THIS.AlternarPagina(1)
                MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para confer" + CHR(234) + "ncia.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa TODAS as leituras marcadas (zera QtdeLido)
    * Mapeamento semantico: em form OPERACIONAL, "excluir" = remover leituras
    * Operacao inversa de BtnAlterarClick / ConferirAutomatico
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
                MsgAviso("N" + CHR(227) + "o existem etiquetas para limpar.", "Aviso")
                RETURN
            ENDIF

            IF !MsgConfirma("Limpar TODAS as leituras marcadas?")
                RETURN
            ENDIF

            SELECT TmpBaixa
            REPLACE ALL QtdeLido WITH 0

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega etiquetas de TmpEnc e atualiza a grade
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF VARTYPE(THIS.this_oParent) = "O"
                THIS.this_oBusinessObject.CarregarBars("TmpEnc")
            ENDIF

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.ColumnCount = 5
                THIS.grd_4c_Dados.RecordSource = "TmpBaixa"
                WITH THIS.grd_4c_Dados
                    .Column1.ControlSource = "TmpBaixa.CodBarra"
                    .Column2.ControlSource = "TmpBaixa.CPros"
                    .Column3.ControlSource = "TmpBaixa.Dopes"
                    .Column4.ControlSource = "TmpBaixa.Numes"
                    .Column5.ControlSource = "TmpBaixa.QtdeLido"
                    .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
                    .Column2.Header1.Caption = "Produto"
                    .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    .Column4.Header1.Caption = "N" + CHR(250) + "mero"
                    .Column5.Header1.Caption = "Qtde."
                    .Refresh()
                ENDWITH
            ENDIF

            IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
                THIS.AlternarPagina(2)
            ELSE
                THIS.AlternarPagina(1)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do form para o Business Object
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF VARTYPE(THIS.txt_4c_Data) = "O"
                    THIS.this_oBusinessObject.this_dData = THIS.txt_4c_Data.Value
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega estado do Business Object para o form
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF VARTYPE(THIS.txt_4c_Data) = "O"
                    IF !EMPTY(THIS.this_oBusinessObject.this_dData)
                        THIS.txt_4c_Data.Value = THIS.this_oBusinessObject.this_dData
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme estado atual
    * par_lHabilitar = .T.: habilita leitura (TmpBaixa com dados)
    *                  .F.: desabilita leitura (TmpBaixa vazio)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(PCOUNT() >= 1, par_lHabilitar, .T.)
        IF VARTYPE(THIS.txt_4c_Leitura) = "O"
            THIS.txt_4c_Leitura.Enabled = loc_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Ok) = "O"
            THIS.cmd_4c_Ok.Visible = loc_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_ConferirAuto) = "O"
            THIS.cmd_4c_ConferirAuto.Visible = loc_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera o campo de leitura de codigo de barras
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.txt_4c_Leitura) = "O"
                THIS.txt_4c_Leitura.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme dados
    * Verifica TmpBaixa e chama AlternarPagina para sincronizar estado visual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
            THIS.AlternarPagina(2)
            THIS.HabilitarCampos(.T.)
        ELSE
            THIS.AlternarPagina(1)
            THIS.HabilitarCampos(.F.)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega etiquetas do form pai (refresh completo)
    * Mapeamento semantico: em form OPERACIONAL, "buscar" = recarregar dados
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o form e reabilita o form pai
    * Alias de CmdEncerrarClick para padrao FormBase
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma a conferencia (alias de CmdOkClick)
    * Mapeamento semantico: em form OPERACIONAL, "salvar" = confirmar conferencia
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdOkClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Descarta e encerra sem gravar (alias de CmdEncerrarClick)
    * Mapeamento semantico: em form OPERACIONAL, "cancelar" = sair sem confirmar
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF USED("TmpBaixa")
            USE IN TmpBaixa
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
