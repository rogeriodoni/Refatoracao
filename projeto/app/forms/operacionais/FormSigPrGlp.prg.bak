*==============================================================================
* FormSigPrGlp.prg - Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o / Reserva
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* Herda de: FormBase
* Legado: SigPrGlp.SCX
*
* Parametros Init:
*   par_oParentForm  - referencia ao form pai
*   par_dData        - data (nao usada; datas vem do avo via par_oParentForm.ParentForm)
*   par_lReserva     - .T. = modo Reserva Automatica; .F. = Globalizacao
*   par_nEmphpdr     - codigo de empresa preferida para globalizacao
*   par_lAutomatico  - modo automatico
*   par_nNumerodaop  - numero da OP (0 = gerar automatico)
*
* Cursors esperados do form pai (datasession compartilhada):
*   TmpFinal  - itens a globalizar/reservar
*   TmpSaldo  - saldo disponivel por produto/cor/tam
*   TmpSaldG  - saldo disponivel por grupo/conta/produto
*   SelPedra  - requisicoes de componentes adicionais
*   crSigCdPam, crSigCdPac - parametros do sistema
*==============================================================================

DEFINE CLASS FormSigPrGlp AS FormBase

    *-- Dimensoes (legado: Width=1000, Height=600)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    ClipControls = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Flags de modo de operacao
    this_lReserva    = .F.
    this_lAutomatico = .F.
    this_nEmphpdr    = 0
    this_nNumerodaop = 0

    *-- Referencia ao form pai
    this_oParentForm = .NULL.

    *==========================================================================
    * Init - compartilha datasession do pai e repassa parametros
    *==========================================================================
    PROCEDURE Init(par_oParentForm, par_dData, par_lReserva, par_nEmphpdr, par_lAutomatico, par_nNumerodaop)
        IF VARTYPE(par_oParentForm) = "O"
            THIS.DataSessionId = par_oParentForm.DataSessionId
        ENDIF
        THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
        THIS.this_nEmphpdr    = IIF(VARTYPE(par_nEmphpdr)    = "N", par_nEmphpdr,    0)
        THIS.this_nNumerodaop = IIF(VARTYPE(par_nNumerodaop) = "N", par_nNumerodaop, 0)
        THIS.this_oParentForm = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)
        IF THIS.this_lReserva
            THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
        ELSE
            THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - criado pelo FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGlpBO.", "Erro")
            ELSE
                WITH THIS.this_oBusinessObject
                    .this_lReserva    = THIS.this_lReserva
                    .this_lAutomatico = THIS.this_lAutomatico
                    .this_nNumerodaop = THIS.this_nNumerodaop
                    .this_cEmphpdr    = TRANSFORM(THIS.this_nEmphpdr)
                    .this_oParentForm = THIS.this_oParentForm
                ENDWITH
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoesPrincipais()
                THIS.ConfigurarGradeItens()
                THIS.ConfigurarContainerInfo()
                THIS.ConfigurarContainerDisponivel()
                THIS.ConfigurarContainerEstoques()
                THIS.ConfigurarContainerLinhas()
                THIS.ConfigurarContainerRequisicoes()
                THIS.ConfigurarTotais()
                THIS.ConfigurarObsItens()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis()
                THIS.InicializarDados()
                THIS.ConfigurarEventos()
                THIS.AjustarBotaoPedras()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - ancora de layout do form OPERACIONAL
    *
    * OPERACIONAL nao possui PageFrame (layout flat: containers direto no Form).
    * Este metodo faz o papel equivalente ao ConfigurarPageFrame dos forms CRUD:
    * define a imagem de fundo do Form antes de instanciar os containers filhos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - equivale ao cntSombra legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = 1004
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100,100,100)
            .BorderWidth = 0
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = THISFORM.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width
                .ForeColor = RGB(0,0,0)
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = THISFORM.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width
                .ForeColor = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesPrincipais - 7 botoes da barra superior
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
        LOCAL loc_lcIcones
        loc_lcIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmd_4c_Requisicoes", "CommandButton")
        WITH THIS.cmd_4c_Requisicoes
            .Top             = 3
            .Left            = 472
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "\<Requisi" + CHR(231) + CHR(245) + "es"
            .Picture         = loc_lcIcones + "geral_datas_60.jpg"
            .DisabledPicture = loc_lcIcones + "geral_datas_60.jpg"
            .Themes          = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Enabled         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Estoques", "CommandButton")
        WITH THIS.cmd_4c_Estoques
            .Top             = 3
            .Left            = 547
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "\<Estoques"
            .Picture         = loc_lcIcones + "geral_marcar_60.jpg"
            .DisabledPicture = loc_lcIcones + "geral_marcar_60.jpg"
            .Themes          = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Enabled         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Disponiveis", "CommandButton")
        WITH THIS.cmd_4c_Disponiveis
            .Top             = 3
            .Left            = 622
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "\<Dispon" + CHR(237) + "veis"
            .Picture         = loc_lcIcones + "geral_palete_60.jpg"
            .DisabledPicture = loc_lcIcones + "geral_palete_60.jpg"
            .Themes          = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
        ENDWITH

        THIS.AddObject("cmd_4c_LinhasTot", "CommandButton")
        WITH THIS.cmd_4c_LinhasTot
            .Top             = 3
            .Left            = 697
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "\<Total/Linhas"
            .Picture         = loc_lcIcones + "geral_grafico_pizza_60.jpg"
            .DisabledPicture = loc_lcIcones + "geral_grafico_pizza_60.jpg"
            .Themes          = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
        ENDWITH

        THIS.AddObject("cmd_4c_Relatorio", "CommandButton")
        WITH THIS.cmd_4c_Relatorio
            .Top             = 3
            .Left            = 772
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "\<Relat" + CHR(243) + "rio"
            .Picture         = loc_lcIcones + "geral_impressora_60.jpg"
            .DisabledPicture = loc_lcIcones + "geral_impressora_60.jpg"
            .Themes          = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
        ENDWITH

        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 847
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "\<Processar"
            .Picture         = loc_lcIcones + "geral_processar_60.jpg"
            .DisabledPicture = loc_lcIcones + "geral_processar_60.jpg"
            .Themes          = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 922
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_lcIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGradeItens - grid principal TmpFinal (9 colunas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeItens()
        THIS.AddObject("grd_4c_Itens", "Grid")
        THIS.grd_4c_Itens.ColumnCount = 9
        WITH THIS.grd_4c_Itens
            .Top               = 125
            .Left              = 11
            .Height            = 224
            .Width             = 708
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .Panel             = 1
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238,238,238)
            WITH .Column1
                .Width              = 115
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Header1.Caption    = "Produto"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontSize     = 8
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
            WITH .Column2
                .ColumnOrder        = 2
                .Width              = 38
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Header1.Caption    = "Cor"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontSize     = 8
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
            WITH .Column3
                .ColumnOrder        = 4
                .Width              = 150
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Header1.Caption    = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontSize     = 8
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
            WITH .Column4
                .ColumnOrder        = 5
                .Width              = 50
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Header1.Caption    = "C" + CHR(243) + "digo"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontSize     = 8
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
            WITH .Column5
                .ColumnOrder        = 6
                .Width              = 80
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Header1.Caption    = "Quantidade"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontBold     = .T.
                .Text1.FontSize     = 8
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
            WITH .Column6
                .ColumnOrder        = 8
                .Width              = 80
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .F.
                .BackColor          = RGB(221,252,255)
                .Header1.Caption    = "Produzir"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontBold     = .T.
                .Text1.FontSize     = 8
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(221,252,255)
            ENDWITH
            WITH .Column7
                .ColumnOrder        = 7
                .Width              = 80
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .BackColor          = RGB(255,253,179)
                .Header1.Caption    = "Estoque"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontBold     = .T.
                .Text1.FontSize     = 8
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,253,179)
            ENDWITH
            WITH .Column8
                .ColumnOrder        = 9
                .Width              = 38
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Alignment          = 2
                .Header1.Caption    = "Obs"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontBold     = .T.
                .Text1.FontSize     = 8
                .Text1.Alignment    = 2
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
            WITH .Column9
                .ColumnOrder        = 3
                .Width              = 38
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Header1.Caption    = "Tam"
                .Header1.FontName   = "Verdana"
                .Header1.FontSize   = 8
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(36,84,155)
                .Text1.FontSize     = 8
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerInfo - Container3: painel informativo sempre visivel
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerInfo()
        THIS.AddObject("cnt_4c_Info", "Container")
        WITH THIS.cnt_4c_Info
            .Top         = 373
            .Left        = 12
            .Width       = 708
            .Height      = 205
            .SpecialEffect = 0
            .BackStyle   = 1
            .BackColor   = RGB(255,255,255)
            .BorderWidth = 0

            .AddObject("lbl_4c_TituloInfo", "Label")
            WITH .lbl_4c_TituloInfo
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 9
                .BackStyle = 0
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 16
                .Left      = 6
                .Top       = 5
                .Width     = 118
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("grd_4c_DispInfo", "Grid")
            .grd_4c_DispInfo.ColumnCount = 6
            WITH .grd_4c_DispInfo
                .Top               = 24
                .Left              = 6
                .Height            = 148
                .Width             = 444
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .Panel             = 1
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238,238,238)
                WITH .Column1
                    .ColumnOrder        = 2
                    .Width              = 74
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Grupo"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column2
                    .ColumnOrder        = 3
                    .Width              = 74
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Conta"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column3
                    .ColumnOrder        = 4
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Atual"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column4
                    .ColumnOrder        = 5
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Utilizado"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column5
                    .ColumnOrder        = 6
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .F.
                    .BackColor          = RGB(255,253,179)
                    .Header1.Caption    = "Dispon" + CHR(237) + "vel"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .F.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,253,179)
                ENDWITH
                WITH .Column6
                    .ColumnOrder        = 1
                    .Width              = 30
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Emp"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
            ENDWITH

            .AddObject("txt_4c_DGrupoInfo", "TextBox")
            WITH .txt_4c_DGrupoInfo
                .Height        = 23
                .Left          = 454
                .SpecialEffect = 1
                .Top           = 106
                .Width         = 247
                .ReadOnly      = .T.
                .Value         = ""
            ENDWITH

            .AddObject("txt_4c_DContaInfo", "TextBox")
            WITH .txt_4c_DContaInfo
                .Height        = 23
                .Left          = 454
                .SpecialEffect = 1
                .Top           = 147
                .Width         = 247
                .ReadOnly      = .T.
                .Value         = ""
            ENDWITH

            .AddObject("txt_4c_TotQtdInfo", "TextBox")
            WITH .txt_4c_TotQtdInfo
                .Height        = 23
                .InputMask     = "99,999.99"
                .Left          = 188
                .SpecialEffect = 1
                .Top           = 173
                .Width         = 80
                .ReadOnly      = .T.
                .Value         = 0
            ENDWITH

            .AddObject("txt_4c_TotEstInfo", "TextBox")
            WITH .txt_4c_TotEstInfo
                .Height        = 23
                .InputMask     = "99,999.99"
                .Left          = 269
                .SpecialEffect = 1
                .Top           = 173
                .Width         = 80
                .ReadOnly      = .T.
                .Value         = 0
            ENDWITH

            .AddObject("txt_4c_TotPrzInfo", "TextBox")
            WITH .txt_4c_TotPrzInfo
                .Height        = 23
                .InputMask     = "99,999.99"
                .Left          = 350
                .SpecialEffect = 1
                .Top           = 173
                .Width         = 80
                .ReadOnly      = .T.
                .Value         = 0
            ENDWITH

            .AddObject("lbl_4c_GrupoInfo", "Label")
            WITH .lbl_4c_GrupoInfo
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Grupo"
                .Height    = 15
                .Left      = 454
                .Top       = 90
                .Width     = 36
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_ContaInfo", "Label")
            WITH .lbl_4c_ContaInfo
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Conta"
                .Height    = 15
                .Left      = 454
                .Top       = 131
                .Width     = 35
                .ForeColor = RGB(90,90,90)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerDisponivel - Container2: disponivel por produto
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerDisponivel()
        LOCAL loc_lcIcones
        loc_lcIcones = gc_4c_CaminhoIcones
        THIS.AddObject("cnt_4c_Disponivel", "Container")
        WITH THIS.cnt_4c_Disponivel
            .Top         = 125
            .Left        = 12
            .Width       = 708
            .Height      = 465
            .SpecialEffect = 0
            .Visible     = .F.
            .BackStyle   = 1
            .BackColor   = RGB(255,255,255)
            .BorderWidth = 0

            .AddObject("lbl_4c_TituloDisp", "Label")
            WITH .lbl_4c_TituloDisp
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 18
                .Left      = 610
                .Top       = 10
                .Width     = 123
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("cmd_4c_SairDisp", "CommandButton")
            WITH .cmd_4c_SairDisp
                .Top             = 3
                .Left            = 620
                .Height          = 75
                .Width           = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = loc_lcIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Sair"
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
            ENDWITH

            .AddObject("grd_4c_DispProd", "Grid")
            .grd_4c_DispProd.ColumnCount = 5
            WITH .grd_4c_DispProd
                .Top               = 32
                .Left              = 169
                .Height            = 388
                .Width             = 370
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .Panel             = 1
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238,238,238)
                WITH .Column1
                    .Width              = 108
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Produto"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column2
                    .ColumnOrder        = 2
                    .Width              = 38
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Cor"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontBold     = .T.
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column3
                    .ColumnOrder        = 3
                    .Width              = 38
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Tam"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontBold     = .T.
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column4
                    .ColumnOrder        = 4
                    .Width              = 75
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Disponivel"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column5
                    .ColumnOrder        = 5
                    .Width              = 75
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .F.
                    .Header1.Caption    = "Utilizar"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontBold     = .T.
                    .Text1.FontSize     = 8
                    .Text1.Alignment    = 3
                    .Text1.BorderStyle  = 0
                    .Text1.Value        = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .F.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
            ENDWITH

            .AddObject("lbl_4c_ProduzirDisp", "Label")
            WITH .lbl_4c_ProduzirDisp
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Qtde " + CHR(224) + " Produzir :"
                .Height    = 15
                .Left      = 168
                .Top       = 432
                .Width     = 84
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_UtilizarDisp", "Label")
            WITH .lbl_4c_UtilizarDisp
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Qtde " + CHR(224) + " Utilizar :"
                .Height    = 17
                .Left      = 365
                .Top       = 431
                .Width     = 109
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("txt_4c_PedidaDisp", "TextBox")
            WITH .txt_4c_PedidaDisp
                .Height        = 23
                .Left          = 268
                .SpecialEffect = 1
                .Top           = 428
                .Width         = 80
                .ReadOnly      = .T.
                .Value         = 0
            ENDWITH

            .AddObject("txt_4c_SelecDisp", "TextBox")
            WITH .txt_4c_SelecDisp
                .Height        = 23
                .Left          = 458
                .SpecialEffect = 1
                .Top           = 428
                .Width         = 80
                .ReadOnly      = .T.
                .Value         = 0
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerEstoques - Container5: disponivel por conta/grupo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerEstoques()
        LOCAL loc_lcIcones
        loc_lcIcones = gc_4c_CaminhoIcones
        THIS.AddObject("cnt_4c_Estoques", "Container")
        WITH THIS.cnt_4c_Estoques
            .Top         = 125
            .Left        = 12
            .Width       = 708
            .Height      = 465
            .SpecialEffect = 0
            .Visible     = .F.
            .BackStyle   = 1
            .BackColor   = RGB(255,255,255)
            .BorderWidth = 0

            .AddObject("lbl_4c_TituloEstq", "Label")
            WITH .lbl_4c_TituloEstq
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 18
                .Left      = 284
                .Top       = 10
                .Width     = 123
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("cmd_4c_OkEstq", "CommandButton")
            WITH .cmd_4c_OkEstq
                .Top             = 3
                .Left            = 620
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = loc_lcIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = loc_lcIcones + "cadastro_salvar_60.jpg"
                .Cancel          = .T.
                .Caption         = "OK"
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
            ENDWITH

            .AddObject("grd_4c_DispEstq", "Grid")
            .grd_4c_DispEstq.ColumnCount = 5
            WITH .grd_4c_DispEstq
                .Top               = 32
                .Left              = 141
                .Height            = 372
                .Width             = 425
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238,238,238)
                WITH .Column1
                    .ColumnOrder        = 2
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Grupo"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .T.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column2
                    .ColumnOrder        = 3
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Conta"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .T.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column3
                    .ColumnOrder        = 1
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Prioridade"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .T.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column4
                    .ColumnOrder        = 4
                    .Width              = 75
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Dispon" + CHR(237) + "vel"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .T.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column5
                    .ColumnOrder        = 5
                    .Width              = 75
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .F.
                    .Header1.Caption    = "Utilizar"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontBold     = .T.
                    .Text1.FontSize     = 8
                    .Text1.Alignment    = 3
                    .Text1.BorderStyle  = 0
                    .Text1.Value        = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .F.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
            ENDWITH

            .AddObject("lbl_4c_ProduzirEstq", "Label")
            WITH .lbl_4c_ProduzirEstq
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Produzir :"
                .Height    = 15
                .Left      = 428
                .Top       = 413
                .Width     = 48
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_UtilizarEstq", "Label")
            WITH .lbl_4c_UtilizarEstq
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Utilizar :"
                .Height    = 15
                .Left      = 435
                .Top       = 438
                .Width     = 41
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_GrupoEstq", "Label")
            WITH .lbl_4c_GrupoEstq
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Grupo :"
                .Height    = 15
                .Left      = 93
                .Top       = 413
                .Width     = 38
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_ContaEstq", "Label")
            WITH .lbl_4c_ContaEstq
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Conta :"
                .Height    = 15
                .Left      = 93
                .Top       = 438
                .Width     = 38
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("txt_4c_DGrupoEstq", "TextBox")
            WITH .txt_4c_DGrupoEstq
                .Height        = 23
                .Left          = 141
                .SpecialEffect = 1
                .Top           = 409
                .Width         = 277
                .ReadOnly      = .T.
                .Value         = ""
            ENDWITH

            .AddObject("txt_4c_DContaEstq", "TextBox")
            WITH .txt_4c_DContaEstq
                .Height        = 23
                .Left          = 141
                .SpecialEffect = 1
                .Top           = 434
                .Width         = 277
                .ReadOnly      = .T.
                .Value         = ""
            ENDWITH

            .AddObject("txt_4c_PedidaEstq", "TextBox")
            WITH .txt_4c_PedidaEstq
                .Height        = 23
                .Left          = 486
                .SpecialEffect = 1
                .Top           = 409
                .Width         = 80
                .ReadOnly      = .T.
                .Value         = 0
            ENDWITH

            .AddObject("txt_4c_SelecEstq", "TextBox")
            WITH .txt_4c_SelecEstq
                .Height        = 23
                .Left          = 486
                .SpecialEffect = 1
                .Top           = 434
                .Width         = 80
                .ReadOnly      = .T.
                .Value         = 0
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerLinhas - Container1: pecas por linha
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerLinhas()
        LOCAL loc_lcIcones
        loc_lcIcones = gc_4c_CaminhoIcones
        THIS.AddObject("cnt_4c_Linhas", "Container")
        WITH THIS.cnt_4c_Linhas
            .Top         = 125
            .Left        = 12
            .Width       = 708
            .Height      = 465
            .SpecialEffect = 0
            .Visible     = .F.
            .BackStyle   = 1
            .BackColor   = RGB(255,255,255)
            .BorderWidth = 0

            .AddObject("lbl_4c_TituloLin", "Label")
            WITH .lbl_4c_TituloLin
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Pe" + CHR(231) + "as a produzir por linha"
                .Height    = 18
                .Left      = 259
                .Top       = 10
                .Width     = 170
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("cmd_4c_OkLinhas", "CommandButton")
            WITH .cmd_4c_OkLinhas
                .Top             = 3
                .Left            = 620
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = loc_lcIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = loc_lcIcones + "cadastro_salvar_60.jpg"
                .Cancel          = .T.
                .Caption         = "OK"
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
            ENDWITH

            .AddObject("grd_4c_LinhasAgg", "Grid")
            .grd_4c_LinhasAgg.ColumnCount = 4
            WITH .grd_4c_LinhasAgg
                .Top               = 32
                .Left              = 174
                .Height            = 420
                .Width             = 359
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ReadOnly          = .T.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238,238,238)
                WITH .Column1
                    .Width              = 84
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Sparse             = .F.
                    .Header1.Caption    = "Linha"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontName     = "Arial"
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column2
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Sparse             = .F.
                    .Header1.Caption    = "Quantidade"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.InputMask    = "999,999.99"
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column3
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Sparse             = .F.
                    .Header1.Caption    = "Estoque"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontName     = "Arial"
                    .Text1.FontSize     = 8
                    .Text1.InputMask    = "999,999.99"
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column4
                    .Width              = 80
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Sparse             = .F.
                    .Header1.Caption    = "Produzir"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontName     = "Arial"
                    .Text1.FontSize     = 8
                    .Text1.InputMask    = "999,999.99"
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerRequisicoes - Container4: componentes adicionais
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerRequisicoes()
        LOCAL loc_lcIcones
        loc_lcIcones = gc_4c_CaminhoIcones
        THIS.AddObject("cnt_4c_Requisicoes", "Container")
        WITH THIS.cnt_4c_Requisicoes
            .Top         = 125
            .Left        = 12
            .Width       = 708
            .Height      = 465
            .SpecialEffect = 0
            .Visible     = .F.
            .BackStyle   = 1
            .BackColor   = RGB(255,255,255)
            .BorderWidth = 0

            .AddObject("lbl_4c_TituloReq", "Label")
            WITH .lbl_4c_TituloReq
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
                .Height    = 18
                .Left      = 229
                .Top       = 8
                .Width     = 249
                .ForeColor = RGB(90,90,90)
            ENDWITH

            .AddObject("cmd_4c_SairReq", "CommandButton")
            WITH .cmd_4c_SairReq
                .Top             = 3
                .Left            = 620
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = loc_lcIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Sair"
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
            ENDWITH

            .AddObject("grd_4c_PedraReq", "Grid")
            .grd_4c_PedraReq.ColumnCount = 5
            WITH .grd_4c_PedraReq
                .Top               = 32
                .Left              = 9
                .Height            = 420
                .Width             = 605
                .FontSize          = 8
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238,238,238)
                WITH .Column1
                    .Width              = 108
                    .Movable            = .F.
                    .Resizable          = .F.
                    .Header1.Caption    = "Produto"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column2
                    .ColumnOrder        = 2
                    .Width              = 249
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontBold     = .T.
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .T.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column3
                    .ColumnOrder        = 3
                    .Width              = 30
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .T.
                    .Header1.Caption    = "Uni"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontBold     = .T.
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ReadOnly     = .T.
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column4
                    .ColumnOrder        = 4
                    .Width              = 75
                    .Movable            = .F.
                    .Resizable          = .F.
                    .ReadOnly           = .F.
                    .Header1.Caption    = "Qtde"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
                WITH .Column5
                    .ColumnOrder        = 5
                    .Width              = 108
                    .Movable            = .F.
                    .Resizable          = .F.
                    .Header1.Caption    = "Produto"
                    .Header1.FontName   = "Verdana"
                    .Header1.FontSize   = 8
                    .Header1.Alignment  = 2
                    .Header1.ForeColor  = RGB(36,84,155)
                    .Text1.FontSize     = 8
                    .Text1.BorderStyle  = 0
                    .Text1.Margin       = 0
                    .Text1.ForeColor    = RGB(0,0,0)
                    .Text1.BackColor    = RGB(255,255,255)
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarTotais - 3 textboxes de totais (Tot_Qtd, Tot_Est, Tot_Prz)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTotais()
        THIS.AddObject("txt_4c_TotQtd", "TextBox")
        WITH THIS.txt_4c_TotQtd
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 417
            .SpecialEffect = 1
            .Top           = 349
            .Width         = 80
            .ReadOnly      = .T.
            .Value         = 0
        ENDWITH

        THIS.AddObject("txt_4c_TotEst", "TextBox")
        WITH THIS.txt_4c_TotEst
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 498
            .SpecialEffect = 1
            .Top           = 349
            .Width         = 81
            .ReadOnly      = .T.
            .Value         = 0
        ENDWITH

        THIS.AddObject("txt_4c_TotPrz", "TextBox")
        WITH THIS.txt_4c_TotPrz
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 580
            .SpecialEffect = 1
            .Top           = 349
            .Width         = 82
            .ReadOnly      = .T.
            .Value         = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarObsItens - imagem do produto + area de observacoes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarObsItens()
        THIS.AddObject("img_4c_Figura", "Image")
        WITH THIS.img_4c_Figura
            .Stretch = 1
            .Height  = 204
            .Left    = 726
            .Top     = 125
            .Visible = .F.
            .Width   = 266
        ENDWITH

        THIS.AddObject("lbl_4c_ObsItens", "Label")
        WITH THIS.lbl_4c_ObsItens
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
            .Height    = 15
            .Left      = 726
            .Top       = 369
            .Width     = 134
            .ForeColor = RGB(255,255,255)
        ENDWITH

        THIS.AddObject("edt_4c_Obs", "EditBox")
        WITH THIS.edt_4c_Obs
            .Height = 205
            .Left   = 732
            .Top    = 361
            .Width  = 266
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Fase 5/8: elementos decorativos complementares
    *
    * Para form OPERACIONAL flat (sem PageFrame/Page2 de CRUD), este metodo
    * adiciona elementos visuais secundarios sobrepostos ao layout principal.
    * Fase 5 (primeira metade): Shape2 - decoracao superior esquerda do header.
    *   Corresponde ao Shape2 do legado: top=9, left=9, 279x51
    *   Posicionado sobre o cnt_4c_Cabecalho para criar destaque visual na
    *   area de titulo/empresa, conforme o original SIGPRGLP.SCX.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top           = 9
                .Left          = 9
                .Height        = 51
                .Width         = 279
                .SpecialEffect = 0
                .BorderStyle   = 1
                .BorderWidth   = 1
                .BorderColor   = RGB(160,160,160)
                .FillStyle     = 0
                .FillColor     = RGB(80,80,80)
                .BackStyle     = 0
                .Curvature     = 5
            ENDWITH

            THIS.AddObject("shp_4c_Shape3", "Shape")
            WITH THIS.shp_4c_Shape3
                .Top           = 10
                .Left          = 820
                .Height        = 38
                .Width         = 116
                .SpecialEffect = 0
                .BorderStyle   = 1
                .BorderWidth   = 1
                .BorderColor   = RGB(160,160,160)
                .FillStyle     = 0
                .FillColor     = RGB(80,80,80)
                .BackStyle     = 0
                .Curvature     = 3
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - containers ocultos mantem filhos visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oCtrl, loc_cNome
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_i)
            loc_cNome = UPPER(loc_oCtrl.Name)
            IF INLIST(loc_cNome, "CNT_4C_DISPONIVEL", "CNT_4C_ESTOQUES", "CNT_4C_LINHAS", "CNT_4C_REQUISICOES")
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
                LOOP
            ENDIF
            IF UPPER(loc_oCtrl.BaseClass) = "CONTAINER"
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
            loc_oCtrl.Visible = .T.
        NEXT
    ENDPROC

    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            loc_oCtrl.Visible = .T.
            IF loc_oCtrl.BaseClass = "Container"
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        NEXT
    ENDPROC

    *==========================================================================
    * InicializarDados - ControlSources, queries iniciais, totais
    *==========================================================================
    PROTECTED PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_oErro, loc_nSal, loc_nEst, loc_nPrz, loc_lcQuery
        loc_lSucesso = .F.
        TRY
            *-- ControlSources GradeItens (mapeamento exato do legado)
            THIS.grd_4c_Itens.RecordSource = "TmpFinal"
            WITH THIS.grd_4c_Itens
                .Column1.ControlSource   = "TmpFinal.Cpros"
                .Column2.ControlSource   = "TmpFinal.CodCors"
                .Column3.ControlSource   = "TmpFinal.Dopes"
                .Column4.ControlSource   = "TmpFinal.Numes"
                .Column5.ControlSource   = "TmpFinal.Saldo"
                .Column6.ControlSource   = "TmpFinal.Produzir"
                .Column7.ControlSource   = "TmpFinal.Estoque"
                .Column8.ControlSource   = "IIF(EMPTY(TmpFinal.Obsps),' ','*')"
                .Column9.ControlSource   = "TmpFinal.CodTams"
            ENDWITH

            *-- Se TransfRes vazio, grid somente leitura
            IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
                IF EMPTY(ALLTRIM(crSigCdPam.TransfRes))
                    THIS.grd_4c_Itens.SetAll("ReadOnly", .T.)
                ENDIF
            ENDIF

            *-- TmpSaldG para Container3
            IF USED("TmpSaldG")
                SELECT TmpSaldG
                SET ORDER TO Cpros
                IF USED("TmpFinal") .AND. NOT EOF("TmpFinal")
                    SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
                ENDIF
                GO TOP
            ENDIF

            THIS.cnt_4c_Info.grd_4c_DispInfo.RecordSource = "TmpSaldG"
            WITH THIS.cnt_4c_Info.grd_4c_DispInfo
                .Column1.ControlSource   = "TmpSaldG.Grupos"
                .Column2.ControlSource   = "TmpSaldG.Estos"
                .Column3.ControlSource   = "TmpSaldG.Saldo"
                .Column4.ControlSource   = "TmpSaldG.Saldo - TmpSaldG.Disps"
                .Column5.ControlSource   = "TmpSaldG.Disps"
                .Column6.ControlSource   = "TmpSaldG.Emps"
                .SetAll("ReadOnly", .T.)
            ENDWITH

            *-- Cursor de rastreamento de selecao manual
            IF NOT USED("TmpSaldU")
                CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- ControlSource do EditBox de observacoes
            THIS.edt_4c_Obs.ControlSource = "TmpFinal.Obsps"

            *-- Calcular totais iniciais
            loc_nSal = 0
            loc_nEst = 0
            loc_nPrz = 0
            IF USED("TmpFinal")
                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO TOP
            ENDIF
            THIS.txt_4c_TotQtd.Value = loc_nSal
            THIS.txt_4c_TotEst.Value = loc_nEst
            THIS.txt_4c_TotPrz.Value = loc_nPrz

            *-- Carregar SigCdTpc + SigCdCom -> crSigCdCom
            IF NOT USED("crSigCdCom")
                loc_lcQuery = "SELECT a.Tipos, a.Custos, b.CGrus " + ;
                              "FROM SigCdTpc a, SigCdCom b " + ;
                              "WHERE a.Tipos = b.Tipos"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCom") > 0
                    SELECT crSigCdCom
                    INDEX ON Tipos + CGrus TAG Tipos
                ELSE
                    MsgErro("Falha ao carregar SigCdCom.", "Erro")
                ENDIF
            ENDIF

            *-- SigKey do pacote (usado em GravaHistorico)
            IF USED("CrSigCdPac") .AND. NOT EOF("CrSigCdPac")
                THIS.this_oBusinessObject.this_cSigKey = CrSigCdPac.sigKeys
            ENDIF

            *-- SelPedra: garantir pelo menos um registro
            IF USED("SelPedra") .AND. RECCOUNT("SelPedra") = 0
                SELECT SelPedra
                APPEND BLANK
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar dados: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotaoPedras - habilitar apenas se parametros completos
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotaoPedras()
        THIS.cmd_4c_Requisicoes.Enabled = .F.
        IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
            IF NOT EMPTY(ALLTRIM(crSigCdPam.DopEmphs)) .AND. ;
               NOT EMPTY(ALLTRIM(crSigCdPam.DopReqcs)) .AND. ;
               NOT EMPTY(ALLTRIM(crSigCdPam.DopPedcs)) .AND. ;
               NOT EMPTY(ALLTRIM(crSigCdPam.DopComps)) .AND. ;
               NOT THIS.this_lReserva
                THIS.cmd_4c_Requisicoes.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - BINDEVENT para todos os eventos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.grd_4c_Itens,                                     "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "When",              THIS, "GradeItensColumn6When")
        BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "Valid",             THIS, "GradeItensColumn6Valid")
        BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "KeyPress",         THIS, "GradeItensColumn6LostFocus")
        BINDEVENT(THIS.grd_4c_Itens.Column1.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
        BINDEVENT(THIS.grd_4c_Itens.Column2.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
        BINDEVENT(THIS.grd_4c_Itens.Column3.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
        BINDEVENT(THIS.grd_4c_Itens.Column4.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
        BINDEVENT(THIS.grd_4c_Itens.Column5.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
        BINDEVENT(THIS.grd_4c_Itens.Column7.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
        BINDEVENT(THIS.grd_4c_Itens.Column8.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
        BINDEVENT(THIS.grd_4c_Itens.Column9.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
        BINDEVENT(THIS.cnt_4c_Info.grd_4c_DispInfo,                      "AfterRowColChange", THIS, "GradeDispInfoAfterRowColChange")
        BINDEVENT(THIS.cnt_4c_Estoques.grd_4c_DispEstq,                  "AfterRowColChange", THIS, "GradeDispEstqAfterRowColChange")
        BINDEVENT(THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1,    "Valid",             THIS, "GradeDispEstqColumn5Valid")
        BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1,  "Valid",             THIS, "GradeDispProdColumn5Valid")
        BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column1.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
        BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column2.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
        BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column3.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
        BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column4.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
        BINDEVENT(THIS.cmd_4c_Disponiveis,                                "Click",             THIS, "CmdDisponiveisClick")
        BINDEVENT(THIS.cmd_4c_LinhasTot,                                  "Click",             THIS, "CmdLinhasTotClick")
        BINDEVENT(THIS.cmd_4c_Requisicoes,                                "Click",             THIS, "CmdRequisoesClick")
        BINDEVENT(THIS.cmd_4c_Estoques,                                   "Click",             THIS, "CmdEstoquesClick")
        BINDEVENT(THIS.cmd_4c_Relatorio,                                  "Click",             THIS, "CmdRelatorioClick")
        BINDEVENT(THIS.cmd_4c_Processar,                                  "Click",             THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,                                   "Click",             THIS, "CmdCancelarClick")
        BINDEVENT(THIS.cnt_4c_Estoques.cmd_4c_OkEstq,                    "Click",             THIS, "CancelarC5Click")
        BINDEVENT(THIS.cnt_4c_Disponivel.cmd_4c_SairDisp,                "Click",             THIS, "CancelarC2Click")
        BINDEVENT(THIS.cnt_4c_Requisicoes.cmd_4c_SairReq,                "Click",             THIS, "CancelarC4Click")
        BINDEVENT(THIS.cnt_4c_Linhas.cmd_4c_OkLinhas,                    "Click",             THIS, "CancelarC1Click")
        BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1, "Valid",             THIS, "GradePedra1Valid")
        BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "When",              THIS, "GradePedra5When")
        BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "Valid",             THIS, "GradePedra5Valid")
        BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "KeyPress",         THIS, "GradePedra5LostFocus")
        BINDEVENT(THIS.img_4c_Figura,                                     "DblClick",          THIS, "ImgFiguraDblClick")
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS
    *==========================================================================

    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        LOCAL loc_lcArquivo, loc_lcFoto, loc_oErro
        TRY
            THIS.edt_4c_Obs.Refresh
            THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)

            =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")

            IF USED("TmpSaldG")
                SELECT TmpSaldG
                SET ORDER TO Cpros
                SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
                GO TOP
            ENDIF

            WITH THIS.cnt_4c_Info
                .txt_4c_TotQtdInfo.Value = TmpSaldo.Saldo
                .txt_4c_TotEstInfo.Value = TmpSaldo.Saldo - TmpSaldo.Disps
                .txt_4c_TotPrzInfo.Value = TmpSaldo.Disps
                .lbl_4c_TituloInfo.Caption = TmpFinal.Cpros + ;
                    IIF(NOT EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
                    IIF(NOT EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")

                IF THIS.this_oBusinessObject.AtualizarInfoItem(par_nColIndex)
                    .txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo
                    .txt_4c_DContaInfo.Value = THIS.this_oBusinessObject.this_cDscConta
                ENDIF
                .grd_4c_DispInfo.Refresh
                .Visible     = .T.
            ENDWITH

            *-- Imagem do produto
            loc_lcArquivo = SYS(2023) + "\TempGlb.jpg"
            CLEAR RESOURCES
            THIS.img_4c_Figura.Picture = ""
            THIS.img_4c_Figura.Visible = .F.
            IF SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crSigProFig") > 0
                IF NOT EOF("crSigProFig")
                    IF NOT EMPTY(crSigProFig.FigJpgs) .AND. NOT ISNULL(crSigProFig.FigJpgs)
                        loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigProFig.FigJpgs, ;
                            "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                        IF STRTOFILE(loc_lcFoto, loc_lcArquivo) > 0
                            THIS.img_4c_Figura.Picture = loc_lcArquivo
                            THIS.img_4c_Figura.Visible = .T.
                        ENDIF
                    ENDIF
                ENDIF
                USE IN crSigProFig
            ENDIF

            SELECT TmpFinal
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE GradeItensRedirFoco()
        THIS.grd_4c_Itens.Column6.Text1.SetFocus
    ENDPROC

    PROCEDURE GradeDispProdRedirFoco()
        THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.SetFocus
    ENDPROC

    PROCEDURE GradeItensColumn6When()
        LOCAL loc_oErro
        THIS.this_oBusinessObject.this_nOldValue = THIS.grd_4c_Itens.Column6.Text1.Value
        IF THIS.this_lReserva .AND. (TmpFinal.Estoque = 0)
            TRY
                IF SQLEXEC(gnConnHandle, "SELECT CGrus FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crTmpPro") > 0
                    IF NOT EOF("crTmpPro")
                        IF SQLEXEC(gnConnHandle, "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crTmpPro.CGrus)), "crTmpGru") > 0
                            IF NOT EOF("crTmpGru")
                                IF INLIST(crTmpGru.TipoEstos, 3, 4)
                                    THIS.cmd_4c_Disponiveis.Enabled = .T.
                                ENDIF
                            ENDIF
                            USE IN crTmpGru
                        ENDIF
                    ENDIF
                    USE IN crTmpPro
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE GradeItensColumn6Valid()
        LOCAL loc_lResultado, loc_nNovoValor, loc_xBaixa, loc_oErro
        loc_lResultado = .T.
        loc_nNovoValor = THIS.grd_4c_Itens.Column6.Text1.Value
        TRY
            IF NOT SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
            ENDIF
            IF loc_nNovoValor <> THIS.this_oBusinessObject.this_nOldValue .AND. TmpSaldU.KeySelm
                IF NOT MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + CHR(13) + ;
                    "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?")
                    THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF loc_lResultado
                DO CASE
                    CASE loc_nNovoValor = THIS.this_oBusinessObject.this_nOldValue
                        *-- nenhuma mudanca
                    CASE loc_nNovoValor < 0
                        MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
                        THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                        loc_lResultado = .F.
                    CASE loc_nNovoValor > TmpFinal.Saldo
                        MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da Opera" + CHR(231) + CHR(227) + "o!!!", "")
                        THIS.grd_4c_Itens.Column6.Text1.Value = TmpFinal.Saldo - TmpFinal.Estoque
                        loc_lResultado = .F.
                    CASE NOT SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") .AND. ;
                         (TmpFinal.Produzir <> TmpFinal.Saldo)
                        MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
                        THIS.grd_4c_Itens.Column6.Text1.Value = TmpFinal.Saldo
                        loc_lResultado = .F.
                    OTHERWISE
                        IF (TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_nNovoValor)
                            REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
                            REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNovoValor IN TmpFinal
                            REPLACE KeySelm WITH .F. IN TmpSaldU
                            SELECT TmpSaldo
                            loc_xBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
                            SELECT TmpSaldG
                            SET ORDER TO Cpros
                            =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                            REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros .AND. ;
                                CodCors = TmpSaldo.CodCors .AND. CodTams = TmpSaldo.CodTams
                            =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                            SCAN WHILE Cpros = TmpSaldo.Cpros .AND. CodCors = TmpSaldo.CodCors .AND. ;
                                CodTams = TmpSaldo.CodTams .AND. loc_xBaixa > 0
                                IF TmpSaldG.Disps >= loc_xBaixa
                                    REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_xBaixa
                                    loc_xBaixa = 0
                                ELSE
                                    loc_xBaixa = loc_xBaixa - TmpSaldG.Disps
                                    REPLACE TmpSaldG.Disps WITH 0
                                ENDIF
                            ENDSCAN
                        ELSE
                            MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
                            THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                            loc_lResultado = .F.
                        ENDIF
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE GradeItensColumn6LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF NOT INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
        TRY
            SELECT TmpFinal
            loc_nRecno = RECNO()
            SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
            GO loc_nRecno
            THIS.txt_4c_TotQtd.Value = loc_nSal
            THIS.txt_4c_TotEst.Value = loc_nEst
            THIS.txt_4c_TotPrz.Value = loc_nPrz
            THIS.txt_4c_TotQtd.Refresh
            THIS.txt_4c_TotEst.Refresh
            THIS.txt_4c_TotPrz.Refresh
            THIS.Refresh
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE GradeDispInfoAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro
        TRY
            IF THIS.this_oBusinessObject.AtualizarInfoContainer3(par_nColIndex)
                THIS.cnt_4c_Info.txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo
                THIS.cnt_4c_Info.txt_4c_DContaInfo.Value = THIS.this_oBusinessObject.this_cDscConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE GradeDispEstqAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro
        TRY
            IF THIS.this_oBusinessObject.AtualizarInfoDisponivelConta(par_nColIndex)
                THIS.cnt_4c_Estoques.txt_4c_DGrupoEstq.Value = THIS.this_oBusinessObject.this_cDscGrupo
                THIS.cnt_4c_Estoques.txt_4c_DContaEstq.Value = THIS.this_oBusinessObject.this_cDscConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE GradeDispEstqColumn5Valid()
        LOCAL loc_lResultado, loc_nNovoValor, loc_nRegDisp, loc_nQtdUti, loc_oErro
        loc_lResultado = .T.
        loc_nNovoValor = THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value
        TRY
            IF loc_nNovoValor > TmpDisp.Disps
                MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "")
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
                loc_lResultado = .F.
            ELSE
                IF loc_nNovoValor < 0
                MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", "")
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
                loc_lResultado = .F.
            ELSE
                loc_nRegDisp = RECNO("TmpDisp")
                SUM TmpDisp.Utilizar TO loc_nQtdUti
                GO loc_nRegDisp IN TmpDisp
                IF loc_nQtdUti > TmpFinal.Saldo - TmpFinal.Estoque
                    MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "")
                    THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
                    THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
                    loc_lResultado = .F.
                ELSE
                    THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value = loc_nQtdUti
                    THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Refresh
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE GradeDispProdColumn5Valid()
        LOCAL loc_lResultado, loc_nNovoValor, loc_nRegDisp, loc_nQtdUti, loc_oErro
        loc_lResultado = .T.
        loc_nNovoValor = THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value
        TRY
            IF loc_nNovoValor > TmpDisp.Disps
                MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Disponivel!!!", "")
                THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value = 0
                THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Refresh
                loc_lResultado = .F.
            ELSE
                loc_nRegDisp = RECNO("TmpDisp")
                SUM TmpDisp.Utilizar TO loc_nQtdUti
                GO loc_nRegDisp IN TmpDisp
                IF loc_nQtdUti > TmpFinal.Saldo
                    MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Pedida!!!", "")
                    THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value = 0
                    THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Refresh
                    loc_lResultado = .F.
                ELSE
                    THIS.cnt_4c_Disponivel.txt_4c_SelecDisp.Value = loc_nQtdUti
                    THIS.cnt_4c_Disponivel.txt_4c_SelecDisp.Refresh
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *-- Disponivel.Click: abre Container2 com estoque por produto/cor/tam
    PROCEDURE CmdDisponiveisClick()
        LOCAL loc_oErro
        TRY
            THIS.this_oBusinessObject.BuscarDisponivel(TmpFinal.Cpros, TmpFinal.CodCors)
            IF NOT USED("TmpDisp") .OR. RECCOUNT("TmpDisp") = 0
                MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
                THIS.CancelarC2Click()
            ELSE
                THIS.cnt_4c_Disponivel.grd_4c_DispProd.ColumnCount = 5
                THIS.cnt_4c_Disponivel.grd_4c_DispProd.RecordSource = "TmpDisp"
                WITH THIS.cnt_4c_Disponivel.grd_4c_DispProd
                    .Column1.Width           = 80
                    .Column2.Width           = 38
                    .Column3.Width           = 24
                    .Column4.Width           = 75
                    .Column5.Width           = 75
                    .Column1.Header1.Caption = "Produto"
                    .Column2.Header1.Caption = "Cor"
                    .Column3.Header1.Caption = "Tam"
                    .Column4.Header1.Caption = "Disponivel"
                    .Column5.Header1.Caption = "Utilizar"
                    .Column1.ControlSource   = "TmpDisp.Cpros"
                    .Column2.ControlSource   = "TmpDisp.CodCors"
                    .Column3.ControlSource   = "TmpDisp.CodTams"
                    .Column4.ControlSource   = "TmpDisp.Disps"
                    .Column5.ControlSource   = "TmpDisp.Utilizar"
                ENDWITH
                THIS.cnt_4c_Disponivel.txt_4c_PedidaDisp.Value = TmpFinal.Saldo
                THIS.grd_4c_Itens.Enabled        = .F.
                THIS.cmd_4c_Processar.Enabled    = .F.
                THIS.cmd_4c_Cancelar.Enabled     = .F.
                THIS.cmd_4c_LinhasTot.Enabled    = .F.
                THIS.cmd_4c_Disponiveis.Enabled  = .F.
                THIS.cnt_4c_Info.Enabled         = .F.
                THIS.cnt_4c_Disponivel.Visible   = .T.
                THIS.cnt_4c_Disponivel.ZOrder(0)
                THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
                THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.SetFocus
                THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- TotLinha.Click: abre Container1 com total por linha de producao
    PROCEDURE CmdLinhasTotClick()
        LOCAL loc_oErro
        TRY
            THIS.this_oBusinessObject.BuscarPorLinhas()
            THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.ColumnCount = 4
            THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.RecordSource = "TmpLinha"
            WITH THIS.cnt_4c_Linhas.grd_4c_LinhasAgg
                .Column1.ControlSource = "TmpLinha.Linhas"
                .Column2.ControlSource = "TmpLinha.Saldo"
                .Column3.ControlSource = "TmpLinha.Estoque"
                .Column4.ControlSource = "TmpLinha.Produzir"
                .SetAll("DynamicFontBold",  "TmpLinha.Linhas=[TOTAIS]",                              "Column")
                .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas=[TOTAIS],RGB(0,0,255),RGB(0,0,0))", "Column")
            ENDWITH
            THIS.cmd_4c_Processar.Enabled   = .F.
            THIS.cmd_4c_Cancelar.Enabled    = .F.
            THIS.cmd_4c_LinhasTot.Enabled   = .F.
            THIS.cmd_4c_Requisicoes.Enabled = .F.
            THIS.cmd_4c_Disponiveis.Enabled = .F.
            THIS.grd_4c_Itens.Enabled       = .F.
            THIS.cnt_4c_Info.Enabled        = .F.
            THIS.cnt_4c_Linhas.Visible      = .T.
            THIS.cnt_4c_Linhas.ZOrder(0)
            THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Refresh
            THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Column1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- Pedras.Click: abre Container4 com requisicoes de componentes
    PROCEDURE CmdRequisoesClick()
        LOCAL loc_oErro
        TRY
            THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.ColumnCount = 5
            THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.RecordSource = "SelPedra"
            WITH THIS.cnt_4c_Requisicoes.grd_4c_PedraReq
                .Column1.ControlSource = "SelPedra.Cpros"
                .Column2.ControlSource = "SelPedra.Dpros"
                .Column3.ControlSource = "SelPedra.Cunis"
                .Column4.ControlSource = "SelPedra.Qtds"
                .Column5.ControlSource = "SelPedra.Cpro2s"
            ENDWITH
            THIS.cmd_4c_Processar.Enabled    = .F.
            THIS.cmd_4c_Cancelar.Enabled     = .F.
            THIS.cmd_4c_LinhasTot.Enabled    = .F.
            THIS.cmd_4c_Requisicoes.Enabled  = .F.
            THIS.cmd_4c_Disponiveis.Enabled  = .F.
            THIS.grd_4c_Itens.Enabled        = .F.
            THIS.cnt_4c_Info.Enabled         = .F.
            THIS.cnt_4c_Requisicoes.Visible  = .T.
            THIS.cnt_4c_Requisicoes.ZOrder(0)
            THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
            THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- SelEstoque.Click: abre Container5 com disponivel por conta/grupo
    PROCEDURE CmdEstoquesClick()
        LOCAL loc_oErro
        TRY
            THIS.this_oBusinessObject.BuscarEstoqueDetalhado(TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams)
            IF NOT USED("TmpDisp") .OR. RECCOUNT("TmpDisp") = 0
                MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
                THIS.CancelarC5Click()
            ELSE
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.ColumnCount = 5
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.RecordSource = "TmpDisp"
                WITH THIS.cnt_4c_Estoques.grd_4c_DispEstq
                    .Column1.Width           = 80
                    .Column2.Width           = 80
                    .Column3.Width           = 24
                    .Column4.Width           = 75
                    .Column5.Width           = 75
                    .Column1.Header1.Caption = "Grupo"
                    .Column2.Header1.Caption = "Conta"
                    .Column3.Header1.Caption = "Prioridade"
                    .Column4.Header1.Caption = "Disponivel"
                    .Column5.Header1.Caption = "Utilizar"
                    .Column1.ControlSource   = "TmpDisp.Grupos"
                    .Column2.ControlSource   = "TmpDisp.Estos"
                    .Column3.ControlSource   = "TmpDisp.Priors"
                    .Column4.ControlSource   = "TmpDisp.Disps"
                    .Column5.ControlSource   = "TmpDisp.Utilizar"
                ENDWITH
                THIS.cnt_4c_Estoques.lbl_4c_TituloEstq.Caption = ;
                    "Estoque Dispon" + CHR(237) + "vel (" + TmpFinal.Cpros + " " + TmpFinal.CodCors + "/" + TmpFinal.CodTams + ")"
                THIS.cnt_4c_Estoques.txt_4c_PedidaEstq.Value = TmpFinal.Saldo - TmpFinal.Estoque
                THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value  = 0
                THIS.cmd_4c_Processar.Enabled    = .F.
                THIS.cmd_4c_Cancelar.Enabled     = .F.
                THIS.cmd_4c_LinhasTot.Enabled    = .F.
                THIS.cmd_4c_Disponiveis.Enabled  = .F.
                THIS.cmd_4c_Estoques.Enabled     = .F.
                THIS.cmd_4c_Requisicoes.Enabled  = .F.
                THIS.cnt_4c_Info.Enabled         = .F.
                THIS.cnt_4c_Estoques.Visible     = .T.
                THIS.cnt_4c_Estoques.ZOrder(0)
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.SetFocus
                THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- btnRelatorio.Click: gerar relatorio SigReGlp
    PROCEDURE CmdRelatorioClick()
        LOCAL loc_oErro
        TRY
            THIS.this_oBusinessObject.GerarRelatorio()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- Processar.Click: executa globalizacao/reserva
    PROCEDURE CmdProcessarClick()
        LOCAL loc_dPrev, loc_dGera, loc_oPP, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
        loc_dPrev = {}
        loc_dGera = {}
        *-- Extrair datas do avo via PEMSTATUS para evitar CATCH silencioso
        IF VARTYPE(THIS.this_oParentForm) = "O"
            IF PEMSTATUS(THIS.this_oParentForm, "ParentForm", 5)
                loc_oPP = THIS.this_oParentForm.ParentForm
                IF VARTYPE(loc_oPP) = "O"
                    IF PEMSTATUS(loc_oPP, "Cnt_Previsao", 5)
                        IF PEMSTATUS(loc_oPP.Cnt_Previsao, "GetPrevisao", 5)
                            loc_dPrev = loc_oPP.Cnt_Previsao.GetPrevisao.Value
                        ENDIF
                        IF PEMSTATUS(loc_oPP.Cnt_Previsao, "GetGeracao", 5)
                            loc_dGera = loc_oPP.Cnt_Previsao.GetGeracao.Value
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        TRY
            IF THIS.this_oBusinessObject.Processar(loc_dPrev, loc_dGera)
                THIS.grd_4c_Itens.Refresh
                THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
                IF USED("TmpFinal")
                    SELECT TmpFinal
                    SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                    THIS.txt_4c_TotQtd.Value = loc_nSal
                    THIS.txt_4c_TotEst.Value = loc_nEst
                    THIS.txt_4c_TotPrz.Value = loc_nPrz
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- Cancelar.Click: fechar form sem processar
    PROCEDURE CmdCancelarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.Release
    ENDPROC

    *-- Container5 OK: confirmar selecao de estoque por conta/grupo
    PROCEDURE CancelarC5Click()
        LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
        TRY
            THIS.this_oBusinessObject.ConfirmarDisponivelSimples()
            IF USED("TmpFinal")
                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                THIS.txt_4c_TotQtd.Value = loc_nSal
                THIS.txt_4c_TotEst.Value = loc_nEst
                THIS.txt_4c_TotPrz.Value = loc_nPrz
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cmd_4c_Processar.Enabled    = .T.
        THIS.cmd_4c_Cancelar.Enabled     = .T.
        THIS.cmd_4c_LinhasTot.Enabled    = .T.
        THIS.cmd_4c_Estoques.Enabled     = .T.
        THIS.cmd_4c_Disponiveis.Enabled  = .T.
        THIS.cnt_4c_Info.Enabled         = .T.
        THIS.cnt_4c_Estoques.Visible     = .F.
        THIS.grd_4c_Itens.Enabled        = .T.
        THIS.grd_4c_Itens.ZOrder(0)
        THIS.grd_4c_Itens.Refresh
        THIS.grd_4c_Itens.Column6.SetFocus
    ENDPROC

    *-- Container2 Sair: confirmar selecao de disponivel por produto
    PROCEDURE CancelarC2Click()
        LOCAL loc_oErro
        TRY
            THIS.this_oBusinessObject.ConfirmarDisponivel()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.cmd_4c_Processar.Enabled    = .T.
        THIS.cmd_4c_Cancelar.Enabled     = .T.
        THIS.cmd_4c_LinhasTot.Enabled    = .T.
        THIS.cmd_4c_Requisicoes.Enabled  = .T.
        THIS.cmd_4c_Disponiveis.Enabled  = .T.
        THIS.cnt_4c_Info.Enabled         = .T.
        THIS.cnt_4c_Disponivel.Visible   = .F.
        THIS.grd_4c_Itens.Enabled        = .T.
        THIS.grd_4c_Itens.ZOrder(0)
        THIS.grd_4c_Itens.Refresh
        THIS.grd_4c_Itens.Column6.SetFocus
    ENDPROC

    *-- Container4 Sair: fechar painel de requisicoes
    PROCEDURE CancelarC4Click()
        THIS.cmd_4c_Processar.Enabled    = .T.
        THIS.cmd_4c_Cancelar.Enabled     = .T.
        THIS.cmd_4c_LinhasTot.Enabled    = .T.
        THIS.cmd_4c_Requisicoes.Enabled  = .T.
        THIS.cmd_4c_Disponiveis.Enabled  = .T.
        THIS.cnt_4c_Info.Enabled         = .T.
        THIS.cnt_4c_Requisicoes.Visible  = .F.
        THIS.grd_4c_Itens.Enabled        = .T.
        THIS.grd_4c_Itens.ZOrder(0)
        THIS.grd_4c_Itens.Refresh
        THIS.grd_4c_Itens.Column6.SetFocus
    ENDPROC

    *-- Container1 OK: fechar painel de linhas
    PROCEDURE CancelarC1Click()
        THIS.cmd_4c_Processar.Enabled    = .T.
        THIS.cmd_4c_Cancelar.Enabled     = .T.
        THIS.cmd_4c_Requisicoes.Enabled  = .T.
        THIS.cmd_4c_LinhasTot.Enabled    = .T.
        THIS.cmd_4c_Disponiveis.Enabled  = .T.
        THIS.cnt_4c_Linhas.Visible       = .F.
        THIS.cnt_4c_Info.Enabled         = .T.
        THIS.grd_4c_Itens.Enabled        = .T.
        THIS.grd_4c_Itens.ZOrder(0)
        THIS.grd_4c_Itens.Refresh
        THIS.grd_4c_Itens.Column6.SetFocus
    ENDPROC

    *-- GradePedra Column1.Text1 Valid: lookup produto
    PROCEDURE GradePedra1Valid()
        LOCAL loc_lResultado, loc_lcValor, loc_oForm, loc_oErro
        loc_lResultado = .T.
        TRY
            loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value))
            IF NOT EMPTY(loc_lcValor)
                IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup") > 0
                    IF NOT EOF("crProLookup")
                        THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = crProLookup.Cpros
                        REPLACE SelPedra.Dpros WITH crProLookup.DPros, ;
                                SelPedra.Cunis WITH crProLookup.Cunis IN SelPedra
                        USE IN crProLookup
                    ELSE
                        USE IN crProLookup
                        IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro") > 0
                            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                            IF VARTYPE(loc_oForm) = "O"
                                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro"
                                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                                loc_oForm.Show()
                                IF loc_oForm.this_lSelecionou
                                    THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = cursor_4c_BuscaPro.Cpros
                                    REPLACE SelPedra.Dpros WITH cursor_4c_BuscaPro.DPros, ;
                                            SelPedra.Cunis WITH cursor_4c_BuscaPro.Cunis IN SelPedra
                                ENDIF
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_BuscaPro")
                            USE IN cursor_4c_BuscaPro
                        ENDIF
                    ENDIF
                ENDIF
                THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *-- GradePedra Column5.Text1 When: salva valor anterior
    PROCEDURE GradePedra5When()
        THIS.this_oBusinessObject.this_nAntValue = THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value
        RETURN NOT EMPTY(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value)
    ENDPROC

    *-- GradePedra Column5.Text1 Valid: lookup produto substituto
    PROCEDURE GradePedra5Valid()
        LOCAL loc_lResultado, loc_lcValor, loc_oForm, loc_oErro
        loc_lResultado = .T.
        TRY
            loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value))
            IF NOT EMPTY(loc_lcValor)
                IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup2") > 0
                    IF NOT EOF("crProLookup2")
                        THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = crProLookup2.Cpros
                        USE IN crProLookup2
                    ELSE
                        USE IN crProLookup2
                        IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro2") > 0
                            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                            IF VARTYPE(loc_oForm) = "O"
                                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro2"
                                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                                loc_oForm.Show()
                                IF loc_oForm.this_lSelecionou
                                    THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = cursor_4c_BuscaPro2.Cpros
                                ENDIF
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_BuscaPro2")
                            USE IN cursor_4c_BuscaPro2
                        ENDIF
                    ENDIF
                ENDIF
                THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *-- GradePedra Column5.Text1 KeyPress: avancar para proximo registro ao confirmar
    PROCEDURE GradePedra5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF NOT INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        LOCAL loc_xPos, loc_oErro
        TRY
            SELECT SelPedra
            loc_xPos = RECNO()
            LOCATE FOR EMPTY(Cpros)
            IF EOF()
                APPEND BLANK
            ENDIF
            LOCATE FOR RECNO() = loc_xPos
            KEYBOARD "{DNARROW}"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- img_4c_Figura DblClick: zoom da imagem
    PROCEDURE ImgFiguraDblClick()
        IF NOT EMPTY(THIS.img_4c_Figura.Picture)
            MsgInfo(THIS.img_4c_Figura.Picture, "Zoom")
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - equivalente OPERACIONAL da Page1 Lista dos CRUD
    *
    * Este form eh OPERACIONAL flat (sem PageFrame): a "pagina lista" corresponde
    * a visao principal com barra de botoes superior + grade de itens central.
    * Este metodo compoe as tres pecas equivalentes ao Page1 de um CRUD:
    *   1) Barra de botoes principais (equivalente ao cnt_4c_Botoes CRUD)
    *   2) Grade principal (equivalente ao grd_4c_Lista CRUD)
    *   3) Container de totais + observacoes (rodape informativo)
    * Retorna o container de botoes principais como "ancora" da lista, para que
    * chamadores possam referenciar a barra CRUD-like sem precisar mudar layout.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Barra de botoes principais (equivalente a cnt_4c_Botoes do CRUD)
            IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)
                THIS.ConfigurarBotoesPrincipais()
            ENDIF
            *-- Grade principal (equivalente ao grid da Page1 do CRUD)
            IF NOT PEMSTATUS(THIS, "grd_4c_Itens", 5)
                THIS.ConfigurarGradeItens()
            ENDIF
            *-- Rodape com totais e observacoes
            IF NOT PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
                THIS.ConfigurarTotais()
            ENDIF
            IF NOT PEMSTATUS(THIS, "edt_4c_Obs", 5)
                THIS.ConfigurarObsItens()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao configurar pagina lista: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - navegacao entre "paginas" logicas do form OPERACIONAL
    *
    * Este form nao tem PageFrame fisico. As "paginas" sao containers flutuantes
    * (Visible=.F. por default) que sobrepoem a visao principal:
    *   par_nPagina = 1 -> Lista principal (esconde todos os containers)
    *   par_nPagina = 2 -> Container Disponivel (estoque por produto/cor/tam)
    *   par_nPagina = 3 -> Container Estoques (disponivel detalhado por conta)
    *   par_nPagina = 4 -> Container Linhas (total por linha de producao)
    *   par_nPagina = 5 -> Container Requisicoes (componentes adicionais)
    *   par_nPagina = 6 -> Container Info (rodape com totais)
    * Retorna .T. em sucesso, .F. em caso de parametro invalido ou erro.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 6
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina), "Aviso")
                loc_lResultado = .F.
            ENDIF
            *-- Sempre esconder todos os containers flutuantes primeiro
            IF PEMSTATUS(THIS, "cnt_4c_Disponivel", 5)
                THIS.cnt_4c_Disponivel.Visible  = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Estoques", 5)
                THIS.cnt_4c_Estoques.Visible    = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Linhas", 5)
                THIS.cnt_4c_Linhas.Visible      = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Requisicoes", 5)
                THIS.cnt_4c_Requisicoes.Visible = .F.
            ENDIF
            DO CASE
                CASE par_nPagina = 1
                    *-- Retorno a visao principal: reabilitar botoes e grade
                    IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
                        THIS.cmd_4c_Processar.Enabled   = .T.
                    ENDIF
                    IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
                        THIS.cmd_4c_Cancelar.Enabled    = .T.
                    ENDIF
                    IF PEMSTATUS(THIS, "cmd_4c_LinhasTot", 5)
                        THIS.cmd_4c_LinhasTot.Enabled   = .T.
                    ENDIF
                    IF PEMSTATUS(THIS, "cmd_4c_Requisicoes", 5)
                        THIS.cmd_4c_Requisicoes.Enabled = .T.
                    ENDIF
                    IF PEMSTATUS(THIS, "cmd_4c_Disponiveis", 5)
                        THIS.cmd_4c_Disponiveis.Enabled = .T.
                    ENDIF
                    IF PEMSTATUS(THIS, "cmd_4c_Estoques", 5)
                        THIS.cmd_4c_Estoques.Enabled    = .T.
                    ENDIF
                    IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
                        THIS.cnt_4c_Info.Enabled        = .T.
                    ENDIF
                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        THIS.grd_4c_Itens.Enabled       = .T.
                        THIS.grd_4c_Itens.ZOrder(0)
                        THIS.grd_4c_Itens.Refresh
                    ENDIF
                    THIS.AjustarBotaoPedras()
                CASE par_nPagina = 2
                    THIS.CmdDisponiveisClick()
                CASE par_nPagina = 3
                    THIS.CmdEstoquesClick()
                CASE par_nPagina = 4
                    THIS.CmdLinhasTotClick()
                CASE par_nPagina = 5
                    THIS.CmdRequisoesClick()
                CASE par_nPagina = 6
                    IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
                        THIS.cnt_4c_Info.Visible = .T.
                        THIS.cnt_4c_Info.ZOrder(0)
                    ENDIF
            ENDCASE
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Dispara a acao principal do formulario (Processar)
    * Executa o processamento da Previa da Globalizacao, gerando OPs, movimentos
    * de estoque, requisicoes de componentes e historicos derivados da grade.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cmd_4c_Processar", 5) AND !THIS.cmd_4c_Processar.Enabled
                MsgAviso("Processamento indispon" + CHR(237) + "vel no momento.", "Aviso")
                loc_lResultado = .F.
            ENDIF
            THIS.CmdProcessarClick()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnIncluirClick: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Retorna a visao principal e devolve o foco a grade de itens
    * Fecha containers flutuantes (Disponivel/Estoques/Linhas/Requisicoes) e
    * reabilita a edicao da coluna Produzir para ajuste manual das quantidades.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
            IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
                SELECT cursor_4c_ItensFinal
                GO TOP
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Itens", 5) AND THIS.grd_4c_Itens.Visible
                THIS.grd_4c_Itens.Refresh
                IF THIS.grd_4c_Itens.ColumnCount >= 6
                    THIS.grd_4c_Itens.Column6.Text1.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Reexibe o painel de informacoes do item corrente
    * Traz o container cnt_4c_Info para o topo e atualiza os totais / totais por
    * linha da linha atualmente selecionada na grade principal.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(6)
            IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
                SELECT cursor_4c_ItensFinal
                THIS.GradeItensAfterRowColChange(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Cancela o processamento e encerra o formulario
    * Faz rollback da transacao aberta pelo Init e libera o form pai.
    * Equivalente a acao do botao Cancelar (Sair) da barra superior.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !MsgConfirma("Deseja realmente cancelar o processamento e sair?", "Confirma" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF
            THIS.CmdCancelarClick()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC


    *==========================================================================
    * BtnBuscarClick - Retorna a visao principal (fecha paineis flutuantes)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
            IF PEMSTATUS(THIS, "grd_4c_Itens", 5) AND THIS.grd_4c_Itens.Visible
                THIS.grd_4c_Itens.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Executa o processamento (equivalente ao Processar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cmd_4c_Processar", 5) AND NOT THIS.cmd_4c_Processar.Enabled
                MsgAviso("Processamento indispon" + CHR(237) + "vel no momento.", "Aviso")
                loc_lResultado = .F.
            ENDIF
            THIS.CmdProcessarClick()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela e encerra o formulario
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transferencia dos campos do form para o BO
    * Para form OPERACIONAL, os dados fluem diretamente dos cursors compartilhados
    * (TmpFinal, TmpSaldo, TmpSaldG, SelPedra). Este metodo atualiza apenas
    * as propriedades de controle do BO.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        WITH THIS.this_oBusinessObject
            .this_lReserva    = THIS.this_lReserva
            .this_lAutomatico = THIS.this_lAutomatico
            .this_nNumerodaop = THIS.this_nNumerodaop
        ENDWITH
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Transferencia do BO para os campos do form
    * Para form OPERACIONAL, os grids sao alimentados diretamente via
    * RecordSource nos cursors compartilhados. Este metodo atualiza os
    * totalizadores e labels exibidos na barra de informacoes.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
        TRY
            loc_nSal = 0
            loc_nEst = 0
            loc_nPrz = 0
            IF USED("TmpFinal")
                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO TOP
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
                THIS.txt_4c_TotQtd.Value = loc_nSal
                THIS.txt_4c_TotEst.Value = loc_nEst
                THIS.txt_4c_TotPrz.Value = loc_nPrz
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                THIS.grd_4c_Itens.Refresh
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
                THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme o modo
    * Para form OPERACIONAL, o controle de habilitacao e feito por operacao
    * especifica (CmdDisponiveis, CmdEstoques, etc.). Este metodo gerencia o
    * estado da barra principal de botoes conforme this_cModoAtual.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Enabled      = loc_lHab
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled  = loc_lHab
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_LinhasTot", 5)
            THIS.cmd_4c_LinhasTot.Enabled  = loc_lHab
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Disponiveis", 5)
            THIS.cmd_4c_Disponiveis.Enabled = loc_lHab
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Estoques", 5)
            THIS.cmd_4c_Estoques.Enabled   = loc_lHab
        ENDIF
        IF loc_lHab
            THIS.AjustarBotaoPedras()
        ELSE
            IF PEMSTATUS(THIS, "cmd_4c_Requisicoes", 5)
                THIS.cmd_4c_Requisicoes.Enabled = .F.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos editaveis do form
    * Para form OPERACIONAL, os cursors compartilhados sao zerados via ZAP
    * no BO. O form apenas reseta os totalizadores e labels locais.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
            THIS.txt_4c_TotQtd.Value = 0
            THIS.txt_4c_TotEst.Value = 0
            THIS.txt_4c_TotPrz.Value = 0
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_ObsItens", 5)
            THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
        ENDIF
        IF PEMSTATUS(THIS, "edt_4c_Obs", 5)
            THIS.edt_4c_Obs.ControlSource = ""
        ENDIF
        IF PEMSTATUS(THIS, "img_4c_Figura", 5)
            THIS.img_4c_Figura.Picture = ""
            THIS.img_4c_Figura.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
            THIS.cnt_4c_Info.txt_4c_TotQtdInfo.Value = 0
            THIS.cnt_4c_Info.txt_4c_TotEstInfo.Value = 0
            THIS.cnt_4c_Info.txt_4c_TotPrzInfo.Value = 0
            THIS.cnt_4c_Info.txt_4c_DGrupoInfo.Value = ""
            THIS.cnt_4c_Info.txt_4c_DContaInfo.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega a grade principal a partir dos cursors
    * Para form OPERACIONAL, nao executa SQL proprio: releia os cursors
    * compartilhados (TmpFinal, TmpSaldG) passados pelo form pai.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
        loc_nSal = 0
        loc_nEst = 0
        loc_nPrz = 0
        TRY
            IF USED("TmpFinal")
                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
                GO TOP
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
                THIS.txt_4c_TotQtd.Value = loc_nSal
                THIS.txt_4c_TotEst.Value = loc_nEst
                THIS.txt_4c_TotPrz.Value = loc_nPrz
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                THIS.grd_4c_Itens.Refresh
            ENDIF
            IF USED("TmpSaldG") AND PEMSTATUS(THIS, "cnt_4c_Info", 5)
                THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recarregar lista: " + loc_oErro.Message + ;
                " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme modo atual
    * Para form OPERACIONAL, o "modo" e determinado pelo estado dos containers
    * flutuantes (algum visivel = modo sub-painel; nenhum = modo principal).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lModoPrincipal
        loc_lModoPrincipal = .T.
        IF PEMSTATUS(THIS, "cnt_4c_Disponivel", 5)
            IF THIS.cnt_4c_Disponivel.Visible
                loc_lModoPrincipal = .F.
            ENDIF
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Estoques", 5)
            IF THIS.cnt_4c_Estoques.Visible
                loc_lModoPrincipal = .F.
            ENDIF
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Linhas", 5)
            IF THIS.cnt_4c_Linhas.Visible
                loc_lModoPrincipal = .F.
            ENDIF
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Requisicoes", 5)
            IF THIS.cnt_4c_Requisicoes.Visible
                loc_lModoPrincipal = .F.
            ENDIF
        ENDIF
        THIS.HabilitarCampos(loc_lModoPrincipal)
        IF loc_lModoPrincipal
            IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
                THIS.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Relatorio", 5)
                THIS.cmd_4c_Relatorio.Enabled = .T.
            ENDIF
        ELSE
            IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
                THIS.cmd_4c_Cancelar.Enabled = .F.
            ENDIF
        ENDIF
    ENDPROC

ENDDEFINE
