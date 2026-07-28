*==============================================================================
* FormCAF.PRG
* Formulario de Cancelamento de OP da Fundicao
* Tabela principal: SIGCDCNF
* Tipo: CRUD com grid operacional
* BO: CAFBO
*==============================================================================

DEFINE CLASS FormCAF AS FormBase

    *-- Propriedades visuais
    Height      = 600
    Width       = 1000
    Caption     = "Cancelamento de OP da Fundicao"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Cancelamento de OP da Fundi" + CHR(231) + CHR(227) + "o"
            THIS.this_oBusinessObject = CREATEOBJECT("CAFBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar CAFBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria cabecalho, botoes CRUD e grid da Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Botoes CRUD
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid da lista (codigos/datas/usuars/obss de SIGCDCNF)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.RecordSource = ""
        loc_oPg1.grd_4c_Lista.ColumnCount  = 4

        WITH loc_oPg1.grd_4c_Lista
            .Top                     = 117
            .Left                    = 12
            .Width                   = 890
            .Height                  = 480
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 2
            .GridLines               = 3
            .ReadOnly                = .T.
            .Visible                 = .T.
            .Column1.Width           = 70
            .Column2.Width           = 140
            .Column3.Width           = 120
            .Column4.Width           = 490
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column3.ReadOnly        = .T.
            .Column4.ReadOnly        = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "digos"
            .Column2.Header1.Caption = "Datas"
            .Column3.Header1.Caption = "usuars"
            .Column4.Header1.Caption = "Observa" + CHR(231) + CHR(245) + "es"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria campos e grid de OPs da Page2
    * Layout preserva coordenadas do SCX legado (+29 por PageFrame.Top=-29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Botoes Confirmar/Cancelar (Top=4+29=33)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Linha 1: Cancelamento N? / getCodigos / Data / getDatas / Usuario / Getusu
        *-- Say2: Left=139, Top=162 ? +29 = 191
        loc_oPg2.AddObject("lbl_4c_LabelCod", "Label")
        WITH loc_oPg2.lbl_4c_LabelCod
            .Caption   = "Cancelamento N" + CHR(186) + " :"
            .Top       = 191
            .Left      = 139
            .Width     = 115
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- getCodigos: Left=251, Top=157 ? +29 = 186
        loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPg2.txt_4c_Codigos
            .Value         = 0
            .Top           = 186
            .Left          = 255
            .Width         = 52
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(235, 235, 235)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "999999"
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Say3: "Data :" Left=358, Top=163 ? +29 = 192
        loc_oPg2.AddObject("lbl_4c_LabelData", "Label")
        WITH loc_oPg2.lbl_4c_LabelData
            .Caption   = "Data :"
            .Top       = 192
            .Left      = 330
            .Width     = 65
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- getDatas: Left=396, Top=157 ? +29 = 186
        loc_oPg2.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPg2.txt_4c_Datas
            .Value         = DATE()
            .Top           = 186
            .Left          = 396
            .Width         = 90
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(235, 235, 235)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Say1: "Usuario : " Left=497, Top=162 ? +29 = 191
        loc_oPg2.AddObject("lbl_4c_LabelUsu", "Label")
        WITH loc_oPg2.lbl_4c_LabelUsu
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 191
            .Left      = 490
            .Width     = 62
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Getusu: Left=552, Top=157 ? +29 = 186; sempre readonly
        loc_oPg2.AddObject("txt_4c_Usuarios", "TextBox")
        WITH loc_oPg2.txt_4c_Usuarios
            .Value         = ""
            .Top           = 186
            .Left          = 552
            .Width         = 90
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(235, 235, 235)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: O.P. n? / Get_nop / Componentes: / Get_qtd (total tubos - readonly)
        *-- Say5: "O.P. n? : " Left=202, Top=203 ? +29 = 232
        loc_oPg2.AddObject("lbl_4c_LabelNop", "Label")
        WITH loc_oPg2.lbl_4c_LabelNop
            .Caption   = "O.P. n" + CHR(186) + " :"
            .Top       = 232
            .Left      = 202
            .Width     = 55
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_nop: Left=255, Top=201 ? +29 = 230; pressionar Enter/Tab/F4 valida OP
        loc_oPg2.AddObject("txt_4c_Nop", "TextBox")
        WITH loc_oPg2.txt_4c_Nop
            .Value         = 0
            .Top           = 230
            .Left          = 255
            .Width         = 94
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "999999999999"
            .Format        = "K"
            .Visible       = .T.
        ENDWITH

        *-- Say6: "Componentes:" Left=378, Top=202 ? +29 = 231
        loc_oPg2.AddObject("lbl_4c_LabelComp", "Label")
        WITH loc_oPg2.lbl_4c_LabelComp
            .Caption   = "Componentes:"
            .Top       = 231
            .Left      = 365
            .Width     = 100
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_qtd (total tubos disponiveis - readonly): Left=467, Top=200 ? +29 = 229
        loc_oPg2.AddObject("txt_4c_Qtd", "TextBox")
        WITH loc_oPg2.txt_4c_Qtd
            .Value         = 0
            .Top           = 229
            .Left          = 467
            .Width         = 87
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(235, 235, 235)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "999,999.999"
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Linha 3: Qtde Cancelada / Get_QtTb / Qtd. Pecas / Get_pecas (readonly)
        *-- Say4: "Qtde Cancelada : " Left=152, Top=224 ? +29 = 253
        loc_oPg2.AddObject("lbl_4c_LabelQtd", "Label")
        WITH loc_oPg2.lbl_4c_LabelQtd
            .Caption   = "Qtde Cancelada :"
            .Top       = 253
            .Left      = 152
            .Width     = 105
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_QtTb: Left=255, Top=222 ? +29 = 251; pressionar Enter/Tab/F4 confirma qtd
        loc_oPg2.AddObject("txt_4c_QtTb", "TextBox")
        WITH loc_oPg2.txt_4c_QtTb
            .Value         = 0
            .Top           = 251
            .Left          = 255
            .Width         = 94
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "999,999.999"
            .Alignment     = 3
            .Visible       = .T.
        ENDWITH

        *-- Say7: "Qtd. Pecas :" Left=391, Top=223 ? +29 = 252
        loc_oPg2.AddObject("lbl_4c_LabelPecas", "Label")
        WITH loc_oPg2.lbl_4c_LabelPecas
            .Caption   = "Qtd. Pe" + CHR(231) + "as :"
            .Top       = 252
            .Left      = 365
            .Width     = 102
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_pecas (total pecas - readonly): Left=467, Top=222 ? +29 = 251
        loc_oPg2.AddObject("txt_4c_Pecas", "TextBox")
        WITH loc_oPg2.txt_4c_Pecas
            .Value         = 0
            .Top           = 251
            .Left          = 467
            .Width         = 87
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(235, 235, 235)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "999,999.999"
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Grid OPs (Gradenop): Left=203, Top=245 ? +29 = 274; Width=381, Height=208
        *-- RecordSource definido em ConfigurarGridDados() apos cursor existir
        loc_oPg2.AddObject("grd_4c_Dados", "Grid")
        loc_oPg2.grd_4c_Dados.ColumnCount = 4

        WITH loc_oPg2.grd_4c_Dados
            .Top                       = 277
            .Left                      = 203
            .Width                     = 381
            .Height                    = 208
            .FontName                  = "Verdana"
            .FontSize                  = 8
            .ForeColor                 = RGB(0, 0, 0)
            .BackColor                 = RGB(255, 255, 255)
            .GridLineColor             = RGB(238, 238, 238)
            .HighlightBackColor        = RGB(255, 255, 255)
            .HighlightForeColor        = RGB(15, 41, 104)
            .HighlightStyle            = 2
            .AllowHeaderSizing         = .F.
            .AllowRowSizing            = .F.
            .DeleteMark                = .F.
            .RecordMark                = .T.
            .RowHeight                 = 17
            .ScrollBars                = 2
            .ReadOnly                  = .T.
            .Visible                   = .T.
            .Column1.Width             = 80
            .Column2.Width             = 108
            .Column3.Width             = 96
            .Column4.Width             = 97
            .Column1.ReadOnly          = .T.
            .Column2.ReadOnly          = .T.
            .Column3.ReadOnly          = .T.
            .Column4.ReadOnly          = .T.
            .Column1.Movable           = .F.
            .Column2.Movable           = .F.
            .Column3.Movable           = .F.
            .Column4.Movable           = .F.
            .Column3.InputMask         = "999,999.999"
            .Column4.InputMask         = "999,999.999"
            .Column1.Header1.Caption   = "O.P."
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(36, 84, 155)
            .Column2.Header1.Caption   = "Produto"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(36, 84, 155)
            .Column3.Header1.Caption   = "Qtde Tubo"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(36, 84, 155)
            .Column4.Header1.Caption   = "Qtde Canc."
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- ApagaItem: Left=587, Top=329 ? +29 = 358; 40x40
        loc_oPg2.AddObject("cmd_4c_ApagaItem", "CommandButton")
        WITH loc_oPg2.cmd_4c_ApagaItem
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 0
            .Top             = 307
            .Left            = 587
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 7
            .FontBold        = .F.
            .WordWrap        = .T.
            .ToolTipText     = "Apaga Item"
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(6, 84, 155)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- Label Observacao: Left=178, Top=467 ? +29 = 496
        loc_oPg2.AddObject("lbl_4c_Observacao", "Label")
        WITH loc_oPg2.lbl_4c_Observacao
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Top       = 498
            .Left      = 178
            .Width     = 120
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_Obs (EditBox): Left=178, Top=483 ? +29 = 512; Width=423, Height=56
        loc_oPg2.AddObject("obj_4c_Obs", "EditBox")
        WITH loc_oPg2.obj_4c_Obs
            .Value       = ""
            .Top         = 514
            .Left        = 178
            .Width       = 423
            .Height      = 56
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .ScrollBars  = 2
            .Visible     = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Nop,      "KeyPress", THIS, "ValidarNop")
        BINDEVENT(loc_oPg2.txt_4c_QtTb,     "KeyPress", THIS, "ConfirmarQtd")
        BINDEVENT(loc_oPg2.cmd_4c_ApagaItem, "Click",   THIS, "ApagaItemClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca cancelamentos e carrega grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (codigos N(6,0), datas D, usuars C(10), obss C(254))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount = 4
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.usuars"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.obss"

                        loc_oGrid.Column1.Width = 70
                        loc_oGrid.Column2.Width = 140
                        loc_oGrid.Column3.Width = 120
                        loc_oGrid.Column4.Width = 490

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.
                        loc_oGrid.Column3.ReadOnly = .T.
                        loc_oGrid.Column4.ReadOnly = .T.

                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
                        loc_oGrid.Column2.Header1.Caption = "Datas"
                        loc_oGrid.Column3.Header1.Caption = "usuars"
                        loc_oGrid.Column4.Header1.Caption = "Observa" + CHR(231) + CHR(245) + "es"

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridDados - Liga grd_4c_Dados ao cursor_4c_OpsCanc
    * Chamado sempre que o cursor for criado/recriado (Incluir, Alterar, Visualizar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridDados()
        LOCAL loc_oGrid, loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOps

        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Dados", 5) AND USED(loc_cCursor)
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                loc_oGrid.RecordSource          = loc_cCursor
                loc_oGrid.Column1.ControlSource = loc_cCursor + ".Nops"
                loc_oGrid.Column2.ControlSource = loc_cCursor + ".Cpros"
                loc_oGrid.Column3.ControlSource = loc_cCursor + ".Qtdos"
                loc_oGrid.Column4.ControlSource = loc_cCursor + ".Qtds"
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.ConfigurarGridDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Lista (1) e Dados (2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para inclusao de novo cancelamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_oBusinessObject.InicializarCursorOps()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.ConfigurarGridDados()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre cancelamento selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigos, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigos = cursor_4c_Dados.codigos

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
                THIS.this_oBusinessObject.CarregarItens(loc_nCodigos)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.ConfigurarGridDados()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre cancelamento selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigos, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigos = cursor_4c_Dados.codigos

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_oBusinessObject.CarregarItens(loc_nCodigos)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.ConfigurarGridDados()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui cancelamento selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigos, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigos = cursor_4c_Dados.codigos

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do cancelamento " + ;
                        TRANSFORM(loc_nCodigos) + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Cancelamento exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Vai para Page2 no modo Buscar (localizar por codigo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.BtnBuscarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva cancelamento (ou localiza em modo BUSCAR)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oPg2, loc_nCodBusca, loc_lResultado, loc_cCursor, loc_lTemItens
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Modo BUSCAR: localiza pelo codigo e volta para lista
        IF THIS.this_cModoAtual = "BUSCAR"
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
                loc_nCodBusca = VAL(TRANSFORM(loc_oPg2.txt_4c_Codigos.Value))
            ELSE
                loc_nCodBusca = 0
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            IF USED("cursor_4c_Dados") AND loc_nCodBusca > 0
                SELECT cursor_4c_Dados
                LOCATE FOR cursor_4c_Dados.codigos = loc_nCodBusca
            ENDIF
            RETURN .T.
        ENDIF

        *-- Em INCLUIR/ALTERAR: exige ao menos um item com Qtds > 0
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_cCursor   = THIS.this_oBusinessObject.this_cCursorOps
            loc_lTemItens = .F.
            IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                DO WHILE !EOF(loc_cCursor)
                    SELECT (loc_cCursor)
                    IF Qtds > 0
                        loc_lTemItens = .T.
                        EXIT
                    ENDIF
                    SKIP IN (loc_cCursor)
                ENDDO
            ENDIF
            IF !loc_lTemItens
                MsgAviso("Adicione ao menos um item com quantidade cancelada.", "Validar")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Cancelamento salvo com sucesso!")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias canonico para BtnConfirmarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e volta para lista sem salvar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNop - Valida OP digitada e adiciona ao cursor de OPs
    * Ativado por BINDEVENT KeyPress em txt_4c_Nop (Enter=13, Tab=9, F4=115)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNop(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        LOCAL loc_nNop, loc_cCursor, loc_oPg2
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_nNop    = INT(loc_oPg2.txt_4c_Nop.Value)
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOps

        IF loc_nNop <= 0
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.ValidarOP(loc_nNop)
                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    LOCATE FOR Nops = loc_nNop
                    IF FOUND()
                        MsgAviso("OP j" + CHR(225) + " adicionada na lista!", "")
                    ELSE
                        APPEND BLANK
                        REPLACE Nops    WITH loc_nNop
                        REPLACE Cpros   WITH THIS.this_oBusinessObject.this_cUltimaOpCpros
                        REPLACE Qtds    WITH 0
                        REPLACE Qtdos   WITH THIS.this_oBusinessObject.this_nUltimaOpQtdTubos
                        REPLACE nFunds  WITH THIS.this_oBusinessObject.this_nUltimaOpNFunds
                        REPLACE DtFunds WITH THIS.this_oBusinessObject.this_dUltimaOpDtFunds

                        IF PEMSTATUS(loc_oPg2, "txt_4c_Qtd", 5)
                            loc_oPg2.txt_4c_Qtd.Value   = THIS.this_oBusinessObject.this_nUltimaOpQtdTubos
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Pecas", 5)
                            loc_oPg2.txt_4c_Pecas.Value = THIS.this_oBusinessObject.this_nUltimaOpQtdPecas
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
                            loc_oPg2.grd_4c_Dados.Refresh()
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_QtTb", 5)
                            loc_oPg2.txt_4c_QtTb.SetFocus()
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                loc_oPg2.txt_4c_Nop.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.ValidarNop")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarQtd - Registra quantidade cancelada para OP na linha do cursor
    * Ativado por BINDEVENT KeyPress em txt_4c_QtTb (Enter=13, Tab=9, F4=115)
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarQtd(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        LOCAL loc_nQtd, loc_nNop, loc_cCursor, loc_oPg2, loc_nQtdos
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_nQtd    = loc_oPg2.txt_4c_QtTb.Value
        loc_nNop    = INT(loc_oPg2.txt_4c_Nop.Value)
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOps

        IF loc_nQtd <= 0
            RETURN
        ENDIF

        TRY
            IF USED(loc_cCursor) AND loc_nNop > 0
                SELECT (loc_cCursor)
                LOCATE FOR Nops = loc_nNop
                IF FOUND()
                    loc_nQtdos = Qtdos
                    IF loc_nQtd > loc_nQtdos
                        MsgAviso("Quantidade n" + CHR(227) + "o dispon" + CHR(237) + "vel!!!", "")
                        IF PEMSTATUS(loc_oPg2, "txt_4c_QtTb", 5)
                            loc_oPg2.txt_4c_QtTb.SetFocus()
                        ENDIF
                    ELSE
                        REPLACE Qtds WITH loc_nQtd

                        loc_oPg2.txt_4c_QtTb.Value  = 0
                        loc_oPg2.txt_4c_Nop.Value   = 0
                        loc_oPg2.txt_4c_Qtd.Value   = 0
                        loc_oPg2.txt_4c_Pecas.Value = 0

                        IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
                            loc_oPg2.grd_4c_Dados.Refresh()
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Nop", 5)
                            loc_oPg2.txt_4c_Nop.SetFocus()
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("OP n" + CHR(227) + "o encontrada na lista. Digite primeiro a OP.", "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.ConfirmarQtd")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ApagaItemClick - Remove item selecionado no grid do cursor de OPs
    * Ativado por BINDEVENT Click em cmd_4c_ApagaItem
    *--------------------------------------------------------------------------
    PROCEDURE ApagaItemClick()
        LOCAL loc_cCursor, loc_oPg2
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOps
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2

        TRY
            IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                SELECT (loc_cCursor)
                IF !EOF()
                    DELETE
                    PACK
                    IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
                        loc_oPg2.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.ApagaItemClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere observacao do form para o BO
    * OPs ja estao no cursor_4c_OpsCanc que o BO acessa diretamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "obj_4c_Obs", 5)
                THIS.this_oBusinessObject.this_cObss = ALLTRIM(loc_oPg2.obj_4c_Obs.Value)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Preenche campos do form com dados do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
                loc_oPg2.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_nCodigos
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Datas", 5)
                loc_oPg2.txt_4c_Datas.Value = THIS.this_oBusinessObject.this_dDatas
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Usuarios", 5)
                loc_oPg2.txt_4c_Usuarios.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Obs", 5)
                loc_oPg2.obj_4c_Obs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cObss)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
                loc_oPg2.txt_4c_Codigos.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Datas", 5)
                loc_oPg2.txt_4c_Datas.Value = DATE()
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Usuarios", 5)
                loc_oPg2.txt_4c_Usuarios.Value = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nop", 5)
                loc_oPg2.txt_4c_Nop.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_QtTb", 5)
                loc_oPg2.txt_4c_QtTb.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Qtd", 5)
                loc_oPg2.txt_4c_Qtd.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pecas", 5)
                loc_oPg2.txt_4c_Pecas.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Obs", 5)
                loc_oPg2.obj_4c_Obs.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos conforme o modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEditMode
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_lEditMode = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            *-- Codigos: editavel apenas em BUSCAR
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
                loc_oPg2.txt_4c_Codigos.Enabled  = (THIS.this_cModoAtual = "BUSCAR")
                loc_oPg2.txt_4c_Codigos.ReadOnly = !(THIS.this_cModoAtual = "BUSCAR")
            ENDIF
            *-- Nop e QtTb: apenas em INCLUIR/ALTERAR
            IF PEMSTATUS(loc_oPg2, "txt_4c_Nop", 5)
                loc_oPg2.txt_4c_Nop.Enabled  = loc_lEditMode
                loc_oPg2.txt_4c_Nop.ReadOnly = !loc_lEditMode
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_QtTb", 5)
                loc_oPg2.txt_4c_QtTb.Enabled  = loc_lEditMode
                loc_oPg2.txt_4c_QtTb.ReadOnly = !loc_lEditMode
            ENDIF
            *-- Botao apagar item: apenas em INCLUIR/ALTERAR
            IF PEMSTATUS(loc_oPg2, "cmd_4c_ApagaItem", 5)
                loc_oPg2.cmd_4c_ApagaItem.Enabled = loc_lEditMode
            ENDIF
            *-- Observacao: editavel em INCLUIR/ALTERAR
            IF PEMSTATUS(loc_oPg2, "obj_4c_Obs", 5)
                loc_oPg2.obj_4c_Obs.Enabled  = loc_lEditMode
                loc_oPg2.obj_4c_Obs.ReadOnly = !loc_lEditMode
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes de acao da Page2
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
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
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos e fecha cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_cCursor
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorOps
                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCAF.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
