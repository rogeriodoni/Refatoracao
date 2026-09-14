*====================================================================
* FormSre.prg
*
* Formulario de Cadastro de Serie de Nota Fiscal (SIGCDSRE)
*
* Tabela principal: SigCdSer (empcods PK = emps + cods)
* Tipo: CRUD (frmcadastro)
* BO: SreBO
*
* FASE 6/8 - Campos restantes e lookups (Page2 - Parte 2)
* Inclui: PageFrame + containers principais, Grid da lista (Emp/Codigo/
* Descricao/Tipo N.F.), botoes CRUD (Incluir/Visualizar/Alterar/Excluir/
* Buscar/Encerrar), CarregarLista(), AlternarPagina(), TODOS os campos
* de Page2 (Codigo/Descricao/Empresa/Modelo/Tipo N.F./Numeracao/
* Imprime NF/Dados ECF Fiscal/Servicos/Selo Transporte/Inicial/Final),
* container cnt_4c_BotoesAcao (Confirmar/Cancelar) e lookup completo
* de Empresa (ValidarEmpresa/ValidarDescricaoEmpresa/AbrirLookupEmpresa)
* NAO inclui ainda: FormParaBO/BOParaForm, eventos dos botoes CRUD
* (Incluir/Alterar/Excluir/Buscar/Salvar/Cancelar) (Fases 7-8)
*====================================================================

DEFINE CLASS FormSre AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de S" + CHR(233) + "rie de Nota Fiscal"
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
    this_oBusinessObject   = .NULL.
    this_cModoAtual        = "LISTA"
    this_cUltimoEmpValidado  = ""
    this_cUltimoDEmpValidado = ""

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSre.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria Business Object e configura estrutura completa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SreBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SreBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSre.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * PageFrame.Top = -29 esconde as abas; controles internos compensam +29
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
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza com titulo do formulario
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

        *-- Container de botoes CRUD (canonico: Left=542, lado direito)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90 - CLAUDE.md regra #10)
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

        *-- Grid lista: Emp + Codigo + Descricao + Tipo N.F.
        *-- (colunas conforme AddCursor/pColuna do legado - Fase 4)
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
            .Column1.Width           = 90
            .Column2.Width           = 140
            .Column3.Width           = 460
            .Column4.Width           = 170
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column3.ReadOnly        = .T.
            .Column4.ReadOnly        = .T.
            .Column1.Header1.Caption = "Emp"
            .Column2.Header1.Caption = "C" + CHR(243) + "digo"
            .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Caption = "Tipo N.F."
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: container de botoes de acao + campos
    * FASE 5/8: primeira metade dos campos (Codigo, Descricao, Empresa/DEmpresa,
    * Modelo, Tipo N.F., Bloqueia NF, Tipo NF (OptionGroup), label Numeracao NF)
    * Todos os Tops compensados com +29 (PageFrame.Top = -29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPg2.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

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
                .AutoSize  = .F.
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH



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
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

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
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        *-- Codigo (Getcods: top=121+29=150, left=275, width=31)
        *-- Label1 (Say1 "C" + CHR(243) + "digo :"): top=125+29=154, left=229
        *======================================================================
        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Value         = ""
            .Top           = 150
            .Left          = 275
            .Width         = 31
            .Height        = 24
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 154
            .Left      = 229
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Descricao (Getdescs: top=121+29=150, left=390, width=209)
        *-- Label2 (Say2 "Descri" + CHR(231) + CHR(227) + "o :"): top=125+29=154, left=331
        *======================================================================
        loc_oPg2.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPg2.txt_4c_Descricao
            .Value         = ""
            .Top           = 150
            .Left          = 390
            .Width         = 209
            .Height        = 24
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 154
            .Left      = 331
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Empresa (getEmps: top=148+29=177, left=275, width=31)
        *-- Descricao da Empresa (getDEmps, somente exibicao): top=148+29=177, left=309, width=290
        *-- Label7 (Say7 "Empresa :"): top=152+29=181, left=221
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg2.lbl_4c_Label7
            .Caption   = "Empresa :"
            .Top       = 181
            .Left      = 221
            .Width     = 50
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPg2.txt_4c_Emps
            .Value         = ""
            .Top           = 177
            .Left          = 275
            .Width         = 31
            .Height        = 24
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oPg2.txt_4c_DEmps
            .Value         = ""
            .Top           = 177
            .Left          = 309
            .Width         = 290
            .Height        = 24
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Lookup de Empresa (fAcessoEmpresa no legado): F4/DblClick abrem
        *-- FormBuscaAuxiliar; LostFocus valida por codigo (Emps) ou por
        *-- descricao (DEmps) e faz busca reversa (ver Problema 45: guard
        *-- contra reabertura em toda perda de foco sem valor alterado)
        BINDEVENT(loc_oPg2.txt_4c_Emps, "KeyPress", THIS, "EmpsKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_Emps, "DblClick", THIS, "EmpsDblClick")
        BINDEVENT(loc_oPg2.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpresa")
        BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress", THIS, "DEmpsKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_DEmps, "DblClick", THIS, "DEmpsDblClick")
        BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress", THIS, "ValidarDescricaoEmpresa")

        *======================================================================
        *-- Modelo (getModelo: top=175+29=204, left=275, width=31)
        *-- Label12 (Say12 "Modelo :"): top=179+29=208, left=228
        *======================================================================
        loc_oPg2.AddObject("txt_4c_Modelo", "TextBox")
        WITH loc_oPg2.txt_4c_Modelo
            .Value         = ""
            .Top           = 204
            .Left          = 275
            .Width         = 31
            .Height        = 24
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPg2.lbl_4c_Label12
            .Caption   = "Modelo :"
            .Top       = 208
            .Left      = 228
            .Width     = 43
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Tipo N.F. (gettiponf: top=175+29=204, left=390, width=48)
        *-- Label14 (Say14 "Tipo NF :"): top=179+29=208, left=341
        *======================================================================
        loc_oPg2.AddObject("txt_4c_Tiponf", "TextBox")
        WITH loc_oPg2.txt_4c_Tiponf
            .Value         = ""
            .Top           = 204
            .Left          = 390
            .Width         = 48
            .Height        = 24
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPg2.lbl_4c_Label14
            .Caption   = "Tipo NF :"
            .Top       = 208
            .Left      = 341
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Bloquear NF Caso Exista Anterior Nao Impressa
        *-- (ck_BlqInss: top=175+29=204, left=467, width=314, height=30)
        *======================================================================
        loc_oPg2.AddObject("chk_4c_Ck_BlqInss", "CheckBox")
        WITH loc_oPg2.chk_4c_Ck_BlqInss
            .Value     = 0
            .Caption   = "Bloquear NF Caso Exista Anterior N" + CHR(227) + "o Impressa"
            .Top       = 204
            .Left      = 467
            .Width     = 314
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Tipo NF (Op_TipoNF: top=203+29=232, left=271, width=420, height=25)
        *-- ButtonCount=4: Automatico / Manual / Automatico Sem Alteracao / Documento
        *======================================================================
        loc_oPg2.AddObject("obj_4c_Op_TipoNF", "OptionGroup")
        WITH loc_oPg2.obj_4c_Op_TipoNF
            .ButtonCount = 4
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 232
            .Left        = 271
            .Width       = 420
            .Height      = 25
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.obj_4c_Op_TipoNF.Buttons(1)
            .Caption   = "Autom" + CHR(225) + "tico"
            .Left      = 5
            .Top       = 5
            .Width     = 85
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Op_TipoNF.Buttons(2)
            .Caption   = "Manual"
            .Left      = 95
            .Top       = 5
            .Width     = 60
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Op_TipoNF.Buttons(3)
            .Caption   = "Autom" + CHR(225) + "tico Sem Altera" + CHR(231) + CHR(227) + "o"
            .Left      = 158
            .Top       = 5
            .Width     = 144
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Op_TipoNF.Buttons(4)
            .Caption   = "Documento"
            .Left      = 334
            .Top       = 5
            .Width     = 72
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *======================================================================
        *-- Label3 (Say3 "N" + CHR(250) + "mera" + CHR(231) + CHR(227) + "o de NF :")
        *-- top=206+29=235, left=177 (campos de numeracao vem na Fase 6)
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .Caption   = "N" + CHR(250) + "mera" + CHR(231) + CHR(227) + "o de NF :"
            .Top       = 235
            .Left      = 177
            .Width     = 94
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- FASE 6/8: campos restantes (ultimos 50%)
        *======================================================================

        *======================================================================
        *-- Label13 (Say13 "N" + CHR(250) + "mera" + CHR(231) + CHR(227) + "o :")
        *-- top=228+29=257, left=208, width=63
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg2.lbl_4c_Label13
            .Caption   = "N" + CHR(250) + "mera" + CHR(231) + CHR(227) + "o :"
            .Top       = 257
            .Left      = 208
            .Width     = 63
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Numeracao de NF (fwoption2: nnfobrigs) top=224+29=253, left=271,
        *-- width=180, height=25, ButtonCount=2: Opcional / Obrigatoria
        *======================================================================
        loc_oPg2.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPg2.obj_4c_Fwoption2
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 253
            .Left        = 271
            .Width       = 180
            .Height      = 25
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.obj_4c_Fwoption2.Buttons(1)
            .Caption   = "Opcional"
            .Left      = 5
            .Top       = 5
            .Width     = 60
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Fwoption2.Buttons(2)
            .Caption   = "Obrigat" + CHR(243) + "ria"
            .Left      = 95
            .Top       = 5
            .Width     = 75
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *======================================================================
        *-- Label4 (Say4 "Imprime NF :") top=249+29=278, left=208, width=63
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = "Imprime NF :"
            .Top       = 278
            .Left      = 208
            .Width     = 63
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Imprime NF (Op_AlteraPeso: impnfs) top=246+29=275, left=271,
        *-- width=175, height=25, ButtonCount=3: Sim / Nao / Eletronica
        *======================================================================
        loc_oPg2.AddObject("obj_4c_Op_AlteraPeso", "OptionGroup")
        WITH loc_oPg2.obj_4c_Op_AlteraPeso
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 275
            .Left        = 271
            .Width       = 175
            .Height      = 25
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.obj_4c_Op_AlteraPeso.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Op_AlteraPeso.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Op_AlteraPeso.Buttons(3)
            .Caption   = "Eletr" + CHR(244) + "nica"
            .Left      = 95
            .Top       = 5
            .Width     = 65
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- ck_BlqInss so fica habilitado quando Imprime NF = Sim (Problema 31:
        *-- InteractiveChange precisa recalcular o Enabled do checkbox)
        BINDEVENT(loc_oPg2.obj_4c_Op_AlteraPeso, "InteractiveChange", THIS, "AjustarChkBlqInss")

        *======================================================================
        *-- Label5 (Say5 "Dados ECF Fiscal :") top=273+29=302, left=181, width=90
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = "Dados ECF Fiscal :"
            .Top       = 302
            .Left      = 181
            .Width     = 90
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Dados ECF Fiscal (Optiongroup1: mostecfs) top=269+29=298, left=271,
        *-- width=96, height=25, ButtonCount=2: Sim / Nao
        *======================================================================
        loc_oPg2.AddObject("obj_4c_Optiongroup1", "OptionGroup")
        WITH loc_oPg2.obj_4c_Optiongroup1
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 298
            .Left        = 271
            .Width       = 100
            .Height      = 25
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.obj_4c_Optiongroup1.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Optiongroup1.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *======================================================================
        *-- Label6 (Say6 "Servi" + CHR(231) + "os :") top=296+29=325, left=222, width=49
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "Servi" + CHR(231) + "os :"
            .Top       = 325
            .Left      = 222
            .Width     = 49
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Servicos (fwoption1: TpServicos) top=291+29=320, left=271,
        *-- width=232, height=27, ButtonCount=3: Sim / Nao / Sim Com Itens
        *======================================================================
        loc_oPg2.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPg2.obj_4c_Fwoption1
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Top         = 320
            .Left        = 271
            .Width       = 232
            .Height      = 27
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.obj_4c_Fwoption1.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 6
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Fwoption1.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 6
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_Fwoption1.Buttons(3)
            .Caption   = "Sim Com Itens"
            .Left      = 96
            .Top       = 5
            .Width     = 112
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *======================================================================
        *-- Label11 (Say11 "Selo Transporte :") top=321+29=350, left=186, width=85
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPg2.lbl_4c_Label11
            .Caption   = "Selo Transporte :"
            .Top       = 350
            .Left      = 186
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        *-- Selo Transporte (optSeloTrans: SeloTrans) top=317+29=346, left=271,
        *-- width=96, height=25, ButtonCount=2: Sim / Nao
        *======================================================================
        loc_oPg2.AddObject("obj_4c_OptSeloTrans", "OptionGroup")
        WITH loc_oPg2.obj_4c_OptSeloTrans
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 346
            .Left        = 271
            .Width       = 100
            .Height      = 25
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.obj_4c_OptSeloTrans.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.obj_4c_OptSeloTrans.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *======================================================================
        *-- Label8 (Say8 "Inicial :") top=321+29=350, left=380, width=36
        *-- Inicial (getInicials: inicials) top=317+29=346, left=419, width=31
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg2.lbl_4c_Label8
            .Caption   = "Inicial :"
            .Top       = 350
            .Left      = 380
            .Width     = 36
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Inicials", "TextBox")
        WITH loc_oPg2.txt_4c_Inicials
            .Value         = ""
            .Top           = 346
            .Left          = 419
            .Width         = 31
            .Height        = 24
            .MaxLength     = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        *-- Label9 (Say9 "Final :") top=321+29=350, left=459, width=31
        *-- Final (getFinals: finals) top=317+29=346, left=491, width=31
        *======================================================================
        loc_oPg2.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg2.lbl_4c_Label9
            .Caption   = "Final :"
            .Top       = 350
            .Left      = 459
            .Width     = 31
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Finals", "TextBox")
        WITH loc_oPg2.txt_4c_Finals
            .Value         = ""
            .Top           = 346
            .Left          = 491
            .Width         = 31
            .Height        = 24
            .MaxLength     = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - LostFocus de txt_4c_Emps. Valida o codigo da empresa
    * digitado e preenche a descricao (Razas). Se nao encontrar, abre o
    * lookup para o usuario selecionar. Equivale ao fAcessoEmpresa(...,'C',...)
    * do legado (sigacess.PRG).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCod, loc_cSQL

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)

        *-- Guard (Problema 45): nao reabrir/revalidar se o valor nao mudou
        IF loc_cCod == THIS.this_cUltimoEmpValidado
            RETURN
        ENDIF
        THIS.this_cUltimoEmpValidado = loc_cCod

        IF EMPTY(loc_cCod)
            loc_oPg2.txt_4c_DEmps.Value = ""
            RETURN
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp" + ;
            " WHERE Cemps = " + EscaparSQL(loc_cCod)

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValid") >= 1 AND RECCOUNT("cursor_4c_EmpValid") > 0
            SELECT cursor_4c_EmpValid
            loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_EmpValid.Cemps)
            loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpValid.Razas)
            THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_EmpValid.Cemps)
            THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_EmpValid.Razas)
            IF USED("cursor_4c_EmpValid")
                USE IN cursor_4c_EmpValid
            ENDIF
        ELSE
            IF USED("cursor_4c_EmpValid")
                USE IN cursor_4c_EmpValid
            ENDIF
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescricaoEmpresa - LostFocus de txt_4c_DEmps. Faz busca reversa
    * pela razao social (Razas) e preenche o codigo (Cemps). Se nao encontrar,
    * abre o lookup. Equivale ao fAcessoEmpresa(...,'D',...) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescricaoEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDesc, loc_cSQL

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DEmps.Value)

        *-- Guard (Problema 45): nao reabrir/revalidar se o valor nao mudou
        IF loc_cDesc == THIS.this_cUltimoDEmpValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDEmpValidado = loc_cDesc

        IF EMPTY(loc_cDesc)
            RETURN
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp" + ;
            " WHERE Razas LIKE " + EscaparSQL(loc_cDesc + "%") + ;
            " ORDER BY Razas"

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DEmpValid") >= 1 AND RECCOUNT("cursor_4c_DEmpValid") > 0
            SELECT cursor_4c_DEmpValid
            loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_DEmpValid.Cemps)
            loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_DEmpValid.Razas)
            THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_DEmpValid.Cemps)
            THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_DEmpValid.Razas)
            IF USED("cursor_4c_DEmpValid")
                USE IN cursor_4c_DEmpValid
            ENDIF
        ELSE
            IF USED("cursor_4c_DEmpValid")
                USE IN cursor_4c_DEmpValid
            ENDIF
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecao de Empresa
    * (SigCdEmp). Disparado por F4/DblClick em txt_4c_Emps/txt_4c_DEmps e
    * como fallback quando ValidarEmpresa/ValidarDescricaoEmpresa nao
    * encontram o registro digitado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oPg2, loc_oBusca

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPg2.txt_4c_Emps.Enabled
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", ;
            "cursor_4c_BuscaEmpresa", ;
            "Cemps", ;
            ALLTRIM(loc_oPg2.txt_4c_Emps.Value), ;
            "Buscar Empresa", ;
            .F., .F., ;
            "")

        loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaEmpresa")
                SELECT cursor_4c_BuscaEmpresa
                loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
                THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
            ENDIF
        ELSE
            loc_oPg2.txt_4c_Emps.Value    = ""
            loc_oPg2.txt_4c_DEmps.Value   = ""
            THIS.this_cUltimoEmpValidado  = ""
            THIS.this_cUltimoDEmpValidado = ""
        ENDIF

        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Handlers KeyPress/DblClick dos campos de Empresa (F4 abre o lookup)
    *--------------------------------------------------------------------------
    PROCEDURE EmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE EmpsDblClick()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    PROCEDURE DEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE DEmpsDblClick()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o Form (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(loc_oBO.this_cCodigo)
            loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(loc_oBO.this_cDescricao)
            loc_oPg2.txt_4c_Emps.Value      = ALLTRIM(loc_oBO.this_cEmps)
            loc_oPg2.txt_4c_DEmps.Value     = ALLTRIM(loc_oBO.BuscarDescricaoEmpresa(loc_oBO.this_cEmps))
            loc_oPg2.txt_4c_Modelo.Value    = ALLTRIM(loc_oBO.this_cModelos)
            loc_oPg2.txt_4c_Tiponf.Value    = ALLTRIM(loc_oBO.this_cCtiponfs)
            loc_oPg2.txt_4c_Inicials.Value  = ALLTRIM(loc_oBO.this_cInicials)
            loc_oPg2.txt_4c_Finals.Value    = ALLTRIM(loc_oBO.this_cFinals)

            loc_oPg2.chk_4c_Ck_BlqInss.Value = (loc_oBO.this_nBlqinss .Value = IIF(loc_oBO.this_nBlqinss = 1, 1, 0))

            *-- OptionGroups: usa valor gravado se dentro da faixa, senao default
            loc_oPg2.obj_4c_Op_TipoNF.Value    = IIF(BETWEEN(loc_oBO.this_nTiponfs, 1, 4), loc_oBO.this_nTiponfs, 1)
            loc_oPg2.obj_4c_Fwoption2.Value    = IIF(BETWEEN(loc_oBO.this_nNnfobrigs, 1, 2), loc_oBO.this_nNnfobrigs, 1)
            loc_oPg2.obj_4c_Op_AlteraPeso.Value = IIF(BETWEEN(loc_oBO.this_nImpnfs, 1, 3), loc_oBO.this_nImpnfs, 1)
            loc_oPg2.obj_4c_Optiongroup1.Value = IIF(BETWEEN(loc_oBO.this_nMostecfs, 1, 2), loc_oBO.this_nMostecfs, 1)
            loc_oPg2.obj_4c_Fwoption1.Value    = IIF(BETWEEN(loc_oBO.this_nTpservicos, 1, 3), loc_oBO.this_nTpservicos, 2)
            loc_oPg2.obj_4c_OptSeloTrans.Value = IIF(BETWEEN(loc_oBO.this_nSelotrans, 1, 2), loc_oBO.this_nSelotrans, 1)

            *-- Reseta guardas de lookup (Problema 45) com os valores recem-carregados,
            *-- evitando reabertura indevida do lookup no primeiro LostFocus
            THIS.this_cUltimoEmpValidado  = loc_oPg2.txt_4c_Emps.Value
            THIS.this_cUltimoDEmpValidado = loc_oPg2.txt_4c_DEmps.Value

            THIS.AjustarChkBlqInss()
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2 e restaura valores default
    * dos OptionGroups (mesmos defaults usados em ConfigurarPaginaDados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigo.Value    = ""
            loc_oPg2.txt_4c_Descricao.Value = ""
            loc_oPg2.txt_4c_Emps.Value      = ""
            loc_oPg2.txt_4c_DEmps.Value     = ""
            loc_oPg2.txt_4c_Modelo.Value    = ""
            loc_oPg2.txt_4c_Tiponf.Value    = ""
            loc_oPg2.txt_4c_Inicials.Value  = ""
            loc_oPg2.txt_4c_Finals.Value    = ""

            loc_oPg2.chk_4c_Ck_BlqInss.Value = 0

            loc_oPg2.obj_4c_Op_TipoNF.Value     = 1  && Automatico
            loc_oPg2.obj_4c_Fwoption2.Value     = 1  && Opcional
            loc_oPg2.obj_4c_Op_AlteraPeso.Value = 1  && Sim
            loc_oPg2.obj_4c_Optiongroup1.Value  = 1  && Sim
            loc_oPg2.obj_4c_Fwoption1.Value     = 2  && Nao
            loc_oPg2.obj_4c_OptSeloTrans.Value  = 1  && Sim

            THIS.this_cUltimoEmpValidado  = ""
            THIS.this_cUltimoDEmpValidado = ""

            THIS.AjustarChkBlqInss()
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
    * Regras extraidas do comportamento.json (eventos When de cada controle):
    * - Codigo: editavel em INCLUIR e BUSCAR (Getcods.When -> nao em ALTERAR/CONSULTAR)
    * - Emps/DEmps: editaveis somente em INCLUIR
    * - Descricao/Modelo/TipoNF/Inicial/Final: editaveis em INCLUIR e ALTERAR
    * - OptionGroups: habilitados em INCLUIR e ALTERAR
    * - ck_BlqInss: habilitado em INCLUIR/ALTERAR E Imprime NF (Op_AlteraPeso) = Sim
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdit, loc_lIncluir, loc_lCodBusca
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEdit     = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
        loc_lIncluir  = (loc_lEdit AND THIS.this_cModoAtual = "INCLUIR")
        loc_lCodBusca = (loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))

        TRY
            loc_oPg2.txt_4c_Codigo.ReadOnly    = !loc_lCodBusca
            loc_oPg2.txt_4c_Emps.ReadOnly      = !loc_lIncluir
            loc_oPg2.txt_4c_DEmps.ReadOnly     = !loc_lIncluir

            loc_oPg2.txt_4c_Descricao.ReadOnly = !loc_lEdit
            loc_oPg2.txt_4c_Modelo.ReadOnly    = !loc_lEdit
            loc_oPg2.txt_4c_Tiponf.ReadOnly    = !loc_lEdit
            loc_oPg2.txt_4c_Inicials.ReadOnly  = !loc_lEdit
            loc_oPg2.txt_4c_Finals.ReadOnly    = !loc_lEdit

            loc_oPg2.obj_4c_Op_TipoNF.Enabled     = loc_lEdit
            loc_oPg2.obj_4c_Fwoption2.Enabled     = loc_lEdit
            loc_oPg2.obj_4c_Op_AlteraPeso.Enabled = loc_lEdit
            loc_oPg2.obj_4c_Optiongroup1.Enabled  = loc_lEdit
            loc_oPg2.obj_4c_Fwoption1.Enabled     = loc_lEdit
            loc_oPg2.obj_4c_OptSeloTrans.Enabled  = loc_lEdit

            THIS.AjustarChkBlqInss()
            THIS.AjustarBotoesPorModo()
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita cmd_4c_Confirmar/cmd_4c_Cancelar
    * conforme o modo atual. Confirmar fica habilitado em INCLUIR/ALTERAR/BUSCAR
    * e tambem em EXCLUIR (usuario precisa confirmar a exclusao do registro).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao

        TRY
            loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR", "EXCLUIR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarChkBlqInss - Recalcula o Enabled de chk_4c_Ck_BlqInss. So fica
    * habilitado quando o form esta em edicao (INCLUIR/ALTERAR) E Imprime NF
    * (obj_4c_Op_AlteraPeso) = 1 (Sim). Reproduz o When original:
    * inlist(pcEscolha,'INSERIR','ALTERAR') and CrSigCdSer.impnfs = 1
    * Ligado tambem ao InteractiveChange de obj_4c_Op_AlteraPeso (Problema 31).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarChkBlqInss()
        LOCAL loc_oPg2, loc_lEdit

        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_lEdit = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oPg2.chk_4c_Ck_BlqInss.Enabled = (loc_lEdit AND loc_oPg2.obj_4c_Op_AlteraPeso.Value = 1)
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.AjustarChkBlqInss")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia inclusao de nova serie de nota fiscal
    * Legado: do case pcEscolha='INSERIR' -> foco em getEmps
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre registro selecionado para visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cEmpCods
        loc_cEmpCods = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
            ENDIF

            IF EMPTY(loc_cEmpCods)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
                    THIS.LimparCampos()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre registro selecionado para alteracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cEmpCods
        loc_cEmpCods = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
            ENDIF

            IF EMPTY(loc_cEmpCods)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.LimparCampos()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Prepara exclusao do registro selecionado (a exclusao
    * de fato ocorre na confirmacao via cmd_4c_Confirmar - Fase 8)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cEmpCods
        loc_cEmpCods = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
            ENDIF

            IF EMPTY(loc_cEmpCods)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
                    THIS.LimparCampos()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "EXCLUIR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form (Page2) para o Business Object
    * this_cEmpCods (PK) eh recalculado internamente pelo BO (ValidarDados/
    * Inserir) a partir de this_cEmps + this_cCodigo, nao precisa ser setado aqui
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            loc_oBO.this_cCodigo     = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            loc_oBO.this_cDescricao  = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            loc_oBO.this_cEmps       = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
            loc_oBO.this_cModelos    = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
            loc_oBO.this_cCtiponfs   = ALLTRIM(loc_oPg2.txt_4c_Tiponf.Value)
            loc_oBO.this_cInicials   = ALLTRIM(loc_oPg2.txt_4c_Inicials.Value)
            loc_oBO.this_cFinals     = ALLTRIM(loc_oPg2.txt_4c_Finals.Value)

            loc_oBO.this_nBlqinss    = IIF(loc_oPg2.chk_4c_Ck_BlqInss.Value = 1, 1, 0)

            loc_oBO.this_nTiponfs    = loc_oPg2.obj_4c_Op_TipoNF.Value
            loc_oBO.this_nNnfobrigs  = loc_oPg2.obj_4c_Fwoption2.Value
            loc_oBO.this_nImpnfs     = loc_oPg2.obj_4c_Op_AlteraPeso.Value
            loc_oBO.this_nMostecfs   = loc_oPg2.obj_4c_Optiongroup1.Value
            loc_oBO.this_nTpservicos = loc_oPg2.obj_4c_Fwoption1.Value
            loc_oBO.this_nSelotrans  = loc_oPg2.obj_4c_OptSeloTrans.Value

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Vai para Page2 no modo BUSCAR (Codigo ou Descricao)
    * Legado: Procedure de Buscar localiza por Getcods, senao por Getdescs
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick (Confirmar) - Comportamento depende do this_cModoAtual:
    * - BUSCAR:  localiza na grade por Codigo (prioridade) ou Descricao
    * - EXCLUIR: confirma e executa a exclusao
    * - INCLUIR/ALTERAR: valida campos obrigatorios e salva
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodBusca, loc_cDescBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "BUSCAR"
            TRY
                loc_cCodBusca  = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
                loc_cDescBusca = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)

                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)

                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    IF !EMPTY(loc_cCodBusca)
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.cods) = loc_cCodBusca
                    ELSE
                        IF !EMPTY(loc_cDescBusca)
                            LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descs)) = UPPER(loc_cDescBusca)
                        ENDIF
                    ENDIF
                    IF !FOUND()
                        GO TOP IN cursor_4c_Dados
                    ENDIF
                ENDIF
                loc_lResultado = .T.
            CATCH TO loException
                MsgErro(loException.Message, "FormSre.BtnSalvarClick")
            ENDTRY

            RETURN loc_lResultado
        ENDIF

        IF THIS.this_cModoAtual = "EXCLUIR"
            TRY
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta s" + CHR(233) + "rie?", "Excluir")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("S" + CHR(233) + "rie exclu" + CHR(237) + "da com sucesso!")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                        loc_lResultado = .T.
                    ELSE
                        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Excluir")
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loException
                MsgErro(loException.Message, "FormSre.BtnSalvarClick")
            ENDTRY

            RETURN loc_lResultado
        ENDIF

        *-- INCLUIR/ALTERAR: validacoes obrigatorias FORA do TRY (CLAUDE.md #1)
        IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Emps.Value))
            MsgAviso("Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
            loc_oPg2.txt_4c_Emps.SetFocus
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
            MsgAviso("S" + CHR(233) + "rie inv" + CHR(225) + "lida.", "")
            loc_oPg2.txt_4c_Codigo.SetFocus
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Tiponf.Value))
            MsgAviso("Tipo Nota Fiscal.", "")
            loc_oPg2.txt_4c_Tiponf.SetFocus
            RETURN .F.
        ENDIF

        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("S" + CHR(233) + "rie salva com sucesso!")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ELSE
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao/busca e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MsgErro(loException.Message, "FormSre.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles do
    * container, percorrendo Pages (PageFrame) e Controls recursivamente
    *--------------------------------------------------------------------------
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

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca series de nota fiscal e carrega grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (empcods C(6), emps C(3), cods C(3), descs C(20), ctiponfs C(5))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount  = 4
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cods"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descs"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ctiponfs"

                        loc_oGrid.Column1.Width = 90
                        loc_oGrid.Column2.Width = 140
                        loc_oGrid.Column3.Width = 460
                        loc_oGrid.Column4.Width = 170

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.
                        loc_oGrid.Column3.ReadOnly = .T.
                        loc_oGrid.Column4.ReadOnly = .T.

                        loc_oGrid.Column1.Header1.Caption = "Emp"
                        loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column4.Header1.Caption = "Tipo N.F."

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSre.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
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
    * AlternarPagina - Alterna entre Lista (1) e Dados (2)
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
            MsgErro(loc_oErro.Message, "FormSre.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera Business Object e cursores abertos pelo form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSre.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE

