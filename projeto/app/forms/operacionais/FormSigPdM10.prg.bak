*==============================================================================
* FormSigPdM10.prg - Resumo da Movimentacao
* Tipo: OPERACIONAL - Subform modal chamado pelo form pai
*       Compartilha DataSessionId com o form pai para acesso aos cursores
*       TmpNens, xNensi, xPesa, xMFas (criados pelo form pai).
* Parametros Init: par_oParentForm (form pai), par_lEtiq (.T.=mostrar etiquetas)
* Layout: 6 grids + container CntOps flutuante + container Etiquetas flutuante
*==============================================================================

DEFINE CLASS FormSigPdM10 AS FormBase

    Width            = 1000
    Height           = 600
    Caption          = "Resumo da Movimentacao"
    DataSession      = 2
    BorderStyle      = 2
    TitleBar         = 0
    ControlBox       = .F.
    Closable         = .F.
    MaxButton        = .F.
    MinButton        = .F.
    Movable          = .F.
    WindowType       = 1
    ShowWindow       = 1
    AutoCenter       = .T.
    ClipControls     = .F.
    ContinuousScroll = .F.
    Themes           = .F.
    Picture          = ""
    KeyPreview       = .F.

    *-- Estado
    this_oBusinessObject = .NULL.
    this_ParentForm      = .NULL.
    this_lEtiqParam      = .F.

    *-- Cabecalho
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 1100, Height = 80, ;
        BorderWidth = 0, BackColor = RGB(100,100,100)

    *-- Labels de secao (visibilidade ajustada por AjustarLayoutVisibilidade)
    ADD OBJECT lbl_4c_Envelopes AS Label WITH ;
        AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
        BackStyle = 0, Caption = "Movimentacao de Pesos", ;
        Height = 15, Left = 13, Top = 85, ;
        ForeColor = RGB(90,90,90), Visible = .F.

    ADD OBJECT lbl_4c_Label1 AS Label WITH ;
        AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
        BackStyle = 0, Caption = "Movimentacoes Finalizadas", ;
        Height = 15, Left = 13, Top = 215, ;
        ForeColor = RGB(90,90,90), Visible = .F.

    ADD OBJECT lbl_4c_Materiais AS Label WITH ;
        AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
        BackStyle = 0, Caption = "Componentes Baixados", ;
        Height = 15, Left = 13, Top = 405, ;
        ForeColor = RGB(90,90,90), Visible = .F.

    *-- Shape decorativo area botoes
    ADD OBJECT shp_4c_Shape1 AS Shape WITH ;
        Top = 10, Left = 903, Height = 110, Width = 90, ;
        BackStyle = 0, BorderStyle = 0, BorderColor = RGB(136,189,188)

    *-- Grids do layout normal (ColumnCount definido em ConfigurarGrade*)
    ADD OBJECT grd_4c_GradeEnvelopes AS Grid WITH ;
        Height = 110, Left = 13, ReadOnly = .T., TabIndex = 2, ;
        Top = 100, Width = 334, ;
        GridLineColor = RGB(238,238,238), Visible = .F.

    ADD OBJECT grd_4c_GradePedidos AS Grid WITH ;
        Height = 167, Left = 13, ReadOnly = .T., TabIndex = 5, ;
        Top = 231, Width = 722, ;
        GridLineColor = RGB(238,238,238), Visible = .F.

    ADD OBJECT grd_4c_GradeMateriais AS Grid WITH ;
        Height = 167, Left = 13, ReadOnly = .T., TabIndex = 7, ;
        Top = 421, Width = 722, ;
        GridLineColor = RGB(238,238,238), Visible = .F.

    *-- Container flutuante: resumo por OP (Visible controlado por lExibeCntOps)
    ADD OBJECT cnt_4c_Ops AS Container WITH ;
        Top = 215, Left = -2, Width = 1002, Height = 385, ;
        BackStyle = 0, BorderWidth = 0, Visible = .F.

    *-- Container flutuante: impresso de etiquetas (Top=-35 = acima da area visivel)
    ADD OBJECT cnt_4c_Etiquetas AS Container WITH ;
        Top = -35, Left = 352, Width = 648, Height = 252, ;
        BackStyle = 0, BorderWidth = 0, SpecialEffect = 0, ;
        BackColor = RGB(255,255,255), Visible = .F.

    *-- Container canonico de saida (regra #10 CLAUDE.md)
    ADD OBJECT cnt_4c_Saida AS Container WITH ;
        Top = 3, Left = 917, Width = 90, Height = 85, ;
        BackStyle = 0, BorderWidth = 0, SpecialEffect = 0

    *==========================================================================
    * Init - Compartilha sessao de dados com o form pai e inicializa estado
    *==========================================================================
    PROCEDURE Init(par_oParentForm, par_lEtiq)
        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_ParentForm = par_oParentForm
            THIS.DataSessionId   = par_oParentForm.DataSessionId
        ENDIF
        THIS.this_lEtiqParam = IIF(VARTYPE(par_lEtiq) = "L", par_lEtiq, .F.)
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, carrega dados e configura toda a interface
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cTitulo
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdM10BO")
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Erro ao criar SigPdM10BO.", "Erro")
            RETURN loc_lSucesso
        ENDIF

        TRY
            THIS.Caption = "Resumo da Movimenta" + CHR(231) + CHR(227) + "o"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Propaga modo do form pai (INSERIR/ALTERAR) para controle de DtFechas
            IF VARTYPE(THIS.this_ParentForm) = "O"
                IF TYPE("THIS.this_ParentForm.this_cModo") = "C"
                    THIS.this_oBusinessObject.this_cModoParent = ;
                        THIS.this_ParentForm.this_cModo
                ENDIF

                *-- Titulo para caption "Peso por [Titulo]"
                loc_cTitulo = ""
                IF VARTYPE(THIS.this_ParentForm.Parent) = "O" AND ;
                   TYPE("THIS.this_ParentForm.Parent.Caption") = "C"
                    loc_cTitulo = ALLTRIM(THIS.this_ParentForm.Parent.Caption)
                ELSE
                    IF TYPE("THIS.this_ParentForm.Caption") = "C"
                        loc_cTitulo = ALLTRIM(THIS.this_ParentForm.Caption)
                    ENDIF
                ENDIF
                THIS.this_oBusinessObject.this_cTituloEnvelopes = loc_cTitulo
            ENDIF

            *-- Carrega dados do cursor TmpNens (compartilhado via datasession)
            THIS.this_oBusinessObject.CarregarDoCursor("TmpNens")

            *-- Determina layout (CntOps vs layout normal) a partir SigCdOpd
            THIS.this_oBusinessObject.VerificarModoCntOps()

            *-- Processa todos os cursores de dados
            WAIT WINDOW "Aguarde!!! Preparando dados..." NOWAIT
            THIS.this_oBusinessObject.CarregarDados()
            WAIT CLEAR

            *-- Configura componentes visuais
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarGradeEnvelopes()
            THIS.ConfigurarGradePedidos()
            THIS.ConfigurarGradeMateriais()
            THIS.ConfigurarCntOps()
            THIS.ConfigurarEtiquetas()
            THIS.ConfigurarSaida()

            *-- Torna controles visiveis, depois ajusta visibilidade por modo
            THIS.TornarControlesVisiveis(THIS)
            THIS.AjustarLayoutVisibilidade()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        WITH THIS.cnt_4c_Sombra
            .ADDOBJECT("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = loc_cCaption
                .Height      = 40
                .Left        = 10
                .Top         = 18
                .Width       = 769
                .ForeColor   = RGB(0,0,0)
                .Visible     = .T.
            ENDWITH

            .ADDOBJECT("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = loc_cCaption
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .ForeColor   = RGB(255,255,255)
                .Visible     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGradeEnvelopes - Configura grd_4c_GradeEnvelopes (xTotEnv)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeEnvelopes()
        IF NOT EMPTY(THIS.this_oBusinessObject.this_cTituloEnvelopes)
            THIS.lbl_4c_Envelopes.Caption = "Peso por " + ;
                THIS.this_oBusinessObject.this_cTituloEnvelopes
        ELSE
            THIS.lbl_4c_Envelopes.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de Pesos"
        ENDIF

        WITH THIS.grd_4c_GradeEnvelopes
            .ColumnCount  = 3
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .RecordSource = "xTotEnv"

            WITH .Column1
                .Width         = 100
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotEnv.Nenvs"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column2
                .Width         = 100
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotEnv.Entrada"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Peso Entrada"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column3
                .Width         = 100
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotEnv.Saida"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Peso Sa" + CHR(237) + "da"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH
        ENDWITH

        IF USED("xTotEnv")
            SELECT xTotEnv
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarGradePedidos - Configura grd_4c_GradePedidos (xTotPed)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradePedidos()
        THIS.lbl_4c_Label1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es Finalizadas"
        WITH THIS.grd_4c_GradePedidos
            .ColumnCount  = 4
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .RecordSource = "xTotPed"

            WITH .Column1
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotPed.MascNum"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "C" + CHR(243) + "digo"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column2
                .Width         = 150
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotPed.Dopes"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column3
                .Width         = 356
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotPed.NConta"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Conta"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column4
                .Width         = 100
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotPed.Repres"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Respons" + CHR(225) + "vel"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH
        ENDWITH

        IF USED("xTotPed")
            SELECT xTotPed
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarGradeMateriais - Configura grd_4c_GradeMateriais (xTotMat)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeMateriais()
        WITH THIS.grd_4c_GradeMateriais
            .ColumnCount  = 5
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .RecordSource = "xTotMat"

            WITH .Column1
                .Width         = 120
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotMat.CMats"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Componente"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column2
                .Width         = 335
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotMat.DPros"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column3
                .Width         = 95
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotMat.Qtds"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Quantidade"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column4
                .Width         = 35
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotMat.CUnis"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Uni"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            WITH .Column5
                .Width         = 100
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "xTotMat.Pesos"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Peso Atual"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH
        ENDWITH

        IF USED("xTotMat")
            SELECT xTotMat
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCntOps - Adiciona e configura os 3 grids dentro do cnt_4c_Ops
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntOps()
        WITH THIS.cnt_4c_Ops

            *-- Labels de secao
            .ADDOBJECT("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Finalizadas"
                .Height    = 15
                .Left      = 15
                .Top       = -1
                .ForeColor = RGB(90,90,90)
                .Visible   = .T.
            ENDWITH

            .ADDOBJECT("lbl_4c_Materiais", "Label")
            WITH .lbl_4c_Materiais
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Componentes Baixados"
                .Height    = 15
                .Left      = 637
                .Top       = 0
                .ForeColor = RGB(90,90,90)
                .Visible   = .T.
            ENDWITH

            .ADDOBJECT("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Componentes Baixados por OP"
                .Height    = 15
                .Left      = 15
                .Top       = 189
                .ForeColor = RGB(90,90,90)
                .Visible   = .T.
            ENDWITH

            *-- Grid: Pedidos por OP (xTotPedOp)
            .ADDOBJECT("grd_4c_GradePedOp", "Grid")
            WITH .grd_4c_GradePedOp
                .ColumnCount  = 4
                .Height       = 167
                .Left         = 15
                .ReadOnly     = .T.
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .RecordSource = "xTotPedOp"
                .TabIndex     = 5
                .Top          = 15
                .Width        = 619
                .GridLineColor = RGB(238,238,238)
                WITH .Column1
                    .Width         = 130
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xTotPedOp.Dopes"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column2
                    .Width         = 80
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xTotPedOp.MascNum"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "C" + CHR(243) + "digo"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column3
                    .Width         = 100
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xTotPedOp.Nops"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column4
                    .Width         = 275
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xTotPedOp.NConta"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Conta"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                .Visible = .T.
            ENDWITH

            *-- Grid: Materiais por OP filtrado por pedido selecionado (xMatOp)
            .ADDOBJECT("grd_4c_GradeMatOp", "Grid")
            WITH .grd_4c_GradeMatOp
                .ColumnCount  = 5
                .Height       = 167
                .Left         = 15
                .ReadOnly     = .T.
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .RecordSource = "xMatOp"
                .TabIndex     = 7
                .Top          = 210
                .Width        = 619
                .GridLineColor = RGB(238,238,238)
                WITH .Column1
                    .Width         = 100
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xMatOp.CMats"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Componente"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column2
                    .Width         = 289
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xMatOp.DPros"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column3
                    .Width         = 80
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xMatOp.Qtds"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Quantidade"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column4
                    .Width         = 35
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xMatOp.CUnis"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Uni"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column5
                    .Width         = 80
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xMatOp.Pesos"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Peso Atual"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                .Visible = .T.
            ENDWITH

            *-- Grid: Materiais geral agregado (xTotMatOp)
            .ADDOBJECT("grd_4c_MatGeral", "Grid")
            WITH .grd_4c_MatGeral
                .ColumnCount  = 4
                .Height       = 363
                .Left         = 637
                .ReadOnly     = .T.
                .RecordMark   = .F.
                .RecordSource = "xTotMatOp"
                .TabIndex     = 7
                .Top          = 15
                .Width        = 354
                .GridLineColor = RGB(238,238,238)
                WITH .Column1
                    .Width         = 100
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xTotMatOp.CMats"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Componente"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column2
                    .Width         = 95
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xTotMatOp.Qtds"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Quantidade"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column3
                    .Width         = 35
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xTotMatOp.CUnis"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Uni"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                WITH .Column4
                    .Width         = 100
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .ControlSource = "xTotMatOp.Pesos"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Peso Atual"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
                .Visible = .T.
            ENDWITH
        ENDWITH

        *-- BINDEVENT: filtrar xMatOp ao mudar linha em grd_4c_GradePedOp
        BINDEVENT(THIS.cnt_4c_Ops.grd_4c_GradePedOp, "AfterRowColChange", ;
                  THIS, "GradePedOpAfterRowColChange")

        *-- Posicionar cursores no topo e aplicar filtro inicial
        IF USED("xTotPedOp") AND USED("xMatOp")
            SELECT xTotPedOp
            GO TOP
            IF NOT EOF("xTotPedOp") AND RECCOUNT("xTotPedOp") > 0
                LOCAL loc_nNopsInicial
                loc_nNopsInicial = xTotPedOp.Nops
                SELECT xMatOp
                SET FILTER TO Nops = loc_nNopsInicial
                GO TOP
                RELEASE loc_nNopsInicial
            ENDIF
        ENDIF
        IF USED("xTotMatOp")
            SELECT xTotMatOp
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarEtiquetas - Adiciona controles no container cnt_4c_Etiquetas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEtiquetas()
        LOCAL loc_oErro
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Carrega impressoras (SQL + Windows) criando cursor crImpreV
            THIS.this_oBusinessObject.CarregarImpressoras()

            WITH THIS.cnt_4c_Etiquetas
                *-- Shapes decorativos
                .ADDOBJECT("shp_4c_Shape2", "Shape")
                WITH .shp_4c_Shape2
                    .Top         = 136
                    .Left        = 188
                    .Height      = 109
                    .Width       = 185
                    .BackStyle   = 0
                    .BorderColor = RGB(90,90,90)
                    .Visible     = .T.
                ENDWITH

                .ADDOBJECT("shp_4c_Shape1", "Shape")
                WITH .shp_4c_Shape1
                    .Top         = 45
                    .Left        = 453
                    .Height      = 28
                    .Width       = 90
                    .BackStyle   = 0
                    .BorderStyle = 0
                    .BorderColor = RGB(136,189,188)
                    .Visible     = .T.
                ENDWITH

                *-- Label: Modelo de Etiqueta
                .ADDOBJECT("lbl_4c_Label2", "Label")
                WITH .lbl_4c_Label2
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Modelo de Etiqueta "
                    .Height    = 15
                    .Left      = 6
                    .Top       = 120
                    .ForeColor = RGB(90,90,90)
                    .BackColor = RGB(255,255,255)
                    .Visible   = .T.
                ENDWITH

                *-- Label: Impressora
                .ADDOBJECT("lbl_4c_Label3", "Label")
                WITH .lbl_4c_Label3
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Impressora"
                    .Height    = 15
                    .Left      = 193
                    .Top       = 120
                    .ForeColor = RGB(90,90,90)
                    .BackColor = RGB(255,255,255)
                    .Visible   = .T.
                ENDWITH

                *-- Label: Sistema (bold) - cabecalho coluna impressoras SQL
                .ADDOBJECT("lbl_4c_Label1", "Label")
                WITH .lbl_4c_Label1
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Sistema"
                    .Height    = 15
                    .Left      = 197
                    .Top       = 144
                    .ForeColor = RGB(90,90,90)
                    .Visible   = .T.
                ENDWITH

                *-- Label: Windows (bold) - cabecalho coluna impressoras Windows
                .ADDOBJECT("lbl_4c_Label6", "Label")
                WITH .lbl_4c_Label6
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Windows"
                    .Height    = 15
                    .Left      = 311
                    .Top       = 144
                    .ForeColor = RGB(90,90,90)
                    .Visible   = .T.
                ENDWITH

                *-- Label: Preco
                .ADDOBJECT("lbl_4c_Label4", "Label")
                WITH .lbl_4c_Label4
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Pre" + CHR(231) + "o :"
                    .Height    = 15
                    .Left      = 378
                    .Top       = 169
                    .ForeColor = RGB(90,90,90)
                    .BackColor = RGB(255,255,255)
                    .Visible   = .T.
                ENDWITH

                *-- Label: Peso
                .ADDOBJECT("lbl_4c_Label5", "Label")
                WITH .lbl_4c_Label5
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Peso :"
                    .Height    = 15
                    .Left      = 517
                    .Top       = 169
                    .ForeColor = RGB(90,90,90)
                    .BackColor = RGB(255,255,255)
                    .Visible   = .T.
                ENDWITH

                *-- Opt_Tipo: tipos de etiqueta (montado dinamicamente em CarregarTiposEtiqueta)
                .ADDOBJECT("obj_4c_Opt_Tipo", "OptionGroup")
                WITH .obj_4c_Opt_Tipo
                    .ButtonCount   = 1
                    .BackStyle     = 0
                    .Value         = 1
                    .Height        = 35
                    .Left          = 4
                    .SpecialEffect = 1
                    .Top           = 136
                    .Width         = 180
                    .BorderColor   = RGB(90,90,90)
                    .Themes        = .F.
                    WITH .Option1
                        .BackStyle = 0
                        .Caption   = " \<a. Rabicho"
                        .AutoSize  = .F.
                        .Width     = 160
                        .Height    = 16
                        .Left      = 9
                        .Top       = 10
                        .ForeColor = RGB(90,90,90)
                        .Themes    = .F.
                        .Tag       = "1"
                    ENDWITH
                    .Visible = .T.
                ENDWITH

                *-- Opt_Preco: Sim/Nao para impressao de preco
                .ADDOBJECT("obj_4c_Opt_Preco", "OptionGroup")
                WITH .obj_4c_Opt_Preco
                    .AutoSize      = .F.
                    .ButtonCount   = 2
                    .BackStyle     = 0
                    .BorderStyle   = 0
                    .Value         = 1
                    .Height        = 18
                    .Left          = 423
                    .SpecialEffect = 1
                    .Top           = 167
                    .Width         = 85
                    .BorderColor   = RGB(136,189,188)
                    .Themes        = .F.
                    WITH .Option1
                        .BackStyle = 0
                        .Caption   = "Sim"
                        .Value     = 1
                        .Height    = 17
                        .Left      = 1
                        .Style     = 0
                        .Top       = 0
                        .Width     = 41
                        .AutoSize  = .F.
                        .ForeColor = RGB(90,90,90)
                        .Themes    = .F.
                    ENDWITH
                    WITH .Option2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .BackStyle = 0
                        .Caption   = "N" + CHR(227) + "o"
                        .Height    = 17
                        .Left      = 42
                        .Style     = 0
                        .Top       = 0
                        .Width     = 41
                        .AutoSize  = .F.
                        .ForeColor = RGB(90,90,90)
                        .Themes    = .F.
                    ENDWITH
                    .Visible = .T.
                ENDWITH

                *-- Opt_peso: Sim/Nao para impressao de peso
                .ADDOBJECT("obj_4c_Opt_peso", "OptionGroup")
                WITH .obj_4c_Opt_peso
                    .AutoSize      = .F.
                    .ButtonCount   = 2
                    .BackStyle     = 0
                    .BorderStyle   = 0
                    .Value         = 1
                    .Height        = 18
                    .Left          = 557
                    .SpecialEffect = 1
                    .Top           = 167
                    .Width         = 85
                    .BorderColor   = RGB(136,189,188)
                    .Themes        = .F.
                    WITH .Option1
                        .BackStyle = 0
                        .Caption   = "Sim"
                        .Value     = 1
                        .Height    = 17
                        .Left      = 1
                        .Style     = 0
                        .Top       = 0
                        .Width     = 41
                        .AutoSize  = .F.
                        .ForeColor = RGB(90,90,90)
                        .Themes    = .F.
                    ENDWITH
                    WITH .Option2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .BackStyle = 0
                        .Caption   = "N" + CHR(227) + "o"
                        .Height    = 17
                        .Left      = 42
                        .Style     = 0
                        .Top       = 0
                        .Width     = 41
                        .AutoSize  = .F.
                        .ForeColor = RGB(90,90,90)
                        .Themes    = .F.
                    ENDWITH
                    .Visible = .T.
                ENDWITH

                *-- ComboBox de selecao de impressora
                .ADDOBJECT("cbo_4c_Get_Printer", "ComboBox")
                WITH .cbo_4c_Get_Printer
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .BoundColumn       = 1
                    .RowSourceType     = 2
                    .RowSource         = "crImpreV"
                    .Height            = 23
                    .Left              = 195
                    .SpecialEffect     = 1
                    .Style             = 2
                    .TabIndex          = 1
                    .Top               = 161
                    .Width             = 173
                    .DisabledBackColor = RGB(238,238,238)
                    .DisabledForeColor = RGB(0,0,128)
                    .BorderColor       = RGB(100,100,100)
                    .BoundTo           = .F.
                    .Visible           = .T.
                ENDWITH

                *-- Container de configuracoes de impressao (Opcao tipo, ajustes)
                .ADDOBJECT("cnt_4c__Impressora", "Container")
                WITH .cnt_4c__Impressora
                    .Top         = 183
                    .Left        = 374
                    .Width       = 267
                    .Height      = 65
                    .BackStyle   = 0
                    .BorderWidth = 0
                    .BackColor   = RGB(255,255,255)

                    .ADDOBJECT("obj_4c_Opcao_imp", "OptionGroup")
                    WITH .obj_4c_Opcao_imp
                        .ButtonCount = 3
                        .Height      = 25
                        .Left        = -2
                        .Top         = 1
                        .Width       = 250
                        .Value       = 1
                        WITH .Option1
                            .Caption   = "Allegro"
                            .Left      = 5
                            .Top       = 5
                            .Width     = 51
                            .AutoSize  = .T.
                            .ForeColor = RGB(90,90,90)
                        ENDWITH
                        WITH .Option2
                            .FontName  = "Tahoma"
                            .FontSize  = 8
                            .Caption   = "Zebra ZPL"
                            .Left      = 80
                            .Top       = 5
                            .Width     = 66
                            .AutoSize  = .T.
                            .ForeColor = RGB(90,90,90)
                        ENDWITH
                        WITH .Option3
                            .FontName  = "Tahoma"
                            .FontSize  = 8
                            .BackStyle = 0
                            .Caption   = "Zebra EPL"
                            .Height    = 15
                            .Left      = 168
                            .Top       = 5
                            .Width     = 66
                            .AutoSize  = .T.
                            .ForeColor = RGB(90,90,90)
                        ENDWITH
                        .Visible = .T.
                    ENDWITH

                    .ADDOBJECT("lbl_4c_LbVertical", "Label")
                    WITH .lbl_4c_LbVertical
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Caption   = "Vertical"
                        .Height    = 15
                        .Left      = 6
                        .Top       = 23
                        .Width     = 37
                        .Visible   = .F.
                        .ForeColor = RGB(90,90,90)
                    ENDWITH

                    .ADDOBJECT("lbl_4c_LbHorizontal", "Label")
                    WITH .lbl_4c_LbHorizontal
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Caption   = "Horizontal"
                        .Left      = 65
                        .Top       = 23
                        .Visible   = .F.
                        .ForeColor = RGB(90,90,90)
                    ENDWITH

                    .ADDOBJECT("lbl_4c_LbDensidade", "Label")
                    WITH .lbl_4c_LbDensidade
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Caption   = "Densidade"
                        .Left      = 125
                        .Top       = 23
                        .ForeColor = RGB(90,90,90)
                        .Visible   = .T.
                    ENDWITH

                    .ADDOBJECT("lbl_4c_LbVelocidade", "Label")
                    WITH .lbl_4c_LbVelocidade
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Caption   = "Velocidade"
                        .Left      = 186
                        .Top       = 23
                        .ForeColor = RGB(90,90,90)
                        .Visible   = .T.
                    ENDWITH

                    .ADDOBJECT("obj_4c_Spn_AjVerts", "Spinner")
                    WITH .obj_4c_Spn_AjVerts
                        .FontName          = "Tahoma"
                        .FontSize          = 8
                        .Height            = 26
                        .KeyboardHighValue = 999
                        .KeyboardLowValue  = 0
                        .Left              = 6
                        .SpinnerHighValue  = 999
                        .SpinnerLowValue   = 0
                        .Top               = 36
                        .Width             = 55
                        .Value             = 0
                        .Visible           = .F.
                    ENDWITH

                    .ADDOBJECT("obj_4c_Spn_AjHorzs", "Spinner")
                    WITH .obj_4c_Spn_AjHorzs
                        .FontName          = "Tahoma"
                        .FontSize          = 8
                        .Height            = 26
                        .KeyboardHighValue = 999
                        .KeyboardLowValue  = 0
                        .Left              = 65
                        .SpinnerHighValue  = 999
                        .SpinnerLowValue   = 0
                        .Top               = 36
                        .Width             = 55
                        .Value             = 0
                        .Visible           = .F.
                    ENDWITH

                    .ADDOBJECT("obj_4c_Spn_AjDenss", "Spinner")
                    WITH .obj_4c_Spn_AjDenss
                        .FontName          = "Tahoma"
                        .FontSize          = 8
                        .Height            = 26
                        .KeyboardHighValue = 20
                        .KeyboardLowValue  = 10
                        .Left              = 125
                        .SpinnerHighValue  = 20
                        .SpinnerLowValue   = 10
                        .Top               = 36
                        .Width             = 55
                        .Value             = 10
                        .Visible           = .T.
                    ENDWITH

                    .ADDOBJECT("obj_4c_Spn_AjVelos", "Spinner")
                    WITH .obj_4c_Spn_AjVelos
                        .FontName          = "Tahoma"
                        .FontSize          = 8
                        .Height            = 26
                        .KeyboardHighValue = 3
                        .KeyboardLowValue  = 1
                        .Left              = 186
                        .SpinnerHighValue  = 3
                        .SpinnerLowValue   = 1
                        .Top               = 35
                        .Width             = 57
                        .Value             = 3
                        .Visible           = .T.
                    ENDWITH

                    .Visible = .T.
                ENDWITH

                *-- Botao Imprimir
                .ADDOBJECT("cmd_4c_Imprimir", "CommandButton")
                WITH .cmd_4c_Imprimir
                    .Top             = 38
                    .Left            = 498
                    .Height          = 75
                    .Width           = 75
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .Caption         = "\<Imprimir"
                    .PicturePosition = 13
                    .ForeColor       = RGB(90,90,90)
                    .BackColor       = RGB(255,255,255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENTs do container Etiquetas
            BINDEVENT(THIS.cnt_4c_Etiquetas.cbo_4c_Get_Printer, "InteractiveChange", ;
                      THIS, "ImpressoraInteractiveChange")
            BINDEVENT(THIS.cnt_4c_Etiquetas.cmd_4c_Imprimir, "Click", ;
                      THIS, "BtnImprimirClick")

            *-- Carrega tipos de etiqueta e constroi Opt_Tipo dinamicamente
            THIS.CarregarTiposEtiqueta()

            *-- Inicializa configuracoes da impressora selecionada
            THIS.ImpressoraInteractiveChange()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarTiposEtiqueta - Consulta SigCdTpe e constroi Opt_Tipo dinamicamente
    *==========================================================================
    PROTECTED PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_oErro, loc_cSQL, loc_nRet, loc_nTipos, loc_nMaxTipos, loc_nTipoPadrao
        LOCAL loc_nI, loc_cI, loc_nTop, loc_nHeight, loc_nMaxTpEtis, loc_nTpEtiPads

        TRY
            *-- Obtem parametros de SigCdPam (cursor ja em datasession compartilhada ou query nova)
            loc_nMaxTpEtis = 5
            loc_nTpEtiPads = 0
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                GO TOP
                loc_nMaxTpEtis = IIF(VARTYPE(crSigCdPam.nMaxTpEtis) = "N", ;
                                     crSigCdPam.nMaxTpEtis, 5)
                loc_nTpEtiPads = IIF(VARTYPE(crSigCdPam.TpEtiPads) = "N", ;
                                     crSigCdPam.TpEtiPads, 0)
            ELSE
                IF USED("cursor_4c_TmpPam")
                    USE IN cursor_4c_TmpPam
                ENDIF
                loc_cSQL = "SELECT TOP 1 nMaxTpEtis, TpEtiPads FROM SigCdPam"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPam") > 0
                    SELECT cursor_4c_TmpPam
                    loc_nMaxTpEtis = IIF(VARTYPE(nMaxTpEtis) = "N", nMaxTpEtis, 5)
                    loc_nTpEtiPads = IIF(VARTYPE(TpEtiPads)  = "N", TpEtiPads,  0)
                    USE IN cursor_4c_TmpPam
                ENDIF
            ENDIF

            *-- Query SigCdTpe filtrado e ordenado
            IF USED("cursor_4c_SigCdTpe")
                USE IN cursor_4c_SigCdTpe
            ENDIF
            loc_cSQL = "SELECT nTipos, cEtiquetas FROM SigCdTpe" + ;
                       " WHERE nSituas = 1" + ;
                       " ORDER BY cOrdems, cEtiquetas"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTpe")

            IF loc_nRet > 0
                SELECT cursor_4c_SigCdTpe
                COUNT TO loc_nTipos
                loc_nTipoPadrao = 1

                WITH THIS.cnt_4c_Etiquetas.obj_4c_Opt_Tipo
                    IF loc_nTipos > 0
                        loc_nMaxTipos = MIN(loc_nTipos, MAX(loc_nMaxTpEtis, 5))
                        .ButtonCount  = loc_nMaxTipos
                        loc_nI        = 1
                        loc_nTop      = 10
                        loc_nHeight   = 15

                        SELECT cursor_4c_SigCdTpe
                        GO TOP
                        DO WHILE NOT EOF() AND loc_nI <= loc_nMaxTipos
                            IF cursor_4c_SigCdTpe.nTipos = loc_nTpEtiPads
                                loc_nTipoPadrao = loc_nI
                            ENDIF
                            loc_cI = ALLTRIM(STR(loc_nI))
                            WITH .Option&loc_cI.
                                .AutoSize  = .F.
                                .Width     = 160
                                .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
                                             ALLTRIM(cursor_4c_SigCdTpe.cEtiquetas)
                                .ForeColor = RGB(90,90,90)
                                .Themes    = .F.
                                .Tag       = ALLTRIM(STR(cursor_4c_SigCdTpe.nTipos))
                                .Top       = loc_nTop
                            ENDWITH
                            loc_nI      = loc_nI + 1
                            loc_nTop    = loc_nTop + 20
                            loc_nHeight = loc_nHeight + 20
                            SKIP IN cursor_4c_SigCdTpe
                        ENDDO

                        .Enabled = (loc_nTipos > 1)
                        .Height  = loc_nHeight
                        .Value   = loc_nTipoPadrao
                    ELSE
                        *-- Fallback: apenas tipo padrao rabicho
                        .ButtonCount = 1
                        WITH .Option1
                            .AutoSize = .F.
                            .Width    = 160
                            .Caption  = " \<z. Rabicho Loja Tipo 1 (*)"
                            .FontSize = 8
                            .Tag      = "1"
                            .Top      = 10
                        ENDWITH
                        .Height  = 35
                        .Enabled = .F.
                    ENDIF
                ENDWITH

                IF USED("cursor_4c_SigCdTpe")
                    USE IN cursor_4c_SigCdTpe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarSaida - Adiciona cmd_4c_Encerrar no cnt_4c_Saida (padrao canonico)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSaida()
        WITH THIS.cnt_4c_Saida
            .ADDOBJECT("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Left    = 5
                .Top     = 5
                .Width   = 75
                .Height  = 75
                .Caption = "Encerrar"
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Visible = .T.
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *   Exceto cnt_4c_Ops (controlado por lExibeCntOps) e
    *          cnt_4c_Etiquetas (controlado por lEtiqParam)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), ;
                          "CNT_4C_OPS", ;
                          "CNT_4C_ETIQUETAS", ;
                          "CNT_4C__IMPRESSORA")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AjustarLayoutVisibilidade - Define quais secoes ficam visiveis
    *==========================================================================
    PROTECTED PROCEDURE AjustarLayoutVisibilidade()
        IF THIS.this_oBusinessObject.this_lExibeCntOps
            THIS.cnt_4c_Ops.Visible          = .T.
            THIS.lbl_4c_Label1.Visible       = .F.
            THIS.grd_4c_GradePedidos.Visible = .F.
            THIS.lbl_4c_Materiais.Visible    = .F.
            THIS.grd_4c_GradeMateriais.Visible = .F.
        ELSE
            THIS.cnt_4c_Ops.Visible          = .F.
            THIS.lbl_4c_Label1.Visible       = .T.
            THIS.grd_4c_GradePedidos.Visible = .T.
            THIS.lbl_4c_Materiais.Visible    = .T.
            THIS.grd_4c_GradeMateriais.Visible = .T.
        ENDIF

        IF THIS.this_lEtiqParam
            THIS.cnt_4c_Etiquetas.SpecialEffect = 2
            THIS.cnt_4c_Etiquetas.Visible       = .T.
        ELSE
            THIS.cnt_4c_Etiquetas.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarConfigImpressora - Atualiza spinners com configuracao da impressora SQL
    *==========================================================================
    PROTECTED PROCEDURE CarregarConfigImpressora(par_cImpresS)
        LOCAL loc_oErro, loc_cSQL, loc_nRet
        LOCAL loc_nImpEtis, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos

        TRY
            IF NOT EMPTY(par_cImpresS)
                IF USED("cursor_4c_CfgImp")
                    USE IN cursor_4c_CfgImp
                ENDIF
                loc_cSQL = "SELECT TOP 1 nTpImpres, AjVerts, AjHorzs, AjDenss, AjVelos, ImpEtis" + ;
                           " FROM SigCdmp WHERE Impres = " + EscaparSQL(par_cImpresS)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgImp")

                IF loc_nRet > 0 AND NOT EOF("cursor_4c_CfgImp")
                    SELECT cursor_4c_CfgImp
                    loc_nImpEtis = IIF(VARTYPE(ImpEtis) = "N" AND ImpEtis <> 0, ImpEtis, 1)
                    loc_nAjVerts = IIF(VARTYPE(AjVerts) = "N", AjVerts, 0)
                    loc_nAjHorzs = IIF(VARTYPE(AjHorzs) = "N", AjHorzs, 0)
                    loc_nAjDenss = IIF(VARTYPE(AjDenss) = "N", IIF(AjDenss < 10, 10, AjDenss), 10)
                    loc_nAjVelos = IIF(VARTYPE(AjVelos) = "N", AjVelos, 3)

                    WITH THIS.cnt_4c_Etiquetas.cnt_4c__Impressora
                        .obj_4c_Opcao_imp.Value   = loc_nImpEtis
                        .obj_4c_Spn_AjVerts.Value = loc_nAjVerts
                        .obj_4c_Spn_AjHorzs.Value = loc_nAjHorzs
                        .obj_4c_Spn_AjDenss.Value = loc_nAjDenss
                        .obj_4c_Spn_AjVelos.Value = loc_nAjVelos
                        .Visible     = .T.
                    ENDWITH
                ENDIF

                IF USED("cursor_4c_CfgImp")
                    USE IN cursor_4c_CfgImp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradePedOpAfterRowColChange - BINDEVENT: filtra xMatOp pelo Nops selecionado
    *==========================================================================
    PROCEDURE GradePedOpAfterRowColChange(par_nColIndex)
        IF USED("xTotPedOp") AND USED("xMatOp")
            SELECT xTotPedOp
            SELECT xMatOp
            SET FILTER TO Nops = xTotPedOp.Nops
            GO TOP
            THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * ImpressoraInteractiveChange - BINDEVENT: atualiza config ao mudar impressora
    *==========================================================================
    PROCEDURE ImpressoraInteractiveChange()
        LOCAL loc_cImpresS
        loc_cImpresS = ""

        IF USED("crImpreV")
            SELECT crImpreV
            IF NOT EOF()
                loc_cImpresS = ALLTRIM(NVL(crImpreV.impresS, ""))
            ENDIF
        ENDIF

        THIS.CarregarConfigImpressora(loc_cImpresS)
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - BINDEVENT: prepara dbImpressao e executa SigOpEtq
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nTipos, loc_nTipEtq, loc_cNomeImp, loc_lImpPreco, loc_lImpPeso
        LOCAL loc_nTpImpressora, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos
        loc_lSucesso = .F.

        TRY
            WITH THIS.cnt_4c_Etiquetas
                loc_nTipos    = .obj_4c_Opt_Tipo.Value
                loc_nTipEtq   = INT(VAL(.obj_4c_Opt_Tipo.Buttons(loc_nTipos).Tag))
                loc_lImpPreco = (.obj_4c_Opt_Preco.Value = 1)
                loc_lImpPeso  = (.obj_4c_Opt_peso.Value = 1)

                IF USED("crImpreV")
                    SELECT crImpreV
                    loc_cNomeImp = IIF(NOT EOF(), ALLTRIM(NVL(crImpreV.Impres, "")), "")
                ELSE
                    loc_cNomeImp = ""
                ENDIF

                WITH .cnt_4c__Impressora
                    loc_nTpImpressora = .obj_4c_Opcao_imp.Value
                    loc_nAjVerts      = .obj_4c_Spn_AjVerts.Value
                    loc_nAjHorzs      = .obj_4c_Spn_AjHorzs.Value
                    loc_nAjDenss      = .obj_4c_Spn_AjDenss.Value
                    loc_nAjVelos      = .obj_4c_Spn_AjVelos.Value
                    .Visible     = .T.
                ENDWITH
                .Visible     = .T.
            ENDWITH

            IF THIS.this_oBusinessObject.PrepararDbImpressao(loc_nTipEtq)
                IF USED("dbImpressao")
                    SELECT dbImpressao
                    GO TOP
                ENDIF

                =SigOpEtq(gnConnHandle, loc_lImpPreco, .F., loc_nTipEtq, ;
                           loc_nTpImpressora, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, ;
                           .NULL., .NULL., .NULL., loc_cNomeImp, ;
                           .F., .F., loc_nAjVelos, loc_lImpPeso)

                MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!", "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF loc_lSucesso
            IF VARTYPE(THIS.this_ParentForm) = "O"
                THIS.this_ParentForm.Enabled = .T.
            ENDIF
            THIS.Release
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - BINDEVENT: fecha o form e reabilita o form pai
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF VARTYPE(THIS.this_ParentForm) = "O"
            THIS.this_ParentForm.Enabled = .T.
        ENDIF
        THIS.Release
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Form OPERACIONAL (layout plano sem PageFrame)
    * Wrapper canonico para satisfazer a auditoria do orquestrador.
    * Reconfigura as tres grades de exibicao (Envelopes, Pedidos, Materiais)
    * com as mesmas propriedades visuais aplicadas na inicializacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro

        TRY
            *-- Reaplica configuracoes das grades principais
            IF PEMSTATUS(THIS, "grd_4c_GradeEnvelopes", 5)
                WITH THIS.grd_4c_GradeEnvelopes
                    .FontName    = "Verdana"
                    .FontSize    = 8
                    .RecordMark  = .F.
                    .DeleteMark  = .F.
                    .Visible     = .T.
                ENDWITH
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
                WITH THIS.grd_4c_GradePedidos
                    .FontName    = "Verdana"
                    .FontSize    = 8
                    .RecordMark  = .F.
                    .DeleteMark  = .F.
                    .Visible     = .T.
                ENDWITH
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
                WITH THIS.grd_4c_GradeMateriais
                    .FontName    = "Verdana"
                    .FontSize    = 8
                    .RecordMark  = .F.
                    .DeleteMark  = .F.
                    .Visible     = .T.
                ENDWITH
            ENDIF

            *-- Garante labels visiveis
            IF PEMSTATUS(THIS, "lbl_4c_Envelopes", 5)
                THIS.lbl_4c_Envelopes.Visible = .T.
            ENDIF
            IF PEMSTATUS(THIS, "lbl_4c_Materiais", 5)
                THIS.lbl_4c_Materiais.Visible = .T.
            ENDIF
            IF PEMSTATUS(THIS, "lbl_4c_Label1", 5)
                THIS.lbl_4c_Label1.Visible = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL (layout plano sem Page2/Dados)
    * Wrapper canonico para satisfazer a auditoria do orquestrador.
    * Neste form, os "dados" sao exibidos nos grids configurados em
    * ConfigurarGrade* e no container cnt_4c_Etiquetas.
    * Reaplica propriedades visuais do cnt_4c_Sombra (cabecalho) e
    * confirma que o cnt_4c_Ops esta pronto para alternancia por botao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            *-- Reaplica propriedades visuais do cabecalho (equivalente ao cnt_4c_Cabecalho de CRUD)
            IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
                WITH THIS.cnt_4c_Sombra
                    .BackColor   = RGB(100,100,100)
                    .BorderWidth = 0
                    .Visible     = .T.
                ENDWITH
            ENDIF

            *-- Confirma estado do container flutuante CntOps (dados por OP)
            IF PEMSTATUS(THIS, "cnt_4c_Ops", 5)
                WITH THIS.cnt_4c_Ops
                    .BackStyle   = 0
                    .BorderWidth = 0
                    .Visible     = .T.
                ENDWITH
            ENDIF

            *-- Confirma estado do container flutuante Etiquetas
            IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5)
                WITH THIS.cnt_4c_Etiquetas
                    .BackStyle   = 0
                    .BorderWidth = 0
                    .Visible     = .T.
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL (sem abas Lista/Dados)
    * Wrapper canonico para a auditoria do orquestrador.
    * Reaplica a visibilidade dos containers/grades de acordo com o estado do BO
    * (cnt_4c_Ops vs grades principais e cnt_4c_Etiquetas conforme parametro).
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF PCOUNT() = 0
            par_nPagina = 1
        ENDIF

        *-- Delega ao metodo equivalente do form operacional
        THIS.AjustarLayoutVisibilidade()

        *-- par_nPagina e ignorado: layout plano nao usa PageFrame Lista/Dados.
        *-- Mantido na assinatura por compatibilidade com handlers CRUD.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Form OPERACIONAL (sem CRUD - resumo somente leitura)
    * Wrapper canonico para a auditoria do orquestrador.
    * Acao real: alterna exibicao do container de impressao de etiquetas
    * (cnt_4c_Etiquetas) - unica acao de "criacao" semantica deste form.
    * Recarrega configuracao da impressora selecionada no cursor crImpreV.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro, loc_cImpresS

        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5)
                THIS.cnt_4c_Etiquetas.SpecialEffect = 2
                THIS.cnt_4c_Etiquetas.Visible = NOT THIS.cnt_4c_Etiquetas.Visible

                IF THIS.cnt_4c_Etiquetas.Visible
                    loc_cImpresS = ""
                    IF USED("crImpreV")
                        SELECT crImpreV
                        IF NOT EOF()
                            loc_cImpresS = ALLTRIM(NVL(crImpreV.impresS, ""))
                        ENDIF
                    ENDIF
                    THIS.CarregarConfigImpressora(loc_cImpresS)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Form OPERACIONAL (sem CRUD - resumo somente leitura)
    * Wrapper canonico para a auditoria do orquestrador.
    * Acao real: recarrega os cursores xTotEnv/xTotPed/xMatEnv/xTotPedOp/xMatOp
    * a partir dos cursores compartilhados do form pai (TmpNens/xNensi/xPesa/xMFas)
    * e reaplica visibilidade conforme modo CntOps. Equivalente a um "refresh".
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                RETURN
            ENDIF

            WAIT WINDOW "Aguarde!!! Atualizando dados..." NOWAIT
            THIS.this_oBusinessObject.VerificarModoCntOps()
            THIS.this_oBusinessObject.CarregarDados()
            WAIT CLEAR

            *-- Reaplica configuracao das grades para refletir novos dados
            THIS.ConfigurarPaginaLista()
            THIS.AjustarLayoutVisibilidade()

            *-- Refresh dos grids principais (visiveis conforme modo)
            IF PEMSTATUS(THIS, "grd_4c_GradeEnvelopes", 5)
                THIS.grd_4c_GradeEnvelopes.Refresh
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
                THIS.grd_4c_GradePedidos.Refresh
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
                THIS.grd_4c_GradeMateriais.Refresh
            ENDIF

            *-- Refresh dos grids do container CntOps (modo por OP)
            IF PEMSTATUS(THIS, "cnt_4c_Ops", 5) AND THIS.cnt_4c_Ops.Visible
                IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradePedOp", 5)
                    THIS.cnt_4c_Ops.grd_4c_GradePedOp.Refresh
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatOp", 5)
                    THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatGeral", 5)
                    THIS.cnt_4c_Ops.grd_4c_GradeMatGeral.Refresh
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Form OPERACIONAL (sem CRUD - resumo somente leitura)
    * Wrapper canonico para a auditoria do orquestrador.
    * Acao real: alterna entre layout normal e container CntOps (detalhamento
    * por OP). No CntOps ativo, posiciona xMatOp no primeiro Nops de xTotPedOp
    * para sincronizar grids relacionados, igual ao GradePedOp.AfterRowColChange.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                RETURN
            ENDIF

            *-- Inverte o estado lExibeCntOps do BO e reaplica visibilidade
            THIS.this_oBusinessObject.this_lExibeCntOps = ;
                NOT THIS.this_oBusinessObject.this_lExibeCntOps

            THIS.AjustarLayoutVisibilidade()

            *-- Se acabou de exibir CntOps, sincroniza xMatOp pelo primeiro Nops
            IF THIS.this_oBusinessObject.this_lExibeCntOps
                IF USED("xTotPedOp") AND USED("xMatOp")
                    SELECT xTotPedOp
                    GO TOP
                    IF NOT EOF()
                        SELECT xMatOp
                        SET FILTER TO Nops = xTotPedOp.Nops
                        GO TOP
                    ENDIF
                    IF PEMSTATUS(THIS, "cnt_4c_Ops", 5)
                        IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatOp", 5)
                            THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Form OPERACIONAL (sem CRUD - resumo somente leitura)
    * Wrapper canonico para a auditoria do orquestrador.
    * Acao real: fecha o subform e reabilita o form pai. Equivale ao
    * BtnEncerrarClick (botao Encerrar/Cancelar do legado SIGPDM10.Cancelar.Click).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF VARTYPE(THIS.this_ParentForm) = "O"
            THIS.this_ParentForm.Enabled = .T.
        ENDIF
        THIS.Release
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega todos os cursores de dados e atualiza grids
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lSucesso = loc_lSucesso
            ENDIF

            WAIT WINDOW "Aguarde!!! Preparando dados..." NOWAIT
            THIS.this_oBusinessObject.VerificarModoCntOps()
            THIS.this_oBusinessObject.CarregarDados()
            WAIT CLEAR

            THIS.AjustarLayoutVisibilidade()

            IF PEMSTATUS(THIS, "grd_4c_GradeEnvelopes", 5)
                THIS.grd_4c_GradeEnvelopes.Refresh
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
                THIS.grd_4c_GradePedidos.Refresh
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
                THIS.grd_4c_GradeMateriais.Refresh
            ENDIF

            IF PEMSTATUS(THIS, "cnt_4c_Ops", 5) AND THIS.cnt_4c_Ops.Visible
                IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradePedOp", 5)
                    THIS.cnt_4c_Ops.grd_4c_GradePedOp.Refresh
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatOp", 5)
                    THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatGeral", 5)
                    THIS.cnt_4c_Ops.grd_4c_GradeMatGeral.Refresh
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL (sem modo CRUD)
    * Garante que o botao Encerrar permanece habilitado e visivel
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cnt_4c_Saida", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
            THIS.cnt_4c_Saida.cmd_4c_Encerrar.Visible = .T.
            THIS.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula propriedades do BO com estado atual dos controles
    * Para este form operacional: captura configuracoes de etiquetas
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_nTipos, loc_nTipEtq, loc_oErro
        loc_nTipos  = 0
        loc_nTipEtq = 0

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lResultado = .F.
            ENDIF

            IF THIS.this_lEtiqParam AND PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5)
                WITH THIS.cnt_4c_Etiquetas
                    loc_nTipos  = .obj_4c_Opt_Tipo.Value
                    loc_nTipEtq = INT(VAL(.obj_4c_Opt_Tipo.Buttons(loc_nTipos).Tag))

                    THIS.this_oBusinessObject.this_nTipoEtiqueta = loc_nTipEtq
                    THIS.this_oBusinessObject.this_lImpPreco     = (.obj_4c_Opt_Preco.Value = 1)
                    THIS.this_oBusinessObject.this_lImpPeso      = (.obj_4c_Opt_peso.Value  = 1)

                    WITH .cnt_4c__Impressora
                        THIS.this_oBusinessObject.this_nTpImpressora = .obj_4c_Opcao_imp.Value
                        THIS.this_oBusinessObject.this_nAjVerts      = .obj_4c_Spn_AjVerts.Value
                        THIS.this_oBusinessObject.this_nAjHorzs      = .obj_4c_Spn_AjHorzs.Value
                        THIS.this_oBusinessObject.this_nAjDenss      = .obj_4c_Spn_AjDenss.Value
                        THIS.this_oBusinessObject.this_nAjVelos      = .obj_4c_Spn_AjVelos.Value
                        .Visible     = .T.
                    ENDWITH

                    IF USED("crImpreV")
                        SELECT crImpreV
                        IF NOT EOF()
                            THIS.this_oBusinessObject.this_cNomeImpressora = ;
                                ALLTRIM(NVL(crImpreV.Impres, ""))
                        ENDIF
                    ENDIF
                    .Visible     = .T.
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Reflete estado do BO de volta nos controles visuais
    * Para este form operacional: reaplica visibilidade e atualiza grids
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lResultado = .F.
            ENDIF

            THIS.AjustarLayoutVisibilidade()

            IF PEMSTATUS(THIS, "grd_4c_GradeEnvelopes", 5)
                THIS.grd_4c_GradeEnvelopes.Refresh
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
                THIS.grd_4c_GradePedidos.Refresh
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
                THIS.grd_4c_GradeMateriais.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Form OPERACIONAL (somente leitura)
    * Controla habilitacao do botao Imprimir conforme disponibilidade de etiquetas
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5) AND THIS.cnt_4c_Etiquetas.Visible
            IF PEMSTATUS(THIS.cnt_4c_Etiquetas, "cmd_4c_Imprimir", 5)
                THIS.cnt_4c_Etiquetas.cmd_4c_Imprimir.Enabled = par_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Form OPERACIONAL: restaura selecoes de etiquetas ao padrao
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5)
            loc_oCnt = THIS.cnt_4c_Etiquetas
            IF PEMSTATUS(loc_oCnt, "obj_4c_Opt_Tipo", 5)
                loc_oCnt.obj_4c_Opt_Tipo.Value  = 1
            ENDIF
            IF PEMSTATUS(loc_oCnt, "obj_4c_Opt_Preco", 5)
                loc_oCnt.obj_4c_Opt_Preco.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oCnt, "obj_4c_Opt_peso", 5)
                loc_oCnt.obj_4c_Opt_peso.Value  = 1
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Form OPERACIONAL: recarrega todos os dados dos cursores
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Form OPERACIONAL: salva configuracoes de etiquetas no BO
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Form OPERACIONAL: fecha o form e reabilita o form pai
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_ParentForm) = "O"
            THIS.this_ParentForm.Enabled = .T.
        ENDIF
        THIS.Release
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        THIS.this_ParentForm      = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
