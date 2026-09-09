*==============================================================================
* Formdmo.prg - Desmontagem de Produtos (SIGCDDMO)
* CRUD + Operacional: pagina Lista (filtro por periodo) + pagina Dados (edicao)
* Tabela principal: SigMvCab / SigMvItn
* Migrado de SIGCDDMO.SCX (herda de frmcadastro / framework Fortyus)
*==============================================================================

DEFINE CLASS FormDmo AS FormBase

    DataSession  = 2
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    KeyPreview   = .F.
    Caption      = "Desmontagem"
    FontName     = "Tahoma"
    FontSize     = 8

    this_oBusinessObject = .NULL.
    this_cModo           = ""      && INSERIR/CONSULTAR/ALTERAR/EXCLUIR/PROCURAR
    this_nNumes_Old      = 0       && equivale OldCodigo do legado
    this_lEditaOrigem    = .T.     && se origem eh editavel

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        THIS.Caption = "Desmontagem"
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores e recursos
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF USED("crSigMvCab")
                USE IN crSigMvCab
            ENDIF
            IF USED("crLclMvItn")
                USE IN crLclMvItn
            ENDIF
            IF USED("TmpOperacao")
                USE IN TmpOperacao
            ENDIF
            IF USED("TempGccr")
                USE IN TempGccr
            ENDIF
            IF USED("TempGru")
                USE IN TempGru
            ENDIF
            IF USED("TempUni")
                USE IN TempUni
            ENDIF
        CATCH TO loc_oErro
            *-- nao exibir erro no Destroy
        ENDTRY
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("dmoBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Falha ao criar dmoBO.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel conectar ao servidor de banco de dados.", ;
                         "Conex" + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oBusinessObject.CarregarParametros()
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oBusinessObject.CarregarLookups()
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.Caption = "Desmontagem - " + ALLTRIM(THIS.this_oBusinessObject.this_cDopesAtual)

                *-- Cursor do lote de operacoes da sessao atual
                CREATE CURSOR TmpOperacao (Emps C(3), Dopes C(20), Numes N(6), Codigos N(10))
                INDEX ON Codigos TAG Codigos
                SET ORDER TO Codigos

                *-- Cursor de itens (estrutura crLclMvItn)
                CREATE CURSOR crLclMvItn ( ;
                    Emps C(3), Dopes C(20), Numes N(6), Cpros C(14), Dpros C(60), ;
                    Qtds N(12,3), Pesos N(12,3), Cunis C(3), Aqtds N(12,3), ;
                    Datatrans D, NrCons C(10), Totas N(18,6), Units C(3), ;
                    NumOlds N(10), Notas C(20), Opers C(3), Moedas C(3), ;
                    Fators N(12,4), MoeFats C(3), FatVals N(18,6), MoeVals N(18,6), ;
                    DescVals N(18,6), UniVals N(18,6), Iconfs L, cItens C(14), ;
                    UnitEmbs N(12,3), TPesos N(12,3), Obs M, CodBarras N(18,0), ;
                    ValIpis N(18,6), TpIpis C(2), Aliqs N(9,4), Sitribs C(3), ;
                    EmpDopNums C(29), DtAlts D, cIdChaves C(20))

                *-- Carregar lista inicial do dia
                THIS.this_oBusinessObject.this_dDtIni = DATE()
                THIS.this_oBusinessObject.this_dDtFim = DATE()
                THIS.this_oBusinessObject.Buscar("")

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis(THIS)
                THIS.ConfigurarBINDEVENTs()

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModo                = ""

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                     "Proc: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Paginas (2 paginas: Lista e Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = 0
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height
            .Tabs      = .F.
            .PageCount = 2
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Constroi Page1 (Lista) com grade e controles
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            *-- Cabecalho cinza (equivalente cntSombra do legado)
            loc_oPg.AddObject("cnt_4c_Sombra", "Container")
            WITH loc_oPg.cnt_4c_Sombra
                .Top         = 0
                .Left        = -1
                .Width       = loc_oPg.Width + 2
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top       = 17
                    .Left      = 10
                    .Width     = loc_oPg.Width
                    .Height    = 46
                    .AutoSize  = .F.
                    .WordWrap  = .T.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .BackStyle = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Caption   = THIS.Caption
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top       = 18
                    .Left      = 10
                    .Width     = loc_oPg.Width
                    .Height    = 46
                    .AutoSize  = .F.
                    .WordWrap  = .T.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .BackStyle = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = THIS.Caption
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Botoes de acao (equivalente Grupo_op: Left=543+offsets)
            loc_oPg.AddObject("cmd_4c_Incluir", "CommandButton")
            WITH loc_oPg.cmd_4c_Incluir
                .Top             = 3
                .Left = 5
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Inserir"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .T.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .ToolTipText     = "Novo registro [F5]"
                .Visible         = .T.
            ENDWITH

            loc_oPg.AddObject("cmd_4c_Consultar", "CommandButton")
            WITH loc_oPg.cmd_4c_Consultar
                .Top             = 3
                .Left            = 623
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Consultar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .T.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .ToolTipText     = "Consultar registro"
                .Visible         = .T.
            ENDWITH

            loc_oPg.AddObject("cmd_4c_Alterar", "CommandButton")
            WITH loc_oPg.cmd_4c_Alterar
                .Top             = 3
                .Left = 155
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Alterar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .T.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .ToolTipText     = "Alterar registro"
                .Visible         = .T.
            ENDWITH

            loc_oPg.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oPg.cmd_4c_Excluir
                .Top             = 3
                .Left = 230
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Excluir"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .T.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .ToolTipText     = "Excluir registro"
                .Visible         = .T.
            ENDWITH

            loc_oPg.AddObject("cmd_4c_Procurar", "CommandButton")
            WITH loc_oPg.cmd_4c_Procurar
                .Top             = 3
                .Left            = 848
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Procurar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .T.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .ToolTipText     = "Procurar registro"
                .Visible         = .T.
            ENDWITH

            *-- Botao Encerrar (padrao canonico: cnt_4c_Saida Left=917)
            loc_oPg.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPg.cnt_4c_Saida
                .Top         = 0
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Top             = 5
                    .Left = 5
                    .Height          = 75
                    .Width           = 75
                    .Caption         = "Encerrar"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .WordWrap        = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel          = .T.
                    .ToolTipText     = "[Esc] Encerrar"
                ENDWITH
            ENDWITH

            *-- Filtro de periodo (equivalente cntPeriodo)
            loc_oPg.AddObject("cnt_4c_Periodo", "Container")
            WITH loc_oPg.cnt_4c_Periodo
                .Top         = 265
                .Left        = 359
                .Width       = 410
                .Height      = 110
                .BackStyle   = 0
                .BorderColor = RGB(0, 0, 0)
                .Style       = 3
                .Visible     = .T.

                .AddObject("lbl_4c_Periodo", "Label")
                WITH .lbl_4c_Periodo
                    .Top       = 48
                    .Left      = 71
                    .Width     = 60
                    .Height    = 15
                    .AutoSize  = .T.
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = "\<Per" + CHR(237) + "odo :"
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Ate", "Label")
                WITH .lbl_4c_Ate
                    .Top       = 48
                    .Left      = 219
                    .Width     = 23
                    .Height    = 15
                    .AutoSize  = .T.
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = "at" + CHR(233)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DtIni", "TextBox")
                WITH .txt_4c_DtIni
                    .Top           = 44
                    .Left          = 133
                    .Width         = 80
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Value         = DATE()
                    .Format        = "K"
                    .SpecialEffect = 1
                    .BorderColor   = RGB(221, 252, 255)
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH

                .AddObject("txt_4c_DtFim", "TextBox")
                WITH .txt_4c_DtFim
                    .Top           = 44
                    .Left          = 249
                    .Width         = 80
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .Value         = DATE()
                    .Format        = "K"
                    .SpecialEffect = 1
                    .BorderColor   = RGB(221, 252, 255)
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH
            ENDWITH

            *-- Grade lista de movimentos (equivalente Pagina.Lista.Grade)
            loc_oPg.AddObject("grd_4c_Lista", "Grid")
            WITH loc_oPg.grd_4c_Lista
                .Top          = 113
                .Left         = 22
                .Width        = 936
                .Height       = 465
                .FontName     = "Tahoma"
                .FontSize     = 8
                .ColumnCount  = 5
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .GridLines    = 3
                .HeaderHeight = 20
                .RowHeight    = 19
                .ScrollBars   = 3
                .ReadOnly     = .T.
                .ForeColor    = RGB(90, 90, 90)
                .RecordSource = "crSigMvCab"
                .Visible      = .T.

                WITH .Column1
                    .ControlSource = "crSigMvCab.MascNum"
                    .Width         = 100
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "N" + CHR(250) + "mero"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .T.
                        .BorderStyle = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column2
                    .ControlSource = "crSigMvCab.Datas"
                    .Width         = 90
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Data"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .T.
                        .BorderStyle = 0
                        .Format      = "D"
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column3
                    .ControlSource = "crSigMvCab.GrupoOs"
                    .Width         = 100
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Gr.Origem"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .T.
                        .BorderStyle = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column4
                    .ControlSource = "crSigMvCab.GrupoDs"
                    .Width         = 100
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Gr.Destino"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .T.
                        .BorderStyle = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column5
                    .ControlSource = "crSigMvCab.ChkSubn"
                    .Width         = 80
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Processado"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .T.
                        .BorderStyle = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Constroi Page2 (Dados) com todos os controles
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- GradeOperacao (equivalente GradeOperacao/TmpOperacao, top=11, left=656, w=108, h=194)
            loc_oPg.AddObject("grd_4c_Operacao", "Grid")
            WITH loc_oPg.grd_4c_Operacao
                .Top          = 11
                .Left         = 656
                .Width        = 108
                .Height       = 194
                .FontName     = "Tahoma"
                .FontSize     = 8
                .ColumnCount  = 1
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .GridLines    = 3
                .HeaderHeight = 20
                .RowHeight    = 19
                .ScrollBars   = 2
                .ForeColor    = RGB(90, 90, 90)
                .RecordSource = "TmpOperacao"
                .Visible      = .T.

                WITH .Column1
                    .ControlSource = "TmpOperacao.Codigos"
                    .Width         = 86
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .BorderStyle = 0
                        .ForeColor   = RGB(90, 90, 90)
                        .BackColor   = RGB(255, 255, 255)
                        .InputMask   = "99999999"
                        .ReadOnly    = .T.
                    ENDWITH
                ENDWITH
            ENDWITH

            *-- Container codigo/data (equivalente Container1+Say1+Say2+Get_codigo+Dt_data)
            loc_oPg.AddObject("cnt_4c_Codigo", "Container")
            WITH loc_oPg.cnt_4c_Codigo
                .Top         = 15
                .Left        = 53
                .Width       = 541
                .Height      = 45
                .BackStyle   = 0
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.

                .AddObject("lbl_4c_LblCodigo", "Label")
                WITH .lbl_4c_LblCodigo
                    .Top       = 1
                    .Left      = 3
                    .Caption   = "C" + CHR(243) + "digo"
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_LblData", "Label")
                WITH .lbl_4c_LblData
                    .Top       = 1
                    .Left      = 90
                    .Caption   = "Data"
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_Codigo", "TextBox")
                WITH .txt_4c_Codigo
                    .Top           = 17
                    .Left          = 3
                    .Width         = 80
                    .Height        = 23
                    .FontBold      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .ReadOnly      = .T.
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH

                .AddObject("txt_4c_Data", "TextBox")
                WITH .txt_4c_Data
                    .Top           = 17
                    .Left          = 90
                    .Width         = 80
                    .Height        = 23
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .Value         = DATE()
                    .Format        = "K"
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH
            ENDWITH

            *-- Botao Pendentes (equivalente Bot_Pendentes: top=11, left=768, w=40, h=40)
            loc_oPg.AddObject("cmd_4c_Pendentes", "CommandButton")
            WITH loc_oPg.cmd_4c_Pendentes
                .Top             = 11
                .Left            = 768
                .Height          = 40
                .Width           = 40
                .Caption         = ""
                .FontName        = "Verdana"
                .FontSize        = 8
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .F.
                .MousePointer    = 15
                .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_26.jpg"
                .ToolTipText     = "Pendentes"
                .Visible         = .T.
            ENDWITH

            *-- Container Origem (top=65, left=53, width=541, height=45)
            loc_oPg.AddObject("cnt_4c_Origem", "Container")
            WITH loc_oPg.cnt_4c_Origem
                .Top         = 65
                .Left        = 53
                .Width       = 541
                .Height      = 45
                .BackStyle   = 0
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.

                .AddObject("lbl_4c_OriTitulo", "Label")
                WITH .lbl_4c_OriTitulo
                    .Top       = 1
                    .Left      = 8
                    .Caption   = "Origem"
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_OriConta", "Label")
                WITH .lbl_4c_OriConta
                    .Top       = 1
                    .Left      = 90
                    .Caption   = "Conta"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_OriNome", "Label")
                WITH .lbl_4c_OriNome
                    .Top       = 1
                    .Left      = 173
                    .Caption   = "Nome"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_OriGrupo", "TextBox")
                WITH .txt_4c_OriGrupo
                    .Top           = 17
                    .Left          = 7
                    .Width         = 80
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH

                .AddObject("txt_4c_OriConta", "TextBox")
                WITH .txt_4c_OriConta
                    .Top           = 17
                    .Left          = 90
                    .Width         = 80
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH

                .AddObject("txt_4c_OriNome", "TextBox")
                WITH .txt_4c_OriNome
                    .Top           = 17
                    .Left          = 173
                    .Width         = 360
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .ReadOnly      = .T.
                    .Visible       = .T.
                ENDWITH
            ENDWITH

            *-- Container Destino (top=116, left=53, width=541, height=45)
            loc_oPg.AddObject("cnt_4c_Destino", "Container")
            WITH loc_oPg.cnt_4c_Destino
                .Top         = 116
                .Left        = 53
                .Width       = 541
                .Height      = 45
                .BackStyle   = 0
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.

                .AddObject("lbl_4c_DesTitulo", "Label")
                WITH .lbl_4c_DesTitulo
                    .Top       = 2
                    .Left      = 8
                    .Caption   = "Destino"
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_DesConta", "Label")
                WITH .lbl_4c_DesConta
                    .Top       = 2
                    .Left      = 90
                    .Caption   = "Conta"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_DesNome", "Label")
                WITH .lbl_4c_DesNome
                    .Top       = 2
                    .Left      = 173
                    .Caption   = "Nome"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DesGrupo", "TextBox")
                WITH .txt_4c_DesGrupo
                    .Top           = 17
                    .Left          = 7
                    .Width         = 80
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH

                .AddObject("txt_4c_DesConta", "TextBox")
                WITH .txt_4c_DesConta
                    .Top           = 17
                    .Left          = 90
                    .Width         = 80
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH

                .AddObject("txt_4c_DesNome", "TextBox")
                WITH .txt_4c_DesNome
                    .Top           = 17
                    .Left          = 173
                    .Width         = 360
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .ReadOnly      = .T.
                    .Visible       = .T.
                ENDWITH
            ENDWITH

            *-- Container Responsavel (top=167, left=53, width=541, height=45)
            loc_oPg.AddObject("cnt_4c_Responsavel", "Container")
            WITH loc_oPg.cnt_4c_Responsavel
                .Top         = 167
                .Left        = 53
                .Width       = 541
                .Height      = 45
                .BackStyle   = 0
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.

                .AddObject("lbl_4c_RespTitulo", "Label")
                WITH .lbl_4c_RespTitulo
                    .Top       = 2
                    .Left      = 6
                    .Caption   = "Respons" + CHR(225) + "vel"
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_RespConta", "Label")
                WITH .lbl_4c_RespConta
                    .Top       = 2
                    .Left      = 90
                    .Caption   = "Conta"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_RespNome", "Label")
                WITH .lbl_4c_RespNome
                    .Top       = 2
                    .Left      = 173
                    .Caption   = "Nome"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_RespGrupo", "TextBox")
                WITH .txt_4c_RespGrupo
                    .Top           = 17
                    .Left          = 7
                    .Width         = 80
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH

                .AddObject("txt_4c_RespConta", "TextBox")
                WITH .txt_4c_RespConta
                    .Top           = 17
                    .Left          = 90
                    .Width         = 80
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .Visible       = .T.
                ENDWITH

                .AddObject("txt_4c_RespNome", "TextBox")
                WITH .txt_4c_RespNome
                    .Top           = 17
                    .Left          = 173
                    .Width         = 360
                    .Height        = 21
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .SpecialEffect = 1
                    .BackColor     = RGB(255, 255, 255)
                    .ReadOnly      = .T.
                    .Visible       = .T.
                ENDWITH
            ENDWITH

            *-- Grade itens (equivalente Grade: top=219, left=53, w=563, h=343)
            loc_oPg.AddObject("grd_4c_Itens", "Grid")
            WITH loc_oPg.grd_4c_Itens
                .Top          = 219
                .Left         = 53
                .Width        = 563
                .Height       = 343
                .FontName     = "Tahoma"
                .FontSize     = 8
                .ColumnCount  = 4
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .GridLines    = 3
                .HeaderHeight = 17
                .RowHeight    = 17
                .ScrollBars   = 3
                .ReadOnly     = .T.
                .ForeColor    = RGB(0, 0, 0)
                .RecordSource = "crLclMvItn"
                .Visible      = .T.

                WITH .Column1
                    .ControlSource = "crLclMvItn.Cpros"
                    .Width         = 108
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Produto"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .T.
                        .BorderStyle = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column2
                    .ControlSource = "crLclMvItn.Qtds"
                    .Width         = 80
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Qtde"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .F.
                        .BorderStyle = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column3
                    .ControlSource = "crLclMvItn.Pesos"
                    .Width         = 90
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Peso Atual"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .F.
                        .BorderStyle = 0
                        .InputMask   = "9,999,999.999"
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column4
                    .ControlSource = "crLclMvItn.Dpros"
                    .Width         = 250
                    .Movable       = .F.
                    .Resizable     = .F.
                    WITH .Header1
                        .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .ReadOnly    = .T.
                        .BorderStyle = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH
            ENDWITH

            *-- Labels e campos de totais (equivalente Say3, getTQtde, getTPeso)
            loc_oPg.AddObject("lbl_4c_Total", "Label")
            WITH loc_oPg.lbl_4c_Total
                .Top       = 573
                .Left      = 381
                .Caption   = "Total :"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_TQtde", "TextBox")
            WITH loc_oPg.txt_4c_TQtde
                .Top           = 569
                .Left          = 423
                .Width         = 81
                .Height        = 22
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Value         = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_TPeso", "TextBox")
            WITH loc_oPg.txt_4c_TPeso
                .Top           = 569
                .Left          = 504
                .Width         = 91
                .Height        = 22
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Value         = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH

            *-- Botoes Salvar e Cancelar (equivalente Grupo_Salva: Left=815, Top=11)
            loc_oPg.AddObject("cmd_4c_Salvar", "CommandButton")
            WITH loc_oPg.cmd_4c_Salvar
                .Top             = 11
                .Left            = 820
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Salvar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .T.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .ToolTipText     = "Salvar e processar"
                .Visible         = .T.
            ENDWITH

            loc_oPg.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oPg.cmd_4c_Cancelar
                .Top             = 11
                .Left            = 895
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Cancelar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .T.
                .MousePointer    = 15
                .Cancel          = .T.
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .ToolTipText     = "[Esc] Cancelar"
                .Visible         = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles do form
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_oCtrl, loc_oErro
        TRY
            FOR EACH loc_oCtrl IN par_oContainer.Controls
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Visible = .T.
                    IF PEMSTATUS(loc_oCtrl, "Controls", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            *-- continua silenciosamente
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula eventos aos handlers
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oPg1, loc_oPg2, loc_oErro
        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Botoes Page1
            BINDEVENT(loc_oPg1.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPg1.cmd_4c_Consultar, "Click", THIS, "BtnConsultarClick")
            BINDEVENT(loc_oPg1.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPg1.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPg1.cmd_4c_Procurar,  "Click", THIS, "BtnProcurarClick")
            BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Filtro periodo
            BINDEVENT(loc_oPg1.cnt_4c_Periodo.txt_4c_DtFim, "KeyPress", THIS, "TxtDtFimLostFocus")

            *-- Botoes Page2
            BINDEVENT(loc_oPg2.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPg2.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
            BINDEVENT(loc_oPg2.cmd_4c_Pendentes,"Click", THIS, "BtnPendentesClick")

            *-- Data valid
            BINDEVENT(loc_oPg2.cnt_4c_Codigo.txt_4c_Data, "KeyPress", THIS, "TxtDataLostFocus")

            *-- Origem
            BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_OriGrupo, "KeyPress", THIS, "TxtOriGrupoLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_OriGrupo, "KeyPress",  THIS, "TxtOriGrupoKeyPress")
            BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_OriConta, "KeyPress", THIS, "TxtOriContaLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_OriConta, "KeyPress",  THIS, "TxtOriContaKeyPress")
            BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_OriNome,  "KeyPress", THIS, "TxtOriNomeLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_OriNome,  "KeyPress",  THIS, "TxtOriNomeKeyPress")

            *-- Destino
            BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_DesGrupo, "KeyPress", THIS, "TxtDesGrupoLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_DesGrupo, "KeyPress",  THIS, "TxtDesGrupoKeyPress")
            BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_DesConta, "KeyPress", THIS, "TxtDesContaLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_DesConta, "KeyPress",  THIS, "TxtDesContaKeyPress")
            BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_DesNome,  "KeyPress", THIS, "TxtDesNomeLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_DesNome,  "KeyPress",  THIS, "TxtDesNomeKeyPress")

            *-- Responsavel
            BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespGrupo, "KeyPress", THIS, "TxtRespGrupoLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespGrupo, "KeyPress",  THIS, "TxtRespGrupoKeyPress")
            BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespConta, "KeyPress", THIS, "TxtRespContaLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespConta, "KeyPress",  THIS, "TxtRespContaKeyPress")
            BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespNome,  "KeyPress", THIS, "TxtRespNomeLostFocus")
            BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespNome,  "KeyPress",  THIS, "TxtRespNomeKeyPress")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ConfigurarBINDEVENTs")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Executa Buscar() e atualiza grade da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oPg1, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                LOCAL loc_dIni, loc_dFim
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1
                loc_dIni = loc_oPg1.cnt_4c_Periodo.txt_4c_DtIni.Value
                loc_dFim = loc_oPg1.cnt_4c_Periodo.txt_4c_DtFim.Value

                IF VARTYPE(loc_dIni) = "D" AND !EMPTY(loc_dIni)
                    THIS.this_oBusinessObject.this_dDtIni = loc_dIni
                ENDIF
                IF VARTYPE(loc_dFim) = "D" AND !EMPTY(loc_dFim)
                    THIS.this_oBusinessObject.this_dDtFim = loc_dFim
                ENDIF

                THIS.this_oBusinessObject.Buscar("")

                IF USED("crSigMvCab") AND PEMSTATUS(loc_oPg1.grd_4c_Lista, "Refresh", 5)
                    loc_oPg1.grd_4c_Lista.RecordSource = "crSigMvCab"
                    loc_oPg1.grd_4c_Lista.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * IrParaPage1 - Vai para pagina Lista, limpa cursores da sessao
    *==========================================================================
    PROCEDURE IrParaPage1()
        LOCAL loc_oErro
        TRY
            THIS.this_cModo = ""

            *-- Limpa lote atual
            IF USED("TmpOperacao")
                ZAP IN TmpOperacao
            ENDIF
            IF USED("crLclMvItn")
                ZAP IN crLclMvItn
            ENDIF

            *-- Reseta BO
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cEmps       = ""
                THIS.this_oBusinessObject.this_nNumes      = 0
                THIS.this_oBusinessObject.this_cEmpDopNums = ""
                THIS.this_oBusinessObject.this_lChkSubn    = .F.
            ENDIF

            *-- Reseta campos de Page2
            THIS.LimparCamposDados()

            *-- Recarrega lista e vai para Page1
            THIS.CarregarLista()
            THIS.pgf_4c_Paginas.ActivePage = 1

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro IrParaPage1")
        ENDTRY
    ENDPROC

    *==========================================================================
    * IrParaPage2 - Vai para pagina Dados com modo informado
    *==========================================================================
    PROCEDURE IrParaPage2(par_cModo)
        LOCAL loc_oErro
        TRY
            THIS.this_cModo = par_cModo
            THIS.AtualizarEdicaoCampos()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro IrParaPage2")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            IF par_nPagina = 1
                THIS.IrParaPage1()
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCamposDados - Reseta todos os campos da Page2
    *==========================================================================
    PROCEDURE LimparCamposDados()
        LOCAL loc_oPg2, loc_oErro
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.cnt_4c_Codigo.txt_4c_Codigo.Value  = ""
            loc_oPg2.cnt_4c_Codigo.txt_4c_Data.Value    = DATE()
            loc_oPg2.cnt_4c_Origem.txt_4c_OriGrupo.Value = ""
            loc_oPg2.cnt_4c_Origem.txt_4c_OriConta.Value = ""
            loc_oPg2.cnt_4c_Origem.txt_4c_OriNome.Value  = ""
            loc_oPg2.cnt_4c_Destino.txt_4c_DesGrupo.Value = ""
            loc_oPg2.cnt_4c_Destino.txt_4c_DesConta.Value = ""
            loc_oPg2.cnt_4c_Destino.txt_4c_DesNome.Value  = ""
            loc_oPg2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value = ""
            loc_oPg2.cnt_4c_Responsavel.txt_4c_RespConta.Value = ""
            loc_oPg2.cnt_4c_Responsavel.txt_4c_RespNome.Value  = ""
            loc_oPg2.txt_4c_TQtde.Value = 0
            loc_oPg2.txt_4c_TPeso.Value = 0
        CATCH TO loc_oErro
            *-- continua silenciosamente
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarEdicaoCampos - Habilita/desabilita campos conforme modo
    *==========================================================================
    PROCEDURE AtualizarEdicaoCampos()
        LOCAL loc_oPg2, loc_lEdita, loc_oErro
        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_lEdita = INLIST(THIS.this_cModo, "INSERIR", "ALTERAR")

            loc_oPg2.cnt_4c_Codigo.txt_4c_Data.ReadOnly    = !loc_lEdita
            loc_oPg2.cmd_4c_Pendentes.Enabled               = loc_lEdita
            loc_oPg2.grd_4c_Operacao.ReadOnly               = !INLIST(THIS.this_cModo, "INSERIR")

            *-- Campos Origem: editavel se Origems=1 e lEditaOrigem e modo edita
            LOCAL loc_lOriEdita
            loc_lOriEdita = loc_lEdita AND THIS.this_lEditaOrigem AND ;
                            THIS.this_oBusinessObject.this_nOrigems = 1
            loc_oPg2.cnt_4c_Origem.txt_4c_OriGrupo.ReadOnly = !loc_lOriEdita OR ;
                                            THIS.this_oBusinessObject.this_lFixGOrigs
            loc_oPg2.cnt_4c_Origem.txt_4c_OriConta.ReadOnly = !loc_lOriEdita OR ;
                                            THIS.this_oBusinessObject.this_lFixCOrigs

            *-- Campos Destino: editavel se Destinos=1 e modo edita
            LOCAL loc_lDesEdita
            loc_lDesEdita = loc_lEdita AND THIS.this_oBusinessObject.this_nDestinos = 1
            loc_oPg2.cnt_4c_Destino.txt_4c_DesGrupo.ReadOnly = !loc_lDesEdita OR ;
                                              THIS.this_oBusinessObject.this_lFixGDests
            loc_oPg2.cnt_4c_Destino.txt_4c_DesConta.ReadOnly = !loc_lDesEdita OR ;
                                              THIS.this_oBusinessObject.this_lFixCDests

            *-- Campos Responsavel: editavel se Vendes>0 e modo edita
            LOCAL loc_lRespEdita
            loc_lRespEdita = loc_lEdita AND THIS.this_oBusinessObject.this_nVendes > 0
            loc_oPg2.cnt_4c_Responsavel.txt_4c_RespGrupo.ReadOnly = !loc_lRespEdita OR ;
                                                THIS.this_oBusinessObject.this_lFixGVends
            loc_oPg2.cnt_4c_Responsavel.txt_4c_RespConta.ReadOnly = !loc_lRespEdita

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AtualizarEdicaoCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega dados do BO nos campos visuais
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO, loc_oErro
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            loc_oPg2.cnt_4c_Codigo.txt_4c_Codigo.Value  = loc_oBO.this_cMascNum
            loc_oPg2.cnt_4c_Codigo.txt_4c_Data.Value    = IIF(EMPTY(loc_oBO.this_dDatas), DATE(), loc_oBO.this_dDatas)
            loc_oPg2.cnt_4c_Origem.txt_4c_OriGrupo.Value = ALLTRIM(loc_oBO.this_cGrupoos)
            loc_oPg2.cnt_4c_Origem.txt_4c_OriConta.Value = ALLTRIM(loc_oBO.this_cContaos)
            loc_oPg2.cnt_4c_Origem.txt_4c_OriNome.Value  = ALLTRIM(loc_oBO.this_cDescOrigem)
            loc_oPg2.cnt_4c_Destino.txt_4c_DesGrupo.Value = ALLTRIM(loc_oBO.this_cGrupods)
            loc_oPg2.cnt_4c_Destino.txt_4c_DesConta.Value = ALLTRIM(loc_oBO.this_cContads)
            loc_oPg2.cnt_4c_Destino.txt_4c_DesNome.Value  = ALLTRIM(loc_oBO.this_cDescDestino)
            loc_oPg2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value = ALLTRIM(loc_oBO.this_cGrVends)
            loc_oPg2.cnt_4c_Responsavel.txt_4c_RespConta.Value = ALLTRIM(loc_oBO.this_cVends)
            loc_oPg2.cnt_4c_Responsavel.txt_4c_RespNome.Value  = ALLTRIM(loc_oBO.this_cDescVend)
            loc_oPg2.txt_4c_TQtde.Value = loc_oBO.this_nTotalQtde
            loc_oPg2.txt_4c_TPeso.Value = loc_oBO.this_nTotalPeso

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Salva dados dos campos visuais no BO
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO, loc_oErro
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            loc_oBO.this_dDatas    = loc_oPg2.cnt_4c_Codigo.txt_4c_Data.Value
            loc_oBO.this_cGrupoos  = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_OriGrupo.Value)
            loc_oBO.this_cContaos  = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_OriConta.Value)
            loc_oBO.this_cGrupods  = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_DesGrupo.Value)
            loc_oBO.this_cContads  = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_DesConta.Value)
            loc_oBO.this_cGrVends  = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value)
            loc_oBO.this_cVends    = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespConta.Value)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCampos - Valida campos obrigatorios conforme configuracao de SigCdOpe
    * Retorna .T. se validacao passou
    *==========================================================================
    PROCEDURE ValidarCampos()
        LOCAL loc_lValido, loc_oPg2, loc_oBO, loc_oErro
        loc_lValido = .T.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            IF loc_oBO.this_nOrigems = 1 AND loc_lValido
                IF EMPTY(loc_oPg2.cnt_4c_Origem.txt_4c_OriGrupo.Value)
                    MsgAviso("Grupo de Origem inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.cnt_4c_Origem.txt_4c_OriGrupo.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_oBO.this_nOrigems = 1 AND loc_lValido
                IF EMPTY(loc_oPg2.cnt_4c_Origem.txt_4c_OriConta.Value) AND ;
                   EMPTY(loc_oPg2.cnt_4c_Origem.txt_4c_OriNome.Value)
                    MsgAviso("Conta de Origem inv" + CHR(225) + "lida!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.cnt_4c_Origem.txt_4c_OriConta.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_oBO.this_nDestinos = 1 AND loc_lValido
                IF EMPTY(loc_oPg2.cnt_4c_Destino.txt_4c_DesGrupo.Value)
                    MsgAviso("Grupo de Destino inv" + CHR(225) + "lido!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.cnt_4c_Destino.txt_4c_DesGrupo.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_oBO.this_nVendes = 1 AND loc_lValido
                IF EMPTY(loc_oPg2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value)
                    MsgAviso("Grupo do Respons" + CHR(225) + "vel inv" + CHR(225) + "lido!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_RespGrupo.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarCampos")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Modo INSERIR: habilita GradeOperacao e vai para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.LimparCamposDados()
            IF USED("TmpOperacao")
                ZAP IN TmpOperacao
            ENDIF
            IF USED("crLclMvItn")
                ZAP IN crLclMvItn
            ENDIF

            *-- Pre-carrega padrao Origem/Destino/Responsavel da operacao
            LOCAL loc_oBO
            loc_oBO = THIS.this_oBusinessObject
            IF !EMPTY(loc_oBO.this_cGruOrigs) AND !loc_oBO.this_lFixGOrigs
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriGrupo.Value = ALLTRIM(loc_oBO.this_cGruOrigs)
            ENDIF
            IF !EMPTY(loc_oBO.this_cConOrigs) AND !loc_oBO.this_lFixCOrigs
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriConta.Value = ALLTRIM(loc_oBO.this_cConOrigs)
            ENDIF
            IF !EMPTY(loc_oBO.this_cGruDests)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesGrupo.Value = ALLTRIM(loc_oBO.this_cGruDests)
            ENDIF
            IF !EMPTY(loc_oBO.this_cConDests)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesConta.Value = ALLTRIM(loc_oBO.this_cConDests)
            ENDIF
            IF !EMPTY(loc_oBO.this_cGrVendsOpe)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value = ALLTRIM(loc_oBO.this_cGrVendsOpe)
            ENDIF

            THIS.IrParaPage2("INSERIR")
            THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao.SetFocus()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnConsultarClick - Modo CONSULTAR: carrega registro selecionado
    *==========================================================================
    PROCEDURE BtnConsultarClick()
        LOCAL loc_oErro, loc_cChave, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !USED("crSigMvCab") OR RECCOUNT("crSigMvCab") = 0
                MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                SELECT crSigMvCab
                loc_cChave = ALLTRIM(crSigMvCab.EmpDopNums)
                IF EMPTY(loc_cChave)
                    MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.CarregarItens(loc_cChave)
                    THIS.BOParaForm()
                    THIS.IrParaPage2("CONSULTAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnConsultarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alias canonico do padrao migracao (delega a Consultar)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.BtnConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Modo ALTERAR: carrega registro para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro, loc_cChave, loc_oBO, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !USED("crSigMvCab") OR RECCOUNT("crSigMvCab") = 0
                MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                SELECT crSigMvCab
                IF crSigMvCab.ChkSubn <> 0
                    MsgAviso("Movimento j" + CHR(225) + " processado. N" + CHR(227) + ;
                             "o pode ser alterado.", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                loc_cChave = ALLTRIM(crSigMvCab.EmpDopNums)
                IF EMPTY(loc_cChave)
                    MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.CarregarItens(loc_cChave)
                    THIS.BOParaForm()
                    THIS.IrParaPage2("ALTERAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Modo EXCLUIR: confirma e cancela desmontagem
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_cChave, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !USED("crSigMvCab") OR RECCOUNT("crSigMvCab") = 0
                MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                SELECT crSigMvCab
                loc_cChave = ALLTRIM(crSigMvCab.EmpDopNums)
                IF EMPTY(loc_cChave)
                    MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                IF !MsgConfirma("Confirma o cancelamento/exclus" + CHR(227) + "o do movimento?", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Movimento exclu" + CHR(237) + "do com sucesso.", "Aviso")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcurarClick - Modo PROCURAR: habilita campo codigo para busca
    *==========================================================================
    PROCEDURE BtnProcurarClick()
        LOCAL loc_oErro
        TRY
            THIS.IrParaPage2("PROCURAR")
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigo.txt_4c_Codigo.ReadOnly = .F.
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigo.txt_4c_Codigo.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnProcurarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida, atualiza BO e processa desmontagem
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lContinuar, loc_oErro
        loc_lContinuar = .T.

        TRY
            IF THIS.this_cModo = "CONSULTAR"
                THIS.IrParaPage1()
                loc_lContinuar = .F.
            ENDIF

            *-- Modo EXCLUIR delegado a BtnExcluirClick (nao deve chegar aqui normalmente)
            IF loc_lContinuar AND THIS.this_cModo = "EXCLUIR"
                THIS.IrParaPage1()
                loc_lContinuar = .F.
            ENDIF

            *-- INSERIR/ALTERAR: valida campos
            IF loc_lContinuar
                loc_lContinuar = THIS.ValidarCampos()
            ENDIF

            *-- Verifica se ha itens para processar
            IF loc_lContinuar AND THIS.this_cModo = "INSERIR"
                IF !USED("crLclMvItn") OR RECCOUNT("crLclMvItn") = 0
                    MsgAviso("Nenhum item informado para desmontagem.", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Verifica bloqueio de periodo
            IF loc_lContinuar
                LOCAL loc_dData
                loc_dData = THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigo.txt_4c_Data.Value
                IF VARTYPE(loc_dData) = "D" AND !EMPTY(loc_dData)
                    IF THIS.this_oBusinessObject.VerificarBloqueio(loc_dData) <> 0
                        MsgAviso("Per" + CHR(237) + "odo Bloqueado!", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Sincroniza form -> BO
            IF loc_lContinuar
                THIS.FormParaBO()
            ENDIF

            *-- Se INSERIR: INSERT ja feito no GradeOperacao handler; apenas Atualizar grupos
            IF loc_lContinuar
                IF !THIS.this_oBusinessObject.this_lNovoRegistro
                    IF INLIST(THIS.this_cModo, "INSERIR", "ALTERAR")
                        IF !THIS.this_oBusinessObject.Atualizar()
                            loc_lContinuar = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- Processar desmontagem (mSv_inserir)
            IF loc_lContinuar AND INLIST(THIS.this_cModo, "INSERIR", "ALTERAR")
                IF THIS.this_oBusinessObject.this_lChkSubn
                    MsgAviso("Movimento j" + CHR(225) + " foi processado anteriormente.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar AND INLIST(THIS.this_cModo, "INSERIR", "ALTERAR")
                IF THIS.this_oBusinessObject.ProcessarDesmontagem()
                    MsgInfo("Desmontagem processada com sucesso.", "Aviso")
                    THIS.IrParaPage1()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao atual e volta para Page1
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.IrParaPage1()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnPendentesClick - Abre form de selecao de produtos (SigOpPdt)
    * Atualiza crLclMvItn e recalcula totais
    *==========================================================================
    PROCEDURE BtnPendentesClick()
        LOCAL loc_oErro, loc_nTQtds, loc_nTPesos, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !INLIST(THIS.this_cModo, "INSERIR", "ALTERAR")
                loc_lContinuar = .F.
            ENDIF

            *-- Verifica se ha movimento ativo
            IF loc_lContinuar AND EMPTY(THIS.this_oBusinessObject.this_cEmpDopNums)
                MsgAviso("Informe um n" + CHR(250) + "mero de movimento antes de adicionar itens.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- SigOpPdt nao foi migrado ainda - exibe aviso e continua
                MsgAviso("Form de Sele" + CHR(231) + CHR(227) + "o de Produtos (SigOpPdt) " + ;
                         "ainda n" + CHR(227) + "o foi migrado." + CHR(13) + ;
                         "Adicione itens diretamente via SQL ou aguarde migra" + CHR(231) + CHR(227) + "o.", ;
                         "Aviso")

                *-- Recalcular totais apos fechar o form auxiliar
                IF USED("crLclMvItn") AND RECCOUNT("crLclMvItn") > 0
                    SELECT SUM(Qtds) AS TQtds, SUM(Qtds * Pesos) AS TPesos ;
                        FROM crLclMvItn ;
                        INTO CURSOR cursor_4c_Tot READWRITE
                    IF RECCOUNT("cursor_4c_Tot") > 0
                        SELECT cursor_4c_Tot
                        loc_nTQtds  = IIF(EMPTY(cursor_4c_Tot.TQtds),  0, cursor_4c_Tot.TQtds)
                        loc_nTPesos = IIF(EMPTY(cursor_4c_Tot.TPesos), 0, cursor_4c_Tot.TPesos)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_TQtde.Value = loc_nTQtds
                        THIS.pgf_4c_Paginas.Page2.txt_4c_TPeso.Value = loc_nTPesos
                        THIS.this_oBusinessObject.this_nTotalQtde = loc_nTQtds
                        THIS.this_oBusinessObject.this_nTotalPeso = loc_nTPesos
                    ENDIF
                    IF USED("cursor_4c_Tot")
                        USE IN cursor_4c_Tot
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.grd_4c_Itens, "Refresh", 5)
                        THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Refresh()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnPendentesClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDtFimLostFocus - Recarrega lista ao sair do campo DtFim
    *==========================================================================
    PROCEDURE TxtDtFimLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * TxtDataLostFocus - Valida data operacao (periodo bloqueado)
    *==========================================================================
    PROCEDURE TxtDataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro, loc_dVal
        TRY
            loc_dVal = THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigo.txt_4c_Data.Value
            IF VARTYPE(loc_dVal) = "D" AND !EMPTY(loc_dVal)
                IF THIS.this_oBusinessObject.VerificarBloqueio(loc_dVal) <> 0
                    MsgAviso("Per" + CHR(237) + "odo Bloqueado!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigo.txt_4c_Data.Value = DATE()
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigo.txt_4c_Data.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtDataLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupo - Abre picker de grupo via TempGccr (FormBuscaAuxiliar Mode 2)
    * Retorna codigo selecionado ou "" se cancelado
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupo(par_cValorAtual)
        LOCAL loc_cCodigo, loc_oBusca, loc_oErro
        loc_cCodigo = ""

        TRY
            IF !USED("TempGccr")
                MsgErro("Tabela de grupos n" + CHR(227) + "o carregada.", "Erro")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "TempGccr"
                    loc_oBusca.this_cTitulo = "Grupos Cont" + CHR(225) + "beis"
                    IF VARTYPE(loc_oBusca.cnt_4c_Cabecalho) = "O"
                        loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_oBusca.this_cTitulo
                    ENDIF
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("TempGccr")
                        SELECT TempGccr
                        loc_cCodigo = ALLTRIM(TempGccr.Codigos)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirLookupGrupo")
        ENDTRY

        RETURN loc_cCodigo
    ENDPROC

    *==========================================================================
    * AbrirLookupConta - Abre picker de conta via SigCdCli (FormBuscaAuxiliar Mode 1)
    * par_lGerBals = .T. exige GerBals=1 (apenas contas com balanco)
    * Retorna array com [IClis, RClis] ou ["",""] se cancelado
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupConta(par_cValorAtual, par_cGrupo, par_lGerBals)
        LOCAL loc_oBusca, loc_cFiltro, loc_oErro
        LOCAL ARRAY loc_aResult(2)
        loc_aResult(1) = ""
        loc_aResult(2) = ""

        TRY
            loc_cFiltro = IIF(par_lGerBals, "GerBals = 1", "")

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "IClis", par_cValorAtual, ;
                "Contas/Clientes", .F., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaCli")
                        SELECT cursor_4c_BuscaCli
                        loc_aResult(1) = ALLTRIM(cursor_4c_BuscaCli.IClis)
                        loc_aResult(2) = ALLTRIM(TratarNulo(cursor_4c_BuscaCli.RClis, "C"))
                    ENDIF
                ELSE
                    loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                        SELECT cursor_4c_BuscaCli
                        loc_aResult(1) = ALLTRIM(cursor_4c_BuscaCli.IClis)
                        loc_aResult(2) = ALLTRIM(TratarNulo(cursor_4c_BuscaCli.RClis, "C"))
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirLookupConta")
        ENDTRY

        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF

        RETURN @loc_aResult
    ENDPROC

    *==========================================================================
    * ValidarGrupoNoCursor - Valida grupo digitado contra TempGccr
    * Retorna .T. se valido, .F. se nao encontrado
    *==========================================================================
    PROTECTED PROCEDURE ValidarGrupoNoCursor(par_cGrupo)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .F.

        TRY
            IF USED("TempGccr") AND !EMPTY(par_cGrupo)
                SET ORDER TO BalCodigo IN TempGccr
                loc_lValido = SEEK(PADR(ALLTRIM(par_cGrupo), 10), "TempGccr", "BalCodigo")
                SET ORDER TO Codigos IN TempGccr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarGrupoNoCursor")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BuscarDescricaoConta - Busca RClis no SQL Server para IClis informado
    * Retorna descricao ou "" se nao encontrado
    *==========================================================================
    PROTECTED PROCEDURE BuscarDescricaoConta(par_cIClis, par_lGerBals)
        LOCAL loc_cDesc, loc_cSQL, loc_oErro
        loc_cDesc = ""

        TRY
            IF !EMPTY(par_cIClis)
                IF par_lGerBals
                    loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(par_cIClis) + " AND GerBals = 1"
                ELSE
                    loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(par_cIClis)
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli") >= 1
                    IF !EOF("cursor_4c_Cli")
                        SELECT cursor_4c_Cli
                        loc_cDesc = ALLTRIM(TratarNulo(cursor_4c_Cli.RClis, "C"))
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BuscarDescricaoConta")
        ENDTRY

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * -- HANDLERS DE GRUPO/CONTA (Origem) --
    *==========================================================================
    PROCEDURE TxtOriGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cSel, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriGrupo.Value)
                IF !THIS.ValidarGrupoNoCursor(loc_cVal)
                    loc_cSel = THIS.AbrirLookupGrupo(loc_cVal)
                    IF !EMPTY(loc_cSel)
                        THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriGrupo.Value = loc_cSel
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtOriGrupoKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtOriGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cSel, loc_oErro
        TRY
            loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriGrupo.Value)
            IF !EMPTY(loc_cVal) AND !THIS.ValidarGrupoNoCursor(loc_cVal)
                loc_cSel = THIS.AbrirLookupGrupo(loc_cVal)
                IF !EMPTY(loc_cSel)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriGrupo.Value = loc_cSel
                ELSE
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriGrupo.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtOriGrupoLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtOriContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cGrupo, loc_cDesc, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriConta.Value)
                loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriGrupo.Value)
                IF USED("TempGccr") AND !EMPTY(loc_cGrupo)
                    SET ORDER TO BalCodigo IN TempGccr
                    SEEK loc_cGrupo IN TempGccr
                    SET ORDER TO Codigos IN TempGccr
                ENDIF
                LOCAL ARRAY loc_aRes(2)
                ACOPY(THIS.AbrirLookupConta(loc_cVal, loc_cGrupo, .T.), loc_aRes)
                IF !EMPTY(loc_aRes(1))
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriConta.Value = loc_aRes(1)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriNome.Value  = loc_aRes(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtOriContaKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtOriContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cDesc, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriConta.Value)
            IF !EMPTY(loc_cVal)
                loc_cDesc = THIS.BuscarDescricaoConta(loc_cVal, .T.)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriNome.Value = loc_cDesc
                THIS.this_oBusinessObject.this_cDescOrigem = loc_cDesc
            ELSE
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriNome.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtOriContaLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtOriNomeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cGrupo, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriNome.Value)
                loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriGrupo.Value)
                LOCAL ARRAY loc_aRes(2)
                ACOPY(THIS.AbrirLookupConta(loc_cVal, loc_cGrupo, .T.), loc_aRes)
                IF !EMPTY(loc_aRes(1))
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriConta.Value = loc_aRes(1)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_OriNome.Value  = loc_aRes(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtOriNomeKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtOriNomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *==========================================================================
    * -- HANDLERS DE GRUPO/CONTA (Destino) --
    *==========================================================================
    PROCEDURE TxtDesGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cSel, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesGrupo.Value)
                IF !THIS.ValidarGrupoNoCursor(loc_cVal)
                    loc_cSel = THIS.AbrirLookupGrupo(loc_cVal)
                    IF !EMPTY(loc_cSel)
                        THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesGrupo.Value = loc_cSel
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtDesGrupoKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDesGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cSel, loc_oErro
        TRY
            loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesGrupo.Value)
            IF !EMPTY(loc_cVal) AND !THIS.ValidarGrupoNoCursor(loc_cVal)
                loc_cSel = THIS.AbrirLookupGrupo(loc_cVal)
                IF !EMPTY(loc_cSel)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesGrupo.Value = loc_cSel
                ELSE
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesGrupo.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtDesGrupoLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDesContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cGrupo, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesConta.Value)
                loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesGrupo.Value)
                LOCAL ARRAY loc_aRes(2)
                ACOPY(THIS.AbrirLookupConta(loc_cVal, loc_cGrupo, .T.), loc_aRes)
                IF !EMPTY(loc_aRes(1))
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesConta.Value = loc_aRes(1)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesNome.Value  = loc_aRes(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtDesContaKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDesContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cDesc, loc_oErro
        TRY
            loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesConta.Value)
            IF !EMPTY(loc_cVal)
                loc_cDesc = THIS.BuscarDescricaoConta(loc_cVal, .T.)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesNome.Value = loc_cDesc
                THIS.this_oBusinessObject.this_cDescDestino = loc_cDesc
            ELSE
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesNome.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtDesContaLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDesNomeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cGrupo, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesNome.Value)
                loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesGrupo.Value)
                LOCAL ARRAY loc_aRes(2)
                ACOPY(THIS.AbrirLookupConta(loc_cVal, loc_cGrupo, .T.), loc_aRes)
                IF !EMPTY(loc_aRes(1))
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesConta.Value = loc_aRes(1)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Destino.txt_4c_DesNome.Value  = loc_aRes(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtDesNomeKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDesNomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *==========================================================================
    * -- HANDLERS DE GRUPO/CONTA (Responsavel) --
    *==========================================================================
    PROCEDURE TxtRespGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cSel, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value)
                IF !THIS.ValidarGrupoNoCursor(loc_cVal)
                    loc_cSel = THIS.AbrirLookupGrupo(loc_cVal)
                    IF !EMPTY(loc_cSel)
                        THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value = loc_cSel
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtRespGrupoKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtRespGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cSel, loc_oErro
        TRY
            loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value)
            IF !EMPTY(loc_cVal) AND !THIS.ValidarGrupoNoCursor(loc_cVal)
                loc_cSel = THIS.AbrirLookupGrupo(loc_cVal)
                IF !EMPTY(loc_cSel)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value = loc_cSel
                ELSE
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtRespGrupoLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtRespContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cGrupo, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespConta.Value)
                loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value)
                LOCAL ARRAY loc_aRes(2)
                ACOPY(THIS.AbrirLookupConta(loc_cVal, loc_cGrupo, .T.), loc_aRes)
                IF !EMPTY(loc_aRes(1))
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespConta.Value = loc_aRes(1)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespNome.Value  = loc_aRes(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtRespContaKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtRespContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cDesc, loc_oErro
        TRY
            loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespConta.Value)
            IF !EMPTY(loc_cVal)
                loc_cDesc = THIS.BuscarDescricaoConta(loc_cVal, .T.)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespNome.Value = loc_cDesc
                THIS.this_oBusinessObject.this_cDescVend = loc_cDesc
            ELSE
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespNome.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtRespContaLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtRespNomeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cGrupo, loc_oErro
        TRY
            IF par_nKeyCode = 115 OR par_nKeyCode = 13
                loc_cVal   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespNome.Value)
                loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespGrupo.Value)
                LOCAL ARRAY loc_aRes(2)
                ACOPY(THIS.AbrirLookupConta(loc_cVal, loc_cGrupo, .T.), loc_aRes)
                IF !EMPTY(loc_aRes(1))
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespConta.Value = loc_aRes(1)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Responsavel.txt_4c_RespNome.Value  = loc_aRes(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtRespNomeKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtRespNomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *==========================================================================
    * AdicionarOperacaoLote - Adiciona um Numes ao lote TmpOperacao
    * Equivale ao Text1.Valid da GradeOperacao legada
    * Chamado externamente (ex: formulario auxiliar ou procedimento de testes)
    *==========================================================================
    PROCEDURE AdicionarOperacaoLote(par_nCodigos)
        LOCAL loc_lSucesso, loc_lContinuar, loc_cSQL, loc_oErro
        LOCAL loc_cChave, loc_cEmps, loc_cDopes
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF par_nCodigos = 0 OR EMPTY(par_nCodigos)
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND par_nCodigos = THIS.this_nNumes_Old
                loc_lContinuar = .F.
            ENDIF

            *-- Verifica duplicata no lote atual
            IF loc_lContinuar AND USED("TmpOperacao")
                IF SEEK(par_nCodigos, "TmpOperacao", "Codigos")
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o j" + CHR(225) + ;
                             " digitada!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cDopes = THIS.this_oBusinessObject.this_cDopesAtual

            *-- Tenta localizar no crSigMvCab (existente)
            IF USED("crSigMvCab")
                SET ORDER TO Numes IN crSigMvCab
                IF SEEK(par_nCodigos, "crSigMvCab", "Numes")
                    *-- Carrega registro existente
                    loc_cChave = ALLTRIM(crSigMvCab.EmpDopNums)
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        THIS.this_oBusinessObject.CarregarItens(loc_cChave)
                        THIS.BOParaForm()

                        *-- Adiciona ao lote
                        INSERT INTO TmpOperacao (Emps, Dopes, Numes, Codigos) ;
                               VALUES (loc_cEmps, loc_cDopes, par_nCodigos, par_nCodigos)

                        THIS.this_nNumes_Old = par_nCodigos
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    *-- Novo registro: INSERT via BO
                    IF THIS.this_oBusinessObject.Inserir()
                        INSERT INTO TmpOperacao (Emps, Dopes, Numes, Codigos) ;
                               VALUES (loc_cEmps, loc_cDopes, ;
                                       THIS.this_oBusinessObject.this_nNumes, par_nCodigos)

                        THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigo.txt_4c_Codigo.Value = ;
                            ALLTRIM(THIS.this_oBusinessObject.this_cMascNum)
                        THIS.this_nNumes_Old = par_nCodigos
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
                SET ORDER TO IN crSigMvCab
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro AdicionarOperacaoLote")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
