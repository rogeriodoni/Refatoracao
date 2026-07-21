*================================================================================
* FormSigPrHpr.prg - Hist" + CHR(243) + "rico de Produtos
* Form: OPERACIONAL (leitura + auditoria de SigMvHst)
* Gerado: 17/07/2026
*================================================================================

DEFINE CLASS FormSigPrHpr AS FormBase

    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    AutoCenter  = .T.
    Width       = 1000
    Height      = 600
    BorderStyle = 2
    DataSession = 2

    this_oBusinessObject = .NULL.
    this_oParentForm     = .NULL.
    this_dDataIni        = {}
    this_dDataFim        = {}
    this_cCdGrupo        = ""
    this_cCdConta        = ""
    this_cCdProduto      = ""
    this_cDsProduto      = ""
    this_lTemAuditoria   = .F.
    this_lEhPeso         = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init
    *--------------------------------------------------------------------------
    LPARAMETERS par_oParentForm, par_dDataIni, par_dDataFim, par_cCdGrupo, par_cCdConta, par_cCdProduto, par_cDsProduto
        THIS.Caption = "Hist" + CHR(243) + "rico de Produtos"
        IF PCOUNT() >= 1 AND VARTYPE(par_oParentForm) == "O"
            THIS.this_oParentForm = par_oParentForm
        ENDIF
        IF PCOUNT() >= 2 AND VARTYPE(par_dDataIni) == "D"
            THIS.this_dDataIni = par_dDataIni
        ENDIF
        IF PCOUNT() >= 3 AND VARTYPE(par_dDataFim) == "D"
            THIS.this_dDataFim = par_dDataFim
        ENDIF
        IF PCOUNT() >= 4 AND VARTYPE(par_cCdGrupo) == "C"
            THIS.this_cCdGrupo = par_cCdGrupo
        ENDIF
        IF PCOUNT() >= 5 AND VARTYPE(par_cCdConta) == "C"
            THIS.this_cCdConta = par_cCdConta
        ENDIF
        IF PCOUNT() >= 6 AND VARTYPE(par_cCdProduto) == "C"
            THIS.this_cCdProduto = par_cCdProduto
        ENDIF
        IF PCOUNT() >= 7 AND VARTYPE(par_cDsProduto) == "C"
            THIS.this_cDsProduto = par_cDsProduto
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrHprBO")
            THIS.this_oBusinessObject.this_dDataIni   = THIS.this_dDataIni
            THIS.this_oBusinessObject.this_dDataFim   = THIS.this_dDataFim
            THIS.this_oBusinessObject.this_cCdGrupo   = THIS.this_cCdGrupo
            THIS.this_oBusinessObject.this_cCdConta   = THIS.this_cCdConta
            THIS.this_oBusinessObject.this_cCdProduto = THIS.this_cCdProduto
            THIS.this_oBusinessObject.this_cDsProduto = THIS.this_cDsProduto

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarContainersVisuais()
            THIS.ConfigurarBotoesTopo()
            THIS.ConfigurarCamposFiltroData()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.TornarControlesVisiveis(THIS)
            THIS.txt_4c_Data.Visible        = .F.
            THIS.lbl_4c_DataLabel.Visible   = .F.
            THIS.chk_4c_ChkAuditado.Visible = .F.
            THIS.ConfigurarEventos()

            IF !(VARTYPE(gb_4c_ValidandoUI) == "L" AND gb_4c_ValidandoUI)
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Layout OPERACIONAL flat: sem PageFrame.
    * Controles sao filhos diretos do form (grd_4c_Historico, grd_4c_Subniveis,
    * containers e textboxes). Metodo mantido para simetria com o pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.BackColor = RGB(236, 233, 216)
        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top       = 0
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackColor = RGB(100, 100, 100)
            .BackStyle = 1
            .Visible   = .T.
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .Caption   = "Hist" + CHR(243) + "rico de Produtos"
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .Caption   = "Hist" + CHR(243) + "rico de Produtos"
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersVisuais
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Origem", "Container")
        WITH THIS.cnt_4c_Origem
            .Top       = 426
            .Left      = 7
            .Width     = 478
            .Height    = 74
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH
        THIS.AddObject("cnt_4c_Destino", "Container")
        WITH THIS.cnt_4c_Destino
            .Top       = 426
            .Left      = 504
            .Width     = 478
            .Height    = 74
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesTopo
    *--------------------------------------------------------------------------
        THIS.AddObject("chk_4c_ChkAuditado", "CheckBox")
        WITH THIS.chk_4c_ChkAuditado
            .Top             = 3
            .Left            = 700
            .Width           = 75
            .Height          = 75
            .Caption         = "Auditado"
            .Alignment       = 0
            .Style           = 1
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .BackStyle       = 0
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        THIS.AddObject("cmd_4c_BtnDocumento", "CommandButton")
        WITH THIS.cmd_4c_BtnDocumento
            .Top             = 3
            .Left            = 775
            .Width           = 75
            .Height          = 75
            .Caption         = "Movimento"
            .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        THIS.AddObject("cmd_4c_Procurar", "CommandButton")
        WITH THIS.cmd_4c_Procurar
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Procurar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top       = 0
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .Visible   = .T.
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top     = 3
                .Left    = 917
                .Width   = 90
                .Height  = 75
                .Caption = "Encerrar"
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Visible = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltroData
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_DataLabel", "Label")
        WITH THIS.lbl_4c_DataLabel
            .Top      = 102
            .Left     = 441
            .AutoSize = .T.
            .Caption  = "Data:"
            .FontBold = .T.
            .Visible  = .F.
        ENDWITH
        THIS.AddObject("txt_4c_Data", "TextBox")
        WITH THIS.txt_4c_Data
            .Top       = 98
            .Left      = 478
            .Width     = 80
            .Height    = 23
            .Alignment = 3
            .MaxLength = 10
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelProduto
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_LabelProduto", "Label")
        WITH THIS.lbl_4c_LabelProduto
            .Top       = 130
            .Left      = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrdHistorico
    *--------------------------------------------------------------------------
        THIS.AddObject("grd_4c_Historico", "GridBase")
        WITH THIS.grd_4c_Historico
            .Top          = 148
            .Left         = 4
            .Width        = 730
            .Height       = 238
            .ColumnCount  = 9
            .RecordSource = "cursor_4c_Historico"
            .ReadOnly     = .T.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .FontName     = "Courier New"
            .FontSize     = 9
            .Visible      = .T.
            WITH .Column1
                .Width            = 86
                .ControlSource    = "cursor_4c_Historico.datas"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Data"
            ENDWITH
            WITH .Column2
                .Width            = 57
                .ControlSource    = "cursor_4c_Historico.numes"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "C" + CHR(243) + "digo"
            ENDWITH
            WITH .Column3
                .Width            = 161
                .ControlSource    = "cursor_4c_Historico.dopes"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH .Column4
                .Width            = 31
                .ControlSource    = "cursor_4c_Historico.cunis"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Un."
            ENDWITH
            WITH .Column5
                .Width            = 78
                .ControlSource    = "cursor_4c_Historico.qtds"
                .Format           = "999,999.999"
                .InputMask        = "999,999.999"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Quantidade"
            ENDWITH
            WITH .Column6
                .Width            = 24
                .ControlSource    = "cursor_4c_Historico.opers"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "O"
            ENDWITH
            WITH .Column7
                .Width            = 93
                .ControlSource    = "cursor_4c_Historico.sqtds"
                .Format           = "9,999,999.999"
                .InputMask        = "9,999,999.999"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Saldo  Q"
            ENDWITH
            WITH .Column8
                .Width            = 80
                .ControlSource    = "cursor_4c_Historico.pesos"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Peso"
                .Visible          = .F.
            ENDWITH
            WITH .Column9
                .Width            = 80
                .ControlSource    = "cursor_4c_Historico.spesos"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Saldo P"
                .Visible          = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrdSubniveis
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top      = 130
            .Left     = 747
            .AutoSize = .T.
            .Caption  = "Movimenta" + CHR(231) + CHR(245) + "es com subn" + CHR(237) + "vel"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("grd_4c_Subniveis", "GridBase")
        WITH THIS.grd_4c_Subniveis
            .Top          = 148
            .Left         = 738
            .Width        = 261
            .Height       = 238
            .ColumnCount  = 3
            .RecordSource = "cursor_4c_Subniveis"
            .ReadOnly     = .T.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .FontName     = "Courier New"
            .FontSize     = 9
            .Visible      = .T.
            WITH .Column1
                .Width           = 31
                .ControlSource   = "cursor_4c_Subniveis.emps"
                .Header1.Caption = "Emp"
            ENDWITH
            WITH .Column2
                .Width           = 156
                .ControlSource   = "cursor_4c_Subniveis.dopes"
                .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH .Column3
                .Width           = 51
                .ControlSource   = "cursor_4c_Subniveis.numes"
                .Header1.Caption = "C" + CHR(243) + "digo"
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaInfo
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top      = 396
            .Left     = 27
            .AutoSize = .T.
            .Caption  = "Documento:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("txt_4c_Nota", "TextBox")
        WITH THIS.txt_4c_Nota
            .Top           = 392
            .Left          = 102
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top      = 396
            .Left     = 197
            .AutoSize = .T.
            .Caption  = "Usu" + CHR(225) + "rio:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("txt_4c_Usuario", "TextBox")
        WITH THIS.txt_4c_Usuario
            .Top           = 392
            .Left          = 250
            .Width         = 96
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Auditoria", "Label")
        WITH THIS.lbl_4c_Auditoria
            .Top      = 396
            .Left     = 403
            .AutoSize = .T.
            .Caption  = "Auditoria:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DtAudits", "TextBox")
        WITH THIS.txt_4c_DtAudits
            .Top           = 392
            .Left          = 465
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Auditor", "Label")
        WITH THIS.lbl_4c_Auditor
            .Top      = 396
            .Left     = 556
            .AutoSize = .T.
            .Caption  = "Auditor:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("txt_4c_Auditors", "TextBox")
        WITH THIS.txt_4c_Auditors
            .Top           = 392
            .Left          = 608
            .Width         = 96
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelsAreaContas
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top      = 428
            .Left     = 17
            .AutoSize = .T.
            .Caption  = "Origem"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lin_4c_Line1", "Line")
        WITH THIS.lin_4c_Line1
            .Top         = 442
            .Left        = 18
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Top      = 451
            .Left     = 62
            .AutoSize = .T.
            .Caption  = "Grupo:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .Top      = 475
            .Left     = 63
            .AutoSize = .T.
            .Caption  = "Conta:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Top      = 428
            .Left     = 513
            .AutoSize = .T.
            .Caption  = "Destino"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lin_4c_Line2", "Line")
        WITH THIS.lin_4c_Line2
            .Top         = 442
            .Left        = 515
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .Top      = 451
            .Left     = 557
            .AutoSize = .T.
            .Caption  = "Grupo:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .Top      = 475
            .Left     = 558
            .AutoSize = .T.
            .Caption  = "Conta:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top      = 517
            .Left     = 29
            .AutoSize = .T.
            .Caption  = "Observa" + CHR(231) + CHR(227) + "o:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposAreaContas
    *--------------------------------------------------------------------------
        THIS.AddObject("txt_4c_GruOri", "TextBox")
        WITH THIS.txt_4c_GruOri
            .Top           = 447
            .Left          = 106
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DesGruOri", "TextBox")
        WITH THIS.txt_4c_DesGruOri
            .Top           = 447
            .Left          = 187
            .Width         = 290
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_ConOri", "TextBox")
        WITH THIS.txt_4c_ConOri
            .Top           = 471
            .Left          = 106
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DesConOri", "TextBox")
        WITH THIS.txt_4c_DesConOri
            .Top           = 471
            .Left          = 187
            .Width         = 290
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_GruDes", "TextBox")
        WITH THIS.txt_4c_GruDes
            .Top           = 447
            .Left          = 601
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DesGruDes", "TextBox")
        WITH THIS.txt_4c_DesGruDes
            .Top           = 447
            .Left          = 682
            .Width         = 290
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_ConDes", "TextBox")
        WITH THIS.txt_4c_ConDes
            .Top           = 471
            .Left          = 601
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DesConDes", "TextBox")
        WITH THIS.txt_4c_DesConDes
            .Top           = 471
            .Left          = 682
            .Width         = 290
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaObs
    *--------------------------------------------------------------------------
        THIS.AddObject("obj_4c_Obs", "EditBox")
        WITH THIS.obj_4c_Obs
            .Top           = 514
            .Left          = 106
            .Width         = 875
            .Height        = 55
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *-- Configura a area principal: label produto + grid historico + grid subniveis
    *--------------------------------------------------------------------------
        THIS.ConfigurarLabelProduto()
        THIS.ConfigurarGrdHistorico()
        THIS.ConfigurarGrdSubniveis()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *-- Configura secao inferior (equivalente a Page2 em CRUD):
    *-- area de informacoes, labels de contas, campos de contas e observacao
    *--------------------------------------------------------------------------
        THIS.ConfigurarAreaInfo()
        THIS.ConfigurarLabelsAreaContas()
        THIS.ConfigurarCamposAreaContas()
        THIS.ConfigurarAreaObs()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina
    *-- Form OPERACIONAL flat sem PageFrame: metodo mantido por simetria com pipeline
    *--------------------------------------------------------------------------
    LPARAMETERS par_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis
    *--------------------------------------------------------------------------
    LPARAMETERS par_oContainer
        LOCAL loc_nI, loc_oControl
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF INLIST(loc_oControl.BaseClass, "Grid", "Column", "Header", "Line")
                LOOP
            ENDIF
            IF INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho")
                LOOP
            ENDIF
            IF INLIST(loc_oControl.BaseClass, "Container", "PageFrame", "Page")
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
            loc_oControl.Visible = .T.
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos
    *--------------------------------------------------------------------------
        BINDEVENT(THIS.grd_4c_Historico,              "AfterRowColChange", THIS, "GrdHistoricoAfterRowColChange")
        BINDEVENT(THIS.chk_4c_ChkAuditado,            "Click",             THIS, "ChkAuditadoClick")
        BINDEVENT(THIS.cmd_4c_Procurar,               "Click",             THIS, "CmdProcurarClick")
        BINDEVENT(THIS.cmd_4c_BtnDocumento,           "Click",             THIS, "CmdMovimentoClick")
        BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",          THIS, "TxtDataKeyPress")
        BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",         THIS, "TxtDataLostFocus")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click",             THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados
    *-- CarregarHistorico ja chama CarregarDadosProduto internamente
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject.CarregarHistorico()
            THIS.this_lEhPeso = THIS.this_oBusinessObject.this_lEhPeso
            THIS.grd_4c_Historico.Column8.Visible = THIS.this_lEhPeso
            THIS.grd_4c_Historico.Column9.Visible = THIS.this_lEhPeso
            THIS.lbl_4c_LabelProduto.Caption = THIS.this_cDsProduto
            IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
                SELECT cursor_4c_Historico
                GO BOTTOM
                THIS.AtualizarCamposLinha()
            ENDIF
            THIS.grd_4c_Historico.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCamposLinha
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
            RETURN
        ENDIF
        IF BOF("cursor_4c_Historico") OR EOF("cursor_4c_Historico")
            RETURN
        ENDIF
        TRY
            THIS.this_oBusinessObject.CarregarDadosLinhaSelecionada()
            THIS.this_oBusinessObject.CarregarDocumento()
            THIS.this_oBusinessObject.CarregarDescricoesContabil()
            THIS.this_oBusinessObject.CarregarSubniveis()

            THIS.txt_4c_Auditors.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cAuditors)
            IF EMPTY(THIS.this_oBusinessObject.this_dDtAudits)
                THIS.txt_4c_DtAudits.Value = ""
            ELSE
                THIS.txt_4c_DtAudits.Value = DTOC(THIS.this_oBusinessObject.this_dDtAudits)
            ENDIF
            THIS.txt_4c_Usuario.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)
            THIS.txt_4c_Nota.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cNotas)
            THIS.txt_4c_GruOri.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoOri)
            THIS.txt_4c_DesGruOri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesGrupoOri)
            THIS.txt_4c_ConOri.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaOri)
            THIS.txt_4c_DesConOri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesContaOri)
            THIS.txt_4c_GruDes.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoDes)
            THIS.txt_4c_DesGruDes.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesGrupoDes)
            THIS.txt_4c_ConDes.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaDes)
            THIS.txt_4c_DesConDes.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesContaDes)
            THIS.obj_4c_Obs.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cObs)

            THIS.this_lTemAuditoria = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cAuditors))
            THIS.chk_4c_ChkAuditado.Value = IIF(THIS.this_lTemAuditoria, 1, 0)
            IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
                THIS.chk_4c_ChkAuditado.Visible = .T.
            ELSE
                THIS.chk_4c_ChkAuditado.Visible = .F.
            ENDIF

            THIS.grd_4c_Subniveis.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar campos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GrdHistoricoAfterRowColChange
    *--------------------------------------------------------------------------
    LPARAMETERS par_nColIndex
        THIS.AtualizarCamposLinha()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkAuditadoClick
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lBOResult
        loc_lSucesso  = .F.
        loc_lBOResult = .F.
        TRY
            IF THIS.chk_4c_ChkAuditado.Value = 1
                loc_lBOResult = THIS.this_oBusinessObject.AuditarRegistro()
            ELSE
                loc_lBOResult = THIS.this_oBusinessObject.DesauditarRegistro()
            ENDIF
            IF loc_lBOResult
                THIS.txt_4c_Auditors.Value = ALLTRIM(THIS.this_oBusinessObject.this_cAuditors)
                IF EMPTY(THIS.this_oBusinessObject.this_dDtAudits)
                    THIS.txt_4c_DtAudits.Value = ""
                ELSE
                    THIS.txt_4c_DtAudits.Value = DTOC(THIS.this_oBusinessObject.this_dDtAudits)
                ENDIF
                THIS.this_lTemAuditoria = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cAuditors))
                THIS.chk_4c_ChkAuditado.Value = IIF(THIS.this_lTemAuditoria, 1, 0)
                THIS.grd_4c_Historico.Refresh()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao auditar registro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdProcurarClick
    *--------------------------------------------------------------------------
        THIS.lbl_4c_DataLabel.Visible = .T.
        THIS.txt_4c_Data.Visible      = .T.
        THIS.txt_4c_Data.Value        = DATE()
        THIS.txt_4c_Data.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TxtDataKeyPress
    *--------------------------------------------------------------------------
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_dData
        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        loc_dData = THIS.txt_4c_Data.Value
        THIS.txt_4c_Data.Visible      = .F.
        THIS.lbl_4c_DataLabel.Visible = .F.
        IF EMPTY(loc_dData) OR VARTYPE(loc_dData) != "D"
            RETURN
        ENDIF
        IF USED("cursor_4c_Historico")
            SET NEAR ON
            = SEEK(DTOS(loc_dData), "cursor_4c_Historico", "datas")
            SET NEAR OFF
            THIS.grd_4c_Historico.Refresh()
            THIS.AtualizarCamposLinha()
        ENDIF
        THIS.grd_4c_Historico.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TxtDataLostFocus
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *--------------------------------------------------------------------------
        THIS.txt_4c_Data.Visible      = .F.
        THIS.lbl_4c_DataLabel.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdMovimentoClick
    *--------------------------------------------------------------------------
        LOCAL loc_cTipoDoc, loc_lSucesso, loc_oForm
        loc_lSucesso = .F.
        loc_oForm    = .NULL.
        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Nenhum registro selecionado.")
            ELSE
                THIS.this_oBusinessObject.CarregarDadosLinhaSelecionada()
                loc_cTipoDoc = THIS.this_oBusinessObject.VerificarExistenciaDocumento()
                DO CASE
                CASE loc_cTipoDoc == "MOVCAB"
                    loc_oForm = CREATEOBJECT("FormSigMvExp", THIS)
                    IF VARTYPE(loc_oForm) == "O"
                        THIS.Enabled = .F.
                        loc_oForm.Show()
                    ENDIF
                CASE loc_cTipoDoc == "NEC"
                    loc_oForm = CREATEOBJECT("FormSigMvPdt", THIS)
                    IF VARTYPE(loc_oForm) == "O"
                        THIS.Enabled = .F.
                        loc_oForm.Show()
                    ENDIF
                OTHERWISE
                    MsgAviso("Documento n" + CHR(227) + "o encontrado.")
                ENDCASE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir documento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick
    *--------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias CRUD para OPERACIONAL de consulta:
    *   "Incluir" nao se aplica ao Historico (readonly). Delega para
    *   CarregarDados() que recarrega o historico com o filtro atual
    *   (data/grupo/conta/produto) e reseleciona o ultimo registro.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.CarregarDados()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao recarregar hist" + CHR(243) + "rico")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alias CRUD para OPERACIONAL de consulta:
    *   "Alterar" no contexto de historico = marcar/desmarcar auditoria
    *   do registro selecionado. Valida permissao via VerificarPermissaoAuditoria
    *   e delega para ChkAuditadoClick que executa AuditarRegistro ou
    *   DesauditarRegistro no BO.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
            ELSE
                IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
                    THIS.chk_4c_ChkAuditado.Value = IIF(THIS.chk_4c_ChkAuditado.Value = 1, 0, 1)
                    THIS.ChkAuditadoClick()
                ELSE
                    MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar auditoria")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alias CRUD para OPERACIONAL de consulta:
    *   "Visualizar" abre o documento (SigMvCab ou SigCdNec) associado
    *   a linha selecionada no grid de historico. Delega para
    *   CmdMovimentoClick que faz VerificarExistenciaDocumento no BO
    *   e instancia FormSigMvExp (movimento) ou FormSigMvPdt (necessidade).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.CmdMovimentoClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Alias CRUD para OPERACIONAL de consulta:
    *   Historico de movimentacao eh readonly - registros nao podem ser
    *   excluidos individualmente. Interpretacao canonica: "Excluir" =
    *   remover marca de auditoria (unico atributo mutavel do registro).
    *   Solicita MsgConfirma antes e delega para ChkAuditadoClick com
    *   toggle para desmarcar.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso, loc_cTitulo
        loc_lSucesso = .F.
        loc_cTitulo  = "Remover Auditoria"
        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
            ELSE
                IF !THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
                    MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
                ELSE
                    IF THIS.chk_4c_ChkAuditado.Value = 1
                        IF MsgConfirma("Confirma remover a marca" + CHR(231) + CHR(227) + "o de auditoria deste registro?", loc_cTitulo)
                            THIS.chk_4c_ChkAuditado.Value = 0
                            THIS.ChkAuditadoClick()
                        ENDIF
                    ELSE
                        MsgAviso("O registro selecionado n" + CHR(227) + "o est" + CHR(225) + " marcado como auditado.")
                    ENDIF
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao remover auditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy
    *--------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oParentForm) == "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias FormBase: delega para CarregarDados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista
        THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Exibe campo de filtro por data (igual ao botao Procurar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick
        THIS.CmdProcurarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias CRUD para OPERACIONAL de auditoria:
    *   "Salvar" = confirmar a marcacao/desmarcacao de auditoria do registro
    *   selecionado. Verifica permissao e delega para ChkAuditadoClick.
    *==========================================================================
    PROCEDURE BtnSalvarClick
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
            ELSE
                IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
                    THIS.ChkAuditadoClick()
                ELSE
                    MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao salvar auditoria")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Alias CRUD para OPERACIONAL:
    *   Oculta o campo de filtro por data e restaura foco ao grid.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        THIS.txt_4c_Data.Visible      = .F.
        THIS.lbl_4c_DataLabel.Visible = .F.
        THIS.grd_4c_Historico.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza estado do form -> BO
    *   OPERACIONAL: propaga parametros de contexto e estado do checkbox
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_lTemAuditoria = (THIS.chk_4c_ChkAuditado.Value = 1)
        THIS.this_oBusinessObject.this_cCdGrupo      = THIS.this_cCdGrupo
        THIS.this_oBusinessObject.this_cCdConta      = THIS.this_cCdConta
        THIS.this_oBusinessObject.this_cCdProduto    = THIS.this_cCdProduto
        THIS.this_oBusinessObject.this_cDsProduto    = THIS.this_cDsProduto
        THIS.this_oBusinessObject.this_dDataIni      = THIS.this_dDataIni
        THIS.this_oBusinessObject.this_dDataFim      = THIS.this_dDataFim
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza estado do BO -> form
    *   OPERACIONAL: atualiza campos de exibicao da linha corrente
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm
        THIS.AtualizarCamposLinha()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - OPERACIONAL: campos sao ReadOnly por natureza.
    *   Gerencia apenas visibilidade do checkbox de auditoria conforme permissao.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos
    LPARAMETERS par_cModo
        LOCAL loc_lPermite
        loc_lPermite = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) == "O"
                loc_lPermite = THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
            ENDIF
            THIS.chk_4c_ChkAuditado.Visible = loc_lPermite
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao habilitar campos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos de exibicao da linha selecionada
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos
        THIS.txt_4c_Auditors.Value    = ""
        THIS.txt_4c_DtAudits.Value    = ""
        THIS.txt_4c_Usuario.Value     = ""
        THIS.txt_4c_Nota.Value        = ""
        THIS.txt_4c_GruOri.Value      = ""
        THIS.txt_4c_DesGruOri.Value   = ""
        THIS.txt_4c_ConOri.Value      = ""
        THIS.txt_4c_DesConOri.Value   = ""
        THIS.txt_4c_GruDes.Value      = ""
        THIS.txt_4c_DesGruDes.Value   = ""
        THIS.txt_4c_ConDes.Value      = ""
        THIS.txt_4c_DesConDes.Value   = ""
        THIS.obj_4c_Obs.Value         = ""
        THIS.chk_4c_ChkAuditado.Value = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - OPERACIONAL sem modos CRUD: no-op de compatibilidade
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo
    LPARAMETERS par_cModo
    ENDPROC

ENDDEFINE
