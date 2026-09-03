*==============================================================================
* Formprc.prg - Cadastro de Movimenta" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia
* Herda de  : FormBase
* Entidade  : prc
* Tabela    : SigPcOoP (PK: codigos numeric(6,0))
* Filhas    : SigPcOoI, SigPcOog
* Task      : task501
*==============================================================================

DEFINE CLASS Formprc AS FormBase

    *-- Propriedades visuais
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Movimenta" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Estado interno
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_nPkAtual        = 0
    this_cProcessoAtual  = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro em Formprc.Init:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado, loc_oCab
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Cadastro de Movimenta" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia"

            THIS.this_oBusinessObject = CREATEOBJECT("prcBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar prcBO!" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                *-- Cria cursores de trabalho ANTES das paginas (grids dependem deles)
                IF USED("csDestinos")
                    USE IN csDestinos
                ENDIF
                CREATE CURSOR csDestinos (Processos c(20), Codigos n(6,0), Drives c(20), Emps c(3), ;
                                           Dopes c(20), EmpDs c(3), DopeDs c(20), TpProdutos n(2,0), ;
                                           Dias n(3,0), GruconOs n(1,0), GruconDs n(1,0), EmpDests n(1,0), ;
                                           Agrupar L, NovoCods L, CorTams L, MoeVals L, ;
                                           Situas n(1,0), Franquias n(1,0), PctMins n(12,2), PctMaxs n(12,2), ;
                                           Custos n(1,0), Impostos n(1,0), Imagem n(1,0), MantProds n(1,0), ;
                                           Barras n(1,0), Mccrs n(1,0), Cheques n(1,0), Delets n(1,0), ;
                                           DesItens n(1,0), MontaObs n(1,0), ChkCons n(1,0), MantemMats n(1,0), ;
                                           MantDPros n(1,0), GdeGrupos c(3), CUnis c(3), OriCompos n(1,0), ;
                                           Origems c(10), Destinos c(10), SemItens n(1,0), Fiscais n(1,0), ;
                                           Recalculos n(1,0), PctCopias n(8,2), OpItens c(1), cIdChaves c(20), ;
                                           MovMZeros n(1,0), MovcParc n(1,0), pctcomps n(8,2), Globalizas n(1,0))

                IF USED("csDestinoG")
                    USE IN csDestinoG
                ENDIF
                CREATE CURSOR csDestinoG (Processos c(20), Mercs c(3), CUnis c(3), fkChaves c(20), Cgrus c(3))

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()


                *-- Propaga caption para labels de titulo
                loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                IF VARTYPE(loc_oCab) = "O"
                    IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
                        loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
                    ENDIF
                    IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
                        loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
                    ENDIF
                ENDIF

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formprc.InicializarForm:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho + botoes + grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
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

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
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
        ENDWITH

        *-- Container botoes CRUD
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 80
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

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 155
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

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 230
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

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 305
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
        ENDWITH

        *-- Container Saida canonico (CLAUDE.md regra #10)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de listagem (3 colunas: processos, emps, codigos)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 3
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 150
            .Left               = 12
            .Width              = 932
            .Height             = 470
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Width      = 200
            .Column1.ReadOnly   = .T.
            .Column1.Header1.Caption = "Processos"
            .Column2.Width      = 60
            .Column2.ReadOnly   = .T.
            .Column2.Header1.Caption = "Emp"
            .Column3.Width      = 80
            .Column3.ReadOnly   = .T.
            .Column3.Header1.Caption = "C" + CHR(243) + "digos"
        ENDWITH

        *-- BINDEVENTs
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos cabecalho + grdDestinos + opcoes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 38
            .Left        = 819
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
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
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 85
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
        ENDWITH

        *-- Shape2: box ao redor dos campos de cabecalho
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top           = 36
            .Left          = 187
            .Width         = 613
            .Height        = 110
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        *-- Campos cabecalho - Processo
        loc_oPagina.AddObject("lbl_4c_Processo", "Label")
        WITH loc_oPagina.lbl_4c_Processo
            .Caption   = "Processo :"
            .Top       = 40
            .Left      = 192
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Processos", "TextBox")
        WITH loc_oPagina.txt_4c_Processos
            .Value         = ""
            .Top           = 51
            .Left          = 192
            .Width         = 150
            .Height        = 21
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Codigo (ReadOnly)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 40
            .Left      = 344
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = 0
            .Top           = 51
            .Left          = 343
            .Width         = 52
            .Height        = 21
            .InputMask     = "999999"
            .ReadOnly      = .T.
            .Enabled       = .F.
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Impressora
        loc_oPagina.AddObject("lbl_4c_Imprimir", "Label")
        WITH loc_oPagina.lbl_4c_Imprimir
            .Caption   = "Impressora :"
            .Top       = 77
            .Left      = 361
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptImprimir", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptImprimir
            .Top          = 88
            .Left         = 361
            .Width        = 89
            .Height       = 23
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 2
            .Visible      = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 40
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 43
            .Buttons(2).Left      = 40
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        *-- Ordenar por
        loc_oPagina.AddObject("lbl_4c_Ordenar", "Label")
        WITH loc_oPagina.lbl_4c_Ordenar
            .Caption   = "Ordenar por :"
            .Top       = 77
            .Left      = 490
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptOrdems", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptOrdems
            .Top          = 88
            .Left         = 490
            .Width        = 70
            .Height       = 23
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.
            .Buttons(1).Caption   = "Op"
            .Buttons(1).Width     = 30
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Dest"
            .Buttons(2).Width     = 38
            .Buttons(2).Left      = 30
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        *-- Dados Fiscais
        loc_oPagina.AddObject("lbl_4c_Fiscal", "Label")
        WITH loc_oPagina.lbl_4c_Fiscal
            .Caption   = "Dados Fiscais :"
            .Top       = 112
            .Left      = 192
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptFiscal", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptFiscal
            .Top          = 123
            .Left         = 192
            .Width        = 81
            .Height       = 23
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 2
            .Visible      = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        *-- Arquivos de Log
        loc_oPagina.AddObject("lbl_4c_Logs", "Label")
        WITH loc_oPagina.lbl_4c_Logs
            .Caption   = "Arquivos de Log :"
            .Top       = 112
            .Left      = 368
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptLogs", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptLogs
            .Top          = 123
            .Left         = 365
            .Width        = 90
            .Height       = 23
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 2
            .Visible      = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 40
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 44
            .Buttons(2).Left      = 40
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        *-- Apagar Dados Origem
        loc_oPagina.AddObject("lbl_4c_Apagar", "Label")
        WITH loc_oPagina.lbl_4c_Apagar
            .Caption   = "Apagar Dados Origem :"
            .Top       = 112
            .Left      = 490
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptApagar", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptApagar
            .Top          = 122
            .Left         = 490
            .Width        = 249
            .Height       = 23
            .ButtonCount  = 4
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.
            .Buttons(1).Caption   = "Ambos"
            .Buttons(1).Width     = 50
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "S" + CHR(243) + " Dados"
            .Buttons(2).Width     = 62
            .Buttons(2).Left      = 50
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "S" + CHR(243) + " Fiscais"
            .Buttons(3).Width     = 65
            .Buttons(3).Left      = 112
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes    = .F.
            .Buttons(4).Caption   = "Nenhum"
            .Buttons(4).Width     = 58
            .Buttons(4).Left      = 177
            .Buttons(4).Top       = 0
            .Buttons(4).AutoSize  = .F.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Themes    = .F.
        ENDWITH

        *-- Container botoes insercao/exclusao de linhas (cmdgCompo)
        loc_oPagina.AddObject("cnt_4c_CompoOp", "Container")
        WITH loc_oPagina.cnt_4c_CompoOp
            .Top         = 36
            .Left        = 7
            .Width       = 173
            .Height      = 110
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_CompoInserir", "CommandButton")
            WITH .cmd_4c_CompoInserir
                .Caption         = "Inserir Linha"
                .Top             = 10
                .Left            = 5
                .Width           = 160
                .Height          = 40
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_CompoExcluir", "CommandButton")
            WITH .cmd_4c_CompoExcluir
                .Caption         = "Excluir Linha"
                .Top             = 60
                .Left            = 5
                .Width           = 160
                .Height          = 40
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Shape1: box ao redor do grdDestinos
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top           = 155
            .Left          = 8
            .Width         = 791
            .Height        = 263
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        *-- Grid grdDestinos (18 colunas - csDestinos)
        loc_oPagina.AddObject("grd_4c_Destinos", "Grid")
        loc_oPagina.grd_4c_Destinos.ColumnCount = 18
        loc_oPagina.grd_4c_Destinos.RecordSource = "csDestinos"
        WITH loc_oPagina.grd_4c_Destinos
            .Top                = 162
            .Left               = 15
            .Width              = 779
            .Height             = 189
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 3
            .GridLines          = 3
            .ReadOnly           = .F.
            .Visible            = .T.

            *-- Col1: EmpDs
            .Column1.Width          = 40
            .Column1.ControlSource  = "csDestinos.EmpDs"
            .Column1.Header1.Caption = "Emp"

            *-- Col2: Drives
            .Column2.Width          = 80
            .Column2.ControlSource  = "csDestinos.Drives"
            .Column2.Header1.Caption = "Local"

            *-- Col3: DopeDs
            .Column3.Width          = 80
            .Column3.ControlSource  = "csDestinos.DopeDs"
            .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o no Destino"

            *-- Col4: TpProdutos
            .Column4.Width          = 45
            .Column4.ControlSource  = "csDestinos.TpProdutos"
            .Column4.Alignment      = 2
            .Column4.Header1.Caption = "Produto"

            *-- Col5: Dias
            .Column5.Width          = 35
            .Column5.ControlSource  = "csDestinos.Dias"
            .Column5.Alignment      = 2
            .Column5.Header1.Caption = "Dias"

            *-- Col6: PctMins
            .Column6.Width          = 75
            .Column6.ControlSource  = "csDestinos.PctMins"
            .Column6.Alignment      = 2
            .Column6.Header1.Caption = "Margem M" + CHR(237) + "n."

            *-- Col7: PctMaxs
            .Column7.Width          = 75
            .Column7.ControlSource  = "csDestinos.PctMaxs"
            .Column7.Alignment      = 2
            .Column7.Header1.Caption = "Margem M" + CHR(225) + "x."

            *-- Col8: GdeGrupos
            .Column8.Width          = 40
            .Column8.ControlSource  = "csDestinos.GdeGrupos"
            .Column8.Header1.Caption = "GGpr"

            *-- Col9: Emps (origem)
            .Column9.Width          = 35
            .Column9.ControlSource  = "csDestinos.Emps"
            .Column9.Header1.Caption = "Emp"

            *-- Col10: Dopes (operacao origem)
            .Column10.Width          = 75
            .Column10.ControlSource  = "csDestinos.Dopes"
            .Column10.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o na Origem"

            *-- Col11: CUnis
            .Column11.Width          = 35
            .Column11.ControlSource  = "csDestinos.CUnis"
            .Column11.Header1.Caption = "Uni"

            *-- Col12: Origems
            .Column12.Width          = 70
            .Column12.ControlSource  = "csDestinos.Origems"
            .Column12.Header1.Caption = "Cta.Origem"

            *-- Col13: Destinos
            .Column13.Width          = 70
            .Column13.ControlSource  = "csDestinos.Destinos"
            .Column13.Header1.Caption = "Cta.Destino"

            *-- Col14: SemItens (CheckBox)
            .Column14.Width          = 55
            .Column14.ControlSource  = "csDestinos.SemItens"
            .Column14.Sparse         = .F.
            .Column14.Header1.Caption = "Sem " + CHR(205) + "tens"
            .Column14.AddObject("Check1", "CheckBox")
            WITH .Column14.Check1
                .Alignment  = 0
                .ReadOnly   = .F.
                .Visible    = .T.
                .Top        = 9
                .Left       = 2
                .Height     = 17
                .Width      = 22
            ENDWITH

            *-- Col15: Fiscais (CheckBox)
            .Column15.Width          = 45
            .Column15.ControlSource  = "csDestinos.Fiscais"
            .Column15.Sparse         = .F.
            .Column15.Header1.Caption = "Fiscal"
            .Column15.AddObject("Check1", "CheckBox")
            WITH .Column15.Check1
                .Alignment  = 0
                .ReadOnly   = .F.
                .Visible    = .T.
                .Top        = 9
                .Left       = 2
                .Height     = 17
                .Width      = 22
            ENDWITH

            *-- Col16: PctCopias
            .Column16.Width          = 70
            .Column16.ControlSource  = "csDestinos.PctCopias"
            .Column16.Alignment      = 2
            .Column16.Header1.Caption = "% Produto / $"

            *-- Col17: OpItens
            .Column17.Width          = 50
            .Column17.ControlSource  = "csDestinos.OpItens"
            .Column17.Header1.Caption = "Op Itens"

            *-- Col18: pctcomps
            .Column18.Width          = 60
            .Column18.ControlSource  = "csDestinos.pctcomps"
            .Column18.Alignment      = 2
            .Column18.Header1.Caption = "% Compos."
        ENDWITH

        *-- Botao copiar linha atual do grdDestinos
        loc_oPagina.AddObject("cmd_4c_CopOpe", "CommandButton")
        WITH loc_oPagina.cmd_4c_CopOpe
            .Caption       = "Copiar"
            .Top           = 325
            .Left          = 738
            .Width         = 55
            .Height        = 59
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH

        *-- Labels linha GruConOs / GruConDs
        loc_oPagina.AddObject("chk_4c_ChkHelp", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkHelp
            .Caption     = ""
            .Top         = 358
            .Left        = 24
            .Width       = 26
            .Height      = 26
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Origem", "Label")
        WITH loc_oPagina.lbl_4c_Origem
            .Caption   = "Origem :"
            .Top       = 356
            .Left      = 62
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptGruConOs", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptGruConOs
            .Top          = 357
            .Left         = 105
            .Width        = 567
            .Height       = 15
            .ButtonCount  = 5
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.
            .Buttons(1).Caption   = "Produtos"
            .Buttons(1).Width     = 65
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Serv." + CHR(47) + "Prod."
            .Buttons(2).Width     = 75
            .Buttons(2).Left      = 65
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "Servi" + CHR(231) + "os"
            .Buttons(3).Width     = 65
            .Buttons(3).Left      = 140
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes    = .F.
            .Buttons(4).Caption   = "S/N.Fiscal"
            .Buttons(4).Width     = 75
            .Buttons(4).Left      = 205
            .Buttons(4).Top       = 0
            .Buttons(4).AutoSize  = .F.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Themes    = .F.
            .Buttons(5).Caption   = "Todos"
            .Buttons(5).Width     = 55
            .Buttons(5).Left      = 280
            .Buttons(5).Top       = 0
            .Buttons(5).AutoSize  = .F.
            .Buttons(5).ForeColor = RGB(90, 90, 90)
            .Buttons(5).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Destino", "Label")
        WITH loc_oPagina.lbl_4c_Destino
            .Caption   = "Destino :"
            .Top       = 375
            .Left      = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptGruConDs", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptGruConDs
            .Top          = 374
            .Left         = 106
            .Width        = 519
            .Height       = 18
            .ButtonCount  = 4
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.
            .Buttons(1).Caption   = "Produtos"
            .Buttons(1).Width     = 65
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Serv." + CHR(47) + "Prod."
            .Buttons(2).Width     = 75
            .Buttons(2).Left      = 65
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "Servi" + CHR(231) + "os"
            .Buttons(3).Width     = 65
            .Buttons(3).Left      = 140
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes    = .F.
            .Buttons(4).Caption   = "Todos"
            .Buttons(4).Width     = 55
            .Buttons(4).Left      = 205
            .Buttons(4).Top       = 0
            .Buttons(4).AutoSize  = .F.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Themes    = .F.
        ENDWITH

        *-- ======= SHAPES DELIMITADORES DAS SECOES DE OPCOES =======
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top = 427
            .Left = 8
            .Width = 323
            .Height = 126
            .BackStyle = 0
            .SpecialEffect = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPagina.shp_4c_Shape4
            .Top = 427
            .Left = 340
            .Width = 252
            .Height = 127
            .BackStyle = 0
            .SpecialEffect = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oPagina.shp_4c_Shape5
            .Top = 427
            .Left = 600
            .Width = 252
            .Height = 82
            .BackStyle = 0
            .SpecialEffect = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPagina.shp_4c_Shape6
            .Top = 513
            .Left = 600
            .Width = 358
            .Height = 71
            .BackStyle = 0
            .SpecialEffect = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible = .T.
        ENDWITH

        *-- ======= SECAO ESQUERDA (Shape3) - opcoes do item =======

        loc_oPagina.AddObject("lbl_4c_Agrupar", "Label")
        WITH loc_oPagina.lbl_4c_Agrupar
            .Caption = "Agrupar Itens :"
            .Top = 428
            .Left = 8
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptAgrupar", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptAgrupar
            .Top = 427
            .Left = 121
            .Width = 163
            .Height = 19
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 40
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 40
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "Divis" + CHR(227) + "o"
            .Buttons(3).Width     = 70
            .Buttons(3).Left      = 80
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Custos", "Label")
        WITH loc_oPagina.lbl_4c_Custos
            .Caption = "Calcular Custos :"
            .Top = 446
            .Left = 12
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptCustos", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptCustos
            .Top = 414
            .Left = 121
            .Width = 80
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Impostos", "Label")
        WITH loc_oPagina.lbl_4c_Impostos
            .Caption = "Calcula Impostos :"
            .Top = 462
            .Left = 12
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptImpostos", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptImpostos
            .Top = 429
            .Left = 121
            .Width = 80
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Imagem", "Label")
        WITH loc_oPagina.lbl_4c_Imagem
            .Caption = "Copia Imagem :"
            .Top = 476
            .Left = 12
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptImagem", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptImagem
            .Top = 474
            .Left = 121
            .Width = 122
            .Height = 19
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_OriCompos", "Label")
        WITH loc_oPagina.lbl_4c_OriCompos
            .Caption = "Componentes Origem :"
            .Top = 491
            .Left = 12
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptOriCompos", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptOriCompos
            .Top = 489
            .Left = 121
            .Width = 121
            .Height = 19
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
            .Buttons(1).Caption   = "Origem"
            .Buttons(1).Width     = 55
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Destino"
            .Buttons(2).Width     = 60
            .Buttons(2).Left      = 55
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_NovoCod", "Label")
        WITH loc_oPagina.lbl_4c_NovoCod
            .Caption = "Novo C" + CHR(243) + "digo :"
            .Top = 506
            .Left = 12
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptNovoCodigo", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptNovoCodigo
            .Top = 504
            .Left = 121
            .Width = 121
            .Height = 19
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_CorTamanho", "Label")
        WITH loc_oPagina.lbl_4c_CorTamanho
            .Caption = "Copia Cor/Tam :"
            .Top = 524
            .Left = 12
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptCorTamanho", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptCorTamanho
            .Top = 520
            .Left = 121
            .Width = 121
            .Height = 19
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_MoeTrat", "Label")
        WITH loc_oPagina.lbl_4c_MoeTrat
            .Caption = "Tratamento Moedas :"
            .Top = 539
            .Left = 12
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMoevals", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMoevals
            .Top = 532
            .Left = 121
            .Width = 193
            .Height = 24
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Divis" + CHR(227) + "o"
            .Buttons(2).Width     = 60
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "N" + CHR(227) + "o"
            .Buttons(3).Width     = 40
            .Buttons(3).Left      = 95
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes    = .F.
        ENDWITH

        *-- ======= SECAO MEIO (Shape4) - Empresa destino + outros =======

        loc_oPagina.AddObject("lbl_4c_EmpDests", "Label")
        WITH loc_oPagina.lbl_4c_EmpDests
            .Caption = "Empresa Destino :"
            .Top = 428
            .Left = 352
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptEmpDests", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptEmpDests
            .Top = 364
            .Left = 102
            .Width = 130
            .Height = 19
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
            .Buttons(1).Caption   = "Igual"
            .Buttons(1).Width     = 42
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Drive"
            .Buttons(2).Width     = 42
            .Buttons(2).Left      = 42
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "Config."
            .Buttons(3).Width     = 46
            .Buttons(3).Left      = 84
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Franquia", "Label")
        WITH loc_oPagina.lbl_4c_Franquia
            .Caption = "Franquias :"
            .Top = 429
            .Left = 350
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptFranquia", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptFranquia
            .Top = 427
            .Left = 494
            .Width = 86
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_MontaObs", "Label")
        WITH loc_oPagina.lbl_4c_MontaObs
            .Caption = "Nota+Data na Obs do" + CHR(205) + "tem :"
            .Top = 476
            .Left = 350
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMontaObs", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMontaObs
            .Top = 475
            .Left = 494
            .Width = 87
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Barras", "Label")
        WITH loc_oPagina.lbl_4c_Barras
            .Caption = "C" + CHR(243) + "d.Barras :"
            .Top = 492
            .Left = 352
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptBarras", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptBarras
            .Top = 491
            .Left = 656
            .Width = 80
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_DesItens", "Label")
        WITH loc_oPagina.lbl_4c_DesItens
            .Caption = "Descri" + CHR(231) + CHR(227) + "o do" + CHR(205) + "tem :"
            .Top = 509
            .Left = 350
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptDesItens", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptDesItens
            .Top = 431
            .Left = 494
            .Width = 80
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Globaliza", "Label")
        WITH loc_oPagina.lbl_4c_Globaliza
            .Caption = "Globaliza :"
            .Top = 528
            .Left = 359
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptGlobaliza", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptGlobaliza
            .Top = 526
            .Left = 656
            .Width = 80
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_ChkCons", "Label")
        WITH loc_oPagina.lbl_4c_ChkCons
            .Caption = "Chk. Conserto :"
            .Top = 546
            .Left = 351
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptChkCons", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptChkCons
            .Top = 461
            .Left = 494
            .Width = 80
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        *-- ======= SECAO DIREITA AREA 1 (Shape5) =======

        loc_oPagina.AddObject("lbl_4c_Mccrs", "Label")
        WITH loc_oPagina.lbl_4c_Mccrs
            .Caption = "Copiar Mov.de Cc. :"
            .Top = 432
            .Left = 624
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMccrs", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMccrs
            .Top = 432
            .Left = 750
            .Width = 87
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Cheques", "Label")
        WITH loc_oPagina.lbl_4c_Cheques
            .Caption = "Copiar Mov.de Cheques :"
            .Top = 447
            .Left = 624
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptCheques", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptCheques
            .Top = 447
            .Left = 750
            .Width = 87
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Recalculos", "Label")
        WITH loc_oPagina.lbl_4c_Recalculos
            .Caption = "Recalcular Saldos/Custos :"
            .Top = 462
            .Left = 613
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptRecalculos", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptRecalculos
            .Top = 462
            .Left = 750
            .Width = 87
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_MantProds", "Label")
        WITH loc_oPagina.lbl_4c_MantProds
            .Caption = "Mantem Prods. Destino :"
            .Top = 477
            .Left = 617
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMantProds", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMantProds
            .Top = 476
            .Left = 750
            .Width = 87
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_MantemMats", "Label")
        WITH loc_oPagina.lbl_4c_MantemMats
            .Caption = "Mantem Mat. Prima :"
            .Top = 492
            .Left = 623
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMantemMats", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMantemMats
            .Top = 491
            .Left = 494
            .Width = 87
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_MantDPros", "Label")
        WITH loc_oPagina.lbl_4c_MantDPros
            .Caption = "Mantem Desc. Produto :"
            .Top = 507
            .Left = 615
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMantDPros", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMantDPros
            .Top = 462
            .Left = 750
            .Width = 87
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        *-- ======= SECAO DIREITA AREA 2 (Shape6) =======

        loc_oPagina.AddObject("lbl_4c_Situacao", "Label")
        WITH loc_oPagina.lbl_4c_Situacao
            .Caption = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top = 518
            .Left = 606
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptSituas", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptSituas
            .Top = 516
            .Left = 660
            .Width = 130
            .Height = 18
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
            .Buttons(1).Caption   = "Igual"
            .Buttons(1).Width     = 40
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Aberto"
            .Buttons(2).Width     = 50
            .Buttons(2).Left      = 40
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "Fech."
            .Buttons(3).Width     = 40
            .Buttons(3).Left      = 90
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Delets", "Label")
        WITH loc_oPagina.lbl_4c_Delets
            .Caption = "Deletar Mov. :"
            .Top = 536
            .Left = 615
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptDelets", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptDelets
            .Top = 416
            .Left = 494
            .Width = 110
            .Height = 18
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
            .Buttons(1).Caption   = "N" + CHR(227) + "o"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "Sim"
            .Buttons(2).Width     = 35
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
            .Buttons(3).Caption   = "Dest."
            .Buttons(3).Width     = 40
            .Buttons(3).Left      = 70
            .Buttons(3).Top       = 0
            .Buttons(3).AutoSize  = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_MovMZeros", "Label")
        WITH loc_oPagina.lbl_4c_MovMZeros
            .Caption = "Mv c/ Qt/Val > 0 :"
            .Top = 554
            .Left = 614
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMovMZeros", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMovMZeros
            .Top = 491
            .Left = 494
            .Width = 80
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_MovcParc", "Label")
        WITH loc_oPagina.lbl_4c_MovcParc
            .Caption = "Mv c/ Parcelas :"
            .Top = 569
            .Left = 616
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMovcParc", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMovcParc
            .Top = 506
            .Left = 494
            .Width = 80
            .Height = 18
            .ButtonCount = 2
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 2
            .Visible = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Width     = 35
            .Buttons(1).Left      = 0
            .Buttons(1).Top       = 0
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Width     = 40
            .Buttons(2).Left      = 35
            .Buttons(2).Top       = 0
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        *-- ======= TOLERANCIAS =======
        loc_oPagina.AddObject("lbl_4c_Tolerancia", "Label")
        WITH loc_oPagina.lbl_4c_Tolerancia
            .Caption = "Toler" + CHR(226) + "ncias (%) :"
            .Top     = 556
            .Left    = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Toleras", "TextBox")
        WITH loc_oPagina.txt_4c_Toleras
            .Value         = 0
            .Top           = 554
            .Left          = 90
            .Width         = 80
            .Height        = 21
            .InputMask     = "999999999.99"
            .Alignment     = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- ======= GRID grd_4c_DestinoG (grupos do item selecionado) =======
        loc_oPagina.AddObject("cnt_4c_CompoG", "Container")
        WITH loc_oPagina.cnt_4c_CompoG
            .Top         = 394
            .Left        = 800
            .Width       = 180
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_GrpInserir", "CommandButton")
            WITH .cmd_4c_GrpInserir
                .Caption         = "Inserir Grupo"
                .Top             = 5
                .Left            = 5
                .Width           = 165
                .Height          = 35
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_GrpExcluir", "CommandButton")
            WITH .cmd_4c_GrpExcluir
                .Caption         = "Excluir Grupo"
                .Top             = 45
                .Left            = 5
                .Width           = 165
                .Height          = 35
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Merc", "Label")
        WITH loc_oPagina.lbl_4c_Merc
            .Caption = "Merc"
            .Top = 393
            .Left = 800
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_CUni", "Label")
        WITH loc_oPagina.lbl_4c_CUni
            .Caption = "Uni"
            .Top = 393
            .Left = 850
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oPagina.AddObject("lbl_4c_CGru", "Label")
        WITH loc_oPagina.lbl_4c_CGru
            .Caption = "Grupo"
            .Top = 393
            .Left = 893
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("grd_4c_DestinoG", "Grid")
        loc_oPagina.grd_4c_DestinoG.ColumnCount = 3
        loc_oPagina.grd_4c_DestinoG.RecordSource = "csDestinoG"
        WITH loc_oPagina.grd_4c_DestinoG
            .Top                = 408
            .Left               = 800
            .Width              = 175
            .Height             = 160
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .F.
            .Visible            = .T.
            .Column1.Width         = 40
            .Column1.ControlSource = "csDestinoG.Mercs"
            .Column1.Header1.Caption = "G.Grp."
            .Column2.Width         = 40
            .Column2.ControlSource = "csDestinoG.CUnis"
            .Column2.Header1.Caption = "Uni"
            .Column3.Width         = 55
            .Column3.ControlSource = "csDestinoG.Cgrus"
            .Column3.Header1.Caption = "Grupo"
        ENDWITH

        *-- BINDEVENTs Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
        BINDEVENT(loc_oPagina.cnt_4c_CompoOp.cmd_4c_CompoInserir, "Click", THIS, "BtnCompoInserirClick")
        BINDEVENT(loc_oPagina.cnt_4c_CompoOp.cmd_4c_CompoExcluir, "Click", THIS, "BtnCompoExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_CompoG.cmd_4c_GrpInserir,    "Click", THIS, "BtnGrpInserirClick")
        BINDEVENT(loc_oPagina.cnt_4c_CompoG.cmd_4c_GrpExcluir,    "Click", THIS, "BtnGrpExcluirClick")
        BINDEVENT(loc_oPagina.grd_4c_Destinos, "AfterRowColChange", THIS, "GrdDestinosAfterRowColChange")
        BINDEVENT(loc_oPagina.grd_4c_Destinos, "KeyPress", THIS, "GrdDestinosKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Destinos, "DblClick", THIS, "GrdDestinosDblClick")
        BINDEVENT(loc_oPagina.grd_4c_DestinoG, "KeyPress", THIS, "GrdDestinoGKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_DestinoG, "DblClick", THIS, "GrdDestinoGDblClick")
        BINDEVENT(loc_oPagina.cmd_4c_CopOpe, "Click", THIS, "BtnCopOpeClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca registros e atualiza grid Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (processos c(20), emps c(3), codigos n(6,0))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 3
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.processos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column1.Header1.Caption = "Processos"
                        loc_oGrid.Column2.Header1.Caption = "Emp"
                        loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digos"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formprc.CarregarLista:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre pages e carrega itens se necessario
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ELSE
                *-- Carrega dados ao ir para Page2
                IF USED("csDestinos")
                    ZAP IN csDestinos
                ENDIF
                IF USED("csDestinoG")
                    ZAP IN csDestinoG
                ENDIF

                IF INLIST(THIS.this_cModoAtual, "VISUALIZAR", "ALTERAR", "EXCLUIR")
                    THIS.CarregarItens(THIS.this_cProcessoAtual)
                ELSE
                    IF THIS.this_cModoAtual = "INCLUIR"
                    *-- Linha padrao vazia para o modo inserir
                    SELECT csDestinos
                    APPEND BLANK
                    ENDIF
                ENDIF

                THIS.RefrescarOpcoesDoItem()
                THIS.AtualizarEstadoCampos()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em Formprc.AlternarPagina:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarItens - Popula csDestinos e csDestinoG a partir do banco
    *==========================================================================
    PROCEDURE CarregarItens(par_cProcessos)
        LOCAL loc_cSQL, loc_nResult, loc_cCidChaves
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_OoI")
                USE IN cursor_4c_OoI
            ENDIF

            loc_cSQL = "SELECT * FROM SigPcOoI WHERE processos = " + EscaparSQL(par_cProcessos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OoI")

            IF loc_nResult >= 0
                SELECT csDestinos
                ZAP
                SELECT cursor_4c_OoI
                SCAN
                    loc_cCidChaves = ALLTRIM(cursor_4c_OoI.cidchaves)
                    INSERT INTO csDestinos (Processos, Codigos, Drives, Emps, Dopes, EmpDs, DopeDs, ;
                                            TpProdutos, Dias, GruconOs, GruconDs, EmpDests, Agrupar, ;
                                            NovoCods, CorTams, MoeVals, Situas, Franquias, PctMins, PctMaxs, ;
                                            Custos, Impostos, Imagem, MantProds, Barras, Mccrs, Cheques, ;
                                            Delets, DesItens, MontaObs, ChkCons, MantemMats, MantDPros, ;
                                            GdeGrupos, CUnis, OriCompos, Origems, Destinos, SemItens, Fiscais, ;
                                            Recalculos, PctCopias, OpItens, cIdChaves, MovMZeros, MovcParc, ;
                                            pctcomps, Globalizas) ;
                           VALUES (TratarNulo(cursor_4c_OoI.processos,""), ;
                                   TratarNulo(cursor_4c_OoI.codigos,0), ;
                                   TratarNulo(cursor_4c_OoI.drives,""), ;
                                   TratarNulo(cursor_4c_OoI.emps,""), ;
                                   TratarNulo(cursor_4c_OoI.dopes,""), ;
                                   TratarNulo(cursor_4c_OoI.empds,""), ;
                                   TratarNulo(cursor_4c_OoI.dopeds,""), ;
                                   TratarNulo(cursor_4c_OoI.tpprodutos,0), ;
                                   TratarNulo(cursor_4c_OoI.dias,0), ;
                                   TratarNulo(cursor_4c_OoI.gruconos,0), ;
                                   TratarNulo(cursor_4c_OoI.gruconds,0), ;
                                   TratarNulo(cursor_4c_OoI.empdests,0), ;
                                   TratarNulo(cursor_4c_OoI.agrupar,0), ;
                                   TratarNulo(cursor_4c_OoI.novocods,0), ;
                                   TratarNulo(cursor_4c_OoI.cortams,0), ;
                                   TratarNulo(cursor_4c_OoI.moevals,0), ;
                                   TratarNulo(cursor_4c_OoI.situas,0), ;
                                   TratarNulo(cursor_4c_OoI.franquias,0), ;
                                   TratarNulo(cursor_4c_OoI.pctmins,0), ;
                                   TratarNulo(cursor_4c_OoI.pctmaxs,0), ;
                                   TratarNulo(cursor_4c_OoI.custos,0), ;
                                   TratarNulo(cursor_4c_OoI.impostos,0), ;
                                   TratarNulo(cursor_4c_OoI.imagem,0), ;
                                   TratarNulo(cursor_4c_OoI.mantprods,0), ;
                                   TratarNulo(cursor_4c_OoI.barras,0), ;
                                   TratarNulo(cursor_4c_OoI.mccrs,0), ;
                                   TratarNulo(cursor_4c_OoI.cheques,0), ;
                                   TratarNulo(cursor_4c_OoI.delets,0), ;
                                   TratarNulo(cursor_4c_OoI.desitens,0), ;
                                   TratarNulo(cursor_4c_OoI.montaobs,0), ;
                                   TratarNulo(cursor_4c_OoI.chkcons,0), ;
                                   TratarNulo(cursor_4c_OoI.mantemmats,0), ;
                                   TratarNulo(cursor_4c_OoI.mantdpros,0), ;
                                   TratarNulo(cursor_4c_OoI.gdegrupos,""), ;
                                   TratarNulo(cursor_4c_OoI.cunis,""), ;
                                   TratarNulo(cursor_4c_OoI.oricompos,0), ;
                                   TratarNulo(cursor_4c_OoI.origems,""), ;
                                   TratarNulo(cursor_4c_OoI.destinos,""), ;
                                   TratarNulo(cursor_4c_OoI.semitens,0), ;
                                   TratarNulo(cursor_4c_OoI.fiscais,0), ;
                                   TratarNulo(cursor_4c_OoI.recalculos,0), ;
                                   TratarNulo(cursor_4c_OoI.pctcopias,0), ;
                                   TratarNulo(cursor_4c_OoI.opitens,""), ;
                                   loc_cCidChaves, ;
                                   TratarNulo(cursor_4c_OoI.movmzeros,0), ;
                                   TratarNulo(cursor_4c_OoI.movcparc,0), ;
                                   TratarNulo(cursor_4c_OoI.pctcomps,0), ;
                                   TratarNulo(cursor_4c_OoI.globalizas,0))

                    *-- Grupos deste item
                    IF USED("cursor_4c_OoG")
                        USE IN cursor_4c_OoG
                    ENDIF
                    LOCAL loc_cSQLG, loc_nResG
                    loc_cSQLG = "SELECT * FROM SigPcOog WHERE fkchaves = " + EscaparSQL(loc_cCidChaves)
                    loc_nResG = SQLEXEC(gnConnHandle, loc_cSQLG, "cursor_4c_OoG")
                    IF loc_nResG >= 0
                        SELECT cursor_4c_OoG
                        SCAN
                            INSERT INTO csDestinoG (Processos, Mercs, CUnis, fkChaves, Cgrus) ;
                                VALUES (TratarNulo(cursor_4c_OoG.processos,""), ;
                                        TratarNulo(cursor_4c_OoG.mercs,""), ;
                                        TratarNulo(cursor_4c_OoG.cunis,""), ;
                                        loc_cCidChaves, ;
                                        TratarNulo(cursor_4c_OoG.cgrus,""))
                        ENDSCAN
                        IF USED("cursor_4c_OoG")
                            USE IN cursor_4c_OoG
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_OoI
                ENDSCAN

                IF USED("cursor_4c_OoI")
                    USE IN cursor_4c_OoI
                ENDIF

                SELECT csDestinos
                IF RECCOUNT("csDestinos") > 0
                    GO TOP IN csDestinos
                ENDIF

                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formprc.CarregarItens:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GrdDestinosAfterRowColChange - Atualiza opcoes ao mudar linha no grid
    *==========================================================================
    PROCEDURE GrdDestinosAfterRowColChange(par_nColIndex)
        THIS.RefrescarOpcoesDoItem()
    ENDPROC

    *==========================================================================
    * RefrescarOpcoesDoItem - Sincroniza OptionGroups com a linha atual csDestinos
    *==========================================================================
    PROCEDURE RefrescarOpcoesDoItem()
        LOCAL loc_oPg2, loc_nVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !USED("csDestinos") OR RECCOUNT("csDestinos") = 0 OR EOF("csDestinos")
            RETURN
        ENDIF

        TRY
            SELECT csDestinos

            IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConOs", 5)
                loc_nVal = csDestinos.GruconOs
                loc_oPg2.obj_4c_OptGruConOs.Value = IIF(loc_nVal > 0, loc_nVal, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConDs", 5)
                loc_nVal = csDestinos.GruconDs
                loc_oPg2.obj_4c_OptGruConDs.Value = IIF(loc_nVal > 0, loc_nVal, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptAgrupar", 5)
                loc_nVal = csDestinos.Agrupar
                loc_oPg2.obj_4c_OptAgrupar.Value = IIF(loc_nVal > 0, loc_nVal, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptFranquia", 5)
                loc_nVal = csDestinos.Franquias
                loc_oPg2.obj_4c_OptFranquia.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptCustos", 5)
                loc_nVal = csDestinos.Custos
                loc_oPg2.obj_4c_OptCustos.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptImpostos", 5)
                loc_nVal = csDestinos.Impostos
                loc_oPg2.obj_4c_OptImpostos.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptImagem", 5)
                loc_nVal = csDestinos.Imagem
                loc_oPg2.obj_4c_OptImagem.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptOriCompos", 5)
                loc_nVal = csDestinos.OriCompos
                loc_oPg2.obj_4c_OptOriCompos.Value = IIF(loc_nVal > 0, loc_nVal, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptNovoCodigo", 5)
                loc_nVal = csDestinos.NovoCods
                loc_oPg2.obj_4c_OptNovoCodigo.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptCorTamanho", 5)
                loc_nVal = csDestinos.CorTams
                loc_oPg2.obj_4c_OptCorTamanho.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMoevals", 5)
                loc_nVal = csDestinos.MoeVals
                loc_oPg2.obj_4c_OptMoevals.Value = IIF(loc_nVal > 0, loc_nVal, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptEmpDests", 5)
                loc_nVal = csDestinos.EmpDests
                loc_oPg2.obj_4c_OptEmpDests.Value = IIF(loc_nVal > 0, loc_nVal, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMontaObs", 5)
                loc_nVal = csDestinos.MontaObs
                loc_oPg2.obj_4c_OptMontaObs.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptBarras", 5)
                loc_nVal = csDestinos.Barras
                loc_oPg2.obj_4c_OptBarras.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptDesItens", 5)
                loc_nVal = csDestinos.DesItens
                loc_oPg2.obj_4c_OptDesItens.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptGlobaliza", 5)
                loc_nVal = csDestinos.Globalizas
                loc_oPg2.obj_4c_OptGlobaliza.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptChkCons", 5)
                loc_nVal = csDestinos.ChkCons
                loc_oPg2.obj_4c_OptChkCons.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMccrs", 5)
                loc_nVal = csDestinos.Mccrs
                loc_oPg2.obj_4c_OptMccrs.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptCheques", 5)
                loc_nVal = csDestinos.Cheques
                loc_oPg2.obj_4c_OptCheques.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptRecalculos", 5)
                loc_nVal = csDestinos.Recalculos
                loc_oPg2.obj_4c_OptRecalculos.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMantProds", 5)
                loc_nVal = csDestinos.MantProds
                loc_oPg2.obj_4c_OptMantProds.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMantemMats", 5)
                loc_nVal = csDestinos.MantemMats
                loc_oPg2.obj_4c_OptMantemMats.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMantDPros", 5)
                loc_nVal = csDestinos.MantDPros
                loc_oPg2.obj_4c_OptMantDPros.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
                loc_nVal = csDestinos.Situas
                loc_oPg2.obj_4c_OptSituas.Value = IIF(loc_nVal > 0, loc_nVal, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptDelets", 5)
                loc_nVal = csDestinos.Delets
                loc_oPg2.obj_4c_OptDelets.Value = IIF(loc_nVal > 0, loc_nVal, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMovMZeros", 5)
                loc_nVal = csDestinos.MovMZeros
                loc_oPg2.obj_4c_OptMovMZeros.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMovcParc", 5)
                loc_nVal = csDestinos.MovcParc
                loc_oPg2.obj_4c_OptMovcParc.Value = IIF(loc_nVal > 0, loc_nVal, 2)
            ENDIF

            *-- Atualiza grdDestinoG para mostrar grupos da linha atual
            IF PEMSTATUS(loc_oPg2, "grd_4c_DestinoG", 5)
                loc_oPg2.grd_4c_DestinoG.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RefrescarOpcoesDoItem:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SincronizarOpcoeParaItem - Grava valores dos OptionGroups na linha csDestinos atual
    *==========================================================================
    PROTECTED PROCEDURE SincronizarOpcoesParaItem()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !USED("csDestinos") OR RECCOUNT("csDestinos") = 0 OR EOF("csDestinos")
            RETURN
        ENDIF

        TRY
            SELECT csDestinos
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConOs", 5)
                REPLACE csDestinos.GruconOs WITH loc_oPg2.obj_4c_OptGruConOs.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConDs", 5)
                REPLACE csDestinos.GruconDs WITH loc_oPg2.obj_4c_OptGruConDs.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptAgrupar", 5)
                REPLACE csDestinos.Agrupar WITH loc_oPg2.obj_4c_OptAgrupar.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptFranquia", 5)
                REPLACE csDestinos.Franquias WITH loc_oPg2.obj_4c_OptFranquia.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptCustos", 5)
                REPLACE csDestinos.Custos WITH loc_oPg2.obj_4c_OptCustos.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptImpostos", 5)
                REPLACE csDestinos.Impostos WITH loc_oPg2.obj_4c_OptImpostos.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptImagem", 5)
                REPLACE csDestinos.Imagem WITH loc_oPg2.obj_4c_OptImagem.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptOriCompos", 5)
                REPLACE csDestinos.OriCompos WITH loc_oPg2.obj_4c_OptOriCompos.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptNovoCodigo", 5)
                REPLACE csDestinos.NovoCods WITH loc_oPg2.obj_4c_OptNovoCodigo.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptCorTamanho", 5)
                REPLACE csDestinos.CorTams WITH loc_oPg2.obj_4c_OptCorTamanho.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMoevals", 5)
                REPLACE csDestinos.MoeVals WITH loc_oPg2.obj_4c_OptMoevals.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptEmpDests", 5)
                REPLACE csDestinos.EmpDests WITH loc_oPg2.obj_4c_OptEmpDests.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMontaObs", 5)
                REPLACE csDestinos.MontaObs WITH loc_oPg2.obj_4c_OptMontaObs.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptBarras", 5)
                REPLACE csDestinos.Barras WITH loc_oPg2.obj_4c_OptBarras.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptDesItens", 5)
                REPLACE csDestinos.DesItens WITH loc_oPg2.obj_4c_OptDesItens.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptGlobaliza", 5)
                REPLACE csDestinos.Globalizas WITH loc_oPg2.obj_4c_OptGlobaliza.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptChkCons", 5)
                REPLACE csDestinos.ChkCons WITH loc_oPg2.obj_4c_OptChkCons.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMccrs", 5)
                REPLACE csDestinos.Mccrs WITH loc_oPg2.obj_4c_OptMccrs.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptCheques", 5)
                REPLACE csDestinos.Cheques WITH loc_oPg2.obj_4c_OptCheques.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptRecalculos", 5)
                REPLACE csDestinos.Recalculos WITH loc_oPg2.obj_4c_OptRecalculos.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMantProds", 5)
                REPLACE csDestinos.MantProds WITH loc_oPg2.obj_4c_OptMantProds.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMantemMats", 5)
                REPLACE csDestinos.MantemMats WITH loc_oPg2.obj_4c_OptMantemMats.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMantDPros", 5)
                REPLACE csDestinos.MantDPros WITH loc_oPg2.obj_4c_OptMantDPros.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
                REPLACE csDestinos.Situas WITH loc_oPg2.obj_4c_OptSituas.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptDelets", 5)
                REPLACE csDestinos.Delets WITH loc_oPg2.obj_4c_OptDelets.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMovMZeros", 5)
                REPLACE csDestinos.MovMZeros WITH loc_oPg2.obj_4c_OptMovMZeros.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptMovcParc", 5)
                REPLACE csDestinos.MovcParc WITH loc_oPg2.obj_4c_OptMovcParc.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SincronizarOpcoesParaItem:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarEstadoCampos - Habilita/desabilita campos conforme modo
    *==========================================================================
    PROTECTED PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg2, loc_lEditar
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        *-- Processo: editavel apenas no INCLUIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
            loc_oPg2.txt_4c_Processos.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
            loc_oPg2.txt_4c_Processos.Enabled  = (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        *-- Codigo: sempre ReadOnly
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.ReadOnly = .T.
            loc_oPg2.txt_4c_Codigos.Enabled  = .F.
        ENDIF

        *-- Tolerancias: editavel em INCLUIR e ALTERAR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Toleras", 5)
            loc_oPg2.txt_4c_Toleras.ReadOnly = !loc_lEditar
            loc_oPg2.txt_4c_Toleras.Enabled  = loc_lEditar
        ENDIF

        *-- Grid destinos: editavel em INCLUIR e ALTERAR
        IF PEMSTATUS(loc_oPg2, "grd_4c_Destinos", 5)
            loc_oPg2.grd_4c_Destinos.ReadOnly = !loc_lEditar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "grd_4c_DestinoG", 5)
            loc_oPg2.grd_4c_DestinoG.ReadOnly = !loc_lEditar
        ENDIF

        *-- Botao confirmar
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar OR (THIS.this_cModoAtual = "EXCLUIR")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com valores dos campos de cabecalho
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
            THIS.this_oBusinessObject.this_cProcessos = ALLTRIM(loc_oPg2.txt_4c_Processos.Value)
        ENDIF
        THIS.this_oBusinessObject.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Toleras", 5)
            THIS.this_oBusinessObject.this_nToleras = loc_oPg2.txt_4c_Toleras.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptFiscal", 5)
            THIS.this_oBusinessObject.this_nFiscal = loc_oPg2.obj_4c_OptFiscal.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptImprimir", 5)
            THIS.this_oBusinessObject.this_nImprimir = loc_oPg2.obj_4c_OptImprimir.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptOrdems", 5)
            THIS.this_oBusinessObject.this_nOrdems = loc_oPg2.obj_4c_OptOrdems.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptLogs", 5)
            THIS.this_oBusinessObject.this_nLogs = loc_oPg2.obj_4c_OptLogs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptApagar", 5)
            THIS.this_oBusinessObject.this_nApagar = loc_oPg2.obj_4c_OptApagar.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do formulario com valores do BO
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
            loc_oPg2.txt_4c_Processos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cProcessos)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Value   = THIS.this_oBusinessObject.this_nCodigos
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Toleras", 5)
            loc_oPg2.txt_4c_Toleras.Value   = THIS.this_oBusinessObject.this_nToleras
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptFiscal", 5)
            loc_oPg2.obj_4c_OptFiscal.Value   = IIF(THIS.this_oBusinessObject.this_nFiscal > 0, THIS.this_oBusinessObject.this_nFiscal, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptImprimir", 5)
            loc_oPg2.obj_4c_OptImprimir.Value = IIF(THIS.this_oBusinessObject.this_nImprimir > 0, THIS.this_oBusinessObject.this_nImprimir, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptOrdems", 5)
            loc_oPg2.obj_4c_OptOrdems.Value   = IIF(THIS.this_oBusinessObject.this_nOrdems > 0, THIS.this_oBusinessObject.this_nOrdems, 1)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptLogs", 5)
            loc_oPg2.obj_4c_OptLogs.Value     = IIF(THIS.this_oBusinessObject.this_nLogs > 0, THIS.this_oBusinessObject.this_nLogs, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptApagar", 5)
            loc_oPg2.obj_4c_OptApagar.Value   = IIF(THIS.this_oBusinessObject.this_nApagar > 0, THIS.this_oBusinessObject.this_nApagar, 1)
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos editaveis da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
            loc_oPg2.txt_4c_Processos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Toleras", 5)
            loc_oPg2.txt_4c_Toleras.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptFiscal", 5)
            loc_oPg2.obj_4c_OptFiscal.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptImprimir", 5)
            loc_oPg2.obj_4c_OptImprimir.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptOrdems", 5)
            loc_oPg2.obj_4c_OptOrdems.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptLogs", 5)
            loc_oPg2.obj_4c_OptLogs.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptApagar", 5)
            loc_oPg2.obj_4c_OptApagar.Value = 1
        ENDIF

        IF USED("csDestinos")
            ZAP IN csDestinos
        ENDIF
        IF USED("csDestinoG")
            ZAP IN csDestinoG
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("csDestinos")
            USE IN csDestinos
        ENDIF
        IF USED("csDestinoG")
            USE IN csDestinoG
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, torna controles visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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

    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual     = "INCLUIR"
            THIS.this_nPkAtual       = 0
            THIS.this_cProcessoAtual = ""
            THIS.AtualizarEstadoCampos()
            THIS.AlternarPagina(2)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Processos", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Processos.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigos
        loc_nCodigos = 0

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro na lista.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF("cursor_4c_Dados")
                    MsgAviso("Selecione um registro na lista.", "Visualizar")
                ELSE
                    loc_nCodigos = cursor_4c_Dados.codigos
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
                        THIS.this_cModoAtual     = "VISUALIZAR"
                        THIS.this_nPkAtual       = loc_nCodigos
                        THIS.this_cProcessoAtual = ALLTRIM(THIS.this_oBusinessObject.this_cProcessos)
                        THIS.BOParaForm()
                        THIS.AtualizarEstadoCampos()
                        THIS.AlternarPagina(2)
                    ELSE
                        MsgErro("Erro ao carregar registro!", "Visualizar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigos
        loc_nCodigos = 0

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro na lista.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF("cursor_4c_Dados")
                    MsgAviso("Selecione um registro na lista.", "Alterar")
                ELSE
                    loc_nCodigos = cursor_4c_Dados.codigos
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
                        THIS.this_oBusinessObject.EditarRegistro()
                        THIS.this_cModoAtual     = "ALTERAR"
                        THIS.this_nPkAtual       = loc_nCodigos
                        THIS.this_cProcessoAtual = ALLTRIM(THIS.this_oBusinessObject.this_cProcessos)
                        THIS.BOParaForm()
                        THIS.AtualizarEstadoCampos()
                        THIS.AlternarPagina(2)
                        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Toleras", 5)
                            THIS.pgf_4c_Paginas.Page2.txt_4c_Toleras.SetFocus()
                        ENDIF
                    ELSE
                        MsgErro("Erro ao carregar registro!", "Alterar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigos
        loc_nCodigos = 0

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro na lista.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF("cursor_4c_Dados")
                    MsgAviso("Selecione um registro na lista.", "Excluir")
                ELSE
                    loc_nCodigos = cursor_4c_Dados.codigos
                    IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste processo?", ;
                                   "Confirmar Exclus" + CHR(227) + "o")
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
                            IF THIS.this_oBusinessObject.Excluir()
                                MsgInfo("Processo exclu" + CHR(237) + "do com sucesso!", ;
                                        "Exclu" + CHR(237) + "do")
                                THIS.CarregarLista()
                            ELSE
                                MsgErro("Erro ao excluir processo!", "Excluir")
                            ENDIF
                        ELSE
                            MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Excluir")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cTermoBusca, loc_cFiltro, loc_oGrid
        loc_cTermoBusca = INPUTBOX("Processo (nome/parte):", ;
                                   "Buscar Processo de C" + CHR(243) + "pia", "")

        TRY
            IF !EMPTY(ALLTRIM(loc_cTermoBusca))
                loc_cFiltro = "processos LIKE " + EscaparSQL(ALLTRIM(loc_cTermoBusca) + "%")
                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 3
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.processos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column1.Header1.Caption = "Processos"
                        loc_oGrid.Column2.Header1.Caption = "Emp"
                        loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digos"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                ENDIF
            ELSE
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e persiste dados
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_cProcessos, loc_nCodFiscal
        LOCAL loc_nResult, loc_cSQL, loc_lFiscalOk, loc_lSucesso
        loc_lSucesso = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        *-- Validacao: processos obrigatorio
        IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
            loc_cProcessos = ALLTRIM(loc_oPg2.txt_4c_Processos.Value)
        ELSE
            loc_cProcessos = ""
        ENDIF

        IF EMPTY(loc_cProcessos)
            MsgAviso("Nome do Processo n" + CHR(227) + "o pode ficar em branco!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
                loc_oPg2.txt_4c_Processos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- Valida unicidade do processo no INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            TRY
                IF USED("cursor_4c_ChkProc")
                    USE IN cursor_4c_ChkProc
                ENDIF
                loc_cSQL = "SELECT codigos FROM SigPcOoP WHERE processos = " + EscaparSQL(loc_cProcessos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkProc")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkProc") > 0
                    MsgAviso("Processo '" + loc_cProcessos + "' j" + CHR(225) + " existe!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("cursor_4c_ChkProc")
                        USE IN cursor_4c_ChkProc
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
                        loc_oPg2.txt_4c_Processos.SetFocus()
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_ChkProc")
                    USE IN cursor_4c_ChkProc
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao verificar processo:" + CHR(13) + loc_oErro.Message, "Erro")
                RETURN
            ENDTRY
        ENDIF

        *-- Valida fiscal: se fiscal=1 deve haver pelo menos 1 linha com Fiscais=1
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptFiscal", 5)
            IF loc_oPg2.obj_4c_OptFiscal.Value = 1
                loc_lFiscalOk = .F.
                IF USED("csDestinos")
                    SELECT csDestinos
                    SCAN
                        IF csDestinos.Fiscais = 1
                            loc_lFiscalOk = .T.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                IF !loc_lFiscalOk
                    MsgAviso("Fiscal habilitado mas nenhuma linha de destino tem Fiscal marcado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF
            ENDIF
        ENDIF

        *-- Sincroniza opcoes da linha atual para csDestinos antes de salvar
        THIS.SincronizarOpcoesParaItem()

        TRY
            THIS.FormParaBO()

            IF THIS.this_cModoAtual = "INCLUIR"
                loc_lSucesso = THIS.this_oBusinessObject.Salvar()
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Salvar()
            ENDIF

            IF loc_lSucesso
                *-- Salva itens filhos
                THIS.this_oBusinessObject.SalvarItens( ;
                    THIS.this_oBusinessObject.this_cProcessos, ;
                    THIS.this_oBusinessObject.this_nCodigos)

                *-- Atualiza SigCdPrg
                THIS.this_oBusinessObject.AtualizarSigCdPrg( ;
                    THIS.this_oBusinessObject.this_cProcessos, ;
                    THIS.this_oBusinessObject.this_nCodigos)

                MsgInfo("Registro salvo com sucesso!", "Salvo")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao salvar processo!", "Salvar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnCompoInserirClick - Insere nova linha em branco no csDestinos
    *==========================================================================
    PROCEDURE BtnCompoInserirClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            *-- Sincroniza opcoes antes de mover para nova linha
            THIS.SincronizarOpcoesParaItem()
            SELECT csDestinos
            APPEND BLANK
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
            ENDIF
            THIS.RefrescarOpcoesDoItem()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCompoInserirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCompoExcluirClick - Exclui linha atual do csDestinos e seus grupos
    *==========================================================================
    PROCEDURE BtnCompoExcluirClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
                LOCAL loc_cIdRef
                SELECT csDestinos
                loc_cIdRef = ALLTRIM(csDestinos.cIdChaves)
                DELETE IN csDestinos
                PACK IN csDestinos
                *-- Remove grupos associados
                IF USED("csDestinoG") AND !EMPTY(loc_cIdRef)
                    SELECT csDestinoG
                    DELETE FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdRef
                    PACK IN csDestinoG
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
                ENDIF
                THIS.RefrescarOpcoesDoItem()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCompoExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnGrpInserirClick - Insere nova linha em csDestinoG vinculada ao item atual
    *==========================================================================
    PROCEDURE BtnGrpInserirClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
                SELECT csDestinos
                LOCAL loc_cFk
                loc_cFk = ALLTRIM(csDestinos.cIdChaves)
                IF EMPTY(loc_cFk)
                    *-- Atribui novo ID se ainda nao tem
                    loc_cFk = SYS(2015)
                    REPLACE csDestinos.cIdChaves WITH loc_cFk
                ENDIF
                INSERT INTO csDestinoG (Processos, fkChaves) ;
                    VALUES (ALLTRIM(csDestinos.Processos), loc_cFk)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_DestinoG", 5)
                    THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG.Refresh()
                ENDIF
            ELSE
                MsgAviso("Selecione um item de destino primeiro.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnGrpInserirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnGrpExcluirClick - Exclui linha atual de csDestinoG
    *==========================================================================
    PROCEDURE BtnGrpExcluirClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF USED("csDestinoG") AND RECCOUNT("csDestinoG") > 0 AND !EOF("csDestinoG")
                SELECT csDestinoG
                DELETE IN csDestinoG
                PACK IN csDestinoG
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_DestinoG", 5)
                    THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnGrpExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCopOpeClick - Copia linha atual do csDestinos e seus grupos
    *==========================================================================
    PROCEDURE BtnCopOpeClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        TRY
            IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
                LOCAL loc_cIdAntigo, loc_cIdNovo
                SELECT csDestinos
                loc_cIdAntigo = ALLTRIM(csDestinos.cIdChaves)
                loc_cIdNovo   = SYS(2015)
                SCATTER MEMVAR MEMO
                APPEND BLANK
                GATHER MEMVAR MEMO
                REPLACE csDestinos.cIdChaves WITH loc_cIdNovo
                IF USED("csDestinoG") AND !EMPTY(loc_cIdAntigo)
                    SELECT csDestinoG
                    LOCATE FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdAntigo
                    DO WHILE !EOF("csDestinoG") AND ALLTRIM(csDestinoG.fkChaves) == loc_cIdAntigo
                        SCATTER MEMVAR MEMO
                        APPEND BLANK
                        GATHER MEMVAR MEMO
                        REPLACE csDestinoG.fkChaves WITH loc_cIdNovo
                        SKIP
                    ENDDO
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
                ENDIF
            ELSE
                MsgAviso("Selecione um item para copiar.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCopOpeClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdDestinosKeyPress - F4 abre lookup da coluna ativa em grd_4c_Destinos
    *==========================================================================
    PROCEDURE GrdDestinosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            LOCAL loc_oGrid
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
            DO CASE
            CASE loc_oGrid.ActiveColumn = 2
                THIS.AbrirLookupDrives()
            CASE loc_oGrid.ActiveColumn = 3
                THIS.AbrirLookupOperacaoDestino()
            CASE loc_oGrid.ActiveColumn = 8
                THIS.AbrirLookupGrandeGrupoDestino()
            CASE loc_oGrid.ActiveColumn = 9
                THIS.AbrirLookupEmpresaDestino()
            CASE loc_oGrid.ActiveColumn = 10
                THIS.AbrirLookupOperacaoOrigem()
            CASE loc_oGrid.ActiveColumn = 11
                THIS.AbrirLookupUnidadeDestino()
            ENDCASE
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdDestinosDblClick - DblClick abre lookup da coluna ativa em grd_4c_Destinos
    *==========================================================================
    PROCEDURE GrdDestinosDblClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
        DO CASE
        CASE loc_oGrid.ActiveColumn = 2
            THIS.AbrirLookupDrives()
        CASE loc_oGrid.ActiveColumn = 3
            THIS.AbrirLookupOperacaoDestino()
        CASE loc_oGrid.ActiveColumn = 8
            THIS.AbrirLookupGrandeGrupoDestino()
        CASE loc_oGrid.ActiveColumn = 9
            THIS.AbrirLookupEmpresaDestino()
        CASE loc_oGrid.ActiveColumn = 10
            THIS.AbrirLookupOperacaoOrigem()
        CASE loc_oGrid.ActiveColumn = 11
            THIS.AbrirLookupUnidadeDestino()
        ENDCASE
    ENDPROC

    *==========================================================================
    * GrdDestinoGKeyPress - F4 abre lookup da coluna ativa em grd_4c_DestinoG
    *==========================================================================
    PROCEDURE GrdDestinoGKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            LOCAL loc_oGrid
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG
            DO CASE
            CASE loc_oGrid.ActiveColumn = 1
                THIS.AbrirLookupGrandeGrupoG()
            CASE loc_oGrid.ActiveColumn = 2
                THIS.AbrirLookupUnidadeG()
            CASE loc_oGrid.ActiveColumn = 3
                THIS.AbrirLookupGrupoG()
            ENDCASE
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdDestinoGDblClick - DblClick abre lookup da coluna ativa em grd_4c_DestinoG
    *==========================================================================
    PROCEDURE GrdDestinoGDblClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG
        DO CASE
        CASE loc_oGrid.ActiveColumn = 1
            THIS.AbrirLookupGrandeGrupoG()
        CASE loc_oGrid.ActiveColumn = 2
            THIS.AbrirLookupUnidadeG()
        CASE loc_oGrid.ActiveColumn = 3
            THIS.AbrirLookupGrupoG()
        ENDCASE
    ENDPROC

    *==========================================================================
    * AbrirLookupDrives - Busca Local/Drive (SigCdLoc.cods) -> csDestinos.Drives
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupDrives()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
            IF USED("cursor_4c_BuscaDrives")
                USE IN cursor_4c_BuscaDrives
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cods, drives FROM SigCdLoc ORDER BY cods", ;
                "cursor_4c_BuscaDrives")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Locais/Drives.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDrives"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaDrives", "cods", "drives", ;
                "Buscar Local/Drive")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinos") AND !EOF("csDestinos")
                    SELECT csDestinos
                    REPLACE csDestinos.Drives WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaDrives")
                USE IN cursor_4c_BuscaDrives
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupDrives:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupOperacaoDestino - Busca Operacao (SigCdOpe.Dopes) -> csDestinos.DopeDs
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupOperacaoDestino()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
            IF USED("cursor_4c_BuscaOpeDs")
                USE IN cursor_4c_BuscaOpeDs
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", ;
                "cursor_4c_BuscaOpeDs")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpeDs"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaOpeDs", "Dopes", "Dopes", ;
                "Buscar Opera" + CHR(231) + CHR(227) + "o Destino")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinos") AND !EOF("csDestinos")
                    SELECT csDestinos
                    REPLACE csDestinos.DopeDs WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaOpeDs")
                USE IN cursor_4c_BuscaOpeDs
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupOperacaoDestino:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupGrandeGrupoDestino - Busca Grande Grupo (SigCdGpr.codigos) -> csDestinos.GdeGrupos
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrandeGrupoDestino()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
            IF USED("cursor_4c_BuscaGdeGrp")
                USE IN cursor_4c_BuscaGdeGrp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
                "cursor_4c_BuscaGdeGrp")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Grandes Grupos.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGdeGrp"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaGdeGrp", "codigos", "descs", ;
                "Buscar Grande Grupo")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinos") AND !EOF("csDestinos")
                    SELECT csDestinos
                    REPLACE csDestinos.GdeGrupos WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGdeGrp")
                USE IN cursor_4c_BuscaGdeGrp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupGrandeGrupoDestino:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaDestino - Busca Empresa (SigCdEmp.Cemps) -> csDestinos.Emps
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresaDestino()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
            IF USED("cursor_4c_BuscaEmpOr")
                USE IN cursor_4c_BuscaEmpOr
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                "cursor_4c_BuscaEmpOr")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Empresas.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOr"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpOr", "Cemps", "Razas", ;
                "Buscar Empresa Origem")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinos") AND !EOF("csDestinos")
                    SELECT csDestinos
                    REPLACE csDestinos.Emps WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaEmpOr")
                USE IN cursor_4c_BuscaEmpOr
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupEmpresaDestino:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupOperacaoOrigem - Busca Operacao (SigCdOpe.Dopes) -> csDestinos.Dopes
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupOperacaoOrigem()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
            IF USED("cursor_4c_BuscaOpeOr")
                USE IN cursor_4c_BuscaOpeOr
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", ;
                "cursor_4c_BuscaOpeOr")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpeOr"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaOpeOr", "Dopes", "Dopes", ;
                "Buscar Opera" + CHR(231) + CHR(227) + "o Origem")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinos") AND !EOF("csDestinos")
                    SELECT csDestinos
                    REPLACE csDestinos.Dopes WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaOpeOr")
                USE IN cursor_4c_BuscaOpeOr
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupOperacaoOrigem:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupUnidadeDestino - Busca Unidade (SigCdUni.CUnis) -> csDestinos.CUnis
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupUnidadeDestino()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
            IF USED("cursor_4c_BuscaUni")
                USE IN cursor_4c_BuscaUni
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", ;
                "cursor_4c_BuscaUni")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Unidades.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUni"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaUni", "CUnis", "DUnis", ;
                "Buscar Unidade")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinos") AND !EOF("csDestinos")
                    SELECT csDestinos
                    REPLACE csDestinos.CUnis WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaUni")
                USE IN cursor_4c_BuscaUni
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupUnidadeDestino:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupGrandeGrupoG - Busca Grande Grupo (SigCdGpr.codigos) -> csDestinoG.Mercs
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrandeGrupoG()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG
            IF USED("cursor_4c_BuscaGdeGrpG")
                USE IN cursor_4c_BuscaGdeGrpG
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
                "cursor_4c_BuscaGdeGrpG")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Grandes Grupos.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGdeGrpG"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaGdeGrpG", "codigos", "descs", ;
                "Buscar Grande Grupo")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinoG") AND !EOF("csDestinoG")
                    SELECT csDestinoG
                    REPLACE csDestinoG.Mercs WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGdeGrpG")
                USE IN cursor_4c_BuscaGdeGrpG
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupGrandeGrupoG:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupUnidadeG - Busca Unidade (SigCdUni.CUnis) -> csDestinoG.CUnis
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupUnidadeG()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG
            IF USED("cursor_4c_BuscaUniG")
                USE IN cursor_4c_BuscaUniG
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", ;
                "cursor_4c_BuscaUniG")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Unidades.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUniG"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaUniG", "CUnis", "DUnis", ;
                "Buscar Unidade")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinoG") AND !EOF("csDestinoG")
                    SELECT csDestinoG
                    REPLACE csDestinoG.CUnis WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaUniG")
                USE IN cursor_4c_BuscaUniG
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupUnidadeG:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupoG - Busca Grupo de Produto (SigCdGrp.cgrus) -> csDestinoG.Cgrus
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupoG()
        LOCAL loc_oBusca, loc_oGrid, loc_nResult, loc_cSelecionado
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG
            IF USED("cursor_4c_BuscaGrpG")
                USE IN cursor_4c_BuscaGrpG
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
                "cursor_4c_BuscaGrpG")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar Grupos de Produto.", "Erro")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrpG"
            loc_oBusca.DefinirCursor("cursor_4c_BuscaGrpG", "cgrus", "dgrus", ;
                "Buscar Grupo de Produto")
            loc_oBusca.Mostrar()
            IF loc_oBusca.this_lSelecionou
                loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF USED("csDestinoG") AND !EOF("csDestinoG")
                    SELECT csDestinoG
                    REPLACE csDestinoG.Cgrus WITH loc_cSelecionado
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGrpG")
                USE IN cursor_4c_BuscaGrpG
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupGrupoG:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
