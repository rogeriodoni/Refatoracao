*==============================================================================
* FormSigReJur.prg
* Form: Lancamento de Juros
* Herda de: FormBase
* Tipo: OPERACIONAL - subformulario aberto pelo form pai de lancamento de juros
* Original: SIGREJUR.SCX
* Tarefa: task133
*==============================================================================

DEFINE CLASS FormSigReJur AS FormBase

    *-- DataSession = 1 (shared) para acessar crTmpJuros/crSigCdPam do form pai
    *-- O original SIGREJUR nao declarava DataSession (default = 1 shared)
    DataSession = 1
    ShowWindow = 1

    *-- Referencia ao form pai (form de lancamento que abriu este subform)
    this_oParentForm = .NULL.

    *-- Permissoes de acesso carregadas via fChecaAcesso no Init
    *-- Controlam editabilidade dos campos de conta e do grid (Col2/Col7)
    this_lAlteraContas = .F.
    this_lAlteraJuros  = .F.

    *-- Propriedades visuais (PILAR 1 - UX fiel ao SIGREJUR original)
    Caption      = ""
    Height       = 450
    Width        = 1003
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *==========================================================================
    * Init - Inicializa o formulario
    * par_oParentForm = referencia obrigatoria ao form pai (form de lancamento)
    *                   que possui crTmpJuros e crSigCdPam abertos em sua sessao
    *==========================================================================
    PROCEDURE Init(par_oParentForm)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Armazena referencia ao form pai e entra na datasession compartilhada
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
                SET DATASESSION TO par_oParentForm.DataSessionId
            ENDIF

            *-- Instancia BO antes de DODEFAULT (InicializarForm usa this_oBusinessObject)
            THIS.this_oBusinessObject = CREATEOBJECT("SigReJurBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigReJurBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "FormSigReJur.Init")
            ELSE
                *-- Carrega permissoes ANTES de InicializarForm() para uso em ConfigurarGrid
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    TRY
                        THIS.this_lAlteraContas = fChecaAcesso(THIS.this_oParentForm.Name, "ALTCONJUR")
                        THIS.this_lAlteraJuros  = fChecaAcesso(THIS.this_oParentForm.Name, "ALTJUROS")
                    CATCH TO loc_oErro
                        THIS.this_lAlteraContas = .T.
                        THIS.this_lAlteraJuros  = .T.
                    ENDTRY
                ENDIF

                *-- FormBase.Init() chama InicializarForm() internamente
                loc_lSucesso = DODEFAULT()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigReJur:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura visual do formulario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.LockScreen = .T.

            *-- Caption e fundo do form (PILAR 1 - UX fiel ao SIGREJUR)
            THIS.Caption = "Lan" + CHR(231) + "amento de Juros"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Configura aparencia base do form (OPERACIONAL sem PageFrame)
            THIS.ConfigurarPageFrame()

            *-- Cabecalho escuro persistente (cntSombra do original)
            THIS.ConfigurarPaginaLista()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Grid de juros, areas debito/credito e botao OK
            THIS.ConfigurarPaginaDados()

            *-- Carrega valores iniciais dos cursores do form pai
            THIS.InicializarValores()

            *-- Vincula eventos de validacao (KeyPress nos TextBoxes)
            THIS.ConfigurarBINDEVENTs()

            THIS.LockScreen = .F.
            loc_lSucesso = .T.

            IF VARTYPE(THIS.cmd_4c_Confirma) = "O"
                THIS.cmd_4c_Confirma.SetFocus
            ENDIF

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cabecalho escuro persistente
    * Em forms OPERACIONAIS equivale ao bloco fixo do topo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Grid de juros, areas debito/credito e botao OK
    * Em forms OPERACIONAIS equivale ao bloco de trabalho do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarGrid()
        THIS.ConfigurarAreaDebito()
        THIS.ConfigurarAreaCredito()
        THIS.ConfigurarBotaoConfirma()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com sombra e titulo
    * Original: SIGREJUR.cntSombra (Top=0, Left=0, Width=1100, Height=80)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .Caption   = loc_cCaption
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .Caption   = loc_cCaption
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grid principal com 7 colunas vinculado a crTmpJuros
    * Original: SIGREJUR.Grid1 (Top=98, Left=59, Width=884, Height=238)
    * Colunas 2 (Historico) e 7 (Juros) editaveis se AlteraJuros=.T.
    * Demais colunas sempre readonly
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        IF !USED("crTmpJuros")
            CREATE CURSOR crTmpJuros (Datas T, Hists C(100), Valors N(15,2), ;
                                      Moedas C(5), TaxJuros N(10,4), Dias N(6,0), ;
                                      Juros N(15,2), Grupos C(10), Contas C(20))
        ENDIF

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 98
            .Left              = 59
            .Width             = 884
            .Height            = 238
            .ColumnCount       = 7
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .RecordSource      = "crTmpJuros"

            *-- Column1: Vencimento - exibe TTOD da data/hora (readonly)
            WITH .Column1
                .Width             = 80
                .FontName          = "Tahoma"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .ControlSource     = "TTOD(crTmpJuros.Datas)"
                .Header1.Caption   = "Vencimento"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 1
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
            ENDWITH

            *-- Column2: Historico - editavel se AlteraJuros=.T.
            WITH .Column2
                .Width             = 336
                .FontName          = "Tahoma"
                .ReadOnly          = !THIS.this_lAlteraJuros
                .Movable           = .F.
                .Resizable         = .F.
                .ControlSource     = "crTmpJuros.Hists"
                .Header1.Caption   = "Hist" + CHR(243) + "rico"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.Margin      = 0
            ENDWITH

            *-- Column3: Valor (readonly)
            WITH .Column3
                .Width             = 120
                .FontName          = "Tahoma"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .ControlSource     = "crTmpJuros.Valors"
                .Header1.Caption   = "Valor"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column4: Moeda (readonly)
            WITH .Column4
                .Width             = 35
                .FontName          = "Tahoma"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .ControlSource     = "crTmpJuros.Moedas"
                .Header1.Caption   = "Moe"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column5: Taxa Juros (readonly)
            WITH .Column5
                .Width             = 120
                .FontName          = "Tahoma"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .ControlSource     = "crTmpJuros.TaxJuros"
                .Header1.Caption   = "Taxa Juros"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column6: Dias (readonly)
            WITH .Column6
                .Width             = 44
                .FontName          = "Tahoma"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .ControlSource     = "crTmpJuros.Dias"
                .Header1.Caption   = "Dias"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column7: Juros - editavel se AlteraJuros=.T.
            WITH .Column7
                .Width             = 120
                .FontName          = "Tahoma"
                .ReadOnly          = !THIS.this_lAlteraJuros
                .Movable           = .F.
                .Resizable         = .F.
                .ControlSource     = "crTmpJuros.Juros"
                .Header1.Caption   = "Juros"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            .Visible = .T.
        ENDWITH

        THIS.FormatarGridLista(THIS.grd_4c_Dados)
    ENDPROC

    *==========================================================================
    * ConfigurarAreaDebito - Shape, labels e textboxes do lado debito
    * Original: Shape2 + Say3/4/5 + Get_OPER/grupo/dgrupo/conta/dconta
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaDebito()
        *-- Shape2: borda visual da area debito (Top=346, Left=59, W=438, H=86)
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 346
            .Left        = 59
            .Width       = 438
            .Height      = 86
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Curvature   = 0
            .Visible     = .T.
        ENDWITH

        *-- Say3: [D/C] :
        THIS.AddObject("lbl_4c_Say3", "Label")
        WITH THIS.lbl_4c_Say3
            .Top       = 355
            .Left      = 78
            .Caption   = "[D/C] :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say4: Grupo :
        THIS.AddObject("lbl_4c_Say4", "Label")
        WITH THIS.lbl_4c_Say4
            .Top       = 380
            .Left      = 75
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say5: Conta :
        THIS.AddObject("lbl_4c_Say5", "Label")
        WITH THIS.lbl_4c_Say5
            .Top       = 405
            .Left      = 75
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_OPER: indicador D/C debito (readonly - sempre "C")
        THIS.AddObject("txt_4c_OPER", "TextBox")
        WITH THIS.txt_4c_OPER
            .Top           = 352
            .Left          = 115
            .Width         = 15
            .Height        = 23
            .Value         = ""
            .ReadOnly      = .T.
            .Format        = "K"
            .InputMask     = "!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Get_grupo: codigo do grupo debito
        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Top           = 377
            .Left          = 115
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .Enabled       = THIS.this_lAlteraContas
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Get_dgrupo: descricao do grupo debito
        THIS.AddObject("txt_4c_Dgrupo", "TextBox")
        WITH THIS.txt_4c_Dgrupo
            .Top           = 377
            .Left          = 198
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .Enabled       = THIS.this_lAlteraContas
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Get_conta: codigo da conta debito
        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top           = 402
            .Left          = 115
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .Enabled       = THIS.this_lAlteraContas
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Get_dconta: descricao da conta debito
        THIS.AddObject("txt_4c_Dconta", "TextBox")
        WITH THIS.txt_4c_Dconta
            .Top           = 402
            .Left          = 198
            .Width         = 290
            .Height        = 23
            .MaxLength     = 50
            .Value         = ""
            .Enabled       = THIS.this_lAlteraContas
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAreaCredito - Shape, labels e textboxes do lado credito
    * Original: Shape3 + Say11/12/13/15 + Get_SOPER/SGRUPO/Sdgrupo/SCONTA/SDCONTA
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaCredito()
        *-- Shape3: borda visual da area credito (Top=345, Left=505, W=438, H=86)
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 345
            .Left        = 505
            .Width       = 438
            .Height      = 86
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Curvature   = 0
            .Visible     = .T.
        ENDWITH

        *-- Say11: [D/C] :
        THIS.AddObject("lbl_4c_Say11", "Label")
        WITH THIS.lbl_4c_Say11
            .Top       = 353
            .Left      = 524
            .Caption   = "[D/C] :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say12: Grupo :
        THIS.AddObject("lbl_4c_Say12", "Label")
        WITH THIS.lbl_4c_Say12
            .Top       = 378
            .Left      = 521
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say13: Conta :
        THIS.AddObject("lbl_4c_Say13", "Label")
        WITH THIS.lbl_4c_Say13
            .Top       = 403
            .Left      = 521
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say15: Cotacao :
        THIS.AddObject("lbl_4c_Say15", "Label")
        WITH THIS.lbl_4c_Say15
            .Top       = 398
            .Left      = 661
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_SOPER: indicador D/C credito (readonly - sempre "D")
        THIS.AddObject("txt_4c_SOPER", "TextBox")
        WITH THIS.txt_4c_SOPER
            .Top           = 350
            .Left          = 561
            .Width         = 15
            .Height        = 23
            .Value         = ""
            .ReadOnly      = .T.
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Get_SGRUPO: codigo do grupo credito
        THIS.AddObject("txt_4c_SGRUPO", "TextBox")
        WITH THIS.txt_4c_SGRUPO
            .Top           = 375
            .Left          = 561
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .Enabled       = THIS.this_lAlteraContas
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Get_sdgrupo: descricao do grupo credito
        THIS.AddObject("txt_4c_Sdgrupo", "TextBox")
        WITH THIS.txt_4c_Sdgrupo
            .Top           = 375
            .Left          = 644
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .Enabled       = THIS.this_lAlteraContas
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Get_SCONTA: codigo da conta credito
        THIS.AddObject("txt_4c_SCONTA", "TextBox")
        WITH THIS.txt_4c_SCONTA
            .Top           = 400
            .Left          = 561
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .Enabled       = THIS.this_lAlteraContas
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Get_SDCONTA: descricao da conta credito
        THIS.AddObject("txt_4c_SDCONTA", "TextBox")
        WITH THIS.txt_4c_SDCONTA
            .Top           = 400
            .Left          = 644
            .Width         = 290
            .Height        = 23
            .MaxLength     = 50
            .Value         = ""
            .Enabled       = THIS.this_lAlteraContas
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoConfirma - Botao OK e shape visual ao redor
    * Original: Confirma (Top=3, Left=928, W=75, H=75, Cancel=.T.)
    *           Shape1   (Top=10, Left=905, W=90, H=110, BackStyle=0, BorderStyle=0)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoConfirma()
        *-- Shape1: elemento visual ao redor do botao (sem borda visivel)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 10
            .Left        = 905
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(206, 247, 251)
            .Curvature   = 0
            .Visible     = .T.
        ENDWITH

        *-- cmd_4c_Confirma: botao OK que encerra o subformulario
        THIS.AddObject("cmd_4c_Confirma", "CommandButton")
        WITH THIS.cmd_4c_Confirma
            .Top           = 3
            .Left          = 928
            .Width         = 75
            .Height        = 75
            .Caption       = "\<Ok"
            .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Cancel        = .T.
            .FontName      = "Tahoma"
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect = 0
            .MousePointer  = 15
            .WordWrap      = .T.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * InicializarValores - Popula campos com dados atuais de crTmpJuros/crSigCdPam
    * Replica a logica do Init original (apos configuracao do grid)
    *==========================================================================
    PROCEDURE InicializarValores()
        LOCAL loc_oErro, loc_cGrupo, loc_cConta, loc_cDesc
        loc_cGrupo = ""
        loc_cConta = ""
        loc_cDesc  = ""

        TRY
            *-- Lado debito: registro corrente de crTmpJuros
            THIS.txt_4c_OPER.Value = "C"

            IF USED("crTmpJuros")
                SELECT crTmpJuros
                loc_cGrupo = ALLTRIM(TratarNulo(Grupos, "C"))
                loc_cConta = ALLTRIM(TratarNulo(Contas, "C"))

                THIS.txt_4c_Grupo.Value = loc_cGrupo

                IF !EMPTY(loc_cGrupo)
                    loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cGrupo)
                    THIS.txt_4c_Dgrupo.Value = loc_cDesc
                ENDIF

                THIS.txt_4c_Conta.Value = loc_cConta

                IF !EMPTY(loc_cConta)
                    loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cGrupo, loc_cConta)
                    THIS.txt_4c_Dconta.Value = loc_cDesc
                ENDIF

                GO TOP IN crTmpJuros
            ENDIF

            *-- Lado credito: parametros de contabilizacao de crSigCdPam
            THIS.txt_4c_SOPER.Value = "D"

            IF USED("crSigCdPam")
                SELECT crSigCdPam
                loc_cGrupo = ALLTRIM(TratarNulo(GrupoPart, "C"))
                loc_cConta = ALLTRIM(TratarNulo(ContaPart, "C"))

                THIS.txt_4c_SGRUPO.Value = loc_cGrupo

                IF !EMPTY(loc_cGrupo)
                    loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cGrupo)
                    THIS.txt_4c_Sdgrupo.Value = loc_cDesc
                ENDIF

                THIS.txt_4c_SCONTA.Value = loc_cConta

                IF !EMPTY(loc_cConta)
                    loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cGrupo, loc_cConta)
                    THIS.txt_4c_SDCONTA.Value = loc_cDesc
                ENDIF
            ENDIF

            *-- Ajusta Enabled dos campos de descricao conforme codigos carregados
            *-- Original: Get_dconta.When / Get_SDCONTA.When controlavam via When event
            THIS.AtualizarHabilitacaoDescricoes()

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar valores:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.InicializarValores")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula KeyPress dos TextBoxes aos handlers
    * BINDEVENT exige metodos PUBLIC (sem PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.cmd_4c_Confirma, "Click",    THIS, "CmdConfirmaClick")
        BINDEVENT(THIS.txt_4c_Grupo,    "KeyPress", THIS, "TxtGrupoKeyPress")
        BINDEVENT(THIS.txt_4c_Grupo,    "DblClick", THIS, "TxtGrupoDblClick")
        BINDEVENT(THIS.txt_4c_Dgrupo,   "KeyPress", THIS, "TxtDgrupoKeyPress")
        BINDEVENT(THIS.txt_4c_Conta,    "KeyPress", THIS, "TxtContaKeyPress")
        BINDEVENT(THIS.txt_4c_Conta,    "DblClick", THIS, "TxtContaDblClick")
        BINDEVENT(THIS.txt_4c_Dconta,   "KeyPress", THIS, "TxtDcontaKeyPress")
        BINDEVENT(THIS.txt_4c_SGRUPO,   "KeyPress", THIS, "TxtSGRUPOKeyPress")
        BINDEVENT(THIS.txt_4c_SGRUPO,   "DblClick", THIS, "TxtSGRUPODblClick")
        BINDEVENT(THIS.txt_4c_Sdgrupo,  "KeyPress", THIS, "TxtSdgrupoKeyPress")
        BINDEVENT(THIS.txt_4c_SCONTA,   "KeyPress", THIS, "TxtSCONTAKeyPress")
        BINDEVENT(THIS.txt_4c_SCONTA,   "DblClick", THIS, "TxtSCONTADblClick")
        BINDEVENT(THIS.txt_4c_SDCONTA,  "KeyPress", THIS, "TxtSDCONTAKeyPress")
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid (fonte uniforme)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * CmdConfirmaClick - Encerra o subformulario (Original: Confirma.Click)
    *==========================================================================
    PROCEDURE CmdConfirmaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TxtGrupoKeyPress - Valida codigo do grupo debito
    * Original: Get_grupo.Valid - chama fAcessoContab("C") e preenche descricao
    *==========================================================================
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cDesc
        IF par_nKeyCode = 115  && F4 - abre lookup de grupo debito
            THIS.AbrirLookupGrupoDebito()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
        IF !EMPTY(loc_cGrupo)
            IF !THIS.this_oBusinessObject.VerificarAcessoGrupo(loc_cGrupo)
                MsgAviso("Grupo n" + CHR(227) + "o encontrado.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Grupo.Value  = ""
                THIS.txt_4c_Dgrupo.Value = ""
            ELSE
                loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cGrupo)
                THIS.txt_4c_Dgrupo.Value = loc_cDesc
            ENDIF
        ELSE
            THIS.txt_4c_Dgrupo.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtDgrupoKeyPress - Valida descricao do grupo debito
    * Original: Get_dgrupo.Valid - chama fAcessoContab("D") e preenche codigo
    *==========================================================================
    PROCEDURE TxtDgrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.txt_4c_Dgrupo.Value))
            THIS.txt_4c_Grupo.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtContaKeyPress - Valida codigo da conta debito
    * Original: Get_conta.Valid - fAcessoContas("C") + fChecarInativas
    *==========================================================================
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cConta, loc_cDesc
        IF par_nKeyCode = 115  && F4 - abre lookup de conta debito
            THIS.AbrirLookupContaDebito()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
        loc_cConta = ALLTRIM(THIS.txt_4c_Conta.Value)
        IF !EMPTY(loc_cConta)
            IF !THIS.this_oBusinessObject.VerificarAcessoConta(loc_cGrupo, loc_cConta)
                MsgAviso("Acesso N" + CHR(227) + "o Permitido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_Conta.Value  = ""
                THIS.txt_4c_Dconta.Value = ""
            ELSE
                IF !THIS.this_oBusinessObject.VerificarContaAtiva(loc_cConta)
                MsgAviso("Conta Inativa!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_Conta.Value  = ""
                THIS.txt_4c_Dconta.Value = ""
            ELSE
                loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cGrupo, loc_cConta)
                THIS.txt_4c_Dconta.Value = loc_cDesc
                ENDIF
            ENDIF
        ELSE
            THIS.txt_4c_Dconta.Value = ""
        ENDIF
        THIS.AtualizarHabilitacaoDescricoes()
    ENDPROC

    *==========================================================================
    * TxtDcontaKeyPress - Valida descricao da conta debito
    * Original: Get_dconta.Valid - fAcessoContas("D") + fChecarInativas
    *==========================================================================
    PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cConta
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.txt_4c_Dconta.Value))
            THIS.txt_4c_Conta.Value = ""
            RETURN
        ENDIF
        loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
        loc_cConta = ALLTRIM(THIS.txt_4c_Conta.Value)
        IF !EMPTY(loc_cConta)
            IF !THIS.this_oBusinessObject.VerificarAcessoConta(loc_cGrupo, loc_cConta)
                MsgAviso("Acesso N" + CHR(227) + "o Permitido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_Dconta.Value = ""
                THIS.txt_4c_Conta.Value  = ""
            ELSE
                IF !THIS.this_oBusinessObject.VerificarContaAtiva(loc_cConta)
                MsgAviso("Conta Inativa!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_Dconta.Value = ""
                THIS.txt_4c_Conta.Value  = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtSGRUPOKeyPress - Valida codigo do grupo credito
    * Original: Get_SGRUPO.Valid - fAcessoContab("C") e preenche descricao
    *==========================================================================
    PROCEDURE TxtSGRUPOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cDesc
        IF par_nKeyCode = 115  && F4 - abre lookup de grupo credito
            THIS.AbrirLookupGrupoCredito()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        loc_cGrupo = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
        IF !EMPTY(loc_cGrupo)
            IF !THIS.this_oBusinessObject.VerificarAcessoGrupo(loc_cGrupo)
                MsgAviso("Grupo n" + CHR(227) + "o encontrado.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_SGRUPO.Value  = ""
                THIS.txt_4c_Sdgrupo.Value = ""
            ELSE
                loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cGrupo)
                THIS.txt_4c_Sdgrupo.Value = loc_cDesc
            ENDIF
        ELSE
            THIS.txt_4c_Sdgrupo.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtSdgrupoKeyPress - Valida descricao do grupo credito
    * Original: Get_sdgrupo.Valid - fAcessoContab("D") e preenche codigo
    *==========================================================================
    PROCEDURE TxtSdgrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.txt_4c_Sdgrupo.Value))
            THIS.txt_4c_SGRUPO.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtSCONTAKeyPress - Valida codigo da conta credito
    * Original: Get_SCONTA.Valid - fAcessoContas("C") + fChecarInativas
    *==========================================================================
    PROCEDURE TxtSCONTAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cConta, loc_cDesc
        IF par_nKeyCode = 115  && F4 - abre lookup de conta credito
            THIS.AbrirLookupContaCredito()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        loc_cGrupo = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
        loc_cConta = ALLTRIM(THIS.txt_4c_SCONTA.Value)
        IF !EMPTY(loc_cConta)
            IF !THIS.this_oBusinessObject.VerificarAcessoConta(loc_cGrupo, loc_cConta)
                MsgAviso("Acesso N" + CHR(227) + "o Permitido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_SCONTA.Value  = ""
                THIS.txt_4c_SDCONTA.Value = ""
            ELSE
                IF !THIS.this_oBusinessObject.VerificarContaAtiva(loc_cConta)
                MsgAviso("Conta Inativa!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_SCONTA.Value  = ""
                THIS.txt_4c_SDCONTA.Value = ""
            ELSE
                loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cGrupo, loc_cConta)
                THIS.txt_4c_SDCONTA.Value = loc_cDesc
                ENDIF
            ENDIF
        ELSE
            THIS.txt_4c_SDCONTA.Value = ""
        ENDIF
        THIS.AtualizarHabilitacaoDescricoes()
    ENDPROC

    *==========================================================================
    * TxtSDCONTAKeyPress - Valida descricao da conta credito
    * Original: Get_SDCONTA.Valid - fAcessoContas("D") + fChecarInativas
    *==========================================================================
    PROCEDURE TxtSDCONTAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cConta
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.txt_4c_SDCONTA.Value))
            THIS.txt_4c_SCONTA.Value = ""
            RETURN
        ENDIF
        loc_cGrupo = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
        loc_cConta = ALLTRIM(THIS.txt_4c_SCONTA.Value)
        IF !EMPTY(loc_cConta)
            IF !THIS.this_oBusinessObject.VerificarAcessoConta(loc_cGrupo, loc_cConta)
                MsgAviso("Acesso N" + CHR(227) + "o Permitido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_SDCONTA.Value = ""
                THIS.txt_4c_SCONTA.Value  = ""
            ELSE
                IF !THIS.this_oBusinessObject.VerificarContaAtiva(loc_cConta)
                MsgAviso("Conta Inativa!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_SDCONTA.Value = ""
                THIS.txt_4c_SCONTA.Value  = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtGrupoDblClick - DblClick no campo grupo debito abre lookup
    *==========================================================================
    PROCEDURE TxtGrupoDblClick()
        THIS.AbrirLookupGrupoDebito()
    ENDPROC

    *==========================================================================
    * TxtContaDblClick - DblClick no campo conta debito abre lookup
    *==========================================================================
    PROCEDURE TxtContaDblClick()
        THIS.AbrirLookupContaDebito()
    ENDPROC

    *==========================================================================
    * TxtSGRUPODblClick - DblClick no campo grupo credito abre lookup
    *==========================================================================
    PROCEDURE TxtSGRUPODblClick()
        THIS.AbrirLookupGrupoCredito()
    ENDPROC

    *==========================================================================
    * TxtSCONTADblClick - DblClick no campo conta credito abre lookup
    *==========================================================================
    PROCEDURE TxtSCONTADblClick()
        THIS.AbrirLookupContaCredito()
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupoDebito - FormBuscaAuxiliar em SigCdGcr para grupo debito
    * Preenche txt_4c_Grupo (Codigos) e txt_4c_Dgrupo (Descrs)
    *==========================================================================
    PROCEDURE AbrirLookupGrupoDebito()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oErro
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF !THIS.txt_4c_Grupo.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", ;
                "cursor_4c_BuscaGrupoD", ;
                "Codigos", ;
                ALLTRIM(THIS.txt_4c_Grupo.Value), ;
                "Buscar Grupo D" + CHR(233) + "bito")

            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGrupoD")
                    SELECT cursor_4c_BuscaGrupoD
                    loc_cCodigo    = ALLTRIM(TratarNulo(Codigos, "C"))
                    loc_cDescricao = ALLTRIM(TratarNulo(Descrs, "C"))
                    THIS.txt_4c_Grupo.Value  = loc_cCodigo
                    THIS.txt_4c_Dgrupo.Value = loc_cDescricao
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaGrupoD")
                USE IN cursor_4c_BuscaGrupoD
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de grupo d" + CHR(233) + "bito:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.AbrirLookupGrupoDebito")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupContaDebito - FormBuscaAuxiliar em SigCdCli para conta debito
    * Filtra por grupo debito (txt_4c_Grupo). Preenche txt_4c_Conta e txt_4c_Dconta
    *==========================================================================
    PROCEDURE AbrirLookupContaDebito()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_cGrupo, loc_oErro
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF !THIS.txt_4c_Conta.Enabled
            RETURN
        ENDIF

        TRY
            loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", ;
                "cursor_4c_BuscaContaD", ;
                "IClis", ;
                ALLTRIM(THIS.txt_4c_Conta.Value), ;
                "Buscar Conta D" + CHR(233) + "bito")

            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaContaD")
                    SELECT cursor_4c_BuscaContaD
                    loc_cCodigo    = ALLTRIM(TratarNulo(IClis, "C"))
                    loc_cDescricao = ALLTRIM(TratarNulo(RClis, "C"))
                    THIS.txt_4c_Conta.Value  = loc_cCodigo
                    THIS.txt_4c_Dconta.Value = loc_cDescricao
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaContaD")
                USE IN cursor_4c_BuscaContaD
            ENDIF
            loc_oBusca.Release()
            THIS.AtualizarHabilitacaoDescricoes()

        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de conta d" + CHR(233) + "bito:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.AbrirLookupContaDebito")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupoCredito - FormBuscaAuxiliar em SigCdGcr para grupo credito
    * Preenche txt_4c_SGRUPO (Codigos) e txt_4c_Sdgrupo (Descrs)
    *==========================================================================
    PROCEDURE AbrirLookupGrupoCredito()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oErro
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF !THIS.txt_4c_SGRUPO.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", ;
                "cursor_4c_BuscaGrupoC", ;
                "Codigos", ;
                ALLTRIM(THIS.txt_4c_SGRUPO.Value), ;
                "Buscar Grupo Cr" + CHR(233) + "dito")

            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGrupoC")
                    SELECT cursor_4c_BuscaGrupoC
                    loc_cCodigo    = ALLTRIM(TratarNulo(Codigos, "C"))
                    loc_cDescricao = ALLTRIM(TratarNulo(Descrs, "C"))
                    THIS.txt_4c_SGRUPO.Value  = loc_cCodigo
                    THIS.txt_4c_Sdgrupo.Value = loc_cDescricao
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaGrupoC")
                USE IN cursor_4c_BuscaGrupoC
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de grupo cr" + CHR(233) + "dito:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.AbrirLookupGrupoCredito")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupContaCredito - FormBuscaAuxiliar em SigCdCli para conta credito
    * Filtra por grupo credito (txt_4c_SGRUPO). Preenche txt_4c_SCONTA e txt_4c_SDCONTA
    *==========================================================================
    PROCEDURE AbrirLookupContaCredito()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_cGrupo, loc_oErro
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF !THIS.txt_4c_SCONTA.Enabled
            RETURN
        ENDIF

        TRY
            loc_cGrupo = ALLTRIM(THIS.txt_4c_SGRUPO.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", ;
                "cursor_4c_BuscaContaC", ;
                "IClis", ;
                ALLTRIM(THIS.txt_4c_SCONTA.Value), ;
                "Buscar Conta Cr" + CHR(233) + "dito")

            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaContaC")
                    SELECT cursor_4c_BuscaContaC
                    loc_cCodigo    = ALLTRIM(TratarNulo(IClis, "C"))
                    loc_cDescricao = ALLTRIM(TratarNulo(RClis, "C"))
                    THIS.txt_4c_SCONTA.Value  = loc_cCodigo
                    THIS.txt_4c_SDCONTA.Value = loc_cDescricao
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaContaC")
                USE IN cursor_4c_BuscaContaC
            ENDIF
            loc_oBusca.Release()
            THIS.AtualizarHabilitacaoDescricoes()

        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de conta cr" + CHR(233) + "dito:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.AbrirLookupContaCredito")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarHabilitacaoDescricoes - Controla Enabled dos campos de descricao
    * Original: Get_dconta.When  = AlteraContas AND Empty(Get_Conta.Value)
    *           Get_SDCONTA.When = AlteraContas AND Empty(Get_SConta.Value)
    * Campos de descricao sao editaveis apenas quando o codigo correspondente
    * esta vazio (permite digitar descricao livre quando nao ha codigo vinculado)
    *==========================================================================
    PROCEDURE AtualizarHabilitacaoDescricoes()
        LOCAL loc_lContaVazia, loc_lSContaVazia

        IF VARTYPE(THIS.txt_4c_Conta) = "O" AND VARTYPE(THIS.txt_4c_Dconta) = "O"
            loc_lContaVazia = EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
            THIS.txt_4c_Dconta.Enabled = THIS.this_lAlteraContas AND loc_lContaVazia
        ENDIF

        IF VARTYPE(THIS.txt_4c_SCONTA) = "O" AND VARTYPE(THIS.txt_4c_SDCONTA) = "O"
            loc_lSContaVazia = EMPTY(ALLTRIM(THIS.txt_4c_SCONTA.Value))
            THIS.txt_4c_SDCONTA.Enabled = THIS.this_lAlteraContas AND loc_lSContaVazia
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Form OPERACIONAL: navega para primeira area editavel
    * Posiciona foco no primeiro campo editavel da area de credito (SGRUPO)
    * ou na grade se apenas alteracao de juros estiver liberada.
    *==========================================================================
    PROTECTED PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF THIS.this_lAlteraContas AND VARTYPE(THIS.txt_4c_SGRUPO) = "O" ;
               AND THIS.txt_4c_SGRUPO.Enabled
                THIS.txt_4c_SGRUPO.SetFocus
            ELSE
                IF THIS.this_lAlteraJuros AND VARTYPE(THIS.grd_4c_Dados) = "O"
                    IF USED("crTmpJuros") AND RECCOUNT("crTmpJuros") > 0
                        SELECT crTmpJuros
                        GO TOP
                    ENDIF
                    THIS.grd_4c_Dados.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao posicionar foco para inclus" + CHR(227) + "o:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Form OPERACIONAL: posiciona foco na grade para edicao
    * Coloca foco na grade de juros (Column2=Historico, Column7=Juros) que
    * sao as colunas editaveis quando AlteraJuros=.T.
    *==========================================================================
    PROTECTED PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF !THIS.this_lAlteraJuros
                IF VARTYPE(THIS.cmd_4c_Confirma) = "O"
                    THIS.cmd_4c_Confirma.SetFocus
                ENDIF
                RETURN
            ENDIF

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                IF USED("crTmpJuros") AND RECCOUNT("crTmpJuros") > 0
                    SELECT crTmpJuros
                    IF EOF()
                        GO TOP
                    ENDIF
                ENDIF
                THIS.grd_4c_Dados.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ativar modo altera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Form OPERACIONAL: atualiza dados exibidos
    * Recarrega valores dos cursores crTmpJuros/crSigCdPam do form pai e
    * refresca a grade. Equivale ao "refresh" do form.
    *==========================================================================
    PROTECTED PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.InicializarValores()
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh
            ENDIF
            THIS.AtualizarHabilitacaoDescricoes()
            THIS.Refresh
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar visualiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Form OPERACIONAL: zera juros da linha corrente
    * Reseta os campos Hists/Juros da linha corrente de crTmpJuros, permitindo
    * cancelar a juros calculada sem remover a linha (form pai mantem a estrutura).
    *==========================================================================
    PROTECTED PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_oErro

        IF !THIS.this_lAlteraJuros
            MsgAviso("Sem permiss" + CHR(227) + "o para alterar valores de juros.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !USED("crTmpJuros")
            MsgAviso("Nenhum registro de juros dispon" + CHR(237) + "vel.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT crTmpJuros
        IF RECCOUNT() = 0 OR EOF() OR BOF()
            MsgAviso("Nenhum registro selecionado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma zerar os juros desta linha?", ;
                                    "Confirma" + CHR(231) + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        TRY
            SELECT crTmpJuros
            REPLACE Hists WITH SPACE(LEN(Hists))
            REPLACE Juros WITH 0
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao zerar juros da linha:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Refresca o grid de juros a partir de crTmpJuros
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro
        TRY
            IF USED("crTmpJuros") AND VARTYPE(THIS.grd_4c_Dados) = "O"
                SELECT crTmpJuros
                GO TOP
                THIS.grd_4c_Dados.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL sem modos: nao altera botoes
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme permissoes
    * par_lEditar: .T. habilitar edicao, .F. somente leitura
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lEditar)
        LOCAL loc_lHabContas, loc_lContaVazia, loc_lSContaVazia
        loc_lHabContas = par_lEditar AND THIS.this_lAlteraContas

        IF VARTYPE(THIS.txt_4c_Conta) = "O"
            loc_lContaVazia = EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
        ELSE
            loc_lContaVazia = .T.
        ENDIF

        IF VARTYPE(THIS.txt_4c_SCONTA) = "O"
            loc_lSContaVazia = EMPTY(ALLTRIM(THIS.txt_4c_SCONTA.Value))
        ELSE
            loc_lSContaVazia = .T.
        ENDIF

        IF VARTYPE(THIS.txt_4c_Grupo) = "O"
            THIS.txt_4c_Grupo.Enabled  = loc_lHabContas
        ENDIF
        IF VARTYPE(THIS.txt_4c_Dgrupo) = "O"
            THIS.txt_4c_Dgrupo.Enabled = loc_lHabContas AND loc_lContaVazia
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta) = "O"
            THIS.txt_4c_Conta.Enabled  = loc_lHabContas
        ENDIF
        IF VARTYPE(THIS.txt_4c_Dconta) = "O"
            THIS.txt_4c_Dconta.Enabled = loc_lHabContas AND loc_lContaVazia
        ENDIF
        IF VARTYPE(THIS.txt_4c_SGRUPO) = "O"
            THIS.txt_4c_SGRUPO.Enabled  = loc_lHabContas
        ENDIF
        IF VARTYPE(THIS.txt_4c_Sdgrupo) = "O"
            THIS.txt_4c_Sdgrupo.Enabled = loc_lHabContas AND loc_lSContaVazia
        ENDIF
        IF VARTYPE(THIS.txt_4c_SCONTA) = "O"
            THIS.txt_4c_SCONTA.Enabled  = loc_lHabContas
        ENDIF
        IF VARTYPE(THIS.txt_4c_SDCONTA) = "O"
            THIS.txt_4c_SDCONTA.Enabled = loc_lHabContas AND loc_lSContaVazia
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column2.ReadOnly = !(par_lEditar AND THIS.this_lAlteraJuros)
            THIS.grd_4c_Dados.Column7.ReadOnly = !(par_lEditar AND THIS.this_lAlteraJuros)
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos TextBox do formulario
    *==========================================================================
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.txt_4c_OPER) = "O"
            THIS.txt_4c_OPER.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Grupo) = "O"
            THIS.txt_4c_Grupo.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Dgrupo) = "O"
            THIS.txt_4c_Dgrupo.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta) = "O"
            THIS.txt_4c_Conta.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Dconta) = "O"
            THIS.txt_4c_Dconta.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_SOPER) = "O"
            THIS.txt_4c_SOPER.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_SGRUPO) = "O"
            THIS.txt_4c_SGRUPO.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Sdgrupo) = "O"
            THIS.txt_4c_Sdgrupo.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_SCONTA) = "O"
            THIS.txt_4c_SCONTA.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_SDCONTA) = "O"
            THIS.txt_4c_SDCONTA.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Propaga campos de conta do form para crTmpJuros (debito)
    * Atualiza Grupos/Contas em todas as linhas de crTmpJuros quando AlteraContas
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_cGrupoD, loc_cContaD, loc_oErro
        loc_cGrupoD = ""
        loc_cContaD = ""

        TRY
            IF THIS.this_lAlteraContas AND USED("crTmpJuros")
                loc_cGrupoD = ALLTRIM(THIS.txt_4c_Grupo.Value)
                loc_cContaD = ALLTRIM(THIS.txt_4c_Conta.Value)

                IF !EMPTY(loc_cGrupoD) OR !EMPTY(loc_cContaD)
                    SELECT crTmpJuros
                    GO TOP
                    DO WHILE !EOF()
                        IF !EMPTY(loc_cGrupoD)
                            REPLACE Grupos WITH loc_cGrupoD
                        ENDIF
                        IF !EMPTY(loc_cContaD)
                            REPLACE Contas WITH loc_cContaD
                        ENDIF
                        SKIP
                    ENDDO
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao propagar dados para cursor:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "FormSigReJur.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Recarrega campos do form a partir dos cursores do form pai
    *==========================================================================
    PROCEDURE BOParaForm()
        THIS.InicializarValores()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Refresca dados do grid de juros
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o subformulario (equivale ao botao Ok)
    * Original: Confirma.Click -> ThisForm.Release
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma alteracoes de conta e encerra o subformulario
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Encerra sem propagar alteracoes de conta para crTmpJuros
    * Edicoes diretas no grid (Hists/Juros) ja estao no cursor e nao sao revertidas
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
